[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/**
  ******************************************************************************
  * @file    mbmux.h
  * @author  MCD Application Team
  * @brief   API which interfaces ${CPUCORE} to IPCC
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MBMUX_${CPUCORE}_H__
#define __MBMUX_${CPUCORE}_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "mbmux_table.h"
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
void   MBMUX_Init(MBMUX_ComTable_t *const pMBMUX_ComTable);

[#if CPUCORE == "CM4"]
void MBMUX_SetCm0plusFeatureListPtr(FEAT_INFO_List_t *pCM0PLUS_FeatureList);

int8_t MBMUX_RegisterFeature(FEAT_INFO_IdTypeDef e_featID, MBMUX_ComType_t ComType,
                             void (*MsgCm4Cb)(void *ComObj), uint32_t *const ComBuffer, uint16_t ComBufSize);
[#else]
int8_t MBMUX_RegisterFeatureCallback(FEAT_INFO_IdTypeDef e_featID, MBMUX_ComType_t ComType, void (*MsgCb)(void *ComObj));
[/#if]

void MBMUX_UnregisterFeature(FEAT_INFO_IdTypeDef e_featID, MBMUX_ComType_t ComType);

MBMUX_ComParam_t *MBMUX_GetFeatureComPtr(FEAT_INFO_IdTypeDef e_featID, MBMUX_ComType_t ComType);

[#if CPUCORE == "CM4"]
int32_t MBMUX_CommandSnd(FEAT_INFO_IdTypeDef e_featID);

uint32_t MBMUX_AcknowledgeSnd(FEAT_INFO_IdTypeDef e_featID);
[#else]
int32_t MBMUX_NotificationSnd(FEAT_INFO_IdTypeDef e_featID);

uint32_t MBMUX_ResponseSnd(FEAT_INFO_IdTypeDef e_featID);
[/#if]

uint32_t MBMUX_GetResponseVal(FEAT_INFO_IdTypeDef e_featID);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__MBMUX_${CPUCORE}_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
