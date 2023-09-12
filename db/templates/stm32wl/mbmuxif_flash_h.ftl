[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    mbmuxif_flash.h
  * @author  MCD Application Team
  * @brief   API for ${CPUCORE} application to register and handle FLASH via MBMUX
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MBMUXIF_FLASH_${CPUCORE}_H__
#define __MBMUXIF_FLASH_${CPUCORE}_H__

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
  * @brief   Registers FLASH feature to the mailbox
[#if CPUCORE == "CM4"]
  * @retval  0: OK; -1: no more ipcc channel available; -2: feature not provided by CM0PLUS
[#else]
  * @retval  0: OK; -1: if ch hasn't been registered by CM4
  * @note    this function is supposed to be called by the System on request (Cmd) of CM4
[/#if]
  */
int8_t MBMUXIF_FlashInit(void);

[#if CPUCORE == "CM4"]
/**
  * @brief  Sends a Flash-Ack via Ipcc without waiting for the ack
  */
void MBMUXIF_FlashSendAck(void);
[#else]
/**
  * @brief   gives back the pointer to the com buffer associated to Flash feature Notif
  * @retval  return pointer to the com param buffer
  */
MBMUX_ComParam_t *MBMUXIF_GetFlashFeatureNotifComPtr(void);

/**
  * @brief Sends a Flash-Notif via Ipcc and Wait for the ack
  */
void MBMUXIF_FlashSendNotif(void);
[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__MBMUXIF_FLASH_${CPUCORE}_H__ */
