[#ftl]
/**
  ******************************************************************************
  * @file    msg_id.h
  * @author  MCD Application Team
  * @brief   MBMUX message ID enumeration
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
[#--
********************************
SWIP Datas:

[#if SWIPdatas??]
  [#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
Defines:
      [#list SWIP.defines as definition]
        ${definition.name}: ${definition.value}
      [/#list]
    [/#if]
  [/#list]
[/#if]
********************************
--]
[#assign SUBGHZ_APPLICATION = ""]
[#list SWIPdatas as SWIP]
  [#if SWIP.defines??]
    [#list SWIP.defines as definition]
            [#if definition.name == "SUBGHZ_APPLICATION"]
                [#assign SUBGHZ_APPLICATION = definition.value]
            [/#if]
        [/#list]
  [/#if]
[/#list]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MSG_ID_H__
#define __MSG_ID_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/

typedef enum
{
  /* CmdResp */
  SYS_GET_INFO_LIST_MSG_ID = 0,
  SYS_REGISTER_FEATURE_MSG_ID,
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") || (SUBGHZ_APPLICATION == "SUBGHZ_USER_APPLICATION")]
  SYS_EE_READ_ID,
  SYS_EE_WRITE_ID,
[/#if]
  /* NotifAck */
  SYS_RTC_ALARM_MSG_ID,
  SYS_OTHER_MSG_ID,
  /* USER CODE BEGIN SYSTEM_MsgIdTypeDef */

  /* USER CODE END SYSTEM_MsgIdTypeDef */
  SYS_MSGID_LAST
} SYSTEM_MsgIdTypeDef;

[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") ||(SUBGHZ_APPLICATION == "LORA_END_NODE") ||(SUBGHZ_APPLICATION == "LORA_USER_APPLICATION") ]
typedef enum
{
  /* CmdResp */
  LMHANDLER_INITIALIZATION_ID = 0,
  LMHANDLER_CONFIGURE_ID,
  LMHANDLER_JOIN_STATUS_ID,
  LMHANDLER_JOIN_ID,
  LMHANDLER_STOP_ID,
  LMHANDLER_SEND_ID,
  LMHANDLER_PROCESS_ID,
  LMHANDLER_REQUEST_CLASS_ID,
  LMHANDLER_GET_CLASS_ID,
  LMHANDLER_GET_DEVEUI_ID,
  LMHANDLER_SET_DEVEUI_ID,
  LMHANDLER_GET_APPEUI_ID,
  LMHANDLER_SET_APPEUI_ID,
  LMHANDLER_GET_NWKID_ID,
  LMHANDLER_SET_NWKID_ID,
  LMHANDLER_GET_DEVADDR_ID,
  LMHANDLER_SET_DEVADDR_ID,
  LMHANDLER_GET_ACTIVE_REGION_ID,
  LMHANDLER_SET_ACTIVE_REGION_ID,
  LMHANDLER_GET_ADR_ENABLE_ID,
  LMHANDLER_SET_ADR_ENABLE_ID,
  LMHANDLER_GET_TX_DATARATE_ID,
  LMHANDLER_SET_TX_DATARATE_ID,
  LMHANDLER_GET_DUTY_CYCLE_ID,
  LMHANDLER_SET_DUTY_CYCLE_ID,
  LMHANDLER_GET_RX2_PARAMS_ID,
  LMHANDLER_GET_TX_PWR_ID,
  LMHANDLER_GET_RX1_DELAY_ID,
  LMHANDLER_GET_RX2_DELAY_ID,
  LMHANDLER_GET_JOIN_RX1_DELAY_ID,
  LMHANDLER_GET_JOIN_RX2_DELAY_ID,
  LMHANDLER_SET_TX_PWR_ID,
  LMHANDLER_SET_RX2_PARAMS_ID,
  LMHANDLER_SET_RX1_DELAY_ID,
  LMHANDLER_SET_RX2_DELAY_ID,
  LMHANDLER_SET_JOIN_RX1_DELAY_ID,
  LMHANDLER_SET_JOIN_RX2_DELAY_ID,
  LMHANDLER_GET_PING_PERIODICITY_ID,
  LMHANDLER_SET_PING_PERIODICITY_ID,
  LMHANDLER_GET_BEACON_STATE_ID,

  LMHANDLER_INFO_INIT_ID,
  /* NotifAck */
  LMHANDLER_GET_BATTERY_LEVEL_CB_ID,
  LMHANDLER_GET_TEMPERATURE_CB_ID,
  LMHANDLER_ON_JOIN_REQ_CB_ID,
  LMHANDLER_ON_TX_DATA_CB_ID,
  LMHANDLER_ON_RX_DATA_CB_ID,
  LMHANDLER_ON_MAC_PROCESS_CB_ID,
  /* USER CODE BEGIN LORA_MsgIdTypeDef */

  /* USER CODE END LORA_MsgIdTypeDef */
  LORA_MSGID_LAST
} LORA_MsgIdTypeDef;

[#elseif (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE")||(SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")|| (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION") ]
typedef enum
{
  /* CmdResp */
  SIGFOX_START_ID = 0,
  SIGFOX_STOP_ID,
  SIGFOX_SEND_FRAME_DWNL_ID,
  SIGFOX_SEND_BIT_ID,
  SIGFOX_SEND_OOB_ID,
  SIGFOX_SET_STD_ID,
  SIGFOX_START_CONTINUOUS_ID,
  SIGFOX_STOP_CONTINUOUS_ID,
  SIGFOX_GET_VERSION_ID,
  SIGFOX_GET_DEVICE_ID,
  SIGFOX_GET_INIT_PAC_ID,
  SIGFOX_SET_RCSYNC_PERIOD_ID,
  SIGFOX_API_TEST_MODE_ID,
  SIGFOX_API_MONARCH_TEST_MODE_ID,
  SIGFOX_API_MONARCH_TEST_EXEC_RC_SCAN_ID,
  SIGFOX_API_MONARCH_STOP_RC_SCAN_ID,
  SIGFOX_EE_READ_ID,
  SIGFOX_EE_WRITE_ID,
  SIGFOX_INFO_INIT_ID,
  /* NotifAck */
  SIGFOX_MONARCH_RC_SCAN_CB_ID,
  SIGFOX_GET_BATTERY_LEVEL_CB_ID,
  SIGFOX_GET_TEMPERATURE_LEVEL_CB_ID,
  /* USER CODE BEGIN Sigfox_MsgIdTypeDef */

  /* USER CODE END Sigfox_MsgIdTypeDef */
  SIGFOX_MSGID_LAST
} Sigfox_MsgIdTypeDef;

[/#if]
typedef enum
{
  /* CmdResp */
  RADIO_INIT_ID = 0,
  RADIO_GET_STATUS_ID,
  RADIO_SET_MODEM_ID,
  RADIO_SET_CHANNEL_ID,
  RADIO_IS_CHANNEL_FREE_ID,
  RADIO_RANDOM_ID,
  RADIO_SET_RX_CONFIG_ID,
  RADIO_SET_TX_CONFIG_ID,
  RADIO_CHECK_RF_FREQUENCY_ID,
  RADIO_GET_TIME_ON_AIR_ID,
  RADIO_SEND_ID,
  RADIO_SLEEP_ID,
  RADIO_STANDBY_ID,
  RADIO_RX_ID,
  RADIO_START_CAD_ID,
  RADIO_SET_TX_CONTINOUS_WAVE_ID,
  RADIO_RSSI_ID,
  RADIO_WRITE_ID,
  RADIO_READ_ID,
  RADIO_WRITE_BUFFER_ID,
  RADIO_READ_BUFFER_ID,
  RADIO_SET_MAX_PAYLOAD_LENGTH_ID,
  RADIO_SET_PUBLIC_NETWORK_ID,
  RADIO_GET_WAKEUP_TIME_ID,
  RADIO_IRQ_PROCESS_ID,
  RADIO_RX_BOOSTED_ID,
  RADIO_SET_RX_DUTY_CYCLE_ID,
  RADIO_TX_PRBS_ID,
  RADIO_TX_CW_ID,
  RADIO_SET_RX_GENERIC_CONFIG_ID,
  RADIO_SET_TX_GENERIC_CONFIG_ID,
  /* NotifAck */
  RADIO_TX_DONE_CB_ID,
  RADIO_TX_TIMEOUT_CB_ID,
  RADIO_RX_DONE_CB_ID,
  RADIO_RX_TIMEOUT_CB_ID,
  RADIO_RX_ERROR_CB_ID,
  RADIO_FHSS_CHANGE_CHANNEL_CB_ID,
  RADIO_CAD_DONE_CB_ID,
  /* USER CODE BEGIN RADIO_MsgIdTypeDef */

  /* USER CODE END RADIO_MsgIdTypeDef */
  RADIO_MSGID_LAST
} RADIO_MsgIdTypeDef;

typedef enum
{
  /* CmdResp */
  KMS_INIT_ID = 0,
  KMS_OPEN_SESSION_ID,
  KMS_CLOSE_SESSION_ID,
  KMS_ENCRYPT_ID,
  KMS_DECRYPT_ID,
  KMS_DERIVE_KEY_ID,
  KMS_CRYPTO_HMAC_SHA256_MSG_ID,
  /* NotifAck */
  /* USER CODE BEGIN KMS_MsgIdTypeDef */

  /* USER CODE END KMS_MsgIdTypeDef */
  KMS_MSGID_LAST
} KMS_MsgIdTypeDef;

typedef enum
{
  /* CmdResp */
  TRACE_SEND_MSG_ID = 0,
  /* NotifAck */
  /* USER CODE BEGIN Trace_MsgIdTypeDef */

  /* USER CODE END Trace_MsgIdTypeDef */
  TRACE_MSGID_LAST
} Trace_MsgIdTypeDef;

/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/

/* Dual core Init sequence */
#define CPUS_BOOT_SYNC_PREVENT_CPU2_TO_START  0xFFFF
#define CPUS_BOOT_SYNC_ALLOW_CPU2_TO_START    0x5555
#define CPUS_BOOT_SYNC_CPU2_INIT_COMPLETED    0xAAAA
#define CPUS_BOOT_SYNC_RTC_REGISTERED         0x9999

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions ------------------------------------------------------- */
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __MSG_ID_H__ */
