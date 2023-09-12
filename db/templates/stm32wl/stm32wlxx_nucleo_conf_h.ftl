[#ftl]
/**
  ******************************************************************************
  * @file    stm32wlxx_nucleo_conf.h
  * @author  MCD Application Team
  * @brief   STM32WLxx_Nucleo board configuration file.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2020 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the
  * License. You may obtain a copy of the License at:
  *                        opensource.org/licenses/BSD-3-Clause
  *
  ******************************************************************************
  */

[#--
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
                ${definition.name}: ${definition.value}
        [/#list]
    [/#if]
[/#list]
--]

[#assign SUBGHZ_APPLICATION = ""]
[#assign RF_WAKEUP_TIME=""]
[#assign IS_TCXO_SUPPORTED="0"]
[#assign IS_DCDC_SUPPORTED="0"]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "SUBGHZ_APPLICATION"]
                [#assign SUBGHZ_APPLICATION = definition.value]
            [/#if]
            [#if definition.name == "RF_WAKEUP_TIME"]
                [#assign RF_WAKEUP_TIME = definition.value]
            [/#if]
            [#if definition.name == "IS_TCXO_SUPPORTED"]
                [#if definition.value == "true"]
                    [#assign IS_TCXO_SUPPORTED = "1"]
                [/#if]
            [/#if]
            [#if definition.name == "IS_DCDC_SUPPORTED"]
                [#if definition.value == "true"]
                    [#assign IS_DCDC_SUPPORTED = "1"]
                [/#if]
            [/#if]
        [/#list]
    [/#if]
[/#list]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef STM32WLXX_NUCLEO_CONF_H
#define STM32WLXX_NUCLEO_CONF_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32wlxx_hal.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/** @addtogroup BSP
  * @{
  */

/** @addtogroup STM32WLXX_NUCLEO
  * @{
  */

/** @defgroup STM32WLXX_NUCLEO_CONFIG Config
  * @{
  */

/** @defgroup STM32WLXX_NUCLEO_CONFIG_Exported_Constants Exported Constants
  * @{
  */
/**
  * COM usage define
  */
#define USE_BSP_COM_FEATURE                 0U

/**
  * COM log define
  */
#define USE_COM_LOG                         0U

/**
  * IRQ priorities
  */
#define BSP_BUTTON_SWx_IT_PRIORITY         15U

/**
  * Radio maximum wakeup time (in ms)
  */
#define RF_WAKEUP_TIME                     ${RF_WAKEUP_TIME}U

/**
  * Indicates whether or not TCXO is supported by the board
  * 0: TCXO not supported
  * 1: TCXO supported
  */
#define IS_TCXO_SUPPORTED                   ${IS_TCXO_SUPPORTED}U

/**
  * Indicates whether or not DCDC is supported by the board
  * 0: DCDC not supported
  * 1: DCDC supported
  */
#define IS_DCDC_SUPPORTED                   ${IS_DCDC_SUPPORTED}U

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* STM32WLXX_NUCLEO_CONF_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
