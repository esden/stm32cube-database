[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_timer.h
  * @author  GPM WBL Application Team
  * @brief   Controls RTC timers for various Sigfox protocol operations.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stdint.h>

#ifndef __WL3SFX_TIMER_H
#define __WL3SFX_TIMER_H

/**
 * @addtogroup WL3SFX
 * @{
 *
 * @addtogroup WL3SFX_TIMER Protocol Timer Management
 * @brief RTC-based timers for Sigfox protocol operations
 * @{
 */

/**
 * @brief Types of timers used by Sigfox
 *
 * The timers are implemented in such a way that they can be used completely independently from each other,
 * i.e. all timers can be running at the same time and arbitrarily started / stopped.
 */
typedef enum {
  /** Timer for wait_frame and time between TX and RX */
  WL3SFX_TIMER_GENERIC = 0,

  /** Timer for carrier sense (listen before talk) */
  WL3SFX_TIMER_CS,

  /** Timer for uplink inter-frame delays */
  WL3SFX_TIMER_INTERFRAME,

  /** Timer for uplink inter-frame delays - early wakeup */
  WL3SFX_TIMER_INTERFRAME_WAKEUP,

  /** Timer for Monarch */
  WL3SFX_TIMER_MONARCH,

  /* -- do not use, just to determine number of timers -- */
  WL3SFX_TIMER_MAX
} wl3sfx_Timer_Type;

/**
 * @brief Timer expiry callback function type
 */
typedef void (*wl3sfx_Timer_Callback)(void);

/**
 * @brief Initialize RTC for use as wakeup timer
 */
void wl3sfx_timer_init(void);

/**
 * @brief Start millisecond-precision RTC wakeup timer
 *
 * @param type Type of Sigfox timer to start (e.g. generic, carrier sense, monarch)
 * @param duration_ms Duration after which timer expires, in milliseconds. Note that for very large time values (more than a week), integer
 * overflows may occur. Under such circumstances, use ::wl3sfx_timer_start_seconds instead.
 * @param cb Callback function to execute when timer expires, or NULL if no callback function is used
 *
 * @retval None
 */
void wl3sfx_timer_start_milliseconds(wl3sfx_Timer_Type type, uint32_t duration_ms, wl3sfx_Timer_Callback cb);

/**
 * @brief Start second-precision RTC wakeup timer
 *
 * @param type Type of Sigfox timer to start (e.g. generic, carrier sense, monarch)
 * @param duration_s Duration after which timer expires, in seconds
 * @param cb Callback function to execute when timer expires, or NULL if no callback function is used
 *
 * @retval None
 */
void wl3sfx_timer_start_seconds(wl3sfx_Timer_Type type, uint32_t duration_s, wl3sfx_Timer_Callback cb);

/**
 * @brief Stop RTC wakeup timer
 *
 * @param type Type of Sigfox timer (e.g. generic, carrier sense, monarch) to stop
 *
 * @retval None
 */
void wl3sfx_timer_stop(wl3sfx_Timer_Type type);

/**
 * @brief Check if RTC wakeup timer has expired yet
 *
 * @param type Type of Sigfox timer (e.g. generic, carrier sense, monarch) to check for expiry
 *
 * @retval 1 if timer has expired, otherwise 0
 */
uint8_t wl3sfx_timer_expired(wl3sfx_Timer_Type type);

/**
 * @brief Check if RTC wakeup timer has expired yet
 *
 * @param type Type of Sigfox timer (e.g. generic, carrier sense, monarch) to check for expiry
 *
 * @retval 1 if timer has expired, otherwise 0
 */
void RTC_IRQHandler(void);
/** @}@} */

#endif