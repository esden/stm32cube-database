[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_mcu_api.c
  * @author  GPM WBL Application Team
  * @brief   Application configuration file for STM32WPAN Middleware
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#if !BspIpDatas??]

/*
*  (!) No platform settings set in Cube MX for the MW SIGFOX. The Logs will not be used (!)
*
*  --------------------------------------------------------------------
*  If you intend to use the Logs, please follow the procedure below :
*  --------------------------------------------------------------------
*
* 1. Open your project on Cube MX.
*
* 2. Click on the MW "SIGFOX".
*
* 3. Click on the "Configuration" panel.
*
* 4. Click on the "Platform Settings" panel.
*
* 5. Select the BSP you'll use for the Logs. It can be one of the following :
*    In order to select them, you need to activate the corresponding IP beforehand in Cube MX.
*    . USART1
*    . LPUART1
*
*/
[/#if]
[#assign IpInstance = ""]
[#assign IpName = ""]
[#assign ipInstance  = ""]
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

#include "stm32wl3x_hal.h"
#include "stm32_lpm.h"
#include "stm32wl3x_ll_usart.h"
#include "wl3sfx_credentials.h"
#include "wl3sfx_nvm_records.h"
#include "wl3sfx_rf_state.h"
#include "wl3sfx_timer.h"
#include "wl3sfx_log.h"
#include "wl3sfx_oob.h"

#include "sigfox_types.h"
#include "sigfox_api.h"
#include "mcu_api.h"

[#if BspIpDatas??]
[#list BspIpDatas as SWIP]
    [#if SWIP.variables??]
        [#list SWIP.variables as variables]
            [#if variables.name?contains("IpInstance")]
                [#assign IpInstance = variables.value]
        [/#if]
            [#if variables.name?contains("IpName")]
                [#assign IpName = variables.value]
            [/#if]
			[#if variables.value?contains("Serial Link for Traces")]
                    [#assign ipInstance  = IpInstance]
            [/#if]
        [/#list]
    [/#if]
[/#list]
[/#if]
/*  ----------------------------- Private static variables ----------------------------- */

/* MCU_API Version Information */
static const uint8_t _api_version[] = { 'v', '1', '.', '0', '.', '0' };

/*  --------------------------- Sigfox MCU_API Implementation --------------------------- */
sfx_u8 MCU_API_malloc(sfx_u16 size, sfx_u8** returned_pointer)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  *returned_pointer = (uint8_t*)malloc(size);
  wl3sfx_log(WL3SFX_SEV_INFO, "returned_pointer: %p", *returned_pointer);

  return (*returned_pointer == NULL) ? MCU_ERR_API_MALLOC : SFX_ERR_NONE;
}

sfx_u8 MCU_API_free(sfx_u8* ptr)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  free(ptr);

  return SFX_ERR_NONE;
}

sfx_u8 MCU_API_get_voltage_temperature(sfx_u16* voltage_idle, sfx_u16* voltage_tx, sfx_s16* temperature)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  wl3sfx_oob_get_voltage_temperature(voltage_idle, voltage_tx, temperature);

  return SFX_ERR_NONE;
}

sfx_u8 MCU_API_delay(sfx_delay_t delay_type)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  switch (delay_type) {
  case SFX_DLY_INTER_FRAME_TRX:
  case SFX_DLY_INTER_FRAME_TX: {
    /*
     * According to the Sigfox specification, inter-frame time intervals between 500ms and 525ms are always acceptable,
     * for both U- and B-procedure and also for all RCs.
     * Therefore, simply always aim for this time interval for SFX_DLY_INTER_FRAME_TRX and SFX_DLY_INTER_FRAME_TX.
     *
     * To take the ramp-down "extra symbol after frame" and processing delays into account, the inter-frame timer
     * is already started when the last data symbol of the uplink frame is transmitted.
     *
     * Please note that *delays are only accurate if logging is disabled*.
     * If logging is enabled, there might be UART output after the timer has expired, which causes unacceptable delays.
     */
    HAL_PWREx_EnableInternalWakeUpLine(PWR_WAKEUP_RTC, PWR_WUP_RISIEDG);
    
    UTIL_LPM_SetStopMode(1 << CFG_LPM_APP, UTIL_LPM_ENABLE);
    UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);
    
    while (!wl3sfx_timer_expired(WL3SFX_TIMER_INTERFRAME_WAKEUP)) {
      /* wait until inter-frame timer expires */

	  [#if BspIpDatas??]
      while ((LL_USART_IsActiveFlag_TXE_TXFNF(${ipInstance}) == RESET) || (LL_USART_IsActiveFlag_TC(${ipInstance}) == RESET)) {};
	  [#else]
	  /*
	  Please configure your platform setting in order to generate
	  while ((LL_USART_IsActiveFlag_TXE_TXFNF(UARTx) == RESET) || (LL_USART_IsActiveFlag_TC(UARTx) == RESET)) {};
	  */
	  #warning user must configure the platform settings to generate.
	  [/#if]
      UTIL_LPM_EnterLowPower();
    };

    /*
     * Wake up earlier from DEEPSTOP than actually needed - this is very important to do
     * so that the XTAL has some time to stabilize, which reduces carrier drift during TX.
     */
    while (!wl3sfx_timer_expired(WL3SFX_TIMER_INTERFRAME)) {};

    break;
  }
  case SFX_DLY_CS_SLEEP: {
    HAL_Delay(1000);
    break;
  }
  case SFX_DLY_OOB_ACK: {
    HAL_Delay(2000);
    break;
  }
  }

  return SFX_ERR_NONE;
}

sfx_u8 MCU_API_aes_128_cbc_encrypt(
  sfx_u8* encrypted_data, sfx_u8* data_to_encrypt, sfx_u8 aes_block_len, sfx_u8 key[16], sfx_credentials_use_key_t use_key)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  wl3sfx_credentials_encrypt(encrypted_data, data_to_encrypt, aes_block_len, key, use_key);

  return SFX_ERR_NONE;
}

sfx_u8 MCU_API_get_nv_mem(sfx_u8 read_data[SFX_NVMEM_BLOCK_SIZE])
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  WL3SFX_Records_StatusTypeDef res = wl3sfx_nvm_records_read((uint8_t*)read_data, SFX_NVMEM_BLOCK_SIZE);

  return (res == WL3SFX_Records_RW_OK) ? SFX_ERR_NONE : MCU_ERR_API_GETNVMEM;
}

sfx_u8 MCU_API_set_nv_mem(sfx_u8 data_to_write[SFX_NVMEM_BLOCK_SIZE])
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  WL3SFX_Records_StatusTypeDef res = wl3sfx_nvm_records_write((uint8_t*)data_to_write, SFX_NVMEM_BLOCK_SIZE);

  return (res == WL3SFX_Records_RW_OK) ? SFX_ERR_NONE : MCU_ERR_API_SETNVMEM;
}

sfx_u8 MCU_API_timer_start_carrier_sense(sfx_u16 time_duration_in_ms)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");
  wl3sfx_log(WL3SFX_SEV_INFO, "duration: %d ms", time_duration_in_ms);

  wl3sfx_timer_start_milliseconds(WL3SFX_TIMER_CS, time_duration_in_ms, NULL);

  return SFX_ERR_NONE;
}

sfx_u8 MCU_API_timer_start(sfx_u32 time_duration_in_s)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");
  wl3sfx_log(WL3SFX_SEV_INFO, "duration: %d s", time_duration_in_s);

  wl3sfx_timer_start_milliseconds(WL3SFX_TIMER_GENERIC, time_duration_in_s * 1000, NULL);

  return SFX_ERR_NONE;
}

sfx_u8 MCU_API_timer_stop(void)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  wl3sfx_timer_stop(WL3SFX_TIMER_GENERIC);

  return SFX_ERR_NONE;
}

sfx_u8 MCU_API_timer_stop_carrier_sense(void)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  return SFX_ERR_NONE;
}

sfx_u8 MCU_API_timer_wait_for_end(void)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  HAL_PWREx_EnableInternalWakeUpLine(PWR_WAKEUP_RTC, PWR_WUP_RISIEDG);

  UTIL_LPM_SetStopMode(1 << CFG_LPM_APP, UTIL_LPM_ENABLE);
  UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);  
  
  while (!wl3sfx_timer_expired(WL3SFX_TIMER_GENERIC)) {
	[#if BspIpDatas??]
    while ((LL_USART_IsActiveFlag_TXE_TXFNF(${ipInstance}) == RESET) || (LL_USART_IsActiveFlag_TC(${ipInstance}) == RESET)) {};
	[#else]
	/*
	Please configure your platform setting in order to generate
	while ((LL_USART_IsActiveFlag_TXE_TXFNF(UARTx) == RESET) || (LL_USART_IsActiveFlag_TC(UARTx) == RESET)) {};
	*/
	#warning user must configure the platform settings to generate.
	[/#if]
    UTIL_LPM_EnterLowPower();
  }
  
  return SFX_ERR_NONE;
}

sfx_u8 MCU_API_report_test_result(sfx_bool status, sfx_s16 rssi)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");
  printf("test result: status = %d, rssi = %d\r\n", status, rssi);

  return SFX_ERR_NONE;
}

sfx_u8 MCU_API_get_version(sfx_u8** version, sfx_u8* size)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  *version = (sfx_u8*)_api_version;
  *size = sizeof(_api_version);

  return SFX_ERR_NONE;
}

sfx_u8 MCU_API_get_device_id_and_payload_encryption_flag(sfx_u8 dev_id[ID_LENGTH], sfx_bool* payload_encryption_enabled)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  wl3sfx_credentials_get_id(dev_id);
  wl3sfx_credentials_get_payload_encryption_flag(payload_encryption_enabled);

  return SFX_ERR_NONE;
}

sfx_u8 MCU_API_get_msg_counter_rollover(e_sfx_msg_counter_rollover* msgCounterRollover)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  *msgCounterRollover = SFX_MSG_COUNTER_ROLLOVER_4096;

  return SFX_ERR_NONE;
}

sfx_u8 MCU_API_get_initial_pac(sfx_u8 initial_pac[PAC_LENGTH])
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  return SFX_ERR_NONE;
}