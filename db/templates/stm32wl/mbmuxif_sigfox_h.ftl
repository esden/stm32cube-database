[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/**
  ******************************************************************************
  * @file    mbmuxif_sigfox.h
  * @author  MCD Application Team
  * @brief   API provided to CM0 appli to register and handle Sigfox to MBMUX
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MBMUXIF_SIGFOX_${CPUCORE}_H__
#define __MBMUXIF_SIGFOX_${CPUCORE}_H__

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
int8_t MBMUXIF_SigfoxInit(void);
[#if CPUCORE == "CM4"]
MBMUX_ComParam_t *MBMUXIF_GetSigfoxFeatureCmdComPtr(void);
void MBMUXIF_SigfoxSendCmd(void);
void MBMUXIF_SigfoxSendAck(void);
[#else]
MBMUX_ComParam_t *MBMUXIF_GetSigfoxFeatureNotifComPtr(void);
void MBMUXIF_SigfoxSendNotif(void);
void MBMUXIF_SigfoxSendNotifTask(void);
void MBMUXIF_SigfoxSendResp(void);
[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__MBMUXIF_SIGFOX_${CPUCORE}_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
