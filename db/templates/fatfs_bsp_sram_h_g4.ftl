[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
  * @file    bsp_driver_sram.h (based on stm32g474e_eval_sram.h)
  * @brief   This file contains the common defines and functions prototypes for  
  *          the bsp_driver_sram.c driver.
  ******************************************************************************  
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
 /* USER CODE END Header */     
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${FamilyName}_SRAM_H
#define __${FamilyName}_SRAM_H

#ifdef __cplusplus
 extern "C" {
#endif 

/* Includes ------------------------------------------------------------------*/
#include "${FamilyName?lower_case}xx_hal.h"
#include "${FamilyName?lower_case}xx_hal_sram.h"

/* USER CODE BEGIN 0 */

/** 
  * @brief  SRAM status structure definition  
  */     
#define BSP_ERROR_NONE            0  /* from stm32g474e_eval_errno.h */

#define SRAM_DEVICE_ADDR  0x60000000U  
#define SRAM_DEVICE_SIZE  0x00100000U  /* 1 MBytes */
 
/* Other defines, such as the ones for SRAM DMA transfer, can be added here */


/* Exported functions --------------------------------------------------------*/
int32_t BSP_SRAM_Init(uint32_t Instance);
void BSP_SRAM_DMA_IRQHandler(void);

/* USER CODE END 0 */
   
#ifdef __cplusplus
}
#endif

#endif /* __${FamilyName}_SRAM_H */

