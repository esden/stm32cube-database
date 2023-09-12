[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    hw_rng.c
  * @author  MCD Application Team
  * @brief   This file contains the RNG driver for STM32WBA
  ******************************************************************************
  [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include "app_common.h"
#include "stm32wbaxx_ll_bus.h"
#include "stm32wbaxx_ll_rng.h"

/*****************************************************************************/

typedef struct
{
  uint32_t pool[CFG_HW_RNG_POOL_SIZE];
  uint8_t  size;
  uint8_t  run;
  uint8_t  clock_en;
  int      error;
} HW_RNG_VAR_T;

/*****************************************************************************/

static HW_RNG_VAR_T HW_RNG_var;

/*****************************************************************************/

void HW_RNG_EnableClock( uint8_t user_mask )
{
  HW_RNG_VAR_T* pv = &HW_RNG_var;

  UTILS_ENTER_CRITICAL_SECTION( );

  if ( pv->clock_en == 0 )
  {
    LL_AHB2_GRP1_EnableClock( LL_AHB2_GRP1_PERIPH_RNG );
  }

  pv->clock_en |= user_mask;

  UTILS_EXIT_CRITICAL_SECTION( );
}

/*****************************************************************************/

void HW_RNG_DisableClock( uint8_t user_mask )
{
  HW_RNG_VAR_T* pv = &HW_RNG_var;

  UTILS_ENTER_CRITICAL_SECTION( );

  pv->clock_en &= ~user_mask;

  if ( pv->clock_en == 0 )
  {
    LL_AHB2_GRP1_DisableClock( LL_AHB2_GRP1_PERIPH_RNG );
  }

  UTILS_EXIT_CRITICAL_SECTION( );
}

/*****************************************************************************/

/*
 * HW_RNG_Run: this function must be called in loop.
 * It implenments a simple state machine that enables the RNG,
 * fills the pool with generated random numbers and then disables the RNG.
 * It always returns 0 in normal conditions. In error conditions, it returns
 * an error code different from 0.
 */
static int HW_RNG_Run( HW_RNG_VAR_T* pv )
{
  int i, error = HW_OK;

  /* If the RNG is OFF */

  if ( !pv->run )
  {
      /* Enable RNG clocks */
      HW_RNG_EnableClock( 1 );

      /* Set RNG enable bit */
      LL_RNG_Enable( RNG );

      /* Set flag indicating that RNG is ON */
      pv->run = TRUE;
  }

  /* Else check for RNG clock error */
    
  else if ( LL_RNG_IsActiveFlag_CECS( RNG ) )
  {
    /* Clear RNG clock error interrupt status flags */
    LL_RNG_ClearFlag_CEIS( RNG );
    
    error = HW_RNG_CLOCK_ERROR;
  }
    
  /* Else check for RNG seed error */
    
  else if ( LL_RNG_IsActiveFlag_SEIS( RNG ) )
  {
    /* Clear RNG seed error interrupt status flags */
    LL_RNG_ClearFlag_SEIS( RNG );
    
    /* Discard 12 words from RNG_DR in order to clean the pipeline */
    for ( i = 12; i > 0; i-- )
    {
      LL_RNG_ReadRandData32( RNG );
    }

    error = HW_RNG_NOISE_ERROR;
  }

  /* Else if the pool is not full */

  else if ( pv->size < CFG_HW_RNG_POOL_SIZE )
  {
    /* Read the H/W generated values until the pool is full */

    UTILS_ENTER_CRITICAL_SECTION( );

    while ( (pv->size < CFG_HW_RNG_POOL_SIZE) &&
            LL_RNG_IsActiveFlag_DRDY( RNG ) )
    {
      pv->pool[pv->size] = LL_RNG_ReadRandData32( RNG );
      pv->size++;
    }

    UTILS_EXIT_CRITICAL_SECTION( );
  }

  /* Else if the pool is full, disable the RNG */

  else
  {
    /* Clear RNG enable bit */
    LL_RNG_Disable( RNG );

    /* Disable RNG clocks */
    HW_RNG_DisableClock( 1 );

    /* Reset flag indicating that the RNG is ON */
    pv->run = FALSE;
  }
  
  return error;
}

/*****************************************************************************/

void HW_RNG_Start( void )
{
  HW_RNG_VAR_T* pv = &HW_RNG_var;

  /* Reset global variables */
  pv->size = 0;
  pv->run = FALSE;
  pv->error = HW_OK;
  pv->clock_en = 0;

  /* Fill the random numbers pool by calling the "run" function */
  do
  {
    pv->error = HW_RNG_Run( pv );
  }
  while ( pv->run && !pv->error );
}

/*****************************************************************************/

void HW_RNG_Get( uint8_t n, uint32_t* val )
{
  HW_RNG_VAR_T* pv = &HW_RNG_var;
  uint32_t pool_value;

  while ( n-- )
  {
    UTILS_ENTER_CRITICAL_SECTION( );

    if ( pv->size == 0 )
    {
      pv->error = HW_RNG_UFLOW_ERROR;
      pool_value = ~pv->pool[n & (CFG_HW_RNG_POOL_SIZE - 1)];
    }
    else
    {
      pool_value = pv->pool[--pv->size];
    }

    UTILS_EXIT_CRITICAL_SECTION( );

    *val++ = pool_value;
  }
  
  /* Call the process callback function to fill the pool offline */
  HWCB_RNG_Process( );
}

/*****************************************************************************/

int HW_RNG_Process( void )
{
  HW_RNG_VAR_T* pv = &HW_RNG_var;
  int status = HW_OK;

  /* Check if the process is not done or if the pool is not full */
  if ( pv->run || (pv->size < CFG_HW_RNG_POOL_SIZE) )
  {
    UTILS_ENTER_CRITICAL_SECTION( );

    /* Check if an error occurred during a previous call to HW_RNG API */
    status = pv->error;
    pv->error = HW_OK;

    UTILS_EXIT_CRITICAL_SECTION( );

    if ( status == HW_OK )
    {
      /* Call the "run" function that generates random data */
      status = HW_RNG_Run( pv );
      
      /* If the process is not done, return "busy" status */
      if ( (status == HW_OK) && pv->run )
      {
        status = HW_BUSY;
      }
    }
  }
  
  if(status != HW_OK)
  {
    HWCB_RNG_Process( );
  }

  /* Return status */
  return status;
}
