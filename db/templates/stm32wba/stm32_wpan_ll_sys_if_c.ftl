[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ll_sys_if.c
  * @author  MCD Application Team
  * @brief   Source file for initiating system
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

#include "app_common.h"
#include "main.h"
#include "ll_intf.h"
#include "ll_sys.h"
#include "ll_sys_if.h"
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
#include "stm32_seq.h"
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
#include "app_threadx.h"
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
#include "app_freertos.h"
[/#if]
[#else]
#include "stm32_rtos.h"
[/#if]
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
#include "adc_ctrl.h"
#endif /* (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1) */
[/#if]

/* Private defines -----------------------------------------------------------*/
[#if (myHash["BLE"] == "Enabled") ]

[#if myHash["THREADX_STATUS"]?number == 1 ]
/* LINK_LAYER_TASK related defines */
#define TASK_LINK_LAYER_STACK_SIZE          (256*7)
#define CFG_TASK_PRIO_LINK_LAYER            (15)
#define CFG_TASK_PREEMP_LINK_LAYER          (0)
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]

/* LINK_LAYER_TEMP_MEAS_TASK related defines */
#define TASK_LINK_LAYER_TEMP_STACK_SIZE     (256*7)
#define CFG_TASK_PRIO_LINK_LAYER_TEMP       (15)
#define CFG_TASK_PREEMP_LINK_LAYER_TEMP     (0)
[/#if]
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
/* LINK_LAYER_TASK related defines */
#define LINK_LAYER_TASK_STACK_SIZE          (64*7)
#define LINK_LAYER_TASK_PRIO                (27)
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]

/* LINK_LAYER_TEMP_MEAS_TASK related defines */
#define LINK_LAYER_TEMP_MEAS_TASK_STACK_SIZE    (64*7)
#define LINK_LAYER_TEMP_MEAS_TASK_PRIO          (27)
[/#if]
[/#if]

[/#if]
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macros ------------------------------------------------------------*/
[#if myHash["OTHER_THAN_BLE"]?number == 1 ]

/* Redefine access to Low Level API to maintain compatibility */
extern uint32_t llhwc_cmn_sys_configure_ll_ctx          (uint8_t param1, uint8_t param2);
extern uint8_t  ll_tx_pwr_if_select_tx_power_mode       (uint8_t param1);

#define ll_intf_config_ll_ctx_params(A, B)              llhwc_cmn_sys_configure_ll_ctx(A, B)
#define ll_intf_select_tx_power_table(A)                ll_tx_pwr_if_select_tx_power_mode(A)
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]

#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
extern uint8_t  llhwc_cmn_set_temperature_value         (uint16_t param1);
extern void     llhwc_cmn_set_temperature_sensor_state  (void);

#define ll_intf_set_temperature_value(A)                llhwc_cmn_set_temperature_value(A)
#define ll_intf_set_temperature_sensor_state()          llhwc_cmn_set_temperature_sensor_state()
#endif /* (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1) */
[/#if]

[/#if]
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private constants ---------------------------------------------------------*/
/* USER CODE BEGIN PC */

/* USER CODE END PC */

/* Private variables ---------------------------------------------------------*/
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
/* LINK_LAYER_TEMP_MEAS_TASK related resources */
static TX_SEMAPHORE     LinkLayerMeasSemaphore;
static TX_THREAD        LinkLayerMeasThread;

[/#if]
/* Link Layer Task related resources */
static TX_SEMAPHORE     LinkLayerSemaphore;
static TX_THREAD        LinkLayerThread;

[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
/* LINK_LAYER_TEMP_MEAS_TASK related resources */
SemaphoreHandle_t       LinkLayerMeasSemaphore;
TaskHandle_t            LinkLayerMeasThread;

[/#if]
/* LINK_LAYER_TASK related resources */
SemaphoreHandle_t       LinkLayerSemaphore;
TaskHandle_t            LinkLayerThread;

[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Global variables ----------------------------------------------------------*/
[#if myHash["THREADX_STATUS"]?number == 1 ]

/* Link Layer Task related resources */
TX_MUTEX                LinkLayerMutex;

[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

/* LINK_LAYER_TASK related resources */
SemaphoreHandle_t       LinkLayerMutex;

[/#if]
/* USER CODE BEGIN GV */

/* USER CODE END GV */

/* Private functions prototypes-----------------------------------------------*/
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
static void ll_sys_bg_temperature_measurement_init(void);
static void request_temperature_measurement(void);
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
[/#if]

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* External variables --------------------------------------------------------*/

/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Functions Definition ------------------------------------------------------*/

[#if myHash["THREADX_STATUS"]?number == 1 ]
/**
 * @brief  Link Layer Task for ThreadX
 * @param  None
 * @retval None
 */
static void ll_sys_bg_process_task( ULONG thread_input )
{
  UNUSED( thread_input );
  
  for(;;)
  {
[#if (myHash["BLE"] == "Enabled")]
    tx_semaphore_get(&LinkLayerSemaphore, TX_WAIT_FOREVER);
    tx_mutex_get(&LinkLayerMutex, TX_WAIT_FOREVER);
    ll_sys_bg_process();
    tx_mutex_put(&LinkLayerMutex);
    tx_thread_relinquish();
[#else]
    tx_semaphore_get( &LinkLayerSemaphore, TX_WAIT_FOREVER );
    ll_sys_bg_process();
[/#if]
  }
}

[/#if]
/**
  * @brief  Link Layer background process initialization
  * @param  None
  * @retval None
  */
void ll_sys_bg_process_init(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  /* Tasks creation */
  UTIL_SEQ_RegTask(1U << CFG_TASK_LINK_LAYER, UTIL_SEQ_RFU, ll_sys_bg_process);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  UINT  ThreadXStatus;
  CHAR  * pStack = TX_NULL;

  /* Register LinkLayer Semaphore */
  ThreadXStatus = tx_semaphore_create( &LinkLayerSemaphore, "LinkLayerSem", 0 );
  if ( ThreadXStatus != TX_SUCCESS )
  { 
    LOG_ERROR_APP( "ERROR THREADX : LINK LAYER SEMAPHORE CREATION FAILED (%d)", ThreadXStatus );
    Error_Handler();
  }

  /* Register LinkLayer Mutex */
  ThreadXStatus = tx_mutex_create( &LinkLayerMutex, "LinkLayerMutex", 0 ); 
  if ( ThreadXStatus != TX_SUCCESS )
  { 
    LOG_ERROR_APP( "ERROR FREERTOS : LINK LAYER MUTEX CREATION FAILED." );
    Error_Handler();
  }

  /* Thread associated with LinkLayer Task */
  ThreadXStatus = tx_byte_allocate( pBytePool, (VOID**) &pStack, TASK_LINK_LAYER_STACK_SIZE, TX_NO_WAIT );
  if ( ThreadXStatus == TX_SUCCESS )
  {
    ThreadXStatus = tx_thread_create( &LinkLayerThread, "LinkLayerThread", ll_sys_bg_process_task, 0, pStack, 
                                      TASK_LINK_LAYER_STACK_SIZE, CFG_TASK_PRIO_LINK_LAYER, CFG_TASK_PREEMP_LINK_LAYER, 
                                      TX_NO_TIME_SLICE, TX_AUTO_START );
  }
  if ( ThreadXStatus != TX_SUCCESS )
  { 
    LOG_ERROR_APP( "ERROR THREADX : LINK LAYER THREAD CREATION FAILED (%d)", ThreadXStatus );
    Error_Handler();
  }
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
  /* Tasks creation */
  LinkLayerSemaphore = xSemaphoreCreateBinary();
  if (LinkLayerSemaphore == NULL)
  {
    Error_Handler();
  }
  LinkLayerMutex = xSemaphoreCreateMutex();
  if (LinkLayerMutex == NULL)
  {
    Error_Handler();
  }
  if (xTaskCreate(ll_sys_bg_process_Entry, "LINK_LAYER_Thread",
                  LINK_LAYER_TASK_STACK_SIZE, NULL, LINK_LAYER_TASK_PRIO,
                  &LinkLayerThread) == pdFAIL)
  {
    Error_Handler();
  }
[/#if]
}

/**
  * @brief  Link Layer background process next iteration scheduling
  * @param  None
  * @retval None
  */
void ll_sys_schedule_bg_process(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_LINK_LAYER, CFG_TASK_PRIO_LINK_LAYER);
[/#if]
[#if (myHash["BLE"] == "Enabled")]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_put( &LinkLayerSemaphore );
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
  xSemaphoreGive(LinkLayerSemaphore);
[/#if]
[#else]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  if ( LinkLayerSemaphore.tx_semaphore_count == 0 )
  {
    tx_semaphore_put( &LinkLayerSemaphore );
  }
[/#if]
[/#if]
}

/**
  * @brief  Link Layer background process next iteration scheduling from ISR
  * @param  None
  * @retval None
  */
void ll_sys_schedule_bg_process_isr(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_LINK_LAYER, CFG_TASK_PRIO_LINK_LAYER);
[/#if]
[#if (myHash["BLE"] == "Enabled")]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_put( &LinkLayerSemaphore );
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
  static BaseType_t xHigherPriorityTaskWoken;
  xSemaphoreGiveFromISR(LinkLayerSemaphore, &xHigherPriorityTaskWoken);
  portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
[/#if]
[#else]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  if ( LinkLayerSemaphore.tx_semaphore_count == 0 )
  {
    tx_semaphore_put( &LinkLayerSemaphore );
  }
[/#if]
[/#if]
}

/**
  * @brief  Link Layer configuration phase before application startup.
  * @param  None
  * @retval None
  */
void ll_sys_config_params(void)
{
  /* Configure link layer behavior for low ISR use and next event scheduling method:
   * - SW low ISR is used.
   * - Next event is scheduled from ISR.
   */
  ll_intf_config_ll_ctx_params(USE_RADIO_LOW_ISR, NEXT_EVENT_SCHEDULING_FROM_ISR);
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]

#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
  /* Initialize link layer temperature measurement background task */
  ll_sys_bg_temperature_measurement_init();

  /* Link layer IP uses temperature based calibration instead of periodic one */
  ll_intf_set_temperature_sensor_state();
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
[/#if]

  /* Link Layer power table */
  ll_intf_select_tx_power_table(CFG_RF_TX_POWER_TABLE_ID);
}

[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
[#if myHash["THREADX_STATUS"]?number == 1 ]
/**
 * @brief  Link Layer Temperature Measurement  Task for FreeRTOS
 * @param  thread_input   Argument passed the first time.
 * @retval None
 */
static void request_temperature_measurement_task( ULONG thread_input )
{
  UNUSED( thread_input );

  for(;;)
  {
[#if (myHash["BLE"] == "Enabled")]
    tx_semaphore_get(&LinkLayerMeasSemaphore, TX_WAIT_FOREVER);
    tx_mutex_get(&LinkLayerMutex, TX_WAIT_FOREVER);
    request_temperature_measurement();
    tx_mutex_put(&LinkLayerMutex);
    tx_thread_relinquish();
[#else]
    tx_semaphore_get( &LinkLayerMeasSemaphore, TX_WAIT_FOREVER );
    request_temperature_measurement();
[/#if]
  }
}

[/#if]
/**
  * @brief  Link Layer temperature request background process initialization
  * @param  None
  * @retval None
  */
void ll_sys_bg_temperature_measurement_init(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  /* Tasks creation */
  UTIL_SEQ_RegTask(1U << CFG_TASK_LINK_LAYER_TEMP_MEAS, UTIL_SEQ_RFU, request_temperature_measurement);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  UINT  ThreadXStatus;
  CHAR  * pStack = TX_NULL;
  
  /* Register Temp Semaphore */
  ThreadXStatus = tx_semaphore_create( &LinkLayerMeasSemaphore, "LinkLayerTempSem", 0 );
  if ( ThreadXStatus != TX_SUCCESS )
  { 
    LOG_ERROR_APP( "ERROR THREADX : LINK LAYER MEAS SEMAPHORE CREATION FAILED (%d)", ThreadXStatus );
    Error_Handler();
  }
  
  /* Thread associated with LinkLayer Temp Task */
  ThreadXStatus = tx_byte_allocate( pBytePool, (VOID**) &pStack, TASK_LINK_LAYER_TEMP_STACK_SIZE, TX_NO_WAIT );
  if ( ThreadXStatus == TX_SUCCESS )
  {
    ThreadXStatus = tx_thread_create( &LinkLayerMeasThread, "LinkLayerMeasThread", request_temperature_measurement_task, 0, pStack, 
                                      TASK_LINK_LAYER_TEMP_STACK_SIZE, CFG_TASK_PRIO_LINK_LAYER_TEMP, CFG_TASK_PREEMP_LINK_LAYER_TEMP, 
                                      TX_NO_TIME_SLICE, TX_AUTO_START );
  }
  if ( ThreadXStatus != TX_SUCCESS )
  { 
    LOG_ERROR_APP( "ERROR THREADX : LINK LAYER MEAS THREAD CREATION FAILED (%d)", ThreadXStatus );
    Error_Handler();
  }
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
  /* Tasks creation */
  LinkLayerMeasSemaphore = xSemaphoreCreateBinary();
  if (LinkLayerMeasSemaphore == NULL)
  {
    Error_Handler();
  }
  if (xTaskCreate(request_temperature_measurement_Entry, "LinkLayerMeasThread",
                  LINK_LAYER_TEMP_MEAS_TASK_STACK_SIZE, NULL, LINK_LAYER_TEMP_MEAS_TASK_PRIO,
                  &LinkLayerMeasThread) == pdFAIL)
  {
    Error_Handler();
  }
[/#if]
}

/**
  * @brief  Request backroud task processing for temperature measurement
  * @param  None
  * @retval None
  */
void ll_sys_bg_temperature_measurement(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_LINK_LAYER_TEMP_MEAS, CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_put(&LinkLayerMeasSemaphore);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
  xSemaphoreGive(LinkLayerMeasSemaphore);
[/#if]
}

/**
  * @brief  Request temperature measurement
  * @param  None
  * @retval None
  */
void request_temperature_measurement(void)
{
  int16_t temperature_value = 0;

  /* Enter limited critical section : disable all the interrupts with priority higher than RCC one
   * Concerns link layer interrupts (high and SW low) or any other high priority user system interrupt
   */
  UTILS_ENTER_LIMITED_CRITICAL_SECTION(RCC_INTR_PRIO<<4);

  /* Request ADC IP activation */
  adc_ctrl_req(SYS_ADC_LL_EVT, ADC_ON);

  /* Get temperature from ADC dedicated channel */
  temperature_value = adc_ctrl_request_temperature();

  /* Request ADC IP deactivation */
  adc_ctrl_req(SYS_ADC_LL_EVT, ADC_OFF);

  /* Give the temperature information to the link layer */
  ll_intf_set_temperature_value(temperature_value);

  /* Exit limited critical section */
  UTILS_EXIT_LIMITED_CRITICAL_SECTION();
}

#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
[/#if]
