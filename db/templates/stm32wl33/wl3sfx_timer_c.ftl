[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_timer.c
  * @author  GPM WBL Application Team
  * @brief   Controls RTC timers for various Sigfox protocol operations.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include "stm32wl3x_hal.h"
#include "wl3sfx_timer.h"
#include "wl3sfx_log.h"

#define MAX_TICKS_PER_WAKEUP 65535
#define TIMERS_COUNT WL3SFX_TIMER_MAX

/** Timer state definition */
typedef enum {
  /** Timer is currently inactive (i.e. was never used or was stopped) */
  INACTIVE = 0,

  /** Timer has been started and is currently running */
  RUNNING,

  /** Timer was running previously and has now expired */
  EXPIRED
} timer_state;

/** Structure to counter number of timer ticks. Used for 64-bit arithmetic using only 32-bit integer. */
typedef struct {
  /** The 32 least significant bits */
  uint32_t lsb;

  /** The 32 most significant bits */
  uint32_t msb;
} tickcount;

/** Timer definition structure */
typedef struct {
  /** Number of RTC ticks remaining on the timer (only valid if timer state is RUNNING) */
  tickcount remaining_ticks;

  /** State of timer (active, running or expired) */
  timer_state state;

  /** Callback function pointer for when timer has expired, or NULL if no callback. */
  wl3sfx_Timer_Callback cb;
} timer;

static timer _timers[TIMERS_COUNT] = { 0 };
tickcount _rtc_ticks_to_next_wakeup = { 0 };
uint32_t _systick_at_update = 0;

/* Initialize RTC Only */
static RTC_HandleTypeDef _hrtc = { .Instance = RTC,
  .Init = {
    .OutPut = RTC_OUTPUT_DISABLE,
    .OutPutPolarity = RTC_OUTPUT_POLARITY_HIGH,
  } };

/* 64-bit tick count manipulation helpers (without requiring 64-bit integer support, which is problematic across compilers) */
static void _ticks_subtract(tickcount* ticks, tickcount subtractor)
{
  ticks->msb -= subtractor.msb;

  if (ticks->lsb > subtractor.lsb) {
    ticks->lsb -= subtractor.lsb;
  } else {
    ticks->lsb -= subtractor.lsb;
    ticks->msb--;
  }
}

/* returns 1 if ticks > comp, otherwise 0 */
static uint8_t _ticks_greater_than(tickcount ticks, tickcount comp)
{
  return (ticks.msb > comp.msb) ? 1 : (ticks.lsb > comp.lsb);
}

/* convert milliseconds into number of RTC wakeup ticks (overflows if number of milliseconds is too large) */
static uint32_t _get_rtc_clock_freq(void)
{
  /* Use RTC clock speed (LSE clock / 16) calibrated to 16 MHz clock from SCM_COUNTER_VAL if available. */
  uint16_t slow_clock_freq = 32000;
  uint16_t scm_counter_currval = READ_REG_FIELD(MR_SUBG_GLOB_MISC->SCM_COUNTER_VAL, MR_SUBG_GLOB_MISC_SCM_COUNTER_VAL_SCM_COUNTER_CURRVAL);
  if (scm_counter_currval != 0)
    slow_clock_freq = 32ull * 16000000ull / scm_counter_currval;

  return slow_clock_freq / 16;
}

static tickcount _milliseconds_to_rtc_ticks(uint32_t milliseconds)
{
  /* Have to use different equations depending on size of milliseconds to get best integer precision */
  tickcount ret;
  ret.msb = milliseconds / (UINT32_MAX / _get_rtc_clock_freq() * 1000);
  milliseconds -= ret.msb * (UINT32_MAX / _get_rtc_clock_freq() * 1000);

  if (milliseconds > UINT32_MAX / _get_rtc_clock_freq())
    ret.lsb = milliseconds / 1000 * _get_rtc_clock_freq();
  else
    ret.lsb = _get_rtc_clock_freq() * milliseconds / 1000;

  return ret;
}

static tickcount _seconds_to_rtc_ticks(uint32_t seconds)
{
  /* Have to use different equations depending on size of milliseconds to get best integer precision */
  tickcount ret;
  ret.msb = seconds / (UINT32_MAX / _get_rtc_clock_freq());
  seconds -= ret.msb * (UINT32_MAX / _get_rtc_clock_freq());
  ret.lsb = _get_rtc_clock_freq() * seconds;

  return ret;
}

/* deduct number of wake up ticks that have already expired from all running timers */
static void _timers_deduct(tickcount rtc_ticks)
{
  for (unsigned int type = 0; type < TIMERS_COUNT; ++type) {
    if (_timers[type].state == RUNNING) {
      if (_ticks_greater_than(_timers[type].remaining_ticks, rtc_ticks)) {
        _ticks_subtract(&_timers[type].remaining_ticks, rtc_ticks);
      } else {
        /* mark timer as expired and execute callback */
        _timers[type].state = EXPIRED;
        if (_timers[type].cb != NULL)
          _timers[type].cb();
      }
    }
  }
}

/*
 * This function should be called whenever the timer configuration changes, i.e. a wakeup timeout occurs or a timer is started / stopped.
 * It performs the following steps:
 * --> update remaining number of ticks for each timer
 * --> look at which timer expires next and sleep until this expiry occurs
 */
static void _timers_update(void)
{
  _systick_at_update = HAL_GetTick();

  uint8_t need_wakeup = 0;
  _rtc_ticks_to_next_wakeup.msb = 0;
  _rtc_ticks_to_next_wakeup.lsb = MAX_TICKS_PER_WAKEUP;

  /* find timer that expires next */
  for (unsigned int type = 0; type < TIMERS_COUNT; ++type) {
    if (_timers[type].state == RUNNING) {
      need_wakeup = 1;
      if (!_ticks_greater_than(_timers[type].remaining_ticks, _rtc_ticks_to_next_wakeup))
        _rtc_ticks_to_next_wakeup = _timers[type].remaining_ticks;
    }
  }

  /*
   * enable RTC wakeup if required
   * note that _rtc_ticks_to_next_wakeup.msb = 0, since we initialized it to be zero and it was only overwritten by timers with shorter
   * durations
   */
  if (need_wakeup) {
    HAL_RTCEx_SetWakeUpTimer_IT(&_hrtc, _rtc_ticks_to_next_wakeup.lsb, RTC_WAKEUPCLOCK_RTCCLK_DIV16);
  } else {
    HAL_RTCEx_DeactivateWakeUpTimer(&_hrtc);
  }
}

static void _timer_start_tickcount(wl3sfx_Timer_Type type, tickcount duration, wl3sfx_Timer_Callback cb)
{
  _timers_deduct(_milliseconds_to_rtc_ticks(HAL_GetTick() - _systick_at_update));

  _timers[type].remaining_ticks = duration;
  _timers[type].state = RUNNING;
  _timers[type].cb = cb;

  _timers_update();
}

void wl3sfx_timer_init(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = { 0 };

#ifdef CONFIG_HW_LS_XTAL
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_LSE;
  RCC_OscInitStruct.LSEState = RCC_LSE_ON;
#endif

#ifdef CONFIG_HW_LS_RO
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_LSI;
  RCC_OscInitStruct.LSEState = RCC_LSE_OFF;
  RCC_OscInitStruct.LSIState = RCC_LSI_ON;
#endif

  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
    while (1) {}

  __HAL_RCC_RTC_CLK_ENABLE();
  __HAL_RCC_CLEAR_IT(RCC_IT_RTCRSTRELRDY);

  /* Force RTC peripheral reset */
  __HAL_RCC_RTC_FORCE_RESET();
  __HAL_RCC_RTC_RELEASE_RESET();

  /* Check if RTC Reset Release flag interrupt occurred or not */
  while (__HAL_RCC_GET_IT(RCC_IT_RTCRSTRELRDY) == 0) {}
  __HAL_RCC_CLEAR_IT(RCC_IT_RTCRSTRELRDY);

  if (HAL_RTC_Init(&_hrtc) != HAL_OK)
    while (1) {}

  /* Configure the NVIC for RTC Alarm */
  HAL_NVIC_EnableIRQ(RTC_IRQn);
  HAL_NVIC_SetPriority(RTC_IRQn, 0x0, 0x0);
}

void wl3sfx_timer_start_milliseconds(wl3sfx_Timer_Type type, uint32_t duration_ms, wl3sfx_Timer_Callback cb)
{
  _timer_start_tickcount(type, _milliseconds_to_rtc_ticks(duration_ms), cb);
}

void wl3sfx_timer_start_seconds(wl3sfx_Timer_Type type, uint32_t duration_s, wl3sfx_Timer_Callback cb)
{
  _timer_start_tickcount(type, _seconds_to_rtc_ticks(duration_s), cb);
}

void wl3sfx_timer_stop(wl3sfx_Timer_Type type)
{
  _timers[type].state = INACTIVE;
  _timers_deduct(_milliseconds_to_rtc_ticks(HAL_GetTick() - _systick_at_update));
  _timers_update();
}

uint8_t wl3sfx_timer_expired(wl3sfx_Timer_Type type)
{
  return _timers[type].state == EXPIRED;
}

void RTC_IRQHandler(void)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");
  __HAL_RTC_WAKEUPTIMER_CLEAR_FLAG(&_hrtc, RTC_FLAG_WUTF);

  _timers_deduct(_rtc_ticks_to_next_wakeup);
  _timers_update();
}