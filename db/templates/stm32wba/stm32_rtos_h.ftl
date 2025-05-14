[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    stm32_rtos.h
  * @author  MCD Application Team
  * @brief   Include file for all RTOS/Sequencer can be used on WBA
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign myHash = {}]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#assign myHash = {definition.name:definition.value} + myHash]
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
#ifndef STM32_RTOS_H
#define STM32_RTOS_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
#include "stm32_seq.h"
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
#include "tx_api.h"
#include "tx_initialize.h"
#include "tx_thread.h"  
#include "app_threadx.h"
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
#include "cmsis_os2.h"
#include "app_freertos.h"
#include "task.h"
[/#if]
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
/* Sequencer priorities by default  */
#define TASK_PRIO_RNG                           CFG_SEQ_PRIO_0
#define TASK_PRIO_LINK_LAYER                    CFG_SEQ_PRIO_0
[#if (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")]
#define TASK_PRIO_ALARM                         CFG_SEQ_PRIO_1
#define TASK_PRIO_US_ALARM                      TASK_PRIO_ALARM
#define TASK_PRIO_TASKLETS                      CFG_SEQ_PRIO_0
#define TASK_PRIO_UART                          CFG_SEQ_PRIO_1
#define TASK_PRIO_PKA                           CFG_SEQ_PRIO_1
#define TASK_PRIO_RCP_SPINEL_RX                 CFG_SEQ_PRIO_1
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
#define TASK_PRIO_MAC_LAYER                     CFG_SEQ_PRIO_1
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled")]
#define TASK_PRIO_ZIGBEE_LAYER                  CFG_SEQ_PRIO_1
#define TASK_PRIO_ZIGBEE_NETWORK_FORM           CFG_SEQ_PRIO_1
#define TASK_PRIO_ZIGBEE_APP_START              CFG_SEQ_PRIO_1
[/#if]
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
/* FreeRTOS priorities by default  */
#define TASK_PRIO_LINK_LAYER                    osPriorityRealtime2
#define TASK_PRIO_TEMP_MEAS_LL                  osPriorityRealtime2
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
#define TASK_PRIO_AMM                           osPriorityNormal
[/#if]
#define TASK_PRIO_RNG                           osPriorityHigh
[#if (myHash["BLE"] == "Enabled")]
#define TASK_PRIO_FLASH_MANAGER                 osPriorityNormal
#define TASK_PRIO_BLE_HOST                      osPriorityNormal
#define TASK_PRIO_HCI_ASYNC_EVENT               osPriorityNormal
#define TASK_PRIO_BLE_TIMER                     osPriorityNormal
#define TASK_PRIO_BPKA                          osPriorityNormal
[/#if]

[#if (myHash["ZIGBEE"] == "Enabled")]
#define TASK_PRIO_ZIGBEE_LAYER                  osPriorityRealtime1
#define TASK_PRIO_MAC_LAYER                     osPriorityRealtime3
#define TASK_PRIO_ZIGBEE_NETWORK_FORM           osPriorityNormal
#define TASK_PRIO_ZIGBEE_APP_START              osPriorityBelowNormal
[/#if]
[#if (myHash["THREAD"] == "Enabled")]
#define TASK_PRIO_ALARM                         osPriorityNormal2
#define TASK_PRIO_US_ALARM                      TASK_PRIO_ALARM
#define TASK_PRIO_TASKLETS                      osPriorityRealtime3
#define TASK_PRIO_PKA                           osPriorityNormal1 
#define TASK_PRIO_CLI_UART                      osPriorityNormal
#define TASK_PRIO_SEND                          osPriorityNormal 
#define TASK_PRIO_RCP_SPINEL_RX                 osPriorityNormal
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
/* ThreadX priorities by default  */
#define TASK_PRIO_LINK_LAYER                    (7u)
#define TASK_PREEMP_LINK_LAYER                  (0u)

#define TASK_PRIO_TEMP_MEAS_LL                  (7u)
#define TASK_PREEMP_TEMP_MEAS_LL                (0u)

[#if (myHash["CFG_MM_TYPE"]?number == 2)]
#define TASK_PRIO_AMM                           (15u)
#define TASK_PREEMP_AMM                         (0u)

[/#if]
#define TASK_PRIO_RNG                           (11u)
#define TASK_PREEMP_RNG                         (0u)
[#if (myHash["BLE"] == "Enabled")]

#define TASK_PRIO_FLASH_MANAGER                 (11u)
#define TASK_PREEMP_FLASH_MANAGER               (0u)

#define TASK_PRIO_BLE_HOST                      (15u)
#define TASK_PREEMP_BLE_HOST                    (0u)

#define TASK_PRIO_HCI_ASYNC_EVENT               (15u)
#define TASK_PREEMP_HCI_ASYNC_EVENT             (0u)

#define TASK_PRIO_BLE_TIMER                     (15u)
#define TASK_PREEMP_BLE_TIMER                   (0u)

#define TASK_PRIO_BPKA                          (15u)
#define TASK_PREEMP_BPKA                        (0u)

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
#define TASK_PRIO_TX_TO_HOST                    (15u)
#define TASK_PREEMP_TX_TO_HOST                  (0u)

[/#if]
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled")]
#define TASK_PRIO_MAC_LAYER                     (5u)
#define TASK_PREEMP_MAC_LAYER                   (0u)

#define TASK_PRIO_ZIGBEE_LAYER                  (9u)
#define TASK_PREEMP_ZIGBEE_LAYER                (0u)

#define TASK_PRIO_ZIGBEE_NETWORK_FORM           (16u)
#define TASK_PREEMP_ZIGBEE_NETWORK_FORM         (0u)

#define TASK_PRIO_ZIGBEE_APP_START              (17u)
#define TASK_PREEMP_ZIGBEE_APP_START            (0u)
[/#if]
[#if (myHash["THREAD"] == "Enabled")]
#define TASK_PRIO_ALARM                         (6u)
#define TASK_PREEMP_ALARM                       (6u)

#define TASK_PRIO_US_ALARM                      TASK_PRIO_ALARM
#define TASK_PREEMP_US_ALARM                    TASK_PRIO_ALARM

#define TASK_PRIO_TASKLETS                      (5u)
#define TASK_PREEMP_TASKLETS                    (5u)

#define TASK_PRIO_PKA                           (10u) 
#define TASK_PREEMP_PRIO_PKA                    (10u)

#define TASK_PRIO_RCP_SPINEL_RX					(11u)
#define TASK_PREEMP_RCP_SPINEL_RX				(11u)

#define TASK_PRIO_CLI_UART                      (12u)
#define TASK_PREEMP_CLI_UART                    (12u)

#define TASK_PRIO_SEND                          (13u) 
#define TASK_PREEMP_PRIO_SEND                   (13u)
[/#if]
[/#if]

/* USER CODE BEGIN TASK_Priority_Define */

/* USER CODE END TASK_Priority_Define */

[#if (myHash["FREERTOS_STATUS"]?number == 1) || (myHash["THREADX_STATUS"]?number == 1) ]
#define RTOS_MAX_THREAD                         (20u)
  
#define RTOS_STACK_SIZE_LARGE                   ( 1024u * 3u )
#define RTOS_STACK_SIZE_MODERATE                ( 2048u )
#define RTOS_STACK_SIZE_NORMAL                  ( 1024u )
#define RTOS_STACK_SIZE_REDUCED                 ( 512u )
#define RTOS_STACK_SIZE_SMALL                   ( 256u )
#define RTOS_STACK_SIZE_TINY                    ( configMINIMAL_STACK_SIZE )

/* Tasks stack sizes by default  */
#define TASK_STACK_SIZE_LINK_LAYER              RTOS_STACK_SIZE_LARGE
#define TASK_STACK_SIZE_TEMP_MEAS_LL            RTOS_STACK_SIZE_REDUCED
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
#define TASK_STACK_SIZE_AMM                     RTOS_STACK_SIZE_REDUCED
[/#if]
#define TASK_STACK_SIZE_RNG                     RTOS_STACK_SIZE_REDUCED
[#if (myHash["BLE"] == "Enabled")]
#define TASK_STACK_SIZE_FLASH_MANAGER           RTOS_STACK_SIZE_NORMAL
#define TASK_STACK_SIZE_BLE_HOST                RTOS_STACK_SIZE_MODERATE
#define TASK_STACK_SIZE_HCI_ASYNC_EVENT         RTOS_STACK_SIZE_NORMAL
#define TASK_STACK_SIZE_BLE_TIMER               RTOS_STACK_SIZE_REDUCED
#define TASK_STACK_SIZE_BPKA                    RTOS_STACK_SIZE_REDUCED
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
#define TASK_STACK_SIZE_TX_TO_HOST              RTOS_STACK_SIZE_NORMAL
[/#if]
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled")]
#define TASK_STACK_SIZE_MAC_LAYER               RTOS_STACK_SIZE_MODERATE
#define TASK_STACK_SIZE_ZIGBEE_LAYER            RTOS_STACK_SIZE_LARGE
#define TASK_STACK_SIZE_ZIGBEE_NETWORK_FORM     RTOS_STACK_SIZE_LARGE
#define TASK_STACK_SIZE_ZIGBEE_APP_START        RTOS_STACK_SIZE_NORMAL
[/#if]
[#if (myHash["THREAD"] == "Enabled")]
#define TASK_STACK_SIZE_ALARM                   RTOS_STACK_SIZE_MODERATE
#define TASK_STACK_SIZE_ALARM_US                RTOS_STACK_SIZE_NORMAL
#define TASK_STACK_SIZE_TASKLETS                RTOS_STACK_SIZE_LARGE
#define TASK_STACK_SIZE_CLI_UART                RTOS_STACK_SIZE_NORMAL
#define TASK_STACK_SIZE_SEND                    RTOS_STACK_SIZE_NORMAL 
#define TASK_STACK_SIZE_PKA                     RTOS_STACK_SIZE_NORMAL  
#define TASK_STACK_SIZE_RCP_SPINEL_RX           RTOS_STACK_SIZE_NORMAL 
[/#if]
/* USER CODE BEGIN TASK_Size_Define */

/* USER CODE END TASK_Size_Define */

[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
/* Attributes needed by CMSIS */
#define TASK_DEFAULT_ATTR_BITS                  ( 0u )
#define TASK_DEFAULT_CB_MEM                     ( 0u )
#define TASK_DEFAULT_CB_SIZE                    ( 0u )
#define TASK_DEFAULT_STACK_MEM                  ( 0u )
  
#define SEMAPHORE_DEFAULT_ATTR_BITS             ( 0u )
#define SEMAPHORE_DEFAULT_CB_MEM                ( 0u )
#define SEMAPHORE_DEFAULT_CB_SIZE               ( 0u )

#define MUTEX_DEFAULT_ATTR_BITS                 ( 0u )
#define MUTEX_DEFAULT_CB_MEM                    ( 0u )
#define MUTEX_DEFAULT_CB_SIZE                   ( 0u )

/* USER CODE BEGIN Attributes_Define */

/* USER CODE END Attributes_Define */

[/#if]
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macros -----------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported variables --------------------------------------------------------*/
[#if myHash["THREADX_STATUS"]?number == 1 ]
extern TX_BYTE_POOL       *pBytePool;   /* ThreadX byte pool pointer for whole WPAN middleware */

[/#if]
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif // STM32_RTOS_H
