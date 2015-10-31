/**
  ******************************************************************************
  * @file    stm32f4xx_sd.c
  * @author  MCD Teams
  * @version V1.0.0
  * @date    28-September-2013
  * @brief   This file includes the uSD card driver.
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

/* Includes ------------------------------------------------------------------*/
#include "stm32f4xx_sd.h"


extern SD_HandleTypeDef  hsd;
extern HAL_SD_CardInfoTypedef SD_CardInfo; 

/* static void SD_LL_Init(void); */
static uint8_t SD_Detect(void);
    
/** @defgroup STM32F4XX_SD_Private_Functions
  * @{
  */ 

    
/**
  * @brief  Initializes the SD card device.
  * @param  None
  * @retval None
  */
HAL_SD_ErrorTypedef SD_Init(void)
{ 
  HAL_SD_ErrorTypedef SD_state = SD_OK;
  
  /* uSD device interface configuration */
  /*
  hsd.Instance = SDIO;
    
  hsd.Init.ClockEdge           = SDIO_CLOCK_EDGE_RISING;
  hsd.Init.ClockBypass         = SDIO_CLOCK_BYPASS_DISABLE;
  hsd.Init.ClockPowerSave      = SDIO_CLOCK_POWER_SAVE_DISABLE;
  hsd.Init.BusWide             = SDIO_BUS_WIDE_1B;
  hsd.Init.HardwareFlowControl = SDIO_HARDWARE_FLOW_CONTROL_DISABLE;
  hsd.Init.ClockDiv            = SDIO_TRANSFER_CLK_DIV;
  */
  
  /* Check the SD card is plugged in the slot */
  if(SD_Detect() != SD_PRESENT)
  {
    return SD_ERROR;
  }
  
  /* uSD card low level initialization */
  /* SD_LL_Init(); */
  
  /* HAL SD initialization */
// SD_state = HAL_SD_Init(&hsd, &SD_CardInfo);
  
  /* Configure SD Bus width */
//  if (SD_state == SD_OK)
//  {
//    /* Enable wide operation */
//    SD_state = HAL_SD_WideBusOperation_Config(&hsd, SDIO_BUS_WIDE_4B);
//  }
 
  return  SD_state;
  
}

/**
 * @brief  Detect if SD card is correctly plugged in the memory slot.
 * @param  None
 * @retval Return if SD is detected or not
 */
static uint8_t SD_Detect(void)
{
  __IO uint8_t status = SD_PRESENT;

  /* Initialize IO expander 1600 */
//  if(IOE16_Config(hi2c_eval, IOE16_ADDR) != IOE16_OK)
//  {
//    return SD_NOT_PRESENT;
//  }
   
  /* Check SD card is present */
//  if (IOE16_MonitorIOPin(hi2c_eval, IOE16_ADDR, SD_DETECT_PIN) != IOE16_BitReset) 
//  {
//    status = SD_NOT_PRESENT;
//  }
  
  return status;
}


/**
  * @brief  Read block(s) from a specified address in a card. The Data
  *         transfer is managed by polling mode.  
  * @param  pData: pointer to the buffer that will contain the data to transmit
  * @param  ReadAddr: Address from where data is to be read.  
  * @param  BlockSize: The SD card Data block size. 
  * @note   The Block size should be 512.
  * @param  NumOfBlocks: Number of SD blocks to write. 
  * @retval SD Card error state.
  */
HAL_SD_ErrorTypedef SD_ReadBlocks(uint32_t *pData, uint64_t ReadAddr, uint32_t BlockSize, uint32_t NumOfBlocks)
{
  return(HAL_SD_ReadBlocks(&hsd, pData, ReadAddr, BlockSize, NumOfBlocks));
}

/**
  * @brief  Write block(s) to a specified address in a card. The Data
  *         transfer is managed by polling mode.  
  * @param  pData: pointer to the buffer that will contain the data to transmit
  * @param  WriteAddr: Address from where data is to be written.  
  * @param  BlockSize: The SD card Data block size. 
  * @note   The Block size should be 512.
  * @param  NumOfBlocks: Number of SD blocks to write. 
  * @retval SD Card error state.
  */
HAL_SD_ErrorTypedef SD_WriteBlocks(uint32_t *pData, uint64_t WriteAddr, uint32_t BlockSize, uint32_t NumOfBlocks)
{
  return(HAL_SD_WriteBlocks(&hsd, pData, WriteAddr, BlockSize, NumOfBlocks));
}


