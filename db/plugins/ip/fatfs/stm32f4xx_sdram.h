/**
  ******************************************************************************
  * @file    stm32f4xx_sdram.h
  * @author  MCD Teams
  * @version V1.0.0
  * @date    28-September-2013
  * @brief   This file contains all the functions prototypes for the stm32f4xx_sdramX.c
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
#ifndef __STM32F4XX_SDRAM_H
#define __STM32F4XX_SDRAM_H

#ifdef __cplusplus
 extern "C" {
#endif 

/* Includes ------------------------------------------------------------------*/
#include "stm32f4xx_hal.h"
#include "fatfs_handles.h"

/* Exported types ------------------------------------------------------------*/ 
/* Exported constants --------------------------------------------------------*/   
#define SDRAM_DEVICE_ADDR  ((uint32_t)0xC0000000)
#define SDRAM_DEVICE_SIZE  ((uint32_t)0x800000)  /* SDRAM device size in MBytes */

/* #define SDRAM_MEMORY_WIDTH            FMC_SDRAM_MEM_BUS_WIDTH_8  */
/* #define SDRAM_MEMORY_WIDTH            FMC_SDRAM_MEM_BUS_WIDTH_16 */
//#define SDRAM_MEMORY_WIDTH               FMC_SDRAM_MEM_BUS_WIDTH_32

//#define SDCLOCK_PERIOD                   FMC_SDRAM_CLOCK_PERIOD_2
/* #define SDCLOCK_PERIOD                FMC_SDRAM_CLOCK_PERIOD_3 */

//#define SDRAM_READBURST                  FMC_SDRAM_RBURST_DISABLE 
/* #define SDRAM_READBURST               FMC_SDRAM_RBURST_ENABLE */    

//#define REFRESH_COUNT                    ((uint32_t)1292)   /* SDRAM refresh counter */
   
#define SDRAM_TIMEOUT     ((uint32_t)0xFFFF) 

/* DMA definitions for SDRAM DMA transfer */
//#define __DMAx_CLK_ENABLE                 __DMA2_CLK_ENABLE
//#define SDRAM_DMAx_CHANNEL                DMA_CHANNEL_0
//#define SDRAM_DMAx_STREAM                 DMA2_Stream0  
//#define SDRAM_DMAx_IRQn                   DMA2_Stream0_IRQn
//#define SDRAM_DMAx_IRQHandler             DMA2_Stream0_IRQHandler 
   

/**
  * @brief  FMC SDRAM Mode definition register defines
  */
//#define SDRAM_MODEREG_BURST_LENGTH_1             ((uint16_t)0x0000)
//#define SDRAM_MODEREG_BURST_LENGTH_2             ((uint16_t)0x0001)
//#define SDRAM_MODEREG_BURST_LENGTH_4             ((uint16_t)0x0002)
//#define SDRAM_MODEREG_BURST_LENGTH_8             ((uint16_t)0x0004)
//#define SDRAM_MODEREG_BURST_TYPE_SEQUENTIAL      ((uint16_t)0x0000)
//#define SDRAM_MODEREG_BURST_TYPE_INTERLEAVED     ((uint16_t)0x0008)
//#define SDRAM_MODEREG_CAS_LATENCY_2              ((uint16_t)0x0020)
//#define SDRAM_MODEREG_CAS_LATENCY_3              ((uint16_t)0x0030)
//#define SDRAM_MODEREG_OPERATING_MODE_STANDARD    ((uint16_t)0x0000)
#define SDRAM_MODEREG_WRITEBURST_MODE_PROGRAMMED ((uint16_t)0x0000) 
#define SDRAM_MODEREG_WRITEBURST_MODE_SINGLE     ((uint16_t)0x0200)  

extern SDRAM_HandleTypeDef _HSDRAM;

/* Exported functions --------------------------------------------------------*/   
void SDRAM_Init(void);
void SDRAM_Initialization_sequence(uint32_t RefreshCount);
void SDRAM_ReadData(uint32_t uwStartAddress, uint32_t* pData, uint32_t uwDataSize);
void SDRAM_ReadData_DMA(uint32_t uwStartAddress, uint32_t* pData, uint32_t uwDataSize);
void SDRAM_WriteData(uint32_t uwStartAddress, uint32_t* pData, uint32_t uwDataSize);
void SDRAM_WriteData_DMA(uint32_t uwStartAddress, uint32_t* pData, uint32_t uwDataSize);
HAL_StatusTypeDef SDRAM_Sendcmd(FMC_SDRAM_CommandTypeDef *SdramCmd);
void SDRAM_DMA_IRQHandler(void);

/**
  * @}
  */
/**
  * @}
  */   
   
#ifdef __cplusplus
}
#endif

#endif /* __STM32F4XX_SDRAM_H */
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
