[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name?lower_case}.h
  * @author  MCD Application Team
  * @brief   This file provides code for the configuration
  *                      of the touchsensing instances.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __touchsensing_H
#define __touchsensing_H
#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "tsl_conf.h"
#include "tsl_user.h"

/* USER CODE BEGIN 0 */
/* USER CODE END 0 */

/* Global variables ---------------------------------------------------------*/

/* USER CODE BEGIN 1 */
/* USER CODE END 1 */

/* TOUCHSENSING init function */
[#if THREADX??]
TSL_Status_enum_T  MX_TOUCHSENSING_Init(void *memory_ptr);
[#else]
void  MX_TOUCHSENSING_Init(void);
[/#if]

/* USER CODE BEGIN 2 */
/* USER CODE END 2 */

#ifdef __cplusplus
}
#endif
#endif /*__touchsensing_H */

/**
  * @}
  */

/**
  * @}
  */
