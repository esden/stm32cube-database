[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : fatfs_platform.h
  * @brief          : fatfs_platform header file
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
*/
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/
#include "${FamilyName?lower_case}xx_hal.h"           [#--include "stm32f4xx_hal.h", for instance --]
[#if Platform??]
	[#if GPIO_IP??]
/* Defines ------------------------------------------------------------------*/
#define SD_PRESENT               ((uint8_t)0x01)  /* also in bsp_driver_sd.h */
#define SD_NOT_PRESENT           ((uint8_t)0x00)  /* also in bsp_driver_sd.h */
#define SD_DETECT_PIN         ${IpInstance}
#define SD_DETECT_GPIO_PORT   ${IpName}
	[/#if]
/* Prototypes ---------------------------------------------------------------*/
uint8_t	BSP_PlatformIsDetected(void);
[/#if]
