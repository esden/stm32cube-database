[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ST_Sigfox_Types.h
  * @author  GPM WBL Application Team
  * @brief   Type definitions that are specific to the STM32WL3 Sigfox Development Kit.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stdint.h>
#include "main.h"

#ifndef __ST_SIGFOX_TYPES_H
#define __ST_SIGFOX_TYPES_H

/**
 * @addtogroup ST_SFX
 * @{
 */

/** Return status types for ST_SFX APIs */
typedef enum {
  /** Success */
  ST_SFX_OK = 0,

  /** Failed to open Sigfox API */
  ST_SFX_ERR_OPEN = 1,

  /** Failed to retrieve board credentials from flash memory */
  ST_SFX_ERR_CREDENTIALS = 2,

  /** Failed to read or set board-specific XTAL frequency offset */
  ST_SFX_ERR_FREQ_OFFSET = 3,

  /** Failed to close Sigfox library */
  ST_SFX_ERR_CLOSE = 4,

  /** Radio configuration (RC) is unknown */
  ST_SFX_ERR_RC_UNKNOWN = 99
} ST_SFX_StatusTypeDef;

/** Board-specific credentials configuration */
typedef struct {
  /** Sigfox ID (4 bytes) */
  uint32_t id;

  /** Sigfox Porting Authorization Code (PAC, 8 bytes) */
  uint8_t pac[8];

  /** Sigfox Radio Configuration (RC) */
  uint8_t rc;
} ST_SFX_BoardCredentials;

/** Supported front-end-module models */
typedef enum {
  /** no front-end module present */
  ST_SFX_FEM_NONE = 0,

  /** Custom FEM */
  ST_SFX_FEM_CUSTOM
} ST_SFX_FEMModel;

/** GPIO configuration for FEM pin */
typedef struct {
  /** GPIO Port of FEM pin, e.g. GPIOA or GPIOB */
  GPIO_TypeDef* port;

  /** Pin mask of GPIO pin within specified port, e.g. LL_GPIO_PIN_0 */
  uint32_t pin;

  /** Peripheral clock domain for RCC corresponding to port, e.g. LL_AHB1_GRP1_PERIPH_GPIOA or LL_AHB1_GRP1_PERIPH_GPIOB */
  uint32_t periph;
} ST_SFX_FEMGPIOConfiguration;

/** Front-end module model configuration structure */
typedef struct {
  /** Model of supported front-end module */
  ST_SFX_FEMModel model;

  /** Structure defining configuration of pin that the front-end module's CSD pin is connected to */
  ST_SFX_FEMGPIOConfiguration csd;

  /** Structure defining configuration of pin that the front-end module's CPS pin is connected to */
  ST_SFX_FEMGPIOConfiguration cps;

  /** Structure defining configuration of pin that the front-end module's CTX pin is connected to */
  ST_SFX_FEMGPIOConfiguration ctx;
} ST_SFX_FEMConfiguration;

/** @}@} */

#endif
