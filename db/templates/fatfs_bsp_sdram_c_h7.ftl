[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
  * @file    bsp_driver_sdram.c (based on stm32h743i_eval_sdram.c)
  * @brief   This file includes a generic SDRAM driver.
  *          To be updated by the user according to the board used for the project.
  * @note    Functions generated as weak: they can be overwritten by 
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
  [#if definition.name=="_HSDRAM"]
   [#assign sdramHandle = definition.value]
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
#include "bsp_driver_sdram.h"

/* Extern variables ----------------------------------------------------------*/
extern SDRAM_HandleTypeDef ${sdramHandle};

/* USER CODE BEGIN Init */
/**
  * @brief  Initializes the SDRAM device 
  * @retval SDRAM status
  * @note   Called in sdram_diskio.c
  */
__weak uint8_t BSP_SDRAM_Init(void)
{
  uint8_t sdramstatus = SDRAM_OK;
  
  /* place for custom code */
  
  return sdramstatus;
}
/* USER CODE END Init */

/* USER CODE BEGIN BeforeReadSection */
/* can be used to modify / undefine following code or add code */
/* USER CODE END BeforeReadSection */

/**
  * @brief  Reads an mount of data from the SDRAM memory in polling mode. 
  * @param  uwStartAddress: Read start address
  * @param  pData: Pointer to data to be read
  * @param  uwDataSize: Size of read data from the memory
  * @retval SDRAM status : SDRAM_OK or SDRAM_ERROR.
  */
__weak uint8_t BSP_SDRAM_ReadData(uint32_t uwStartAddress, uint32_t *pData, uint32_t uwDataSize)
{ 
  uint8_t sdramstatus = SDRAM_OK;
  
  if(HAL_SDRAM_Read_32b(&${sdramHandle}, (uint32_t *)uwStartAddress, pData, uwDataSize) != HAL_OK)
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
  * @retval SDRAM status : SDRAM_OK or SDRAM_ERROR.
  */
__weak uint8_t BSP_SDRAM_ReadData_DMA(uint32_t uwStartAddress, uint32_t *pData, uint32_t uwDataSize)
{ 
  uint8_t sdramstatus = SDRAM_OK;
  
  if(HAL_SDRAM_Read_DMA(&${sdramHandle}, (uint32_t *)uwStartAddress, pData, uwDataSize) != HAL_OK)
  {
    sdramstatus = SDRAM_ERROR;
  }
   
  return sdramstatus;
}

/* USER CODE BEGIN BeforeWriteSection */
/* can be used to modify / undefine following code or add code */
/* USER CODE END BeforeWriteSection */

/**
  * @brief  Writes an mount of data to the SDRAM memory in polling mode.
  * @param  uwStartAddress: Write start address
  * @param  pData: Pointer to data to be written
  * @param  uwDataSize: Size of written data from the memory
  * @retval SDRAM status : SDRAM_OK or SDRAM_ERROR.
  */
__weak uint8_t BSP_SDRAM_WriteData(uint32_t uwStartAddress, uint32_t *pData, uint32_t uwDataSize)
{ 
  uint8_t sdramstatus = SDRAM_OK;
  
  if(HAL_SDRAM_Write_32b(&${sdramHandle}, (uint32_t *)uwStartAddress, pData, uwDataSize) != HAL_OK)
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
  * @retval SDRAM status : SDRAM_OK or SDRAM_ERROR.
  */
__weak uint8_t BSP_SDRAM_WriteData_DMA(uint32_t uwStartAddress, uint32_t *pData, uint32_t uwDataSize)
{ 
  uint8_t sdramstatus = SDRAM_OK;
  
  if(HAL_SDRAM_Write_DMA(&${sdramHandle}, (uint32_t *)uwStartAddress, pData, uwDataSize) != HAL_OK)
  {
    sdramstatus = SDRAM_ERROR;
  }

  return sdramstatus;
}

/**
  * @brief  Sends command to the SDRAM bank.
  * @param  SdramCmd: Pointer to SDRAM command structure
  * @retval SDRAM status : SDRAM_OK or SDRAM_ERROR.
  */
__weak uint8_t BSP_SDRAM_Sendcmd(FMC_SDRAM_CommandTypeDef *SdramCmd)
{ 
  uint8_t sdramstatus = SDRAM_OK;
  
  if(HAL_SDRAM_SendCommand(&${sdramHandle}, SdramCmd, SDRAM_TIMEOUT) != HAL_OK)
  {
    sdramstatus = SDRAM_ERROR;
  }

  return sdramstatus;
}

/* USER CODE BEGIN AdditionalCode */
/* user code can be inserted here */
/* USER CODE END AdditionalCode */

#endif
