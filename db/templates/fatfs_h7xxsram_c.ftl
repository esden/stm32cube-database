[#ftl]
/**
 ******************************************************************************
  * @file    bsp_driver_sram.c (based on stm32h743i_eval_sram.c)
  * @brief   This file includes a generic SRAM driver.
  ******************************************************************************
[@common.optinclude name="Src/license.tmp"/][#--include License text --]
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

/* USER CODE END 0 */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/