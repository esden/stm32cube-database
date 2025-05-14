[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_entry.c
  * @author  MCD Application Team
  * @brief   Entry point of the application
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign PG_FILL_UCS = "False"]
[#assign PG_BSP_NUCLEO_WBA52CG = 0]
[#assign PG_VALIDATION = 0]
[#assign PG_SKIP_LIST = "False"]
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
[#-- If Thread with OT-CLI is activated, SerialCommandInterface is deactivated --]
[#assign SerialCommandInterface = "True"]
[#if (myHash["THREAD"] == "Enabled")]
    [#assign nbInstanceCli = 0]
    [#assign myHashCli = {}]
    [#if BspIpDatas??]
        [#list BspIpDatas as SWIP]
            [#if SWIP.variables??]
                [#list SWIP.variables as variables]
                    [#assign myHashCli = {variables.name + nbInstanceCli:variables.value} + myHashCli]
                    [#if variables.name?contains("BoardName")]
                        [#assign nbInstanceCli = nbInstanceCli + 1]
                        Instance++
                    [/#if]
                [/#list]
            [/#if]
        [/#list]
    [/#if]
    [#if nbInstanceCli !=0 ]
        [#list 0..(nbInstanceCli-1) as i]
            [#if myHashCli["bspName"+i] == "Serial Link for Command Line Interface" ]
                [#assign SerialCommandInterface = "False" ]
            [/#if]
        [/#list]
    [/#if]
[/#if]

/* Includes ------------------------------------------------------------------*/
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
#include "app_common.h"
#include "log_module.h"
[/#if]
#include "app_conf.h"
#include "main.h"
[#if myHash["ZIGBEE"] == "Enabled"]
#include "app_zigbee.h"
[/#if]
#include "app_entry.h"
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
#include "stm32_rtos.h"
[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
#include "stm_list.h"
[/#if]
#if (CFG_LPM_LEVEL != 0)
[#if myHash["ZIGBEE"] == "Enabled" || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled") || (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")]
#include "app_sys.h"
[/#if]
#include "stm32_lpm.h"
#endif /* (CFG_LPM_LEVEL != 0) */
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
#include "stm32_timer.h"
[/#if]
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
#include "advanced_memory_manager.h"
[/#if]
[#if (myHash["CFG_MM_TYPE"]?number != 0)]
#include "stm32_mm.h"
[/#if]
#if (CFG_LOG_SUPPORTED != 0)
#include "stm32_adv_trace.h"
#include "serial_cmd_interpreter.h"
#endif /* CFG_LOG_SUPPORTED */
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
#include "app_ble.h"
[/#if]
[#if myHash["BLE"] == "Enabled" ]
#include "ll_sys.h"
#include "ll_sys_if.h"
[/#if]
[#if myHash["THREAD"] == "Enabled" ]
#include "app_thread.h"
[/#if]
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
#include "app_sys.h"
[/#if]
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
#include "otp.h"
#include "scm.h"
[/#if]
[#if (myHash["BLE"] == "Enabled")]
#include "bpka.h"
[/#if]
[#if (myHash["BLE"] == "Enabled") || ((myHash["ZIGBEE"] == "Enabled") && (myHash["USE_SNVMA_NVM"]?number != 0))]
#include "flash_driver.h"
#include "flash_manager.h"
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
#include "simple_nvm_arbiter.h"
[/#if]
[/#if]
[#if (myHash["BLE"] == "Enabled")]
#include "app_debug.h"
[/#if]
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
#include "adc_ctrl.h"
#include "temp_measurement.h"
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
#if(CFG_RT_DEBUG_DTB == 1)
#include "RTDebug_dtb.h"
#endif /* CFG_RT_DEBUG_DTB */
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
#include "stm32wbaxx_ll_rcc.h"
[/#if]
[#if (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")]
#include "ll_sys.h"
[/#if]
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled")]
#include "skel_ble.h"
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
#include "timer_if.h"
extern void xPortSysTickHandler (void);
extern void vPortSetupTimerInterrupt(void);
[/#if]

/* Private includes -----------------------------------------------------------*/
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
extern void ll_sys_mac_cntrl_init( void );
[/#if]
/* USER CODE BEGIN Includes */
[#if PG_FILL_UCS == "True"]
[#if PG_BSP_NUCLEO_WBA52CG == 1]
#include "stm32wbaxx_nucleo.h"
[/#if]
[/#if]

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/

/* USER CODE BEGIN PTD */
[#if PG_FILL_UCS == "True"]
[#if PG_BSP_NUCLEO_WBA52CG == 1]
#if (CFG_BUTTON_SUPPORTED == 1)
typedef struct
{
  Button_TypeDef      button;
  UTIL_TIMER_Object_t longTimerId;
  uint8_t             longPressed;
} ButtonDesc_t;
#endif /* (CFG_BUTTON_SUPPORTED == 1) */
[/#if]
[/#if]

/* USER CODE END PTD */

/* Private defines -----------------------------------------------------------*/

/* USER CODE BEGIN PD */
[#if PG_FILL_UCS == "True"]
[#if PG_BSP_NUCLEO_WBA52CG == 1]
#if (CFG_BUTTON_SUPPORTED == 1)
#define BUTTON_LONG_PRESS_THRESHOLD_MS   (500u)
#define BUTTON_NB_MAX                    (B3 + 1u)
#endif
[/#if]
[/#if]

/* USER CODE END PD */

/* Private macros ------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private constants ---------------------------------------------------------*/
/* USER CODE BEGIN PC */

/* USER CODE END PC */

/* Private variables ---------------------------------------------------------*/
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
const uint32_t FW_Version = (CFG_FW_MAJOR_VERSION << 24) + (CFG_FW_MINOR_VERSION << 16) + (CFG_FW_SUBVERSION << 8)
+ (CFG_FW_BRANCH << 4) + CFG_FW_BUILD;

[/#if]
[#if (myHash["SEQUENCER_STATUS"]?number == 1)]
#if ( CFG_LPM_LEVEL != 0)
static bool system_startup_done = FALSE;
#endif /* ( CFG_LPM_LEVEL != 0) */
[#elseif (myHash["FREERTOS_STATUS"]?number == 1)]
#if ( CFG_LPM_LEVEL != 0)
static bool system_startup_done = FALSE;
/* Holds maximum number of FreeRTOS tick periods that can be suppressed */
static uint32_t maximumPossibleSuppressedTicks = 0;
#endif /* ( CFG_LPM_LEVEL != 0) */
[/#if]

#if (CFG_LOG_SUPPORTED != 0)
/* Log configuration */
static Log_Module_t Log_Module_Config = { .verbose_level = APPLI_CONFIG_LOG_LEVEL, .region = LOG_REGION_ALL_REGIONS };
#endif /* (CFG_LOG_SUPPORTED != 0) */

[#if (myHash["CFG_MM_TYPE"]?number == 2)]
/* AMM configuration */
static uint32_t AMM_Pool[CFG_AMM_POOL_SIZE];
static AMM_VirtualMemoryConfig_t vmConfig[CFG_AMM_VIRTUAL_MEMORY_NUMBER] =
{
[#if PG_SKIP_LIST == "False"]
[#list 1..(myHash["CFG_AMM_VIRTUAL_MEMORY_NUMBER"]?number) as i]
  /* Virtual Memory #${i} */
  {
    .Id = CFG_AMM_VIRTUAL_${myHash["CFG_AMM_VIRTUAL_ID_NAME_"+i?string]},
    .BufferSize = CFG_AMM_VIRTUAL_${myHash["CFG_AMM_VIRTUAL_ID_NAME_"+i?string]}_BUFFER_SIZE
  },
[/#list]
[#else]
  /* Virtual Memory #1 */
  {
    .Id = CFG_AMM_VIRTUAL_STACK_BLE,
    .BufferSize = CFG_AMM_VIRTUAL_STACK_BLE_BUFFER_SIZE
  },
  /* Virtual Memory #2 */
  {
    .Id = CFG_AMM_VIRTUAL_APP_BLE,
    .BufferSize = CFG_AMM_VIRTUAL_APP_BLE_BUFFER_SIZE
  },
[/#if]
};

static AMM_InitParameters_t ammInitConfig =
{
  .p_PoolAddr = AMM_Pool,
  .PoolSize = CFG_AMM_POOL_SIZE,
  .VirtualMemoryNumber = CFG_AMM_VIRTUAL_MEMORY_NUMBER,
  .p_VirtualMemoryConfigList = vmConfig
};

[/#if]

[#if myHash["FREERTOS_STATUS"]?number == 1 ]
/* Timers for FreeRTOS declaration */

static UTIL_TIMER_Object_t  TimerOStick_Id;
static UTIL_TIMER_Object_t  TimerOSwakeup_Id;

/* FreeRTOS objects declaration */

[#if (myHash["CFG_MM_TYPE"]?number == 2)]
static osThreadId_t     AmmTaskHandle;
static osSemaphoreId_t  AmmSemaphore;

const osThreadAttr_t AmmTask_attributes = {
  .name         = "AMM Task",
  .priority     = TASK_PRIO_AMM,
  .stack_size   = TASK_STACK_SIZE_AMM,
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM
};

const osSemaphoreAttr_t AmmSemaphore_attributes = {
  .name         = "AMM Semaphore",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE
};

[/#if]
static osThreadId_t     RngTaskHandle;
static osSemaphoreId_t  RngSemaphore;

const osThreadAttr_t RngTask_attributes = {
  .name         = "Random Number Generator Task",
  .priority     = TASK_PRIO_RNG,
  .stack_size   = TASK_STACK_SIZE_RNG,
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM
};

const osSemaphoreAttr_t RngSemaphore_attributes = {
  .name         = "Random Number Generator Semaphore",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE
};

[#if (myHash["BLE"] == "Enabled")]
static osThreadId_t     FlashManagerTaskHandle;
static osSemaphoreId_t  FlashManagerSemaphore;

const osThreadAttr_t FlashManagerTask_attributes = {
  .name         = "FLASH Manager Task",
  .priority     = TASK_PRIO_FLASH_MANAGER,
  .stack_size   = TASK_STACK_SIZE_FLASH_MANAGER,
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM
};

const osSemaphoreAttr_t FlashManagerSemaphore_attributes = {
  .name         = "FLASH Manager Semaphore",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE
};

[/#if]
[#if (myHash["BLE"] == "Enabled")]
static osThreadId_t     BpkaTaskHandle;
static osSemaphoreId_t  BpkaSemaphore;

const osThreadAttr_t BpkaTask_attributes = {
  .name         = "BPKA Task",
  .priority     = TASK_PRIO_RNG,
  .stack_size   = TASK_STACK_SIZE_RNG,
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM
};

const osSemaphoreAttr_t BpkaSemaphore_attributes = {
  .name         = "BPKA Semaphore",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE
};

[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
/* ThreadX objects declaration */

[#if (myHash["CFG_MM_TYPE"]?number == 2)]
static TX_THREAD      AmmTaskHandle;
static TX_SEMAPHORE   AmmSemaphore;

[/#if]
static TX_THREAD      RngTaskHandle;
static TX_SEMAPHORE   RngSemaphore;

[#if myHash["ZIGBEE"] == "Enabled" || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
static TX_THREAD      AppliStartThread;

[/#if]
[#if (myHash["BLE"] == "Enabled")]
static TX_THREAD      FlashManagerTaskHandle;
static TX_SEMAPHORE   FlashManagerSemaphore;

[/#if]

[#if (myHash["BLE"] == "Enabled")]
static TX_THREAD      BpkaTaskHandle;
static TX_SEMAPHORE   BpkaSemaphore;

[/#if]

[/#if]

/* USER CODE BEGIN PV */
[#if PG_FILL_UCS == "True"]
[#if PG_BSP_NUCLEO_WBA52CG == 1]
#if (CFG_BUTTON_SUPPORTED == 1)
/* Button management */
static ButtonDesc_t buttonDesc[BUTTON_NB_MAX];
#endif
[/#if]
[/#if]

/* USER CODE END PV */

/* Global variables ----------------------------------------------------------*/
[#if myHash["THREADX_STATUS"]?number == 1 ]
/* ThreadX byte pool pointer for whole WPAN middleware */
TX_BYTE_POOL  * pBytePool;
CHAR          * pStack;

[/#if]
/* USER CODE BEGIN GV */

/* USER CODE END GV */

/* Private functions prototypes-----------------------------------------------*/
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
static void System_Init( void );
static void SystemPower_Config( void );
static void Config_HSE(void);
static void APPE_RNG_Init( void );
[/#if]

[#if (myHash["CFG_MM_TYPE"]?number == 2)]
static void APPE_AMM_Init(void);
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
static void AMM_Task_Entry(void* argument);
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
static void AMM_Task_Entry(ULONG lArgument);
[/#if]
static void AMM_WrapperInit(uint32_t * const p_PoolAddr, const uint32_t PoolSize);
static uint32_t * AMM_WrapperAllocate(const uint32_t BufferSize);
static void AMM_WrapperFree(uint32_t * const p_BufferAddr);

[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
static void RNG_Task_Entry(void* argument);
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
static void RNG_Task_Entry(ULONG lArgument);
[/#if]

[#if (myHash["BLE"] == "Enabled") || ((myHash["ZIGBEE"] == "Enabled") && (myHash["USE_SNVMA_NVM"]?number != 0))]
static void APPE_FLASH_MANAGER_Init( void );
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
static void FLASH_Manager_Task_Entry(void* argument);
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
static void FLASH_Manager_Task_Entry(ULONG lArgument);
[/#if]

[/#if]

[#if (myHash["BLE"] == "Enabled")]
static void APPE_BPKA_Init( void );
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
static void BPKA_Task_Entry(void* argument);
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
static void BPKA_Task_Entry(ULONG lArgument);
[/#if]

[/#if]

[#if myHash["THREADX_STATUS"]?number == 1 ]
#ifndef TX_LOW_POWER_USER_ENTER
void ThreadXLowPowerUserEnter( void );
#endif
#ifndef TX_LOW_POWER_USER_EXIT
void ThreadXLowPowerUserExit( void );
#endif
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
static void TimerOStickCB(void *arg);
static void TimerOSwakeupCB(void *arg);
#if ( CFG_LPM_LEVEL != 0)
static uint32_t getCurrentTime(void);
#endif /* CFG_LPM_LEVEL */
[/#if]

/* USER CODE BEGIN PFP */
[#if PG_FILL_UCS == "True"]
#if (CFG_LED_SUPPORTED == 1)
static void Led_Init(void);
#endif
#if (CFG_BUTTON_SUPPORTED == 1)
static void Button_Init(void);
static void Button_TriggerActions(void *arg);
#endif
[/#if]
/* USER CODE END PFP */

/* External variables --------------------------------------------------------*/

/* USER CODE BEGIN EV */

/* USER CODE END EV */


/* Functions Definition ------------------------------------------------------*/
/**
 * @brief   Wireless Private Area Network configuration.
 */
void MX_APPE_Config(void)
{
[#if myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled"]
  /* Configure HSE Tuning */
  Config_HSE();
[#else]
  /* Apply default gain */
  HAL_RCCEx_HSESetTrimming(0x0C); 
[/#if]
}

[#if myHash["ZIGBEE"] == "Enabled" || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
/**
 * @brief   LinkLayer & MAC Initialisation.
 */
void MX_APPE_LinkLayerInit(void)
{
  /* Initialization of the low level : link layer and MAC */
  ll_sys_mac_cntrl_init();

}

[#if myHash["THREADX_STATUS"]?number == 1 ]
/**
 * @brief   System Tasks Initialisations
 */
void MX_APPE_InitTask( ULONG lArgument )
{
  /* USER CODE START APPE_Init_Task_1 */
  /* Initialize Peripherals */
#if (CFG_LED_SUPPORTED == 1)
  Led_Init();
#endif // (CFG_LED_SUPPORTED == 1)
#if (CFG_BUTTON_SUPPORTED == 1)
  Button_Init();
#endif // (CFG_BUTTON_SUPPORTED == 1)

  /* USER CODE END APPE_Init_Task_1 */

  /* Initialization of the low level : link layer and MAC */
  MX_APPE_LinkLayerInit();

  /* Initialization of the Zigbee Application */
  /* Must be called in thread context
     due to dependency of ZbInit() on MAC layer semaphore */
  APP_ZIGBEE_ApplicationInit();

  /* USER CODE BEGIN APPE_Init_Task_2 */
  /* USER CODE END APPE_Init_Task_2 */

  /* Free allocated stack before entering completed state */
  tx_byte_release(AppliStartThread.tx_thread_stack_start);
}

[/#if]
[/#if]
/**
 * @brief   Wireless Private Area Network initialisation.
 */
uint32_t MX_APPE_Init(void *p_param)
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled")]
  UNUSED(p_param);

  BLE_Init();
[#else]
[#if (myHash["ZIGBEE"] == "Enabled")]
[#if (myHash["THREADX_STATUS"]?number == 1)]
  UINT TXstatus;
  CHAR *pStack;

[/#if]
[/#if]
  APP_DEBUG_SIGNAL_SET(APP_APPE_INIT);

[#if myHash["THREADX_STATUS"]?number == 1 ]
  /* Save ThreadX byte pool for whole WPAN middleware */
  pBytePool = p_param;
[#else]
  UNUSED(p_param);
[/#if]

  /* System initialization */
  System_Init();

  /* Configure the system Power Mode */
  SystemPower_Config();

[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
  /* Initialize the Temperature measurement */
  TEMPMEAS_Init ();
#endif /* (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1) */

[/#if]
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
  /* Initialize the Advance Memory Manager module */
  APPE_AMM_Init();
  
[/#if]
  /* Initialize the Random Number Generator module */
  APPE_RNG_Init();

[#if (myHash["BLE"] == "Enabled") || ((myHash["ZIGBEE"] == "Enabled") && (myHash["USE_SNVMA_NVM"]?number != 0))]
  /* Initialize the Flash Manager module */
  APPE_FLASH_MANAGER_Init();

  /* Disable flash before any use - RFTS */
  FD_SetStatus (FD_FLASHACCESS_RFTS, LL_FLASH_DISABLE);
  /* Enable RFTS Bypass for flash operation - Since LL has not started yet */
  FD_SetStatus (FD_FLASHACCESS_RFTS_BYPASS, LL_FLASH_ENABLE);
  /* Enable flash system flag */
  FD_SetStatus (FD_FLASHACCESS_SYSTEM, LL_FLASH_ENABLE);

[/#if]
  /* USER CODE BEGIN APPE_Init_1 */
[#if PG_FILL_UCS == "True"]
[#if PG_BSP_NUCLEO_WBA52CG == 1]
#if (CFG_LED_SUPPORTED == 1)
  Led_Init();
#endif
#if (CFG_BUTTON_SUPPORTED == 1)
  Button_Init();
#endif
[/#if]
[/#if]

  /* USER CODE END APPE_Init_1 */

[#if (myHash["BLE"] == "Enabled")]
  /* Initialize the Ble Public Key Accelerator module */
  APPE_BPKA_Init();

[#if ((myHash["BLE"] == "Enabled") && (myHash["USE_SNVMA_NVM"]?number != 0)) || ((myHash["ZIGBEE"] == "Enabled") && (myHash["USE_SNVMA_NVM"]?number != 0))]
  /* Initialize the Simple Non Volatile Memory Arbiter */
  if( SNVMA_Init((uint32_t *)CFG_SNVMA_START_ADDRESS) != SNVMA_ERROR_OK )
  {
    Error_Handler();
  }

[/#if]

  APP_BLE_Init();

  /* Disable RFTS Bypass for flash operation - Since LL has not started yet */
  FD_SetStatus (FD_FLASHACCESS_RFTS_BYPASS, LL_FLASH_DISABLE);
[/#if]

[#if (myHash["THREAD"] == "Enabled")]
  /* Thread Initialisation */
  APP_THREAD_Init();
  ll_sys_config_params();
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  /* create a SW timer to wakeup system from low power */
  UTIL_TIMER_Create(&TimerOSwakeup_Id,
                    0,
                    UTIL_TIMER_ONESHOT,
                    &TimerOSwakeupCB, 0);
#if ( CFG_LPM_LEVEL != 0)
  maximumPossibleSuppressedTicks = UINT32_MAX;// TODO check this value
#endif /* ( CFG_LPM_LEVEL != 0) */
[/#if]

[#if ((myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled"))]
[#if (myHash["SEQUENCER_STATUS"]?number == 1)]
  /* Initialization of the low level : link layer and MAC */
  MX_APPE_LinkLayerInit();

[#if (myHash["ZIGBEE"] == "Enabled")]
  /* Initialization of the Zigbee Application */
  APP_ZIGBEE_ApplicationInit();

[/#if]
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled") && (myHash["THREADX_STATUS"]?number == 1)]
  /* Create the Application Startup Thread and this Stack */
  TXstatus = tx_byte_allocate( pBytePool, (VOID**) &pStack, TASK_STACK_SIZE_ZIGBEE_APP_START, TX_NO_WAIT);
  if ( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create( &AppliStartThread, "AppliStart Thread", MX_APPE_InitTask, 0, pStack,
                                       TASK_STACK_SIZE_ZIGBEE_APP_START, TASK_PRIO_ZIGBEE_APP_START, TASK_PREEMP_ZIGBEE_APP_START,
                                       TX_NO_TIME_SLICE, TX_AUTO_START);
  }
  if ( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "ERROR THREADX : APPLICATION START THREAD CREATION FAILED (%d)", TXstatus );
    Error_Handler();
  }
[/#if]
[/#if]


  /* USER CODE BEGIN APPE_Init_2 */

  /* USER CODE END APPE_Init_2 */
  
  APP_DEBUG_SIGNAL_RESET(APP_APPE_INIT);
[/#if]

  return WPAN_SUCCESS;
}

[#if myHash["SEQUENCER_STATUS"]?number == 1 || (myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled")]
void MX_APPE_Process(void)
{
  /* USER CODE BEGIN MX_APPE_Process_1 */

  /* USER CODE END MX_APPE_Process_1 */
[#if myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled"]
  UTIL_SEQ_Run(UTIL_SEQ_DEFAULT);
[#else]
  BLE_Process();
[/#if]
  /* USER CODE BEGIN MX_APPE_Process_2 */

  /* USER CODE END MX_APPE_Process_2 */
}
[/#if]

/* USER CODE BEGIN FD */
[#if PG_FILL_UCS == "True"]
[#if PG_BSP_NUCLEO_WBA52CG == 1]
#if (CFG_BUTTON_SUPPORTED == 1)
/**
 * @brief   Indicate if the selected button was pressedn during a 'long time' or not.
 *
 * @param   btnIdx    Button to test, listed in enum Button_TypeDef
 * @return  '1' if pressed during a 'long time', else '0'.
 */
uint8_t APPE_ButtonIsLongPressed(uint16_t btnIdx)
{
  uint8_t pressStatus;

  if ( btnIdx < BUTTON_NB_MAX )
  {
    pressStatus = buttonDesc[btnIdx].longPressed;
  }
  else
  {
    pressStatus = 0;
  }

  return pressStatus;
}

/**
 * @brief  Action of button 1 when pressed, to be implemented by user.
 * @param  None
 * @retval None
 */
__WEAK void APPE_Button1Action(void)
{
}

/**
 * @brief  Action of button 2 when pressed, to be implemented by user.
 * @param  None
 * @retval None
 */
__WEAK void APPE_Button2Action(void)
{
}

/**
 * @brief  Action of button 3 when pressed, to be implemented by user.
 * @param  None
 * @retval None
 */
__WEAK void APPE_Button3Action(void)
{
}
#endif
[/#if]
[/#if]

/* USER CODE END FD */

/*************************************************************
 *
 * LOCAL FUNCTIONS
 *
 *************************************************************/
[#if myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled"]

/**
 * @brief Configure HSE by read this Tuning from OTP
 *
 */
static void Config_HSE(void)
{
  OTP_Data_s* otp_ptr = NULL;

  /* Read HSE_Tuning from OTP */
  if (OTP_Read(DEFAULT_OTP_IDX, &otp_ptr) != HAL_OK)
  {
    /* OTP no present in flash, apply default gain */
    HAL_RCCEx_HSESetTrimming(0x0C);
  }
  else
  {
    HAL_RCCEx_HSESetTrimming(otp_ptr->hsetune);
  }
}

/**
 *
 */
static void System_Init( void )
{
  /* Clear RCC RESET flag */
  LL_RCC_ClearResetFlags();

  UTIL_TIMER_Init();

  /* Enable wakeup out of standby from RTC ( UTIL_TIMER )*/
  HAL_PWR_EnableWakeUpPin(PWR_WAKEUP_PIN7_HIGH_3);

#if (CFG_LOG_SUPPORTED != 0)
  /* Initialize the logs ( using the USART ) */
  Log_Module_Init( Log_Module_Config );
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
[#else]
  Log_Module_Set_Region( LOG_REGION_APP );
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled")]
  Log_Module_Add_Region( LOG_REGION_ZIGBEE );
[/#if]
[#if (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")]
  Log_Module_Add_Region( LOG_REGION_THREAD );
[/#if]
[/#if]
[#if SerialCommandInterface == "True"]

  /* Initialize the Command Interpreter */
  Serial_CMD_Interpreter_Init();
[/#if]
#endif  /* (CFG_LOG_SUPPORTED != 0) */

[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
  ADCCTRL_Init ();
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */

[/#if]
#if(CFG_RT_DEBUG_DTB == 1)
  /* DTB initialization and configuration */
  RT_DEBUG_DTBInit();
  RT_DEBUG_DTBConfig();
#endif /* CFG_RT_DEBUG_DTB */

[#if ( (myHash["SEQUENCER_STATUS"]?number == 1) || (myHash["FREERTOS_STATUS"]?number == 1) )]

#if ( CFG_LPM_LEVEL != 0)
  system_startup_done = TRUE;
#endif /* ( CFG_LPM_LEVEL != 0) */
[/#if]

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
#if (CFG_SCM_SUPPORTED == 1)
  /* Initialize System Clock Manager */
  scm_init();
#endif /* CFG_SCM_SUPPORTED */

#if (CFG_DEBUGGER_LEVEL == 0)
  /* Pins used by SerialWire Debug are now analog input */
  GPIO_InitTypeDef DbgIOsInit = {0};
  DbgIOsInit.Mode = GPIO_MODE_ANALOG;
  DbgIOsInit.Pull = GPIO_NOPULL;
  DbgIOsInit.Pin = GPIO_PIN_13|GPIO_PIN_14|GPIO_PIN_15;
  __HAL_RCC_GPIOA_CLK_ENABLE();
  HAL_GPIO_Init(GPIOA, &DbgIOsInit);

  DbgIOsInit.Mode = GPIO_MODE_ANALOG;
  DbgIOsInit.Pull = GPIO_NOPULL;
  DbgIOsInit.Pin = GPIO_PIN_3|GPIO_PIN_4;
  __HAL_RCC_GPIOB_CLK_ENABLE();
  HAL_GPIO_Init(GPIOB, &DbgIOsInit);
#endif /* CFG_DEBUGGER_LEVEL */

[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled")]
#if (CFG_SCM_SUPPORTED == 1)
  /* Set the HSE clock to 32MHz */
  scm_setsystemclock(SCM_USER_APP, HSE_32MHZ);
#endif /* CFG_SCM_SUPPORTED */

[/#if]
#if (CFG_LPM_LEVEL != 0)
  /* Initialize low Power Manager. By default enabled */
  UTIL_LPM_Init();

#if (CFG_LPM_STDBY_SUPPORTED == 1)
  /* Enable SRAM1, SRAM2 and RADIO retention*/
  LL_PWR_SetSRAM1SBRetention(LL_PWR_SRAM1_SB_FULL_RETENTION);
  LL_PWR_SetSRAM2SBRetention(LL_PWR_SRAM2_SB_FULL_RETENTION);
  LL_PWR_SetRadioSBRetention(LL_PWR_RADIO_SB_FULL_RETENTION); /* Retain sleep timer configuration */

[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
#else /* (CFG_LPM_STDBY_SUPPORTED == 1) */
  UTIL_LPM_SetOffMode(1U << CFG_LPM_APP, UTIL_LPM_DISABLE);
#endif /* (CFG_LPM_STDBY_SUPPORTED == 1) */
[#else]
#endif /* (CFG_LPM_STDBY_SUPPORTED == 1) */

  /* Disable LowPower during Init */
  UTIL_LPM_SetStopMode(1U << CFG_LPM_APP, UTIL_LPM_DISABLE);
  UTIL_LPM_SetOffMode(1U << CFG_LPM_APP, UTIL_LPM_DISABLE);
[/#if]
#endif /* (CFG_LPM_LEVEL != 0)  */

  /* USER CODE BEGIN SystemPower_Config */

  /* USER CODE END SystemPower_Config */
}
[/#if]

[#if myHash["FREERTOS_STATUS"]?number == 1 ]
static void RNG_Task_Entry(void *argument)
{
  UNUSED(argument);
  
  for(;;)
  {
    osSemaphoreAcquire(RngSemaphore, osWaitForever);
    HW_RNG_Process();
    osThreadYield();
  }
}
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
static void RNG_Task_Entry(ULONG lArgument)
{
  UNUSED(lArgument);

  for(;;)
  {
    tx_semaphore_get( &RngSemaphore, TX_WAIT_FOREVER );
    HW_RNG_Process();
    tx_thread_relinquish();
  }
}
[/#if]

[#if myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled"]
/**
 * @brief Initialize Random Number Generator module
 */
static void APPE_RNG_Init(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  HW_RNG_Start();

  /* Register Random Number Generator task */
  UTIL_SEQ_RegTask(1U << CFG_TASK_HW_RNG, UTIL_SEQ_RFU, (void (*)(void))HW_RNG_Process);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  HW_RNG_Start();

  /* Create Random Number Generator FreeRTOS objects */

  RngTaskHandle = osThreadNew(RNG_Task_Entry, NULL, &RngTask_attributes);

  RngSemaphore = osSemaphoreNew(1U, 0U, &RngSemaphore_attributes);

  if ((RngTaskHandle == NULL) || (RngSemaphore == NULL))
  {
    LOG_ERROR_APP( "RNG FreeRTOS objects creation FAILED");
    Error_Handler();
  }

[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  UINT TXstatus;
  CHAR *pStack;

  HW_RNG_Start();

  /* Create Random Number Generator ThreadX objects */

  TXstatus = tx_byte_allocate(pBytePool, (void **)&pStack, TASK_STACK_SIZE_RNG, TX_NO_WAIT);
  
  if( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create(&RngTaskHandle, "RNG Task", RNG_Task_Entry, 0,
                                 pStack, TASK_STACK_SIZE_RNG,
                                 TASK_PRIO_RNG, TASK_PREEMP_RNG,
                                 TX_NO_TIME_SLICE, TX_AUTO_START);

    TXstatus |= tx_semaphore_create(&RngSemaphore, "RNG Semaphore", 0);
  }
  
  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "RNG ThreadX objects creation FAILED, status: %d", TXstatus);
    Error_Handler();
  }
[/#if]
}
[/#if]

[#if (myHash["BLE"] == "Enabled") || ((myHash["ZIGBEE"] == "Enabled") && (myHash["USE_SNVMA_NVM"]?number != 0))]
/**
 * @brief Initialize Flash Manager module
 */
static void APPE_FLASH_MANAGER_Init(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  /* Register Flash Manager task */
  UTIL_SEQ_RegTask(1U << CFG_TASK_FLASH_MANAGER, UTIL_SEQ_RFU, FM_BackgroundProcess);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  /* Create Flash Manager FreeRTOS objects */

  FlashManagerTaskHandle = osThreadNew(FLASH_Manager_Task_Entry, NULL, &FlashManagerTask_attributes);

  FlashManagerSemaphore = osSemaphoreNew(1U, 0U, &FlashManagerSemaphore_attributes);

  if ((FlashManagerTaskHandle == NULL) || (FlashManagerSemaphore == NULL))
  {
    LOG_ERROR_APP( "FLASH FreeRTOS objects creation FAILED");
    Error_Handler();
  }

[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  UINT TXstatus;
  CHAR *pStack;
  
  /* Create Flash Manager ThreadX objects */
  
  TXstatus = tx_byte_allocate(pBytePool, (void **)&pStack, TASK_STACK_SIZE_FLASH_MANAGER, TX_NO_WAIT);
  
  if( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create(&FlashManagerTaskHandle, "FLASH Manager Task", FLASH_Manager_Task_Entry, 0,
                                 pStack, TASK_STACK_SIZE_FLASH_MANAGER,
                                 TASK_PRIO_FLASH_MANAGER, TASK_PREEMP_FLASH_MANAGER,
                                 TX_NO_TIME_SLICE, TX_AUTO_START);
                                 
    TXstatus |= tx_semaphore_create(&FlashManagerSemaphore, "FLASH Manager Semaphore", 0);
  }
  
  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "FLASH ThreadX objects creation FAILED, status: %d", TXstatus);
    Error_Handler();
  }
[/#if]
}
[/#if]

[#if (myHash["BLE"] == "Enabled")]
/**
 * @brief Initialize Ble Public Key Accelerator module
 */
static void APPE_BPKA_Init(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  /* Register Ble Public Key Accelerator task */
  UTIL_SEQ_RegTask(1U << CFG_TASK_BPKA, UTIL_SEQ_RFU, BPKA_BG_Process);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  /* Create Ble Public Key Accelerator FreeRTOS objects */
  
  BpkaTaskHandle = osThreadNew(BPKA_Task_Entry, NULL, &BpkaTask_attributes);
  
  BpkaSemaphore = osSemaphoreNew(1U, 0U, &BpkaSemaphore_attributes);

  if ((BpkaTaskHandle == NULL) || (BpkaSemaphore == NULL))
  {
    LOG_ERROR_APP( "BPKA FreeRTOS objects creation FAILED");
    Error_Handler();
  }

[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  UINT TXstatus;
  CHAR *pStack;
  
  /* Create Ble Public Key Accelerator ThreadX objects */
  
  TXstatus = tx_byte_allocate(pBytePool, (void **)&pStack, TASK_STACK_SIZE_BPKA, TX_NO_WAIT);
  
  if( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create(&BpkaTaskHandle, "BPKA Task", BPKA_Task_Entry, 0,
                                 pStack, TASK_STACK_SIZE_BPKA,
                                 TASK_PRIO_BPKA, TASK_PREEMP_BPKA,
                                 TX_NO_TIME_SLICE, TX_AUTO_START);
                                 
    TXstatus |= tx_semaphore_create(&BpkaSemaphore, "BPKA Semaphore", 0);
  }
  
  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "BPKA ThreadX objects creation FAILED, status: %d", TXstatus);
    Error_Handler();
  }
[/#if]
}
[/#if]

[#if (myHash["CFG_MM_TYPE"]?number == 2)]
static void APPE_AMM_Init(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  /* Initialize the Advance Memory Manager */
  if( AMM_Init(&ammInitConfig) != AMM_ERROR_OK )
  {
    Error_Handler();
  }

  /* Register Advance Memory Manager task */
  UTIL_SEQ_RegTask(1U << CFG_TASK_AMM, UTIL_SEQ_RFU, AMM_BackgroundProcess);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  /* Initialize the Advance Memory Manager */
  if( AMM_Init(&ammInitConfig) != AMM_ERROR_OK )
  {
    Error_Handler();
  }

  /* Create Advance Memory Manager FreeRTOS objects */

  AmmTaskHandle = osThreadNew(AMM_Task_Entry, NULL, &AmmTask_attributes);

  AmmSemaphore = osSemaphoreNew(1U, 0U, &AmmSemaphore_attributes);
  
  if ((AmmTaskHandle == NULL) || (AmmSemaphore == NULL))
  {
    LOG_ERROR_APP( "AMM FreeRTOS objects creation FAILED");
    Error_Handler();
  }
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  UINT TXstatus;
  CHAR *pStack;

  /* Initialize the Advance Memory Manager */
  if( AMM_Init(&ammInitConfig) != AMM_ERROR_OK )
  {
    Error_Handler();
  }

  /* Create Advance Memory Manager ThreadX objects */

  TXstatus = tx_byte_allocate(pBytePool, (void **)&pStack, TASK_STACK_SIZE_AMM, TX_NO_WAIT);

  if( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create(&AmmTaskHandle, "AMM Task", AMM_Task_Entry, 0,
                                 pStack, TASK_STACK_SIZE_AMM,
                                 TASK_PRIO_AMM, TASK_PREEMP_AMM,
                                 TX_NO_TIME_SLICE, TX_AUTO_START);
                                 
    TXstatus |= tx_semaphore_create(&AmmSemaphore, "AMM Semaphore", 0);
  }

  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "AMM ThreadX objects creation FAILED, status: %d", TXstatus);
    Error_Handler();
  }
[/#if]
}

static void AMM_WrapperInit(uint32_t * const p_PoolAddr, const uint32_t PoolSize)
{
  UTIL_MM_Init ((uint8_t *)p_PoolAddr, ((size_t)PoolSize * sizeof(uint32_t)));
}

static uint32_t * AMM_WrapperAllocate(const uint32_t BufferSize)
{
  return (uint32_t *)UTIL_MM_GetBuffer (((size_t)BufferSize * sizeof(uint32_t)));
}

static void AMM_WrapperFree (uint32_t * const p_BufferAddr)
{
  UTIL_MM_ReleaseBuffer ((void *)p_BufferAddr);
}

[#if myHash["FREERTOS_STATUS"]?number == 1 ]
static void AMM_Task_Entry(void* argument)
{
  UNUSED(argument);

  for(;;)
  {
    osSemaphoreAcquire(AmmSemaphore, osWaitForever);
    AMM_BackgroundProcess();
    osThreadYield();
  }
}
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
static void AMM_Task_Entry(ULONG lArgument)
{
  UNUSED(lArgument);

  for(;;)
  {
    tx_semaphore_get(&AmmSemaphore, TX_WAIT_FOREVER);
    AMM_BackgroundProcess();
    tx_thread_relinquish();
  }
}
[/#if]
[/#if]

[#if (myHash["BLE"] == "Enabled")]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
static void FLASH_Manager_Task_Entry(void* argument)
{
  UNUSED(argument);

  for(;;)
  {
    osSemaphoreAcquire(FlashManagerSemaphore, osWaitForever);
    FM_BackgroundProcess();
    osThreadYield();
  }
}
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
static void FLASH_Manager_Task_Entry(ULONG lArgument)
{
  UNUSED(lArgument);

  for(;;)
  {
    tx_semaphore_get(&FlashManagerSemaphore, TX_WAIT_FOREVER);
    FM_BackgroundProcess();
    tx_thread_relinquish();
  }
}
[/#if]
[/#if]

[#if (myHash["BLE"] == "Enabled")]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
static void BPKA_Task_Entry(void *argument)
{
  UNUSED(argument);

  for(;;)
  {
    osSemaphoreAcquire(BpkaSemaphore, osWaitForever);
    BPKA_BG_Process();
    osThreadYield();
  }
}

[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
static void BPKA_Task_Entry(ULONG lArgument)
{
  UNUSED(lArgument);

  for(;;)
  {
    tx_semaphore_get(&BpkaSemaphore, TX_WAIT_FOREVER);
    BPKA_BG_Process();
    tx_thread_relinquish();
  }
}

[/#if]
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
/* OS tick callback */
static void TimerOStickCB(void *arg)
{
  xPortSysTickHandler();
  /* USER CODE BEGIN TimerOStickCB */

  /* USER CODE END TimerOStickCB */

  return;
}

/* OS wakeup callback */
static void TimerOSwakeupCB(void *arg)
{
  /* USER CODE BEGIN TimerOSwakeupCB */

  /* USER CODE END TimerOSwakeupCB */
  return;
}

#if ( CFG_LPM_LEVEL != 0)
/* return current time since boot, continue to count in standby low power mode */
static uint32_t getCurrentTime(void)
{
  return TIMER_IF_GetTimerValue();
}
#endif /* ( CFG_LPM_LEVEL != 0) */
[/#if]

/* USER CODE BEGIN FD_LOCAL_FUNCTIONS */
[#if PG_FILL_UCS == "True"]
[#if PG_BSP_NUCLEO_WBA52CG == 1]
#if (CFG_LED_SUPPORTED == 1)
static void Led_Init( void )
{
  /* Leds Initialization */
  BSP_LED_Init(LED_BLUE);
  BSP_LED_Init(LED_GREEN);
  BSP_LED_Init(LED_RED);

  BSP_LED_On(LED_GREEN);

  return;
}
#endif

[#if PG_FILL_UCS == "True"]
#if (CFG_BUTTON_SUPPORTED == 1)
static void Button_Init( void )
{
[#if PG_BSP_NUCLEO_WBA52CG == 1]
  /* Button Initialization */
  buttonDesc[B1].button = B1;
  buttonDesc[B2].button = B2;
  buttonDesc[B3].button = B3;
  BSP_PB_Init(B1, BUTTON_MODE_EXTI);
  BSP_PB_Init(B2, BUTTON_MODE_EXTI);
  BSP_PB_Init(B3, BUTTON_MODE_EXTI);

[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  /* Register tasks associated to buttons */
  UTIL_SEQ_RegTask(1U << TASK_BUTTON_1, UTIL_SEQ_RFU, APPE_Button1Action);
  UTIL_SEQ_RegTask(1U << TASK_BUTTON_2, UTIL_SEQ_RFU, APPE_Button2Action);
  UTIL_SEQ_RegTask(1U << TASK_BUTTON_3, UTIL_SEQ_RFU, APPE_Button3Action);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  CHAR * pStack;

  /* Register tasks associated to buttons */
  if (tx_byte_allocate(pBytePool, (void **) &pStack, PB1_BUTTON_PUSHED_TASK_STACK_SIZE,TX_NO_WAIT) != TX_SUCCESS)
  {
    Error_Handler();
  }
  if (tx_semaphore_create(&PB1_BUTTON_PUSHED_Thread_Sem, "PB1_BUTTON_PUSHED_Thread_Sem", 0)!= TX_SUCCESS )
  {
    Error_Handler();
  }
  if (tx_thread_create(&PB1_BUTTON_PUSHED_Thread, "PB1_BUTTON_PUSHED Thread", APPE_Button1Action_Entry, 0,
                         pStack, PB1_BUTTON_PUSHED_TASK_STACK_SIZE,
                         PB1_BUTTON_PUSHED_TASK_PRIO, PB1_BUTTON_PUSHED_TASK_PREEM_TRES,
                         TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
  {
    Error_Handler();
  }

  if (tx_byte_allocate(pBytePool, (void **) &pStack, PB2_BUTTON_PUSHED_TASK_STACK_SIZE,TX_NO_WAIT) != TX_SUCCESS)
  {
    Error_Handler();
  }
  if (tx_semaphore_create(&PB2_BUTTON_PUSHED_Thread_Sem, "PB2_BUTTON_PUSHED_Thread_Sem", 0)!= TX_SUCCESS )
  {
    Error_Handler();
  }
  if (tx_thread_create(&PB2_BUTTON_PUSHED_Thread, "PB2_BUTTON_PUSHED Thread", APPE_Button2Action_Entry, 0,
                         pStack, PB2_BUTTON_PUSHED_TASK_STACK_SIZE,
                         PB2_BUTTON_PUSHED_TASK_PRIO, PB2_BUTTON_PUSHED_TASK_PREEM_TRES,
                         TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
  {
    Error_Handler();
  }

  if (tx_byte_allocate(pBytePool, (void **) &pStack, PB3_BUTTON_PUSHED_TASK_STACK_SIZE,TX_NO_WAIT) != TX_SUCCESS)
  {
    Error_Handler();
  }
  if (tx_semaphore_create(&PB3_BUTTON_PUSHED_Thread_Sem, "PB3_BUTTON_PUSHED_Thread_Sem", 0)!= TX_SUCCESS )
  {
    Error_Handler();
  }
  if (tx_thread_create(&PB3_BUTTON_PUSHED_Thread, "PB3_BUTTON_PUSHED Thread", APPE_Button3Action_Entry, 0,
                         pStack, PB3_BUTTON_PUSHED_TASK_STACK_SIZE,
                         PB3_BUTTON_PUSHED_TASK_PRIO, PB3_BUTTON_PUSHED_TASK_PREEM_TRES,
                         TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
  {
    Error_Handler();
  }
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
[/#if]

  /* Create timers to detect button long press (one for each button) */
  Button_TypeDef buttonIndex;
  for ( buttonIndex = B1; buttonIndex < BUTTON_NB_MAX; buttonIndex++ )
  {
    UTIL_TIMER_Create( &buttonDesc[buttonIndex].longTimerId,
                       0,
                       UTIL_TIMER_ONESHOT,
                       &Button_TriggerActions,
                       &buttonDesc[buttonIndex] );
  }
[/#if]

  return;
}

[#if PG_BSP_NUCLEO_WBA52CG == 1]
static void Button_TriggerActions(void *arg)
{
  ButtonDesc_t *p_buttonDesc = arg;

  p_buttonDesc->longPressed = BSP_PB_GetState(p_buttonDesc->button);

  LOG_INFO_APP("Button %d pressed\n", (p_buttonDesc->button + 1));
  switch (p_buttonDesc->button)
  {
    case B1:
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
      UTIL_SEQ_SetTask(1U << TASK_BUTTON_1, CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
[/#if]
      break;
    case B2:
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
      UTIL_SEQ_SetTask(1U << TASK_BUTTON_2, CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
[/#if]
      break;
    case B3:
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
      UTIL_SEQ_SetTask(1U << TASK_BUTTON_3, CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
[/#if]
      break;
    default:
      break;
  }

  return;
}
[/#if]

#endif
[/#if]
[/#if]
[/#if]

/* USER CODE END FD_LOCAL_FUNCTIONS */

/*************************************************************
 *
 * WRAP FUNCTIONS
 *
 *************************************************************/

[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
[#if (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")]
void UTIL_SEQ_EvtIdle( UTIL_SEQ_bm_t task_id_bm, UTIL_SEQ_bm_t evt_waited_bm )
{
  UTIL_SEQ_Run( UTIL_SEQ_DEFAULT );

  return;
}

[/#if]
void UTIL_SEQ_Idle( void )
{
#if ( CFG_LPM_LEVEL != 0)
  HAL_SuspendTick();
  UTIL_LPM_EnterLowPower();
  HAL_ResumeTick();
#endif /* CFG_LPM_LEVEL */
  return;
}

void UTIL_SEQ_PreIdle( void )
{
  /* USER CODE BEGIN UTIL_SEQ_PreIdle_1 */

  /* USER CODE END UTIL_SEQ_PreIdle_1 */
#if ( CFG_LPM_LEVEL != 0)
  LL_PWR_ClearFlag_STOP();

  if ( ( system_startup_done != FALSE ) && ( UTIL_LPM_GetMode() == UTIL_LPM_OFFMODE ) )
  {
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
    APP_SYS_BLE_EnterDeepSleep();
[#else]
    APP_SYS_LPM_EnterLowPowerMode();
[/#if]
  }

  LL_RCC_ClearResetFlags();

[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled")]
  /* Wait until System clock is not on HSI */
  while (LL_RCC_GetSysClkSource() == LL_RCC_SYS_CLKSOURCE_STATUS_HSI);

[/#if]
#if defined(STM32WBAXX_SI_CUT1_0)
  /* Wait until HSE is ready */
  while (LL_RCC_HSE_IsReady() == 0);

  UTILS_ENTER_LIMITED_CRITICAL_SECTION(RCC_INTR_PRIO << 4U);
  scm_hserdy_isr();
  UTILS_EXIT_LIMITED_CRITICAL_SECTION();
#endif /* STM32WBAXX_SI_CUT1_0 */
#endif /* CFG_LPM_LEVEL */
  /* USER CODE BEGIN UTIL_SEQ_PreIdle_2 */

  /* USER CODE END UTIL_SEQ_PreIdle_2 */
  return;
}

void UTIL_SEQ_PostIdle( void )
{
  /* USER CODE BEGIN UTIL_SEQ_PostIdle_1 */

  /* USER CODE END UTIL_SEQ_PostIdle_1 */
#if ( CFG_LPM_LEVEL != 0)
  LL_AHB5_GRP1_EnableClock(LL_AHB5_GRP1_PERIPH_RADIO);
  ll_sys_dp_slp_exit();
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
  UTIL_LPM_SetOffMode(1U << CFG_LPM_LL_DEEPSLEEP, UTIL_LPM_ENABLE);
[/#if]
#endif /* CFG_LPM_LEVEL */
  /* USER CODE BEGIN UTIL_SEQ_PostIdle_2 */

  /* USER CODE END UTIL_SEQ_PostIdle_2 */
  return;
}

[/#if]
[#if (myHash["BLE"] == "Enabled")]
void BPKACB_Process( void )
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_BPKA, CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_put(&BpkaSemaphore);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
  osSemaphoreRelease(BpkaSemaphore);
[/#if]
}

[/#if]

[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
/**
 * @brief Callback used by Random Number Generator to launch Task to generate Random Numbers
 */
void HWCB_RNG_Process( void )
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_HW_RNG, TASK_PRIO_RNG);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  osSemaphoreRelease(RngSemaphore);
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
  tx_semaphore_put(&RngSemaphore);
[#else]
  if (RngSemaphore.tx_semaphore_count == 0)
  {
    tx_semaphore_put(&RngSemaphore);
  }
[/#if]
[/#if]
}
[/#if]

[#if (myHash["CFG_MM_TYPE"]?number == 2)]
void AMM_RegisterBasicMemoryManager (AMM_BasicMemoryManagerFunctions_t * const p_BasicMemoryManagerFunctions)
{
  /* Fulfill the function handle */
  p_BasicMemoryManagerFunctions->Init = AMM_WrapperInit;
  p_BasicMemoryManagerFunctions->Allocate = AMM_WrapperAllocate;
  p_BasicMemoryManagerFunctions->Free = AMM_WrapperFree;
}

void AMM_ProcessRequest(void)
{
  /* Trigger to call Advance Memory Manager process function */
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_AMM, CFG_SEQ_PRIO_0);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  osSemaphoreRelease(AmmSemaphore);
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_put(&AmmSemaphore);
[/#if]
}

[/#if]
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || ((myHash["ZIGBEE"] == "Enabled") && (myHash["USE_SNVMA_NVM"]?number != 0))]
void FM_ProcessRequest(void)
{
  /* Trigger to call Flash Manager process function */
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_FLASH_MANAGER, CFG_SEQ_PRIO_0);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  osSemaphoreRelease(FlashManagerSemaphore);
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_put(&FlashManagerSemaphore);
[/#if]
}

[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled")]
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
#if ((CFG_LOG_SUPPORTED == 0) && (CFG_LPM_LEVEL != 0))
/* RNG module turn off HSI clock when traces are not used and low power used */
void RNG_KERNEL_CLK_OFF(void)
{
  /* USER CODE BEGIN RNG_KERNEL_CLK_OFF_1 */

  /* USER CODE END RNG_KERNEL_CLK_OFF_1 */
  LL_RCC_HSI_Disable();
  /* USER CODE BEGIN RNG_KERNEL_CLK_OFF_2 */

  /* USER CODE END RNG_KERNEL_CLK_OFF_2 */
}

/* SCM module turn off HSI clock when traces are not used and low power used */
void SCM_HSI_CLK_OFF(void)
{
  /* USER CODE BEGIN SCM_HSI_CLK_OFF_1 */

  /* USER CODE END SCM_HSI_CLK_OFF_1 */
  LL_RCC_HSI_Disable();
  /* USER CODE BEGIN SCM_HSI_CLK_OFF_2 */

  /* USER CODE END SCM_HSI_CLK_OFF_2 */
}
#endif /* ((CFG_LOG_SUPPORTED == 0) && (CFG_LPM_LEVEL != 0)) */

#if (CFG_LOG_SUPPORTED != 0)
void UTIL_ADV_TRACE_PreSendHook(void)
{
#if (CFG_LPM_LEVEL != 0)
  /* Disable Stop mode before sending a LOG message over UART */
  UTIL_LPM_SetStopMode(1U << CFG_LPM_LOG, UTIL_LPM_DISABLE);
#endif /* (CFG_LPM_LEVEL != 0) */
  /* USER CODE BEGIN UTIL_ADV_TRACE_PreSendHook */

  /* USER CODE END UTIL_ADV_TRACE_PreSendHook */
}

void UTIL_ADV_TRACE_PostSendHook(void)
{
#if (CFG_LPM_LEVEL != 0)
  /* Enable Stop mode after LOG message over UART sent */
  UTIL_LPM_SetStopMode(1U << CFG_LPM_LOG, UTIL_LPM_ENABLE);
#endif /* (CFG_LPM_LEVEL != 0) */
  /* USER CODE BEGIN UTIL_ADV_TRACE_PostSendHook */

  /* USER CODE END UTIL_ADV_TRACE_PostSendHook */
}

#endif /* (CFG_LOG_SUPPORTED != 0) */
[/#if]
[/#if]

[#if myHash["THREADX_STATUS"]?number == 1 ]
/**
 * @brief   Enter in LowPower Mode after a ThreadX call
 */
void ThreadXLowPowerUserEnter( void )
{
  /* USER CODE BEGIN ThreadXLowPowerUserEnter_1 */

  /* USER CODE END ThreadXLowPowerUserEnter_1 */

#if ( CFG_LPM_LEVEL != 0 )
  LL_PWR_ClearFlag_STOP();

  LL_RCC_ClearResetFlags();

  /* Wait until HSE is ready */
  while ( LL_RCC_HSE_IsReady() == 0 );

  UTILS_ENTER_LIMITED_CRITICAL_SECTION( RCC_INTR_PRIO << 4U );
  scm_hserdy_isr();
  UTILS_EXIT_LIMITED_CRITICAL_SECTION();
  HAL_SuspendTick();

  /* Disable SysTick Interrupt */
  SysTick->CTRL &= ~SysTick_CTRL_TICKINT_Msk;
  UTIL_LPM_EnterLowPower();
#endif /* CFG_LPM_LEVEL */

  /* USER CODE BEGIN ThreadXLowPowerUserEnter_2 */

  /* USER CODE END ThreadXLowPowerUserEnter_2 */
  return;
}

/**
 * @brief   Exit of LowPower Mode after a ThreadX call
 */
void ThreadXLowPowerUserExit( void )
{
  /* USER CODE BEGIN ThreadXLowPowerUserExit_1 */

  /* USER CODE END ThreadXLowPowerUserExit_1 */

#if ( CFG_LPM_LEVEL != 0 )
  HAL_ResumeTick();

  /* Enable SysTick Interrupt */
  SysTick->CTRL |= SysTick_CTRL_TICKINT_Msk;
  LL_AHB5_GRP1_EnableClock( LL_AHB5_GRP1_PERIPH_RADIO );
  ll_sys_dp_slp_exit();
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
  UTIL_LPM_SetOffMode(1U << CFG_LPM_LL_DEEPSLEEP, UTIL_LPM_ENABLE);
[/#if]
#endif /* CFG_LPM_LEVEL */

  /* USER CODE BEGIN ThreadXLowPowerUserExit_2 */

  /* USER CODE END ThreadXLowPowerUserExit_2 */
  return;
}

[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
/* Implement weak function to setup a timer that will trig OS ticks */
void vPortSetupTimerInterrupt( void )
{
  UTIL_TIMER_Create(&TimerOStick_Id,
                    portTICK_PERIOD_MS,
                    UTIL_TIMER_PERIODIC,
                    &TimerOStickCB, 0);

  UTIL_TIMER_StartWithPeriod(&TimerOStick_Id, portTICK_PERIOD_MS);
  /* USER CODE BEGIN vPortSetupTimerInterrupt */

  /* USER CODE END vPortSetupTimerInterrupt */
  return;
}
#if ( CFG_LPM_LEVEL != 0)
void vPortSuppressTicksAndSleep( uint32_t xExpectedIdleTime )
{
  uint32_t lowPowerTimeBeforeSleep, lowPowerTimeAfterSleep;
  eSleepModeStatus eSleepStatus;

  /* Stop the timer that is generating the OS tick interrupt. */
  UTIL_TIMER_Stop(&TimerOStick_Id);


  /* Make sure the SysTick reload value does not overflow the counter. */
  if( xExpectedIdleTime > maximumPossibleSuppressedTicks )
  {
    xExpectedIdleTime = maximumPossibleSuppressedTicks;
  }

  /* Enter a critical section but don't use the taskENTER_CRITICAL()
   * method as that will mask interrupts that should exit sleep mode. */
  __asm volatile ( "cpsid i" ::: "memory" );
  __asm volatile ( "dsb" );
  __asm volatile ( "isb" );

  eSleepStatus = eTaskConfirmSleepModeStatus();

  /* If a context switch is pending or a task is waiting for the scheduler
   * to be unsuspended then abandon the low power entry. */
  if( eSleepStatus == eAbortSleep )
  {
    /* Restart the timer that is generating the OS tick interrupt. */
    UTIL_TIMER_StartWithPeriod(&TimerOStick_Id, portTICK_PERIOD_MS);

    /* Re-enable interrupts - see comments above the cpsid instruction above. */
    __asm volatile ( "cpsie i" ::: "memory" );
  }
  else
  {
    if( eSleepStatus != eNoTasksWaitingTimeout )
    {
      /* Configure an interrupt to bring the microcontroller out of its low
         power state at the time the kernel next needs to execute. The
         interrupt must be generated from a source that remains operational
         when the microcontroller is in a low power state. */
      UTIL_TIMER_StartWithPeriod(&TimerOSwakeup_Id, (xExpectedIdleTime - 1) * portTICK_PERIOD_MS);
    }

    /* Read the current time from RTC, maintainned in standby */
    lowPowerTimeBeforeSleep = getCurrentTime();

    /* Enter the low power state. */
      
    LL_PWR_ClearFlag_STOP();
    if ( ( system_startup_done != FALSE ) && ( UTIL_LPM_GetMode() == UTIL_LPM_OFFMODE ) )
    {
      APP_SYS_BLE_EnterDeepSleep();
    }
    
    LL_RCC_ClearResetFlags();/* TODO check if its necessary -----------------------------------------------------*/

    UTIL_LPM_EnterLowPower(); /* WFI instruction call is inside this API */
    
    /* Stop the timer that may wakeup us as wakeup source can be another one */
    UTIL_TIMER_Stop(&TimerOSwakeup_Id);

    /* Determine how long the microcontroller was actually in a low power
     state for, which will be less than xExpectedIdleTime if the
     microcontroller was brought out of low power mode by an interrupt
     other than that configured by the vSetWakeTimeInterrupt() call.
     Note that the scheduler is suspended before
     portSUPPRESS_TICKS_AND_SLEEP() is called, and resumed when
     portSUPPRESS_TICKS_AND_SLEEP() returns.  Therefore no other tasks will
     execute until this function completes. */
    lowPowerTimeAfterSleep = getCurrentTime();

    /* Correct the kernel tick count to account for the time spent in its low power state. */
    vTaskStepTick( TIMER_IF_Convert_Tick2ms(lowPowerTimeAfterSleep - lowPowerTimeBeforeSleep) / portTICK_PERIOD_MS );

    /* Re-enable interrupts to allow the interrupt that brought the MCU
     * out of sleep mode to execute immediately.  See comments above
     * the cpsid instruction above. */
    __asm volatile ( "cpsie i" ::: "memory" );
    __asm volatile ( "dsb" );
    __asm volatile ( "isb" );
    
    /* Put the radio in active state */
    if ( ( system_startup_done != FALSE ) && ( UTIL_LPM_GetMode() == UTIL_LPM_OFFMODE ) )
    {
      LL_AHB5_GRP1_EnableClock(LL_AHB5_GRP1_PERIPH_RADIO);
      ll_sys_dp_slp_exit();
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
      UTIL_LPM_SetOffMode(1U << CFG_LPM_LL_DEEPSLEEP, UTIL_LPM_ENABLE);
[/#if]
    }

    /* Restart the timer that is generating the OS tick interrupt. */
    UTIL_TIMER_StartWithPeriod(&TimerOStick_Id, portTICK_PERIOD_MS);
  }
  return;
}
#else
void vPortSuppressTicksAndSleep( uint32_t xExpectedIdleTime )
{
  return;
}
#endif /* ( CFG_LPM_LEVEL != 0) */

[/#if]
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")]
/**
 * @brief Function Assert AEABI in case of not described on 'libc' libraries.
 */
__WEAK void __aeabi_assert(const char * szExpression, const char * szFile, int iLine)
{
  Error_Handler();
}

[/#if]
/* USER CODE BEGIN FD_WRAP_FUNCTIONS */
[#if PG_FILL_UCS == "True"]
[#if PG_BSP_NUCLEO_WBA52CG == 1]
#if (CFG_BUTTON_SUPPORTED == 1)
void BSP_PB_Callback(Button_TypeDef Button)
{
  buttonDesc[Button].longPressed = 0;
  UTIL_TIMER_StartWithPeriod(&buttonDesc[Button].longTimerId, BUTTON_LONG_PRESS_THRESHOLD_MS);

  return;
}
#endif
[/#if]
[/#if]

/* USER CODE END FD_WRAP_FUNCTIONS */
