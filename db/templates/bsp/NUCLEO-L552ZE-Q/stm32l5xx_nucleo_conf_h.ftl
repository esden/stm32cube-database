[#ftl]
[#list SWIPdatas as SWIP]
[#assign instName = SWIP.ipName]
[#assign fileName = SWIP.fileName]
[#assign version = SWIP.version]

  [#if SWIP.defines??]
    [#list SWIP.defines as definition]
      [#if definition.name=="VCP"]
          [#assign VCP = definition.value]
      [/#if]
    [/#list]
  [/#if]
[/#list]
/**
  ******************************************************************************
  * @file    stm32l5xx_nucleo_conf.h
  * @author  MCD Application Team
  * @brief   STM32L5xx_Nucleo board configuration file.
  *          This file should be copied to the application folder and renamed
  *          to stm32l5xx_nucleo_conf.h
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2022 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef STM32L5XX_NUCLEO_CONF_H
#define STM32L5XX_NUCLEO_CONF_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32l5xx_hal.h"

/** @addtogroup BSP
  * @{
  */

/** @addtogroup STM32L5XX_NUCLEO
  * @{
  */

/** @defgroup STM32L5XX_NUCLEO_CONFIG Config
  * @{
  */

/** @defgroup STM32C0XX_NUCLEO_CONFIG_Exported_Constants Exported Constants
  * @{
  */
/* Nucleo pin and part number defines */
#define USE_STM32L5XX_NUCLEO

/* Button state */
#define BUTTON_RELEASED                    0U
#define BUTTON_PRESSED                     1U


/* COM define */
#define USE_COM_LOG                         [#if VCP == "true"]1U[#else]0U[/#if]
#define USE_BSP_COM_FEATURE                 [#if VCP == "true"]1U[#else]0U[/#if]

/* IRQ priorities */
#define BSP_BUTTON_USER_IT_PRIORITY         15U

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

#ifdef __cplusplus
}
#endif

#endif /* STM32L5XX_NUCLEO_CONF_H */
