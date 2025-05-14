[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
  * File Name          : app_thread.c
  * Description        : Thread Application.
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
			[#if (definition.name == "THREAD_APPLICATION") ]
                [#assign THREAD_APPLICATION = definition.value]
            [/#if]
            [#if (definition.name == "CFG_CLI_UART")  && (definition.value != "0")]
                [#assign CFG_CLI_UART = definition.value]
            [/#if]
            [#if (definition.name == "PANID")]
                [#assign PANID = definition.value]
            [/#if]
            [#if (definition.name == "CHANNEL")]
                [#assign CHANNEL = definition.value]
            [/#if]
            [#if (definition.name == "NETWORKKEY")]
                [#assign NETWORKKEY = definition.value]
                [#assign NETWORKKEY = NETWORKKEY?replace(", ", ", 0x")]
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

/* Includes ------------------------------------------------------------------*/
#include <assert.h>
#include <stdint.h>

#include "app_conf.h"
#include "app_common.h"
#include "app_entry.h"
#include "log_module.h"
#include "app_thread.h"
#include "dbg_trace.h"
#include "stm32_rtos.h"
#include "stm32_timer.h"
#if (CFG_LPM_LEVEL != 0)
#include "stm32_lpm.h"
#endif // CFG_LPM_LEVEL
#include "common_types.h"
#include "instance.h"
#include "radio.h"
#include "platform.h"
#include "ll_sys_startup.h"
#include "event_manager.h"
#include "platform_wba.h"
#include "link.h"
#include "cli.h"
#include "coap.h"
#include "tasklet.h"
#include "thread.h"
[#if (THREAD_APPLICATION != "RCP")]
#include "threadplat_pka.h"
[/#if]
#include "joiner.h"
#include OPENTHREAD_CONFIG_FILE

/* Private includes -----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private defines -----------------------------------------------------------*/
[#if (THREAD_APPLICATION != "FTD_CLI") && (THREAD_APPLICATION != "RCP")]
#define C_PANID                 0x${PANID}U
#define C_CHANNEL_NB            ${CHANNEL}U
[/#if]
[#if (THREAD_APPLICATION == "MTD")]
#define WAIT_TIMEOUT           (5000U)    /**< 5s */
[/#if]
#define C_CCA_THRESHOLD         (-70)

/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macros ------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private function prototypes -----------------------------------------------*/
static void APP_THREAD_DeviceConfig(void);
[#if (THREAD_APPLICATION != "RCP")]
static void APP_THREAD_StateNotif(uint32_t NotifFlags, void *pContext);
[/#if]
static void APP_THREAD_TraceError(const char * pMess, uint32_t ErrCode);

[#if (THREAD_APPLICATION != "RCP")]
#if (OT_CLI_USE == 1)
static void APP_THREAD_CliInit(otInstance *aInstance);
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
static void APP_THREAD_ProcessUart(void);
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
static void APP_THREAD_ProcessUart(ULONG lArgument);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
static void APP_THREAD_ProcessUart(void *argument);
[/#if]
#endif // OT_CLI_USE
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
static void APP_THREAD_ProcessPka(void);
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
static void APP_THREAD_ProcessPka(ULONG lArgument);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
static void APP_THREAD_ProcessPka(void *argument);
[/#if]

[/#if]
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private variables -----------------------------------------------*/
static otInstance * PtOpenThreadInstance;

[#if myHash["THREADX_STATUS"]?number == 1 ]
TX_THREAD           AlarmTask, AlarmUsTask, TaskletsTask;
TX_SEMAPHORE        AlarmSemaphore, AlarmUsSemaphore, TaskletSemaphore;
[#if (THREAD_APPLICATION != "RCP")]
TX_THREAD 			PkaTask;
TX_SEMAPHORE        PkaSemaphore, PkaCompletedSemaphore;
#if (OT_CLI_USE == 1)
TX_THREAD           CliUartTask;
TX_SEMAPHORE        CliUartSemaphore;
#endif // OT_CLI_USE
[/#if]
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
osThreadId_t        AlarmTask, AlarmUsTask, TaskletsTask;
osSemaphoreId_t     AlarmSemaphore, AlarmUsSemaphore, TaskletSemaphore;
[#if (THREAD_APPLICATION != "RCP")]
osThreadId_t        PkaTask;
osSemaphoreId_t     PkaSemaphore, PkaCompletedSemaphore;
#if (OT_CLI_USE == 1)
osThreadId_t        CliUartTask;
osSemaphoreId_t     CliUartSemaphore;
#endif // OT_CLI_USE
[/#if]

const osThreadAttr_t AlarmTask_attr = {
  .name         = "Alarm Task",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM,
  .priority     = TASK_PRIO_ALARM,
  .stack_size   = TASK_STACK_SIZE_ALARM
};

const osThreadAttr_t AlarmUsTask_attr = {
  .name         = "AlarmUs Task",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM,
  .priority     = TASK_PRIO_US_ALARM,
  .stack_size   = TASK_STACK_SIZE_ALARM_US
};

const osThreadAttr_t TaskletsTask_attr = {
  .name         = "Tasklets Task",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM,
  .priority     = TASK_PRIO_TASKLETS,
  .stack_size   = TASK_STACK_SIZE_TASKLETS
};

[#if (THREAD_APPLICATION != "RCP")]
#if (OT_CLI_USE == 1)
const osThreadAttr_t CliUartTask_attr = {
  .name         = "CliUart Task",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM,
  .priority     = TASK_PRIO_CLI_UART,
  .stack_size   = TASK_STACK_SIZE_CLI_UART
};
#endif // OT_CLI_USE

const osThreadAttr_t PkaTask_attr = {
  .name         = "Pka Task",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM,
  .priority     = TASK_PRIO_PKA,
  .stack_size   = TASK_STACK_SIZE_PKA
};
[/#if]
[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Functions Definition ------------------------------------------------------*/

[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
void ProcessAlarm(void)
{
  arcAlarmProcess(PtOpenThreadInstance);
}

void ProcessUsAlarm(void)
{
  arcUsAlarmProcess(PtOpenThreadInstance);
}

void ProcessTasklets(void)
{
  if (otTaskletsArePending(PtOpenThreadInstance) == TRUE) 
  {
    UTIL_SEQ_SetTask(1U << CFG_TASK_OT_TASKLETS, TASK_PRIO_TASKLETS);
  }
}

/**
 * @brief  ProcessOpenThreadTasklets.
 * @param  None
 * @param  None
 * @retval None
 */
void ProcessOpenThreadTasklets(void)
{
  /* wakeUp the system */
  //ll_sys_radio_hclk_ctrl_req(LL_SYS_RADIO_HCLK_LL_BG, LL_SYS_RADIO_HCLK_ON);
  //ll_sys_dp_slp_exit();

  /* process the tasklet */
  otTaskletsProcess(PtOpenThreadInstance);

  /* put the IP802_15_4 back to sleep mode */
  //ll_sys_radio_hclk_ctrl_req(LL_SYS_RADIO_HCLK_LL_BG, LL_SYS_RADIO_HCLK_OFF);

  /* reschedule the tasklets if any */
  ProcessTasklets();
}

/**
 * OpenThread calls this function when the tasklet queue transitions from empty to non-empty.
 *
 * @param[in] aInstance A pointer to an OpenThread instance.
 */
void otTaskletsSignalPending(otInstance *aInstance)
{
  UTIL_SEQ_SetTask(1U << CFG_TASK_OT_TASKLETS, TASK_PRIO_TASKLETS);
}
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
static void APP_THREAD_ProcessAlarm(ULONG lArgument)
{
  UNUSED(lArgument);
  
  for(;;)
  {
    tx_semaphore_get(&AlarmSemaphore, TX_WAIT_FOREVER);
    arcAlarmProcess(PtOpenThreadInstance);
  }
}

static void APP_THREAD_ProcessUsAlarm(ULONG lArgument)
{
  UNUSED(lArgument);
  
  for(;;)
  {
    tx_semaphore_get(&AlarmUsSemaphore, TX_WAIT_FOREVER);
    arcUsAlarmProcess(PtOpenThreadInstance);
  }
}

static void ProcessTasklets(void)
{
  if (otTaskletsArePending(PtOpenThreadInstance) == TRUE)
  {
    tx_semaphore_put(&TaskletSemaphore);
  }
}

/**
 * @brief  APP_THREAD_ProcessOpenThreadTasklets.
 * @param  ULONG lArgument (unused)
 * @param  None
 * @retval None
 */
static void APP_THREAD_ProcessOpenThreadTasklets(ULONG lArgument)
{
  UNUSED(lArgument);
  
  for(;;)
  {
    tx_semaphore_get(&TaskletSemaphore, TX_WAIT_FOREVER);
 
    /* wakeUp the system */
    //ll_sys_radio_hclk_ctrl_req(LL_SYS_RADIO_HCLK_LL_BG, LL_SYS_RADIO_HCLK_ON);
    //ll_sys_dp_slp_exit();

    /* process the tasklet */
    otTaskletsProcess(PtOpenThreadInstance);

    /* put the IP802_15_4 back to sleep mode */
    //ll_sys_radio_hclk_ctrl_req(LL_SYS_RADIO_HCLK_LL_BG, LL_SYS_RADIO_HCLK_OFF);

    /* reschedule the tasklets if any */
    ProcessTasklets();
  }
}

/**
 * OpenThread calls this function when the tasklet queue transitions from empty to non-empty.
 *
 * @param[in] aInstance A pointer to an OpenThread instance.
 */
void otTaskletsSignalPending(otInstance *aInstance)
{
  tx_semaphore_put(&TaskletSemaphore);
}
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
static void APP_THREAD_ProcessAlarm(void *argument)
{
  UNUSED(argument);
  
  for(;;)
  {
    osSemaphoreAcquire(AlarmSemaphore, osWaitForever);
    arcAlarmProcess(PtOpenThreadInstance);
  }
}

static void APP_THREAD_ProcessUsAlarm(void *argument)
{
  UNUSED(argument);
  
  for(;;)
  {
    osSemaphoreAcquire(AlarmUsSemaphore, osWaitForever);
    arcUsAlarmProcess(PtOpenThreadInstance);
  }
}

static void ProcessTasklets(void)
{
  if (otTaskletsArePending(PtOpenThreadInstance) == TRUE)
  {
    osSemaphoreRelease(TaskletSemaphore);
  }
}

/**
 * @brief  APP_THREAD_ProcessOpenThreadTasklets.
 * @param  ULONG lArgument (unused)
 * @param  None
 * @retval None
 */
static void APP_THREAD_ProcessOpenThreadTasklets(void *argument)
{
  UNUSED(argument);
  
  for(;;)
  {
    osSemaphoreAcquire(TaskletSemaphore, osWaitForever);
 
    /* wakeUp the system */
    //ll_sys_radio_hclk_ctrl_req(LL_SYS_RADIO_HCLK_LL_BG, LL_SYS_RADIO_HCLK_ON);
    //ll_sys_dp_slp_exit();

    /* process the tasklet */
    otTaskletsProcess(PtOpenThreadInstance);

    /* put the IP802_15_4 back to sleep mode */
    //ll_sys_radio_hclk_ctrl_req(LL_SYS_RADIO_HCLK_LL_BG, LL_SYS_RADIO_HCLK_OFF);

    /* reschedule the tasklets if any */
    ProcessTasklets();
  }
}

/**
 * OpenThread calls this function when the tasklet queue transitions from empty to non-empty.
 *
 * @param[in] aInstance A pointer to an OpenThread instance.
 */
void otTaskletsSignalPending(otInstance *aInstance)
{
  osSemaphoreRelease(TaskletSemaphore);
}
[/#if]

void APP_THREAD_ScheduleAlarm(void)
{
[#if myHash["THREADX_STATUS"]?number == 1 ]
  if (AlarmSemaphore.tx_semaphore_count == 0)
  {
    tx_semaphore_put(&AlarmSemaphore);
  }
[/#if]  
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  osSemaphoreRelease(AlarmSemaphore);
[/#if]  
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_OT_ALARM, TASK_PRIO_ALARM);
[/#if]  
}

void APP_THREAD_ScheduleUsAlarm(void)
{
[#if myHash["THREADX_STATUS"]?number == 1 ]
  if (AlarmUsSemaphore.tx_semaphore_count == 0)
  {
    tx_semaphore_put(&AlarmUsSemaphore);
  }
[/#if] 
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  osSemaphoreRelease(AlarmUsSemaphore);
[/#if] 
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_OT_US_ALARM, TASK_PRIO_US_ALARM);
[/#if]   
}

static void APP_THREAD_AlarmsInit(void)
{
[#if myHash["THREADX_STATUS"]?number == 1 ]
  UINT ThreadXStatus;
  CHAR *pStack;
  
  /* Register semaphores to launch tasks */
  ThreadXStatus = tx_semaphore_create(&AlarmSemaphore, "AlarmSemaphore", 0);

  if (ThreadXStatus == TX_SUCCESS)
  {
    ThreadXStatus = tx_semaphore_create(&AlarmUsSemaphore, "AlarmUsSemaphore", 0);
  }
  
  /* Create associated tasks */
  if (ThreadXStatus == TX_SUCCESS)
  { 
    ThreadXStatus = tx_byte_allocate(pBytePool, (VOID**) &pStack, TASK_STACK_SIZE_ALARM, TX_NO_WAIT);
  }
  if (ThreadXStatus == TX_SUCCESS)
  {
    ThreadXStatus = tx_thread_create( &AlarmTask, "AlarmTask", APP_THREAD_ProcessAlarm, 0, pStack,
                                      TASK_STACK_SIZE_ALARM, TASK_PRIO_ALARM, TASK_PREEMP_ALARM,
                                      TX_NO_TIME_SLICE, TX_AUTO_START );
  }
  
  if (ThreadXStatus == TX_SUCCESS)
  { 
    ThreadXStatus = tx_byte_allocate(pBytePool, (VOID**) &pStack, TASK_STACK_SIZE_ALARM_US, TX_NO_WAIT);
  }
  if (ThreadXStatus == TX_SUCCESS)
  {
    ThreadXStatus = tx_thread_create( &AlarmUsTask, "AlarmUsTask", APP_THREAD_ProcessUsAlarm, 0, pStack,
                                      TASK_STACK_SIZE_ALARM_US, TASK_PRIO_US_ALARM, TASK_PREEMP_US_ALARM,
                                      TX_NO_TIME_SLICE, TX_AUTO_START );
  }
  
  /* Verify if it's OK */
  if (ThreadXStatus != TX_SUCCESS)
  { 
    LOG_ERROR_APP( "ERROR THREADX : ALARMS THREAD CREATION FAILED (%d)", ThreadXStatus );
    while(1);
  }
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  /* Register semaphores to launch tasks */
  AlarmSemaphore = osSemaphoreNew(1, 0, NULL);

  if (AlarmSemaphore == NULL)
  {
    LOG_ERROR_APP("ERROR FREERTOS : ALARM SEMAPHORE CREATION FAILED");
    while(1);
  }
   
  AlarmTask = osThreadNew(APP_THREAD_ProcessAlarm, NULL, &AlarmTask_attr);
  if (AlarmTask == NULL)
  {
    LOG_ERROR_APP("ERROR FREERTOS : ALARM TASK CREATION FAILED");
    while(1);
  }
  
  AlarmUsSemaphore = osSemaphoreNew(1, 0, NULL);
  if (AlarmUsSemaphore == NULL)
  {
    LOG_ERROR_APP("ERROR FREERTOS : ALARM US SEMAPHORE CREATION FAILED");
    while(1);
  }
   
  AlarmUsTask = osThreadNew(APP_THREAD_ProcessUsAlarm, NULL, &AlarmUsTask_attr);
  if (AlarmTask == NULL)
  {
    LOG_ERROR_APP("ERROR FREERTOS : ALARM US TASK CREATION FAILED");
    while(1);
  }
[/#if]   
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_RegTask(1U << CFG_TASK_OT_ALARM, UTIL_SEQ_RFU, ProcessAlarm);
  UTIL_SEQ_RegTask(1U << CFG_TASK_OT_US_ALARM, UTIL_SEQ_RFU, ProcessUsAlarm);
  
  /* Run first time */
  UTIL_SEQ_SetTask(1U << CFG_TASK_OT_ALARM, TASK_PRIO_ALARM);
[/#if]  
}

static void APP_THREAD_TaskletsInit(void)
{
[#if myHash["THREADX_STATUS"]?number == 1 ]
  UINT ThreadXStatus;
  CHAR *pStack;
  
  /* Semaphore already created */

  /* Create associated task */
  ThreadXStatus = tx_byte_allocate(pBytePool, (VOID**) &pStack, TASK_STACK_SIZE_TASKLETS, TX_NO_WAIT);
  
  if (ThreadXStatus == TX_SUCCESS)
  {
    ThreadXStatus |= tx_thread_create(&TaskletsTask, "TaskletsTask", APP_THREAD_ProcessOpenThreadTasklets, 0, pStack,
                                      TASK_STACK_SIZE_TASKLETS, TASK_PRIO_TASKLETS, TASK_PREEMP_TASKLETS,
                                      TX_NO_TIME_SLICE, TX_AUTO_START);
  }
 
  /* Verify if it's OK */
  if (ThreadXStatus != TX_SUCCESS)
  { 
    LOG_ERROR_APP( "ERROR THREADX : TASKLETS THREAD CREATION FAILED (%d)", ThreadXStatus );
    while(1);
  }
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  /* Semaphore already created */
  TaskletsTask = osThreadNew(APP_THREAD_ProcessOpenThreadTasklets, NULL, &TaskletsTask_attr);
  if (TaskletsTask == NULL)
  { 
    APP_DBG( "ERROR FREERTOS : TASKLETS TASK CREATION FAILED" );
    while(1);
  } 
[/#if]
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_RegTask(1U << CFG_TASK_OT_TASKLETS, UTIL_SEQ_RFU, ProcessOpenThreadTasklets);
[/#if]  
}

[#if (THREAD_APPLICATION != "RCP")]
static void APP_THREAD_PkaInit(void)
{
[#if myHash["THREADX_STATUS"]?number == 1 ]
  UINT ThreadXStatus;
  CHAR *pStack;
  
  /* Register semaphores to launch tasks */
  ThreadXStatus = tx_semaphore_create(&PkaSemaphore, "PkaSemaphore", 0);
  if (ThreadXStatus == TX_SUCCESS)
  {
	ThreadXStatus = tx_semaphore_create(&PkaCompletedSemaphore, "PkaCompletedSemaphore", 0);
  }

  if (ThreadXStatus == TX_SUCCESS)
  {
	/* Create associated task */
	ThreadXStatus = tx_byte_allocate(pBytePool, (VOID**) &pStack, TASK_STACK_SIZE_PKA, TX_NO_WAIT);
  }
  if (ThreadXStatus == TX_SUCCESS)
  {
    ThreadXStatus |= tx_thread_create(&PkaTask, "PkaTask", APP_THREAD_ProcessPka, 0, pStack,
                                      TASK_STACK_SIZE_PKA, TASK_PRIO_PKA, TASK_PREEMP_PRIO_PKA,
                                      TX_NO_TIME_SLICE, TX_AUTO_START);
  }
 
  /* Verify if it's OK */
  if (ThreadXStatus != TX_SUCCESS)
  { 
    LOG_ERROR_APP( "ERROR THREADX : PKA THREAD CREATION FAILED (%d)", ThreadXStatus );
    while(1);
  }
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  /* Register semaphores to launch tasks */
  PkaSemaphore = osSemaphoreNew(1, 0, NULL);
  if (PkaSemaphore == NULL)
  {
    LOG_ERROR_APP("ERROR FREERTOS : PKA SEMAPHORE CREATION FAILED");
    while(1);
  }
  PkaCompletedSemaphore = osSemaphoreNew(1, 0, NULL);
  if (PkaCompletedSemaphore == NULL)
  {
    LOG_ERROR_APP("ERROR FREERTOS : PKA COMPLETED SEMAPHORE CREATION FAILED");
    while(1);
  }
  
  PkaTask = osThreadNew(APP_THREAD_ProcessPka, NULL, &PkaTask_attr);
  if (PkaTask == NULL)
  { 
    APP_DBG( "ERROR FREERTOS : PKA TASK CREATION FAILED" );
    while(1);
  } 
[/#if]
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_RegTask(1U << CFG_TASK_PKA, UTIL_SEQ_RFU, APP_THREAD_ProcessPka);
[/#if]  
}

[/#if] 
/**
 *
 */
void Thread_Init(void)
{
#if OPENTHREAD_CONFIG_MULTIPLE_INSTANCE_ENABLE
  size_t otInstanceBufferLength = 0;
  uint8_t *otInstanceBuffer = NULL;
#endif // OPENTHREAD_CONFIG_MULTIPLE_INSTANCE_ENABLE

  otSysInit(0, NULL);

[#if myHash["THREADX_STATUS"]?number == 1 ]
 /* Semaphore used by otTaskletsSignalPending() that is called by otInstanceInit() */
  tx_semaphore_create(&TaskletSemaphore, "TaskletSemaphore", 0);
  
[/#if] 
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  /* Semaphore used by otTaskletsSignalPending() that is called by otInstanceInit() */
  TaskletSemaphore = osSemaphoreNew(1, 0, NULL);
  
[/#if]
#if OPENTHREAD_CONFIG_MULTIPLE_INSTANCE_ENABLE
  // Call to query the buffer size
  (void)otInstanceInit(NULL, &otInstanceBufferLength);

  // Call to allocate the buffer
  otInstanceBuffer = (uint8_t *)malloc(otInstanceBufferLength);
  assert(otInstanceBuffer);

  // Initialize OpenThread with the buffer
  PtOpenThreadInstance = otInstanceInit(otInstanceBuffer, &otInstanceBufferLength);
#else // OPENTHREAD_CONFIG_MULTIPLE_INSTANCE_ENABLE
  PtOpenThreadInstance = otInstanceInitSingle();
#endif // OPENTHREAD_CONFIG_MULTIPLE_INSTANCE_ENABLE

  assert(PtOpenThreadInstance);

[#if (THREAD_APPLICATION != "RCP")]
#if (OT_CLI_USE == 1)
  APP_THREAD_CliInit(PtOpenThreadInstance);
#endif // OT_CLI_USE
[/#if]
  otDispatch_tbl_init(PtOpenThreadInstance);

  /* Register tasks */
  APP_THREAD_AlarmsInit();
  APP_THREAD_TaskletsInit();
[#if (THREAD_APPLICATION != "RCP")]
  APP_THREAD_PkaInit();
[/#if]  

  ll_sys_thread_init();

  /* USER CODE BEGIN INIT TASKS */

  /* USER CODE END INIT TASKS */
}

/**
 * @brief Thread initialization.
 * @param  None
 * @retval None
 */
static void APP_THREAD_DeviceConfig(void)
{
  otError error = OT_ERROR_NONE;
[#if (THREAD_APPLICATION == "RCP")]  
  otExtAddress ext_addr;
[/#if]
[#if (THREAD_APPLICATION == "MTD")]
  otLinkModeConfig OT_LinkMode;
[/#if]
[#if (THREAD_APPLICATION != "FTD_CLI") && (THREAD_APPLICATION != "RCP")]
  otNetworkKey networkKey = {{0xFF, 0xEE, 0xDD, 0xCC, 0xBB, 0xAA, 0x99, 0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11, 0x00}}; 
[/#if]

[#if (THREAD_APPLICATION != "RCP")]
  error = otSetStateChangedCallback(PtOpenThreadInstance, APP_THREAD_StateNotif, NULL);
  if (error != OT_ERROR_NONE)
  {
    APP_THREAD_Error(ERR_THREAD_SET_STATE_CB,error);
  }
[#else]
  otPlatRadioGetIeeeEui64(PtOpenThreadInstance, ext_addr.m8);

  otPlatRadioSetExtendedAddress(PtOpenThreadInstance, &ext_addr);   
[/#if]

  error = otPlatRadioSetCcaEnergyDetectThreshold(PtOpenThreadInstance, C_CCA_THRESHOLD);
  if (error != OT_ERROR_NONE)
  {
    APP_THREAD_Error(ERR_THREAD_SET_THRESHOLD,error);
  }

[#if (THREAD_APPLICATION != "FTD_CLI") && (THREAD_APPLICATION != "RCP")]
  error = otLinkSetChannel(PtOpenThreadInstance, C_CHANNEL_NB);
  if (error != OT_ERROR_NONE)
  {
    APP_THREAD_Error(ERR_THREAD_SET_CHANNEL,error);
  }
  
  error = otLinkSetPanId(PtOpenThreadInstance, C_PANID);
  if (error != OT_ERROR_NONE)
  {
    APP_THREAD_Error(ERR_THREAD_SET_PANID,error);
  }
  
  error = otThreadSetNetworkKey(PtOpenThreadInstance, &networkKey);
  if (error != OT_ERROR_NONE)
  {
    APP_THREAD_Error(ERR_THREAD_SET_NETWORK_KEY,error);
  }
  
[/#if]
  otPlatRadioEnableSrcMatch(PtOpenThreadInstance, true);

[#if (THREAD_APPLICATION == "MTD")]
    /* After reaching the child or router state, the system
   *   a) sets the 'sleepy end device' mode
   *   b) perform a Thread stop
   *   c) perform a Thread start.
   *
   *  NOTE : According to the Thread specification, it is necessary to set the
   *         mode before starting Thread.
   *
   * A Child that has attached to its Parent indicating it is an FTD MUST NOT use Child UpdateRequest
   * to modify its mode to MTD.
   * As a result, you need to first detach from the network before switching from FTD to MTD at runtime,
   * then reattach.
   *
   */
  /* Set the pool period . It means that when the device will enter in 'sleepy
   * end device' mode, it will send an ACK_Request every 
   * WAIT_TIMEOUT.
   * This message will act as keep alive message.
   */
  /* Set the sleepy end device mode */
  OT_LinkMode.mRxOnWhenIdle = 0;
  OT_LinkMode.mDeviceType = 0; /* 0: MTD, 1: FTD */
  OT_LinkMode.mNetworkData = 1U;

  error = otThreadSetLinkMode(PtOpenThreadInstance,OT_LinkMode);
  if (error != OT_ERROR_NONE)
  {
    APP_THREAD_Error(ERR_THREAD_LINK_MODE,error);
  }
  error = otLinkSetPollPeriod(PtOpenThreadInstance, WAIT_TIMEOUT);
  if (error != OT_ERROR_NONE)
  {
    APP_THREAD_Error(ERR_THREAD_POLL_MODE,error);
  }  
[/#if]
[#if (THREAD_APPLICATION != "RCP")]
  error = otIp6SetEnabled(PtOpenThreadInstance, true);
  if (error != OT_ERROR_NONE)
  {
    APP_THREAD_Error(ERR_THREAD_IPV6_ENABLE,error);
  }
[#if (THREAD_APPLICATION == "FTD_CLI")]
  error = otThreadSetEnabled(PtOpenThreadInstance, false);
[#else]
  error = otThreadSetEnabled(PtOpenThreadInstance, true);
[/#if]
  if (error != OT_ERROR_NONE)
  {
    APP_THREAD_Error(ERR_THREAD_START,error);
  }
[/#if]
  /* USER CODE BEGIN DEVICECONFIG */

  /* USER CODE END DEVICECONFIG */
}


void APP_THREAD_Init( void )
{
#if (CFG_LPM_LEVEL != 0)
  UTIL_LPM_SetStopMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);
  UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);
#endif // CFG_LPM_LEVEL

  Thread_Init();

  APP_THREAD_DeviceConfig();
}

/**
 * @brief  Warn the user that an error has occurred.
 *
 * @param  pMess  : Message associated to the error.
 * @param  ErrCode: Error code associated to the module (OpenThread or other module if any)
 * @retval None
 */
static void APP_THREAD_TraceError(const char * pMess, uint32_t ErrCode)
{
  /* USER CODE BEGIN TRACE_ERROR */

  /* USER CODE END TRACE_ERROR */
}

/**
 * @brief  Trace the error or the warning reported.
 * @param  ErrId :
 * @param  ErrCode
 * @retval None
 */
void APP_THREAD_Error(uint32_t ErrId, uint32_t ErrCode)
{
  /* USER CODE BEGIN APP_THREAD_Error_1 */

  /* USER CODE END APP_THREAD_Error_1 */
  
  switch(ErrId)
  {
    case ERR_THREAD_SET_STATE_CB :
        APP_THREAD_TraceError("ERROR : ERR_THREAD_SET_STATE_CB ",ErrCode);
        break;

    case ERR_THREAD_SET_CHANNEL :
        APP_THREAD_TraceError("ERROR : ERR_THREAD_SET_CHANNEL ",ErrCode);
        break;

    case ERR_THREAD_SET_PANID :
        APP_THREAD_TraceError("ERROR : ERR_THREAD_SET_PANID ",ErrCode);
        break;

    case ERR_THREAD_IPV6_ENABLE :
        APP_THREAD_TraceError("ERROR : ERR_THREAD_IPV6_ENABLE ",ErrCode);
        break;

    case ERR_THREAD_START :
        APP_THREAD_TraceError("ERROR: ERR_THREAD_START ", ErrCode);
        break;

    case ERR_THREAD_ERASE_PERSISTENT_INFO :
        APP_THREAD_TraceError("ERROR : ERR_THREAD_ERASE_PERSISTENT_INFO ",ErrCode);
        break;

    case ERR_THREAD_SET_NETWORK_KEY :
        APP_THREAD_TraceError("ERROR : ERR_THREAD_SET_NETWORK_KEY ",ErrCode);
        break;

    case ERR_THREAD_CHECK_WIRELESS :
        APP_THREAD_TraceError("ERROR : ERR_THREAD_CHECK_WIRELESS ",ErrCode);
        break;

	case ERR_THREAD_SET_THRESHOLD:
        APP_THREAD_TraceError("ERROR : ERR_THREAD_SET_THRESHOLD", ErrCode);
        break;
    
    /* USER CODE BEGIN APP_THREAD_Error_2 */

    /* USER CODE END APP_THREAD_Error_2 */
    default :
        APP_THREAD_TraceError("ERROR Unknown ", 0);
        break;
  }
}

[#if (THREAD_APPLICATION != "RCP")]
/**
 * @brief Thread notification when the state changes.
 * @param  aFlags  : Define the item that has been modified
 *         aContext: Context
 *
 * @retval None
 */
static void APP_THREAD_StateNotif(uint32_t NotifFlags, void *pContext)
{
  /* Prevent unused argument(s) compilation warning */
  UNUSED(pContext);

  /* USER CODE BEGIN APP_THREAD_STATENOTIF */
  
  /* USER CODE END APP_THREAD_STATENOTIF */

  if ((NotifFlags & (uint32_t)OT_CHANGED_THREAD_ROLE) == (uint32_t)OT_CHANGED_THREAD_ROLE)
  {
    switch (otThreadGetDeviceRole(PtOpenThreadInstance))
    {
      case OT_DEVICE_ROLE_DISABLED:
          /* USER CODE BEGIN OT_DEVICE_ROLE_DISABLED */
          /* USER CODE END OT_DEVICE_ROLE_DISABLED */
          break;
          
      case OT_DEVICE_ROLE_DETACHED:
          /* USER CODE BEGIN OT_DEVICE_ROLE_DETACHED */
          /* USER CODE END OT_DEVICE_ROLE_DETACHED */
          break;
          
      case OT_DEVICE_ROLE_CHILD:
          /* USER CODE BEGIN OT_DEVICE_ROLE_CHILD */
          /* USER CODE END OT_DEVICE_ROLE_CHILD */
          break;
    
      case OT_DEVICE_ROLE_ROUTER :
          /* USER CODE BEGIN OT_DEVICE_ROLE_ROUTER */
          /* USER CODE END OT_DEVICE_ROLE_ROUTER */
          break;
        
      case OT_DEVICE_ROLE_LEADER :
          /* USER CODE BEGIN OT_DEVICE_ROLE_LEADER */
          /* USER CODE END OT_DEVICE_ROLE_LEADER */
          break;
          
      default:
          /* USER CODE BEGIN DEFAULT */
          /* USER CODE END DEFAULT */
          break;
    }
  }
}

#if (OT_CLI_USE == 1)
/* OT CLI UART functions */
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
static void APP_THREAD_ProcessUart(void)
{
  arcUartProcess();
}

void APP_THREAD_ScheduleUART(void)
{
  UTIL_SEQ_SetTask(1U << CFG_TASK_OT_UART, TASK_PRIO_UART);
}
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
static void APP_THREAD_ProcessUart(ULONG lArgument)
{
  UNUSED(lArgument);
  
  for(;;)
  {
    tx_semaphore_get(&CliUartSemaphore, TX_WAIT_FOREVER);
    arcUartProcess();
  }
}

void APP_THREAD_ScheduleUART(void)
{
  tx_semaphore_put(&CliUartSemaphore);
}
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
static void APP_THREAD_ProcessUart(void *argument)
{
  UNUSED(argument);
  
  for(;;)
  {
    osSemaphoreAcquire(CliUartSemaphore, osWaitForever);
    arcUartProcess();
  }
}

void APP_THREAD_ScheduleUART(void)
{
  osSemaphoreRelease(CliUartSemaphore);
}
[/#if]

static void APP_THREAD_CliInit(otInstance *aInstance)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_RegTask(1 << CFG_TASK_OT_UART, UTIL_SEQ_RFU, APP_THREAD_ProcessUart);
  /* run first time */ 
  UTIL_SEQ_SetTask(1U << CFG_TASK_OT_UART, TASK_PRIO_UART);
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  UINT ThreadXStatus;
  CHAR *pStack;
  
  /* Register semaphore to launch task */
  ThreadXStatus = tx_semaphore_create(&CliUartSemaphore, "CliUartSemaphore", 0);

  /* Create CLI UART thread with this stack */
  if (ThreadXStatus == TX_SUCCESS)
  { 
    ThreadXStatus |= tx_byte_allocate(pBytePool, (VOID**) &pStack, TASK_CLI_UART_STACK_SIZE, TX_NO_WAIT);
  }
  if (ThreadXStatus == TX_SUCCESS)
  {
    ThreadXStatus |= tx_thread_create(&CliUartTask, "CliUartTask", APP_THREAD_ProcessUart, 0, pStack,
                                      TASK_CLI_UART_STACK_SIZE, TASK_PRIO_CLI_UART, TASK_PREEMP_CLI_UART,
                                      TX_NO_TIME_SLICE, TX_AUTO_START);
  }

  /* Verify if it's OK */
  if (ThreadXStatus != TX_SUCCESS)
  { 
    LOG_ERROR_APP( "ERROR THREADX : CLI UART THREAD CREATION FAILED (%d)", ThreadXStatus );
    while(1);
  }
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  CliUartSemaphore = osSemaphoreNew( 1, 0, NULL );
  if (CliUartSemaphore == NULL)
  { 
    APP_DBG( "ERROR FREERTOS : CLI UART SEMAPHORE CREATION FAILED" );
    while(1);
  }  

  CliUartTask = osThreadNew( APP_THREAD_ProcessUart, NULL, &CliUartTask_attr );
  if (CliUartTask == NULL)
  { 
    APP_DBG( "ERROR FREERTOS : CLI UART TASK CREATION FAILED" );
    while(1);
  }  
[/#if]

  otPlatUartEnable();
  otCliInit(aInstance, CliUartOutput, aInstance);
}
#endif /* OT_CLI_USE */

[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
static void APP_THREAD_ProcessPka(void)
{
  otPlatPkaProccessLoop();
}

void APP_THREAD_SchedulePka(void)
{
  UTIL_SEQ_SetTask(1U << CFG_TASK_PKA, TASK_PRIO_PKA);
}

void APP_THREAD_WaitPkaEndOfOperation(void)
{
  /* Wait for event CFG_EVENT_PKA_COMPLETED */
  UTIL_SEQ_WaitEvt(1U << CFG_EVENT_PKA_COMPLETED);
}

void APP_THREAD_PostPkaEndOfOperation(void)
{
  /* Pka operation ended, set CFG_EVENT_PKA_COMPLETED event */
  UTIL_SEQ_SetEvt(1U << CFG_EVENT_PKA_COMPLETED);
}
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
static void APP_THREAD_ProcessPka(ULONG lArgument)
{
  UNUSED(lArgument);
  
  for(;;)
  {
    tx_semaphore_get(&PkaSemaphore, TX_WAIT_FOREVER);
    otPlatPkaProccessLoop();
  }
}

void APP_THREAD_SchedulePka(void)
{
  tx_semaphore_put(&PkaSemaphore);
}

void APP_THREAD_WaitPkaEndOfOperation(void)
{
  tx_semaphore_get(&PkaCompletedSemaphore, TX_WAIT_FOREVER);
}

void APP_THREAD_PostPkaEndOfOperation(void)
{
  tx_semaphore_put(&PkaCompletedSemaphore);
}
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
static void APP_THREAD_ProcessPka(void *argument)
{
  UNUSED(argument);
  
  for(;;)
  {
    osSemaphoreAcquire(PkaSemaphore, osWaitForever);
    otPlatPkaProccessLoop();
  }
}

void APP_THREAD_SchedulePka(void)
{
  osSemaphoreRelease(PkaSemaphore);
}

void APP_THREAD_WaitPkaEndOfOperation(void)
{
  osSemaphoreAcquire(PkaCompletedSemaphore, osWaitForever);
}

void APP_THREAD_PostPkaEndOfOperation(void)
{
  osSemaphoreRelease(PkaCompletedSemaphore);
}
[/#if]
[/#if]

void app_logger_write(uint8_t *buffer, uint32_t size)
{
  //UTIL_ADV_TRACE_COND_Send(VLEVEL_ALWAYS, ~0x0, 0, buffer, (uint16_t)size);
}

/* USER CODE BEGIN FD_LOCAL_FUNCTIONS */

/* USER CODE END FD_LOCAL_FUNCTIONS */


