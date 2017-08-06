[#ftl]
/**
 ******************************************************************************
  * @file    bsp_driver_sram.c (based on stm32l476g_eval_sram.c)
  * @brief   This file includes a generic SRAM driver.
  ******************************************************************************
  *
  * COPYRIGHT(c) ${year} STMicroelectronics
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  *   1. Redistributions of source code must retain the above copyright notice,
  *      this list of conditions and the following disclaimer.
  *   2. Redistributions in binary form must reproduce the above copyright notice,
  *      this list of conditions and the following disclaimer in the documentation
  *      and/or other materials provided with the distribution.
  *   3. Neither the name of STMicroelectronics nor the names of its contributors
  *      may be used to endorse or promote products derived from this software
  *      without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
  * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
  * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */

/* USER CODE BEGIN 0 */

/* Includes ------------------------------------------------------------------*/
#include "bsp_driver_sram.h"
  
/**
  * @brief  Initializes the SRAM device.
  * @retval SRAM status
  */
uint8_t BSP_SRAM_Init(void)
{ 
  uint8_t sramstatus = SRAM_OK;
  
  /* place for user code */
  
  return sramstatus;
}

/**
  * @brief  Reads an amount of data from the SRAM device in polling mode.
  * @param  uwStartAddress: Read start address
  * @param  pData: Pointer to data to be read
  * @param  uwDataSize: Size of read data from the memory   
  * @retval SRAM status
  */
uint8_t BSP_SRAM_ReadData(uint32_t uwStartAddress, uint16_t *pData, uint32_t uwDataSize)
{ 
  uint8_t sramstatus = SRAM_OK;

  if(HAL_SRAM_Read_16b(&_HSRAM, (uint32_t *)uwStartAddress, pData, uwDataSize) != HAL_OK)
  {
    sramstatus = SRAM_ERROR;
  }

  return sramstatus;
}

/**
  * @brief  Reads an amount of data from the SRAM device in DMA mode.
  * @param  uwStartAddress: Read start address
  * @param  pData: Pointer to data to be read
  * @param  uwDataSize: Size of read data from the memory   
  * @retval SRAM status
  */
uint8_t BSP_SRAM_ReadData_DMA(uint32_t uwStartAddress, uint16_t *pData, uint32_t uwDataSize)
{
  uint8_t sramstatus = SRAM_OK;
  
  if(HAL_SRAM_Read_DMA(&_HSRAM, (uint32_t *)uwStartAddress, (uint32_t *)pData, uwDataSize) != HAL_OK)
  {
    sramstatus = SRAM_ERROR;
  }

  return sramstatus;
}

/**
  * @brief  Writes an amount of data from the SRAM device in polling mode.
  * @param  uwStartAddress: Write start address
  * @param  pData: Pointer to data to be written
  * @param  uwDataSize: Size of written data from the memory   
  * @retval SRAM status
  */
uint8_t BSP_SRAM_WriteData(uint32_t uwStartAddress, uint16_t *pData, uint32_t uwDataSize) 
{
  uint8_t sramstatus = SRAM_OK;
  
  if(HAL_SRAM_Write_16b(&_HSRAM, (uint32_t *)uwStartAddress, pData, uwDataSize) != HAL_OK)
  {
    sramstatus = SRAM_ERROR;
  }

  return sramstatus;
}

/**
  * @brief  Writes an amount of data from the SRAM device in DMA mode.
  * @param  uwStartAddress: Write start address
  * @param  pData: Pointer to data to be written
  * @param  uwDataSize: Size of written data from the memory   
  * @retval SRAM status
  */
uint8_t BSP_SRAM_WriteData_DMA(uint32_t uwStartAddress, uint16_t *pData, uint32_t uwDataSize) 
{
  uint8_t sramstatus = SRAM_OK;
  
  if(HAL_SRAM_Write_DMA(&_HSRAM, (uint32_t *)uwStartAddress, (uint32_t *)pData, uwDataSize) != HAL_OK)
  {
    sramstatus = SRAM_ERROR;
  }

  return sramstatus;
}

/**
  * @brief  Handles SRAM DMA transfer interrupt request.
  */
void BSP_SRAM_DMA_IRQHandler(void)
{
  HAL_DMA_IRQHandler(_HSRAM.hdma); 
}

/* USER CODE END 0 */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/