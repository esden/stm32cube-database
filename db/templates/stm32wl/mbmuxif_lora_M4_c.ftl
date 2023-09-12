[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    mbmuxif_lora.c
  * @author  MCD Application Team
  * @brief   allows CM4 application to register and handle LoraWAN via MBMUX
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
#include "mbmuxif_lora.h"
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
#include "LoRaMac.h"
#include "LmHandler_mbwrapper.h"
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
static MBMUX_ComParam_t *LoraComObj;
[#if FREERTOS??][#-- If FreeRtos is used --]
static osSemaphoreId_t Sem_MbLoRaRespRcv;
osThreadId_t Thd_LoraNotifRcvProcessId;
[/#if]
[#if THREADX??]
static __IO uint8_t Thd_LoraNotifRcv_RescheduleFlag = 0;
static TX_THREAD Thd_LoraNotifRcv;
static TX_SEMAPHORE Sem_MbLoraRespRcv;
[/#if]

/**
  * @brief LoRa cmd buffer to exchange data between CM4 and CM0+
  */
UTIL_MEM_PLACE_IN_SECTION("MB_MEM1") uint32_t aLoraCmdRespBuff[MAX_PARAM_OF_LORAWAN_CMD_FUNCTIONS];/*shared*/

/**
  * @brief LoRa notif buffer to exchange data between CM4 and CM0+
  */
UTIL_MEM_PLACE_IN_SECTION("MB_MEM1") uint32_t aLoraNotifAckBuff[MAX_PARAM_OF_LORAWAN_NOTIF_FUNCTIONS];/*shared*/

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/**
  * @brief   LORA response callbacks: set event to release waiting task
  * @param   ComObj pointer to the LORA com param buffer
  */
static void MBMUXIF_IsrLoraRespRcvCb(void *ComObj);

/**
  * @brief   LORA notification callbacks: schedules a task in order to quit the ISR
  * @param   ComObj pointer to the LORA com param buffer
  */
static void MBMUXIF_IsrLoraNotifRcvCb(void *ComObj);

/**
  * @brief   LORA task to process the notification
  */
static void MBMUXIF_TaskLoraNotifRcv(void);

[#if FREERTOS??][#-- If FreeRtos is used --]
const osThreadAttr_t Thd_LoraNotifRcvProcess_attr =
{
  .name = CFG_MB_LORA_PROCESS_NAME,
  .attr_bits = CFG_MB_LORA_PROCESS_ATTR_BITS,
  .cb_mem = CFG_MB_LORA_PROCESS_CB_MEM,
  .cb_size = CFG_MB_LORA_PROCESS_CB_SIZE,
  .stack_mem = CFG_MB_LORA_PROCESS_STACK_MEM,
  .priority = CFG_MB_LORA_PROCESS_PRIORITY,
  .stack_size = CFG_MB_LORA_PROCESS_STACK_SIZE
};
/**
  * @brief  FreeRTOS process when receiving MailBox Lora Notification .
  */
static void Thd_LoraNotifRcvProcess(void *argument);
[/#if]
[#if THREADX??]
/**
  * @brief  Entry point for the thread when receiving MailBox Lora Notification .
  * @param  thread_input: Not used
  */
static void Thd_MbLoraNotifRcv_Entry(unsigned long thread_input);
[/#if]
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/
int8_t MBMUXIF_LoraInit(void)
{
  FEAT_INFO_Param_t *p_cm0plus_system_info;
  int32_t cm0_vers = 0;
  int8_t ret = 0;

  /* USER CODE BEGIN MBMUXIF_LoraInit_1 */

  /* USER CODE END MBMUXIF_LoraInit_1 */

  p_cm0plus_system_info = MBMUXIF_SystemGetFeatCapabInfoPtr(FEAT_INFO_SYSTEM_ID);
  /* abstract CM0 release version from RC (release candidate) and compare */
  cm0_vers = p_cm0plus_system_info->Feat_Info_Feature_Version >> APP_VERSION_SUB2_SHIFT;
  if (cm0_vers < (LAST_COMPATIBLE_CM0_RELEASE >> APP_VERSION_SUB2_SHIFT))
  {
    ret = -4; /* version incompatibility */
  }
  if (ret >= 0)
  {
    ret = MBMUX_RegisterFeature(FEAT_INFO_LORAWAN_ID, MBMUX_CMD_RESP,
                                MBMUXIF_IsrLoraRespRcvCb,
                                aLoraCmdRespBuff, sizeof(aLoraCmdRespBuff));
  }
  if (ret >= 0)
  {
    ret = MBMUX_RegisterFeature(FEAT_INFO_LORAWAN_ID, MBMUX_NOTIF_ACK,
                                MBMUXIF_IsrLoraNotifRcvCb,
                                aLoraNotifAckBuff, sizeof(aLoraNotifAckBuff));
  }

[#if THREADX??]
  if (ret >= 0)
  {
    /* Allocate the stack for MbLoraNotifRcv.  */
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
    /* Create MbLoraNotifRcv.  */
    if (tx_thread_create(&Thd_LoraNotifRcv, "Thread MbLoraNotifRcv", Thd_MbLoraNotifRcv_Entry, 0,
                         pointer, CFG_MAILBOX_THREAD_STACK_SIZE,
                         CFG_MAILBOX_THREAD_PRIO, CFG_MAILBOX_THREAD_PREEMPTION_THRESHOLD,
                         TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
    {
      ret = -11;  /* equivalent at TX_THREAD_ERROR */
    }
[#elseif FREERTOS??][#-- If FreeRtos is used --]
    Thd_LoraNotifRcvProcessId = osThreadNew(Thd_LoraNotifRcvProcess, NULL, &Thd_LoraNotifRcvProcess_attr);
[#elseif UTIL_SEQ_EN_M4 == "true"]
    UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_MbLoRaNotifRcv), UTIL_SEQ_RFU, MBMUXIF_TaskLoraNotifRcv);
[#else]
  /* USER CODE BEGIN MBMUXIF_LoraInit_OS */

  /* USER CODE END MBMUXIF_LoraInit_OS */
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
  }

  if (ret >= 0)
  {
    ret = MBMUXIF_SystemSendCm0plusRegistrationCmd(FEAT_INFO_LORAWAN_ID);
    if (ret < 0)
    {
      ret = -3;
    }
  }

[#if THREADX??]
  if (ret >= 0)
  {
    /* Create the semaphore.  */
    if (tx_semaphore_create(&Sem_MbLoraRespRcv, "Sem_MbLoraRespRcv", 0) != TX_SUCCESS)
    {
      ret = -12; /* equivalent at TX_SEMAPHORE_ERROR */
    }
  }
[#elseif FREERTOS??][#-- If FreeRtos is used --]
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

MBMUX_ComParam_t *MBMUXIF_GetLoraFeatureCmdComPtr(void)
{
  /* USER CODE BEGIN MBMUXIF_GetLoraFeatureCmdComPtr_1 */

  /* USER CODE END MBMUXIF_GetLoraFeatureCmdComPtr_1 */
  MBMUX_ComParam_t *com_param_ptr = MBMUX_GetFeatureComPtr(FEAT_INFO_LORAWAN_ID, MBMUX_CMD_RESP);
  if (com_param_ptr == NULL)
  {
    Error_Handler(); /* feature isn't registered */
  }
  return com_param_ptr;
  /* USER CODE BEGIN MBMUXIF_GetLoraFeatureCmdComPtr_Last */

  /* USER CODE END MBMUXIF_GetLoraFeatureCmdComPtr_Last */
}

void MBMUXIF_LoraSendCmd(void)
{
  /* USER CODE BEGIN MBMUXIF_LoraSendCmd_1 */

  /* USER CODE END MBMUXIF_LoraSendCmd_1 */
  if (MBMUX_CommandSnd(FEAT_INFO_LORAWAN_ID) == 0)
  {
[#if THREADX??][#-- If AzRtos is used --]
    while (tx_semaphore_get(&Sem_MbLoraRespRcv, TX_WAIT_FOREVER) != TX_SUCCESS) {}
[#elseif FREERTOS??][#-- If FreeRtos is used --]
    osSemaphoreAcquire(Sem_MbLoRaRespRcv, osWaitForever);
[#elseif UTIL_SEQ_EN_M4 == "true"]
    UTIL_SEQ_WaitEvt(1 << CFG_SEQ_Evt_MbLoRaRespRcv);
[#else]
    /* USER CODE BEGIN MBMUXIF_LoraSendCmd_OS */

    /* USER CODE END MBMUXIF_LoraSendCmd_OS */
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
  }
  else
  {
    Error_Handler();
  }
  /* USER CODE BEGIN MBMUXIF_LoraSendCmd_Last */

  /* USER CODE END MBMUXIF_LoraSendCmd_Last */
}

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
static void MBMUXIF_IsrLoraRespRcvCb(void *ComObj)
{
  /* USER CODE BEGIN MBMUXIF_IsrLoraRespRcvCb_1 */

  /* USER CODE END MBMUXIF_IsrLoraRespRcvCb_1 */
[#if THREADX??][#-- If AzRtos is used --]
  /* Set the semaphore to release the MbLoraRespRcv thread */
  tx_semaphore_put(&Sem_MbLoraRespRcv);
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  osSemaphoreRelease(Sem_MbLoRaRespRcv);
[#elseif UTIL_SEQ_EN_M4 == "true"]
  UTIL_SEQ_SetEvt(1 << CFG_SEQ_Evt_MbLoRaRespRcv);
[#else]
  /* USER CODE BEGIN MBMUXIF_IsrLoraRespRcvCb_OS */

  /* USER CODE END MBMUXIF_IsrLoraRespRcvCb_OS */
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
  /* USER CODE BEGIN MBMUXIF_IsrLoraRespRcvCb_Last */

  /* USER CODE END MBMUXIF_IsrLoraRespRcvCb_Last */
}

static void MBMUXIF_IsrLoraNotifRcvCb(void *ComObj)
{
  /* USER CODE BEGIN MBMUXIF_IsrLoraNotifRcvCb_1 */

  /* USER CODE END MBMUXIF_IsrLoraNotifRcvCb_1 */
  LoraComObj = (MBMUX_ComParam_t *) ComObj;
[#if THREADX??][#-- If AzRtos is used --]
  if (Thd_LoraNotifRcv_RescheduleFlag < 255)
  {
    Thd_LoraNotifRcv_RescheduleFlag++;
  }
  tx_thread_resume(&Thd_LoraNotifRcv);
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  osThreadFlagsSet(Thd_LoraNotifRcvProcessId, 1);
[#elseif UTIL_SEQ_EN_M4 == "true"]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_MbLoRaNotifRcv), CFG_SEQ_Prio_0);
[#else]
  /* USER CODE BEGIN MBMUXIF_IsrLoraNotifRcvCb_OS */

  /* USER CODE END MBMUXIF_IsrLoraNotifRcvCb_OS */
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
  /* USER CODE BEGIN MBMUXIF_IsrLoraNotifRcvCb_Last */

  /* USER CODE END MBMUXIF_IsrLoraNotifRcvCb_Last */
}

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
  /* Following USER CODE SECTION will be never reached */
  /* it can be use for compilation flag like #else or #endif */
  /* USER CODE BEGIN Thd_LoraNotifRcvProcess_Last */

  /* USER CODE END Thd_LoraNotifRcvProcess_Last */
}
[/#if]
[#if THREADX??][#-- If AzRtos is used --]

static void Thd_MbLoraNotifRcv_Entry(ULONG thread_input)
{
  (void) thread_input;
  /* USER CODE BEGIN Thd_MbLoraNotifRcv_Entry_1 */

  /* USER CODE END Thd_MbLoraNotifRcv_Entry_1 */
  /* Infinite loop */
  for (;;)
  {
    if (Thd_LoraNotifRcv_RescheduleFlag > 0)
    {
      /* if RescheduleFlag was set during MBMUXIF_TaskLoraNotifRcv() don't suspend  */
      Thd_LoraNotifRcv_RescheduleFlag--;
    }
    else
    {
      tx_thread_suspend(&Thd_LoraNotifRcv);
      /* if RescheduleFlag was set during suspend it should be reset */
      Thd_LoraNotifRcv_RescheduleFlag = 0;
    }
    MBMUXIF_TaskLoraNotifRcv();  /*what you want to do*/
    /* USER CODE BEGIN Thd_MbLoraNotifRcv_Entry_2 */

    /* USER CODE END Thd_MbLoraNotifRcv_Entry_2 */
  }
  /* Following USER CODE SECTION will be never reached */
  /* it can be use for compilation flag like #else or #endif */
  /* USER CODE BEGIN Thd_MbLoraNotifRcv_Entry_Last */

  /* USER CODE END Thd_MbLoraNotifRcv_Entry_Last */
}
[/#if]

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