/**
  * @brief  Read block(s) from a specified address in a card. The Data
  *         transfer is managed by DMA mode.  
  * @param  pData: pointer to the buffer that will contain the data to transmit
  * @param  ReadAddr: Address from where data is to be read.  
  * @param  BlockSize: The SD card Data block size. 
  * @note   The Block size should be 512.
  * @param  NumOfBlocks: Number of SD blocks to write. 
  * @retval SD Card error state.
  */
HAL_SD_ErrorTypedef SD_ReadBlocks_DMA(uint32_t *pData, uint64_t ReadAddr, uint32_t BlockSize, uint32_t NumOfBlocks)
{
  HAL_SD_ErrorTypedef SD_state = SD_OK;
  
  SD_state = HAL_SD_ReadBlocks_DMA(&hsd, pData, ReadAddr, BlockSize, NumOfBlocks);
  
  if (SD_state == SD_OK)
  {
    SD_state = HAL_SD_CheckReadOperation(&hsd, (uint32_t)SD_DATATIMEOUT);
  }
  
  return SD_state; 
}

/**
  * @brief  Write block(s) to a specified address in a card. The Data
  *         transfer is managed by DMA mode.  
  * @param  pData: pointer to the buffer that will contain the data to transmit
  * @param  WriteAddr: Address from where data is to be written.  
  * @param  BlockSize: The SD card Data block size. 
  * @note   The Block size should be 512.
  * @param  NumOfBlocks: Number of SD blocks to write. 
  * @retval SD Card error state.
  */
HAL_SD_ErrorTypedef SD_WriteBlocks_DMA(uint32_t *pData, uint64_t WriteAddr, uint32_t BlockSize, uint32_t NumOfBlocks)
{
  HAL_SD_ErrorTypedef SD_state = SD_OK;
  
  SD_state = HAL_SD_WriteBlocks_DMA(&hsd, pData, WriteAddr, BlockSize, NumOfBlocks);
  
  if (SD_state == SD_OK)
  {
    SD_state = HAL_SD_CheckWriteOperation(&hsd, (uint32_t)SD_DATATIMEOUT);
  }
  
  return SD_state;  
}


/**
  * @brief  Erase the specified memory area of the given SD card. 
  * @param  Startaddr: The start byte address.
  * @param  Endaddr: The end byte address.
  * @retval SD Card error state.
  */
HAL_SD_ErrorTypedef SD_Erase(uint64_t Startaddr, uint64_t Endaddr)
{
  return(HAL_SD_Erase(&hsd, Startaddr, Endaddr));
}



/**
  * @brief  This function handles SD card interrupt request.
  * @param  none
  * @retval none
  */
void SD_IRQHandler(void)
{
  HAL_SD_IRQHandler(&hsd);
}

/**
  * @brief  This function handles SD DMA Tx transfer interrupt request.
  * @param  none
  * @retval none
  */
void SD_DMA_Tx_IRQHandler(void)
{
  HAL_DMA_IRQHandler(hsd.hdmatx); 
}

/**
  * @brief  This function handles SD DMA Rx transfer interrupt request.
  * @param  none
  * @retval none
  */
void SD_DMA_Rx_IRQHandler(void)
{
  HAL_DMA_IRQHandler(hsd.hdmarx);
}


/**
  * @brief  Get the current SD card data status.
  * @param  none
  * @retval SDTransferState: Data Transfer state.
  *         This value can be: 
  *          @arg SD_TRANSFER_OK:   No data transfer is acting
  *          @arg SD_TRANSFER_BUSY: Data transfer is acting
  *          @arg SD_TRANSFER_ERROR: Data transfer error 
  */
HAL_SD_TransferStateTypedef SD_GetStatus(void)
{
  return(HAL_SD_GetStatus(&hsd));
}

/**
  * @brief  Returns information about specific card.
  * @param  none
  * @retval pCardInfo: pointer to a HAL_SD_CardInfoTypedef structure that contains all SD card 
  *         information.  
  */
HAL_SD_CardInfoTypedef SD_GetCardInfo(void)
{
  HAL_SD_CardInfoTypedef sdCardInfo;
  
  /* Get SD card Information */
  SD_Get_CardInfo(&hsd, &sdCardInfo);
  
  return(sdCardInfo);
}


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
