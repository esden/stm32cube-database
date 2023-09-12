[#ftl]
[#if GRAPHICS??]
[#assign coreDir="Core/"]
[#else]
[#assign coreDir=""]
[/#if]
[#assign coreDir=sourceDir]
[#assign contextFolder=""]
[#if cpucore!=""]    
[#assign contextFolder = cpucore?replace("ARM_CORTEX_","C")+"/"]
[/#if]
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
[#if !ip?contains("FATFS") && !ip?contains("FREERTOS") && !ip?contains("NVIC")&& !ip?contains("NVIC1")&& !ip?contains("NVIC2")&& !ip?contains("CORTEX") && !ip?contains("GRAPHICS") && !ip?contains("GRAPHICS_M4")&& !ip?contains("GRAPHICS_M7") && !ip?contains("TRACER_EMB")]
[#if ip?contains("STM32_WPAN")]
#include "app_entry.h"
[/#if]
[#if (!ip?contains("LWIP")&& !ip?contains("STM32_WPAN")) || (ip?contains("LWIP") && (MBEDTLSUSed=="false"))]
#include "${ip?lower_case}.h"
[/#if][/#if]
[#-- Examples Migration (FCR) - Begin--]
[#if ip?contains("FATFS")]
 [#assign familyName=FamilyName?lower_case]
 [#if familyName="stm32g0" || familyName="stm32wb" || familyName="stm32g4"]
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

[#if USE_Touch_GFX_STACK??]
       [#--include "BoardConfiguration.hpp"--]
[/#if]
#n
/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */
#n
/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */
[#if bootMode?? && bootMode=="boot0" && McuDualCore??] [#-- boot0 sequence --]
#define HSEM_ID_0 (0U) /* HW semaphore 0*/
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
${variable.value} ${variable.name};
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
[#if rccFctName?? && ((!McuDualCore??) || (bootMode?? && bootMode=="boot0" && cpucore=="ARM_CORTEX_M7" && McuDualCore??))]
[#if USE_Touch_GFX_STACK??]
extern "C" void SystemClock_Config(void); [#-- remove static --]
[#else]
void SystemClock_Config(void); [#-- remove static --]
[/#if]
[/#if]
[/#if]
[#if mpuControl??] [#-- if MPU config is enabled --]
[#if !McuDualCore?? || (cpucore=="ARM_CORTEX_M7" && McuDualCore??)]
static void MPU_Config(void); 
[/#if]  
[/#if]    

[#-- modif for freeRtos 21 Augst 2014 --]
[#if FREERTOS??]
 [#if !HALCompliant??]           [#-- modif for freeRtos 24th Nov. 2014 --]
 void MX_FREERTOS_Init(void); 
 [/#if]
[/#if]
[#if HALCompliant??]
    [#list voids as void]
        [#if !void.ipType?contains("thirdparty")&&!void.functionName?contains("FREERTOS")&&void.functionName!="Init"&&!void.functionName?contains("FATFS")&& !void.functionName?contains("LWIP")&& !void.functionName?contains("MBEDTLS")&& !void.functionName?contains("USB_DEVICE") && !void.functionName?contains("USB_Device") && !void.functionName?contains("USB_HOST")&& !void.functionName?contains("CORTEX")&& !void.functionName?contains("SystemClock_Config")&& !void.functionName?contains("LIBJPEG")&& !void.functionName?contains("PDM2PCM")&& !void.functionName?contains("TOUCHSENSING")&& !void.functionName?contains("MotorControl")&& !void.functionName?contains("RESMGR_UTILITY") && !void.functionName?contains("OPENAMP") && !void.functionName?contains("TRACER_EMB") && !void.functionName?contains("APPE_Init") && !void.functionName?contains("ETZPC")]
            [#if !void.functionName?contains("GRAPHICS") && !void.functionName?contains("USBPD")]
                [#if void.isStatic]
                    static void ${""?right_pad(2)}${void.functionName}(void);
                    [#assign staticVoids =staticVoids + " "+ '${void.functionName}']
                [#else]
                    void ${""?right_pad(2)}${void.functionName}(void);
                [/#if]
            [/#if]
            [#if !void.isNotGenerated && (void.functionName?contains("GRAPHICS") || (void.functionName?contains("GRAPHICS_M4") && cpucore=="ARM_CORTEX_M4") || (void.functionName?contains("GRAPHICS_M7") && cpucore=="ARM_CORTEX_M7"))]
          extern void GRAPHICS_HW_Init(void);
          extern void ${""?right_pad(2)}${void.functionName}(void);
          extern void GRAPHICS_MainTask(void);
            [/#if]
        [/#if]
    [/#list]
	[#if OPENAMP??]
       int MX_OPENAMP_Init(int RPMsgRole, rpmsg_ns_bind_cb ns_bind_cb);
    [/#if]
 [@common.optinclude name=contextFolder+mxTmpFolder+"/rtos_pfp.tmp"/]
[#else]
    [#list voids as void]
        [#if void.isNotGenerated?? && !void.isNotGenerated && (void.functionName?contains("GRAPHICS") || (void.functionName?contains("GRAPHICS_M4") && cpucore=="ARM_CORTEX_M4") || (void.functionName?contains("GRAPHICS_M7") && cpucore=="ARM_CORTEX_M7"))]
   extern void GRAPHICS_HW_Init(void);
   extern void ${""?right_pad(2)}${void.functionName}(void);
   extern void GRAPHICS_MainTask(void);
        [/#if]
    [/#list]
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
  /* USER CODE BEGIN 1 */

  /* USER CODE END 1 */
  [#if bootMode?? && bootMode=="boot0" && cpucore=="ARM_CORTEX_M7" && McuDualCore??] [#-- M7 boot0 sequence --]
  /* USER CODE BEGIN Boot_Mode_Sequence_0 */
  #tint32_t timeout; 
  /* USER CODE END Boot_Mode_Sequence_0 */
  [/#if]

[#compress]
[#if !McuDualCore?? || (cpucore=="ARM_CORTEX_M7" && McuDualCore??)]
[#if mpuControl??] [#-- if MPU config is enabled --]

#t/* MPU Configuration--------------------------------------------------------*/

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
[/#if]
#n
[#if bootMode?? && McuDualCore??]
/* USER CODE BEGIN Boot_Mode_Sequence_1 */
[#if bootMode?? && bootMode=="boot0" && cpucore=="ARM_CORTEX_M7" && McuDualCore??] [#-- M7 boot0 sequence --]
#t/* Wait until CPU2 boots and enters in stop mode or timeout*/
  #ttimeout = 0xFFFF;
  #twhile((__HAL_RCC_GET_FLAG(RCC_FLAG_D2CKRDY) != RESET) && (timeout-- > 0));
  #tif ( timeout < 0 )
  #t{
    #tError_Handler();
  #t}
[/#if]
[#if bootMode?? && bootMode=="boot0" && cpucore=="ARM_CORTEX_M4" && McuDualCore??]
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
#t/* USER CODE BEGIN Init */

#n#t/* USER CODE END Init */
#n
[#list voids as void]
    [#if void.functionName?? && void.functionName?contains("SystemClock_Config") && !void.isNotGenerated]

[#if rccFctName??]
[#if (!McuDualCore??) || (bootMode?? && bootMode=="boot0" && cpucore=="ARM_CORTEX_M7" && McuDualCore??)]
    #n#t/* Configure the system clock */
#tSystemClock_Config();[/#if][/#if]
    [/#if]
[/#list]
[/#if]
[#if bootMode?? && cpucore=="ARM_CORTEX_M7" && McuDualCore??] [#-- M7 boot0 sequence --]
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
[#if void.functionName?? && void.functionName?contains("IPCC") && !void.isNotGenerated]
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
[#list voids as void]
[#if void.functionName?? && !void.functionName?contains("FREERTOS")&&!void.functionName?contains("CORTEX")&& !void.functionName?contains("SystemClock_Config")&&void.functionName!="Init" && !void.functionName?contains("Process") && !void.functionName?contains("RESMGR_UTILITY")  && !void.functionName?contains("OPENAMP") && !void.functionName?contains("IPCC") && !void.functionName?contains("ETZPC") && !void.functionName?contains("TRACER_EMB")]
[#if !void.isNotGenerated]
[#if ((FREERTOS?? && void.ipType=="peripheral") || !FREERTOS??) && void.functionName!="GRAPHICS_Init"]
[#if void.functionName?contains("FATFS") && (familyName="stm32g0" || familyName="stm32wb")]
 [#-- Required by the examples migration (due to the fact that the function signature has changed and returns a value now. --]
 #tif (MX_FATFS_Init() != APP_OK) {
 #t#tError_Handler();
 #t}
 [#else]
[#if void.functionName="APPE_Init"]
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
[#list voids as void]
[#if void.functionName?? && void.functionName?contains("APPE_Init")]
#tAPPE_Init();
[/#if]
[/#list]
[#if USBPD??]
    [#lt]#t/* USBPD initialisation ---------------------------------*/
    [#lt]#tMX_USBPD_Init();
[/#if]

[#if FREERTOS??] [#-- If FreeRtos is used --]
    [#if GRAPHICS??]
/* Initialise the graphical hardware */
  GRAPHICS_HW_Init();
#n
#t/* Initialise the graphical stack engine */
#tGRAPHICS_Init();#n      
      [/#if]
  [#if HALCompliant??]
  [@common.optinclude name=contextFolder+mxTmpFolder+"/rtos_HalInit.tmp"/] [#-- include generated tmp file22 Augst 2014 --]
  [#else]
  /* Call init function for freertos objects (in freertos.c) */
  MX_FREERTOS_Init();
  [/#if]

  [@common.optinclude name=contextFolder+mxTmpFolder+"/rtos_start.tmp"/] [#-- include generated tmp file 13 Nov 2014 --] 
  /* We should never get here as control is now taken by the scheduler */
[/#if]

[#-- if !FREERTOS?? --] 
#n
[#if GRAPHICS?? && !FREERTOS??]

/* Initialise the graphical hardware */
  GRAPHICS_HW_Init();



  /* Initialise the graphical stack engine */
  GRAPHICS_Init();
  
  /* Graphic application */  
  GRAPHICS_MainTask();
    
  /* Infinite loop */
  for(;;);
[#else]
#t/* Infinite loop */
#t/* USER CODE BEGIN WHILE */
#twhile (1)
#t{
#t#t/* USER CODE END WHILE */
[#if USB_HOST?? && !FREERTOS??]
#t#tMX_USB_HOST_Process();
[/#if]
#n
[#list voids as void]
[#if void.functionName?? && void.functionName?contains("Process") && !void.isNotGenerated && !FREERTOS??]
#t${void.functionName}();
[/#if]
[/#list]
#t#t/* USER CODE BEGIN 3 */
#t}
#t/* USER CODE END 3 */
[/#if]
[#-- if --]
}
[/#if]
[#compress]
[#if clockConfig?? && rccFctName?? && (!McuDualCore?? || (bootMode?? && bootMode=="boot0" && cpucore=="ARM_CORTEX_M7"))]

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
}[/#if]
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
[#if instanceData.isMWUsed=="false" && instanceData.isBusDriverUSed=="false" && !ipName?contains("CORTEX") && !ipName?contains("RESMGR_UTILITY")]
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

[#if HALCompliant??] [#-- If FreeRtos is used --]
[@common.optinclude name=contextFolder+mxTmpFolder+"/rtos_threads.tmp"/]
[@common.optinclude name=contextFolder+mxTmpFolder+"/rtos_user_threads.tmp"/] 
[/#if] [#-- If FreeRtos is used --]
[#if !McuDualCore?? || (cpucore=="ARM_CORTEX_M7" && McuDualCore??)]
[#if mpuControl??] [#-- if MPU config is enabled --]
/* MPU Configuration */
[@common.optinclude name=contextFolder+mxTmpFolder+"/cortex.tmp"/]
[/#if]
[/#if]
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
[#assign familyName=FamilyName?lower_case]
[#if familyName="stm32f0" || familyName="stm32f3" ||familyName="stm32l4"]
void assert_failed(char *file, uint32_t line)
[#else]
void assert_failed(uint8_t *file, uint32_t line)
[/#if]
{ 
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     tex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */



/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
