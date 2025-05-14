[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name}
  * @author  MCD Application Team
  * @brief   Entry point of the application
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign BLE_TRANSPARENT_MODE_UART = 0]
[#assign BLE_TRANSPARENT_MODE_VCP = 0]
[#assign BT_SIG_BEACON = "0"]
[#assign BT_SIG_BLOOD_PRESSURE_SENSOR = 0]
[#assign BT_SIG_HEALTH_THERMOMETER_SENSOR = 0]
[#assign BT_SIG_HEART_RATE_SENSOR = 0]
[#assign CUSTOM_OTA = 0]
[#assign CUSTOM_P2P_CLIENT = 0]
[#assign CUSTOM_P2P_ROUTER = 0]
[#assign CUSTOM_P2P_SERVER = 0]
[#assign CUSTOM_TEMPLATE = 0]
[#assign FREERTOS_STATUS = 0]
[#assign THREADX_STATUS = 0]
[#assign SEQUENCER_STATUS = 0]
[#assign THREAD = 0]
[#assign BLE = 0]
[#assign ZIGBEE = 0]
[#assign CFG_DEBUG_TRACE_UART  = ""]
[#assign CFG_DEBUG_TRACE  = 1]
[#assign DIE = DIE]
[#assign Line = Line]

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
            [#if (definition.name == "BT_SIG_BEACON") && (definition.value != "Disabled")]
                [#assign BT_SIG_BEACON = definition.value]
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
            [#if !(THREADX?? || FREERTOS??)]
                [#assign SEQUENCER_STATUS = 1]
            [/#if]
            [#if THREADX??]
                [#assign THREADX_STATUS = 1]
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
            [#if (definition.name == "ZIGBEE") && (definition.value == "Enabled")]
                [#assign ZIGBEE = 1]
            [/#if]
            [#if definition.name == "ZGB_SLEEPY_MODE"]
                [#assign ZGB_SLEEPY_MODE = definition.value]
            [/#if]
            [#if (definition.name == "CFG_DEBUG_TRACE_UART")  && (definition.value != "0")]
                [#assign CFG_DEBUG_TRACE_UART  = definition.value]
            [/#if]
			[#if (definition.name == "CFG_DEBUG_TRACE")]
                [#assign CFG_DEBUG_TRACE = definition.value]
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
[#-- MZA 112688 --]
[#if  BT_SIG_BLOOD_PRESSURE_SENSOR = 1 || BT_SIG_HEALTH_THERMOMETER_SENSOR = 1 || BT_SIG_HEART_RATE_SENSOR = 1 
	|| CUSTOM_OTA = 1 || CUSTOM_P2P_CLIENT = 1 || CUSTOM_P2P_ROUTER = 1 || CUSTOM_P2P_SERVER = 1 || CUSTOM_TEMPLATE =1
	|| BT_SIG_BEACON != "0"]
#include "app_ble.h"
[/#if]
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
[/#if]
[#if ZIGBEE = 1]
#include "app_zigbee.h"
[/#if]
[#if THREAD = 1 || ZIGBEE = 1]
#include "app_conf.h"
#include "hw_conf.h"
[/#if]
[#if FREERTOS_STATUS = 1 ]
#include "cmsis_os.h"
[#elseif THREADX_STATUS = 1]
#include "tx_api.h"
[#else]
#include "stm32_seq.h"
[/#if]
[#if BLE = 1 ]
[#if (BLE_TRANSPARENT_MODE_UART = 1) || (BLE_TRANSPARENT_MODE_VCP = 1)]
#include "stm_list.h"
[#else]
#include "shci_tl.h"
[/#if]
[/#if]
[#if THREAD = 1 || ZIGBEE = 1]
#include "stm_logging.h"
#include "shci_tl.h"
[/#if]
#include "stm32_lpm.h"
[#if BLE = 1]
#include "app_debug.h"
[/#if]
#include "dbg_trace.h"
[#if (THREAD = 1 || ZIGBEE = 1) || ((BLE = 1) && (BLE_TRANSPARENT_MODE_UART != 1) && (BLE_TRANSPARENT_MODE_VCP != 1))]
#include "shci.h"
[/#if]
#include "otp.h"
[#if (BLE = 1) && ((BLE_TRANSPARENT_MODE_UART = 1) ||(BLE_TRANSPARENT_MODE_VCP = 1))]
#include "shci.h"
[/#if]
[#if THREAD = 1]
#include "stm_list.h"
#include "advanced_memory_manager.h"
#include "stm32_mm.h"
[/#if]

/* Private includes -----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
extern RTC_HandleTypeDef hrtc;
[#if THREAD = 1]
/**
 * Structure of Trace_Elt_t
 * buffer : trace buffer
 * size : size of the trace buffer
 */
typedef __PACKED_STRUCT
{
  uint32_t *next;
  uint32_t *prev;
} TraceEltHeader_t;

/**
 * Structure of Trace_Elt_t
 * buffer : trace buffer
 * size : size of the trace buffer
 */
typedef __PACKED_STRUCT
{
  uint8_t   buffer[255];
  uint32_t  size;
} TraceElt_t;


/**
 * Structure of Trace_Elt_t
 * buffer : trace buffer
 * size : size of the trace buffer
 */
typedef struct __attribute__((packed, aligned(4)))
{
  TraceEltHeader_t header;
  TraceElt_t trace;
} TraceEltPacket_t;
[/#if]

/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private defines -----------------------------------------------------------*/
[#if BLE = 1 ]
#define POOL_SIZE (CFG_TLBLE_EVT_QUEUE_LENGTH*4U*DIVC((sizeof(TL_PacketHeader_t) + TL_BLE_EVENT_FRAME_SIZE), 4U))
[#if (BLE_TRANSPARENT_MODE_UART = 1) || (BLE_TRANSPARENT_MODE_VCP = 1)]
#define INFORMATION_SECTION_KEYWORD   (0xA56959A6)
[/#if]
[/#if]
[#if THREAD = 1 || ZIGBEE = 1]
/* POOL_SIZE = 2(TL_PacketHeader_t) + 258 (3(TL_EVT_HDR_SIZE) + 255(Payload size)) */
#define POOL_SIZE (CFG_TL_EVT_QUEUE_LENGTH * 4U * DIVC((sizeof(TL_PacketHeader_t) + TL_EVENT_FRAME_SIZE), 4U))
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
[#if ZIGBEE = 1]
extern uint8_t g_ot_notification_allowed;
[/#if]
[#if THREAD = 1]
uint8_t g_ot_notification_allowed = 0U;

#if (CFG_AMM_ENABLED != 0)
static tListNode TraceBufferList;
static uint32_t TracePool[CFG_AMM_POOL_SIZE];

[#if (FREERTOS_STATUS = 1)]
/* AMM_BCKGND_TASK related resources */
osThreadId_t AMM_BCKGND_Thread;
const osThreadAttr_t AMM_BCKGND_Thread_Attr;
osSemaphoreId_t AMM_BCKGND_Thread_Sem;
const osSemaphoreAttr_t AMM_BCKGND_Thread_Sem_Attr;

/* TRC_BCKGND_TASK related resources */
osThreadId_t TRC_BCKGND_Thread;
const osThreadAttr_t TRC_BCKGND_Thread_Attr;
osSemaphoreId_t TRC_BCKGND_Thread_Sem;
const osSemaphoreAttr_t TRC_BCKGND_Thread_Sem_Attr;

osMutexId_t LINK_LAYER_Thread_Mutex;
[/#if]
static AMM_VirtualMemoryConfig_t vmConfig[CFG_AMM_VIRTUAL_MEMORY_NUMBER] = {
  /* Virtual Memory #1 */
  { 
    .Id = CFG_AMM_VIRTUAL_APP_TRACE,  
    .BufferSize = CFG_AMM_VIRTUAL_APP_TRACE_BUFFER_SIZE
  }
};

static AMM_InitParameters_t ammInitConfig =
{
  .p_PoolAddr = TracePool,
  .PoolSize = CFG_AMM_POOL_SIZE,
  .VirtualMemoryNumber = CFG_AMM_VIRTUAL_MEMORY_NUMBER,
  .p_VirtualMemoryConfigList = vmConfig
};
#endif
[/#if]
[#if BLE = 1 ]
PLACE_IN_SECTION("MB_MEM2") ALIGN(4) static uint8_t BleSpareEvtBuffer[sizeof(TL_PacketHeader_t) + TL_EVT_HDR_SIZE + 255];
[#if (BLE_TRANSPARENT_MODE_UART = 1) || (BLE_TRANSPARENT_MODE_VCP = 1)]
static tListNode  SysEvtQueue;
[/#if]
[/#if]

/* USER CODE BEGIN PV */

/* USER CODE END PV */

[#if FREERTOS_STATUS = 1]
/* Global variables ----------------------------------------------------------*/
osMutexId_t MtxShciId;
osSemaphoreId_t SemShciId;
osThreadId_t ShciUserEvtProcessId;

const osThreadAttr_t ShciUserEvtProcess_attr = {
    .name = CFG_SHCI_USER_EVT_PROCESS_NAME,
    .attr_bits = CFG_SHCI_USER_EVT_PROCESS_ATTR_BITS,
    .cb_mem = CFG_SHCI_USER_EVT_PROCESS_CB_MEM,
    .cb_size = CFG_SHCI_USER_EVT_PROCESS_CB_SIZE,
    .stack_mem = CFG_SHCI_USER_EVT_PROCESS_STACK_MEM,
    .priority = CFG_SHCI_USER_EVT_PROCESS_PRIORITY,
    .stack_size = CFG_SHCI_USER_EVT_PROCESS_STACK_SIZE
};
[#elseif THREADX_STATUS = 1]
/* Global variables ----------------------------------------------------------*/
TX_MUTEX          MtxShciId;
TX_SEMAPHORE      SemShciId;
TX_SEMAPHORE      SemShciNotify;
TX_THREAD         ShciUserEvtProcessId;
TX_BYTE_POOL      * pBytePool;
[/#if]

[#if THREAD = 1 || ZIGBEE = 1]
/* Global function prototypes -----------------------------------------------*/
#if (CFG_DEBUG_TRACE != 0)
size_t DbgTraceWrite(int handle, const unsigned char * buf, size_t bufSize);
#endif /* CFG_DEBUG_TRACE != 0 */

/* USER CODE BEGIN GFP */

/* USER CODE END GFP */
[/#if]

/* Private functions prototypes-----------------------------------------------*/
[#if FREERTOS_STATUS = 1]
static void ShciUserEvtProcess(void *argument);
[#elseif THREADX_STATUS = 1]
static void ShciUserEvtProcess(ULONG argument);
[/#if]
static void Config_HSE(void);
static void Reset_Device(void);
#if (CFG_HW_RESET_BY_FW == 1)
static void Reset_IPCC(void);
static void Reset_BackupDomain(void);
#endif /* CFG_HW_RESET_BY_FW == 1*/
static void System_Init(void);
static void SystemPower_Config(void);
[#if THREAD = 1 || ZIGBEE = 1]
static void Init_Debug(void);
[/#if]
static void appe_Tl_Init(void);
[#if (BLE = 1)]
[#if (BLE_TRANSPARENT_MODE_UART = 1) || (BLE_TRANSPARENT_MODE_VCP = 1)]
static void APPE_SysUserEvtRx(TL_EvtPacket_t * p_evt_rx);
static void shci_user_evt_proc(void);
[/#if]
[#if (BLE_TRANSPARENT_MODE_UART = 0) && (BLE_TRANSPARENT_MODE_VCP = 0)]
static void APPE_SysStatusNot(SHCI_TL_CmdStatus_t status);
static void APPE_SysUserEvtRx(void * pPayload);
static void APPE_SysEvtReadyProcessing(void * pPayload);
static void APPE_SysEvtError(void * pPayload);
[/#if]
[/#if]
[#if THREAD = 1 || ZIGBEE = 1]
static void APPE_SysStatusNot(SHCI_TL_CmdStatus_t status);
static void APPE_SysUserEvtRx(void * pPayload);
static void APPE_SysEvtReadyProcessing(void);
static void APPE_SysEvtError(SCHI_SystemErrCode_t ErrorCode);
[#if (THREAD = 1) && (FREERTOS_STATUS = 0)]
#if(CFG_DEBUG_TRACE != 0)
static void writeTrace(char * buffer, uint32_t size);
#endif
#if (CFG_AMM_ENABLED != 0)
static void ProcessTrace(void);
#endif
[/#if]
[#if (THREAD = 1) && (FREERTOS_STATUS = 1)]
#if (CFG_AMM_ENABLED != 0)
static void TRC_BackgroundProcess(void);
#endif
#if(CFG_DEBUG_TRACE != 0)
static void writeTrace(char * buffer, uint32_t size);
#endif /* CFG_DEBUG_TRACE */
[/#if]
#if (CFG_HW_LPUART1_ENABLED == 1)
extern void MX_LPUART1_UART_Init(void);
#endif /* CFG_HW_LPUART1_ENABLED == 1 */
#if (CFG_HW_USART1_ENABLED == 1)
extern void MX_USART1_UART_Init(void);
#endif /* CFG_HW_USART1_ENABLED == 1 */
[/#if]
static void Init_Rtc(void);
[#if (BLE = 1)  &&
	 (BLE_TRANSPARENT_MODE_UART != 1 && BLE_TRANSPARENT_MODE_VCP != 1
	  && BT_SIG_BLOOD_PRESSURE_SENSOR != 1 && BT_SIG_HEALTH_THERMOMETER_SENSOR != 1 && BT_SIG_HEART_RATE_SENSOR != 1
	  && CUSTOM_OTA != 1 && CUSTOM_P2P_CLIENT != 1 && CUSTOM_P2P_ROUTER != 1 && CUSTOM_P2P_SERVER != 1 && CUSTOM_TEMPLATE !=1
	  && BT_SIG_BEACON == "0")]
__WEAK void APP_BLE_Init(void);
[/#if]

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

[#if (THREAD = 1) && (FREERTOS_STATUS = 1)]
#if (CFG_AMM_ENABLED != 0)
static void AMM_BackgroundProcess_Entry(void* thread_input);
static void TRC_BackgroundProcess_Entry(void* thread_input);
#endif
[/#if]
/* Functions Definition ------------------------------------------------------*/
void MX_APPE_Config(void)
{
  /**
   * The OPTVERR flag is wrongly set at power on
   * It shall be cleared before using any HAL_FLASH_xxx() api
   */
  __HAL_FLASH_CLEAR_FLAG(FLASH_FLAG_OPTVERR);

  /**
   * Reset some configurations so that the system behave in the same way
   * when either out of nReset or Power On
   */
  Reset_Device();

  /* Configure HSE Tuning */
  Config_HSE();

  return;
}

[#if THREADX_STATUS = 1]
uint32_t MX_APPE_Init(void *p_param)
{
  /* Save ThreadX byte pool for whole WPAN middleware */
  pBytePool = p_param;
  
[#else]
void MX_APPE_Init(void)
{
[/#if] 
  System_Init();       /**< System initialization */

  SystemPower_Config(); /**< Configure the system Power Mode */
  
  [#if (THREAD = 1) && (FREERTOS_STATUS = 0)]
#if (CFG_AMM_ENABLED != 0)
  /* Initialize the Advance Memory Manager */
  AMM_Init ((AMM_InitParameters_t *) &ammInitConfig);
  
  /* Register the AMM background task */
  UTIL_SEQ_RegTask( 1U << CFG_TASK_AMM_BCKGND, UTIL_SEQ_RFU, AMM_BackgroundProcess);
    
  /* Register the Trace background task */
  UTIL_SEQ_RegTask( 1<<(uint32_t)CFG_TASK_TRACE, UTIL_SEQ_RFU, ProcessTrace);
  
  LST_init_head (&TraceBufferList); 
#endif
  [/#if]
  
  [#if (THREAD = 1) && (FREERTOS_STATUS = 1)]
#if (CFG_AMM_ENABLED != 0)
  /* Initialize the Advance Memory Manager */
  AMM_Init (&ammInitConfig);

  /* Register the AMM background task */
  AMM_BCKGND_Thread_Sem = osSemaphoreNew(1, 0, &AMM_BCKGND_Thread_Sem_Attr);
  AMM_BCKGND_Thread = osThreadNew(AMM_BackgroundProcess_Entry, NULL, &AMM_BCKGND_Thread_Attr);
  
  /* Register the TRC background task */
  TRC_BCKGND_Thread_Sem = osSemaphoreNew(1, 0, &TRC_BCKGND_Thread_Sem_Attr);
  TRC_BCKGND_Thread = osThreadNew(TRC_BackgroundProcess_Entry, NULL, &TRC_BCKGND_Thread_Attr);
  
  LST_init_head (&TraceBufferList); 
#endif
  [/#if]
  
  HW_TS_Init(hw_ts_InitMode_Full, &hrtc); /**< Initialize the TimerServer */

/* USER CODE BEGIN APPE_Init_1 */

/* USER CODE END APPE_Init_1 */
  appe_Tl_Init();	/* Initialize all transport layers */

  /**
   * From now, the application is waiting for the ready event (VS_HCI_C2_Ready)
   * received on the system channel before starting the Stack
   * This system event is received with APPE_SysUserEvtRx()
   */
/* USER CODE BEGIN APPE_Init_2 */

/* USER CODE END APPE_Init_2 */

[#if THREADX_STATUS = 1]
  return(TX_SUCCESS);
[#else]  
   return;
[/#if]  
}

[#if Line != "STM32WBx0 Value Line" ]
void Init_Smps(void)
{
#if (CFG_USE_SMPS != 0)
  /**
   *  Configure and enable SMPS
   *
   *  The SMPS configuration is not yet supported by CubeMx
   *  when SMPS output voltage is set to 1.4V, the RF output power is limited to 3.7dBm
   *  the SMPS output voltage shall be increased for higher RF output power
   */
  LL_PWR_SMPS_SetStartupCurrent(LL_PWR_SMPS_STARTUP_CURRENT_80MA);
  LL_PWR_SMPS_SetOutputVoltageLevel(LL_PWR_SMPS_OUTPUT_VOLTAGE_1V40);
  LL_PWR_SMPS_Enable();
#endif /* CFG_USE_SMPS != 0 */

  return;
}

[/#if]
void Init_Exti(void)
{
  /* Enable IPCC(36), HSEM(38) wakeup interrupts on CPU1 */
  LL_EXTI_EnableIT_32_63(LL_EXTI_LINE_36 | LL_EXTI_LINE_38);

  return;
}

/* USER CODE BEGIN FD */

/* USER CODE END FD */

/*************************************************************
 *
 * LOCAL FUNCTIONS
 *
 *************************************************************/
[#if THREAD = 1 || ZIGBEE = 1]
static void Init_Debug(void)
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

#if (CFG_DEBUG_TRACE != 0)
  DbgTraceInit();
#endif /* CFG_DEBUG_TRACE != 0 */

  return;
}
[/#if]
static void Reset_Device(void)
{
#if (CFG_HW_RESET_BY_FW == 1)
  Reset_BackupDomain();

  Reset_IPCC();
#endif /* CFG_HW_RESET_BY_FW == 1 */

  return;
}

#if (CFG_HW_RESET_BY_FW == 1)
static void Reset_BackupDomain(void)
{
  if ((LL_RCC_IsActiveFlag_PINRST() != FALSE) && (LL_RCC_IsActiveFlag_SFTRST() == FALSE))
  {
    HAL_PWR_EnableBkUpAccess(); /**< Enable access to the RTC registers */

    /**
     *  Write twice the value to flush the APB-AHB bridge
     *  This bit shall be written in the register before writing the next one
     */
    HAL_PWR_EnableBkUpAccess();

    __HAL_RCC_BACKUPRESET_FORCE();
    __HAL_RCC_BACKUPRESET_RELEASE();
  }

  return;
}

static void Reset_IPCC(void)
{
  LL_AHB3_GRP1_EnableClock(LL_AHB3_GRP1_PERIPH_IPCC);

  LL_C1_IPCC_ClearFlag_CHx(
      IPCC,
      LL_IPCC_CHANNEL_1 | LL_IPCC_CHANNEL_2 | LL_IPCC_CHANNEL_3 | LL_IPCC_CHANNEL_4
      | LL_IPCC_CHANNEL_5 | LL_IPCC_CHANNEL_6);

  LL_C2_IPCC_ClearFlag_CHx(
      IPCC,
      LL_IPCC_CHANNEL_1 | LL_IPCC_CHANNEL_2 | LL_IPCC_CHANNEL_3 | LL_IPCC_CHANNEL_4
      | LL_IPCC_CHANNEL_5 | LL_IPCC_CHANNEL_6);

  LL_C1_IPCC_DisableTransmitChannel(
      IPCC,
      LL_IPCC_CHANNEL_1 | LL_IPCC_CHANNEL_2 | LL_IPCC_CHANNEL_3 | LL_IPCC_CHANNEL_4
      | LL_IPCC_CHANNEL_5 | LL_IPCC_CHANNEL_6);

  LL_C2_IPCC_DisableTransmitChannel(
      IPCC,
      LL_IPCC_CHANNEL_1 | LL_IPCC_CHANNEL_2 | LL_IPCC_CHANNEL_3 | LL_IPCC_CHANNEL_4
      | LL_IPCC_CHANNEL_5 | LL_IPCC_CHANNEL_6);

  LL_C1_IPCC_DisableReceiveChannel(
      IPCC,
      LL_IPCC_CHANNEL_1 | LL_IPCC_CHANNEL_2 | LL_IPCC_CHANNEL_3 | LL_IPCC_CHANNEL_4
      | LL_IPCC_CHANNEL_5 | LL_IPCC_CHANNEL_6);

  LL_C2_IPCC_DisableReceiveChannel(
      IPCC,
      LL_IPCC_CHANNEL_1 | LL_IPCC_CHANNEL_2 | LL_IPCC_CHANNEL_3 | LL_IPCC_CHANNEL_4
      | LL_IPCC_CHANNEL_5 | LL_IPCC_CHANNEL_6);

  return;
}
#endif /* CFG_HW_RESET_BY_FW == 1 */

static void Config_HSE(void)
{
    OTP_ID0_t * p_otp;

  /**
   * Read HSE_Tuning from OTP
   */
  p_otp = (OTP_ID0_t *) OTP_Read(0);
  if (p_otp)
  {
    LL_RCC_HSE_SetCapacitorTuning(p_otp->hse_tuning);
  }

  return;
}

static void System_Init(void)
{
[#if Line != "STM32WBx0 Value Line" ]
  Init_Smps();

[/#if]
  Init_Exti();

  Init_Rtc();

  return;
}

static void Init_Rtc(void)
{
  /* Disable RTC registers write protection */
  LL_RTC_DisableWriteProtection(RTC);

  LL_RTC_WAKEUP_SetClock(RTC, CFG_RTC_WUCKSEL_DIVIDER);

  /* Enable RTC registers write protection */
  LL_RTC_EnableWriteProtection(RTC);

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
static void SystemPower_Config(void)
{
[#if ZIGBEE = 1]
  /* Before going to stop or standby modes, do the settings so that system clock and IP80215.4 clock start on HSI automatically */
  LL_RCC_HSI_EnableAutoFromStop();

[/#if]
  /**
   * Select HSI as system clock source after Wake Up from Stop mode
   */
  LL_RCC_SetClkAfterWakeFromStop(LL_RCC_STOP_WAKEUPCLOCK_HSI);

  /* Initialize low power manager */
  UTIL_LPM_Init();
  /* Initialize the CPU2 reset value before starting CPU2 with C2BOOT */
  LL_C2_PWR_SetPowerMode(LL_PWR_MODE_SHUTDOWN);

[#if ZIGBEE = 1]
  /* Disable Stop & Off Modes until Initialisation is complete */
  UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);
  UTIL_LPM_SetStopMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);

[/#if]

#if (CFG_USB_INTERFACE_ENABLE != 0)
  /**
   *  Enable USB power
   */
  HAL_PWREx_EnableVddUSB();
#endif /* CFG_USB_INTERFACE_ENABLE != 0 */
[#if DIE == "DIE494"]
  /**
   * Active SRAM retention for standby support
   */
  HAL_PWREx_EnableSRAMRetention();
[/#if]

  return;
}

static void appe_Tl_Init(void)
{
  TL_MM_Config_t tl_mm_config;
[#if (BLE = 1) && ((BLE_TRANSPARENT_MODE_UART = 1) ||(BLE_TRANSPARENT_MODE_VCP = 1))]
  TL_SYS_InitConf_t tl_sys_init_conf;
[#else]
  SHCI_TL_HciInitConf_t SHci_Tl_Init_Conf;
[/#if]
[#if THREADX_STATUS = 1]
  UINT ThreadXStatus;
  CHAR * pTempBuf = TX_NULL;
[/#if]
  /**< Reference table initialization */
  TL_Init();

[#if FREERTOS_STATUS = 1]

  MtxShciId = osMutexNew(NULL);
  SemShciId = osSemaphoreNew(1, 0, NULL); /*< Create the semaphore and make it busy at initialization */

  /** FreeRTOS system task creation */
  ShciUserEvtProcessId = osThreadNew(ShciUserEvtProcess, NULL, &ShciUserEvtProcess_attr);
[#elseif THREADX_STATUS = 1]
  /* Create Mutex & Semaphore and make it busy at initialization */
  tx_mutex_create(&MtxShciId, "MtxShciId", TX_NO_INHERIT);
  tx_semaphore_create(&SemShciId, "SemShciId", 0);
  tx_semaphore_create(&SemShciNotify, "SemShciNotify", 0);
  
  /* System task creation */
  tx_byte_allocate(pBytePool, (VOID**) &pTempBuf, THREADX_STACK_SIZE_LARGE, TX_NO_WAIT);
  ThreadXStatus = tx_thread_create(&ShciUserEvtProcessId,
                                    "ShciUserEvtProcessId",
                                    ShciUserEvtProcess,
                                    0,
                                    pTempBuf,
                                    THREADX_STACK_SIZE_LARGE,
                                    SHCI_USER_EVT_PROCESS_PRIORITY,
                                    SHCI_USER_EVT_PROCESS_PRIORITY,
                                    TX_NO_TIME_SLICE,
                                    TX_AUTO_START);
  
  if (ThreadXStatus != TX_SUCCESS)
  { 
    APP_ZIGBEE_Error(ERR_ZIGBEE_THREAD_X_FAILED,1); 
  }
[/#if]

  /**< System channel initialization */
[#if (BLE = 1) && ((BLE_TRANSPARENT_MODE_UART = 1) ||(BLE_TRANSPARENT_MODE_VCP = 1))]
  LST_init_head (&SysEvtQueue);
[/#if]
[#if (BLE = 1)]
[#if (SEQUENCER_STATUS = 1)]
  UTIL_SEQ_RegTask(1<< CFG_TASK_SYSTEM_HCI_ASYNCH_EVT_ID, UTIL_SEQ_RFU, shci_user_evt_proc);
[/#if]
[/#if]
[#if THREAD = 1 || ZIGBEE = 1]
[#if (SEQUENCER_STATUS = 1)]
  UTIL_SEQ_RegTask(1<< CFG_TASK_SYSTEM_HCI_ASYNCH_EVT, UTIL_SEQ_RFU, shci_user_evt_proc);
[/#if]
[/#if]
[#if BLE = 1 && ((BLE_TRANSPARENT_MODE_UART = 1) ||(BLE_TRANSPARENT_MODE_VCP = 1))]
  tl_sys_init_conf.p_cmdbuffer =  (uint8_t*)&SystemCmdBuffer;
  tl_sys_init_conf.IoBusCallBackCmdEvt = TM_SysCmdRspCb;
  tl_sys_init_conf.IoBusCallBackUserEvt = APPE_SysUserEvtRx;
  TL_SYS_Init((void*) &tl_sys_init_conf);
[#else]
  SHci_Tl_Init_Conf.p_cmdbuffer = (uint8_t*)&SystemCmdBuffer;
  SHci_Tl_Init_Conf.StatusNotCallBack = APPE_SysStatusNot;
  shci_init(APPE_SysUserEvtRx, (void*) &SHci_Tl_Init_Conf);
[/#if]

  /**< Memory Manager channel initialization */
[#if (BLE = 1)]
  tl_mm_config.p_BleSpareEvtBuffer = BleSpareEvtBuffer;
[/#if]
[#if ZIGBEE = 1]
  memset(&tl_mm_config, 0, sizeof(TL_MM_Config_t));
[/#if]
[#if THREAD = 1 || ZIGBEE = 1]
  tl_mm_config.p_BleSpareEvtBuffer = 0;
[/#if]
  tl_mm_config.p_SystemSpareEvtBuffer = SystemSpareEvtBuffer;
  tl_mm_config.p_AsynchEvtPool = EvtPool;
  tl_mm_config.AsynchEvtPoolSize = POOL_SIZE;
  TL_MM_Init(&tl_mm_config);

  TL_Enable();

  return;
}

[#if (BLE = 1)  &&
	 (BLE_TRANSPARENT_MODE_UART != 1 && BLE_TRANSPARENT_MODE_VCP != 1
	  && BT_SIG_BLOOD_PRESSURE_SENSOR != 1 && BT_SIG_HEALTH_THERMOMETER_SENSOR != 1 && BT_SIG_HEART_RATE_SENSOR != 1
	  && CUSTOM_OTA != 1 && CUSTOM_P2P_CLIENT != 1 && CUSTOM_P2P_ROUTER != 1 && CUSTOM_P2P_SERVER != 1 && CUSTOM_TEMPLATE !=1
	  && BT_SIG_BEACON == "0")]
__WEAK void APP_BLE_Init(void)
{
}

[/#if]

[#if (BLE = 1) && ((BLE_TRANSPARENT_MODE_UART = 1) ||(BLE_TRANSPARENT_MODE_VCP = 1))]
static void APPE_SysUserEvtRx(TL_EvtPacket_t * p_evt_rx)
{
  TL_AsynchEvt_t *p_sys_event;
  WirelessFwInfo_t WirelessInfo;

  LST_insert_tail (&SysEvtQueue, (tListNode *)p_evt_rx);

 if (p_evt_rx->evtserial.evt.evtcode == SHCI_EVTCODE){

    p_sys_event = (TL_AsynchEvt_t *)(p_evt_rx->evtserial.evt.payload);

    switch(p_sys_event->subevtcode)
    {
    case SHCI_SUB_EVT_CODE_READY:
    /* Read the firmware version of both the wireless firmware and the FUS */
    SHCI_GetWirelessFwInfo(&WirelessInfo);
    APP_DBG_MSG("Wireless Firmware version %d.%d.%d\n", WirelessInfo.VersionMajor, WirelessInfo.VersionMinor, WirelessInfo.VersionSub);
    APP_DBG_MSG("Wireless Firmware build %d\n", WirelessInfo.VersionReleaseType);
    APP_DBG_MSG("FUS version %d.%d.%d\n", WirelessInfo.FusVersionMajor, WirelessInfo.FusVersionMinor, WirelessInfo.FusVersionSub);
      APP_DBG_MSG(">>== SHCI_SUB_EVT_CODE_READY\n\r");
    UTIL_SEQ_SetTask(1<<CFG_TASK_SYSTEM_HCI_ASYNCH_EVT_ID, CFG_SCH_PRIO_0);

    case SHCI_SUB_EVT_ERROR_NOTIF:
      APP_DBG_MSG(">>== SHCI_SUB_EVT_ERROR_NOTIF \n\r");
      break;

    case SHCI_SUB_EVT_BLE_NVM_RAM_UPDATE:
      APP_DBG_MSG(">>== SHCI_SUB_EVT_BLE_NVM_RAM_UPDATE -- BLE NVM RAM HAS BEEN UPDATED BY CPU2 \n");
      APP_DBG_MSG("     - StartAddress = %lx , Size = %ld\n",
                  ((SHCI_C2_BleNvmRamUpdate_Evt_t*)p_sys_event->payload)->StartAddress,
                  ((SHCI_C2_BleNvmRamUpdate_Evt_t*)p_sys_event->payload)->Size);
      break;

    case SHCI_SUB_EVT_NVM_START_WRITE:
      APP_DBG_MSG("==>> SHCI_SUB_EVT_NVM_START_WRITE : NumberOfWords = %ld\n",
                  ((SHCI_C2_NvmStartWrite_Evt_t*)p_sys_event->payload)->NumberOfWords);
      break;

    case SHCI_SUB_EVT_NVM_END_WRITE:
      APP_DBG_MSG(">>== SHCI_SUB_EVT_NVM_END_WRITE\n\r");
      break;

    case SHCI_SUB_EVT_NVM_START_ERASE:
      APP_DBG_MSG("==>>SHCI_SUB_EVT_NVM_START_ERASE : NumberOfSectors = %ld\n",
                  ((SHCI_C2_NvmStartErase_Evt_t*)p_sys_event->payload)->NumberOfSectors);
      break;

    case SHCI_SUB_EVT_NVM_END_ERASE:
      APP_DBG_MSG(">>== SHCI_SUB_EVT_NVM_END_ERASE\n\r");
      break;

    default:
      break;
    }
  }
  return;
}

static void shci_user_evt_proc (void)
{
  TL_EvtPacket_t * p_evt_rx;
  /**
   * Currently, only VS_HCI_C2_Ready() system user event is supported.
   */

  /**< Traces channel initialization */
[#if (THREAD = 1)]
  TL_TRACES_Init();
[/#if]
[#if (BLE = 1)]
  APPD_EnableCPU2();
[/#if]
  UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_ENABLE);

  LST_remove_head(&SysEvtQueue, (tListNode **)&p_evt_rx);

  TL_MM_EvtDone(p_evt_rx);

  TM_Init();
  
[#else]
static void APPE_SysStatusNot(SHCI_TL_CmdStatus_t status)
{
[#if (SEQUENCER_STATUS = 1)]
  UNUSED(status);
[#elseif (FREERTOS_STATUS = 1)]
  switch (status)
  {
    case SHCI_TL_CmdBusy:
      osMutexAcquire(MtxShciId, osWaitForever);
      break;

    case SHCI_TL_CmdAvailable:
      osMutexRelease(MtxShciId);
      break;

    default:
      break;
  }
[#elseif (THREADX_STATUS = 1)]    
  switch (status)
  {
    case SHCI_TL_CmdBusy:
      tx_mutex_get(&MtxShciId, TX_WAIT_FOREVER  );
      break;

    case SHCI_TL_CmdAvailable:
      tx_mutex_put(&MtxShciId );
      break;

    default:
      break;
  }
[/#if]
  return;
}

/**
 * The type of the payload for a system user event is tSHCI_UserEvtRxParam
 * When the system event is both :
 *    - a ready event (subevtcode = SHCI_SUB_EVT_CODE_READY)
 *    - reported by the FUS (sysevt_ready_rsp == FUS_FW_RUNNING)
 * The buffer shall not be released
 * (eg ((tSHCI_UserEvtRxParam*)pPayload)->status shall be set to SHCI_TL_UserEventFlow_Disable)
 * When the status is not filled, the buffer is released by default
 */
static void APPE_SysUserEvtRx(void * pPayload)
{
[#if (BLE = 1)]
  TL_AsynchEvt_t *p_sys_event;
  WirelessFwInfo_t WirelessInfo;

  p_sys_event = (TL_AsynchEvt_t*)(((tSHCI_UserEvtRxParam*)pPayload)->pckt->evtserial.evt.payload);

  switch(p_sys_event->subevtcode)
  {
  case SHCI_SUB_EVT_CODE_READY:
    /* Read the firmware version of both the wireless firmware and the FUS */
    SHCI_GetWirelessFwInfo(&WirelessInfo);
    APP_DBG_MSG("Wireless Firmware version %d.%d.%d\n", WirelessInfo.VersionMajor, WirelessInfo.VersionMinor, WirelessInfo.VersionSub);
    APP_DBG_MSG("Wireless Firmware build %d\n", WirelessInfo.VersionReleaseType);
    APP_DBG_MSG("FUS version %d.%d.%d\n", WirelessInfo.FusVersionMajor, WirelessInfo.FusVersionMinor, WirelessInfo.FusVersionSub);

    APP_DBG_MSG(">>== SHCI_SUB_EVT_CODE_READY\n\r");
    APPE_SysEvtReadyProcessing(pPayload);
    break;

  case SHCI_SUB_EVT_ERROR_NOTIF:
    APP_DBG_MSG(">>== SHCI_SUB_EVT_ERROR_NOTIF \n\r");
    APPE_SysEvtError(pPayload);
    break;

  case SHCI_SUB_EVT_BLE_NVM_RAM_UPDATE:
    APP_DBG_MSG(">>== SHCI_SUB_EVT_BLE_NVM_RAM_UPDATE -- BLE NVM RAM HAS BEEN UPDATED BY CPU2 \n");
    APP_DBG_MSG("     - StartAddress = %lx , Size = %ld\n",
                ((SHCI_C2_BleNvmRamUpdate_Evt_t*)p_sys_event->payload)->StartAddress,
                ((SHCI_C2_BleNvmRamUpdate_Evt_t*)p_sys_event->payload)->Size);
    break;

  case SHCI_SUB_EVT_NVM_START_WRITE:
    APP_DBG_MSG("==>> SHCI_SUB_EVT_NVM_START_WRITE : NumberOfWords = %ld\n",
                ((SHCI_C2_NvmStartWrite_Evt_t*)p_sys_event->payload)->NumberOfWords);
    break;

  case SHCI_SUB_EVT_NVM_END_WRITE:
    APP_DBG_MSG(">>== SHCI_SUB_EVT_NVM_END_WRITE\n\r");
    break;

  case SHCI_SUB_EVT_NVM_START_ERASE:
    APP_DBG_MSG("==>>SHCI_SUB_EVT_NVM_START_ERASE : NumberOfSectors = %ld\n",
                ((SHCI_C2_NvmStartErase_Evt_t*)p_sys_event->payload)->NumberOfSectors);
    break;

  case SHCI_SUB_EVT_NVM_END_ERASE:
    APP_DBG_MSG(">>== SHCI_SUB_EVT_NVM_END_ERASE\n\r");
    break;

  default:
    break;
  }

[/#if]
[#if THREAD = 1 || ZIGBEE = 1]
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
[/#if]
  return;
}

/**
 * @brief Notify a system error coming from the M0 firmware
 * @param  ErrorCode  : errorCode detected by the M0 firmware
 *
 * @retval None
 */
[#if THREAD == 1 || ZIGBEE == 1]
static void APPE_SysEvtError(SCHI_SystemErrCode_t ErrorCode)
[/#if]
[#if BLE == 1]
static void APPE_SysEvtError(void * pPayload)
[/#if]
{
[#if BLE == 1]
  TL_AsynchEvt_t *p_sys_event;
  SCHI_SystemErrCode_t *p_sys_error_code;
    
  p_sys_event = (TL_AsynchEvt_t*)(((tSHCI_UserEvtRxParam*)pPayload)->pckt->evtserial.evt.payload);
  p_sys_error_code = (SCHI_SystemErrCode_t*) p_sys_event->payload;
       
  APP_DBG_MSG(">>== SHCI_SUB_EVT_ERROR_NOTIF WITH REASON %x \n\r",(*p_sys_error_code));
  
  if ((*p_sys_error_code) == ERR_BLE_INIT)
  {
    /* Error during BLE stack initialization */
    APP_DBG_MSG(">>== SHCI_SUB_EVT_ERROR_NOTIF WITH REASON - ERR_BLE_INIT \n");
  }
  else
  {
    APP_DBG_MSG(">>== SHCI_SUB_EVT_ERROR_NOTIF WITH REASON - BLE ERROR \n");
[/#if]
[#if THREAD == 1 || ZIGBEE == 1]
  switch(ErrorCode)
  {
[/#if]
[#if THREAD == 1]
  case ERR_THREAD_LLD_FATAL_ERROR:
       APP_DBG("** ERR_THREAD : LLD_FATAL_ERROR \n");
       break;
  case ERR_THREAD_UNKNOWN_CMD:
       APP_DBG("** ERR_THREAD : UNKNOWN_CMD \n");
       break;
  default:
       APP_DBG("** ERR_THREAD : ErroCode=%d \n",ErrorCode);
       break;
[/#if]
[#if ZIGBEE == 1]
  case ERR_ZIGBEE_UNKNOWN_CMD:
       APP_DBG("** ERR_ZIGBEE : UNKNOWN_CMD \n");
       break;
  default:
       APP_DBG("** ERR_ZIGBEE : ErroCode=%d \n",ErrorCode);
       break;
[/#if]
  }
[/#if]
  return;
}

[#if (BLE = 1) && (BLE_TRANSPARENT_MODE_UART = 0) && (BLE_TRANSPARENT_MODE_VCP = 0)]
static void APPE_SysEvtReadyProcessing(void * pPayload)
{
  TL_AsynchEvt_t *p_sys_event;
  SHCI_C2_Ready_Evt_t *p_sys_ready_event;
  
  SHCI_C2_CONFIG_Cmd_Param_t config_param = {0};
  uint32_t RevisionID=0;
  uint32_t DeviceID=0;
  
  p_sys_event = (TL_AsynchEvt_t*)(((tSHCI_UserEvtRxParam*)pPayload)->pckt->evtserial.evt.payload);
  p_sys_ready_event = (SHCI_C2_Ready_Evt_t*) p_sys_event->payload;
  
  if (p_sys_ready_event->sysevt_ready_rsp == WIRELESS_FW_RUNNING)
  {
    /**
    * The wireless firmware is running on the CPU2
    */
    APP_DBG_MSG(">>== WIRELESS_FW_RUNNING \n");
    
    /* Traces channel initialization */
    APPD_EnableCPU2();
    
    /* Enable all events Notification */
    config_param.PayloadCmdSize = SHCI_C2_CONFIG_PAYLOAD_CMD_SIZE;
    config_param.EvtMask1 = SHCI_C2_CONFIG_EVTMASK1_BIT0_ERROR_NOTIF_ENABLE  
      +  SHCI_C2_CONFIG_EVTMASK1_BIT1_BLE_NVM_RAM_UPDATE_ENABLE
        +  SHCI_C2_CONFIG_EVTMASK1_BIT2_THREAD_NVM_RAM_UPDATE_ENABLE
          +  SHCI_C2_CONFIG_EVTMASK1_BIT3_NVM_START_WRITE_ENABLE   
            +  SHCI_C2_CONFIG_EVTMASK1_BIT4_NVM_END_WRITE_ENABLE
              +  SHCI_C2_CONFIG_EVTMASK1_BIT5_NVM_START_ERASE_ENABLE
                +  SHCI_C2_CONFIG_EVTMASK1_BIT6_NVM_END_ERASE_ENABLE;

    /* Read revision identifier */
    /**
    * @brief  Return the device revision identifier
    * @note   This field indicates the revision of the device.
    * @rmtoll DBGMCU_IDCODE REV_ID        LL_DBGMCU_GetRevisionID
    * @retval Values between Min_Data=0x00 and Max_Data=0xFFFF
    */
    RevisionID = LL_DBGMCU_GetRevisionID();
    
    APP_DBG_MSG(">>== DBGMCU_GetRevisionID= %lx \n\r", RevisionID);

    config_param.RevisionID = (uint16_t)RevisionID;

    DeviceID = LL_DBGMCU_GetDeviceID();
    APP_DBG_MSG(">>== DBGMCU_GetDeviceID= %lx \n\r", DeviceID);
    config_param.DeviceID = (uint16_t)DeviceID;
    (void)SHCI_C2_Config(&config_param);

    APP_BLE_Init();
    UTIL_LPM_SetOffMode(1U << CFG_LPM_APP, UTIL_LPM_ENABLE);
  }
  else if (p_sys_ready_event->sysevt_ready_rsp == FUS_FW_RUNNING)
  {
    /**
    * The FUS firmware is running on the CPU2
    * In the scope of this application, there should be no case when we get here
    */
    APP_DBG_MSG(">>== SHCI_SUB_EVT_CODE_READY - FUS_FW_RUNNING \n\r");

    /* The packet shall not be released as this is not supported by the FUS */
    ((tSHCI_UserEvtRxParam*)pPayload)->status = SHCI_TL_UserEventFlow_Disable;
  }
  else
  {
    APP_DBG_MSG(">>== SHCI_SUB_EVT_CODE_READY - UNEXPECTED CASE \n\r");
  }

  return;
}
[/#if]

[#if THREAD = 1 || ZIGBEE = 1]
static void APPE_SysEvtReadyProcessing(void)
{
  /* Traces channel initialization */
  TL_TRACES_Init();

[#if (THREAD = 1)]
  APP_THREAD_Init();
  UTIL_LPM_SetStopMode(1 << CFG_LPM_APP, UTIL_LPM_ENABLE);
  UTIL_LPM_SetOffMode(1U << CFG_LPM_APP, UTIL_LPM_ENABLE);
[/#if]
[#if ZIGBEE = 1]
  APP_ZIGBEE_Init();
[/#if]
  return;
}
[/#if]
[#if (FREERTOS_STATUS = 1)]

/*************************************************************
 *
 * FREERTOS WRAPPER FUNCTIONS
 *
*************************************************************/
static void ShciUserEvtProcess(void *argument)
{
  UNUSED(argument);
  for(;;)
  {
    /* USER CODE BEGIN SHCI_USER_EVT_PROCESS_1 */

    /* USER CODE END SHCI_USER_EVT_PROCESS_1 */
     osThreadFlagsWait(1, osFlagsWaitAny, osWaitForever);
     shci_user_evt_proc();
    /* USER CODE BEGIN SHCI_USER_EVT_PROCESS_2 */

    /* USER CODE END SHCI_USER_EVT_PROCESS_2 */
    }
}
[#elseif THREADX_STATUS = 1]

/*************************************************************
 *
 * ThreadX WRAPPER FUNCTIONS
 *
*************************************************************/
static void ShciUserEvtProcess(ULONG argument)
{
  UNUSED(argument);

  for(;;)
  {
    /* USER CODE BEGIN SHCI_USER_EVT_PROCESS_1 */

    /* USER CODE END SHCI_USER_EVT_PROCESS_1 */
     tx_semaphore_get(&SemShciNotify, TX_WAIT_FOREVER);
     shci_user_evt_proc();
    /* USER CODE BEGIN SHCI_USER_EVT_PROCESS_2 */

    /* USER CODE END SHCI_USER_EVT_PROCESS_2 */
  }
}
[/#if]

/* USER CODE BEGIN FD_LOCAL_FUNCTIONS */

/* USER CODE END FD_LOCAL_FUNCTIONS */

/*************************************************************
 *
 * WRAP FUNCTIONS
 *
 *************************************************************/
void HAL_Delay(uint32_t Delay)
{
  uint32_t tickstart = HAL_GetTick();
  uint32_t wait = Delay;

  /* Add a freq to guarantee minimum wait */
  if (wait < HAL_MAX_DELAY)
  {
    wait += HAL_GetTickFreq();
  }

  while ((HAL_GetTick() - tickstart) < wait)
  {
    /************************************************************************************
     * ENTER SLEEP MODE
     ***********************************************************************************/
    LL_LPM_EnableSleep(); /**< Clear SLEEPDEEP bit of Cortex System Control Register */

    /**
     * This option is used to ensure that store operations are completed
     */
  #if defined (__CC_ARM) || defined (__ARMCC_VERSION)
    __force_stores();
  #endif /* __ARMCC_VERSION */

    __WFI();
  }
}

[#if (SEQUENCER_STATUS = 1)]
void MX_APPE_Process(void)
{
  /* USER CODE BEGIN MX_APPE_Process_1 */

  /* USER CODE END MX_APPE_Process_1 */
  UTIL_SEQ_Run(UTIL_SEQ_DEFAULT);
  /* USER CODE BEGIN MX_APPE_Process_2 */

  /* USER CODE END MX_APPE_Process_2 */
}

void UTIL_SEQ_Idle(void)
{
#if (CFG_LPM_SUPPORTED == 1)
  UTIL_LPM_EnterLowPower();
#endif /* CFG_LPM_SUPPORTED == 1 */
  return;
}
[/#if]
[#if (THREAD = 1) &&(FREERTOS_STATUS = 1)]
#if (CFG_AMM_ENABLED != 0)
static void AMM_WrapperInit (uint32_t * const p_PoolAddr, const uint32_t PoolSize)
{
  UTIL_MM_Init ((uint8_t *)p_PoolAddr, ((size_t)PoolSize * sizeof(uint32_t)));
}

static uint32_t * AMM_WrapperAllocate (const uint32_t BufferSize)
{
  return (uint32_t *)UTIL_MM_GetBuffer (((size_t)BufferSize * sizeof(uint32_t)));
}

static void AMM_WrapperFree (uint32_t * const p_BufferAddr)
{
  UTIL_MM_ReleaseBuffer ((void *)p_BufferAddr);
}

void AMM_BackgroundProcess_Entry(void* thread_input)
{
  (void)(thread_input);
  
  while(1)
  {
    osSemaphoreAcquire(AMM_BCKGND_Thread_Sem , osWaitForever);
    AMM_BackgroundProcess();
  }
}

void AMM_RegisterBasicMemoryManager (AMM_BasicMemoryManagerFunctions_t * const p_BasicMemoryManagerFunctions)
{
  /* Fulfill the function handle */
  p_BasicMemoryManagerFunctions->Init = AMM_WrapperInit;
  p_BasicMemoryManagerFunctions->Allocate = AMM_WrapperAllocate;
  p_BasicMemoryManagerFunctions->Free = AMM_WrapperFree;
}

void AMM_ProcessRequest (void)
{
  /* Ask for AMM background task scheduling */
  osSemaphoreRelease(AMM_BCKGND_Thread_Sem);
}

void TRC_BackgroundProcess(void)
{
  TraceEltPacket_t * traceElt = NULL;
  while (LST_is_empty (&TraceBufferList) == FALSE)
  {
    LST_remove_tail (&TraceBufferList, (tListNode**)&traceElt);
    if (traceElt != NULL)
    {
#if(CFG_DEBUG_TRACE != 0)
      DbgTraceWrite(1U, (const unsigned char *) traceElt->trace.buffer, traceElt->trace.size);
#endif /* CFG_DEBUG_TRACE */
      AMM_Free((uint32_t *)traceElt);
    }
  }
}

void TRC_BackgroundProcess_Entry(void* thread_input)
{
  (void)(thread_input);
  
  while(1)
  {
    osSemaphoreAcquire(TRC_BCKGND_Thread_Sem , osWaitForever);
    TRC_BackgroundProcess();
  }
}
#endif
[/#if]
[#if (SEQUENCER_STATUS = 1)]
[#if BLE != 1]
/**
  * @brief  This function is called by the scheduler each time an event
  *         is pending.
  *
  * @param  evt_waited_bm : Event pending.
  * @retval None
  */
void UTIL_SEQ_EvtIdle(UTIL_SEQ_bm_t task_id_bm, UTIL_SEQ_bm_t evt_waited_bm)
{
[#if THREAD = 1 || ZIGBEE = 1]
[#if ZIGBEE = 1]
        /* Check the notification condition */
        if (g_ot_notification_allowed) {
                UTIL_SEQ_Run(1U << CFG_TASK_NOTIFY_FROM_M0_TO_M4);
        }
[/#if]
  switch(evt_waited_bm)
  {
  case EVENT_ACK_FROM_M0_EVT:
[#if THREAD = 1]
    if (g_ot_notification_allowed == 1U)
    {
      /* Some OT API send M0 to M4 notifications so allow notifications when waiting for OT Cmd response */
      UTIL_SEQ_Run(TASK_MSG_FROM_M0_TO_M4);
    }
    else
    {
      /* Does not allow other tasks when waiting for OT Cmd response */
      UTIL_SEQ_Run(0);
    }
[#else]
    /**
     * Run only the task CFG_TASK_REQUEST_FROM_M0_TO_M4 to process
     * direct requests from the M0 (e.g. ZbMalloc), but no stack notifications
     * until we're done the request to the M0.
     */
    UTIL_SEQ_Run((1U << CFG_TASK_REQUEST_FROM_M0_TO_M4));
[/#if]
    break;
  case EVENT_SYNCHRO_BYPASS_IDLE:
    UTIL_SEQ_SetEvt(EVENT_SYNCHRO_BYPASS_IDLE);
[#if THREAD = 1]
    /* Run only the task CFG_TASK_MSG_FROM_M0_TO_M4 */
    UTIL_SEQ_Run(TASK_MSG_FROM_M0_TO_M4);
[#else]
    /* Process notifications and requests from the M0 */
    UTIL_SEQ_Run((1U << CFG_TASK_NOTIFY_FROM_M0_TO_M4) | (1U << CFG_TASK_REQUEST_FROM_M0_TO_M4));
[/#if]
    break;
  default :
    /* default case */
    UTIL_SEQ_Run(UTIL_SEQ_DEFAULT);
    break;
  }
[/#if]      
}
[/#if]
[/#if]

[#if (THREAD = 1) &&(FREERTOS_STATUS = 0)]
#if (CFG_AMM_ENABLED != 0)
static void AMM_WrapperInit (uint32_t * const p_PoolAddr, const uint32_t PoolSize)
{
  UTIL_MM_Init ((uint8_t *)p_PoolAddr, ((size_t)PoolSize * sizeof(uint32_t)));
}

static uint32_t * AMM_WrapperAllocate (const uint32_t BufferSize)
{
  return (uint32_t *)UTIL_MM_GetBuffer (((size_t)BufferSize * sizeof(uint32_t)));
}

static void AMM_WrapperFree (uint32_t * const p_BufferAddr)
{
  UTIL_MM_ReleaseBuffer ((void *)p_BufferAddr);
}

void AMM_RegisterBasicMemoryManager (AMM_BasicMemoryManagerFunctions_t * const p_BasicMemoryManagerFunctions)
{
  /* Fulfill the function handle */
  p_BasicMemoryManagerFunctions->Init = AMM_WrapperInit;
  p_BasicMemoryManagerFunctions->Allocate = AMM_WrapperAllocate;
  p_BasicMemoryManagerFunctions->Free = AMM_WrapperFree;
}

void AMM_ProcessRequest (void)
{
  /* Ask for AMM background task scheduling */
  UTIL_SEQ_SetTask(1U << CFG_TASK_AMM_BCKGND, CFG_SCH_PRIO_0);
}
#endif
[/#if]

[#if THREAD = 1 || ZIGBEE = 1]
void shci_notify_asynch_evt(void* pdata)
{
  UNUSED(pdata);
[#if (FREERTOS_STATUS = 1)]  
  osThreadFlagsSet(ShciUserEvtProcessId,1);
[#elseif THREADX_STATUS = 1]  
  tx_semaphore_put(&SemShciNotify);
[#elseif (SEQUENCER_STATUS = 1)]  
  UTIL_SEQ_SetTask(1U << CFG_TASK_SYSTEM_HCI_ASYNCH_EVT, CFG_SCH_PRIO_0);
[/#if]  
  return;
}
[/#if]

[#if (BLE = 1) && (BLE_TRANSPARENT_MODE_UART = 0) && (BLE_TRANSPARENT_MODE_VCP = 0)]
void shci_notify_asynch_evt(void* pdata)
{
[#if (FREERTOS_STATUS = 1)]
  UNUSED(pdata);
  osThreadFlagsSet(ShciUserEvtProcessId, 1);
[#else]
  UTIL_SEQ_SetTask(1<<CFG_TASK_SYSTEM_HCI_ASYNCH_EVT_ID, CFG_SCH_PRIO_0);
[/#if]
  return;
}

void shci_cmd_resp_release(uint32_t flag)
{
[#if (FREERTOS_STATUS = 1)]
  UNUSED(flag);
  osSemaphoreRelease(SemShciId);
[#else]
  UTIL_SEQ_SetEvt(1<< CFG_IDLEEVT_SYSTEM_HCI_CMD_EVT_RSP_ID);
[/#if]
  return;
}

void shci_cmd_resp_wait(uint32_t timeout)
{
[#if (FREERTOS_STATUS = 1)]
  UNUSED(timeout);
  osSemaphoreAcquire(SemShciId, osWaitForever);
[#else]
  UTIL_SEQ_WaitEvt(1<< CFG_IDLEEVT_SYSTEM_HCI_CMD_EVT_RSP_ID);
[/#if]
  return;
}

[/#if]
[#if THREAD = 1 || ZIGBEE = 1]
void shci_cmd_resp_release(uint32_t flag)
{
  UNUSED(flag);
[#if (FREERTOS_STATUS = 1)]
  osSemaphoreRelease(SemShciId);
[#elseif THREADX_STATUS = 1]
  tx_semaphore_put(&SemShciId);
[#elseif (SEQUENCER_STATUS = 1)]
  UTIL_SEQ_SetEvt(1U << CFG_EVT_SYSTEM_HCI_CMD_EVT_RESP);
[/#if]
  return;
}

void shci_cmd_resp_wait(uint32_t timeout)
{
  UNUSED(timeout);
[#if (FREERTOS_STATUS = 1)]
  osSemaphoreAcquire(SemShciId, osWaitForever);
[#elseif THREADX_STATUS = 1]
  tx_semaphore_get(&SemShciId, TX_WAIT_FOREVER);
[#elseif (SEQUENCER_STATUS = 1)]
  UTIL_SEQ_WaitEvt(1U << CFG_EVT_SYSTEM_HCI_CMD_EVT_RESP);
[/#if]
  return;
}

[#if (THREAD = 1) && (FREERTOS_STATUS = 1)]
/* Received trace buffer from M0 */
void TL_TRACES_EvtReceived( TL_EvtPacket_t * hcievt )
{
#if(CFG_DEBUG_TRACE != 0)
  writeTrace(( char *) ((TL_AsynchEvt_t *)(hcievt->evtserial.evt.payload))->payload, hcievt->evtserial.evt.plen - 2U);
#endif /* CFG_DEBUG_TRACE */
  /* Release buffer */
  TL_MM_EvtDone( hcievt );
}

#if(CFG_DEBUG_TRACE != 0)
void writeTrace(char * buffer, uint32_t size)
{
#if (CFG_AMM_ENABLED != 0) 
  TraceEltPacket_t * traceElt = NULL;
  if(AMM_ERROR_OK == AMM_Alloc (CFG_AMM_VIRTUAL_APP_TRACE, DIVC(sizeof(TraceEltPacket_t), sizeof(uint32_t)), (uint32_t **)&traceElt, NULL))
  {
    if(traceElt != NULL)
    {
      memcpy(traceElt->trace.buffer, (const unsigned char *) buffer, size);
      traceElt->trace.size = size;
      LST_insert_head (&TraceBufferList, (tListNode *)traceElt);
      osSemaphoreRelease(TRC_BCKGND_Thread_Sem);
    }
  }
#endif
}
#endif /* CFG_DEBUG_TRACE */
[#else]
[#if (THREAD = 1) && (FREERTOS_STATUS = 0)]
/* Received trace buffer from M0 */
void TL_TRACES_EvtReceived( TL_EvtPacket_t * hcievt )
{
#if(CFG_DEBUG_TRACE != 0)
  writeTrace(( char *) ((TL_AsynchEvt_t *)(hcievt->evtserial.evt.payload))->payload, hcievt->evtserial.evt.plen - 2U);
#endif /* CFG_DEBUG_TRACE */
  /* Release buffer */
  TL_MM_EvtDone( hcievt );
}

#if (CFG_AMM_ENABLED != 0)
/**
 * @brief Process the traces coming from the M0 or M4.
 * @param  None
 * @retval None
 */
void ProcessTrace(void)
{
  TraceEltPacket_t * traceElt = NULL;
  
  while (LST_is_empty (&TraceBufferList) == FALSE)
  {
    /* Remove the head element */
    LST_remove_tail (&TraceBufferList, (tListNode**)&traceElt);
    
    if (traceElt != NULL)
    {
#if(CFG_DEBUG_TRACE != 0)
      DbgTraceWrite(1U, (const unsigned char *) traceElt->trace.buffer, traceElt->trace.size);
#endif /* CFG_DEBUG_TRACE */
      AMM_Free((uint32_t *)traceElt);
    }
  }
}
#endif
[#else]
/* Received trace buffer from M0 */
void TL_TRACES_EvtReceived(TL_EvtPacket_t * hcievt)
{
#if (CFG_DEBUG_TRACE != 0)
  /* Call write/print function using DMA from dbg_trace */
  /* - Cast to TL_AsynchEvt_t* to get "real" payload (without Sub Evt code 2bytes),
     - (-2) to size to remove Sub Evt Code */
  DbgTraceWrite(1U, (const unsigned char *) ((TL_AsynchEvt_t *)(hcievt->evtserial.evt.payload))->payload, hcievt->evtserial.evt.plen - 2U);
#endif /* CFG_DEBUG_TRACE != 0 */
  /* Release buffer */
  TL_MM_EvtDone(hcievt);
}
[/#if]
[/#if]
[/#if]
[#if THREAD = 1 || ZIGBEE = 1]
/**
  * @brief  Initialisation of the trace mechanism
  * @param  None
  * @retval None
  */
#if (CFG_DEBUG_TRACE != 0)
void DbgOutputInit(void)
{
#ifdef CFG_DEBUG_TRACE_UART
[#if (CFG_DEBUG_TRACE_UART = "hw_lpuart1")]
  MX_LPUART1_UART_Init();
[/#if]
[#if (CFG_DEBUG_TRACE_UART = "hw_uart1")]
  MX_USART1_UART_Init();
[/#if]
  return;
#endif /* CFG_DEBUG_TRACE_UART */
}

/**
  * @brief  Management of the traces
  * @param  p_data : data
  * @param  size : size
  * @param  call-back :
  * @retval None
  */
void DbgOutputTraces(uint8_t *p_data, uint16_t size, void (*cb)(void))
{
  HW_UART_Transmit_DMA(CFG_DEBUG_TRACE_UART, p_data, size, cb);

  return;
}
#endif /* CFG_DEBUG_TRACE != 0 */
[/#if]
[#if (THREAD = 1) && (FREERTOS_STATUS = 0)]
[#if CFG_DEBUG_TRACE = "0"]
#if(CFG_DEBUG_TRACE != 0)
[/#if]
static void writeTrace(char * buffer, uint32_t size)
{
#if (CFG_AMM_ENABLED != 0)
  TraceEltPacket_t * traceElt = NULL;

  /* Allocate memory for the message to store in the trace pool */
  if(AMM_ERROR_OK == AMM_Alloc (CFG_AMM_VIRTUAL_APP_TRACE, DIVC(sizeof(TraceEltPacket_t), sizeof(uint32_t)), (uint32_t **)&traceElt, NULL))
  {
    if(traceElt != NULL)
    {
      /* Copy the M0 message in the dedicated memory */
      memcpy(traceElt->trace.buffer, (const unsigned char *) buffer, size);
      traceElt->trace.size = size;
      /* Add M0 message to the trace list */
      LST_insert_head (&TraceBufferList, (tListNode *)traceElt);

      UTIL_SEQ_SetTask(1 <<CFG_TASK_TRACE, CFG_SCH_PRIO_1);
    }
  }
#endif
}
[#if CFG_DEBUG_TRACE = "0"]
#endif /* CFG_DEBUG_TRACE */
[/#if]
[/#if]
/* USER CODE BEGIN FD_WRAP_FUNCTIONS */

/* USER CODE END FD_WRAP_FUNCTIONS */
