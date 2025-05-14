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
  * @file    b-wba5m-wpan_conf.h
  * @author  MCD Application Team
  * @brief   B-WBA5M-WPAN board configuration file.
  *          This file should be copied to the application folder and renamed
  *          to b-wba5m-wpan_conf.h
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
#ifndef B_WBA5M_WPAN_CONF_H
#define B_WBA5M_WPAN_CONF_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32wbaxx_hal.h"

/** @addtogroup BSP
  * @{
  */

/** @addtogroup B-WBA5M-WPAN
  * @{
  */

/** @defgroup B-WBA5M-WPAN_CONFIG Config
  * @{
  */

/* Button state */
#define BUTTON_RELEASED                    0U
#define BUTTON_PRESSED                     1U


/* COM define */
#define USE_COM_LOG                         [#if VCP == "true"]1U[#else]0U[/#if]
#define USE_BSP_COM_FEATURE                 [#if VCP == "true"]1U[#else]0U[/#if]

/* IRQ priorities */
#define BSP_B2_IT_PRIORITY         15U

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

#endif /* B-WBA5M-WPAN_CONF_H */
