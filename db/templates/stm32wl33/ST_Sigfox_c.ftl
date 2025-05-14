[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ST_Sigfox.c
  * @author  GPM WBL Application Team
  * @brief   Application of the Sigfox Middleware
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "wl3sfx_nvm_boarddata.h"
#include "wl3sfx_nvm_records.h"
#include "wl3sfx_credentials.h"
#include "wl3sfx_txsymbols.h"
#include "wl3sfx_timer.h"
#include "wl3sfx_fem.h"
#include "wl3sfx_log.h"
#include "main.h"
#include "stm32wl3x_ll_utils.h"
#include "ST_Sigfox.h"
#include "sigfox_types.h"
#include "sigfox_api.h"

ST_SFX_StatusTypeDef ST_SFX_Init(ST_SFX_BoardCredentials* credentials, const ST_SFX_FEMConfiguration* fem_configuration)
{
  /* Log Sigfox API versions */
  sfx_u8* version;
  sfx_u8 version_size;
  SIGFOX_API_get_version(&version, &version_size, VERSION_SIGFOX);
  wl3sfx_log(WL3SFX_SEV_INFO, "libsfx version : %.*s", version_size, version);
  SIGFOX_API_get_version(&version, &version_size, VERSION_RF);
  wl3sfx_log(WL3SFX_SEV_INFO, "rf_api version : %.*s", version_size, version);
  SIGFOX_API_get_version(&version, &version_size, VERSION_MCU);
  wl3sfx_log(WL3SFX_SEV_INFO, "mcu_api version: %.*s", version_size, version);

  ST_SFX_StatusTypeDef ret_err = ST_SFX_OK;

  /* Initialize timers */
  wl3sfx_timer_init();

  /* Configure the NVM_API */
  wl3sfx_nvm_records_init();

  /* Configure front-end module (FEM) support */
  wl3sfx_set_fem_configuration(fem_configuration);

  /* Change XTAL offset value if configured in boarddata flash */
  int32_t xtal_off = 0;
  if (wl3sfx_nvm_boarddata_get(WL3SFX_BOARDDATA_XTAL_OFFSET, &xtal_off) != WL3SFX_BOARDDATA_RW_OK) {
    /* An error occurred reading xtal freq offset */
    ret_err = ST_SFX_ERR_FREQ_OFFSET;
  }

  if (!ret_err) {
    wl3sfx_log(WL3SFX_SEV_INFO, "XTAL offset: %d", xtal_off);
    LL_SetXTALFreq(HSE_VALUE + xtal_off);
  }

  /* Retrieve Sigfox info from FLASH */
  if (wl3sfx_credentials_retrieve(credentials) != 0)
    ret_err = ST_SFX_ERR_CREDENTIALS;

  return ret_err;
}

ST_SFX_StatusTypeDef ST_SFX_Open(uint8_t rc)
{
  ST_SFX_StatusTypeDef open_err = ST_SFX_OK;

  switch (rc) {
  case 1: {
    /* Turn PA off in RC1/3/5/6/7 */
    wl3sfx_fem_set_pa_enabled(0);

    /* RC1 - open the Sigfox library */
    if (SIGFOX_API_open(&(sfx_rc_t)RC1) != 0)
      open_err = ST_SFX_ERR_OPEN;

    break;
  }

  case 2: {
    /* Turn PA off in RC2 and RC4 */
    wl3sfx_fem_set_pa_enabled(1);

    /* RC2 - open the Sigfox library */
    if (SIGFOX_API_open(&(sfx_rc_t)RC2) != 0)
      open_err = ST_SFX_ERR_OPEN;

    /* In FCC we can choose the macro channel to use by a 86 bits bitmask
    In this case we use the first 9 macro channels */
    sfx_u32 config_words[3] = RC2_SM_CONFIG;

    /* Set the standard configuration with default channel to 1 */
    if (SIGFOX_API_set_std_config(config_words, 0) != 0)
      open_err = ST_SFX_ERR_OPEN;

    break;
  }

  case 3: {
    /* Turn PA off in RC1/3/5/6/7 */
    wl3sfx_fem_set_pa_enabled(0);

    /* RC3 - open the Sigfox library */
    uint8_t ret = SIGFOX_API_open(&(sfx_rc_t)RC3C);
    if (ret != 0)
      open_err = ST_SFX_ERR_OPEN;

    /* In FCC we can choose the macro channel to use by a 86 bits bitmask
    In this case we use 9 consecutive macro channels starting from 63 (920.8MHz) */
    sfx_u32 config_words[3] = RC3C_CONFIG;

    /* Set the standard configuration with default channel to 63 */
    if (SIGFOX_API_set_std_config(config_words, 0) != 0)
      open_err = ST_SFX_ERR_OPEN;

    break;
  }

  case 4: {
    /* Turn PA off in RC2 and RC4 */
    wl3sfx_fem_set_pa_enabled(1);

    /* RC4 - open the Sigfox library */
    uint8_t ret = SIGFOX_API_open(&(sfx_rc_t)RC4);
    if (ret != 0)
      open_err = ST_SFX_ERR_OPEN;

    /* In FCC we can choose the macro channel to use by a 86 bits bitmask
    In this case we use 9 consecutive macro channels starting from 63 (920.8MHz) */
    sfx_u32 config_words[3] = RC4_SM_CONFIG;

    /* Set the standard configuration with default channel to 63 */
    if (SIGFOX_API_set_std_config(config_words, 1) != 0)
      open_err = ST_SFX_ERR_OPEN;

    break;
  }

  case 5: {
    /* Turn PA off in RC1/3/5/6/7 */
    wl3sfx_fem_set_pa_enabled(0);

    /* RC5 - open the Sigfox library */
    uint8_t ret = SIGFOX_API_open(&(sfx_rc_t)RC5);
    if (ret != 0)
      open_err = ST_SFX_ERR_OPEN;

    /* In FCC we can choose the macro channel to use by a 86 bits bitmask
    In this case we use 9 consecutive macro channels starting from 63 (920.8MHz) */
    sfx_u32 config_words[3] = RC5_CONFIG;

    /* Set the standard configuration with default channel to 63 */
    if (SIGFOX_API_set_std_config(config_words, 0) != 0)
      open_err = ST_SFX_ERR_OPEN;

    break;
  }

  case 6: {
    /* Turn PA off in RC1/3/5/6/7 */
    wl3sfx_fem_set_pa_enabled(0);

    /* RC6 - open the Sigfox library */
    if (SIGFOX_API_open(&(sfx_rc_t)RC6) != 0)
      open_err = ST_SFX_ERR_OPEN;

    break;
  }

  case 7: {
    /* Turn PA off in RC1/3/5/6/7 */
    wl3sfx_fem_set_pa_enabled(0);

    /* RC7 - open the Sigfox library */
    if (SIGFOX_API_open(&(sfx_rc_t)RC7) != 0)
      open_err = ST_SFX_ERR_OPEN;

    break;
  }

  default: {
    open_err = ST_SFX_ERR_RC_UNKNOWN;
    break;
  }
  }

  return open_err;
}

ST_SFX_StatusTypeDef ST_SFX_Close(void)
{
  return SIGFOX_API_close() == SFX_ERR_NONE ? ST_SFX_OK : ST_SFX_ERR_CLOSE;
}

void ST_SFX_SetPublicKey(uint8_t en)
{
  wl3sfx_credentials_set_key(en ? WL3SFX_CREDENTIALS_ENCKEY_PUBLIC : WL3SFX_CREDENTIALS_ENCKEY_BOARD);
}

void ST_SFX_SetTestCredentials(uint8_t en)
{
  wl3sfx_credentials_set_key(en ? WL3SFX_CREDENTIALS_ENCKEY_TEST : WL3SFX_CREDENTIALS_ENCKEY_BOARD);
  wl3sfx_credentials_set_test_id(en);
}

uint8_t ST_SFX_SetXtalFreq(uint32_t xtal)
{
  uint8_t ret = 1;

  /* update xtal offset configuration in flash and apply change immediately */
  if (wl3sfx_nvm_boarddata_set(WL3SFX_BOARDDATA_XTAL_OFFSET, ((int32_t)xtal) - HSE_VALUE) == WL3SFX_BOARDDATA_RW_OK) {
    LL_SetXTALFreq(xtal);
    ret = 0;
  }

  return ret;
}

uint32_t ST_SFX_GetXtalFreq(void)
{
  return LL_GetXTALFreq();
}

uint8_t ST_SFX_GetRSSIOffset(int8_t* rssi_off)
{
  int32_t rssi_off_32;
  uint8_t ret = wl3sfx_nvm_boarddata_get(WL3SFX_BOARDDATA_RSSI_OFFSET, &rssi_off_32);
  *rssi_off = (int8_t)rssi_off_32;

  return (ret == WL3SFX_BOARDDATA_RW_OK) ? 0 : 1;
}

uint8_t ST_SFX_SetRSSIOffset(int8_t rssi_off)
{
  return wl3sfx_nvm_boarddata_set(WL3SFX_BOARDDATA_RSSI_OFFSET, rssi_off) == WL3SFX_BOARDDATA_RW_OK ? 0 : 1;
}

uint8_t ST_SFX_GetLBTThresholdOffset(int8_t* lbt_thr_off)
{
  int32_t lbt_thr_off_32;
  uint8_t ret = wl3sfx_nvm_boarddata_get(WL3SFX_BOARDDATA_LBT_THR_OFFSET, &lbt_thr_off_32);
  *lbt_thr_off = (int8_t)lbt_thr_off_32;

  return (ret == WL3SFX_BOARDDATA_RW_OK) ? 0 : 1;
}

uint8_t ST_SFX_SetLBTThresholdOffset(int8_t lbt_thr_off)
{
  return wl3sfx_nvm_boarddata_set(WL3SFX_BOARDDATA_LBT_THR_OFFSET, lbt_thr_off) == WL3SFX_BOARDDATA_RW_OK ? 0 : 1;
}

void ST_SFX_SetPayloadEncryption(uint8_t enable)
{
  wl3sfx_credentials_set_payload_encryption_flag(enable);
}

void ST_SFX_ReduceOutputPower(int8_t reduction)
{
  wl3sfx_txsymbols_set_power_reduction(reduction);
}

void ST_SFX_SetPAEnabled(uint8_t enabled)
{
  wl3sfx_fem_set_pa_enabled(enabled);
}

uint8_t ST_SFX_GetRolloverCounter(uint8_t* counter)
{
  uint8_t ret = 1;
  uint8_t record[SFX_NVMEM_BLOCK_SIZE];

  if (wl3sfx_nvm_records_read(record, sizeof(record)) == WL3SFX_Records_RW_OK) {
    ret = 0;
    *counter = record[SFX_NVMEM_RL];
  }

  return ret;
}