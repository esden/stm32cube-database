[#ftl]
/**
  ******************************************************************************
  * @file    app_sigfox.c
  * @author  MCD Application Team
  * @brief   Application of the Sigfox Middleware
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

[#--
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            ${definition.name}: ${definition.value}
        [/#list]
    [/#if]
[/#list]
--]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
[#assign SUBGHZ_APPLICATION = ""]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "SUBGHZ_APPLICATION"]
                [#assign SUBGHZ_APPLICATION = definition.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]
/* Includes ------------------------------------------------------------------*/
#include "app_sigfox.h"
[#if (CPUCORE == "CM4") || (CPUCORE == "")]
#include "sgfx_app.h"
[#elseif (CPUCORE == "CM0PLUS")]
#include "radio.h"
[/#if]
#include "sys_app.h"
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION") ]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
#include "stm32_seq.h"
[#else]
#include "cmsis_os.h"
[/#if]
[/#if]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
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

void MX_Sigfox_Init(void)
{
  /* USER CODE BEGIN MX_Sigfox_Init_1 */

  /* USER CODE END MX_Sigfox_Init_1 */
  SystemApp_Init();
[#if (CPUCORE == "CM4") || (CPUCORE == "")]
  Sigfox_Init();
[#elseif (CPUCORE == "CM0PLUS")]
  Radio.Init(&RfApiRadioEvents);
[/#if]
  /* USER CODE BEGIN MX_Sigfox_Init_2 */

  /* USER CODE END MX_Sigfox_Init_2 */
}

void MX_Sigfox_Process(void)
{
  /* USER CODE BEGIN MX_Sigfox_Process_1 */

  /* USER CODE END MX_Sigfox_Process_1 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION") ]
  UTIL_SEQ_Run(UTIL_SEQ_DEFAULT);
[/#if]

  /* USER CODE BEGIN MX_Sigfox_Process_2 */

  /* USER CODE END MX_Sigfox_Process_2 */
}
/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
