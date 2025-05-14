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
[#assign THREAD_APPLICATION = 0]
[#assign CFG_CLI_UART = 0]
[#assign FREERTOS_STATUS = 0]
[#assign PANID = 0]
[#assign CHANNEL = 0]
[#assign NETWORKKEY = 0]

[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
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
            [#if (definition.name == "FREERTOS_STATUS")  && (definition.value == "1")]
                [#assign FREERTOS_STATUS = 1]
            [/#if]
        [/#list]
    [/#if]
[/#list]
/* Includes ------------------------------------------------------------------*/
#include <assert.h>
#include <stdint.h>

#include "app_conf.h"
#include "app_common.h"
#include "app_entry.h"
#include "app_thread.h"
#include "dbg_trace.h"
#include "stm32_rtos.h"
#include "stm32_timer.h"

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

#include "joiner.h"
#include OPENTHREAD_CONFIG_FILE

/* Private includes -----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private defines -----------------------------------------------------------*/
#define C_SIZE_CMD_STRING       256U
[#if (THREAD_APPLICATION != "FTD_CLI")]
#define C_PANID                 0x${PANID}U
#define C_CHANNEL_NB            ${CHANNEL}U
[/#if]
#define C_CCA_THRESHOLD         -70

/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macros ------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private function prototypes -----------------------------------------------*/
static void APP_THREAD_DeviceConfig(void);
static void APP_THREAD_StateNotif(uint32_t NotifFlags, void *pContext);
static void APP_THREAD_TraceError(const char * pMess, uint32_t ErrCode);

#if (OT_CLI_USE == 1)
static void APP_THREAD_CliInit(otInstance *aInstance);
static void APP_THREAD_ProcessUart(void);
#endif /* OT_CLI_USE */

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private variables -----------------------------------------------*/
static otInstance * PtOpenThreadInstance;

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Functions Definition ------------------------------------------------------*/

void APP_THREAD_ScheduleAlarm(void)
{
  UTIL_SEQ_SetTask( 1U<< CFG_TASK_OT_ALARM, CFG_TASK_PRIO_ALARM);
}

void APP_THREAD_ScheduleUsAlarm(void)
{
  UTIL_SEQ_SetTask( 1U<< CFG_TASK_OT_US_ALARM, CFG_TASK_PRIO_US_ALARM);
}

void Thread_Init(void)
{
#if OPENTHREAD_CONFIG_MULTIPLE_INSTANCE_ENABLE
  size_t otInstanceBufferLength = 0;
  uint8_t *otInstanceBuffer = NULL;
#endif

  otSysInit(0, NULL);


#if OPENTHREAD_CONFIG_MULTIPLE_INSTANCE_ENABLE
  // Call to query the buffer size
  (void)otInstanceInit(NULL, &otInstanceBufferLength);

  // Call to allocate the buffer
  otInstanceBuffer = (uint8_t *)malloc(otInstanceBufferLength);
  assert(otInstanceBuffer);

  // Initialize OpenThread with the buffer
  PtOpenThreadInstance = otInstanceInit(otInstanceBuffer, &otInstanceBufferLength);
#else
  PtOpenThreadInstance = otInstanceInitSingle();
#endif

  assert(PtOpenThreadInstance);

#if (OT_CLI_USE == 1)
  APP_THREAD_CliInit(PtOpenThreadInstance);
#endif

  otDispatch_tbl_init(PtOpenThreadInstance);

  /* Register tasks */
#if (OT_CLI_USE == 1)
  UTIL_SEQ_RegTask(1<<CFG_TASK_OT_UART, UTIL_SEQ_RFU, APP_THREAD_ProcessUart);
#endif
  UTIL_SEQ_RegTask(1<<CFG_TASK_OT_ALARM, UTIL_SEQ_RFU, ProcessAlarm);
  UTIL_SEQ_RegTask(1<<CFG_TASK_OT_US_ALARM, UTIL_SEQ_RFU, ProcessUsAlarm);
  
  UTIL_SEQ_RegTask(1<<CFG_TASK_OT_TASKLETS, UTIL_SEQ_RFU, ProcessOpenThreadTasklets);

  ll_sys_thread_init();

  /* Run first time */
  UTIL_SEQ_SetTask( 1U<< CFG_TASK_OT_ALARM, CFG_TASK_PRIO_ALARM);
#if (OT_CLI_USE == 1)
  UTIL_SEQ_SetTask( 1U<< CFG_TASK_OT_UART, CFG_TASK_PRIO_TASKLETS);
#endif

  /* USER CODE BEGIN INIT TASKS */

  /* USER CODE END INIT TASKS */
  
}

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
    UTIL_SEQ_SetTask( 1U<< CFG_TASK_OT_TASKLETS, CFG_TASK_PRIO_TASKLETS);
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

  /* Put the IP802_15_4 back to sleep mode */
  //ll_sys_radio_hclk_ctrl_req(LL_SYS_RADIO_HCLK_LL_BG, LL_SYS_RADIO_HCLK_OFF);

  /* Reschedule the tasklets if any */
  ProcessTasklets();
}

/**
 * OpenThread calls this function when the tasklet queue transitions from empty to non-empty.
 *
 * @param[in] aInstance A pointer to an OpenThread instance.
 */
void otTaskletsSignalPending(otInstance *aInstance)
{
  UTIL_SEQ_SetTask( 1U<< CFG_TASK_OT_TASKLETS, CFG_TASK_PRIO_TASKLETS);
}

/**
 * @brief Thread initialization.
 * @param  None
 * @retval None
 */
static void APP_THREAD_DeviceConfig(void)
{
  otError error = OT_ERROR_NONE;
[#if (THREAD_APPLICATION == "FTD_CLI")]

#ifndef OPENTHREAD_RCP
  error = otSetStateChangedCallback(PtOpenThreadInstance, APP_THREAD_StateNotif, NULL);
  if (error != OT_ERROR_NONE)
  {
    APP_THREAD_Error(ERR_THREAD_SET_STATE_CB,error);
  }
#endif /* OPENTHREAD_RCP */
[#else]
  otNetworkKey networkKey = {{0xFF, 0xEE, 0xDD, 0xCC, 0xBB, 0xAA, 0x99, 0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11, 0x00}};

//  error = otInstanceErasePersistentInfo(PtOpenThreadInstance);
//  if (error != OT_ERROR_NONE)
//  {
//    APP_THREAD_Error(ERR_THREAD_ERASE_PERSISTENT_INFO,error);
//  }

  error = otSetStateChangedCallback(PtOpenThreadInstance, APP_THREAD_StateNotif, NULL);
  if (error != OT_ERROR_NONE)
  {
    APP_THREAD_Error(ERR_THREAD_SET_STATE_CB,error);
  }
[/#if]

  error = otPlatRadioSetCcaEnergyDetectThreshold(PtOpenThreadInstance, C_CCA_THRESHOLD);
  if (error != OT_ERROR_NONE)
  {
    APP_THREAD_Error(ERR_THREAD_SET_THRESHOLD,error);
  }

[#if (THREAD_APPLICATION != "FTD_CLI")]
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
  
[#else]
#ifndef OPENTHREAD_RCP
[/#if]
  otPlatRadioEnableSrcMatch(PtOpenThreadInstance, true);

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
[#if (THREAD_APPLICATION == "FTD_CLI")]
#endif /* OPENTHREAD_RCP */
[/#if]

  /* USER CODE BEGIN DEVICECONFIG */

  /* USER CODE END DEVICECONFIG */
}


void APP_THREAD_Init( void )
{
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

    /* USER CODE BEGIN APP_THREAD_Error_2 */

    /* USER CODE END APP_THREAD_Error_2 */
    default :
        APP_THREAD_TraceError("ERROR Unknown ", 0);
        break;
  }
}

[#if (THREAD_APPLICATION == "FTD_CLI")]
#ifndef OPENTHREAD_RCP
[/#if]
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
[#if (THREAD_APPLICATION == "FTD_CLI")]
#endif /* OPENTHREAD_RCP */
[/#if]

void app_logger_write(uint8_t *buffer, uint32_t size)
{
  //UTIL_ADV_TRACE_COND_Send(VLEVEL_ALWAYS, ~0x0, 0, buffer, (uint16_t)size);
}

#if (OT_CLI_USE == 1)
/* OT CLI UART functions */
static void APP_THREAD_ProcessUart(void)
{
  arcUartProcess();
}

void APP_THREAD_ScheduleUART(void)
{
  UTIL_SEQ_SetTask( 1U<< CFG_TASK_OT_UART, CFG_TASK_PRIO_UART);
}

static void APP_THREAD_CliInit(otInstance *aInstance)
{
[#if (THREAD_APPLICATION == "FTD_CLI")]
#ifdef OPENTHREAD_RCP
  otAppNcpInit(aInstance);
#else /* OPENTHREAD_RCP */
  otPlatUartEnable();
  otCliInit(aInstance, CliUartOutput, aInstance);
#endif /* OPENTHREAD_RCP */
[#else]
  otPlatUartEnable();
  otCliInit(aInstance, CliUartOutput, aInstance);
[/#if]
}
#endif /* OT_CLI_USE */

/* USER CODE BEGIN FD_LOCAL_FUNCTIONS */

/* USER CODE END FD_LOCAL_FUNCTIONS */


