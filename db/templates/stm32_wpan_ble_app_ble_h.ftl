[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name}
  * @author  MCD Application Team
  * @brief   Header for ble application
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign BLE_TRANSPARENT_MODE_UART = 0]
[#assign BLE_TRANSPARENT_MODE_VCP = 0]
[#assign BT_SIG_BEACON = 0]
[#assign BT_SIG_BLOOD_PRESSURE_SENSOR = 0]
[#assign BT_SIG_HEALTH_THERMOMETER_SENSOR = 0]
[#assign BT_SIG_HEART_RATE_SENSOR = 0]
[#assign CUSTOM_OTA = 0]
[#assign CUSTOM_P2P_CLIENT = 0]
[#assign CUSTOM_P2P_ROUTER = 0]
[#assign CUSTOM_P2P_SERVER = 0]
[#assign CUSTOM_TEMPLATE = 0]
[#assign FREERTOS_STATUS = 0]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
            [#if (definition.name == "BLE_TRANSPARENT_MODE_UART") && (definition.value == "Enabled")]
                [#assign BLE_TRANSPARENT_MODE_UART = 1]
            [/#if]
            [#if (definition.name == "BLE_TRANSPARENT_MODE_VCP") && (definition.value == "Enabled")]
                [#assign BLE_TRANSPARENT_MODE_VCP = 1]
            [/#if]
            [#if (definition.name == "BT_SIG_BEACON") && (definition.value == "Enabled")]
                [#assign BT_SIG_BEACON = 1]
            [/#if]
            [#if (definition.name == "BT_SIG_BLOOD_PRESSURE_SENSOR") && (definition.value == "Enabled")]
                [#assign BT_SIG_BLOOD_PRESSURE_SENSOR = 1]
            [/#if]
            [#if (definition.name == "BT_SIG_HEALTH_THERMOMETER_SENSOR") && (definition.value == "Enabled")]
                [#assign BT_SIG_HEALTH_THERMOMETER_SENSOR = 1]
            [/#if]
            [#if (definition.name == "BT_SIG_HEART_RATE_SENSOR") && (definition.value == "Enabled")]
                [#assign BT_SIG_HEART_RATE_SENSOR = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_OTA") && (definition.value == "Enabled")]
                [#assign CUSTOM_OTA = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_P2P_CLIENT") && (definition.value == "Enabled")]
                [#assign CUSTOM_P2P_CLIENT = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_P2P_ROUTER") && (definition.value =="Enabled")]
                [#assign CUSTOM_P2P_ROUTER = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_P2P_SERVER") && (definition.value == "Enabled")]
                [#assign CUSTOM_P2P_SERVER = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_TEMPLATE") && (definition.value == "Enabled")]
                [#assign CUSTOM_TEMPLATE = 1]
            [/#if]
            [#if definition.name == "BLE_APPLICATION_TYPE"]
                [#assign BLE_APPLICATION_TYPE = definition.value]
            [/#if]
            [#if (definition.name == "FREERTOS_STATUS") && (definition.value == "1")]
                [#assign FREERTOS_STATUS = 1]
            [/#if]
        [/#list]
	[/#if]
[/#list]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef APP_BLE_H
#define APP_BLE_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "hci_tl.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/

[#if  ((BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_TEMPLATE = 1)) && (CUSTOM_P2P_CLIENT = 0) && (CUSTOM_P2P_ROUTER = 0)]
typedef enum
{
  APP_BLE_IDLE,
  APP_BLE_FAST_ADV,
  APP_BLE_LP_ADV,
  APP_BLE_SCAN,
  APP_BLE_LP_CONNECTING,
  APP_BLE_CONNECTED_SERVER,
  APP_BLE_CONNECTED_CLIENT
} APP_BLE_ConnStatus_t;
    
[/#if]
[#if  (CUSTOM_P2P_CLIENT = 1)]
typedef enum
{
  APP_BLE_IDLE,
  APP_BLE_FAST_ADV,
  APP_BLE_LP_ADV,
  APP_BLE_SCAN,
  APP_BLE_LP_CONNECTING,
  APP_BLE_CONNECTED_SERVER,
  APP_BLE_CONNECTED_CLIENT,

  APP_BLE_DISCOVER_SERVICES,
  APP_BLE_DISCOVER_CHARACS,
  APP_BLE_DISCOVER_WRITE_DESC,
  APP_BLE_DISCOVER_NOTIFICATION_CHAR_DESC,
  APP_BLE_ENABLE_NOTIFICATION_DESC,
  APP_BLE_DISABLE_NOTIFICATION_DESC
} APP_BLE_ConnStatus_t;

[/#if]
[#if  (CUSTOM_P2P_ROUTER = 1)]
typedef enum
{
  APP_BLE_IDLE,
  APP_BLE_FAST_ADV,
  APP_BLE_LP_ADV,
  APP_BLE_SCAN,
  APP_BLE_CONNECTING,
  APP_BLE_CONNECTED,

  APP_BLE_DISCOVER_SERVICES,
  APP_BLE_DISCOVER_CHARACS,
  APP_BLE_DISCOVER_LED_CHAR_DESC,
  APP_BLE_DISCOVER_BUTTON_CHAR_DESC,
  APP_BLE_DISCOVER_NOTIFICATION_CHAR_DESC,
  APP_BLE_ENABLE_NOTIFICATION_BUTTON_DESC,
  APP_BLE_DISABLE_NOTIFICATION_TX_DESC
} APP_BLE_ConnStatus_t;  

typedef enum
{
  P2P_START_TIMER_EVT,
  P2P_STOP_TIMER_EVT,
  P2P_BUTTON_INFO_RECEIVED_EVT,
} P2P_Client_Opcode_Notification_evt_t;

typedef struct
{
  uint8_t *pPayload;
  uint8_t Length;
}P2P_Client_Data_t;  

typedef struct
{
  P2P_Client_Opcode_Notification_evt_t  P2P_Client_Evt_Opcode;
  P2P_Client_Data_t DataTransfered;
  uint8_t   ServiceInstance;
}P2P_Client_App_Notification_evt_t;

[/#if]
/* USER CODE BEGIN ET */

/* USER CODE END ET */  

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions ---------------------------------------------*/
void APP_BLE_Init(void); 

[#if  (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (BT_SIG_HEART_RATE_SENSOR = 1)]
APP_BLE_ConnStatus_t APP_BLE_Get_Server_Connection_Status(void);
[/#if]
[#if  (CUSTOM_P2P_ROUTER = 1) || (CUSTOM_P2P_CLIENT = 1)]
APP_BLE_ConnStatus_t APP_BLE_Get_Client_Connection_Status( uint16_t Connection_Handle );
[/#if]

/* USER CODE BEGIN EF */

/* USER CODE END EF */

#ifdef __cplusplus
}
#endif

#endif /*APP_BLE_H */
