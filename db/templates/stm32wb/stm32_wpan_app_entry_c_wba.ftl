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

[#assign BLE_TRANSPARENT_MODE_UART = 0]
[#assign CUSTOM_P2P_CLIENT = 0]
[#assign CUSTOM_P2P_ROUTER = 0]
[#assign CUSTOM_TEMPLATE = 0]
[#assign FREERTOS_STATUS = 0]
[#assign THREAD = 0]
[#assign BLE = 0]
[#assign ZIGBEE = 0]
[#assign THREAD_SKELETON = 0]
[#assign BLE_SKELETON = 0]
[#assign ZIGBEE_SKELETON = 0]

[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
[#--
        ${definition.name}: ${definition.value}
--]
            [#if (definition.name == "BLE_TRANSPARENT_MODE_UART") && (definition.value == "Enabled")]
                [#assign BLE_TRANSPARENT_MODE_UART = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_P2P_CLIENT") && (definition.value == "Enabled")]
                [#assign CUSTOM_P2P_CLIENT = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_P2P_ROUTER") && (definition.value == "Enabled")]
                [#assign CUSTOM_P2P_ROUTER = 1]
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
            [#if (definition.name == "ZIGBEE") && (definition.value == "Enabled")]
                [#assign ZIGBEE = 1]
            [/#if]
            [#if (definition.name == "BLE_SKELETON") && (definition.value == "Enabled")]
                [#assign BLE_SKELETON = 1]
            [/#if]
            [#if (definition.name == "THREAD_SKELETON") && (definition.value == "Enabled")]
                [#assign THREAD_SKELETON = 1]
            [/#if]
            [#if (definition.name == "ZIGBEE") && (definition.value == "Enabled")]
                [#assign ZIGBEE_SKELETON = 1]
            [/#if]
        [/#list]
    [/#if]
[/#list]
/* Includes ------------------------------------------------------------------*/
#include "app_common.h"
#include "app_conf.h"
#include "main.h"
#include "app_entry.h"
[#if FREERTOS_STATUS = 1 ]
#include "cmsis_os.h"
[#else]
#include "stm32_seq.h"
[/#if]
[#if (BLE_TRANSPARENT_MODE_UART = 1)]
#include "stm_list.h"
[/#if]
[#if THREAD = 1 || ZIGBEE = 1]
#include "stm_logging.h"
#include "shci_tl.h"
[/#if]
#include "stm32_lpm.h"
#include "stm32_timer.h"
#include "stm32_mm.h"
#include "stm32_adv_trace.h"
[#if  (CUSTOM_P2P_CLIENT = 1 || CUSTOM_P2P_ROUTER = 1 || CUSTOM_TEMPLATE =1)]
#include "app_ble.h"
[/#if]
[#if (BLE_TRANSPARENT_MODE_UART = 1)]
#include "tm.h"
[/#if]
[#if THREAD = 1 ]
#include "app_thread.h"
[/#if]
[#if ZIGBEE = 1]
#include "app_zigbee.h"
[/#if]
[#if THREAD = 1 || ZIGBEE = 1]
#include "hw_conf.h"
[/#if]
#include "otp.h"
#include "scm.h"
#include "bpka.h"

/* Private includes -----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/

/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private defines -----------------------------------------------------------*/

/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macros ------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
ALIGN(4) static uint8_t MM_Pool[CFG_MM_POOL_SIZE];
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private functions prototypes-----------------------------------------------*/
static void Config_HSE(void);
static void System_Init( void );
static void SystemPower_Config( void );

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Functions Definition ------------------------------------------------------*/
void MX_APPE_Config(void)
{
  /* Configure HSE Tuning */
  Config_HSE();
}

void MX_APPE_Init(void)
{
  System_Init();       /**< System initialization */

  SystemPower_Config(); /**< Configure the system Power Mode */

  UTIL_MM_Init(MM_Pool, CFG_MM_POOL_SIZE);      /**< Initialize Memory Manager */
  
/* USER CODE BEGIN APPE_Init_1 */

/* USER CODE END APPE_Init_1 */
  UTIL_SEQ_RegTask( 1U << CFG_TASK_BPKA, UTIL_SEQ_RFU, BPKA_BG_Process);
  BPKA_Reset( );
  
  UTIL_SEQ_RegTask( 1U << CFG_TASK_HW_RNG, UTIL_SEQ_RFU, (void (*)(void))HW_RNG_Process);
  HW_RNG_Start( );

[#if BLE = 1]
  APP_BLE_Init();
[/#if]
#if ( CFG_LPM_SUPPORTED == 1)
  system_startup_done = TRUE;
#endif
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

static void Config_HSE(void)
{
  OTP_Data_s* otp_ptr = NULL;

  /**
   * Read HSE_Tuning from OTP
   */
  if (OTP_Read(DEFAULT_OTP_IDX, &otp_ptr) != HAL_OK) {
    /* Initialization error */
  }

  HAL_RCCEx_HSESetTrimming(otp_ptr->hsetune);
}

static void System_Init( void )
{ 
  /* Clear RCC RESET flag */
  LL_RCC_ClearResetFlags();
  
  /* Configure ICACHE */
  HAL_ICACHE_ConfigAssociativityMode(ICACHE_2WAYS);
  HAL_ICACHE_Enable();

  UTIL_TIMER_Init();

#if (CFG_DEBUG_APP_TRACE != 0) 
  /*Initialize the terminal using the USART2 */
  UTIL_ADV_TRACE_Init();
  UTIL_ADV_TRACE_SetVerboseLevel(VLEVEL_L); /*!< functional traces*/
  UTIL_ADV_TRACE_SetRegion(~0x0);
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
static void SystemPower_Config(void)
{
  /* Set VOS (Range 1) */
  LL_PWR_SetRegulVoltageScaling(LL_PWR_REGU_VOLTAGE_SCALE1);
  
  /* Wait until VOS has changed */
  while (LL_PWR_IsActiveFlag_VOS() == 0);

  scm_init();
}

/* USER CODE BEGIN FD_LOCAL_FUNCTIONS */

/* USER CODE END FD_LOCAL_FUNCTIONS */

/*************************************************************
 *
 * WRAP FUNCTIONS
 *
 *************************************************************/
void MX_APPE_Process(void)
{
  /* USER CODE BEGIN MX_APPE_Process_1 */

  /* USER CODE END MX_APPE_Process_1 */
  UTIL_SEQ_Run(UTIL_SEQ_DEFAULT);
  /* USER CODE BEGIN MX_APPE_Process_2 */

  /* USER CODE END MX_APPE_Process_2 */
}

void UTIL_SEQ_Idle( void ){}

void BPKACB_Process( void )
{
  UTIL_SEQ_SetTask(1U << CFG_TASK_BPKA, CFG_SCH_PRIO_0);
}

void HWCB_RNG_Process( void )
{
  UTIL_SEQ_SetTask(1U << CFG_TASK_HW_RNG, CFG_SCH_PRIO_0);
}

/* USER CODE BEGIN FD_WRAP_FUNCTIONS */

/* USER CODE END FD_WRAP_FUNCTIONS */
