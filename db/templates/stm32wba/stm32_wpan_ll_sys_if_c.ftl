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
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
#include "stm32_seq.h"
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
#include "app_threadx.h"
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
[/#if]
#include "adc_ctrl.h"
#include "linklayer_plat.h"
/* Private defines -----------------------------------------------------------*/

[#if myHash["THREADX_STATUS"]?number == 1 ]
/* LINK_LAYER_TASK related defines */
#define LINK_LAYER_TASK_STACK_SIZE    (256*7)
#define LINK_LAYER_TASK_PRIO          (15)
#define LINK_LAYER_TASK_PREEM_TRES    (0)

/* LINK_LAYER_TEMP_MEAS_TASK related defines */
#define LINK_LAYER_TEMP_MEAS_TASK_STACK_SIZE    (256*7)
#define LINK_LAYER_TEMP_MEAS_TASK_PRIO          (15)
#define LINK_LAYER_TEMP_MEAS_TASK_PREEM_TRES    (0)

[/#if]
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macros ------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

[#if myHash["THREADX_STATUS"]?number == 1 ]
/* LINK_LAYER_TEMP_MEAS_TASK related resources */
TX_THREAD LINK_LAYER_TEMP_MEAS_Thread;
TX_SEMAPHORE LINK_LAYER_TEMP_MEAS_Thread_Sem;

/* LINK_LAYER_TASK related resources */
TX_THREAD LINK_LAYER_Thread;
TX_SEMAPHORE LINK_LAYER_Thread_Sem;

[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Global variables ----------------------------------------------------------*/

[#if myHash["THREADX_STATUS"]?number == 1 ]
/* LINK_LAYER_TASK related resources */
TX_MUTEX LINK_LAYER_Thread_Mutex;

[/#if]
/* USER CODE BEGIN GV */

/* USER CODE END GV */

#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
void ll_sys_bg_temperature_measurement(void);
static void ll_sys_bg_temperature_measurement_init(void);
static void request_temperature_measurement(void);
[#if myHash["THREADX_STATUS"]?number == 1 ]
static void request_temperature_measurement_Entry(unsigned long thread_input);
static void ll_sys_bg_process_Entry(unsigned long thread_input);
[/#if]
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */

/**
  * @brief  Link Layer background process initialization
  * @param  None
  * @retval None
  */
void ll_sys_bg_process_init(void)
{
  /* Tasks creation */
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_RegTask( 1U << CFG_TASK_LINK_LAYER, UTIL_SEQ_RFU, ll_sys_bg_process);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  CHAR * pStack;

  if (tx_byte_allocate(pBytePool, (void **) &pStack, LINK_LAYER_TASK_STACK_SIZE,TX_NO_WAIT) != TX_SUCCESS)
  {
    Error_Handler();
  }
  if (tx_semaphore_create(&LINK_LAYER_Thread_Sem, "LINK_LAYER_Thread_Sem", 0)!= TX_SUCCESS )
  {
    Error_Handler();
  }
  if (tx_mutex_create(&LINK_LAYER_Thread_Mutex, "LINK_LAYER_Thread_Mutex", TX_NO_INHERIT)!=TX_SUCCESS )
  {
    Error_Handler();
  }
  if (tx_thread_create(&LINK_LAYER_Thread, "LINK_LAYER_Thread", ll_sys_bg_process_Entry, 0,
                         pStack, LINK_LAYER_TASK_STACK_SIZE,
                         LINK_LAYER_TASK_PRIO, LINK_LAYER_TASK_PREEM_TRES,
                         TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
  {
    Error_Handler();
  }
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

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
  UTIL_SEQ_SetTask(1U << CFG_TASK_LINK_LAYER, CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_put(&LINK_LAYER_Thread_Sem);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

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
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
  /* Initialize link layer temperature measurement background task */
  ll_sys_bg_temperature_measurement_init();

  /* Link layer IP uses temperature based calibration instead of periodic one */
  ll_intf_set_temperature_sensor_state();
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
}

#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
/**
  * @brief  Link Layer temperature request background process initialization
  * @param  None
  * @retval None
  */
void ll_sys_bg_temperature_measurement_init(void)
{
  /* Tasks creation */
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_RegTask( 1U << CFG_TASK_LINK_LAYER_TEMP_MEAS, UTIL_SEQ_RFU, request_temperature_measurement);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  CHAR * pStack;

  if (tx_byte_allocate(pBytePool, (void **) &pStack, LINK_LAYER_TEMP_MEAS_TASK_STACK_SIZE,TX_NO_WAIT) != TX_SUCCESS)
  {
    Error_Handler();
  }
  if (tx_semaphore_create(&LINK_LAYER_TEMP_MEAS_Thread_Sem, "LINK_LAYER_TEMP_MEAS_Thread_Sem", 0)!= TX_SUCCESS )
  {
    Error_Handler();
  }
  if (tx_thread_create(&LINK_LAYER_TEMP_MEAS_Thread, "LINK_LAYER_TEMP_MEAS_Thread", request_temperature_measurement_Entry, 0,
                         pStack, LINK_LAYER_TEMP_MEAS_TASK_STACK_SIZE,
                         LINK_LAYER_TEMP_MEAS_TASK_PRIO, LINK_LAYER_TEMP_MEAS_TASK_PREEM_TRES,
                         TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
  {
    Error_Handler();
  }
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

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
  tx_semaphore_put(&LINK_LAYER_TEMP_MEAS_Thread_Sem);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

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

[#if myHash["THREADX_STATUS"]?number == 1 ]
static void request_temperature_measurement_Entry(unsigned long thread_input)
{
  (void)(thread_input);

  while(1)
  {
    tx_semaphore_get(&LINK_LAYER_TEMP_MEAS_Thread_Sem, TX_WAIT_FOREVER);
    tx_mutex_get(&LINK_LAYER_Thread_Mutex, TX_WAIT_FOREVER);
    request_temperature_measurement();
    tx_mutex_put(&LINK_LAYER_Thread_Mutex);
    tx_thread_relinquish();
  }
}
[/#if]
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */

[#if myHash["THREADX_STATUS"]?number == 1 ]
static void ll_sys_bg_process_Entry(unsigned long thread_input)
{
  (void)(thread_input);

  while(1)
  {
    tx_semaphore_get(&LINK_LAYER_Thread_Sem, TX_WAIT_FOREVER);
    tx_mutex_get(&LINK_LAYER_Thread_Mutex, TX_WAIT_FOREVER);
    ll_sys_bg_process();
    tx_mutex_put(&LINK_LAYER_Thread_Mutex);
    tx_thread_relinquish();
  }
}

[/#if]

/**
  * @brief  Enable RTOS context switch.
  * @param  None
  * @retval None
  */
void LINKLAYER_PLAT_EnableOSContextSwitch(void)
{
[#if myHash["THREADX_STATUS"]?number == 1 ]
  tx_interrupt_control(TX_INT_ENABLE);
[/#if]
}

/**
  * @brief  Disable RTOS context switch.
  * @param  None
  * @retval None
  */
void LINKLAYER_PLAT_DisableOSContextSwitch(void)
{
[#if myHash["THREADX_STATUS"]?number == 1 ]
  tx_interrupt_control(TX_INT_DISABLE);
[/#if]
}
