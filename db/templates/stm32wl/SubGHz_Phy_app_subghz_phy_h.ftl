[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_subghz_phy.h
  * @author  MCD Application Team
  * @brief   Header of application of the SubGHz_Phy Middleware
   ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __APP_SUBGHZ_PHY_H__
#define __APP_SUBGHZ_PHY_H__

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
  * @brief  Init SubGHz Radio Application
  */
[#if !THREADX??][#-- If AzRtos is not used --]
void MX_SubGHz_Phy_Init(void);
[#else][#--  THREADX --]
uint32_t MX_SubGHz_Phy_Init(void *memory_ptr);
[/#if]

[#if !FREERTOS??][#-- If FreeRtos, only available in CM4 is not used --]
[#if !THREADX??][#-- If AzRtos is not used --]
/**
  * @brief  SubGHz Radio Application Process
  */
void MX_SubGHz_Phy_Process(void);

[/#if]
[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__APP_SUBGHZ_PHY_H__*/
