[#ftl]
[#if GRAPHICS??]
[#assign coreDir="Core/"]
[#else]
[#assign coreDir=""]
[/#if]
[#assign coreDir=sourceDir]

/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
[@common.optinclude name=coreDir+"Src/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
[#assign staticVoids =""]
[#compress]
[#assign usb_device = false]
/* Includes ------------------------------------------------------------------*/
#include "${main_h}"
[#if isHalSupported?? && isHALUsed?? ]
#include "${FamilyName?lower_case}xx_hal.h"
[/#if]
[#if H7_ETH_NoLWIP?? &&HALCompliant??]
#include "string.h"
[/#if]
[#-- IF GFXMMU is used and all is generated in the main and the Lut is configured--]
[#if GFXMMUisUsed?? && HALCompliant??]
[@common.optincludeFile path=coreDir+"Inc" name="gfxmmu_lut.h"/]
[/#if]
[#-- move includes to main.h --]
[@common.optinclude name=coreDir+"Src/rtos_inc.tmp"/][#--include freertos includes --]
[#-- if !HALCompliant??--][#-- if HALCompliant Begin --]
[#assign LWIPUSed = "false"]
[#assign MBEDTLSUSed = "false"]
[#list ips as ip]
[#if ip?contains("LWIP")]
[#assign LWIPUSed = "true"]
[/#if]
[#if ip=="MBEDTLS"]
[#assign MBEDTLSUSed = "true"]
[/#if]
[/#list]
[#list ips as ip]
[#if !ip?contains("FREERTOS") && !ip?contains("NVIC")&& !ip?contains("CORTEX")&& !ip?contains("GRAPHICS")]
[#if !ip?contains("LWIP") || (ip?contains("LWIP") && (MBEDTLSUSed=="false"))]
#include "${ip?lower_case}.h"
[/#if][/#if]
[#if ip?contains("USB_DEVICE")]
[#assign usb_device = true]
[/#if]
[/#list]
[#-- /#if --]
[/#compress]

[#if USE_Touch_GFX_STACK??]
       [#--include "BoardConfiguration.hpp"--]
[/#if]
#n
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */
#n
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
[/#compress]
    [#compress]
    [#-- BDMA global variables --]
    [#-- ADD BDMA Code Begin--]
    [@common.optinclude name=coreDir+"Src/bdma_GV.tmp"/]
    [#-- ADD BDMA Code End--]
    [#-- DMA global variables --]
    [#-- ADD DMA Code Begin--]
    [@common.optinclude name=coreDir+"Src/dma_GV.tmp"/]
    [#-- ADD DMA Code End--]
    [#-- ADD MDMA Code Begin--]
    [@common.optinclude name=coreDir+"Src/mdma_GV.tmp"/]
    [#-- ADD MDMA Code End--]
    [#-- FMCGlobal variables --]
    [#-- Add FMC Code Begin--]
    [@common.optinclude name=coreDir+"Src/mx_fmc_GV.tmp"/]
    [#--ADD FMC Code End--]
    [#-- Add FSMC Code Begin--]
    [@common.optinclude name=coreDir+"Src/mx_fsmc_GV.tmp"/]
    [#--ADD FSMC Code End--] 
    [#-- RTOS variables --]
    [#-- ADD RTOS Code Begin--]
    [@common.optinclude name=coreDir+"Src/rtos_vars.tmp"/]   
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
#n#n

/* USER CODE BEGIN PV */
/* Private variables ---------------------------------------------------------*/

/* USER CODE END PV */
#n
[#compress]
[#if clockConfig??]
/* Private function prototypes -----------------------------------------------*/
[#if isHALUsed??]
[#-- Use HAL_MspInit--]
[#else]
static void LL_Init(void);
[/#if]
void SystemClock_Config(void); [#-- remove static --]
[/#if]
[#if mpuControl??] [#-- if MPU config is enabled --]
static void MPU_Config(void); 
[/#if]    

[#-- modif for freeRtos 21 Augst 2014 --]
[#if FREERTOS??]
 [#if !HALCompliant??]           [#-- modif for freeRtos 24th Nov. 2014 --]
 void MX_FREERTOS_Init(void); 
 [/#if]
[/#if]
[#if HALCompliant??]
    [#list voids as void]
        [#if !void.ipType?contains("thirdparty")&&!void.functionName?contains("FREERTOS")&&void.functionName!="Init"&&!void.functionName?contains("FATFS")&& !void.functionName?contains("LWIP")&& !void.functionName?contains("MBEDTLS")&& !void.functionName?contains("USB_DEVICE")&& !void.functionName?contains("USB_HOST")&& !void.functionName?contains("CORTEX")&& !void.functionName?contains("SystemClock_Config")&& !void.functionName?contains("LIBJPEG")&& !void.functionName?contains("PDM2PCM")&& !void.functionName?contains("TOUCHSENSING")&& !void.functionName?contains("MotorControl")]
            [#if !void.functionName?contains("GRAPHICS")]
                [#if void.isStatic]
                    static void ${""?right_pad(2)}${void.functionName}(void);
                    [#assign staticVoids =staticVoids + " "+ '${void.functionName}']
                [#else]
                    void ${""?right_pad(2)}${void.functionName}(void);
                [/#if]
            [/#if]
            
            [#if !void.isNotGenerated&&void.functionName?contains("GRAPHICS")]
          extern void GRAPHICS_HW_Init(void);
          extern void ${""?right_pad(2)}${void.functionName}(void);
          extern void GRAPHICS_MainTask(void);
            [/#if]
        [/#if]
    [/#list]
 [@common.optinclude name=coreDir+"Src/rtos_pfp.tmp"/]
[#else]
    [#list voids as void]
        [#if void.isNotGenerated?? && !void.isNotGenerated&&void.functionName?contains("GRAPHICS")]
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
[#-- PostInit declaration --]
[#if Peripherals??]
    [#assign postinitList = ""]
    [#list Peripherals as Peripheral]
        [#if Peripheral??]
            [#list Peripheral as IP]
                [#list IP.configModelList as instanceData]
                [#if instanceData.initServices??]
                    [#if instanceData.initServices.gpioOut??] 
                        [#list instanceData.initCallBackInitMethodList as initCallBack]
                            [#if initCallBack?contains("PostInit")]
                                [#assign halMode = instanceData.halMode]
                                [#assign ipName = instanceData.ipName]
                                [#assign ipInstance = instanceData.instanceName]
                                [#if halMode!=ipName&&!ipName?contains("TIM")&&!ipName?contains("CEC")]
                                    [#if !postinitList?contains(initCallBack)]
                                        #nvoid ${initCallBack}(${instanceData.halMode}_HandleTypeDef *h${instanceData.halMode?lower_case});
                                        [#assign postinitList = postinitList+" "+initCallBack]
                                    [/#if]
                                [#else]
                                    [#if !postinitList?contains(initCallBack)]
                                    #nvoid ${initCallBack}([#if ipName?contains("TIM")&&!(ipName?contains("HRTIM")||ipName?contains("LPTIM"))]TIM_HandleTypeDef *htim[#else]${ipName}_HandleTypeDef *h${ipName?lower_case}[/#if]);
                                    [#assign postinitList = postinitList+" "+initCallBack]
                                    [/#if]
                                [/#if]
                                [#break] [#-- take only the first PostInit : case of timer--]
                            [/#if]
                        [/#list]
                    [/#if]
                [/#if]

                [/#list]
            [/#list]
        [/#if]
    [/#list]
[/#if]

[#-- PostInit declaration : End --]
#n
/* USER CODE BEGIN PFP */
/* Private function prototypes -----------------------------------------------*/

/* USER CODE END PFP */


/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  *
  * @retval None
  */
int main(void)
{
  /* USER CODE BEGIN 1 */

  /* USER CODE END 1 */

[#compress]
[#if mpuControl??] [#-- if MPU config is enabled --]
#t/* MPU Configuration----------------------------------------------------------*/
    #tMPU_Config();
[/#if]
[#if ICache??] [#-- if CPU ICache is enabled --]
#n#t/* Enable I-Cache-------------------------------------------------------------*/
    #tSCB_EnableICache();
[/#if]
[#if DCache??] [#-- if CPU DCache config is enabled --]
#n#t/* Enable D-Cache-------------------------------------------------------------*/
    #tSCB_EnableDCache();
[/#if]
#n
#t/* MCU Configuration----------------------------------------------------------*/
[#if clockConfig??]
#n#t/* Reset of all peripherals, Initializes the Flash interface and the Systick. */
[#if isHALUsed??]
#tHAL_Init();
[#else]
#tLL_Init();
[/#if]
#n
#t/* USER CODE BEGIN Init */

#n#t/* USER CODE END Init */
#n
#n#t/* Configure the system clock */
#tSystemClock_Config();
[/#if]
#n
#t/* USER CODE BEGIN SysInit */

#n#t/* USER CODE END SysInit */
#n
#n#t/* Initialize all configured peripherals */
[#list voids as void]
[#if void.functionName?? && !void.functionName?contains("FREERTOS")&&!void.functionName?contains("CORTEX")&& !void.functionName?contains("SystemClock_Config")&&void.functionName!="Init" && !void.functionName?contains("Process")]
[#if !void.isNotGenerated]
[#if ((FREERTOS?? && void.ipType=="peripheral") || !FREERTOS??) && void.functionName!="GRAPHICS_Init"]
#t${void.functionName}();
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

[#if FREERTOS??] [#-- If FreeRtos is used --]
    [#if GRAPHICS??]
/* Initialise the graphical hardware */
  GRAPHICS_HW_Init();
#n
#t/* Initialise the graphical stack engine */
#tGRAPHICS_Init();#n      
      [/#if]
  [#if HALCompliant??]
  [@common.optinclude name=coreDir+"Src/rtos_HalInit.tmp"/] [#-- include generated tmp file22 Augst 2014 --]
  [#else]
  /* Call init function for freertos objects (in freertos.c) */
  MX_FREERTOS_Init();
  [/#if]

  [@common.optinclude name=coreDir+"Src/rtos_start.tmp"/] [#-- include generated tmp file 13 Nov 2014 --] 
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
#n
#t/* USER CODE END WHILE */
[#if USB_HOST?? && !FREERTOS??]
#t#tMX_USB_HOST_Process();
[/#if]
#n
[#list voids as void]
[#if void.functionName?? && void.functionName?contains("Process")]
#t${void.functionName}();
[/#if]
[/#list]
#t/* USER CODE BEGIN 3 */

#t}
#t/* USER CODE END 3 */
[/#if]
#n
[#-- if --]
}

[#if isHALUsed??]
[#-- Use HAL_MspInit--]
[#else]
    [#if clockConfig??]
static void LL_Init(void)
{
#t[@common.optinclude name=coreDir+"Src/system.tmp"/] [#-- if LL include system.tmp --]
}
    [/#if]
[/#if]
[#compress]
[#if clockConfig??]
#n/**
#t* @brief System Clock Configuration
#t* @retval None
#t*/
void SystemClock_Config(void)
{
#n
[#compress]
[#assign listOfLocalVariables =""]
        [#assign resultList =""]
    [#list clockConfig as configModel] [#--list0--]
        [#list configModel.configs as config] [#--list1--]
           [#compress] [@common.getLocalVariable configModel1=config listOfLocalVariables=listOfLocalVariables resultList=resultList/][/#compress]
            [#assign listOfLocalVariables =resultList]
        [/#list]
    [/#list]
[/#compress]#n
[#assign clockInst=""]
[#assign nTab=1]
[#if clockConfig??] 
[#list clockConfig as configModel] [#--list0--]
    [#--list configModel.configs as config--] [#--list1--]
   [#compress] [@common.generateConfigModelListCode configModel=configModel inst=clockInst  nTab=1 index=""/][/#compress]#n
    [#--/#list--]
[/#list][/#if]
[#-- configure systick interrupts  --]
[#if systemVectors??]
    [#list systemVectors as initVector] 
        [#if initVector.vector=="SysTick_IRQn" && initVector.codeInMspInit]
            #t/* ${initVector.vector} interrupt configuration */
            [#if rccUsedDriver == "HAL"]
                #tHAL_NVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority}, ${initVector.subPriority});
            [#else]
                [#if FamilyName=="STM32L0" || FamilyName=="STM32F0"]
                #tNVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority});
                [#else]
                #tNVIC_SetPriority(${initVector.vector}, NVIC_EncodePriority(NVIC_GetPriorityGrouping(),${initVector.preemptionPriority}, ${initVector.subPriority}));
                [/#if]
            [/#if]
            [#if initVector.systemHandler=="false"]
                [#if rccUsedDriver == "HAL"]
                    #tHAL_NVIC_EnableIRQ(${initVector.vector});#n
                [#else]
                    #tNVIC_EnableIRQ(${initVector.vector});#n
                [/#if]
                    
            [/#if]
        [/#if]
    [/#list]
[/#if]
}[/#if]
#n

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
      [#if FamilyName=="STM32L0" || FamilyName=="STM32F0"]
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
      [#if FamilyName=="STM32L0" || FamilyName=="STM32F0"]
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

[#if HALCompliant??][#-- if HALCompliant Begin --]
#n[#list Peripherals as Peripheral][#if Peripheral??]
[#list Peripheral as IP]
[#-- Section1: Create the void mx_<IpInstance>_<HalMode>_init() function for each ip instance --]
[#compress]
[#list IP.configModelList as instanceData]
[#assign ipName = instanceData.ipName]
[#if instanceData.isMWUsed=="false" && !ipName?contains("CORTEX") ]
     [#assign instName = instanceData.instanceName]

        [#assign halMode= instanceData.halMode]
        /* ${instName} init function */ 
       
            [#if halMode!=ipName&&!ipName?contains("TIM")&&!ipName?contains("CEC")][#if staticVoids?contains('MX_${instName}_${halMode}_Init')]static[/#if] void MX_${instName}_${halMode}_Init(void)[#else][#if staticVoids?contains('MX_${instName}_Init')]static[/#if] void MX_${instName}_Init(void)[/#if]
            {       
#n
        [#-- assign ipInstanceIndex = instName?replace(name,"")--]
        [#assign args = ""]
        [#assign listOfLocalVariables =""]
        [#assign resultList =""]
 	[#--list instanceData.configs as config--]
            [@common.getLocalVariableList instanceData=instanceData/]            
        [#--/#list--]#n
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
   #t${variable.value} ${variable.name};
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
   #t${variable.value} ${variable.name};
                   [#assign v = v + " "+ variable.name/]	
               [/#if]	
           [/#list]  
    [/#if]
    [#-- Generate service code --]
    #n[@common.generateServiceCode ipName=instName serviceType="Init" modeName="mode" instHandler=instName tabN=1 IPData=instanceData/] 
[/#if]
[#if ipName?contains("SPI")]
#t/* ${instName}   parameter configuration*/
[/#if]
[#if instanceData.instIndex??][@common.generateConfigModelListCode configModel=instanceData inst=instName  nTab=1 index=instanceData.instIndex/][#else][@common.generateConfigModelListCode configModel=instanceData inst=instName  nTab=1 index=""/][/#if]

[#list ips as ip]
[#if ip?contains("PDM2PCM")]
#t__HAL_CRC_DR_RESET(&h${instName?lower_case});
[/#if]
[/#list]

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

[@common.optinclude name=coreDir+"Src/bdma.tmp"/][#-- ADD BDMA Code--]
[@common.optinclude name=coreDir+"Src/dma.tmp"/][#-- ADD DMA Code--]
[@common.optinclude name=coreDir+"Src/mdma.tmp"/][#-- ADD MDMA Code--]
[@common.optinclude name=coreDir+"Src/mx_fmc_HC.tmp"/][#-- FMC Init --]
[@common.optinclude name=coreDir+"Src/gpio.tmp"/][#-- ADD GPIO Code--]
[/#if] [#-- if HALCompliant End --]
#n
[#-- FSMC Init --]
[@common.optinclude name=coreDir+"Src/mx_fsmc_HC.tmp"/]
#n
/* USER CODE BEGIN 4 */

/* USER CODE END 4 */
#n

[#if HALCompliant??] [#-- If FreeRtos is used --]
[@common.optinclude name=coreDir+"Src/rtos_threads.tmp"/]
[@common.optinclude name=coreDir+"Src/rtos_user_threads.tmp"/] 
[/#if] [#-- If FreeRtos is used --]

[#if mpuControl??] [#-- if MPU config is enabled --]
/* MPU Configuration */
[@common.optinclude name=coreDir+"Src/cortex.tmp"/]
[/#if]
[#-- For Tim timebase --]
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
  * @param  file: The file name as string.
  * @param  line: The line in file as a number.
  * @retval None
  */
void _Error_Handler(char *file, int line)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */
  while(1)
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
void assert_failed(uint8_t* file, uint32_t line)
{ 
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     tex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
