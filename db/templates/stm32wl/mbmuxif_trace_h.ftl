[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    mbmuxif_trace.h
  * @author  MCD Application Team
  * @brief   API for ${CPUCORE} application to register and handle TRACE via MBMUX
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

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
/**
  * @brief  Registers TRACE feature to the mailbox
  * @retval 0: OK; -1: no more ipcc channel available; -2: feature not provided by CM0PLUS
  */
int8_t MBMUXIF_TraceInit(void);

/**
  * @brief  Sends a Trace-Ack  via Ipcc without waiting for the ack
  */
void MBMUXIF_TraceSendAck(void);
[#else]
/**
  * @brief   Registers TRACE feature to the mailbox
  * @param   verboseLevel level of trace verbosity
  * @retval  0: OK; -1: if ch hasn't been registered by CM4
  * @note    this function is supposed to be called by the System on request (Cmd) of CM4
  */
int8_t MBMUXIF_TraceInit(uint8_t verboseLevel);

/**
  * @brief   gives back the pointer to the com buffer associated to Trace feature Notif
  * @retval  return pointer to the com param buffer
  */
MBMUX_ComParam_t *MBMUXIF_GetTraceFeatureNotifComPtr(void);

/**
  * @brief Sends a Trace-Notif via Ipcc without waiting for the ack
  */
void MBMUXIF_TraceSendNotif_NoWait(void);
[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__MBMUXIF_TRACE_${CPUCORE}_H__ */
