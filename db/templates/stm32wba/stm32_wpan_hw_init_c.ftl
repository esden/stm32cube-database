[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    hw_init.c
  * @author  MCD Application Team
  * @brief   This file contains the HW initialization for STM32WBA.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include "app_common.h"
#include "stm32wbaxx_hal.h"

/*****************************************************************************/

void HW_Config_HSE( uint8_t hsetune )
{
  HAL_RCCEx_SetHSETrimming( hsetune );
}

/*****************************************************************************/
