[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    mbmuxif_radio.h
  * @author  MCD Application Team
  * @brief   API for ${CPUCORE} application to register and handle RADIO driver via MBMUX
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MBMUXIF_RADIO_${CPUCORE}_H__
#define __MBMUXIF_RADIO_${CPUCORE}_H__

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
/**
  * @brief   Registers RADIO feature to the mailbox and to the sequencer
  * @retval   0: OK;
             -1: no more ipcc channel available;
             -2: feature not provided by CM0PLUS;
             -3: callback error on CM0PLUS
             -4: mismatch between CM4 and CM0PLUS lora stack versions
  */
int8_t MBMUXIF_RadioInit(void);

[#if CPUCORE == "CM4"]
/**
  * @brief   gives back the pointer to the com buffer associated to Radio feature Cmd
  * @retval  return pointer to the com param buffer
  */
MBMUX_ComParam_t *MBMUXIF_GetRadioFeatureCmdComPtr(void);

/**
  * @brief   Sends a Radio-Cmd via Ipcc and Wait for the response
  */
void MBMUXIF_RadioSendCmd(void);

/**
  * @brief   Sends a Radio-Ack  via Ipcc without waiting for the ack
  */
void MBMUXIF_RadioSendAck(void);
[#else]
/**
  * @brief   gives back the pointer to the com buffer associated to Radio feature Notif
  * @retval  return pointer to the com param buffer
  */
MBMUX_ComParam_t *MBMUXIF_GetRadioFeatureNotifComPtr(void);

/**
  * @brief   Sends a Radio-Notif via Ipcc and Wait for the ack
  */
void MBMUXIF_RadioSendNotif(void);

/**
  * @brief   Sends a Radio-Resp  via Ipcc without waiting for the response
  */
void MBMUXIF_RadioSendResp(void);
[/#if]

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__MBMUXIF_RADIO_${CPUCORE}_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
