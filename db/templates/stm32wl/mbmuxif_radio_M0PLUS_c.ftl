[#ftl]
/**
  ******************************************************************************
  * @file    mbmuxif_radio.c
  * @author  MCD Application Team
  * @brief   allows CM0PLUS applic to register and handle RADIO driver via MBMUX
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "platform.h"
#include "mbmuxif_radio.h"
#include "mbmux.h"
#include "sys_app.h"
#include "stm32_seq.h"
#include "radio_mbwrapper.h"
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
static MBMUX_ComParam_t *RadioComObj;
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
static void MBMUXIF_IsrRadioAckRcvCb(void *ComObj);
static void MBMUXIF_IsrRadioCmdRcvCb(void *ComObj);
static void MBMUXIF_TaskRadioCmdRcv(void);
static void MBMUXIF_TaskRadioNotifSnd(void);
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/

/**
  * @brief   Registers RADIO feature to the mailbox and to the sequencer
  * @param   none
  * @retval  0: OK; -1: if ch hasn't been registered by CM4
  * @note    this function is supposed to be called by the System on request (Cmd) of CM4
  */
int8_t MBMUXIF_RadioInit(void)
{
  int8_t ret;

  /* USER CODE BEGIN MBMUXIF_RadioInit_1 */

  /* USER CODE END MBMUXIF_RadioInit_1 */

  ret = MBMUX_RegisterFeatureCallback(FEAT_INFO_RADIO_ID, MBMUX_NOTIF_ACK, MBMUXIF_IsrRadioAckRcvCb);
  if (ret >= 0)
  {
    ret = MBMUX_RegisterFeatureCallback(FEAT_INFO_RADIO_ID, MBMUX_CMD_RESP, MBMUXIF_IsrRadioCmdRcvCb);
  }
  if (ret >= 0)
  {
    UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_MbRadioCmdRcv), UTIL_SEQ_RFU, MBMUXIF_TaskRadioCmdRcv);
    UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_MbRadioNotifSnd), UTIL_SEQ_RFU, MBMUXIF_TaskRadioNotifSnd);
    ret = 0;
  }

  /* USER CODE BEGIN MBMUXIF_RadioInit_Last */

  /* USER CODE END MBMUXIF_RadioInit_Last */
  return ret;
}

/**
  * @brief gives back the pointer to the com buffer associated to Radio feature Notif
  * @param none
  * @retval  return pointer to the com param buffer
  */
MBMUX_ComParam_t *MBMUXIF_GetRadioFeatureNotifComPtr(void)
{
  /* USER CODE BEGIN MBMUXIF_GetRadioFeatureNotifComPtr_1 */

  /* USER CODE END MBMUXIF_GetRadioFeatureNotifComPtr_1 */
  MBMUX_ComParam_t *com_param_ptr = MBMUX_GetFeatureComPtr(FEAT_INFO_RADIO_ID, MBMUX_NOTIF_ACK);
  if (com_param_ptr == NULL)
  {
    while (1) {} /* ErrorHandler() : feature isn't registered */
  }
  return com_param_ptr;
  /* USER CODE BEGIN MBMUXIF_GetRadioFeatureNotifComPtr_Last */

  /* USER CODE END MBMUXIF_GetRadioFeatureNotifComPtr_Last */
}

/**
  * @brief Sends a Radio-Notif via Ipcc and Wait for the ack
  * @param none
  * @retval   none
  */
void MBMUXIF_RadioSendNotif(void)
{
  /* USER CODE BEGIN MBMUXIF_RadioSendNotif_1 */

  /* USER CODE END MBMUXIF_RadioSendNotif_1 */
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_MbRadioNotifSnd), CFG_SEQ_Prio_0);
  /* USER CODE BEGIN MBMUXIF_RadioSendNotif_Last */

  /* USER CODE END MBMUXIF_RadioSendNotif_Last */
}

/**
  * @brief Sends a Radio-Resp  via Ipcc without waiting for the response
  * @param none
  * @retval   none
  */
void MBMUXIF_RadioSendResp(void)
{
  /* USER CODE BEGIN MBMUXIF_RadioSendResp_1 */

  /* USER CODE END MBMUXIF_RadioSendResp_1 */
  if (MBMUX_ResponseSnd(FEAT_INFO_RADIO_ID) != 0)
  {
    while (1) {} /* ErrorHandler(); */
  }
  /* USER CODE BEGIN MBMUXIF_RadioSendResp_Last */

  /* USER CODE END MBMUXIF_RadioSendResp_Last */
}

/* USER CODE BEGIN EFD */

/* USER CODE END EFD */

/* Private functions ---------------------------------------------------------*/
/**
  * @brief  RADIO acknowledge callbacks: set event to release waiting task
  * @param  pointer to the RADIO com param buffer
  * @retval  none
  */
static void MBMUXIF_IsrRadioAckRcvCb(void *ComObj)
{
  /* USER CODE BEGIN MBMUXIF_IsrRadioAckRcvCb_1 */

  /* USER CODE END MBMUXIF_IsrRadioAckRcvCb_1 */
  UTIL_SEQ_SetEvt(1 << CFG_SEQ_Evt_MbRadioAckRcv);
  /* USER CODE BEGIN MBMUXIF_IsrRadioAckRcvCb_Last */

  /* USER CODE END MBMUXIF_IsrRadioAckRcvCb_Last */
}

/**
  * @brief  RADIO command callbacks: schedules a task in order to quit the ISR
  * @param  pointer to the RADIO com param buffer
  * @retval  none
  */
static void MBMUXIF_IsrRadioCmdRcvCb(void *ComObj)
{
  /* USER CODE BEGIN MBMUXIF_IsrRadioCmdRcvCb_1 */

  /* USER CODE END MBMUXIF_IsrRadioCmdRcvCb_1 */
  RadioComObj = (MBMUX_ComParam_t *) ComObj;
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_MbRadioCmdRcv), CFG_SEQ_Prio_0);
  /* USER CODE BEGIN MBMUXIF_IsrRadioCmdRcvCb_Last*/

  /* USER CODE END MBMUXIF_IsrRadioCmdRcvCb_Last */
}

/**
  * @brief  RADIO task to process the command
  * @param  pointer to the RADIO com param buffer
  * @retval  none
  */
static void MBMUXIF_TaskRadioCmdRcv(void)
{
  /* USER CODE BEGIN MBMUXIF_TaskRadioCmdRcv_1 */

  /* USER CODE END MBMUXIF_TaskRadioCmdRcv_1 */
  Process_Radio_Cmd(RadioComObj);
  /* USER CODE BEGIN MBMUXIF_TaskRadioCmdRcv_Last */

  /* USER CODE END MBMUXIF_TaskRadioCmdRcv_Last */
}

/**
  * @brief  RADIO task to use the IPCC and the blocking WaitEvt on Task rather then Irq
  * @param  pointer to the RADIO com param buffer
  * @retval  none
  */
static void MBMUXIF_TaskRadioNotifSnd(void)
{
  /* USER CODE BEGIN MBMUXIF_TaskRadioNotifSnd_1 */

  /* USER CODE END MBMUXIF_TaskRadioNotifSnd_1 */
  if (MBMUX_NotificationSnd(FEAT_INFO_RADIO_ID) == 0)
  {
    UTIL_SEQ_WaitEvt(1 << CFG_SEQ_Evt_MbRadioAckRcv);
  }
  else
  {
    while (1) {} /* ErrorHandler(); */
  }
  /* USER CODE BEGIN MBMUXIF_TaskRadioNotifSnd_Last */

  /* USER CODE END MBMUXIF_TaskRadioNotifSnd_Last */
}

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
