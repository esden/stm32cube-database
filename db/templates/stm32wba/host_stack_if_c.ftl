[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    host_stack_if.c
  * @author  MCD Application Team
  * @brief : Source file for the stack tasks
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

/* Includes ------------------------------------------------------------------*/
#include "host_stack_if.h"
#include "app_conf.h"
#include "ll_sys.h"
[#if (myHash["BLE"] == "Enabled")]
#include "app_ble.h"
#include "auto/ble_raw_api.h"
[/#if]
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
#include "stm32_seq.h"
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
#include "app_threadx.h"
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
#include "cmsis_os2.h"
[/#if]
[#if myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled" ]
#include "skel_ble.h"
[/#if]

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables --------------------------------------------------------*/
[#if (myHash["BLE"] == "Enabled")]
/**
  * @brief  Missed HCI event flag
  */
extern uint8_t missed_hci_event_flag;
[/#if]
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* External function prototypes -----------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
/* Trigger BLE Host stack process after calling any aci/hci functions */
#define BLE_WRAP_POSTPROC BleStackCB_Process()
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
/* Release Link Layer Mutex before calling any aci/hci functions */
#define BLE_WRAP_PREPROC tx_mutex_get(&LinkLayerMutex, TX_WAIT_FOREVER)

/* Release Link Layer Mutex and Trigger BLE Host stack process after calling any aci/hci functions */
#define BLE_WRAP_POSTPROC do{ \
                              tx_mutex_put(&LinkLayerMutex);  \
                              BleStackCB_Process(); \
                            }while(0)
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
/* Release Link Layer Mutex before calling any aci/hci functions */
#define BLE_WRAP_PREPROC osMutexAcquire(LinkLayerMutex, osWaitForever)

/* Release Link Layer Mutex and Trigger BLE Host stack process after calling any aci/hci functions */
#define BLE_WRAP_POSTPROC do{ \
                              osMutexRelease(LinkLayerMutex);  \
                              BleStackCB_Process(); \
                            }while(0)
[/#if]

[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled") || (myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled")]
/**
  * @brief  Host stack processing request from Link Layer.
  * @param  None
  * @retval None
  */
void HostStack_Process(void)
{
  /* USER CODE BEGIN HostStack_Process 0 */

  /* USER CODE END HostStack_Process 0 */

  /* Process BLE Host stack */
  BleStackCB_Process();

  /* USER CODE BEGIN HostStack_Process 1 */

  /* USER CODE END HostStack_Process 1 */
}

/**
  * @brief  BLE Host stack processing callback.
  * @param  None
  * @retval None
  */
void BleStackCB_Process(void)
{
  /* USER CODE BEGIN BleStackCB_Process 0 */

  /* USER CODE END BleStackCB_Process 0 */
[#if myHash["BLE_MODE_SKELETON"] == "Enabled" ]

[#elseif myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled" ]
  Ble_HostStack_Process();
[#else]
  if (missed_hci_event_flag)
  {
    missed_hci_event_flag = 0;
    HCI_HARDWARE_ERROR_EVENT(0x03);
  }
  /* BLE Host stack processing through background task */
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask( 1U << CFG_TASK_BLE_HOST, CFG_SEQ_PRIO_0);

[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_put(&BleHostSemaphore);

[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
  osSemaphoreRelease(BleHostSemaphore);

[/#if]
[/#if]
  /* USER CODE BEGIN BleStackCB_Process 1 */

  /* USER CODE END BleStackCB_Process 1 */
}
[/#if]