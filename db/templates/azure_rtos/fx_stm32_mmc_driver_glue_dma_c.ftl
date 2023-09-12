[#ftl]
[#assign  mmc_instance = 0]
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
	[#if name == "MMC_INSTANCE"]
		[#if value == "0"]
			[#assign mmc_instance = 0]
		[#else]
			[#assign mmc_instance = 1]
		[/#if]
    [/#if]
    [#if name == "MMC_GLUE_FUNCTIONS"]
      [#assign glue_functions = value]
    [/#if]
	[#if name == "MMC_TRANSFER_NOTIFICATION"]
      [#assign transfer_notification = value]
    [/#if]
    [/#list]
[/#if]
[/#list]
[/#compress]
/**************************************************************************/
/*                                                                        */
/*       Copyright (c) Microsoft Corporation. All rights reserved.        */
/*                                                                        */
/*       This software is licensed under the Microsoft Software License   */
/*       Terms for Microsoft Azure RTOS. Full text of the license can be  */
/*       found in the LICENSE file at https://aka.ms/AzureRTOS_EULA       */
/*       and in the root directory of this software.                      */
/*                                                                        */
/**************************************************************************/

#include "fx_stm32_mmc_driver.h"

[#if transfer_notification=="ThreadX_Semaphore"]
TX_SEMAPHORE mmc_tx_semaphore;
TX_SEMAPHORE mmc_rx_semaphore;
[/#if]

extern MMC_HandleTypeDef hmmc${mmc_instance+1};
#if (FX_STM32_MMC_INIT == 1)
extern void MX_SDMMC${mmc_instance+1}_MMC_Init(void);
#endif

/* USER CODE BEGIN  0 */

/* USER CODE END  0 */

[#if transfer_notification=="Global_state_variables"]
__IO UINT mmc_rx_cplt;
__IO UINT mmc_tx_cplt;
[/#if]


/**
* @brief Initializes the MMC IP instance
* @param UINT instance MMC instance to initialize
* @retval 0 on success error value otherwise
*/
INT fx_stm32_mmc_init(UINT instance)
{
  INT ret = 0;

  /* USER CODE BEGIN PRE_FX_MMC_INIT */
  UNUSED(instance);
  /* USER CODE END PRE_FX_MMC_INIT */

#if (FX_STM32_MMC_INIT == 1)
	MX_SDMMC${mmc_instance+1}_MMC_Init();
#endif

  /* USER CODE BEGIN POST_FX_MMC_INIT */

  /* USER CODE END POST_FX_MMC_INIT */

  return ret;
}

/**
* @brief Deinitializes the MMC IP instance
* @param UINT instance MMC instance to deinitialize
* @retval 0 on success error value otherwise
*/
INT fx_stm32_mmc_deinit(UINT instance)
{
  INT ret = 0;

  /* USER CODE BEGIN PRE_FX_MMC_DEINIT */
  UNUSED(instance);
  /* USER CODE END PRE_FX_MMC_DEINIT */

  if(HAL_MMC_DeInit(&hmmc${mmc_instance+1}) != HAL_OK)
  {
    ret = 1;
  }

  /* USER CODE BEGIN POST_FX_MMC_DEINIT */

  /* USER CODE END POST_FX_MMC_DEINIT */

  return ret;
}

/**
* @brief Check the MMC IP status.
* @param UINT instance MMC instance to check
* @retval 0 when ready 1 when busy
*/
INT fx_stm32_mmc_get_status(UINT instance)
{
  INT ret = 0;

  /* USER CODE BEGIN PRE_GET_STATUS */
  UNUSED(instance);
  /* USER CODE END PRE_GET_STATUS */

  if(HAL_MMC_GetCardState(&hmmc${mmc_instance+1}) != HAL_MMC_CARD_TRANSFER)
  {
    ret = 1;
  }

  /* USER CODE BEGIN POST_GET_STATUS */

  /* USER CODE END POST_GET_STATUS */

  return ret;
}

/**
* @brief Read Data from the MMC device into a buffer.
* @param UINT instance MMC IP instance to read from.
* @param UINT *buffer buffer into which the data is to be read.
* @param UINT start_block the first block to start reading from.
* @param UINT total_blocks total number of blocks to read.
* @retval 0 on success error code otherwise
*/
INT fx_stm32_mmc_read_blocks(UINT instance, UINT *buffer, UINT start_block, UINT total_blocks)
{
  INT ret = 0;
  
  /* USER CODE BEGIN PRE_READ_BLOCKS */
  [#if transfer_notification=="ThreadX_Semaphore"]
	UNUSED(instance);
  [/#if]
  /* USER CODE END PRE_READ_BLOCKS */
  [#if transfer_notification=="Global_state_variables"]
  mmc_rx_cplt = 0;
  [/#if]
  
  if(HAL_MMC_ReadBlocks_DMA(&hmmc${mmc_instance+1}, (uint8_t *)buffer, start_block, total_blocks) != HAL_OK)
  {
    ret = 1;
  }

  /* USER CODE BEGIN POST_READ_BLOCKS */

  /* USER CODE END POST_READ_BLOCKS */

  return ret;
}

/**
* @brief Write data buffer into the MMC device.
* @param UINT instance MMC IP instance to write into.
* @param UINT *buffer buffer to write into the MMC device.
* @param UINT start_block the first block to start writing into.
* @param UINT total_blocks total number of blocks to write.
* @retval 0 on success error code otherwise
*/
INT fx_stm32_mmc_write_blocks(UINT instance, UINT *buffer, UINT start_block, UINT total_blocks)
{
  INT ret = 0;

  /* USER CODE BEGIN PRE_WRITE_BLOCKS */
  [#if transfer_notification=="ThreadX_Semaphore"]
	UNUSED(instance);
  [/#if]
  /* USER CODE END PRE_WRITE_BLOCKS */
  
  [#if transfer_notification=="Global_state_variables"]
  mmc_tx_cplt = 0;
  [/#if]
  
  if(HAL_MMC_WriteBlocks_DMA(&hmmc${mmc_instance+1}, (uint8_t *)buffer, start_block, total_blocks) != HAL_OK)
  {
    ret = 1;
  }

  /* USER CODE BEGIN POST_WRITE_BLOCKS */

  /* USER CODE END POST_WRITE_BLOCKS */

  return ret;
}

[#if transfer_notification=="ThreadX_Semaphore"]
/**
* @brief MMC DMA Tx Transfer completed callbacks
* @param Instance the mmc instance
* @retval None
*/
void HAL_MMC_TxCpltCallback(MMC_HandleTypeDef *hmmc)
{
  /* USER CODE BEGIN PRE_TX_CMPLT */

  /* USER CODE END PRE_TX_CMPLT */

  tx_semaphore_put(&mmc_tx_semaphore);

  /* USER CODE BEGIN POST_TX_CMPLT */

  /* USER CODE END POST_TX_CMPLT */
}
[/#if]  

[#if transfer_notification=="Custom"]
/**
* @brief MMC DMA Tx Transfer completed callbacks
* @param Instance the mmc instance
* @retval None
*/
void HAL_MMC_TxCpltCallback(MMC_HandleTypeDef *hmmc)
{
/* USER CODE BEGIN HAL_MMC_TxCpltCallback */

  /* USER CODE END HAL_MMC_TxCpltCallback */
}
[/#if]  

[#if transfer_notification=="Global_state_variables"]
/**
* @brief MMC DMA Tx Transfer completed callbacks
* @param MMC_HandleTypeDef *hmmc the MMC_HandleTypeDef handle
* @retval None
*/
void HAL_MMC_TxCpltCallback(MMC_HandleTypeDef *hmmc)
{
/* USER CODE BEGIN TX_COMPLETED_0 */

/* USER CODE END TX_COMPLETED_0 */
  
  mmc_tx_cplt = 1;

/* USER CODE BEGIN TX_COMPLETED_1 */

/* USER CODE END TX_COMPLETED_1 */

}
[/#if]  
  
[#if transfer_notification=="ThreadX_Semaphore"]
/**
* @brief MMC DMA Rx Transfer completed callbacks
* @param Instance the mmc instance
* @retval None
*/
void HAL_MMC_RxCpltCallback(MMC_HandleTypeDef *hmmc)
{

   /* USER CODE BEGIN PRE_RX_CMPLT */

  /* USER CODE END PRE_RX_CMPLT */

  tx_semaphore_put(&mmc_rx_semaphore);

  /* USER CODE BEGIN POST_RX_CMPLT */

  /* USER CODE END POST_RX_CMPLT */
}
[/#if]  

[#if transfer_notification=="Custom"]
/**
* @brief MMC DMA Rx Transfer completed callbacks
* @param Instance the mmc instance
* @retval None
*/
void HAL_MMC_RxCpltCallback(MMC_HandleTypeDef *hmmc)
{

   /* USER CODE BEGIN HAL_MMC_RxCpltCallback */

  /* USER CODE END HAL_MMC_RxCpltCallback */
  
}
[/#if]  

[#if transfer_notification=="Global_state_variables"]
/**
* @brief MMC DMA Rx Transfer completed callbacks
* @param MMC_HandleTypeDef *hmmc the MMC_HandleTypeDef handle
* @retval None
*/
void HAL_MMC_RxCpltCallback(MMC_HandleTypeDef *hmmc)
{
  /* USER CODE BEGIN RX_COMPLETED_0 */

/* USER CODE END RX_COMPLETED_0 */
  mmc_rx_cplt = 1;

/* USER CODE BEGIN RX_COMPLETED_1 */

/* USER CODE END RX_COMPLETED_1 */

}
[/#if]  

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
