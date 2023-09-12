[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
 * @file    bsp_driver_sram.c (based on stm32h743i_eval_sram.c)
 * @brief   This file includes a generic SRAM driver.
 *          To be updated by the user according to the board used for the project.
 * @note    Functions generated as weak: they can be overridden by 
 *          - code in user files 
 *          - or BSP code from the FW pack files 
 *          if such files are added to the generated project (by the user).
 ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
 ******************************************************************************
 */
/* USER CODE END Header */

[#-- SWIPdatas is a list of SWIPconfigModel --]  
[#list SWIPdatas as SWIP]  
[#if SWIP.defines??]
 [#list SWIP.defines as definition]
  [#if definition.name=="_HSRAM"]
   [#assign sramHandle = definition.value]
  [/#if]
 [/#list]
[/#if]
[/#list]

#ifdef OLD_CODE
/* Kept to avoid issue when migrating old projects (as some user sections were renamed/changed). */
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */
#else

/* Includes ------------------------------------------------------------------*/
#include "bsp_driver_sram.h"

/* Extern variables ----------------------------------------------------------*/
extern SRAM_HandleTypeDef ${sramHandle};

/* USER CODE BEGIN Init */
/**
  * @brief  Initializes the SRAM device.
  * @retval SRAM status
  */
__weak uint8_t BSP_SRAM_Init(void)
{ 
  uint8_t sramstatus = SRAM_OK;
  
  /* place for user code */
  
  return sramstatus;
}
/* USER CODE END Init */

/* USER CODE BEGIN BeforeReadSection */
/* can be used to modify / undefine following code or add code */
/* USER CODE END BeforeReadSection */

/**
  * @brief  Reads an amount of data from the SRAM device in polling mode.
  * @param  uwStartAddress: Read start address
  * @param  pData: Pointer to data to be read
  * @param  uwDataSize: Size of read data from the memory
  * @retval SRAM status
  */
__weak uint8_t BSP_SRAM_ReadData(uint32_t uwStartAddress, uint16_t *pData, uint32_t uwDataSize)
{ 
  uint8_t sramstatus = SRAM_OK;

  if(HAL_SRAM_Read_16b(&${sramHandle}, (uint32_t *)uwStartAddress, pData, uwDataSize) != HAL_OK)
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
__weak uint8_t BSP_SRAM_ReadData_DMA(uint32_t uwStartAddress, uint16_t *pData, uint32_t uwDataSize)
{
  uint8_t sramstatus = SRAM_OK;
  
  if(HAL_SRAM_Read_DMA(&${sramHandle}, (uint32_t *)uwStartAddress, (uint32_t *)pData, (uint32_t)(uwDataSize/2)) != HAL_OK)
  {
    sramstatus = SRAM_ERROR;
  }

  return sramstatus;
}

/* USER CODE BEGIN BeforeWriteSection */
/* can be used to modify / undefine following code or add code */
/* USER CODE END BeforeWriteSection */

/**
  * @brief  Writes an amount of data from the SRAM device in polling mode.
  * @param  uwStartAddress: Write start address
  * @param  pData: Pointer to data to be written
  * @param  uwDataSize: Size of written data from the memory
  * @retval SRAM status
  */
__weak uint8_t BSP_SRAM_WriteData(uint32_t uwStartAddress, uint16_t *pData, uint32_t uwDataSize) 
{
  uint8_t sramstatus = SRAM_OK;
  
  if(HAL_SRAM_Write_16b(&${sramHandle}, (uint32_t *)uwStartAddress, pData, uwDataSize) != HAL_OK)
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
__weak uint8_t BSP_SRAM_WriteData_DMA(uint32_t uwStartAddress, uint16_t *pData, uint32_t uwDataSize)
{
  uint8_t sramstatus = SRAM_OK;
  
  if(HAL_SRAM_Write_DMA(&${sramHandle}, (uint32_t *)uwStartAddress, (uint32_t *)pData, (uint32_t)(uwDataSize/2)) != HAL_OK)
  {
    sramstatus = SRAM_ERROR;
  }

  return sramstatus;
}

/* USER CODE BEGIN AdditionalCode */
/* user code can be inserted here */
/* USER CODE END AdditionalCode */

#endif
