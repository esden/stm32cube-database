[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name}
  * @author  MCD Application Team
  * @brief   Interface to the application
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef APP_ENTRY_H
#define APP_ENTRY_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if THREADX??]
#include        "tx_api.h"

[/#if]

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if THREADX??]
#define THREADX_BYTE_POOL_SIZE          (9120u)
#define THREADX_BLOCK_POOL_SIZE         (100u)

#define THREADX_STACK_SIZE_LARGE        (1024u)
#define THREADX_STACK_SIZE_REDUCED      (512u)

[/#if]
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported variables --------------------------------------------------------*/
[#if THREADX??]
extern TX_BYTE_POOL        * pBytePool;

[/#if]
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macros ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions ---------------------------------------------*/
void MX_APPE_Config(void);
[#if THREADX??]
uint32_t MX_APPE_Init(void *p_param);
[#else]
void MX_APPE_Init(void);
[/#if]
[#if !(THREADX?? || FREERTOS??)]
void MX_APPE_Process(void);
[/#if]
void Init_Exti(void);
[#if Line != "STM32WBx0 Value Line" ]
void Init_Smps(void);
[/#if]

/* USER CODE BEGIN EF */

/* USER CODE END EF */

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /*APP_ENTRY_H */
