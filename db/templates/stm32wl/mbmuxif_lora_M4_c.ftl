[#ftl]
/**
  ******************************************************************************
  * @file    mbmuxif_lora.c
  * @author  MCD Application Team
  * @brief   allows CM4 applic to register and handle LoraWAN via MBMUX
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "platform.h"
#include "mbmuxif_lora.h"
#include "mbmuxif_sys.h"
#include "sys_app.h"
#include "stm32_mem.h"
[#if !FREERTOS??][#-- If FreeRtos is not used --]
#include "stm32_seq.h"
[#else]
#include "cmsis_os.h"
[/#if]
#include "LoRaMac.h"
#include "LmHandler_mbwrapper.h"
#include "utilities_def.h"
#include "lora_app_version.h"

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
static MBMUX_ComParam_t *LoraComObj;

UTIL_MEM_PLACE_IN_SECTION("MB_MEM1") uint32_t aLoraCmdRespBuff[MAX_PARAM_OF_LORAWAN_CMD_FUNCTIONS];/*shared*/
UTIL_MEM_PLACE_IN_SECTION("MB_MEM1") uint32_t aLoraNotifAckBuff[MAX_PARAM_OF_LORAWAN_NOTIF_FUNCTIONS];/*shared*/

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
static void MBMUXIF_IsrLoraRespRcvCb(void *ComObj);
static void MBMUXIF_IsrLoraNotifRcvCb(void *ComObj);
static void MBMUXIF_TaskLoraNotifRcv(void);

[#if FREERTOS??][#-- If FreeRtos is used --]
static osSemaphoreId_t Sem_MbLoRaRespRcv;

osThreadId_t Thd_LoraNotifRcvProcessId;

const osThreadAttr_t Thd_LoraNotifRcvProcess_attr =
{
  .name = CFG_MB_LORA_PROCESS_NAME,
  .attr_bits = CFG_MB_LORA_PROCESS_ATTR_BITS,
  .cb_mem = CFG_MB_LORA_PROCESS_CB_MEM,
  .cb_size = CFG_MB_LORA_PROCESS_CB_SIZE,
  .stack_mem = CFG_MB_LORA_PROCESS_STACK_MEM,
  .priority = CFG_MB_LORA_PROCESS_PRIORITY,
  .stack_size = CFG_MB_LORA_PROCESS_STACk_SIZE
};
static void Thd_LoraNotifRcvProcess(void *argument);
[/#if]
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/

/**
  * @brief Registers LORA feature to the mailbox and to the sequencer
  * @param none
  * @retval   0: OK;
             -1: no more ipcc channel available;
             -2: feature not provided by CM0PLUS;
             -3: callback error on CM0PLUS
             -4: mistmatch between CM4 and CM0PLUS lora stack versions
  */
int8_t MBMUXIF_LoraInit(void)
{
  FEAT_INFO_Param_t *p_cm0plus_system_info;
  int32_t cm0_vers = 0;
  int8_t ret = 0;

  /* USER CODE BEGIN MBMUXIF_LoraInit_1 */

  /* USER CODE END MBMUXIF_LoraInit_1 */

  p_cm0plus_system_info = MBMUXIF_SystemGetFeatCapabInfoPtr(FEAT_INFO_SYSTEM_ID);
  /* abstract CM0 release version from RC (release candidate) and compare */
  cm0_vers = p_cm0plus_system_info->Feat_Info_Feature_Version >> __APP_VERSION_SUB2_SHIFT;
  if (cm0_vers < (__LAST_COMPATIBLE_CM0_RELEASE >> __APP_VERSION_SUB2_SHIFT))
  {
    ret = -4; /* version incompatibility */
  }
  if (ret >= 0)
  {
    ret = MBMUX_RegisterFeature(FEAT_INFO_LORAWAN_ID, MBMUX_CMD_RESP, MBMUXIF_IsrLoraRespRcvCb, aLoraCmdRespBuff, sizeof(aLoraCmdRespBuff));
  }
  if (ret >= 0)
  {
    ret = MBMUX_RegisterFeature(FEAT_INFO_LORAWAN_ID, MBMUX_NOTIF_ACK, MBMUXIF_IsrLoraNotifRcvCb, aLoraNotifAckBuff, sizeof(aLoraNotifAckBuff));
  }
  if (ret >= 0)
  {
[#if !FREERTOS??][#-- If FreeRtos is not used --]
    UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_MbLoRaNotifRcv), UTIL_SEQ_RFU, MBMUXIF_TaskLoraNotifRcv);
[#else]
    Thd_LoraNotifRcvProcessId = osThreadNew(Thd_LoraNotifRcvProcess, NULL, &Thd_LoraNotifRcvProcess_attr);
[/#if]
    ret = MBMUXIF_SystemSendCm0plusRegistrationCmd(FEAT_INFO_LORAWAN_ID);
    if (ret < 0)
    {
      ret = -3;
    }
  }
[#if FREERTOS??][#-- If FreeRtos is used --]
  Sem_MbLoRaRespRcv = osSemaphoreNew(1, 0, NULL);   /*< Create the semaphore and make it busy at initialization */
[/#if]

  if (ret >= 0)
  {
    ret = 0;
  }

  /* USER CODE BEGIN MBMUXIF_LoraInit_Last */

  /* USER CODE END MBMUXIF_LoraInit_Last */
  return ret;
}

/**
  * @brief gives back the pointer to the com buffer associated to Lora feature Cmd
  * @param none
  * @retval  return pointer to the com param buffer
  */
MBMUX_ComParam_t *MBMUXIF_GetLoraFeatureCmdComPtr(void)
{
  /* USER CODE BEGIN MBMUXIF_GetLoraFeatureCmdComPtr_1 */

  /* USER CODE END MBMUXIF_GetLoraFeatureCmdComPtr_1 */
  MBMUX_ComParam_t *com_param_ptr = MBMUX_GetFeatureComPtr(FEAT_INFO_LORAWAN_ID, MBMUX_CMD_RESP);
  if (com_param_ptr == NULL)
  {
    while (1) {} /* ErrorHandler() : feature isn't registered */
  }
  return com_param_ptr;
  /* USER CODE BEGIN MBMUXIF_GetLoraFeatureCmdComPtr_Last */

  /* USER CODE END MBMUXIF_GetLoraFeatureCmdComPtr_Last */
}

/**
  * @brief Sends a Lora-Cmd via Ipcc and Wait for the response
  * @param none
  * @retval   none
  */
void MBMUXIF_LoraSendCmd(void)
{
  /* USER CODE BEGIN MBMUXIF_LoraSendCmd_1 */

  /* USER CODE END MBMUXIF_LoraSendCmd_1 */
  if (MBMUX_CommandSnd(FEAT_INFO_LORAWAN_ID) == 0)
  {
[#if !FREERTOS??][#-- If FreeRtos is not used --]
    UTIL_SEQ_WaitEvt(1 << CFG_SEQ_Evt_MbLoRaRespRcv);
[#else]
    osSemaphoreAcquire(Sem_MbLoRaRespRcv, osWaitForever);
[/#if]
  }
  else
  {
    Error_Handler();
  }
  /* USER CODE BEGIN MBMUXIF_LoraSendCmd_Last */

  /* USER CODE END MBMUXIF_LoraSendCmd_Last */
}

/**
  * @brief Sends a Lora-Ack  via Ipcc without waiting for the ack
  * @param none
  * @retval   none
  */
void MBMUXIF_LoraSendAck(void)
{
  /* USER CODE BEGIN MBMUXIF_LoraSendAck_1 */

  /* USER CODE END MBMUXIF_LoraSendAck_1 */
  if (MBMUX_AcknowledgeSnd(FEAT_INFO_LORAWAN_ID) != 0)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN MBMUXIF_LoraSendAck_Last */

  /* USER CODE END MBMUXIF_LoraSendAck_Last */
}

/* USER CODE BEGIN EFD */

/* USER CODE END EFD */

/* Private functions ---------------------------------------------------------*/
/**
  * @brief  LORA response callbacks: set event to release waiting task
  * @param  pointer to the LORA com param buffer
  * @retval  none
  */
static void MBMUXIF_IsrLoraRespRcvCb(void *ComObj)
{
  /* USER CODE BEGIN MBMUXIF_IsrLoraRespRcvCb_1 */

  /* USER CODE END MBMUXIF_IsrLoraRespRcvCb_1 */
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_SetEvt(1 << CFG_SEQ_Evt_MbLoRaRespRcv);
[#else]
  osSemaphoreRelease(Sem_MbLoRaRespRcv);
[/#if]
  /* USER CODE BEGIN MBMUXIF_IsrLoraRespRcvCb_Last */

  /* USER CODE END MBMUXIF_IsrLoraRespRcvCb_Last */
}

/**
  * @brief  LORA notification callbacks: schedules a task in order to quit the ISR
  * @param  pointer to the LORA com param buffer
  * @retval  none
  */
static void MBMUXIF_IsrLoraNotifRcvCb(void *ComObj)
{
  /* USER CODE BEGIN MBMUXIF_IsrLoraNotifRcvCb_1 */

  /* USER CODE END MBMUXIF_IsrLoraNotifRcvCb_1 */
  LoraComObj = (MBMUX_ComParam_t *) ComObj;
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_MbLoRaNotifRcv), CFG_SEQ_Prio_0);
[#else]
  osThreadFlagsSet(Thd_LoraNotifRcvProcessId, 1);
[/#if]
  /* USER CODE BEGIN MBMUXIF_IsrLoraNotifRcvCb_Last */

  /* USER CODE END MBMUXIF_IsrLoraNotifRcvCb_Last */
}

/**
  * @brief  LORA task to process the notification
  * @param  pointer to the LORA com param buffer
  * @retval  none
  */
static void MBMUXIF_TaskLoraNotifRcv(void)
{
  /* USER CODE BEGIN MBMUXIF_TaskLoraNotifRcv_1 */

  /* USER CODE END MBMUXIF_TaskLoraNotifRcv_1 */
  Process_Lora_Notif(LoraComObj);
  /* USER CODE BEGIN MBMUXIF_TaskLoraNotifRcv_Last */

  /* USER CODE END MBMUXIF_TaskLoraNotifRcv_Last */
}
[#if FREERTOS??][#-- If FreeRtos is used --]

static void Thd_LoraNotifRcvProcess(void *argument)
{
  /* USER CODE BEGIN Thd_LoraNotifRcvProcess_1 */

  /* USER CODE END Thd_LoraNotifRcvProcess_1 */
  UNUSED(argument);
  for (;;)
  {
    osThreadFlagsWait(1, osFlagsWaitAny, osWaitForever);
    MBMUXIF_TaskLoraNotifRcv();  /*what you want to do*/
  }
  /* USER CODE BEGIN Thd_LoraNotifRcvProcess_Last */

  /* USER CODE END Thd_LoraNotifRcvProcess_Last */
}
[/#if]

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
