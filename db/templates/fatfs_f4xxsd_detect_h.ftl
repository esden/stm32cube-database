[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : fatfs_f4xxsd_detect.h
  * @brief          : header file for the SD card detection
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
*/
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM32F4XX_SD_DETECT_H
#define __STM32F4XX_SD_DETECT_H

#ifdef __cplusplus
 extern "C" {
#endif 



/* USER CODE BEGIN 0 */
/* Includes ------------------------------------------------------------------*/
#include "stm32f4xx_hal.h"
#include "fatfs_f4xxsd_detect.h"
uint8_t MX_SD_IsDetected(void);
/* USER CODE END 0 */ 

#ifdef __cplusplus
}
#endif

#endif /* __STM32F4XX_SD_H */
