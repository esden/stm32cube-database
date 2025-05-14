[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_nvm_records.h
  * @author  GPM WBL Application Team
  * @brief   Stores Sigfox NVM records in blocks (records) to economize flash write cycles.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stdint.h>

#ifndef __WL3SFX_NVM_RECORDS_H
#define __WL3SFX_NVM_RECORDS_H

/**
 * @addtogroup WL3SFX
 * @{
 *
 * @addtogroup WL3SFX_NVM_RECORDS Protocol State Record Storage
 * @brief Provides nonvolatile flash memory storage for Sigfox library. Ensures that write cycles are distributed uniformally across a
 * complete flash page to reduce erasure cycles.
 * @{
 */

/// \cond DO_NOT_DOCUMENT
#define WL3SFX_RECORD_INVALID 0xFFFFFFFCFFFFFF0E
#define WL3SFX_RECORD_VALID 0xFFFFFF0CFFFFFF0E
#define WL3SFX_RECORD_EMPTY 0xFFFFFFFFFFFFFFFF

#define WL3SFX_RECORD_INVALID_1 0xFFFFFFFF
#define WL3SFX_RECORD_INVALID_2 0xFFFFFF0E

#define WL3SFX_RECORD_VALID_1 0xFFFFFF0E
#define WL3SFX_RECORD_VALID_2 0xFFFFFF0C

#define RECORD_HEADER_SIZE 8 /* To preserve data integrity, 2 words are reserved for record validation */
#define RECORD_BODY_SIZE 8 /* NVM data size */
/// \endcond

/**
 * @brief Return values for NVM Sigfox Records Read/Write functions
 */
typedef enum {
  WL3SFX_Records_RW_OK = 0,
  WL3SFX_Records_WRITE_ERROR,
  WL3SFX_Records_READ_ERROR,
  WL3SFX_Records_WRITE_RECORD_ERROR,
  WL3SFX_Records_READ_RECORD_ERROR,
  WL3SFX_Records_WRITE_HEADER_ERROR,
  WL3SFX_Records_NO_RECORDS
} WL3SFX_Records_StatusTypeDef;

/*-------------------------------------FUNCTION PROTOTYPES------------------------------------*/

/**
 * @brief  Initialize NVM API
 *
 * @param  config configuration structure.
 */
void wl3sfx_nvm_records_init(void);

/**
 * @brief Reads last record stored at userSpaceAddress
 *
 * @param  nvmRecord Returned record
 * @param  recordSize Size of record
 * @retval WL3SFX_Records_StatusTypeDef
 */
WL3SFX_Records_StatusTypeDef wl3sfx_nvm_records_read(uint8_t* nvmRecord, uint32_t recordSize);

/**
 * @brief Writes record in the last available slot in the userSpace page. If no space left, the page will be erased
 * before write
 *
 * @param  nvmRecord Record to write
 * @param  recordSize Size of record
 * @retval WL3SFX_Records_StatusTypeDef
 */
WL3SFX_Records_StatusTypeDef wl3sfx_nvm_records_write(uint8_t* nvmRecord, uint32_t recordSize);

/** @}@} */

#endif