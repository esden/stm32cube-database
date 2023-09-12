[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    mbmuxif_kms.c
  * @author  MCD Application Team
  * @brief   Interface layer ${CPUCORE} Kms to MBMUX (Mailbox Multiplexer)
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "platform.h"
#include "mbmuxif_kms.h"
[#if CPUCORE == "CM4"]
#include "mbmuxif_sys.h"
#include "stm32_mem.h"
[#else]
#include "mbmux.h"
#include "sys_app.h"
[/#if]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
#include "stm32_seq.h"
[#else]
#include "cmsis_os.h"
[/#if]
#include "utilities_def.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
[#if CPUCORE == "CM4"]
UTIL_MEM_PLACE_IN_SECTION("MB_MEM1") uint32_t aKmsCmdRespBuff[MAX_PARAM_OF_KMS_CMD_FUNCTIONS];/*shared*/
[#else]
static MBMUX_ComParam_t *KmsComObj;
[/#if]

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
[#if CPUCORE == "CM4"]
static void MBMUXIF_IsrKmsRespRcvCb(void *ComObj);
[#if FREERTOS??][#-- If FreeRtos is used --]
static osSemaphoreId_t Sem_MbKmsRespRcv;
[/#if]
[#else]
static void MBMUXIF_IsrKmsCmdRcvCb(void *ComObj);
static void MBMUXIF_TaskKmsCmdRcv(void);
[/#if]

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/

/**
[#if CPUCORE == "CM4"]
  * @brief Registers KMS feature to the mailbox
  * @param none
  * @retval   0: OK; -1: no more ipcc channel available; -2: feature not provided by CM0PLUS
[#else]
  * @brief   Registers KMS feature to the mailbox and to the sequencer
  * @param   none
  * @retval  0: OK; -1: if ch hasn't been registered by CM4
  * @note    this function is supposed to be called by the System on request (Cmd) of CM4
[/#if]
  */
int8_t MBMUXIF_KmsInit(void)
{
  int8_t ret;
  /* USER CODE BEGIN MBMUXIF_KmsInit_1 */

  /* USER CODE END MBMUXIF_KmsInit_1 */

[#if CPUCORE == "CM4"]
  ret = MBMUX_RegisterFeature(FEAT_INFO_KMS_ID, MBMUX_CMD_RESP, MBMUXIF_IsrKmsRespRcvCb, aKmsCmdRespBuff, sizeof(aKmsCmdRespBuff));
[#else]
  ret = MBMUX_RegisterFeatureCallback(FEAT_INFO_KMS_ID, MBMUX_CMD_RESP, MBMUXIF_IsrKmsCmdRcvCb);
[/#if]
  if (ret >= 0)
  {
[#if CPUCORE == "CM4"]
    /* Note: Kms uses only NOTIF_ACK channel, the SEQ_TASK only on CM0PLUS */

    ret = MBMUXIF_SystemSendCm0plusRegistrationCmd(FEAT_INFO_KMS_ID);
    if (ret < 0)
    {
      ret = -3;
    }
[#else]
    UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_MbKmsCmdRcv), UTIL_SEQ_RFU, MBMUXIF_TaskKmsCmdRcv);
    ret = 0;
[/#if]
  }

  /* USER CODE BEGIN MBMUXIF_KmsInit_Last */

  /* USER CODE END MBMUXIF_KmsInit_Last */
  return ret;
}

[#if CPUCORE == "CM4"]
/**
  * @brief gives back the pointer to the com buffer associated to Kms feature Cmd
  * @param none
  * @retval  return pointer to the com param buffer
  */
MBMUX_ComParam_t *MBMUXIF_GetKmsFeatureCmdComPtr(void)
{
  MBMUX_ComParam_t *com_param_ptr = MBMUX_GetFeatureComPtr(FEAT_INFO_KMS_ID, MBMUX_CMD_RESP);
  /* USER CODE BEGIN MBMUXIF_GetKmsFeatureCmdComPtr_1 */

  /* USER CODE END MBMUXIF_GetKmsFeatureCmdComPtr_1 */

  if (com_param_ptr == NULL)
  {
    Error_Handler(); /* ErrorHandler() : feature isn't registered */
  }

  /* USER CODE BEGIN MBMUXIF_GetKmsFeatureCmdComPtr_Last */

  /* USER CODE END MBMUXIF_GetKmsFeatureCmdComPtr_Last */
  return com_param_ptr;
}

/**
  * @brief Sends a Kms-Cmd via Ipcc and Wait for the response
  * @param none
  * @retval   none
  */
void MBMUXIF_KmsSendCmd(void)
{
  /* USER CODE BEGIN MBMUXIF_KmsSendCmd_1 */

  /* USER CODE END MBMUXIF_KmsSendCmd_1 */
  if (MBMUX_CommandSnd(FEAT_INFO_KMS_ID) == 0)
  {
[#if !FREERTOS??][#-- If FreeRtos is not used --]
    UTIL_SEQ_WaitEvt(1 << CFG_SEQ_Evt_MbKmsRespRcv);
[#else]
    osSemaphoreAcquire(Sem_MbKmsRespRcv, osWaitForever);
[/#if]
  }
  else
  {
    ErrorHandler();
  }
  /* USER CODE BEGIN MBMUXIF_KmsSendCmd_Last */

  /* USER CODE END MBMUXIF_KmsSendCmd_Last */
}

[#else]
/**
  * @brief Sends a Kms-Resp  via Ipcc without waiting for the response
  * @param none
  * @retval   none
  */
void MBMUXIF_KmsSendResp(void)
{
  /* USER CODE BEGIN MBMUXIF_KmsSendResp_1 */

  /* USER CODE END MBMUXIF_KmsSendResp_1 */
  if (MBMUX_ResponseSnd(FEAT_INFO_KMS_ID) != 0)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN MBMUXIF_KmsSendResp_Last */

  /* USER CODE END MBMUXIF_KmsSendResp_Last */
}
[/#if]

/* USER CODE BEGIN EFD */

/* USER CODE END EFD */

/* Private functions ---------------------------------------------------------*/
[#if CPUCORE == "CM4"]
/**
  * @brief  KMS response callbacks: set event to release waiting task
  * @param  pointer to the KMS com param buffer
  * @retval  none
  */
static void MBMUXIF_IsrKmsRespRcvCb(void *ComObj)
{
  /* USER CODE BEGIN MBMUXIF_IsrKmsRespRcvCb_1 */

  /* USER CODE END MBMUXIF_IsrKmsRespRcvCb_1 */
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_SetEvt(1 << CFG_SEQ_Evt_MbKmsRespRcv);
[#else]
  osSemaphoreRelease(Sem_MbKmsRespRcv);
[/#if]
  /* USER CODE BEGIN MBMUXIF_IsrKmsRespRcvCb_Last */

  /* USER CODE END MBMUXIF_IsrKmsRespRcvCb_Last */
}
[#else]
/**
  * @brief  KMS command callbacks: schedules a task in order to quit the ISR
  * @param  pointer to the KMS com param buffer
  * @retval  none
  */
static void MBMUXIF_IsrKmsCmdRcvCb(void *ComObj)
{
  /* USER CODE BEGIN MBMUXIF_IsrKmsCmdRcvCb_1 */

  /* USER CODE END MBMUXIF_IsrKmsCmdRcvCb_1 */
  KmsComObj = (MBMUX_ComParam_t *) ComObj;
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_MbKmsCmdRcv), CFG_SEQ_Prio_0);
  /* USER CODE BEGIN MBMUXIF_IsrKmsCmdRcvCb_Last */

  /* USER CODE END MBMUXIF_IsrKmsCmdRcvCb_Last */
}

/**
  * @brief  KMS task to process the command
  * @param  pointer to the KMS com param buffer
  * @retval  none
  */
static void MBMUXIF_TaskKmsCmdRcv(void)
{
  /* USER CODE BEGIN MBMUXIF_TaskKmsCmdRcv_1 */

  /* USER CODE END MBMUXIF_TaskKmsCmdRcv_1 */
#ifdef ALLOW_KMS_VIA_MBMUX /* currently not supported */
  Process_Kms_Cmd(KmsComObj);
#endif /* ALLOW_KMS_VIA_MBMUX */
  /* USER CODE BEGIN MBMUXIF_TaskKmsCmdRcv_Last */

  /* USER CODE END MBMUXIF_TaskKmsCmdRcv_Last */
}
[/#if]

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
