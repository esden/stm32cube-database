[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/**
  ******************************************************************************
  * @file    mbmuxif_trace.h
  * @author  MCD Application Team
  * @brief   API for ${CPUCORE} applic to register and handle TRACE via MBMUX
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MBMUXIF_TRACE_${CPUCORE}_H__
#define __MBMUXIF_TRACE_${CPUCORE}_H__

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
[#if CPUCORE == "CM4"]
int8_t MBMUXIF_TraceInit(void);
void MBMUXIF_TraceSendAck(void);
[#else]
int8_t MBMUXIF_TraceInit(uint8_t verboseLevel);
MBMUX_ComParam_t *MBMUXIF_GetTraceFeatureNotifComPtr(void);
void MBMUXIF_TraceSendNotif_NoWait(void);
[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__MBMUXIF_TRACE_${CPUCORE}_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
