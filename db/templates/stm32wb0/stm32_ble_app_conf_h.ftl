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
#include "stm32wb0x.h"
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/**
 * Define to 1 if LSE is used, otherwise set it to 0.
 */
#define CFG_LSCLK_LSE                       (${myHash["CFG_LSCLK_LSE"]})

/******************************************************************************
 * Application Config
 ******************************************************************************/
/**< generic parameters ******************************************************/
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled")]
/**
 * Define Tx Power Mode
 */
#define CFG_TX_POWER_MODE                   ${myHash["CFG_TX_POWER_MODE"]}

/**
 * Define Tx Power
 */
#define CFG_TX_POWER                        ${myHash["CFG_TX_POWER"]}

/**
 * Define Advertising parameters
 */
#define CFG_PUBLIC_BD_ADDRESS               (${myHash["CFG_PUBLIC_BD_ADDRESS"]})
#define CFG_BD_ADDRESS_TYPE                 ${myHash["CFG_BD_ADDRESS_TYPE"]}
#define CFG_BLE_PRIVACY_ENABLED             (${myHash["CFG_BLE_PRIVACY_ENABLED"]})

[#if (myHash["BLE_MODE_CLIENT"] != "Enabled")]
#define ADV_INTERVAL_MIN                    (${myHash["ADV_INTERVAL_MIN_HEXA"]})
#define ADV_INTERVAL_MAX                    (${myHash["ADV_INTERVAL_MAX_HEXA"]})
#define ADV_LP_INTERVAL_MIN                 (${myHash["ADV_LP_INTERVAL_MIN_HEXA"]})
#define ADV_LP_INTERVAL_MAX                 (${myHash["ADV_LP_INTERVAL_MAX_HEXA"]})
#define ADV_TYPE                            (${myHash["ADV_TYPE"]})
#define ADV_FILTER                          ${myHash["ADV_FILTER"]}
[/#if]

/**
 * Define IO Authentication
 */
#define CFG_BONDING_MODE                    (${myHash["CFG_BONDING_MODE"]})
#define CFG_FIXED_PIN                       (${myHash["CFG_FIXED_PIN"]})
#define CFG_ENCRYPTION_KEY_SIZE_MAX         (${myHash["CFG_ENCRYPTION_KEY_SIZE_MAX"]})
#define CFG_ENCRYPTION_KEY_SIZE_MIN         (${myHash["CFG_ENCRYPTION_KEY_SIZE_MIN"]})

/**
 * Define IO capabilities
 */
#define CFG_IO_CAPABILITY                   ${myHash["CFG_IO_CAPABILITY"]}

/**
 * Define MITM modes
 */
#define CFG_MITM_PROTECTION                 ${myHash["CFG_MITM_PROTECTION"]}

/**
 * Define Secure Connections Support
 */
#define CFG_SC_SUPPORT                      ${myHash["CFG_SC_SUPPORT"]}

/**
 * Define Keypress Notification Support
 */
#define CFG_KEYPRESS_NOTIFICATION_SUPPORT   ${myHash["CFG_KEYPRESS_NOTIFICATION_SUPPORT"]}

/**
 * Appearance of device set into BLE GAP
 */
#define CFG_GAP_APPEARANCE                  (${myHash["CFG_GAP_APPEARANCE"]})
[/#if]

/* USER CODE BEGIN Generic_Parameters */

/* USER CODE END Generic_Parameters */

/**< specific parameters */
/*****************************************************/

/* USER CODE BEGIN Specific_Parameters */

/* USER CODE END Specific_Parameters */

/******************************************************************************
 * BLE Stack initialization parameters
 ******************************************************************************/

/**
 * Maximum number of simultaneous radio tasks. Radio controller supports up to
 * 128 simultaneous radio tasks, but actual usable max value depends on the
 * available RAM.
 */
#define CFG_BLE_NUM_RADIO_TASKS                         (CFG_NUM_RADIO_TASKS)

/**
 * Maximum number of attributes that can be stored in the GATT database in addition to the attributes number already defined for the GATT and GAP services
 * (BLE_STACK_NUM_GATT_MANDATORY_ATTRIBUTES value on STM32_BLE middleware, ble_stack.h header file).
 */
#define CFG_BLE_NUM_GATT_ATTRIBUTES                     (${myHash["CFG_BLE_NUM_GATT_ATTRIBUTES"]})

/**
 * Maximum number of concurrent Client's Procedures. This value must be less
 * than or equal to the maximum number of supported links (CFG_BLE_NUM_RADIO_TASKS).
 */
#define CFG_BLE_NUM_OF_CONCURRENT_GATT_CLIENT_PROC      (${myHash["CFG_BLE_NUM_OF_CONCURRENT_GATT_CLIENT_PROC"]})

/**
 * Maximum supported ATT MTU size [23-1020].
 */
#define CFG_BLE_ATT_MTU_MAX                             (${myHash["CFG_BLE_ATT_MTU_MAX"]})

/**
 * Maximum duration of the connection event in system time units (625/256 us =~ 
 * 2.44 us) when the device is in Peripheral role [0-0xFFFFFFFF].
 */
#define CFG_BLE_CONN_EVENT_LENGTH_MAX                   (${myHash["CFG_BLE_CONN_EVENT_LENGTH_MAX_HEXA"]})      

/**
 * Sleep clock accuracy (ppm).
 */
[#if (myHash["RFWKPCLKSOURCE"] == "LSE")]
#if CFG_LSCLK_LSE
/* Change this value according to accuracy of low speed crystal (ppm). */
#define CFG_BLE_SLEEP_CLOCK_ACCURACY                    (${myHash["CFG_BLE_SLEEP_CLOCK_ACCURACY"]})
#else
/* This value should be kept to 500 ppm when using LSI. */
#define CFG_BLE_SLEEP_CLOCK_ACCURACY                    (500)
#endif
[#else]
#if CFG_LSCLK_LSE
/* Change this value according to accuracy of low speed crystal (ppm). */
#define CFG_BLE_SLEEP_CLOCK_ACCURACY                    (100)
#else
/* This value should be kept to 500 ppm when using LSI. */
#define CFG_BLE_SLEEP_CLOCK_ACCURACY                    (${myHash["CFG_BLE_SLEEP_CLOCK_ACCURACY"]})
#endif
[/#if]

/**
 * Number of extra memory blocks, in addition to the minimum required for the
 * supported links.
 */
#define CFG_BLE_MBLOCK_COUNT_MARGIN                     (${myHash["CFG_BLE_MBLOCK_COUNT_MARGIN"]})

/**
 * Maximum number of simultaneous EATT active channels. It must be less than or
 * equal to CFG_BLE_COC_NBR_MAX.
 */
#define CFG_BLE_NUM_EATT_CHANNELS                       (${myHash["CFG_BLE_NUM_EATT_CHANNELS"]})

/**
 * Maximum number of channels in LE Credit Based Flow Control mode [0-255].
 * This number must be greater than or equal to CFG_BLE_NUM_EATT_CHANNELS.
 */
#define CFG_BLE_COC_NBR_MAX                             (${myHash["CFG_BLE_COC_NBR_MAX"]})

/**
 * The maximum size of payload data in octets that the L2CAP layer entity is
 * capable of accepting [0-1024].
 */
#define CFG_BLE_COC_MPS_MAX                             (${myHash["CFG_BLE_COC_MPS_MAX"]})

/**
 * Maximum number of Advertising Data Sets, if Advertising Extension Feature is
 * enabled.
 */
#define CFG_BLE_NUM_ADV_SETS                            (${myHash["CFG_BLE_NUM_ADV_SETS"]})

/**
 * Maximum number of Periodic Advertising with Responses subevents.
 */
#define CFG_BLE_NUM_PAWR_SUBEVENTS                      (${myHash["CFG_BLE_NUM_PAWR_SUBEVENTS"]})

/**
 * Maximum number of subevent data that can be queued in the controller.
 */    
#define CFG_BLE_PAWR_SUBEVENT_DATA_COUNT_MAX            (${myHash["CFG_BLE_PAWR_SUBEVENT_DATA_COUNT_MAX"]}U)

/**
 * Maximum number of slots for scanning on the secondary advertising channel,
 * if Advertising Extension Feature is enabled.
 */
#define CFG_BLE_NUM_AUX_SCAN_SLOTS                      (${myHash["CFG_BLE_NUM_AUX_SCAN_SLOTS"]})

/**
 * Maximum number of slots for synchronizing to a periodic advertising train,
 * if Periodic Advertising and Synchronizing Feature is enabled. 
 */
#define CFG_BLE_NUM_SYNC_SLOTS                          (${myHash["CFG_BLE_NUM_SYNC_SLOTS"]})

/**
 * Two's logarithm of Filter Accept, Resolving and Advertiser list size.
 */
#define CFG_BLE_FILTER_ACCEPT_LIST_SIZE_LOG2            (${myHash["CFG_BLE_FILTER_ACCEPT_LIST_SIZE_LOG2"]})

/**
 * Maximum number of Antenna IDs in the antenna pattern used in CTE connection
 * oriented mode.
 */ 
#define CFG_BLE_NUM_CTE_ANTENNA_IDS_MAX                 (${myHash["CFG_BLE_NUM_CTE_ANTENNA_IDS_MAX"]})

/**
 * Maximum number of IQ samples in the buffer used in CTE connection oriented mode.
 */
#define CFG_BLE_NUM_CTE_IQ_SAMPLES_MAX                  (${myHash["CFG_BLE_NUM_CTE_IQ_SAMPLES_MAX"]})

/**
 * Maximum number of slots for synchronizing to a Broadcast Isochronous Group. 
 */
#define CFG_BLE_NUM_SYNC_BIG_MAX                        (${myHash["CFG_BLE_NUM_SYNC_BIG_MAX"]}U)

/**
 * Maximum number of slots for synchronizing to a Broadcast Isochronous Stream. 
 */
#define CFG_BLE_NUM_SYNC_BIS_MAX                        (${myHash["CFG_BLE_NUM_SYNC_BIS_MAX"]}U)

/**
 * Maximum number of slots for broadcasting a Broadcast Isochronous Group. 
 */
#define CFG_BLE_NUM_BRC_BIG_MAX                         (${myHash["CFG_BLE_NUM_BRC_BIG_MAX"]}U)

/**
 * Maximum number of slots for broadcasting a Broadcast Isochronous Stream. 
 */
#define CFG_BLE_NUM_BRC_BIS_MAX                         (${myHash["CFG_BLE_NUM_BRC_BIS_MAX"]}U)

/**
 * Maximum number of Connected Isochronous Groups. 
 */
#define CFG_BLE_NUM_CIG_MAX                             (${myHash["CFG_BLE_NUM_CIG_MAX"]}U)

/**
 * Maximum number of Connected Isochronous Streams. 
 */
#define CFG_BLE_NUM_CIS_MAX                             (${myHash["CFG_BLE_NUM_CIS_MAX"]}U)

/**
 * Size of the internal FIFO used for critical controller events produced by the
 * ISR (e.g. rx data packets).
 */
#define CFG_BLE_ISR0_FIFO_SIZE                          (${myHash["CFG_BLE_ISR0_FIFO_SIZE"]})

/**
 * Size of the internal FIFO used for non-critical controller events produced by
 * the ISR (e.g. advertising or IQ sampling reports).
 */
#define CFG_BLE_ISR1_FIFO_SIZE                          (${myHash["CFG_BLE_ISR1_FIFO_SIZE"]})

/**
 * Size of the internal FIFO used for controller and host events produced
 * outside the ISR.
 */
#define CFG_BLE_USER_FIFO_SIZE                          (${myHash["CFG_BLE_USER_FIFO_SIZE"]})

/**
 * If 1, Peripheral Preferred Connection Parameters Characteristic is added in GAP service.
 */
#define CFG_BLE_GAP_PERIPH_PREF_CONN_PARAM_CHARACTERISTIC  (${myHash["CFG_BLE_GAP_PERIPH_PREF_CONN_PARAM_CHARACTERISTIC"]})

/**
 * If 1, Encrypted Key Material Characteristic is added in GAP service.
 */
#define CFG_BLE_GAP_ENCRYPTED_KEY_MATERIAL_CHARACTERISTIC  (${myHash["CFG_BLE_GAP_ENCRYPTED_KEY_MATERIAL_CHARACTERISTIC"]})

/**
 * Number of allocated memory blocks used for packet allocation.
 * The use of BLE_STACK_MBLOCKS_CALC macro is suggested to calculate the minimum
 * number of memory blocks for a given number of supported links and ATT MTU.
 */
#define CFG_BLE_MBLOCKS_COUNT           (BLE_STACK_MBLOCKS_CALC(CFG_BLE_ATT_MTU_MAX, CFG_BLE_NUM_RADIO_TASKS, CFG_BLE_NUM_EATT_CHANNELS) + CFG_BLE_MBLOCK_COUNT_MARGIN)

/**
 * Macro to calculate the RAM needed by the stack according the number of links,
 * memory blocks, advertising data sets and all the other initialization
 * parameters.
 */
#define BLE_DYN_ALLOC_SIZE (BLE_STACK_TOTAL_BUFFER_SIZE(CFG_BLE_NUM_RADIO_TASKS,\
                                                        CFG_BLE_NUM_EATT_CHANNELS,\
                                                        CFG_BLE_NUM_GATT_ATTRIBUTES,\
                                                        CFG_BLE_NUM_OF_CONCURRENT_GATT_CLIENT_PROC,\
                                                        CFG_BLE_MBLOCKS_COUNT,\
                                                        CFG_BLE_NUM_ADV_SETS,\
                                                        CFG_BLE_NUM_PAWR_SUBEVENTS,\
                                                        CFG_BLE_PAWR_SUBEVENT_DATA_COUNT_MAX,\
                                                        CFG_BLE_NUM_AUX_SCAN_SLOTS,\
                                                        CFG_BLE_FILTER_ACCEPT_LIST_SIZE_LOG2,\
                                                        CFG_BLE_COC_NBR_MAX,\
                                                        CFG_BLE_NUM_SYNC_SLOTS,\
                                                        CFG_BLE_NUM_CTE_ANTENNA_IDS_MAX,\
                                                        CFG_BLE_NUM_CTE_IQ_SAMPLES_MAX,\
                                                        CFG_BLE_NUM_SYNC_BIG_MAX,\
                                                        CFG_BLE_NUM_BRC_BIG_MAX,\
                                                        CFG_BLE_NUM_SYNC_BIS_MAX,\
                                                        CFG_BLE_NUM_BRC_BIS_MAX,\
                                                        CFG_BLE_NUM_CIG_MAX,\
                                                        CFG_BLE_NUM_CIS_MAX,\
                                                        CFG_BLE_ISR0_FIFO_SIZE,\
                                                        CFG_BLE_ISR1_FIFO_SIZE,\
                                                        CFG_BLE_USER_FIFO_SIZE))

/* USER CODE BEGIN BLE_Stack */

/* USER CODE END BLE_Stack */

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
/******************************************************************************
 * Initialization parameters used in Network Processor mode
 ******************************************************************************/
/**
 * Network mode (used in gap_profile.c)
 */
#define CFG_BLE_NETWORK_PROC_MODE                       (1)

/**
 * Size of buffer used for ATT queued writes
 */
#define CFG_BLE_ATT_QUEUED_WRITE_SIZE                   (${myHash["CFG_BLE_ATT_QUEUED_WRITE_SIZE"]})

/**
 * Amount of RAM used to store GATT services (bytes)
 */
 #define CFG_BLE_GATT_NWK_BUFFER_SIZE                   (${myHash["CFG_BLE_GATT_NWK_BUFFER_SIZE"]})

/**
 * Amount of RAM used to store advertising data (bytes)
 */
 #define CFG_BLE_ADV_NWK_BUFFER_SIZE                    (${myHash["CFG_BLE_ADV_NWK_BUFFER_SIZE"]})

/**
 * Size of buffer shared between GATT_NWK library (used for GATT database and client
 * write procedures) and ADV_NWK library (used for advertising buffers).
 */
#define CFG_BLE_GATT_ADV_NWK_BUFFER_SIZE           (CFG_BLE_GATT_NWK_BUFFER_SIZE + CFG_BLE_ADV_NWK_BUFFER_SIZE + CFG_BLE_ATT_QUEUED_WRITE_SIZE)

/**
* Maximum number of characteristics that can be subscribed to check for security level.
*/
#define  CFG_BLE_GATT_CLT_NUM_CHARAC_SUBSCRIPTIONS_MAX        (${myHash["CFG_BLE_GATT_CLT_NUM_CHARAC_SUBSCRIPTIONS_MAX"]})

[/#if]
/******************************************************************************
 * BLE Stack modularity options
 ******************************************************************************/
#define CFG_BLE_CONTROLLER_SCAN_ENABLED                   (${myHash["CFG_BLE_CONTROLLER_SCAN_ENABLED"]}U) 
#define CFG_BLE_CONTROLLER_PRIVACY_ENABLED                (${myHash["CFG_BLE_CONTROLLER_PRIVACY_ENABLED"]}U) 
#define CFG_BLE_SECURE_CONNECTIONS_ENABLED                (${myHash["CFG_BLE_SECURE_CONNECTIONS_ENABLED"]}U) 
#define CFG_BLE_CONTROLLER_DATA_LENGTH_EXTENSION_ENABLED  (${myHash["CFG_BLE_CONTROLLER_DATA_LENGTH_EXTENSION_ENABLED"]}U) 
#define CFG_BLE_CONTROLLER_2M_CODED_PHY_ENABLED           (${myHash["CFG_BLE_CONTROLLER_2M_CODED_PHY_ENABLED"]}U)
#define CFG_BLE_CONTROLLER_EXT_ADV_SCAN_ENABLED           (${myHash["CFG_BLE_CONTROLLER_EXT_ADV_SCAN_ENABLED"]}U) 
#define CFG_BLE_L2CAP_COS_ENABLED                         (${myHash["CFG_BLE_L2CAP_COS_ENABLED"]}U) 
#define CFG_BLE_CONTROLLER_PERIODIC_ADV_ENABLED           (${myHash["CFG_BLE_CONTROLLER_PERIODIC_ADV_ENABLED"]}U)
#define CFG_BLE_CONTROLLER_PERIODIC_ADV_WR_ENABLED        (${myHash["CFG_BLE_CONTROLLER_PERIODIC_ADV_WR_ENABLED"]}U)
#define CFG_BLE_CONTROLLER_CTE_ENABLED                    (${myHash["CFG_BLE_CONTROLLER_CTE_ENABLED"]}U)
#define CFG_BLE_CONTROLLER_POWER_CONTROL_ENABLED          (${myHash["CFG_BLE_CONTROLLER_POWER_CONTROL_ENABLED"]}U) 
#define CFG_BLE_CONNECTION_ENABLED                        (${myHash["CFG_BLE_CONNECTION_ENABLED"]}U)
#define CFG_BLE_CONTROLLER_CHAN_CLASS_ENABLED             (${myHash["CFG_BLE_CONTROLLER_CHAN_CLASS_ENABLED"]}U)
#define CFG_BLE_CONTROLLER_BIS_ENABLED                    (${myHash["CFG_BLE_CONTROLLER_BIS_ENABLED"]}U)
#define CFG_BLE_CONNECTION_SUBRATING_ENABLED              (${myHash["CFG_BLE_CONNECTION_SUBRATING_ENABLED"]}U)
#define CFG_BLE_CONTROLLER_CIS_ENABLED                    (${myHash["CFG_BLE_CONTROLLER_CIS_ENABLED"]}U)

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled")]
#if CFG_BLE_PRIVACY_ENABLED
#undef CFG_BLE_CONTROLLER_PRIVACY_ENABLED
#define CFG_BLE_CONTROLLER_PRIVACY_ENABLED                (1U)
#endif

[/#if]
/******************************************************************************
 * Low Power
 *
 *  When CFG_FULL_LOW_POWER is set to 1, the system is configured in full
 *  low power mode. It means that all what can have an impact on the consumptions
 *  are powered down.(For instance LED, Access to Debugger, Etc.)
 *
 *  When CFG_LPM_SUPPORTED and CFG_FULL_LOW_EMULATED are both set to 1, the system is configured to
 *  emulate the Deepstop mode without losing the debugger connection and breakpoints nor watchpoints.
 * 
 ******************************************************************************/
 
#define CFG_FULL_LOW_POWER       (${myHash["CFG_FULL_LOW_POWER"]})

#define CFG_LPM_SUPPORTED        (${myHash["CFG_LPM_SUPPORTED"]})

#define CFG_LPM_EMULATED         (${myHash["CFG_LPM_EMULATED"]})

/**
 * Low Power configuration
 */
#if (CFG_FULL_LOW_POWER == 1)
  #undef CFG_LPM_SUPPORTED
  #define CFG_LPM_SUPPORTED      (1)
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

/*****************************************************************************
 * Traces
 * Enable or Disable traces in application
 * When CFG_DEBUG_TRACE is set, traces are activated
 *
 * Note : Refer to utilities_conf.h file in order to details
 *        the level of traces : CFG_DEBUG_TRACE_FULL or CFG_DEBUG_TRACE_LIGHT
 *****************************************************************************/
/**
 * Enable or disable debug prints.
 */
#define CFG_DEBUG_APP_TRACE             (${myHash["CFG_DEBUG_APP_TRACE"]})

/**
 * Use or not advanced trace module. UART interrupts to be enabled.
 */
#define CFG_DEBUG_APP_ADV_TRACE         (${myHash["CFG_DEBUG_APP_ADV_TRACE"]})

#define ADV_TRACE_TIMESTAMP_ENABLE      (${myHash["ADV_TRACE_TIMESTAMP_ENABLE"]})

#if (CFG_DEBUG_APP_TRACE == 0)
#undef CFG_DEBUG_APP_ADV_TRACE
#define CFG_DEBUG_APP_ADV_TRACE         (0)
#endif


#if (CFG_DEBUG_APP_ADV_TRACE != 0)

#include "stm32_adv_trace.h"

#define APP_DBG(...)                                      \
{                                                                 \
  UTIL_ADV_TRACE_COND_FSend(VLEVEL_L, ~0x0, ADV_TRACE_TIMESTAMP_ENABLE, __VA_ARGS__); \
}
#else
#define APP_DBG(...) printf(__VA_ARGS__)
#endif

#if (CFG_DEBUG_APP_TRACE != 0)
#include <stdio.h>
#define APP_DBG_MSG             APP_DBG
#else
#define APP_DBG_MSG(...)
#endif

/* USER CODE BEGIN Traces */

/* USER CODE END Traces */

/******************************************************************************
 * Sequencer
 ******************************************************************************/

/**
 * These are the lists of task id registered to the sequencer
 * Each task id shall be in the range [0:31]
 */
typedef enum
{
  CFG_TASK_BLE_STACK,
  CFG_TASK_VTIMER,
  CFG_TASK_NVM,
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
  CFG_TASK_DISCOVER_SERVICES_ID,
[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
  CFG_TASK_TM,
  CFG_TASK_BURST,
[/#if]
  /* USER CODE BEGIN CFG_Task_Id_t */

  /* USER CODE END CFG_Task_Id_t */
  CFG_TASK_NBR,  /**< Shall be LAST in the list */
} CFG_Task_Id_t;

/* USER CODE BEGIN DEFINE_TASK */

/* USER CODE END DEFINE_TASK */

/**
 * This is the list of priority required by the application
 * Each Id shall be in the range 0..31
 */
typedef enum
{
  CFG_SEQ_PRIO_0,
  CFG_SEQ_PRIO_1,
  /* USER CODE BEGIN CFG_SEQ_Prio_Id_t */

  /* USER CODE END CFG_SEQ_Prio_Id_t */
  CFG_SEQ_PRIO_NBR
} CFG_SEQ_Prio_Id_t;

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Disabled")]
/**
 * This is a bit mapping over 32bits listing all events id supported in the application
 */
typedef enum
{
  CFG_IDLEEVT_PROC_GAP_COMPLETE,
[#if (myHash["BLE_MODE_CENTRAL"] != "Disabled")]
  CFG_IDLEEVT_PROC_GATT_COMPLETE,
[/#if]
  /* USER CODE BEGIN CFG_IdleEvt_Id_t */

  /* USER CODE END CFG_IdleEvt_Id_t */
} CFG_IdleEvt_Id_t;
[/#if]


/******************************************************************************
 * RT GPIO debug module configuration
 ******************************************************************************/

#define RT_DEBUG_GPIO_MODULE         (${myHash["RT_DEBUG_GPIO_MODULE"]})


/* USER CODE BEGIN Defines */

/* USER CODE END Defines */

#endif /*APP_CONF_H */
