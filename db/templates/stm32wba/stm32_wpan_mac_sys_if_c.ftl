[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    mac_sys_if.c
  * @author  MCD Application Team
  * @brief   Source file for using MAC Layer with a RTOS
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2025 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
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

#include "main.h"
#include "app_common.h"
#include "app_conf.h"
#include "log_module.h"
#include "stm32_rtos.h"
#include "st_mac_802_15_4_sys.h"

extern void mac_baremetal_run(void);

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macros ------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
[#if myHash["THREADX_STATUS"]?number == 1 ]
static TX_SEMAPHORE     stMacLayerTaskSemaphore, stMacLayerEventSemaphore;
static TX_THREAD        stMacLayerThread;
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
/* FreeRTOS objects declaration */

static osThreadId_t     stMacLayerTaskHandle;
static osSemaphoreId_t  stMacLayerTaskSemaphore, stMacLayerEventSemaphore;

/* FreeRtos MacLayer stacks attributes */
const osThreadAttr_t stMacLayerTask_attributes = 
{
  .name         = "MacLayer Task",
  .priority     = TASK_PRIO_MAC_LAYER,
  .stack_size   = TASK_STACK_SIZE_MAC_LAYER,
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM
};

const osSemaphoreAttr_t stMacLayerTaskSemaphore_attributes = 
{
  .name         = "MacLayer Task Semaphore",
  .attr_bits    = SEMAPHORE_DEFAULT_ATTR_BITS,
  .cb_mem       =  SEMAPHORE_DEFAULT_CB_MEM,
  .cb_size      =  SEMAPHORE_DEFAULT_CB_SIZE
};

const osSemaphoreAttr_t stMacLayerEventSemaphore_attributes = 
{
  .name         = "MacLayer Event Semaphore",
  .attr_bits    = SEMAPHORE_DEFAULT_ATTR_BITS,
  .cb_mem       = SEMAPHORE_DEFAULT_CB_MEM,
  .cb_size      = SEMAPHORE_DEFAULT_CB_SIZE
};

[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Global variables ----------------------------------------------------------*/
/* USER CODE BEGIN GV */

/* USER CODE END GV */

/* Functions Definition ------------------------------------------------------*/

[#if myHash["THREADX_STATUS"]?number == 1 ]
/**
 * @brief  Mac Layer Task for ThreadX
 * @param  lArgument  Argument passed the first time.
 * @retval None
 */
static void MacSys_Process( ULONG lArgument ) 
{
  UNUSED( lArgument );
  
  for (;;)
  {
    tx_semaphore_get( &stMacLayerTaskSemaphore, TX_WAIT_FOREVER );
    mac_baremetal_run();
  }
}

[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
/**
 * @brief  Mac Layer Task for FreeRTOS
 * @param  void *argument
 * @retval None
 */
static void MacSys_Task_Entry( void * argument )
{
  UNUSED( argument );
  
  for (;;)
  {
    osSemaphoreAcquire( stMacLayerTaskSemaphore, osWaitForever );
    mac_baremetal_run();
  }
}

[/#if]
/**
  * @brief  Mac Layer Initialisation
  * @param  None
  * @retval None
  */
void MacSys_Init(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  /* Register tasks */
  UTIL_SEQ_RegTask( TASK_MAC_LAYER, UTIL_SEQ_RFU, mac_baremetal_run);
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  UINT    lThreadXStatus;
  CHAR    * pStack = TX_NULL;

  /* Create the Mac Layer Task Semaphore.*/
  lThreadXStatus = tx_semaphore_create( &stMacLayerTaskSemaphore, "MacLayerTaskSemaphore", 0 );
  if ( lThreadXStatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "ERROR THREADX : MAC LAYER TASK SEMAPHORE CREATION FAILED (%d)", lThreadXStatus );
    Error_Handler();
  }

  /* Create the Mac Layer Thread and this Stack */
  lThreadXStatus = tx_byte_allocate( pBytePool, (void **)&pStack, TASK_STACK_SIZE_MAC_LAYER, TX_NO_WAIT);
  if ( lThreadXStatus == TX_SUCCESS )
  {
    lThreadXStatus = tx_thread_create( &stMacLayerThread, "MacLayerTaskId", MacSys_Process, 0, pStack,
                                        TASK_STACK_SIZE_MAC_LAYER, TASK_PRIO_MAC_LAYER, TASK_PREEMP_MAC_LAYER,
                                        TX_NO_TIME_SLICE, TX_AUTO_START);
  }
  if ( lThreadXStatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "ERROR THREADX : MAC LAYER TASK CREATION FAILED (%d)", lThreadXStatus );
    Error_Handler();
  }

  /* Create the Mac Layer Event Semaphore. */
  lThreadXStatus = tx_semaphore_create( &stMacLayerEventSemaphore, "MacLayerEventSemaphore", 0 );
  if ( lThreadXStatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "ERROR THREADX : EVENT MAC LAYER EVENT SEMAPHORE CREATION FAILED (%d)", lThreadXStatus );
    Error_Handler();
  }
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  /* Create MacLayer FreeRTOS objects */
  stMacLayerTaskSemaphore = osSemaphoreNew( 1, 0, &stMacLayerTaskSemaphore_attributes ); 
  stMacLayerEventSemaphore = osSemaphoreNew( 1, 0, &stMacLayerEventSemaphore_attributes ); 
  
  stMacLayerTaskHandle = osThreadNew( MacSys_Task_Entry, NULL, &stMacLayerTask_attributes );
  
  if ( ( stMacLayerTaskHandle == NULL ) || ( stMacLayerTaskSemaphore == NULL ) || ( stMacLayerEventSemaphore == NULL ) )
  {
    LOG_ERROR_APP( "MacLayer FreeRTOS objects creation FAILED" );
    Error_Handler();
  }
[/#if]
}

/**
  * @brief  Mac Layer Resume
  * @param  None
  * @retval None
  */
void MacSys_Resume(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_ResumeTask( TASK_MAC_LAYER );
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  tx_thread_resume( &stMacLayerThread );
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  osThreadResume( stMacLayerTaskHandle );
[/#if]
}

/**
  * @brief  MAC Layer set Task. 
  * @param  None
  * @retval None
  */
void MacSys_SemaphoreSet(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask( TASK_MAC_LAYER, TASK_PRIO_MAC_LAYER );
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  if ( stMacLayerTaskSemaphore.tx_semaphore_count == 0 )
  {
    tx_semaphore_put( &stMacLayerTaskSemaphore );
  }
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  if ( osSemaphoreGetCount( stMacLayerTaskSemaphore ) == 0 )
  {
    osSemaphoreRelease( stMacLayerTaskSemaphore );
  }
[/#if]
}

/**
  * @brief  MAC Layer Task wait.
  * @param  None
  * @retval None
  */
void MacSys_SemaphoreWait( void )
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  /* Not used */
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_get( &stMacLayerTaskSemaphore, TX_WAIT_FOREVER );
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  osSemaphoreAcquire( stMacLayerTaskSemaphore, osWaitForever );
[/#if]
}

/**
  * @brief  MAC Layer set Event. 
  * @param  None
  * @retval None
  */
void MacSys_EventSet( void )
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetEvt( EVENT_MAC_LAYER );
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  if ( stMacLayerEventSemaphore.tx_semaphore_count == 0 )
  {
    tx_semaphore_put( &stMacLayerEventSemaphore );
  }
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  if ( osSemaphoreGetCount( stMacLayerEventSemaphore ) == 0 )
  {
    osSemaphoreRelease( stMacLayerEventSemaphore );
  }
[/#if]
}

/**
  * @brief  MAC Layer wait Event. 
  * @param  None
  * @retval None
  */
void MacSys_EventWait( void )
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_WaitEvt( EVENT_MAC_LAYER );
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_get( &stMacLayerEventSemaphore, TX_WAIT_FOREVER );
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  osSemaphoreAcquire( stMacLayerEventSemaphore, osWaitForever );
[/#if]
}

