[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    usart_if.h
  * @author  MCD Application Team
  * @brief   Header for USART interface configuration
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#if HALCompliant??]
[#if (contextFolder?? && contextFolder=="ExtMemLoader/")]
#include "extmemloader_init.h"
[#else]
#include "${main_h}"
[/#if]
[#else]
#include "usart.h"
[/#if]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __USART_IF_H__
#define __USART_IF_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
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

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/**
  * @brief  Init the UART used for trace.
  */
void MX_EXTMEM_Trace_Init(void);

/**
  * @brief  DeInit the UART.
  */
void MX_EXTMEM_Trace_DeInit(void);

/**
  * @brief  send buffer \p p_data via USART/UART in polling mode
  * @param  p_data data to be sent
  */
void MX_EXTMEM_Trace(uint8_t *p_data);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __USART_IF_H__ */
