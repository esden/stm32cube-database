[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name?lower_case}.c
  * @author  MCD Application Team
  * @brief   This file provides code for the configuration
  *                      of the touchsensing instances.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "touchsensing.h"

/* USER CODE BEGIN 0 */
/* USER CODE END 0 */

/* USER CODE BEGIN 1 */
/* USER CODE END 1 */

/* Global variables ---------------------------------------------------------*/

/* USER CODE BEGIN 2 */
/* USER CODE END 2 */

/* TOUCHSENSING init function */
[#if THREADX??]
TSL_Status_enum_T  MX_TOUCHSENSING_Init(void *memory_ptr)
{
/***************************************/
   /**
  */

  tsl_user_Init();

  /* USER CODE BEGIN 3 */
  /* USER CODE END 3 */

  return TSL_STATUS_OK;
}
[#else]
void MX_TOUCHSENSING_Init(void)
{
/***************************************/
   /**
  */

  tsl_user_Init();

  /* USER CODE BEGIN 3 */
  /* USER CODE END 3 */

}
[/#if]
/* USER CODE BEGIN 4 */
/* USER CODE END 4 */

/**
  * @}
  */

/**
  * @}
  */
