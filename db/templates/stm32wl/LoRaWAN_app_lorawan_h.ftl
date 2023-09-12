[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_lorawan.h
  * @author  MCD Application Team
  * @brief   Header of application of the LRWAN Middleware
   ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __APP_LORAWAN_H__
#define __APP_LORAWAN_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if THREADX??]
#include <stdint.h>
[/#if]
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported Functions Prototypes ---------------------------------------------*/
/**
  * @brief  Init Lora Application
  */
[#if !THREADX??][#-- If AzRtos is not used --]
void MX_LoRaWAN_Init(void);
[#else]
uint32_t MX_LoRaWAN_Init(void *memory_ptr);
[/#if]

[#if !FREERTOS??][#-- If FreeRtos, only available in CM4 is not used --]
[#if !THREADX??][#-- If AzRtos is not used --]
/**
  * @brief  Entry Lora Process or scheduling
  */
void MX_LoRaWAN_Process(void);

[/#if]
[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__APP_LORAWAN_H__*/
