[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_sigfox.c
  * @author  MCD Application Team
  * @brief   Application of the Sigfox Middleware
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#--
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                ${definition.name}: ${definition.value}
            [/#list]
        [/#if]
    [/#list]
[/#if]
--]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
[#assign SUBGHZ_APPLICATION = ""]
[#assign UTIL_SEQ_EN_M4 = "true"]
[#assign UTIL_SEQ_EN_M0 = "true"]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "SUBGHZ_APPLICATION"]
                    [#assign SUBGHZ_APPLICATION = definition.value]
                [/#if]
                [#if definition.name == "UTIL_SEQ_EN_M4"]
                    [#assign UTIL_SEQ_EN_M4 = definition.value]
                [/#if]
                [#if definition.name == "UTIL_SEQ_EN_M0"]
                    [#assign UTIL_SEQ_EN_M0 = definition.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]

/* Includes ------------------------------------------------------------------*/
#include "app_sigfox.h"
[#if (CPUCORE == "CM0PLUS")]
#include "radio.h"
[#else]
#include "sgfx_app.h"
[/#if]
#include "sys_app.h"
[#if THREADX??][#-- If AzRtos is used --]
#include "app_azure_rtos.h"
#include "tx_api.h"
[#elseif FREERTOS??][#-- If FreeRtos is used --]
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION") && (CPUCORE != "CM0PLUS")]
#include "cmsis_os.h"
[/#if]
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION"))]
#include "stm32_seq.h"
[/#if][#--  THREADX vs FREERTOS vs SEQ_EN_M4 or SEQ_EN_M0 --]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
[#if THREADX??]
TX_THREAD App_MainThread;
TX_BYTE_POOL *byte_pool;
CHAR *pointer;
[/#if]
[#if (CPUCORE == "CM0PLUS")]
extern RadioEvents_t RfApiRadioEvents;

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
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/
[#if !THREADX??][#-- If AzRtos is not used --]
void MX_Sigfox_Init(void)
{
  /* USER CODE BEGIN MX_Sigfox_Init_1 */

  /* USER CODE END MX_Sigfox_Init_1 */
  SystemApp_Init();
  /* USER CODE BEGIN MX_Sigfox_Init_1_1 */

  /* USER CODE END MX_Sigfox_Init_1_1 */
[#if (CPUCORE == "CM4") || (CPUCORE == "")]
  Sigfox_Init();
[#elseif (CPUCORE == "CM0PLUS")]
  Radio.Init(&RfApiRadioEvents);
[/#if]
  /* USER CODE BEGIN MX_Sigfox_Init_2 */

  /* USER CODE END MX_Sigfox_Init_2 */
}
[#else]
uint32_t MX_Sigfox_Init(void *memory_ptr)
{
  uint32_t ret = TX_SUCCESS;

  /* USER CODE BEGIN MX_Sigfox_Init_1 */

  /* USER CODE END MX_Sigfox_Init_1 */
  byte_pool = memory_ptr;

  /* Allocate the stack for App App_MainThread.  */
  if (tx_byte_allocate(byte_pool, (VOID **) &pointer,
                       CFG_APP_SIGFOX_THREAD_STACK_SIZE, TX_NO_WAIT) != TX_SUCCESS)
  {
    ret = TX_POOL_ERROR;
  }

  /* Create App_MainThread.  */
  if (ret == TX_SUCCESS)
  {
    if (tx_thread_create(&App_MainThread, "App Sigfox Main Thread", App_Main_Thread_Entry, 0,
                         pointer, CFG_APP_SIGFOX_THREAD_STACK_SIZE,
                         CFG_APP_SIGFOX_THREAD_PRIO, CFG_APP_SIGFOX_THREAD_PREEMPTION_THRESHOLD,
                         TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
    {
      ret = TX_THREAD_ERROR;
    }
  }

  /* USER CODE BEGIN MX_Sigfox_Init_Last */

  /* USER CODE END MX_Sigfox_Init_Last */
  return ret;
}
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]

[#if !FREERTOS??][#-- If FreeRtos, only available in CM4 is not used --]
[#if !THREADX??][#-- If AzRtos is not used --]
void MX_Sigfox_Process(void)
{
  /* USER CODE BEGIN MX_Sigfox_Process_1 */

  /* USER CODE END MX_Sigfox_Process_1 */
[#if ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION"))]
  UTIL_SEQ_Run(UTIL_SEQ_DEFAULT);
  /* USER CODE BEGIN MX_Sigfox_Process_2 */

  /* USER CODE END MX_Sigfox_Process_2 */
[#else]
  /* USER CODE BEGIN MX_Sigfox_Process_OS */

  /* USER CODE END MX_Sigfox_Process_OS */
[/#if][#--  UTIL_SEQ_EN_M0 or UTIL_SEQ_EN_M4 --]
}
[/#if]
[/#if]

/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
