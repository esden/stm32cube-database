[#ftl]
/**
  ******************************************************************************
  * File Name          : ethernetif.c
  * Description        : This file provides code for the configuration
  *                      of the ethernetif.c MiddleWare.
  ******************************************************************************
[@common.optinclude name=sourceDir+"Src/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
[#-- SWIPdatas is a list of SWIPconfigModel --]
[#compress] 
[#list SWIPdatas as SWIP]
[#assign with_rtos = 0]
[#assign netif_callback = 0]
[#assign custom_pbuf = 0]
[#assign lwip_arp = 0]
[#assign bsp = 0][#-- bsp is LAN8742 for H7 --]
[#assign tx_descr_address = 0]
[#assign rx_descr_address = 0]
[#assign rx_buffer_address = 0]
[#assign lwip_ipv6 = 0]
[#assign BspComponent = ""]
[#if SWIP.defines??]
	[#list SWIP.defines as definition] 	
        [#if (definition.name == "WITH_RTOS")]
            [#if definition.value == "1"]
                [#assign with_rtos = 1]
            [/#if][#-- "1" --]
        [/#if][#-- WITH_RTOS --]
        [#if (definition.name == "NO_SYS")]
            [#if definition.value == "0"]
                [#assign with_rtos = 1]
            [#else]
                [#assign with_rtos = 0]
            [/#if][#-- "0" --]
        [/#if][#-- NO_SYS --]
        [#if (definition.name == "LWIP_SUPPORT_CUSTOM_PBUF") && (definition.value == "1")]
            [#assign custom_pbuf = 1] 
        [/#if]
        [#if (definition.name == "LWIP_NETIF_LINK_CALLBACK") && (definition.value == "1")]
            [#assign netif_callback = 1] 
        [/#if]
		[#if (definition.name == "LWIP_ARP") && (definition.value == "1")]
            [#assign lwip_arp = 1] 
        [/#if]
        [#if (definition.name == "TX_DESCRIPTOR_ADDRESS")]
            [#assign tx_descr_address = definition.value]
        [/#if]
        [#if (definition.name == "RX_DESCRIPTOR_ADDRESS")]
            [#assign rx_descr_address = definition.value]
        [/#if]
        [#if (definition.name == "RX_BUFFER_ADDRESS")]
            [#assign rx_buffer_address = definition.value]
        [/#if] 
        [#if (definition.name == "LWIP_IPV6") && (definition.value == "1")]
            [#assign lwip_ipv6 = 1]
        [/#if]
	[/#list]
[/#if][#-- SWIP.defines --]
[/#list][/#compress]

[#if BspComponentDatas??]
[#list BspComponentDatas as BspComponent]
[#if BspComponent.variables??]
[#list BspComponent.variables as variables]
		[#if variables.name?contains("BspComponent")]
			[#assign BspComponent = variables.value]
			[#if (variables.value == "Choose")]			
				[#assign bsp = 0]
			[#else]
				[#assign bsp = 1]
			[/#if][#-- end "Choose" --]
		[/#if][#-- end "BspComponent" --]
[/#list]
[/#if][#-- end "BspComponent.variables??" --]
[/#list]
[/#if][#-- end "BspComponentDatas??" --]

/* Includes ------------------------------------------------------------------*/
#include "${FamilyName?lower_case}xx_hal.h"
#include "lwip/opt.h"
[#if with_rtos == 0]
#include "lwip/mem.h"
#include "lwip/memp.h"
[/#if][#-- endif with_rtos --]
#include "lwip/timeouts.h"
#include "netif/ethernet.h"
#include "netif/etharp.h"
#include "lwip/ethip6.h"
#include "ethernetif.h"
[#if bsp == 1]
#include "${BspComponent?lower_case}.h"
[/#if][#-- endif bsp --]
#include <string.h>
[#if with_rtos == 1]
#include "cmsis_os.h"
[/#if][#-- endif with_rtos --]

/* Within 'USER CODE' section, code will be kept by default at each generation */
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/* Private define ------------------------------------------------------------*/
[#compress]
[#if with_rtos == 1]

/* The time to block waiting for input. */
#define TIME_WAITING_FOR_INPUT                 ( portMAX_DELAY )
/* Stack size of the interface thread */
#define INTERFACE_THREAD_STACK_SIZE            ( 350 )
[/#if][#-- endif with_rtos --][/#compress]

/* Network interface name */
#define IFNAME0 's'
#define IFNAME1 't'

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

/* Private variables ---------------------------------------------------------*/
/* 
@Note: This interface is implemented to operate in zero-copy mode only:
        - Rx buffers are allocated statically and passed directly to the LwIP stack
          they will return back to DMA after been processed by the stack.
        - Tx Buffers will be allocated from LwIP stack memory heap, 
          then passed to ETH HAL driver.

@Notes: 
  1.a. ETH DMA Rx descriptors must be contiguous, the default count is 4, 
       to customize it please redefine ETH_RX_DESC_CNT in ETH GUI (Rx Descriptor Length)
       so that updated value will be generated in stm32xxxx_hal_conf.h
  1.b. ETH DMA Tx descriptors must be contiguous, the default count is 4, 
       to customize it please redefine ETH_TX_DESC_CNT in ETH GUI (Tx Descriptor Length)
       so that updated value will be generated in stm32xxxx_hal_conf.h

  2.a. Rx Buffers number must be between ETH_RX_DESC_CNT and 2*ETH_RX_DESC_CNT
  2.b. Rx Buffers must have the same size: ETH_MAX_PACKET_SIZE, this value must
       passed to ETH DMA in the init field (heth.Init.RxBuffLen)
*/

#if defined ( __ICCARM__ ) /*!< IAR Compiler */

#pragma location=${rx_descr_address}
ETH_DMADescTypeDef  DMARxDscrTab[ETH_RX_DESC_CNT]; /* Ethernet Rx DMA Descriptors */
#pragma location=${tx_descr_address}
ETH_DMADescTypeDef  DMATxDscrTab[ETH_TX_DESC_CNT]; /* Ethernet Tx DMA Descriptors */
#pragma location=${rx_buffer_address}
uint8_t Rx_Buff[ETH_RX_DESC_CNT][ETH_MAX_PACKET_SIZE]; /* Ethernet Receive Buffers */

#elif defined ( __CC_ARM )  /* MDK ARM Compiler */

__attribute__((at(${rx_descr_address}))) ETH_DMADescTypeDef  DMARxDscrTab[ETH_RX_DESC_CNT]; /* Ethernet Rx DMA Descriptors */
__attribute__((at(${tx_descr_address}))) ETH_DMADescTypeDef  DMATxDscrTab[ETH_TX_DESC_CNT]; /* Ethernet Tx DMA Descriptors */
__attribute__((at(${rx_buffer_address}))) uint8_t Rx_Buff[ETH_RX_DESC_CNT][ETH_MAX_PACKET_SIZE]; /* Ethernet Receive Buffer */

#elif defined ( __GNUC__ ) /* GNU Compiler */ 

ETH_DMADescTypeDef DMARxDscrTab[ETH_RX_DESC_CNT] __attribute__((section(".RxDecripSection"))); /* Ethernet Rx DMA Descriptors */
ETH_DMADescTypeDef DMATxDscrTab[ETH_TX_DESC_CNT] __attribute__((section(".TxDecripSection")));   /* Ethernet Tx DMA Descriptors */
uint8_t Rx_Buff[ETH_RX_DESC_CNT][ETH_MAX_PACKET_SIZE] __attribute__((section(".RxArraySection"))); /* Ethernet Receive Buffers */

#endif

/* USER CODE BEGIN 2 */

/* USER CODE END 2 */

[#if with_rtos == 1]
osSemaphoreId RxPktSemaphore = NULL; /* Semaphore to signal incoming packets */
[/#if][#-- endif with_rtos --]
uint32_t current_pbuf_idx = 0;

/* Global Ethernet handle */
ETH_HandleTypeDef heth;
ETH_TxPacketConfig TxConfig;
struct pbuf_custom rx_pbuf[ETH_RX_DESC_CNT];

/* Private function prototypes -----------------------------------------------*/
[#if bsp == 1]
int32_t ETH_PHY_IO_Init(void);
int32_t ETH_PHY_IO_DeInit (void);
int32_t ETH_PHY_IO_ReadReg(uint32_t DevAddr, uint32_t RegAddr, uint32_t *pRegVal);
int32_t ETH_PHY_IO_WriteReg(uint32_t DevAddr, uint32_t RegAddr, uint32_t RegVal);
int32_t ETH_PHY_IO_GetTick(void);

${BspComponent?lower_case}_Object_t ${BspComponent};
${BspComponent?lower_case}_IOCtx_t  ${BspComponent}_IOCtx = {ETH_PHY_IO_Init,
                                  ETH_PHY_IO_DeInit,
                                  ETH_PHY_IO_WriteReg,
                                  ETH_PHY_IO_ReadReg,
                                  ETH_PHY_IO_GetTick};
[/#if][#-- endif bsp --]

/* USER CODE BEGIN 3 */

/* USER CODE END 3 */

/* Private functions ---------------------------------------------------------*/
[#if custom_pbuf == 1]
void pbuf_free_custom(struct pbuf *p);
[/#if][#-- endif custom_pbuf --]

[#include sourceDir+"Src/eth_Msp.tmp"]

[#if with_rtos == 1]
/**
  * @brief  Ethernet Rx Transfer completed callback
  * @param  heth: ETH handle
  * @retval None
  */
void HAL_ETH_RxCpltCallback(ETH_HandleTypeDef *heth)
{
  osSemaphoreRelease(RxPktSemaphore);
}

[/#if][#-- endif with_rtos --]

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */


/*******************************************************************************
                       LL Driver Interface ( LwIP stack --> ETH) 
*******************************************************************************/
/**
 * @brief In this function, the hardware should be initialized.
 * Called from ethernetif_init().
 *
 * @param netif the already initialized lwip network interface structure
 *        for this ethernetif
 */
static void low_level_init(struct netif *netif)
{ 
  uint32_t idx = 0;
  HAL_StatusTypeDef hal_eth_init_status;
  
  /* Init ETH */
[#include sourceDir+"Src/eth_HalInit.tmp"]  
  
  for(idx = 0; idx < ETH_RX_DESC_CNT; idx ++)
  {
    HAL_ETH_DescAssignMemory(&heth, idx, Rx_Buff[idx], NULL);
    
    /* Set Custom pbuf free function */
[#if custom_pbuf == 1]    
    rx_pbuf[idx].custom_free_function = pbuf_free_custom;
[/#if]
  }
  
[#if lwip_ipv6 == 1]
  /* Pass all multicast frames: needed for IPv6 protocol*/
  heth.Instance->MACPFR |= ETH_MACPFR_PM;
[/#if]
 
#if LWIP_ARP || LWIP_ETHERNET 

  /* set MAC hardware address length */
  netif->hwaddr_len = ETH_HWADDR_LEN;
  
  /* set MAC hardware address */
  netif->hwaddr[0] =  heth.Init.MACAddr[0];
  netif->hwaddr[1] =  heth.Init.MACAddr[1];
  netif->hwaddr[2] =  heth.Init.MACAddr[2];
  netif->hwaddr[3] =  heth.Init.MACAddr[3];
  netif->hwaddr[4] =  heth.Init.MACAddr[4];
  netif->hwaddr[5] =  heth.Init.MACAddr[5];
  
  /* maximum transfer unit */
  netif->mtu = 1500;
  
  /* Accept broadcast address and ARP traffic */
  /* don't set NETIF_FLAG_ETHARP if this device is not an ethernet one */
  #if LWIP_ARP
    netif->flags |= NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP;
  #else 
    netif->flags |= NETIF_FLAG_BROADCAST;
  #endif /* LWIP_ARP */
  
[#if with_rtos == 1]
  /* create a binary semaphore used for informing ethernetif of frame reception */
  osSemaphoreDef(SEM);
  RxPktSemaphore = osSemaphoreCreate(osSemaphore(SEM) , 1 );

  /* create the task that handles the ETH_MAC */
  osThreadDef(EthIf, ethernetif_input, osPriorityRealtime, 0, INTERFACE_THREAD_STACK_SIZE);
  osThreadCreate (osThread(EthIf), netif);
[/#if][#-- endif with_rtos --]

/* USER CODE BEGIN PHY_PRE_CONFIG */ 
    
/* USER CODE END PHY_PRE_CONFIG */
  
[#if bsp == 1]
  /* Set PHY IO functions */
  ${BspComponent}_RegisterBusIO(&${BspComponent}, &${BspComponent}_IOCtx);

  /* Initialize the ${BspComponent} ETH PHY */
  ${BspComponent}_Init(&${BspComponent});
[/#if][#-- endif bsp --]

  if (hal_eth_init_status == HAL_OK)
  {    
[#if netif_callback == 1]
[#if with_rtos == 1]
[#else][#-- else with_rtos --]
    ethernet_link_check_state(netif);
[/#if][#-- endif with_rtos --]
[#else][#-- else netif_callback --]
    netif_set_up(netif);
    netif_set_link_up(netif);
[#if with_rtos == 1]
    HAL_ETH_Start_IT(&heth);
[#else][#-- else with_rtos --]
    HAL_ETH_Start(&heth);
[/#if][#-- endif with_rtos --]
[/#if][#-- endif netif_callback --]
  }
  else 
  {
    _Error_Handler(__FILE__, __LINE__);
  }

/* USER CODE BEGIN PHY_POST_CONFIG */ 
    
/* USER CODE END PHY_POST_CONFIG */

#endif /* LWIP_ARP || LWIP_ETHERNET */

/* USER CODE BEGIN LOW_LEVEL_INIT */ 
    
/* USER CODE END LOW_LEVEL_INIT */
}

/**
 * This function should do the actual transmission of the packet. The packet is
 * contained in the pbuf that is passed to the function. This pbuf
 * might be chained.
 *
 * @param netif the lwip network interface structure for this ethernetif
 * @param p the MAC packet to send (e.g. IP packet including MAC addresses and type)
 * @return ERR_OK if the packet could be sent
 *         an err_t value if the packet couldn't be sent
 *
 * @note Returning ERR_MEM here if a DMA queue of your MAC is full can lead to
 *       strange results. You might consider waiting for space in the DMA queue
 *       to become availale since the stack doesn't retry to send a packet
 *       dropped because of memory failure (except for the TCP timers).
 */

static err_t low_level_output(struct netif *netif, struct pbuf *p)
{
   uint32_t i=0, framelen = 0;
  struct pbuf *q;
  err_t errval = ERR_OK;
  ETH_BufferTypeDef Txbuffer[ETH_TX_DESC_CNT];
  
  for(q = p; q != NULL; q = q->next)
  {
    if(i >= ETH_TX_DESC_CNT)	
      return ERR_IF;
    
    Txbuffer[i].buffer = q->payload;
    Txbuffer[i].len = q->len;
    framelen += q->len;
    
    if(i>0)
    {
      Txbuffer[i-1].next = &Txbuffer[i];
    }
    
    if(q->next == NULL)
    {
      Txbuffer[i].next = NULL;
    }
    
    i++;
  }

  TxConfig.Length = framelen;
  TxConfig.TxBuffer = Txbuffer;
  
  /* Clean and Invalidate data cache */
  SCB_CleanInvalidateDCache();
  
  HAL_ETH_Transmit(&heth, &TxConfig, 0);
  
  return errval;
}

/**
 * Should allocate a pbuf and transfer the bytes of the incoming
 * packet from the interface into the pbuf.
 *
 * @param netif the lwip network interface structure for this ethernetif
 * @return a pbuf filled with the received packet (including MAC header)
 *         NULL on memory error
   */
static struct pbuf * low_level_input(struct netif *netif)
{
  struct pbuf *p = NULL;
  ETH_BufferTypeDef RxBuff;
  uint32_t framelength = 0;
  
[#if with_rtos == 1]  
  /* Clean and Invalidate data cache */
  SCB_CleanInvalidateDCache();
  
  if(HAL_ETH_GetRxDataBuffer(&heth, &RxBuff) == HAL_OK) 
  {
    HAL_ETH_GetRxDataLength(&heth, &framelength);
[#if custom_pbuf == 1]    
    p = pbuf_alloced_custom(PBUF_RAW, framelength, PBUF_POOL, &rx_pbuf[current_pbuf_idx], RxBuff.buffer, framelength);
    
    if(current_pbuf_idx < (ETH_RX_DESC_CNT -1))
    {
      current_pbuf_idx++;
    }
    else
    {
      current_pbuf_idx = 0;
    }
 [/#if][#-- endif custom_pbuf --]
  }
  
  
  return p;
[#else][#-- else with_rtos --]
  
  if (HAL_ETH_IsRxDataAvailable(&heth))
  {
    /* Clean and Invalidate data cache */
    SCB_CleanInvalidateDCache();
  
    HAL_ETH_GetRxDataBuffer(&heth, &RxBuff);
    HAL_ETH_GetRxDataLength(&heth, &framelength);
    
    p = pbuf_alloced_custom(PBUF_RAW, framelength, PBUF_POOL, &rx_pbuf[current_pbuf_idx], RxBuff.buffer, framelength);
    
    if(current_pbuf_idx < (ETH_RX_DESC_CNT -1))
    {
      current_pbuf_idx++;
    }
    else
    {
      current_pbuf_idx = 0;
    }
    
    return p;
  }
  else
  {
    return NULL;
  }
[/#if][#-- endif with_rtos --] 
}

/**
 * This function should be called when a packet is ready to be read
 * from the interface. It uses the function low_level_input() that
 * should handle the actual reception of bytes from the network
 * interface. Then the type of the received packet is determined and
 * the appropriate input function is called.
 *
 * @param netif the lwip network interface structure for this ethernetif
 */
[#if with_rtos == 1]
void ethernetif_input( void const * argument ) 
[#else]
void ethernetif_input(struct netif *netif)
[/#if][#-- endif with_rtos --]
{
[#if with_rtos == 0]
  err_t err;
[/#if][#-- endif with_rtos --]
  struct pbuf *p;
[#if with_rtos == 1]
  struct netif *netif = (struct netif *) argument;
  
  for( ;; )
  {
    if (osSemaphoreWait( RxPktSemaphore, TIME_WAITING_FOR_INPUT)==osOK)
    {
      do
      {
        p = low_level_input( netif );
        if (p != NULL)
        {
          if (netif->input( p, netif) != ERR_OK )
          {
            pbuf_free(p);           
          }
        }
        
        /* Build Rx descriptor to be ready for next data reception */   
        HAL_ETH_BuildRxDescriptors(&heth);
        
      }while(p!=NULL);
    }
  }
[#else][#-- else with_rtos --]

  /* move received packet into a new pbuf */
  p = low_level_input(netif);
    
  /* no packet could be read, silently ignore this */
  if (p == NULL) return;
    
  /* entry point to the LwIP stack */
  err = netif->input(p, netif);
    
  if (err != ERR_OK)
  {
    LWIP_DEBUGF(NETIF_DEBUG, ("ethernetif_input: IP input error\n"));
    pbuf_free(p);
    p = NULL;    
  }
  HAL_ETH_BuildRxDescriptors(&heth);
[/#if][#-- endif with_rtos --]
  
}

#if !LWIP_ARP
/**
 * This function has to be completed by user in case of ARP OFF.
 *
 * @param netif the lwip network interface structure for this ethernetif
 * @return ERR_OK if ...
 */
static err_t low_level_output_arp_off(struct netif *netif, struct pbuf *q, const ip4_addr_t *ipaddr)
{  
  err_t errval;
  errval = ERR_OK;
    
/* USER CODE BEGIN 5 */ 
    
/* USER CODE END 5 */  
    
  return errval;
  
}
#endif /* LWIP_ARP */ 

/**
 * Should be called at the beginning of the program to set up the
 * network interface. It calls the function low_level_init() to do the
 * actual setup of the hardware.
 *
 * This function should be passed as a parameter to netif_add().
 *
 * @param netif the lwip network interface structure for this ethernetif
 * @return ERR_OK if the loopif is initialized
 *         ERR_MEM if private data couldn't be allocated
 *         any other err_t on error
 */
err_t ethernetif_init(struct netif *netif)
{
  LWIP_ASSERT("netif != NULL", (netif != NULL));
  
#if LWIP_NETIF_HOSTNAME
  /* Initialize interface hostname */
  netif->hostname = "lwip";
#endif /* LWIP_NETIF_HOSTNAME */

  
  netif->name[0] = IFNAME0;
  netif->name[1] = IFNAME1;
  /* We directly use etharp_output() here to save a function call.
   * You can instead declare your own function an call etharp_output()
   * from it if you have to do some checks before sending (e.g. if link
   * is available...) */

#if LWIP_IPV4
#if LWIP_ARP || LWIP_ETHERNET
#if LWIP_ARP
  netif->output = etharp_output;
#else
  /* The user should write ist own code in low_level_output_arp_off function */
  netif->output = low_level_output_arp_off;
#endif /* LWIP_ARP */
#endif /* LWIP_ARP || LWIP_ETHERNET */
#endif /* LWIP_IPV4 */
 
#if LWIP_IPV6
  netif->output_ip6 = ethip6_output;
#endif /* LWIP_IPV6 */

  netif->linkoutput = low_level_output;

  /* initialize the hardware */
  low_level_init(netif);

  return ERR_OK;
}

[#if custom_pbuf == 1]
/**
  * @brief  Custom Rx pbuf free callback
  * @param  pbuf: pbuf to be freed
  * @retval None
  */
void pbuf_free_custom(struct pbuf *p)
{
  if(p!=NULL)
  {
    p->flags = 0;
    p->next = NULL;
    p->len = p->tot_len = 0;
    p->ref = 0;
    p->payload = NULL;
  }
}
[/#if][#-- endif custom_pbuf --]

/* USER CODE BEGIN 6 */

/**
* @brief  Returns the current time in milliseconds
*         when LWIP_TIMERS == 1 and NO_SYS == 1
* @param  None
* @retval Current Time value
*/
u32_t sys_jiffies(void)
{
  return HAL_GetTick();
}

/**
* @brief  Returns the current time in milliseconds
*         when LWIP_TIMERS == 1 and NO_SYS == 1
* @param  None
* @retval Current Time value
*/
u32_t sys_now(void)
{
  return HAL_GetTick();
}

/* USER CODE END 6 */

[#if bsp == 1]
/*******************************************************************************
                       PHI IO Functions
*******************************************************************************/
/**
  * @brief  Initializes the MDIO interface GPIO and clocks.
  * @param  None
  * @retval 0 if OK, -1 if ERROR
  */
int32_t ETH_PHY_IO_Init(void)
{  
  /* We assume that MDIO GPIO configuration is already done
     in the ETH_MspInit() else it should be done here 
  */
  
  /* Configure the MDIO Clock */
  HAL_ETH_SetMDIOClockRange(&heth);
  
  return 0;
}

/**
  * @brief  De-Initializes the MDIO interface .
  * @param  None
  * @retval 0 if OK, -1 if ERROR
  */
int32_t ETH_PHY_IO_DeInit (void)
{
  return 0;
}

/**
  * @brief  Read a PHY register through the MDIO interface.
  * @param  DevAddr: PHY port address
  * @param  RegAddr: PHY register address
  * @param  pRegVal: pointer to hold the register value 
  * @retval 0 if OK -1 if Error
  */
int32_t ETH_PHY_IO_ReadReg(uint32_t DevAddr, uint32_t RegAddr, uint32_t *pRegVal)
{
  if(HAL_ETH_ReadPHYRegister(&heth, DevAddr, RegAddr, pRegVal) != HAL_OK)
  {
    return -1;
  }
  
  return 0;
}

/**
  * @brief  Write a value to a PHY register through the MDIO interface.
  * @param  DevAddr: PHY port address
  * @param  RegAddr: PHY register address
  * @param  RegVal: Value to be written 
  * @retval 0 if OK -1 if Error
  */
int32_t ETH_PHY_IO_WriteReg(uint32_t DevAddr, uint32_t RegAddr, uint32_t RegVal)
{
  if(HAL_ETH_WritePHYRegister(&heth, DevAddr, RegAddr, RegVal) != HAL_OK)
  {
    return -1;
  }
  
  return 0;
}

/**
  * @brief  Get the time in millisecons used for internal PHY driver process.
  * @retval Time value
  */
int32_t ETH_PHY_IO_GetTick(void)
{
  return HAL_GetTick();
}
[/#if][#-- endif bsp --]

[#if netif_callback == 1]
/**
  * @brief  Check the ETH link state then update ETH driver and netif link accordingly.
  * @param  argument: netif
  * @retval None
  */
[#if with_rtos == 1]
void ethernet_link_thread( void const * argument )
[#else][#-- else with_rtos --]  
void ethernet_link_check_state(struct netif *netif)
[/#if][#-- endif with_rtos --]
{
[#if bsp == 1]
  ETH_MACConfigTypeDef MACConf;
  uint32_t PHYLinkState;
  uint32_t linkchanged = 0, speed = 0, duplex =0;
[#if with_rtos == 1]
  struct netif *netif = (struct netif *) argument;
  
  for(;;)
  {
[/#if][#-- endif with_rtos --]
  
  PHYLinkState = ${BspComponent}_GetLinkState(&${BspComponent});
  
  if(netif_is_link_up(netif) && (PHYLinkState <= ${BspComponent}_STATUS_LINK_DOWN))
  {
[#if with_rtos == 1]
    HAL_ETH_Stop_IT(&heth);
[#else][#-- else with_rtos --]
    HAL_ETH_Stop(&heth);
[/#if][#-- endif with_rtos --]  
    netif_set_down(netif);
    netif_set_link_down(netif);
  }
  else if(!netif_is_link_up(netif) && (PHYLinkState > ${BspComponent}_STATUS_LINK_DOWN))
  {
    switch (PHYLinkState)
    {
    case ${BspComponent}_STATUS_100MBITS_FULLDUPLEX:
      duplex = ETH_FULLDUPLEX_MODE;
      speed = ETH_SPEED_100M;
      linkchanged = 1;
      break;
    case ${BspComponent}_STATUS_100MBITS_HALFDUPLEX:
      duplex = ETH_HALFDUPLEX_MODE;
      speed = ETH_SPEED_100M;
      linkchanged = 1;
      break;
    case ${BspComponent}_STATUS_10MBITS_FULLDUPLEX:
      duplex = ETH_FULLDUPLEX_MODE;
      speed = ETH_SPEED_10M;
      linkchanged = 1;
      break;
    case ${BspComponent}_STATUS_10MBITS_HALFDUPLEX:
      duplex = ETH_HALFDUPLEX_MODE;
      speed = ETH_SPEED_10M;
      linkchanged = 1;
      break;
    default:
      break;      
    }
    
    if(linkchanged)
    {
      /* Get MAC Config MAC */
      HAL_ETH_GetMACConfig(&heth, &MACConf); 
      MACConf.DuplexMode = duplex;
      MACConf.Speed = speed;
      HAL_ETH_SetMACConfig(&heth, &MACConf);
[#if with_rtos == 1]
      HAL_ETH_Start_IT(&heth);
[#else][#-- else with_rtos --]
      HAL_ETH_Start(&heth);
[/#if][#-- endif with_rtos --]
      netif_set_up(netif);
      netif_set_link_up(netif);
    }
  }
[#if with_rtos == 1]
    osDelay(100);
  }
[/#if][#-- endif with_rtos --]  
[#else][#-- else bsp == 0 --] 

/* USER CODE BEGIN 7 */

/* USER CODE END 7 */    
[/#if][#-- endif bsp --]  
}
[/#if][#-- endif netif_callback --]
/* USER CODE BEGIN 8 */

/* USER CODE END 8 */
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

