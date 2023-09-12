[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/**
  ******************************************************************************
  * @file    mbmuxif_lora.h
  * @author  MCD Application Team
  * @brief   API provided to ${CPUCORE} applic to register and handle LoraWAN via MBMUX
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MBMUXIF_LORA_${CPUCORE}_H__
#define __MBMUXIF_LORA_${CPUCORE}_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "mbmux.h"
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
int8_t MBMUXIF_LoraInit(void);
[#if CPUCORE == "CM4"]
MBMUX_ComParam_t *MBMUXIF_GetLoraFeatureCmdComPtr(void);
void MBMUXIF_LoraSendCmd(void);
void MBMUXIF_LoraSendAck(void);
[#else]
MBMUX_ComParam_t *MBMUXIF_GetLoraFeatureNotifComPtr(void);
void MBMUXIF_LoraSendNotif(void);
void MBMUXIF_LoraSendResp(void);
[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__MBMUXIF_LORA_${CPUCORE}_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
