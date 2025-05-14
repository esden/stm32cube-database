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
#include "app_threadx.h"
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
#include "app_freertos.h"
[/#if]
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
/* Sequencer priorities by default  */
#define CFG_TASK_PRIO_HW_RNG                    CFG_SEQ_PRIO_0
#define CFG_TASK_PRIO_LINK_LAYER                CFG_SEQ_PRIO_0
[#if (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")]
#define CFG_TASK_PRIO_ALARM                     CFG_SEQ_PRIO_1
#define CFG_TASK_PRIO_US_ALARM                  CFG_TASK_PRIO_ALARM
#define CFG_TASK_PRIO_TASKLETS                  CFG_SEQ_PRIO_0
#define CFG_TASK_PRIO_UART                      CFG_SEQ_PRIO_1
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
#define CFG_TASK_PRIO_MAC_LAYER                 CFG_SEQ_PRIO_1
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled")]
#define CFG_TASK_PRIO_ZIGBEE_LAYER              CFG_SEQ_PRIO_1

#define CFG_TASK_PRIO_ZIGBEE_NETWORK_FORM       CFG_SEQ_PRIO_1
#define CFG_TASK_PRIO_ZIGBEE_APP_START          CFG_SEQ_PRIO_1
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
/* ThreadX priorities by default  */
#define CFG_TASK_PRIO_MAC_LAYER                 5u
#define CFG_TASK_PREEMP_MAC_LAYER               0u

#define CFG_TASK_PRIO_LINK_LAYER                7u
#define CFG_TASK_PREEMP_LINK_LAYER              0u

#define CFG_TASK_PRIO_LINK_LAYER_TEMP           7u
#define CFG_TASK_PREEMP_LINK_LAYER_TEMP         0u

#define CFG_TASK_PRIO_ZIGBEE_LAYER              9u
#define CFG_TASK_PREEMP_ZIGBEE_LAYER            0u

#define CFG_TASK_PRIO_HW_RNG                    11u
#define CFG_TASK_PREEMP_HW_RNG                  0u

#define CFG_TASK_PRIO_ZIGBEE_NETWORK_FORM       16u
#define CFG_TASK_PREEMP_ZIGBEE_NETWORK_FORM     0u

#define CFG_TASK_PRIO_ZIGBEE_APP_START          17u
#define CFG_TASK_PREEMP_ZIGBEE_APP_START        0u
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
/* FreeRTOS priorities by default  */
#define CFG_TASK_PRIO_MAC_LAYER                 osPriorityRealtime3
#define CFG_TASK_PRIO_LINK_LAYER                osPriorityRealtime2
#define CFG_TASK_PRIO_LINK_LAYER_TEMP           osPriorityRealtime2
#define CFG_TASK_PRIO_ZIGBEE_LAYER              osPriorityRealtime1
#define CFG_TASK_PRIO_HW_RNG                    osPriorityHigh

#define CFG_TASK_PRIO_ZIGBEE_NETWORK_FORM       osPriorityNormal
#define CFG_TASK_PRIO_ZIGBEE_APP_START          osPriorityBelowNormal
[/#if]

/* USER CODE BEGIN TASK_Priority_Define */

/* USER CODE END TASK_Priority_Define */

[#if (myHash["FREERTOS_STATUS"]?number == 1) || (myHash["THREADX_STATUS"]?number == 1) ]
#define RTOS_MAX_THREAD                         20u
  
#define RTOS_STACK_SIZE_LARGE                   ( 1024u * 3u )
#define RTOS_STACK_SIZE_ENHANCED                ( 1024u * 2u )
#define RTOS_STACK_SIZE_NORMAL                  ( 1024u )
#define RTOS_STACK_SIZE_REDUCED                 ( 512u )
#define RTOS_STACK_SIZE_SMALL                   ( 384u )

/* Tasks stack sizes by default  */
#define TASK_LINK_LAYER_STACK_SIZE              RTOS_STACK_SIZE_LARGE
#define TASK_LINK_LAYER_TEMP_STACK_SIZE         RTOS_STACK_SIZE_REDUCED
#define TASK_MAC_LAYER_STACK_SIZE               RTOS_STACK_SIZE_ENHANCED
#define TASK_ZIGBEE_LAYER_STACK_SIZE            RTOS_STACK_SIZE_LARGE
#define TASK_HW_RNG_STACK_SIZE                  RTOS_STACK_SIZE_REDUCED
#define TASK_ZIGBEE_NETWORK_FORM_STACK_SIZE     RTOS_STACK_SIZE_LARGE
#define TASK_ZIGBEE_APP_START_STACK_SIZE        RTOS_STACK_SIZE_NORMAL
/* USER CODE BEGIN TASK_Size_Define */

/* USER CODE END TASK_Size_Define */

[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
/* Attributes needed by CMSIS */
#define TASK_DEFAULT_ATTR_BITS                  ( 0u )
#define TASK_DEFAULT_CB_MEM                     ( 0u )
#define TASK_DEFAULT_CB_SIZE                    (  0u )
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
extern TX_MUTEX           LinkLayerMutex;

[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
extern osMutexId_t        LinkLayerMutex;

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
