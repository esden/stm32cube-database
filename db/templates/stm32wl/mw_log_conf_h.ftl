[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    mw_log_conf.h
  * @author  MCD Application Team
[#if (CPUCORE == "")]
  * @brief   Configure (enable/disable) traces
[#else]
  * @brief   Configure (enable/disable) traces for CM0
[/#if]
  *******************************************************************************
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
[#assign MW_LOG_ENABLED = "0"]
[#assign SUBGHZ_APPLICATION = ""]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "MW_LOG_ENABLED"]
                    [#if definition.value == "true"]
                        [#assign MW_LOG_ENABLED = "1"]
                    [/#if]
                [/#if]
                [#if definition.name == "SUBGHZ_APPLICATION"]
                    [#assign SUBGHZ_APPLICATION = definition.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MW_LOG_CONF_H__
#define __MW_LOG_CONF_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if ((SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION"))]
#include "stm32_adv_trace.h"

[/#if]
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if (MW_LOG_ENABLED == "1")]
#define MW_LOG_ENABLED
[#else]
//#define MW_LOG_ENABLED
[/#if]

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
#ifdef MW_LOG_ENABLED
[#if ((SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION"))]
#define MW_LOG(TS,VL, ...)   do{ {UTIL_ADV_TRACE_COND_FSend(VL, T_REG_OFF, TS, __VA_ARGS__);} }while(0)
#else  /* MW_LOG_ENABLED */
#define MW_LOG(TS,VL, ...)
[#else]
/* USER CODE BEGIN Mw_Logs_En*/
/* Map your own trace mechanism or to map UTIL_ADV_TRACE see examples from CubeFw, i.e.:
                             do{ {UTIL_ADV_TRACE_COND_FSend(VL, T_REG_OFF, TS, __VA_ARGS__);} }while(0) */
#define MW_LOG(TS,VL, ...)
/* USER CODE END Mw_Logs_En */
#else  /* MW_LOG_ENABLED */
/* USER CODE BEGIN Mw_Logs_Dis*/
#define MW_LOG(TS,VL, ...)
/* USER CODE END Mw_Logs_Dis */
[/#if]
#endif /* MW_LOG_ENABLED */
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__MW_LOG_CONF_H__ */
