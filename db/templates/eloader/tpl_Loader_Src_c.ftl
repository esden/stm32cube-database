[#ftl]
[#assign familyName=FamilyName?lower_case]
[#assign IpInit_ToIgnore = "VREFBUF CORTEX_M4 CORTEX_M7 CORTEX_M0+ CORTEX_M33_S CORTEX_M33_NS HSEM PWR RCC"]
[#assign azureMW_list = "threadx levelx filex netxduo usbx"]
[#assign staticVoids =""]
[#assign includeList =""]
[#assign EXTMEM_USED = false]
[#assign targetMemory ="EXTMEMORY_1"]
[#if EloaderMemory?? && EloaderMemory = "EXTMEM2"]
[#assign targetMemory ="EXTMEMORY_2"]
[/#if]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    extmemloader_init.c  
  * @author  MCD Application Team
  * @brief   This file defines the system initialisation of an external loader.
  *
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/
#include "extmemloader_init.h"
#include <string.h>
#include <stdio.h>
[#if EloaderTarget?? && EloaderTarget = "PROGRAMMER"]
#include "Dev_inf.h"
[/#if]
[#if EloaderTrace?? && EloaderTrace = "true"]
#include "usart_if.h"
[/#if]
[#compress]
[#list ips as ip]
[#if !ip?contains("FATFS") && !ip?contains("FREERTOS") && !ip?contains("NVIC")&& !ip?contains("NVIC1")&& !ip?contains("NVIC2")&& !ip?contains("CORTEX") && !ip?contains("TRACER_EMB")&& !ip?contains("GUI_INTERFACE")]
[#if ip?contains("Sigfox")]
#include "app_sigfox.h"
[/#if]
[#if ip?contains("SubGHz_Phy")]
#include "app_subghz_phy.h"
[/#if]
[#if ip?contains("LoRaWAN")]
#include "app_lorawan.h"
[/#if]
[#if ((!ip?contains("LWIP")&& !ip?contains("STM32_WPAN")&& !ip?contains("LoRaWAN")&& !ip?contains("SubGHz_Phy")&& !ip?contains("Sigfox") && !ip?contains("KMS") && !ip?contains("MotorControl")) || (ip?contains("LWIP") && (MBEDTLSUSed=="false")))]
    [#assign ipExistsIntoreducevoids=false]
    [#if reducevoids??]
        [#list reducevoids as voidr]
            [#if (!voidr.isNotGenerated && voidr.genCode && (voidr.ipgenericName != "SubGHz_Phy") && (((voidr.ipgenericName?lower_case)?starts_with("tim")&&(ip?lower_case)=="tim") ||(voidr.ipgenericName?lower_case==(ip?lower_case)) ||(voidr.ipgenericName?lower_case?contains("lpuart") && ip?contains("USART")))||(!voidr.isNotGenerated && voidr.genCode && (voidr.ipgenericName != "SubGHz_Phy") && voidr.ipgenericName?lower_case?contains(ip?lower_case)))]

				[#if azureMW_list?contains(ip?lower_case)]
					[#-- FileX, NetXDuo and USBX calls should be performed in threadx.
					This should be updated to support the bare-metal mode
					--]
					[#if !THREADX?? && ip?lower_case!="usb" && ip?lower_case!="levelx"]
						#include "app_${ip?lower_case}.h"
					[/#if]
                [#else]
                    [#if !existsInList(includeList?split(" "),ip?lower_case+".h") && !ip?lower_case?contains("extmem_loader")]
					#include "${ip?lower_case}.h"
                    [#assign includeList =includeList + " "+ '${ip?lower_case}.h']
                    [/#if]
				[/#if]
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
    [#if (ip?has_content && ipExistsIntoreducevoids == false) && !ip?lower_case?contains("threadx") && !ip?lower_case?contains("levelx") && !ip?lower_case?contains("usbx")]
    [#if !existsInList(includeList?split(" "),ip?lower_case+".h")]
    #include "${ip?lower_case}.h"
    [#assign includeList =includeList + " "+ '${ip?lower_case}.h']
    [/#if]
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
[#if (ip?lower_case ==("usb")) && !existsInList(includeList?split(" "),ip?lower_case+".h")]
	#include "${ip?lower_case}.h"
[#assign includeList =includeList + " "+ '${ip?lower_case}.h']
[/#if]
[#if ip?contains("EXTMEM")]
[#assign EXTMEM_USED = true]
[/#if]
[/#list]
[/#compress]


/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

#n
/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

[#if EloaderTrace?? && EloaderTrace = "true"]
#define TRACE_DEBUG(_STR_) MX_EXTMEM_Trace(_STR_)
[/#if]

/* Private variables ---------------------------------------------------------*/
[#assign variablename =""]
[#assign dmahandler =""]
[#if HALCompliant??][#-- if HALCompliant Begin --]
[#compress]
    [#list Peripherals as Peripheral]
        [#if Peripheral??]
        [#list Peripheral as periph]
                [#-- Global variables --]
                [#if periph.variables??]

                    [#list periph.variables as variable]
                    [#if !variablename?contains(variable.value+ " "+variable.name + ";") && !handlerToignore?contains(variable.name)]
                    ${variable.value} ${variable.name};
                    [#assign variablename =variablename + " "+ variable.value+ " "+variable.name + ";"]
                    [/#if]
                    [/#list]
                [/#if][#--if periph.variables??--]
                [#-- Add global dma Handler --]
                [#list periph.configModelList as instanceData]
                    [#if instanceData.dmaHandel?? && periph.ipName!="GPDMA" && periph.ipName!="LPDMA" && periph.ipName!="HPDMA"]
                        [#list instanceData.dmaHandel as dHandle]
${dHandle};
[#assign dmahandler =dmahandler + " "+ dHandle]
                        [/#list]
                    [/#if]
                [/#list]
            [/#list]#n
        [/#if][#--if Peripheral??--]
    [/#list]
[/#compress]
[/#if][#--if HALCompliant??--]

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/

[#compress]
[#if HALCompliant??]
    [#list voids as void]
        [#if void.genCode && !(IpInit_ToIgnore?contains(void.ipName)) && !void.ipType?contains("thirdparty")&&!void.ipType?contains("middleware")&&!void.functionName?contains("VREFBUF")&&void.functionName!="Init" && !void.functionName?contains("MotorControl") && !void.functionName?contains("ETZPC") && !void.functionName?contains("TRACER_EMB") && !void.functionName?contains("GUI_INTERFACE") && !void.functionName?contains("RF")]
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
	[#if FREERTOS??]
 [@common.optinclude name=contextFolder+mxTmpFolder+"/rtos_pfp.tmp"/]
    [/#if]
[/#if]
[/#compress]

static void SystemClock_Config(void);

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */


/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/**
  * @brief  main entry of the external flash loader initialization.
  * @param  None
  * @retval  0 : operation is ok else operation is failed

  */
uint32_t extmemloader_Init()
{
  uint32_t retr = 0;
  /* USER CODE BEGIN 1 */

  /* USER CODE END 1 */
[#if !STM32_EXTMEMLOADER_STM32CUBEOPENBLTARGET_Used??]

  /* Init system */
  SystemInit();

  /* disable all the IRQ */
  __disable_irq();

  /* MCU Configuration--------------------------------------------------------*/
[#compress]
#t/* Enable the CPU Cache */
#n#t/* Enable I-Cache---------------------------------------------------------*/

    #tSCB_EnableICache();
#n#t/* Enable D-Cache---------------------------------------------------------*/

    #tSCB_EnableDCache();
[/#compress]
#n
  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* MPU Configuration--------------------------------------------------------*/
  HAL_MPU_Disable();

  /* USER CODE BEGIN Init */

  /* USER CODE END Init */

  /* Configure the system clock  */
  SystemClock_Config();
[#else]

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_MspInit();

  /* MPU Configuration--------------------------------------------------------*/
  HAL_MPU_Disable();

  /* USER CODE BEGIN Init */

  /* USER CODE END Init */

[/#if]
  /* USER CODE BEGIN SysInit */

  /* USER CODE END SysInit */

#n#t/* Initialize all configured peripherals */
[#-- FCR: init of middleware to always be done in the main (USBD and USBH, kept in default task (study on-going ) --]
[#assign USE_MBEDTLS = false]
[#list voids as void]
 [#if void.functionName?? && void.functionName?contains("MBEDTLS")]
 [#assign USE_MBEDTLS = true]
 [/#if]
[/#list]
[#list voids as void]
[#if void.functionName?? && !(IpInit_ToIgnore?contains(void.ipName)) && !void.functionName?contains("FREERTOS")&&void.functionName!="Init" && !void.functionName?contains("Process") && !void.functionName?contains("RESMGR_UTILITY")  && !void.functionName?contains("OPENAMP") && !void.functionName?contains("IPCC") && !void.functionName?contains("GTZC") && !void.functionName?contains("ETZPC") && !void.functionName?contains("TRACER_EMB") && !void.functionName?contains("GUI_INTERFACE") && !void.functionName?contains("RF")]
[#if !void.isNotGenerated && void.genCode]
[#-- FCR: Replaces previous loop (since 5.5.0) --]
[#if void.functionName!="APPE_Init"]
 [#if void.functionName?contains("USBPD") || 
	((XCUBEFREERTOS?? || FREERTOS??) && (void.functionName?contains("LWIP") ||
					void.functionName?contains("MBEDTLS") || 
					void.functionName?contains("USB_DEVICE") || 
					void.functionName?contains("USB_HOST") || 
					void.functionName?contains("LoRaWAN") || 
					void.functionName?contains("Sigfox") || 
					void.functionName?contains("SubGHz_Phy"))) ||
	(THREADX?? && (void.functionName?contains("FileX") || 
	void.functionName?contains("USBX") || 
	void.functionName?contains("NetXDuo") || 
	void.functionName?contains("LevelX") ||
	[#-- BZ 120745 remove call to MX_MwName_init when ThreadX is used--]
	void.ipType?contains("thirdparty"))) ||
	(!THREADX?? && void.functionName?contains("LevelX")) ||
            (THREADX?? &&(void.functionName?contains("LoRaWAN") || 
                void.functionName?contains("Sigfox") || 
		void.functionName?contains("SubGHz_Phy") || 
		void.functionName?contains("KMS")))
 ]
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
   [#elseif !void.functionName?contains("EXTMEM_LOADER")]
#t${void.functionName}();
   [/#if]
 [/#if]
[/#if]

[/#if]
[/#if]
[/#list]

[#if EloaderTrace?? && EloaderTrace = "true"]
#t/* Initialize trace interface */
#tMX_EXTMEM_Trace_Init();

  TRACE_DEBUG("\n\nCall Function Init\n");
[/#if]

  /* USER CODE BEGIN 2 */

  /* USER CODE END 2 */

  return retr;
}

#n/**
#t* @brief System Clock Configuration
#t* @retval None
#t*/
void SystemClock_Config(void)
{
[#compress]
[#assign nbVars = 0]
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
[#if Structure?? && (Structure=="FullSecure" || Structure=="Default")]
#tif (HAL_RCC_DeInit() != HAL_OK)
  #t{
    #t#tError_Handler();
  #t}
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
[#-- debug instance name = ${instName} --]
[#if instName?starts_with("GPDMA") | instName?starts_with("LPDMA") | instName?starts_with("HPDMA") | (instanceData.usedDriver?? && instanceData.usedDriver!="HAL")][#--Check if LL driver is used. instanceData:ConfigModel --]
    [#-- variable declaration --]

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
    [#if !(instName?starts_with("GPDMA")) && !(instName?starts_with("LPDMA")) && !(instName?starts_with("HPDMA")) && instanceData.initServices?? && instanceData.initServices.dma?? && IsDMA3ServiceUsed?? ]
        [#assign service=instanceData.initServices.dma]
           [#list service as dmaConfig]
                [#list dmaConfig.variables as variable] [#-- variables declaration --]
                    [#if v?contains(variable.name)]
                    [#-- no matches--]
                    [#else]
                        #t${variable.value} ${variable.name} = {0};
                        [#assign v = v + " "+ variable.name/]	
                    [/#if]	
                [/#list]
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
[@common.optinclude name=contextFolder+mxTmpFolder+"/linkedlist.tmp"/][#-- ADD LINKEDLIST Code--]
[@common.optinclude name=contextFolder+mxTmpFolder+"/mx_fmc_HC.tmp"/][#-- FMC Init --]
[@common.optinclude name=contextFolder+mxTmpFolder+"/gpio.tmp"/][#-- ADD GPIO Code--] 
[/#if][#-- if HALCompliant Begin --]

/**
  * @brief  This function is executed in case of error occurrence.
  * @retval None
  */
void Error_Handler(void)
{
  /* User may add here some code to deal with this error */
  while(1)
  {
  }
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
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
  }
}
#endif /* USE_FULL_ASSERT */

[#function existsInList(myList,keyName)]
    [#if myList?? && keyName??]
        [#list myList as elem]
                [#if elem==keyName]
                   [#return true]                    
                [/#if]
        [/#list]
        [#return false]
    [/#if]   
    [#return false]
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
