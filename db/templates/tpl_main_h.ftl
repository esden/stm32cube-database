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
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
  ******************************************************************************
[@common.optinclude name=sourceDir+"Src/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H__
#define __MAIN_H__

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

[#compress]
[#if GRAPHICS??]
    [#if USE_OTM??]
        #include "otm8009a.h"
    [/#if]
    #include "${FamilyName?lower_case}xx_hal.h"
    [#if USE_STemWin_STACK??]
        #include "GUI.h"        
        [#if USE_ILI??]
            #include "ili9341.h"
        [/#if]
        #include "HW_Init.h"
        [#if Display_Interface_FMC??]
            #include "WM.h"
        [/#if]
        #include "GUI_App.h"
        #include "STemWin_wrapper.h"
    [/#if]
    [#if USE_Embedded_Wizard_STACK??]
        #include "xprintf.h"
        #include "tlsf.h"
        #include "ewrte.h"
        #include "ewgfx.h"
        #include "ewextgfx.h"
        #include "ewgfxdefs.h"
        #include "Core.h"
        #include "Graphics.h"
        #include "tara_wrapper.h"
        [#-- #include "ew_bsp_system.h"
        #include "ew_bsp_clock.h"
        #include "ew_bsp_event.h"
        #include "ew_bsp_display.h"
        #include "ew_bsp_touch.h"
        #include "ew_bsp_serial.h" --]
    [/#if]
    [#if USE_Touch_GFX_STACK??]
       #include "HW_Init.hpp"
    [/#if]
   
[/#if]
[/#compress]


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

[/#if]

[#list voids as void]
  [#if void.bspUsed?? && void.bspUsed]
void ${""?right_pad(2)}${void.functionName}(void);
  [/#if]
[/#list] 
/* ########################## Assert Selection ############################## */
/**
  * @brief Uncomment the line below to expanse the "assert_param" macro in the 
  *        HAL drivers code
  */
[#if !fullAssert??]/*[/#if] #define USE_FULL_ASSERT    1U [#if !fullAssert??]*/[/#if]

/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

#ifdef __cplusplus
 extern "C" {
#endif
void _Error_Handler(char *, int);

#define Error_Handler() _Error_Handler(__FILE__, __LINE__)
#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/