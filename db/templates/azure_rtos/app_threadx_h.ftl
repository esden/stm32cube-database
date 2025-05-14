[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_threadx.h
  * @author  MCD Application Team
  * @brief   ThreadX applicative header file
  ******************************************************************************
  [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_value = "0"]
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]

   [#if name == "AZRTOS_APP_MEM_ALLOCATION_METHOD"]
      [#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_value = value]
   [/#if]

   [#if name == "TX_APP_GENERATE_INIT_CODE"]
      [#assign TX_APP_GENERATE_INIT_CODE_value = value]
   [/#if]

   [#if name == "TX_APP_CREATION"]
      [#assign TX_APP_CREATION_value = value]
   [/#if]

   [#if name == "TX_APP_THREAD_ENTRY"]
      [#assign TX_APP_THREAD_ENTRY_value = value]
   [/#if]

   [#if name == "TX_APP_THREAD_NAME"]
      [#assign TX_APP_THREAD_NAME_value = value]
   [/#if]

   [#if name == "TX_APP_THREAD_PRIO"]
      [#assign TX_APP_THREAD_PRIO_value = value]
   [/#if]

   [#if name == "TX_APP_STACK_SIZE"]
      [#assign TX_APP_STACK_SIZE_value = value]
   [/#if]

   [#if name == "TX_APP_SEM_CREATION"]
      [#assign TX_APP_SEM_CREATION_value = value]
   [/#if]

   [#if name == "TX_APP_MUTEX_CREATION"]
      [#assign TX_APP_MUTEX_CREATION_value = value]
   [/#if]
 
   [#if name == "TX_APP_MSG_QUEUE_CREATION"]
      [#assign TX_APP_MSG_QUEUE_CREATION_value = value]
   [/#if]
 
   [#if name == "TX_MSG_QUEUE_NAME"]
      [#assign TX_MSG_QUEUE_NAME_value = value]
   [/#if]

   [#if name == "TX_MSG_SIZE_WORDS"]
      [#assign TX_MSG_SIZE_WORDS_value = value]
   [/#if]

   [#if name == "TX_NB_MSG"]
      [#assign TX_NB_MSG_value = value]
   [/#if]

  [/#list]
[/#if]
[/#list]
[/#compress]

/* Define to prevent recursive inclusion -------------------------------------*/
[#assign familyName=FamilyName?lower_case]
#ifndef __APP_THREADX_H
#define __APP_THREADX_H

#ifdef __cplusplus
[#if (familyName?starts_with("stm32u3")||familyName?starts_with("stm32u5")||familyName?starts_with("stm32h5")||familyName?starts_with("stm32c0")||familyName?starts_with("stm32wba"))]
extern "C" {
[#else]
 extern "C" {
[/#if]
#endif

/* Includes ------------------------------------------------------------------*/
#include "tx_api.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

[#assign familyName=FamilyName?lower_case]
/* Private defines -----------------------------------------------------------*/
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_value != "0"]
[#if TX_APP_GENERATE_INIT_CODE_value != "false"]
[#if TX_APP_CREATION_value != "0"]
#define TX_APP_STACK_SIZE                       ${TX_APP_STACK_SIZE_value}
#define TX_APP_THREAD_PRIO                      ${TX_APP_THREAD_PRIO_value}
[/#if]
[#if TX_APP_MSG_QUEUE_CREATION_value != "0"]
#define TX_APP_SINGLE_MSG_SIZE                  ${TX_MSG_SIZE_WORDS_value}
#define TX_APP_MSG_QUEUE_NB_MSG                 ${TX_NB_MSG_value}
#define TX_APP_MSG_QUEUE_FULL_SIZE              TX_APP_SINGLE_MSG_SIZE * TX_APP_MSG_QUEUE_NB_MSG
[/#if]
[/#if]

/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Main thread defines -------------------------------------------------------*/
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_value != "0"]
[#if TX_APP_GENERATE_INIT_CODE_value != "false"]
[#if TX_APP_CREATION_value != "0"]
#ifndef TX_APP_THREAD_PREEMPTION_THRESHOLD
#define TX_APP_THREAD_PREEMPTION_THRESHOLD      TX_APP_THREAD_PRIO
#endif

#ifndef TX_APP_THREAD_TIME_SLICE
#define TX_APP_THREAD_TIME_SLICE                TX_NO_TIME_SLICE
#endif

#ifndef TX_APP_THREAD_AUTO_START
#define TX_APP_THREAD_AUTO_START                TX_AUTO_START
#endif
[/#if]
[/#if]
[/#if]
/* USER CODE BEGIN MTD */

/* USER CODE END MTD */
[/#if]

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
UINT App_ThreadX_Init(VOID *memory_ptr);
void MX_ThreadX_Init(void);
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_value != "0"]
[#if TX_APP_GENERATE_INIT_CODE_value != "false"]
void ${TX_APP_THREAD_ENTRY_value}(ULONG thread_input);
[/#if]
[/#if]

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif
[#if (!familyName?starts_with("stm32wba"))]
#endif /* __APP_THREADX_H */
[#else]
#endif /* __APP_THREADX_H__ */
[/#if]