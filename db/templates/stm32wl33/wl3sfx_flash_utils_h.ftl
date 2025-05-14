[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_flash_utils.h
  * @author  GPM WBL Application Team
  * @brief   Utilities to write to and read from flash memory on a per-byte basis.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stdint.h>

#ifndef __WL3SFX_FLASH_UTILS_H
#define __WL3SFX_FLASH_UTILS_H

/**
 * @addtogroup WL3SFX Low-level STM32WL3 Sigfox Implementation
 * @brief STM32WL3-specific Sigfox Implementation Layer
 * @{
 *
 * @addtogroup WL3SFX_FLASH_UTILS Flash Read/Write Utilities
 * @brief Flash memory helper functions for byte-wise read/write access to flash memory
 * @{
 */

#define FLASH_ERASE_VALUE 0xFF

#define MAX_NO_OF_PAGES 80 /* Pages for sector */

/**
 * @brief  wl3sfx_flash_read Status Enum
 *
 * These values are used to set the status of an R/W operations
 */
typedef enum { WL3SFX_FLASH_OK = 0x00, WL3SFX_FLASH_ERROR = 0x01, WL3SFX_FLASH_OUT_OF_RANGE = 0x02 } WL3SFX_FLASH_StatusTypeDef;

/**
 * @brief  Operating modes for wl3sfx_flash_write
 */
typedef enum { WL3SFX_FLASH_WRITEMODE_WRITEOVER = 0, WL3SFX_FLASH_WRITEMODE_ERASE } WL3SFX_FLASH_WriteMode;

/**
 * @brief Reads cNbBytes from FLASH memory starting at nAddress and store a pointer to that in pcBuffer.
 *
 * @param[in] nAddress starting address
 * @param[in] cNbBytes number of bytes to read
 * @param[out] pcBuffer the pointer to the data
 * @return The status of the operation
 */
WL3SFX_FLASH_StatusTypeDef wl3sfx_flash_read(uint32_t nAddress, uint16_t cNbBytes, uint8_t* pcBuffer);

/**
 * @brief  Writes cNbBytes pointed to pcBuffer to FLASH memory starting at nAddress.
 *
 * @param[in] nAddress starting address
 * @param[in] cNbBytes number of bytes to write
 * @param[in] pcBuffer the pointer to the data
 * @param[in] eraseBeforeWrite if set to 1 erase the page before write bytes
 * @return The status of the operation
 */
WL3SFX_FLASH_StatusTypeDef wl3sfx_flash_write(uint32_t nAddress, uint16_t cNbBytes, uint8_t* pcBuffer, WL3SFX_FLASH_WriteMode mode);

/**
 * @brief  Erase nPages from FLASH starting at nAddress
 *
 * @param[in] nAddress starting address
 * @param[in] nPages number of pages to erase
 * @return The status of the operation
 */
WL3SFX_FLASH_StatusTypeDef wl3sfx_flash_erase(uint32_t nAddress, uint32_t nPages);

/** @}@} */

#endif