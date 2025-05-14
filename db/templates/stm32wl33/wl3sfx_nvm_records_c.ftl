[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_nvm_records.c
  * @author  GPM WBL Application Team
  * @brief   Stores Sigfox NVM records in blocks (records) to economize flash write cycles.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include "stm32wl3x_hal.h"

#include "wl3sfx_flash_utils.h"
#include "wl3sfx_nvm_records.h"

#include "wl3sfx_nvm.h"
#include "wl3sfx_log.h"

/*  ----------------------------- Private helper functions ----------------------------- */
#define _write(nAddress, cNbBytes, pcBuffer, writeMode)                                                                                    \
  ((wl3sfx_flash_write(nAddress, cNbBytes, pcBuffer, writeMode) == WL3SFX_FLASH_OK) ? WL3SFX_Records_RW_OK : WL3SFX_Records_WRITE_ERROR);
#define _read(nAddress, cNbBytes, pcBuffer)                                                                                                \
  ((wl3sfx_flash_read(nAddress, cNbBytes, pcBuffer) == WL3SFX_FLASH_OK) ? WL3SFX_Records_RW_OK : WL3SFX_Records_READ_ERROR)

static WL3SFX_Records_StatusTypeDef _setRecordValid(uint32_t addr, uint64_t state)
{
  WL3SFX_Records_StatusTypeDef tRet = WL3SFX_Records_RW_OK;
  uint64_t wrState;

  if (state == WL3SFX_RECORD_INVALID) {
    wrState = WL3SFX_RECORD_INVALID_2;
    tRet = _write(addr, RECORD_HEADER_SIZE / 2, (uint8_t*)&wrState, WL3SFX_FLASH_WRITEMODE_WRITEOVER);
  } else if (state == WL3SFX_RECORD_VALID) {
    wrState = WL3SFX_RECORD_VALID_2;
    tRet = _write(addr + RECORD_HEADER_SIZE / 2, RECORD_HEADER_SIZE / 2, (uint8_t*)&wrState, WL3SFX_FLASH_WRITEMODE_WRITEOVER);
  } else
    tRet = WL3SFX_Records_WRITE_HEADER_ERROR;

  return tRet;
}

static WL3SFX_Records_StatusTypeDef _writeAndValidateRecord(uint32_t addr, uint8_t* nvmRecord, uint32_t recordSize)
{
  WL3SFX_Records_StatusTypeDef tRet = WL3SFX_Records_RW_OK;

  tRet = _setRecordValid(addr, WL3SFX_RECORD_INVALID);

  if (tRet == WL3SFX_Records_RW_OK)
    tRet = _write(addr + RECORD_HEADER_SIZE, recordSize, (uint8_t*)nvmRecord, WL3SFX_FLASH_WRITEMODE_WRITEOVER);

  if (tRet == WL3SFX_Records_RW_OK)
    tRet = _setRecordValid(addr, WL3SFX_RECORD_VALID);

  return tRet;
}

/*  ----------------------------- Public NVM Records Interface ----------------------------- */
void wl3sfx_nvm_records_init(void)
{
  // First boot: Erase flash and add new empty record
  uint8_t cleanBuf[RECORD_BODY_SIZE];

  if (wl3sfx_nvm_records_read(cleanBuf, RECORD_BODY_SIZE) == WL3SFX_Records_NO_RECORDS) {
    memset(cleanBuf, FLASH_ERASE_VALUE, RECORD_BODY_SIZE);
    wl3sfx_flash_erase((uint32_t)wl3sfx_nvm_records, 1);
    wl3sfx_nvm_records_write(&cleanBuf[0], RECORD_BODY_SIZE);
  }
}

WL3SFX_Records_StatusTypeDef wl3sfx_nvm_records_read(uint8_t* nvmRecord, uint32_t recordSize)
{
  WL3SFX_Records_StatusTypeDef tRet = WL3SFX_Records_RW_OK;
  uint64_t currentRecordState = WL3SFX_RECORD_INVALID;
  uint32_t recordPointer = (uint32_t)wl3sfx_nvm_records;

  /* find the last (i.e. latest) record; it has to be followed by either an empty block or the end of the flash page */
  while (currentRecordState != WL3SFX_RECORD_EMPTY) {
    if (_read(recordPointer, RECORD_HEADER_SIZE, (uint8_t*)&currentRecordState) == WL3SFX_Records_RW_OK) {
      if (recordPointer + (RECORD_BODY_SIZE + RECORD_HEADER_SIZE) == (uint32_t)(wl3sfx_nvm_records + (sizeof(wl3sfx_nvm_records))))
        break;
      else
        recordPointer += RECORD_BODY_SIZE + RECORD_HEADER_SIZE;
    } else {
      tRet = WL3SFX_Records_READ_RECORD_ERROR;
      break;
    }
  }

  /* read latest record (if applicable) */
  if (tRet == WL3SFX_Records_RW_OK) {
    while (currentRecordState != WL3SFX_RECORD_VALID && tRet == WL3SFX_Records_RW_OK) {
      recordPointer -= (RECORD_BODY_SIZE + RECORD_HEADER_SIZE);

      if (recordPointer < (uint32_t)wl3sfx_nvm_records) {
        tRet = WL3SFX_Records_NO_RECORDS;
        break;
      }

      tRet = _read(recordPointer, RECORD_HEADER_SIZE, (uint8_t*)&currentRecordState);
    }

    if (tRet == WL3SFX_Records_RW_OK)
      tRet = _read(recordPointer + RECORD_HEADER_SIZE, recordSize, (uint8_t*)nvmRecord);
    else if (tRet != WL3SFX_Records_NO_RECORDS)
      tRet = WL3SFX_Records_READ_RECORD_ERROR;
  }

  /* if there was no record to read (e.g. blank flash page), check if backup page contains a backup record */
  if (tRet == WL3SFX_Records_NO_RECORDS) {
    tRet = _read((uint32_t)wl3sfx_nvm_records_backup, RECORD_HEADER_SIZE, (uint8_t*)&currentRecordState);
    if (tRet == WL3SFX_Records_RW_OK && currentRecordState == WL3SFX_RECORD_VALID) {
      /* a backup record exists! use it! */
      tRet = _read((uint32_t)wl3sfx_nvm_records_backup + RECORD_HEADER_SIZE, recordSize, (uint8_t*)nvmRecord);
    } else {
      tRet = WL3SFX_Records_NO_RECORDS;
    }
  }

  return tRet;
}

WL3SFX_Records_StatusTypeDef wl3sfx_nvm_records_write(uint8_t* nvmRecord, uint32_t recordSize)
{
  WL3SFX_Records_StatusTypeDef tRet = WL3SFX_Records_RW_OK;
  uint64_t currentRecordState;
  currentRecordState = WL3SFX_RECORD_INVALID;

  uint32_t recordPointer = (uint32_t)wl3sfx_nvm_records;

  while (currentRecordState != WL3SFX_RECORD_EMPTY) {
    if (recordPointer != (uint32_t)(wl3sfx_nvm_records + (sizeof(wl3sfx_nvm_records)))) {
      if (_read(recordPointer, RECORD_HEADER_SIZE, (uint8_t*)&currentRecordState) == WL3SFX_Records_RW_OK) {
        if (currentRecordState == WL3SFX_RECORD_EMPTY) {
          tRet = _writeAndValidateRecord(recordPointer, nvmRecord, recordSize);
          break;
        } else
          recordPointer += (RECORD_BODY_SIZE + RECORD_HEADER_SIZE);
      } else {
        tRet = WL3SFX_Records_READ_RECORD_ERROR;
        break;
      }
    } else {
      /*
       * Flash page containing records is now full; we need to erase it to write the new record.
       * Under rare unforeseen circumstances, a reset could in theory occur between the time when
       * the flash page is erased and the new record is written.
       * Therefore: First write new record to backup page!
       */
      wl3sfx_flash_erase((uint32_t)wl3sfx_nvm_records_backup, 1);
      tRet = _writeAndValidateRecord((uint32_t)wl3sfx_nvm_records_backup, nvmRecord, recordSize);
      if (tRet != WL3SFX_Records_RW_OK) {
        wl3sfx_log(WL3SFX_SEV_ERROR, "failed to write backup record");
      }

      /* erase record flash page and add new record at page start */
      wl3sfx_flash_erase((uint32_t)wl3sfx_nvm_records, 1);
      tRet = _writeAndValidateRecord((uint32_t)wl3sfx_nvm_records, nvmRecord, recordSize);

      break;
    }
  }

  return tRet;
}