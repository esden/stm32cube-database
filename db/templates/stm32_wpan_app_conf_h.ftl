[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name}
  * @author  MCD Application Team
  * @brief   Application configuration file for STM32WPAN Middleware.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign BLE_TRANSPARENT_MODE_UART = 0]
[#assign BLE_TRANSPARENT_MODE_VCP = 0]
[#assign BT_SIG_BEACON = "0"]
[#assign BT_SIG_BLOOD_PRESSURE_SENSOR = 0]
[#assign BT_SIG_HEALTH_THERMOMETER_SENSOR = 0]
[#assign BT_SIG_HEART_RATE_SENSOR = 0]
[#assign CUSTOM_OTA = 0]
[#assign CUSTOM_P2P_CLIENT = 0]
[#assign CUSTOM_P2P_ROUTER = 0]
[#assign CUSTOM_P2P_SERVER = 0]
[#assign CUSTOM_TEMPLATE = 0]
[#assign FREERTOS_STATUS = 0]
[#assign CFG_USB_INTERFACE_ENABLE_VALUE = 0]
[#assign THREAD = 0]
[#assign BLE = 0]
[#assign ZIGBEE = 0]
[#assign CFG_FULL_LOW_POWER = 0]
[#assign CFG_DEBUG_TRACE_LIGHT = 0]
[#assign CFG_DEBUG_TRACE_FULL = 0]
[#assign CFG_DEBUG_TRACE = 0]
[#assign CFG_DEBUG_TRACE_UART = "0"]
[#assign CFG_UART_GUI = "0"]
[#assign CFG_CONSOLE_MENU = ""]
[#assign CFG_CLI_UART = "0"]
[#assign CFG_DEBUGGER_SUPPORTED = 0]
[#assign CFG_ADV_BD_ADDRESS = 0]
[#assign CFG_STATIC_RANDOM_ADDRESS = 0]
[#assign STATIC_RANDOM_ADDRESS = 0]
[#assign CFG_FAST_CONN_ADV_INTERVAL_MAX_HEXA = 0]
[#assign CFG_FAST_CONN_ADV_INTERVAL_MIN_HEXA = 0]
[#assign CFG_LP_CONN_ADV_INTERVAL_MAX_HEXA = 0]
[#assign CFG_LP_CONN_ADV_INTERVAL_MIN_HEXA = 0]
[#assign CFG_BONDING_MODE = 0]
[#assign CFG_USED_FIXED_PIN = 0]
[#assign CFG_FIXED_PIN = 0]
[#assign CFG_ENCRYPTION_KEY_SIZE_MAX = 0]
[#assign CFG_ENCRYPTION_KEY_SIZE_MIN = 0]
[#assign CFG_IO_CAPABILITY = 0]
[#assign CFG_MITM_PROTECTION = 0]
[#assign CFG_SC_SUPPORT = 0]
[#assign CFG_KEYPRESS_NOTIFICATION_SUPPORT = 0]
[#assign ADV_TYPE = 0]
[#assign CFG_TX_POWER = 0]
[#assign BLE_ADDR_TYPE = 0]
[#assign ADV_FILTER = 0]
[#assign CFG_GAP_DEVICE_NAME = ""]
[#assign CFG_GAP_DEVICE_NAME_LENGTH = 0]
[#assign APPLI_PRINT_FILE_FUNC_LINE = 0]
[#assign CFG_BLE_IRK_HEX = "0"]
[#assign CFG_BLE_ERK_HEX = "0"]
[#assign CFG_USE_SMPS = 0]
[#assign OFFSET_PAYLOAD_LENGTH = 9]
[#assign OFFSET_PAYLOAD_DATA = 10]
[#assign CFG_BLE_NUM_LINK = 2]
[#assign CFG_BLE_NUM_GATT_SERVICES = 8]
[#assign CFG_BLE_NUM_GATT_ATTRIBUTES = 68]
[#assign CFG_BLE_MAX_ATT_MTU = 156]
[#assign CFG_BLE_ATT_VALUE_ARRAY_SIZE = 1344]
[#assign CFG_BLE_DATA_LENGTH_EXTENSION = 1]
[#assign CFG_BLE_SLAVE_SCA = 500]
[#assign CFG_BLE_MASTER_SCA = 0]
[#assign CFG_BLE_LSE_SOURCE = 0]
[#assign CFG_BLE_HSE_STARTUP_TIME = "0x0148"]
[#assign CFG_BLE_MAX_CONN_EVENT_LENGTH = "0xFFFFFFFF"]
[#assign CFG_BLE_VITERBI_MODE = 1]
[#assign CFG_BLE_OPTIONS_LL = "SHCI_C2_BLE_INIT_OPTIONS_LL_HOST"]
[#assign CFG_BLE_OPTIONS_SVC = "SHCI_C2_BLE_INIT_OPTIONS_WITH_SVC_CHANGE_DESC"]
[#assign CFG_BLE_OPTIONS_DEVICE_NAME = "SHCI_C2_BLE_INIT_OPTIONS_DEVICE_NAME_RW"]
[#assign CFG_BLE_OPTIONS_POWER_CLASS = "SHCI_C2_BLE_INIT_OPTIONS_POWER_CLASS_2_3"]
[#assign CFG_BLE_MAX_COC_INITIATOR_NBR = 32]
[#assign CFG_BLE_MIN_TX_POWER = 0]
[#assign CFG_BLE_MAX_TX_POWER = 0]
[#assign CFG_TLBLE_EVT_QUEUE_LENGTH = 5]
[#assign CFG_TLBLE_MOST_EVENT_PAYLOAD_SIZE = 255]
[#assign DBG_TRACE_USE_CIRCULAR_QUEUE = 1]
[#assign DBG_TRACE_MSG_QUEUE_SIZE = 4096]
[#assign MAX_DBG_TRACE_MSG_SIZE = 1024]
[#assign CFG_RTCCLK_DIVIDER_CONF = 0]
[#assign CFG_RTCCLK_DIV = 16]
[#assign CFG_RTC_WUCKSEL_DIVIDER = 0]
[#assign CFG_RTC_ASYNCH_PRESCALER = "0x0F"]
[#assign CFG_RTC_SYNCH_PRESCALER = "0x7FFF"]
[#assign CFG_LPM_STANDBY_SUPPORTED = 0]
[#assign DIE = DIE]
[#assign Line = Line]
[#--
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
                ${definition.name}: ${definition.value}
        [/#list]
    [/#if]
[/#list]
--]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
            [#if (definition.name == "BLE_TRANSPARENT_MODE_UART") && (definition.value == "Enabled")]
                [#assign BLE_TRANSPARENT_MODE_UART = 1]
            [/#if]
            [#if (definition.name == "BLE_TRANSPARENT_MODE_VCP") && (definition.value == "Enabled")]
                [#assign BLE_TRANSPARENT_MODE_VCP = 1]
            [/#if]
            [#if (definition.name == "BT_SIG_BEACON") && (definition.value != "Disabled")]
                [#assign BT_SIG_BEACON = definition.value]
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
            [#if (definition.name == "CFG_USB_INTERFACE_ENABLE") && (definition.value == "Enabled")]
                [#assign CFG_USB_INTERFACE_ENABLE = 1]
                [#assign CFG_USB_INTERFACE_ENABLE_VALUE = 1]
            [/#if]
            [#if (definition.name == "FREERTOS_STATUS") && (definition.value == "1")]
                [#assign FREERTOS_STATUS = 1]
            [/#if]
            [#if (definition.name == "BLE") && (definition.value == "Enabled")]
                [#assign BLE = 1]
            [/#if]
            [#if (definition.name == "THREAD") && (definition.value == "Enabled")]
                [#assign THREAD = 1]
            [/#if]
            [#if (definition.name == "ZIGBEE") && (definition.value == "Enabled")]
                [#assign ZIGBEE = 1]
            [/#if]
            [#if definition.name == "BLE_APPLICATION_TYPE"]
                [#assign BLE_APPLICATION_TYPE = definition.value]
            [/#if]
            [#if definition.name == "THREAD_APPLICATION"]
                [#assign THREAD_APPLICATION = definition.value]
            [/#if]
            [#if definition.name == "CFG_DEBUG_TRACE"]
                [#assign CFG_DEBUG_TRACE = definition.value]
            [/#if]
            [#if (definition.name == "CFG_DEBUG_TRACE_UART") && !(definition.value == "")]
                [#assign CFG_DEBUG_TRACE_UART = definition.value]
            [/#if]
			[#if (definition.name == "CFG_UART_GUI") && !(definition.value == "")]
                [#assign CFG_UART_GUI = definition.value]
            [/#if]
			[#if (definition.name == "CFG_CONSOLE_MENU") && (definition.value == "No UART selected") && (THREAD == 1)]
                [#assign CFG_CONSOLE_MENU = ""]
            [/#if]
			[#if (definition.name == "CFG_CONSOLE_MENU") && (definition.value == "No UART selected") && (BLE == 1)]
                [#assign CFG_CONSOLE_MENU = 0]
            [/#if]
			[#if (definition.name == "CFG_CONSOLE_MENU") && (definition.value != "No UART selected")]
                [#assign CFG_CONSOLE_MENU = definition.value]
            [/#if]
			[#if (definition.name == "CFG_CLI_UART") && !(definition.value == "")]
                [#assign CFG_CLI_UART = definition.value]
            [/#if]
            [#if (definition.name == "CFG_FULL_LOW_POWER") && (definition.value == "Enabled")]
                [#assign CFG_FULL_LOW_POWER = 1]
            [/#if]
            [#if (definition.name == "CFG_DEBUG_TRACE_LIGHT") && (definition.value == "Enabled")]
                [#assign CFG_DEBUG_TRACE_LIGHT = 1]
            [/#if]
            [#if (definition.name == "CFG_DEBUG_TRACE_FULL") && (definition.value == "Enabled")]
                [#assign CFG_DEBUG_TRACE_FULL = 1]
            [/#if]
            [#if (definition.name == "CFG_DEBUGGER_SUPPORTED") && (definition.value == "Enabled")]
                [#assign CFG_DEBUGGER_SUPPORTED = 1]
            [/#if]
            [#if (definition.name == "CFG_ADV_BD_ADDRESS")]
                [#assign CFG_ADV_BD_ADDRESS = definition.value]
            [/#if]
            [#if (definition.name == "CFG_STATIC_RANDOM_ADDRESS")]
                [#assign CFG_STATIC_RANDOM_ADDRESS = definition.value]
            [/#if]
            [#if (definition.name == "STATIC_RANDOM_ADDRESS")]
                [#assign STATIC_RANDOM_ADDRESS = definition.value]
            [/#if]
            [#if (definition.name == "CFG_FAST_CONN_ADV_INTERVAL_MIN_HEXA")]
                [#assign CFG_FAST_CONN_ADV_INTERVAL_MIN_HEXA = definition.value]
            [/#if]
            [#if (definition.name == "CFG_FAST_CONN_ADV_INTERVAL_MAX_HEXA")]
                [#assign CFG_FAST_CONN_ADV_INTERVAL_MAX_HEXA = definition.value]
            [/#if]
            [#if (definition.name == "CFG_LP_CONN_ADV_INTERVAL_MIN_HEXA")]
                [#assign CFG_LP_CONN_ADV_INTERVAL_MIN_HEXA = definition.value]
            [/#if]
            [#if (definition.name == "CFG_LP_CONN_ADV_INTERVAL_MAX_HEXA")]
                [#assign CFG_LP_CONN_ADV_INTERVAL_MAX_HEXA = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BONDING_MODE")]
                [#assign CFG_BONDING_MODE = definition.value]
            [/#if]
            [#if (definition.name == "CFG_USED_FIXED_PIN")]
                [#assign CFG_USED_FIXED_PIN = definition.value]
            [/#if]
            [#if (definition.name == "CFG_FIXED_PIN")]
                [#assign CFG_FIXED_PIN = definition.value]
            [/#if]
            [#if (definition.name == "CFG_ENCRYPTION_KEY_SIZE_MAX")]
                [#assign CFG_ENCRYPTION_KEY_SIZE_MAX = definition.value]
            [/#if]
            [#if (definition.name == "CFG_ENCRYPTION_KEY_SIZE_MIN")]
                [#assign CFG_ENCRYPTION_KEY_SIZE_MIN = definition.value]
            [/#if]
            [#if (definition.name == "CFG_IO_CAPABILITY")]
                [#assign CFG_IO_CAPABILITY = definition.value]
            [/#if]
            [#if (definition.name == "CFG_MITM_PROTECTION")]
                [#assign CFG_MITM_PROTECTION = definition.value]
            [/#if]
            [#if (definition.name == "CFG_SC_SUPPORT")]
                [#assign CFG_SC_SUPPORT = definition.value]
            [/#if]
            [#if (definition.name == "CFG_KEYPRESS_NOTIFICATION_SUPPORT")]
                [#assign CFG_KEYPRESS_NOTIFICATION_SUPPORT = definition.value]
            [/#if]
            [#if (definition.name == "ADV_TYPE")]
                [#assign ADV_TYPE = definition.value]
            [/#if]
            [#if (definition.name == "CFG_TX_POWER")]
                [#assign CFG_TX_POWER = definition.value]
            [/#if]
            [#if (definition.name == "BLE_ADDR_TYPE")]
                [#assign BLE_ADDR_TYPE = definition.value]
            [/#if]
            [#if (definition.name == "ADV_FILTER")]
                [#assign ADV_FILTER = definition.value]
            [/#if]
            [#if (definition.name == "CFG_GAP_DEVICE_NAME")]
                [#assign CFG_GAP_DEVICE_NAME = definition.value]
            [/#if]
            [#if (definition.name == "CFG_GAP_DEVICE_NAME_LENGTH")]
                [#assign CFG_GAP_DEVICE_NAME_LENGTH = definition.value]
            [/#if]
            [#if (definition.name == "APPLI_PRINT_FILE_FUNC_LINE")]
                [#assign APPLI_PRINT_FILE_FUNC_LINE = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_IRK_HEX")]
                [#assign CFG_BLE_IRK_HEX = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_ERK_HEX")]
                [#assign CFG_BLE_ERK_HEX = definition.value]
            [/#if]
            [#if (definition.name == "CFG_USE_SMPS")]
                [#assign CFG_USE_SMPS = definition.value]
            [/#if]
            [#if (definition.name == "OFFSET_PAYLOAD_LENGTH")]
                [#assign OFFSET_PAYLOAD_LENGTH = definition.value]
            [/#if]
            [#if (definition.name == "OFFSET_PAYLOAD_DATA")]
                [#assign OFFSET_PAYLOAD_DATA = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_NUM_LINK")]
                [#assign CFG_BLE_NUM_LINK = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_NUM_GATT_SERVICES")]
                [#assign CFG_BLE_NUM_GATT_SERVICES = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_NUM_GATT_ATTRIBUTES")]
                [#assign CFG_BLE_NUM_GATT_ATTRIBUTES = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_MAX_ATT_MTU")]
                [#assign CFG_BLE_MAX_ATT_MTU = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_ATT_VALUE_ARRAY_SIZE")]
                [#assign CFG_BLE_ATT_VALUE_ARRAY_SIZE = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_DATA_LENGTH_EXTENSION")]
                [#assign CFG_BLE_DATA_LENGTH_EXTENSION = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_SLAVE_SCA")]
                [#assign CFG_BLE_SLAVE_SCA = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_MASTER_SCA")]
                [#assign CFG_BLE_MASTER_SCA = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_LSE_SOURCE")]
                [#assign CFG_BLE_LSE_SOURCE = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_HSE_STARTUP_TIME")]
                [#assign CFG_BLE_HSE_STARTUP_TIME = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_MAX_CONN_EVENT_LENGTH")]
                [#assign CFG_BLE_MAX_CONN_EVENT_LENGTH = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_VITERBI_MODE")]
                [#assign CFG_BLE_VITERBI_MODE = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_OPTIONS_LL")]
                [#assign CFG_BLE_OPTIONS_LL = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_OPTIONS_SVC")]
                [#assign CFG_BLE_OPTIONS_SVC = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_OPTIONS_DEVICE_NAME")]
                [#assign CFG_BLE_OPTIONS_DEVICE_NAME = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_OPTIONS_POWER_CLASS")]
                [#assign CFG_BLE_OPTIONS_POWER_CLASS = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_MAX_COC_INITIATOR_NBR")]
                [#assign CFG_BLE_MAX_COC_INITIATOR_NBR = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_MIN_TX_POWER")]
                [#assign CFG_BLE_MIN_TX_POWER = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_MAX_TX_POWER")]
                [#assign CFG_BLE_MAX_TX_POWER = definition.value]
            [/#if]
            [#if (definition.name == "CFG_TLBLE_EVT_QUEUE_LENGTH")]
                [#assign CFG_TLBLE_EVT_QUEUE_LENGTH = definition.value]
            [/#if]
            [#if (definition.name == "CFG_TLBLE_MOST_EVENT_PAYLOAD_SIZE")]
                [#assign CFG_TLBLE_MOST_EVENT_PAYLOAD_SIZE = definition.value]
            [/#if]
            [#if (definition.name == "DBG_TRACE_USE_CIRCULAR_QUEUE")]
                [#assign DBG_TRACE_USE_CIRCULAR_QUEUE = definition.value]
            [/#if]
            [#if (definition.name == "DBG_TRACE_MSG_QUEUE_SIZE")]
                [#assign DBG_TRACE_MSG_QUEUE_SIZE = definition.value]
            [/#if]
            [#if (definition.name == "MAX_DBG_TRACE_MSG_SIZE")]
                [#assign MAX_DBG_TRACE_MSG_SIZE = definition.value]
            [/#if]
            [#if (definition.name == "CFG_RTCCLK_DIVIDER_CONF")]
                [#assign CFG_RTCCLK_DIVIDER_CONF = definition.value]
            [/#if]
            [#if (definition.name == "CFG_RTCCLK_DIV")]
                [#assign CFG_RTCCLK_DIV = definition.value]
            [/#if]
            [#if (definition.name == "CFG_RTC_WUCKSEL_DIVIDER")]
                [#assign CFG_RTC_WUCKSEL_DIVIDER = definition.value]
            [/#if]
            [#if (definition.name == "CFG_RTC_ASYNCH_PRESCALER")]
                [#assign CFG_RTC_ASYNCH_PRESCALER = definition.value]
            [/#if]
            [#if (definition.name == "CFG_RTC_SYNCH_PRESCALER")]
                [#assign CFG_RTC_SYNCH_PRESCALER = definition.value]
            [/#if]
            [#if (definition.name == "CFG_LPM_STANDBY_SUPPORTED")]
                [#assign CFG_LPM_STANDBY_SUPPORTED = definition.value]
            [/#if]
		[/#list]
	[/#if]
[/#list]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef APP_CONF_H
#define APP_CONF_H

#include "hw.h"
#include "hw_conf.h"
#include "hw_if.h"
[#if (BLE = 1)]
#include "ble_bufsize.h"
[/#if]

/******************************************************************************
 * Application Config
 ******************************************************************************/
[#if (BLE = 1)]

[#if (BT_SIG_BEACON != "0") || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1)|| (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)|| (BT_SIG_HEART_RATE_SENSOR = 1)|| (CUSTOM_OTA = 1)|| (CUSTOM_P2P_SERVER = 1)|| (CUSTOM_P2P_CLIENT = 1)|| (CUSTOM_P2P_ROUTER = 1)|| (CUSTOM_TEMPLATE = 1)]
/**< generic parameters ******************************************************/

/**
 * Define Tx Power
 */
#define CFG_TX_POWER                      ${CFG_TX_POWER}

/**
 * Define Advertising parameters
 */
#define CFG_ADV_BD_ADDRESS                (${CFG_ADV_BD_ADDRESS})
[/#if]
[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_P2P_ROUTER = 1) || (CUSTOM_TEMPLATE = 1)]
#define CFG_BLE_ADDRESS_TYPE              ${BLE_ADDR_TYPE} /**< Bluetooth address types defined in ble_legacy.h */
[#if ((CFG_STATIC_RANDOM_ADDRESS = "1") && (BLE_ADDR_TYPE = "RANDOM_ADDR"))]
#define CFG_STATIC_RANDOM_ADDRESS         (${STATIC_RANDOM_ADDRESS}) /**< Static Random Address fixed for lifetime of the device */
[/#if]
[/#if]

[#if (BT_SIG_BEACON != "0") || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1)|| (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)|| (BT_SIG_HEART_RATE_SENSOR = 1)|| (CUSTOM_OTA = 1)|| (CUSTOM_P2P_SERVER = 1)|| (CUSTOM_TEMPLATE = 1)]
#define CFG_FAST_CONN_ADV_INTERVAL_MIN    (${CFG_FAST_CONN_ADV_INTERVAL_MIN_HEXA})   /**< 80ms */
#define CFG_FAST_CONN_ADV_INTERVAL_MAX    (${CFG_FAST_CONN_ADV_INTERVAL_MAX_HEXA})  /**< 100ms */
#define CFG_LP_CONN_ADV_INTERVAL_MIN      (${CFG_LP_CONN_ADV_INTERVAL_MIN_HEXA}) /**< 1s */
#define CFG_LP_CONN_ADV_INTERVAL_MAX      (${CFG_LP_CONN_ADV_INTERVAL_MAX_HEXA}) /**< 2.5s */
[/#if]
[#if (CUSTOM_TEMPLATE = 1)]
#define ADV_TYPE                          ${ADV_TYPE}
#define BLE_ADDR_TYPE                     ${BLE_ADDR_TYPE}
#define ADV_FILTER                        ${ADV_FILTER}
[/#if]
[#if (CUSTOM_P2P_ROUTER = 1)]
#define LEDBUTTON_CONN_ADV_INTERVAL_MIN   (0x1FA)
#define LEDBUTTON_CONN_ADV_INTERVAL_MAX   (0x3E8)

[/#if]
[#if (BT_SIG_BEACON != "0") || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1)|| (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)|| (BT_SIG_HEART_RATE_SENSOR = 1)|| (CUSTOM_OTA = 1)|| (CUSTOM_P2P_SERVER = 1)|| (CUSTOM_P2P_CLIENT = 1)|| (CUSTOM_P2P_ROUTER = 1)|| (CUSTOM_TEMPLATE = 1)]

/**
 * Define IO Authentication
 */
[#if (BT_SIG_HEART_RATE_SENSOR = 1)|| (CUSTOM_P2P_SERVER = 1)|| (CUSTOM_P2P_CLIENT = 1)|| (CUSTOM_P2P_ROUTER = 1)]
#define CFG_BONDING_MODE                 (1)
[#else]
#define CFG_BONDING_MODE                 (${CFG_BONDING_MODE})
[/#if]
#define CFG_FIXED_PIN                    (${CFG_FIXED_PIN})
[#if (CUSTOM_P2P_CLIENT = 1)|| (CUSTOM_P2P_ROUTER = 1)]
#define CFG_USED_FIXED_PIN               (1)
[#else]
#define CFG_USED_FIXED_PIN               (${CFG_USED_FIXED_PIN})
[/#if]
#define CFG_ENCRYPTION_KEY_SIZE_MAX      (${CFG_ENCRYPTION_KEY_SIZE_MAX})
#define CFG_ENCRYPTION_KEY_SIZE_MIN      (${CFG_ENCRYPTION_KEY_SIZE_MIN})

/**
 * Define IO capabilities
 */
#define CFG_IO_CAPABILITY_DISPLAY_ONLY       (0x00)
#define CFG_IO_CAPABILITY_DISPLAY_YES_NO     (0x01)
#define CFG_IO_CAPABILITY_KEYBOARD_ONLY      (0x02)
#define CFG_IO_CAPABILITY_NO_INPUT_NO_OUTPUT (0x03)
#define CFG_IO_CAPABILITY_KEYBOARD_DISPLAY   (0x04)

#define CFG_IO_CAPABILITY              ${CFG_IO_CAPABILITY}

/**
 * Define MITM modes
 */
#define CFG_MITM_PROTECTION_NOT_REQUIRED      (0x00)
#define CFG_MITM_PROTECTION_REQUIRED          (0x01)

#define CFG_MITM_PROTECTION             ${CFG_MITM_PROTECTION}

[/#if]
/**
 * Define Secure Connections Support
 */
#define CFG_SECURE_NOT_SUPPORTED       (0x00)
#define CFG_SECURE_OPTIONAL            (0x01)
#define CFG_SECURE_MANDATORY           (0x02)

#define CFG_SC_SUPPORT                 ${CFG_SC_SUPPORT}

/**
 * Define Keypress Notification Support
 */
#define CFG_KEYPRESS_NOT_SUPPORTED      (0x00)
#define CFG_KEYPRESS_SUPPORTED          (0x01)

#define CFG_KEYPRESS_NOTIFICATION_SUPPORT             ${CFG_KEYPRESS_NOTIFICATION_SUPPORT}
   
/**
 * Numeric Comparison Answers
 */   
#define YES (0x01)
#define NO  (0x00)

/**
 * Device name configuration for Generic Access Service
 */
#define CFG_GAP_DEVICE_NAME             "${CFG_GAP_DEVICE_NAME}"
#define CFG_GAP_DEVICE_NAME_LENGTH      (${CFG_GAP_DEVICE_NAME_LENGTH})

[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1)|| (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
/**
 * Define PHY
 */
#define ALL_PHYS_PREFERENCE                             0x00
#define RX_2M_PREFERRED                                 0x02
#define TX_2M_PREFERRED                                 0x02
#define TX_1M                                           0x01
#define TX_2M                                           0x02
#define RX_1M                                           0x01
#define RX_2M                                           0x02 
[/#if]

[#if (BT_SIG_BEACON != "0") || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1)|| (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)|| (BT_SIG_HEART_RATE_SENSOR = 1)|| (CUSTOM_OTA = 1)|| (CUSTOM_P2P_SERVER = 1)|| (CUSTOM_P2P_CLIENT = 1)|| (CUSTOM_P2P_ROUTER = 1)|| ( BLE_TRANSPARENT_MODE_UART = 1)|| ( BLE_TRANSPARENT_MODE_VCP = 1)|| (CUSTOM_TEMPLATE = 1)]
/**
*   Identity root key used to derive LTK and CSRK
*/
#define CFG_BLE_IRK     {${CFG_BLE_IRK_HEX}}

/**
* Encryption root key used to derive LTK and CSRK
*/
#define CFG_BLE_ERK     {${CFG_BLE_ERK_HEX}}

[/#if]
[#if Line != "STM32WBx0 Value Line" ]
/**
 * SMPS supply
 * SMPS not used when Set to 0
 * SMPS used when Set to 1
 */
#define CFG_USE_SMPS    ${CFG_USE_SMPS}

[/#if]
/* USER CODE BEGIN Generic_Parameters */

/* USER CODE END Generic_Parameters */

/**< specific parameters */
/*****************************************************/

[#if (CUSTOM_P2P_CLIENT = 1)]
#define CFG_MAX_CONNECTION                      1
#define UUID_128BIT_FORMAT                      1
#define CFG_DEV_ID_P2P_SERVER1                  (0x83)
#define CONN_L(x) ((int)((x)/0.625f))
#define CONN_P(x) ((int)((x)/1.25f))
#define SCAN_P (0x320)
#define SCAN_L (0x320)
#define CONN_P1   (CONN_P(50))
#define CONN_P2   (CONN_P(100))
#define SUPERV_TIMEOUT (0x1F4)
#define CONN_L1   (CONN_L(10))
#define CONN_L2   (CONN_L(10))
#define OOB_DEMO                                1   /* Out Of Box Demo */  
[/#if]

[#if (BT_SIG_BEACON != "0")]
/**
 * Beacon selection
 * Beacons are all exclusive
 */
#define CFG_EDDYSTONE_UID_BEACON_TYPE   (1<<0)
#define CFG_EDDYSTONE_URL_BEACON_TYPE   (1<<1)
#define CFG_EDDYSTONE_TLM_BEACON_TYPE   (1<<2)
#define CFG_IBEACON                     (1<<3)

#define CFG_BEACON_TYPE                 (${BT_SIG_BEACON})

#define OTA_BEACON_DATA_ADDRESS         FLASH_BASE + 0x6000
#define OFFSET_PAYLOAD_LENGTH           ${OFFSET_PAYLOAD_LENGTH}
#define OFFSET_PAYLOAD_DATA             ${OFFSET_PAYLOAD_DATA}
[/#if]
[#if (BT_SIG_HEART_RATE_SENSOR = 1)]
/**
* AD Element - Group B Feature
*/ 
/* LSB - Second Byte */
#define CFG_FEATURE_OTA_REBOOT                  (0x20)
[/#if]
[#if (CUSTOM_P2P_SERVER = 1)]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="P2P_SERVER_NUMBER"]
                [#if definition.value="P2P_SERVER1"]
                    [#lt]#define P2P_SERVER1    1    /*1 = Device is Peripherique*/
                [#else]
                    [#lt]#define P2P_SERVER1    0
                [/#if]
            [/#if]
        [/#list]
    [/#if]
[/#list]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="P2P_SERVER_NUMBER"]
                [#if definition.value="P2P_SERVER2"]
                    [#lt]#define P2P_SERVER2    1    /*1 = Device is Peripherique*/
                [#else]
                    [#lt]#define P2P_SERVER2    0
                [/#if]
            [/#if]
        [/#list]
    [/#if]
[/#list]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="P2P_SERVER_NUMBER"]
                [#if definition.value="P2P_SERVER3"]
                    [#lt]#define P2P_SERVER3    1    /*1 = Device is Peripherique*/
                [#else]
                    [#lt]#define P2P_SERVER3    0
                [/#if]
            [/#if]
        [/#list]
    [/#if]
[/#list]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="P2P_SERVER_NUMBER"]
                [#if definition.value="P2P_SERVER4"]
                    [#lt]#define P2P_SERVER4    1    /*1 = Device is Peripherique*/
                [#else]
                    [#lt]#define P2P_SERVER4    0
                [/#if]
            [/#if]
        [/#list]
    [/#if]
[/#list]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="P2P_SERVER_NUMBER"]
                [#if definition.value="P2P_SERVER5"]
                    [#lt]#define P2P_SERVER5    1    /*1 = Device is Peripherique*/
                [#else]
                    [#lt]#define P2P_SERVER5    0
                [/#if]
            [/#if]
        [/#list]
    [/#if]
[/#list]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="P2P_SERVER_NUMBER"]
                [#if definition.value="P2P_SERVER6"]
                    [#lt]#define P2P_SERVER6    1    /*1 = Device is Peripherique*/
                [#else]
                    [#lt]#define P2P_SERVER6    0
                [/#if]
            [/#if]
        [/#list]
    [/#if]
[/#list]


#define CFG_DEV_ID_P2P_SERVER1                  (0x83)
#define CFG_DEV_ID_P2P_SERVER2                  (0x84)
#define CFG_DEV_ID_P2P_SERVER3                  (0x87)
#define CFG_DEV_ID_P2P_SERVER4                  (0x88)
#define CFG_DEV_ID_P2P_SERVER5                  (0x89)
#define CFG_DEV_ID_P2P_SERVER6                  (0x8A)
#define CFG_DEV_ID_P2P_ROUTER                   (0x85)

[/#if]
[#if (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
#define  RADIO_ACTIVITY_EVENT   1          /* 1 for OOB Demo */

/**
* AD Element - Group B Feature
*/ 
/* LSB - First Byte */
#define CFG_FEATURE_THREAD_SWITCH               (0x40)

/* LSB - Second Byte */
#define CFG_FEATURE_OTA_REBOOT                  (0x20)

#define CONN_L(x) ((int)((x)/0.625f))
#define CONN_P(x) ((int)((x)/1.25f))

  /*  L2CAP Connection Update request parameters used for test only with smart Phone */
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="L2CAP_REQUEST_NEW_CONN_PARAM"]
                [#lt]#define ${definition.name}             ${definition.value}
            [/#if]
        [/#list]
    [/#if]
[/#list]

#define L2CAP_INTERVAL_MIN              CONN_P(1000) /* 1s */
#define L2CAP_INTERVAL_MAX              CONN_P(1000) /* 1s */
#define L2CAP_SLAVE_LATENCY             0x0000
#define L2CAP_TIMEOUT_MULTIPLIER        0x1F4

[/#if]
[#if (BLE = 1)]
/* USER CODE BEGIN Specific_Parameters */

/* USER CODE END Specific_Parameters */

[/#if]
[#if (CUSTOM_OTA = 1)]
/**
* AD Element - DEV ID
*/
#define CFG_DEV_ID_P2P_SERVER1                  (0x83)
#define CFG_DEV_ID_P2P_SERVER2                  (0x84)
#define CFG_DEV_ID_P2P_ROUTER                   (0x85)
#define CFG_DEV_ID_OTA_FW_UPDATE                (0x86)

/**
* AD Element - Group B Feature
*/
/* LSB - First Byte */
#define CFG_FEATURE_OTA_SW                      (0x08)

/**
 * Define the start address where the application shall be located
 */
#define CFG_APP_START_SECTOR_INDEX          (7)

[/#if]
[#if (CUSTOM_P2P_ROUTER = 1)]
#define CFG_MAX_CONNECTION                8
#define UUID_128BIT_FORMAT                1    

#define CFG_DEV_ID_P2P_SERVER1                  (0x83)
#define CFG_DEV_ID_P2P_SERVER2                  (0x84)
#define CFG_DEV_ID_P2P_SERVER3                  (0x87)
#define CFG_DEV_ID_P2P_SERVER4                  (0x88)
#define CFG_DEV_ID_P2P_SERVER5                  (0x89)   
#define CFG_DEV_ID_P2P_SERVER6                  (0x8A)   
#define CFG_DEV_ID_P2P_ROUTER                   (0x85)

#define CFG_P2P_DEMO_MULTI                      1


#define CONN_L(x) ((int)((x)/0.625f))
#define CONN_P(x) ((int)((x)/1.25f))
#define SCAN_P (0x320)
#define SCAN_L (0x320)
#define CONN_P1		(CONN_P(200)) 
#define CONN_P2		(CONN_P(1000)) 
#define SUPERV_TIMEOUT (400)
#define CONN_L1   (CONN_L(10))
#define CONN_L2   (CONN_L(10))
[/#if]
[#if (BLE_TRANSPARENT_MODE_UART = 1) || (BLE_TRANSPARENT_MODE_VCP = 1)]
/******************************************************************************
 * Information Table
 *
  * Version
  * [0:3]   = Build - 0: Untracked - 15:Released - x: Tracked version
  * [4:7]   = branch - 0: Mass Market - x: ...
  * [8:15]  = Subversion
  * [16:23] = Version minor
  * [24:31] = Version major
  *
 ******************************************************************************/
#define CFG_FW_MAJOR_VERSION      (0)
#define CFG_FW_MINOR_VERSION      (0)
#define CFG_FW_SUBVERSION         (1)
#define CFG_FW_BRANCH             (0)
#define CFG_FW_BUILD              (0)

[/#if]
[#if (BT_SIG_BEACON != "0") || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1)|| (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)|| (BT_SIG_HEART_RATE_SENSOR = 1)|| (CUSTOM_OTA = 1)|| (CUSTOM_P2P_SERVER = 1)|| (CUSTOM_P2P_CLIENT = 1)|| (CUSTOM_P2P_ROUTER = 1)|| ( BLE_TRANSPARENT_MODE_UART = 1 )|| ( BLE_TRANSPARENT_MODE_VCP = 1)|| (CUSTOM_TEMPLATE = 1)]

/******************************************************************************
 * BLE Stack
 ******************************************************************************/
/**
 * Maximum number of simultaneous connections that the device will support.
 * Valid values are from 1 to 8
 */
[#if (BT_SIG_BEACON != "0") || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1)|| (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)|| (BT_SIG_HEART_RATE_SENSOR = 1)|| (CUSTOM_OTA = 1)|| (CUSTOM_P2P_SERVER = 1)|| (CUSTOM_P2P_CLIENT = 1)|| (CUSTOM_P2P_ROUTER = 1)|| ( BLE_TRANSPARENT_MODE_UART = 1 )|| ( BLE_TRANSPARENT_MODE_VCP = 1)|| (CUSTOM_TEMPLATE = 1)]
#define CFG_BLE_NUM_LINK            ${CFG_BLE_NUM_LINK}
[/#if]

/**
 * Maximum number of Services that can be stored in the GATT database.
 * Note that the GAP and GATT services are automatically added so this parameter should be 2 plus the number of user services
 */
#define CFG_BLE_NUM_GATT_SERVICES   ${CFG_BLE_NUM_GATT_SERVICES}

/**
 * Maximum number of Attributes
 * (i.e. the number of characteristic + the number of characteristic values + the number of descriptors, excluding the services)
 * that can be stored in the GATT database.
 * Note that certain characteristics and relative descriptors are added automatically during device initialization
 * so this parameters should be 9 plus the number of user Attributes
 */
#define CFG_BLE_NUM_GATT_ATTRIBUTES ${CFG_BLE_NUM_GATT_ATTRIBUTES}

/**
 * Maximum supported ATT_MTU size
 * This parameter is ignored by the CPU2 when CFG_BLE_OPTIONS is set to 1"
 */
#define CFG_BLE_MAX_ATT_MTU             (${CFG_BLE_MAX_ATT_MTU})

/**
 * Size of the storage area for Attribute values
 *  This value depends on the number of attributes used by application. In particular the sum of the following quantities (in octets) should be made for each attribute:
 *  - attribute value length
 *  - 5, if UUID is 16 bit; 19, if UUID is 128 bit
 *  - 2, if server configuration descriptor is used
 *  - 2*DTM_NUM_LINK, if client configuration descriptor is used
 *  - 2, if extended properties is used
 *  The total amount of memory needed is the sum of the above quantities for each attribute.
 * This parameter is ignored by the CPU2 when CFG_BLE_OPTIONS is set to 1"
 */
#define CFG_BLE_ATT_VALUE_ARRAY_SIZE    (${CFG_BLE_ATT_VALUE_ARRAY_SIZE})

[#if (BT_SIG_BEACON != "0") || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1)|| (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)|| (BT_SIG_HEART_RATE_SENSOR = 1)|| (CUSTOM_OTA = 1)|| (CUSTOM_P2P_SERVER = 1)|| (CUSTOM_P2P_CLIENT = 1)|| (CUSTOM_P2P_ROUTER = 1)|| ( BLE_TRANSPARENT_MODE_UART = 1 )|| ( BLE_TRANSPARENT_MODE_VCP = 1)|| (CUSTOM_TEMPLATE = 1)]
/**
 * Prepare Write List size in terms of number of packet
 * This parameter is ignored by the CPU2 when CFG_BLE_OPTIONS is set to 1"
 */
#define CFG_BLE_PREPARE_WRITE_LIST_SIZE         BLE_PREP_WRITE_X_ATT(CFG_BLE_MAX_ATT_MTU)

/**
 * Number of allocated memory blocks
 * This parameter is overwritten by the CPU2 with an hardcoded optimal value when the parameter when CFG_BLE_OPTIONS is set to 1
 */
#define CFG_BLE_MBLOCK_COUNT            (BLE_MBLOCKS_CALC(CFG_BLE_PREPARE_WRITE_LIST_SIZE, CFG_BLE_MAX_ATT_MTU, CFG_BLE_NUM_LINK))
[/#if]

/**
 * Enable or disable the Extended Packet length feature. Valid values are 0 or 1.
 */
#define CFG_BLE_DATA_LENGTH_EXTENSION   ${CFG_BLE_DATA_LENGTH_EXTENSION}

/**
 * Sleep clock accuracy in Slave mode (ppm value)
 */
#define CFG_BLE_SLAVE_SCA   ${CFG_BLE_SLAVE_SCA}

/**
 * Sleep clock accuracy in Master mode
 * 0 : 251 ppm to 500 ppm
 * 1 : 151 ppm to 250 ppm
 * 2 : 101 ppm to 150 ppm
 * 3 : 76 ppm to 100 ppm
 * 4 : 51 ppm to 75 ppm
 * 5 : 31 ppm to 50 ppm
 * 6 : 21 ppm to 30 ppm
 * 7 : 0 ppm to 20 ppm
 */
#define CFG_BLE_MASTER_SCA   ${CFG_BLE_MASTER_SCA}

/**
 *  Source for the low speed clock for RF wake-up
 *  1 : external high speed crystal HSE/32/32
 *  0 : external low speed crystal ( no calibration )
 */
#define CFG_BLE_LSE_SOURCE  ${CFG_BLE_LSE_SOURCE}

/**
 * Start up time of the high speed (16 or 32 MHz) crystal oscillator in units of 625/256 us (~2.44 us)
 */
#define CFG_BLE_HSE_STARTUP_TIME  ${CFG_BLE_HSE_STARTUP_TIME}

/**
 * Maximum duration of the connection event when the device is in Slave mode in units of 625/256 us (~2.44 us)
 */
#define CFG_BLE_MAX_CONN_EVENT_LENGTH  (${CFG_BLE_MAX_CONN_EVENT_LENGTH})

/**
 * Viterbi Mode
 * 1 : enabled
 * 0 : disabled
 */
#define CFG_BLE_VITERBI_MODE  ${CFG_BLE_VITERBI_MODE}

/**
 * BLE stack Options flags to be configured with:
 * - SHCI_C2_BLE_INIT_OPTIONS_LL_ONLY
 * - SHCI_C2_BLE_INIT_OPTIONS_LL_HOST
 * - SHCI_C2_BLE_INIT_OPTIONS_NO_SVC_CHANGE_DESC
 * - SHCI_C2_BLE_INIT_OPTIONS_WITH_SVC_CHANGE_DESC
 * - SHCI_C2_BLE_INIT_OPTIONS_DEVICE_NAME_RO
 * - SHCI_C2_BLE_INIT_OPTIONS_DEVICE_NAME_RW
 * - SHCI_C2_BLE_INIT_OPTIONS_EXT_ADV
 * - SHCI_C2_BLE_INIT_OPTIONS_NO_EXT_ADV
 * - SHCI_C2_BLE_INIT_OPTIONS_CS_ALGO2
 * - SHCI_C2_BLE_INIT_OPTIONS_NO_CS_ALGO2
 * - SHCI_C2_BLE_INIT_OPTIONS_POWER_CLASS_1
 * - SHCI_C2_BLE_INIT_OPTIONS_POWER_CLASS_2_3
 * which are used to set following configuration bits:
 * (bit 0): 1: LL only
 *          0: LL + host
 * (bit 1): 1: no service change desc.
 *          0: with service change desc.
 * (bit 2): 1: device name Read-Only
 *          0: device name R/W
 * (bit 3): 1: extended advertizing supported       [NOT SUPPORTED]
 *          0: extended advertizing not supported   [NOT SUPPORTED]
 * (bit 4): 1: CS Algo #2 supported
 *          0: CS Algo #2 not supported
 * (bit 7): 1: LE Power Class 1
 *          0: LE Power Class 2-3
 * other bits: reserved (shall be set to 0)
 */
#define CFG_BLE_OPTIONS  (SHCI_C2_BLE_INIT_OPTIONS_LL_HOST | SHCI_C2_BLE_INIT_OPTIONS_WITH_SVC_CHANGE_DESC | SHCI_C2_BLE_INIT_OPTIONS_DEVICE_NAME_RW | SHCI_C2_BLE_INIT_OPTIONS_NO_EXT_ADV | SHCI_C2_BLE_INIT_OPTIONS_NO_CS_ALGO2 | SHCI_C2_BLE_INIT_OPTIONS_POWER_CLASS_2_3)

#define CFG_BLE_MAX_COC_INITIATOR_NBR   (${CFG_BLE_MAX_COC_INITIATOR_NBR})

#define CFG_BLE_MIN_TX_POWER            (${CFG_BLE_MIN_TX_POWER})

#define CFG_BLE_MAX_TX_POWER            (${CFG_BLE_MAX_TX_POWER})

/**
 * BLE Rx model configuration flags to be configured with:
 * - SHCI_C2_BLE_INIT_RX_MODEL_AGC_RSSI_LEGACY
 * - SHCI_C2_BLE_INIT_RX_MODEL_AGC_RSSI_BLOCKER 
 * which are used to set following configuration bits:
 * (bit 0): 1: agc_rssi model improved vs RF blockers
 *          0: Legacy agc_rssi model
 * other bits: reserved (shall be set to 0)
 */

#define CFG_BLE_RX_MODEL_CONFIG         SHCI_C2_BLE_INIT_RX_MODEL_AGC_RSSI_LEGACY

[/#if]
[/#if]
/******************************************************************************
 * Transport Layer
 ******************************************************************************/
/**
 * Queue length of BLE Event
 * This parameter defines the number of asynchronous events that can be stored in the HCI layer before
 * being reported to the application. When a command is sent to the BLE core coprocessor, the HCI layer
 * is waiting for the event with the Num_HCI_Command_Packets set to 1. The receive queue shall be large
 * enough to store all asynchronous events received in between.
 * When CFG_TLBLE_MOST_EVENT_PAYLOAD_SIZE is set to 27, this allow to store three 255 bytes long asynchronous events
 * between the HCI command and its event.
 * This parameter depends on the value given to CFG_TLBLE_MOST_EVENT_PAYLOAD_SIZE. When the queue size is to small,
 * the system may hang if the queue is full with asynchronous events and the HCI layer is still waiting
 * for a CC/CS event, In that case, the notification TL_BLE_HCI_ToNot() is called to indicate
 * to the application a HCI command did not receive its command event within 30s (Default HCI Timeout).
 */
[#if (BLE = 1)]
#define CFG_TLBLE_EVT_QUEUE_LENGTH ${CFG_TLBLE_EVT_QUEUE_LENGTH}
[#else]
#define CFG_TL_EVT_QUEUE_LENGTH 5
[/#if]
/**
 * This parameter should be set to fit most events received by the HCI layer. It defines the buffer size of each element
 * allocated in the queue of received events and can be used to optimize the amount of RAM allocated by the Memory Manager.
 * It should not exceed 255 which is the maximum HCI packet payload size (a greater value is a lost of memory as it will
 * never be used)
 * It shall be at least 4 to receive the command status event in one frame.
 * The default value is set to 27 to allow receiving an event of MTU size in a single buffer. This value maybe reduced
 * further depending on the application.
 */
[#if (BLE = 1)]
#define CFG_TLBLE_MOST_EVENT_PAYLOAD_SIZE ${CFG_TLBLE_MOST_EVENT_PAYLOAD_SIZE}   /**< Set to 255 with the memory manager and the mailbox */

#define TL_BLE_EVENT_FRAME_SIZE ( TL_EVT_HDR_SIZE + CFG_TLBLE_MOST_EVENT_PAYLOAD_SIZE )
[#else]
#define CFG_TL_MOST_EVENT_PAYLOAD_SIZE 255   /**< Set to 255 with the memory manager and the mailbox */

#define TL_EVENT_FRAME_SIZE ( TL_EVT_HDR_SIZE + CFG_TL_MOST_EVENT_PAYLOAD_SIZE )
[/#if]
/******************************************************************************
 * UART interfaces
 ******************************************************************************/

/**
 * Select UART interfaces
 */
[#if (BLE_TRANSPARENT_MODE_UART = 1) ||(BLE_TRANSPARENT_MODE_VCP = 1) ]
    [#lt]#define CFG_UART_GUI          ${CFG_UART_GUI}
[/#if]
	[#lt]#define CFG_DEBUG_TRACE_UART    ${CFG_DEBUG_TRACE_UART}
[#if (BLE_TRANSPARENT_MODE_UART = 0) && (BLE_TRANSPARENT_MODE_VCP = 0)]
    [#lt]#define CFG_CONSOLE_MENU      ${CFG_CONSOLE_MENU}
[/#if]
[#if (THREAD = 1 || ZIGBEE = 1)]
    [#lt]#define CFG_CLI_UART    ${CFG_CLI_UART}
[/#if]
/******************************************************************************
 * USB interface
 ******************************************************************************/

/**
 * Enable/Disable USB interface
 */
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="CFG_USB_INTERFACE_ENABLE"]
                [#lt]#define ${definition.name}    ${CFG_USB_INTERFACE_ENABLE_VALUE}
            [/#if]
        [/#list]
    [/#if]
[/#list]

/******************************************************************************
 * IPCC interface
 ******************************************************************************/

/**
 * The IPCC is dedicated to the communication between the CPU2 and the CPU1
 * and shall not be modified by the application
 * The two following definitions shall not be modified
 */
#define HAL_IPCC_TX_IRQHandler(...)  HW_IPCC_Tx_Handler( )
#define HAL_IPCC_RX_IRQHandler(...)  HW_IPCC_Rx_Handler( )

 [#if THREAD = 1 || ZIGBEE = 1]
/******************************************************************************
 * Low Power
 *
 *  When CFG_FULL_LOW_POWER is set to 1, the system is configured in full
 *  low power mode. It means that all what can have an impact on the consumptions
 *  are powered down.(For instance LED, Access to Debugger, Etc.)
 *
 *  When CFG_FULL_LOW_POWER is set to 0, the low power mode is not activated
 *
 ******************************************************************************/

 [#else]
/******************************************************************************
 * Low Power
 ******************************************************************************/
/**
 *  When set to 1, the low power mode is enable
 *  When set to 0, the device stays in RUN mode
 */
[/#if]
[#if THREAD = 1 || ZIGBEE = 1]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="CFG_FULL_LOW_POWER"]
                [#lt]#define ${definition.name}    ${definition.value}

            [/#if]
        [/#list]
    [/#if]
[/#list]
#if (CFG_FULL_LOW_POWER == 1)
#undef CFG_LPM_SUPPORTED
#define CFG_LPM_SUPPORTED   1
#endif /* CFG_FULL_LOW_POWER */
[#else]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="CFG_LPM_SUPPORTED"]
                [#lt]#define ${definition.name}    ${definition.value}

            [/#if]
        [/#list]
    [/#if]
[/#list]
[/#if]
[#if DIE == "DIE494"]
 /**
 * This shall be set to 1 when standby is supported while the wireless stack on CPU2 is running
 * (i.e the CPU2 is allowed to enter standby between RF activity)
 * Otherwise, it should be set to 0 for marginal code and test execution saving
 * In this case the lowest power mode available will be Stop 1
 * Note that keeping that setting to 1 when standby is not supported does not hurt
 */
#define CFG_LPM_STANDBY_SUPPORTED    ${CFG_LPM_STANDBY_SUPPORTED}

[/#if]
/******************************************************************************
 * RTC interface
 ******************************************************************************/
#define HAL_RTCEx_WakeUpTimerIRQHandler(...)  HW_TS_RTC_Wakeup_Handler( )

/******************************************************************************
 * Timer Server
 ******************************************************************************/
/**
 *  CFG_RTC_WUCKSEL_DIVIDER:  This sets the RTCCLK divider to the wakeup timer.
 *  The lower is the value, the better is the power consumption and the accuracy of the timerserver
 *  The higher is the value, the finest is the granularity
 *
 *  CFG_RTC_ASYNCH_PRESCALER: This sets the asynchronous prescaler of the RTC. It should as high as possible ( to output
 *  clock as low as possible) but the output clock should be equal or higher frequency compare to the clock feeding
 *  the wakeup timer. A lower clock speed would impact the accuracy of the timer server.
 *
 *  CFG_RTC_SYNCH_PRESCALER: This sets the synchronous prescaler of the RTC.
 *  When the 1Hz calendar clock is required, it shall be sets according to other settings
 *  When the 1Hz calendar clock is not needed, CFG_RTC_SYNCH_PRESCALER should be set to 0x7FFF (MAX VALUE)
 *
 *  CFG_RTCCLK_DIVIDER_CONF:
 *  Shall be set to either 0,2,4,8,16
 *  When set to either 2,4,8,16, the 1Hhz calendar is supported
 *  When set to 0, the user sets its own configuration
 *
 *  The following settings are computed with LSI as input to the RTC
 */

#define CFG_RTCCLK_DIVIDER_CONF ${CFG_RTCCLK_DIVIDER_CONF}

#if (CFG_RTCCLK_DIVIDER_CONF == 0)
/**
 * Custom configuration
 * It does not support 1Hz calendar
 * It divides the RTC CLK by 16
 */

[#if (CFG_RTCCLK_DIVIDER_CONF != "0")]
#define CFG_RTCCLK_DIV  (${CFG_RTCCLK_DIV})
[#if (CFG_RTCCLK_DIV == "16")]
#define CFG_RTC_WUCKSEL_DIVIDER (0)
[#elseif (CFG_RTCCLK_DIV == "8")]
#define CFG_RTC_WUCKSEL_DIVIDER (1)
[#elseif (CFG_RTCCLK_DIV == "4")]
#define CFG_RTC_WUCKSEL_DIVIDER (2)
[#elseif (CFG_RTCCLK_DIV == "2")]
#define CFG_RTC_WUCKSEL_DIVIDER (3)
[/#if]
#define CFG_RTC_ASYNCH_PRESCALER (${CFG_RTC_ASYNCH_PRESCALER})
#define CFG_RTC_SYNCH_PRESCALER (${CFG_RTC_SYNCH_PRESCALER})
[#else]
#define CFG_RTCCLK_DIV  (${CFG_RTCCLK_DIV})
#define CFG_RTC_WUCKSEL_DIVIDER (${CFG_RTC_WUCKSEL_DIVIDER})
#define CFG_RTC_ASYNCH_PRESCALER (${CFG_RTC_ASYNCH_PRESCALER})
#define CFG_RTC_SYNCH_PRESCALER (${CFG_RTC_SYNCH_PRESCALER})
[/#if]

#else

#if (CFG_RTCCLK_DIVIDER_CONF == 2)
/**
 * It divides the RTC CLK by 2
 */
#define CFG_RTC_WUCKSEL_DIVIDER (3)
#endif

#if (CFG_RTCCLK_DIVIDER_CONF == 4)
/**
 * It divides the RTC CLK by 4
 */
#define CFG_RTC_WUCKSEL_DIVIDER (2)
#endif

#if (CFG_RTCCLK_DIVIDER_CONF == 8)
/**
 * It divides the RTC CLK by 8
 */
#define CFG_RTC_WUCKSEL_DIVIDER (1)
#endif

#if (CFG_RTCCLK_DIVIDER_CONF == 16)
/**
 * It divides the RTC CLK by 16
 */
#define CFG_RTC_WUCKSEL_DIVIDER (0)
#endif

#define CFG_RTCCLK_DIV              CFG_RTCCLK_DIVIDER_CONF
#define CFG_RTC_ASYNCH_PRESCALER    (CFG_RTCCLK_DIV - 1)
#define CFG_RTC_SYNCH_PRESCALER     (DIVR( LSE_VALUE, (CFG_RTC_ASYNCH_PRESCALER+1) ) - 1 )

#endif

/** tick timer values */
#define CFG_TS_TICK_VAL           DIVR( (CFG_RTCCLK_DIV * 1000000), LSE_VALUE )
#define CFG_TS_TICK_VAL_PS        DIVR( ((uint64_t)CFG_RTCCLK_DIV * 1e12), (uint64_t)LSE_VALUE )

typedef enum
{
  CFG_TIM_PROC_ID_ISR,
  /* USER CODE BEGIN CFG_TimProcID_t */

  /* USER CODE END CFG_TimProcID_t */
} CFG_TimProcID_t;

/******************************************************************************
 * Debug
 ******************************************************************************/
/**
 * When set, this resets some hw resources to set the device in the same state than the power up
 * The FW resets only register that may prevent the FW to run properly
 *
 * This shall be set to 0 in a final product
 *
 */
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="CFG_HW_RESET_BY_FW"]
                [#lt]#define ${definition.name}         ${definition.value}
            [/#if]
        [/#list]
    [/#if]
[/#list]

[#if BLE = 1]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="CFG_LED_SUPPORTED"]
                [#lt]#define ${definition.name}         ${definition.value}
            [/#if]
        [/#list]
    [/#if]
[/#list]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="CFG_BUTTON_SUPPORTED"]
                [#lt]#define ${definition.name}      ${definition.value}
            [/#if]
        [/#list]
    [/#if]
[/#list]
[/#if]
/**
 * keep debugger enabled while in any low power mode when set to 1
 * should be set to 0 in production
 */
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="CFG_DEBUGGER_SUPPORTED"]
                [#lt]#define ${definition.name}    ${definition.value}
            [/#if]
        [/#list]
    [/#if]
[/#list]

[#if THREAD = 1 || ZIGBEE = 1]
#if (CFG_FULL_LOW_POWER == 1)
#undef CFG_DEBUGGER_SUPPORTED
#define CFG_DEBUGGER_SUPPORTED    0
#endif /* CFG_FULL_LOW_POWER */
[/#if]

[#if (BLE = 1)]
/**
 * When set to 1, the traces are enabled in the BLE services
 */
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="CFG_DEBUG_BLE_TRACE"]
                [#lt]#define ${definition.name}     ${definition.value}
            [/#if]
        [/#list]
    [/#if]
[/#list]

/**
 * Enable or Disable traces in application
 */
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="CFG_DEBUG_APP_TRACE"]
                [#lt]#define ${definition.name}     ${definition.value}
            [/#if]
        [/#list]
    [/#if]
[/#list]

#if (CFG_DEBUG_APP_TRACE != 0)
#define APP_DBG_MSG                 PRINT_MESG_DBG
#else
#define APP_DBG_MSG                 PRINT_NO_MESG
#endif


#if ( (CFG_DEBUG_BLE_TRACE != 0) || (CFG_DEBUG_APP_TRACE != 0) )
#define CFG_DEBUG_TRACE             1
#endif

#if (CFG_DEBUG_TRACE != 0)
#undef CFG_LPM_SUPPORTED
#undef CFG_DEBUGGER_SUPPORTED
#define CFG_LPM_SUPPORTED         0
#define CFG_DEBUGGER_SUPPORTED      1
#endif

[#else]
/*****************************************************************************
 * Traces
 * Enable or Disable traces in application
 * When CFG_DEBUG_TRACE is set, traces are activated
 *
 * Note : Refer to utilities_conf.h file in order to details
 *        the level of traces : CFG_DEBUG_TRACE_FULL or CFG_DEBUG_TRACE_LIGHT
 *****************************************************************************/
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="CFG_DEBUG_TRACE"]
                [#lt]#define ${definition.name}    ${definition.value}
            [/#if]
        [/#list]
    [/#if]
[/#list]

#if (CFG_FULL_LOW_POWER == 1)
#undef CFG_DEBUG_TRACE
#define CFG_DEBUG_TRACE      0
#endif /* CFG_FULL_LOW_POWER */
[/#if]

/**
 * When CFG_DEBUG_TRACE_FULL is set to 1, the trace are output with the API name, the file name and the line number
 * When CFG_DEBUG_TRACE_LIGHT is set to 1, only the debug message is output
 *
 * When both are set to 0, no trace are output
 * When both are set to 1,  CFG_DEBUG_TRACE_FULL is selected
 */
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="CFG_DEBUG_TRACE_LIGHT"]
                [#lt]#define ${definition.name}     ${definition.value}
            [/#if]
        [/#list]
    [/#if]
[/#list]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="CFG_DEBUG_TRACE_FULL"]
                [#lt]#define ${definition.name}      ${definition.value}
            [/#if]
        [/#list]
    [/#if]
[/#list]

#if (( CFG_DEBUG_TRACE != 0 ) && ( CFG_DEBUG_TRACE_LIGHT == 0 ) && (CFG_DEBUG_TRACE_FULL == 0))
#undef CFG_DEBUG_TRACE_FULL
#undef CFG_DEBUG_TRACE_LIGHT
#define CFG_DEBUG_TRACE_FULL      0
#define CFG_DEBUG_TRACE_LIGHT     1
#endif

#if ( CFG_DEBUG_TRACE == 0 )
#undef CFG_DEBUG_TRACE_FULL
#undef CFG_DEBUG_TRACE_LIGHT
#define CFG_DEBUG_TRACE_FULL      0
#define CFG_DEBUG_TRACE_LIGHT     0
#endif

/**
 * When not set, the traces is looping on sending the trace over UART
 */
#define DBG_TRACE_USE_CIRCULAR_QUEUE ${DBG_TRACE_USE_CIRCULAR_QUEUE}

/**
 * max buffer Size to queue data traces and max data trace allowed.
 * Only Used if DBG_TRACE_USE_CIRCULAR_QUEUE is defined
 */
#define DBG_TRACE_MSG_QUEUE_SIZE ${DBG_TRACE_MSG_QUEUE_SIZE}
#define MAX_DBG_TRACE_MSG_SIZE ${MAX_DBG_TRACE_MSG_SIZE}

[#if (THREAD = 1 || ZIGBEE = 1)]
/******************************************************************************
 * Configure Log level for Application
 ******************************************************************************/
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="APPLI_CONFIG_LOG_LEVEL"]
                [#lt]#define ${definition.name}    ${definition.value}
            [/#if]
        [/#list]
    [/#if]
[/#list]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name="APPLI_PRINT_FILE_FUNC_LINE"]
                [#lt]#define ${definition.name}    ${definition.value}
            [/#if]
        [/#list]
    [/#if]
[/#list][/#if]

/* USER CODE BEGIN Defines */

/* USER CODE END Defines */

[#if (FREERTOS_STATUS = 0)]
/******************************************************************************
 * Scheduler
 ******************************************************************************/
[#if (BLE = 1)]


/**
 * These are the lists of task id registered to the scheduler
 * Each task id shall be in the range [0:31]
 * This mechanism allows to implement a generic code in the API TL_BLE_HCI_StatusNot() to comply with
 * the requirement that a HCI/ACI command shall never be sent if there is already one pending
 */

/**< Add in that list all tasks that may send a ACI/HCI command */
typedef enum
{
[#if BT_SIG_BEACON != "0"]
    CFG_TASK_BEACON_UPDATE_REQ_ID,
[/#if]
[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1)]
    CFG_TASK_ADV_UPDATE_ID,
[/#if]
[#if BT_SIG_BLOOD_PRESSURE_SENSOR = 1]
    CFG_TASK_BLS_MEAS_REQ_ID,
    CFG_TASK_BLS_INT_CUFF_PRESSURE_REQ_ID,
[/#if]
[#if BT_SIG_HEALTH_THERMOMETER_SENSOR = 1]
    CFG_TASK_HTS_MEAS_REQ_ID,
    CFG_TASK_HTS_INTERMEDIATE_TEMPERATURE_REQ_ID,
    CFG_TASK_HTS_MEAS_INTERVAL_REQ_ID,
    CFG_TASK_HTS_DISCONNECTION_REQ_ID,
[/#if]
[#if BT_SIG_HEART_RATE_SENSOR = 1]
    CFG_TASK_MEAS_REQ_ID,
[/#if]
[#if (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
    CFG_TASK_ADV_CANCEL_ID,
#if (L2CAP_REQUEST_NEW_CONN_PARAM != 0 )
    CFG_TASK_CONN_UPDATE_REG_ID,
#endif
[/#if]
[#if CUSTOM_P2P_CLIENT = 1]
    CFG_TASK_START_SCAN_ID,
    CFG_TASK_CONN_DEV_1_ID,
    CFG_TASK_SEARCH_SERVICE_ID,
    CFG_TASK_CONN_UPDATE_ID,
[/#if]
[#if CUSTOM_P2P_ROUTER = 1]
    CFG_TASK_START_ADV_ID,
    CFG_TASK_START_SCAN_ID,
    CFG_TASK_CONN_DEV_1_ID,
    CFG_TASK_CONN_DEV_2_ID,
    CFG_TASK_CONN_DEV_3_ID,
    CFG_TASK_CONN_DEV_4_ID,
    CFG_TASK_CONN_DEV_5_ID,
    CFG_TASK_CONN_DEV_6_ID,
    CFG_TASK_SEARCH_SERVICE_ID,
[/#if]
[#if (BT_SIG_BEACON != "0") || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_OTA = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_P2P_ROUTER = 1) || (CUSTOM_P2P_CLIENT = 1) || (CUSTOM_TEMPLATE = 1)]
    CFG_TASK_HCI_ASYNCH_EVT_ID,
[/#if]
[#if (BLE_TRANSPARENT_MODE_UART = 1) || (BLE_TRANSPARENT_MODE_VCP = 1)]
    CFG_TASK_BLE_HCI_CMD_ID,
    CFG_TASK_SYS_HCI_CMD_ID,
    CFG_TASK_HCI_ACL_DATA_ID,
    CFG_TASK_SYS_LOCAL_CMD_ID,
    CFG_TASK_TX_TO_HOST_ID,
[/#if]
[#if (BT_SIG_BEACON != "0") || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_OTA = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_P2P_ROUTER = 1) || (CUSTOM_P2P_CLIENT = 1) || (BLE_TRANSPARENT_MODE_UART = 1) || (BLE_TRANSPARENT_MODE_VCP = 1) || (CUSTOM_TEMPLATE = 1)]
    /* USER CODE BEGIN CFG_Task_Id_With_HCI_Cmd_t */

    /* USER CODE END CFG_Task_Id_With_HCI_Cmd_t */
[#else]
[#-- BZ 112688, 109187 --]
    CFG_TASK_APP_WITH_HCICMD_1,
    CFG_TASK_APP_WITH_HCICMD_2,
    CFG_TASK_APP_WITH_HCICMD_3,
    CFG_TASK_APP_WITH_HCICMD_4,
    CFG_TASK_APP_WITH_HCICMD_5,
    /* USER CODE BEGIN CFG_Task_Id_With_HCI_Cmd_t */

    /* USER CODE END CFG_Task_Id_With_HCI_Cmd_t */
[/#if]
    CFG_LAST_TASK_ID_WITH_HCICMD,                                               /**< Shall be LAST in the list */
} CFG_Task_Id_With_HCI_Cmd_t;

/**< Add in that list all tasks that never send a ACI/HCI command */
typedef enum
{
    CFG_FIRST_TASK_ID_WITH_NO_HCICMD = CFG_LAST_TASK_ID_WITH_HCICMD - 1,        /**< Shall be FIRST in the list */
[#if (BLE_TRANSPARENT_MODE_VCP = 1)]
    CFG_TASK_VCP_SEND_DATA_ID,
[/#if]
    CFG_TASK_SYSTEM_HCI_ASYNCH_EVT_ID,
[#if (BT_SIG_BEACON != "0") || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_OTA = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_P2P_ROUTER = 1) || (CUSTOM_P2P_CLIENT = 1) || (BLE_TRANSPARENT_MODE_UART = 1) || (BLE_TRANSPARENT_MODE_VCP = 1) || (CUSTOM_TEMPLATE = 1)]
    /* USER CODE BEGIN CFG_Task_Id_With_NO_HCI_Cmd_t */

    /* USER CODE END CFG_Task_Id_With_NO_HCI_Cmd_t */
[#else]
    CFG_TASK_APP_WITH_NO_HCICMD_1,
    CFG_TASK_APP_WITH_NO_HCICMD_2,
    CFG_TASK_APP_WITH_NO_HCICMD_3,
    CFG_TASK_APP_WITH_NO_HCICMD_4,
    CFG_TASK_APP_WITH_NO_HCICMD_5,
    /* USER CODE BEGIN CFG_Task_Id_With_NO_HCI_Cmd_t */

    /* USER CODE END CFG_Task_Id_With_NO_HCI_Cmd_t */
[/#if]
    CFG_LAST_TASK_ID_WITHO_NO_HCICMD                                            /**< Shall be LAST in the list */
} CFG_Task_Id_With_NO_HCI_Cmd_t;

#define CFG_TASK_NBR    CFG_LAST_TASK_ID_WITHO_NO_HCICMD

/**
 * This is the list of priority required by the application
 * Each Id shall be in the range 0..31
 */
typedef enum
{
    CFG_SCH_PRIO_0,
[#if BLE_TRANSPARENT_MODE_VCP = 1]
    CFG_SCH_PRIO_1,
[/#if]
    CFG_PRIO_NBR,
} CFG_SCH_Prio_Id_t;

/**
 * This is a bit mapping over 32bits listing all events id supported in the application
 */
typedef enum
{
[#if (BLE_TRANSPARENT_MODE_VCP = 1) || (BLE_TRANSPARENT_MODE_UART = 1)]
[#else]
    CFG_IDLEEVT_HCI_CMD_EVT_RSP_ID,
[/#if]
    CFG_IDLEEVT_SYSTEM_HCI_CMD_EVT_RSP_ID,
} CFG_IdleEvt_Id_t;

[#else]
  /**
   * This is the list of task id required by the application
   * Each Id shall be in the range 0..31
   */

typedef enum
{
[#if THREAD = 1]
  CFG_TASK_MSG_FROM_M0_TO_M4,
  CFG_TASK_SEND_CLI_TO_M0,
[#elseif ZIGBEE = 1]
  CFG_TASK_NOTIFY_FROM_M0_TO_M4,
  CFG_TASK_REQUEST_FROM_M0_TO_M4,
  CFG_TASK_ZIGBEE_NETWORK_FORM,
[/#if]
  CFG_TASK_SYSTEM_HCI_ASYNCH_EVT,
#if (CFG_USB_INTERFACE_ENABLE != 0)
  CFG_TASK_VCP_SEND_DATA,
#endif /* (CFG_USB_INTERFACE_ENABLE != 0) */
  /* USER CODE BEGIN CFG_IdleTask_Id_t */

  /* USER CODE END CFG_IdleTask_Id_t */
  CFG_TASK_NBR  /**< Shall be last in the list */
} CFG_IdleTask_Id_t;

/* Scheduler types and defines        */
/*------------------------------------*/
[#if THREAD = 1]
#define TASK_MSG_FROM_M0_TO_M4      (1U << CFG_TASK_MSG_FROM_M0_TO_M4)
[#elseif ZIGBEE = 1]
#define EVENT_ACK_FROM_M0_EVT        (1U << CFG_EVT_ACK_FROM_M0_EVT)
#define EVENT_SYNCHRO_BYPASS_IDLE    (1U << CFG_EVT_SYNCHRO_BYPASS_IDLE)
[/#if]
/* USER CODE BEGIN DEFINE_TASK */

/* USER CODE END DEFINE_TASK */
 
/**
 * This is the list of priority required by the application
 * Each Id shall be in the range 0..31
 */
typedef enum
{
    CFG_SCH_PRIO_0,
    CFG_SCH_PRIO_1,
    CFG_PRIO_NBR,
} CFG_SCH_Prio_Id_t;

  /**
   * This is a bit mapping over 32bits listing all events id supported in the application
   */
typedef enum
{
  CFG_EVT_SYSTEM_HCI_CMD_EVT_RESP,
  CFG_EVT_ACK_FROM_M0_EVT,
  CFG_EVT_SYNCHRO_BYPASS_IDLE,
[#if ZIGBEE == 1]
  CFG_EVT_ZIGBEE_STARTUP_ENDED,
[/#if]
  /* USER CODE BEGIN CFG_IdleEvt_Id_t */

  /* USER CODE END CFG_IdleEvt_Id_t */
} CFG_IdleEvt_Id_t;

#define EVENT_ACK_FROM_M0_EVT           (1U << CFG_EVT_ACK_FROM_M0_EVT)
#define EVENT_SYNCHRO_BYPASS_IDLE       (1U << CFG_EVT_SYNCHRO_BYPASS_IDLE)
[#if ZIGBEE == 1]
#define EVENT_ZIGBEE_STARTUP_ENDED      (1U << CFG_EVT_ZIGBEE_STARTUP_ENDED)
[/#if]
/* USER CODE BEGIN DEFINE_EVENT */

/* USER CODE END DEFINE_EVENT */

[/#if]
[#else]
/******************************************************************************
 * FreeRTOS
 ******************************************************************************/
#define CFG_SHCI_USER_EVT_PROCESS_NAME        "SHCI_USER_EVT_PROCESS"
#define CFG_SHCI_USER_EVT_PROCESS_ATTR_BITS   (0)
#define CFG_SHCI_USER_EVT_PROCESS_CB_MEM      (0)
#define CFG_SHCI_USER_EVT_PROCESS_CB_SIZE     (0)
#define CFG_SHCI_USER_EVT_PROCESS_STACK_MEM   (0)
#define CFG_SHCI_USER_EVT_PROCESS_PRIORITY    osPriorityNone
#define CFG_SHCI_USER_EVT_PROCESS_STACK_SIZE  (128 * 20)

[#if (THREAD = 1)]
#define CFG_THREAD_MSG_M0_TO_M4_PROCESS_NAME        "THREAD_MSG_M0_TO_M4_PROCESS"
#define CFG_THREAD_MSG_M0_TO_M4_PROCESS_ATTR_BITS   (0)
#define CFG_THREAD_MSG_M0_TO_M4_PROCESS_CB_MEM      (0)
#define CFG_THREAD_MSG_M0_TO_M4_PROCESS_CB_SIZE     (0)
#define CFG_THREAD_MSG_M0_TO_M4_PROCESS_STACK_MEM   (0)
#define CFG_THREAD_MSG_M0_TO_M4_PROCESS_PRIORITY    osPriorityLow
#define CFG_THREAD_MSG_M0_TO_M4_PROCESS_STACK_SIZE  (128 * 8)

#define CFG_THREAD_CLI_PROCESS_NAME        "THREAD_CLI_PROCESS"
#define CFG_THREAD_CLI_PROCESS_ATTR_BITS   (0)
#define CFG_THREAD_CLI_PROCESS_CB_MEM      (0)
#define CFG_THREAD_CLI_PROCESS_CB_SIZE     (0)
#define CFG_THREAD_CLI_PROCESS_STACK_MEM   (0)
#define CFG_THREAD_CLI_PROCESS_PRIORITY    osPriorityNormal
#define CFG_THREAD_CLI_PROCESS_STACK_SIZE  (128 * 8)

[/#if]
[#if (BLE = 1)]
#define CFG_HCI_USER_EVT_PROCESS_NAME         "HCI_USER_EVT_PROCESS"
#define CFG_HCI_USER_EVT_PROCESS_ATTR_BITS    (0)
#define CFG_HCI_USER_EVT_PROCESS_CB_MEM       (0)
#define CFG_HCI_USER_EVT_PROCESS_CB_SIZE      (0)
#define CFG_HCI_USER_EVT_PROCESS_STACK_MEM    (0)
#define CFG_HCI_USER_EVT_PROCESS_PRIORITY     osPriorityNone
#define CFG_HCI_USER_EVT_PROCESS_STACK_SIZE   (128 * 40)

#define CFG_ADV_UPDATE_PROCESS_NAME           "ADV_UPDATE_PROCESS"
#define CFG_ADV_UPDATE_PROCESS_ATTR_BITS      (0)
#define CFG_ADV_UPDATE_PROCESS_CB_MEM         (0)
#define CFG_ADV_UPDATE_PROCESS_CB_SIZE        (0)
#define CFG_ADV_UPDATE_PROCESS_STACK_MEM      (0)
#define CFG_ADV_UPDATE_PROCESS_PRIORITY       osPriorityNone
#define CFG_ADV_UPDATE_PROCESS_STACK_SIZE     (128 * 20)

#define CFG_HRS_PROCESS_NAME                  "HRS_PROCESS"
#define CFG_HRS_PROCESS_ATTR_BITS             (0)
#define CFG_HRS_PROCESS_CB_MEM                (0)
#define CFG_HRS_PROCESS_CB_SIZE               (0)
#define CFG_HRS_PROCESS_STACK_MEM             (0)
#define CFG_HRS_PROCESS_PRIORITY              osPriorityNone
#define CFG_HRS_PROCESS_STACK_SIZE            (128 * 20)

[/#if]
/* USER CODE BEGIN FreeRTOS_Defines */

/* USER CODE END FreeRTOS_Defines */
[/#if]

/******************************************************************************
 * LOW POWER
 ******************************************************************************/
/**
 * Supported requester to the MCU Low Power Manager - can be increased up  to 32
 * It list a bit mapping of all user of the Low Power Manager
 */
typedef enum
{
    CFG_LPM_APP,
[#if (BLE = 1)]
    CFG_LPM_APP_BLE,
[/#if]
[#if (THREAD = 1)]
    CFG_LPM_APP_THREAD,
[/#if]
    /* USER CODE BEGIN CFG_LPM_Id_t */

    /* USER CODE END CFG_LPM_Id_t */
} CFG_LPM_Id_t;


/******************************************************************************
 * OTP manager
 ******************************************************************************/
#define CFG_OTP_BASE_ADDRESS    OTP_AREA_BASE

#define CFG_OTP_END_ADRESS      OTP_AREA_END_ADDR

#endif /*APP_CONF_H */

