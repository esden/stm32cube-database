[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_nvm.c
  * @author  GPM WBL Application Team
  * @brief   Nonvolatile memory (NVM) contents.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include "wl3sfx_nvm.h"

NO_INIT_SECTION(const uint8_t wl3sfx_nvm_boarddata[FLASH_PAGE_SIZE], ".noinit.sigfox_boarddata");
NO_INIT_SECTION(const uint8_t wl3sfx_nvm_records[FLASH_PAGE_SIZE], ".noinit.sigfox_nvm_records");
NO_INIT_SECTION(const uint8_t wl3sfx_nvm_records_backup[FLASH_PAGE_SIZE], ".noinit.sigfox_nvm_records_backup");