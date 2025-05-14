[#ftl]
[#assign contextFolder=""]
[#if cpucore!=""]    
[#assign contextFolder = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")+"/"]
[/#if]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file   fatfs.h
  * @brief  Header for fatfs applications
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __fatfs_H
#define __fatfs_H
#ifdef __cplusplus
 extern "C" {
#endif

[#assign SD_DISKIO_INTERFACE="0"]

[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
      [#if (definition.name == "SD_DISKIO_INTERFACE")]
        [#assign SD_DISKIO_INTERFACE = definition.value]
      [/#if]
    [/#list]
  [/#if]
[/#list]

[#compress]

/* Includes ------------------------------------------------------------------*/
#n
/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
#include "ff.h"
#include "user_diskio.h"

/* USER CODE END Includes */
#n
/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN Private defines */
#n
/* USER CODE END Private defines */
#n
/* Exported functions prototypes ---------------------------------------------*/
void MX_FATFS_Init(void);
/* USER CODE BEGIN Prototypes */
#n
/* USER CODE END Prototypes */
#n
[/#compress]

#ifdef __cplusplus
}
#endif
#endif /*__fatfs_H */
