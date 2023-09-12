[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
  * File Name          : ${name}
  * Description        : Entry application source file for BLE
  *                      middleWare.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
 ******************************************************************************
 */
/* USER CODE END Header */

[#assign BLE_TRANSPARENT_MODE_UART = 0]
[#assign BLE_TRANSPARENT_MODE_VCP = 0]
[#assign BT_SIG_BEACON = 0]
[#assign BT_SIG_BLOOD_PRESSURE_SENSOR = 0]
[#assign BT_SIG_HEALTH_THERMOMETER_SENSOR = 0]
[#assign BT_SIG_HEART_RATE_SENSOR = 0]
[#assign CUSTOM_OTA = 0]
[#assign CUSTOM_P2P_CLIENT = 0]
[#assign CUSTOM_P2P_ROUTER = 0]
[#assign CUSTOM_P2P_SERVER = 0]
[#assign CUSTOM_TEMPLATE = 0]
[#assign FREERTOS_STATUS = 0]
[#assign THREAD = 0]
[#assign BLE = 0]
[#assign DBG_TRACE_UART_CFG = ""]

[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
[#--
        ${definition.name}: ${definition.value}
--]
            [#if (definition.name == "BLE_TRANSPARENT_MODE_UART") && (definition.value == "Enabled")]
                [#assign BLE_TRANSPARENT_MODE_UART = 1]
            [/#if]
            [#if (definition.name == "BLE_TRANSPARENT_MODE_VCP") && (definition.value == "Enabled")]
                [#assign BLE_TRANSPARENT_MODE_VCP = 1]
            [/#if]
            [#if (definition.name == "BT_SIG_BEACON") && (definition.value == "Enabled")]
                [#assign BT_SIG_BEACON = 1]
            [/#if]
            [#if (definition.name == "BT_SIG_BLOOD_PRESSURE_SENSOR") && (definition.value == "Enabled")]
                [#assign BT_SIG_BLOOD_PRESSURE_SENSOR = 1]
            [/#if]
            [#if (definition.name == "BT_SIG_HEALTH_THERMOMETER_SENSOR") && (definition.value == "Enabled")]
                [#assign BT_SIG_HEALTH_THERMOMETER_SENSOR = 1]
            [/#if]
            [#if (definition.name == "BT_SIG_HEART_RATE_SENSOR") && (definition.value == "Enabled")]
                [#assign BT_SIG_HEART_RATE_SENSOR = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_OTA") && (definition.value == "Enabled")]
                [#assign CUSTOM_OTA = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_P2P_CLIENT") && (definition.value == "Enabled")]
                [#assign CUSTOM_P2P_CLIENT = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_P2P_ROUTER") && (definition.value == "Enabled")]
                [#assign CUSTOM_P2P_ROUTER = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_P2P_SERVER") && (definition.value == "Enabled")]
                [#assign CUSTOM_P2P_SERVER = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_TEMPLATE") && (definition.value == "Enabled")]
                [#assign CUSTOM_TEMPLATE = 1]
            [/#if]
            [#if definition.name == "BLE_APPLICATION_TYPE"]
                [#assign BLE_APPLICATION_TYPE = definition.value]
            [/#if]
            [#if (definition.name == "FREERTOS_STATUS") && (definition.value == "1")]
                [#assign FREERTOS_STATUS = 1]
            [/#if]
            [#if definition.name == "THREAD_APPLICATION"]
                [#assign THREAD_APPLICATION = definition.value]
            [/#if]
            [#if (definition.name == "BLE") && (definition.value == "Enabled")]
                [#assign BLE = 1]
            [/#if]
            [#if (definition.name == "THREAD") && (definition.value == "Enabled")]
                [#assign THREAD = 1]
            [/#if]
            [#if (definition.name == "DBG_TRACE_UART_CFG")  && (definition.value != "0")]
                [#assign DBG_TRACE_UART_CFG = definition.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]
/* Includes ------------------------------------------------------------------*/
#include "app_common.h"
#include "main.h"
#include "app_entry.h"
[#if BLE = 1 ]
[#if (BLE_TRANSPARENT_MODE_UART = 1) || (BLE_TRANSPARENT_MODE_VCP = 1)]
[#else]
#include "app_ble.h"
[/#if]
[#if (BLE_TRANSPARENT_MODE_UART = 1) || (BLE_TRANSPARENT_MODE_VCP = 1)]
#include "tm.h"
[#else]
#include "ble.h"
[/#if]
#include "tl.h"
[/#if]
[#if THREAD = 1 ]
#include "app_thread.h"
#include "app_conf.h"
#include "hw_conf.h"
[/#if]
#include "scheduler.h"
[#if BLE = 1 ]
[#if (BLE_TRANSPARENT_MODE_UART = 1) || (BLE_TRANSPARENT_MODE_VCP = 1)]
#include "stm_list.h"
[#else]
#include "shci_tl.h"
[/#if]
[/#if]
[#if THREAD = 1 ]
#include "stm_logging.h"
#include "shci_tl.h"
[/#if]
#include "lpm.h"
#include "dbg_trace.h"
[#if THREAD = 1 ]
#include "shci.h"
[/#if]

/* Private includes -----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
extern RTC_HandleTypeDef hrtc;
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private defines -----------------------------------------------------------*/
[#if BLE = 1 ]
#define POOL_SIZE (CFG_TLBLE_EVT_QUEUE_LENGTH*4U*DIVC(( sizeof(TL_PacketHeader_t) + TL_BLE_EVENT_FRAME_SIZE ), 4U))
[#if (BLE_TRANSPARENT_MODE_UART = 1) || (BLE_TRANSPARENT_MODE_VCP = 1)]
#define INFORMATION_SECTION_KEYWORD   (0xA56959A6)
[/#if]
[/#if]
[#if THREAD = 1 ]
#define POOL_SIZE (CFG_TL_EVT_QUEUE_LENGTH * 4U * DIVC(( sizeof(TL_PacketHeader_t) + TL_EVENT_FRAME_SIZE ), 4U))
[/#if]

/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macros ------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
[#if BLE = 1 ]
[#if (BLE_TRANSPARENT_MODE_UART = 1) || (BLE_TRANSPARENT_MODE_VCP = 1)]
PLACE_IN_SECTION("VERSION") const uint32_t FW_Version = (CFG_FW_MAJOR_VERSION << 24) + (CFG_FW_MINOR_VERSION << 16) + (CFG_FW_SUBVERSION << 8)
+ (CFG_FW_BRANCH << 4) + CFG_FW_BUILD;
PLACE_IN_SECTION("VERSION") const uint32_t keyword = INFORMATION_SECTION_KEYWORD;

extern RTC_HandleTypeDef hrtc; /**< RTC handler declaration */
[/#if]
[/#if]
PLACE_IN_SECTION("MB_MEM2") ALIGN(4) static uint8_t EvtPool[POOL_SIZE];
PLACE_IN_SECTION("MB_MEM2") ALIGN(4) static TL_CmdPacket_t SystemCmdBuffer;
PLACE_IN_SECTION("MB_MEM2") ALIGN(4) static uint8_t SystemSpareEvtBuffer[sizeof(TL_PacketHeader_t) + TL_EVT_HDR_SIZE + 255U];
[#if BLE = 1 ]
PLACE_IN_SECTION("MB_MEM2") ALIGN(4) static uint8_t BleSpareEvtBuffer[sizeof(TL_PacketHeader_t) + TL_EVT_HDR_SIZE + 255];
[#if (BLE_TRANSPARENT_MODE_UART = 1) || (BLE_TRANSPARENT_MODE_VCP = 1)]
static tListNode  SysEvtQueue;
[/#if]
[/#if]

/* USER CODE BEGIN PV */

/* USER CODE END PV */
[#if (THREAD = 1)]
/* Global function prototypes -----------------------------------------------*/
size_t DbgTraceWrite(int handle, const unsigned char * buf, size_t bufSize);

/* USER CODE BEGIN GFP */

/* USER CODE END GFP */
[/#if]

/* Private functions prototypes-----------------------------------------------*/
static void SystemPower_Config( void );
static void Init_Debug( void );
static void appe_Tl_Init( void );
static void Switch_On_HSI( void );
[#if (BLE = 1)]
[#if (BLE_TRANSPARENT_MODE_UART = 1) || (BLE_TRANSPARENT_MODE_VCP = 1)]
static void APPE_SysUserEvtRx( TL_EvtPacket_t * p_evt_rx );
static void shci_user_evt_proc( void );
[/#if]
[#if (BLE_TRANSPARENT_MODE_UART = 0) && (BLE_TRANSPARENT_MODE_VCP = 0)]
static void APPE_SysStatusNot( SHCI_TL_CmdStatus_t status );
static void APPE_SysUserEvtRx( void * pPayload );
[/#if]
[/#if]
[#if (THREAD = 1)]
static void APPE_SysStatusNot( SHCI_TL_CmdStatus_t status );
static void APPE_SysUserEvtRx( void * pPayload );
static void APPE_SysEvtReadyProcessing( void );
static void APPE_SysEvtError( SCHI_SystemErrCode_t ErrorCode);
[/#if]

#if (CFG_HW_LPUART1_ENABLED == 1)
extern void MX_LPUART1_UART_Init(void);
#endif
#if (CFG_HW_USART1_ENABLED == 1)
extern void MX_USART1_UART_Init(void);
#endif

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Functions Definition ------------------------------------------------------*/
void APPE_Init( void )
{
  SystemPower_Config(); /**< Configure the system Power Mode */

  HW_TS_Init(hw_ts_InitMode_Full, &hrtc); /**< Initialize the TimerServer */

/* USER CODE BEGIN APPE_Init_1 */

/* USER CODE END APPE_Init_1 */
  appe_Tl_Init();	/* Initialize all transport layers */

  /**
   * From now, the application is waiting for the ready event ( VS_HCI_C2_Ready )
   * received on the system channel before starting the Stack
   * This system event is received with APPE_SysUserEvtRx()
   */
/* USER CODE BEGIN APPE_Init_2 */

/* USER CODE END APPE_Init_2 */
   return;
}
/* USER CODE BEGIN FD */

/* USER CODE END FD */

/*************************************************************
 *
 * LOCAL FUNCTIONS
 *
 *************************************************************/
static void Init_Debug( void )
{
#if (CFG_DEBUGGER_SUPPORTED == 1)
  /**
   * Keep debugger enabled while in any low power mode
   */
  HAL_DBGMCU_EnableDBGSleepMode();

  /***************** ENABLE DEBUGGER *************************************/
  LL_EXTI_EnableIT_32_63(LL_EXTI_LINE_48);
  LL_C2_EXTI_EnableIT_32_63(LL_EXTI_LINE_48);

#else

  GPIO_InitTypeDef gpio_config = {0};

  gpio_config.Pull = GPIO_NOPULL;
  gpio_config.Mode = GPIO_MODE_ANALOG;

  gpio_config.Pin = GPIO_PIN_15 | GPIO_PIN_14 | GPIO_PIN_13;
  __HAL_RCC_GPIOA_CLK_ENABLE();
  HAL_GPIO_Init(GPIOA, &gpio_config);
  __HAL_RCC_GPIOA_CLK_DISABLE();

  gpio_config.Pin = GPIO_PIN_4 | GPIO_PIN_3;
  __HAL_RCC_GPIOB_CLK_ENABLE();
  HAL_GPIO_Init(GPIOB, &gpio_config);
  __HAL_RCC_GPIOB_CLK_DISABLE();

  HAL_DBGMCU_DisableDBGSleepMode();
  HAL_DBGMCU_DisableDBGStopMode();
  HAL_DBGMCU_DisableDBGStandbyMode();

#endif /* (CFG_DEBUGGER_SUPPORTED == 1) */

#if(CFG_DEBUG_TRACE != 0)
  DbgTraceInit();
#endif

  return;
}

/**
 * @brief  Configure the system for power optimization
 *
 * @note  This API configures the system to be ready for low power mode
 *
 * @param  None
 * @retval None
 */
static void SystemPower_Config( void )
{
  LPM_Conf_t LowPowerModeConfiguration;

  /**
   * Select HSI as system clock source after Wake Up from Stop mode
   */
  LL_RCC_SetClkAfterWakeFromStop(LL_RCC_STOP_WAKEUPCLOCK_HSI);

  /**< Configure low power manager */
  LowPowerModeConfiguration.Stop_Mode_Config = LPM_StopMode2;
  LowPowerModeConfiguration.OFF_Mode_Config = LPM_Standby;
  LPM_SetConf(&LowPowerModeConfiguration);

#if (CFG_USB_INTERFACE_ENABLE != 0)
  /**
   *  Enable USB power
   */
  HAL_PWREx_EnableVddUSB();
#endif

  return;
}

static void appe_Tl_Init( void )
{
  TL_MM_Config_t tl_mm_config;
[#if (BLE = 1) && ((BLE_TRANSPARENT_MODE_UART = 1) ||(BLE_TRANSPARENT_MODE_VCP = 1))]
  TL_SYS_InitConf_t tl_sys_init_conf;
[#else]
  SHCI_TL_HciInitConf_t SHci_Tl_Init_Conf;
[/#if]
  /**< Reference table initialization */
  TL_Init();

  /**< System channel initialization */
[#if (BLE = 1) && ((BLE_TRANSPARENT_MODE_UART = 1) ||(BLE_TRANSPARENT_MODE_VCP = 1))]
  LST_init_head (&SysEvtQueue);
[/#if]
[#if (BLE = 1)]
  SCH_RegTask( CFG_TASK_SYSTEM_HCI_ASYNCH_EVT_ID, shci_user_evt_proc );
[/#if]
[#if (THREAD = 1)]
  SCH_RegTask( CFG_TASK_SYSTEM_HCI_ASYNCH_EVT, shci_user_evt_proc );
[/#if]
[#if BLE = 1 && ((BLE_TRANSPARENT_MODE_UART = 1) ||(BLE_TRANSPARENT_MODE_VCP = 1))]
  tl_sys_init_conf.p_cmdbuffer =  (uint8_t*)&SystemCmdBuffer;
  tl_sys_init_conf.IoBusCallBackCmdEvt = TM_SysCmdRspCb;
  tl_sys_init_conf.IoBusCallBackUserEvt = APPE_SysUserEvtRx;
  TL_SYS_Init( (void*) &tl_sys_init_conf );
[#else]
  SHci_Tl_Init_Conf.p_cmdbuffer = (uint8_t*)&SystemCmdBuffer;
  SHci_Tl_Init_Conf.StatusNotCallBack = APPE_SysStatusNot;
  shci_init(APPE_SysUserEvtRx, (void*) &SHci_Tl_Init_Conf);
[/#if]

  /**< Memory Manager channel initialization */
[#if (BLE = 1)]
  tl_mm_config.p_BleSpareEvtBuffer = BleSpareEvtBuffer;
[/#if]
[#if (THREAD = 1)]
  tl_mm_config.p_BleSpareEvtBuffer = 0;
[/#if]
  tl_mm_config.p_SystemSpareEvtBuffer = SystemSpareEvtBuffer;
  tl_mm_config.p_AsynchEvtPool = EvtPool;
  tl_mm_config.AsynchEvtPoolSize = POOL_SIZE;
  TL_MM_Init( &tl_mm_config );

  TL_Enable();

  return;
}

static void Switch_On_HSI( void )
{
  LL_RCC_HSI_Enable();
  while(!LL_RCC_HSI_IsReady());
  LL_RCC_SetSysClkSource(LL_RCC_SYS_CLKSOURCE_HSI);
  while (LL_RCC_GetSysClkSource() != LL_RCC_SYS_CLKSOURCE_STATUS_HSI);

  return;
}

[#if (BLE = 1) && ((BLE_TRANSPARENT_MODE_UART = 1) ||(BLE_TRANSPARENT_MODE_VCP = 1))]
static void APPE_SysUserEvtRx( TL_EvtPacket_t * p_evt_rx )
{
  LST_insert_tail (&SysEvtQueue, (tListNode *)p_evt_rx);

  SCH_SetTask( 1<<CFG_TASK_SYSTEM_HCI_ASYNCH_EVT_ID, CFG_SCH_PRIO_0);

  return;
}

static void shci_user_evt_proc ( void )
{
  TL_EvtPacket_t * p_evt_rx;
  /**
   * Currently, only VS_HCI_C2_Ready() system user event is supported.
   */

  /**< Traces channel initialization */
  TL_TRACES_Init( );

  LPM_SetOffMode(1 << CFG_LPM_APP, LPM_OffMode_En);

  LST_remove_head( &SysEvtQueue, (tListNode **)&p_evt_rx );

  TL_MM_EvtDone( p_evt_rx );

  TM_Init( );
}

[#else]
static void APPE_SysStatusNot( SHCI_TL_CmdStatus_t status )
{
  UNUSED(status);
  return;
}

[#if (THREAD = 1)]
/**
 * @brief Trap a notification coming from the M0 firmware
 * @param  pPayload  : payload associated to the notification
 *
 * @retval None
 */

 [/#if]
static void APPE_SysUserEvtRx( void * pPayload )
{
[#if (BLE = 1)]
  UNUSED(pPayload);
[/#if]
[#if (THREAD = 1)]
  TL_AsynchEvt_t *p_sys_event;
  p_sys_event = (TL_AsynchEvt_t*)(((tSHCI_UserEvtRxParam*)pPayload)->pckt->evtserial.evt.payload);

  switch(p_sys_event->subevtcode)
  {
     case SHCI_SUB_EVT_CODE_READY:
         APPE_SysEvtReadyProcessing();
         break;
     case SHCI_SUB_EVT_ERROR_NOTIF:
         APPE_SysEvtError((SCHI_SystemErrCode_t) (p_sys_event->payload[0]));
         break;
     default:
         break;
  }
  return;
}

/**
 * @brief Notify a system error coming from the M0 firmware
 * @param  ErrorCode  : errorCode detected by the M0 firmware
 *
 * @retval None
 */
static void APPE_SysEvtError( SCHI_SystemErrCode_t ErrorCode)
{
  switch(ErrorCode)
  {
  case ERR_THREAD_LLD_FATAL_ERROR:
       APP_DBG("** ERR_THREAD : LLD_FATAL_ERROR \n");
       break;
  case ERR_THREAD_UNKNOWN_CMD:
       APP_DBG("** ERR_THREAD : UNKNOWN_CMD \n");
       break;
  default:
       APP_DBG("** ERR_THREAD : ErroCode=%d \n",ErrorCode);
       break;
  }
  return;
}

static void APPE_SysEvtReadyProcessing( void )
{
[/#if]
  /* Traces channel initialization */
  TL_TRACES_Init( );

[#if (BLE = 1)]
  APP_BLE_Init( );
[/#if]
[#if (THREAD = 1)]
  APP_THREAD_Init();
[/#if]
  LPM_SetOffMode(1U << CFG_LPM_APP, LPM_OffMode_En);
  return;
}
[/#if]

/* USER CODE BEGIN FD_LOCAL_FUNCTIONS */

/* USER CODE END FD_LOCAL_FUNCTIONS */

/*************************************************************
 *
 * WRAP FUNCTIONS
 *
 *************************************************************/

void SCH_Idle( void )
{
#if ( CFG_LPM_SUPPORTED == 1)
  LPM_EnterModeSelected();
#endif
  return;
}

void LPM_EnterStopMode(void)
{
  /**
   * This function is called from CRITICAL SECTION
   */

  while( LL_HSEM_1StepLock( HSEM, CFG_HW_RCC_SEMID ) );

  if ( ! LL_HSEM_1StepLock( HSEM, CFG_HW_ENTRY_STOP_MODE_SEMID ) )
  {
    if( LL_PWR_IsActiveFlag_C2DS() )
    {
      /* Release ENTRY_STOP_MODE semaphore */
      LL_HSEM_ReleaseLock( HSEM, CFG_HW_ENTRY_STOP_MODE_SEMID, 0 );

      Switch_On_HSI();
    }
  }
  else
  {
    Switch_On_HSI();
  }

  /* Release RCC semaphore */
  LL_HSEM_ReleaseLock( HSEM, CFG_HW_RCC_SEMID, 0 );

  return;
}

void LPM_ExitStopMode(void)
{
  /**
   * This function is called from CRITICAL SECTION
   */

  /* Release ENTRY_STOP_MODE semaphore */
  LL_HSEM_ReleaseLock( HSEM, CFG_HW_ENTRY_STOP_MODE_SEMID, 0 );

  if( (LL_RCC_GetSysClkSource() == LL_RCC_SYS_CLKSOURCE_STATUS_HSI) || (LL_PWR_IsActiveFlag_C1STOP() != 0) )
  {
    LL_PWR_ClearFlag_C1STOP_C1STB();

    while( LL_HSEM_1StepLock( HSEM, CFG_HW_RCC_SEMID ) );

    if(LL_RCC_GetSysClkSource() == LL_RCC_SYS_CLKSOURCE_STATUS_HSI)
    {
      LL_RCC_HSE_Enable();
      while(!LL_RCC_HSE_IsReady());
      LL_RCC_SetSysClkSource(LL_RCC_SYS_CLKSOURCE_HSE);
      while (LL_RCC_GetSysClkSource() != LL_RCC_SYS_CLKSOURCE_STATUS_HSE);
    }
    else
    {
      /**
       * As long as the current application is fine with HSE as system clock source,
       * there is nothing to do here
       */
    }

    /* Release RCC semaphore */
    LL_HSEM_ReleaseLock( HSEM, CFG_HW_RCC_SEMID, 0 );
  }

  return;
}

/**
  * @brief  This function is called by the scheduler each time an event
  *         is pending.
  *
  * @param  evt_waited_bm : Event pending.
  * @retval None
  */
void SCH_EvtIdle( uint32_t evt_waited_bm )
{
[#if (THREAD = 1)]
  switch(evt_waited_bm)
  {
  case EVENT_ACK_FROM_M0_EVT:
    /* Does not allow other tasks when waiting for OT Cmd response */
    SCH_Run(0);
    break;
  case EVENT_SYNCHRO_BYPASS_IDLE:
    SCH_SetEvt(EVENT_SYNCHRO_BYPASS_IDLE);
    /* Run only the task CFG_TASK_MSG_FROM_M0_TO_M4 */
    SCH_Run(TASK_MSG_FROM_M0_TO_M4);
    break;
  default :
    /* default case */
[/#if]
  SCH_Run(~0);
[#if (THREAD = 1)]
    break;
  }
}

void shci_notify_asynch_evt(void* pdata)
{
  UNUSED(pdata);
  SCH_SetTask(1U << CFG_TASK_SYSTEM_HCI_ASYNCH_EVT, CFG_SCH_PRIO_0);
  return;
[/#if]
}

[#if (BLE = 1) && (BLE_TRANSPARENT_MODE_UART = 0) && (BLE_TRANSPARENT_MODE_VCP = 0)]
void shci_notify_asynch_evt(void* pdata)
{
  SCH_SetTask( 1<<CFG_TASK_SYSTEM_HCI_ASYNCH_EVT_ID, CFG_SCH_PRIO_0);
  return;
}

void shci_cmd_resp_release(uint32_t flag)
{
  SCH_SetEvt( 1<< CFG_IDLEEVT_SYSTEM_HCI_CMD_EVT_RSP_ID );
  return;
}

void shci_cmd_resp_wait(uint32_t timeout)
{
  SCH_WaitEvt( 1<< CFG_IDLEEVT_SYSTEM_HCI_CMD_EVT_RSP_ID );
  return;
}

[/#if]
[#if (THREAD = 1)]
void shci_cmd_resp_release(uint32_t flag)
{
  UNUSED(flag);
  SCH_SetEvt(1U << CFG_EVT_SYSTEM_HCI_CMD_EVT_RESP);
  return;
}

void shci_cmd_resp_wait(uint32_t timeout)
{
  UNUSED(timeout);
  SCH_WaitEvt(1U << CFG_EVT_SYSTEM_HCI_CMD_EVT_RESP);
  return;
}

/* Received trace buffer from M0 */
void TL_TRACES_EvtReceived( TL_EvtPacket_t * hcievt )
{
#if(CFG_DEBUG_TRACE != 0)
  /* Call write/print function using DMA from dbg_trace */
  /* - Cast to TL_AsynchEvt_t* to get "real" payload (without Sub Evt code 2bytes),
     - (-2) to size to remove Sub Evt Code */
  DbgTraceWrite(1U, (const unsigned char *) ((TL_AsynchEvt_t *)(hcievt->evtserial.evt.payload))->payload, hcievt->evtserial.evt.plen - 2U);
#endif /* CFG_DEBUG_TRACE */
  /* Release buffer */
  TL_MM_EvtDone( hcievt );
}
[/#if]
/**
  * @brief  Initialisation of the trace mechanism
  * @param  None
  * @retval None
  */
#if(CFG_DEBUG_TRACE != 0)
void DbgOutputInit( void )
{
[#if DBG_TRACE_UART_CFG = "hw_lpuart1" ]
    MX_LPUART1_UART_Init();
[/#if]
[#if DBG_TRACE_UART_CFG = "hw_uart1" ]
    MX_USART1_UART_Init();
[/#if]

  return;
}

/**
  * @brief  Management of the traces
  * @param  p_data : data
  * @param  size : size
  * @param  call-back :
  * @retval None
  */
void DbgOutputTraces(  uint8_t *p_data, uint16_t size, void (*cb)(void) )
{
  HW_UART_Transmit_DMA(DBG_TRACE_UART_CFG, p_data, size, cb);

  return;
}
#endif

/* USER CODE BEGIN FD_WRAP_FUNCTIONS */

/* USER CODE END FD_WRAP_FUNCTIONS */
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/