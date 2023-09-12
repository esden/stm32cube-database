[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : ethernetif.c
  * Description        : This file provides code for the configuration
  *                      of the ethernetif.c MiddleWare.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#-- SWIPdatas is a list of SWIPconfigModel --]
[#compress] 
[#list SWIPdatas as SWIP]
[#assign with_rtos = 0]
[#assign cmsis_version = "n/a"]
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
        [#if (definition.name == "CMSIS_VERSION") && (with_rtos == 1)]
            [#if definition.value == "0"]
               [#assign cmsis_version = "v1"]
            [/#if]
            [#if definition.value == "1"]
               [#assign cmsis_version = "v2"]
            [/#if]
        [/#if][#-- CMSIS_VERSION --]
        [#if (definition.name == "LWIP_SUPPORT_CUSTOM_PBUF") && (definition.value == "1")]
            [#assign custom_pbuf = 1] 
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
			[#if (variables.value == "Undefined")]			
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
#include "main.h"
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
[#else]
/* USER CODE BEGIN Include for User BSP */

/* USER CODE END Include for User BSP */
[/#if][#-- endif bsp --]
#include <string.h>
[#if with_rtos == 1]
#include "cmsis_os.h"
#include "lwip/tcpip.h"
[/#if][#-- endif with_rtos --]

/* Within 'USER CODE' section, code will be kept by default at each generation */
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/* Private define ------------------------------------------------------------*/
[#compress]
[#if with_rtos == 1]

/* The time to block waiting for input. */
#define TIME_WAITING_FOR_INPUT                 ( portMAX_DELAY )
/* USER CODE BEGIN OS_THREAD_STACK_SIZE_WITH_RTOS */
/* Stack size of the interface thread */
#define INTERFACE_THREAD_STACK_SIZE            ( 350 )
/* USER CODE END OS_THREAD_STACK_SIZE_WITH_RTOS */
[/#if][#-- endif with_rtos --][/#compress]

/* Network interface name */
#define IFNAME0 's'
#define IFNAME1 't'

/* ETH Setting  */
#define ETH_DMA_TRANSMIT_TIMEOUT               ( 20U )
#define ETH_TX_BUFFER_MAX             ((ETH_TX_DESC_CNT) * 2U)

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

/* Private variables ---------------------------------------------------------*/
/* 
@Note: This interface is implemented to operate in zero-copy mode only:
        - Rx buffers will be allocated from LwIP stack memory heap,
          then passed to ETH HAL driver.
        - Tx buffers will be allocated from LwIP stack memory heap, 
          then passed to ETH HAL driver.

@Notes: 
  1.a. ETH DMA Rx descriptors must be contiguous, the default count is 4, 
       to customize it please redefine ETH_RX_DESC_CNT in ETH GUI (Rx Descriptor Length)
       so that updated value will be generated in stm32xxxx_hal_conf.h
  1.b. ETH DMA Tx descriptors must be contiguous, the default count is 4, 
       to customize it please redefine ETH_TX_DESC_CNT in ETH GUI (Tx Descriptor Length)
       so that updated value will be generated in stm32xxxx_hal_conf.h

  2.a. Rx Buffers number must be between ETH_RX_DESC_CNT and 2*ETH_RX_DESC_CNT
  2.b. Rx Buffers must have the same size: ETH_RX_BUF_SIZE, this value must
       passed to ETH DMA in the init field (heth.Init.RxBuffLen)
  2.c  The RX Ruffers addresses and sizes must be properly defined to be aligned
       to L1-CACHE line size (32 bytes).       
*/

/* Data Type Definitions */
typedef enum
{
  RX_ALLOC_OK       = 0x00,
  RX_ALLOC_ERROR    = 0x01
} RxAllocStatusTypeDef;

typedef struct
{
  struct pbuf_custom pbuf_custom;
  uint8_t buff[(ETH_RX_BUF_SIZE + 31) & ~31] __ALIGNED(32);
} RxBuff_t;

/* Memory Pool Declaration */
#define ETH_RX_BUFFER_CNT             12U
LWIP_MEMPOOL_DECLARE(RX_POOL, ETH_RX_BUFFER_CNT, sizeof(RxBuff_t), "Zero-copy RX PBUF pool");

/* Variable Definitions */
static uint8_t RxAllocStatus;

ETH_DMADescTypeDef  DMARxDscrTab[ETH_RX_DESC_CNT]; /* Ethernet Rx DMA Descriptors */
ETH_DMADescTypeDef  DMATxDscrTab[ETH_TX_DESC_CNT]; /* Ethernet Tx DMA Descriptors */



/* USER CODE BEGIN 2 */

/* USER CODE END 2 */

[#if with_rtos == 1]
osSemaphoreId RxPktSemaphore = NULL;   /* Semaphore to signal incoming packets */
osSemaphoreId TxPktSemaphore = NULL;   /* Semaphore to signal transmit packet complete */
[/#if][#-- endif with_rtos --]

/* Global Ethernet handle */
ETH_HandleTypeDef heth;
ETH_TxPacketConfig TxConfig;

/* Private function prototypes -----------------------------------------------*/
[#if with_rtos == 1][#-- rtos used --]
[#if cmsis_version = "v1"][#-- cmsis_version v1 --]
static void ethernetif_input(void const * argument);
[/#if][#-- endif cmsis_version v1 --]
[/#if][#-- rtos used --]
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
[#else]
/* USER CODE BEGIN Private function prototypes for User BSP */

/* USER CODE END Private function prototypes for User BSP */
[/#if][#-- endif bsp --]

/* USER CODE BEGIN 3 */

/* USER CODE END 3 */

/* Private functions ---------------------------------------------------------*/
[#if custom_pbuf == 1]
void pbuf_free_custom(struct pbuf *p);
[/#if][#-- endif custom_pbuf --]

[#if with_rtos == 1][#-- rtos used MAIN --]
/**
  * @brief  Ethernet Rx Transfer completed callback
  * @param  handlerEth: ETH handler
  * @retval None
  */
void HAL_ETH_RxCpltCallback(ETH_HandleTypeDef *handlerEth)
{
  osSemaphoreRelease(RxPktSemaphore);
}
/**
  * @brief  Ethernet Tx Transfer completed callback
  * @param  handlerEth: ETH handler
  * @retval None
  */
void HAL_ETH_TxCpltCallback(ETH_HandleTypeDef *handlerEth)
{
  osSemaphoreRelease(TxPktSemaphore);
}
/**
  * @brief  Ethernet DMA transfer error callback
  * @param  handlerEth: ETH handler
  * @retval None
  */
void HAL_ETH_ErrorCallback(ETH_HandleTypeDef *handlerEth)
{
  if((HAL_ETH_GetDMAError(handlerEth) & ETH_DMASR_RBUS) == ETH_DMASR_RBUS)
  {
     osSemaphoreRelease(RxPktSemaphore);
  }
}
[/#if][#-- endif with_rtos MAIN --]

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
  HAL_StatusTypeDef hal_eth_init_status = HAL_OK;
[#if cmsis_version = "v2"]
/* USER CODE BEGIN OS_THREAD_ATTR_CMSIS_RTOS_V2 */
  osThreadAttr_t attributes;
/* USER CODE END OS_THREAD_ATTR_CMSIS_RTOS_V2 */
[/#if][#-- endif cmsis_version --]
[#if with_rtos == 1]
[#if bsp == 1]
  uint32_t duplex, speed = 0;
  int32_t PHYLinkState = 0;
  ETH_MACConfigTypeDef MACConf = {0};
[#else]
/* USER CODE BEGIN low_level_init Variables Initialization for User BSP */

/* USER CODE END low_level_init Variables Initialization for User BSP */
[/#if][#-- endif bsp --]
[/#if][#-- endif with_rtos --]
  /* Start ETH HAL Init */
[#include mxTmpFolder+"/eth_HalInit.tmp"]
  /* End ETH HAL Init */
  
  /* Initialize the RX POOL */
  LWIP_MEMPOOL_INIT(RX_POOL);

[#if lwip_ipv6 == 1]
  /* Pass all multicast frames: needed for IPv6 protocol*/
  heth.Instance->MACPFR |= ETH_MACPFR_PM;
  
[/#if] [#-- endif lwip_ipv6 --]
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
  netif->mtu = ETH_MAX_PAYLOAD;
  
  /* Accept broadcast address and ARP traffic */
  /* don't set NETIF_FLAG_ETHARP if this device is not an ethernet one */
  #if LWIP_ARP
    netif->flags |= NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP;
  #else 
    netif->flags |= NETIF_FLAG_BROADCAST;
  #endif /* LWIP_ARP */
      
[#if with_rtos == 1]
[#if cmsis_version = "v2"]
  /* create a binary semaphore used for informing ethernetif of frame reception */
  RxPktSemaphore = osSemaphoreNew(1, 1, NULL);
  
  /* create a binary semaphore used for informing ethernetif of frame transmission */
  TxPktSemaphore = osSemaphoreNew(1, 1, NULL);
[#else][#-- else cmsis_version --]
  /* create a binary semaphore used for informing ethernetif of frame reception */
  RxPktSemaphore = xSemaphoreCreateBinary();
  
  /* create a binary semaphore used for informing ethernetif of frame transmission */
  TxPktSemaphore = xSemaphoreCreateBinary();
[/#if][#-- endif cmsis_version --]

  /* create the task that handles the ETH_MAC */
[#if cmsis_version = "v2"]
/* USER CODE BEGIN OS_THREAD_NEW_CMSIS_RTOS_V2 */
  memset(&attributes, 0x0, sizeof(osThreadAttr_t));
  attributes.name = "EthIf";
  attributes.stack_size = INTERFACE_THREAD_STACK_SIZE;
  attributes.priority = osPriorityRealtime;
  osThreadNew(ethernetif_input, netif, &attributes);
/* USER CODE END OS_THREAD_NEW_CMSIS_RTOS_V2 */
[#else]
/* USER CODE BEGIN OS_THREAD_DEF_CREATE_CMSIS_RTOS_V1 */
  osThreadDef(EthIf, ethernetif_input, osPriorityRealtime, 0, INTERFACE_THREAD_STACK_SIZE);
  osThreadCreate (osThread(EthIf), netif);
/* USER CODE END OS_THREAD_DEF_CREATE_CMSIS_RTOS_V1 */
[/#if][#-- endif cmsis_version --]
[/#if][#-- endif with_rtos --]

[#if bsp == 1]
/* USER CODE BEGIN PHY_PRE_CONFIG */ 
    
/* USER CODE END PHY_PRE_CONFIG */
  /* Set PHY IO functions */
  ${BspComponent}_RegisterBusIO(&${BspComponent}, &${BspComponent}_IOCtx);

  /* Initialize the ${BspComponent} ETH PHY */
  ${BspComponent}_Init(&${BspComponent});
[#else]
/* USER CODE BEGIN low_level_init Code 1 for User BSP */ 
    
/* USER CODE END low_level_init Code 1 for User BSP */
[/#if][#-- endif bsp --] 

  if (hal_eth_init_status == HAL_OK)
  {
[#if with_rtos == 1]
[#if bsp == 1]
    PHYLinkState = ${BspComponent}_GetLinkState(&${BspComponent});
  
    /* Get link state */  
    if(PHYLinkState <= ${BspComponent}_STATUS_LINK_DOWN)
    {
      netif_set_link_down(netif);
      netif_set_down(netif);
    }
    else 
    {
      switch (PHYLinkState)
      {
      case ${BspComponent}_STATUS_100MBITS_FULLDUPLEX:
        duplex = ETH_FULLDUPLEX_MODE;
        speed = ETH_SPEED_100M;
        break;
      case ${BspComponent}_STATUS_100MBITS_HALFDUPLEX:
        duplex = ETH_HALFDUPLEX_MODE;
        speed = ETH_SPEED_100M;
        break;
      case ${BspComponent}_STATUS_10MBITS_FULLDUPLEX:
        duplex = ETH_FULLDUPLEX_MODE;
        speed = ETH_SPEED_10M;
        break;
      case ${BspComponent}_STATUS_10MBITS_HALFDUPLEX:
        duplex = ETH_HALFDUPLEX_MODE;
        speed = ETH_SPEED_10M;
        break;
      default:
        duplex = ETH_FULLDUPLEX_MODE;
        speed = ETH_SPEED_100M;
        break;      
      }
    
    /* Get MAC Config MAC */
    HAL_ETH_GetMACConfig(&heth, &MACConf); 
    MACConf.DuplexMode = duplex;
    MACConf.Speed = speed;
    HAL_ETH_SetMACConfig(&heth, &MACConf);
    
    HAL_ETH_Start_IT(&heth);
    netif_set_up(netif);
    netif_set_link_up(netif);
    
/* USER CODE BEGIN PHY_POST_CONFIG */ 
    
/* USER CODE END PHY_POST_CONFIG */
    }
[#else][#-- endif bsp --]
/* USER CODE BEGIN low_level_init Code 2 for User BSP */ 
    
/* USER CODE END low_level_init Code 2 for User BSP */
[/#if][#-- endelse bsp --]

[#else][#-- endif with_rtos --]
  /* Get link state */
  ethernet_link_check_state(netif);
[/#if][#-- endelse with_rtos --]
  }
  else
  {
    Error_Handler();
  }
#endif /* LWIP_ARP || LWIP_ETHERNET */

/* USER CODE BEGIN LOW_LEVEL_INIT */ 
    
/* USER CODE END LOW_LEVEL_INIT */
}

/**
 * @brief This function should do the actual transmission of the packet. The packet is
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
 *       to become available since the stack doesn't retry to send a packet
 *       dropped because of memory failure (except for the TCP timers).
 */

static err_t low_level_output(struct netif *netif, struct pbuf *p)
{
  uint32_t i = 0U;
  struct pbuf *q = NULL;
  err_t errval = ERR_OK;
  ETH_BufferTypeDef Txbuffer[ETH_TX_DESC_CNT] = {0};
  
  memset(Txbuffer, 0 , ETH_TX_DESC_CNT*sizeof(ETH_BufferTypeDef));
  
  for(q = p; q != NULL; q = q->next)
  {
    if(i >= ETH_TX_DESC_CNT)	
      return ERR_IF;
    
    Txbuffer[i].buffer = q->payload;
    Txbuffer[i].len = q->len;
    
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

  TxConfig.Length = p->tot_len;
  TxConfig.TxBuffer = Txbuffer;
  TxConfig.pData = p;

[#if with_rtos == 1]
  pbuf_ref(p);
  
  HAL_ETH_Transmit_IT(&heth, &TxConfig);
[#if cmsis_version = "v1"]
  while(osSemaphoreWait(TxPktSemaphore, TIME_WAITING_FOR_INPUT)!=osOK)
[#else]
  while(osSemaphoreAcquire(TxPktSemaphore, TIME_WAITING_FOR_INPUT)!=osOK)
[/#if][#-- endif cmsis_version --]

  {
  }

  HAL_ETH_ReleaseTxPacket(&heth);
[#else][#-- endif with_rtos --]
  HAL_ETH_Transmit(&heth, &TxConfig, ETH_DMA_TRANSMIT_TIMEOUT);
[/#if][#-- endelse with_rtos --]
  
  return errval;
}

/**
 * @brief Should allocate a pbuf and transfer the bytes of the incoming
 * packet from the interface into the pbuf.
 *
 * @param netif the lwip network interface structure for this ethernetif
 * @return a pbuf filled with the received packet (including MAC header)
 *         NULL on memory error
   */
static struct pbuf * low_level_input(struct netif *netif)
{
  struct pbuf *p = NULL;

  if(RxAllocStatus == RX_ALLOC_OK)
  {
    HAL_ETH_ReadData(&heth, (void **)&p);
  }

  return p;
}

/**
 * @brief This function should be called when a packet is ready to be read
 * from the interface. It uses the function low_level_input() that
 * should handle the actual reception of bytes from the network
 * interface. Then the type of the received packet is determined and
 * the appropriate input function is called.
 *
 * @param netif the lwip network interface structure for this ethernetif
 */
[#if with_rtos == 1]
[#if cmsis_version = "v1"]
static void ethernetif_input(void const * argument)
[#else]
void ethernetif_input(void* argument)
[/#if][#-- endif cmsis_version --]
[#else][#-- else with_rtos --]
void ethernetif_input(struct netif *netif)
[/#if][#-- endif with_rtos --]
{
  struct pbuf *p = NULL;
[#if with_rtos == 1]
  struct netif *netif = (struct netif *) argument;
  
  for( ;; )
  {
[#if cmsis_version = "v1"]
    if (osSemaphoreWait(RxPktSemaphore, TIME_WAITING_FOR_INPUT) == osOK)
[#else][#-- else cmsis_version v2 --]
    if (osSemaphoreAcquire(RxPktSemaphore, TIME_WAITING_FOR_INPUT) == osOK)
[/#if][#-- endif cmsis_version --]
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
      } while(p!=NULL);
    }
  }
[#else][#-- else with_rtos --]

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
  } while(p!=NULL);
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
 * @brief Should be called at the beginning of the program to set up the
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

  /*
   * Initialize the snmp variables and counters inside the struct netif.
   * The last argument should be replaced with your link speed, in units
   * of bits per second.
   */
  // MIB2_INIT_NETIF(netif, snmp_ifType_ethernet_csmacd, LINK_SPEED_OF_YOUR_NETIF_IN_BPS);
    
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
  /* The user should write its own code in low_level_output_arp_off function */
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
  struct pbuf_custom* custom_pbuf = (struct pbuf_custom*)p;
  LWIP_MEMPOOL_FREE(RX_POOL, custom_pbuf);
  
  /* If the Rx Buffer Pool was exhausted, signal the ethernetif_input task to
   * call HAL_ETH_GetRxDataBuffer to rebuild the Rx descriptors. */
  
  if (RxAllocStatus == RX_ALLOC_ERROR)
  {
    RxAllocStatus = RX_ALLOC_OK;
[#if with_rtos == 1]
    osSemaphoreRelease(RxPktSemaphore);
[/#if][#-- endif with_rtos --]
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
u32_t sys_now(void)
{
  return HAL_GetTick();
}

/* USER CODE END 6 */

[#if bsp == 1]

/**
  * @brief  Initializes the ETH MSP.
  * @param  ethHandle: ETH handle
  * @retval None
  */
[#include mxTmpFolder+"/eth_Msp.tmp"]

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
[#else]
/* USER CODE BEGIN PHI IO Functions for User BSP */ 
    
/* USER CODE END PHI IO Functions for User BSP */
[/#if][#-- endif bsp --]

/**
  * @brief  Check the ETH link state then update ETH driver and netif link accordingly.
  * @retval None
  */
[#if with_rtos == 1]
[#if cmsis_version = "v2"]
void ethernet_link_thread(void* argument)
[#else] [#-- endif cmsis_version --]
void ethernet_link_thread(void const * argument)
[/#if][#-- endelse cmsis_version --]
[#else][#-- else with_rtos --]  
void ethernet_link_check_state(struct netif *netif)
[/#if][#-- endelse with_rtos --]
{
[#if bsp == 1]
  ETH_MACConfigTypeDef MACConf = {0};
  int32_t PHYLinkState = 0;
  uint32_t linkchanged = 0U, speed = 0U, duplex = 0U;
[/#if][#-- endif bsp --]
  
[#if with_rtos == 1]
[#if bsp == 1]
  struct netif *netif = (struct netif *) argument;
[/#if][#-- endif bsp --]
/* USER CODE BEGIN ETH link init */

/* USER CODE END ETH link init */
  
  for(;;)
  {
[/#if][#-- endif with_rtos --]
[#if bsp == 1]
  PHYLinkState = ${BspComponent}_GetLinkState(&${BspComponent});
  
  if(netif_is_link_up(netif) && (PHYLinkState <= ${BspComponent}_STATUS_LINK_DOWN))
  {
[#if with_rtos == 1]
    HAL_ETH_Stop_IT(&heth);
[#else]
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
    [#else]
      HAL_ETH_Start(&heth);
    [/#if][#-- endif with_rtos --]
      netif_set_up(netif);
      netif_set_link_up(netif);
    }
  }
[/#if][#-- endif bsp --]

[#if with_rtos == 1]
/* USER CODE BEGIN ETH link Thread core code for User BSP */
    
/* USER CODE END ETH link Thread core code for User BSP */
[/#if][#-- endif with_rtos --]

[#if with_rtos == 1]
    osDelay(100);
  }
[/#if][#-- endif with_rtos --]   
}

void HAL_ETH_RxAllocateCallback(uint8_t **buff)
{
/* USER CODE BEGIN HAL ETH RxAllocateCallback */
[#if custom_pbuf == 1]
  struct pbuf_custom *p = LWIP_MEMPOOL_ALLOC(RX_POOL);
  if (p)
  {
    /* Get the buff from the struct pbuf address. */
    *buff = (uint8_t *)p + offsetof(RxBuff_t, buff);
    p->custom_free_function = pbuf_free_custom;
    /* Initialize the struct pbuf.
    * This must be performed whenever a buffer's allocated because it may be
    * changed by lwIP or the app, e.g., pbuf_free decrements ref. */
    pbuf_alloced_custom(PBUF_RAW, 0, PBUF_REF, p, *buff, ETH_RX_BUF_SIZE);
  }
  else
  {
    RxAllocStatus = RX_ALLOC_ERROR;
    *buff = NULL;
  }
[/#if][#-- endif custom_pbuf --]   
/* USER CODE END HAL ETH RxAllocateCallback */  
}

void HAL_ETH_RxLinkCallback(void **pStart, void **pEnd, uint8_t *buff, uint16_t Length)
{
/* USER CODE BEGIN HAL ETH RxLinkCallback */

  struct pbuf **ppStart = (struct pbuf **)pStart;
  struct pbuf **ppEnd = (struct pbuf **)pEnd;
  struct pbuf *p = NULL;

  /* Get the struct pbuf from the buff address. */
  p = (struct pbuf *)(buff - offsetof(RxBuff_t, buff));
  p->next = NULL;
  p->tot_len = 0;
  p->len = Length;

  /* Chain the buffer. */
  if (!*ppStart)
  {
    /* The first buffer of the packet. */
    *ppStart = p;
  }
  else
  {
    /* Chain the buffer to the end of the packet. */
    (*ppEnd)->next = p;
  }
  *ppEnd  = p;

  /* Update the total length of all the buffers of the chain. Each pbuf in the chain should have its tot_len
   * set to its own length, plus the length of all the following pbufs in the chain. */
  for (p = *ppStart; p != NULL; p = p->next)
  {
    p->tot_len += Length;
  }
  
/* USER CODE END HAL ETH RxLinkCallback */  
}

void HAL_ETH_TxFreeCallback(uint32_t * buff)
{
/* USER CODE BEGIN HAL ETH TxFreeCallback */

  pbuf_free((struct pbuf *)buff);
  
/* USER CODE END HAL ETH TxFreeCallback */  
}

/* USER CODE BEGIN 8 */

/* USER CODE END 8 */

