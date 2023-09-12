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
            [#if definition.name == "TRACE"]
                [#assign TRACE = true]
            [/#if]
            [#if definition.name == "USBPD_REV30_SUPPORT"]
                [#assign USBPD_REV30_SUPPORT = true]
            [/#if]
            [#if definition.name == "SRC"]
                [#assign SRC = true]
            [/#if]
            [#if definition.name == "SNK"]
                [#assign SNK = true]
            [/#if]
            [#if definition.name == "DRP"]
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
[#if VDM || VCONN_SUPPORT]
#include "usbpd_vdm_user.h"
[/#if]
#include "usbpd_dpm_conf.h"
[#if RTOS]
#include "cmsis_os.h"
[#else]
[#if USBPD_TCPM_MODULE_ENABLED]
#include "usbpd_timersserver.h"
[/#if]
[/#if]
[#if GUI_INTERFACE]
#include "string.h"
#include "gui_api.h"
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
enum {
  USBPD_THREAD_PORT_0 = USBPD_PORT_0,
#if USBPD_PORT_COUNT == 2
  USBPD_THREAD_PORT_1 = USBPD_PORT_1,
#endif
  USBPD_THREAD_CAD
};

/* Private function prototypes -----------------------------------------------*/
void USBPD_DPM_CADCallback(uint8_t PortNum, USBPD_CAD_EVENT State, CCxPin_TypeDef Cc);
void USBPD_PE_Task(void const *argument);
[#if USBPD_TCPM_MODULE_ENABLED]
void USBPD_ALERT_Task(void const *argument);
[#else]
void USBPD_CAD_Task(void const *argument);
[/#if]
[#if TRACE || GUI_INTERFACE]
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
osThreadDef(PE_0, USBPD_PE_Task, osPriorityHigh, 0, 150);
osThreadDef(PE_1, USBPD_PE_Task, osPriorityHigh, 0, 150);
[#else]
    [#if USBPD_TCPM_MODULE_ENABLED]
osThreadDef(PE_0, USBPD_PE_Task, osPriorityHigh, 0, 150);
osThreadDef(PE_1, USBPD_PE_Task, osPriorityHigh, 0, 150);
    [#else]
osThreadDef(PE_0, USBPD_PE_Task, osPriorityHigh, 0, 64);
osThreadDef(PE_1, USBPD_PE_Task, osPriorityHigh, 0, 64);
    [/#if]
[/#if]
[/#if]

/* Private define ------------------------------------------------------------*/
[#if RTOS]
#define MAX_TREAD_POWER   (USBPD_PORT_COUNT + 1)
#define OSTHREAD_PE(__VAL__) __VAL__==USBPD_PORT_0?osThread(PE_0):osThread(PE_1)
[/#if]

/* Private macro -------------------------------------------------------------*/
#define CHECK_PE_FUNCTION_CALL(_function_)  if(USBPD_OK != _function_) {return USBPD_ERROR;}
#define CHECK_CAD_FUNCTION_CALL(_function_) if(USBPD_CAD_OK != _function_) {return USBPD_ERROR;}

/* Private variables ---------------------------------------------------------*/
[#if GUI_INTERFACE]
    [#if RTOS]
SemaphoreHandle_t GUI_Requests_To_Process;
    [/#if]
[/#if]

[#if RTOS]
static osThreadId DPM_Thread_Table[MAX_TREAD_POWER];
static uint32_t DPM_Sleep_time[MAX_TREAD_POWER];
[#if USBPD_TCPM_MODULE_ENABLED]
osMessageQId  AlarmMsgBox;
[/#if]
osMessageQDef(queuePE, 2, uint16_t);
osMessageQDef(queueCAD, 1, uint16_t);
static osMessageQId PEQueueId[USBPD_PORT_COUNT], CADQueueId;
[/#if]

USBPD_ParamsTypeDef   DPM_Params[USBPD_PORT_COUNT];

/* Private functions ---------------------------------------------------------*/
static void DPM_ManageAttachedState(uint8_t PortNum, USBPD_CAD_EVENT State, CCxPin_TypeDef Cc);

/**
  * @brief  Initialize the core stack (port power role, PWR_IF, CAD and PE Init procedures)
  * @retval USBPD status
  */
  uint32_t stack_dynamemsize;
USBPD_StatusTypeDef USBPD_DPM_InitCore(void)
{
/* variable to get dynamique memory allocated by usbpd stack */


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

  /* Check the lib selected */
  if( USBPD_TRUE != USBPD_PE_CheckLIB(_LIB_ID))
  {
    return USBPD_ERROR;
  }

  /* to get how much memory are dynamically allocated by the stack
     the memory return is corresponding to 2 ports so if the application
     managed only one port divide the value return by 2                   */
  stack_dynamemsize = USBPD_PE_GetMemoryConsumption();

  /* done to avoid warning */
  stack_dynamemsize--;

[#if GUI_INTERFACE]
  /* Perform copy from FLASH to RAM */
  memcpy(DPM_Settings, DPM_FLASH_Settings, (sizeof(USBPD_SettingsTypeDef) * USBPD_PORT_COUNT));
  memcpy(DPM_USER_Settings, DPM_USER_FLASH_Settings, (sizeof(USBPD_USER_SettingsTypeDef) * USBPD_PORT_COUNT));
[#if VDM]
  memcpy(DPM_VDM_Settings, DPM_VDM_FLASH_Settings, (sizeof(USBPD_VDM_SettingsTypeDef) * USBPD_PORT_COUNT));
[/#if]
[/#if]

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

[#if TRACE || GUI_INTERFACE]
  /* Initialise the TRACE */
  USBPD_TRACE_Init();
[/#if]

[#if USBPD_TCPM_MODULE_ENABLED]
[#if !RTOS]
  USBPD_TIM_Init();
[/#if]

  TCPC_DrvTypeDef* tcpc_driver;
  USBPD_TCPCI_GetDevicesDrivers(USBPD_PORT_0, &tcpc_driver);
  USBPD_TCPM_HWInit(USBPD_PORT_0, DPM_Settings[USBPD_PORT_0].CAD_RoleToggle, &DPM_Params[USBPD_PORT_0], (USBPD_CAD_Callbacks *)&CAD_cbs, tcpc_driver);
#if USBPD_PORT_COUNT == 2
  USBPD_TCPCI_GetDevicesDrivers(USBPD_PORT_1, &tcpc_driver);
  USBPD_TCPM_HWInit(USBPD_PORT_1, DPM_Settings[USBPD_PORT_1].CAD_RoleToggle, &DPM_Params[USBPD_PORT_1], (USBPD_CAD_Callbacks *)&CAD_cbs, tcpc_driver);
#endif /* USBPD_PORT_COUNT == 2 */
[#else]
  /* CAD SET UP : Port 0 */
  CHECK_CAD_FUNCTION_CALL(USBPD_CAD_Init(USBPD_PORT_0, (USBPD_CAD_Callbacks *)&CAD_cbs, (USBPD_SettingsTypeDef *)&DPM_Settings[USBPD_PORT_0], &DPM_Params[USBPD_PORT_0]));
#if USBPD_PORT_COUNT == 2
  CHECK_CAD_FUNCTION_CALL(USBPD_CAD_Init(USBPD_PORT_1, (USBPD_CAD_Callbacks *)&CAD_cbs, (USBPD_SettingsTypeDef *)&DPM_Settings[USBPD_PORT_1], &DPM_Params[USBPD_PORT_1]));
#endif /* USBPD_PORT_COUNT == 2 */
[/#if]

  /* PE SET UP : Port 0 */
  CHECK_PE_FUNCTION_CALL(USBPD_PE_Init(USBPD_PORT_0, (USBPD_SettingsTypeDef *)&DPM_Settings[USBPD_PORT_0], &DPM_Params[USBPD_PORT_0], &dpmCallbacks));
#if USBPD_PORT_COUNT == 2
  CHECK_PE_FUNCTION_CALL(USBPD_PE_Init(USBPD_PORT_1, (USBPD_SettingsTypeDef *)&DPM_Settings[USBPD_PORT_1], &DPM_Params[USBPD_PORT_1], &dpmCallbacks));
#endif /* USBPD_PORT_COUNT == 2 */

[#if VDM]
  if(USBPD_TRUE == DPM_Settings[USBPD_PORT_0].PE_VDMSupport)
  {
    if (USBPD_OK != USBPD_VDM_UserInit(USBPD_PORT_0, (USBPD_VDM_SettingsTypeDef *)&DPM_VDM_Settings[USBPD_PORT_0], &DPM_Params[USBPD_PORT_0]))
    {
      return USBPD_ERROR;
    }
  }
#if USBPD_PORT_COUNT == 2
  if(USBPD_TRUE == DPM_Settings[USBPD_PORT_1].PE_VDMSupport)
  {
    if (USBPD_OK != USBPD_VDM_UserInit(USBPD_PORT_1, (USBPD_VDM_SettingsTypeDef *)&DPM_VDM_Settings[USBPD_PORT_1], &DPM_Params[USBPD_PORT_1]))
    {
      return USBPD_ERROR;
    }
  }
#endif /* USBPD_PORT_COUNT == 2 */
[#elseif VCONN_SUPPORT]
  if (USBPD_OK != USBPD_VDM_UserInit(USBPD_PORT_0, NULL, NULL))
  {
    return USBPD_ERROR;
  }
#if USBPD_PORT_COUNT == 2
  if (USBPD_OK != USBPD_VDM_UserInit(USBPD_PORT_1, NULL, NULL))
  {
    return USBPD_ERROR;
  }
#endif /* USBPD_PORT_COUNT == 2 */
[/#if]

  /* DPM is correctly initialized */
  DPM_Params[USBPD_PORT_0].DPM_Initialized = USBPD_TRUE;
#if USBPD_PORT_COUNT == 2
  DPM_Params[USBPD_PORT_1].DPM_Initialized = USBPD_TRUE;
#endif /* USBPD_PORT_COUNT == 2 */

  /* Initialize */
  if (USBPD_OK != USBPD_DPM_UserInit())
  {
    return USBPD_ERROR;
  }

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
  osThreadDef(CAD, USBPD_CAD_Task, osPriorityRealtime, 0, 96);
  if((DPM_Thread_Table[USBPD_THREAD_CAD] = osThreadCreate(osThread(CAD), NULL)) == NULL)
  {
    return USBPD_ERROR;
  }
  CADQueueId = osMessageCreate(osMessageQ(queueCAD), NULL);
[/#if]

[#if TRACE || GUI_INTERFACE]
  osThreadDef(TRA_TX, USBPD_TRACE_TX_Task, osPriorityLow, 0, configMINIMAL_STACK_SIZE * 2);
  if(NULL == osThreadCreate(osThread(TRA_TX), NULL))
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
[#if DRP]
    (void)USBPD_PE_StateMachine_DRP(USBPD_PORT_0);
[#elseif SRC]
    (void)USBPD_PE_StateMachine_SRC(USBPD_PORT_0);
[#elseif SNK]
    (void)USBPD_PE_StateMachine_SNK(USBPD_PORT_0);
[/#if]

    USBPD_DPM_UserExecute(NULL);
[#if TRACE || GUI_INTERFACE]
    (void)USBPD_TRACE_TX_Process();
[/#if]
    }
  while(1u == 1u);
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

[#if RTOS]
  /* check to avoid count before OSKernel Start */
//  if (uxTaskGetNumberOfTasks() != 0)
//  {
//    osSystickHandler();
//  }
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
  (void)PortNum;
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

UBaseType_t PE_uxHighWaterMark;
UBaseType_t CAD_uxHighWaterMark;
void USBPD_PE_Task(void const *argument)
{
  uint8_t _port = (uint32_t)argument;

  for(;;)
  {
    DPM_Sleep_time[_port] =
[#if DRP]
     USBPD_PE_StateMachine_DRP(_port);
[#elseif SRC]
    USBPD_PE_StateMachine_SRC(_port);
[#elseif SNK]
    USBPD_PE_StateMachine_SNK(_port);
[/#if]
    osMessageGet(PEQueueId[_port], DPM_Sleep_time[_port]);

[#if USBPD_TCPM_MODULE_ENABLED]
    /* During SRC tests, VBUS is disabled by the FUSB but the detection is not
       well done */
    if ((DPM_Params[_port].PE_SwapOngoing == 0) && (USBPD_ERROR == USBPD_TCPM_VBUS_IsVsafe5V(_port)))
    {
      osMessagePut(AlarmMsgBox, (_port << 8 | 2), osWaitForever);
    }
[/#if]


    /* Inspect our own high water mark on entering the task. */
//    PE_uxHighWaterMark = uxTaskGetStackHighWaterMark( NULL );
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
  for(;;)
  {
    osEvent event = osMessageGet(queue, osWaitForever);
    port = (event.value.v >> 8);
[#if TRACE]
    USBPD_TRACE_Add(USBPD_TRACE_DEBUG, port, ((event.value.v) & 0x00FF), "ALERT_TASK", sizeof("ALERT_TASK")-1);
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
  for(;;)
  {
    DPM_Sleep_time[USBPD_THREAD_CAD] = USBPD_CAD_Process();
    osMessageGet(CADQueueId, DPM_Sleep_time[USBPD_THREAD_CAD]);

    /* Inspect our own high water mark on entering the task. */
//    CAD_uxHighWaterMark = uxTaskGetStackHighWaterMark( NULL );
  }
}
[/#if]

[#if TRACE || GUI_INTERFACE]
/**
  * @brief  Main task for TRACE TX layer
  * @param  argument Not used
  * @retval None
  */
void USBPD_TRACE_TX_Task(void const *argument)
{
  for(;;)
  {
    USBPD_TRACE_TX_Process();
    osDelay(5);
  }
}
[/#if]
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

  switch(State)
  {
  case USBPD_CAD_EVENT_ATTEMC :
    {
[#if VCONN_SUPPORT]
    DPM_Params[PortNum].VconnStatus = USBPD_TRUE;
[/#if]
      DPM_ManageAttachedState(PortNum, State, Cc);
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
[#if RTOS]
    if (DPM_Thread_Table[PortNum] != NULL)
    {
      osThreadTerminate(DPM_Thread_Table[PortNum]);
      DPM_Thread_Table[PortNum] = NULL;
    }
[/#if]
    USBPD_DPM_UserCableDetection(PortNum, State);
    DPM_Params[PortNum].ActiveCCIs = CCNONE;
    DPM_Params[PortNum].PE_Power   = USBPD_POWER_NO;
[#if VCONN_SUPPORT]
    DPM_Params[PortNum].VconnCCIs = CCNONE;
    DPM_Params[PortNum].VconnStatus = USBPD_FALSE;
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
  if(CC1 == Cc) {DPM_Params[PortNum].VconnCCIs = CC2;}
  if(CC2 == Cc) {DPM_Params[PortNum].VconnCCIs = CC1;}
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
      while(1);
    }
  }
[/#if]
}
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
