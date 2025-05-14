[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_oob.h
  * @author  GPM WBL Application Team
  * @brief   Utilities for retrieving measurements required for Sigfox out-of-band frames (temperature / battery voltage).
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stdint.h>

#ifndef __WL3SFX_OOB
#define __WL3SFX_OOB

/**
 * @addtogroup WL3SFX
 * @{
 * @addtogroup WL3SFX_OOB Sigfox OOB Frame Measurements
 * @brief These functions implement support for gathering measurements for Sigfox out-of-band frames, namely battery voltage and temperature
 * measurements.
 * @{
 */

/**
 * @brief Update measured battery voltage during TX
 *
 * @retval None
 */
void wl3sfx_oob_update_tx_voltage(void);

/**
 * @brief Get voltage and temperature for Sigfox out-of-band (OOB) frames
 *
 * @param[out] *voltage_idle             Device's voltage in Idle state (mV)
 * @param[out] *voltage_tx               Device's voltage in Tx state (mV) - for the last transmission
 * @param[out] *temperature              Device's temperature in 1/10 of degrees celsius
 *
 * @retval None
 */
void wl3sfx_oob_get_voltage_temperature(uint16_t* voltage_idle, uint16_t* voltage_tx, int16_t* temperature);

uint32_t APP_GetBatteryVoltageMillivolts(void);
int16_t APP_GetTemperatureTenthCelsius(void);

/** @}@} */

#endif