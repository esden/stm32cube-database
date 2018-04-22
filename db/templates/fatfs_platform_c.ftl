[#ftl]
/**
  ******************************************************************************
  * @file           : fatfs_platform.c
  * @brief          : fatfs_platform source file
  ******************************************************************************
[@common.optinclude name=sourceDir+"Src/license.tmp"/][#--include License text --]
  ******************************************************************************
*/
#include "fatfs_platform.h"

uint8_t	BSP_PlatformIsDetected(void) {
  uint8_t status = (uint8_t)0x01;
  [#if GPIO_IP??] 
  /* Check SD card detect pin */
  if (HAL_GPIO_ReadPin(SD_PORT,SD_PIN) == GPIO_PIN_RESET) {
    status = (uint8_t)0x00;
  }
  [/#if]
  /* USER CODE BEGIN 1 */
  /* user code can be inserted here */
  /* USER CODE END 1 */ 
  return status;
}  
