[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    mbmuxif_radio.c
  * @author  MCD Application Team
  * @brief   allows CM4 application to register and handle RADIO driver via MBMUX
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign UTIL_SEQ_EN_M4 = "true"]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "UTIL_SEQ_EN_M4"]
                    [#assign UTIL_SEQ_EN_M4 = definition.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]

/* Includes ------------------------------------------------------------------*/
#include "platform.h"
#include "mbmuxif_radio.h"
#include "mbmuxif_sys.h"
#include "sys_app.h"
#include "stm32_mem.h"
[#if THREADX??][#-- If AzRtos is used --]
#include "app_azure_rtos.h"
#include "tx_api.h"
[#elseif FREERTOS??][#-- If FreeRtos is used --]
#include "cmsis_os.h"
[#elseif UTIL_SEQ_EN_M4 == "true"]
#include "stm32_seq.h"
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
#include "radio_mbwrapper.h"
#include "utilities_def.h"
#include "app_version.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
[#if THREADX??]
extern  TX_BYTE_POOL *byte_pool;
extern  CHAR *pointer;
[/#if]
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
[#if FREERTOS??][#-- If FreeRtos is used --]
static osSemaphoreId_t Sem_MbRadioRespRcv;
osThreadId_t Thd_RadioNotifRcvProcessId;
[/#if]
[#if THREADX??]
static __IO uint8_t Thd_RadioNotifRcv_RescheduleFlag = 0;
static TX_THREAD Thd_RadioNotifRcv;
static TX_SEMAPHORE Sem_MbRadioRespRcv;
[/#if]

/**
  * @brief radio cmd buffer to exchange data between CM4 and CM0+
  */
UTIL_MEM_PLACE_IN_SECTION("MB_MEM1") uint32_t aRadioCmdRespBuff[MAX_PARAM_OF_RADIO_CMD_FUNCTIONS];/*shared*/

/**
  * @brief radio notif buffer to exchange data between CM4 and CM0+
  */
UTIL_MEM_PLACE_IN_SECTION("MB_MEM1") uint32_t aRadioNotifAckBuff[MAX_PARAM_OF_RADIO_NOTIF_FUNCTIONS];/*shared*/

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/**
  * @brief   RADIO response callbacks: set event to release waiting task
  * @param   ComObj pointer to the RADIO com param buffer
  */
static void MBMUXIF_IsrRadioRespRcvCb(void *ComObj);

/**
  * @brief   RADIO notification callbacks: schedules a task in order to quit the ISR
  * @param   ComObj pointer to the RADIO com param buffer
  */
static void MBMUXIF_IsrRadioNotifRcvCb(void *ComObj);

/**
  * @brief  RADIO task to process the notification
  */
static void MBMUXIF_TaskRadioNotifRcv(void);

[#if FREERTOS??][#-- If FreeRtos is used --]
const osThreadAttr_t Thd_RadioNotifRcvProcess_attr =
{
  .name = CFG_MB_RADIO_PROCESS_NAME,
  .attr_bits = CFG_MB_RADIO_PROCESS_ATTR_BITS,
  .cb_mem = CFG_MB_RADIO_PROCESS_CB_MEM,
  .cb_size = CFG_MB_RADIO_PROCESS_CB_SIZE,
  .stack_mem = CFG_MB_RADIO_PROCESS_STACK_MEM,
  .priority = CFG_MB_RADIO_PROCESS_PRIORITY,
  .stack_size = CFG_MB_RADIO_PROCESS_STACK_SIZE
};
/**
  * @brief  FreeRTOS process when receiving MailBox Radio Notification .
  */
static void Thd_RadioNotifRcvProcess(void *argument);

[/#if]
[#if THREADX??]
/**
  * @brief  Entry point for the thread when receiving MailBox Radio Notification .
  * @param  thread_input: Not used
  */
static void Thd_MbRadioNotifRcv_Entry(unsigned long thread_input);

[/#if]
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/
int8_t MBMUXIF_RadioInit(void)
{
  FEAT_INFO_Param_t *p_cm0plus_system_info;
  int32_t cm0_vers = 0;
  int8_t ret = 0;

  /* USER CODE BEGIN MBMUXIF_RadioInit_1 */

  /* USER CODE END MBMUXIF_RadioInit_1 */

  p_cm0plus_system_info = MBMUXIF_SystemGetFeatCapabInfoPtr(FEAT_INFO_SYSTEM_ID);
  /* abstract CM0 release version from RC (release candidate) and compare */
  cm0_vers = p_cm0plus_system_info->Feat_Info_Feature_Version >> APP_VERSION_SUB2_SHIFT;
  if (cm0_vers < (LAST_COMPATIBLE_CM0_RELEASE >> APP_VERSION_SUB2_SHIFT))
  {
    ret = -4; /* version incompatibility */
  }
  if (ret >= 0)
  {
    ret = MBMUX_RegisterFeature(FEAT_INFO_RADIO_ID, MBMUX_CMD_RESP,
                                MBMUXIF_IsrRadioRespRcvCb,
                                aRadioCmdRespBuff, sizeof(aRadioCmdRespBuff));
  }
  if (ret >= 0)
  {
    ret = MBMUX_RegisterFeature(FEAT_INFO_RADIO_ID, MBMUX_NOTIF_ACK,
                                MBMUXIF_IsrRadioNotifRcvCb,
                                aRadioNotifAckBuff, sizeof(aRadioNotifAckBuff));
  }

[#if THREADX??]
  if (ret >= 0)
  {
    /* Allocate the stack for MbRadioNotifRcv.  */
    if (tx_byte_allocate(byte_pool, (VOID **) &pointer,
                         CFG_MAILBOX_THREAD_STACK_SIZE, TX_NO_WAIT) != TX_SUCCESS)
    {
      ret = -10; /* equivalent at TX_POOL_ERROR */
    }
  }
  if (ret >= 0)
  {
    /* Create MbRadioNotifRcv.  */
    if (tx_thread_create(&Thd_RadioNotifRcv, "Thread MbRadioNotifRcv", Thd_MbRadioNotifRcv_Entry, 0,
                         pointer, CFG_MAILBOX_THREAD_STACK_SIZE,
                         CFG_MAILBOX_THREAD_PRIO, CFG_MAILBOX_THREAD_PREEMPTION_THRESHOLD,
                         TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
    {
      ret = -11;  /* equivalent at TX_THREAD_ERROR */
    }
  }
[/#if][#--  THREADX --]
  if (ret >= 0)
  {
[#if THREADX??]
    /* Create the semaphore.  */
    if (tx_semaphore_create(&Sem_MbRadioRespRcv, "Sem_MbRadioRespRcv", 0) != TX_SUCCESS)
    {
      ret = -12; /* equivalent at TX_SEMAPHORE_ERROR */
    }
[#elseif FREERTOS??][#-- If FreeRtos is used --]
    Thd_RadioNotifRcvProcessId = osThreadNew(Thd_RadioNotifRcvProcess, NULL, &Thd_RadioNotifRcvProcess_attr);
    Sem_MbRadioRespRcv = osSemaphoreNew(1, 0, NULL);   /*< Create the semaphore and make it busy at initialization */
[#elseif UTIL_SEQ_EN_M4 == "true"]
    UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_MbRadioNotifRcv), UTIL_SEQ_RFU, MBMUXIF_TaskRadioNotifRcv);
[#else]
  /* USER CODE BEGIN MBMUXIF_RadioInit_OS */

  /* USER CODE END MBMUXIF_RadioInit_OS */
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
  }

  if (ret >= 0)
  {
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

MBMUX_ComParam_t *MBMUXIF_GetRadioFeatureCmdComPtr(void)
{
  /* USER CODE BEGIN MBMUXIF_GetRadioFeatureCmdComPtr_1 */

  /* USER CODE END MBMUXIF_GetRadioFeatureCmdComPtr_1 */
  MBMUX_ComParam_t *com_param_ptr = MBMUX_GetFeatureComPtr(FEAT_INFO_RADIO_ID, MBMUX_CMD_RESP);
  if (com_param_ptr == NULL)
  {
    Error_Handler(); /* feature isn't registered */
  }
  return com_param_ptr;
  /* USER CODE BEGIN MBMUXIF_GetRadioFeatureCmdComPtr_Last */

  /* USER CODE END MBMUXIF_GetRadioFeatureCmdComPtr_Last */
}

void MBMUXIF_RadioSendCmd(void)
{
  /* USER CODE BEGIN MBMUXIF_RadioSendCmd_1 */

  /* USER CODE END MBMUXIF_RadioSendCmd_1 */
  if (MBMUX_CommandSnd(FEAT_INFO_RADIO_ID) == 0)
  {
[#if THREADX??][#-- If AzRtos is used --]
    while (tx_semaphore_get(&Sem_MbRadioRespRcv, TX_WAIT_FOREVER) != TX_SUCCESS) {}
[#elseif FREERTOS??][#-- If FreeRtos is used --]
    osSemaphoreAcquire(Sem_MbRadioRespRcv, osWaitForever);
[#elseif UTIL_SEQ_EN_M4 == "true"]
    UTIL_SEQ_WaitEvt(1 << CFG_SEQ_Evt_MbRadioRespRcv);
[#else]
    /* USER CODE BEGIN MBMUXIF_RadioSendCmd_OS */

    /* USER CODE END MBMUXIF_RadioSendCmd_OS */
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
  }
  else
  {
    Error_Handler();
  }
  /* USER CODE BEGIN MBMUXIF_RadioSendCmd_Last */

  /* USER CODE END MBMUXIF_RadioSendCmd_Last */
}

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
static void MBMUXIF_IsrRadioRespRcvCb(void *ComObj)
{
  /* USER CODE BEGIN MBMUXIF_IsrRadioRespRcvCb_1 */

  /* USER CODE END MBMUXIF_IsrRadioRespRcvCb_1 */
[#if THREADX??][#-- If AzRtos is used --]
  /* Set the semaphore to release the Sem_MbRadioRespRcv Thread */
  tx_semaphore_put(&Sem_MbRadioRespRcv);
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  osSemaphoreRelease(Sem_MbRadioRespRcv);
[#elseif UTIL_SEQ_EN_M4 == "true"]
  UTIL_SEQ_SetEvt(1 << CFG_SEQ_Evt_MbRadioRespRcv);
[#else]
  /* USER CODE BEGIN MBMUXIF_IsrRadioRespRcvCb_OS */

  /* USER CODE END MBMUXIF_IsrRadioRespRcvCb_OS */
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
  /* USER CODE BEGIN MBMUXIF_IsrRadioRespRcvCb_Last */

  /* USER CODE END MBMUXIF_IsrRadioRespRcvCb_Last */
}

static void MBMUXIF_IsrRadioNotifRcvCb(void *ComObj)
{
  /* USER CODE BEGIN MBMUXIF_IsrRadioNotifRcvCb_1 */

  /* USER CODE END MBMUXIF_IsrRadioNotifRcvCb_1 */
  RadioComObj = (MBMUX_ComParam_t *) ComObj;
[#if THREADX??][#-- If AzRtos is used --]
  if (Thd_RadioNotifRcv_RescheduleFlag < 255)
  {
    Thd_RadioNotifRcv_RescheduleFlag++;
  }
  tx_thread_resume(&Thd_RadioNotifRcv);
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  osThreadFlagsSet(Thd_RadioNotifRcvProcessId, 1);
[#elseif UTIL_SEQ_EN_M4 == "true"]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_MbRadioNotifRcv), CFG_SEQ_Prio_0);
[#else]
  /* USER CODE BEGIN MBMUXIF_IsrRadioNotifRcvCb_OS */

  /* USER CODE END MBMUXIF_IsrRadioNotifRcvCb_OS */
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
  /* USER CODE BEGIN MBMUXIF_IsrRadioNotifRcvCb_Last */

  /* USER CODE END MBMUXIF_IsrRadioNotifRcvCb_Last */
}

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
  /* Following USER CODE SECTION will be never reached */
  /* it can be use for compilation flag like #else or #endif */
  /* USER CODE BEGIN Thd_RadioNotifRcvProcess_Last */

  /* USER CODE END Thd_RadioNotifRcvProcess_Last */
}
[/#if]
[#if THREADX??][#-- If AzRtos is used --]

static void Thd_MbRadioNotifRcv_Entry(ULONG thread_input)
{
  (void) thread_input;
  /* USER CODE BEGIN Thd_MbRadioNotifRcv_Entry_1 */

  /* USER CODE END Thd_MbRadioNotifRcv_Entry_1 */
  /* Infinite loop */
  for (;;)
  {
    if (Thd_RadioNotifRcv_RescheduleFlag > 0)
    {
      /* if RescheduleFlag was set during MBMUXIF_TaskRadioNotifRcv() don't suspend  */
      Thd_RadioNotifRcv_RescheduleFlag--;
    }
    else
    {
      tx_thread_suspend(&Thd_RadioNotifRcv);
      /* if RescheduleFlag was set during suspend it should be reset */
      Thd_RadioNotifRcv_RescheduleFlag = 0;
    }
    MBMUXIF_TaskRadioNotifRcv();  /*what you want to do*/
    /* USER CODE BEGIN Thd_MbRadioNotifRcv_Entry_2 */

    /* USER CODE END Thd_MbRadioNotifRcv_Entry_2 */
  }
  /* Following USER CODE SECTION will be never reached */
  /* it can be use for compilation flag like #else or #endif */
  /* USER CODE BEGIN Thd_MbRadioNotifRcv_Entry_Last */

  /* USER CODE END Thd_MbRadioNotifRcv_Entry_Last */
}
[/#if]

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
