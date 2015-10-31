/**
  ******************************************************************************
  * @file    stm32f4xx_sd.h
  * @author  MCD Teams
  * @version V1.0.0
  * @date    28-September-2013
  * @brief   This file contains all the functions prototypes for the stm32f4xx_sd.c
  *          driver.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2012 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
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

/* Exported types ------------------------------------------------------------*/ 
/* Exported constants --------------------------------------------------------*/ 
#define SD_DATATIMEOUT           ((uint32_t)0xFFFFFFFF)

#define SD_PRESENT               ((uint8_t)0x01)
#define SD_NOT_PRESENT           ((uint8_t)0x00)
   
/* DMA definitions for SD DMA transfer */
/*
#define __DMAx_TxRx_CLK_ENABLE            __DMA2_CLK_ENABLE
#define SD_DMAx_Tx_CHANNEL                DMA_CHANNEL_4
#define SD_DMAx_Rx_CHANNEL                DMA_CHANNEL_4
#define SD_DMAx_Tx_STREAM                 DMA2_Stream6  
#define SD_DMAx_Rx_STREAM                 DMA2_Stream3  
#define SD_DMAx_Tx_IRQn                   DMA2_Stream6_IRQn
#define SD_DMAx_Rx_IRQn                   DMA2_Stream3_IRQn
#define SD_DMAx_Tx_IRQHandler             DMA2_Stream6_IRQHandler   
#define SD_DMAx_Rx_IRQHandler             DMA2_Stream3_IRQHandler  
*/

/* Exported functions --------------------------------------------------------*/   
HAL_SD_ErrorTypedef SD_Init(void);
HAL_SD_ErrorTypedef SD_ReadBlocks(uint32_t *pData, uint64_t ReadAddr, uint32_t BlockSize, uint32_t NumOfBlocks);
HAL_SD_ErrorTypedef SD_WriteBlocks(uint32_t *pData, uint64_t WriteAddr, uint32_t BlockSize, uint32_t NumOfBlocks);
HAL_SD_ErrorTypedef SD_ReadBlocks_DMA(uint32_t *pData, uint64_t ReadAddr, uint32_t BlockSize, uint32_t NumOfBlocks);
HAL_SD_ErrorTypedef SD_WriteBlocks_DMA(uint32_t *pData, uint64_t WriteAddr, uint32_t BlockSize, uint32_t NumOfBlocks);
HAL_SD_ErrorTypedef SD_Erase(uint64_t Startaddr, uint64_t Endaddr);
void SD_IRQHandler(void);
void SD_DMA_Tx_IRQHandler(void);
void SD_DMA_Rx_IRQHandler(void);
HAL_SD_TransferStateTypedef SD_GetStatus(void);
HAL_SD_CardInfoTypedef SD_GetCardInfo(void);

/**
  * @}
  */
/**
  * @}
  */   
   
#ifdef __cplusplus
}
#endif

#endif /* __STM32F4XX_SD_H */
/**
  * @}
  */ 

/**
  * @}
  */ 

/**
  * @}
  */ 

/**
  * @}
  */ 

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
