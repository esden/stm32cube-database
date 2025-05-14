[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    extmemloader_init.h
  * @author  MCD Application Team
  * @brief   Header file of Loader_Src.c
  *
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef EXTMEMLOADER_INIT_H
#define EXTMEMLOADER_INIT_H

/* Includes ------------------------------------------------------------------*/
[#assign includesList = ""]
[#if isHALUsed??]
#include "${FamilyName?lower_case}xx_hal.h"
[#assign includesList = includesList+" "+"${FamilyName?lower_case}xx_hal.h"]
[/#if]
[#compress]

[#if LLincludes??] [#-- Include LL headers --]
    [#list LLincludes as inc]
        [#if !includesList?contains(inc)]
#include "${inc}"
            [#assign includesList = includesList+" "+inc]
        [/#if]
    [/#list]
[/#if]
#n

[#if !isHALUsed??]
#if defined(USE_FULL_ASSERT)
#include "stm32_assert.h"
#endif /* USE_FULL_ASSERT */
[/#if]

[#-- MZA add the list of files (board_conf.h,..) to be include into the main.h for Tikcet 50684 --]
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
/* Exported types ------------------------------------------------------------*/

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

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

[#if HALCompliant??]
[#list voids as void]
  [#if (void.isStatic?? && !void.isStatic) && ((void.bspUsed?? && void.bspUsed && !void.isNotGenerated)||(void.functionName!="SystemClock_Config"))]
[#if !void.ipType?contains("thirdparty")&&!void.ipType?contains("middleware")&&!void.functionName?contains("VREFBUF")&&void.functionName!="Init" && !void.functionName?contains("MotorControl") && !void.functionName?contains("ETZPC") && !void.functionName?contains("TRACER_EMB") && !void.functionName?contains("GUI_INTERFACE")]
void ${void.functionName}(void);
[/#if]
  [/#if]
[/#list]
[/#if]
uint32_t extmemloader_Init(void);
void Error_Handler(void);

/* Private defines -----------------------------------------------------------*/


/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

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
#endif /* EXTMEMLOADER_INIT_H */
