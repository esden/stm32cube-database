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
[#assign TRACE = false]
[#assign USBPD_REV30_SUPPORT = false]
[#assign SRC = false]
[#assign SNK = false]
[#assign DRP = false]
[#assign USBPDCORE_LIB_NO_PD = false]
[#assign USBPD_STATEMACHINE = false]

[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
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
            [#if definition.name == "USBPD_CoreLib" && definition.value == "USBPDCORE_LIB_NO_PD"]
                [#assign USBPDCORE_LIB_NO_PD = true]
            [/#if]
            [#if definition.name == "USBPD_StateMachine" && definition.value == "true"]
                [#assign USBPD_STATEMACHINE = true]
            [/#if]
        [/#list]
    [/#if]
[/#list]

#define __USBPD_DPM_CORE_C

/* Includes ------------------------------------------------------------------*/
#include "usbpd_core.h"
#include "usbpd_trace.h"
#include "usbpd_dpm_core.h"
[#if !USBPDCORE_LIB_NO_PD || USBPD_STATEMACHINE]
#include "usbpd_dpm_user.h"
[/#if]
#include "usbpd_dpm_conf.h"

[#if FREERTOS?? && Secure!="true"]
#include "cmsis_os.h"
#if (osCMSIS >= 0x20000U)
#include "task.h"
#endif /* osCMSIS >= 0x20000U */
[/#if]

[#if !FREERTOS??]
#if USBPD_PORT_COUNT >= 2
#error "the non RTOS mode is supported only for one port configuration"
#endif
[/#if]

/* Generic STM32 prototypes */
extern uint32_t HAL_GetTick(void);

/* Private function prototypes -----------------------------------------------*/
[#if FREERTOS?? && Secure!="true"]
#if (osCMSIS < 0x20000U)
[#if !USBPDCORE_LIB_NO_PD]
void USBPD_PE_Task(void const *argument);
[/#if]
[#if !USBPDCORE_LIB_NO_PD || USBPD_STATEMACHINE]
void USBPD_CAD_Task(void const *argument);
[/#if]
[#if TRACE]
void USBPD_TRACE_TX_Task(void const *argument);
[/#if]

#else /* osCMSIS >= 0x20000U */

[#if !USBPDCORE_LIB_NO_PD]
void USBPD_PE_Task_P0(void *argument);
void USBPD_PE_Task_P1(void *argument);
static void PE_Task(uint32_t PortNum);
[/#if]
[#if !USBPDCORE_LIB_NO_PD || USBPD_STATEMACHINE]
void USBPD_CAD_Task(void *argument);
[/#if]
[#if TRACE]
void USBPD_TRACE_TX_Task(void *argument);
[/#if]
#endif /* osCMSIS < 0x20000U */
[#else] /* !FREERTOS */

[#if !USBPDCORE_LIB_NO_PD || USBPD_STATEMACHINE]
void USBPD_CAD_Task(void);
[/#if]

[#if TRACE]
void USBPD_TRACE_TX_Task(void);
[/#if]

[#if !USBPDCORE_LIB_NO_PD]
void USBPD_PE_Task_P0(void);
void USBPD_PE_Task_P1(void);
[/#if]

void USBPD_TaskUser(void);

[/#if]

/* Private typedef -----------------------------------------------------------*/
[#if FREERTOS?? && Secure!="true"]
#if (osCMSIS < 0x20000U)
#define DPM_STACK_SIZE_ADDON_FOR_CMSIS              1
#else
#define DPM_STACK_SIZE_ADDON_FOR_CMSIS              4
#endif /* osCMSIS < 0x20000U */
[#if !USBPDCORE_LIB_NO_PD]
#define FREERTOS_PE_PRIORITY                    osPriorityAboveNormal
[#if USBPDCORE_LIB_NO_PD]
#define FREERTOS_PE_STACK_SIZE                  (350 * DPM_STACK_SIZE_ADDON_FOR_CMSIS)
[#else]
#define FREERTOS_PE_STACK_SIZE                  (200 * DPM_STACK_SIZE_ADDON_FOR_CMSIS)
[/#if]
[/#if]
#define FREERTOS_CAD_PRIORITY                   osPriorityRealtime
#define FREERTOS_CAD_STACK_SIZE                 (300 * DPM_STACK_SIZE_ADDON_FOR_CMSIS)
[#if TRACE]
#define FREERTOS_TRACE_PRIORITY                 osPriorityLow
#define FREERTOS_TRACE_STACK_SIZE               (300 * DPM_STACK_SIZE_ADDON_FOR_CMSIS)
[/#if]

#if (osCMSIS < 0x20000U)
[#if !USBPDCORE_LIB_NO_PD]
osThreadDef(PE_0, USBPD_PE_Task, FREERTOS_PE_PRIORITY, 0, FREERTOS_PE_STACK_SIZE);
osThreadDef(PE_1, USBPD_PE_Task, FREERTOS_PE_PRIORITY, 0, FREERTOS_PE_STACK_SIZE);
osMessageQDef(queuePE, 1, uint16_t);
[/#if]
[#if !USBPDCORE_LIB_NO_PD || USBPD_STATEMACHINE]
osThreadDef(CAD, USBPD_CAD_Task, FREERTOS_CAD_PRIORITY, 0, FREERTOS_CAD_STACK_SIZE);
osMessageQDef(queueCAD, 2, uint16_t);
[/#if]
[#if TRACE]
osThreadDef(TRA_TX, USBPD_TRACE_TX_Task, FREERTOS_TRACE_PRIORITY, 0, FREERTOS_TRACE_STACK_SIZE);
osMessageQDef(queueTRACE, 1, uint16_t);
[/#if]

#else /* osCMSIS >= 0x20000U */

[#if !USBPDCORE_LIB_NO_PD]
osThreadAttr_t PE0_Thread_Atrr = {
  .name       = "PE_0",
  .priority   = FREERTOS_PE_PRIORITY, /*osPriorityAboveNormal,*/
  .stack_size = FREERTOS_PE_STACK_SIZE
};
osThreadAttr_t PE1_Thread_Atrr = {
  .name       = "PE_1",
  .priority   = FREERTOS_PE_PRIORITY,
  .stack_size = FREERTOS_PE_STACK_SIZE
};
[/#if]

[#if !USBPDCORE_LIB_NO_PD || USBPD_STATEMACHINE]
osThreadAttr_t CAD_Thread_Atrr = {
  .name       = "CAD",
  .priority   = FREERTOS_CAD_PRIORITY, /*osPriorityRealtime,*/
  .stack_size = FREERTOS_CAD_STACK_SIZE
};
[/#if]

[#if TRACE]
osThreadAttr_t TRA_Thread_Atrr = {
  .name       = "TRA_TX",
  .priority   = FREERTOS_TRACE_PRIORITY, /*osPriorityLow,*/
  .stack_size = FREERTOS_TRACE_STACK_SIZE
};
[/#if]
#endif /* osCMSIS < 0x20000U */
[/#if]

/* Private define ------------------------------------------------------------*/
[#if FREERTOS?? && Secure!="true"]
#if (osCMSIS < 0x20000U)
#define OSTHREAD_PE(__PORT__)       (((__PORT__) == USBPD_PORT_0) ? osThread(PE_0) : osThread(PE_1))
#else
#define OSTHREAD_PE(__PORT__)       (((__PORT__) == USBPD_PORT_0) ? USBPD_PE_Task_P0 : USBPD_PE_Task_P1)
#define OSTHREAD_PE_ATTR(__PORT__)  (((__PORT__) == USBPD_PORT_0) ? &PE0_Thread_Atrr : &PE1_Thread_Atrr)
#endif /* osCMSIS < 0x20000U */
[/#if]

/* Private macro -------------------------------------------------------------*/
#define CHECK_PE_FUNCTION_CALL(_function_)  _retr = _function_;                  \
                                            if(USBPD_OK != _retr) {return _retr;}
#define CHECK_CAD_FUNCTION_CALL(_function_) if(USBPD_CAD_OK != _function_) {return USBPD_ERROR;}

#if defined(_DEBUG_TRACE)
#define DPM_CORE_DEBUG_TRACE(_PORTNUM_, __MESSAGE__)  USBPD_TRACE_Add(USBPD_TRACE_DEBUG, _PORTNUM_, 0u, (uint8_t *)(__MESSAGE__), sizeof(__MESSAGE__) - 1u);
#else
#define DPM_CORE_DEBUG_TRACE(_PORTNUM_, __MESSAGE__)
#endif /* _DEBUG_TRACE */

/* Private variables ---------------------------------------------------------*/
[#if FREERTOS?? && Secure!="true"]
[#if USBPDCORE_LIB_NO_PD]
[#if USBPD_STATEMACHINE]
static osMessageQId CADQueueId;
[/#if]
[#else]
static osThreadId DPM_PEThreadId_Table[USBPD_PORT_COUNT];
static osMessageQId CADQueueId;
static osMessageQId PEQueueId[USBPD_PORT_COUNT];
[/#if]
[#if TRACE]
osMessageQId TraceQueueId;
[/#if]
[#else]
[#if TRACE]
#define OFFSET_TRACE 1U
[#else]
#define OFFSET_TRACE 0U
[/#if]
#define OFFSET_CAD 1U
[#if !USBPDCORE_LIB_NO_PD || USBPD_STATEMACHINE || TRACE]
static uint32_t DPM_Sleep_time[USBPD_PORT_COUNT + OFFSET_CAD + OFFSET_TRACE];
static uint32_t DPM_Sleep_start[USBPD_PORT_COUNT + OFFSET_CAD + OFFSET_TRACE];
[/#if]
[/#if]

USBPD_ParamsTypeDef   DPM_Params[USBPD_PORT_COUNT];

/* Private function prototypes -----------------------------------------------*/
[#if !USBPDCORE_LIB_NO_PD]
static void USBPD_PE_TaskWakeUp(uint8_t PortNum);
static void DPM_ManageAttachedState(uint8_t PortNum, USBPD_CAD_EVENT State, CCxPin_TypeDef Cc);
[/#if]
[#if !USBPDCORE_LIB_NO_PD || USBPD_STATEMACHINE]
void USBPD_DPM_CADCallback(uint8_t PortNum, USBPD_CAD_EVENT State, CCxPin_TypeDef Cc);
static void USBPD_DPM_CADTaskWakeUp(void);
[/#if]
[#if TRACE]
void USBPD_DPM_TraceWakeUp(void);
[/#if]

/**
  * @brief  Initialize the core stack (port power role, PWR_IF, CAD and PE Init procedures)
  * @retval USBPD status
  */
USBPD_StatusTypeDef USBPD_DPM_InitCore(void)
{
  /* variable to get dynamique memory allocated by usbpd stack */
  uint32_t stack_dynamemsize;
  USBPD_StatusTypeDef _retr = USBPD_OK;

[#if USBPDCORE_LIB_NO_PD]

[#if USBPD_STATEMACHINE]
  static const USBPD_CAD_Callbacks CAD_cbs = { USBPD_DPM_CADCallback, USBPD_DPM_CADTaskWakeUp };
[/#if]

  /* Check the lib selected */
  if (USBPD_TRUE != USBPD_PE_CheckLIB(_LIB_ID))
  {
    return USBPD_ERROR;
  }

  /* to get how much memory are dynamically allocated by the stack
     the memory return is corresponding to 2 ports so if the application
     managed only one port divide the value return by 2                   */
  stack_dynamemsize = USBPD_PE_GetMemoryConsumption();

  /* done to avoid warning */
  (void)stack_dynamemsize;

#if defined(_TRACE) || defined(_GUI_INTERFACE)
  /* Initialise the TRACE */
  USBPD_TRACE_Init();
#endif /* _TRACE || _GUI_INTERFACE */

  DPM_Params[USBPD_PORT_0].PE_PowerRole     = DPM_Settings[USBPD_PORT_0].PE_DefaultRole;

[#if USBPD_STATEMACHINE]
  /* Init CAD */
  CHECK_CAD_FUNCTION_CALL(USBPD_CAD_Init(USBPD_PORT_0, &CAD_cbs, (USBPD_SettingsTypeDef *)&DPM_Settings[USBPD_PORT_0], &DPM_Params[USBPD_PORT_0]));

  /* Enable CAD on Port 0 */
  USBPD_CAD_PortEnable(USBPD_PORT_0, USBPD_CAD_ENABLE);
[#else]
   /* Init CAD */
  CHECK_CAD_FUNCTION_CALL(USBPD_CAD_Init(USBPD_PORT_0, NULL, (USBPD_SettingsTypeDef *)&DPM_Settings[USBPD_PORT_0], &DPM_Params[USBPD_PORT_0]));
[/#if]

[#else]

  static const USBPD_PE_Callbacks dpmCallbacks =
  {
[#if SRC || DRP]
    USBPD_DPM_SetupNewPower,
[#else]
    NULL,
[/#if]
    USBPD_DPM_HardReset,
[#if DRP]
    USBPD_DPM_EvaluatePowerRoleSwap,
[#else]
    NULL,
[/#if]
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
#if defined(_VCONN_SUPPORT)
    USBPD_DPM_EvaluateVconnSwap,
    USBPD_DPM_PE_VconnPwr,
#else
    NULL,
    NULL,
#endif /* _VCONN_SUPPORT */
    NULL,
    USBPD_DPM_EvaluateDataRoleSwap,
    USBPD_DPM_IsPowerReady
  };

  static const USBPD_CAD_Callbacks CAD_cbs = { USBPD_DPM_CADCallback, USBPD_DPM_CADTaskWakeUp };

  /* Check the lib selected */
  if (USBPD_TRUE != USBPD_PE_CheckLIB(_LIB_ID))
  {
    return USBPD_ERROR;
  }

  /* to get how much memory are dynamically allocated by the stack
     the memory return is corresponding to 2 ports so if the application
     managed only one port divide the value return by 2                   */
  stack_dynamemsize = USBPD_PE_GetMemoryConsumption();

  /* done to avoid warning */
  (void)stack_dynamemsize;

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

  /* CAD SET UP : Port 0 */
  CHECK_CAD_FUNCTION_CALL(USBPD_CAD_Init(USBPD_PORT_0, (USBPD_CAD_Callbacks *)&CAD_cbs, (USBPD_SettingsTypeDef *)&DPM_Settings[USBPD_PORT_0], &DPM_Params[USBPD_PORT_0]));
#if USBPD_PORT_COUNT == 2
  CHECK_CAD_FUNCTION_CALL(USBPD_CAD_Init(USBPD_PORT_1, (USBPD_CAD_Callbacks *)&CAD_cbs, (USBPD_SettingsTypeDef *)&DPM_Settings[USBPD_PORT_1], &DPM_Params[USBPD_PORT_1]));
#endif /* USBPD_PORT_COUNT == 2 */

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

  /* Enable CAD on Port 0 */
  USBPD_CAD_PortEnable(USBPD_PORT_0, USBPD_CAD_ENABLE);
#if USBPD_PORT_COUNT == 2
  USBPD_CAD_PortEnable(USBPD_PORT_1, USBPD_CAD_ENABLE);
#endif /* USBPD_PORT_COUNT == 2 */

[/#if]

  return _retr;
}

/**
  * @brief  Initialize the OS parts (task, queue,... )
  * @retval USBPD status
  */
USBPD_StatusTypeDef USBPD_DPM_InitOS(void)
{
[#if FREERTOS?? && Secure!="true"]
[#if !USBPDCORE_LIB_NO_PD]
#if (osCMSIS < 0x20000U)
  CADQueueId = osMessageCreate(osMessageQ(queueCAD), NULL);
  if (osThreadCreate(osThread(CAD), NULL) == NULL)
#else
  CADQueueId = osMessageQueueNew (2, sizeof(uint16_t), NULL);
  if (NULL == osThreadNew(USBPD_CAD_Task, &CADQueueId, &CAD_Thread_Atrr))
#endif /* osCMSIS < 0x20000U */
  {
    return USBPD_ERROR;
  }
[/#if]

[#if TRACE]
#if (osCMSIS < 0x20000U)
  TraceQueueId = osMessageCreate(osMessageQ(queueTRACE), NULL);
  if (NULL == osThreadCreate(osThread(TRA_TX), NULL))
#else
  TraceQueueId = osMessageQueueNew (1, sizeof(uint16_t), NULL);
  if (NULL == osThreadNew(USBPD_TRACE_TX_Task, &TraceQueueId, &TRA_Thread_Atrr))
#endif /* osCMSIS < 0x20000U */
  {
    return USBPD_ERROR;
  }
[/#if]

[#if !USBPDCORE_LIB_NO_PD]
  /* Create the queue corresponding to PE task */
#if (osCMSIS < 0x20000U)
  PEQueueId[0] = osMessageCreate(osMessageQ(queuePE), NULL);
#if USBPD_PORT_COUNT == 2
  PEQueueId[1] = osMessageCreate(osMessageQ(queuePE), NULL);
#endif /* USBPD_PORT_COUNT == 2 */
#else
  PEQueueId[0] = osMessageQueueNew (1, sizeof(uint16_t), NULL);
#if USBPD_PORT_COUNT == 2
  PEQueueId[1] = osMessageQueueNew (1, sizeof(uint16_t), NULL);
#endif /* USBPD_PORT_COUNT == 2 */
#endif /* osCMSIS < 0x20000U */

  /* PE task to be created on attachment */
  DPM_PEThreadId_Table[USBPD_PORT_0] = NULL;
#if USBPD_PORT_COUNT == 2
  DPM_PEThreadId_Table[USBPD_PORT_1] = NULL;
#endif /* USBPD_PORT_COUNT == 2 */
[/#if]
[/#if]

  return USBPD_OK;
}

/**
  * @brief  Initialize the OS parts (port power role, PWR_IF, CAD and PE Init procedures)
  * @retval None
  */
[#if FREERTOS?? && Secure!="true"]
void USBPD_DPM_Run(void)
{
#if (osCMSIS >= 0x20000U)
  osKernelInitialize();
#endif /* osCMSIS >= 0x20000U */
  osKernelStart();
}
[#else]
void USBPD_DPM_Run(void)
{

[#if !USBPDCORE_LIB_NO_PD || USBPD_STATEMACHINE]
    if ((HAL_GetTick() - DPM_Sleep_start[USBPD_PORT_COUNT]) >= DPM_Sleep_time[USBPD_PORT_COUNT])
    {
      DPM_Sleep_time[USBPD_PORT_COUNT] = USBPD_CAD_Process();
      DPM_Sleep_start[USBPD_PORT_COUNT] = HAL_GetTick();
    }
[/#if]

[#if !USBPDCORE_LIB_NO_PD]
    uint32_t port = 0;

    for (port = 0; port < USBPD_PORT_COUNT; port++)
    {
      if ((HAL_GetTick() - DPM_Sleep_start[port]) >= DPM_Sleep_time[port])
      {
        DPM_Sleep_time[port] =
[#if DRP]
          USBPD_PE_StateMachine_DRP(port);
[#elseif SRC]
          USBPD_PE_StateMachine_SRC(port);
[#elseif SNK]
          USBPD_PE_StateMachine_SNK(port);
[/#if]
        DPM_Sleep_start[port] = HAL_GetTick();
      }
    }
[/#if]

[#if !USBPDCORE_LIB_NO_PD || USBPD_STATEMACHINE]
    USBPD_DPM_UserExecute(NULL);
[/#if]

[#if TRACE]
    if ((HAL_GetTick() - DPM_Sleep_start[USBPD_PORT_COUNT + OFFSET_CAD]) >= DPM_Sleep_time[USBPD_PORT_COUNT + OFFSET_CAD])
    {
      DPM_Sleep_time[USBPD_PORT_COUNT + OFFSET_CAD] = USBPD_TRACE_TX_Process();
      DPM_Sleep_start[USBPD_PORT_COUNT + OFFSET_CAD] = HAL_GetTick();
    }
[/#if]

}

[/#if]


[#if !USBPDCORE_LIB_NO_PD]
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
  }
#if USBPD_PORT_COUNT==2
  if (USBPD_TRUE == DPM_Params[USBPD_PORT_1].DPM_Initialized)
  {
    USBPD_DPM_UserTimerCounter(USBPD_PORT_1);
    USBPD_PE_TimerCounter(USBPD_PORT_1);
    USBPD_PRL_TimerCounter(USBPD_PORT_1);
  }
#endif /* USBPD_PORT_COUNT == 2 */

[#if !CUBEMX_GENERATED]
[#-- does not provide this piece of code because already done by CubeMX in main.c --]
[#if FREERTOS?? && Secure!="true"]
#if (osCMSIS >= 0x20000U)
  /* SysTick Handler now fully handled on CMSIS OS V2 side */
#else
  /* check to avoid count before OSKernel Start */
  if (uxTaskGetNumberOfTasks() != 0)
  {
    osSystickHandler();
  }
#endif /* osCMSIS >= 0x20000U */
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
[#if FREERTOS?? && Secure!="true"]
#if (osCMSIS < 0x20000U)
  (void)osMessagePut(PEQueueId[PortNum], 0xFFFF, 0);
#else
  uint32_t event = 0xFFFFU;
  (void)osMessageQueuePut(PEQueueId[PortNum], &event, 0U, 0U);
#endif /* osCMSIS < 0x20000U */
[#else]
  DPM_Sleep_time[PortNum] = 0;
[/#if]
}
[/#if]

[#if !USBPDCORE_LIB_NO_PD || USBPD_STATEMACHINE]
/**
  * @brief  WakeUp CAD task
  * @retval None
  */
static void USBPD_DPM_CADTaskWakeUp(void)
{
[#if FREERTOS?? && Secure!="true"]
#if (osCMSIS < 0x20000U)
  (void)osMessagePut(CADQueueId, 0xFFFF, 0);
#else
  uint32_t event = 0xFFFFU;
  (void)osMessageQueuePut(CADQueueId, &event, 0U, 0U);
#endif /* osCMSIS < 0x20000U */
[#else]
  DPM_Sleep_time[USBPD_PORT_COUNT] = 0;
[/#if]
}
[/#if]

[#if FREERTOS?? && Secure!="true"]
[#if !USBPDCORE_LIB_NO_PD]
#if (osCMSIS < 0x20000U)
/**
  * @brief  Main task for PE layer
  * @param  argument Not used
  * @retval None
  */
void USBPD_PE_Task(void const *argument)
{
  uint8_t _port = (uint32_t)argument;
  uint32_t _timing;

  for(;;)
  {
[#if DRP || (SRC && SNK)]
    _timing = USBPD_PE_StateMachine_DRP(_port);
[#elseif SRC]
    _timing = USBPD_PE_StateMachine_SRC(_port);
[#elseif SNK]
    _timing = USBPD_PE_StateMachine_SNK(_port);
[/#if]
    osMessageGet(PEQueueId[_port],_timing);
  }
}

#else /* osCMSIS > 0x20000U */

/**
  * @brief  Main task for PE layer on Port0
  * @param  argument Not used
  * @retval None
  */
void USBPD_PE_Task_P0(void *argument)
{
  PE_Task(USBPD_PORT_0);
}

/**
  * @brief  Main task for PE layer on Port1
  * @param  argument Not used
  * @retval None
  */
void USBPD_PE_Task_P1(void *argument)
{
  PE_Task(USBPD_PORT_1);
}

/**
  * @brief  Main task for PE layer
  * @param  argument Not used
  * @retval None
  */
static void PE_Task(uint32_t PortNum)
{
  for (;;)
  {
    uint32_t event;
    (void)osMessageQueueGet(PEQueueId[PortNum], &event, NULL,
[#if DRP]
    USBPD_PE_StateMachine_DRP(PortNum));
[#elseif SRC]
    USBPD_PE_StateMachine_SRC(PortNum));
[#elseif SNK]
    USBPD_PE_StateMachine_SNK(PortNum));
[/#if]
  }
}
#endif /* osCMSIS < 0x20000U */
[/#if]

[#if !USBPDCORE_LIB_NO_PD || USBPD_STATEMACHINE]
/**
  * @brief  Main task for CAD layer
  * @param  argument Not used
  * @retval None
  */
#if (osCMSIS < 0x20000U)
void USBPD_CAD_Task(void const *argument)
#else
void USBPD_CAD_Task(void *argument)
#endif /* osCMSIS < 0x20000U */
{
  for (;;)
  {
#if (osCMSIS < 0x20000U)
    osMessageGet(CADQueueId, USBPD_CAD_Process());
#else
    uint32_t event;
    (void)osMessageQueueGet(CADQueueId, &event, NULL, USBPD_CAD_Process());
#endif /* osCMSIS < 0x20000U */
  }
}
[/#if]

[#if TRACE]
/**
  * @brief  Main task for TRACE TX layer
  * @param  argument Not used
  * @retval None
  */
#if (osCMSIS < 0x20000U)
void USBPD_TRACE_TX_Task(void const *argument)
#else
void USBPD_TRACE_TX_Task(void *argument)
#endif /* osCMSIS < 0x20000U */
{
  for (;;)
  {
#if (osCMSIS < 0x20000U)
    osMessageGet(TraceQueueId,USBPD_TRACE_TX_Process());
#else
    uint32_t event;
    (void)osMessageQueueGet(TraceQueueId, &event, NULL, USBPD_TRACE_TX_Process());
#endif /* osCMSIS < 0x20000U */
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
[#if FREERTOS?? && Secure!="true"]
  if (NULL != TraceQueueId)
  {
#if (osCMSIS < 0x20000U)
    (void)osMessagePut(TraceQueueId, 0xFFFF, 0);
#else
    uint32_t event = 0xFFFFU;
    (void)osMessageQueuePut(TraceQueueId, &event, 0U, 0U);
#endif /* osCMSIS < 0x20000U */
  }
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
[#if USBPDCORE_LIB_NO_PD]
[#if USBPD_STATEMACHINE]
void USBPD_DPM_CADCallback(uint8_t PortNum, USBPD_CAD_EVENT State, CCxPin_TypeDef Cc)
{
#ifdef _TRACE
  USBPD_TRACE_Add(USBPD_TRACE_CADEVENT, PortNum, (uint8_t)State, NULL, 0);
#endif /* _TRACE */

  switch (State)
  {
  case USBPD_CAD_EVENT_ATTEMC :
  case USBPD_CAD_EVENT_ATTACHED :
    {
      DPM_Params[PortNum].ActiveCCIs = Cc;
      USBPD_DPM_UserCableDetection(PortNum, State);
      break;
    }
  case USBPD_CAD_EVENT_DETACHED :
  case USBPD_CAD_EVENT_EMC :
    {
      USBPD_DPM_UserCableDetection(PortNum, State);
      DPM_Params[PortNum].ActiveCCIs = CCNONE;
      break;
    }
  default :
    /* nothing to do */
    break;
  }
}
[/#if]
[#else]
void USBPD_DPM_CADCallback(uint8_t PortNum, USBPD_CAD_EVENT State, CCxPin_TypeDef Cc)
{
[#if TRACE]
  USBPD_TRACE_Add(USBPD_TRACE_CADEVENT, PortNum, (uint8_t)State, NULL, 0);
[/#if]

  switch (State)
  {
    case USBPD_CAD_EVENT_ATTEMC :
    {
#ifdef _VCONN_SUPPORT
      DPM_Params[PortNum].VconnStatus = USBPD_TRUE;
#endif /* _VCONN_SUPPORT */
      DPM_ManageAttachedState(PortNum, State, Cc);
#ifdef _VCONN_SUPPORT
      DPM_CORE_DEBUG_TRACE(PortNum, "Note: VconnStatus=TRUE");
#endif /* _VCONN_SUPPORT */
      break;
    }
    case USBPD_CAD_EVENT_ATTACHED :
      DPM_ManageAttachedState(PortNum, State, Cc);
      break;
    case USBPD_CAD_EVENT_DETACHED :
    case USBPD_CAD_EVENT_EMC :
    {
      /* The ufp is detached */
      (void)USBPD_PE_IsCableConnected(PortNum, 0);
      /* Terminate PE task */
[#if FREERTOS?? && Secure!="true"]
      if (DPM_PEThreadId_Table[PortNum] != NULL)
      {
        osThreadTerminate(DPM_PEThreadId_Table[PortNum]);
        DPM_PEThreadId_Table[PortNum] = NULL;
      }
[#else]
      DPM_Sleep_time[PortNum] = 0xFFFFFFFFU;
[/#if]
      DPM_Params[PortNum].PE_SwapOngoing = USBPD_FALSE;
      DPM_Params[PortNum].ActiveCCIs = CCNONE;
      DPM_Params[PortNum].PE_Power   = USBPD_POWER_NO;
      USBPD_DPM_UserCableDetection(PortNum, State);
#ifdef _VCONN_SUPPORT
      DPM_Params[PortNum].VconnCCIs = CCNONE;
      DPM_Params[PortNum].VconnStatus = USBPD_FALSE;
      DPM_CORE_DEBUG_TRACE(PortNum, "Note: VconnStatus=FALSE");
#endif /* _VCONN_SUPPORT */
      break;
    }
    default :
      /* nothing to do */
      break;
  }
}

static void DPM_ManageAttachedState(uint8_t PortNum, USBPD_CAD_EVENT State, CCxPin_TypeDef Cc)
{
#ifdef _VCONN_SUPPORT
  if (CC1 == Cc)
  {
    DPM_Params[PortNum].VconnCCIs = CC2;
  }
  if (CC2 == Cc)
  {
    DPM_Params[PortNum].VconnCCIs = CC1;
  }
#endif /* _VCONN_SUPPORT */
  DPM_Params[PortNum].ActiveCCIs = Cc;
  (void)USBPD_PE_IsCableConnected(PortNum, 1);

  USBPD_DPM_UserCableDetection(PortNum, State);

[#if FREERTOS?? && Secure!="true"]
  /* Create PE task */
  if (DPM_PEThreadId_Table[PortNum] == NULL)
  {
#if (osCMSIS < 0x20000U)
    DPM_PEThreadId_Table[PortNum] = osThreadCreate(OSTHREAD_PE(PortNum), (void *)((uint32_t)PortNum));
#else
    DPM_PEThreadId_Table[PortNum] = osThreadNew(OSTHREAD_PE(PortNum), NULL, OSTHREAD_PE_ATTR(PortNum));
#endif /* osCMSIS < 0x20000U */
    if (DPM_PEThreadId_Table[PortNum] == NULL)
    {
      /* should not occurr. May be an issue with FreeRTOS heap size too small */
      while (1);
    }
  }
[#else]
  DPM_Sleep_time[PortNum] = 0U;
[/#if]
}
[/#if]

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
