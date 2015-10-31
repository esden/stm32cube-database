/**
  ******************************************************************************
  * @file    stm32f4xx_sdram2.c
  * @author  MCD Teams
  * @version V1.0.0
  * @date    28-September-2013
  * @brief   This file includes the SDRAM driver for the MT48LC2M32B2 memory device

  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2013 STMicroelectronics</center></h2>
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
#include "stm32f4xx_sdram.h"


extern SDRAM_HandleTypeDef hsdram2;
// static FMC_SDRAM_TimingTypeDef Timing;
static FMC_SDRAM_CommandTypeDef Command;
    
/** @defgroup STM324x9I_EVAL_SDRAM_Private_Functions
  * @{
  */ 
   
/**
  * @brief  Initializes the SDRAM device.
  * @param  None
  * @retval None
  */
void SDRAM_Init(void)
{ 
  /* SDRAM device configuration */
  //hsdram2.Instance = FMC_SDRAM_DEVICE;
    
  //Timing.LoadToActiveDelay    = 2;
  //Timing.ExitSelfRefreshDelay = 6;
  //Timing.SelfRefreshTime      = 4;
  //Timing.RowCycleDelay        = 6;
  //Timing.WriteRecoveryTime    = 2;
  //Timing.RPDelay              = 2;
  //Timing.RCDDelay             = 2;
  
  //hsdram2.Init.SDBank             = FMC_SDRAM_BANK1;
  //hsdram2.Init.ColumnBitsNumber   = FMC_SDRAM_COLUMN_BITS_NUM_8;
  //hsdram2.Init.RowBitsNumber      = FMC_SDRAM_ROW_BITS_NUM_11;
  //hsdram2.Init.MemoryDataWidth    = SDRAM_MEMORY_WIDTH;
  //hsdram2.Init.InternalBankNumber = FMC_SDRAM_INTERN_BANKS_NUM_4;
  //hsdram2.Init.CASLatency         = FMC_SDRAM_CAS_LATENCY_3;
  //hsdram2.Init.WriteProtection    = FMC_SDRAM_WRITE_PROTECTION_DISABLE;
  //hsdram2.Init.SDClockPeriod      = SDCLOCK_PERIOD;
  //hsdram2.Init.ReadBurst          = SDRAM_READBURST;
  //hsdram2.Init.ReadPipeDelay      = FMC_SDRAM_RPIPE_DELAY_1;
    
  /* SDRAM low level initialization */
  //SDRAM_LL_Init();
  
  /* SDRAM controller initialization */
  //HAL_SDRAM_Init(&hsdram2, &Timing);
  
  /* SDRAM initialization sequence */
  //SDRAM_Initialization_sequence(REFRESH_COUNT);
  
}


/**
  * @brief  Read an mount of data from the SDRAM memory in polling mode 
  * @param  uwStartAddress : Read start address
  * @param  pData : Pointer to data to be read  
  * @param  uwDataSize : size of read data from the memory
  * @retval none
  */
void SDRAM_ReadData(uint32_t uwStartAddress, uint32_t* pData, uint32_t uwDataSize)
{
  HAL_SDRAM_Read_32b(&hsdram2, (uint32_t *)uwStartAddress, pData, uwDataSize); 
}

/**
  * @brief  Read an mount of data from the SDRAM memory in DMA mode 
  * @param  uwStartAddress : Read start address
  * @param  pData : Pointer to data to be read  
  * @param  uwDataSize : size of read data from the memory
  * @retval none
  */
void SDRAM_ReadData_DMA(uint32_t uwStartAddress, uint32_t* pData, uint32_t uwDataSize)
{
  HAL_SDRAM_Read_DMA(&hsdram2, (uint32_t *)uwStartAddress, pData, uwDataSize);     
}


/**
  * @brief  Write an mount of data to the SDRAM memory in polling mode
  * @param  uwStartAddress : Write start address
  * @param  pData : Pointer to data to be written  
  * @param  uwDataSize : size of written data from the memory
  * @retval none
  */
void SDRAM_WriteData(uint32_t uwStartAddress, uint32_t* pData, uint32_t uwDataSize) 
{
  HAL_SDRAM_Write_32b(&hsdram2, (uint32_t *)uwStartAddress, pData, uwDataSize);
}

/**
  * @brief  Write an mount of data to the SDRAM memory in DMA mode
  * @param  uwStartAddress : Write start address
  * @param  pData : Pointer to data to be written  
  * @param  uwDataSize : size of written data from the memory
  * @retval none
  */
void SDRAM_WriteData_DMA(uint32_t uwStartAddress, uint32_t* pData, uint32_t uwDataSize) 
{
  HAL_SDRAM_Write_DMA(&hsdram2, (uint32_t *)uwStartAddress, pData, uwDataSize); 
}


/**
  * @brief  Send Command to the SDRAM bank
  * @param  SdramCmd: SDRAM command structure 
  * @retval HAL status
  */  
HAL_StatusTypeDef SDRAM_Sendcmd(FMC_SDRAM_CommandTypeDef *SdramCmd)
{
  return(HAL_SDRAM_SendCommand(&hsdram2, SdramCmd, SDRAM_TIMEOUT));
}

/**
  * @brief  This function handles SRAM DMA transfer interrupt request.
  * @param  none
  * @retval none
  */
void SDRAM_DMA_IRQHandler(void)
{
  HAL_DMA_IRQHandler(hsdram2.hdma); 
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
