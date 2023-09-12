[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    mbmux.h
  * @author  MCD Application Team
  * @brief   API which interfaces ${CPUCORE} to IPCC
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

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
/**
  * @brief   Init the mailbox feature table and init the ipcc
  * @param   pMBMUX_ComTable Mailbox intra-MCUs communication table
  */
void MBMUX_Init(MBMUX_ComTable_t *const pMBMUX_ComTable);

[#if CPUCORE == "CM4"]
/**
  * @brief   The application informs MBMUX about the CM0PLUS supported feature list
  * @param   pCM0PLUS_FeatureList pointer to the list of CM0PLUS features
  */
void MBMUX_SetCm0plusFeatureListPtr(FEAT_INFO_List_t *pCM0PLUS_FeatureList);

[/#if]
/**
  * @brief   Assigns an ipcc channel to a feature (for a requested direction) and registers associated application cb and buffer
  * @param   e_featID   identifier of the feature
  * @param   ComType    0 for CMd/Resp (TX), 1 for Notif/Ack (RX)
  * @param   MsgCb      application callback for notification processing
[#if CPUCORE == "CM4"]
  * @param   ComBuffer  application buffer where Msg values (params) are stored
  * @param   ComBufSize max size allocated by the application for the buffer
  * @return  channel index or -1: (no more ipcc channel available) or -2: feature not provided by CM0PLUS
[#else]
  * @retval  -1 if ch hasn't been registered by CM4, otherwise the nr of the assigned ch
[/#if]
  */
[#if CPUCORE == "CM4"]
int8_t MBMUX_RegisterFeature(FEAT_INFO_IdTypeDef e_featID, MBMUX_ComType_t ComType,
                             void (*MsgCb)(void *ComObj), uint32_t *const ComBuffer, uint16_t ComBufSize);
[#else]
int8_t MBMUX_RegisterFeatureCallback(FEAT_INFO_IdTypeDef e_featID, MBMUX_ComType_t ComType,
                                     void (*MsgCb)(void *ComObj));
[/#if]

/**
  * @brief   Release an ipcc channel from the given feature and direction
  * @param   e_featID  identifier of the feature
  * @param   ComType  0 for CMd/Resp (TX), 1 for Notif/Ack (RX)
  * @note    this function has not been fully tested, because never required by our application
  */
void MBMUX_UnregisterFeature(FEAT_INFO_IdTypeDef e_featID, MBMUX_ComType_t ComType);

/**
[#if CPUCORE == "CM4"]
  * @brief   gives back the pointer to the MailBox com buffer associated to the feature
[#else]
  * @brief   gives back the pointer to the com object retrieved from shared memory
[/#if]
  * @param   e_featID  identifier of the feature
  * @param   ComType   0 for CMd/Resp (TX), 1 for Notif/Ack (RX)
  * @return  pointer to the com param object associated to the feature
  */
MBMUX_ComParam_t *MBMUX_GetFeatureComPtr(FEAT_INFO_IdTypeDef e_featID, MBMUX_ComType_t ComType);

[#if CPUCORE == "CM4"]
/**
  * @brief   Send Cmd to remote MCU for a requested feature by abstracting the channel idx
  * @param   e_featID  identifier of the feature
  * @retval  OK: 0 , fail: -1
  */
int32_t MBMUX_CommandSnd(FEAT_INFO_IdTypeDef e_featID);

/**
  * @brief   Send ack to remote MCU for a requested feature by abstracting the channel idx
  * @param   e_featID  identifier of the feature
  * @retval  OK: 0 , fail: -1
  */
uint32_t MBMUX_AcknowledgeSnd(FEAT_INFO_IdTypeDef e_featID);
[#else]
/**
  * @brief   Send Notif to remote MCU for a requested feature by abstracting the channel idx
  * @param   e_featID  identifier of the feature
  * @retval  OK: 0 , fail: -1
  */
int32_t MBMUX_NotificationSnd(FEAT_INFO_IdTypeDef e_featID);

/**
  * @brief   Send response to remote MCU for a requested feature by abstracting the channel idx
  * @param   e_featID  identifier of the feature
  * @retval  OK: 0 , fail: -1
  */
uint32_t MBMUX_ResponseSnd(FEAT_INFO_IdTypeDef e_featID);
[/#if]

[#if CPUCORE == "CM0PLUS"]
/**
  * @brief   Double check buffer pointer (to avoid fault HW injection attacks)
  * @param   pBufferAddress buffer start address
  * @param   bufferSize buffer size
  * @return  pointer to validated address
  */
uint32_t *MBMUX_SEC_VerifySramBufferPtr(uint32_t *pBufferAddress, uint32_t bufferSize);

[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__MBMUX_${CPUCORE}_H__ */
