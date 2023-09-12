[#ftl]
[#list configs as dt]
[#assign data = dt]
[#assign coreDir=sourceDir]
[#assign peripheralParams =dt.peripheralParams]
[#assign peripheralGPIOParams =dt.peripheralGPIOParams]
[#assign peripheralDMAParams =dt.peripheralDMAParams]
[#assign peripheralNVICParams =dt.peripheralNVICParams]
[#assign HSE_timout ="0000"]
[#list peripheralParams.get("RCC").entrySet() as paramEntry]
[#if paramEntry.value??  && paramEntry.key=="HSE_Timout"][#assign HSE_timout = paramEntry.value][/#if]
[#if paramEntry.value??  && paramEntry.key=="LSE_Timout"][#assign LSE_Timout = paramEntry.value][/#if]
[/#list]
[/#list]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

[#if TZEN=="1" && Secure=="true"]
#if defined ( __ICCARM__ )
#  define CMSE_NS_CALL  __cmse_nonsecure_call
#  define CMSE_NS_ENTRY __cmse_nonsecure_entry
#else
#  define CMSE_NS_CALL  __attribute((cmse_nonsecure_call))
#  define CMSE_NS_ENTRY __attribute((cmse_nonsecure_entry))
#endif
#n
[/#if]
/* Includes ------------------------------------------------------------------*/
[#assign includesList = ""]
[#if isHALUsed??]
#include "${FamilyName?lower_case}xx_hal.h"
[#assign includesList = includesList+" "+"${FamilyName?lower_case}xx_hal.h"]
[/#if]
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
[#if RESMGR_UTILITY?? && !RESMGR_UTILITYUsed]
#include "resmgr_utility.h"
[/#if]
[#list ips as ip]
[#if ip?contains("STM32_WPAN")]
    [#assign name=contextFolder + coreDir+"/Inc/app_conf.h"/]
    [#assign appFileExist = common.fileExist(name)]  [#-- Check if app file exists --]	    
    [#list voids as void]
        [#-- BZ114099 --]
        [#if void.functionName?? && void.functionName?contains("APPE_Init")]
		[#if appFileExist=="true"]
#include "app_conf.h"
		[/#if]
#include "app_entry.h"
#include "app_common.h"
[#if FamilyName=="STM32WBA"]
#include "app_debug.h"
[/#if]
        [/#if]
    [/#list]
[/#if]
[#if ip?contains("KMS")]
#include "app_kms.h"
[/#if]
[#if ip?contains("MotorControl")]
#include "${ip?lower_case}.h"
[/#if]

[/#list]
[#compress]
[#--include "mxconstants.h"--]

[#if LLincludes??] [#-- Include LL headers --]
    [#list LLincludes as inc]
        [#if !includesList?contains(inc)]
#include "${inc}"
            [#assign includesList = includesList+" "+inc]
        [/#if]
    [/#list]
[/#if]
#n

[#-- /#if --]
[#if TZEN=="1" && Secure=="false"]
[#if (Structure?? && Structure=="FullNonSecure")]
[#else]
#include "secure_nsc.h"    /* For export Non-secure callable APIs */
[/#if]
[/#if]
[#--Include common LL driver --]
[#if isLLUsed??] [#-- Include LL headers --]
    [#-- Include common LL driver that should be always included--]
    [#-- include "${FamilyName?lower_case}xx_ll_bus.h" --]
    [#if !includesList?contains(FamilyName?lower_case+"xx_ll_bus.h")]
    #include "${FamilyName?lower_case}xx_ll_bus.h"
        [#assign includesList = includesList+" "+FamilyName?lower_case+"xx_ll_bus.h"]
    [/#if]
    [#-- include "${FamilyName?lower_case}xx_ll_cortex.h" --]
    [#if !includesList?contains(FamilyName?lower_case+"xx_ll_cortex.h") && FamilyName!="STM32MP1"]
    #include "${FamilyName?lower_case}xx_ll_cortex.h"
        [#assign includesList = includesList+" "+FamilyName?lower_case+"xx_ll_cortex.h"]
    [/#if]
    [#-- include "${FamilyName?lower_case}xx_ll_rcc.h" --]
    [#if !includesList?contains(FamilyName?lower_case+"xx_ll_rcc.h")]
    #include "${FamilyName?lower_case}xx_ll_rcc.h"
        [#assign includesList = includesList+" "+FamilyName?lower_case+"xx_ll_rcc.h"]
    [/#if]
    [#-- include "${FamilyName?lower_case}xx_ll_system.h" --]
    [#if !includesList?contains(FamilyName?lower_case+"xx_ll_system.h")]
    #include "${FamilyName?lower_case}xx_ll_system.h"
        [#assign includesList = includesList+" "+FamilyName?lower_case+"xx_ll_system.h"]
    [/#if]
    [#-- include "${FamilyName?lower_case}xx_ll_utils.h" --]
    [#if !includesList?contains(FamilyName?lower_case+"xx_ll_utils.h")]
    #include "${FamilyName?lower_case}xx_ll_utils.h"
        [#assign includesList = includesList+" "+FamilyName?lower_case+"xx_ll_utils.h"]
    [/#if]
    [#-- include "${FamilyName?lower_case}xx_ll_gpio.h" --]
    [#if !includesList?contains(FamilyName?lower_case+"xx_ll_gpio.h")]
    #include "${FamilyName?lower_case}xx_ll_gpio.h"
        [#assign includesList = includesList+" "+FamilyName?lower_case+"xx_ll_gpio.h"]
    [/#if]
    [#-- include "${FamilyName?lower_case}xx_ll_exti.h" --]
    [#if !includesList?contains(FamilyName?lower_case+"xx_ll_exti.h")]
    #include "${FamilyName?lower_case}xx_ll_exti.h"
        [#assign includesList = includesList+" "+FamilyName?lower_case+"xx_ll_exti.h"]
    [/#if]
    [#-- include "${FamilyName?lower_case}xx_ll_pwr.h"     --]
    [#if !includesList?contains(FamilyName?lower_case+"xx_ll_pwr.h")]
    #include "${FamilyName?lower_case}xx_ll_pwr.h"
        [#assign includesList = includesList+" "+FamilyName?lower_case+"xx_ll_pwr.h"]
    [/#if]
    [#if !includesList?contains(FamilyName?lower_case+"xx_ll_dma.h")]
    #include "${FamilyName?lower_case}xx_ll_dma.h"
        [#assign includesList = includesList+" "+FamilyName?lower_case+"xx_ll_dma.h"]
    [/#if]

[#if !isHALUsed??]
#if defined(USE_FULL_ASSERT)
#include "stm32_assert.h"
#endif /* USE_FULL_ASSERT */
[/#if]

[/#if]
[/#compress]
#n

[#-- MZA add the list of files (board_conf.h,..) to be include into the main.h for Tikcet 50684 --]
[#compress]
[#assign bspConfIncludesList = ""]
[#if BspConfIncludes??] [#-- Include Bsp Configuration file --]
    [#list BspConfIncludes as inc]
        [#if !bspConfIncludesList?contains(inc)]
#include "${inc}"
            [#assign bspConfIncludesList = bspConfIncludesList+" "+inc]
        [/#if]
    [/#list]
[/#if]
[/#compress]

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */
#n
/* Exported types ------------------------------------------------------------*/
[#if TZEN=="1" && Secure=="true"]
/* Function pointer declaration in non-secure*/
#if defined ( __ICCARM__ )
typedef void (CMSE_NS_CALL *funcptr)(void);
#else
typedef void CMSE_NS_CALL (*funcptr)(void);
#endif

/* typedef for non-secure callback functions */
typedef funcptr funcptr_NS;
#n
[/#if]
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */
[#compress]
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
[/#compress] 
#n
/* Exported functions prototypes ---------------------------------------------*/
void Error_Handler(void);
[#if HALCompliant??]
[#list voids as void]
  [#if (void.isStatic?? && !void.isStatic) && ((void.bspUsed?? && void.bspUsed && !void.isNotGenerated)||(void.functionName!="SystemClock_Config"))]
[#if !void.ipType?contains("thirdparty")&&!void.ipType?contains("middleware")&&!void.functionName?contains("VREFBUF")&&void.functionName!="Init" && !void.functionName?contains("MotorControl") && !void.functionName?contains("ETZPC") && !void.functionName?contains("TRACER_EMB") && !void.functionName?contains("GUI_INTERFACE")]
void ${void.functionName}(void);
[/#if]
  [/#if]
[/#list]
[/#if]

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
[#if UserDefines??][#-- user defines declaration --]
[#assign defines = UserDefines.get(0)]
[#list defines.entrySet() as define]
[#if (define.key)?? & (define.value)??]
#define ${define.key} ${define.value}
[/#if]
[/#list]
[/#if]
[#if LabelDefines??][#-- user defines declaration --]
[#assign defines = LabelDefines.get(0)]
[#list defines.entrySet() as define]
#define ${define.key} ${define.value}
[/#list]
[/#if]
[#if isHALUsed??]
[#else]
[#if FamilyName!="STM32G0" && FamilyName!="STM32L5"]
#ifndef NVIC_PRIORITYGROUP_0
#define NVIC_PRIORITYGROUP_0         ((uint32_t)0x00000007) /*!< 0 bit  for pre-emption priority,
                                                                 4 bits for subpriority */
#define NVIC_PRIORITYGROUP_1         ((uint32_t)0x00000006) /*!< 1 bit  for pre-emption priority,
                                                                 3 bits for subpriority */
#define NVIC_PRIORITYGROUP_2         ((uint32_t)0x00000005) /*!< 2 bits for pre-emption priority,
                                                                 2 bits for subpriority */
#define NVIC_PRIORITYGROUP_3         ((uint32_t)0x00000004) /*!< 3 bits for pre-emption priority,
                                                                 1 bit  for subpriority */
#define NVIC_PRIORITYGROUP_4         ((uint32_t)0x00000003) /*!< 4 bits for pre-emption priority,
                                                                 0 bit  for subpriority */
#endif
[/#if]
[#if FamilyName=="STM32L5"]
#ifndef NVIC_PRIORITYGROUP_0
#define NVIC_PRIORITYGROUP_0         ((uint32_t)0x00000007) /*!< 0 bit  for pre-emption priority,
                                                                 3 bits for subpriority */
#define NVIC_PRIORITYGROUP_1         ((uint32_t)0x00000006) /*!< 1 bit  for pre-emption priority,
                                                                 2 bits for subpriority */
#define NVIC_PRIORITYGROUP_2         ((uint32_t)0x00000005) /*!< 2 bits for pre-emption priority,
                                                                 1 bits for subpriority */
#define NVIC_PRIORITYGROUP_3         ((uint32_t)0x00000004) /*!< 3 bits for pre-emption priority,
                                                                 0 bit  for subpriority */
#endif
[/#if]
[/#if]

/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */
