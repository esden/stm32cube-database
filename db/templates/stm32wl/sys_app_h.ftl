[#ftl]
/**
  ******************************************************************************
  * @file    sys_app.h
  * @author  MCD Application Team
  * @brief   Function prototypes for sys_app.c file
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
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "SUBGHZ_APPLICATION"]
                [#assign SUBGHZ_APPLICATION = definition.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __SYS_APP_H__
#define __SYS_APP_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stdint.h"
[#if ((SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION"))]
#include "sys_conf.h"
#include "stm32_adv_trace.h"
[/#if]
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macros -----------------------------------------------------------*/
[#if ((SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION"))]
#define APP_PPRINTF(...)  do{ } while( UTIL_ADV_TRACE_OK \
                              != UTIL_ADV_TRACE_COND_FSend(VLEVEL_ALWAYS, T_REG_OFF, TS_OFF, __VA_ARGS__) ) /* Polling Mode */
#define APP_TPRINTF(...)   do{ {UTIL_ADV_TRACE_COND_FSend(VLEVEL_ALWAYS, T_REG_OFF, TS_ON, __VA_ARGS__);} }while(0); /* with timestamp */
#define APP_PRINTF(...)   do{ {UTIL_ADV_TRACE_COND_FSend(VLEVEL_ALWAYS, T_REG_OFF, TS_OFF, __VA_ARGS__);} }while(0);

#if defined (APP_LOG_ENABLED) && (APP_LOG_ENABLED == 1)
#define APP_LOG(TS,VL,...)   do{ {UTIL_ADV_TRACE_COND_FSend(VL, T_REG_OFF, TS, __VA_ARGS__);} }while(0);
#elif defined (APP_LOG_ENABLED) && (APP_LOG_ENABLED == 0) /* APP_LOG disabled */
#define APP_LOG(TS,VL,...)
#else
#error "APP_LOG_ENABLED not defined or out of range <0,1>"
#endif /* APP_LOG_ENABLED */

[/#if]
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/**
  * @brief initialises the system (dbg pins, trace, systiemr, LPM, ...)
  * @param none
  * @retval  none
  */
void SystemApp_Init(void);

[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION"))]
/**
  * @brief  callback to get the battery level in % of full charge (254 full charge, 0 no charge)
  * @param  none
  * @retval battery level
  */
uint8_t GetBatteryLevel(void);

/**
  * @brief  callback to get the current temperature in the MCU
  * @param  none
  * @retval temperature level
  */
uint16_t GetTemperatureLevel(void);

/**
  * @brief  callback to get the board 64 bits unique ID
  * @param  unique ID
  * @retval none
  */
void GetUniqueId(uint8_t *id);

/**
  * @brief  callback to get the board 32 bits unique ID (LSB)
  * @param  none
  * @retval devAddr Device Address
  */
uint32_t GetDevAddr(void);
[/#if]

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __SYS_APP_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
