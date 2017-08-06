[#ftl]
/**
 ******************************************************************************
  * @file    bsp_driver_sdram.c (based on stm32h743i_eval_sdram.c)
  * @brief   This file includes a generic SDRAM driver.
  ******************************************************************************
[@common.optinclude name="Src/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* USER CODE BEGIN 0 */

/* Includes ------------------------------------------------------------------*/
#include "bsp_driver_sdram.h"
  
/**
  * @brief  Initializes the SDRAM device 
  * @retval SDRAM status
  */
uint8_t BSP_SDRAM_Init(void)
{
  uint8_t sdramstatus = SDRAM_OK;
  
  /* place for custom code */
  
  return sdramstatus;
}

/**
  * @brief  Reads an mount of data from the SDRAM memory in polling mode. 
  * @param  uwStartAddress: Read start address
  * @param  pData: Pointer to data to be read
  * @param  uwDataSize: Size of read data from the memory
  * @retval SDRAM status
  */
uint8_t BSP_SDRAM_ReadData(uint32_t uwStartAddress, uint32_t* pData, uint32_t uwDataSize)
{ 
  uint8_t sdramstatus = SDRAM_OK;
  
  if(HAL_SDRAM_Read_32b(&_HSDRAM, (uint32_t *)uwStartAddress, pData, uwDataSize) != HAL_OK)
  {
    sdramstatus = SDRAM_ERROR;
  }

  return sdramstatus;
}

/**
  * @brief  Reads an mount of data from the SDRAM memory in DMA mode. 
  * @param  uwStartAddress: Read start address
  * @param  pData: Pointer to data to be read  
  * @param  uwDataSize: Size of read data from the memory
  * @retval SDRAM status
  */
uint8_t BSP_SDRAM_ReadData_DMA(uint32_t uwStartAddress, uint32_t *pData, uint32_t uwDataSize)
{ 
  uint8_t sdramstatus = SDRAM_OK;
  
  if(HAL_SDRAM_Read_DMA(&_HSDRAM, (uint32_t *)uwStartAddress, pData, uwDataSize) != HAL_OK)
  {
    sdramstatus = SDRAM_ERROR;
  }
   
  return sdramstatus;
}

/**
  * @brief  Writes an mount of data to the SDRAM memory in polling mode.
  * @param  uwStartAddress: Write start address
  * @param  pData: Pointer to data to be written  
  * @param  uwDataSize: Size of written data from the memory
  * @retval SDRAM status
  */
uint8_t BSP_SDRAM_WriteData(uint32_t uwStartAddress, uint32_t *pData, uint32_t uwDataSize)
{ 
  uint8_t sdramstatus = SDRAM_OK;
  
  if(HAL_SDRAM_Write_32b(&_HSDRAM, (uint32_t *)uwStartAddress, pData, uwDataSize) != HAL_OK)
  {
    sdramstatus = SDRAM_ERROR;
  }

  return sdramstatus;
}

/**
  * @brief  Writes an mount of data to the SDRAM memory in DMA mode.
  * @param  uwStartAddress: Write start address
  * @param  pData: Pointer to data to be written  
  * @param  uwDataSize: Size of written data from the memory
  * @retval SDRAM status
  */
uint8_t BSP_SDRAM_WriteData_DMA(uint32_t uwStartAddress, uint32_t *pData, uint32_t uwDataSize)
{ 
  uint8_t sdramstatus = SDRAM_OK;
  
  if(HAL_SDRAM_Write_DMA(&_HSDRAM, (uint32_t *)uwStartAddress, pData, uwDataSize) != HAL_OK)
  {
    sdramstatus = SDRAM_ERROR;
  }

  return sdramstatus;
}

/**
  * @brief  Sends command to the SDRAM bank.
  * @param  SdramCmd: Pointer to SDRAM command structure 
  * @retval SDRAM status
  */  
uint8_t BSP_SDRAM_Sendcmd(FMC_SDRAM_CommandTypeDef *SdramCmd)
{ 
  uint8_t sdramstatus = SDRAM_OK;
  
  if(HAL_SDRAM_SendCommand(&_HSDRAM, SdramCmd, SDRAM_TIMEOUT) != HAL_OK)
  {
    sdramstatus = SDRAM_ERROR;
  }

  return sdramstatus;
}

/* USER CODE END 0 */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/