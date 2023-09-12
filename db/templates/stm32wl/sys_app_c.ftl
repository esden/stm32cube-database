[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    sys_app.c
  * @author  MCD Application Team
  * @brief   Initializes HW and SW system entities (not related to the radio)
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
[#assign STM32WL5MXX = "false"]
[#assign USE_LPM = "true"]
[#assign USE_UART = "true"]
[#assign UTIL_SEQ_EN_M4 = "true"]
[#assign UTIL_SEQ_EN_M0 = "true"]
[#assign UTIL_TIMER_EN = "true"]
[#assign INTERNAL_LORAWAN_FUOTA = "0"]
[#assign INTERNAL_THREADX_TRACEX = "0"]
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
                [#if definition.name == "STM32WL5MXX"]
                    [#assign STM32WL5MXX = definition.value]
                [/#if]
                [#if definition.name == "USE_LPM"]
                    [#assign USE_LPM = definition.value]
                [/#if]
                [#if definition.name == "USE_UART"]
                    [#assign USE_UART = definition.value]
                [/#if]
                [#if definition.name == "UTIL_SEQ_EN_M4"]
                    [#assign UTIL_SEQ_EN_M4 = definition.value]
                [/#if]
                [#if definition.name == "UTIL_SEQ_EN_M0"]
                    [#assign UTIL_SEQ_EN_M0 = definition.value]
                [/#if]
                [#if definition.name == "UTIL_TIMER_EN"]
                    [#assign UTIL_TIMER_EN = definition.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]
[#if (CPUCORE == "CM0PLUS")]
    [#if  timeBaseSource_M0PLUS??]
        [#assign timeBaseSource = timeBaseSource_M0PLUS]
    [/#if]
[#elseif (CPUCORE == ("CM4"))]
    [#if  timeBaseSource_M4??]
        [#assign timeBaseSource = timeBaseSource_M4]
    [/#if]
[/#if]

/* Includes ------------------------------------------------------------------*/
#include <stdio.h>
#include "platform.h"
#include "sys_app.h"
[#if ((CPUCORE != "CM0PLUS") && (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_AT_SLAVE") && (SUBGHZ_APPLICATION != "SUBGHZ_ADV_APPLICATION"))]
#include "adc_if.h"
[/#if]
[#if THREADX??]
#include "app_threadx.h"
#include "tx_user.h"
[#elseif FREERTOS??]
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE == "CM4"))][#--  dual --]
#include "stm32_seq.h"
[#elseif ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE == ""))][#--  single --]
[#if ((SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION"))]
#include "stm32_seq.h"
[/#if]
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER_M0 vs SEQUENCER_M4 --]
#include "stm32_systime.h"
[#if (USE_LPM == "true")]
#include "stm32_lpm.h"
[/#if]
#include "timer_if.h"
#include "utilities_def.h"
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
#include "sys_debug.h"
[/#if]
[#if (SECURE_PROJECTS == "1") && (CPUCORE == "CM0PLUS") ]
#if defined (SECURE_UNPRIVILEGE_ENABLE) && (SECURE_UNPRIVILEGE_ENABLE == 1)
#include "sys_privileged_services.h"
#elif !defined (SECURE_UNPRIVILEGE_ENABLE)
#error SECURE_UNPRIVILEGE_ENABLE not defined
#endif /* SECURE_UNPRIVILEGE_ENABLE */
[/#if]
[#if (CPUCORE != "CM0PLUS") && ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")) ]
#include "sys_sensors.h"
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") ]
#include "sgfx_eeprom_if.h"
[/#if]
[#if (CPUCORE != "")][#--  !SINGLE --]
#include "msg_id.h"
#include "mbmuxif_sys.h"
[#if (USE_UART == "true")]
#include "mbmuxif_trace.h"
[/#if]
#include "mbmuxif_radio.h"
[#if (CPUCORE == "CM0PLUS")]
#include "features_info.h"
[/#if]
[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE"))|| (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION") ]
#include "mbmuxif_lora.h"
[/#if][#--  SUBGHZ_APPLICATION == "LORA_XXX" --]
[#if (INTERNAL_LORAWAN_FUOTA == "1")]
#include "mbmuxif_flash.h"
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION") ]
#include "mbmuxif_sigfox.h"
[#if (CPUCORE == "CM4")]
#include "sgfx_app.h"
[/#if]
[/#if][#--  SUBGHZ_APPLICATION == "SIGFOX_XXX" --]
[#if ((SUBGHZ_APPLICATION != "SUBGHZ_ADV_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION")) ]
#ifdef ALLOW_KMS_VIA_MBMUX /* currently not supported */
/* #include "mbmuxif_kms.h" */
#endif /* ALLOW_KMS_VIA_MBMUX */
[/#if][#--  SUBGHZ_APPLICATION == "SUBGHZ_XXX" --]
[/#if][#--  CPUCORE == !SINGLE --]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
[#if (SECURE_PROJECTS == "1") && (CPUCORE == "CM4") && (STM32WL5MXX == "false")]
#if ( DEBUGGER_ENABLED == 1 )
__IO uint32_t lets_go_on = 0;
#endif /* DEBUGGER_ENABLED */
[/#if]
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION")]
#define MAX_TS_SIZE (int) 16

[/#if]
[#if (CPUCORE != "CM0PLUS") && ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION"))]
/**
  * Defines the maximum battery level
  */
#define LORAWAN_MAX_BAT   254

[/#if]
[#if THREADX??]
/**
  * Tick rate reference 1ms
  */
#define configTICK_RATE_HZ_1MS                 1000

[#if (INTERNAL_THREADX_TRACEX == "1")]
/**
  * TraceX definitions: buffer size and max thread
  */
#define APP_TRACE_SIZE  (12*1024)
#define APP_MAX_THREAD  8
#define APP_TRACE_INFO  (TX_TRACE_USER_EVENT_START+1)

[/#if][#--  INTERNAL_THREADX_TRACEX --]
[/#if][#--  THREADX --]
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
[#if (SECURE_PROJECTS == "1") && (CPUCORE == "CM0PLUS") ]
static EXTI_HandleTypeDef Exti41;
[/#if]
[#if THREADX??]
[#if (USE_LPM == "true")]
static uint32_t Time_BeforeSleep;
static uint32_t Time_SleepFract = 0;
[/#if][#--  USE_LPM --]
[#else]
[#if (CPUCORE == "CM4")]
uint32_t InstanceIndex;
uint8_t SYS_Cm0plusRdyNotificationFlag = 0;
[/#if]
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
[#if (UTIL_TIMER_EN == "true")]
static uint8_t SYS_TimerInitialisedFlag = 0;
[/#if]
[#if (INTERNAL_THREADX_TRACEX == "1")]
#ifdef TX_ENABLE_EVENT_TRACE
uint8_t app_trace[APP_TRACE_SIZE];
#endif /* TX_ENABLE_EVENT_TRACE */
[/#if][#--  INTERNAL_THREADX_TRACEX --]

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
[#if (CPUCORE == "CM0PLUS")]
/**
  * @brief Radio NVIC IRQ & MSI Wakeup SystemClock setting
  */
static void System_Init(void);

[#elseif (CPUCORE == "CM4")]
/**
  * @brief Initialize MBMUX, wait CM0PLUS is ready, gets CM0PLUS capabilities, Initialize other features
  */
static void MBMUXIF_Init(void);

[/#if][#--  CPUCORE == CM4 vs CM0 --]
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
[#if (CPUCORE != "CM0PLUS")]
/**
  * @brief Returns sec and msec based on the systime in use
  * @param buff to update with timestamp
  * @param size of updated buffer
  */
static void TimestampNow(uint8_t *buff, uint16_t *size);

[/#if]
/**
  * @brief  it calls UTIL_ADV_TRACE_VSNPRINTF
  */
static void tiny_snprintf_like(char *buf, uint32_t maxsize, const char *strFormat, ...);

[/#if]
[#if (SECURE_PROJECTS == "1") && (CPUCORE == "CM0PLUS") ]
/**
  * @brief  Init the Exti used for sync the two CPU after SBSFU download
  */
static void MX_EXTI_Init(void);

[/#if][#--  SUBGHZ_APPLICATION != "XXX_USER_APPLICATION" --]
[#if THREADX??]
[#if (USE_LPM == "true")]
/**
  * @brief  Convert ms to AzRTOS ticks
  * @param  time in ms
  * @retval time in AzRTOS ticks
  */
static uint32_t app_azrtos_ms_to_tick(uint32_t ms);

/**
  * @brief  Convert time in RTOS ticks to ms
  * @param  value in RTOS tick
  * @retval value in milliseconds
  */
static uint32_t app_azrtos_tick_to_ms(uint32_t tick);

[/#if][#--  USE_LPM --]
[/#if][#--  THREADX --]
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions ---------------------------------------------------------*/
[#if THREADX??]
[#if (USE_LPM == "true")]
void App_ThreadX_LowPower_Enter(void)
{
  /* Called by the kernel before it places the MCU into a LowPower mode .

  NOTE:  Additional actions can be taken here to get the power consumption
  even lower.  For example, peripherals can be turned off here, and then back
  on again in the post sleep processing function.  For maximum power saving
  ensure all unused pins are in their lowest power state. */

  /* USER CODE BEGIN App_ThreadX_LowPower_Enter_0 */

  /* USER CODE END App_ThreadX_LowPower_Enter_0 */

  /*Get Current Time*/
  Time_BeforeSleep = UTIL_TIMER_GetCurrentTime();

  /*Enter to LowPower Mode using the Utilities LPM functions*/
  UTIL_LPM_EnterLowPower();

  /* USER CODE BEGIN App_ThreadX_LowPower_Enter_Last */

  /* USER CODE END App_ThreadX_LowPower_Enter_Last */
}

void App_ThreadX_LowPower_Exit(void)
{
  /* USER CODE BEGIN App_ThreadX_LowPower_Exit */

  /* USER CODE END App_ThreadX_LowPower_Exit */
}

unsigned long App_ThreadX_LowPower_Timer_Adjust(void)
{
  uint32_t  ret = 0;
  uint32_t SleepDuration = UTIL_TIMER_GetElapsedTime(Time_BeforeSleep);

  /* USER CODE BEGIN App_ThreadX_LowPower_Timer_Adjust_0 */

  /* USER CODE END App_ThreadX_LowPower_Timer_Adjust_0 */

  if (TX_TIMER_TICKS_PER_SECOND < configTICK_RATE_HZ_1MS)
  {
    /* keep the fractional part and add it next time */
    ret =  app_azrtos_ms_to_tick(SleepDuration + Time_SleepFract);
    Time_SleepFract = (SleepDuration + Time_SleepFract) - app_azrtos_tick_to_ms(ret);
  }

  /* USER CODE BEGIN App_ThreadX_LowPower_Timer_Adjust_Last */

  /* USER CODE END App_ThreadX_LowPower_Timer_Adjust_Last */
  return ret;
}

[/#if][#--  USE_LPM --]
[/#if][#--  THREADX --]
void SystemApp_Init(void)
{
[#if (CPUCORE == "CM0PLUS")]
  int8_t init_status;
[/#if]
  /* USER CODE BEGIN SystemApp_Init_1 */

  /* USER CODE END SystemApp_Init_1 */

[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
[#if (CPUCORE != "CM0PLUS")]
  /* Ensure that MSI is wake-up system clock */
  __HAL_RCC_WAKEUPSTOP_CLK_CONFIG(RCC_STOP_WAKEUPCLOCK_MSI);

[#else]
  /* RTC_Init: normally already executed by overloading HAL_InitTick(), but need to be sure before notify Cm4 */
[/#if][#--  CPUCORE == CM4 vs CM0 vs SINGLE --]
[#if (CPUCORE != "CM4")]
  /*Initialize timer and RTC*/
  UTIL_TIMER_Init();
  SYS_TimerInitialisedFlag = 1;
[/#if][#--  CPUCORE == !CM4 --]
[#if (CPUCORE != "CM0PLUS")]
  /* Initializes the SW probes pins and the monitor RF pins via Alternate Function */
  DBG_Init();

[#if (INTERNAL_THREADX_TRACEX == "1")]
  /*Initialize TRACEX */
#ifdef TX_ENABLE_EVENT_TRACE
  tx_trace_enable(app_trace, sizeof(app_trace), APP_MAX_THREAD);
  /* to filter some default trace that we don't want to see with TraceX */
  tx_trace_event_filter(TX_TRACE_INTERNAL_EVENTS);
#endif /* TX_ENABLE_EVENT_TRACE */

[/#if]
  /*Initialize the terminal */
  UTIL_ADV_TRACE_Init();
  UTIL_ADV_TRACE_RegisterTimeStampFunction(TimestampNow);

[/#if][#--  CPUCORE == !CM0PLUS --]
[#if ((CPUCORE != "CM4") && ((SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") || (INTERNAL_LORAWAN_FUOTA == "1"))) || ((CPUCORE != "CM0PLUS") && ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE"))) ]
  /* #warning "should be removed when proper obl is done" */
  __HAL_FLASH_CLEAR_FLAG(FLASH_FLAG_OPTVERR);

[/#if]
[#if (CPUCORE != "CM4") && ((SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON"))]
  E2P_Init();
[/#if]

[#if (CPUCORE != "CM0PLUS")]
  /*Set verbose LEVEL*/
[#if (CPUCORE == "") && ((SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")) ]
[#if !THREADX??]
  UTIL_ADV_TRACE_SetVerboseLevel(E2P_Read_VerboseLevel());
[#else]
  UTIL_ADV_TRACE_SetVerboseLevel(VERBOSE_LEVEL);
[/#if]
[#else]
  UTIL_ADV_TRACE_SetVerboseLevel(VERBOSE_LEVEL);
[/#if]

[#if (SUBGHZ_APPLICATION != "SUBGHZ_ADV_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_AT_SLAVE")]
  /*Initialize the temperature and Battery measurement services */
  SYS_InitMeasurement();
[/#if]

[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")) ]
  /*Initialize the Sensors */
  EnvSensors_Init();
[/#if]
[/#if][#--  CPUCORE == != "CM0PLUS" --]

  /*Init low power manager*/
  UTIL_LPM_Init();
  /* Disable Stand-by mode */
  UTIL_LPM_SetOffMode((1 << CFG_LPM_APPLI_Id), UTIL_LPM_DISABLE);

#if defined (LOW_POWER_DISABLE) && (LOW_POWER_DISABLE == 1)
  /* Disable Stop Mode */
  UTIL_LPM_SetStopMode((1 << CFG_LPM_APPLI_Id), UTIL_LPM_DISABLE);
#elif !defined (LOW_POWER_DISABLE)
#error LOW_POWER_DISABLE not defined
#endif /* LOW_POWER_DISABLE */

[/#if][#--  SUBGHZ_APPLICATION != "XXX_USER_APPLICATION" --]
[#if (SECURE_PROJECTS == "1") && (CPUCORE == "CM0PLUS") ]
  /* Init the Exti used for sync the two CPU after SBSFU download */
  MX_EXTI_Init();

#if defined (SECURE_UNPRIVILEGE_ENABLE) && (SECURE_UNPRIVILEGE_ENABLE == 1)
  ThumbState_RemapMspAndSwitchToPspStack();
  ThumbState_EnterUnprivilegedMode();
#elif !defined (SECURE_UNPRIVILEGE_ENABLE)
#error SECURE_UNPRIVILEGE_ENABLE not defined
#endif /* SECURE_UNPRIVILEGE_ENABLE */

  /* Wait for CPU1 to be ready */
  while (HAL_EXTI_GetPending(&Exti41, EXTI_TRIGGER_RISING_FALLING) != 0x01u)
  {
    /* Wait CPU1 Event */
  }
  /* Acknowledge CPU1 event */
  HAL_EXTI_ClearPending(&Exti41, EXTI_TRIGGER_RISING_FALLING);

[/#if]
[#if (CPUCORE == "CM4")]
  /*Initialize MBMux (to be done after LPM because MBMux uses the sequencer) */
  MBMUXIF_Init();

[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")]
  /*Update verbose LEVEL with EEPROM content*/
  UTIL_ADV_TRACE_SetVerboseLevel(E2P_Read_VerboseLevel());

[/#if]
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  /* Initialise only TimeServer. RTC Init already done by CM0PLUS */
  UTIL_TIMER_Init();
  SYS_TimerInitialisedFlag = 1;
[/#if]

[#elseif (CPUCORE == "CM0PLUS")]
  /* Init Feat_Info table */
  FEAT_INFO_Init();

  /* Note: the trace is initialized in the context of MBMUXIF because it uses the MB on Cm0 side */
  init_status = MBMUXIF_SystemInit();
  if (init_status < 0)
  {
    Error_Handler();
  }

  System_Init();

[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION") ]
[#if (UTIL_SEQ_EN_M0 == "true") ]
  /* Registers Sigfox Notif to the sequencer */
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_MbSigfoxNotifRcv), UTIL_SEQ_RFU, MBMUXIF_SigfoxSendNotifTask);
[/#if]
[/#if]
[/#if][#--  CPUCORE == CM4 vs CM0 --]

[#if (CPUCORE != "") || ((SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION"))]
  /* USER CODE BEGIN SystemApp_Init_2 */

  /* USER CODE END SystemApp_Init_2 */
[/#if]
}

[#if (CPUCORE == "CM4")]
void Process_Sys_Notif(MBMUX_ComParam_t *ComObj)
{
  /* USER CODE BEGIN Process_Sys_Notif_1 */

  /* USER CODE END Process_Sys_Notif_1 */
  uint32_t  notif_ack_id;

  notif_ack_id = ComObj->MsgId;

  switch (notif_ack_id)
  {
    case SYS_RTC_ALARM_MSG_ID:
      /* USER CODE BEGIN Process_Sys_Notif_RTC_ALARM */

      /* USER CODE END Process_Sys_Notif_RTC_ALARM */
      break;
    case SYS_OTHER_MSG_ID:
      APP_LOG(TS_ON, VLEVEL_H, "CM4<(System)\r\n");
      /* prepare ack buffer*/
      ComObj->ParamCnt = 0;
      ComObj->ReturnVal = 0; /* dummy value  */
      /* USER CODE BEGIN Process_Sys_Notif_OTHER */

      /* USER CODE END Process_Sys_Notif_OTHER */
      break;
    default:
      /* USER CODE BEGIN Process_Sys_Notif_DEFAULT */

      /* USER CODE END Process_Sys_Notif_DEFAULT */
      break;
  }

  /* Send ack*/
  APP_LOG(TS_ON, VLEVEL_H, "CM4>(System)\r\n");
  MBMUXIF_SystemSendAck(FEAT_INFO_SYSTEM_ID);
  /* USER CODE BEGIN Process_Sys_Notif_2 */

  /* USER CODE END Process_Sys_Notif_2 */
}

[#elseif (CPUCORE == "CM0PLUS")]
void TimestampNow(uint8_t *buff, uint16_t *size)
{
  /* USER CODE BEGIN TimestampNow_1 */

  /* USER CODE END TimestampNow_1 */
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  SysTime_t curtime = SysTimeGet();
  tiny_snprintf_like((char *)buff, MAX_TS_SIZE, "%ds%03d:", curtime.Seconds, curtime.SubSeconds);
  *size = strlen((char *)buff);
  /* USER CODE BEGIN TimestampNow_2 */

  /* USER CODE END TimestampNow_2 */
[/#if]
}

[#if ((SUBGHZ_APPLICATION != "SUBGHZ_ADV_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION")) ]
#ifdef ALLOW_KMS_VIA_MBMUX /* currently not supported */
void Process_Kms_Cmd(MBMUX_ComParam_t *ComObj)
{
  /* USER CODE BEGIN Process_Kms_Cmd_1 */

  /* USER CODE END Process_Kms_Cmd_1 */
  uint32_t *com_buffer = MBMUX_SEC_VerifySramBufferPtr(ComObj->ParamBuf, ComObj->BufSize);

  APP_LOG(TS_ON, VLEVEL_L, ">CM0PLUS(KMS)\r\n");

  /* process Command */
  switch (ComObj->MsgId)
  {
    case KMS_CRYPTO_HMAC_SHA256_MSG_ID:
      APP_LOG(TS_ON, VLEVEL_L, " * CM0 Cmd rcv : KMS_CRYPTO_HMAC_SHA256_MSG_ID\r\n");
      APP_LOG(TS_ON, VLEVEL_L, " * CM0 Crypto aKey length %d\r\n", com_buffer[1]);
      APP_LOG(TS_ON, VLEVEL_L, " * CM0 Crypto aKey string %s\r\n", (char *) com_buffer[0]);
      /* prepare response buffer */
      ComObj->ParamCnt = 0;
      ComObj->ReturnVal = (uint32_t) -5; /* dummy value for test */
      break;

    default:
      break;
  }

  /* send Response */
  APP_LOG(TS_ON, VLEVEL_L, "<CM0PLUS(KMS)\r\n");
  MBMUX_ResponseSnd(FEAT_INFO_KMS_ID);

  /* USER CODE BEGIN Process_Kms_Cmd_2 */

  /* USER CODE END Process_Kms_Cmd_2 */
}
#endif /* ALLOW_KMS_VIA_MBMUX */
[/#if][#--  SUBGHZ_APPLICATION != XXX --]

void Process_Sys_Cmd(MBMUX_ComParam_t *ComObj)
{
  /* USER CODE BEGIN Process_Sys_Cmd_1 */

  /* USER CODE END Process_Sys_Cmd_1 */
  APP_LOG(TS_ON, VLEVEL_L, ">CM0PLUS(System)\r\n");

  /* process Command */
  switch (ComObj->MsgId)
  {
    case SYS_OTHER_MSG_ID:
      /* USER CODE BEGIN Process_Sys_Cmd_switch_msg_id */

      /* USER CODE END Process_Sys_Cmd_switch_msg_id */
      break;

    /* USER CODE BEGIN Process_Sys_Cmd_switch_case */

    /* USER CODE END Process_Sys_Cmd_switch_case */

    default:
      /* USER CODE BEGIN Process_Sys_Cmd_switch_default */

      /* USER CODE END Process_Sys_Cmd_switch_default */
      break;
  }

  /* send Response */
  APP_LOG(TS_ON, VLEVEL_M, "<CM0PLUS(System)\r\n");
  MBMUX_ResponseSnd(FEAT_INFO_SYSTEM_ID);
  /* USER CODE BEGIN Process_Sys_Cmd_2 */

  /* USER CODE END Process_Sys_Cmd_2 */
}
[/#if][#--  CPUCORE == CM4 vs CM0 --]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
[#if !THREADX??][#-- If AzRtos is not used --]
[#if ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE == "CM4"))][#--  DUAL && UTIL_SEQ_EN --]

void UTIL_SEQ_EvtIdle(uint32_t TaskId_bm, uint32_t EvtWaited_bm)
{
  /**
    * overwrites the __weak UTIL_SEQ_EvtIdle() in stm32_seq.c
    * all to process all tack except TaskId_bm
    */
  /* USER CODE BEGIN UTIL_SEQ_EvtIdle_1 */

  /* USER CODE END UTIL_SEQ_EvtIdle_1 */
  UTIL_SEQ_Run(~TaskId_bm);
  /* USER CODE BEGIN UTIL_SEQ_EvtIdle_2 */

  /* USER CODE END UTIL_SEQ_EvtIdle_2 */
  return;
}
[/#if][#--  CPUCORE == DUAL && UTIL_SEQ_EN --]
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]

/**
  * @brief redefines __weak function in stm32_seq.c such to enter low power
  */
void UTIL_SEQ_Idle(void)
{
  /* USER CODE BEGIN UTIL_SEQ_Idle_1 */

  /* USER CODE END UTIL_SEQ_Idle_1 */
  UTIL_LPM_EnterLowPower();
  /* USER CODE BEGIN UTIL_SEQ_Idle_2 */

  /* USER CODE END UTIL_SEQ_Idle_2 */
}
[/#if]
[/#if]
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]

[#if (CPUCORE != "CM0PLUS")]
[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION"))]
uint8_t GetBatteryLevel(void)
{
  uint8_t batteryLevel = 0;
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
  uint16_t batteryLevelmV;
[/#if]

  /* USER CODE BEGIN GetBatteryLevel_0 */

  /* USER CODE END GetBatteryLevel_0 */

[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
  batteryLevelmV = (uint16_t) SYS_GetBatteryLevel();

  /* Convert battery level from mV to linear scale: 1 (very low) to 254 (fully charged) */
  if (batteryLevelmV > VDD_BAT)
  {
    batteryLevel = LORAWAN_MAX_BAT;
  }
  else if (batteryLevelmV < VDD_MIN)
  {
    batteryLevel = 0;
  }
  else
  {
    batteryLevel = (((uint32_t)(batteryLevelmV - VDD_MIN) * LORAWAN_MAX_BAT) / (VDD_BAT - VDD_MIN));
  }

  /* USER CODE BEGIN GetBatteryLevel_2 */

  /* USER CODE END GetBatteryLevel_2 */

[/#if]
  return batteryLevel;  /* 1 (very low) to 254 (fully charged) */
}
[/#if][#--  SUBGHZ_APPLICATION == "LORA_XXX" --]

[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") || (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE"))]
int16_t GetTemperatureLevel(void)
{
  int16_t temperatureLevel = 0;

[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE")]
  temperatureLevel = (int16_t)(SYS_GetTemperatureLevel() >> 8);
[#elseif ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON"))]
  sensor_t sensor_data;

  EnvSensors_Read(&sensor_data);
  temperatureLevel = (int16_t)(sensor_data.temperature);
[/#if]
  /* USER CODE BEGIN GetTemperatureLevel */

  /* USER CODE END GetTemperatureLevel */
  return temperatureLevel;
}

[/#if][#--  SUBGHZ_APPLICATION == "LORA_XXX" || SIGFOX_XXX --]
[/#if][#--  CPUCORE != "CM0PLUS" --]
[#if CPUCORE != "CM4"]
[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION"))]
void GetUniqueId(uint8_t *id)
{
  /* USER CODE BEGIN GetUniqueId_1 */

  /* USER CODE END GetUniqueId_1 */
  uint32_t val = 0;
  val = LL_FLASH_GetUDN();
  if (val == 0xFFFFFFFF)  /* Normally this should not happen */
  {
    uint32_t ID_1_3_val = HAL_GetUIDw0() + HAL_GetUIDw2();
    uint32_t ID_2_val = HAL_GetUIDw1();

    id[7] = (ID_1_3_val) >> 24;
    id[6] = (ID_1_3_val) >> 16;
    id[5] = (ID_1_3_val) >> 8;
    id[4] = (ID_1_3_val);
    id[3] = (ID_2_val) >> 24;
    id[2] = (ID_2_val) >> 16;
    id[1] = (ID_2_val) >> 8;
    id[0] = (ID_2_val);
  }
  else  /* Typical use case */
  {
    id[7] = val & 0xFF;
    id[6] = (val >> 8) & 0xFF;
    id[5] = (val >> 16) & 0xFF;
    id[4] = (val >> 24) & 0xFF;
    val = LL_FLASH_GetDeviceID();
    id[3] = val & 0xFF;
    val = LL_FLASH_GetSTCompanyID();
    id[2] = val & 0xFF;
    id[1] = (val >> 8) & 0xFF;
    id[0] = (val >> 16) & 0xFF;
  }

[#if (INTERNAL_THREADX_TRACEX == "1")]
#ifdef TX_ENABLE_EVENT_TRACE
  /* Example of User Event (UE) traceX usage to see on traceX the variable "val" and the constant 0xABCD*/
  tx_trace_user_event_insert(APP_TRACE_INFO, 0, val, 0, 0xABCD);
#endif /* TX_ENABLE_EVENT_TRACE */
[/#if]
  /* USER CODE BEGIN GetUniqueId_2 */

  /* USER CODE END GetUniqueId_2 */
}

void GetDevAddr(uint32_t *devAddr)
{
  /* USER CODE BEGIN GetDevAddr_1 */

  /* USER CODE END GetDevAddr_1 */

  *devAddr = LL_FLASH_GetUDN();
  if (*devAddr == 0xFFFFFFFF)
  {
    *devAddr = ((HAL_GetUIDw0()) ^ (HAL_GetUIDw1()) ^ (HAL_GetUIDw2()));
  }

  /* USER CODE BEGIN GetDevAddr_2 */

  /* USER CODE END GetDevAddr_2 */
}

[/#if][#--  SUBGHZ_APPLICATION == "LORA_XXX" --]
[/#if][#--  CPUCORE != "CM4" --]
/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private functions ---------------------------------------------------------*/
[#if (CPUCORE == "CM4")]
static void MBMUXIF_Init(void)
{
  /* USER CODE BEGIN MBMUXIF_Init_1 */

  /* USER CODE END MBMUXIF_Init_1 */
  FEAT_INFO_List_t *p_cm0plus_supported_features_list;
  int8_t init_status;

  APP_LOG(TS_ON, VLEVEL_H, "\r\nCM4: System Initialization started \r\n");

  init_status = MBMUXIF_SystemInit();
  if (init_status < 0)
  {
    Error_Handler();
  }

  /* start CM0PLUS */
  /* Note: when debugging in order to connect with the debugger CPU2 shall be start using workspace CM4 starts CM0PLUS */
  /* On the other hand is up to the developer make sure the CM0PLUS debugger is run after CM4 debugger */
  HAL_PWREx_ReleaseCore(PWR_CORE_CPU2);

[#if (SECURE_PROJECTS == "1") && (CPUCORE == "CM4")]
  /* Warn CPU2 that CPU1 is ready */
  /* Set Cpu Event then consume it to allow next low power entry */
  __SEV();
  __WFE();

[#if (STM32WL5MXX == "false")]
  /* Push Button for stop the core in other to attach debugger */
#if ( DEBUGGER_ENABLED == 1 )
  APP_LOG(TS_ON, VLEVEL_L, "\r\nPress PushButton2 to continue \r\n");
  while (lets_go_on == 0);
  lets_go_on = 0;
#endif /* DEBUGGER_ENABLED */

[/#if]
[/#if]
  /* CM4 has started and it has reset the mailbox and initialized the MbMux; */
  /* once CM0PLUS is also initialized it send a SYS notification */
  MBMUXIF_SetCpusSynchroFlag(CPUS_BOOT_SYNC_ALLOW_CPU2_TO_START);

  APP_LOG(TS_ON, VLEVEL_H, "CM4: System Initialization done: Wait for CM0PLUS \r\n");

  MBMUXIF_WaitCm0MbmuxIsInitialized();

  APP_LOG(TS_ON, VLEVEL_H, "CM0PLUS: System Initialization started \r\n");

  p_cm0plus_supported_features_list = MBMUXIF_SystemSendCm0plusInfoListReq();
  MBMUX_SetCm0plusFeatureListPtr(p_cm0plus_supported_features_list);

  APP_LOG(TS_ON, VLEVEL_H, "System Initialization CM4-CM0PLUS completed \r\n");

[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  init_status = MBMUXIF_SystemPrio_Add(FEAT_INFO_SYSTEM_NOTIF_PRIO_A_ID);
  if (init_status < 0)
  {
    Error_Handler();
  }
[/#if]
  MBMUXIF_SetCpusSynchroFlag(CPUS_BOOT_SYNC_RTC_REGISTERED);
  APP_LOG(TS_ON, VLEVEL_H, "System_Priority_A Registration for RTC Alarm handling completed \r\n");

[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  init_status = MBMUXIF_TraceInit();
  if (init_status < 0)
  {
    Error_Handler();
  }
  APP_LOG(TS_ON, VLEVEL_H, "Trace registration CM4-CM0PLUS completed \r\n");

[/#if]
[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION"))]
  init_status = MBMUXIF_LoraInit();
  if (init_status < 0)
  {
    Error_Handler();
  }
  APP_LOG(TS_ON, VLEVEL_H, "Lora registration CM4-CM0PLUS completed \r\n");

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "SUBGHZ_ADV_APPLICATION") || (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION")]
  init_status = MBMUXIF_RadioInit();
  if (init_status < 0)
  {
    Error_Handler();
  }
  APP_LOG(TS_ON, VLEVEL_H, "Radio registration CM4-CM0PLUS completed \r\n");

[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE")||(SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")|| (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION") ]
  init_status = MBMUXIF_SigfoxInit();
  if (init_status < 0)
  {
    Error_Handler();
  }
  APP_LOG(TS_ON, VLEVEL_H, "Sigfox registration CM4-CM0PLUS completed \n\r");

[/#if]
[#if (INTERNAL_LORAWAN_FUOTA == "1")]
  init_status = MBMUXIF_FlashInit();
  if (init_status < 0)
  {
    Error_Handler();
  }
  APP_LOG(TS_ON, VLEVEL_H, "Flash registration CM4-CM0PLUS completed \n\r");

[/#if]
  /* USER CODE BEGIN MBMUXIF_Init_Last */

  /* USER CODE END MBMUXIF_Init_Last */
}
[#elseif (CPUCORE == "CM0PLUS")]
static void System_Init(void)
{
  /* USER CODE BEGIN System_Init_1 */

  /* USER CODE END System_Init_1 */
  /* No need of Enable Internal Wake-up line for CPU2 */
  LL_C2_PWR_DisableInternWU();

  /**< Disable all wakeup interrupt on CPU2  except RTC(17,20) IPCC_CPU2(37), Radio(44,45), Debugger(46) */
  /* This is to avoid that Cm0 woke up as consequence of IRQs that are meant to reach only Cm4 */
  LL_C2_EXTI_DisableIT_0_31(~0  & (~(LL_EXTI_LINE_17 | LL_EXTI_LINE_20)));
  LL_C2_EXTI_DisableIT_32_63((~0) & (~(LL_EXTI_LINE_37 | (0x1U << (7u)) | LL_EXTI_LINE_44 | LL_EXTI_LINE_45 | LL_EXTI_LINE_46)));

  /* Enable Radio IRQ lines interrupt for CPU2 */
  LL_C2_PWR_SetRadioIRQTrigger(LL_PWR_RADIO_IRQ_TRIGGER_WU_IT);
  /* Enable Radio EXTI lines for CPU2 (Needed for low power STOP mode */
  LL_C2_EXTI_EnableIT_32_63(LL_EXTI_LINE_44);
  LL_C2_EXTI_EnableIT_32_63(LL_EXTI_LINE_45);

  /* Ensure that MSI is wake-up system clock */
  __HAL_RCC_WAKEUPSTOP_CLK_CONFIG(RCC_STOP_WAKEUPCLOCK_MSI);
  /* USER CODE BEGIN System_Init_Last */

  /* USER CODE END System_Init_Last */
}

[/#if][#--  CPUCORE == CM4 vs CM0 --]
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
[#if (CPUCORE != "CM0PLUS")]

static void TimestampNow(uint8_t *buff, uint16_t *size)
{
  /* USER CODE BEGIN TimestampNow_1 */

  /* USER CODE END TimestampNow_1 */
  SysTime_t curtime = SysTimeGet();
  tiny_snprintf_like((char *)buff, MAX_TS_SIZE, "%ds%03d:", curtime.Seconds, curtime.SubSeconds);
  *size = strlen((char *)buff);
  /* USER CODE BEGIN TimestampNow_2 */

  /* USER CODE END TimestampNow_2 */
}

[/#if]
/* Disable StopMode when traces need to be printed */
void UTIL_ADV_TRACE_PreSendHook(void)
{
  /* USER CODE BEGIN UTIL_ADV_TRACE_PreSendHook_1 */

  /* USER CODE END UTIL_ADV_TRACE_PreSendHook_1 */
  UTIL_LPM_SetStopMode((1 << CFG_LPM_UART_TX_Id), UTIL_LPM_DISABLE);
  /* USER CODE BEGIN UTIL_ADV_TRACE_PreSendHook_2 */

  /* USER CODE END UTIL_ADV_TRACE_PreSendHook_2 */
}
/* Re-enable StopMode when traces have been printed */
void UTIL_ADV_TRACE_PostSendHook(void)
{
  /* USER CODE BEGIN UTIL_LPM_SetStopMode_1 */

  /* USER CODE END UTIL_LPM_SetStopMode_1 */
  UTIL_LPM_SetStopMode((1 << CFG_LPM_UART_TX_Id), UTIL_LPM_ENABLE);
  /* USER CODE BEGIN UTIL_LPM_SetStopMode_2 */

  /* USER CODE END UTIL_LPM_SetStopMode_2 */
}

static void tiny_snprintf_like(char *buf, uint32_t maxsize, const char *strFormat, ...)
{
  /* USER CODE BEGIN tiny_snprintf_like_1 */

  /* USER CODE END tiny_snprintf_like_1 */
  va_list vaArgs;
  va_start(vaArgs, strFormat);
  UTIL_ADV_TRACE_VSNPRINTF(buf, maxsize, strFormat, vaArgs);
  va_end(vaArgs);
  /* USER CODE BEGIN tiny_snprintf_like_2 */

  /* USER CODE END tiny_snprintf_like_2 */
}

[/#if][#--  SUBGHZ_APPLICATION != "XXX_USER_APPLICATION" --]
[#if (SECURE_PROJECTS == "1") && (CPUCORE == "CM0PLUS") ]
/**
  * Enable EXTI controller
  * Configure line 41
  */
static void MX_EXTI_Init(void)
{
  EXTI_ConfigTypeDef exit41config;

  exit41config.Line = EXTI_LINE_41;
  exit41config.Mode = EXTI_MODE_INTERRUPT;
  exit41config.Trigger = EXTI_TRIGGER_RISING;
  HAL_EXTI_SetConfigLine(&Exti41, &exit41config);
}

[/#if]
[#if THREADX??]
[#if (USE_LPM == "true")]
static uint32_t app_azrtos_ms_to_tick(uint32_t ms)
{
  uint32_t tick = ms;
  if (TX_TIMER_TICKS_PER_SECOND != configTICK_RATE_HZ_1MS)
  {
    tick = (uint32_t)((((uint64_t)(ms)) * TX_TIMER_TICKS_PER_SECOND) / configTICK_RATE_HZ_1MS);
  }
  return tick;
}

static uint32_t app_azrtos_tick_to_ms(uint32_t tick)
{
  uint32_t ms = tick;
  if (TX_TIMER_TICKS_PER_SECOND != configTICK_RATE_HZ_1MS)
  {
    ms = (uint32_t)((((uint64_t)(tick)) * configTICK_RATE_HZ_1MS) / TX_TIMER_TICKS_PER_SECOND);
  }
  return ms;
}

[/#if][#--  USE_LPM --]
[/#if][#--  THREADX --]
/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */

/* HAL overload functions ---------------------------------------------------------*/

[#if (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION") || (SUBGHZ_APPLICATION == "SUBGHZ_USER_APPLICATION") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION")]
/* Set #if 0 if you want to keep the default HAL instead overcharge them*/
/* USER CODE BEGIN Overload_HAL_weaks_1 */
#if 1
/* USER CODE END Overload_HAL_weaks_1 */

[/#if]
[#if (timeBaseSource??) && (timeBaseSource=="None")]
/**
  * @note This function overwrites the __weak one from HAL
  */
HAL_StatusTypeDef HAL_InitTick(uint32_t TickPriority)
{
  /*Don't enable SysTick if TIMER_IF is based on other counters (e.g. RTC) */
  /* USER CODE BEGIN HAL_InitTick_1 */

  /* USER CODE END HAL_InitTick_1 */
  return HAL_OK;
  /* USER CODE BEGIN HAL_InitTick_2 */

  /* USER CODE END HAL_InitTick_2 */
}
[/#if]

[#if (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION") || (SUBGHZ_APPLICATION == "SUBGHZ_USER_APPLICATION") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION")]
/* USER CODE BEGIN Overload_HAL_weaks_1a */

/* USER CODE END Overload_HAL_weaks_1a */

[/#if]
[#if (UTIL_TIMER_EN == "true")]
/**
  * @note This function overwrites the __weak one from HAL
  */
uint32_t HAL_GetTick(void)
{
  uint32_t ret = 0;
  /* TIMER_IF can be based on other counter the SysTick e.g. RTC */
  /* USER CODE BEGIN HAL_GetTick_1 */

  /* USER CODE END HAL_GetTick_1 */
  if (SYS_TimerInitialisedFlag == 0)
  {
    /* TIMER_IF_GetTimerValue should be used only once UTIL_TIMER_Init() is initialized */
    /* If HAL_Delay or a TIMEOUT countdown is necessary during initialization phase */
    /* please use temporarily another timebase source (SysTick or TIMx), which implies also */
    /* to rework the above function HAL_InitTick() and to call HAL_IncTick() on the timebase IRQ */
[#if (CPUCORE == "CM4")]
    /* Note: In DualCore UTIL_TIMER_Init() is called rather late because it needs first CM0PLUS to init RTC */
[#else]
    /* Note: when TIMER_IF is based on RTC, stm32wlxx_hal_rtc.c calls this function before TimeServer is functional */
    /* RTC TIMEOUT will not expire, i.e. if RTC has an hw problem it will keep looping in the RTC_Init function */
[/#if]
    /* USER CODE BEGIN HAL_GetTick_EarlyCall */

    /* USER CODE END HAL_GetTick_EarlyCall */
  }
  else
  {
    ret = TIMER_IF_GetTimerValue();
  }
  /* USER CODE BEGIN HAL_GetTick_2 */

  /* USER CODE END HAL_GetTick_2 */
  return ret;
}

/**
  * @note This function overwrites the __weak one from HAL
  */
void HAL_Delay(__IO uint32_t Delay)
{
  /* TIMER_IF can be based on other counter the SysTick e.g. RTC */
  /* USER CODE BEGIN HAL_Delay_1 */

  /* USER CODE END HAL_Delay_1 */
  TIMER_IF_DelayMs(Delay);
  /* USER CODE BEGIN HAL_Delay_2 */

  /* USER CODE END HAL_Delay_2 */
}

[/#if][#--  UTIL_TIMER_EN --]
[#if (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION") || (SUBGHZ_APPLICATION == "SUBGHZ_USER_APPLICATION") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION")]
/* USER CODE BEGIN Overload_HAL_weaks_2 */
#endif /* 1 default HAL overcharge */
/* if needed set #if 0 and redefine here your own "Tick" functions*/

/* USER CODE END Overload_HAL_weaks_2 */
[#else]

/* USER CODE BEGIN Overload_HAL_weaks */

/* USER CODE END Overload_HAL_weaks */
[/#if]
