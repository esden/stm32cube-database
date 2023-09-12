[#ftl]
/**
  ******************************************************************************
  * @file    kms_if.h
  * @author  MCD Application Team
  * @brief   This file contains kms interfaces with middleware
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
[#assign ipNameList = configs[0].peripheralParams?keys]
[#assign useKMS = ipNameList?seq_contains("KMS")]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef KMS_IF_H
#define KMS_IF_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if useKMS]

#include "kms.h"
#include "tkms.h"
#include "kms_interface.h"

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
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* KMS_IF_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

