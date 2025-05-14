[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ST_Sigfox.h
  * @author  GPM WBL Application Team
  * @brief   STM32WL3-specific Sigfox API. Do not use any interface other than this from your application!
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stdint.h>
#include "ST_Sigfox_Types.h"

#ifndef __ST_SIGFOX_H
#define __ST_SIGFOX_H

/**
 * @addtogroup ST_SFX ST STM32WL3-Specific Sigfox API
 * @brief Sigfox-related APIs for use by Applications based on the STM32WL3 Sigfox SDK
 * @{
 */

/**
 * @brief Sigfox subsystem main initialization.
 *
 * @param[out] credentials Board configuration (ID, PAC, offsets) obtained from flash memory
 * @param[in] fem_configuration Pointer to front-end module configuration structure.
 *
 * @retval Result of operation, success or type of failure
 */
ST_SFX_StatusTypeDef ST_SFX_Init(ST_SFX_BoardCredentials* credentials, const ST_SFX_FEMConfiguration* fem_configuration);

/**
 * @brief Opens Sigfox Library and initializes hardware for given radio configuration.
 *
 * @param rc The Radio Configuration
 *
 * @retval Result of operation, success or type of failure
 */
ST_SFX_StatusTypeDef ST_SFX_Open(uint8_t rc);

/**
 * @brief Closes Sigfox Library
 *
 * @retval Result of operation, success or type of failure
 */
ST_SFX_StatusTypeDef ST_SFX_Close(void);

/**
 * @brief  Switch between public Sigfox key (<i>0x00112233445566778899AABBCCDDEEFF</i>) and board key from flash memory.
 *
 * @retval None
 */
void ST_SFX_SetPublicKey(uint8_t en);

/**
 * @brief Switch between Sigfox test credentials (test key <i>0x0123456789ABCDEF0123456789ABCDEF</i> and test ID <i>0xFEDCBA98</i>) and
 * board credentials from flash memory.
 *
 * @param en Set to 1 to enable test credential mode, 0 to return to board credentials.
 *
 * @retval None
 */
void ST_SFX_SetTestCredentials(uint8_t en);

/**
 * @brief Sets the XTAL frequency of the STM32WL3 in Hertz (default is 48MHz). Change is persistent.
 *
 * @param[in] xtal: the xtal frequency of the STM32WL3 in Hz as an integer.
 *
 * @retval 0 if no error, 1 otherwise.
 */
uint8_t ST_SFX_SetXtalFreq(uint32_t xtal);

/**
 * @brief Gets the XTAL frequency of the STM32WL3 in Hertz (default is 48MHz).
 *
 * @retval the xtal frequency of the STM32WL3 in Hz as an integer.
 */
uint32_t ST_SFX_GetXtalFreq(void);

/**
 * @brief Retrieve configured RSSI offset.
 *
 * @param[out] rssi_off Pointer to variable to store retrieved RSSI offset in, value in dB.
 *
 * @retval 0 if no error, 1 otherwise.
 */
uint8_t ST_SFX_GetRSSIOffset(int8_t* rssi_off);

/**
 * @brief Set offset for the RSSI (e.g. to compensate manufacturing tolerances). Change is persistent.
 *
 * @param[in] rssi_off an integer representing the offset in dB, default value is 0.
 *
 * @retval 0 if no error, 1 otherwise.
 */
uint8_t ST_SFX_SetRSSIOffset(int8_t rssi_off);

/**
 * @brief Retrieve power offset (in dB) used for tuning the LBT mechanism.
 *
 * @param[in] lbt_thr_off: Pointer to variable to store retrieved LBT threshold offset in, value in dB.
 *
 * @retval 0 if no error, 1 otherwise.
 */
uint8_t ST_SFX_GetLBTThresholdOffset(int8_t* lbt_thr_off);

/**
 * @brief Set a power offset (in dB) for tuning the LBT mechanism. Change is persistent.
 *
 * @param[in] lbt_thr_off: an integer representing the offset in dB.
 *                  Default value is 0.
 *
 * @retval 0 if no error, 1 otherwise.
 */
uint8_t ST_SFX_SetLBTThresholdOffset(int8_t lbt_thr_off);

/**
 * @brief Retrieve configured RSSI offset.
 *
 * @param[out] rssi_off: Pointer to variable to store retrieved RSSI offset in.
 *
 * @retval 0 if no error, 1 otherwise.
 */
uint8_t ST_SFX_GetRSSIOffset(int8_t* rssi_off);
/**
 * @brief Enable / disable payload encryption. Value is lost when device restarts.
 *
 * @param[in] enable 1 to enable payload encryption, otherwise 0.
 *
 * @retval None
 */
void ST_SFX_SetPayloadEncryption(uint8_t enable);

/**
 * @brief Reduces the output power of the transmitted signal by some value.
 *
 * @param[in] reduction Power reduction in dB. For positive values, power is reduce; for negative values, power is increased.
 *
 * @retval None
 */
void ST_SFX_ReduceOutputPower(int8_t reduction);

/**
 * @brief Enables / disables power amplifier during transmissions in front-end module (if present)
 *
 * \details By default, whether to use the front-end module's power amplifier is determined by the radio configuration and automatically
 * configured when calling ST_SFX_Open. Use this function to override the default.
 *
 * @param[in] enabled 1 to enable power amplifier during transmissions, otherwise 0
 *
 * @retval None
 */
void ST_SFX_SetPAEnabled(uint8_t enabled);

/**
 * @brief Retrieves current rollover counter from nonvolatile memory, relevant if Sigfox encryption is used
 *
 * @param[in] counter Pointer to variable to store rollover counter in
 *
 * @retval 0 if no error, 1 otherwise (e.g. if rollover counter is not available)
 */
uint8_t ST_SFX_GetRolloverCounter(uint8_t* counter);

/** @}@} */

#endif