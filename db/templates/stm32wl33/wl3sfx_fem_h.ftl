[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_fem.h
  * @author  GPM WBL Application Team
  * @brief   Helpers for configuring and using front-end modules with Sigfox on the STM32WL3.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stdint.h>
#include "ST_Sigfox_Types.h"

#ifndef __WL3SFX_FEM
#define __WL3SFX_FEM

/**
 * @addtogroup WL3SFX
 * @{
 * @addtogroup WL3SFX_FEM Front-End Module Management
 * @brief Configuration of front-end module type and amplification mode
 * @{
 */

/** Information about front-end module required for transmit pulse shaping */
typedef struct {
  /** Power ramp value for transmit power */
  uint8_t maxPower;

  /** Factor by which to reduce transmit gain for specific parts of the transmit symbols */
  uint8_t gainFactor1;

  /** Factor by which to reduce transmit gain for specific parts of the transmit symbols */
  uint8_t gainFactor2;
} WL3SFX_FEM_PulseShapingSettings;

/**
 * @brief Configure whether the front-end module's power amplifier (if applicable) should be used during transmissions or not.
 * Not persistent across device restarts.
 *
 * @param[in] enabled if 0, PA will not used for TX (FEM bypass mode is used if supported by FEM), otherwise PA will be activated
 * @retval None
 */
void wl3sfx_fem_set_pa_enabled(uint8_t enabled);

/**
 * @brief Configure front-end module (model and GPIO). Not persistent across device restarts.
 *
 * @param[in] fem_configuration Configuration for front-end module
 *
 * @retval None
 */
void wl3sfx_set_fem_configuration(const ST_SFX_FEMConfiguration* configuration);

/**
 * @brief Set up front-end module for transmission
 *
 * @retval None
 */
void wl3sfx_fem_start_tx(void);

/**
 * @brief Set up front-end module for reception
 *
 * @retval None
 */
void wl3sfx_fem_start_rx(void);

/**
 * @brief Put front-end module back into idle state
 *
 * @retval None
 */
void wl3sfx_fem_stop(void);

/**
 * @brief Retrieve information on pulse shaping based on the FEM configuration
 *
 * @param[out] settings Pointer to pulse shapping settings struct to be written
 *
 * @retval None
 */
void wl3sfx_fem_get_pulse_shaping_settings(WL3SFX_FEM_PulseShapingSettings* settings);

/** @}@} */

#endif