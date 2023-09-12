[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_conf.h
  * @author  MCD Application Team
  * @brief   Application configuration file for STM32WPAN Middleware.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign BLE_TRANSPARENT_MODE_UART = 0]
[#assign CUSTOM_P2P_CLIENT = 0]
[#assign CUSTOM_P2P_ROUTER = 0]
[#assign CUSTOM_TEMPLATE = 0]
[#assign FREERTOS_STATUS = 0]
[#assign THREAD = 0]
[#assign THREAD_SKELETON = 0]
[#assign BLE = 0]
[#assign BLE_SKELETON = 0]
[#assign ZIGBEE = 0]
[#assign ZIGBEE_SKELETON = 0]
[#assign CFG_TX_POWER = 0]
[#assign CFG_ADV_BD_ADDRESS = 0]
[#assign CFG_BLE_ADDRESS_TYPE = "GAP_PUBLIC_ADDR"]
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
[#assign CFG_BLE_IRK_HEX = "0"]
[#assign CFG_BLE_ERK_HEX = "0"]
[#assign CFG_BLE_NUM_LINK = 2]
[#assign CFG_BLE_NUM_GATT_SERVICES = 8]
[#assign CFG_BLE_NUM_GATT_ATTRIBUTES = 68]
[#assign CFG_BLE_MAX_ATT_MTU = 156]
[#assign CFG_BLE_ATT_VALUE_ARRAY_SIZE = 1344]
[#assign CFG_BLE_ATTR_PREPARE_WRITE_VALUE_SIZE = 32]
[#assign CFG_BLE_MBLOCK_COUNT_MARGIN = "0x15"]
[#assign CFG_BLE_MAX_COC_NUMBER = 64]
[#assign CFG_BLE_MAX_COC_INITIATOR_NBR = 32]
[#assign CFG_BLE_OPTIONS_LL = "SHCI_C2_BLE_INIT_OPTIONS_LL_HOST"]
[#assign CFG_BLE_OPTIONS_SVC = "SHCI_C2_BLE_INIT_OPTIONS_WITH_SVC_CHANGE_DESC"]
[#assign CFG_BLE_OPTIONS_DEVICE_NAME = "SHCI_C2_BLE_INIT_OPTIONS_DEVICE_NAME_RW"]
[#assign CFG_BLE_OPTIONS_EXT_ADV = "SHCI_C2_BLE_INIT_OPTIONS_NO_EXT_ADV"]
[#assign CFG_BLE_OPTIONS_CS_ALGO = "SHCI_C2_BLE_INIT_OPTIONS_NO_CS_ALGO2"]
[#assign CFG_BLE_OPTIONS_POWER_CLASS = "SHCI_C2_BLE_INIT_OPTIONS_POWER_CLASS_2_3"]
[#assign CFG_BLE_MIN_TX_POWER = 0]
[#assign CFG_BLE_MAX_TX_POWER = 0]
[#assign CFG_BLE_MAX_DDB_ENTRIES = 20]
[#assign CFG_FULL_LOW_POWER = 0]
[#assign CFG_LPM_SUPPORTED = 0]
[#assign CFG_LPM_STDBY_SUPPORTED = 0]
[#assign ADV_TRACE_TIMESTAMP_ENABLE = 0]
[#assign CFG_DEBUG_APP_TRACE = 0]
[#assign CFG_DEBUG_TRACE_LIGHT = 0]
[#assign CFG_DEBUG_TRACE_FULL = 0]
[#assign DBG_TRACE_USE_CIRCULAR_QUEUE = 1]
[#assign DBG_TRACE_MSG_QUEUE_SIZE = 4096]
[#assign MAX_DBG_TRACE_MSG_SIZE = 1024]
[#assign SYS_MAX_MSG = 200]
[#assign INITIAL_ADV_TIMEOUT = 60]
[#assign APPLI_CONFIG_LOG_LEVEL = 0]
[#assign APPLI_PRINT_FILE_FUNC_LINE = 0]
[#assign CFG_NVM_ALIGN = 0]
[#assign USE_RADIO_LOW_ISR = 1]
[#assign NEXT_EVENT_SCHEDULING_FROM_ISR = 1]
[#assign RADIO_INTR_PRIO_HIGH = 1]
[#assign RADIO_INTR_PRIO_LOW = 1]
[#assign RADIO_SW_LOW_INTR_NUM = ""]
[#assign RADIO_SW_LOW_INTR_PRIO = 15]
[#assign CFG_HW_RNG_POOL_SIZE = 32]
[#assign CFG_MM_POOL_SIZE = 2000]
[#assign CFG_STATIC_RANDOM_ADDRESS = 0]
[#assign STATIC_RANDOM_ADDRESS = 0]
[#assign ADV_TYPE = "ADV_IND"]
[#assign ADV_FILTER = "NO_WHITE_LIST_USE"]
[#assign CFG_GAP_DEVICE_NAME = ""]
[#assign CFG_GAP_DEVICE_NAME_LENGTH = 0]

[#assign CFG_RTCCLK_DIV = 16]
[#assign CFG_RTC_WUCKSEL_DIVIDER = 0]
[#assign CFG_RTC_ASYNCH_PRESCALER = "0x0F"]
[#assign CFG_RTC_SYNCH_PRESCALER = "0x7FFF"]
[#assign L2CAP_REQUEST_NEW_CONN_PARAM = 0]

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
            [#if (definition.name == "CUSTOM_P2P_CLIENT") && (definition.value == "Enabled")]
                [#assign CUSTOM_P2P_CLIENT = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_P2P_ROUTER") && (definition.value =="Enabled")]
                [#assign CUSTOM_P2P_ROUTER = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_TEMPLATE") && (definition.value == "Enabled")]
                [#assign CUSTOM_TEMPLATE = 1]
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
            [#if (definition.name == "BLE_SKELETON") && (definition.value == "Enabled")]
                [#assign BLE_SKELETON = 1]
            [/#if]
            [#if (definition.name == "THREAD_SKELETON") && (definition.value == "Enabled")]
                [#assign THREAD_SKELETON = 1]
            [/#if]
            [#if (definition.name == "ZIGBEE_SKELETON") && (definition.value == "Enabled")]
                [#assign ZIGBEE_SKELETON = 1]
            [/#if]
            [#if definition.name == "BLE_APPLICATION_TYPE"]
                [#assign BLE_APPLICATION_TYPE = definition.value]
            [/#if]
            [#if definition.name == "THREAD_APPLICATION"]
                [#assign THREAD_APPLICATION = definition.value]
            [/#if]
            [#if definition.name == "ADV_TRACE_TIMESTAMP_ENABLE"]
                [#assign ADV_TRACE_TIMESTAMP_ENABLE = definition.value]
            [/#if]
            [#if (definition.name == "CFG_FULL_LOW_POWER")]
                [#assign CFG_FULL_LOW_POWER = definition.value]
            [/#if]
            [#if (definition.name == "CFG_LPM_SUPPORTED")]
                [#assign CFG_LPM_SUPPORTED = definition.value]
            [/#if]
            [#if (definition.name == "CFG_LPM_STDBY_SUPPORTED")]
                [#assign CFG_LPM_STDBY_SUPPORTED = definition.value]
            [/#if]
            [#if (definition.name == "CFG_DEBUG_APP_TRACE")]
                [#assign CFG_DEBUG_APP_TRACE = definition.value]
            [/#if]
            [#if (definition.name == "CFG_DEBUG_TRACE_LIGHT")]
                [#assign CFG_DEBUG_TRACE_LIGHT = definition.value]
            [/#if]
            [#if (definition.name == "CFG_DEBUG_TRACE_FULL")]
                [#assign CFG_DEBUG_TRACE_FULL = definition.value]
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
            [#if (definition.name == "CFG_BLE_ADDRESS_TYPE")]
                [#assign CFG_BLE_ADDRESS_TYPE = definition.value]
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
            [#if (definition.name == "APPLI_CONFIG_LOG_LEVEL")]
                [#assign APPLI_CONFIG_LOG_LEVEL = definition.value]
            [/#if]
            [#if (definition.name == "APPLI_PRINT_FILE_FUNC_LINE")]
                [#assign APPLI_PRINT_FILE_FUNC_LINE = definition.value]
            [/#if]
            [#if (definition.name == "CFG_NVM_ALIGN")]
                [#assign CFG_NVM_ALIGN = definition.value]
            [/#if]
            [#if (definition.name == "USE_RADIO_LOW_ISR")]
                [#assign USE_RADIO_LOW_ISR = definition.value]
            [/#if]
            [#if (definition.name == "NEXT_EVENT_SCHEDULING_FROM_ISR")]
                [#assign NEXT_EVENT_SCHEDULING_FROM_ISR = definition.value]
            [/#if]
            [#if (definition.name == "RADIO_INTR_PRIO_HIGH")]
                [#assign RADIO_INTR_PRIO_HIGH = definition.value]
            [/#if]
            [#if (definition.name == "RADIO_INTR_PRIO_LOW")]
                [#assign RADIO_INTR_PRIO_LOW = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_IRK_HEX")]
                [#assign CFG_BLE_IRK_HEX = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_ERK_HEX")]
                [#assign CFG_BLE_ERK_HEX = definition.value]
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
            [#if (definition.name == "CFG_BLE_ATTR_PREPARE_WRITE_VALUE_SIZE")]
                [#assign CFG_BLE_ATTR_PREPARE_WRITE_VALUE_SIZE = definition.value]
            [/#if]

            [#if (definition.name == "CFG_BLE_MBLOCK_COUNT_MARGIN")]
                [#assign CFG_BLE_MBLOCK_COUNT_MARGIN = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_MAX_COC_NUMBER")]
                [#assign CFG_BLE_MAX_COC_NUMBER = definition.value]
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
            [#if (definition.name == "CFG_BLE_OPTIONS_EXT_ADV")]
                [#assign CFG_BLE_OPTIONS_EXT_ADV = definition.value]
            [/#if]
            [#if (definition.name == "CFG_BLE_OPTIONS_CS_ALGO")]
                [#assign CFG_BLE_OPTIONS_CS_ALGO = definition.value]
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
            [#if (definition.name == "CFG_BLE_MAX_DDB_ENTRIES")]
                [#assign CFG_BLE_MAX_DDB_ENTRIES = definition.value]
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
            [#if (definition.name == "SYS_MAX_MSG")]
                [#assign SYS_MAX_MSG = definition.value]
            [/#if]
            [#if (definition.name == "INITIAL_ADV_TIMEOUT")]
                [#assign INITIAL_ADV_TIMEOUT = definition.value]
            [/#if]
            [#if (definition.name == "CFG_LPM_STANDBY_SUPPORTED")]
                [#assign CFG_LPM_STANDBY_SUPPORTED = definition.value]
            [/#if]
            [#if (definition.name == "L2CAP_REQUEST_NEW_CONN_PARAM")]
                [#assign L2CAP_REQUEST_NEW_CONN_PARAM = definition.value]
            [/#if]
            [#if (definition.name == "RADIO_SW_LOW_INTR_NUM")]
                [#assign RADIO_SW_LOW_INTR_NUM = definition.value]
            [/#if]
            [#if (definition.name == "RADIO_SW_LOW_INTR_PRIO")]
                [#assign RADIO_SW_LOW_INTR_PRIO = definition.value]
            [/#if]
            [#if (definition.name == "CFG_HW_RNG_POOL_SIZE")]
                [#assign CFG_HW_RNG_POOL_SIZE = definition.value]
            [/#if]
            [#if (definition.name == "CFG_MM_POOL_SIZE")]
                [#assign CFG_MM_POOL_SIZE = definition.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef APP_CONF_H
#define APP_CONF_H

/* Includes ------------------------------------------------------------------*/
#include "hw_conf.h"
#include "hw_if.h"
#include "stm32_adv_trace.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/******************************************************************************
 * Application Config
 ******************************************************************************/
/**< generic parameters ******************************************************/

[#if (BLE = 1)]
[#if (CUSTOM_P2P_CLIENT = 1) || (CUSTOM_P2P_ROUTER = 1) || (CUSTOM_TEMPLATE = 1)]
/**
 * Define Tx Power
 */
#define CFG_TX_POWER                      ${CFG_TX_POWER}

/**
 * Define Advertising parameters
 */
#define CFG_ADV_BD_ADDRESS                (${CFG_ADV_BD_ADDRESS})
[/#if]
[#if (CUSTOM_P2P_ROUTER = 1) || (CUSTOM_TEMPLATE = 1)]
#define CFG_BLE_ADDRESS_TYPE              ${CFG_BLE_ADDRESS_TYPE} /**< Bluetooth address types defined in ble_defs.h */
[#if ((CFG_STATIC_RANDOM_ADDRESS = "1") && (CFG_BLE_ADDRESS_TYPE = "GAP_RANDOM_ADDR"))]
#define CFG_STATIC_RANDOM_ADDRESS         (${STATIC_RANDOM_ADDRESS}) /**< Static Random Address fixed for lifetime of the device */
[/#if]
[/#if]

[#if (CUSTOM_TEMPLATE = 1)]
#define CFG_FAST_CONN_ADV_INTERVAL_MIN    (${CFG_FAST_CONN_ADV_INTERVAL_MIN_HEXA})      /* 80ms */
#define CFG_FAST_CONN_ADV_INTERVAL_MAX    (${CFG_FAST_CONN_ADV_INTERVAL_MAX_HEXA})      /* 100ms */
#define CFG_LP_CONN_ADV_INTERVAL_MIN      (${CFG_LP_CONN_ADV_INTERVAL_MIN_HEXA})       /* 1s */
#define CFG_LP_CONN_ADV_INTERVAL_MAX      (${CFG_LP_CONN_ADV_INTERVAL_MAX_HEXA})       /* 2.5s */
[/#if]
[#if (CUSTOM_TEMPLATE = 1)]
#define ADV_TYPE                          ${ADV_TYPE}
#define ADV_FILTER                        ${ADV_FILTER}
[/#if]
[#if (CUSTOM_P2P_ROUTER = 1)]
#define LEDBUTTON_CONN_ADV_INTERVAL_MIN   (0x1FA)
#define LEDBUTTON_CONN_ADV_INTERVAL_MAX   (0x3E8)

[/#if]
[#if (CUSTOM_P2P_CLIENT = 1) || (CUSTOM_P2P_ROUTER = 1) || (CUSTOM_TEMPLATE = 1)]

/**
 * Define IO Authentication
 */
[#if (CUSTOM_P2P_CLIENT = 1) || (CUSTOM_P2P_ROUTER = 1)]
#define CFG_BONDING_MODE                 (1)
[#else]
#define CFG_BONDING_MODE                 (${CFG_BONDING_MODE})
[/#if]
#define CFG_FIXED_PIN                    (${CFG_FIXED_PIN})
[#if (CUSTOM_P2P_CLIENT = 1) || (CUSTOM_P2P_ROUTER = 1)]
#define CFG_USED_FIXED_PIN               (1)
[#else]
#define CFG_USED_FIXED_PIN               (${CFG_USED_FIXED_PIN})
[/#if]
#define CFG_ENCRYPTION_KEY_SIZE_MAX      (${CFG_ENCRYPTION_KEY_SIZE_MAX})
#define CFG_ENCRYPTION_KEY_SIZE_MIN      (${CFG_ENCRYPTION_KEY_SIZE_MIN})

/**
 * Define IO capabilities
 */
#define CFG_IO_CAPABILITY_DISPLAY_ONLY        (0x00)
#define CFG_IO_CAPABILITY_DISPLAY_YES_NO      (0x01)
#define CFG_IO_CAPABILITY_KEYBOARD_ONLY       (0x02)
#define CFG_IO_CAPABILITY_NO_INPUT_NO_OUTPUT  (0x03)
#define CFG_IO_CAPABILITY_KEYBOARD_DISPLAY    (0x04)

#define CFG_IO_CAPABILITY                     ${CFG_IO_CAPABILITY}

/**
 * Define MITM modes
 */
#define CFG_MITM_PROTECTION_NOT_REQUIRED      (0x00)
#define CFG_MITM_PROTECTION_REQUIRED          (0x01)

#define CFG_MITM_PROTECTION                   ${CFG_MITM_PROTECTION}

[/#if]
/**
 * Define Secure Connections Support
 */
#define CFG_SECURE_NOT_SUPPORTED              (0x00)
#define CFG_SECURE_OPTIONAL                   (0x01)
#define CFG_SECURE_MANDATORY                  (0x02)

#define CFG_SC_SUPPORT                        ${CFG_SC_SUPPORT}

/**
 * Define Keypress Notification Support
 */
#define CFG_KEYPRESS_NOT_SUPPORTED            (0x00)
#define CFG_KEYPRESS_SUPPORTED                (0x01)

#define CFG_KEYPRESS_NOTIFICATION_SUPPORT     ${CFG_KEYPRESS_NOTIFICATION_SUPPORT}

/**
 * Numeric Comparison Answers
 */
#define YES (0x01)
#define NO  (0x00)

[#if (CUSTOM_TEMPLATE = 1)]
/**
 * Define PHY
 */
#define ALL_PHYS_PREFERENCE                             (0x00)
#define RX_2M_PREFERRED                                 (0x02)
#define TX_2M_PREFERRED                                 (0x02)
#define TX_1M                                           (0x01)
#define TX_2M                                           (0x02)
#define RX_1M                                           (0x01)
#define RX_2M                                           (0x02)
[/#if]

[#if (CUSTOM_P2P_CLIENT = 1) || (CUSTOM_P2P_ROUTER = 1) || ( BLE_TRANSPARENT_MODE_UART = 1) || (CUSTOM_TEMPLATE = 1)]
/**
*   Identity root key used to derive LTK and CSRK
*/
#define CFG_BLE_IRK     {${CFG_BLE_IRK_HEX}}

/**
* Encryption root key used to derive LTK and CSRK
*/
#define CFG_BLE_ERK     {${CFG_BLE_ERK_HEX}}

[/#if]
[/#if]
/* USER CODE BEGIN Generic_Parameters */

/* USER CODE END Generic_Parameters */

/**< specific parameters */
/*****************************************************/

[#if (BLE = 1)]
[#if (CUSTOM_P2P_CLIENT = 1)]
#define CFG_MAX_CONNECTION                      (1)
#define UUID_128BIT_FORMAT                      (1)
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
#define OOB_DEMO                                (1)   /* Out Of Box Demo */  
[/#if]

[#if (CUSTOM_TEMPLATE = 1)]

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

#define L2CAP_INTERVAL_MIN              CONN_P(1000) /* 1s */
#define L2CAP_INTERVAL_MAX              CONN_P(1000) /* 1s */
#define L2CAP_SLAVE_LATENCY             (0x0000)
#define L2CAP_TIMEOUT_MULTIPLIER        (0x1F4)

[/#if]

[#if (CUSTOM_P2P_ROUTER = 1)]
#define CFG_MAX_CONNECTION                (8)
#define UUID_128BIT_FORMAT                (1)

#define CFG_DEV_ID_P2P_SERVER1                  (0x83)
#define CFG_DEV_ID_P2P_SERVER2                  (0x84)
#define CFG_DEV_ID_P2P_SERVER3                  (0x87)
#define CFG_DEV_ID_P2P_SERVER4                  (0x88)
#define CFG_DEV_ID_P2P_SERVER5                  (0x89)   
#define CFG_DEV_ID_P2P_SERVER6                  (0x8A)   
#define CFG_DEV_ID_P2P_ROUTER                   (0x85)

#define CFG_P2P_DEMO_MULTI                      (1)


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
[/#if]

/* USER CODE BEGIN Specific_Parameters */

/* USER CODE END Specific_Parameters */

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

/******************************************************************************
 * BLE Stack
 ******************************************************************************/
[#if (BLE = 1) || (BLE_SKELETON = 1)]

/**
 * Maximum number of simultaneous connections that the device will support.
 * Valid values are from 1 to 8
 * This setting should not exceed the number of BLE connection supported by 
 * the ble host
 */
#define CFG_BLE_NUM_LINK            (${CFG_BLE_NUM_LINK})

/**
 * Maximum number of Services that can be stored in the GATT database.
 * Note that the GAP and GATT services are automatically added so this parameter should be 2 plus the number of user services
 */
#define CFG_BLE_NUM_GATT_SERVICES   (${CFG_BLE_NUM_GATT_SERVICES})

/**
 * Maximum number of Attributes
 * (i.e. the number of characteristic + the number of characteristic values + the number of descriptors, excluding the services)
 * that can be stored in the GATT database.
 * Note that certain characteristics and relative descriptors are added automatically during device initialization
 * so this parameters should be 9 plus the number of user Attributes
 */
#define CFG_BLE_NUM_GATT_ATTRIBUTES (${CFG_BLE_NUM_GATT_ATTRIBUTES})

/**
 * Maximum supported ATT_MTU size
 * This setting should be aligned with ATT_MTU value configured in the ble host
 */
#define CFG_BLE_MAX_ATT_MTU         (${CFG_BLE_MAX_ATT_MTU})

/**
 * Size of the storage area for Attribute values
 *  This value depends on the number of attributes used by application. In particular the sum of the following quantities (in octets) should be made for each attribute:
 *  - attribute value length
 *  - 5, if UUID is 16 bit; 19, if UUID is 128 bit
 *  - 2, if server configuration descriptor is used
 *  - 2*DTM_NUM_LINK, if client configuration descriptor is used
 *  - 2, if extended properties is used
 *  The total amount of memory needed is the sum of the above quantities for each attribute.
 */
#define CFG_BLE_ATT_VALUE_ARRAY_SIZE    (${CFG_BLE_ATT_VALUE_ARRAY_SIZE})

/**
 * depth of the PREPARE WRITE queue when PREPARE WRITE REQUEST
 */
#define CFG_BLE_ATTR_PREPARE_WRITE_VALUE_SIZE       (${CFG_BLE_ATTR_PREPARE_WRITE_VALUE_SIZE})

#define CFG_BLE_MBLOCK_COUNT_MARGIN                 (${CFG_BLE_MBLOCK_COUNT_MARGIN})
#define CFG_BLE_MAX_COC_NUMBER                      (${CFG_BLE_MAX_COC_NUMBER})
#define CFG_BLE_MAX_COC_INITIATOR_NBR               (${CFG_BLE_MAX_COC_INITIATOR_NBR})
#define PREP_WRITE_LIST_SIZE                        (BLE_DEFAULT_PREP_WRITE_LIST_SIZE)

#define BLE_MEM_BLOCK_TX(mtu) \
          (DIVC((mtu) + 4U, BLE_MEM_BLOCK_SIZE) + 1U)
#define BLE_MEM_BLOCK_RX(mtu, n_link) \
          ((DIVC((mtu) + 4U, BLE_MEM_BLOCK_SIZE) + 1U) * (n_link))
#define BLE_MEM_BLOCK_MTU(mtu, n_link) \
          (BLE_MEM_BLOCK_TX(mtu) + BLE_MEM_BLOCK_RX(mtu, n_link))
/**
 * Number of allocated memory blocks used to transmit and receive data packets
 */
#define CFG_BLE_MBLOCK_COUNT    MAX(BLE_MEM_BLOCK_X_MTU(CFG_BLE_MAX_ATT_MTU, CFG_BLE_NUM_LINK), BLE_MBLOCKS_SECURE_CONNECTIONS)

/**
 * Options
 * Each definition below may be added together to build the Options value
 * WARNING : Only one definition per bit shall be added to build the Options value
 */
#define BLE_INIT_OPTIONS_LL_ONLY                              (1<<0)
#define BLE_INIT_OPTIONS_LL_HOST                              (0<<0)

#define BLE_INIT_OPTIONS_NO_SVC_CHANGE_DESC                   (1<<1)
#define BLE_INIT_OPTIONS_WITH_SVC_CHANGE_DESC                 (0<<1)

#define BLE_INIT_OPTIONS_DEVICE_NAME_RO                       (1<<2)
#define BLE_INIT_OPTIONS_DEVICE_NAME_RW                       (0<<2)

#define BLE_INIT_OPTIONS_POWER_CLASS_1                        (1<<7)
#define BLE_INIT_OPTIONS_POWER_CLASS_2_3                      (0<<7)

/**
 * BLE stack Options flags to be configured with:
 * - BLE_INIT_OPTIONS_LL_ONLY
 * - BLE_INIT_OPTIONS_LL_HOST
 * - BLE_INIT_OPTIONS_NO_SVC_CHANGE_DESC
 * - BLE_INIT_OPTIONS_WITH_SVC_CHANGE_DESC
 * - BLE_INIT_OPTIONS_DEVICE_NAME_RO
 * - BLE_INIT_OPTIONS_DEVICE_NAME_RW
 * - BLE_INIT_OPTIONS_POWER_CLASS_1
 * - BLE_INIT_OPTIONS_POWER_CLASS_2_3
 * which are used to set following configuration bits:
 * (bit 0): 1: LL only
 *          0: LL + host
 * (bit 1): 1: no service change desc.
 *          0: with service change desc.
 * (bit 2): 1: device name Read-Only
 *          0: device name R/W
 * (bit 7): 1: LE Power Class 1
 *          0: LE Power Class 2-3
 * other bits: reserved (shall be set to 0)
 */
#define CFG_BLE_OPTIONS  (${CFG_BLE_OPTIONS_LL} | ${CFG_BLE_OPTIONS_SVC} | ${CFG_BLE_OPTIONS_DEVICE_NAME} | ${CFG_BLE_OPTIONS_POWER_CLASS})

#define CFG_BLE_MIN_TX_POWER            (${CFG_BLE_MIN_TX_POWER})

#define CFG_BLE_MAX_TX_POWER            (${CFG_BLE_MAX_TX_POWER})

/**
 * Maximum supported Devices in BLE Database
 */
#define CFG_BLE_MAX_DDB_ENTRIES         (${CFG_BLE_MAX_DDB_ENTRIES})

[/#if]
/* USER CODE BEGIN BLE_Stack */

/* USER CODE END BLE_Stack */

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
#define CFG_FULL_LOW_POWER       (${CFG_FULL_LOW_POWER})

#define CFG_LPM_SUPPORTED        (${CFG_LPM_SUPPORTED})
#define CFG_LPM_STDBY_SUPPORTED  (${CFG_LPM_STDBY_SUPPORTED})


/**
 * Low Power configuration
 */
#if (CFG_FULL_LOW_POWER == 1)
  #undef CFG_LPM_SUPPORTED
  #define CFG_LPM_SUPPORTED      (1)

  #undef  CFG_DBG_SUPPORTED
  #define CFG_DBG_SUPPORTED      (0)

  #undef  CFG_LED_SUPPORTED
  #define CFG_LED_SUPPORTED      (0)

  #undef  CFG_BUTTON_SUPPORTED
  #define CFG_BUTTON_SUPPORTED   (0)

#else
  #undef CFG_LPM_SUPPORTED
  #define CFG_LPM_SUPPORTED      (0)
#endif /* CFG_FULL_LOW_POWER */

/* USER CODE BEGIN Low_Power 0 */

/* USER CODE END Low_Power 0 */

/**
 * Supported requester to the MCU Low Power Manager - can be increased up  to 32
 * It list a bit mapping of all user of the Low Power Manager
 */
typedef enum
{
  CFG_LPM_APP,
  /* USER CODE BEGIN CFG_LPM_Id_t */

  /* USER CODE END CFG_LPM_Id_t */
} CFG_LPM_Id_t;

/* USER CODE BEGIN Low_Power 1 */

/* USER CODE END Low_Power 1 */

/******************************************************************************
 * RTC
 ******************************************************************************/
#define RTC_N_PREDIV_S (10)
#define RTC_PREDIV_S ((1<<RTC_N_PREDIV_S)-1)
#define RTC_PREDIV_A ((1<<(15-RTC_N_PREDIV_S))-1)

/* USER CODE BEGIN RTC */

/* USER CODE END RTC */

/*****************************************************************************
 * Traces
 * Enable or Disable traces in application
 * When CFG_DEBUG_TRACE is set, traces are activated
 *
 * Note : Refer to utilities_conf.h file in order to details
 *        the level of traces : CFG_DEBUG_TRACE_FULL or CFG_DEBUG_TRACE_LIGHT
 *****************************************************************************/

#define ADV_TRACE_TIMESTAMP_ENABLE  (${ADV_TRACE_TIMESTAMP_ENABLE}U)

/**
 * Enable or Disable traces in application
 */
#define CFG_DEBUG_APP_TRACE         (${CFG_DEBUG_APP_TRACE})

/* New implementation using stm32_adv_trace */
#define APP_DBG(...)                                      \
{                                                                 \
  UTIL_ADV_TRACE_COND_FSend(VLEVEL_L, ~0x0, ADV_TRACE_TIMESTAMP_ENABLE, __VA_ARGS__); \
}

#if (CFG_DEBUG_APP_TRACE != 0)
#define APP_DBG_MSG                 APP_DBG
#else
#define APP_DBG_MSG(...)
#endif

#if (CFG_DEBUG_APP_TRACE != 0)
#define CFG_DEBUG_TRACE             (1)
#endif

#if (CFG_DEBUG_TRACE != 0)
#undef CFG_LPM_SUPPORTED
#define CFG_LPM_SUPPORTED           (0)
#endif

/**
 * When CFG_DEBUG_TRACE_FULL is set to 1, the trace are output with the API name, the file name and the line number
 * When CFG_DEBUG_TRACE_LIGHT is set to 1, only the debug message is output
 *
 * When both are set to 0, no trace are output
 * When both are set to 1,  CFG_DEBUG_TRACE_FULL is selected
 */
#define CFG_DEBUG_TRACE_LIGHT       (${CFG_DEBUG_TRACE_LIGHT})
#define CFG_DEBUG_TRACE_FULL        (${CFG_DEBUG_TRACE_FULL})

#if (( CFG_DEBUG_TRACE != 0 ) && ( CFG_DEBUG_TRACE_LIGHT == 0 ) && (CFG_DEBUG_TRACE_FULL == 0))
#undef CFG_DEBUG_TRACE_FULL
#undef CFG_DEBUG_TRACE_LIGHT
#define CFG_DEBUG_TRACE_FULL        (0)
#define CFG_DEBUG_TRACE_LIGHT       (1)
#endif

#if ( CFG_DEBUG_TRACE == 0 )
#undef CFG_DEBUG_TRACE_FULL
#undef CFG_DEBUG_TRACE_LIGHT
#define CFG_DEBUG_TRACE_FULL        (0)
#define CFG_DEBUG_TRACE_LIGHT       (0)
#endif

/**
 * When not set, the traces is looping on sending the trace over UART
 */
#define DBG_TRACE_USE_CIRCULAR_QUEUE  (${DBG_TRACE_USE_CIRCULAR_QUEUE})

/**
 * Max buffer size to queue data traces and max data trace allowed.
 * Only Used if DBG_TRACE_USE_CIRCULAR_QUEUE is defined
 */
#define DBG_TRACE_MSG_QUEUE_SIZE      (${DBG_TRACE_MSG_QUEUE_SIZE})
#define MAX_DBG_TRACE_MSG_SIZE        (${MAX_DBG_TRACE_MSG_SIZE})

/**
 * Max message size for debug logging service
 */
#define SYS_MAX_MSG                 (${SYS_MAX_MSG}U)

/**
 * Timeout for advertising
 */
#define INITIAL_ADV_TIMEOUT         (${INITIAL_ADV_TIMEOUT}*1000) /**< 60s */

/* USER CODE BEGIN Traces */

/* USER CODE END Traces */

/******************************************************************************
 * Configure Log level for Application
 ******************************************************************************/
#define APPLI_CONFIG_LOG_LEVEL      (${APPLI_CONFIG_LOG_LEVEL})
#define APPLI_PRINT_FILE_FUNC_LINE  (${APPLI_PRINT_FILE_FUNC_LINE})

/* USER CODE BEGIN Log_level */

/* USER CODE END Log_level */

[#if (FREERTOS_STATUS = 0)]
/******************************************************************************
 * Scheduler
 ******************************************************************************/
[#if (BLE = 1) || (BLE_SKELETON = 1)]

/**
 * These are the lists of task id registered to the scheduler
 * Each task id shall be in the range [0:31]
 * This mechanism allows to implement a generic code in the API TL_BLE_HCI_StatusNot() to comply with
 * the requirement that a HCI/ACI command shall never be sent if there is already one pending
 */

/**< Add in that list all tasks that may send a ACI/HCI command */
typedef enum
{
[#if (CUSTOM_TEMPLATE = 1)]
  CFG_TASK_ADV_CANCEL_ID,
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
[#if (CUSTOM_P2P_ROUTER = 1) || (CUSTOM_P2P_CLIENT = 1) || (CUSTOM_TEMPLATE = 1)]
  CFG_TASK_HCI_ASYNCH_EVT_ID,
[/#if]
[#if (BLE_TRANSPARENT_MODE_UART = 1)]
  CFG_TASK_BLE_HCI_CMD_ID,
  CFG_TASK_SYS_HCI_CMD_ID,
  CFG_TASK_HCI_ACL_DATA_ID,
  CFG_TASK_SYS_LOCAL_CMD_ID,
  CFG_TASK_TX_TO_HOST_ID,
[/#if]
[#if (CUSTOM_P2P_ROUTER = 1) || (CUSTOM_P2P_CLIENT = 1) || (BLE_TRANSPARENT_MODE_UART = 1)  || (CUSTOM_TEMPLATE = 1)]
  /* USER CODE BEGIN CFG_Task_Id_With_HCI_Cmd_t */

  /* USER CODE END CFG_Task_Id_With_HCI_Cmd_t */
[#else]
  CFG_TASK_ADV_UPDATE_ID,
  CFG_TASK_MEAS_REQ_ID,
  CFG_TASK_HCI_ASYNCH_EVT_ID,
  /* USER CODE BEGIN CFG_Task_Id_With_HCI_Cmd_t */

  /* USER CODE END CFG_Task_Id_With_HCI_Cmd_t */
[/#if]
  CFG_TASK_LINK_LAYER,
  CFG_TASK_BLE_HOST,
  CFG_LAST_TASK_ID_WITH_HCICMD,                                               /**< Shall be LAST in the list */
} CFG_Task_Id_With_HCI_Cmd_t;

/**< Add in that list all tasks that never send a ACI/HCI command */
typedef enum
{
  CFG_FIRST_TASK_ID_WITH_NO_HCICMD = CFG_LAST_TASK_ID_WITH_HCICMD - 1,        /**< Shall be FIRST in the list */
  CFG_TASK_BPKA,
  CFG_TASK_HW_RNG,
  /* USER CODE BEGIN CFG_Task_Id_With_NO_HCI_Cmd_t */

  /* USER CODE END CFG_Task_Id_With_NO_HCI_Cmd_t */
[/#if]
  CFG_LAST_TASK_ID_WITH_NO_HCICMD                                             /**< Shall be LAST in the list */
} CFG_Task_Id_With_NO_HCI_Cmd_t;

#define CFG_TASK_NBR    CFG_LAST_TASK_ID_WITH_NO_HCICMD

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
  /* USER CODE BEGIN CFG_SCH_Prio_Id_t */

  /* USER CODE END CFG_SCH_Prio_Id_t */
  CFG_PRIO_NBR
} CFG_SCH_Prio_Id_t;

[#else]
/******************************************************************************
 * FreeRTOS
 ******************************************************************************/
/* USER CODE BEGIN FreeRTOS */

/* USER CODE END FreeRTOS */
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
 * NVM configuration
 ******************************************************************************/
/**
 * Do not enable ALIGN mode
 * Used only by BLE Test Fw
 */
#define CFG_NVM_ALIGN                       (${CFG_NVM_ALIGN})

  /**
   * This is the max size of data the BLE Stack needs to write in NVM
   * This is different to the size allocated in the EEPROM emulator
   * The BLE Stack shall write all data at an address in the range of [0 : (x-1)]
   * The size is a number of 32bits values
   * NOTE:
   * THIS VALUE SHALL BE IN LINE WITH THE BLOCK DEFINE IN THE SCATTER FILE BLOCK_STACKLIB_FLASH_DATA
   * There are 8x32bits = 32 Bytes header in the EEPROM for each sector.
   * a page is a collection of 1 or more sectors
   */
#define CFG_NVM_BLE_MAX_SIZE                ((128*20)/4)

/* USER CODE BEGIN NVM_Configuration */

/* USER CODE END NVM_Configuration */

/******************************************************************************
 * BLEPLAT configuration
 ******************************************************************************/

/* Number of 64-bit words in NVM flash area */
#define CFG_BLEPLAT_NVM_MAX_SIZE            ((2048/8)-4)

/* USER CODE BEGIN BLEPLAT_Configuration */

/* USER CODE END BLEPLAT_Configuration */

/******************************************************************************
 * HW RADIO configuration
 ******************************************************************************/

#define USE_RADIO_LOW_ISR                   (${USE_RADIO_LOW_ISR})            /* Link Layer uses radio low interrupt (0 --> NO)
                                                                                                     (1 --> YES)
                                                               */

#define NEXT_EVENT_SCHEDULING_FROM_ISR      (${NEXT_EVENT_SCHEDULING_FROM_ISR})            /* Link Layer uses radio low interrupt (0 --> NO --> Next event schediling is done at background)
                                                                                                     (1 --> YES)
                                                               */

#define RADIO_INTR_NUM                      RADIO_IRQn     /* 2.4GHz RADIO global interrupt */
#define RADIO_INTR_PRIO_HIGH                (${RADIO_INTR_PRIO_HIGH})            /* 2.4GHz RADIO interrupt priority when radio is Active */
#define RADIO_INTR_PRIO_LOW                 (${RADIO_INTR_PRIO_LOW})            /* 2.4GHz RADIO interrupt priority when radio is Not Active - Sleep Timer Only */

#if (USE_RADIO_LOW_ISR == 1)
#define RADIO_SW_LOW_INTR_NUM               ${RADIO_SW_LOW_INTR_NUM}      /* Selected interrupt vector for 2.4GHz RADIO low ISR */
#define RADIO_SW_LOW_INTR_PRIO              (${RADIO_SW_LOW_INTR_PRIO})           /* 2.4GHz RADIO low ISR priority */
#endif /* USE_RADIO_LOW_ISR */

#define RCC_INTR_PRIO                       (1)           /* HSERDY and PLL1RDY */

#define TOTAL_NUM_IRQ                       (HSEM_IRQn + 1)

/* USER CODE BEGIN Radio_Configuration */

/* USER CODE END Radio_Configuration */

/******************************************************************************
 * HW_RNG configuration
 ******************************************************************************/

/* Number of 32-bit random values stored in internal pool */
#define CFG_HW_RNG_POOL_SIZE                (${CFG_HW_RNG_POOL_SIZE})

/******************************************************************************
 * MEMORY MANAGER
 ******************************************************************************/
#define CFG_MM_POOL_SIZE                    (${CFG_MM_POOL_SIZE})
#define CFG_PWR_VOS2_SUPPORTED              (0)   /* VOS2 power configuration not currently supported with radio activity */

/* USER CODE BEGIN Defines */

/* USER CODE END Defines */

#endif /*APP_CONF_H */