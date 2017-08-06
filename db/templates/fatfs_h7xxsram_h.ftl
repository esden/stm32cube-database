[#ftl]
/**
 ******************************************************************************
  * @file    bsp_driver_sram.h (based on stm32h743i_eval_sram.h)
  * @brief   This file contains the common defines and functions prototypes for  
  *          the bsp_driver_sram.c driver.
  ******************************************************************************
[@common.optinclude name="Src/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
  
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM32H7XX_SRAM_H
#define __STM32H7XX_SRAM_H

#ifdef __cplusplus
 extern "C" {
#endif 

/* Includes ------------------------------------------------------------------*/
#include "stm32h7xx_hal.h"
#include "stm32h7xx_hal_sram.h"

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

/** @defgroup STM32H743I_EVAL_SRAM_Exported_Constants
  * @{
  */ 
/** 
  * @brief  SRAM status structure definition  
  */     
#define   SRAM_OK         ((uint8_t)0x00)
#define   SRAM_ERROR      ((uint8_t)0x01)

#define SRAM_DEVICE_ADDR  ((uint32_t)0x68000000)
#define SRAM_DEVICE_SIZE  ((uint32_t)0x200000)  /* SRAM device size in MBytes */  
  
/* #define SRAM_MEMORY_WIDTH    FMC_NORSRAM_MEM_BUS_WIDTH_8  */
#define SRAM_MEMORY_WIDTH    FMC_NORSRAM_MEM_BUS_WIDTH_16

#define SRAM_BURSTACCESS    FMC_BURST_ACCESS_MODE_DISABLE  
/* #define SRAM_BURSTACCESS    FMC_BURST_ACCESS_MODE_ENABLE*/
  
#define SRAM_WRITEBURST    FMC_WRITE_BURST_DISABLE  
/* #define SRAM_WRITEBURST   FMC_WRITE_BURST_ENABLE */
 
#define CONTINUOUSCLOCK_FEATURE    FMC_CONTINUOUS_CLOCK_SYNC_ONLY 
/* #define CONTINUOUSCLOCK_FEATURE     FMC_CONTINUOUS_CLOCK_SYNC_ASYNC */ 

/* DMA definitions for SRAM DMA transfer */
#define __SRAM_MDMAx_CLK_ENABLE            __HAL_RCC_MDMA_CLK_ENABLE
#define __SRAM_MDMAx_CLK_DISABLE           __HAL_RCC_MDMA_CLK_DISABLE
#define SRAM_MDMAx_CHANNEL                 MDMA_Channel1
#define SRAM_MDMAx_IRQn                    MDMA_IRQn

extern SRAM_HandleTypeDef _HSRAM;


/* Exported functions --------------------------------------------------------*/   
uint8_t BSP_SRAM_Init(void);
uint8_t BSP_SRAM_ReadData(uint32_t uwStartAddress, uint16_t *pData, uint32_t uwDataSize);
uint8_t BSP_SRAM_ReadData_DMA(uint32_t uwStartAddress, uint16_t *pData, uint32_t uwDataSize);
uint8_t BSP_SRAM_WriteData(uint32_t uwStartAddress, uint16_t *pData, uint32_t uwDataSize);
uint8_t BSP_SRAM_WriteData_DMA(uint32_t uwStartAddress, uint16_t *pData, uint32_t uwDataSize);

/* USER CODE END 0 */
   
#ifdef __cplusplus
}
#endif

#endif /* __STM32H7XX_SRAM_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/