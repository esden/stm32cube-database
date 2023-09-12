[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    mbmuxif_sigfox.c
  * @author  MCD Application Team
  * @brief   allows CM4 application to register and handle SigfoxWAN via MBMUX
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "platform.h"
#include "mbmuxif_sigfox.h"
#include "mbmuxif_sys.h"
#include "sys_app.h"
#include "stm32_mem.h"
[#if !FREERTOS??][#-- If FreeRtos is not used --]
#include "stm32_seq.h"
[#else]
#include "cmsis_os.h"
[/#if]
#include "sigfox_mbwrapper.h"
#include "sgfx_app_version.h"
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

UTIL_MEM_PLACE_IN_SECTION("MB_MEM1") uint32_t aSigfoxCmdRespBuff[MAX_PARAM_OF_SIGFOX_CMD_FUNCTIONS];/*shared*/
UTIL_MEM_PLACE_IN_SECTION("MB_MEM1") uint32_t aSigfoxNotifAckBuff[MAX_PARAM_OF_SIGFOX_NOTIF_FUNCTIONS];/*shared*/

[#if FREERTOS??][#-- If FreeRtos is used --]
static osSemaphoreId_t Sem_MbSigfoxRespRcv;

osThreadId_t Thd_SigfoxNotifRcvProcessId;

const osThreadAttr_t Thd_SigfoxNotifRcvProcess_attr =
{
  .name = CFG_MB_SIGFOX_PROCESS_NAME,
  .attr_bits = CFG_MB_SIGFOX_PROCESS_ATTR_BITS,
  .cb_mem = CFG_MB_SIGFOX_PROCESS_CB_MEM,
  .cb_size = CFG_MB_SIGFOX_PROCESS_CB_SIZE,
  .stack_mem = CFG_MB_SIGFOX_PROCESS_STACK_MEM,
  .priority = CFG_MB_SIGFOX_PROCESS_PRIORITY,
  .stack_size = CFG_MB_SIGFOX_PROCESS_STACk_SIZE
};
static void Thd_SigfoxNotifRcvProcess(void *argument);
[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/**
  * @brief  Sigfox response callbacks: set event to release waiting task
  * @param  ComObj pointer to the Sigfox com param buffer
  */
static void MBMUXIF_IsrSigfoxRespRcvCb(void *ComObj);

/**
  * @brief  Sigfox notification callbacks: schedules a task in order to quit the ISR
  * @param  ComObj pointer to the Sigfox com param buffer
  */
static void MBMUXIF_IsrSigfoxNotifRcvCb(void *ComObj);

/**
  * @brief  Sigfox task to process the notification
  */
static void MBMUXIF_TaskSigfoxNotifRcv(void);

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/
int8_t MBMUXIF_SigfoxInit(void)
{
  FEAT_INFO_Param_t *p_cm0plus_system_info;
  int32_t cm0_vers = 0;
  int8_t ret = 0;

  /* USER CODE BEGIN MBMUXIF_SigfoxInit_1 */

  /* USER CODE END MBMUXIF_SigfoxInit_1 */

  p_cm0plus_system_info = MBMUXIF_SystemGetFeatCapabInfoPtr(FEAT_INFO_SYSTEM_ID);
  /* abstract CM0 release version from RC (release candidate) and compare */
  cm0_vers = p_cm0plus_system_info->Feat_Info_Feature_Version >> __APP_VERSION_SUB2_SHIFT;
  if (cm0_vers < (__LAST_COMPATIBLE_CM0_RELEASE >> __APP_VERSION_SUB2_SHIFT))
  {
    ret = -4; /* version incompatibility */
  }
  if (ret >= 0)
  {
    ret = MBMUX_RegisterFeature(FEAT_INFO_SIGFOX_ID, MBMUX_CMD_RESP, MBMUXIF_IsrSigfoxRespRcvCb, aSigfoxCmdRespBuff, sizeof(aSigfoxCmdRespBuff));
  }
  if (ret >= 0)
  {
    ret = MBMUX_RegisterFeature(FEAT_INFO_SIGFOX_ID, MBMUX_NOTIF_ACK, MBMUXIF_IsrSigfoxNotifRcvCb, aSigfoxNotifAckBuff, sizeof(aSigfoxNotifAckBuff));
  }
  if (ret >= 0)
  {
[#if !FREERTOS??][#-- If FreeRtos is not used --]
    UTIL_SEQ_RegTask(1 << CFG_SEQ_Task_MbSigfoxNotifRcv, UTIL_SEQ_RFU, MBMUXIF_TaskSigfoxNotifRcv);
[#else]
    Thd_SigfoxNotifRcvProcessId = osThreadNew(Thd_SigfoxNotifRcvProcess, NULL, &Thd_SigfoxNotifRcvProcess_attr);
[/#if]
    ret = MBMUXIF_SystemSendCm0plusRegistrationCmd(FEAT_INFO_SIGFOX_ID);
    if (ret < 0)
    {
      ret = -3;
    }
  }

  if (ret >= 0)
  {
    ret = 0;
  }

  /* USER CODE BEGIN MBMUXIF_SigfoxInit_Last */

  /* USER CODE END MBMUXIF_SigfoxInit_Last */

  return ret;
}

MBMUX_ComParam_t *MBMUXIF_GetSigfoxFeatureCmdComPtr(void)
{
  /* USER CODE BEGIN MBMUXIF_GetSigfoxFeatureCmdComPtr_1 */

  /* USER CODE END MBMUXIF_GetSigfoxFeatureCmdComPtr_1 */
  MBMUX_ComParam_t *com_param_ptr = MBMUX_GetFeatureComPtr(FEAT_INFO_SIGFOX_ID, MBMUX_CMD_RESP);
  if (com_param_ptr == NULL)
  {
    Error_Handler(); /* feature isn't registered */
  }
  return com_param_ptr;
  /* USER CODE BEGIN MBMUXIF_GetSigfoxFeatureCmdComPtr_Last */

  /* USER CODE END MBMUXIF_GetSigfoxFeatureCmdComPtr_Last */
}

void MBMUXIF_SigfoxSendCmd(void)
{
  /* USER CODE BEGIN MBMUXIF_SigfoxSendCmd_1 */

  /* USER CODE END MBMUXIF_SigfoxSendCmd_1 */
  if (MBMUX_CommandSnd(FEAT_INFO_SIGFOX_ID) == 0)
  {
[#if !FREERTOS??][#-- If FreeRtos is not used --]
    UTIL_SEQ_WaitEvt(1 << CFG_SEQ_Evt_MbSigfoxRespRcv);
[#else]
    osSemaphoreAcquire(Sem_MbSigfoxRespRcv, osWaitForever);
[/#if]
  }
  else
  {
    Error_Handler();
  }
  /* USER CODE BEGIN MBMUXIF_SigfoxSendCmd_Last */

  /* USER CODE END MBMUXIF_SigfoxSendCmd_Last */
}

void MBMUXIF_SigfoxSendAck(void)
{
  /* USER CODE BEGIN MBMUXIF_SigfoxSendAck_1 */

  /* USER CODE END MBMUXIF_SigfoxSendAck_1 */
  if (MBMUX_AcknowledgeSnd(FEAT_INFO_SIGFOX_ID) != 0)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN MBMUXIF_SigfoxSendAck_Last */

  /* USER CODE END MBMUXIF_SigfoxSendAck_Last */
}

/* USER CODE BEGIN EFD */

/* USER CODE END EFD */

/* Private functions ---------------------------------------------------------*/
static void MBMUXIF_IsrSigfoxRespRcvCb(void *ComObj)
{
  /* USER CODE BEGIN MBMUXIF_IsrSigfoxRespRcvCb_1 */

  /* USER CODE END MBMUXIF_IsrSigfoxRespRcvCb_1 */
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_SetEvt(1 << CFG_SEQ_Evt_MbSigfoxRespRcv);
[#else]
  osSemaphoreRelease(Sem_MbSigfoxRespRcv);
[/#if]
  /* USER CODE BEGIN MBMUXIF_IsrSigfoxRespRcvCb_Last */

  /* USER CODE END MBMUXIF_IsrSigfoxRespRcvCb_Last */
}

static void MBMUXIF_IsrSigfoxNotifRcvCb(void *ComObj)
{
  /* USER CODE BEGIN MBMUXIF_IsrSigfoxNotifRcvCb_1 */

  /* USER CODE END MBMUXIF_IsrSigfoxNotifRcvCb_1 */
  SigfoxComObj = (MBMUX_ComParam_t *) ComObj;
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_SetTask(1 << CFG_SEQ_Task_MbSigfoxNotifRcv, CFG_SEQ_Prio_0);
[#else]
  osThreadFlagsSet(Thd_SigfoxNotifRcvProcessId, 1);
[/#if]
  /* USER CODE BEGIN MBMUXIF_IsrSigfoxNotifRcvCb_Last */

  /* USER CODE END MBMUXIF_IsrSigfoxNotifRcvCb_Last */
}

static void MBMUXIF_TaskSigfoxNotifRcv(void)
{
  /* USER CODE BEGIN MBMUXIF_TaskSigfoxNotifRcv_1 */

  /* USER CODE END MBMUXIF_TaskSigfoxNotifRcv_1 */
  Process_Sigfox_Notif(SigfoxComObj);
  /* USER CODE BEGIN MBMUXIF_TaskSigfoxNotifRcv_Last */

  /* USER CODE END MBMUXIF_TaskSigfoxNotifRcv_Last */
}
[#if FREERTOS??][#-- If FreeRtos is used --]

static void Thd_SigfoxNotifRcvProcess(void *argument)
{
  /* USER CODE BEGIN Thd_SigfoxNotifRcvProcess_1 */

  /* USER CODE END Thd_SigfoxNotifRcvProcess_1 */
  UNUSED(argument);
  for (;;)
  {
    osThreadFlagsWait(1, osFlagsWaitAny, osWaitForever);
    MBMUXIF_TaskSigfoxNotifRcv();  /*what you want to do*/
  }
  /* USER CODE BEGIN Thd_SigfoxNotifRcvProcess_Last */

  /* USER CODE END Thd_SigfoxNotifRcvProcess_Last */
}
[/#if]

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
