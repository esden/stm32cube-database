[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    sgfx_app.c
  * @author  MCD Application Team
  * @brief   provides code for the application of the sigfox Middleware
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#--
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                ${definition.name}: ${definition.value}
            [/#list]
        [/#if]
    [/#list]
[/#if]
--]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
[#assign SUBGHZ_APPLICATION = ""]
[#assign SECURE_PROJECTS = "0"]
[#assign FILL_UCS = ""]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "SUBGHZ_APPLICATION"]
                    [#assign SUBGHZ_APPLICATION = definition.value]
                [/#if]
                [#if definition.name == "FILL_UCS"]
                    [#assign FILL_UCS = definition.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]

/* Includes ------------------------------------------------------------------*/

#include "st_sigfox_api.h"
#include "sgfx_app.h"
#include "sgfx_app_version.h"
#include "sigfox_version.h"
[#if THREADX??][#-- If AzRtos is used --]
#include "app_azure_rtos.h"
#include "tx_api.h"
#include "sys_app.h"
[/#if]
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
#include "subghz_phy_version.h"
#include "radio.h"
#include "sys_conf.h"
#include "sgfx_eeprom_if.h"
#include "sys_app.h"
#include "stm32_lpm.h"
[#if !THREADX??][#-- If AzRtos is not used --]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
#include "stm32_seq.h"
[#else]
#include "cmsis_os.h"
[/#if]
[/#if]
#include "utilities_def.h"
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") ]
#include "sgfx_command.h"
[/#if]
[#if ((SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")) && (CPUCORE == "CM4") ]
#include "sigfox_mbwrapper.h"
#include "sigfox_info.h"
#include "mbmuxif_sys.h"
[/#if]
[/#if]

/* USER CODE BEGIN Includes */
[#if (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") && (FILL_UCS == "true")]
#include "sys_sensors.h"
[/#if]

/* USER CODE END Includes */

/* Exported variables ---------------------------------------------------------*/
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
[#if (CPUCORE == "")]
[#if THREADX??]
TX_SEMAPHORE  Sem_Delay;        /* used by mcu_api.c */
TX_SEMAPHORE  Sem_Timeout;      /* used by mcu_api.c and rf_api.c*/
TX_SEMAPHORE  Sem_TxTimeout;    /* used by rf_api.c */
[#elseif FREERTOS??][#-- If FreeRtos is used --]
osSemaphoreId_t Sem_Delay;      /* used by mcu_api.c */
osSemaphoreId_t Sem_Timeout;    /* used by mcu_api.c and rf_api.c*/
osSemaphoreId_t Sem_TxTimeout;  /* used by rf_api.c */
[/#if]
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE")]
[#if THREADX??]
TX_SEMAPHORE  Sem_Monarch;      /* used by sgfx_at.c */
[#elseif FREERTOS??][#-- If FreeRtos is used --]
osSemaphoreId_t Sem_Monarch;    /* used by sgfx_at.c */
[/#if]
[/#if]
[/#if]

/* USER CODE BEGIN ExpV */

/* USER CODE END ExpV */

/* External variables ---------------------------------------------------------*/
[#if THREADX??]
extern TX_THREAD App_MainThread;
extern TX_BYTE_POOL *byte_pool;
extern CHAR *pointer;
[/#if]
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
extern RadioEvents_t RfApiRadioEvents;
[/#if]
[#if (SECURE_PROJECTS == "1") && (CPUCORE == "CM4") ]
#if defined (DEBUGGER_ENABLED) && ( DEBUGGER_ENABLED == 1 )
extern __IO uint32_t lets_go_on;
#elif !defined (DEBUGGER_ENABLED)
#error "DEBUGGER_ENABLED not defined or out of range <0,1>"
#endif /* DEBUGGER_ENABLED */

[/#if]
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
[#if ((SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON"))]
[#if (CPUCORE == "CM4")]
static SigfoxCallback_t SigfoxCallbacks = { SYS_GetBatteryLevel,
                                            GetTemperatureLevel
                                          };

[/#if]
[#if THREADX??][#-- If AzRtos is used --]
[#if (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")]
TX_THREAD Thd_PushButtonProcessId;
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE")]
TX_THREAD Thd_VcomProcessId;
[/#if]

[/#if]
[#if FREERTOS??][#-- If FreeRtos is used --]
[#if (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")]
osThreadId_t Thd_SendProcessId;

const osThreadAttr_t Thd_SendProcess_attr =
{
  .name = CFG_APP_SGFX_PROCESS_NAME,
  .attr_bits = CFG_APP_SGFX_PROCESS_ATTR_BITS,
  .cb_mem = CFG_APP_SGFX_PROCESS_CB_MEM,
  .cb_size = CFG_APP_SGFX_PROCESS_CB_SIZE,
  .stack_mem = CFG_APP_SGFX_PROCESS_STACK_MEM,
  .priority = CFG_APP_SGFX_PROCESS_PRIORITY,
  .stack_size = CFG_APP_SGFX_PROCESS_STACK_SIZE
};
static void Thd_SendProcess(void *argument);

[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE")]
osThreadId_t Thd_VcomProcessId;

const osThreadAttr_t Thd_VcomProcess_attr =
{
  .name = CFG_VCOM_PROCESS_NAME,
  .attr_bits = CFG_VCOM_PROCESS_ATTR_BITS,
  .cb_mem = CFG_VCOM_PROCESS_CB_MEM,
  .cb_size = CFG_VCOM_PROCESS_CB_SIZE,
  .stack_mem = CFG_VCOM_PROCESS_STACK_MEM,
  .priority = CFG_VCOM_PROCESS_PRIORITY,
  .stack_size = CFG_VCOM_PROCESS_STACK_SIZE
};
static void Thd_VcomProcess(void *argument);

[/#if]
[/#if]
[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
[#if THREADX??][#-- If AzRtos is used --]
[#if (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")]
/**
  * @brief  Entry point for the thread PushButtonProcess.
  * @param  thread_input: Not used
  * @retval None
  */
static void Thd_PushButtonProcess_Entry(unsigned long thread_input);

[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE")]
/**
  * @brief  Entry point for the thread when receiving MailBox Vcom Notification .
  * @param  thread_input: Not used
  * @retval None
  */
static void Thd_VcomProcess_Entry(unsigned long thread_input);

[/#if]
[/#if]
/**
  * @brief  It calls SIGFOX_API_open()
  * @param  Config
  * @retval Status
  */
static sfx_error_t st_sigfox_open(sfx_rc_enum_t sfx_rc);

[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") ]
/**
  * @brief  It schedules the Virtual Com task
  * @param  None
  * @retval None
  */
static void CmdProcessNotify(void);

[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")]
/**
  * @brief  The example sends T, P and H data. To be changed by the user.
  * @param  None
  * @retval None
  */
static void SendSigfox(void);

[/#if]
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/

void Sigfox_Init(void)
{
  sfx_rc_enum_t sfx_rc = SFX_RC1;
  sfx_error_t error = 0;
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") && (CPUCORE != "CM4")]
  /* USER CODE BEGIN Sigfox_Init_0 */

  /* USER CODE END Sigfox_Init_0 */
[/#if]
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
[#if (CPUCORE == "CM4")]
  SigfoxInfo_t *SigfoxRegionInfo;

  /* USER CODE BEGIN Sigfox_Init_0 */
[#if (FILL_UCS == "true")]
  FEAT_INFO_Param_t *p_cm0plus_specific_features_info;
  uint32_t feature_version = 0UL;
[#else]

[/#if]
  /* USER CODE END Sigfox_Init_0 */
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") ]
  CMD_Init(CmdProcessNotify);

[/#if]
[/#if]
  /* USER CODE BEGIN Sigfox_Init_1 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION") && (FILL_UCS == "true")]

[#if CPUCORE == "CM4"]
  /* Get CM4 Sigfox APP version*/
  APP_LOG(TS_OFF, VLEVEL_M, "M4_APP_VERSION:      V%X.%X.%X\r\n",
          (uint8_t)(APP_VERSION_MAIN),
          (uint8_t)(APP_VERSION_SUB1),
          (uint8_t)(APP_VERSION_SUB2));

  /* Get CM0 Sigfox APP version*/
  p_cm0plus_specific_features_info = MBMUXIF_SystemGetFeatCapabInfoPtr(FEAT_INFO_SYSTEM_ID);
  feature_version = p_cm0plus_specific_features_info->Feat_Info_Feature_Version;
  APP_LOG(TS_OFF, VLEVEL_M, "M0PLUS_APP_VERSION:  V%X.%X.%X\r\n",
          (uint8_t)(feature_version >> 24),
          (uint8_t)(feature_version >> 16),
          (uint8_t)(feature_version >> 8));

  /* Get MW Sigfox info */
  p_cm0plus_specific_features_info = MBMUXIF_SystemGetFeatCapabInfoPtr(FEAT_INFO_SIGFOX_ID);
  feature_version = p_cm0plus_specific_features_info->Feat_Info_Feature_Version;
  APP_LOG(TS_OFF, VLEVEL_M, "MW_SIGFOX_VERSION:   V%X.%X.%X\r\n",
          (uint8_t)(feature_version >> 24),
          (uint8_t)(feature_version >> 16),
          (uint8_t)(feature_version >> 8));

  /* Get MW SubGhz_Phy info */
  p_cm0plus_specific_features_info = MBMUXIF_SystemGetFeatCapabInfoPtr(FEAT_INFO_RADIO_ID);
  feature_version = p_cm0plus_specific_features_info->Feat_Info_Feature_Version;
  APP_LOG(TS_OFF, VLEVEL_M, "MW_RADIO_VERSION:    V%X.%X.%X\r\n",
          (uint8_t)(feature_version >> 24),
          (uint8_t)(feature_version >> 16),
          (uint8_t)(feature_version >> 8));
[#else]
  /* Get Sigfox APP version*/
  APP_LOG(TS_OFF, VLEVEL_M, "APPLICATION_VERSION: V%X.%X.%X\r\n",
          (uint8_t)(APP_VERSION_MAIN),
          (uint8_t)(APP_VERSION_SUB1),
          (uint8_t)(APP_VERSION_SUB2));

  /* Get MW Sigfox info */
  APP_LOG(TS_OFF, VLEVEL_M, "MW_SIGFOX_VERSION:   V%X.%X.%X\r\n",
          (uint8_t)(SIGFOX_VERSION_MAIN),
          (uint8_t)(SIGFOX_VERSION_SUB1),
          (uint8_t)(SIGFOX_VERSION_SUB2));

  /* Get MW SubGhz_Phy info */
  APP_LOG(TS_OFF, VLEVEL_M, "MW_RADIO_VERSION:    V%X.%X.%X\r\n",
          (uint8_t)(SUBGHZ_PHY_VERSION_MAIN),
          (uint8_t)(SUBGHZ_PHY_VERSION_SUB1),
          (uint8_t)(SUBGHZ_PHY_VERSION_SUB2));
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") ]

  APP_PPRINTF("ATtention command interface\n\r");
[/#if]
[/#if][#-- (FILL_UCS == "true") --]

  /* USER CODE END Sigfox_Init_1 */

[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") ]
[#if THREADX??][#-- If AzRtos is used --]
  /* Allocate the stack for Thd_VcomProcess.  */
  if (tx_byte_allocate(byte_pool, (VOID **) &pointer, CFG_VCOM_THREAD_STACK_SIZE, TX_NO_WAIT) != TX_SUCCESS)
  {
    Error_Handler();
  }
  if (tx_thread_create(&Thd_VcomProcessId, "Thread VcomProcess", Thd_VcomProcess_Entry, 0,
                       pointer, CFG_VCOM_THREAD_STACK_SIZE,
                       CFG_VCOM_THREAD_PRIO, CFG_VCOM_THREAD_PREEMPTION_THRESHOLD,
                       TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
  {
    Error_Handler();
  }

  if (tx_semaphore_create(&Sem_Monarch, "Sem_Monarch", 0) != TX_SUCCESS)
  {
    Error_Handler();
  }

[/#if]
[#if FREERTOS??][#-- If FreeRtos is used --]
  Thd_VcomProcessId = osThreadNew(Thd_VcomProcess, NULL, &Thd_VcomProcess_attr);
  if (Thd_VcomProcessId == NULL)
  {
    Error_Handler();
  }
  Sem_Monarch = osSemaphoreNew(1, 0, NULL);

[/#if]
[/#if]
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]

[#if (CPUCORE == "")]
[#if THREADX??][#-- If AzRtos is used --]
  if (tx_semaphore_create(&Sem_Delay, "Sem_Delay", 0) != TX_SUCCESS)
  {
    Error_Handler();
  }
  if (tx_semaphore_create(&Sem_Timeout, "Sem_Timeout", 0) != TX_SUCCESS)
  {
    Error_Handler();
  }
  if (tx_semaphore_create(&Sem_TxTimeout, "Sem_TxTimeout", 0) != TX_SUCCESS)
  {
    Error_Handler();
  }

[/#if]
[#if FREERTOS??][#-- If FreeRtos is used --]
  Sem_Delay = osSemaphoreNew(1, 0, NULL);   /*< Create the semaphore and make it busy at initialization */
  Sem_Timeout = osSemaphoreNew(1, 0, NULL);   /*< Create the semaphore and make it busy at initialization */
  Sem_TxTimeout = osSemaphoreNew(1, 0, NULL);   /*< Create the semaphore and make it busy at initialization */

[/#if]
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") ]
  sfx_rc = E2P_Read_Rc();

[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") ]
  E2P_Write_Rc(DEFAULT_RC);
  sfx_rc = E2P_Read_Rc();

[/#if]
[/#if]
  /*Open Sigfox library */
  error = st_sigfox_open(sfx_rc);

[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
[#if (CPUCORE == "CM0PLUS") || (CPUCORE == "")]
  Radio.Init(&RfApiRadioEvents);
[#elseif (CPUCORE == "CM4")]
  /* Init SigfoxInfo capabilities table (redundant: Cm0 is supposed to have done it already) */
  SigfoxInfo_Init();

  SigfoxRegionInfo = SigfoxInfo_GetPtr();
  if (SigfoxRegionInfo->Region == 0)
  {
    APP_PRINTF("error: At least one region shall be defined : RC1 to RC7 \n\r");
    while (1) {} /* At least one region shall be defined */
  }

  /* Register GetBatteryLevel and GetTemperatureLevel functions */
  Sigfox_Register(&SigfoxCallbacks);
[/#if]
  /* USER CODE BEGIN Sigfox_Init_ErrorCheck */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION") && (FILL_UCS == "true")]
  if (1U == E2P_Read_AtEcho())
  {
    if (error == SFX_ERR_NONE)
    {
      APP_PPRINTF("\r\n\n\rSIGFOX APPLICATION READY\n\r\n\r");
    }
    else
    {
      APP_PPRINTF("\r\n\n\rSIGFOX APPLICATION ERROR: 0x%04X\n\r\n\r", error);
    }
  }
[#else]

[/#if]
  /* USER CODE END Sigfox_Init_ErrorCheck */
  (void)error;

[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") ]
[#if !THREADX??][#-- If AzRtos not is not used --]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  /* Put radio in Sleep waiting next cmd */
  UTIL_SEQ_RegTask(1 << CFG_SEQ_Task_Vcom, UTIL_SEQ_RFU, CMD_Process);
[/#if]
[/#if]
[/#if]
[#else][#-- SIGFOX_USER_APPLICATION--]

  (void)error;
  /*initialize an event to send data periodically*/

[/#if][#-- SIGFOX_USER_APPLICATION--]
[#if (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")]
[#if THREADX??][#-- If AzRtos is used --]
  /* Allocate the stack for PushButtonProcess.  */
  if (tx_byte_allocate(byte_pool, (VOID **) &pointer,
                       CFG_PBP_THREAD_STACK_SIZE, TX_NO_WAIT) != TX_SUCCESS)
  {
    Error_Handler();
  }

  if (tx_thread_create(&Thd_PushButtonProcessId, "Thread PushButtonProcess", Thd_PushButtonProcess_Entry, 0,
                       pointer, CFG_PBP_THREAD_STACK_SIZE,
                       CFG_PBP_THREAD_PRIO, CFG_PBP_THREAD_PREEMPTION_THRESHOLD,
                       TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
  {
    Error_Handler();
  }

[#else][#-- not THREADX--]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_Pb), UTIL_SEQ_RFU, SendSigfox);
[#else]
  Thd_SendProcessId = osThreadNew(Thd_SendProcess, NULL, &Thd_SendProcess_attr);
  if (Thd_SendProcessId == NULL)
  {
    Error_Handler();
  }
[/#if]
[/#if][#-- THREADX--]

[/#if]
  /* USER CODE BEGIN Sigfox_Init_2 */

  /* USER CODE END Sigfox_Init_2 */
}
/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/
static sfx_error_t st_sigfox_open(sfx_rc_enum_t sfx_rc)
{
  /* USER CODE BEGIN st_sigfox_open_1 */

  /* USER CODE END st_sigfox_open_1 */
  sfx_u32 config_words[3] = {0};

[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  E2P_Read_ConfigWords(sfx_rc, config_words);
[#else]
  /* USER CODE BEGIN st_sigfox_open_read_config_words */
  /* read config words from memory */
  /* USER CODE END st_sigfox_open_read_config_words */
[/#if]

  sfx_error_t error = SFX_ERR_NONE;

  /*record RCZ*/
  switch (sfx_rc)
  {
    case SFX_RC1:
    {
      sfx_rc_t SgfxRc = RC1;
      error = SIGFOX_API_open(&SgfxRc);

      break;
    }
    case SFX_RC2:
    {
      sfx_rc_t SgfxRc = RC2;

      error = SIGFOX_API_open(&SgfxRc);

      if (error == SFX_ERR_NONE)
      {
        error = SIGFOX_API_set_std_config(config_words, RC2_SET_STD_TIMER_ENABLE);
      }

      break;
    }
    case SFX_RC3A:
    {
      sfx_rc_t SgfxRc = RC3A;

      error = SIGFOX_API_open(&SgfxRc);

      if (error == SFX_ERR_NONE)
      {
        error = SIGFOX_API_set_std_config(config_words, NA);
      }
      break;
    }
    case SFX_RC3C:
    {
      sfx_rc_t SgfxRc = RC3C;

      error = SIGFOX_API_open(&SgfxRc);

      if (error == SFX_ERR_NONE)
      {
        error = SIGFOX_API_set_std_config(config_words, NA);
      }
      break;
    }
    case SFX_RC4:
    {
      sfx_rc_t SgfxRc = RC4;

      error = SIGFOX_API_open(&SgfxRc);

      if (error == SFX_ERR_NONE)
      {
        error = SIGFOX_API_set_std_config(config_words, RC4_SET_STD_TIMER_ENABLE);
      }
      break;
    }
    case SFX_RC5:
    {
      sfx_rc_t SgfxRc = RC5;

      error = SIGFOX_API_open(&SgfxRc);

      if (error == SFX_ERR_NONE)
      {
        error = SIGFOX_API_set_std_config(config_words, NA);
      }
      break;
    }
    case SFX_RC6:
    {
      sfx_rc_t SgfxRc = RC6;
      error = SIGFOX_API_open(&SgfxRc);
      break;
    }
    case SFX_RC7:
    {
      sfx_rc_t SgfxRc = RC7;
      error = SIGFOX_API_open(&SgfxRc);
      break;
    }
    /* USER CODE BEGIN st_sigfox_open_case */

    /* USER CODE END st_sigfox_open_case */
    default:
    {
      error = SFX_ERR_API_OPEN;
      break;
    }
  }

  return error;
  /* USER CODE BEGIN st_sigfox_open_2 */

  /* USER CODE END st_sigfox_open_2 */
}
[#if THREADX??][#-- If AzRtos is used --]

void App_Main_Thread_Entry(unsigned long thread_input)
{
  (void) thread_input;

  /* USER CODE BEGIN App_Main_Thread_Entry_1 */

  /* USER CODE END App_Main_Thread_Entry_1 */
  SystemApp_Init();
  Sigfox_Init();
  /* USER CODE BEGIN App_Main_Thread_Entry_2 */

  /* USER CODE END App_Main_Thread_Entry_2 */

  /* Infinite loop */
  while (1)
  {
    tx_thread_suspend(&App_MainThread);
    /*do what you want*/
    /* USER CODE BEGIN App_Main_Thread_Entry_Loop */

    /* USER CODE END App_Main_Thread_Entry_Loop */
  }
  /* Following USER CODE SECTION will be never reached */
  /* it can be use for compilation flag like #else or #endif */
  /* USER CODE BEGIN App_Main_Thread_Entry_Last */

  /* USER CODE END App_Main_Thread_Entry_Last */
}
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") ]

static void CmdProcessNotify(void)
{
  /* USER CODE BEGIN CmdProcessNotify_1 */

  /* USER CODE END CmdProcessNotify_1 */
[#if THREADX??][#-- If AzRtos is used --]
  tx_thread_resume(&Thd_VcomProcessId);
[#else]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_SetTask(1 << CFG_SEQ_Task_Vcom, CFG_SEQ_Prio_0);
[#else]
  osThreadFlagsSet(Thd_VcomProcessId, 1);
[/#if]
[/#if]
  /* USER CODE BEGIN CmdProcessNotify_2 */

  /* USER CODE END CmdProcessNotify_2 */
}
[#if THREADX??][#-- If AzRtos is used --]

static void Thd_VcomProcess_Entry(ULONG thread_input)
{
  /* USER CODE BEGIN Thd_VcomProcess_Entry_1 */

  /* USER CODE END Thd_VcomProcess_Entry_1 */
  (void) thread_input;
  /* Infinite loop */
  for (;;)
  {
    tx_thread_suspend(&Thd_VcomProcessId);
    CMD_Process();  /*what you want to do*/
    /* USER CODE BEGIN Thd_VcomProcess_Entry_2 */

    /* USER CODE END Thd_VcomProcess_Entry_2 */
  }
  /* Following USER CODE SECTION will be never reached */
  /* it can be use for compilation flag like #else or #endif */
  /* USER CODE BEGIN Thd_VcomProcess_Entry_Last */

  /* USER CODE END Thd_VcomProcess_Entry_Last */
}
[/#if]
[#if FREERTOS??][#-- If FreeRtos is used --]

static void Thd_VcomProcess(void *argument)
{
  /* USER CODE BEGIN Thd_VcomProcess_1 */

  /* USER CODE END Thd_VcomProcess_1 */
  UNUSED(argument);
  for (;;)
  {
    osThreadFlagsWait(1, osFlagsWaitAny, osWaitForever);
    CMD_Process(); /*what you want to do*/
  }
  /* USER CODE BEGIN Thd_VcomProcess_2 */

  /* USER CODE END Thd_VcomProcess_2 */
}
[/#if]
[/#if]

[#if (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")]
[#if THREADX??][#-- If AzRtos is used --]
void Thd_PushButtonProcess_Entry(unsigned long thread_input)
{
  (void) thread_input;
  /* USER CODE BEGIN Thd_PushButtonProcess_Entry_1 */

  /* USER CODE END Thd_PushButtonProcess_Entry_1 */
  /* Infinite loop */
  while (1)
  {
    tx_thread_suspend(&Thd_PushButtonProcessId);
    SendSigfox(); /* function to be customised by user. See below */
    /* USER CODE BEGIN Thd_PushButtonProcess_Entry_2 */

    /* USER CODE END Thd_PushButtonProcess_Entry_2 */
  }
  /* USER CODE BEGIN Thd_PushButtonProcess_Entry_Last */

  /* USER CODE END Thd_PushButtonProcess_Entry_Last */
}

[/#if]
[#if FREERTOS??][#-- If FreeRtos is used --]
static void Thd_SendProcess(void *argument)
{
  UNUSED(argument);
  /* USER CODE BEGIN Thd_SendProcess_1 */

  /* USER CODE END Thd_SendProcess_1 */
  for (;;)
  {
    osThreadFlagsWait(1, osFlagsWaitAny, osWaitForever);
    SendSigfox(); /* function to be customised by user. See below */
    /* USER CODE BEGIN Thd_SendProcess_2 */

    /* USER CODE END Thd_SendProcess_2 */
  }
  /* USER CODE BEGIN Thd_SendProcess_Last */

  /* USER CODE END Thd_SendProcess_Last */
}

[/#if]
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")]
/* USER CODE BEGIN PB_Callbacks */
[#if (FILL_UCS != "true")]

#if 0 /* User should remove the #if 0 statement and adapt the below code according with his needs*/
[/#if]
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
{
  switch (GPIO_Pin)
  {
    case  BUT1_Pin:
[#if THREADX??]
      tx_thread_resume(&Thd_PushButtonProcessId);
[#else]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
      UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_Pb), CFG_SEQ_Prio_0);
[#else]
      osThreadFlagsSet(Thd_SendProcessId, 1);
[/#if]
[/#if]
      break;
    case  BUT2_Pin:
[#if (SECURE_PROJECTS == "1") && (CPUCORE == "CM4") ]
#if defined (DEBUGGER_ENABLED) && ( DEBUGGER_ENABLED == 1 )
      lets_go_on = 1;
#elif !defined (DEBUGGER_ENABLED)
#error "DEBUGGER_ENABLED not defined or out of range <0,1>"
#endif /* DEBUGGER_ENABLED */
[/#if]
      break;
    default:
      break;
  }
}
[#if (FILL_UCS != "true")]
#endif
[/#if]
/* USER CODE END PB_Callbacks */

static void SendSigfox(void)
{
  /* USER CODE BEGIN SendSigfox */
[#if (FILL_UCS == "true")]

  /* Following code is an example that user can replace according with his needs */

  uint8_t ul_msg[12] = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x10, 0x11};
  uint8_t dl_msg[8] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
  uint32_t  ul_size = 0;
  int16_t temperature = 0;
  uint16_t batteryLevel = SYS_GetBatteryLevel();
  uint32_t nbTxRepeatFlag = 1;
  sensor_t sensor_data;
  uint16_t pressure = 0;
  uint16_t humidity = 0;

  EnvSensors_Read(&sensor_data);

  temperature = (uint16_t)(sensor_data.temperature);
  pressure    = (uint16_t)(sensor_data.pressure * 100 / 10);      /* in hPa / 10 */
  humidity    = (uint16_t) sensor_data.humidity;

  APP_LOG(TS_ON, VLEVEL_L, "sending temperature=%d degC,  battery=%d mV", temperature, batteryLevel);

  ul_msg[ul_size++] = (uint8_t)((batteryLevel * 100) / 3300);
  ul_msg[ul_size++] = (pressure >> 8) & 0xFF;
  ul_msg[ul_size++] = pressure & 0xFF;
  ul_msg[ul_size++] = (temperature >> 8) & 0xFF;
  ul_msg[ul_size++] = temperature & 0xFF;
  ul_msg[ul_size++] = (humidity >> 8) & 0xFF;
  ul_msg[ul_size++] = humidity & 0xFF;

  SIGFOX_API_send_frame(ul_msg, ul_size, dl_msg, nbTxRepeatFlag, SFX_FALSE);

  APP_LOG(TS_OFF, VLEVEL_L, " done\n\r");
[/#if]
  /* USER CODE END SendSigfox */
}
[/#if]

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
