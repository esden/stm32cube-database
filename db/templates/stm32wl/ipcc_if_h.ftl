[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ipcc_if.h
  * @author  MCD Application Team
  * @brief   This file contains the interface of the ipcc driver on ${CPUCORE}.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __IPCC_IF_${CPUCORE}_H__
#define __IPCC_IF_${CPUCORE}_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "platform.h"
[#if HALCompliant??]
#include "main.h"
[#else]
#include "ipcc.h"
[/#if]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
[#if HALCompliant??]
extern IPCC_HandleTypeDef hipcc;

[/#if]
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
  * @brief Initialize IPCC and register upper and downer callbacks
  * @param  IPCC_IF_ResponseRcv_cb     response callback
  * @param  IPCC_IF_NotificationRcv_cb notification callback
  */
void IPCC_IF_Init(void (*IPCC_IF_ResponseRcv_cb)(uint32_t channelIdx),
                  void (*IPCC_IF_NotificationRcv_cb)(uint32_t channelIdx));
[#else]
/**
  * @brief Initialize IPCC and register upper and downer callbacks
  * @param  IPCC_IF_CommandRcv_cb     command callback
  * @param  IPCC_IF_AcknowledgeRcv_cb acknowledge callback
  */
void IPCC_IF_Init(void (*IPCC_IF_CommandRcv_cb)(uint32_t channelIdx),
                  void (*IPCC_IF_AcknowledgeRcv_cb)(uint32_t channelIdx));
[/#if]

/**
  * @brief Get Command status (abstract application from Ipcc handler and channel direction)
  * @param channelIdx  ipcc channel
  * @return ipcc channel status
  * @retval IPCC_CHANNEL_STATUS_FREE 0
  * @retval IPCC_CHANNEL_STATUS_OCCUPIED 1
  */
uint32_t IPCC_IF_CmdRespStatus(uint32_t channelIdx);

/**
  * @brief Get notification status (abstract application from Ipcc handler and channel direction)
  * @param channelIdx  ipcc channel
  * @return ipcc channel status
  * @retval IPCC_CHANNEL_STATUS_FREE 0
  * @retval IPCC_CHANNEL_STATUS_OCCUPIED 1
  */
uint32_t IPCC_IF_NotifAckStatus(uint32_t channelIdx);

[#if CPUCORE == "CM4"]
/**
  * @brief Send Cmd to the remote CPU (abstract application from Ipcc handler and channel direction)
  * @param channelIdx  ipcc channel
  * @return ipcc status [OK: 0 , fail: -1]
  */
int32_t IPCC_IF_CommandSnd(uint32_t channelIdx);

/**
  * @brief Send Ack to the remote CPU (abstract application from Ipcc handler and channel direction)
  * @param channelIdx  ipcc channel
  * @return ipcc status [OK: 0 , fail: -1]
  */
int32_t IPCC_IF_AcknowledgeSnd(uint32_t channelIdx);
[#else]
/**
  * @brief Send Cmd to the remote CPU (abstract application from Ipcc handler and channel direction)
  * @param channelIdx  ipcc channel
  * @return ipcc status [OK: 0 , fail: -1]
  */
int32_t IPCC_IF_NotificationSnd(uint32_t channelIdx);

/**
  * @brief Send Ack to the remote CPU (abstract application from Ipcc handler and channel direction)
  * @param channelIdx  ipcc channel
  * @return ipcc status [OK: 0 , fail: -1]
  */
int32_t IPCC_IF_ResponseSnd(uint32_t channelIdx);
[/#if]

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __IPCC_IF_${CPUCORE}_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE***/
