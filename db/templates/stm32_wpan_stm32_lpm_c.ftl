[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
 * @file    stm32_lpm.c
 * @author  MCD Application Team
 * @brief   Low Power Manager
 ******************************************************************************
 [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
 ******************************************************************************
 */
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/
#include "stm32_lpm.h"
#include "utilities_conf.h"

/* Private typedef -----------------------------------------------------------*/
/* Private macros ------------------------------------------------------------*/
#define UTIL_LPM_NO_BIT_SET   (0)

#ifndef UTIL_LPM_INIT_CRITICAL_SECTION
  #define UTIL_LPM_INIT_CRITICAL_SECTION( )
#endif

#ifndef UTIL_LPM_ENTER_CRITICAL_SECTION
  #define UTIL_LPM_ENTER_CRITICAL_SECTION( )    UTILS_ENTER_CRITICAL_SECTION( )
#endif

#ifndef UTIL_LPM_EXIT_CRITICAL_SECTION
  #define UTIL_LPM_EXIT_CRITICAL_SECTION( )     UTILS_EXIT_CRITICAL_SECTION( )
#endif

/* Private function prototypes -----------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private typedef -----------------------------------------------------------*/
/* Private defines -----------------------------------------------------------*/
/* Private macros ------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
static UTIL_LPM_bm_t StopModeDisable = UTIL_LPM_NO_BIT_SET;
static UTIL_LPM_bm_t OffModeDisable = UTIL_LPM_NO_BIT_SET;

/* Global variables ----------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Functions Definition ------------------------------------------------------*/

void UTIL_LPM_Init( void )
{
  StopModeDisable = UTIL_LPM_NO_BIT_SET;
  OffModeDisable = UTIL_LPM_NO_BIT_SET;
  UTIL_LPM_INIT_CRITICAL_SECTION( );
}

void UTIL_LPM_DeInit( void )
{
}

void UTIL_LPM_SetStopMode( UTIL_LPM_bm_t lpm_id_bm, UTIL_LPM_State_t state )
{
  UTIL_LPM_ENTER_CRITICAL_SECTION( );
  
  switch( state )
  {
    case UTIL_LPM_DISABLE:
    {
      StopModeDisable |= lpm_id_bm;
      break;
    }
    case UTIL_LPM_ENABLE:
    {
      StopModeDisable &= ( ~lpm_id_bm );
      break;
    }
    default:
      break;
  }
  
  UTIL_LPM_EXIT_CRITICAL_SECTION( );
}

void UTIL_LPM_SetOffMode( UTIL_LPM_bm_t lpm_id_bm, UTIL_LPM_State_t state )
{
  UTIL_LPM_ENTER_CRITICAL_SECTION( );
  
  switch(state)
  {
    case UTIL_LPM_DISABLE:
    {
      OffModeDisable |= lpm_id_bm;
      break;
    }
    case UTIL_LPM_ENABLE:
    {
      OffModeDisable &= ( ~lpm_id_bm );
      break;
    }
    default:
      break;
  }
  
  UTIL_LPM_EXIT_CRITICAL_SECTION( );
}

UTIL_LPM_Mode_t UTIL_LPM_GetMode( void )
{
  UTIL_LPM_Mode_t mode_selected;

  UTIL_LPM_ENTER_CRITICAL_SECTION( );

  if( StopModeDisable != UTIL_LPM_NO_BIT_SET )
  {
    /**
     * At least one user disallows Stop Mode
     */
    mode_selected = UTIL_LPM_SLEEPMODE;
  }
  else
  {
    if( OffModeDisable != UTIL_LPM_NO_BIT_SET )
    {
      /**
       * At least one user disallows Off Mode
       */
      mode_selected = UTIL_LPM_STOPMODE;
    }
    else
    {
      mode_selected = UTIL_LPM_OFFMODE;
    }
  }

  UTIL_LPM_EXIT_CRITICAL_SECTION( );

  return mode_selected;
}

void UTIL_LPM_EnterLowPower( void )
{
  UTIL_LPM_ENTER_CRITICAL_SECTION( );

  if( StopModeDisable != UTIL_LPM_NO_BIT_SET )
  {
    /**
     * At least one user disallows Stop Mode
     * SLEEP mode is required
     */
      UTIL_PowerDriver.EnterSleepMode( );
      UTIL_PowerDriver.ExitSleepMode( );
  }
  else
  { 
    if( OffModeDisable != UTIL_LPM_NO_BIT_SET )
    {
      /**
       * At least one user disallows Off Mode
       * STOP mode is required
       */
        UTIL_PowerDriver.EnterStopMode( );
        UTIL_PowerDriver.ExitStopMode( );
    }
    else
    {
      /**
       * OFF mode is required
       */
      UTIL_PowerDriver.EnterOffMode( );
      UTIL_PowerDriver.ExitOffMode( );
    }
  }
  
  UTIL_LPM_EXIT_CRITICAL_SECTION( );
}
