[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ble_timer_if.c
  * @author  MCD Application Team
  * @brief   routines for Timer service needed by the BLE Host Stack
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include "ble_timer_if.h"
#include "stm32_timer.h"

/* Private typedef -----------------------------------------------------------*/
/*---------------------------------------------------------------------------
 * TimerFunc type
 *     Type for a timer notification callback. The notification function
 *     is called to indicate that the timer has fired.
 */
typedef void (*TimerFunc)(void *parms);

/* Private macros ------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/

/* Function callback to call when timer has fired */
TimerFunc timerFunction;

/* Parameter of the function callback */
void *timerParam;

/*Timer used by the BLE Host*/
static UTIL_TIMER_Object_t BleHostTimer;

/* Private functions prototypes-----------------------------------------------*/
static void bleHostTimerCallback(void *arg);

/* Functions Definition ------------------------------------------------------*/

/**
 * @brief ble_timer_start
 * This function is used to initialize and start the oneshot timer
 * used by the ble host.
 *
 * @param func : pointer to a function to call when the timer expires
 * @param param : param to pass in func when the timer expire
 * @param timeout : time in milliseconds to wait before the timer expiration
 *
 */
void ble_timer_start(void *func, void *param, uint32_t timeout){

  /* Save the parameters */
  timerFunction = (TimerFunc )func;
  timerParam = param;

  UTIL_TIMER_Create(&BleHostTimer,
                    timeout,
                    UTIL_TIMER_ONESHOT,
                    &bleHostTimerCallback, 0);

  UTIL_TIMER_Start(&BleHostTimer);

}

/**
 * @brief ble_timer_get_remain_time
 * This function is used by the ble host to get the remaining time
 * of the timer started thanks to the ble_start_timer() function.
 *
 * @return remaining time in millisecond.
 */
uint32_t ble_timer_get_remain_time(void){

  uint32_t elapsedTime;

  UTIL_TIMER_GetRemainingTime(&BleHostTimer, &elapsedTime);

  return elapsedTime;
}

/**
 * @brief ble_timer_stop
 * This function is used by the ble host to stop timer. This function
 * requests destruction of the timer created by ble_timer_start()
 * 
 * @param func : pointer to a function to call when the timer expires
 * @param param : param to pass in func when the timer expire
 * @param timeout : time in milliseconds to wait before the timer expiration
 *
 */
void ble_timer_stop(void){

   UTIL_TIMER_Stop(&BleHostTimer);

}

static void bleHostTimerCallback(void *arg){
  /* Call timer Callback of the Host Stack */
  timerFunction(timerParam);
}
