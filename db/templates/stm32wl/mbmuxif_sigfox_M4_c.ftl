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
#include "mbmuxif_sigfox.h"
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
#include "sigfox_mbwrapper.h"
#include "app_version.h"
#include "utilities_def.h"
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
static MBMUX_ComParam_t *SigfoxComObj;

UTIL_MEM_PLACE_IN_SECTION("MB_MEM1") uint32_t aSigfoxCmdRespBuff[MAX_PARAM_OF_SIGFOX_CMD_FUNCTIONS];/*shared*/
UTIL_MEM_PLACE_IN_SECTION("MB_MEM1") uint32_t aSigfoxNotifAckBuff[MAX_PARAM_OF_SIGFOX_NOTIF_FUNCTIONS];/*shared*/

[#if THREADX??]
static __IO uint8_t Thd_SigfoxNotifRcv_RescheduleFlag = 0;
static TX_THREAD Thd_SigfoxNotifRcv;
static TX_SEMAPHORE Sem_MbSigfoxRespRcv;
[/#if]
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
  .stack_size = CFG_MB_SIGFOX_PROCESS_STACK_SIZE
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

[#if THREADX??]
/**
  * @brief  Entry point for the thread when receiving MailBox Sigfox Notification .
  * @param  thread_input: Not used
  */
static void Thd_MbSigfoxNotifRcv_Entry(unsigned long thread_input);
[/#if]
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
  cm0_vers = p_cm0plus_system_info->Feat_Info_Feature_Version >> APP_VERSION_SUB2_SHIFT;
  if (cm0_vers < (LAST_COMPATIBLE_CM0_RELEASE >> APP_VERSION_SUB2_SHIFT))
  {
    ret = -4; /* version incompatibility */
  }
  if (ret >= 0)
  {
    ret = MBMUX_RegisterFeature(FEAT_INFO_SIGFOX_ID, MBMUX_CMD_RESP,
                                MBMUXIF_IsrSigfoxRespRcvCb,
                                aSigfoxCmdRespBuff, sizeof(aSigfoxCmdRespBuff));
  }
  if (ret >= 0)
  {
    ret = MBMUX_RegisterFeature(FEAT_INFO_SIGFOX_ID, MBMUX_NOTIF_ACK,
                                MBMUXIF_IsrSigfoxNotifRcvCb,
                                aSigfoxNotifAckBuff, sizeof(aSigfoxNotifAckBuff));
  }
[#if THREADX??]
  if (ret >= 0)
  {
    /* Allocate the stack for MbSigfoxNotifRcv.  */
    if (tx_byte_allocate(byte_pool, (VOID **) &pointer,
                         CFG_MAILBOX_THREAD_STACK_SIZE, TX_NO_WAIT) != TX_SUCCESS)
    {
      ret = -10; /* equivalent at TX_POOL_ERROR */
    }
  }
[/#if][#--  THREADX --]
  if (ret >= 0)
  {
[#if THREADX??]
    /* Create MbSigfoxNotifRcv.  */
    if (tx_thread_create(&Thd_SigfoxNotifRcv, "Thread MbSigfoxNotifRcv", Thd_MbSigfoxNotifRcv_Entry, 0,
                         pointer, CFG_MAILBOX_THREAD_STACK_SIZE,
                         CFG_MAILBOX_THREAD_PRIO, CFG_MAILBOX_THREAD_PREEMPTION_THRESHOLD,
                         TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
    {
      ret = -11;  /* equivalent at TX_THREAD_ERROR */
    }
[#elseif FREERTOS??][#-- If FreeRtos is used --]
    Thd_SigfoxNotifRcvProcessId = osThreadNew(Thd_SigfoxNotifRcvProcess, NULL, &Thd_SigfoxNotifRcvProcess_attr);
[#elseif UTIL_SEQ_EN_M4 == "true"]
    UTIL_SEQ_RegTask(1 << CFG_SEQ_Task_MbSigfoxNotifRcv, UTIL_SEQ_RFU, MBMUXIF_TaskSigfoxNotifRcv);
[#else]
  /* USER CODE BEGIN MBMUXIF_SigfoxInit_OS */

  /* USER CODE END MBMUXIF_SigfoxInit_OS */
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
  }

  if (ret >= 0)
  {
    ret = MBMUXIF_SystemSendCm0plusRegistrationCmd(FEAT_INFO_SIGFOX_ID);
    if (ret < 0)
    {
      ret = -3;
    }
  }

[#if FREERTOS??][#-- If FreeRtos is used --]
  Sem_MbSigfoxRespRcv = osSemaphoreNew(1, 0, NULL);   /*< Create the semaphore and make it busy at initialization */
[/#if]
[#if THREADX??]
  if (ret >= 0)
  {
    /* Create the semaphore.  */
    if (tx_semaphore_create(&Sem_MbSigfoxRespRcv, "Sem_MbSigfoxRespRcv", 0) != TX_SUCCESS)
    {
      ret = -12; /* equivalent at TX_SEMAPHORE_ERROR */
    }
  }
[/#if]

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
[#if THREADX??][#-- If AzRtos is used --]
    while (tx_semaphore_get(&Sem_MbSigfoxRespRcv, TX_WAIT_FOREVER) != TX_SUCCESS) {}
[#elseif FREERTOS??][#-- If FreeRtos is used --]
    osSemaphoreAcquire(Sem_MbSigfoxRespRcv, osWaitForever);
[#elseif UTIL_SEQ_EN_M4 == "true"]
    UTIL_SEQ_WaitEvt(1 << CFG_SEQ_Evt_MbSigfoxRespRcv);
[#else]
    /* USER CODE BEGIN MBMUXIF_SigfoxSendCmd_OS */

    /* USER CODE END MBMUXIF_SigfoxSendCmd_OS */
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
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
[#if THREADX??][#-- If AzRtos is used --]
  /* Set the semaphore to release the Sem_MbSigfoxRespRcv Thread */
  tx_semaphore_put(&Sem_MbSigfoxRespRcv);
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  osSemaphoreRelease(Sem_MbSigfoxRespRcv);
[#elseif UTIL_SEQ_EN_M4 == "true"]
  UTIL_SEQ_SetEvt(1 << CFG_SEQ_Evt_MbSigfoxRespRcv);
[#else]
  /* USER CODE BEGIN MBMUXIF_IsrSigfoxRespRcvCb_OS */

  /* USER CODE END MBMUXIF_IsrSigfoxRespRcvCb_OS */
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
  /* USER CODE BEGIN MBMUXIF_IsrSigfoxRespRcvCb_Last */

  /* USER CODE END MBMUXIF_IsrSigfoxRespRcvCb_Last */
}

static void MBMUXIF_IsrSigfoxNotifRcvCb(void *ComObj)
{
  /* USER CODE BEGIN MBMUXIF_IsrSigfoxNotifRcvCb_1 */

  /* USER CODE END MBMUXIF_IsrSigfoxNotifRcvCb_1 */
  SigfoxComObj = (MBMUX_ComParam_t *) ComObj;
[#if THREADX??][#-- If AzRtos is used --]
  if (Thd_SigfoxNotifRcv_RescheduleFlag < 255)
  {
    Thd_SigfoxNotifRcv_RescheduleFlag++;
  }
  tx_thread_resume(&Thd_SigfoxNotifRcv);
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  osThreadFlagsSet(Thd_SigfoxNotifRcvProcessId, 1);
[#elseif UTIL_SEQ_EN_M4 == "true"]
  UTIL_SEQ_SetTask(1 << CFG_SEQ_Task_MbSigfoxNotifRcv, CFG_SEQ_Prio_0);
[#else]
  /* USER CODE BEGIN MBMUXIF_IsrSigfoxNotifRcvCb_OS */

  /* USER CODE END MBMUXIF_IsrSigfoxNotifRcvCb_OS */
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
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
  /* Following USER CODE SECTION will be never reached */
  /* it can be use for compilation flag like #else or #endif */
  /* USER CODE BEGIN Thd_SigfoxNotifRcvProcess_Last */

  /* USER CODE END Thd_SigfoxNotifRcvProcess_Last */
}
[/#if]
[#if THREADX??][#-- If AzRtos is used --]

static void Thd_MbSigfoxNotifRcv_Entry(ULONG thread_input)
{
  (void) thread_input;
  /* USER CODE BEGIN Thd_MbSigfoxNotifRcv_Entry_1 */

  /* USER CODE END Thd_MbSigfoxNotifRcv_Entry_1 */
  /* Infinite loop */
  for (;;)
  {
    if (Thd_SigfoxNotifRcv_RescheduleFlag > 0)
    {
      /* if RescheduleFlag was set during MBMUXIF_TaskSigfoxNotifRcv() don't suspend  */
      Thd_SigfoxNotifRcv_RescheduleFlag--;
    }
    else
    {
      tx_thread_suspend(&Thd_SigfoxNotifRcv);
      /* if RescheduleFlag was set during suspend it should be reset */
      Thd_SigfoxNotifRcv_RescheduleFlag = 0;
    }
    MBMUXIF_TaskSigfoxNotifRcv();  /*what you want to do*/
    /* USER CODE BEGIN Thd_MbSigfoxNotifRcv_Entry_2 */

    /* USER CODE END Thd_MbSigfoxNotifRcv_Entry_2 */
  }
  /* Following USER CODE SECTION will be never reached */
  /* it can be use for compilation flag like #else or #endif */
  /* USER CODE BEGIN Thd_MbSigfoxNotifRcv_Entry_Last */

  /* USER CODE END Thd_MbSigfoxNotifRcv_Entry_Last */
}
[/#if]

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
