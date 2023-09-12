[#ftl]
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
    [#if definition.value="stm32g474e"]
#include "stm32g474e_eval_sd.h"
    [/#if]
    [#if definition.value="stm32g474re"]
#include "adafruit_802_sd.h"
#include "adafruit_802_conf.h"    [#-- contains a #include "stm32g4xx_nucleo_conf.h" --]
    [/#if]
    [#if definition.value="stm32g431rb"]
#include "adafruit_802_sd.h"
#include "adafruit_802_conf.h"    [#-- contains a #include "stm32g4xx_nucleo_conf.h" --]
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
