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
[#assign PG_FILL_UCS = "False"]
[#assign PG_BSP_NUCLEO_WBA52CG = 0]
[#assign PG_SKIP_LIST = "False"]
[#assign myHash = {}]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#assign myHash = {definition.name:definition.value} + myHash]
        [/#list]
    [/#if]
[/#list]
[#assign SNVMA_NUMBER_OF_SECTOR_NEEDED = 0]
[#list 1..myHash["SNVMA_NVM_NUMBER"]?number as nvm_number]
[#assign SNVMA_NUMBER_OF_SECTOR_NEEDED = SNVMA_NUMBER_OF_SECTOR_NEEDED + myHash["SNVMA_NVM_ID_" + nvm_number?string  + "_BANK_NUMBER"]?number * myHash["SNVMA_NVM_ID_" + nvm_number?string  + "_BANK_SIZE"]?number]
[/#list]
[#--
Key & Value:
[#list myHash?keys as key]
Key: ${key}; Value: ${myHash[key]}
[/#list]
--]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef APP_CONF_H
#define APP_CONF_H

/* Includes ------------------------------------------------------------------*/
#include "hw_if.h"
#include "stm32_adv_trace.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/******************************************************************************
 * Application Config
 ******************************************************************************/
/**< generic parameters ******************************************************/
[#if (myHash["BLE"] == "Enabled")]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]

/**
 * Define Tx Power
 */
#define CFG_TX_POWER                      ${myHash["CFG_TX_POWER"]}

/**
 * Define Advertising parameters
 */
#define CFG_ADV_BD_ADDRESS                (${myHash["CFG_ADV_BD_ADDRESS"]})
[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
#define CFG_BLE_ADDRESS_TYPE              ${myHash["CFG_BLE_ADDRESS_TYPE"]} /**< Bluetooth address types defined in ble_defs.h */
[#if ((myHash["CFG_STATIC_RANDOM_ADDRESS"]?number == 1) && (myHash["CFG_BLE_ADDRESS_TYPE"] == "GAP_RANDOM_ADDR"))]
#define CFG_STATIC_RANDOM_ADDRESS         (${myHash["STATIC_RANDOM_ADDRESS"]}) /**< Static Random Address fixed for lifetime of the device */
[/#if]

[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
#define ADV_INTERVAL_MIN                  (${myHash["ADV_INTERVAL_MIN_HEXA"]})
#define ADV_INTERVAL_MAX                  (${myHash["ADV_INTERVAL_MAX_HEXA"]})
#define ADV_LP_INTERVAL_MIN               (0x0640)
#define ADV_LP_INTERVAL_MAX               (0x0FA0)
#define ADV_TYPE                          ${myHash["ADV_TYPE"]}
#define ADV_FILTER                        ${myHash["ADV_FILTER"]}
[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled")]
#define LEDBUTTON_CONN_ADV_INTERVAL_MIN   (0x1FA)
#define LEDBUTTON_CONN_ADV_INTERVAL_MAX   (0x3E8)
[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]

/**
 * Define IO Authentication
 */
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled")]
#define CFG_BONDING_MODE                 (1)
[#else]
#define CFG_BONDING_MODE                 (${myHash["CFG_BONDING_MODE"]})
[/#if]
#define CFG_FIXED_PIN                    (${myHash["CFG_FIXED_PIN"]})
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled")]
#define CFG_USED_FIXED_PIN               (1)
[#else]
#define CFG_USED_FIXED_PIN               (${myHash["CFG_USED_FIXED_PIN"]})
[/#if]
#define CFG_ENCRYPTION_KEY_SIZE_MAX      (${myHash["CFG_ENCRYPTION_KEY_SIZE_MAX"]})
#define CFG_ENCRYPTION_KEY_SIZE_MIN      (${myHash["CFG_ENCRYPTION_KEY_SIZE_MIN"]})

/**
 * Define IO capabilities
 */
#define CFG_IO_CAPABILITY_DISPLAY_ONLY        (0x00)
#define CFG_IO_CAPABILITY_DISPLAY_YES_NO      (0x01)
#define CFG_IO_CAPABILITY_KEYBOARD_ONLY       (0x02)
#define CFG_IO_CAPABILITY_NO_INPUT_NO_OUTPUT  (0x03)
#define CFG_IO_CAPABILITY_KEYBOARD_DISPLAY    (0x04)

#define CFG_IO_CAPABILITY                     ${myHash["CFG_IO_CAPABILITY"]}

/**
 * Define MITM modes
 */
#define CFG_MITM_PROTECTION_NOT_REQUIRED      (0x00)
#define CFG_MITM_PROTECTION_REQUIRED          (0x01)

#define CFG_MITM_PROTECTION                   ${myHash["CFG_MITM_PROTECTION"]}

[/#if]

/**
 * Define Secure Connections Support
 */
#define CFG_SECURE_NOT_SUPPORTED              (0x00)
#define CFG_SECURE_OPTIONAL                   (0x01)
#define CFG_SECURE_MANDATORY                  (0x02)

#define CFG_SC_SUPPORT                        ${myHash["CFG_SC_SUPPORT"]}

/**
 * Define Keypress Notification Support
 */
#define CFG_KEYPRESS_NOT_SUPPORTED            (0x00)
#define CFG_KEYPRESS_SUPPORTED                (0x01)

#define CFG_KEYPRESS_NOTIFICATION_SUPPORT     ${myHash["CFG_KEYPRESS_NOTIFICATION_SUPPORT"]}

/**
 * Numeric Comparison Answers
 */
#define YES (0x01)
#define NO  (0x00)

[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
/**
*   Identity root key used to derive LTK and CSRK
*/
#define CFG_BLE_IRK     {${myHash["CFG_BLE_IRK_HEX"]}}

/**
* Encryption root key used to derive LTK and CSRK
*/
#define CFG_BLE_ERK     {${myHash["CFG_BLE_ERK_HEX"]}}

[/#if]
[/#if]
/* USER CODE BEGIN Generic_Parameters */

/* USER CODE END Generic_Parameters */

/**< specific parameters */
/*****************************************************/

/* USER CODE BEGIN Specific_Parameters */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "BEACON")]

/**
 * Beacon selection
 * Beacons are all exclusive
 */
#define CFG_EDDYSTONE_UID_BEACON_TYPE   (1<<0)
#define CFG_EDDYSTONE_URL_BEACON_TYPE   (1<<1)
#define CFG_EDDYSTONE_TLM_BEACON_TYPE   (1<<2)
#define CFG_IBEACON                     (1<<3)

#define CFG_BEACON_TYPE                 (CFG_EDDYSTONE_URL_BEACON_TYPE)

#define OFFSET_PAYLOAD_LENGTH           9
#define OFFSET_PAYLOAD_DATA             10
[/#if]
[/#if]

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
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled")]

/**
 * Maximum number of simultaneous connections that the device will support.
 * Valid values are from 1 to 8
 * This setting should not exceed the number of BLE connection supported by
 * the ble host
 */
#define CFG_BLE_NUM_LINK            (${myHash["CFG_BLE_NUM_LINK"]})

/**
 * Maximum number of Services that can be stored in the GATT database.
 * Note that the GAP and GATT services are automatically added so this parameter should be 2 plus the number of user services
 */
#define CFG_BLE_NUM_GATT_SERVICES   (${myHash["CFG_BLE_NUM_GATT_SERVICES"]})

/**
 * Maximum number of Attributes
 * (i.e. the number of characteristic + the number of characteristic values + the number of descriptors, excluding the services)
 * that can be stored in the GATT database.
 * Note that certain characteristics and relative descriptors are added automatically during device initialization
 * so this parameters should be 9 plus the number of user Attributes
 */
#define CFG_BLE_NUM_GATT_ATTRIBUTES (${myHash["CFG_BLE_NUM_GATT_ATTRIBUTES"]})

/**
 * Maximum supported ATT_MTU size
 * This setting should be aligned with ATT_MTU value configured in the ble host
 */
#define CFG_BLE_MAX_ATT_MTU         (${myHash["CFG_BLE_MAX_ATT_MTU"]})

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
#define CFG_BLE_ATT_VALUE_ARRAY_SIZE    (${myHash["CFG_BLE_ATT_VALUE_ARRAY_SIZE"]})

/**
 * depth of the PREPARE WRITE queue when PREPARE WRITE REQUEST
 */
#define CFG_BLE_ATTR_PREPARE_WRITE_VALUE_SIZE       (${myHash["CFG_BLE_ATTR_PREPARE_WRITE_VALUE_SIZE"]})

#define CFG_BLE_MBLOCK_COUNT_MARGIN                 (${myHash["CFG_BLE_MBLOCK_COUNT_MARGIN"]})
#define CFG_BLE_MAX_COC_NUMBER                      (${myHash["CFG_BLE_MAX_COC_NUMBER"]})
#define CFG_BLE_MAX_COC_MPS                         (${myHash["CFG_BLE_MAX_COC_MPS"]})
#define CFG_BLE_MAX_COC_INITIATOR_NBR               (${myHash["CFG_BLE_MAX_COC_INITIATOR_NBR"]})
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
#define CFG_BLE_MBLOCK_COUNT (BLE_MBLOCKS_CALC(PREP_WRITE_LIST_SIZE, \
                                       CFG_BLE_MAX_ATT_MTU, CFG_BLE_NUM_LINK) \
                                   + CFG_BLE_MBLOCK_COUNT_MARGIN)
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
#define CFG_BLE_OPTIONS  (${myHash["CFG_BLE_OPTIONS_LL"]} | ${myHash["CFG_BLE_OPTIONS_SVC"]} | ${myHash["CFG_BLE_OPTIONS_DEVICE_NAME"]} | ${myHash["CFG_BLE_OPTIONS_POWER_CLASS"]})

/**
 * Maximum supported Devices in BLE Database
 */
#define CFG_BLE_MAX_DDB_ENTRIES         (${myHash["CFG_BLE_MAX_DDB_ENTRIES"]})

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
#define CFG_FULL_LOW_POWER       (${myHash["CFG_FULL_LOW_POWER"]})

#define CFG_LPM_SUPPORTED        (${myHash["CFG_LPM_SUPPORTED"]})
#define CFG_LPM_STDBY_SUPPORTED  (${myHash["CFG_LPM_STDBY_SUPPORTED"]})


/**
 * Low Power configuration
 */
#if (CFG_FULL_LOW_POWER == 1)
  #undef CFG_LPM_SUPPORTED
  #define CFG_LPM_SUPPORTED      (1)

  #undef  CFG_DBG_SUPPORTED
  #define CFG_DBG_SUPPORTED      (0)

#else
  #undef CFG_LPM_SUPPORTED
  #define CFG_LPM_SUPPORTED      (0)
#endif /* CFG_FULL_LOW_POWER */

/* USER CODE BEGIN Low_Power 0 */

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
/* Keep HSI Enabled for USART for Transparent Mode Appli */
#define CFG_KEEP_HSI_ENABLED     (1)
[/#if]

/* USER CODE END Low_Power 0 */

/**
 * Supported requester to the MCU Low Power Manager - can be increased up  to 32
 * It list a bit mapping of all user of the Low Power Manager
 */
typedef enum
{
  CFG_LPM_APP,
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
  CFG_LPM_APP_BLE,
[/#if]
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

#define ADV_TRACE_TIMESTAMP_ENABLE  (${myHash["ADV_TRACE_TIMESTAMP_ENABLE"]}U)

/**
 * Enable or Disable traces in application
 */
#define CFG_DEBUG_APP_TRACE         (${myHash["CFG_DEBUG_APP_TRACE"]})

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
#define CFG_DEBUG_TRACE_LIGHT       (${myHash["CFG_DEBUG_TRACE_LIGHT"]})
#define CFG_DEBUG_TRACE_FULL        (${myHash["CFG_DEBUG_TRACE_FULL"]})

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
#define DBG_TRACE_USE_CIRCULAR_QUEUE  (${myHash["DBG_TRACE_USE_CIRCULAR_QUEUE"]})

/**
 * Max buffer size to queue data traces and max data trace allowed.
 * Only Used if DBG_TRACE_USE_CIRCULAR_QUEUE is defined
 */
#define DBG_TRACE_MSG_QUEUE_SIZE      (${myHash["DBG_TRACE_MSG_QUEUE_SIZE"]})
#define MAX_DBG_TRACE_MSG_SIZE        (${myHash["MAX_DBG_TRACE_MSG_SIZE"]})

/**
 * Max message size for debug logging service
 */
#define SYS_MAX_MSG                 (${myHash["SYS_MAX_MSG"]}U)

/**
 * Timeout for advertising
 */
#define INITIAL_ADV_TIMEOUT         (${myHash["INITIAL_ADV_TIMEOUT"]}*1000) /**< 60s */

/* USER CODE BEGIN Traces */

/* USER CODE END Traces */

/******************************************************************************
 * Configure Log level for Application
 ******************************************************************************/
#define APPLI_CONFIG_LOG_LEVEL      (${myHash["APPLI_CONFIG_LOG_LEVEL"]})
#define APPLI_PRINT_FILE_FUNC_LINE  (${myHash["APPLI_PRINT_FILE_FUNC_LINE"]})

/* USER CODE BEGIN Log_level */

/* USER CODE END Log_level */

[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
/******************************************************************************
 * Scheduler
 ******************************************************************************/
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled")]

/**
 * These are the lists of task id registered to the scheduler
 * Each task id shall be in the range [0:31]
 * This mechanism allows to implement a generic code in the API TL_BLE_HCI_StatusNot() to comply with
 * the requirement that a HCI/ACI command shall never be sent if there is already one pending
 */

/**< Add in that list all tasks that may send a ACI/HCI command */
typedef enum
{
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
[/#if]
[#if myHash["BLE_MODE_CENTRAL"] == "Enabled"]
  CFG_TASK_DISCOVER_SERVICES_ID,
[/#if]
[#if myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled"]
[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
  CFG_TASK_HCI_ASYNCH_EVT_ID,
[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
  CFG_TASK_BLE_HCI_CMD_ID,
  CFG_TASK_SYS_HCI_CMD_ID,
  CFG_TASK_HCI_ACL_DATA_ID,
  CFG_TASK_SYS_LOCAL_CMD_ID,
  CFG_TASK_TX_TO_HOST_ID,
[/#if]
  /* USER CODE BEGIN CFG_Task_Id_With_HCI_Cmd_t */
[#if PG_FILL_UCS == "True"]
[#if PG_BSP_NUCLEO_WBA52CG == 1]
  CFG_TASK_PB1_BUTTON_PUSHED_ID,
  CFG_TASK_PB2_BUTTON_PUSHED_ID,
  CFG_TASK_PB3_BUTTON_PUSHED_ID,
[/#if]
[#if (RF_APPLICATION == "HEARTRATE")]
  CFG_TASK_MEAS_REQ_ID,
  CFG_TASK_ADV_LP_REQ_ID,
[/#if]
[#if (RF_APPLICATION == "P2PCLIENT")]
  CFG_TASK_CONN_DEV_ID,
  CFG_TASK_P2PC_WRITE_CHAR_ID,
[/#if]
[#if (RF_APPLICATION == "P2PSERVER")]
  CFG_TASK_ADV_CANCEL_ID,
  CFG_TASK_SEND_NOTIF_ID,
[/#if]
[#if (RF_APPLICATION == "HEALTH_TERMOMETER")]
  CFG_TASK_HTS_MEAS_REQ_ID,
  CFG_TASK_HTS_INTERMEDIATE_TEMPERATURE_REQ_ID,
  CFG_TASK_HTS_MEAS_INTERVAL_REQ_ID,
[/#if]
[/#if]

  /* USER CODE END CFG_Task_Id_With_HCI_Cmd_t */
  CFG_TASK_LINK_LAYER,
  CFG_TASK_LINK_LAYER_TEMP_MEAS,
[#if (myHash["BLE_MODE_SKELETON"] != "Enabled")]
  CFG_TASK_BLE_HOST,
[/#if]
  CFG_LAST_TASK_ID_WITH_HCICMD,                                               /**< Shall be LAST in the list */
} CFG_Task_Id_With_HCI_Cmd_t;

/**< Add in that list all tasks that never send a ACI/HCI command */
typedef enum
{
  CFG_FIRST_TASK_ID_WITH_NO_HCICMD = CFG_LAST_TASK_ID_WITH_HCICMD - 1,        /**< Shall be FIRST in the list */
  CFG_TASK_BPKA,
  CFG_TASK_HW_RNG,
  CFG_TASK_AMM_BCKGND,
  CFG_TASK_FLASH_MANAGER_BCKGND,
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

[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")||(myHash["BLE_MODE_CENTRAL"] == "Enabled")]
/**
 * This is a bit mapping over 32bits listing all events id supported in the application
 */
typedef enum
{
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")||(myHash["BLE_MODE_CENTRAL"] == "Enabled")]
  CFG_IDLEEVT_PROC_GAP_COMPLETE,
[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
  CFG_IDLEEVT_PROC_GATT_COMPLETE,
[/#if]
  /* USER CODE BEGIN CFG_IdleEvt_Id_t */

  /* USER CODE END CFG_IdleEvt_Id_t */
} CFG_IdleEvt_Id_t;

[/#if]

[/#if]

/******************************************************************************
 * NVM configuration
 ******************************************************************************/
/**
 * Do not enable ALIGN mode
 * Used only by BLE Test Fw
 */
#define CFG_NVM_ALIGN                       (${myHash["CFG_NVM_ALIGN"]})

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

#define CFG_SNVMA_START_SECTOR_ID     (FLASH_PAGE_NB - ${SNVMA_NUMBER_OF_SECTOR_NEEDED}u)

#define CFG_SNVMA_START_ADDRESS       (FLASH_BASE + (FLASH_PAGE_SIZE * (FLASH_PAGE_NB - ${SNVMA_NUMBER_OF_SECTOR_NEEDED}u)))

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
 * RT GPIO debug module configuration
 ******************************************************************************/

#define RT_DEBUG_GPIO_MODULE         (${myHash["RT_DEBUG_GPIO_MODULE"]})

/******************************************************************************
 * HW RADIO configuration
 ******************************************************************************/

#define USE_RADIO_LOW_ISR                   (${myHash["USE_RADIO_LOW_ISR"]})            /* Link Layer uses radio low interrupt (0 --> NO)
                                                                                                     (1 --> YES)
                                                               */

#define NEXT_EVENT_SCHEDULING_FROM_ISR      (${myHash["NEXT_EVENT_SCHEDULING_FROM_ISR"]})            /* Link Layer uses radio low interrupt (0 --> NO --> Next event schediling is done at background)
                                                                                                     (1 --> YES)
                                                               */

#define USE_TEMPERATURE_BASED_RADIO_CALIBRATION  (${myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]})       /* Link Layer uses temperature based calibration (0 --> NO)
                                                            *                                               (1 --> YES)
                                                            */

#define RADIO_INTR_NUM                      RADIO_IRQn     /* 2.4GHz RADIO global interrupt */
#define RADIO_INTR_PRIO_HIGH                (${myHash["RADIO_INTR_PRIO_HIGH"]})            /* 2.4GHz RADIO interrupt priority when radio is Active */
#define RADIO_INTR_PRIO_LOW                 (${myHash["RADIO_INTR_PRIO_LOW"]})            /* 2.4GHz RADIO interrupt priority when radio is Not Active - Sleep Timer Only */

#if (USE_RADIO_LOW_ISR == 1)
#define RADIO_SW_LOW_INTR_NUM               ${myHash["RADIO_SW_LOW_INTR_NUM"]}      /* Selected interrupt vector for 2.4GHz RADIO low ISR */
#define RADIO_SW_LOW_INTR_PRIO              (${myHash["RADIO_SW_LOW_INTR_PRIO"]})           /* 2.4GHz RADIO low ISR priority */
#endif /* USE_RADIO_LOW_ISR */

#define RCC_INTR_PRIO                       (1)           /* HSERDY and PLL1RDY */

/* USER CODE BEGIN Radio_Configuration */

/* USER CODE END Radio_Configuration */

/******************************************************************************
 * HW_RNG configuration
 ******************************************************************************/

/* Number of 32-bit random values stored in internal pool */
#define CFG_HW_RNG_POOL_SIZE                (${myHash["CFG_HW_RNG_POOL_SIZE"]})

/* USER CODE BEGIN HW_RNG_Configuration */

/* USER CODE END HW_RNG_Configuration */

/******************************************************************************
 * MEMORY MANAGER
 ******************************************************************************/

#define CFG_MM_POOL_SIZE                          (${myHash["CFG_MM_POOL_SIZE"]})
#define CFG_PWR_VOS2_SUPPORTED                    (0)   /* VOS2 power configuration not currently supported with radio activity */
#define CFG_AMM_VIRTUAL_MEMORY_NUMBER             (${myHash["CFG_AMM_VIRTUAL_MEMORY_NUMBER"]}u)
[#if PG_SKIP_LIST == "False"]
[#assign i = 0]
[#list 1..(myHash["CFG_AMM_VIRTUAL_MEMORY_NUMBER"]?number) as i]
#define CFG_AMM_VIRTUAL_${myHash["CFG_AMM_VIRTUAL_ID_NAME_"+i?string]}                   (${myHash["CFG_AMM_VIRTUAL_ID_NBR_"+i?string]}U)
#define CFG_AMM_VIRTUAL_${myHash["CFG_AMM_VIRTUAL_ID_NAME_"+i?string]}_BUFFER_SIZE       (${myHash["CFG_AMM_VIRTUAL_BUFFER_SIZE_"+i?string]}U)
[/#list]
[#else]
#define CFG_AMM_VIRTUAL_STACK_BLE                   (1U)
#define CFG_AMM_VIRTUAL_STACK_BLE_BUFFER_SIZE       (400U)
#define CFG_AMM_VIRTUAL_APP_BLE                   (2U)
#define CFG_AMM_VIRTUAL_APP_BLE_BUFFER_SIZE       (200U)
[/#if]
#define CFG_AMM_POOL_SIZE                      DIVC(CFG_MM_POOL_SIZE, sizeof (uint32_t)) \
                                               + (AMM_VIRTUAL_INFO_ELEMENT_SIZE * CFG_AMM_VIRTUAL_MEMORY_NUMBER)

/* USER CODE BEGIN MEMORY_MANAGER_Configuration */

/* USER CODE END MEMORY_MANAGER_Configuration */

/* USER CODE BEGIN Defines */
[#if PG_FILL_UCS == "True"]
/**
 * User interaction
 * When CFG_LED_SUPPORTED is set, LEDS are activated if requested
 * When CFG_BUTTON_SUPPORTED is set, the push button are activated if requested
 * When CFG_DBG_SUPPORTED is set, the debugger is activated
 */

[#if (RF_APPLICATION == "HEARTRATE")]
#define CFG_LED_SUPPORTED                       (0)
#define CFG_BUTTON_SUPPORTED                    (1)
#define CFG_DBG_SUPPORTED                       (0)
[#else]
#define CFG_LED_SUPPORTED                       (1)
#define CFG_BUTTON_SUPPORTED                    (1)
#define CFG_DBG_SUPPORTED                       (1)
[/#if]

/**
 * If CFG_FULL_LOW_POWER is requested, make sure LED and debugger are disabled
 */
#if (CFG_FULL_LOW_POWER == 1)
  #undef  CFG_LED_SUPPORTED
  #define CFG_LED_SUPPORTED      (0)
  #undef  CFG_DBG_SUPPORTED
  #define CFG_DBG_SUPPORTED      (0)
#endif /* CFG_FULL_LOW_POWER */
[/#if]

/* USER CODE END Defines */

#endif /*APP_CONF_H */
