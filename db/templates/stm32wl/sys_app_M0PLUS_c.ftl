[#ftl]
/**
  ******************************************************************************
  * @file    sys_app.c
  * @author  MCD Application Team
  * @brief   Initializes HW and SW system entities (not related to the radio)
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

[#--
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
                ${definition.name}: ${definition.value}
        [/#list]
    [/#if]
[/#list]
--]
[#assign SUBGHZ_APPLICATION = ""]

[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "SUBGHZ_APPLICATION"]
                [#assign SUBGHZ_APPLICATION = definition.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]
/* Includes ------------------------------------------------------------------*/
#include <stdio.h>
#include "platform.h"
#include "sys_app.h"
#include "stm32_seq.h"
#include "stm32_systime.h"
#include "stm32_lpm.h"
#include "timer_if.h"
#include "utilities_def.h"
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
#include "sys_debug.h"
[/#if]

#include "msg_id.h"
#include "features_info.h"
#include "mbmuxif_sys.h"
#include "mbmuxif_trace.h"
#include "mbmuxif_radio.h"
[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE"))|| (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION") ]
#include "mbmuxif_lora.h"
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE")||(SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")|| (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION") ]
#include "mbmuxif_sigfox.h"
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE")||(SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") ]
#include "sgfx_eeprom_if.h"
[/#if]
[#if ((SUBGHZ_APPLICATION != "SUBGHZ_PINGPONG") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION")) ]
#ifdef ALLOW_KMS_VIA_MBMUX /* currently not supported */
#include "mbmuxif_kms.h"
#endif /* ALLOW_KMS_VIA_MBMUX */
[/#if]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION")]
#define MAX_TS_SIZE (int) 16
[/#if]
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/**
  * @brief Radio NVIC IRQ & MSI Wakeup SystemClock setting
  * @param none
  * @retval  none
  */
static void System_Init(void);

[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
/**
  * @brief  it calls UTIL_ADV_TRACE_VSNPRINTF
  */
static void tiny_snprintf_like(char *buf, uint32_t maxsize, const char *strFormat, ...);
[/#if]
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions ---------------------------------------------------------*/
/**
  * @brief initialises MBMUXIF System and send a notification to Cm4 when ready
  * @param none
  * @retval  none
  */
void SystemApp_Init(void)
{
  int8_t init_status;
  /* USER CODE BEGIN SystemApp_Init_1 */

  /* USER CODE END SystemApp_Init_1 */
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]

  /* RTC_Init: normally already executed by overloading HAL_InitTick(), but need to be sure before notify Cm4 */
  UTIL_TIMER_Init();

[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE")||(SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")|| (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION") ]
  __HAL_FLASH_CLEAR_FLAG(FLASH_FLAG_OPTVERR);
  E2P_Init();

  /*Set verbose LEVEL*/
  UTIL_ADV_TRACE_SetVerboseLevel(E2P_Read_VerboseLevel());
[/#if]

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
[/#if]

  /* Init Feat_Info table */
  FEAT_INFO_Init();

  /* Note: the trace is initialised in the context of MBMUXIF because it uses the MB on Cm0 side */
  init_status = MBMUXIF_SystemInit();
  if (init_status < 0)
  {
    Error_Handler();
  }

  System_Init();

[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  /* Configure the debug mode*/
  DBG_Init();
[/#if]

[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE")||(SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")|| (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION") ]
  /* Registers Sigfox Notif to the sequencer */
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_MbSigfoxNotifRcv), UTIL_SEQ_RFU, MBMUXIF_SigfoxSendNotifTask);
[/#if]

  /* USER CODE BEGIN SystemApp_Init_2 */

  /* USER CODE END SystemApp_Init_2 */
}

/**
  * @brief Returns sec and msec based on the systime in use
  * @param none
  * @retval  none
  */
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

[#if ((SUBGHZ_APPLICATION != "SUBGHZ_PINGPONG") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION")) ]
#ifdef ALLOW_KMS_VIA_MBMUX /* currently not supported */
void Process_Kms_Cmd(MBMUX_ComParam_t *ComObj)
{
  /* USER CODE BEGIN Process_Kms_Cmd_1 */

  /* USER CODE END Process_Kms_Cmd_1 */
  uint32_t *com_buffer = ComObj->ParamBuf;;

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
[/#if]

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

void UTIL_SEQ_EvtIdle(uint32_t task_id_bm, uint32_t evt_waited_bm)
{
  /**
    * overwrites the __weak UTIL_SEQ_EvtIdle() in stm32_seq.c
    * all to process all tack except task_id_bm
    */
  /* USER CODE BEGIN UTIL_SEQ_EvtIdle_1 */

  /* USER CODE END UTIL_SEQ_EvtIdle_1 */
  UTIL_SEQ_Run(~task_id_bm);
  /* USER CODE BEGIN UTIL_SEQ_EvtIdle_2 */

  /* USER CODE END UTIL_SEQ_EvtIdle_2 */
  return;
}

/**
  * @brief redefines __weak function in stm32_seq.c such to enter low power
  * @param none
  * @retval  none
  */
void UTIL_SEQ_Idle(void)
{
  /* USER CODE BEGIN UTIL_SEQ_Idle_1 */

  /* USER CODE END UTIL_SEQ_Idle_1 */
  UTIL_LPM_EnterLowPower();
  /* USER CODE BEGIN UTIL_SEQ_Idle_2 */

  /* USER CODE END UTIL_SEQ_Idle_2 */
}

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

  /* USER CODE BEGIN GetUniqueId_2 */

  /* USER CODE END GetUniqueId_2 */
}

uint32_t GetDevAddr(void)
{
  uint32_t val = 0;
  /* USER CODE BEGIN GetDevAddr_1 */

  /* USER CODE END GetDevAddr_1 */
  val = LL_FLASH_GetUDN();
  if (val == 0xFFFFFFFF)
  {
    val = ((HAL_GetUIDw0()) ^ (HAL_GetUIDw1()) ^ (HAL_GetUIDw2()));
  }
  /* USER CODE BEGIN GetDevAddr_2 */

  /* USER CODE END GetDevAddr_2 */
  return val;
}

/* USER CODE BEGIN ExF */

/* USER CODE END ExF */

/* Private functions ---------------------------------------------------------*/
static void System_Init(void)
{
  /* USER CODE BEGIN System_Init_1 */

  /* USER CODE END System_Init_1 */
  /* No need of Enable Internal Wake-up line for CPU2 */
  LL_C2_PWR_DisableInternWU();

  /**< Disable all wakeup interrupt on CPU2  except RTC(17,20) IPCC_CPU2(37), Radio(44,45), Debugger(46) */
  /* This is to avoid that Cm0 woke up as consequence of IRQs that are meant to reach onlt Cm4 */
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

[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
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

[/#if]
/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */

/* HAL overload functions ---------------------------------------------------------*/

[#if (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION") || (SUBGHZ_APPLICATION == "SUBGHZ_USER_APPLICATION") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION")]
/* Use #if 0 if you want to keep the default HAL istead overcharge them*/
/* USER CODE BEGIN Overload_HAL_weaks_1 */
#if 1
/* USER CODE END Overload_HAL_weaks_1 */

[/#if]
[#if cpucore!="" &&cpucore?replace("ARM_CORTEX_","")=="M0+"]
    [#if  timeBaseSource_M0PLUS??]
        [#assign timeBaseSource = timeBaseSource_M0PLUS]
    [/#if]
[/#if]
[#if timeBaseSource?? && timeBaseSource=="SysTick"]
/**
  * @brief This function configures the source of the time base.
  * @brief  don't enable systick
  * @param TickPriority: Tick interrupt priority.
  * @retval HAL status
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

/**
  * @brief Provide a tick value in millisecond measured using RTC
  * @note This function overwrites the __weak one from HAL
  * @retval tick value
  */
uint32_t HAL_GetTick(void)
{
  /* TIMER_IF can be based onother counter the SysTick e.g. RTC */
  /* USER CODE BEGIN HAL_GetTick_1 */

  /* USER CODE END HAL_GetTick_1 */
  return TIMER_IF_GetTimerValue();
  /* USER CODE BEGIN HAL_GetTick_2 */

  /* USER CODE END HAL_GetTick_2 */
}

/**
  * @brief This function provides delay (in ms)
  * @param Delay: specifies the delay time length, in milliseconds.
  * @retval None
  */
void HAL_Delay(__IO uint32_t Delay)
{
  /* TIMER_IF can be based onother counter the SysTick e.g. RTC */
  /* USER CODE BEGIN HAL_Delay_1 */

  /* USER CODE END HAL_Delay_1 */
  TIMER_IF_DelayMs(Delay);
  /* USER CODE BEGIN HAL_Delay_2 */

  /* USER CODE END HAL_Delay_2 */
}
[#if (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION") || (SUBGHZ_APPLICATION == "SUBGHZ_USER_APPLICATION") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION")]
/* USER CODE BEGIN Overload_HAL_weaks_2 */
#endif
/* Redefine here your own if needed */

/* USER CODE END Overload_HAL_weaks_2 */
[#else]

/* USER CODE BEGIN Overload_HAL_weaks */

/* USER CODE END Overload_HAL_weaks */
[/#if]

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
