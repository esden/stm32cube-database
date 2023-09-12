[#ftl]
/**
  ******************************************************************************
  * @file    usart_if.c
  * @author  MCD Application Team
  * @brief   Configuration of UART MX driver interface for hyperterminal communication
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
[#assign UsartInstance = ""]
[#list BspIpDatas as SWIP]
  [#if SWIP.variables??]
    [#list SWIP.variables as variables]
      [#if variables.name?contains("IpInstance")]
        [#assign IpInstance = variables.value]
      [/#if]
      [#if variables.value?contains("BSP USART")]
        [#assign UsartInstance = IpInstance]
        [#assign useUSART = true]
      [/#if]
      [#if variables.name?contains("EXTI_LINE_NUMBER")]
        [#assign ExtiLine = variables.value]
      [/#if]
    [/#list]
  [/#if]
[/#list]
[#--[#list BspIpDatas as SWIP]
  [#if SWIP.variables??]
    [#list SWIP.variables as variables]
      ${variables.name}: ${variables.value}
    [/#list]
  [/#if]
[/#list]--]
/* Includes ------------------------------------------------------------------*/
#include "usart_if.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
/**
  * @brief DMA handle
  */
extern DMA_HandleTypeDef hdma_${IpInstance?lower_case}_tx;

/**
  * @brief UART handle
  */
extern UART_HandleTypeDef h${IpInstance?lower_case?replace("s","")};

/**
  * @brief buffer to receive 1 character
  */
uint8_t charRx;

/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/
/**
  * @brief Trace driver callbacks handler
  */
const UTIL_ADV_TRACE_Driver_s UTIL_TraceDriver =
{
  vcom_Init,
  vcom_DeInit,
  vcom_ReceiveInit,
  vcom_Trace_DMA,
};

/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/**
  * @brief  TX complete callback
  * @return none
  */
static void (*TxCpltCallback)(void *);
/**
  * @brief  RX complete callback
  * @param  rxChar ptr of chars buffer sent by user
  * @param  size buffer size
  * @param  error errorcode
  * @return none
  */
static void (*RxCpltCallback)(uint8_t *rxChar, uint16_t size, uint8_t error);

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/

[#--  __weak HAL_StatusTypeDef MX_${UsartInstance}_UART_Init(UART_HandleTypeDef* huart);--]
UTIL_ADV_TRACE_Status_t vcom_Init(void (*cb)(void *))
{
  /* USER CODE BEGIN vcom_Init_1 */

  /* USER CODE END vcom_Init_1 */
  TxCpltCallback = cb;
  MX_DMA_Init();
  MX_${IpInstance}_UART_Init();
[#if (IpInstance == "LPUART1") ]
  LL_EXTI_EnableIT_0_31(LL_EXTI_LINE_28);
[#elseif (IpInstance == "USART2") ]
  LL_EXTI_EnableIT_0_31(LL_EXTI_LINE_27);
[#elseif (IpInstance == "USART1") ]
  LL_EXTI_EnableIT_0_31(LL_EXTI_LINE_26);
[/#if]
  return UTIL_ADV_TRACE_OK;
  /* USER CODE BEGIN vcom_Init_2 */

  /* USER CODE END vcom_Init_2 */
}

UTIL_ADV_TRACE_Status_t vcom_DeInit(void)
{
  /* USER CODE BEGIN vcom_DeInit_1 */

  /* USER CODE END vcom_DeInit_1 */
  /* ##-1- Reset peripherals ################################################## */
  __HAL_RCC_${IpInstance}_FORCE_RESET();
  __HAL_RCC_${IpInstance}_RELEASE_RESET();

  /* ##-2- MspDeInit ################################################## */
  HAL_UART_MspDeInit(&h${IpInstance?lower_case?replace("s","")});

  /* ##-3- Disable the NVIC for DMA ########################################### */
  /* temporary while waiting CR 50840: MX implementation of  MX_DMA_DeInit() */
  /* For the time being user should change manually the channel according to the MX settings */
  /* USER CODE BEGIN 1 */
  HAL_NVIC_DisableIRQ(DMA1_Channel5_IRQn);

  return UTIL_ADV_TRACE_OK;
  /* USER CODE END 1 */
  /* USER CODE BEGIN vcom_DeInit_2 */

  /* USER CODE END vcom_DeInit_2 */
}

void vcom_Trace(uint8_t *p_data, uint16_t size)
{
  /* USER CODE BEGIN vcom_Trace_1 */

  /* USER CODE END vcom_Trace_1 */
  HAL_UART_Transmit(&h${IpInstance?lower_case?replace("s","")}, p_data, size, 1000);
  /* USER CODE BEGIN vcom_Trace_2 */

  /* USER CODE END vcom_Trace_2 */
}

UTIL_ADV_TRACE_Status_t vcom_Trace_DMA(uint8_t *p_data, uint16_t size)
{
  /* USER CODE BEGIN vcom_Trace_DMA_1 */

  /* USER CODE END vcom_Trace_DMA_1 */
  HAL_UART_Transmit_DMA(&h${IpInstance?lower_case?replace("s","")}, p_data, size);
  return UTIL_ADV_TRACE_OK;
  /* USER CODE BEGIN vcom_Trace_DMA_2 */

  /* USER CODE END vcom_Trace_DMA_2 */
}

UTIL_ADV_TRACE_Status_t vcom_ReceiveInit(void (*RxCb)(uint8_t *rxChar, uint16_t size, uint8_t error))
{
  /* USER CODE BEGIN vcom_ReceiveInit_1 */

  /* USER CODE END vcom_ReceiveInit_1 */
  UART_WakeUpTypeDef WakeUpSelection;

  /*record call back*/
  RxCpltCallback = RxCb;

  /*Set wakeUp event on start bit*/
  WakeUpSelection.WakeUpEvent = UART_WAKEUP_ON_STARTBIT;

  HAL_UARTEx_StopModeWakeUpSourceConfig(&h${IpInstance?lower_case?replace("s","")}, WakeUpSelection);

  /* Make sure that no UART transfer is on-going */
  while (__HAL_UART_GET_FLAG(&h${IpInstance?lower_case?replace("s","")}, USART_ISR_BUSY) == SET);

  /* Make sure that UART is ready to receive)   */
  while (__HAL_UART_GET_FLAG(&h${IpInstance?lower_case?replace("s","")}, USART_ISR_REACK) == RESET);

  /* Enable USART interrupt */
  __HAL_UART_ENABLE_IT(&h${IpInstance?lower_case?replace("s","")}, UART_IT_WUF);

  /*Enable wakeup from stop mode*/
  HAL_UARTEx_EnableStopMode(&h${IpInstance?lower_case?replace("s","")});

  /*Start LPUART receive on IT*/
  HAL_UART_Receive_IT(&h${IpInstance?lower_case?replace("s","")}, &charRx, 1);

  return UTIL_ADV_TRACE_OK;
  /* USER CODE BEGIN vcom_ReceiveInit_2 */

  /* USER CODE END vcom_ReceiveInit_2 */
}

void vcom_Resume(void)
{
  /* USER CODE BEGIN vcom_Resume_1 */

  /* USER CODE END vcom_Resume_1 */
[#if (IpInstance != "LPUART1") ]
  /*to re-enable lost UART settings*/
  if (HAL_UART_Init(&h${IpInstance?lower_case?replace("s","")}) != HAL_OK)
  {
    Error_Handler();
  }

[/#if]
  /*to re-enable lost DMA settings*/
  if (HAL_DMA_Init(&hdma_${IpInstance?lower_case}_tx) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN vcom_Resume_2 */

  /* USER CODE END vcom_Resume_2 */
}

void HAL_UART_TxCpltCallback(UART_HandleTypeDef *h${IpInstance?lower_case?replace("s","")})
{
  /* USER CODE BEGIN HAL_UART_TxCpltCallback_1 */

  /* USER CODE END HAL_UART_TxCpltCallback_1 */
  /* buffer transmission complete*/
  TxCpltCallback(NULL);
  /* USER CODE BEGIN HAL_UART_TxCpltCallback_2 */

  /* USER CODE END HAL_UART_TxCpltCallback_2 */
}

void HAL_UART_RxCpltCallback(UART_HandleTypeDef *h${IpInstance?lower_case?replace("s","")})
{
  /* USER CODE BEGIN HAL_UART_RxCpltCallback_1 */

  /* USER CODE END HAL_UART_RxCpltCallback_1 */
  if ((NULL != RxCpltCallback) && (HAL_UART_ERROR_NONE == h${IpInstance?lower_case?replace("s","")}->ErrorCode))
  {
    RxCpltCallback(&charRx, 1, 0);
  }
  HAL_UART_Receive_IT(h${IpInstance?lower_case?replace("s","")}, &charRx, 1);
  /* USER CODE BEGIN HAL_UART_RxCpltCallback_2 */

  /* USER CODE END HAL_UART_RxCpltCallback_2 */
}

/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
