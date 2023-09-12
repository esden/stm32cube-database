[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
 * @file    bsp_driver_sram.c for G4 (based on stm32g474e_eval_sram.c)
 * @brief   This file includes a generic SRAM driver.
 *          To be updated by the user according to the board used for the project.
 * @note    Functions generated as weak: they can be overridden by 
 *          - code in user files 
 *          - or BSP code from the FW pack files 
 *          if such files are added to the generated project (by the user).
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#-- SWIPdatas is a list of SWIPconfigModel --]  
[#list SWIPdatas as SWIP]  
[#if SWIP.defines??]
 [#list SWIP.defines as definition]
  [#if definition.name=="_HSRAM"]
   [#assign sramHandle = definition.value]
  [/#if]
 [/#list]
[/#if]
[/#list]

/* Includes ------------------------------------------------------------------*/
#include "bsp_driver_sram.h"

/* Extern variables ----------------------------------------------------------*/
extern SRAM_HandleTypeDef ${sramHandle};

/* USER CODE BEGIN Init */
/**
  * @brief  Initializes the SRAM device.
  * @param  Instance SRAM instance
  * @retval BSP status
  */
__weak int32_t BSP_SRAM_Init(uint32_t Instance)
{ 
  int32_t ret = BSP_ERROR_NONE;
  
  /* place for user code */
  
  return ret;
}
/* USER CODE END Init */


/**
  * @brief  This function handles SRAM DMA interrupt request.
  * @retval None
  */
__weak void BSP_SRAM_DMA_IRQHandler(void)
{
  HAL_DMA_IRQHandler(${sramHandle}.hdma);
}

/* USER CODE BEGIN AdditionalCode */
/* user code can be inserted here */
/* USER CODE END AdditionalCode */
