[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_lorawan.c
  * @author  MCD Application Team
  * @brief   Application of the LRWAN Middleware
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
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "SUBGHZ_APPLICATION"]
                    [#assign SUBGHZ_APPLICATION = definition.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]

/* Includes ------------------------------------------------------------------*/
#include "app_lorawan.h"
#include "lora_app.h"
#include "sys_app.h"
[#if !FREERTOS??][#-- If FreeRtos is not used --]
[#if !THREADX??][#-- If AzRtos is not used --]
#include "stm32_seq.h"
[/#if]
[/#if]
[#if THREADX??]
#include "tx_api.h"
[/#if]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
[#if THREADX??]
TX_THREAD App_MainThread;
TX_BYTE_POOL *byte_pool;
CHAR *pointer;
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
void MX_LoRaWAN_Init(void)
{
  /* USER CODE BEGIN MX_LoRaWAN_Init_1 */

  /* USER CODE END MX_LoRaWAN_Init_1 */
  SystemApp_Init();
  /* USER CODE BEGIN MX_LoRaWAN_Init_2 */

  /* USER CODE END MX_LoRaWAN_Init_2 */
[#if CPUCORE != "CM0PLUS"]
  LoRaWAN_Init();
  /* USER CODE BEGIN MX_LoRaWAN_Init_3 */

  /* USER CODE END MX_LoRaWAN_Init_3 */
[/#if]
}
[#else]
uint32_t MX_LoRaWAN_Init(void *memory_ptr)
{
  uint32_t ret = TX_SUCCESS;

  /* USER CODE BEGIN MX_LoRaWAN_Init_1 */

  /* USER CODE END MX_LoRaWAN_Init_1 */
  byte_pool = memory_ptr;

  /* Allocate the stack for App App_MainThread.  */
  if (tx_byte_allocate(byte_pool, (VOID **) &pointer,
                       CFG_APP_LORA_THREAD_STACK_SIZE, TX_NO_WAIT) != TX_SUCCESS)
  {
    ret = TX_POOL_ERROR;
  }

  /* Create App_MainThread.  */
  if (ret == TX_SUCCESS)
  {
    if (tx_thread_create(&App_MainThread, "App LoRaWAN Main Thread", App_Main_Thread_Entry, 0,
                         pointer, CFG_APP_LORA_THREAD_STACK_SIZE,
                         CFG_APP_LORA_THREAD_PRIO, CFG_APP_LORA_THREAD_PREEMPTION_THRESHOLD,
                         TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
    {
      ret = TX_THREAD_ERROR;
    }
  }

  /* USER CODE BEGIN MX_LoRaWAN_Init_Last */

  /* USER CODE END MX_LoRaWAN_Init_Last */
  return ret;
}
[/#if]

[#if !FREERTOS??][#-- If FreeRtos, only available in CM4 is not used --]
[#if !THREADX??][#-- If AzRtos is not used --]
void MX_LoRaWAN_Process(void)
{
  /* USER CODE BEGIN MX_LoRaWAN_Process_1 */

  /* USER CODE END MX_LoRaWAN_Process_1 */
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") || (CPUCORE == "CM0PLUS")]
  UTIL_SEQ_Run(UTIL_SEQ_DEFAULT);
  /* USER CODE BEGIN MX_LoRaWAN_Process_2 */

  /* USER CODE END MX_LoRaWAN_Process_2 */
[/#if]
}
[/#if]
[/#if]

/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/
/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
