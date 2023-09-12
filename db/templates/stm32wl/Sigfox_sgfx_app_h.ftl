[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    sgfx_app.h
  * @author  MCD Application Team
  * @brief   provides code for the application of the SIGFOX Middleware
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
[#assign DEFAULT_RC = ""]
[#assign SECURE_PROJECTS = "0"]
[#if SWIPdatas??]
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
[/#if]

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
[#if FREERTOS??][#-- If FreeRtos is used --]
[#if (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")]
/*Send*/
#define CFG_APP_SGFX_PROCESS_NAME                  "SGFX_SEND_PROCESS"
#define CFG_APP_SGFX_PROCESS_ATTR_BITS             (0)
#define CFG_APP_SGFX_PROCESS_CB_MEM                (0)
#define CFG_APP_SGFX_PROCESS_CB_SIZE               (0)
#define CFG_APP_SGFX_PROCESS_STACK_MEM             (0)
#define CFG_APP_SGFX_PROCESS_PRIORITY              osPriorityNone
#define CFG_APP_SGFX_PROCESS_STACK_SIZE            1024

[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE")]
/*Vcom*/
#define CFG_VCOM_PROCESS_NAME                      "VCOM_PROCESS"
#define CFG_VCOM_PROCESS_ATTR_BITS                 (0)
#define CFG_VCOM_PROCESS_CB_MEM                    (0)
#define CFG_VCOM_PROCESS_CB_SIZE                   (0)
#define CFG_VCOM_PROCESS_STACK_MEM                 (0)
#define CFG_VCOM_PROCESS_PRIORITY                  osPriorityNone
#define CFG_VCOM_PROCESS_STACK_SIZE                1024

[/#if]
[/#if][#--  FREERTOS --]
[#if THREADX??]
/*
 * THREADs configuration defines: stack size and priorities
 * of the different Azure RTOS threads used by the Sigfox application.
 */
/* USER CODE BEGIN THREADX_EC */
/*Main Sigfox Thread*/
#define CFG_APP_SIGFOX_THREAD_STACK_SIZE                 1024
#define CFG_APP_SIGFOX_THREAD_PRIO                       10
#define CFG_APP_SIGFOX_THREAD_PREEMPTION_THRESHOLD       CFG_APP_SIGFOX_THREAD_PRIO

[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE")]
/*Vcom*/
#define CFG_VCOM_THREAD_STACK_SIZE                       1024
#define CFG_VCOM_THREAD_PRIO                             CFG_APP_SIGFOX_THREAD_PRIO
#define CFG_VCOM_THREAD_PREEMPTION_THRESHOLD             CFG_APP_SIGFOX_THREAD_PRIO

[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")]
/*Push Button Process (send)*/
#define CFG_PBP_THREAD_STACK_SIZE                        1024
#define CFG_PBP_THREAD_PRIO                              CFG_APP_SIGFOX_THREAD_PRIO
#define CFG_PBP_THREAD_PREEMPTION_THRESHOLD              CFG_APP_SIGFOX_THREAD_PRIO

[/#if]
[#if (CPUCORE == "")]
/*Monarch*/
#define CFG_MN_THREAD_STACK_SIZE                         1024
#define CFG_MN_THREAD_PRIO                               CFG_APP_SIGFOX_THREAD_PRIO
#define CFG_MN_THREAD_PREEMPTION_THRESHOLD               CFG_APP_SIGFOX_THREAD_PRIO

[/#if]
/* USER CODE END THREADX_EC */

[/#if][#--  THREADX --]
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macros -----------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/**
  * @brief  Init Sigfox Application
  */
void Sigfox_Init(void);

[#if THREADX??]
/**
  * @brief  Function implementing the Sigfox Main Thread thread.
  * @param  thread_input: Not used
  * @retval None
  */
void App_Main_Thread_Entry(unsigned long thread_input);
[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__SGFX_APP_H__*/
