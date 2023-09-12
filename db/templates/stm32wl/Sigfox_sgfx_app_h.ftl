[#ftl]
/**
  ******************************************************************************
  * @file    sgfx_app.h
  * @author  MCD Application Team
  * @brief   provides code for the application of the SIGFOX Middleware
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

[#assign SUBGHZ_APPLICATION = ""]
[#assign DEFAULT_RC = ""]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "SUBGHZ_APPLICATION"]
                [#assign SUBGHZ_APPLICATION = definition.value]
            [/#if]
            [#if definition.name == "DEFAULT_RC"]
                [#assign DEFAULT_RC = definition.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __SGFX_APP_H__
#define __SGFX_APP_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32wlxx.h"
#include "stm32wlxx_hal.h"
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION") ]
#include "adc_if.h"
[/#if]
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") ]
#define DEFAULT_RC ${DEFAULT_RC}
[/#if]
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macros -----------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/* Init Sigfox Application */
void Sigfox_Init(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__SGFX_APP_H__*/

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
