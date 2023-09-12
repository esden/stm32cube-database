[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    lora_app.c
  * @author  MCD Application Team
  * @brief   Application of the LRWAN Middleware
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
#include "sys_app.h"
#include "lora_app.h"
[#if UTIL_SEQ_EN_M0 == "true"]
#include "stm32_seq.h"
[/#if]
#include "utilities_def.h"
#include "LmHandler.h"

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

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Exported functions ---------------------------------------------------------*/
/* USER CODE BEGIN EF */

/* USER CODE END EF */

void InitPackageProcess(void)
{
  /* USER CODE BEGIN InitPackageProcess_1 */

  /* USER CODE END InitPackageProcess_1 */
[#if UTIL_SEQ_EN_M0 == "true"]
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_LmHandlerProcess), UTIL_SEQ_RFU, LmHandlerProcess);
[#else]
  /* USER CODE BEGIN InitPackageProcess_OS */

  /* USER CODE END InitPackageProcess_OS */
[/#if][#--  SEQUENCER --]
  /* USER CODE BEGIN InitPackageProcess_2 */

  /* USER CODE END InitPackageProcess_2 */
}

void OnMacProcessNotify(void)
{
  /* USER CODE BEGIN OnMacProcessNotify_1 */

  /* USER CODE END OnMacProcessNotify_1 */
[#if UTIL_SEQ_EN_M0 == "true"]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_LmHandlerProcess), CFG_SEQ_Prio_0);
[#else]
  /* USER CODE BEGIN OnMacProcessNotify_OS */

  /* USER CODE END OnMacProcessNotify_OS */
[/#if][#--  SEQUENCER --]
  /* USER CODE BEGIN OnMacProcessNotify_2 */

  /* USER CODE END OnMacProcessNotify_2 */
}
