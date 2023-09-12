[#ftl]
[#assign use_dma=1]
[#assign use_rtos=0]
[#if SWIPdatas??]
[#list SWIPdatas as SWIP]  
[#if SWIP.defines??]
 [#list SWIP.defines as definition] 
  [#if definition.name="_FS_REENTRANT"]
   [#if definition.value="1"]
    [#assign use_rtos=1]
   [/#if]
  [/#if]
 [/#list]
[/#if]
[/#list]
[/#if]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    sd_diskio.h
  * @brief   Header for sd_diskio.c module
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#-- Moved here (as the user section prevents from refreshing the comments). --]
[#if use_rtos = 1]
/* Note: code generation based on sd_diskio_dma_rtos_template.h for L5 */
[#else]
/* Note: code generation based on sd_diskio_dma_template.h for L5 */
[/#if]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __SD_DISKIO_H
#define __SD_DISKIO_H

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/

[#list SWIPdatas as SWIP]  
 [#if SWIP.defines??]
  [#list SWIP.defines as definition]
   [#if definition.name="BOARD_NAME"] 
    [#if definition.value="stm32l552e"]
#include "stm32l552e_eval_sd.h"
    [/#if]
    [#if definition.value="stm32l562e"]
#include "stm32l562e_discovery_sd.h"
    [/#if]    
   [/#if]
  [/#list]
 [/#if]
[/#list]

    
/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
extern const Diskio_drvTypeDef  SD_Driver;
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __SD_DISKIO_H */
