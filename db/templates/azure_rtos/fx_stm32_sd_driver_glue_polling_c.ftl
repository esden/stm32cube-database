#include "fx_stm32_sd_driver.h"

/* USER CODE BEGIN  0 */
TX_SEMAPHORE transfer_semaphore;

extern SD_HandleTypeDef hsd1;
extern void   MX_SDMMC1_SD_Init(void);
/* USER CODE END  0 */

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
/* USER CODE BEGIN  READ_BLOCKS */
  if (HAL_SD_ReadBlocks(&hsd1, (uint8_t *)buffer, start_block, total_blocks, FX_STM32_SD_DEFAULT_TIMEOUT) != HAL_OK)
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
/* USER CODE BEGIN  WRITE_BLOCKS */
  if (HAL_SD_WriteBlocks(&hsd1, (uint8_t *)buffer, start_block, total_blocks, FX_STM32_SD_DEFAULT_TIMEOUT) != HAL_OK)
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


/* USER CODE BEGIN  1 */

/* USER CODE END  1 */