[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    mn_lptim_if.h
  * @author  MCD Application Team
  * @brief   Header for between Sigfox monarch and lptim
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MN_LPTIM_IF_H__
#define __MN_LPTIM_IF_H__

#ifdef __cplusplus
extern "C" {
#endif
/* Includes ------------------------------------------------------------------*/
[#if HALCompliant??]
#include "main.h"
[#else]
#include "lptim.h"
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

/* Exported functions prototypes ---------------------------------------------*/
/**
  * @brief This function initializes the LPTIM used in the scope of Monarch
  */
void MN_LPTIM_IF_Init(void);

/**
  * @brief This function de-init the LPTIM used in the scope of Monarch
  */
void MN_LPTIM_IF_DeInit(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __MN_LPTIM_IF_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
