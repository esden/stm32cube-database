[#ftl]
/**
  ******************************************************************************
  * @file    mbmuxif_radio.c
  * @author  MCD Application Team
  * @brief   allows CM4 applic to register and handle RADIO driver via MBMUX
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "platform.h"
#include "mbmuxif_radio.h"
#include "mbmuxif_sys.h"
#include "sys_app.h"
#include "stm32_mem.h"
[#if !FREERTOS??][#-- If FreeRtos is not used --]
#include "stm32_seq.h"
[#else]
#include "cmsis_os.h"
[/#if]
#include "radio_mbwrapper.h"
#include "subghz_phy_version.h"
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

UTIL_MEM_PLACE_IN_SECTION("MB_MEM1") uint32_t aRadioCmdRespBuff[MAX_PARAM_OF_RADIO_CMD_FUNCTIONS];/*shared*/
UTIL_MEM_PLACE_IN_SECTION("MB_MEM1") uint32_t aRadioNotifAckBuff[MAX_PARAM_OF_RADIO_NOTIF_FUNCTIONS];/*shared*/

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
static void MBMUXIF_IsrRadioRespRcvCb(void *ComObj);
static void MBMUXIF_IsrRadioNotifRcvCb(void *ComObj);
static void MBMUXIF_TaskRadioNotifRcv(void);
[#if FREERTOS??][#-- If FreeRtos is used --]

static osSemaphoreId_t Sem_MbRadioRespRcv;

osThreadId_t Thd_RadioNotifRcvProcessId;

const osThreadAttr_t Thd_RadioNotifRcvProcess_attr =
{
  .name = CFG_MB_RADIO_PROCESS_NAME,
  .attr_bits = CFG_MB_RADIO_PROCESS_ATTR_BITS,
  .cb_mem = CFG_MB_RADIO_PROCESS_CB_MEM,
  .cb_size = CFG_MB_RADIO_PROCESS_CB_SIZE,
  .stack_mem = CFG_MB_RADIO_PROCESS_STACK_MEM,
  .priority = CFG_MB_RADIO_PROCESS_PRIORITY,
  .stack_size = CFG_MB_RADIO_PROCESS_STACk_SIZE
};
static void Thd_RadioNotifRcvProcess(void *argument);
[/#if]

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/

/**
  * @brief Registers RADIO feature to the mailbox and to the sequencer
  * @param none
  * @retval   0: OK;
             -1: no more ipcc channel available;
             -2: feature not provided by CM0PLUS;
             -3: callback error on CM0PLUS
             -4: mistmatch between CM4 and CM0PLUS lora stack versions
  */
int8_t MBMUXIF_RadioInit(void)
{
  FEAT_INFO_Param_t *p_cm0plus_specific_features_info;
  int8_t ret = 0;

  /* USER CODE BEGIN MBMUXIF_RadioInit_1 */

  /* USER CODE END MBMUXIF_RadioInit_1 */

  p_cm0plus_specific_features_info = MBMUXIF_SystemGetFeatCapabInfoPtr(FEAT_INFO_RADIO_ID);
  if (p_cm0plus_specific_features_info->Feat_Info_Feature_Version != __SUBGHZ_PHY_VERSION)
  {
    ret = -4; /* version mismatch */
  }
  if (ret >= 0)
  {
    ret = MBMUX_RegisterFeature(FEAT_INFO_RADIO_ID, MBMUX_CMD_RESP, MBMUXIF_IsrRadioRespRcvCb, aRadioCmdRespBuff, sizeof(aRadioCmdRespBuff));
  }
  if (ret >= 0)
  {
    ret = MBMUX_RegisterFeature(FEAT_INFO_RADIO_ID, MBMUX_NOTIF_ACK, MBMUXIF_IsrRadioNotifRcvCb, aRadioNotifAckBuff, sizeof(aRadioNotifAckBuff));
  }
  if (ret >= 0)
  {
[#if !FREERTOS??][#-- If FreeRtos is not used --]
    UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_MbRadioNotifRcv), UTIL_SEQ_RFU, MBMUXIF_TaskRadioNotifRcv);
[#else]
    Thd_RadioNotifRcvProcessId = osThreadNew(Thd_RadioNotifRcvProcess, NULL, &Thd_RadioNotifRcvProcess_attr);
    Sem_MbRadioRespRcv = osSemaphoreNew(1, 0, NULL);   /*< Create the semaphore and make it busy at initialization */
[/#if]
    ret = MBMUXIF_SystemSendCm0plusRegistrationCmd(FEAT_INFO_RADIO_ID);
    if (ret < 0)
    {
      ret = -3;
    }
  }

  if (ret >= 0)
  {
    ret = 0;
  }

  /* USER CODE BEGIN MBMUXIF_RadioInit_Last */

  /* USER CODE END MBMUXIF_RadioInit_Last */
  return ret;
}

/**
  * @brief gives back the pointer to the com buffer associated to Radio feature Cmd
  * @param none
  * @retval  return pointer to the com param buffer
  */
MBMUX_ComParam_t *MBMUXIF_GetRadioFeatureCmdComPtr(void)
{
  /* USER CODE BEGIN MBMUXIF_GetRadioFeatureCmdComPtr_1 */

  /* USER CODE END MBMUXIF_GetRadioFeatureCmdComPtr_1 */
  MBMUX_ComParam_t *com_param_ptr = MBMUX_GetFeatureComPtr(FEAT_INFO_RADIO_ID, MBMUX_CMD_RESP);
  if (com_param_ptr == NULL)
  {
    while (1) {} /* ErrorHandler() : feature isn't registered */
  }
  return com_param_ptr;
  /* USER CODE BEGIN MBMUXIF_GetRadioFeatureCmdComPtr_Last */

  /* USER CODE END MBMUXIF_GetRadioFeatureCmdComPtr_Last */
}

/**
  * @brief Sends a Radio-Cmd via Ipcc and Wait for the response
  * @param none
  * @retval   none
  */
void MBMUXIF_RadioSendCmd(void)
{
  /* USER CODE BEGIN MBMUXIF_RadioSendCmd_1 */

  /* USER CODE END MBMUXIF_RadioSendCmd_1 */
  if (MBMUX_CommandSnd(FEAT_INFO_RADIO_ID) == 0)
  {
[#if !FREERTOS??][#-- If FreeRtos is not used --]
    UTIL_SEQ_WaitEvt(1 << CFG_SEQ_Evt_MbRadioRespRcv);
[#else]
    osSemaphoreAcquire(Sem_MbRadioRespRcv, osWaitForever);
[/#if]
  }
  else
  {
    Error_Handler();
  }
  /* USER CODE BEGIN MBMUXIF_RadioSendCmd_Last */

  /* USER CODE END MBMUXIF_RadioSendCmd_Last */
}

/**
  * @brief Sends a Radio-Ack  via Ipcc without waiting for the ack
  * @param none
  * @retval   none
  */
void MBMUXIF_RadioSendAck(void)
{
  /* USER CODE BEGIN MBMUXIF_RadioSendAck_1 */

  /* USER CODE END MBMUXIF_RadioSendAck_1 */
  if (MBMUX_AcknowledgeSnd(FEAT_INFO_RADIO_ID) != 0)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN MBMUXIF_RadioSendAck_Last */

  /* USER CODE END MBMUXIF_RadioSendAck_Last */
}

/* USER CODE BEGIN EFD */

/* USER CODE END EFD */

/* Private functions ---------------------------------------------------------*/
/**
  * @brief  RADIO response callbacks: set event to release waiting task
  * @param  pointer to the RADIO com param buffer
  * @retval  none
  */
static void MBMUXIF_IsrRadioRespRcvCb(void *ComObj)
{
  /* USER CODE BEGIN MBMUXIF_IsrRadioRespRcvCb_1 */

  /* USER CODE END MBMUXIF_IsrRadioRespRcvCb_1 */
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_SetEvt(1 << CFG_SEQ_Evt_MbRadioRespRcv);
[#else]
  osSemaphoreRelease(Sem_MbRadioRespRcv);
[/#if]
  /* USER CODE BEGIN MBMUXIF_IsrRadioRespRcvCb_Last */

  /* USER CODE END MBMUXIF_IsrRadioRespRcvCb_Last */
}

/**
  * @brief  RADIO notification callbacks: schedules a task in order to quit the ISR
  * @param  pointer to the RADIO com param buffer
  * @retval  none
  */
static void MBMUXIF_IsrRadioNotifRcvCb(void *ComObj)
{
  /* USER CODE BEGIN MBMUXIF_IsrRadioNotifRcvCb_1 */

  /* USER CODE END MBMUXIF_IsrRadioNotifRcvCb_1 */
  RadioComObj = (MBMUX_ComParam_t *) ComObj;
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_MbRadioNotifRcv), CFG_SEQ_Prio_0);
[#else]
  osThreadFlagsSet(Thd_RadioNotifRcvProcessId, 1);
[/#if]
  /* USER CODE BEGIN MBMUXIF_IsrRadioNotifRcvCb_Last */

  /* USER CODE END MBMUXIF_IsrRadioNotifRcvCb_Last */
}

/**
  * @brief  RADIO task to process the notification
  * @param  pointer to the RADIO com param buffer
  * @retval  none
  */
static void MBMUXIF_TaskRadioNotifRcv(void)
{
  /* USER CODE BEGIN MBMUXIF_TaskRadioNotifRcv_1 */

  /* USER CODE END MBMUXIF_TaskRadioNotifRcv_1 */
  Process_Radio_Notif(RadioComObj);
  /* USER CODE BEGIN MBMUXIF_TaskRadioNotifRcv_Last */

  /* USER CODE END MBMUXIF_TaskRadioNotifRcv_Last */
}
[#if FREERTOS??][#-- If FreeRtos is used --]

static void Thd_RadioNotifRcvProcess(void *argument)
{
  /* USER CODE BEGIN Thd_RadioNotifRcvProcess_1 */

  /* USER CODE END Thd_RadioNotifRcvProcess_1 */
  UNUSED(argument);
  for (;;)
  {
    osThreadFlagsWait(1, osFlagsWaitAny, osWaitForever);
    MBMUXIF_TaskRadioNotifRcv();  /*what you want to do*/
  }
  /* USER CODE BEGIN Thd_RadioNotifRcvProcess_Last */

  /* USER CODE END Thd_RadioNotifRcvProcess_Last */
}
[/#if]

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
