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
            [#if ("${definition.value}"=="valueNotSetted")]
              [#assign myHash = {definition.name:0} + myHash]
            [#else]
              [#assign myHash = {definition.name:definition.value} + myHash]
            [/#if]
        [/#list]
    [/#if]
[/#list]
[#assign nbInstanceCli = 0]
[#assign myHashCli = {}]
[#if BspIpDatas??]
	[#list BspIpDatas as SWIP]
		[#if SWIP.variables??]
			[#list SWIP.variables as variables]
				[#assign myHashCli = {variables.name + nbInstanceCli:variables.value} + myHashCli]
				[#if variables.name?contains("BoardName")]
					[#assign nbInstanceCli = nbInstanceCli + 1]
				[/#if]
			[/#list]
		[/#if]
	[/#list]
[/#if]
[#--
Key & Value:
[#list myHash?keys as key]
Key: ${key}; Value: ${myHash[key]}
[/#list]
--]
[#assign SNVMA_NUMBER_OF_SECTOR_NEEDED = 0]
[#if myHash["SNVMA_NVM_NUMBER"]?number != 0]
		[#list 1..myHash["SNVMA_NVM_NUMBER"]?number as nvm_number]
		[#assign SNVMA_NUMBER_OF_SECTOR_NEEDED = SNVMA_NUMBER_OF_SECTOR_NEEDED + myHash["SNVMA_NVM_ID_" + nvm_number?string  + "_BANK_NUMBER"]?number * myHash["SNVMA_NVM_ID_" + nvm_number?string  + "_BANK_SIZE"]?number]
		[/#list]
[/#if]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef APP_CONF_H
#define APP_CONF_H

/* Includes ------------------------------------------------------------------*/
#include "hw_if.h"
#include "utilities_conf.h"
#include "log_module.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/******************************************************************************
 * Application Config
 ******************************************************************************/
/**< generic parameters ******************************************************/
[#if (myHash["BLE"] == "Enabled")]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled")]

/**
 * Define Tx Power
 */
#define CFG_TX_POWER                      ${myHash["CFG_TX_POWER"]}

/**
 * Define Advertising parameters
 */
#define CFG_BD_ADDRESS                    (${myHash["CFG_BD_ADDRESS"]})

/**
 * Define BD_ADDR type: define proper address. Can only be GAP_PUBLIC_ADDR (0x00) or GAP_STATIC_RANDOM_ADDR (0x01)
 */
#define CFG_BD_ADDRESS_TYPE               (${myHash["CFG_BD_ADDRESS_TYPE"]})
[#if ((myHash["CFG_STATIC_RANDOM_ADDRESS"]?number == 1) && (myHash["CFG_BD_ADDRESS_TYPE"] == "GAP_STATIC_RANDOM_ADDR"))]
/**
 * Define Static Random Address fixed for lifetime of the device
 */
#define CFG_STATIC_RANDOM_ADDRESS         (${myHash["STATIC_RANDOM_ADDRESS"]})
[/#if]

/**
 * Define privacy: PRIVACY_DISABLED or PRIVACY_ENABLED
 */
#define CFG_PRIVACY                       (${myHash["CFG_PRIVACY"]})

/**
 * Define BLE Address Type
 * Bluetooth address types defined in ble_legacy.h
 * if CFG_PRIVACY equals PRIVACY_DISABLED, CFG_BLE_ADDRESS_TYPE has 2 allowed values: GAP_PUBLIC_ADDR or GAP_STATIC_RANDOM_ADDR
 * if CFG_PRIVACY equals PRIVACY_ENABLED, CFG_BLE_ADDRESS_TYPE has 2 allowed values: GAP_RESOLVABLE_PRIVATE_ADDR or GAP_NON_RESOLVABLE_PRIVATE_ADDR
 */
[#if (myHash["CFG_PRIVACY"] == "PRIVACY_DISABLED")]
#define CFG_BLE_ADDRESS_TYPE              (${myHash["CFG_BD_ADDRESS_TYPE"]})
[#else]
#define CFG_BLE_ADDRESS_TYPE              (${myHash["CFG_BLE_ADDR_TYPE"]})
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
[#if ((myHash["BLE_MODE_HOST_SKELETON"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL"] == "Enabled"))]

/**
 * Define IO Authentication
 */
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled")]
#define CFG_BONDING_MODE                 (1)
[#else]
#define CFG_BONDING_MODE                 (${myHash["CFG_BONDING_MODE"]})
[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled")]
#define CFG_USED_FIXED_PIN               (1)                               /* 0->fixed pin is used ; 1->No fixed pin used*/
[#else]
#define CFG_USED_FIXED_PIN               (${myHash["CFG_USED_FIXED_PIN"]}) /* 0->fixed pin is used ; 1->No fixed pin used*/
[/#if]
#define CFG_FIXED_PIN                    (${myHash["CFG_FIXED_PIN"]})
#define CFG_ENCRYPTION_KEY_SIZE_MAX      (${myHash["CFG_ENCRYPTION_KEY_SIZE_MAX"]})
#define CFG_ENCRYPTION_KEY_SIZE_MIN      (${myHash["CFG_ENCRYPTION_KEY_SIZE_MIN"]})

/**
 * Define Input Output capabilities
 */
#define CFG_IO_CAPABILITY                (${myHash["CFG_IO_CAPABILITY"]})

/**
 * Define Man In The Middle modes
 */
#define CFG_MITM_PROTECTION              (${myHash["CFG_MITM_PROTECTION"]})

/**
 * Define Secure Connections Support
 */
#define CFG_SC_SUPPORT                   (${myHash["CFG_SC_SUPPORT"]})

/**
 * Define Keypress Notification Support
 */
#define CFG_KEYPRESS_NOTIFICATION_SUPPORT     (${myHash["CFG_KEYPRESS_NOTIFICATION_SUPPORT"]})

[/#if]
/**
*   Identity root key used to derive IRK and DHK(Legacy)
*/
#define CFG_BLE_IR      {${myHash["CFG_BLE_IR_HEX"]}}

/**
* Encryption root key used to derive LTK(Legacy) and CSRK
*/
#define CFG_BLE_ER      {${myHash["CFG_BLE_ER_HEX"]}}

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

[/#if]
[/#if]

/* USER CODE END Specific_Parameters */

[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
/******************************************************************************
 * BLE Stack
 ******************************************************************************/
/**
 * BLE stack options, bitmap to active or not some features at BleStack_Init() function call.
 */
#define CFG_BLE_OPTIONS             (${myHash["BLE_OPTIONS_LL_ONLY"]} | \
                                     ${myHash["BLE_OPTIONS_NO_SVC_CHANGE_DESC"]} | \
                                     ${myHash["BLE_OPTIONS_DEV_NAME_READ_ONLY"]} | \
                                     ${myHash["BLE_OPTIONS_EXTENDED_ADV"]} | \
                                     ${myHash["BLE_OPTIONS_REDUCED_DB_IN_NVM"]} | \
                                     ${myHash["BLE_OPTIONS_GATT_CACHING"]} | \
                                     ${myHash["BLE_OPTIONS_POWER_CLASS_1"]} | \
                                     ${myHash["BLE_OPTIONS_APPEARANCE_WRITABLE"]})

/**
 * Maximum number of simultaneous connections and advertising that the device will support.
 * This setting should not exceed the number of BLE connection supported by BLE host stack.
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
#define CFG_BLE_ATT_MTU_MAX         (${myHash["CFG_BLE_ATT_MTU_MAX"]})

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

#define PREP_WRITE_LIST_SIZE                        (BLE_DEFAULT_PREP_WRITE_LIST_SIZE)

/**
 * Number of allocated memory blocks used to transmit and receive data packets
 */
#define CFG_BLE_MBLOCK_COUNT          (BLE_MBLOCKS_CALC(PREP_WRITE_LIST_SIZE, \
                                       CFG_BLE_ATT_MTU_MAX, CFG_BLE_NUM_LINK) \
                                       + CFG_BLE_MBLOCK_COUNT_MARGIN)

/**
 * Appearance of device set into BLE GAP
 */
#define CFG_GAP_APPEARANCE            (${myHash["CFG_GAP_APPEARANCE"]})

/**
 * Connection Oriented Channel parameters
 */
#define CFG_BLE_COC_NBR_MAX           (${myHash["CFG_BLE_COC_NBR_MAX"]})
#define CFG_BLE_COC_MPS_MAX           (${myHash["CFG_BLE_COC_MPS_MAX"]})
#define CFG_BLE_COC_INITIATOR_NBR_MAX (${myHash["CFG_BLE_COC_INITIATOR_NBR_MAX"]})

/**
 * PHY preferences
 */
#define CFG_PHY_PREF                  (${myHash["CFG_PHY_PREF"]})
#define CFG_PHY_PREF_TX               (${myHash["CFG_PHY_PREF_TX"]})
#define CFG_PHY_PREF_RX               (${myHash["CFG_PHY_PREF_RX"]})

/* USER CODE BEGIN BLE_Stack */

/* USER CODE END BLE_Stack */
[/#if]

/******************************************************************************
 * Low Power
 *
 *  When CFG_LPM_LEVEL is set to:
 *   - 0 : Low Power Mode is not activated, RUN mode will be used.
 *   - 1 : Low power active, the one selected with CFG_LPM_STDBY_SUPPORTED
 *   - 2 : In addition, force to disable modules to reach lowest power figures.
 *
 * When CFG_LPM_STDBY_SUPPORTED is set to:
 *   - 1 : Standby is used as low power mode.
 *   - 0 : Standby is not used, so stop mode 1 is used as low power mode.
 *
 ******************************************************************************/
#define CFG_LPM_LEVEL            (${myHash["CFG_LPM_LEVEL"]})
#define CFG_LPM_STDBY_SUPPORTED  (${myHash["CFG_LPM_STDBY_SUPPORTED"]})

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
  CFG_LPM_LOG,
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
  CFG_LPM_APP_BLE,
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")|| (myHash["THREAD_SKELETON"] == "Enabled")|| (myHash["THREAD"] == "Enabled")]
  CFG_LPM_APP_THREAD,
[/#if]
  /* USER CODE BEGIN CFG_LPM_Id_t */

  /* USER CODE END CFG_LPM_Id_t */
} CFG_LPM_Id_t;

/* USER CODE BEGIN Low_Power 1 */

/* USER CODE END Low_Power 1 */

[#if McuName?starts_with("STM32WBA55")]
/* Core voltage supply selection, it can be PWR_LDO_SUPPLY or PWR_SMPS_SUPPLY */
#define CFG_CORE_SUPPLY          (PWR_${myHash["CFG_CORE_SUPPLY"]}_SUPPLY)

[/#if]
/******************************************************************************
 * RTC
 ******************************************************************************/
#define RTC_N_PREDIV_S (10)
#define RTC_PREDIV_S ((1<<RTC_N_PREDIV_S)-1)
#define RTC_PREDIV_A ((1<<(15-RTC_N_PREDIV_S))-1)

/* USER CODE BEGIN RTC */

/* USER CODE END RTC */

/*****************************************************************************
 * Logs
 *
 * Applications must call LOG_INFO_APP for logs.
 * By default, CFG_LOG_INSERT_TIME_STAMP_INSIDE_THE_TRACE is set to 0.
 * As a result, there is no time stamp insertion inside the logs.
 *
 * For advanced log use cases, see the log_module.h file.
 * This file is customizable, you can create new verbose levels and log regions.
 *****************************************************************************/
/**
 * Enable or disable LOG over UART in the application.
 * Low power level(CFG_LPM_LEVEL) above 1 will disable LOG.
 * Standby low power mode(CFG_LPM_STDBY_SUPPORTED) will disable LOG.
 */
#define CFG_LOG_SUPPORTED           (${myHash["CFG_LOG_SUPPORTED"]}U)

/* Configure Log display settings */
#define CFG_LOG_INSERT_COLOR_INSIDE_THE_TRACE       (${myHash["CFG_LOG_INSERT_COLOR_INSIDE_THE_TRACE"]}U)
#define CFG_LOG_INSERT_TIME_STAMP_INSIDE_THE_TRACE  (${myHash["CFG_LOG_INSERT_TIME_STAMP_INSIDE_THE_TRACE"]}U)
#define CFG_LOG_INSERT_EOL_INSIDE_THE_TRACE         (${myHash["CFG_LOG_INSERT_EOL_INSIDE_THE_TRACE"]}U)



/* macro ensuring retrocompatibility with old applications */
#define APP_DBG                     LOG_INFO_APP
#define APP_DBG_MSG                 LOG_INFO_APP

[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled")]
/* Specific defines for Zigbee traces levels */
#define ZB_LOG_MASK_LEVEL_0         0x00000000U
#define ZB_LOG_MASK_LEVEL_1         ( ZB_LOG_MASK_FATAL )
#define ZB_LOG_MASK_LEVEL_2         ( ZB_LOG_MASK_LEVEL_1 | ZB_LOG_MASK_ERROR )
#define ZB_LOG_MASK_LEVEL_3         ( ZB_LOG_MASK_LEVEL_2 | ZB_LOG_MASK_INFO )
#define ZB_LOG_MASK_LEVEL_4         ( ZB_LOG_MASK_LEVEL_3 | ZB_LOG_MASK_DEBUG )
#define ZB_LOG_MASK_LEVEL_5         ( ZB_LOG_MASK_LEVEL_4 | ZB_LOG_MASK_ZCL )
#define ZB_LOG_MASK_LEVEL_ALL       0xFFFFFFFFU

/* Indicate Trace Level for Zigbee Stack (Fatal/Error) */
#define ZIGBEE_CONFIG_LOG_LEVEL     ZB_LOG_MASK_LEVEL_2

[/#if]
/* USER CODE BEGIN Logs */

/* USER CODE END Logs */

/******************************************************************************
 * Configure Log level for Application
 ******************************************************************************/
#define APPLI_CONFIG_LOG_LEVEL      ${myHash["CFG_LOG_VERBOSE_LEVEL"]}

/* USER CODE BEGIN Log_level */

/* USER CODE END Log_level */

[#if (myHash["THREAD"] == "Enabled")]
    [#if nbInstanceCli !=0 ]
        [#list 0..(nbInstanceCli-1) as i]
            [#if myHashCli["bspName"+i] == "Serial Link for Command Line Interface"]
/******************************************************************************
 * Configure Serial Link used for Thread Command Line
 ******************************************************************************/
#define OT_CLI_USE                  (1U)
extern UART_HandleTypeDef           h${myHashCli["IpInstance"+i]?lower_case?replace("s","")};
#define OT_CLI_UART_HANDLER         h${myHashCli["IpInstance"+i]?lower_case?replace("s","")}

            [/#if]
        [/#list]
    [/#if]
[/#if]
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
/******************************************************************************
 * Sequencer
 ******************************************************************************/

/**
 * These are the lists of task id registered to the sequencer
 * Each task id shall be in the range [0:31]
 */
typedef enum
{
  CFG_TASK_HW_RNG,                /* Task linked to chip internal peripheral. */
  CFG_TASK_LINK_LAYER,            /* Tasks linked to Communications Layers. */
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
[#if myHash["BLE_MODE_CENTRAL"] == "Enabled"]
  CFG_TASK_DISCOVER_SERVICES_ID,
[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled")]
  CFG_TASK_HCI_ASYNCH_EVT_ID,
[#else]
  CFG_TASK_BLE_HCI_CMD_ID,
  CFG_TASK_SYS_HCI_CMD_ID,
  CFG_TASK_HCI_ACL_DATA_ID,
  CFG_TASK_SYS_LOCAL_CMD_ID,
  CFG_TASK_TX_TO_HOST_ID,
[/#if]
[/#if]
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
  CFG_TASK_LINK_LAYER_TEMP_MEAS,
[/#if]
[#if (myHash["BLE"] == "Enabled")]
  CFG_TASK_BLE_HOST,
[/#if]
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
  CFG_TASK_BPKA,
[/#if]
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
  CFG_TASK_AMM_BCKGND,
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
  CFG_TASK_FLASH_MANAGER_BCKGND,
[/#if]
[/#if]
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
  CFG_TASK_BLE_TIMER_BCKGND,
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
  CFG_TASK_MAC_LAYER,
[#if (myHash["ZIGBEE"] == "Enabled")]
  CFG_TASK_ZIGBEE_LAYER,
  CFG_TASK_ZIGBEE_NETWORK_FORM,   /* Tasks linked to Zigbee Start. */
  CFG_TASK_ZIGBEE_APP_START,
  CFG_TASK_ZIGBEE_APP1,           /* Tasks linked to Zigbee Application. */
  CFG_TASK_ZIGBEE_APP2,
  CFG_TASK_ZIGBEE_APP3,
  CFG_TASK_ZIGBEE_APP4,
[/#if]
[/#if]
[#if (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled") ]
  CFG_TASK_OT_UART,
  CFG_TASK_OT_ALARM,
  CFG_TASK_OT_US_ALARM,

  /* APPLI TASKS */
  CFG_TASK_OT_TASKLETS,
  CFG_TASK_SET_THREAD_MODE,
[/#if]
  /* USER CODE BEGIN CFG_Task_Id_t */
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
[#if PG_FILL_UCS == "True"]
[#if PG_BSP_NUCLEO_WBA52CG == 1]
  TASK_BUTTON_1,
  TASK_BUTTON_2,
  TASK_BUTTON_3,
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
[#if (RF_APPLICATION == "HEALTH_THERMOMETER")]
  CFG_TASK_HTS_MEAS_REQ_ID,
  CFG_TASK_HTS_INTERMEDIATE_TEMPERATURE_REQ_ID,
  CFG_TASK_HTS_MEAS_INTERVAL_REQ_ID,
[/#if]
[#if (RF_APPLICATION == "P2PROUTER")]
  CFG_TASK_FORWARD_NOTIF_ID,
  CFG_TASK_FORWARD_WRITE_ID,
  CFG_TASK_DEV_TABLE_NOTIF_ID,
  CFG_TASK_CONN_DEV_ID,
[/#if]
[/#if]
[/#if]
  /* USER CODE END CFG_Task_Id_t */
  CFG_TASK_NBR /* Shall be LAST in the list */
} CFG_Task_Id_t;

/* USER CODE BEGIN DEFINE_TASK */

/* USER CODE END DEFINE_TASK */

/**
 * This is the list of priority required by the application
 * Shall be in the range 0..31
 */
typedef enum
{
  CFG_SEQ_PRIO_0 = 0,
  CFG_SEQ_PRIO_1,
  /* USER CODE BEGIN CFG_SEQ_Prio_Id_t */

  /* USER CODE END CFG_SEQ_Prio_Id_t */
  CFG_SEQ_PRIO_NBR /* Shall be LAST in the list */
} CFG_SEQ_Prio_Id_t;

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
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "HEARTRATE")]
[/#if]
[#if (RF_APPLICATION == "P2PCLIENT")]
  CFG_IDLEEVT_CONNECTION_COMPLETE,
[/#if]
[#if (RF_APPLICATION == "P2PSERVER")]
[/#if]
[#if (RF_APPLICATION == "HEALTH_THERMOMETER")]
[/#if]
[#if (RF_APPLICATION == "P2PROUTER")]
  CFG_IDLEEVT_NODE_CONNECTION_COMPLETE,
  CFG_IDLEEVT_NODE_MTU_EXCHANGED_COMPLETE,
[/#if]
[/#if]

  /* USER CODE END CFG_IdleEvt_Id_t */
} CFG_IdleEvt_Id_t;

[/#if]
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled") || (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")  ]
/* Sequencer defines */
#define TASK_HW_RNG                         ( 1u << CFG_TASK_HW_RNG )
#define TASK_LINK_LAYER                     ( 1u << CFG_TASK_LINK_LAYER )
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
#define TASK_MAC_LAYER                      ( 1u << CFG_TASK_MAC_LAYER )
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled")]
#define TASK_ZIGBEE_LAYER                   ( 1u << CFG_TASK_ZIGBEE_LAYER )
#define TASK_ZIGBEE_NETWORK_FORM            ( 1u << CFG_TASK_ZIGBEE_NETWORK_FORM )
#define TASK_ZIGBEE_APP_START               ( 1u << CFG_TASK_ZIGBEE_APP_START )
#define TASK_ZIGBEE_APP1                    ( 1u << CFG_TASK_ZIGBEE_APP1 )
#define TASK_ZIGBEE_APP2                    ( 1u << CFG_TASK_ZIGBEE_APP2 )
#define TASK_ZIGBEE_APP3                    ( 1u << CFG_TASK_ZIGBEE_APP3 )
#define TASK_ZIGBEE_APP4                    ( 1u << CFG_TASK_ZIGBEE_APP3 )
[/#if]
/* USER CODE BEGIN TASK_ID_Define */

/* USER CODE END TASK_ID_Define */

[/#if]
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled")]
/* Sequencer priorities by default  */
#define CFG_TASK_PRIO_HW_RNG                CFG_SEQ_PRIO_0
#define CFG_TASK_PRIO_LINK_LAYER            CFG_SEQ_PRIO_0
/* USER CODE BEGIN TASK_Priority_Define */

/* USER CODE END TASK_Priority_Define */

[/#if]
/* Used by Sequencer */
#define UTIL_SEQ_CONF_PRIO_NBR              CFG_SEQ_PRIO_NBR

/**
 * These are the lists of events id registered to the sequencer
 * Each event id shall be in the range [0:31]
 */
typedef enum
{
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
  CFG_EVENT_LINK_LAYER,
  CFG_EVENT_MAC_LAYER,
[#if (myHash["ZIGBEE"] == "Enabled")]
  CFG_EVENT_ZIGBEE_LAYER,
  CFG_EVENT_ZIGBEE_STARTUP_ENDED,
  CFG_EVENT_ZIGBEE_APP1,           /* Events linked to Zigbee Application. */
  CFG_EVENT_ZIGBEE_APP2,
  CFG_EVENT_ZIGBEE_APP3,
  CFG_EVENT_ZIGBEE_APP4,
[/#if]
[/#if]
  /* USER CODE BEGIN CFG_Event_Id_t */

  /* USER CODE END CFG_Event_Id_t */
  CFG_EVENT_NBR                   /* Shall be LAST in the list */
} CFG_Event_Id_t;

/**< Events defines */
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
#define EVENT_LINK_LAYER                ( 1U << CFG_EVENT_LINK_LAYER )
#define EVENT_MAC_LAYER                 ( 1U << CFG_EVENT_MAC_LAYER )
[#if (myHash["ZIGBEE"] == "Enabled")]
#define EVENT_ZIGBEE_LAYER              ( 1U << CFG_EVENT_ZIGBEE_LAYER )
#define EVENT_ZIGBEE_STARTUP_ENDED      ( 1U << CFG_EVENT_ZIGBEE_STARTUP_ENDED )
#define EVENT_ZIGBEE_APP1               ( 1U << CFG_EVENT_ZIGBEE_APP1 )
#define EVENT_ZIGBEE_APP2               ( 1U << CFG_EVENT_ZIGBEE_APP2 )
#define EVENT_ZIGBEE_APP3               ( 1U << CFG_EVENT_ZIGBEE_APP3 )
#define EVENT_ZIGBEE_APP4               ( 1U << CFG_EVENT_ZIGBEE_APP4 )
[/#if]
[/#if]

[/#if]

[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
/******************************************************************************
 * NVM configuration
 ******************************************************************************/


#define CFG_SNVMA_START_SECTOR_ID     (FLASH_PAGE_NB - ${SNVMA_NUMBER_OF_SECTOR_NEEDED}u)

#define CFG_SNVMA_START_ADDRESS       (FLASH_BASE + (FLASH_PAGE_SIZE * (CFG_SNVMA_START_SECTOR_ID)))

[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["THREAD"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
  /**
   * This is the max size of data the THREAD Stack needs to write in NVM
   * This is different to the size allocated in the EEPROM emulator
   * The THREAD Stack shall write all data at an address in the range of [0 : (y-1)]
   * The size is a number of 32bits values
   */
#define CFG_NVMA_THREAD_NVM_SIZE                    ( 0u )

[/#if]

/* USER CODE BEGIN NVM_Configuration */

/* USER CODE END NVM_Configuration */
[/#if]


[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
/******************************************************************************
 * BLEPLAT configuration
 ******************************************************************************/
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
/* Number of 64-bit words in NVM flash area */
#define CFG_BLEPLAT_NVM_MAX_SIZE            ((2048/8)-4)
[/#if]

/* USER CODE BEGIN BLEPLAT_Configuration */

/* USER CODE END BLEPLAT_Configuration */

[/#if]
/******************************************************************************
 * Debugger
 *
 *  When CFG_DEBUGGER_LEVEL is set to:
 *   - 0 : No Debugger available, SWD/JTAG pins are disabled.
 *   - 1 : Debugger available in RUN mode only.
 *   - 2 : Debugger available in low power mode.
 *
 ******************************************************************************/
#define CFG_DEBUGGER_LEVEL           (${myHash["CFG_DEBUGGER_LEVEL"]})

/******************************************************************************
 * RealTime GPIO debug module configuration
 ******************************************************************************/

#define CFG_RT_DEBUG_GPIO_MODULE         (${myHash["CFG_RT_DEBUG_GPIO_MODULE"]})
#define CFG_RT_DEBUG_DTB                 (0)

/******************************************************************************
 * System Clock Manager module configuration
 ******************************************************************************/

#define CFG_SCM_SUPPORTED            (1)

/******************************************************************************
 * HW RADIO configuration
 ******************************************************************************/
/* Do not modify - must be 1 */
#define USE_RADIO_LOW_ISR                   (${myHash["USE_RADIO_LOW_ISR"]})

/* Do not modify - must be 1 */
#define NEXT_EVENT_SCHEDULING_FROM_ISR      (${myHash["NEXT_EVENT_SCHEDULING_FROM_ISR"]})

[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
/* Link Layer uses temperature based calibration (0 --> NO ; 1 --> YES) */
#define USE_TEMPERATURE_BASED_RADIO_CALIBRATION  (${myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]})

[/#if]
#define RADIO_INTR_NUM                      RADIO_IRQn     /* 2.4GHz RADIO global interrupt */
#define RADIO_INTR_PRIO_HIGH                (${myHash["RADIO_INTR_PRIO_HIGH"]})            /* 2.4GHz RADIO interrupt priority when radio is Active */
#define RADIO_INTR_PRIO_LOW                 (${myHash["RADIO_INTR_PRIO_LOW"]})            /* 2.4GHz RADIO interrupt priority when radio is Not Active - Sleep Timer Only */

#if (USE_RADIO_LOW_ISR == 1)
#define RADIO_SW_LOW_INTR_NUM               ${myHash["RADIO_SW_LOW_INTR_NUM"]}      /* Selected interrupt vector for 2.4GHz RADIO low ISR */
#define RADIO_SW_LOW_INTR_PRIO              (${myHash["RADIO_SW_LOW_INTR_PRIO"]})           /* 2.4GHz RADIO low ISR priority */
#endif /* USE_RADIO_LOW_ISR */

/* Link Layer supported number of antennas */
#define RADIO_NUM_OF_ANTENNAS               (4)

#define RCC_INTR_PRIO                       (1)           /* HSERDY and PLL1RDY */

/* RF TX power table ID selection:
 *   0 -> RF TX output level from -20 dBm to +10 dBm
 *   1 -> RF TX output level from -20 dBm to +3 dBm
 */
#define CFG_RF_TX_POWER_TABLE_ID            (${myHash["CFG_RF_TX_POWER_TABLE_ID"]})

/* USER CODE BEGIN Radio_Configuration */

/* USER CODE END Radio_Configuration */

/******************************************************************************
 * HW_RNG configuration
 ******************************************************************************/

/* Number of 32-bit random values stored in internal pool */
#define CFG_HW_RNG_POOL_SIZE                (${myHash["CFG_HW_RNG_POOL_SIZE"]})

/* USER CODE BEGIN HW_RNG_Configuration */

/* USER CODE END HW_RNG_Configuration */

[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
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
#define CFG_AMM_VIRTUAL_STACK_BLE                 (1U)
#define CFG_AMM_VIRTUAL_STACK_BLE_BUFFER_SIZE     (400U)
#define CFG_AMM_VIRTUAL_APP_BLE                   (2U)
#define CFG_AMM_VIRTUAL_APP_BLE_BUFFER_SIZE       (200U)
[/#if]
#define CFG_AMM_POOL_SIZE                      DIVC(CFG_MM_POOL_SIZE, sizeof (uint32_t)) \
                                               + (AMM_VIRTUAL_INFO_ELEMENT_SIZE * CFG_AMM_VIRTUAL_MEMORY_NUMBER)

/* USER CODE BEGIN MEMORY_MANAGER_Configuration */

/* USER CODE END MEMORY_MANAGER_Configuration */

[/#if]
/* USER CODE BEGIN Defines */
[#if PG_FILL_UCS == "True"]
/**
 * User interaction
 * When CFG_LED_SUPPORTED is set, LEDS are activated if requested
 * When CFG_BUTTON_SUPPORTED is set, the push button are activated if requested
 */

[#if (RF_APPLICATION == "HEARTRATE")]
#define CFG_LED_SUPPORTED                       (0)
[#else]
#define CFG_LED_SUPPORTED                       (1)
[/#if]
#define CFG_BUTTON_SUPPORTED                    (1)

/**
 * Overwrite some configuration imposed by Low Power level selected.
 */
#if (CFG_LPM_LEVEL > 1)
  #if CFG_LED_SUPPORTED
    #undef  CFG_LED_SUPPORTED
    #define CFG_LED_SUPPORTED       (0)
  #endif /* CFG_LED_SUPPORTED */
#endif /* CFG_LPM_LEVEL */
[/#if]

/* USER CODE END Defines */

/**
 * Overwrite some configuration imposed by Low Power level selected.
 */
#if (CFG_LPM_LEVEL > 1)
  #if CFG_LOG_SUPPORTED
    #undef  CFG_LOG_SUPPORTED
    #define CFG_LOG_SUPPORTED       (0)
  #endif /* CFG_LOG_SUPPORTED */
  #if CFG_DEBUGGER_LEVEL
    #undef  CFG_DEBUGGER_LEVEL
    #define CFG_DEBUGGER_LEVEL      (0)
  #endif /* CFG_DEBUGGER_LEVEL */
#endif /* CFG_LPM_LEVEL */

#if (CFG_LPM_STDBY_SUPPORTED == 1)
  #if CFG_LOG_SUPPORTED
    #undef  CFG_LOG_SUPPORTED
    #define CFG_LOG_SUPPORTED       (0)
  #endif /* CFG_LOG_SUPPORTED */
#endif /* CFG_LPM_STDBY_SUPPORTED */

/* USER CODE BEGIN Defines_2 */

/* USER CODE END Defines_2 */


#endif /*APP_CONF_H */
