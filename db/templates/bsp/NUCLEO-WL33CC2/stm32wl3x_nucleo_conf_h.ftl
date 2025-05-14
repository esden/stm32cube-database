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
  * @file    stm32wl3xx_nucleo_conf.h
  * @author  MCD Application Team
  * @brief   STM32WL3xx_Nucleo board configuration file.
  *          This file should be copied to the application folder and renamed
  *          to stm32wl3xx_nucleo_conf.h
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
#ifndef STM32WL3XX_NUCLEO_CONF_H
#define STM32WL3XX_NUCLEO_CONF_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32wl3x_hal.h"

/** @addtogroup BSP
  * @{
  */

/** @addtogroup STM32WL3XX_NUCLEO
  * @{
  */

/** @defgroup STM32WL3XX_NUCLEO_CONFIG Config
  * @{
  */

/** @defgroup STM32C0XX_NUCLEO_CONFIG_Exported_Constants Exported Constants
  * @{
  */
/* Nucleo pin and part number defines */
#define USE_STM32WL3XX_NUCLEO

/* COM define */
#define USE_COM_LOG                         [#if VCP == "true"]1U[#else]0U[/#if]
#define USE_BSP_COM_FEATURE                 [#if VCP == "true"]1U[#else]0U[/#if]

/* IRQ priorities */
#define BSP_B1_IT_PRIORITY         15U
#define BSP_B2_IT_PRIORITY         15U
#define BSP_B3_IT_PRIORITY         15U

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

#endif /* STM32WL3XX_NUCLEO_CONF_H */
