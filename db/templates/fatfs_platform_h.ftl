[#ftl]
/**
  ******************************************************************************
  * @file           : fatfs_platform.h
  * @brief          : fatfs_platform header file
  ******************************************************************************
[@common.optinclude name=sourceDir+"Src/license.tmp"/][#--include License text --]
  ******************************************************************************
*/
/* Includes ------------------------------------------------------------------*/
#include "${FamilyName?lower_case}xx_hal.h"           [#--include "stm32f4xx_hal.h", for instance --]
[#if Platform??]
	[#if GPIO_IP??]
/* Defines ------------------------------------------------------------------*/
#define SD_PIN                   ${IpInstance}
#define SD_PORT                  ${IpName}
	[/#if]
/* Prototypes ---------------------------------------------------------------*/
uint8_t	BSP_PlatformIsDetected(void);
[/#if]
