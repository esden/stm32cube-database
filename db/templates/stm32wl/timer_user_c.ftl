[#ftl]
/* USER CODE BEGIN Header */
/******************************************************************************
 * @file    timer.c
 * @author  MCD Application Team
 * @brief   Time server to be implemented by user
 ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "timer.h"
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
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
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions ---------------------------------------------------------*/
/* USER CODE BEGIN USER_TIMER_EF */
void TimerInit( TimerEvent_t *obj, void ( *callback )( void *context ) )
{
}

void TimerStart( TimerEvent_t *obj )
{
}

void TimerStop( TimerEvent_t *obj )
{
}

void TimerSetValue( TimerEvent_t *obj, uint32_t value )
{
}

TimerTime_t TimerGetCurrentTime( void )
{
  return  0;
}

TimerTime_t TimerGetElapsedTime( TimerTime_t past )
{
  return 0;
}

void UTIL_TIMER_IRQ_Handler( void )
{
}
/* USER CODE END USER_TIMER_EF */

/* USER CODE BEGIN EF */

/* USER CODE END EF */

/**************************** Private functions *******************************/
