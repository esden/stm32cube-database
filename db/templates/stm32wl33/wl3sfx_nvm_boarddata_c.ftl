[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_nvm_boarddata.c
  * @author  GPM WBL Application Team
  * @brief   Simple persistent key-value store for configuration parameters of Sigfox on the STM32WL3.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <string.h>

#include "stm32wl3x_hal.h"

#include "wl3sfx_nvm_boarddata.h"
#include "wl3sfx_flash_utils.h"
#include "wl3sfx_nvm.h"
#include "wl3sfx_log.h"

/**
 * @brief Total size of boarddata record in flash memory, including static configuration (e.g. credentials).
 */
#define WL3SFX_BOARDDATA_SIZE 64

WL3SFX_BOARDDATA_StatusTypeDef wl3sfx_nvm_boarddata_set(WL3SFX_BoardData_Property property, int32_t value)
{
  wl3sfx_log(WL3SFX_SEV_INFO, "wl3sfx_nvm_boarddata_set [%d] = %d", property, value);

  uint8_t flash_contents[WL3SFX_BOARDDATA_SIZE];
  WL3SFX_BOARDDATA_StatusTypeDef ret = WL3SFX_BOARDDATA_RW_OK;

  /* have to back up flash block into flash_contents since flash page has to be erased; modify value in flash_contents */
  if (wl3sfx_flash_read((uint32_t)wl3sfx_nvm_boarddata, WL3SFX_BOARDDATA_SIZE, &flash_contents[0]) == WL3SFX_FLASH_OK)
    memcpy(&flash_contents[property], &value, sizeof(int32_t));
  else
    ret = WL3SFX_BOARDDATA_READ_ERROR;

  /* if reading flash_contents was successful, write back to flash memory */
  if (ret == WL3SFX_BOARDDATA_RW_OK)
    if (wl3sfx_flash_write((uint32_t)wl3sfx_nvm_boarddata, WL3SFX_BOARDDATA_SIZE, &flash_contents[0], WL3SFX_FLASH_WRITEMODE_ERASE)
      != WL3SFX_FLASH_OK)
      ret = WL3SFX_BOARDDATA_WRITE_ERROR;

  return ret;
}

WL3SFX_BOARDDATA_StatusTypeDef wl3sfx_nvm_boarddata_get(WL3SFX_BoardData_Property property, int32_t* value)
{
  return wl3sfx_flash_read((uint32_t)&wl3sfx_nvm_boarddata[property], sizeof(*value), (uint8_t*)value) == WL3SFX_FLASH_OK
    ? WL3SFX_BOARDDATA_RW_OK
    : WL3SFX_BOARDDATA_READ_ERROR;
}