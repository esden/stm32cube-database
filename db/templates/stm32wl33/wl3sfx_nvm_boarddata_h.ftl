[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_nvm_boarddata.h
  * @author  GPM WBL Application Team
  * @brief   Simple persistent key-value store for configuration parameters of Sigfox on the STM32WL3.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stdint.h>

#ifndef __WL3SFX_NVM_BOARDDATA_H
#define __WL3SFX_NVM_BOARDDATA_H

/**
 * @addtogroup WL3SFX
 * @{
 * @addtogroup WL3SFX_NVM_BOARDDATA Boarddata Key-Value Store
 * @brief Simple key-value store for calibration offsets and radio configuration
 * @{
 */

/**
 * @brief Different boarddata properties. Enum numbers encode location in nvm_boarddata record.
 */
typedef enum {
  WL3SFX_BOARDDATA_XTAL_OFFSET = 48,
  WL3SFX_BOARDDATA_RSSI_OFFSET = 52,
  WL3SFX_BOARDDATA_LBT_THR_OFFSET = 56
} WL3SFX_BoardData_Property;

/**
 * @brief Return values for NVM Sigfox Board Data Read/Write functions
 */
typedef enum {
  WL3SFX_BOARDDATA_RW_OK = 0,
  WL3SFX_BOARDDATA_WRITE_ERROR,
  WL3SFX_BOARDDATA_READ_ERROR,
  WL3SFX_BOARDDATA_ILLEGAL
} WL3SFX_BOARDDATA_StatusTypeDef;

/**
 * @brief Update boarddata configuration value in flash memory (RC + frequency, RSSI and LBT offsets)
 *
 * @param[in] property Property to set
 * @param[in] value Value to set
 *
 * @retval Success or error code
 */
WL3SFX_BOARDDATA_StatusTypeDef wl3sfx_nvm_boarddata_set(WL3SFX_BoardData_Property property, int32_t value);

/**
 * @brief Read boarddata property from flash memory
 *
 * @param[in] property Property to get
 * @param[out] value Pointer to variable that retrieved value should be written to
 *
 * @retval Success or error code
 */
WL3SFX_BOARDDATA_StatusTypeDef wl3sfx_nvm_boarddata_get(WL3SFX_BoardData_Property property, int32_t* value);

/** @}@} */

#endif