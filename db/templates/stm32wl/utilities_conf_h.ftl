[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    utilities_conf.h
  * @author  MCD Application Team
  * @brief   Header for configuration file to utilities
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
[#assign SUBGHZ_APPLICATION = ""]
[#assign SECURE_PROJECTS = "0"]
[#assign USE_UART = "true"]
[#assign UTIL_SEQ_EN_M4 = "true"]
[#assign UTIL_SEQ_EN_M0 = "true"]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "SUBGHZ_APPLICATION"]
                    [#assign SUBGHZ_APPLICATION = definition.value]
                [/#if]
                [#if definition.name == "USE_UART"]
                    [#assign USE_UART = definition.value]
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __UTILITIES_CONF_H__
#define __UTILITIES_CONF_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if CPUCORE == "CM0PLUS"]
#include "platform.h"
[/#if]
#include "cmsis_compiler.h"

/* definitions to be provided to "sequencer" utility */
#include "stm32_mem.h"
/* definition and callback for tiny_vsnprintf */
#include "stm32_tiny_vsnprintf.h"

[#if CPUCORE == "CM0PLUS"]
[#if (USE_UART == "true")]
#include "mbmuxif_trace.h"
[/#if]
[#if (SECURE_PROJECTS == "1")]
#include "sys_privileged_wrap.h"
#include "stm32_seq.h"

[/#if]
[/#if]

[#if !THREADX??][#-- If AzRtos is not used --]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
[#if ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
/* enum number of task and priority*/
#include "utilities_def.h"
[/#if]
[/#if]
[/#if]
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
#define VLEVEL_OFF    0  /*!< used to set UTIL_ADV_TRACE_SetVerboseLevel() (not as message param) */
#define VLEVEL_ALWAYS 0  /*!< used as message params, if this level is given
                              trace will be printed even when UTIL_ADV_TRACE_SetVerboseLevel(OFF) */
#define VLEVEL_L 1       /*!< just essential traces */
#define VLEVEL_M 2       /*!< functional traces */
#define VLEVEL_H 3       /*!< all traces */

#define TS_OFF 0         /*!< Log without TimeStamp */
#define TS_ON 1          /*!< Log with TimeStamp */

#define T_REG_OFF  0     /*!< Log without bitmask */

/* USER CODE BEGIN EC */

/* USER CODE END EC */
/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macros -----------------------------------------------------------*/
/******************************************************************************
  * common
  ******************************************************************************/
/**
  * @brief Memory placement macro
  */
#if defined(__CC_ARM)
#define UTIL_PLACE_IN_SECTION( __x__ )  __attribute__((section (__x__), zero_init))
#elif defined(__ICCARM__)
#define UTIL_PLACE_IN_SECTION( __x__ )  __attribute__((section (__x__)))
#else  /* __GNUC__ */
#define UTIL_PLACE_IN_SECTION( __x__ )  __attribute__((section (__x__)))
#endif /* __CC_ARM | __ICCARM__ | __GNUC__ */

/**
  * @brief Memory alignment macro
  */
#undef ALIGN
#ifdef WIN32
#define ALIGN(n)
#else
#define ALIGN(n)             __attribute__((aligned(n)))
#endif /* WIN32 */

/**
  * @brief macro used to initialize the critical section
  */
#define UTILS_INIT_CRITICAL_SECTION()

[#if (SECURE_PROJECTS == "1") && (CPUCORE == "CM0PLUS") ]
/**
  * @brief macro used to enter the critical section
  */
#define UTILS_ENTER_CRITICAL_SECTION() uint32_t nvic_iser_state= SYS_PRIVIL_EnterCriticalSection()

/**
  * @brief macro used to exit the critical section
  */
#define UTILS_EXIT_CRITICAL_SECTION()  SYS_PRIVIL_ExitCriticalSection(nvic_iser_state)

/******************************************************************************
  * tiny low power manager
  ******************************************************************************/
/**
  * @brief macro used to Enter critical section specifically for UTIL_LPM_EnterLowPower()
  */
#define UTIL_LPM_ENTER_CRITICAL_SECTION_ELP()
/**
  * @brief macro used to Exit critical section specifically for UTIL_LPM_EnterLowPower()
  */
#define UTIL_LPM_EXIT_CRITICAL_SECTION_ELP()
[#else]
/**
  * @brief macro used to enter the critical section
  */
#define UTILS_ENTER_CRITICAL_SECTION() uint32_t primask_bit= __get_PRIMASK();\
  __disable_irq()

/**
  * @brief macro used to exit the critical section
  */
#define UTILS_EXIT_CRITICAL_SECTION()  __set_PRIMASK(primask_bit)
[/#if]
/******************************************************************************
  * sequencer
  ******************************************************************************/
[#if !THREADX??][#-- If AzRTOS is not used --]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
[#if ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]

/**
  * @brief default number of tasks configured in sequencer
  */
#define UTIL_SEQ_CONF_TASK_NBR    CFG_SEQ_Task_NBR

/**
  * @brief default value of priority task
  */

#define UTIL_SEQ_CONF_PRIO_NBR    CFG_SEQ_Prio_NBR

[/#if][#--  SEQ_EN_M4 or SEQ_EN_M0 --]
[/#if]
[/#if]
[#if !THREADX??][#-- If AzRTOS is not used --]
/**
  * @brief macro used to initialize the critical section
  */
#define UTIL_SEQ_INIT_CRITICAL_SECTION( )    UTILS_INIT_CRITICAL_SECTION()

/**
  * @brief macro used to enter the critical section
  */
#define UTIL_SEQ_ENTER_CRITICAL_SECTION( )   UTILS_ENTER_CRITICAL_SECTION()

/**
  * @brief macro used to exit the critical section
  */
#define UTIL_SEQ_EXIT_CRITICAL_SECTION( )    UTILS_EXIT_CRITICAL_SECTION()

[/#if]
[#if (SECURE_PROJECTS == "1") && (CPUCORE == "CM0PLUS") ]
/**
  * @brief macro to Enter CS used specifically by UTIL_SEQ_Run before going to Idle
  */
#define UTIL_SEQ_ENTER_CRITICAL_SECTION_IDLE( )   SYS_PRIVIL_DisableIrqsAndRemainPriv()

/**
  * @brief macro to Exit CS used specifically by UTIL_SEQ_Run exiting from Idle
  */
#define UTIL_SEQ_EXIT_CRITICAL_SECTION_IDLE( )    SYS_PRIVIL_EnableIrqsAndGoUnpriv()

/******************************************************************************
  * tim_serv
  * (any macro that does not need to be modified can be removed)
  ******************************************************************************/
/**
  * @brief Security: Map UTIL_TIMER_IRQ on Sequencer Task (rather then Isr) such to run Unprivileged
  */
#define UTIL_TIMER_IRQ_MAP_INIT()     do{ UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_UtilTimer_Process), UTIL_SEQ_RFU, UTIL_TIMER_IRQ_Handler);} while(0)

#define UTIL_TIMER_IRQ_MAP_PROCESS()  do{ UTIL_SEQ_SetTask(1 << CFG_SEQ_Task_UtilTimer_Process, CFG_SEQ_Prio_0); } while(0)

[/#if]
/**
  * @brief Memset utilities interface to application
  */
#define UTIL_SEQ_MEMSET8( dest, value, size )   UTIL_MEM_set_8( dest, value, size )

/******************************************************************************
  * trace\advanced
  * the define option
  *    UTIL_ADV_TRACE_CONDITIONNAL shall be defined if you want use conditional function
  *    UTIL_ADV_TRACE_UNCHUNK_MODE shall be defined if you want use the unchunk mode
  *
  ******************************************************************************/

#define UTIL_ADV_TRACE_CONDITIONNAL                                                      /*!< not used */
#define UTIL_ADV_TRACE_UNCHUNK_MODE                                                      /*!< not used */
[#if CPUCORE == "CM0PLUS"]
#define UTIL_ADV_TRACE_MEMLOCATION                 UTIL_MEM_PLACE_IN_SECTION("MB_MEM3")  /*!< memory placement for trace buffer */
[/#if]
#define UTIL_ADV_TRACE_DEBUG(...)                                                        /*!< not used */
#define UTIL_ADV_TRACE_INIT_CRITICAL_SECTION( )    UTILS_INIT_CRITICAL_SECTION()         /*!< init the critical section in trace feature */
#define UTIL_ADV_TRACE_ENTER_CRITICAL_SECTION( )   UTILS_ENTER_CRITICAL_SECTION()        /*!< enter the critical section in trace feature */
#define UTIL_ADV_TRACE_EXIT_CRITICAL_SECTION( )    UTILS_EXIT_CRITICAL_SECTION()         /*!< exit the critical section in trace feature */
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "SUBGHZ_AT_SLAVE")]
#define UTIL_ADV_TRACE_TMP_BUF_SIZE                (1024U)                               /*!< default trace buffer size */
#define UTIL_ADV_TRACE_TMP_MAX_TIMESTMAP_SIZE      (15U)                                 /*!< default trace timestamp size */
#define UTIL_ADV_TRACE_FIFO_SIZE                   (2048U)                               /*!< default trace fifo size */
[#elseif (SUBGHZ_APPLICATION == "LORA_END_NODE")]
#define UTIL_ADV_TRACE_TMP_BUF_SIZE                (512U)                                /*!< default trace buffer size */
#define UTIL_ADV_TRACE_TMP_MAX_TIMESTMAP_SIZE      (15U)                                 /*!< default trace timestamp size */
#define UTIL_ADV_TRACE_FIFO_SIZE                   (1024U)                               /*!< default trace fifo size */
[#else]
#define UTIL_ADV_TRACE_TMP_BUF_SIZE                (256U)                                /*!< default trace buffer size */
#define UTIL_ADV_TRACE_TMP_MAX_TIMESTMAP_SIZE      (15U)                                 /*!< default trace timestamp size */
#define UTIL_ADV_TRACE_FIFO_SIZE                   (512U)                                /*!< default trace fifo size */
[/#if]
#define UTIL_ADV_TRACE_MEMSET8( dest, value, size) UTIL_MEM_set_8((dest),(value),(size)) /*!< memset utilities interface to trace feature */
#define UTIL_ADV_TRACE_VSNPRINTF(...)              tiny_vsnprintf_like(__VA_ARGS__)      /*!< vsnprintf utilities interface to trace feature */

/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__UTILITIES_CONF_H__ */
