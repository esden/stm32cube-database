[#ftl]
[#list configs as dt]
[#assign data = dt]
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
/**
  ******************************************************************************
  * File Name          : main.h
  * Description        : This file contains the common defines of the application
  ******************************************************************************
[@common.optinclude name="Src/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H
  /* Includes ------------------------------------------------------------------*/
[#compress]
[#--include "mxconstants.h"--]
[#assign includesList = ""]
[#if LLincludes??] [#-- Include LL headers --]
    [#list LLincludes as inc]
        [#if !includesList?contains(inc)]
#include "${inc}"
            [#assign includesList = includesList+" "+inc]
        [/#if]
    [/#list]
[/#if]
#n
[#--Include common LL driver --]
[#if isLLUsed??] [#-- Include LL headers --]
    [#-- Include common LL driver that should be always included--]
    [#-- include "${FamilyName?lower_case}xx_ll_bus.h" --]
    [#if !includesList?contains(FamilyName?lower_case+"xx_ll_bus.h")]
    #include "${FamilyName?lower_case}xx_ll_bus.h"
        [#assign includesList = includesList+" "+FamilyName?lower_case+"xx_ll_bus.h"]
    [/#if]
    [#-- include "${FamilyName?lower_case}xx_ll_cortex.h" --]
    [#if !includesList?contains(FamilyName?lower_case+"xx_ll_cortex.h")]
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
[/#if]
[/#compress]
#n

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */
#n
/* Private define ------------------------------------------------------------*/
[#if UserDefines??][#-- user defines declaration --]
[#assign defines = UserDefines.get(0)]
[#list defines.entrySet() as define]
#define ${define.key} ${define.value}
[/#list]
[/#if]
#n
[#if LabelDefines??][#-- user defines declaration --]
[#assign defines = LabelDefines.get(0)]
[#list defines.entrySet() as define]
#define ${define.key} ${define.value}
[/#list]
[/#if]
[#if isHALUsed??]
[#else]
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

/* ########################## Assert Selection ############################## */
/**
  * @brief Uncomment the line below to expanse the "assert_param" macro in the 
  *        HAL drivers code
  */
[#if !fullAssert??]/*[/#if] #define USE_FULL_ASSERT    1 [#if !fullAssert??]*/[/#if]
[/#if]

/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */
#n
/**
#t* @}
#t*/ 
#n
/**
#t* @}
*/ 
#n
#endif /* __MAIN_H */
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/