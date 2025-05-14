[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_flash_utils.c
  * @author  GPM WBL Application Team
  * @brief   Utilities to write to and read from flash memory on a per-byte basis.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <string.h>

#include "stm32wl3x_hal.h"
#include "wl3sfx_flash_utils.h"
#include "wl3sfx_log.h"

static uint32_t _GetNumberOfPagesByBytes(uint32_t nBytesCount)
{
  uint32_t nRet, nTmp;

  nTmp = nBytesCount % FLASH_PAGE_SIZE;
  nRet = (!nTmp) ? (nBytesCount / FLASH_PAGE_SIZE) : ((nBytesCount / FLASH_PAGE_SIZE) + 1);

  return nRet;
}

WL3SFX_FLASH_StatusTypeDef wl3sfx_flash_read(uint32_t nAddress, uint16_t cNbBytes, uint8_t* pcBuffer)
{
  WL3SFX_FLASH_StatusTypeDef frRetStatus = WL3SFX_FLASH_OK;
  volatile uint32_t tmp;
  uint8_t i, byteCount;
  uint16_t wordIdx;

  /* Address must be word-aligned */
  if ((nAddress % 4) != 0)
    frRetStatus = WL3SFX_FLASH_ERROR;

  if (pcBuffer == NULL)
    frRetStatus = WL3SFX_FLASH_ERROR;

  if (frRetStatus == WL3SFX_FLASH_OK) {
    for (i = 0; i < cNbBytes; i++) {
      byteCount = i % 4;
      wordIdx = (i / 4) * 4;

      if (IS_FLASH_MAIN_MEM_ADDRESS(nAddress + wordIdx)) {
        tmp = *((__IO uint32_t*)(nAddress + wordIdx));
        pcBuffer[i] = (tmp & (0xFF000000 >> (byteCount * 8))) >> (24 - (byteCount * 8));
      } else {
        frRetStatus = WL3SFX_FLASH_ERROR;
        break;
      }
    }
  }

  return frRetStatus;
}

WL3SFX_FLASH_StatusTypeDef wl3sfx_flash_write(uint32_t nAddress, uint16_t cNbBytes, uint8_t* pcBuffer, WL3SFX_FLASH_WriteMode mode)
{
  wl3sfx_log(WL3SFX_SEV_INFO, "writing %d bytes to 0x%08x", cNbBytes, nAddress);
  wl3sfx_log_bytearray(WL3SFX_SEV_INFO, "content: ", pcBuffer, cNbBytes);

  uint8_t i, byteCount;
  uint16_t wordIdx;
  uint32_t temp_word;

  WL3SFX_FLASH_StatusTypeDef frRetStatus = WL3SFX_FLASH_OK;

  if (_GetNumberOfPagesByBytes(cNbBytes) > MAX_NO_OF_PAGES)
    frRetStatus = WL3SFX_FLASH_OUT_OF_RANGE;

  if (pcBuffer == NULL)
    frRetStatus = WL3SFX_FLASH_ERROR;

  /* Address must be word aligned (4 byte for each row) */
  if ((nAddress % 4) != 0)
    frRetStatus = WL3SFX_FLASH_ERROR;

  if (mode == WL3SFX_FLASH_WRITEMODE_ERASE)
    frRetStatus = wl3sfx_flash_erase(nAddress, _GetNumberOfPagesByBytes(cNbBytes));

  if (frRetStatus == WL3SFX_FLASH_OK) {
    temp_word = 0;

    for (i = 0; i < cNbBytes; i++) {
      byteCount = i % 4;
      wordIdx = (i / 4) * 4;

      temp_word |= ((uint32_t)pcBuffer[i]) << (24 - (8 * byteCount));

      // Write after every complete word (4 bytes) or if these are the last 1-3 bytes in the buffer
      if (byteCount == 3 || (i == cNbBytes - 1)) {
        if (HAL_FLASH_Program(FLASH_TYPEPROGRAM_WORD, nAddress + wordIdx, temp_word) == HAL_OK) {
          temp_word = 0;
        } else {
          frRetStatus = WL3SFX_FLASH_ERROR;
          break;
        }
      }
    }
  }

  return frRetStatus;
}

WL3SFX_FLASH_StatusTypeDef wl3sfx_flash_erase(uint32_t nAddress, uint32_t nPages)
{
  wl3sfx_log(WL3SFX_SEV_INFO, "erasing 0x%08x - 0x%08x", nAddress, nAddress + nPages * FLASH_PAGE_SIZE);

  /* Address must be word aligned */
  uint32_t pageerror = 0;
  if ((nAddress % 4) == 0) {
    FLASH_EraseInitTypeDef EraseInitStruct;
    EraseInitStruct.TypeErase = FLASH_TYPEERASE_PAGES;
    EraseInitStruct.Page = _GetNumberOfPagesByBytes(nAddress - _MEMORY_FLASH_BEGIN_);
    EraseInitStruct.NbPages = nPages;

    HAL_FLASHEx_Erase(&EraseInitStruct, &pageerror);
  }

  return pageerror == 0xFFFFFFFFU ? WL3SFX_FLASH_OK : WL3SFX_FLASH_ERROR;
}