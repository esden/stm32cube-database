[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
 * @file    bsp_driver_sram.c for L5 (based on stm32l5_eval_sram.c)
 * @brief   This file includes a generic SRAM driver 
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

/* USER CODE BEGIN UserDefinitions */
/* user definitions can be inserted here (adding new ones / suppressing existing ones) */
/* Includes ------------------------------------------------------------------*/
#include "bsp_driver_sram.h"

/* USER CODE END UserDefinitions */

/* Extern variables ----------------------------------------------------------*/
extern SRAM_HandleTypeDef ${sramHandle};

/* USER CODE BEGIN UserCode */
/* user code can be inserted here (adding new one /modifying or suppressing existing one) */
/**
  * @brief  Initializes the SRAM device.
  * @retval SRAM status
  */
__weak int32_t BSP_SRAM_Init(uint32_t Instance)
{ 
  int32_t ret = BSP_ERROR_NONE;
  
  /* place for user code (empty function generated to correctly compile the call to it in sram_diskio.c file */
  
  return ret;
}
/* USER CODE BEGIN UserCode */

