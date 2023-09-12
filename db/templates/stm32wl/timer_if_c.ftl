[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    timer_if.c
  * @author  MCD Application Team
  * @brief   Configure RTC Alarm, Tick and Calendar manager
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
[#assign RTC_Instance = ""]
[#list BspIpDatas as SWIP]
    [#if SWIP.variables??]
        [#list SWIP.variables as variables]
            [#if variables.name?contains("IpInstance")]
                [#assign IpInstance = variables.value]
            [/#if]
            [#if variables.name?contains("IpName")]
                [#assign IpName = variables.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]

/* Includes ------------------------------------------------------------------*/
#include <math.h>
#include "main.h" /*for Mx generated RTC_N_PREDIV_S and RTC_N_PREDIV_A*/
[#if CPUCORE != "CM4"]
[#if HALCompliant??]
#include "main.h"
[#else]
#include "rtc.h"
[/#if]
[/#if]
#include "timer_if.h"
#include "stm32_lpm.h"
#include "utilities_def.h"
#include "stm32wlxx_ll_rtc.h"
[#if CPUCORE == "CM0PLUS"]
#include "msg_id.h"
#include "mbmuxif_sys.h"
[/#if]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
/**
  * @brief RTC handle
  */
[#if CPUCORE != "CM4"]
extern RTC_HandleTypeDef h${IpInstance?lower_case};
[#else]
RTC_HandleTypeDef h${IpInstance?lower_case};
[/#if]

/**
  * @brief Timer driver callbacks handler
  */
const UTIL_TIMER_Driver_s UTIL_TimerDriver =
{
  TIMER_IF_Init,
  NULL,

  TIMER_IF_StartTimer,
  TIMER_IF_StopTimer,

  TIMER_IF_SetTimerContext,
  TIMER_IF_GetTimerContext,

  TIMER_IF_GetTimerElapsedTime,
  TIMER_IF_GetTimerValue,
  TIMER_IF_GetMinimumTimeout,

  TIMER_IF_Convert_ms2Tick,
  TIMER_IF_Convert_Tick2ms,
};

/**
  * @brief SysTime driver callbacks handler
  */
const UTIL_SYSTIM_Driver_s UTIL_SYSTIMDriver =
{
  TIMER_IF_BkUp_Write_Seconds,
  TIMER_IF_BkUp_Read_Seconds,
  TIMER_IF_BkUp_Write_SubSeconds,
  TIMER_IF_BkUp_Read_SubSeconds,
  TIMER_IF_GetTime,
};

/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/**
  * @brief Minimum timeout delay of Alarm in ticks
  */
#define MIN_ALARM_DELAY    3

/**
  * @brief Backup seconds register
  */
#define RTC_BKP_SECONDS    RTC_BKP_DR0

/**
  * @brief Backup subseconds register
  */
#define RTC_BKP_SUBSECONDS RTC_BKP_DR1

/**
  * @brief Backup msbticks register
  */
#define RTC_BKP_MSBTICKS   RTC_BKP_DR2

/* #define RTIF_DEBUG */

/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
#ifdef RTIF_DEBUG
#include "sys_app.h" /*for app_log*/
/**
  * @brief Post the RTC log string format to the circular queue for printing in using the polling mode
  */
#define TIMER_IF_DBG_PRINTF(...) do{ {UTIL_ADV_TRACE_COND_FSend(VLEVEL_ALWAYS, T_REG_OFF, TS_OFF, __VA_ARGS__);} }while(0);
#else
/**
  * @brief not used
  */
#define TIMER_IF_DBG_PRINTF(...)
#endif /* RTIF_DEBUG */

/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/**
  * @brief Indicates if the RTC is already Initialized or not
  */
static bool RTC_Initialized = false;

/**
  * @brief RtcTimerContext
  */
static uint32_t RtcTimerContext = 0;

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/**
  * @brief Get rtc timer Value in rtc tick
  * @return val the rtc timer value (upcounting)
  */
static inline uint32_t GetTimerTicks(void);

[#if CPUCORE != "CM4"]
/**
  * @brief Writes MSBticks to backup register
  * Absolute RTC time in tick is (MSBticks)<<32 + (32bits binary counter)
  * @note MSBticks incremented every time the 32bits RTC timer wraps around (~44days)
  * @param[in] MSBticks
  * @return none
  */
static void TIMER_IF_BkUp_Write_MSBticks(uint32_t MSBticks);

[/#if]
/**
  * @brief Reads MSBticks from backup register
  * Absolute RTC time in tick is (MSBticks)<<32 + (32bits binary counter)
  * @note MSBticks incremented every time the 32bits RTC timer wraps around (~44days)
  * @retval MSBticks
  */
static uint32_t TIMER_IF_BkUp_Read_MSBticks(void);

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions ---------------------------------------------------------*/
UTIL_TIMER_Status_t TIMER_IF_Init(void)
{
  UTIL_TIMER_Status_t ret = UTIL_TIMER_OK;
  /* USER CODE BEGIN TIMER_IF_Init_1 */

  /* USER CODE END TIMER_IF_Init_1 */
[#if CPUCORE == "CM4"]
  /** Configure the Instance */
  h${IpInstance?lower_case}.Instance = RTC;
  HAL_RTC_DeactivateAlarm(&h${IpInstance?lower_case}, RTC_ALARM_A);
  TIMER_IF_SetTimerContext();
  RTC_Initialized = true;
[#else]
  if (RTC_Initialized == false)
  {
    h${IpInstance?lower_case}.IsEnabled.RtcFeatures = UINT32_MAX;
    /*Init RTC*/
    MX_RTC_Init();
    /*Stop Timer */
    TIMER_IF_StopTimer();
[#if CPUCORE == "CM0PLUS"]
    /** DeActivate the Alarm A and Alarm B enabled by MX during MX_RTC_Init() */
    HAL_RTC_DeactivateAlarm(&h${IpInstance?lower_case}, RTC_ALARM_A); /* handled by Cm4 */
    HAL_RTC_DeactivateAlarm(&h${IpInstance?lower_case}, RTC_ALARM_B); /* handled by Cm0plus */
[#else]
    /** DeActivate the Alarm A enabled by MX during MX_RTC_Init() */
    HAL_RTC_DeactivateAlarm(&h${IpInstance?lower_case}, RTC_ALARM_A);
[/#if]
    /*overload RTC feature enable*/
    h${IpInstance?lower_case}.IsEnabled.RtcFeatures = UINT32_MAX;

    /*Enable Direct Read of the calendar registers (not through Shadow) */
    HAL_RTCEx_EnableBypassShadow(&h${IpInstance?lower_case});
    /*Initialise MSB ticks*/
    TIMER_IF_BkUp_Write_MSBticks(0);

    TIMER_IF_SetTimerContext();

    RTC_Initialized = true;
  }

  /* USER CODE BEGIN TIMER_IF_Init_Last */

  /* USER CODE END TIMER_IF_Init_Last */
[/#if]
  return ret;
}

UTIL_TIMER_Status_t TIMER_IF_StartTimer(uint32_t timeout)
{
  UTIL_TIMER_Status_t ret = UTIL_TIMER_OK;
  /* USER CODE BEGIN TIMER_IF_StartTimer */

  /* USER CODE END TIMER_IF_StartTimer */
  RTC_AlarmTypeDef sAlarm = {0};
  /*Stop timer if one is already started*/
  TIMER_IF_StopTimer();
  timeout += RtcTimerContext;

  TIMER_IF_DBG_PRINTF("Start timer: time=%d, alarm=%d\n\r",  GetTimerTicks(), timeout);
  /* starts timer*/
  sAlarm.BinaryAutoClr = RTC_ALARMSUBSECONDBIN_AUTOCLR_NO;
  sAlarm.AlarmTime.SubSeconds = UINT32_MAX - timeout;
  sAlarm.AlarmMask = RTC_ALARMMASK_NONE;
  sAlarm.AlarmSubSecondMask = RTC_ALARMSUBSECONDBINMASK_NONE;
[#if CPUCORE == "CM0PLUS"]
  sAlarm.Alarm = RTC_ALARM_B;
[#else]
  sAlarm.Alarm = RTC_ALARM_A;
[/#if]
  if (HAL_RTC_SetAlarm_IT(&h${IpInstance?lower_case}, &sAlarm, RTC_FORMAT_BCD) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN TIMER_IF_StartTimer_Last */

  /* USER CODE END TIMER_IF_StartTimer_Last */
  return ret;
}

UTIL_TIMER_Status_t TIMER_IF_StopTimer(void)
{
  UTIL_TIMER_Status_t ret = UTIL_TIMER_OK;
  /* USER CODE BEGIN TIMER_IF_StopTimer */

  /* USER CODE END TIMER_IF_StopTimer */
  /* Clear RTC Alarm Flag */
[#if CPUCORE == "CM0PLUS"]
  __HAL_RTC_ALARM_CLEAR_FLAG(&h${IpInstance?lower_case}, RTC_FLAG_ALRBF);
  /* Disable the Alarm A interrupt */
  HAL_RTC_DeactivateAlarm(&h${IpInstance?lower_case}, RTC_ALARM_B);
[#else]
  __HAL_RTC_ALARM_CLEAR_FLAG(&h${IpInstance?lower_case}, RTC_FLAG_ALRAF);
  /* Disable the Alarm A interrupt */
  HAL_RTC_DeactivateAlarm(&h${IpInstance?lower_case}, RTC_ALARM_A);
[/#if]
[#if CPUCORE != "CM4"]
  /*overload RTC feature enable*/
  h${IpInstance?lower_case}.IsEnabled.RtcFeatures = UINT32_MAX;
[/#if]
  /* USER CODE BEGIN TIMER_IF_StopTimer_Last */

  /* USER CODE END TIMER_IF_StopTimer_Last */
  return ret;
}

uint32_t TIMER_IF_SetTimerContext(void)
{
  /*store time context*/
  RtcTimerContext = GetTimerTicks();

  /* USER CODE BEGIN TIMER_IF_SetTimerContext */

  /* USER CODE END TIMER_IF_SetTimerContext */

  TIMER_IF_DBG_PRINTF("TIMER_IF_SetTimerContext=%d\n\r", RtcTimerContext);
  /*return time context*/
  return RtcTimerContext;
}

uint32_t TIMER_IF_GetTimerContext(void)
{
  /* USER CODE BEGIN TIMER_IF_GetTimerContext */

  /* USER CODE END TIMER_IF_GetTimerContext */

  TIMER_IF_DBG_PRINTF("TIMER_IF_GetTimerContext=%d\n\r", RtcTimerContext);
  /*return time context*/
  return RtcTimerContext;
}

uint32_t TIMER_IF_GetTimerElapsedTime(void)
{
  /* USER CODE BEGIN TIMER_IF_GetTimerElapsedTime */

  /* USER CODE END TIMER_IF_GetTimerElapsedTime */
  return ((uint32_t)(GetTimerTicks() - RtcTimerContext));
  /* USER CODE BEGIN TIMER_IF_GetTimerElapsedTime_Last */

  /* USER CODE END TIMER_IF_GetTimerElapsedTime_Last */
}

uint32_t TIMER_IF_GetTimerValue(void)
{
  /* USER CODE BEGIN TIMER_IF_GetTimerValue */

  /* USER CODE END TIMER_IF_GetTimerValue */
  if (RTC_Initialized == true)
  {
    return GetTimerTicks();
  }
  else
  {
    return 0;
  }
  /* USER CODE BEGIN TIMER_IF_GetTimerValue_Last */

  /* USER CODE END TIMER_IF_GetTimerValue_Last */
}

uint32_t TIMER_IF_GetMinimumTimeout(void)
{
  /* USER CODE BEGIN TIMER_IF_GetTimerElapsedTime */

  /* USER CODE END TIMER_IF_GetTimerElapsedTime */
  return (MIN_ALARM_DELAY);
  /* USER CODE BEGIN TIMER_IF_GetTimerElapsedTime_Last */

  /* USER CODE END TIMER_IF_GetTimerElapsedTime_Last */
}

uint32_t TIMER_IF_Convert_ms2Tick(uint32_t timeMilliSec)
{
  /* USER CODE BEGIN TIMER_IF_Convert_ms2Tick */

  /* USER CODE END TIMER_IF_Convert_ms2Tick */
  return ((uint32_t)((((uint64_t) timeMilliSec) << RTC_N_PREDIV_S) / 1000));
  /* USER CODE BEGIN TIMER_IF_Convert_ms2Tick_Last */

  /* USER CODE END TIMER_IF_Convert_ms2Tick_Last */
}

uint32_t TIMER_IF_Convert_Tick2ms(uint32_t tick)
{
  /* USER CODE BEGIN TIMER_IF_Convert_ms2Tick */

  /* USER CODE END TIMER_IF_Convert_ms2Tick */
  return ((uint32_t)((((uint64_t)(tick)) * 1000) >> RTC_N_PREDIV_S));
  /* USER CODE BEGIN TIMER_IF_Convert_ms2Tick_Last */

  /* USER CODE END TIMER_IF_Convert_ms2Tick_Last */
}

void TIMER_IF_DelayMs(uint32_t delay)
{
  /* USER CODE BEGIN TIMER_IF_DelayMs */

  /* USER CODE END TIMER_IF_DelayMs */
  uint32_t delayTicks = TIMER_IF_Convert_ms2Tick(delay);
  uint32_t timeout = GetTimerTicks();

  /* Wait delay ms */
  while (((GetTimerTicks() - timeout)) < delayTicks)
  {
    __NOP();
  }
  /* USER CODE BEGIN TIMER_IF_DelayMs_Last */

  /* USER CODE END TIMER_IF_DelayMs_Last */
}

[#if CPUCORE == ""]
void HAL_RTC_AlarmAEventCallback(RTC_HandleTypeDef *h${IpInstance?lower_case})
{
  /* USER CODE BEGIN HAL_RTC_AlarmAEventCallback */

  /* USER CODE END HAL_RTC_AlarmAEventCallback */
  UTIL_TIMER_IRQ_Handler();
  /* USER CODE BEGIN HAL_RTC_AlarmAEventCallback_Last */

  /* USER CODE END HAL_RTC_AlarmAEventCallback_Last */
}

[/#if]
[#if CPUCORE == "CM0PLUS"]
void HAL_RTC_AlarmAEventCallback(RTC_HandleTypeDef *h${IpInstance?lower_case})
{
  /* USER CODE BEGIN HAL_RTC_AlarmAEventCallback */

  /* USER CODE END HAL_RTC_AlarmAEventCallback */
  MBMUX_ComParam_t *com_obj;

  if (MBMUXIF_GetCpusSynchroFlag() == CPUS_BOOT_SYNC_RTC_REGISTERED)
  {
    /*Alarm A reserved for CM4: notify CM4 that Alarm A was raised */
    com_obj = MBMUXIF_GetSystemFeatureNotifComPtr(FEAT_INFO_SYSTEM_NOTIF_PRIO_A_ID);
    if (com_obj != NULL)
    {
      com_obj->MsgId = SYS_RTC_ALARM_MSG_ID;
      com_obj->ParamCnt = 0;
      MBMUXIF_SystemSendNotif_NoWait(FEAT_INFO_SYSTEM_NOTIF_PRIO_A_ID);
    }
  }
  /* USER CODE BEGIN HAL_RTC_AlarmAEventCallback_Last */

  /* USER CODE END HAL_RTC_AlarmAEventCallback_Last */
}

void HAL_RTCEx_AlarmBEventCallback(RTC_HandleTypeDef *h${IpInstance?lower_case})
{
  /* USER CODE BEGIN HAL_RTCEx_AlarmBEventCallback */

  /* USER CODE END HAL_RTCEx_AlarmBEventCallback */
  UTIL_TIMER_IRQ_Handler();
  /* USER CODE BEGIN HAL_RTCEx_AlarmBEventCallback_Last */

  /* USER CODE END HAL_RTCEx_AlarmBEventCallback_Last */
}

[/#if]
[#if CPUCORE != "CM4"]
void HAL_RTCEx_SSRUEventCallback(RTC_HandleTypeDef *h${IpInstance?lower_case})
{
  /* USER CODE BEGIN HAL_RTCEx_SSRUEventCallback */

  /* USER CODE END HAL_RTCEx_SSRUEventCallback */
  /*called every 48 days with 1024 ticks per seconds*/
  TIMER_IF_DBG_PRINTF(">>Handler SSRUnderflow at %d\n\r", GetTimerTicks());
  /*Increment MSBticks*/
  uint32_t MSB_ticks = TIMER_IF_BkUp_Read_MSBticks();
  TIMER_IF_BkUp_Write_MSBticks(MSB_ticks + 1);
  /* USER CODE BEGIN HAL_RTCEx_SSRUEventCallback_Last */

  /* USER CODE END HAL_RTCEx_SSRUEventCallback_Last */
}

[/#if]
uint32_t TIMER_IF_GetTime(uint16_t *mSeconds)
{
  /* USER CODE BEGIN TIMER_IF_GetTime */

  /* USER CODE END TIMER_IF_GetTime */
  uint64_t ticks;
  uint32_t timerValueLsb = GetTimerTicks();
  uint32_t timerValueMSB = TIMER_IF_BkUp_Read_MSBticks();

  ticks = (((uint64_t) timerValueMSB) << 32) + timerValueLsb;

  uint32_t seconds = (uint32_t)(ticks >> RTC_N_PREDIV_S);

  ticks = (uint32_t) ticks & RTC_PREDIV_S;

  *mSeconds = TIMER_IF_Convert_Tick2ms(ticks);

  return seconds;
  /* USER CODE BEGIN TIMER_IF_GetTime_Last */

  /* USER CODE END TIMER_IF_GetTime_Last */
}

void TIMER_IF_BkUp_Write_Seconds(uint32_t Seconds)
{
  /* USER CODE BEGIN TIMER_IF_BkUp_Write_Seconds */

  /* USER CODE END TIMER_IF_BkUp_Write_Seconds */
  HAL_RTCEx_BKUPWrite(&h${IpInstance?lower_case}, RTC_BKP_SECONDS, Seconds);
  /* USER CODE BEGIN TIMER_IF_BkUp_Write_Seconds_Last */

  /* USER CODE END TIMER_IF_BkUp_Write_Seconds_Last */
}

void TIMER_IF_BkUp_Write_SubSeconds(uint32_t SubSeconds)
{
  /* USER CODE BEGIN TIMER_IF_BkUp_Write_SubSeconds */

  /* USER CODE END TIMER_IF_BkUp_Write_SubSeconds */
  HAL_RTCEx_BKUPWrite(&h${IpInstance?lower_case}, RTC_BKP_SUBSECONDS, SubSeconds);
  /* USER CODE BEGIN TIMER_IF_BkUp_Write_SubSeconds_Last */

  /* USER CODE END TIMER_IF_BkUp_Write_SubSeconds_Last */
}

uint32_t TIMER_IF_BkUp_Read_Seconds(void)
{
  /* USER CODE BEGIN TIMER_IF_BkUp_Read_Seconds */

  /* USER CODE END TIMER_IF_BkUp_Read_Seconds */
  return HAL_RTCEx_BKUPRead(&h${IpInstance?lower_case}, RTC_BKP_SECONDS);
  /* USER CODE BEGIN TIMER_IF_BkUp_Read_Seconds_Last */

  /* USER CODE END TIMER_IF_BkUp_Read_Seconds_Last */
}

uint32_t TIMER_IF_BkUp_Read_SubSeconds(void)
{
  /* USER CODE BEGIN TIMER_IF_BkUp_Read_SubSeconds */

  /* USER CODE END TIMER_IF_BkUp_Read_SubSeconds */
  return HAL_RTCEx_BKUPRead(&h${IpInstance?lower_case}, RTC_BKP_SUBSECONDS);
  /* USER CODE BEGIN TIMER_IF_BkUp_Read_SubSeconds_Last */

  /* USER CODE END TIMER_IF_BkUp_Read_SubSeconds_Last */
}

/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private functions ---------------------------------------------------------*/
[#if CPUCORE != "CM4"]
static void TIMER_IF_BkUp_Write_MSBticks(uint32_t MSBticks)
{
  /* USER CODE BEGIN TIMER_IF_BkUp_Write_MSBticks */

  /* USER CODE END TIMER_IF_BkUp_Write_MSBticks */
  HAL_RTCEx_BKUPWrite(&h${IpInstance?lower_case}, RTC_BKP_MSBTICKS, MSBticks);
  /* USER CODE BEGIN TIMER_IF_BkUp_Write_MSBticks_Last */

  /* USER CODE END TIMER_IF_BkUp_Write_MSBticks_Last */
}

[/#if]
static uint32_t TIMER_IF_BkUp_Read_MSBticks(void)
{
  /* USER CODE BEGIN TIMER_IF_BkUp_Read_MSBticks */

  /* USER CODE END TIMER_IF_BkUp_Read_MSBticks */
  uint32_t MSBticks;
  MSBticks = HAL_RTCEx_BKUPRead(&h${IpInstance?lower_case}, RTC_BKP_MSBTICKS);
  return MSBticks;
  /* USER CODE BEGIN TIMER_IF_BkUp_Read_MSBticks_Last */

  /* USER CODE END TIMER_IF_BkUp_Read_MSBticks_Last */
}

static inline uint32_t GetTimerTicks(void)
{
  /* USER CODE BEGIN GetTimerTicks */

  /* USER CODE END GetTimerTicks */
  return (UINT32_MAX - LL_RTC_TIME_GetSubSecond(RTC));
  /* USER CODE BEGIN GetTimerTicks_Last */

  /* USER CODE END GetTimerTicks_Last */
}

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
