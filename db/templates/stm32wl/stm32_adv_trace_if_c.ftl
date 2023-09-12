[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file  : stm32_adv_trace_if.c
  * @brief : Source file for interfacing the stm32_adv_trace to hardware
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include "stm32_adv_trace.h"
#include "stm32_adv_trace_if.h"
/* USER CODE BEGIN include */

/* USER CODE END include */

/* Exported variables --------------------------------------------------------*/

/**
  *  @brief  trace tracer definition.
  *
  *  list all the driver interface used by the trace application.
  */
const UTIL_ADV_TRACE_Driver_s UTIL_TraceDriver =
{
  UART_Init,
  UART_DeInit,
  UART_StartRx,
  UART_TransmitDMA
};
/* USER CODE BEGIN EV */

/* USER CODE END EV */
/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN Private_Function_Prototypes */

/* USER CODE END Private_Function_Prototypes */
/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN Private_Typedef */

/* USER CODE END Private_Typedef */
/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN Private_Define */

/* USER CODE END Private_Define */
/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN Private_Macro */

/* USER CODE END Private_Macro */
/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN Private_Variables */

/* USER CODE END Private_Variables */

UTIL_ADV_TRACE_Status_t UART_Init(void (*cb)(void *))
{
  /* USER CODE BEGIN UART_Init */
  return UTIL_ADV_TRACE_OK;
  /* USER CODE END UART_Init */
}

UTIL_ADV_TRACE_Status_t UART_DeInit(void)
{
  /* USER CODE BEGIN UART_DeInit */
  return UTIL_ADV_TRACE_OK;
  /* USER CODE END UART_DeInit */
}

UTIL_ADV_TRACE_Status_t UART_StartRx(void (*cb)(uint8_t *pdata, uint16_t size, uint8_t error))
{
  /* USER CODE BEGIN UART_StartRx */
  return UTIL_ADV_TRACE_OK;
  /* USER CODE END UART_StartRx */
}

UTIL_ADV_TRACE_Status_t UART_TransmitDMA(uint8_t *pdata, uint16_t size)
{
  /* USER CODE BEGIN UART_TransmitDMA */
  return UTIL_ADV_TRACE_OK;
  /* USER CODE END UART_TransmitDMA */
}

/* USER CODE BEGIN Private_Functions */

/* USER CODE END Private_Functions */
