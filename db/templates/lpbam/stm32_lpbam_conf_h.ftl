[#ftl]
/* USER CODE BEGIN Header */
/**
  **********************************************************************************************************************
  * @file    stm32_lpbam_conf.h
  * @author  MCD Application Team
  * @brief   lpbam configuration file.
  **********************************************************************************************************************
  * @attention
  *
  * Copyright (c) ${year} STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  **********************************************************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -----------------------------------------------------------------------------*/
#ifndef STM32_LPBAM_CONF_H
#define STM32_LPBAM_CONF_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes --------------------------------------------------------------------------------------------------------- */
/**
  * @brief Include device header file
  */
#include "stm32u5xx_hal.h"

/* ############################################## Module Selection ################################################## */
/**
  * @brief This is the list of modules to be used in the LPBAM utilities
  */

[#if LPBAMQUEUEMODULES??]
    [#assign allModules = ["ADC", "COMP", "DAC", "LPDMA", "LPGPIO", "I2C", "LPTIM", "OPAMP", "RTC", "SPI", "LPUART", "VREFBUF"]]
  [#list allModules as module]
	[#if LPBAMQUEUEMODULES?contains(module)]
[#compress]#define LPBAM_${module?replace("LPDMA","DMA")?replace("LPGPIO","GPIO")?replace("LPUART","UART")}_MODULE_ENABLED[/#compress]
	[#else]
/*#define LPBAM_${module}_MODULE_ENABLED   */
	[/#if]	
  [/#list]  
[/#if]
[#function isModuleUsed moduleName]
    [#list LPBAMQUEUEMODULES as usedModule]
        [#if usedModule==moduleName]
            [#return true]
        [/#if]
    [/#list]
    [#return false]
[/#function]
#define LPBAM_COMMON_MODULE_ENABLED

#ifdef __cplusplus
}
#endif

#endif /* STM32_LPBAM_CONF_H */
