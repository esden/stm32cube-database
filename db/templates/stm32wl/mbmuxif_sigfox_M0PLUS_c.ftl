[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    mbmuxif_sigfox.c
  * @author  MCD Application Team
  * @brief   allows CM0PLUS application to register and handle Sigfox to MBMUX
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign UTIL_SEQ_EN_M0 = "true"]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "UTIL_SEQ_EN_M0"]
                    [#assign UTIL_SEQ_EN_M0 = definition.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]

/* Includes ------------------------------------------------------------------*/
#include "platform.h"
#include "mbmuxif_sigfox.h"
#include "mbmux.h"
#include "sys_app.h"
[#if UTIL_SEQ_EN_M0 == "true"]
#include "stm32_seq.h"
[/#if]
#include "sigfox_mbwrapper.h"
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
static MBMUX_ComParam_t *SigfoxComObj;

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/**
  * @brief  Sigfox acknowledge callbacks: set event to release waiting task
  * @param  ComObj pointer to the Sigfox com param buffer
  */
static void MBMUXIF_IsrSigfoxAckRcvCb(void *ComObj);

/**
  * @brief  Sigfox command callbacks: schedules a task in order to quit the ISR
  * @param  ComObj pointer to the Sigfox com param buffer
  */
static void MBMUXIF_IsrSigfoxCmdRcvCb(void *ComObj);

/**
  * @brief  Sigfox task to process the command
  */
static void MBMUXIF_TaskSigfoxCmdRcv(void);

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/
int8_t MBMUXIF_SigfoxInit(void)
{
  int8_t ret;

  /* USER CODE BEGIN MBMUXIF_SigfoxInit_1 */

  /* USER CODE END MBMUXIF_SigfoxInit_1 */

  ret = MBMUX_RegisterFeatureCallback(FEAT_INFO_SIGFOX_ID, MBMUX_NOTIF_ACK, MBMUXIF_IsrSigfoxAckRcvCb);
  if (ret >= 0)
  {
    ret = MBMUX_RegisterFeatureCallback(FEAT_INFO_SIGFOX_ID, MBMUX_CMD_RESP, MBMUXIF_IsrSigfoxCmdRcvCb);
  }
  if (ret >= 0)
  {
[#if UTIL_SEQ_EN_M0 == "true"]
    UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_MbSigfoxCmdRcv), UTIL_SEQ_RFU, MBMUXIF_TaskSigfoxCmdRcv);
[#else]
    /* USER CODE BEGIN MBMUXIF_SigfoxInit_OS */

    /* USER CODE END MBMUXIF_SigfoxInit_OS */
[/#if][#--  SEQUENCER --]
    ret = 0;
  }

  /* USER CODE BEGIN MBMUXIF_SigfoxInit_Last */

  /* USER CODE END MBMUXIF_SigfoxInit_Last */

  return ret;
}

MBMUX_ComParam_t *MBMUXIF_GetSigfoxFeatureNotifComPtr(void)
{
  /* USER CODE BEGIN MBMUXIF_GetSigfoxFeatureNotifComPtr_1 */

  /* USER CODE END MBMUXIF_GetSigfoxFeatureNotifComPtr_1 */
  MBMUX_ComParam_t *com_param_ptr = MBMUX_GetFeatureComPtr(FEAT_INFO_SIGFOX_ID, MBMUX_NOTIF_ACK);
  if (com_param_ptr == NULL)
  {
    Error_Handler(); /* feature isn't registered */
  }
  return com_param_ptr;
  /* USER CODE BEGIN MBMUXIF_GetSigfoxFeatureNotifComPtr_Last */

  /* USER CODE END MBMUXIF_GetSigfoxFeatureNotifComPtr_Last */
}

void MBMUXIF_SigfoxSendNotif(void)
{
  /* USER CODE BEGIN MBMUXIF_SigfoxSendNotif_1 */

  /* USER CODE END MBMUXIF_SigfoxSendNotif_1 */
[#if UTIL_SEQ_EN_M0 == "true"]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_MbSigfoxNotifRcv), CFG_SEQ_Prio_0);
[#else]
  /* USER CODE BEGIN MBMUXIF_SigfoxSendNotif_OS */

  /* USER CODE END MBMUXIF_SigfoxSendNotif_OS */
[/#if][#--  SEQUENCER --]
  /* USER CODE BEGIN MBMUXIF_SigfoxSendNotif_Last */

  /* USER CODE END MBMUXIF_SigfoxSendNotif_Last */
}

void MBMUXIF_SigfoxSendNotifTask(void)
{
  /* USER CODE BEGIN MBMUXIF_SigfoxSendNotifTask_1 */

  /* USER CODE END MBMUXIF_SigfoxSendNotifTask_1 */
  if (MBMUX_NotificationSnd(FEAT_INFO_SIGFOX_ID) == 0)
  {
[#if UTIL_SEQ_EN_M0 == "true"]
    UTIL_SEQ_WaitEvt(1 << CFG_SEQ_Evt_MbSigfoxAckRcv);
[#else]
    /* USER CODE BEGIN MBMUXIF_SigfoxSendNotifTask_OS */

    /* USER CODE END MBMUXIF_SigfoxSendNotifTask_OS */
[/#if][#--  SEQUENCER --]
  }
  else
  {
    Error_Handler();
  }
  /* USER CODE BEGIN MBMUXIF_SigfoxSendNotifTask_Last */

  /* USER CODE END MBMUXIF_SigfoxSendNotifTask_Last */
}

void MBMUXIF_SigfoxSendResp(void)
{
  /* USER CODE BEGIN MBMUXIF_SigfoxSendResp_1 */

  /* USER CODE END MBMUXIF_SigfoxSendResp_1 */
  if (MBMUX_ResponseSnd(FEAT_INFO_SIGFOX_ID) != 0)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN MBMUXIF_SigfoxSendResp_Last */

  /* USER CODE END MBMUXIF_SigfoxSendResp_Last */
}

/* USER CODE BEGIN EFD */

/* USER CODE END EFD */

/* Private functions ---------------------------------------------------------*/

static void MBMUXIF_IsrSigfoxAckRcvCb(void *ComObj)
{
  /* USER CODE BEGIN MBMUXIF_IsrSigfoxAckRcvCb_1 */

  /* USER CODE END MBMUXIF_IsrSigfoxAckRcvCb_1 */
[#if UTIL_SEQ_EN_M0 == "true"]
  UTIL_SEQ_SetEvt(1 << CFG_SEQ_Evt_MbSigfoxAckRcv);
[#else]
  /* USER CODE BEGIN MBMUXIF_IsrLoraSigfoxRcvCb_OS */

  /* USER CODE END MBMUXIF_IsrLoraSigfoxRcvCb_OS */
[/#if][#--  SEQUENCER --]
  /* USER CODE BEGIN MBMUXIF_IsrSigfoxAckRcvCb_Last */

  /* USER CODE END MBMUXIF_IsrSigfoxAckRcvCb_Last */
}

static void MBMUXIF_IsrSigfoxCmdRcvCb(void *ComObj)
{
  /* USER CODE BEGIN MBMUXIF_IsrSigfoxCmdRcvCb_1 */

  /* USER CODE END MBMUXIF_IsrSigfoxCmdRcvCb_1 */
  SigfoxComObj = (MBMUX_ComParam_t *) ComObj;
[#if UTIL_SEQ_EN_M0 == "true"]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_MbSigfoxCmdRcv), CFG_SEQ_Prio_0);
[#else]
  /* USER CODE BEGIN MBMUXIF_IsrSigfoxCmdRcvCb_OS */

  /* USER CODE END MBMUXIF_IsrSigfoxCmdRcvCb_OS */
[/#if][#--  SEQUENCER --]
  /* USER CODE BEGIN MBMUXIF_IsrSigfoxCmdRcvCb_Last */

  /* USER CODE END MBMUXIF_IsrSigfoxCmdRcvCb_Last */
}

static void MBMUXIF_TaskSigfoxCmdRcv(void)
{
  /* USER CODE BEGIN MBMUXIF_TaskSigfoxCmdRcv_1 */

  /* USER CODE END MBMUXIF_TaskSigfoxCmdRcv_1 */
  Process_Sigfox_Cmd(SigfoxComObj);
  /* USER CODE BEGIN MBMUXIF_TaskSigfoxCmdRcv_Last */

  /* USER CODE END MBMUXIF_TaskSigfoxCmdRcv_Last */
}

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
