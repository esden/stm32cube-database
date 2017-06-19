[#ftl]
/**
 ******************************************************************************
  * @file    bsp_driver_sd.h (based on stm324x9i_eval_sd.h)
  * @brief   This file contains the common defines and functions prototypes for 
  *          the bsp_driver_sd.c driver.
  ******************************************************************************
[@common.optinclude name="Src/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM32F4XX_SD_H
#define __STM32F4XX_SD_H

#ifdef __cplusplus
 extern "C" {
#endif 

/* Includes ------------------------------------------------------------------*/
#include "stm32f4xx_hal.h"
[#if Platform??]
#include "fatfs_platform.h"
[/#if]

/* Exported constants --------------------------------------------------------*/ 

/** 
  * @brief SD Card information structure 
  */
#ifndef BSP_SD_CardInfo
  #define BSP_SD_CardInfo HAL_SD_CardInfoTypeDef
#endif

/**  
  * @brief  SD status structure definition  
  */     
#define   MSD_OK                        ((uint8_t)0x00)
#define   MSD_ERROR                     ((uint8_t)0x01)
   
/** 
  * @brief  SD transfer state definition  
  */     
#define   SD_TRANSFER_OK                ((uint8_t)0x00)
#define   SD_TRANSFER_BUSY              ((uint8_t)0x01)
/** @defgroup STM324x9I_EVAL_SD_Exported_Constants STM324x9I EVAL SD Exported Constants
  * @{
  */ 
#define SD_PRESENT               ((uint8_t)0x01)
#define SD_NOT_PRESENT           ((uint8_t)0x00) 
#define SD_DATATIMEOUT           ((uint32_t)100000000)

#ifdef OLD_API
/* kept to avoid issue when migrating old projects. */
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */ 
#else
/* USER CODE BEGIN BSP_H_CODE */
/* DMA definitions for SD DMA transfer */
/*
#define __DMAx_TxRx_CLK_ENABLE            __HAL_RCC_DMA2_CLK_ENABLE
#define SD_DMAx_Tx_CHANNEL                DMA_CHANNEL_4
#define SD_DMAx_Rx_CHANNEL                DMA_CHANNEL_4
#define SD_DMAx_Tx_STREAM                 DMA2_Stream6  
#define SD_DMAx_Rx_STREAM                 DMA2_Stream3  
#define SD_DMAx_Tx_IRQn                   DMA2_Stream6_IRQn
#define SD_DMAx_Rx_IRQn                   DMA2_Stream3_IRQn
#define SD_DMAx_Tx_IRQHandler             DMA2_Stream6_IRQHandler   
#define SD_DMAx_Rx_IRQHandler             DMA2_Stream3_IRQHandler 
#define SD_DetectIRQHandler()             HAL_GPIO_EXTI_IRQHandler(GPIO_PIN_8)
*/

/* Exported functions --------------------------------------------------------*/   
uint8_t BSP_SD_Init(void);
uint8_t BSP_SD_ITConfig(void);
void    BSP_SD_DetectIT(void);
void    BSP_SD_DetectCallback(void);
uint8_t BSP_SD_ReadBlocks(uint32_t *pData, uint32_t ReadAddr, uint32_t NumOfBlocks, uint32_t Timeout);
uint8_t BSP_SD_WriteBlocks(uint32_t *pData, uint32_t WriteAddr, uint32_t NumOfBlocks, uint32_t Timeout);
uint8_t BSP_SD_ReadBlocks_DMA(uint32_t *pData, uint32_t ReadAddr, uint32_t NumOfBlocks);
uint8_t BSP_SD_WriteBlocks_DMA(uint32_t *pData, uint32_t WriteAddr, uint32_t NumOfBlocks);
uint8_t BSP_SD_Erase(uint32_t StartAddr, uint32_t EndAddr);
void BSP_SD_IRQHandler(void);
void BSP_SD_DMA_Tx_IRQHandler(void);
void BSP_SD_DMA_Rx_IRQHandler(void);
uint8_t BSP_SD_GetCardState(void);
void    BSP_SD_GetCardInfo(BSP_SD_CardInfo *CardInfo);
uint8_t BSP_SD_IsDetected(void);
/* USER CODE END BSP_H_CODE */
#endif
   
#ifdef __cplusplus
}
#endif

#endif /* __STM32F4XX_SD_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/