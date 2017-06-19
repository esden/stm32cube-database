[#ftl]
/**
 ******************************************************************************
  * @file    bsp_driver_sram.h (based on stm3210e_eval_sram.h)
  * @brief   This file contains the common defines and functions prototypes for  
  *          the bsp_driver_sram.c driver.
  ******************************************************************************
[@common.optinclude name="Src/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
  
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM32F1XX_SRAM_H
#define __STM32F1XX_SRAM_H

#ifdef __cplusplus
 extern "C" {
#endif 


/* Includes ------------------------------------------------------------------*/
#include "stm32f1xx_hal.h"
#include "stm32f1xx_hal_sram.h"
[#-- SWIPdatas is a list of SWIPconfigModel --]  
[#list SWIPdatas as SWIP]  
[#if SWIP.defines??]
	[#list SWIP.defines as definition]	
/*---------- Handle for SRAM -----------*/
#define ${definition.name} #t#t ${definition.value} 
[#if definition.description??]${definition.description} [/#if]
	[/#list]
[/#if]

[/#list]
/* USER CODE BEGIN 0 */

/** @defgroup STM3210E_EVAL_SRAM_Exported_Constants Exported_Constants
  * @{
  */
  
/** 
  * @brief  SRAM status structure definition  
  */     
#define   SRAM_OK         ((uint8_t)0x00)
#define   SRAM_ERROR      ((uint8_t)0x01)

#define SRAM_DEVICE_ADDR  ((uint32_t)0x68000000)
#define SRAM_DEVICE_SIZE  ((uint32_t)0x200000)  /* SRAM device size in MBytes */  
  
/* #define SRAM_MEMORY_WIDTH    FSMC_NORSRAM_MEM_BUS_WIDTH_8  */
#define SRAM_MEMORY_WIDTH    FSMC_NORSRAM_MEM_BUS_WIDTH_16

#define SRAM_BURSTACCESS    FSMC_BURST_ACCESS_MODE_DISABLE  
/* #define SRAM_BURSTACCESS    FSMC_BURST_ACCESS_MODE_ENABLE*/
  
#define SRAM_WRITEBURST    FSMC_WRITE_BURST_DISABLE  
/* #define SRAM_WRITEBURST   FSMC_WRITE_BURST_ENABLE */
 
/* DMA definitions for SRAM DMA transfer */
#define __SRAM_DMAx_CLK_ENABLE            __HAL_RCC_DMA2_CLK_ENABLE
#define SRAM_DMAx_STREAM                  DMA2_Channel1  
#define SRAM_DMAx_IRQn                    DMA2_Channel1_IRQn
#define SRAM_DMAx_IRQHandler              DMA2_Channel1_IRQHandler  

extern SRAM_HandleTypeDef _HSRAM;


/* Exported functions --------------------------------------------------------*/
/** @addtogroup STM3210E_EVAL_SRAM_Exported_Functions
  * @{
  */    
uint8_t BSP_SRAM_Init(void);
uint8_t BSP_SRAM_ReadData(uint32_t uwStartAddress, uint16_t *pData, uint32_t uwDataSize);
uint8_t BSP_SRAM_ReadData_DMA(uint32_t uwStartAddress, uint16_t *pData, uint32_t uwDataSize);
uint8_t BSP_SRAM_WriteData(uint32_t uwStartAddress, uint16_t *pData, uint32_t uwDataSize);
uint8_t BSP_SRAM_WriteData_DMA(uint32_t uwStartAddress, uint16_t *pData, uint32_t uwDataSize);
void BSP_SRAM_DMA_IRQHandler(void);

/* USER CODE END 0 */
   
#ifdef __cplusplus
}
#endif

#endif /* __STM32F1XX_SRAM_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/