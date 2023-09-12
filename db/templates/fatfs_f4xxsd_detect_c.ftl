[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : fatfs_f4xxsd_detect.c
  * @brief          : source file for the SD card detection
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
*/
/* USER CODE END Header */
#include "fatfs_f4xxsd_detect.h"
[#if GPIO_IP??] 
[#else]
/* External variables ---------------------------------------------------------*/
extern ${IpName}_HandleTypeDef h${IpInstance?lower_case};
[/#if]

/**
  * @brief  MX_SD_IsDetected  
  */
uint8_t MX_SD_IsDetected(void) 
{ 
[#if GPIO_IP??] 
 __IO uint8_t status = GPIO_PIN_RESET;

  /* TBI: add user code here depending on the hardware configuration used */
  if (HAL_GPIO_ReadPin(${IpName},${IpInstance}) == GPIO_PIN_SET) {
    status = GPIO_PIN_SET;
  }  
  return status;
 
[/#if]
}