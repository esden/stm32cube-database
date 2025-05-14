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
[#assign DIE = DIE]
[#--
Key & Value:
[#list myHash?keys as key]
Key: ${key}; Value: ${myHash[key]}
[/#list]
--]

#include "main.h"
#include "app_common.h"
#include "app_conf.h"
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
#include "log_module.h"
[/#if]
#include "ll_intf_cmn.h"
#include "ll_sys.h"
#include "ll_sys_if.h"
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
#include "stm32_rtos.h"
[/#if]
#include "utilities_common.h"
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
#include "temp_measurement.h"
#endif /* (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1) */
[/#if]
[#if myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled"]
#include "skel_ble.h"
#include "stm32wbaxx_ll_system.h"
[/#if]

/* Private defines -----------------------------------------------------------*/
/* Radio event scheduling method - must be set at 1 */
#define USE_RADIO_LOW_ISR                   (1)
#define NEXT_EVENT_SCHEDULING_FROM_ISR      (1)

/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macros ------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private constants ---------------------------------------------------------*/
/* USER CODE BEGIN PC */

/* USER CODE END PC */

/* Private variables ---------------------------------------------------------*/
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
/* FreeRTOS objects declaration */

static osThreadId_t     LinkLayerTaskHandle;
static osSemaphoreId_t  LinkLayerSemaphore;

const osThreadAttr_t LinkLayerTask_attributes = {
  .name         = "Link Layer Task",
  .priority     = TASK_PRIO_LINK_LAYER,
  .stack_size   = TASK_STACK_SIZE_LINK_LAYER,
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM
};

const osSemaphoreAttr_t LinkLayerSemaphore_attributes = {
  .name         = "Link Layer Semaphore",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE
};

[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
static osThreadId_t     TempMeasLLTaskHandle;
static osSemaphoreId_t  TempMeasLLSemaphore;

const osThreadAttr_t TempMeasLLTask_attributes = {
  .name         = "Temperature Measurement LL Task",
  .priority     = TASK_PRIO_TEMP_MEAS_LL,
  .stack_size   = TASK_STACK_SIZE_TEMP_MEAS_LL,
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM
};

const osSemaphoreAttr_t TempMeasLLSemaphore_attributes = {
  .name         = "Temperature Measurement LL Semaphore",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE
};
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */

[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
/* ThreadX objects declaration */

static TX_THREAD        LinkLayerTaskHandle;
static TX_SEMAPHORE     LinkLayerSemaphore;

[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
static TX_THREAD        TempMeasLLTaskHandle;
static TX_SEMAPHORE     TempMeasLLSemaphore;

[/#if]

[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Global variables ----------------------------------------------------------*/

[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
osMutexId_t             LinkLayerMutex;

const osMutexAttr_t LinkLayerMutex_attributes = {
  .name         = "Link Layer Mutex",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE
};

[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
TX_MUTEX                LinkLayerMutex;

[/#if]
[/#if]
/* USER CODE BEGIN GV */

/* USER CODE END GV */

/* Private functions prototypes-----------------------------------------------*/
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
static void ll_sys_bg_temperature_measurement_init(void);
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
[/#if]
static void ll_sys_sleep_clock_source_selection(void);
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled")  || (myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled")]
static uint8_t ll_sys_BLE_sleep_clock_accuracy_selection(void);
[/#if]
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled")  || (myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled")]
void ll_sys_reset(void);
[/#if]

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* External variables --------------------------------------------------------*/

/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Functions Definition ------------------------------------------------------*/
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
/**
 * @brief  Link Layer Task for FreeRTOS
 * @param  void *argument
 * @retval None
 */
static void LinkLayer_Task_Entry(void *argument)
{
  UNUSED(argument);

  for(;;)
  {
[#if (myHash["BLE"] == "Enabled")]
    osSemaphoreAcquire(LinkLayerSemaphore, osWaitForever);
    osMutexAcquire(LinkLayerMutex, osWaitForever);
    ll_sys_bg_process();
    osMutexRelease(LinkLayerMutex);
[#else]
    osSemaphoreAcquire(LinkLayerSemaphore, osWaitForever);
    ll_sys_bg_process();
[/#if]
  }
}
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
/**
 * @brief  Link Layer Task for ThreadX
 * @param  ULONG lArgument
 * @retval None
 */
static void LinkLayer_Task_Entry( ULONG lArgument )
{
  UNUSED(lArgument);

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
    tx_thread_relinquish();
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
  /* Register Link Layer task */
  UTIL_SEQ_RegTask(1U << CFG_TASK_LINK_LAYER, UTIL_SEQ_RFU, ll_sys_bg_process);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  /* Create Link Layer FreeRTOS objects */

  LinkLayerSemaphore = osSemaphoreNew(1U, 0U, &LinkLayerSemaphore_attributes);

  LinkLayerTaskHandle = osThreadNew(LinkLayer_Task_Entry, NULL, &LinkLayerTask_attributes);

[#if (myHash["BLE"] == "Enabled") ]
  LinkLayerMutex = osMutexNew(&LinkLayerMutex_attributes);

  if ((LinkLayerTaskHandle == NULL) || (LinkLayerSemaphore == NULL) || (LinkLayerMutex == NULL))
[#else]
  if ((LinkLayerTaskHandle == NULL) || (LinkLayerSemaphore == NULL))
[/#if]
  {
    LOG_ERROR_APP( "Link Layer FreeRTOS objects creation FAILED");
    Error_Handler();
  }
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  UINT TXstatus;
  CHAR *pStack;

  /* Create Link Layer ThreadX objects */

  TXstatus = tx_byte_allocate(pBytePool, (void **)&pStack, TASK_STACK_SIZE_LINK_LAYER, TX_NO_WAIT);

  if( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create(&LinkLayerTaskHandle, "Link Layer  Task", LinkLayer_Task_Entry, 0,
                                 pStack, TASK_STACK_SIZE_LINK_LAYER,
                                 TASK_PRIO_LINK_LAYER, TASK_PREEMP_LINK_LAYER,
                                 TX_NO_TIME_SLICE, TX_AUTO_START);
                                 
    TXstatus |= tx_semaphore_create(&LinkLayerSemaphore, "Link Layer Semaphore", 0);
[#if (myHash["BLE"] == "Enabled") ]

    TXstatus |= tx_mutex_create(&LinkLayerMutex, "Link Layer Mutex", 0 );
[/#if]
  }

  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "Link Layer ThreadX objects creation FAILED, status: %d", TXstatus);
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
[#if myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled"]
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_LINK_LAYER, TASK_PRIO_LINK_LAYER);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if (myHash["BLE"] == "Enabled")]
  osSemaphoreRelease(LinkLayerSemaphore);
[#else]
  if ( osSemaphoreGetCount(LinkLayerSemaphore) == 0 )
  {
    osSemaphoreRelease( LinkLayerSemaphore );
  }
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if (myHash["BLE"] == "Enabled")]
  tx_semaphore_put( &LinkLayerSemaphore );
[#else]
  if ( LinkLayerSemaphore.tx_semaphore_count == 0 )
  {
    tx_semaphore_put( &LinkLayerSemaphore );
  }
[/#if]
[/#if]
[#else]
  ll_process();
[/#if]
}

/**
  * @brief  Link Layer background process next iteration scheduling from ISR
  * @param  None
  * @retval None
  */
void ll_sys_schedule_bg_process_isr(void)
{
[#if myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled"]
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_LINK_LAYER, TASK_PRIO_LINK_LAYER);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if (myHash["BLE"] == "Enabled")]
  osSemaphoreRelease(LinkLayerSemaphore);
[#else]  
  if ( osSemaphoreGetCount(LinkLayerSemaphore) == 0 )
  {
    osSemaphoreRelease( LinkLayerSemaphore );
  }
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if (myHash["BLE"] == "Enabled")]
  tx_semaphore_put( &LinkLayerSemaphore );
[#else]
  if ( LinkLayerSemaphore.tx_semaphore_count == 0 )
  {
    tx_semaphore_put( &LinkLayerSemaphore );
  }
[/#if]
[/#if]
[#else]
  ll_process();
[/#if]
}

/**
  * @brief  Link Layer configuration phase before application startup.
  * @param  None
  * @retval None
  */
void ll_sys_config_params(void)
{
/* USER CODE BEGIN ll_sys_config_params_0 */

/* USER CODE END ll_sys_config_params_0 */

  /* Configure link layer behavior for low ISR use and next event scheduling method:
   * - SW low ISR is used.
   * - Next event is scheduled from ISR.
   */
  ll_intf_cmn_config_ll_ctx_params(USE_RADIO_LOW_ISR, NEXT_EVENT_SCHEDULING_FROM_ISR);
  /* Apply the selected link layer sleep timer source */
  ll_sys_sleep_clock_source_selection();

/* USER CODE BEGIN ll_sys_config_params_1 */

/* USER CODE END ll_sys_config_params_1 */
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]

#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
  /* Initialize link layer temperature measurement background task */
  ll_sys_bg_temperature_measurement_init();

  /* Link layer IP uses temperature based calibration instead of periodic one */
  ll_intf_cmn_set_temperature_sensor_state();
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
[/#if]

  /* Link Layer power table */
  ll_intf_cmn_select_tx_power_table(CFG_RF_TX_POWER_TABLE_ID);
/* USER CODE BEGIN ll_sys_config_params_2 */

/* USER CODE END ll_sys_config_params_2 */
}

[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
/**
 * @brief  Temperature Measurement Task for FreeRTOS
 * @param
 * @retval None
 */
 static void TempMeasureLL_Task_Entry( void *argument )
{
  UNUSED(argument);

  for(;;)
  {
    osSemaphoreAcquire(TempMeasLLSemaphore, osWaitForever);
    TEMPMEAS_RequestTemperatureMeasurement();
  }
}

[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
/**
 * @brief  Temperature Measurement Task for ThreadX
 * @param  lArgument   Argument passed the first time.
 * @retval None
 */
static void TempMeasureLL_Task_Entry( ULONG lArgument )
{
  UNUSED(lArgument);

  for(;;)
  {
[#if (myHash["BLE"] == "Enabled")]
    tx_semaphore_get(&TempMeasLLSemaphore, TX_WAIT_FOREVER);
    TEMPMEAS_RequestTemperatureMeasurement();
    tx_thread_relinquish();
[#else]
    tx_semaphore_get( &TempMeasLLSemaphore, TX_WAIT_FOREVER );
    TEMPMEAS_RequestTemperatureMeasurement();
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
  /* Register Temperature Measurement task */
  UTIL_SEQ_RegTask(1U << CFG_TASK_TEMP_MEAS, UTIL_SEQ_RFU, TEMPMEAS_RequestTemperatureMeasurement);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  /* Create Temperature Measurement Link Layer FreeRTOS objects */

  TempMeasLLTaskHandle = osThreadNew(TempMeasureLL_Task_Entry, NULL, &TempMeasLLTask_attributes);
  
  TempMeasLLSemaphore = osSemaphoreNew(1U, 0U, &TempMeasLLSemaphore_attributes);

  if ((TempMeasLLTaskHandle == NULL) || (TempMeasLLSemaphore == NULL))
  {
    LOG_ERROR_APP( "Temperature Measurement Link Layer FreeRTOS objects creation FAILED");
    Error_Handler();
  }

[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  UINT TXstatus;
  CHAR *pStack;

  /* Create Temperature Measurement Link Layer ThreadX objects */

  TXstatus = tx_byte_allocate(pBytePool, (void **)&pStack, TASK_STACK_SIZE_TEMP_MEAS_LL, TX_NO_WAIT);

  if( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create(&TempMeasLLTaskHandle, "Temperature Measurement LL Task", TempMeasureLL_Task_Entry, 0,
                                 pStack, TASK_STACK_SIZE_TEMP_MEAS_LL,
                                 TASK_PRIO_TEMP_MEAS_LL, TASK_PREEMP_TEMP_MEAS_LL,
                                 TX_NO_TIME_SLICE, TX_AUTO_START);
                                 
    TXstatus |= tx_semaphore_create(&TempMeasLLSemaphore, "Temperature Measurement LL Semaphore", 0);
  }

  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "Temperature Measurement Link Layer ThreadX objects creation FAILED, status: %d", TXstatus);
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
  static uint8_t initial_temperature_acquisition = 0;

  if(initial_temperature_acquisition == 0)
  {
    TEMPMEAS_RequestTemperatureMeasurement();
    initial_temperature_acquisition = 1;
  }
  else
  {
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
    UTIL_SEQ_SetTask(1U << CFG_TASK_TEMP_MEAS, CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
    tx_semaphore_put(&TempMeasLLSemaphore);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
    osSemaphoreRelease(TempMeasLLSemaphore);
[/#if]
  }
}

#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
[/#if]

[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled")  || (myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled")]
uint8_t ll_sys_BLE_sleep_clock_accuracy_selection(void)
{
  uint8_t BLE_sleep_clock_accuracy = 0;
#if (CFG_RADIO_LSE_SLEEP_TIMER_CUSTOM_SCA_RANGE == 0)
  uint32_t RevID = LL_DBGMCU_GetRevisionID();
#endif
  uint32_t linklayer_slp_clk_src = LL_RCC_RADIO_GetSleepTimerClockSource();
  
  if(linklayer_slp_clk_src == LL_RCC_RADIOSLEEPSOURCE_LSE)
  {
    /* LSE selected as Link Layer sleep clock source. 
       Sleep clock accuracy is different regarding the WBA device ID and revision 
     */
#if (CFG_RADIO_LSE_SLEEP_TIMER_CUSTOM_SCA_RANGE == 0)  	 
#if defined(STM32WBA52xx) || defined(STM32WBA54xx) || defined(STM32WBA55xx)
    if(RevID == REV_ID_A)
    {
      BLE_sleep_clock_accuracy = STM32WBA5x_REV_ID_A_SCA_RANGE;
    } 
    else if(RevID == REV_ID_B)
    {
      BLE_sleep_clock_accuracy = STM32WBA5x_REV_ID_B_SCA_RANGE;
    } 
    else
    {
      /* Revision ID not supported, default value of 500ppm applied */
      BLE_sleep_clock_accuracy = STM32WBA5x_DEFAULT_SCA_RANGE;
    }
#elif defined(STM32WBA65xx)
    BLE_sleep_clock_accuracy = STM32WBA6x_SCA_RANGE;
    UNUSED(RevID);
#else
    UNUSED(RevID);
#endif /* defined(STM32WBA52xx) || defined(STM32WBA54xx) || defined(STM32WBA55xx) */
#else /* CFG_RADIO_LSE_SLEEP_TIMER_CUSTOM_SCA_RANGE */  
    BLE_sleep_clock_accuracy = CFG_RADIO_LSE_SLEEP_TIMER_CUSTOM_SCA_RANGE;
#endif /* CFG_RADIO_LSE_SLEEP_TIMER_CUSTOM_SCA_RANGE */  	
  }
  else
  {
    /* LSE is not the Link Layer sleep clock source, sleep clock accurcay default value is 500 ppm */
    BLE_sleep_clock_accuracy = STM32WBA5x_DEFAULT_SCA_RANGE;
  }

  return BLE_sleep_clock_accuracy;  
}
[/#if]

void ll_sys_sleep_clock_source_selection(void)
{
  uint16_t freq_value = 0;
  uint32_t linklayer_slp_clk_src = LL_RCC_RADIOSLEEPSOURCE_NONE;
  
  linklayer_slp_clk_src = LL_RCC_RADIO_GetSleepTimerClockSource();
  switch(linklayer_slp_clk_src)
  {
    case LL_RCC_RADIOSLEEPSOURCE_LSE:
      linklayer_slp_clk_src = RTC_SLPTMR;
      break;

    case LL_RCC_RADIOSLEEPSOURCE_LSI:
      linklayer_slp_clk_src = RCO_SLPTMR;
      break;

    case LL_RCC_RADIOSLEEPSOURCE_HSE_DIV1000:
      linklayer_slp_clk_src = CRYSTAL_OSCILLATOR_SLPTMR;
      break;

    case LL_RCC_RADIOSLEEPSOURCE_NONE:
      /* No Link Layer sleep clock source selected */
      assert_param(0);
      break;
  }
  ll_intf_cmn_le_select_slp_clk_src((uint8_t)linklayer_slp_clk_src, &freq_value);
}

[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled")  || (myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled")]
void ll_sys_reset(void)
{
  uint8_t bsca = 0;
  /* Link layer timings */
  uint8_t drift_time = DRIFT_TIME_DEFAULT;
  uint8_t exec_time = EXEC_TIME_DEFAULT;

/* USER CODE BEGIN ll_sys_reset_0 */

/* USER CODE END ll_sys_reset_0 */

  /* Apply the selected link layer sleep timer source */
  ll_sys_sleep_clock_source_selection();

  /* Configure the link layer sleep clock accuracy */
  bsca = ll_sys_BLE_sleep_clock_accuracy_selection();
  ll_intf_le_set_sleep_clock_accuracy(bsca);

  /* Update link layer timings depending on selected configuration */
  if(LL_RCC_RADIO_GetSleepTimerClockSource() == LL_RCC_RADIOSLEEPSOURCE_LSI)
  {
    drift_time += DRIFT_TIME_EXTRA_LSI2;
    exec_time += EXEC_TIME_EXTRA_LSI2;
  }
  else
  {
#if defined(__GNUC__) && defined(DEBUG)
    drift_time += DRIFT_TIME_EXTRA_GCC_DEBUG;
    exec_time += EXEC_TIME_EXTRA_GCC_DEBUG;
#endif
  }

  /* USER CODE BEGIN ll_sys_reset_1 */

  /* USER CODE END ll_sys_reset_1 */

  if((drift_time != DRIFT_TIME_DEFAULT) || (exec_time != EXEC_TIME_DEFAULT))
  {
    ll_sys_config_BLE_schldr_timings(drift_time, exec_time);
  }
  /* USER CODE BEGIN ll_sys_reset_2 */

  /* USER CODE END ll_sys_reset_2 */
}
[/#if]
