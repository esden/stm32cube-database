[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    adc_if.h
  * @author  MCD Application Team
  * @brief   Header for ADC interface configuration
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __ADC_IF_H__
#define __ADC_IF_H__

#ifdef __cplusplus
extern "C" {
#endif
/* Includes ------------------------------------------------------------------*/
[#if HALCompliant??]
#include "main.h"
[#else]
#include "adc.h"
[/#if]
#include "platform.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/**
  * @brief Battery level in mV
  */
#define BAT_CR2032                  ((uint32_t) 3000)
/**
  * @brief Maximum battery level in mV
  */
#define VDD_BAT                     BAT_CR2032
/**
  * @brief Minimum battery level in mV
  */
#define VDD_MIN                     1800

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/

/**
  * @brief  Initializes the ADC input
  */
void SYS_InitMeasurement(void);

/**
  * @brief DeInitializes the ADC
  */
void SYS_DeInitMeasurement(void);

/**
  * @brief  Get the current temperature
  * @return value temperature in degree Celsius( q7.8 )
  */
int16_t SYS_GetTemperatureLevel(void);

/**
  * @brief Get the current battery level
  * @return value battery level in linear scale
  */
uint16_t SYS_GetBatteryLevel(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __ADC_IF_H__ */
