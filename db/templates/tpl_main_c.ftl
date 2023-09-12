[#ftl]

[#assign coreDir=""]

[#assign coreDir=sourceDir]
[#if cpucore!="" && (contextFolder=="" || contextFolder=="/")]
    [#assign contextFolder = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")+"/"]
[/#if]
[#assign familyName=FamilyName?lower_case]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign IpInit_ToIgnore = "VREFBUF CORTEX_M4 CORTEX_M7 HSEM PWR RCC"]
[#assign staticVoids =""]
[#compress]
[#assign usb_device = false]
/* Includes ------------------------------------------------------------------*/
#include "${main_h}"
[#if H7_ETH_NoLWIP?? &&HALCompliant??]
#include "string.h"
[/#if]
[#-- IF GFXMMU is used and all is generated in the main and the Lut is configured--]
[#if GFXMMUisUsed?? && HALCompliant?? && !Display_Interface_LTDC_DSIHOST?? ]
[@common.optincludeFile path=coreDir+"Inc" name="gfxmmu_lut.h"/]
[/#if]
[#-- move includes to main.h --]
[@common.optinclude name=contextFolder+mxTmpFolder+"/rtos_inc.tmp"/][#--include freertos includes --]
[#-- if !HALCompliant??--][#-- if HALCompliant Begin --]
[#assign LWIPUSed = "false"]
[#assign MBEDTLSUSed = "false"]
[#assign RESMGR_UTILITYUsed = false]
[#list ips as ip]
    [#if ip?contains("LWIP")]
        [#assign LWIPUSed = "true"]
    [/#if]
    [#if ip=="MBEDTLS"]
        [#assign MBEDTLSUSed = "true"]
    [/#if]
    [#if ip=="RESMGR_UTILITY"]
        [#assign RESMGR_UTILITYUsed = true]
    [/#if]
[/#list]

[#list ips as ip]
[#if !ip?contains("FATFS") && !ip?contains("FREERTOS") && !ip?contains("NVIC")&& !ip?contains("NVIC1")&& !ip?contains("NVIC2")&& !ip?contains("CORTEX") && !ip?contains("TRACER_EMB")&& !ip?contains("GUI_INTERFACE")]
[#if ip?contains("STM32_WPAN")]
#include "app_entry.h"
#include "app_common.h"
[/#if]
[#if ip?contains("Sigfox")]
#include "app_sigfox.h"
[/#if]
[#if ip?contains("SubGHz_Phy")]
#include "app_subghz_phy.h"
[/#if]
[#if ip?contains("LoRaWAN")]
#include "app_lorawan.h"
[/#if]
[#if ((!ip?contains("LWIP")&& !ip?contains("STM32_WPAN")&& !ip?contains("LoRaWAN")&& !ip?contains("SubGHz_Phy")&& !ip?contains("Sigfox") && !ip?contains("KMS")) || (ip?contains("LWIP") && (MBEDTLSUSed=="false")))]
    [#assign ipExistsIntoreducevoids=false]
    [#if reducevoids??]
        [#list reducevoids as voidr]
            [#if (!voidr.isNotGenerated && voidr.genCode && (voidr.ipgenericName != "SubGHz_Phy") && ((voidr.ipgenericName?lower_case?contains(ip?lower_case)) ||(voidr.ipgenericName?lower_case?contains("lpuart") && ip?contains("USART"))))]
                #include "${ip?lower_case}.h"
                [#break]
            [/#if]
        [/#list]
        [#list reducevoids as voidr]
            [#if (ipExistsIntoreducevoids == false) && (voidr.ipgenericName?lower_case?contains(ip?lower_case) && !voidr.ipgenericName?lower_case?contains("hrtim"))||(voidr.ipgenericName?lower_case?contains("lpuart") && ip?contains("USART"))]
                [#assign ipExistsIntoreducevoids=true]
                [#break]
            [/#if]
        [/#list]
    [/#if]
    [#if ip?has_content && ipExistsIntoreducevoids == false]
    #include "${ip?lower_case}.h"
    [/#if]    
[/#if]
[/#if]
[#-- Examples Migration (FCR) - Begin--]
[#if ip?contains("FATFS")]
 [#assign familyName=FamilyName?lower_case]
 [#if familyName="stm32g0" || familyName="stm32wb" || familyName="stm32g4" || familyName="stm32l5" || familyName="stm32wl"]
 #include "app_fatfs.h"
 [#else]
 #include "fatfs.h"
 [/#if]
[/#if]
[#-- Examples Migration (FCR) - End--]
[#if ip?contains("USB_DEVICE") || ip?contains("USB_Device")]
[#assign usb_device = true]
[/#if]


[/#list]
[#if RESMGR_UTILITY?? && !RESMGR_UTILITYUsed]
#include "resmgr_utility.h"
[/#if]
[#-- /#if --]
[/#compress]

#n
/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */
#n
/* Private typedef -----------------------------------------------------------*/
[#if HALCompliant??]
[@common.optinclude name=contextFolder+mxTmpFolder+"/rtos_typedefs.tmp"/]
[/#if]
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */
[#if bootMode?? && bootMode=="boot0" && McuDualCore?? && FamilyName=="STM32H7"] [#-- boot0 sequence --]
#ifndef HSEM_ID_0
#define HSEM_ID_0 (0U) /* HW semaphore 0*/
#endif
[/#if]
[#if TZEN=="1" && Secure=="true"]
#n
/* Non-secure Vector table to jump to (internal Flash Bank2 here)             */
/* Caution: address must correspond to non-secure internal Flash where is     */
/*          mapped in the non-secure vector table                             */
#define VTOR_TABLE_NS_START_ADDR  0x08040000UL
[/#if]
/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

[#if usb_device]
  [#if vectors??]
    [#assign wakeupInterrupt = false]
    [#list vectors as vector]
      [#if (vector.vector?contains("OTG_FS") || vector.vector?contains("OTG_HS") || vector.vector?contains("USB")) && (vector.vector?contains("WKUP") || vector.vector?contains("WakeUp"))]
        [#if !wakeupInterrupt]
/* External variables --------------------------------------------------------*/
        [/#if]
        [#assign wakeupInterrupt = true]
        [#assign handleName = getHandleName(vector.vector)]
extern PCD_HandleTypeDef ${handleName};
      [/#if]
    [/#list]
    [#if wakeupInterrupt]
#n
    [/#if]
  [/#if]
[/#if]
/* Private variables ---------------------------------------------------------*/
[#-- WorkAround for Ticket 30863 --]
[#if H7_ETH_NoLWIP?? &&HALCompliant??]
#if defined ( __ICCARM__ ) /*!< IAR Compiler */

#pragma location=[#if RxDescAddress??]${RxDescAddress}[#else]0x30040000[/#if]
ETH_DMADescTypeDef  DMARxDscrTab[ETH_RX_DESC_CNT]; /* Ethernet Rx DMA Descriptors */
#pragma location=[#if TxDescAddress??]${TxDescAddress}[#else]0x30040060[/#if]
ETH_DMADescTypeDef  DMATxDscrTab[ETH_TX_DESC_CNT]; /* Ethernet Tx DMA Descriptors */
#pragma location=[#if RxBuffAddress??]${RxBuffAddress}[#else]0x30040200[/#if]
uint8_t Rx_Buff[ETH_RX_DESC_CNT][ETH_MAX_PACKET_SIZE]; /* Ethernet Receive Buffers */

#elif defined ( __CC_ARM )  /* MDK ARM Compiler */

__attribute__((at([#if RxDescAddress??]${RxDescAddress}[#else]0x30040000[/#if]))) ETH_DMADescTypeDef  DMARxDscrTab[ETH_RX_DESC_CNT]; /* Ethernet Rx DMA Descriptors */
__attribute__((at([#if TxDescAddress??]${TxDescAddress}[#else]0x30040060[/#if]))) ETH_DMADescTypeDef  DMATxDscrTab[ETH_TX_DESC_CNT]; /* Ethernet Tx DMA Descriptors */
__attribute__((at([#if RxBuffAddress??]${RxBuffAddress}[#else]0x30040200[/#if]))) uint8_t Rx_Buff[ETH_RX_DESC_CNT][ETH_MAX_PACKET_SIZE]; /* Ethernet Receive Buffer */

#elif defined ( __GNUC__ ) /* GNU Compiler */ 

ETH_DMADescTypeDef DMARxDscrTab[ETH_RX_DESC_CNT] __attribute__((section(".RxDecripSection"))); /* Ethernet Rx DMA Descriptors */
ETH_DMADescTypeDef DMATxDscrTab[ETH_TX_DESC_CNT] __attribute__((section(".TxDecripSection")));   /* Ethernet Tx DMA Descriptors */
uint8_t Rx_Buff[ETH_RX_DESC_CNT][ETH_MAX_PACKET_SIZE] __attribute__((section(".RxArraySection"))); /* Ethernet Receive Buffers */

#endif

ETH_TxPacketConfig TxConfig; 
[/#if]
[#-- End workaround for Ticket 30863 --]
[#-- If HAL compliant generate Global variable : Peripherals handler -Begin --]
[#if HALCompliant??][#-- if HALCompliant Begin --]
[#compress]
    [#list Peripherals as Peripheral]
        [#if Peripheral??]                
        [#list Peripheral as periph]
                [#-- Global variables --]
                [#if periph.variables??]
                    [#list periph.variables as variable]
[#if !handlerToignore?contains(variable.name)]
${variable.value} ${variable.name};
[/#if]
                    [/#list]
                [/#if][#--if periph.variables??--]
                [#-- Add global dma Handler --]
                [#list periph.configModelList as instanceData]
                    [#if instanceData.dmaHandel??]
                        [#list instanceData.dmaHandel as dHandle]
${dHandle};
                        [/#list]
                    [/#if]
                [/#list]                
            [/#list]#n
        [/#if][#--if Peripheral??--]
    [/#list]
[#-- Add EXTI handler --]
[#--if BspExtiHandler??] [#-- Fix 59273 --]
[#--    [#list BspExtiHandler as ipHandle]
[#-- ${ipHandle.type} ${ipHandle.name};
[#--    [/#list]
[/#if--]
[/#compress]
    [#compress]
    [#-- BDMA global variables --]
    [#-- ADD BDMA Code Begin--]
    [@common.optinclude name=contextFolder+mxTmpFolder+"/bdma_GV.tmp"/]
    [#-- ADD BDMA Code End--]
[#-- BDMA1 global variables --]
    [#-- ADD BDMA1 Code Begin--]
    [@common.optinclude name=contextFolder+mxTmpFolder+"/bdma1_GV.tmp"/]
    [#-- ADD BDMA1 Code End--]
[#-- BDMA2 global variables --]
    [#-- ADD BDMA2 Code Begin--]
    [@common.optinclude name=contextFolder+mxTmpFolder+"/bdma2_GV.tmp"/]
    [#-- ADD BDMA2 Code End--]
    [#-- DMA global variables --]
    [#-- ADD DMA Code Begin--]
    [@common.optinclude name=contextFolder+mxTmpFolder+"/dma_GV.tmp"/]
    [#-- ADD DMA Code End--]
    [#-- ADD MDMA Code Begin--]
    [@common.optinclude name=contextFolder+mxTmpFolder+"/mdma_GV.tmp"/]
    [#-- ADD MDMA Code End--]
    [#-- FMCGlobal variables --]
    [#-- Add FMC Code Begin--]
    [@common.optinclude name=contextFolder+mxTmpFolder+"/mx_fmc_GV.tmp"/]
    [#--ADD FMC Code End--]
    [#-- Add FSMC Code Begin--]
    [@common.optinclude name=contextFolder+mxTmpFolder+"/mx_fsmc_GV.tmp"/]
    [#--ADD FSMC Code End--] 
    [#-- RTOS variables --]
    [#-- ADD RTOS Code Begin--]
    [@common.optinclude name=contextFolder+mxTmpFolder+"/rtos_vars.tmp"/]   
    [#-- ADD RTOS Code End--]
    [/#compress]
   [/#if][#-- if HALCompliant End --]
[#if HALCompliant??]
  [#-- CEC array --]
  [#compress]
  [#list Peripherals as Peripheral]
    [#if Peripheral??]
      [#list Peripheral as IP]
[@common.generateCecRxBuffer configModelList=IP.configModelList methodName="HAL_CEC_Init" argumentName="RxBuffer" bufferType="uint8_t" bufferSize="16"/]
      [/#list]
    [/#if]
  [/#list]
  [/#compress]
[/#if]
    [#-- Global variables --]
[#-- If HAL compliant generate Global variable : Peripherals handler -End --]

/* USER CODE BEGIN PV */

/* USER CODE END PV */
#n
[#list voids as void] 
[#if void.functionName?? && void.functionName == "SystemClock_Config" ]
[#assign rccFctName ="SystemClock_Config"]
[/#if]
[/#list]
[#compress]
[#if clockConfig??]
/* Private function prototypes -----------------------------------------------*/
[#if TZEN=="1" && Secure=="true"]
static void NonSecure_Init(void);
[/#if]
[#if rccFctName?? && ((!McuDualCore?? && TZEN=="0") || ((TZEN=="1" && Secure=="true") && rccIsSecure??) || ((TZEN=="1" && Secure=="false") && !rccIsSecure??)|| (bootMode?? && bootMode=="boot0" && cpucore=="ARM_CORTEX_M7" && McuDualCore??) || (cpucore=="ARM_CORTEX_M4" && McuDualCore?? && FamilyName=="STM32WL"))]
void SystemClock_Config(void); [#-- remove static --]
[#if commonClockConfig??]
void PeriphCommonClock_Config(void);
[/#if]
[/#if]
[/#if]
[#if mpuControl??] [#-- if MPU config is enabled --]
[#--if !McuDualCore?? || (cpucore=="ARM_CORTEX_M7" && McuDualCore??)--]
static void MPU_Config(void); 
[#--/#if--]  
[/#if]    

[#-- modif for freeRtos 21 Augst 2014 --]
[#if FREERTOS??]
 [#if !HALCompliant??]           [#-- modif for freeRtos 24th Nov. 2014 --]
 void MX_FREERTOS_Init(void); 
 [/#if]
[/#if]
[#if HALCompliant??]
    [#list voids as void]
        [#if void.genCode && !(IpInit_ToIgnore?contains(void.ipName)) && !void.ipType?contains("thirdparty")&&!void.ipType?contains("middleware")&&!void.functionName?contains("VREFBUF")&&void.functionName!="Init" && !void.functionName?contains("MotorControl") && !void.functionName?contains("ETZPC") && !void.functionName?contains("TRACER_EMB") && !void.functionName?contains("GUI_INTERFACE")]
                [#if void.isStatic]
                    static void ${""?right_pad(2)}${void.functionName}(void);
                    [#assign staticVoids =staticVoids + " "+ '${void.functionName}']
                [#else]
                    [#-- void ${""?right_pad(2)}${void.functionName}(void);--]
                [/#if]
            
           
        [/#if]
    [/#list]
	[#if OPENAMP??]
       int MX_OPENAMP_Init(int RPMsgRole, rpmsg_ns_bind_cb ns_bind_cb);
    [/#if]
 [@common.optinclude name=contextFolder+mxTmpFolder+"/rtos_pfp.tmp"/]


[/#if]
[#if vectors??]
static void MX_NVIC_Init(void);
[/#if]
[/#compress]
[#if USB_HOST?? && !FREERTOS??]
#nvoid MX_USB_HOST_Process(void);
[/#if]

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  * @retval int
  */
[#if noMain?? && noMain=="false"]
int main(void)
{
[#if TZEN=="1" && Secure=="true"]
  /* SAU/IDAU, FPU and interrupts secure/non-secure allocation setup done */
  /* in SystemInit() based on partition_[#if McuName?starts_with("STM32L562")]stm32l562xx.h[#else]stm32l552xx.h[/#if] file's definitions. */
[/#if]
#t/* USER CODE BEGIN 1 */

#t/* USER CODE END 1 */
[#compress]
[#if bootMode?? && bootMode=="boot0" && cpucore=="ARM_CORTEX_M7" && McuDualCore?? && FamilyName=="STM32H7"][#-- M7 boot0 sequence --]
  /* USER CODE BEGIN Boot_Mode_Sequence_0 */
  #tint32_t timeout; 
  /* USER CODE END Boot_Mode_Sequence_0 */
[/#if]
[#if mpuControl??] [#-- if MPU config is enabled --]
#n#t/* MPU Configuration--------------------------------------------------------*/

    #tMPU_Config();
    
[/#if]

[#if ICache??] [#-- if CPU ICache is enabled --]
#n#t/* Enable I-Cache---------------------------------------------------------*/

    #tSCB_EnableICache();
[/#if]
[#if DCache??] [#-- if CPU DCache config is enabled --]
#n#t/* Enable D-Cache---------------------------------------------------------*/

    #tSCB_EnableDCache();
[/#if]
[#--/#if--]
#n
[#if bootMode?? && McuDualCore?? && FamilyName=="STM32H7"]
/* USER CODE BEGIN Boot_Mode_Sequence_1 */
    [#if bootMode=="boot0" && cpucore=="ARM_CORTEX_M7"] [#-- M7 boot0 sequence --]
#t/* Wait until CPU2 boots and enters in stop mode or timeout*/
  #ttimeout = 0xFFFF;
  #twhile((__HAL_RCC_GET_FLAG(RCC_FLAG_D2CKRDY) != RESET) && (timeout-- > 0));
  #tif ( timeout < 0 )
  #t{
    #tError_Handler();
  #t}
    [/#if]
    [#if bootMode=="boot0" && cpucore=="ARM_CORTEX_M4"]
#t/*HW semaphore Clock enable*/
  #t__HAL_RCC_HSEM_CLK_ENABLE(); 
 #t/* Activate HSEM notification for Cortex-M4*/
  #tHAL_HSEM_ActivateNotification(__HAL_HSEM_SEMID_TO_MASK(HSEM_ID_0));  
  #t/* 
    #tDomain D2 goes to STOP mode (Cortex-M4 in deep-sleep) waiting for Cortex-M7 to
    #tperform system initialization (system clock config, external memory configuration.. )   
  #t*/
  #tHAL_PWREx_ClearPendingEvent();
  #tHAL_PWREx_EnterSTOPMode(PWR_MAINREGULATOR_ON, PWR_STOPENTRY_WFE, PWR_D2_DOMAIN);
  #t/* Clear HSEM flag */
  #t__HAL_HSEM_CLEAR_FLAG(__HAL_HSEM_SEMID_TO_MASK(HSEM_ID_0));
#n
    [/#if]
/* USER CODE END Boot_Mode_Sequence_1 */
[/#if]
#t/* MCU Configuration--------------------------------------------------------*/

[#if clockConfig??]
[#if mpu??] [#-- if MPU, there is no flash --]
#n#t/* Reset of all peripherals, Initializes the Systick. */
[#else]
#n#t/* Reset of all peripherals, Initializes the Flash interface and the Systick. */
[/#if]
[#if isHALUsed??]
#tHAL_Init();
[#else]
    [#if clockConfig??]
#t[@common.optinclude name=contextFolder+mxTmpFolder+"/system.tmp"/] [#-- if LL include system.tmp --]
[/#if]
[/#if]

#n
[#if pwrConfig??]
[#list pwrConfig as config]
 [#assign listOfLocalVariables =""]
        [#assign resultList =""] 	
            [@common.getLocalVariableList instanceData=config/] 
[/#list]
[/#if]
#n
[#-- PWR configuration --]
[#if pwrConfig??]
[#list pwrConfig as config]

[@common.generateConfigModelListCode configModel=config inst="PWR"  nTab=1 index=""/]
[/#list]
[/#if]
#n

[#-- vrefbuf configuration --]
[#if vrefbufConfig??]
[#list vrefbufConfig as config]
[@common.generateConfigModelListCode configModel=config inst="VREFBUF"  nTab=1 index=""/]
[/#list]
[/#if]
#n
#t/* USER CODE BEGIN Init */

#n#t/* USER CODE END Init */
#n
[#list voids as void]
    [#if void.functionName?? && void.functionName?contains("SystemClock_Config") && !void.isNotGenerated]

[#if rccFctName??]
[#if (!McuDualCore?? && TZEN=="0") ||  ((TZEN=="1" && Secure=="true") && rccIsSecure??) || ((TZEN=="1" && Secure=="false") && !rccIsSecure??) || (bootMode?? && bootMode=="boot0" && cpucore=="ARM_CORTEX_M7" && McuDualCore??) || (cpucore=="ARM_CORTEX_M4" && McuDualCore?? && FamilyName=="STM32WL")]
[#if FamilyName=="STM32MP1"]
#tif(IS_ENGINEERING_BOOT_MODE())
#t{
    #t#t/* Configure the system clock */

#t#tSystemClock_Config();
#t}
[#if commonClockConfig??]
#t
#tif(IS_ENGINEERING_BOOT_MODE())
#t{
#t#t/* Configure the peripherals common clocks */
#t#tPeriphCommonClock_Config();
#t}
[/#if]
[#else]
    #n#t/* Configure the system clock */
#tSystemClock_Config();
[#if commonClockConfig??]
#t
/* Configure the peripherals common clocks */
#tPeriphCommonClock_Config();
[/#if]
[/#if]
[/#if][/#if]

[/#if]
[/#list]
   
[/#if]

[#if (cpucore=="ARM_CORTEX_M0+" && McuDualCore?? && FamilyName=="STM32WL" && !isHALUsed??)]
#t/* Update SystemCoreClock variable */
  #tSystemCoreClockUpdate();
[/#if] 
[#if bootMode?? && cpucore=="ARM_CORTEX_M7" && McuDualCore?? && FamilyName=="STM32H7"] [#-- M7 boot0 sequence --]
/* USER CODE BEGIN Boot_Mode_Sequence_2 */
 /* When system initialization is finished, Cortex-M7 will release Cortex-M4  by means of 
     HSEM notification */

  /*HW semaphore Clock enable*/
  __HAL_RCC_HSEM_CLK_ENABLE();

  /*Take HSEM */
  HAL_HSEM_FastTake(HSEM_ID_0);   
  /*Release HSEM in order to notify the CPU2(CM4)*/     
  HAL_HSEM_Release(HSEM_ID_0,0);

  /* wait until CPU2 wakes up from stop mode */
  timeout = 0xFFFF;
  while((__HAL_RCC_GET_FLAG(RCC_FLAG_D2CKRDY) == RESET) && (timeout-- > 0));
  if ( timeout < 0 )
  {
    Error_Handler();
  }
/* USER CODE END Boot_Mode_Sequence_2 */
[/#if]
#n
[#list voids as void]
[#if void.functionName?? && void.functionName?contains("GTZC") && !void.isNotGenerated && void.genCode]
#t/* ${void.functionName} initialisation */
#t${void.functionName}();
[/#if]
[/#list]
#n
[#list voids as void]
[#if void.functionName?? && void.functionName?contains("IPCC") && !void.isNotGenerated && void.genCode]
    #t/* IPCC initialisation */
	#t MX_IPCC_Init();
[/#if]
[/#list]
[#if OPENAMP??]
#t/* OpenAmp initialisation ---------------------------------*/
    #tMX_OPENAMP_Init(RPMSG_REMOTE, NULL);
[/#if]
[#if RESMGR_UTILITY??]
#t/* Resource Manager Utility initialisation ---------------------------------*/
    #tMX_RESMGR_UTILITY_Init();
[/#if]


#n
#t/* USER CODE BEGIN SysInit */

#n#t/* USER CODE END SysInit */
#n

#n#t/* Initialize all configured peripherals */
[#-- FCR: init of middleware to always be done in the main (USBD and USBH, kept in default task (study on-going ) --]
[#assign USE_MBEDTLS = false]
[#list voids as void]
 [#if void.functionName?? && void.functionName?contains("MBEDTLS")]
 [#assign USE_MBEDTLS = true]
 [/#if]
[/#list]
[#list voids as void]
[#if void.functionName?? && !(IpInit_ToIgnore?contains(void.ipName)) && !void.functionName?contains("FREERTOS")&&void.functionName!="Init" && !void.functionName?contains("Process") && !void.functionName?contains("RESMGR_UTILITY")  && !void.functionName?contains("OPENAMP") && !void.functionName?contains("IPCC") && !void.functionName?contains("GTZC") && !void.functionName?contains("ETZPC") && !void.functionName?contains("TRACER_EMB") && !void.functionName?contains("GUI_INTERFACE")]
[#if !void.isNotGenerated && void.genCode]
[#-- FCR: Replaces previous loop (since 5.5.0) --]
[#if void.functionName!="APPE_Init"]
 [#if void.functionName?contains("USBPD") || (FREERTOS?? && (void.functionName?contains("LWIP") || void.functionName?contains("MBEDTLS") || void.functionName?contains("USB_DEVICE") || void.functionName?contains("USB_HOST") || void.functionName?contains("LoRaWAN") || void.functionName?contains("Sigfox") || void.functionName?contains("SubGHz_Phy")))]
 [#-- Nothing generated for 
  - USBPD
  - MBEDTLS with FreeRTOS
  - Lwip with FreeRTOS
  - USBD and USBH when FreeRTOS (still generated in default task as temporary patch) 
 --]
  [#if void.functionName?contains("MBEDTLS") && void.genCode][#-- special comment generated here --]
    #tMX_MBEDTLS_Init();
  [/#if]
 [#else] [#-- must generate a call in all other cases --]
   [#if void.functionName?contains("FATFS") && (familyName="stm32g0" || familyName="stm32wb" || familyName="stm32l5" || familyName="stm32g4")]
  #tif (MX_FATFS_Init() != APP_OK) {
  #t#tError_Handler();
  #t}
   [#else]
  #t${void.functionName}();
   [/#if]
 [/#if]
[/#if]

[/#if]
[/#if]
[/#list]
[#if vectors??]
#n
#t/* Initialize interrupts */
#tMX_NVIC_Init();
[/#if]
[/#compress]

  /* USER CODE BEGIN 2 */

  /* USER CODE END 2 */
#n
[#compress]
[@common.optinclude name=contextFolder+mxTmpFolder+"/rtos_kernelInit.tmp"/][#-- any RTOS can include here --]
[#list voids as void]
  [#if USBPD?? && void.functionName?? && void.functionName?contains("USBPD") && !void.isNotGenerated && void.genCode] [#-- cf BZ-79321 --]
    [#lt]#t/* USBPD initialisation ---------------------------------*/
    [#lt]#tMX_USBPD_Init();
  [/#if]
[/#list]
[#if HALCompliant??][#-- Put after UBSPD init to keep examples generated unchanged --]
[@common.optinclude name=contextFolder+mxTmpFolder+"/rtos_obj_creat.tmp"/][#-- any RTOS can include here --]
[/#if]
[/#compress]
[#if FREERTOS??][#-- If FreeRtos is used --]
  [#if HALCompliant??]
[#list voids as void]
[#if void.functionName?? && void.functionName?contains("APPE_Init")]
#t/* Init code for STM32_WPAN */
#tAPPE_Init();
[/#if]
[/#list]
  [#else]
  /* Call init function for freertos objects (in freertos.c) */
  MX_FREERTOS_Init(); 
  [/#if]
[#else][#-- If FreeRtos is not used --]
[#list voids as void]
[#if void.functionName?? && void.functionName?contains("APPE_Init")]
#t/* Init code for STM32_WPAN */
#tAPPE_Init();
[/#if]
[/#list]
[/#if][#-- If FreeRtos is used --]
[@common.optinclude name=contextFolder+mxTmpFolder+"/rtos_kernelStart.tmp"/]
[#if FREERTOS??] [#-- If FreeRtos is used (should become more generic: if RTOS??) --]
  /* We should never get here as control is now taken by the scheduler */
[/#if]
[#if TZEN=="1" && Secure=="true"][#-- FreeRTOS is not enabled in that case --]
#n
#t/*************** Setup and jump to non-secure *******************************/
#n
#tNonSecure_Init();
#n
#t/* Non-secure software does not return, this code is not executed */
[/#if]
[#if bootMode?? && bootMode=="boot0" && McuDualCore?? && FamilyName=="STM32WL" && cpucore=="ARM_CORTEX_M4"]
#t/* Boot CPU2 */
[#if isHALUsed??]
#tHAL_PWREx_ReleaseCore(PWR_CORE_CPU2);
#n
[#else]
#tLL_PWR_EnableBootC2();
#n
[/#if]   
[/#if]
[#-- if !FREERTOS?? --] 
#t/* Infinite loop */
#t/* USER CODE BEGIN WHILE */
#twhile (1)
#t{
#t#t/* USER CODE END WHILE */
[#if USB_HOST?? && !FREERTOS??]
#t#tMX_USB_HOST_Process();
[/#if]
[#list ips as ip]
[#if ip?contains("LoRaWAN") && !FREERTOS??]
#t#tMX_LoRaWAN_Process();
[/#if]
[#if ip?contains("SubGHz_Phy") && !FREERTOS??]
#t#tMX_SubGHz_Phy_Process();
[/#if]
[#if ip?contains("Sigfox") && !FREERTOS??]
#t#tMX_Sigfox_Process();
[/#if]
[/#list]
#n
[#list voids as void]
[#if void.functionName?? && !(IpInit_ToIgnore?contains(void.ipName)) && void.functionName?contains("Process") && !void.isNotGenerated && !FREERTOS?? && void.genCode]
#t${void.functionName}();
[/#if]
[/#list]
#t#t/* USER CODE BEGIN 3 */
#t}
#t/* USER CODE END 3 */
[#-- if --]
}
[/#if]
[#if TZEN=="1" && Secure=="true"]
#n
/**
  * @brief  Non-secure call function
  *         This function is responsible for Non-secure initialization and switch 
  *         to non-secure state
  * @retval None
  */
static void NonSecure_Init(void)
{
  funcptr_NS NonSecure_ResetHandler;

  SCB_NS->VTOR = VTOR_TABLE_NS_START_ADDR;

  /* Set non-secure main stack (MSP_NS) */
  __TZ_set_MSP_NS((*(uint32_t *)VTOR_TABLE_NS_START_ADDR));

  /* Get non-secure reset handler */
  NonSecure_ResetHandler = (funcptr_NS)(*((uint32_t *)((VTOR_TABLE_NS_START_ADDR) + 4U)));

  /* Start non-secure state software application */
  NonSecure_ResetHandler();
}
[/#if]
[#compress]
[#if clockConfig?? && rccFctName?? && ((!McuDualCore?? && TZEN=="0") ||  ((TZEN=="1" && Secure=="true") && rccIsSecure??) || ((TZEN=="1" && Secure=="false") && !rccIsSecure??) ||(bootMode?? && bootMode=="boot0" && cpucore=="ARM_CORTEX_M7") ||(cpucore=="ARM_CORTEX_M4" && FamilyName=="STM32WL"))]

#n/**
#t* @brief System Clock Configuration
#t* @retval None
#t*/
void SystemClock_Config(void)
{
[#compress]
[#assign nbVars = 0]
[#if FamilyName=="STM32MP1"]
[#-- #if defined (CONFIG_MASTER_MODE) --]
[/#if]
[#assign listOfLocalVariables =""]
        [#assign resultList =""]
    [#list clockConfig as configModel] [#--list0--]
        [#list configModel.configs as config] [#--list1--]
           [#compress] [@common.getLocalVariable configModel1=config listOfLocalVariables=listOfLocalVariables resultList=resultList/][/#compress]
            [#assign listOfLocalVariables =resultList]
            [#assign nbVars = nbVars + getNbVariable(config)]
        [/#list]
    [/#list]
[/#compress]
[#if nbVars != 0 ]
#n
[/#if]
[#assign clockInst=""]
[#assign nTab=1]
[#if clockConfig??] 
[#list clockConfig as configModel] [#--list0--]
    [#--list configModel.configs as config--] [#--list1--]
   [#compress] [@common.generateConfigModelListCode configModel=configModel inst=clockInst  nTab=1 index=""/][/#compress]
    [#--/#list--]
[/#list][/#if]
[#if FamilyName=="STM32MP1"]
[#--  #endif --]
[/#if]
}
[#compress]
[#if commonClockConfig??]

#n/**
#t* @brief Peripherals Common Clock Configuration
#t* @retval None
#t*/
void PeriphCommonClock_Config(void)
{
[#compress]
[#assign nbVars = 0]
[#assign listOfLocalVariables =""]
        [#assign resultList =""]
    [#list commonClockConfig as configModel] [#--list0--]
        [#list configModel.configs as config] [#--list1--]
           [#compress] [@common.getLocalVariable configModel1=config listOfLocalVariables=listOfLocalVariables resultList=resultList/][/#compress]
            [#assign listOfLocalVariables =resultList]
            [#assign nbVars = nbVars + getNbVariable(config)]
        [/#list]
    [/#list]
[/#compress]
[#if nbVars != 0 ]
#n
[/#if]
[#assign clockInst=""]
[#assign nTab=1]
[#if commonClockConfig??] 
[#list commonClockConfig as configModel] [#--list0--]
    [#--list configModel.configs as config--] [#--list1--]
   [#compress] [@common.generateConfigModelListCode configModel=configModel inst=clockInst  nTab=1 index=""/][/#compress]
    [#--/#list--]
[/#list][/#if]
}[/#if]
[/#compress]
[/#if]

[/#compress]

[#compress]
[#if vectors??]
#n/**
#t* @brief NVIC Configuration.
#t* @retval None
#t*/
static void MX_NVIC_Init(void)
{
[#list vectors as vector]
  #t/* ${vector.vector} interrupt configuration */
  [#if (vector.vector?contains("OTG_FS") || vector.vector?contains("OTG_HS") || vector.vector?contains("USB")) && (vector.vector?contains("WKUP") || vector.vector?contains("WakeUp"))]
    [#assign handleName = getHandleName(vector.vector)]
    [#assign ipName = getIpName(vector.vector)]
    #tif (${handleName}.Init.low_power_enable == 1)
    #t{
    [@common.generateUsbWakeUpInterrupt ipName=ipName tabN=2/]
    [#if vector.usedDriver == "HAL"]
    #t#tHAL_NVIC_SetPriority(${vector.vector}, ${vector.preemptionPriority}, ${vector.subPriority});
    #t#tHAL_NVIC_EnableIRQ(${vector.vector});
    [#else]
      [#if !NVICPriorityGroup??]
    #t#tNVIC_SetPriority(${vector.vector}, ${vector.preemptionPriority});
      [#else]
    #t#tNVIC_SetPriority(${vector.vector}, NVIC_EncodePriority(NVIC_GetPriorityGrouping(),${vector.preemptionPriority}, ${vector.subPriority}));
      [/#if]
    #t#tNVIC_EnableIRQ(${vector.vector});
    [/#if]
    #t}
  [#else]
    [#if vector.usedDriver == "HAL"]
    #tHAL_NVIC_SetPriority(${vector.vector}, ${vector.preemptionPriority}, ${vector.subPriority});
    [#else]
      [#if !NVICPriorityGroup??]
    #tNVIC_SetPriority(${vector.vector}, ${vector.preemptionPriority});
      [#else]
    #tNVIC_SetPriority(${vector.vector}, NVIC_EncodePriority(NVIC_GetPriorityGrouping(),${vector.preemptionPriority}, ${vector.subPriority}));
      [/#if]
    [/#if]
    [#if vector.systemHandler=="false"]
      [#if vector.usedDriver == "HAL"]
      #tHAL_NVIC_EnableIRQ(${vector.vector});
      [#else]
      #tNVIC_EnableIRQ(${vector.vector});
      [/#if]
    [/#if]
  [/#if]
[/#list]
}
#n
[/#if]
[/#compress]

[#function getIpName(vectorName)]
    [#if vectorName?starts_with("OTG_FS")]
        [#return "USB_OTG_FS"]
    [#elseif vectorName?starts_with("OTG_HS")]
        [#return "USB_OTG_HS"]
    [#elseif vectorName?starts_with("USB")]
        [#return "USB"]
    [/#if]
    [#return ""]
[/#function]

[#function getHandleName(vectorName)]
    [#if vectorName?starts_with("OTG_FS")]
        [#return "hpcd_USB_OTG_FS"]
    [#elseif vectorName?starts_with("OTG_HS")]
        [#return "hpcd_USB_OTG_HS"]
    [#elseif vectorName?starts_with("USB")]
        [#return "hpcd_USB_FS"]
    [/#if]
    [#return ""]
[/#function]

[#-- function getNbVariable --]
[#function getNbVariable configModel1]
    [#if configModel1.methods??] 
        [#assign methodList1 = configModel1.methods]
    [#else] [#assign methodList1 = configModel1.libMethod]
    [/#if]
 [#assign nbVars = 0]
 [#assign myListOfLocalVariables = ""]
    [#list methodList1 as method][#-- list methodList1 --][#if method.arguments?? && method.status!="WARNING"]
        [#list method.arguments as argument][#-- list method.arguments --]
            [#if argument.genericType == "struct"][#-- if struct --]
                [#if argument.context??][#-- if argument.context?? --]
                    [#if argument.context!="global"&&argument.status!="WARNING"&&argument.status!="NULL"] [#-- if !global --]
                    [#assign varName= " "+argument.name]                    
                    [#assign ll= myListOfLocalVariables?split(" ")]
                    [#assign exist=false]
                    [#list ll as var  ]
                        [#if var==argument.name]
                            [#assign exist=true]
                        [/#if]
                    [/#list]
                    [#if !exist]  [#-- if exist --]                  
                      [#assign myListOfLocalVariables = myListOfLocalVariables + " "+ argument.name]
                      [#assign nbVars = nbVars + 1]
                      [#assign resultList = myListOfLocalVariables]
                    [/#if][#-- if exist --]
                    [/#if][#-- if global --]
                [#else][#-- if context?? --]
            [/#if][#-- if argument.context?? --]
[#else][#-- if non struct --]
                [#if argument.context??][#-- if argument.context?? --]
                    [#if argument.context!="global"&&argument.status!="WARNING"&&argument.status!="NULL"&&argument.returnValue="true"] [#-- if !global --]
                    [#assign varName= " "+argument.name]                    
                    [#assign ll= myListOfLocalVariables?split(" ")]
                    [#assign exist=false]
                    [#list ll as var  ]
                        [#if var==argument.name]
                            [#assign exist=true]
                        [/#if]
                    [/#list]
                    [#if !exist]  [#-- if exist --]                  
                      [#assign myListOfLocalVariables = myListOfLocalVariables + " "+ argument.name]
                      [#assign nbVars = nbVars + 1]
                      [#assign resultList = myListOfLocalVariables]
                    [/#if][#-- if exist --]
                    [/#if][#-- if global --]
                [#else][#-- if context?? --]
            [/#if]
            [/#if][#-- if struct --]
        [/#list][#-- list method.arguments --]
        [/#if]
    [/#list][#-- list methodList1 --]
[#return nbVars]
[/#function]
[#-- function getNbVariable of a config End--]

[#if HALCompliant??][#-- if HALCompliant Begin --]
#n[#list Peripherals as Peripheral][#if Peripheral??]
[#list Peripheral as IP]
[#-- Section1: Create the void mx_<IpInstance>_<HalMode>_init() function for each ip instance --]
[#compress]
[#list IP.configModelList as instanceData]
[#assign ipName = instanceData.ipName]
[#if instanceData.isMWUsed=="false" && instanceData.isBusDriverUSed=="false" && !ipName?contains("CORTEX") && !ipName?contains("PWR")&& !ipName?contains("VREFBUF")&& !ipName?contains("HSEM")&& !ipName?contains("RESMGR_UTILITY") && !ipName?contains("TRACER_EMB") && !ipName?contains("GUI_INTERFACE")]
     [#assign instName = instanceData.instanceName]

        [#assign halMode= instanceData.halMode]
/**
#t* @brief  ${instName} Initialization Function
#t* @param  None
#t* @retval None
#t*/
            [#if halMode!=ipName&&!ipName?contains("TIM")&&!ipName?contains("CEC")][#if staticVoids?contains('MX_${instName}_${halMode}_Init')]static[/#if] void MX_${instName}_${halMode}_Init(void)[#else][#if staticVoids?contains('MX_${instName}_Init')]static[/#if] void MX_${instName}_Init(void)[/#if]
            {     
#n
[#if RESMGR_UTILITY??]
    [@common.optinclude name=contextFolder+mxTmpFolder+"/resmgrutility_"+instName+".tmp"/][#-- ADD RESMGR_UTILITY Code--]
[/#if]
      
#t/* USER CODE BEGIN ${instName}_Init 0 */
#n
 #t/* USER CODE END ${instName}_Init 0 */
     
#n
        [#-- assign ipInstanceIndex = instName?replace(name,"")--]
        [#assign args = ""]
        [#assign listOfLocalVariables =""]
        [#assign resultList =""]
 	[#--list instanceData.configs as config--]
            [@common.getLocalVariableList instanceData=instanceData/]            
        [#--/#list--]#n

#n
        [#--list instanceData.configs as config--]
[#--debug instance name = ${instName}--]
[#if instanceData.usedDriver?? && instanceData.usedDriver!="HAL"][#--Check if LL driver is used. instanceData:ConfigModel --]
    [#-- varaible declaration --]

    [#assign v = ""]
    [#if instanceData.initServices?? && instanceData.initServices.gpio??]
        [#assign service=instanceData.initServices.gpio]
           [#list service.variables as variable] [#-- variables declaration --]
               [#if v?contains(variable.name)]
               [#-- no matches--]
               [#else]
   #t${variable.value} ${variable.name} = {0};
                   [#assign v = v + " "+ variable.name/]	
               [/#if]	
           [/#list]  

    [/#if]

    [#-- if used with LL and MspPost init is required using gpioOut service --]
    [#if instanceData.initServices?? && instanceData.initServices.gpioOut?? ]
           [#assign service=instanceData.initServices.gpioOut]
           [#list service.variables as variable] [#-- variables declaration --]
               [#if v?contains(variable.name)]
               [#-- no matches--]
               [#else]
   #t${variable.value} ${variable.name} = {0};
                   [#assign v = v + " "+ variable.name/]	
               [/#if]	
           [/#list]  

    [/#if]


[#assign listOfLocalVariables =""]
    [#assign resultList =""]
[#if instanceData.initServices??]
    [#if instanceData.initServices.pclockConfig??]

        [#assign   pclockConfig=instanceData.initServices.pclockConfig] [#--list0--]
        [#list pclockConfig.configs as config] [#--list1--]
            [@common.getLocalVariable configModel1=config listOfLocalVariables=listOfLocalVariables resultList=resultList/]
            [#assign listOfLocalVariables =resultList]
        [/#list]
    [/#if]
[/#if]
#n
[#assign clockInst=""]

[#if instanceData.initServices??]
    [#if instanceData.initServices.pclockConfig??]
[#if FamilyName=="STM32MP1"]
#tif(IS_ENGINEERING_BOOT_MODE())
#t{
[#assign nTab=2]
[#else]
[#assign nTab=1]
[/#if]
[#assign   pclockConfig=instanceData.initServices.pclockConfig] [#--list0--]
[@common.generateConfigModelListCode configModel=pclockConfig inst=""  nTab=nTab index=""/]#n
[#if FamilyName=="STM32MP1"]
#t}
[/#if]
#n
    [/#if]
[/#if]

    [#-- Generate service code --]
    #n[@common.generateServiceCode ipName=instName serviceType="Init" modeName="mode" instHandler=instName tabN=1 IPData=instanceData/] 
#n
[/#if]
 #t/* USER CODE BEGIN ${instName}_Init 1 */
#n
 #t/* USER CODE END ${instName}_Init 1 */
[#if ipName?contains("SPI")]
#t/* ${instName}   parameter configuration*/
[/#if]

[#if instanceData.instIndex??][@common.generateConfigModelListCode configModel=instanceData inst=instName  nTab=1 index=instanceData.instIndex/][#else][@common.generateConfigModelListCode configModel=instanceData inst=instName  nTab=1 index=""/][/#if]

[#list ips as ip]
[#if ip?contains("PDM2PCM") && instName?contains("CRC")]
#t__HAL_CRC_DR_RESET(&h${instName?lower_case});
[/#if]

[/#list]



 #t/* USER CODE BEGIN ${instName}_Init 2 */
#n
 #t/* USER CODE END ${instName}_Init 2 */


[#-- MspPostInit callBack if needed for output gpio config --]
[#if instanceData.initServices??]
    [#if instanceData.initServices.gpioOut??]
        [#if instanceData.usedDriver?? && instanceData.usedDriver=="HAL"]
            [#assign ipName = instanceData.ipName]
            [#list instanceData.initCallBackInitMethodList as initCallBack]
                [#if initCallBack?contains("PostInit")]
                #t${initCallBack}([#if ipName?contains("TIM")&&!(ipName?contains("HRTIM")||ipName?contains("LPTIM"))]&htim[#else]&h${instanceData.realIpName?lower_case}[/#if]${instanceData.instIndex});
                [/#if]
            [/#list]
        [#else][#-- Else if LL is used gpio code should be generated --]
            [@common.generateConfigCode ipName=instName type="Init" serviceName="gpioOut" instHandler="Tim"?lower_case+"Handle" tabN=1 IPData1=instanceData/]  
        [/#if]
    [/#if]
[/#if]
[#-- MspPostInit End --]

#n}#n
[/#if]
[/#list]
[/#compress]
[/#list][/#if]
[/#list]

[@common.optinclude name=contextFolder+mxTmpFolder+"/bdma.tmp"/][#-- ADD BDMA Code--]
[@common.optinclude name=contextFolder+mxTmpFolder+"/bdma1.tmp"/][#-- ADD BDMA1 Code--]
[@common.optinclude name=contextFolder+mxTmpFolder+"/bdma2.tmp"/][#-- ADD BDMA2 Code--]

[@common.optinclude name=contextFolder+mxTmpFolder+"/dma.tmp"/][#-- ADD DMA Code--]
[@common.optinclude name=contextFolder+mxTmpFolder+"/mdma.tmp"/][#-- ADD MDMA Code--]
[@common.optinclude name=contextFolder+mxTmpFolder+"/mx_fmc_HC.tmp"/][#-- FMC Init --]
[@common.optinclude name=contextFolder+mxTmpFolder+"/gpio.tmp"/][#-- ADD GPIO Code--] 
[/#if] [#-- if HALCompliant End --]
#n

[#-- FSMC Init --]
[@common.optinclude name=contextFolder+mxTmpFolder+"/mx_fsmc_HC.tmp"/]
#n

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */
#n

[#if HALCompliant??] [#-- If FreeRtos is used (and tmp files included in the main) --]
[@common.optinclude name=contextFolder+mxTmpFolder+"/rtos_default_thread.tmp"/]
[@common.optinclude name=contextFolder+mxTmpFolder+"/rtos_threads.tmp"/]
[@common.optinclude name=contextFolder+mxTmpFolder+"/rtos_callbacks.tmp"/]
[/#if] [#-- If FreeRtos is used (and tmp files included in the main) --]
[#--if !McuDualCore?? || (cpucore=="ARM_CORTEX_M7" && McuDualCore??)--]
[#if mpuControl??] [#-- if MPU config is enabled --]
/* MPU Configuration */
[@common.optinclude name=contextFolder+mxTmpFolder+"/cortex.tmp"/]
[/#if]
[#--/#if--]
[#-- For Tim timebase --]
[#if cpucore!="" && cpucore?replace("ARM_CORTEX_","")=="M4"]
    [#if  timeBaseSource_M4??]
        [#assign timeBaseSource = timeBaseSource_M4]
        [#assign timeBaseHandlerType = timeBaseHandlerType_M4]
        [#assign timeBaseHandler = timeBaseHandler_M4]
    [/#if]
[/#if]
[#if cpucore!="" &&cpucore?replace("ARM_CORTEX_","")=="M7"]
    [#if  timeBaseSource_M7??]
        [#assign timeBaseSource = timeBaseSource_M7]
        [#assign timeBaseHandlerType = timeBaseHandlerType_M7]
        [#assign timeBaseHandler = timeBaseHandler_M7]
    [/#if]
[/#if]
[#if cpucore!="" &&cpucore?replace("ARM_CORTEX_","")=="M0+"]
    [#if  timeBaseSource_M0PLUS??]
        [#assign timeBaseSource = timeBaseSource_M0PLUS]
        [#assign timeBaseHandlerType = timeBaseHandlerType_M0PLUS]
        [#assign timeBaseHandler = timeBaseHandler_M0PLUS]
    [/#if]
[/#if]
[#if timeBaseSource?? && timeBaseSource.contains("TIM")]
/**
  * @brief  Period elapsed callback in non blocking mode
  * @note   This function is called  when ${timeBaseSource} interrupt took place, inside
  * HAL_TIM_IRQHandler(). It makes a direct call to HAL_IncTick() to increment
  * a global variable "uwTick" used as application time base.
  * @param  htim : TIM handle
  * @retval None
  */
void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim)
{
  /* USER CODE BEGIN Callback 0 */

  /* USER CODE END Callback 0 */
  if (htim->Instance == ${timeBaseSource}) {
    HAL_IncTick();
  }
  /* USER CODE BEGIN Callback 1 */

  /* USER CODE END Callback 1 */
}
[/#if]

/**
  * @brief  This function is executed in case of error occurrence.
  * @retval None
  */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */
  __disable_irq();
  while (1)
  {
  }
  /* USER CODE END Error_Handler_Debug */
}

#ifdef  USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t *file, uint32_t line)
{
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */



/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
