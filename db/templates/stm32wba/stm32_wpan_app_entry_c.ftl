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

/* Includes ------------------------------------------------------------------*/
#include "app_common.h"
#include "app_conf.h"
#include "main.h"
[#if myHash["ZIGBEE"] == "Enabled"]
#include "app_zigbee.h"
[/#if]
#include "app_entry.h"
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
#include "stm32_seq.h"
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
#include "app_threadx.h"
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
#include "cmsis_os.h"
[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
#include "stm_list.h"
[/#if]
#if (CFG_LPM_SUPPORTED == 1)
#include "stm32_lpm.h"
#endif /* CFG_LPM_SUPPORTED */
#include "stm32_timer.h"
#include "stm32_mm.h"
#include "stm32_adv_trace.h"
[#if ((myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL"] == "Enabled") || (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled"))]
#include "app_ble.h"
[/#if]
[#if myHash["BLE"] == "Enabled" ]
#include "ll_sys_if.h"
[/#if]
[#if myHash["THREAD"] == "Enabled" ]
#include "app_thread.h"
[/#if]
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled")]
#include "app_sys.h"
[/#if]
#include "otp.h"
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled")]
#include "scm.h"
#include "bpka.h"
#include "ll_sys.h"
#include "advanced_memory_manager.h"
#include "flash_driver.h"
#include "flash_manager.h"
#include "simple_nvm_arbiter.h"
#include "app_debug.h"
#include "adc_ctrl.h"
[/#if]
[#if myHash["ZIGBEE"] == "Enabled" || (myHash["ZIGBEE_SKELETON"] == "Enabled")]
#include "stm32_mm.h"
#include "stm32_rtos.h"
#include "stm32_lpm.h"
#include "stm32_timer.h"

#include "stm32wbaxx_ll_rcc.h"
[/#if]

/* Private includes -----------------------------------------------------------*/
[#if myHash["ZIGBEE"] == "Enabled" ]
extern void ll_sys_mac_cntrl_init( void );
[/#if]
/* USER CODE BEGIN Includes */
[#if PG_FILL_UCS == "True"]
[#if PG_BSP_NUCLEO_WBA52CG == 1]
#include "stm32wbaxx_nucleo.h"
[/#if]
[#if PG_VALIDATION == 1]
#include "usart_if.h"
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
[#if myHash["ZIGBEE"] == "Enabled" ]
/* Heap size for System (used by Low-Layers) */
#define C_SYS_MEMORY_HEAP_SIZE_BYTES          60000
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
/* AMM_BCKGND_TASK related defines */
#define AMM_BCKGND_TASK_STACK_SIZE    (256*7)
#define AMM_BCKGND_TASK_PRIO          (15)
#define AMM_BCKGND_TASK_PREEM_TRES    (0)

/* BPKA_TASK related defines */
#define BPKA_TASK_STACK_SIZE    (256*7)
#define BPKA_TASK_PRIO          (15)
#define BPKA_TASK_PREEM_TRES    (0)

/* HW_RNG_TASK related defines */
#define HW_RNG_TASK_STACK_SIZE    (256*7)
#define HW_RNG_TASK_PRIO          (15)
#define HW_RNG_TASK_PREEM_TRES    (0)

/* FLASH_MANAGER_BCKGND_TASK related defines */
#define FLASH_MANAGER_BCKGND_TASK_STACK_SIZE    (256*7)
#define FLASH_MANAGER_BCKGND_TASK_PRIO          (15)
#define FLASH_MANAGER_BCKGND_TASK_PREEM_TRES    (0)

[/#if]

/* USER CODE BEGIN PD */
[#if PG_FILL_UCS == "True"]
[#if PG_BSP_NUCLEO_WBA52CG == 1]
#if (CFG_BUTTON_SUPPORTED == 1)
#define BUTTON_LONG_PRESS_THRESHOLD_MS   (500u)
#define BUTTON_NB_MAX                    (B3 + 1u)
#endif
[/#if]
[#if PG_VALIDATION == 1]
/* Section specific to button management using UART */
#define C_SIZE_CMD_STRING       256U
[/#if]
[/#if]

/* USER CODE END PD */

/* Private macros ------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
#if ( CFG_LPM_SUPPORTED == 1)
static bool system_startup_done = FALSE;
#endif /* CFG_LPM_SUPPORTED */
[/#if]

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
/* AMM_BCKGND_TASK related resources */
TX_THREAD AMM_BCKGND_Thread;
TX_SEMAPHORE AMM_BCKGND_Thread_Sem;

/* BPKA_TASK related resources */
TX_THREAD BPKA_Thread;
TX_SEMAPHORE BPKA_Thread_Sem;

/* HW_RNG_TASK related resources */
TX_THREAD HW_RNG_Thread;
TX_SEMAPHORE HW_RNG_Thread_Sem;

/* FLASH_MANAGER_BCKGND_TASK related resources */
TX_THREAD FLASH_MANAGER_BCKGND_Thread;
TX_SEMAPHORE FLASH_MANAGER_BCKGND_Thread_Sem;

[/#if]
/* USER CODE BEGIN PV */
[#if PG_FILL_UCS == "True"]
[#if PG_BSP_NUCLEO_WBA52CG == 1]
#if (CFG_BUTTON_SUPPORTED == 1)
/* Button management */
static ButtonDesc_t buttonDesc[BUTTON_NB_MAX];
#endif
[/#if]
[#if PG_VALIDATION == 1]
/* Section specific to button management using UART */
static uint8_t CommandString[C_SIZE_CMD_STRING];
static uint16_t indexReceiveChar = 0;
EXTI_HandleTypeDef exti_handle;
[/#if]
[/#if]

/* USER CODE END PV */

/* Global variables ----------------------------------------------------------*/
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
/* ThreadX byte pool pointer for whole WPAN middleware */
TX_BYTE_POOL *pBytePool;
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
[/#if]
/* USER CODE BEGIN GV */

/* USER CODE END GV */

/* Private functions prototypes-----------------------------------------------*/
static void Config_HSE(void);
static void RNG_Init( void );
static void System_Init( void );
static void SystemPower_Config( void );

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
static void BPKA_BG_Process_Entry(unsigned long thread_input);
static void HW_RNG_Process_Entry(unsigned long thread_input);
static void AMM_BackgroundProcess_Entry(unsigned long thread_input);
static void FM_BackgroundProcess_Entry(unsigned long thread_input);
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
[#if PG_VALIDATION == 1]
/* Section specific to button management using UART */
static void RxUART_Init(void);
static void RxCpltCallback(uint8_t *pdata, uint16_t size, uint8_t error);
static void UartCmdExecute(void);
[/#if]
[/#if]
/* USER CODE END PFP */

/* External variables --------------------------------------------------------*/

/* USER CODE BEGIN EV */
[#if PG_FILL_UCS == "True"]
[#if PG_VALIDATION == 1]
/* Section specific to button management using UART */
extern uint8_t charRx;
[/#if]
[/#if]
/* USER CODE END EV */


/* Functions Definition ------------------------------------------------------*/
void MX_APPE_Config(void)
{
  /* Configure HSE Tuning */
  Config_HSE();
}

[#if myHash["ZIGBEE"] == "Enabled" || (myHash["ZIGBEE_SKELETON"] == "Enabled")]
void MX_APPE_LinkLayerInit(void)
{
  /* Initialization of the low level : link layer and MAC */
  ll_sys_mac_cntrl_init();

}

[/#if]
uint32_t MX_APPE_Init(void *p_param)
{
  APP_DEBUG_SIGNAL_SET(APP_APPE_INIT);

[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UNUSED(p_param);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  /* save ThreadX byte pool for whole WPAN middleware */
  pBytePool = p_param;
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
  UNUSED(p_param);
[/#if]

  /* System initialization */
  System_Init();

  /* Configure the system Power Mode */
  SystemPower_Config();

  /* Initialize the Advance Memory Manager */
  AMM_Init (&ammInitConfig);

  /* Register the AMM background task */
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_RegTask(1U << CFG_TASK_AMM_BCKGND, UTIL_SEQ_RFU, AMM_BackgroundProcess);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  CHAR * pStack;

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

  /* Initialize the Simple NVM Arbiter */
  SNVMA_Init ((uint32_t *)CFG_SNVMA_START_ADDRESS);

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
[#if PG_VALIDATION == 1]
  /* Section specific to button management using UART */
  RxUART_Init();
[/#if]
[/#if]
/* USER CODE END APPE_Init_1 */
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

  /* Disable flash before any use - RFTS */
  FD_SetStatus (FD_FLASHACCESS_RFTS, LL_FLASH_DISABLE);
  /* Enable RFTS Bypass for flash operation - Since LL has not started yet */
  FD_SetStatus (FD_FLASHACCESS_RFTS_BYPASS, LL_FLASH_ENABLE);
  /* Enable flash system flag */
  FD_SetStatus (FD_FLASHACCESS_SYSTEM, LL_FLASH_ENABLE);

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
[#if myHash["THREADX_STATUS"]?number == 0]
  ll_sys_config_params();
[/#if]
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
#if ( CFG_LPM_SUPPORTED == 1)
  system_startup_done = TRUE;
#endif /* CFG_LPM_SUPPORTED */
[/#if]
  /* Disable RFTS Bypass for flash operation - Since LL has not started yet */
  FD_SetStatus (FD_FLASHACCESS_RFTS_BYPASS, LL_FLASH_DISABLE);

/* USER CODE BEGIN APPE_Init_2 */

/* USER CODE END APPE_Init_2 */
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

static void System_Init( void )
{
  /* Clear RCC RESET flag */
  LL_RCC_ClearResetFlags();

  UTIL_TIMER_Init();
  /* Enable wakeup out of standby from RTC ( UTIL_TIMER )*/
  HAL_PWR_EnableWakeUpPin(PWR_WAKEUP_PIN7_HIGH_3);

#if (CFG_DEBUG_APP_TRACE != 0)
  /*Initialize the terminal using the USART2 */
  UTIL_ADV_TRACE_Init();
  UTIL_ADV_TRACE_SetVerboseLevel(VLEVEL_L); /* functional traces*/
  UTIL_ADV_TRACE_SetRegion(~0x0);
#endif

#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
  adc_ctrl_init();
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */

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
  scm_init();

#if (CFG_LPM_SUPPORTED == 1)
 /* Initialize low power manager */
  UTIL_LPM_Init();

#if (CFG_LPM_STDBY_SUPPORTED == 1)
  /* Enable SRAM1, SRAM2 and RADIO retention*/
  LL_PWR_SetSRAM1SBRetention(LL_PWR_SRAM1_SB_FULL_RETENTION);
  LL_PWR_SetSRAM2SBRetention(LL_PWR_SRAM2_SB_FULL_RETENTION);
  LL_PWR_SetRadioSBRetention(LL_PWR_RADIO_SB_FULL_RETENTION); /* Retain sleep timer configuration */
#else
  UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);
#endif /* CFG_LPM_STDBY_SUPPORTED */
#endif /* CFG_LPM_SUPPORTED */
}

/**
 * @brief Initialize Random Number Generator module
 */
static void RNG_Init(void)
{
[#if myHash["THREADX_STATUS"]?number == 1 ]
  CHAR * pStack;

[/#if]
  HW_RNG_Start();

[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_RegTask(1U << CFG_TASK_HW_RNG, UTIL_SEQ_RFU, (void (*)(void))HW_RNG_Process);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  if (tx_byte_allocate(pBytePool, (void **) &pStack, HW_RNG_TASK_STACK_SIZE,TX_NO_WAIT) != TX_SUCCESS)
  {
    Error_Handler();
  }
  if (tx_semaphore_create(&HW_RNG_Thread_Sem, "HW_RNG_Thread_Sem", 0)!= TX_SUCCESS )
  {
    Error_Handler();
  }
  if (tx_thread_create(&HW_RNG_Thread, "HW_RNG Thread", HW_RNG_Process_Entry, 0,
                         pStack, HW_RNG_TASK_STACK_SIZE,
                         HW_RNG_TASK_PRIO, HW_RNG_TASK_PREEM_TRES,
                         TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
  {
    Error_Handler();
  }
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

[/#if]

  return;
}

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

  APP_DBG_MSG("Button %d pressed\n", (p_buttonDesc->button + 1));
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
[#if PG_VALIDATION == 1]

/* Section specific to button management using UART */
static void RxUART_Init(void)
{
  UART_StartRx(RxCpltCallback);
}

static void RxCpltCallback(uint8_t *pdata, uint16_t size, uint8_t error)
{
  /* Filling buffer and wait for '\r' char */
  if (indexReceiveChar < C_SIZE_CMD_STRING)
  {
    if (charRx == '\r')
    {
      APP_DBG_MSG("received %s\n", CommandString);

      UartCmdExecute();

      /* Clear receive buffer and character counter*/
      indexReceiveChar = 0;
      memset(CommandString, 0, C_SIZE_CMD_STRING);
    }
    else
    {
      CommandString[indexReceiveChar++] = charRx;
    }
  }

  /* Once a character has been sent, put back the device in reception mode */
  UART_StartRx(RxCpltCallback);
}

static void UartCmdExecute(void)
{
  /* Parse received CommandString */
  if(strcmp((char const*)CommandString, "SW1") == 0)
  {
    APP_DBG_MSG("SW1 OK\n");
#if (CFG_BUTTON_SUPPORTED == 1)
    buttonDesc[B1].longPressed = 0;
    UTIL_SEQ_SetTask(1U << TASK_BUTTON_1, CFG_SEQ_PRIO_0);
#endif
  }
  else if (strcmp((char const*)CommandString, "SW2") == 0)
  {
    APP_DBG_MSG("SW2 OK\n");
#if (CFG_BUTTON_SUPPORTED == 1)
    buttonDesc[B2].longPressed = 0;
    UTIL_SEQ_SetTask(1U << TASK_BUTTON_2, CFG_SEQ_PRIO_0);
#endif
  }
  else if (strcmp((char const*)CommandString, "SW3") == 0)
  {
    APP_DBG_MSG("SW3 OK\n");
#if (CFG_BUTTON_SUPPORTED == 1)
    buttonDesc[B3].longPressed = 0;
    UTIL_SEQ_SetTask(1U << TASK_BUTTON_3, CFG_SEQ_PRIO_0);
#endif
  }
  else if(strcmp((char const*)CommandString, "SW1_LONG") == 0)
  {
    APP_DBG_MSG("SW1_LONG OK\n");
#if (CFG_BUTTON_SUPPORTED == 1)
    buttonDesc[B1].longPressed = 1;
    UTIL_SEQ_SetTask(1U << TASK_BUTTON_1, CFG_SEQ_PRIO_0);
#endif
  }
  else if (strcmp((char const*)CommandString, "SW2_LONG") == 0)
  {
    APP_DBG_MSG("SW2_LONG OK\n");
#if (CFG_BUTTON_SUPPORTED == 1)
    buttonDesc[B2].longPressed = 1;
    UTIL_SEQ_SetTask(1U << TASK_BUTTON_2, CFG_SEQ_PRIO_0);
#endif
  }
  else if (strcmp((char const*)CommandString, "SW3_LONG") == 0)
  {
    APP_DBG_MSG("SW3_LONG OK\n");
#if (CFG_BUTTON_SUPPORTED == 1)
    buttonDesc[B3].longPressed = 1;
    UTIL_SEQ_SetTask(1U << TASK_BUTTON_3, CFG_SEQ_PRIO_0);
#endif
  }
  else
  {
    APP_DBG_MSG("NOT RECOGNIZED COMMAND : %s\n", CommandString);
  }
}
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

void UTIL_SEQ_Idle( void )
{
#if ( CFG_LPM_SUPPORTED == 1)
  HAL_SuspendTick();
  UTIL_LPM_EnterLowPower();
  HAL_ResumeTick();
#endif /* CFG_LPM_SUPPORTED */
  return;
}

void UTIL_SEQ_PreIdle( void )
{
#if ( CFG_LPM_SUPPORTED == 1)
  LL_PWR_ClearFlag_STOP();

  if(system_startup_done && UTIL_LPM_GetMode() == UTIL_LPM_OFFMODE)
  {
    APP_SYS_BLE_EnterDeepSleep();
  }

  LL_RCC_ClearResetFlags();

  /* Wait until HSE is ready */
  while (LL_RCC_HSE_IsReady() == 0);

  UTILS_ENTER_LIMITED_CRITICAL_SECTION(RCC_INTR_PRIO<<4);
  scm_hserdy_isr();
  UTILS_EXIT_LIMITED_CRITICAL_SECTION();
#endif /* CFG_LPM_SUPPORTED */
  return;
}

void UTIL_SEQ_PostIdle( void )
{
#if ( CFG_LPM_SUPPORTED == 1)
  LL_AHB5_GRP1_EnableClock(LL_AHB5_GRP1_PERIPH_RADIO);
  ll_sys_dp_slp_exit();
#endif /* CFG_LPM_SUPPORTED */
  return;
}
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
void ThreadXLowPowerUserEnter( void )
{
#if ( CFG_LPM_SUPPORTED == 1)
  LL_PWR_ClearFlag_STOP();

  LL_RCC_ClearResetFlags();

  /* Wait until HSE is ready */
  while (LL_RCC_HSE_IsReady() == 0);

  UTILS_ENTER_LIMITED_CRITICAL_SECTION(RCC_INTR_PRIO<<4);
  scm_hserdy_isr();
  UTILS_EXIT_LIMITED_CRITICAL_SECTION();
  HAL_SuspendTick();
  /* Disable SysTick Interrupt */
  SysTick->CTRL &= ~SysTick_CTRL_TICKINT_Msk;
  UTIL_LPM_EnterLowPower();
#endif /* CFG_LPM_SUPPORTED */
  return;
}

void ThreadXLowPowerUserExit( void )
{
#if ( CFG_LPM_SUPPORTED == 1)
  HAL_ResumeTick();
  /* Enable SysTick Interrupt */
  SysTick->CTRL  |= SysTick_CTRL_TICKINT_Msk;
  LL_AHB5_GRP1_EnableClock(LL_AHB5_GRP1_PERIPH_RADIO);
  ll_sys_dp_slp_exit();
#endif /* CFG_LPM_SUPPORTED */
  return;
}
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

[/#if]

void BPKACB_Process( void )
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_BPKA, CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_put(&BPKA_Thread_Sem);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

[/#if]
}

[#if myHash["THREADX_STATUS"]?number == 1 ]
void BPKA_BG_Process_Entry(unsigned long thread_input)
{
  (void)(thread_input);

  while(1)
  {
    tx_semaphore_get(&BPKA_Thread_Sem, TX_WAIT_FOREVER);
    tx_mutex_get(&LINK_LAYER_Thread_Mutex, TX_WAIT_FOREVER);
    BPKA_BG_Process();
    tx_mutex_put(&LINK_LAYER_Thread_Mutex);
    tx_thread_relinquish();
  }
}
[/#if]

void HWCB_RNG_Process( void )
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_HW_RNG, CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_put(&HW_RNG_Thread_Sem);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

[/#if]
}

[#if myHash["THREADX_STATUS"]?number == 1 ]
void HW_RNG_Process_Entry(unsigned long thread_input)
{
  (void)(thread_input);

  while(1)
  {
    tx_semaphore_get(&HW_RNG_Thread_Sem, TX_WAIT_FOREVER);
    tx_mutex_get(&LINK_LAYER_Thread_Mutex, TX_WAIT_FOREVER);
    HW_RNG_Process();
    tx_mutex_put(&LINK_LAYER_Thread_Mutex);
    tx_thread_relinquish();
  }
}
[/#if]

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
    tx_mutex_get(&LINK_LAYER_Thread_Mutex, TX_WAIT_FOREVER);
    AMM_BackgroundProcess();
    tx_mutex_put(&LINK_LAYER_Thread_Mutex);
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
    tx_mutex_get(&LINK_LAYER_Thread_Mutex, TX_WAIT_FOREVER);
    FM_BackgroundProcess();
    tx_mutex_put(&LINK_LAYER_Thread_Mutex);
    tx_thread_relinquish();
  }
}
[/#if]

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Disabled")]
#if (CFG_DEBUG_APP_TRACE != 0)
[/#if]
void RNG_KERNEL_CLK_OFF(void)
{
  /* RNG module may not switch off HSI clock when traces are used */

  /* USER CODE BEGIN RNG_KERNEL_CLK_OFF */

  /* USER CODE END RNG_KERNEL_CLK_OFF */
}

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Disabled")]
#endif

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
