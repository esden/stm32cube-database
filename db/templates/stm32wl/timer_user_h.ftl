[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    timer.h
  * @author  MCD Application Team
  * @brief   Timeserver API
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __TIMER_H__
#define __TIMER_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN USER_TIMER_ET */

/*!
 * \brief Timer object description
 */
typedef struct TimerEvent_s
{
    uint32_t Timestamp;           /*!<Expiring timer value in ticks from TimerContext */
    uint32_t ReloadValue;         /*!<Reload Value when Timer is restarted            */
    uint8_t IsPending;            /*!<Is the timer waiting for an event               */
    uint8_t IsRunning;            /*!<Is the timer running                            */
    uint8_t IsReloadStopped;      /*!<Is the reload stopped                           */
    uint8_t Mode;                 /*!<Timer type : one-shot/continuous                */
    void ( *Callback )( void *);  /*!<callback function                               */
    void *argument;               /*!<callback argument                               */
    struct TimerEvent_s *Next;    /*!<Pointer to the next Timer object.               */
}TimerEvent_t;

/*!
 * \brief Timer time variable definition
 */
#ifndef TimerTime_t
typedef uint32_t TimerTime_t;
#endif

/* USER CODE END USER_TIMER_ET */

/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/**
  * @brief Max timer mask
  */
#define TIMERTIME_T_MAX ( ( uint32_t )~0 )

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN USER_TIMER_EFP */

/*!
 * \brief Initializes the timer object
 *
 * \remark TimerSetValue function must be called before starting the timer.
 *         this function initializes timestamp and reload value at 0.
 *
 * \param [IN] obj          Structure containing the timer object parameters
 * \param [IN] callback     Function callback called at the end of the timeout
 */
void TimerInit( TimerEvent_t *obj, void ( *callback )( void *context ) );

/*!
 * \brief Starts and adds the timer object to the list of timer events
 *
 * \param [IN] obj Structure containing the timer object parameters
 */
void TimerStart( TimerEvent_t *obj );

/*!
 * \brief Stops and removes the timer object from the list of timer events
 *
 * \param [IN] obj Structure containing the timer object parameters
 */
void TimerStop( TimerEvent_t *obj );


/*!
 * \brief Set timer new timeout value
 *
 * \param [IN] obj   Structure containing the timer object parameters
 * \param [IN] value New timer timeout value
 */
void TimerSetValue( TimerEvent_t *obj, uint32_t value );

/*!
 * \brief Read the current time
 *
 * \retval time returns current time
 */
TimerTime_t TimerGetCurrentTime( void );

/*!
 * \brief Return the Time elapsed since a fix moment in Time
 *
 * \remark TimerGetElapsedTime will return 0 for argument 0.
 *
 * \param [IN] past         fix moment in Time
 * \retval time             returns elapsed time
 */
TimerTime_t TimerGetElapsedTime( TimerTime_t past );

/**
 * @brief Timer IRQ event handler
 *
 * @note Head Timer Object is automatically removed from the List
 *
 * @note e.g. it is not needed to stop it
 */
void UTIL_TIMER_IRQ_Handler( void );

/* USER CODE END USER_TIMER_EFP */

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __TIMER_H__*/
