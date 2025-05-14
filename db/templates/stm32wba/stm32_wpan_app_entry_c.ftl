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
#include "app_common.h"
#include "app_conf.h"
#include "main.h"
[#if myHash["ZIGBEE"] == "Enabled"]
#include "app_zigbee.h"
[/#if]
#include "app_entry.h"
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
[#else]
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
#include "stm32_seq.h"
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
#include "app_threadx.h"
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
#include "cmsis_os.h"
[/#if]
[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
#include "stm_list.h"
[/#if]
#if (CFG_LPM_LEVEL != 0)
[#if myHash["ZIGBEE"] == "Enabled" || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
#include "app_sys.h"
[/#if]
#include "stm32_lpm.h"
#endif /* (CFG_LPM_LEVEL != 0) */
#include "stm32_timer.h"
[#if !((myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled"))]
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
#include "ll_sys_if.h"
[/#if]
[#if myHash["THREAD"] == "Enabled" ]
#include "app_thread.h"
[/#if]
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
#include "app_sys.h"
[/#if]
#include "otp.h"
#include "scm.h"
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
#include "bpka.h"
#include "ll_sys.h"
#include "advanced_memory_manager.h"
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
#include "flash_driver.h"
#include "flash_manager.h"
#include "simple_nvm_arbiter.h"
[/#if]
#include "app_debug.h"
[/#if]
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
#include "adc_ctrl.h"
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
#include "stm32_rtos.h"
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
#include "stm32wbaxx_ll_rcc.h"
[/#if]
[#if (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")]
#include "ll_sys.h"
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
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
/* Heap size for System (used by Low-Layers) */
#define C_SYS_MEMORY_HEAP_SIZE_BYTES          60000U

[/#if]
[#if (myHash["BLE"] == "Enabled")]
[#if myHash["THREADX_STATUS"]?number == 1 ]
/* AMM_BCKGND_TASK related defines */
#define AMM_BCKGND_TASK_STACK_SIZE    (256*7)
#define AMM_BCKGND_TASK_PRIO          (15)
#define AMM_BCKGND_TASK_PREEM_TRES    (0)

[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
/* BPKA_TASK related defines */
#define BPKA_TASK_STACK_SIZE    (256*7)
#define BPKA_TASK_PRIO          (15)
#define BPKA_TASK_PREEM_TRES    (0)

[/#if]
/* HW_RNG_TASK related defines */
#define HW_RNG_TASK_STACK_SIZE    (256*7)
#define HW_RNG_TASK_PRIO          (15)
#define HW_RNG_TASK_PREEM_TRES    (0)

/* FLASH_MANAGER_BCKGND_TASK related defines */
#define FLASH_MANAGER_BCKGND_TASK_STACK_SIZE    (256*7)
#define FLASH_MANAGER_BCKGND_TASK_PRIO          (15)
#define FLASH_MANAGER_BCKGND_TASK_PREEM_TRES    (0)

[/#if]
[/#if]
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
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled")]
static uint8_t        SYS_MEMORY_HEAP[C_SYS_MEMORY_HEAP_SIZE_BYTES];

[/#if]
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
#if ( CFG_LPM_LEVEL != 0)
static bool system_startup_done = FALSE;
#endif /* ( CFG_LPM_LEVEL != 0) */

[/#if]
#if (CFG_LOG_SUPPORTED != 0)
/* Log configuration */
static Log_Module_t Log_Module_Config = { .verbose_level = APPLI_CONFIG_LOG_LEVEL, .region = LOG_REGION_ALL_REGIONS };
#endif /* (CFG_LOG_SUPPORTED != 0) */

[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
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

[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
/* AMM_BCKGND_TASK related resources */
TX_THREAD AMM_BCKGND_Thread;
TX_SEMAPHORE AMM_BCKGND_Thread_Sem;

/* BPKA_TASK related resources */
TX_THREAD BPKA_Thread;
TX_SEMAPHORE BPKA_Thread_Sem;

[/#if]
/* HW_RNG_TASK related resources */
TX_THREAD HW_RNG_Thread;
TX_SEMAPHORE HW_RNG_Thread_Sem;

/* FLASH_MANAGER_BCKGND_TASK related resources */
TX_THREAD FLASH_MANAGER_BCKGND_Thread;
TX_SEMAPHORE FLASH_MANAGER_BCKGND_Thread_Sem;

[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
TX_SEMAPHORE          AppliStartEndSemaphore, HwRngSemaphore;
TX_THREAD             AppliStartThread, HwRngThread;

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
static void Config_HSE(void);
static void RNG_Init( void );
static void System_Init( void );
static void SystemPower_Config( void );
[#if myHash["THREADX_STATUS"]?number == 1 ]

#ifndef TX_LOW_POWER_USER_ENTER
void ThreadXLowPowerUserEnter( void );
#endif
#ifndef TX_LOW_POWER_USER_EXIT
void ThreadXLowPowerUserExit( void );
#endif
[/#if]

[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
/**
 * @brief Wrapper for init function of the MM for the AMM
 *
 * @param p_PoolAddr: Address of the pool to use - Not use -
 * @param PoolSize: Size of the pool - Not use -
 *
 * @return None
 */
static void AMM_WrapperInit (uint32_t * const p_PoolAddr, const uint32_t PoolSize);

/**
 * @brief Wrapper for allocate function of the MM for the AMM
 *
 * @param BufferSize
 *
 * @return Allocated buffer
 */
static uint32_t * AMM_WrapperAllocate (const uint32_t BufferSize);

/**
 * @brief Wrapper for free function of the MM for the AMM
 *
 * @param p_BufferAddr
 *
 * @return None
 */
static void AMM_WrapperFree (uint32_t * const p_BufferAddr);

[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
static void BPKA_BG_Process_Entry(unsigned long thread_input);
[/#if]
static void AMM_BackgroundProcess_Entry(unsigned long thread_input);
static void FM_BackgroundProcess_Entry(unsigned long thread_input);
[/#if]
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
 * @brief   System Initialisation.
 */
void MX_APPE_Config(void)
{
  /* Configure HSE Tuning */
  Config_HSE();
}

[#if myHash["ZIGBEE"] == "Enabled" || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
/**
 *
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

  RNG_Init();

  /* Initialization of the low level : link layer and MAC */
  MX_APPE_LinkLayerInit();

  /* Initialization of the Zigbee Application */
  APP_ZIGBEE_ApplicationInit();
  
  /* USER CODE BEGIN APPE_Init_Task_2 */
  /* USER CODE END APPE_Init_Task_2 */
  
  /* Wait unlimited */
  tx_semaphore_get( &AppliStartEndSemaphore, TX_WAIT_FOREVER );
}

[/#if]
[/#if]
/**
 * @brief   System Initialisation.
 */
uint32_t MX_APPE_Init(void *p_param)
{
[#if (myHash["THREADX_STATUS"]?number == 1) && !(myHash["BLE"] == "Enabled")]
  UINT        ThreadXStatus;

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

[#if (myHash["BLE"] == "Enabled")]
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
  /* Initialize the Advance Memory Manager */
  AMM_Init (&ammInitConfig);

  /* Register the AMM background task */
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_RegTask(1U << CFG_TASK_AMM_BCKGND, UTIL_SEQ_RFU, AMM_BackgroundProcess);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  if (tx_byte_allocate(pBytePool, (void **) &pStack, AMM_BCKGND_TASK_STACK_SIZE,TX_NO_WAIT) != TX_SUCCESS)
  {
    Error_Handler();
  }
  if (tx_semaphore_create(&AMM_BCKGND_Thread_Sem, "AMM_BCKGND_Thread_Sem", 0)!= TX_SUCCESS )
  {
    Error_Handler();
  }
  if (tx_thread_create(&AMM_BCKGND_Thread, "AMM_BCKGND Thread", AMM_BackgroundProcess_Entry, 0,
                         pStack, AMM_BCKGND_TASK_STACK_SIZE,
                         AMM_BCKGND_TASK_PRIO, AMM_BCKGND_TASK_PREEM_TRES,
                         TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
  {
    Error_Handler();
  }
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

[/#if]
[/#if]
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
  /* Initialize the Simple NVM Arbiter */
  SNVMA_Init ((uint32_t *)CFG_SNVMA_START_ADDRESS);

[/#if]
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
  /* Register the flash manager task */
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_RegTask(1U << CFG_TASK_FLASH_MANAGER_BCKGND, UTIL_SEQ_RFU, FM_BackgroundProcess);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  if (tx_byte_allocate(pBytePool, (void **) &pStack, FLASH_MANAGER_BCKGND_TASK_STACK_SIZE,TX_NO_WAIT) != TX_SUCCESS)
  {
    Error_Handler();
  }
  if (tx_semaphore_create(&FLASH_MANAGER_BCKGND_Thread_Sem, "FLASH_MANAGER_BCKGND_Thread_Sem", 0)!= TX_SUCCESS )
  {
    Error_Handler();
  }
  if (tx_thread_create(&FLASH_MANAGER_BCKGND_Thread, "FLASH_MANAGER_BCKGND Thread", FM_BackgroundProcess_Entry, 0,
                         pStack, FLASH_MANAGER_BCKGND_TASK_STACK_SIZE,
                         FLASH_MANAGER_BCKGND_TASK_PRIO, FLASH_MANAGER_BCKGND_TASK_PREEM_TRES,
                         TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
  {
    Error_Handler();
  }
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

[/#if]
[/#if]
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
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_RegTask(1U << CFG_TASK_BPKA, UTIL_SEQ_RFU, BPKA_BG_Process);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  if (tx_byte_allocate(pBytePool, (void **) &pStack, BPKA_TASK_STACK_SIZE,TX_NO_WAIT) != TX_SUCCESS)
  {
    Error_Handler();
  }
  if (tx_semaphore_create(&BPKA_Thread_Sem, "BPKA_Thread_Sem", 0)!= TX_SUCCESS )
  {
    Error_Handler();
  }
  if (tx_thread_create(&BPKA_Thread, "BPKA Thread", BPKA_BG_Process_Entry, 0,
                         pStack, BPKA_TASK_STACK_SIZE,
                         BPKA_TASK_PRIO, BPKA_TASK_PREEM_TRES,
                         TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
  {
    Error_Handler();
  }
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

[/#if]

  BPKA_Reset( );

  RNG_Init();
[/#if]

[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
  /* Disable flash before any use - RFTS */
  FD_SetStatus (FD_FLASHACCESS_RFTS, LL_FLASH_DISABLE);
  /* Enable RFTS Bypass for flash operation - Since LL has not started yet */
  FD_SetStatus (FD_FLASHACCESS_RFTS_BYPASS, LL_FLASH_ENABLE);
  /* Enable flash system flag */
  FD_SetStatus (FD_FLASHACCESS_SYSTEM, LL_FLASH_ENABLE);

[/#if]
[#if myHash["BLE"] == "Enabled"]
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  if (tx_semaphore_create(&PROC_GAP_COMPLETE_Sem, "PROC_GAP_COMPLETE_Sem", 0) != TX_SUCCESS )
  {
    Error_Handler();
  }
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
[/#if]
  APP_BLE_Init();
[/#if]
[#if (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")]
  RNG_Init();

[#if (myHash["THREAD"] == "Enabled")]
  /* Thread Initialisation */
  APP_THREAD_Init();
  ll_sys_config_params();

[/#if]
[/#if]
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
  /* Disable RFTS Bypass for flash operation - Since LL has not started yet */
  FD_SetStatus (FD_FLASHACCESS_RFTS_BYPASS, LL_FLASH_DISABLE);

[/#if]
[#if ((myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")) && (myHash["SEQUENCER_STATUS"]?number == 1)]
  RNG_Init();
  
  /* Initialization of the low level : link layer and MAC */
  MX_APPE_LinkLayerInit();

[#if (myHash["ZIGBEE"] == "Enabled")]
  /* Initialization of the Zigbee Application */
  APP_ZIGBEE_ApplicationInit();

[/#if]
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled") && (myHash["THREADX_STATUS"]?number == 1)]
  /* Register Semaphore to Stop the Application Startup */
  ThreadXStatus = tx_semaphore_create( &AppliStartEndSemaphore, "AppliStart Semaphore", 0 );

  /* Create the Application Startup Thread and this Stack */
  ThreadXStatus |= tx_byte_allocate( pBytePool, (VOID**) &pStack, TASK_ZIGBEE_APP_START_STACK_SIZE, TX_NO_WAIT);
  if ( ThreadXStatus == TX_SUCCESS )
  {
    ThreadXStatus = tx_thread_create( &AppliStartThread, "AppliStart Thread", MX_APPE_InitTask, 0, pStack,
                                       TASK_ZIGBEE_APP_START_STACK_SIZE, CFG_TASK_PRIO_ZIGBEE_APP_START, CFG_TASK_PREEMP_ZIGBEE_APP_START,
                                       TX_NO_TIME_SLICE, TX_AUTO_START);
  }
  if ( ThreadXStatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "ERROR THREADX : APPLICATION START THREAD CREATION FAILED (%d)", ThreadXStatus );
    Error_Handler();
  }

[#else]
  /* USER CODE BEGIN APPE_Init_2 */

  /* USER CODE END APPE_Init_2 */
[/#if]
  APP_DEBUG_SIGNAL_RESET(APP_APPE_INIT);
  return WPAN_SUCCESS;
}

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
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled")]
  /* Initialize System Heap used by Zigbee Stack */
  UTIL_MM_Init( SYS_MEMORY_HEAP, C_SYS_MEMORY_HEAP_SIZE_BYTES );

[/#if]
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
[#if SerialCommandInterface == "True" ]

  /* Initialize the Command Interpreter */
  Serial_CMD_Interpreter_Init();
[/#if]
#endif  /* (CFG_LOG_SUPPORTED != 0) */
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]

#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
  adc_ctrl_init();
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
[/#if]
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]

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
  HAL_GPIO_Init(GPIOA, &DbgIOsInit);

  DbgIOsInit.Mode = GPIO_MODE_ANALOG;
  DbgIOsInit.Pull = GPIO_NOPULL;
  DbgIOsInit.Pin = GPIO_PIN_3|GPIO_PIN_4;
  HAL_GPIO_Init(GPIOB, &DbgIOsInit);
#endif /* CFG_DEBUGGER_LEVEL */

[#if McuName?starts_with("STM32WBA55")]
  /* Configure Vcore supply */
  if ( HAL_PWREx_ConfigSupply( CFG_CORE_SUPPLY ) != HAL_OK )
  {
    Error_Handler();
  }

[/#if]
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
}

[#if myHash["THREADX_STATUS"]?number == 1 ]
static void HW_RNG_Process_Task( ULONG lArgument )
{
  UNUSED( lArgument );

  for(;;)
  {
[#if (myHash["BLE"] == "Enabled")]
    tx_semaphore_get(&HW_RNG_Thread_Sem, TX_WAIT_FOREVER);
    tx_mutex_get(&LinkLayerMutex, TX_WAIT_FOREVER);
    HW_RNG_Process();
    tx_mutex_put(&LinkLayerMutex);
    tx_thread_relinquish();
[#else]
    tx_semaphore_get( &HwRngSemaphore, TX_WAIT_FOREVER );
    HW_RNG_Process();
[/#if]
  }
}
[/#if]

/**
 * @brief Initialize Random Number Generator module
 */
static void RNG_Init(void)
{
[#if (myHash["THREADX_STATUS"]?number == 1) && !(myHash["BLE"] == "Enabled")]
  UINT        ThreadXStatus;

[/#if]
  HW_RNG_Start();

[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_RegTask(1U << CFG_TASK_HW_RNG, UTIL_SEQ_RFU, (void (*)(void))HW_RNG_Process);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
[#if (myHash["BLE"] == "Enabled")]
  if (tx_byte_allocate(pBytePool, (void **) &pStack, HW_RNG_TASK_STACK_SIZE,TX_NO_WAIT) != TX_SUCCESS)
  {
    Error_Handler();
  }
  if (tx_semaphore_create(&HW_RNG_Thread_Sem, "HW_RNG_Thread_Sem", 0)!= TX_SUCCESS )
  {
    Error_Handler();
  }
  if (tx_thread_create(&HW_RNG_Thread, "HW_RNG Thread", HW_RNG_Process_Task, 0,
                         pStack, HW_RNG_TASK_STACK_SIZE,
                         HW_RNG_TASK_PRIO, HW_RNG_TASK_PREEM_TRES,
                         TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
  {
    Error_Handler();
  }

  return;
[#else]  
  /* Register Semaphore to launch the Random Process */
  ThreadXStatus = tx_semaphore_create( &HwRngSemaphore, "RandomProcess Semaphore", 0 );
  
  /* Create the Random Process Thread and this Stack */
  if ( ThreadXStatus == TX_SUCCESS )
  {
    ThreadXStatus |= tx_byte_allocate( pBytePool, (VOID**) &pStack, TASK_HW_RNG_STACK_SIZE, TX_NO_WAIT);
  }
  if ( ThreadXStatus == TX_SUCCESS )
  {
    ThreadXStatus |= tx_thread_create( &HwRngThread, "RandomProcess Thread", HW_RNG_Process_Task, 0, pStack,
                                       TASK_HW_RNG_STACK_SIZE, CFG_TASK_PRIO_HW_RNG, CFG_TASK_PREEMP_HW_RNG,
                                       TX_NO_TIME_SLICE, TX_AUTO_START);
  }
  
  /* Verify if it's OK */
  if ( ThreadXStatus != TX_SUCCESS )
  { 
    APP_DBG( "ERROR THREADX : RANDOM PROCESS THREAD CREATION FAILED (%d)", ThreadXStatus );
    while(1);
  }
[/#if]  
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
  /* Register Semaphore to launch the Random Process */
  HwRngSemaphore = osSemaphoreNew( 1, 0, NULL );
  if ( HwRngSemaphore == NULL )
  { 
    APP_DBG( "ERROR FREERTOS : RANDOM PROCESS SEMAPHORE CREATION FAILED" );
    while(1);
  }

  /* Create the Random Process Thread */
  HwRngThread = osThreadNew( HW_RNG_Process_Task, NULL, &stHwRngThreadAttributes );
  if ( HwRngThread == NULL )
  { 
    APP_DBG( "ERROR FREERTOS : RANDOM PROCESS THREAD CREATION FAILED" );
    while(1);
  }
[/#if]
}

[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
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
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
[/#if]

  /* Create timers to detect button long press (one for each button) */
  Button_TypeDef buttonIndex;
  for ( buttonIndex = B1; buttonIndex < BUTTON_NB_MAX; buttonIndex++ )
  {
    UTIL_TIMER_Create( &buttonDesc[buttonIndex].longTimerId,
                       0,
                       (UTIL_TIMER_Mode_t)hw_ts_SingleShot,
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
void MX_APPE_Process(void)
{
  /* USER CODE BEGIN MX_APPE_Process_1 */

  /* USER CODE END MX_APPE_Process_1 */
  UTIL_SEQ_Run(UTIL_SEQ_DEFAULT);
  /* USER CODE BEGIN MX_APPE_Process_2 */

  /* USER CODE END MX_APPE_Process_2 */
}

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
#endif /* CFG_LPM_LEVEL */
  /* USER CODE BEGIN UTIL_SEQ_PostIdle_2 */

  /* USER CODE END UTIL_SEQ_PostIdle_2 */
  return;
}

[/#if]
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
void BPKACB_Process( void )
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_BPKA, CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_put(&BPKA_Thread_Sem);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

[/#if]
}

[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
void BPKA_BG_Process_Entry(unsigned long thread_input)
{
  (void)(thread_input);

  while(1)
  {
    tx_semaphore_get(&BPKA_Thread_Sem, TX_WAIT_FOREVER);
    tx_mutex_get(&LinkLayerMutex, TX_WAIT_FOREVER);
    BPKA_BG_Process();
    tx_mutex_put(&LinkLayerMutex);
    tx_thread_relinquish();
  }
}

[/#if]
[/#if]
/**
 * @brief Callback used by 'Random Generator' to launch Task to generate Random Numbers
 */
void HWCB_RNG_Process( void )
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_HW_RNG, CFG_TASK_PRIO_HW_RNG);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_put(&HwRngSemaphore);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

[/#if]
}

[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
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
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_AMM_BCKGND, CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_put(&AMM_BCKGND_Thread_Sem);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

[/#if]
}

[#if myHash["THREADX_STATUS"]?number == 1 ]
void AMM_BackgroundProcess_Entry(unsigned long thread_input)
{
  (void)(thread_input);

  while(1)
  {
    tx_semaphore_get(&AMM_BCKGND_Thread_Sem, TX_WAIT_FOREVER);
    tx_mutex_get(&LinkLayerMutex, TX_WAIT_FOREVER);
    AMM_BackgroundProcess();
    tx_mutex_put(&LinkLayerMutex);
    tx_thread_relinquish();
  }
}
[/#if]

void FM_ProcessRequest (void)
{
  /* Schedule the background process */
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_FLASH_MANAGER_BCKGND, CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_put(&FLASH_MANAGER_BCKGND_Thread_Sem);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

[/#if]
}

[#if myHash["THREADX_STATUS"]?number == 1 ]
void FM_BackgroundProcess_Entry(unsigned long thread_input)
{
  (void)(thread_input);

  while(1)
  {
    tx_semaphore_get(&FLASH_MANAGER_BCKGND_Thread_Sem, TX_WAIT_FOREVER);
    tx_mutex_get(&LinkLayerMutex, TX_WAIT_FOREVER);
    FM_BackgroundProcess();
    tx_mutex_put(&LinkLayerMutex);
    tx_thread_relinquish();
  }
}
[/#if]

[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Disabled")]
#if (CFG_LOG_SUPPORTED != 0)
[/#if]
/**
 *
 */
void RNG_KERNEL_CLK_OFF(void)
{
  /* RNG module may not switch off HSI clock when traces are used */

  /* USER CODE BEGIN RNG_KERNEL_CLK_OFF */

  /* USER CODE END RNG_KERNEL_CLK_OFF */
}

void SCM_HSI_CLK_OFF(void)
{
  /* SCM module may not switch off HSI clock when traces are used */

  /* USER CODE BEGIN SCM_HSI_CLK_OFF */

  /* USER CODE END SCM_HSI_CLK_OFF */
}

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Disabled")]
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
#endif /* CFG_LPM_LEVEL */

  /* USER CODE BEGIN ThreadXLowPowerUserExit_2 */

  /* USER CODE END ThreadXLowPowerUserExit_2 */
  return;
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
