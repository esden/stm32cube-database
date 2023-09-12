[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    usart_if.c
  * @author  MCD Application Team
  * @brief : Source file for interfacing the stm32_adv_trace to hardware
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
[#if HALCompliant??]
#include "main.h"
[#else]
#include "usart.h"
[/#if]
#include "stm32_adv_trace.h"
#include "usart_if.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
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

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
#if (CFG_HW_USART1_ENABLED == 1)
  extern UART_HandleTypeDef huart1;

  #if (CFG_HW_USART1_DMA_TX_SUPPORTED == 1)   
    extern DMA_HandleTypeDef handle_GPDMA1_Channel0;
  #endif /*(CFG_HW_USART1_DMA_TX_SUPPORTED == 1)*/

  #if (CFG_HW_USART1_DMA_RX_SUPPORTED == 1)   
    extern DMA_HandleTypeDef handle_GPDMA1_Channel1;
  #endif /*(CFG_HW_USART1_DMA_RX_SUPPORTED == 1)*/
#endif /* (CFG_HW_USART1_ENABLED == 1) */

#if (CFG_HW_USART2_ENABLED == 1)
  extern UART_HandleTypeDef huart2;

  #if (CFG_HW_USART2_DMA_TX_SUPPORTED == 1)   
    extern DMA_HandleTypeDef hdma_usart2_tx;
  #endif /*(CFG_HW_USART2_DMA_TX_SUPPORTED == 1)*/
  
  #if (CFG_HW_USART2_DMA_RX_SUPPORTED == 1)   
    extern DMA_HandleTypeDef hdma_usart2_rx;
  #endif /*(CFG_HW_USART2_DMA_RX_SUPPORTED == 1)*/
#endif /* (CFG_HW_USART2_ENABLED == 1) */

#if (CFG_HW_LPUART1_ENABLED == 1)
  extern UART_HandleTypeDef hlpuart1;

  #if (CFG_HW_LPUART1_DMA_TX_SUPPORTED == 1)   
    extern DMA_HandleTypeDef hdma_hlpuart1_tx;
  #endif /*(CFG_HW_LPUART1_DMA_TX_SUPPORTED == 1)*/

  #if (CFG_HW_LPUART1_DMA_RX_SUPPORTED == 1)   
    extern DMA_HandleTypeDef hdma_hlpuart1_rx;
  #endif /*(CFG_HW_LPUART1_DMA_RX_SUPPORTED == 1)*/
#endif /* (CFG_HW_LPUART1_ENABLED == 1) */

/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private variables ---------------------------------------------------------*/
uint8_t receive_after_transmit = 0; /* Whether the UART should be in RX after a Transmit */

/**
  * @brief buffer to receive 1 character
  */
uint8_t charRx;

/**
  * @brief  TX complete callback
  * @return none
  */
static void (*TxCpltCallback)(void *);
static void (*RxCpltCallback)(uint8_t *pdata, uint16_t size, uint8_t error);

#if (CFG_HW_USART1_ENABLED == 1)
  static void USART1_DMA_MspDeInit(void);
#endif /* CFG_HW_USART1_ENABLED */

#if (CFG_HW_USART2_ENABLED == 1)
  static void USART2_DMA_MspDeInit(void);
#endif /* CFG_HW_USART2_ENABLED */

#if (CFG_HW_LPUART1_ENABLED == 1)
  static void LPUART1_DMA_MspDeInit(void);
#endif /* CFG_HW_LPUART1_ENABLED */

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Private function prototypes -----------------------------------------------*/
static void UsartIf_TxCpltCallback(UART_HandleTypeDef *huart);
static void UsartIf_RxCpltCallback(UART_HandleTypeDef *huart);

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

UTIL_ADV_TRACE_Status_t UART_Init(  void (*cb)(void *))
{
  #if (CFG_HW_USART1_ENABLED == 1)
    /* Init done in main: GPIO */
    HAL_UART_MspInit(&huart1);
    MX_USART1_UART_Init();
    
    /* Two layer callbacks: perhaps smarter way to do it? */
    TxCpltCallback = cb;
    huart1.TxCpltCallback = UsartIf_TxCpltCallback;
  #endif /* (CFG_HW_USART1_ENABLED == 1) */
  
  #if (CFG_HW_USART2_ENABLED == 1)
    HAL_UART_MspInit(&huart2);
    MX_USART2_UART_Init();
  #endif /* (CFG_HW_USART2_ENABLED == 1) */
  
  #if (CFG_HW_LPUART1_ENABLED == 1)
    HAL_UART_MspInit(&hlpuart1);
    MX_LPUART1_UART_Init();
  #endif /* (CFG_HW_LPUART1_ENABLED == 1) */

  return UTIL_ADV_TRACE_OK;
}

UTIL_ADV_TRACE_Status_t UART_DeInit( void )
{
  HAL_StatusTypeDef result;

  /* USART1 */
  #if (CFG_HW_USART1_ENABLED == 1)
    USART1_DMA_MspDeInit();
    
    result = HAL_UART_DeInit(&huart1);
    if (result != HAL_OK)
    {
      huart1.TxCpltCallback = NULL;
      return UTIL_ADV_TRACE_UNKNOWN_ERROR;
    }
    
    #if (CFG_HW_USART1_DMA_TX_SUPPORTED == 1)
      result = HAL_DMA_DeInit(&handle_GPDMA1_Channel0);
      if (result != HAL_OK)
      {
        return UTIL_ADV_TRACE_UNKNOWN_ERROR;
      }
    #endif /*(CFG_HW_USART1_DMA_TX_SUPPORTED == 1)*/
    
    #if (CFG_HW_USART1_DMA_RX_SUPPORTED == 1)  
      result = HAL_DMA_DeInit(&handle_GPDMA1_Channel1);
      if (result != HAL_OK)
      {
        return UTIL_ADV_TRACE_UNKNOWN_ERROR;
      }
    #endif /*(CFG_HW_USART1_DMA_RX_SUPPORTED == 1)*/
  #endif /* (CFG_HW_USART1_ENABLED == 1) */


  /* USART 2 */
  #if (CFG_HW_USART2_ENABLED == 1)
    USART2_DMA_MspDeInit();
    
    result = HAL_UART_DeInit(&huart2);
    if (result != HAL_OK)
    {
      huart2.TxCpltCallback = NULL;
      return UTIL_ADV_TRACE_UNKNOWN_ERROR;
    }
    
    #if (CFG_HW_USART2_DMA_TX_SUPPORTED == 1)
      result = HAL_DMA_DeInit(&hdma_usart2_tx);
      if (result != HAL_OK)
      {
        return UTIL_ADV_TRACE_UNKNOWN_ERROR;
      }
    #endif /*(CFG_HW_USART2_DMA_TX_SUPPORTED == 1)*/
    
    #if (CFG_HW_USART2_DMA_RX_SUPPORTED == 1)
      result = HAL_DMA_DeInit(&hdma_usart2_rx);
      if (result != HAL_OK)
      {
        return UTIL_ADV_TRACE_UNKNOWN_ERROR;
      }
    #endif /*(CFG_HW_USART2_DMA_RX_SUPPORTED == 1)*/
  #endif /* (CFG_HW_USART2_ENABLED == 1) */
  
  
  /* LPUART1 */
  #if (CFG_HW_LPUART1_ENABLED == 1)
    LPUART1_DMA_MspDeInit();
    
    result = HAL_UART_DeInit(&hlpuart1);
    if (result != HAL_OK)
    {
      hlpuart1.TxCpltCallback = NULL;
      return UTIL_ADV_TRACE_UNKNOWN_ERROR;
    }
    
    #if (CFG_HW_LPUART1_DMA_TX_SUPPORTED == 1)
      result = HAL_DMA_DeInit(&hdma_hlpuart1_tx);
      if (result != HAL_OK)
      {
        return UTIL_ADV_TRACE_UNKNOWN_ERROR;
      }
    #endif /*(CFG_HW_LPUART1_DMA_TX_SUPPORTED == 1)*/
    
    #if (CFG_HW_LPUART1_DMA_RX_SUPPORTED == 1)
      result = HAL_DMA_DeInit(&hdma_hlpuart1_rx);
      if (result != HAL_OK)
      {
        return UTIL_ADV_TRACE_UNKNOWN_ERROR;
      }
    #endif /*(CFG_HW_LPUART1_DMA_RX_SUPPORTED == 1)*/
  #endif /* (CFG_HW_LPUART1_ENABLED == 1) */
  
  return UTIL_ADV_TRACE_OK;
}

UTIL_ADV_TRACE_Status_t UART_StartRx(void (*cb)(uint8_t *pdata, uint16_t size, uint8_t error))
{
  /* Configure UART1 in Receive mode */
  #if (CFG_HW_USART1_ENABLED == 1)
    HAL_UART_Receive_IT(&huart1, &charRx, 1);
    huart1.RxCpltCallback = &UsartIf_RxCpltCallback;
    if (cb != NULL)
    { 
      RxCpltCallback = cb;
    }
  #endif /* CFG_HW_USART1_ENABLED */

  /* USER CODE BEGIN UART_StartRx */
  
  /* USER CODE END UART_StartRx */
  
  return UTIL_ADV_TRACE_OK;
}

UTIL_ADV_TRACE_Status_t UART_TransmitDMA ( uint8_t *pdata, uint16_t size )
{
  UTIL_ADV_TRACE_Status_t status = UTIL_ADV_TRACE_OK;
  
  #if (CFG_HW_USART1_ENABLED == 1)
    #if ((CFG_HW_USART1_DMA_TX_SUPPORTED || CFG_HW_USART1_DMA_RX_SUPPORTED)==1)
      HAL_StatusTypeDef result = HAL_UART_Transmit_DMA(&huart1, pdata, size);
    #else
      HAL_StatusTypeDef result = HAL_UART_Transmit_IT(&huart1, pdata, size);
    #endif /* (CFG_HW_USART1_DMA_TX_SUPPORTED || CFG_HW_USART1_DMA_RX_SUPPORTED) */
    
    if (result != HAL_OK)
      status = UTIL_ADV_TRACE_HW_ERROR;
    /* Check whether the UART should return in Receiver mode */
    if(receive_after_transmit)
     HAL_UART_Receive_IT(&huart1, &charRx, 1);
  #endif /* CFG_HW_USART1_ENABLED */
  
  return status;
}

#if (CFG_HW_USART1_ENABLED == 1)
  static void USART1_DMA_MspDeInit(void)
  {
    /* Disable USART1 clk */
    __HAL_RCC_USART1_CLK_DISABLE();
    
    /* Disable interrupts for USART1 */
    HAL_NVIC_DisableIRQ(USART1_IRQn);
    
     /* GPDMA1 controller clock disable */
    __HAL_RCC_GPDMA1_CLK_DISABLE();

    /* DMA interrupt init */
    /* GPDMA1_Channel0_IRQn interrupt configuration */
    HAL_NVIC_DisableIRQ(GPDMA1_Channel0_IRQn);
  }
#endif  /* CFG_HW_USART1_ENABLED */

#if (CFG_HW_USART2_ENABLED == 1)
  static void USART2_DMA_MspDeInit(void)
  {
    /* Disable USART2 clk */
    __HAL_RCC_USART2_CLK_DISABLE();
    
    /* Disable interrupts for USART2 */
    HAL_NVIC_DisableIRQ(USART2_IRQn);
    
     /* GPDMA1 controller clock disable */
    __HAL_RCC_GPDMA1_CLK_DISABLE();

    /* DMA interrupt init */
    /* GPDMA1_Channel7_IRQn interrupt configuration */
    HAL_NVIC_DisableIRQ(GPDMA1_Channel7_IRQn);
  }
#endif /* CFG_HW_USART2_ENABLED */

#if (CFG_HW_LPUART1_ENABLED == 1)
  static void LPUART1_DMA_MspDeInit(void)
  {
    /* Disable USART1 clk */
    __HAL_RCC_LPUART1_CLK_DISABLE();
    
    /* Disable interrupts for LPUART1 */
    HAL_NVIC_DisableIRQ(LPUART1_IRQn);
    
     /* GPDMA1 controller clock disable */
    __HAL_RCC_GPDMA1_CLK_DISABLE();

    /* DMA interrupt init */
    /* GPDMA1_Channel0_IRQn interrupt configuration */
    HAL_NVIC_DisableIRQ(GPDMA1_Channel0_IRQn);
  }
#endif  /* CFG_HW_LPUART1_ENABLED */

static void UsartIf_TxCpltCallback(UART_HandleTypeDef *huart)
{
  /* ADV Trace callback */
  TxCpltCallback(NULL);
}

static void UsartIf_RxCpltCallback(UART_HandleTypeDef *huart)
{
  #if (CFG_HW_USART1_ENABLED == 1)
     RxCpltCallback(&charRx, 1, 0);
     HAL_UART_Receive_IT(&huart1, &charRx, 1);
  #endif  /* CFG_HW_USART1_ENABLED */
}

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */