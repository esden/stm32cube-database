[#ftl]

[#assign  sd_instance = "0"]
[#assign  maintain_cpu_cache = "1"]

[#assign  sector_size = "512"]
[#assign  sd_init = "1"]
[#assign  use_dma = "0"]
[#assign  transfer_notification = "Custom"]

[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
    [#if name == "GLUE_FUNCTIONS"]
      [#assign glue_functions = value]
	   [#if value =="DMA_API"]
	   [#assign use_dma = "1"]
	   [/#if]
    [/#if]
	
	[#if name == "TRANSFER_NOTIFICATION"]
      [#assign transfer_notification = value]
    [/#if]
	[#if name == "SD_INSTANCE"]
      [#assign sd_instance = value]
    [/#if]
    [#if name == "ENABLE_CACHE_MAINTENANCE"]
      [#if value.contains("false")]
        [#assign maintain_cpu_cache = "0"]
      [/#if]
    [/#if]
    [#if name == "SD_SECTOR_SIZE"]
      [#assign sector_size = value]
    [/#if]
    [#if name == "FX_DRIVER_SD_INIT"]
      [#assign sd_init = value]
    [/#if]
    [/#list]
[/#if]
[/#list]
[/#compress]

#include "fx_stm32_sd_driver.h"

[#if transfer_notification=="ThreadX Semaphore"]
/* USER CODE BEGIN  0 */
TX_SEMAPHORE transfer_semaphore;

[/#if]

[#if sd_instance=="0"]
extern SD_HandleTypeDef hsd1;  
extern void  MX_SDMMC1_SD_Init(void);
/* USER CODE END  0 */
[/#if]
[#if sd_instance=="1"]
extern SD_HandleTypeDef hsd2;   
extern void  MX_SDMMC2_SD_Init(void);
/* USER CODE END  0 */
[/#if]
/**
* @brief Initializes the SD IP instance
* @param uINT Instance SD instance to initialize
* @retval 0 on success error value otherwise
*/
INT fx_stm32_sd_init(UINT instance)
{
  INT ret = 0;
/* USER CODE BEGIN  FX_SD_INIT */
#if (FX_STM32_SD_INIT == 1)
    MX_SDMMC1_SD_Init();
#endif
/* USER CODE END  FX_SD_INIT */

  return ret;
}

/**
* @brief Deinitializes the SD IP instance
* @param uINT Instance SD instance to deinitialize
* @retval 0 on success error value otherwise
*/
INT fx_stm32_sd_deinit(UINT instance)
{
  INT ret = 0;
/* USER CODE BEGIN  FX_SD_DEINIT */

/* USER CODE END  FX_SD_DEINIT */

  return ret;
}

/**
* @brief Check the SD IP status.
* @param uINT Instance SD instance to check
* @retval 0 when ready 1 when busy
*/
INT fx_stm32_sd_get_status(UINT instance)
{
  INT ret = 0;
/* USER CODE BEGIN  GET_STATUS */
  if (HAL_SD_GetCardState(&hsd1) != HAL_SD_CARD_TRANSFER)
  {
    ret = HAL_ERROR;
  }
  else
  {
    ret = HAL_OK;
  }
/* USER CODE END  GET_STATUS */
  return ret;
}

/**
* @brief Read Data from the SD device into a buffer.
* @param uINT *buffer buffer into which the data is to be read.
* @param uINT start_block the first block to start reading from.
* @param uINT total_blocks total number of blocks to read.
* @retval 0 on success error code otherwise
*/
INT fx_stm32_sd_read_blocks(UINT instance, UINT *buffer, UINT start_block, UINT total_blocks)
{
  INT ret = 0;
[#if glue_functions=="IT_API"]
/* USER CODE BEGIN  READ_BLOCKS */
   if (HAL_SD_ReadBlocks_IT(&hsd1, (uint8_t *)buffer, start_block, total_blocks) != HAL_OK) 
[/#if]
[#if glue_functions=="DMA_API"]
  /* USER CODE BEGIN  WRITE_BLOCKS */
  if (HAL_SD_ReadBlocks_DMA(&hsd1, (uint8_t *)buffer, start_block, total_blocks) != HAL_OK)
  [/#if]
  {
    ret = HAL_ERROR;
  }
  else
  {
    ret = HAL_OK;
  }
/* USER CODE END  READ_BLOCKS */
  return ret;
}
/**
* @brief Write data buffer into the SD device.
* @param uINT *buffer buffer .to write into the SD device.
* @param uINT start_block the first block to start writing from.
* @param uINT total_blocks total number of blocks to write.
* @retval 0 on success error code otherwise
*/

INT fx_stm32_sd_write_blocks(UINT instance, UINT *buffer, UINT start_block, UINT total_blocks)
{
  INT ret = 0;
  [#if glue_functions=="IT_API"]
/* USER CODE BEGIN  WRITE_BLOCKS */
  if (HAL_SD_WriteBlocks_IT(&hsd1, (uint8_t *)buffer, start_block, total_blocks) != HAL_OK)
  [/#if]
  [#if glue_functions=="DMA_API"]
  /* USER CODE BEGIN  WRITE_BLOCKS */
  if (HAL_SD_WriteBlocks_DMA(&hsd1, (uint8_t *)buffer, start_block, total_blocks) != HAL_OK)
  [/#if]
  {
    ret = HAL_ERROR;
  }
  else
  {
    ret = HAL_OK;
  }
/* USER CODE END  WRITE_BLOCKS */
  return ret;

}

[#if transfer_notification=="ThreadX Semaphore"]
/* USER CODE BEGIN  1 */
/**
* @brief SD DMA Tx Transfer completed callbacks
* @param Instance the sd instance
* @retval None
*/
void HAL_SD_TxCpltCallback(SD_HandleTypeDef *hsd)
{
  tx_semaphore_put(&transfer_semaphore);
}

/**
* @brief SD DMA Rx Transfer completed callbacks
* @param Instance the sd instance
* @retval None
*/

void HAL_SD_RxCpltCallback(SD_HandleTypeDef *hsd)
{
  tx_semaphore_put(&transfer_semaphore);
}
/* USER CODE END  1 */
[/#if]
[#if transfer_notification=="Custom"]
/* USER CODE BEGIN  1 */
/**
* @brief SD DMA Tx Transfer completed callbacks
* @param Instance the sd instance
* @retval None
*/
void HAL_SD_TxCpltCallback(SD_HandleTypeDef *hsd)
{
  
}

/**
* @brief SD DMA Rx Transfer completed callbacks
* @param Instance the sd instance
* @retval None
*/

void HAL_SD_RxCpltCallback(SD_HandleTypeDef *hsd)
{
 
}
/* USER CODE END  1 */
[/#if]
