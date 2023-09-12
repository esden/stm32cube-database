[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    usbpd_dpm_core.c
  * @author  MCD Application Team
  * @brief   USBPD dpm core file
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign CUBEMX_GENERATED = true]
[#assign USBPD_TCPM_MODULE_ENABLED = false]
[#assign VDM = false]
[#assign RTOS = false]
[#assign GUI_INTERFACE = false]
[#assign FWUPDATE_RESPONDER = false]
[#assign TRACE = false]
[#assign USBPD_REV30_SUPPORT = false]
[#assign SRC = false]
[#assign SNK = false]
[#assign DRP = false]
[#assign VCONN_SUPPORT = false]
[#assign ERROR_RECOVERY = false]
[#assign AUTHENTICATION = false]
[#assign SIMULATOR = false]

[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "VDM"]
                [#assign VDM = true]
            [/#if]
            [#if definition.name == "USBPD_TCPM_MODULE_ENABLED"]
                [#assign USBPD_TCPM_MODULE_ENABLED = true]
            [/#if]
            [#if definition.name == "RTOS"]
                [#assign RTOS = true]
            [/#if]
            [#if definition.name == "GUI_INTERFACE"]
                [#assign GUI_INTERFACE = true]
            [/#if]
            [#if definition.name == "FWUPDATE_RESPONDER"]
                [#assign FWUPDATE_RESPONDER = true]
            [/#if]
            [#if definition.name == "TRACE" && definition.value == "true"]
                [#assign TRACE = true]
            [/#if]
            [#if definition.name == "USBPD_REV30_SUPPORT" && definition.value == "true"]
                [#assign USBPD_REV30_SUPPORT = true]
            [/#if]
            [#if definition.name == "SRC" && definition.value == "true"]
                [#assign SRC = true]
            [/#if]
            [#if definition.name == "SNK" && definition.value == "true"]
                [#assign SNK = true]
            [/#if]
            [#if definition.name == "DRP" && definition.value == "true"]
                [#assign DRP = true]
            [/#if]
            [#if definition.name == "VCONN_SUPPORT"]
                [#assign VCONN_SUPPORT = true]
            [/#if]
            [#if definition.name == "ERROR_RECOVERY"]
                [#assign ERROR_RECOVERY = true]
            [/#if]
            [#if definition.name == "AUTHENTICATION"]
                [#assign AUTHENTICATION = true]
            [/#if]
            [#if definition.name == "SIMULATOR"]
                [#assign SIMULATOR = true]
            [/#if]
        [/#list]
    [/#if]
[/#list]

#define __USBPD_DPM_CORE_C

/* Includes ------------------------------------------------------------------*/
#include "usbpd_core.h"
[#if USBPD_TCPM_MODULE_ENABLED]
#include "usbpd_tcpci.h"
[/#if]
#include "usbpd_trace.h"
#include "usbpd_dpm_core.h"
#include "usbpd_dpm_user.h"
#include "usbpd_dpm_conf.h"
[#if RTOS]
#include "cmsis_os.h"
[#else]
[#if USBPD_TCPM_MODULE_ENABLED]
#include "usbpd_timersserver.h"
[/#if]
[/#if]
[#if FWUPDATE_RESPONDER]
#include "usbpd_pdfu_responder.h"
[/#if]

[#if !RTOS]
#if USBPD_PORT_COUNT >= 2
#error "the non RTOS mode is supported only for one port configuration"
#endif
[/#if]

/* Private enum */
enum
{
  USBPD_THREAD_PORT_0 = USBPD_PORT_0,
#if USBPD_PORT_COUNT == 2
  USBPD_THREAD_PORT_1 = USBPD_PORT_1,
#endif
  USBPD_THREAD_CAD
};

/* Generic STM32 prototypes */
extern uint32_t HAL_GetTick(void);

/* Private function prototypes -----------------------------------------------*/
void USBPD_DPM_CADCallback(uint8_t PortNum, USBPD_CAD_EVENT State, CCxPin_TypeDef Cc);
void USBPD_PE_Task(void const *argument);
[#if USBPD_TCPM_MODULE_ENABLED]
void USBPD_ALERT_Task(void const *argument);
[#else]
void USBPD_CAD_Task(void const *argument);
[/#if]
[#if TRACE]
void USBPD_TRACE_TX_Task(void const *argument);
[/#if]

static void USBPD_PE_TaskWakeUp(uint8_t PortNum);
static void USBPD_DPM_CADTaskWakeUp(void);

/* Private typedef -----------------------------------------------------------*/
[#if RTOS]
[#if VDM]
osThreadDef(PE_0, USBPD_PE_Task, osPriorityHigh, 0, 350);
osThreadDef(PE_1, USBPD_PE_Task, osPriorityHigh, 0, 350);
[#elseif AUTHENTICATION]
osThreadDef(PE_0, USBPD_PE_Task, osPriorityHigh, 0, 350);
osThreadDef(PE_1, USBPD_PE_Task, osPriorityHigh, 0, 350);
[#else]
osThreadDef(PE_0, USBPD_PE_Task, osPriorityHigh, 0, 200);
osThreadDef(PE_1, USBPD_PE_Task, osPriorityHigh, 0, 200);
[/#if]
[/#if]

/* Private define ------------------------------------------------------------*/
#define MAX_THREAD_NB   (USBPD_PORT_COUNT + 1)          /* 1 entry per port + 1 for CAD */

[#if RTOS]
#define OSTHREAD_PE(__VAL__) __VAL__==USBPD_PORT_0?osThread(PE_0):osThread(PE_1)
[/#if]

/* Private macro -------------------------------------------------------------*/
#define CHECK_PE_FUNCTION_CALL(_function_)  if(USBPD_OK != _function_) {return USBPD_ERROR;}
#define CHECK_CAD_FUNCTION_CALL(_function_) if(USBPD_CAD_OK != _function_) {return USBPD_ERROR;}

#if defined(_DEBUG_TRACE)
#define DPM_CORE_DEBUG_TRACE(_PORTNUM_, __MESSAGE__)  USBPD_TRACE_Add(USBPD_TRACE_DEBUG, _PORTNUM_, 0u, (uint8_t *)(__MESSAGE__), sizeof(__MESSAGE__) - 1u);
#else
#define DPM_CORE_DEBUG_TRACE(_PORTNUM_, __MESSAGE__)
#endif /* _DEBUG_TRACE */

/* Private variables ---------------------------------------------------------*/
[#if RTOS]
static osThreadId DPM_Thread_Table[MAX_THREAD_NB];
[#if USBPD_TCPM_MODULE_ENABLED]
osMessageQId  AlarmMsgBox;
[/#if]
osMessageQDef(queuePE, 2, uint16_t);
osMessageQDef(queueCAD, 1, uint16_t);
static osMessageQId PEQueueId[USBPD_PORT_COUNT], CADQueueId;
[#if TRACE]
osMessageQDef(queueTRACE, 1, uint16_t);
osMessageQId TraceQueueId;
[/#if]
[#else]
static uint32_t DPM_Sleep_time[MAX_THREAD_NB];
static uint32_t DPM_Sleep_start[MAX_THREAD_NB];
[/#if]

USBPD_ParamsTypeDef   DPM_Params[USBPD_PORT_COUNT];

/* Private functions ---------------------------------------------------------*/
void USBPD_DPM_TraceWakeUp(void);
static void DPM_ManageAttachedState(uint8_t PortNum, USBPD_CAD_EVENT State, CCxPin_TypeDef Cc);

/**
  * @brief  Initialize the core stack (port power role, PWR_IF, CAD and PE Init procedures)
  * @retval USBPD status
  */
USBPD_StatusTypeDef USBPD_DPM_InitCore(void)
{
  /* variable to get dynamique memory allocated by usbpd stack */
  uint32_t stack_dynamemsize;

  static const USBPD_PE_Callbacks dpmCallbacks =
  {
[#if SRC || DRP]
    USBPD_DPM_SetupNewPower,
[#else]
    NULL,
[/#if]
    USBPD_DPM_HardReset,
    USBPD_DPM_EvaluatePowerRoleSwap,
    USBPD_DPM_Notification,
[#if USBPD_REV30_SUPPORT]
    USBPD_DPM_ExtendedMessageReceived,
[#else]
    NULL,
[/#if]
    USBPD_DPM_GetDataInfo,
    USBPD_DPM_SetDataInfo,
[#if SRC || DRP]
    USBPD_DPM_EvaluateRequest,
[#else]
    NULL,
[/#if]
[#if SNK || DRP]
    USBPD_DPM_SNK_EvaluateCapabilities,
[#else]
    NULL,
[/#if]
[#if DRP]
    USBPD_DPM_PowerRoleSwap,
[#else]
    NULL,
[/#if]
    USBPD_PE_TaskWakeUp,
[#if VCONN_SUPPORT]
    USBPD_DPM_EvaluateVconnSwap,
    USBPD_DPM_PE_VconnPwr,
[#else]
    NULL,
    NULL,
[/#if]
[#if ERROR_RECOVERY]
    USBPD_DPM_EnterErrorRecovery,
[#else]
    NULL,
[/#if]
    USBPD_DPM_EvaluateDataRoleSwap,
    USBPD_DPM_IsPowerReady
  };

  static const USBPD_CAD_Callbacks CAD_cbs = { USBPD_DPM_CADCallback, USBPD_DPM_CADTaskWakeUp };

[#if !SIMULATOR]
  /* Check the lib selected */
  if (USBPD_TRUE != USBPD_PE_CheckLIB(_LIB_ID))
  {
    return USBPD_ERROR;
  }
[/#if]

  /* to get how much memory are dynamically allocated by the stack
     the memory return is corresponding to 2 ports so if the application
     managed only one port divide the value return by 2                   */
  stack_dynamemsize = USBPD_PE_GetMemoryConsumption();

  /* done to avoid warning */
  stack_dynamemsize--;

  /* Variable to be sure that DPM is correctly initialized */
  DPM_Params[USBPD_PORT_0].DPM_Initialized = USBPD_FALSE;
#if USBPD_PORT_COUNT == 2
  DPM_Params[USBPD_PORT_1].DPM_Initialized = USBPD_FALSE;
#endif /* USBPD_PORT_COUNT == 2 */

  /* check the stack settings */
  DPM_Params[USBPD_PORT_0].PE_SpecRevision  = DPM_Settings[USBPD_PORT_0].PE_SpecRevision;
  DPM_Params[USBPD_PORT_0].PE_PowerRole     = DPM_Settings[USBPD_PORT_0].PE_DefaultRole;
  DPM_Params[USBPD_PORT_0].PE_SwapOngoing   = USBPD_FALSE;
  DPM_Params[USBPD_PORT_0].ActiveCCIs       = CCNONE;
  DPM_Params[USBPD_PORT_0].VconnCCIs        = CCNONE;
  DPM_Params[USBPD_PORT_0].VconnStatus      = USBPD_FALSE;
#if USBPD_PORT_COUNT == 2
  DPM_Params[USBPD_PORT_1].PE_SpecRevision  = DPM_Settings[USBPD_PORT_1].PE_SpecRevision;
  DPM_Params[USBPD_PORT_1].PE_PowerRole     = DPM_Settings[USBPD_PORT_1].PE_DefaultRole;
  DPM_Params[USBPD_PORT_1].PE_SwapOngoing   = USBPD_FALSE;
  DPM_Params[USBPD_PORT_1].ActiveCCIs       = CCNONE;
  DPM_Params[USBPD_PORT_1].VconnCCIs        = CCNONE;
  DPM_Params[USBPD_PORT_1].VconnStatus      = USBPD_FALSE;
#endif /* USBPD_PORT_COUNT == 2 */

[#if TRACE]
  /* Initialise the TRACE */
  USBPD_TRACE_Init();
[/#if]

[#if USBPD_TCPM_MODULE_ENABLED]
[#if !RTOS]
  USBPD_TIM_Init();
[/#if]

  USBPD_TCPCI_Init();
  TCPC_DrvTypeDef *tcpc_driver;
  USBPD_TCPCI_GetDevicesDrivers(USBPD_PORT_0, &tcpc_driver);
  USBPD_TCPM_HWInit(USBPD_PORT_0, DPM_Settings[USBPD_PORT_0].CAD_RoleToggle, &DPM_Params[USBPD_PORT_0], (USBPD_CAD_Callbacks *)&CAD_cbs, tcpc_driver);
#if USBPD_PORT_COUNT == 2
  USBPD_TCPCI_GetDevicesDrivers(USBPD_PORT_1, &tcpc_driver);
  USBPD_TCPM_HWInit(USBPD_PORT_1, DPM_Settings[USBPD_PORT_1].CAD_RoleToggle, &DPM_Params[USBPD_PORT_1], (USBPD_CAD_Callbacks *)&CAD_cbs, tcpc_driver);
#endif /* USBPD_PORT_COUNT == 2 */
[#else]
  /* CAD SET UP : Port 0 */
  CHECK_CAD_FUNCTION_CALL(USBPD_CAD_Init(USBPD_PORT_0, &CAD_cbs, (USBPD_SettingsTypeDef *)&DPM_Settings[USBPD_PORT_0], &DPM_Params[USBPD_PORT_0]));
#if USBPD_PORT_COUNT == 2
  CHECK_CAD_FUNCTION_CALL(USBPD_CAD_Init(USBPD_PORT_1, &CAD_cbs, (USBPD_SettingsTypeDef *)&DPM_Settings[USBPD_PORT_1], &DPM_Params[USBPD_PORT_1]));
#endif /* USBPD_PORT_COUNT == 2 */
[/#if]

  /* PE SET UP : Port 0 */
  CHECK_PE_FUNCTION_CALL(USBPD_PE_Init(USBPD_PORT_0, (USBPD_SettingsTypeDef *)&DPM_Settings[USBPD_PORT_0], &DPM_Params[USBPD_PORT_0], &dpmCallbacks));
#if USBPD_PORT_COUNT == 2
  CHECK_PE_FUNCTION_CALL(USBPD_PE_Init(USBPD_PORT_1, (USBPD_SettingsTypeDef *)&DPM_Settings[USBPD_PORT_1], &DPM_Params[USBPD_PORT_1], &dpmCallbacks));
#endif /* USBPD_PORT_COUNT == 2 */

  /* DPM is correctly initialized */
  DPM_Params[USBPD_PORT_0].DPM_Initialized = USBPD_TRUE;
#if USBPD_PORT_COUNT == 2
  DPM_Params[USBPD_PORT_1].DPM_Initialized = USBPD_TRUE;
#endif /* USBPD_PORT_COUNT == 2 */

[#if USBPD_TCPM_MODULE_ENABLED]

[#else]
  /* Enable CAD on Port 0 */
  USBPD_CAD_PortEnable(USBPD_PORT_0, USBPD_CAD_ENABLE);
#if USBPD_PORT_COUNT == 2
  USBPD_CAD_PortEnable(USBPD_PORT_1, USBPD_CAD_ENABLE);
#endif /* USBPD_PORT_COUNT == 2 */
[/#if]

  return USBPD_OK;
}

/**
  * @brief  Initialize the OS parts (task, queue,... )
  * @retval USBPD status
  */
USBPD_StatusTypeDef USBPD_DPM_InitOS(void)
{
[#if RTOS]
[#if USBPD_TCPM_MODULE_ENABLED]
  osMessageQDef(MsgBox, TCPM_ALARMBOX_MESSAGES_MAX, uint16_t);

[#if TRACE]
  osThreadDef(ALERTTask, USBPD_ALERT_Task, osPriorityRealtime, 0, 240);
[#else]
  osThreadDef(ALERTTask, USBPD_ALERT_Task, osPriorityRealtime, 0, 120);
[/#if]
  AlarmMsgBox = osMessageCreate(osMessageQ(MsgBox), NULL);
  if (NULL == osThreadCreate(osThread(ALERTTask), &AlarmMsgBox))
  {
    return USBPD_ERROR;
  }
[#else]
  osThreadDef(CAD, USBPD_CAD_Task, osPriorityRealtime, 0, 300);
  if ((DPM_Thread_Table[USBPD_THREAD_CAD] = osThreadCreate(osThread(CAD), NULL)) == NULL)
  {
    return USBPD_ERROR;
  }
  CADQueueId = osMessageCreate(osMessageQ(queueCAD), NULL);
[/#if]

[#if TRACE]
  TraceQueueId = osMessageCreate(osMessageQ(queueTRACE), NULL);
  osThreadDef(TRA_TX, USBPD_TRACE_TX_Task, osPriorityLow, 0, configMINIMAL_STACK_SIZE * 2);
  if (NULL == osThreadCreate(osThread(TRA_TX), NULL))
  {
    return USBPD_ERROR;
  }
[/#if]

  /* Create the queue corresponding to PE task */
  PEQueueId[0] = osMessageCreate(osMessageQ(queuePE), NULL);
#if USBPD_PORT_COUNT == 2
  PEQueueId[1] = osMessageCreate(osMessageQ(queuePE), NULL);
#endif /* USBPD_PORT_COUNT == 2 */

  /* PE task to be created on attachment */
  DPM_Thread_Table[USBPD_THREAD_PORT_0] = NULL;
#if USBPD_PORT_COUNT == 2
  DPM_Thread_Table[USBPD_THREAD_PORT_1] = NULL;
#endif /* USBPD_PORT_COUNT == 2 */

[#if USBPD_TCPM_MODULE_ENABLED]
  USBPD_TCPI_AlertInit();
[/#if]

[/#if]

  return USBPD_OK;
}

/**
  * @brief  Initialize the OS parts (port power role, PWR_IF, CAD and PE Init procedures)
  * @retval None
  */
void USBPD_DPM_Run(void)
{
[#if RTOS]
  osKernelStart();
[#else]
  do
  {
[#if USBPD_TCPM_MODULE_ENABLED]
[#else]
    (void)USBPD_CAD_Process();
[/#if]
    if ((HAL_GetTick() - DPM_Sleep_start[USBPD_PORT_0]) >  DPM_Sleep_time[USBPD_PORT_0])
    {
      DPM_Sleep_time[USBPD_PORT_0] =
    [#if DRP]
        USBPD_PE_StateMachine_DRP(USBPD_PORT_0);
    [#elseif SRC]
        USBPD_PE_StateMachine_SRC(USBPD_PORT_0);
    [#elseif SNK]
        USBPD_PE_StateMachine_SNK(USBPD_PORT_0);
    [/#if]
      DPM_Sleep_start[USBPD_PORT_0] = HAL_GetTick();
    }

    USBPD_DPM_UserExecute(NULL);
[#if TRACE]
    (void)USBPD_TRACE_TX_Process();
[/#if]

[#if SIMULATOR]
    return;
[/#if]
    }
  while (1u == 1u);
[/#if]
}


/**
  * @brief  Initialize DPM (port power role, PWR_IF, CAD and PE Init procedures)
  * @retval USBPD status
  */
void USBPD_DPM_TimerCounter(void)
{
  /* Call PE/PRL timers functions only if DPM is initialized */
  if (USBPD_TRUE == DPM_Params[USBPD_PORT_0].DPM_Initialized)
  {
    USBPD_DPM_UserTimerCounter(USBPD_PORT_0);
    USBPD_PE_TimerCounter(USBPD_PORT_0);
    USBPD_PRL_TimerCounter(USBPD_PORT_0);
[#if FWUPDATE_RESPONDER]
    USBPD_PDFU_TimerCounter(USBPD_PORT_0);
[/#if]
  }
#if USBPD_PORT_COUNT==2
  if (USBPD_TRUE == DPM_Params[USBPD_PORT_1].DPM_Initialized)
  {
    USBPD_DPM_UserTimerCounter(USBPD_PORT_1);
    USBPD_PE_TimerCounter(USBPD_PORT_1);
    USBPD_PRL_TimerCounter(USBPD_PORT_1);
[#if FWUPDATE_RESPONDER]
    USBPD_PDFU_TimerCounter(USBPD_PORT_1);
[/#if]
  }
#endif /* USBPD_PORT_COUNT == 2 */

[#if !CUBEMX_GENERATED]
[#-- does not provide this piece of code because already done by CubeMX in main.c --]
[#if RTOS]
  /* check to avoid count before OSKernel Start */
  if (uxTaskGetNumberOfTasks() != 0)
  {
    osSystickHandler();
  }
[/#if]
[/#if]
}

/**
  * @brief  WakeUp PE task
  * @param  PortNum port number
  * @retval None
  */
static void USBPD_PE_TaskWakeUp(uint8_t PortNum)
{
[#if RTOS]
  osMessagePut(PEQueueId[PortNum], 0xFFFF, 0);
[#else]
   DPM_Sleep_time[PortNum] = 0;
   DPM_Sleep_start[PortNum] = HAL_GetTick();
[/#if]
}

/**
  * @brief  WakeUp CAD task
  * @retval None
  */
static void USBPD_DPM_CADTaskWakeUp(void)
{
[#if RTOS]
  osMessagePut(CADQueueId, 0xFFFF, 0);
[/#if]
}

[#if RTOS]
/**
  * @brief  Main task for PE layer
  * @param  argument Not used
  * @retval None
  */
void USBPD_PE_Task(void const *argument)
{
  uint8_t _port = (uint32_t)argument;
  for (;;)
  {
    osMessageGet(PEQueueId[_port], [#rt]
[#if DRP]
      [#lt]USBPD_PE_StateMachine_DRP(_port));
[#elseif SRC]
      [#lt]USBPD_PE_StateMachine_SRC(_port));
[#elseif SNK]
      [#lt]USBPD_PE_StateMachine_SNK(_port));
[/#if]

[#if USBPD_TCPM_MODULE_ENABLED]
    /* During SRC tests, VBUS is disabled by the FUSB but the detection is not
       well done */
    if ((DPM_Params[_port].PE_SwapOngoing == 0) && (USBPD_ERROR == USBPD_TCPM_VBUS_IsVsafe5V(_port)))
    {
      osMessagePut(AlarmMsgBox, (_port << 8 | 2), osWaitForever);
    }
[/#if]
  }
}

[#if USBPD_TCPM_MODULE_ENABLED]
/**
  * @brief  Main task for ALERT layer
  * @param  argument: Not used
  * @retval None
  */
void USBPD_ALERT_Task(void const *queue_id)
{
  osMessageQId  queue = *(osMessageQId *)queue_id;
  uint8_t port;
  for (;;)
  {
    osEvent event = osMessageGet(queue, osWaitForever);
    port = (event.value.v >> 8);
[#if TRACE]
    USBPD_TRACE_Add(USBPD_TRACE_DEBUG, port, ((event.value.v) & 0x00FF), "ALERT_TASK", sizeof("ALERT_TASK") - 1);
[/#if]
    USBPD_TCPM_alert(event.value.v);
    HAL_NVIC_EnableIRQ(ALERT_GPIO_IRQHANDLER(port));
  }
}
[#else]
/**
  * @brief  Main task for CAD layer
  * @param  argument Not used
  * @retval None
  */
void USBPD_CAD_Task(void const *argument)
{
  for (;;)
  {
    osMessageGet(CADQueueId, USBPD_CAD_Process());
  }
}
[/#if]

[#if TRACE]
/**
  * @brief  Main task for TRACE TX layer
  * @param  argument Not used
  * @retval None
  */
void USBPD_TRACE_TX_Task(void const *argument)
{
  for (;;)
  {
    (void)USBPD_TRACE_TX_Process();
    osDelay(5);
  }
}
[/#if]
[/#if]

[#if TRACE]
/**
  * @brief  WakeUp TRACE task
  * @retval None
  */
void USBPD_DPM_TraceWakeUp(void)
{
[#if RTOS]
  osMessagePut(TraceQueueId, 0xFFFF, 0);
[#else]
  /* Wake up the non RTOS application to evacuate the trace */
[/#if]
}
[/#if]

/**
  * @brief  CallBack reporting events on a specified port from CAD layer.
  * @param  PortNum   The handle of the port
  * @param  State     CAD state
  * @param  Cc        The Communication Channel for the USBPD communication
  * @retval None
  */
void USBPD_DPM_CADCallback(uint8_t PortNum, USBPD_CAD_EVENT State, CCxPin_TypeDef Cc)
{
[#if TRACE]
  USBPD_TRACE_Add(USBPD_TRACE_CADEVENT, PortNum, (uint8_t)State, NULL, 0);
[/#if]

  switch (State)
  {
    case USBPD_CAD_EVENT_ATTEMC :
    {
[#if !RTOS]
      DPM_Sleep_time[USBPD_PORT_0] = 0;
[/#if]
[#if VCONN_SUPPORT]
      DPM_Params[PortNum].VconnStatus = USBPD_TRUE;
[/#if]
      DPM_ManageAttachedState(PortNum, State, Cc);
[#if VCONN_SUPPORT]
      DPM_CORE_DEBUG_TRACE(PortNum, "Note: VconnStatus=TRUE");
[/#if]
      break;
    }
    case USBPD_CAD_EVENT_ATTACHED :
[#if !RTOS]
      DPM_Sleep_time[USBPD_PORT_0] = 0;
[/#if]
      DPM_ManageAttachedState(PortNum, State, Cc);
      break;
    case USBPD_CAD_EVENT_DETACHED :
    case USBPD_CAD_EVENT_EMC :
    {
      /* The ufp is detached */
      (void)USBPD_PE_IsCableConnected(PortNum, 0);
      /* Terminate PE task */
[#if RTOS]
      if (DPM_Thread_Table[PortNum] != NULL)
      {
        osThreadTerminate(DPM_Thread_Table[PortNum]);
        DPM_Thread_Table[PortNum] = NULL;
      }
[/#if]
      USBPD_DPM_UserCableDetection(PortNum, State);
      DPM_Params[PortNum].PE_SwapOngoing = USBPD_FALSE;
      DPM_Params[PortNum].ActiveCCIs = CCNONE;
      DPM_Params[PortNum].PE_Power   = USBPD_POWER_NO;
[#if VCONN_SUPPORT]
      DPM_Params[PortNum].VconnCCIs = CCNONE;
      DPM_Params[PortNum].VconnStatus = USBPD_FALSE;
      DPM_CORE_DEBUG_TRACE(PortNum, "Note: VconnStatus=FALSE");
[/#if]
    break;
    }
  default :
    /* nothing to do */
    break;
  }
}

static void DPM_ManageAttachedState(uint8_t PortNum, USBPD_CAD_EVENT State, CCxPin_TypeDef Cc)
{
[#if VCONN_SUPPORT]
  if (CC1 == Cc)
    {
      DPM_Params[PortNum].VconnCCIs = CC2;
    }
  if (CC2 == Cc)
    {
      DPM_Params[PortNum].VconnCCIs = CC1;
    }
[/#if]
  DPM_Params[PortNum].ActiveCCIs = Cc;
  (void)USBPD_PE_IsCableConnected(PortNum, 1);

  USBPD_DPM_UserCableDetection(PortNum, State);
[#if USBPD_TCPM_MODULE_ENABLED]
  /* Add a delay to postpone the 1st send of SRC capa
  FUS305 seems not react correctly if it sent too quickly */
  USBPD_DPM_WaitForTime(6);
[/#if]

[#if RTOS]
  /* Create PE task */
  if (DPM_Thread_Table[PortNum] == NULL)
  {
    DPM_Thread_Table[PortNum] = osThreadCreate(OSTHREAD_PE(PortNum), (void *)((uint32_t)PortNum));
    if (DPM_Thread_Table[PortNum] == NULL)
    {
      /* should not occurr. May be an issue with FreeRTOS heap size too small */
      while (1);
    }
  }
[/#if]
}
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
