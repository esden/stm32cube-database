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
[#if !BspIpDatas??]

/*
 *	(!) No platform settings set in Cube MX for the MW STM32_WPAN. The Logs will not be used (!)
 *
 *	--------------------------------------------------------------------
 *	If you intend to use the Logs, please follow the procedure below :
 *	--------------------------------------------------------------------
 *
 *	1.	Open your project on Cube MX.
 *
 *	2.	Click on the MW "STM32_WPAN".
 *
 *	3.	Click on the "Configuration" panel.
 *
 *	4.	Open the sub-section "Application configuration - Logs".
 *
 *	5.	Enable one of the following according to your needs :
 *		. CFG_LOG_INSERT_TIME_STAMP_INSIDE_THE_TRACE
 *		. CFG_LOG_SUPPORTED
 *
 *	6.	Click on the "Platform Settings" panel.
 *
 *	7.	Select the BSP you'll use for the Logs. It can be one of the following :
 *		In order to select them, you need to activate the corresponding IP beforehand in Cube MX.
 *		. USART1
 *		. USART2
 *		. LPUART1
 *
 */
[/#if]
[#assign nbInstance = 0]
[#assign myHash = {}]
[#if BspIpDatas??]
	[#list BspIpDatas as SWIP]
		[#if SWIP.variables??]
			[#list SWIP.variables as variables]
				[#assign myHash = {variables.name + nbInstance:variables.value} + myHash]
				[#if variables.name?contains("BoardName")]
					[#assign nbInstance=nbInstance+1]
				[/#if]
			[/#list]
		[/#if]
	[/#list]
[/#if]
[#--

Key & Value:
[#list myHash?keys as key]
Key: ${key}; Value: ${myHash[key]}
[/#list]
nbInstance : ${nbInstance}

--]
[#assign is_for_BLE_TM_and_BLE_Skeleton_only = 0]
[#if nbInstance == 1]
	[#if myHash["bspName0"]?contains("Serial Link for CubeMonitor RF") && !myHash["bspName0"]?contains("Serial Link for Logs")]
		[#assign is_for_BLE_TM_and_BLE_Skeleton_only=is_for_BLE_TM_and_BLE_Skeleton_only+1]
	[/#if]
[/#if]
[#if nbInstance == 2]
	[#if myHash["bspName0"]?contains("Serial Link for CubeMonitor RF") || myHash["bspName1"]?contains("Serial Link for CubeMonitor RF")
	&& !myHash["bspName0"]?contains("Serial Link for Logs") && !myHash["bspName1"]?contains("Serial Link for Logs")]
		[#assign is_for_BLE_TM_and_BLE_Skeleton_only=is_for_BLE_TM_and_BLE_Skeleton_only+1]
	[/#if]
[/#if]
[#if is_for_BLE_TM_and_BLE_Skeleton_only != 0]

/**
 *	THIS FILE IS NOT USED FOR BLE TM.
 *	THE SERIAL LINK IS DIRECTLY USED ON app_ble.c side.
 */
[/#if]

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
#define IRQ_BADIRQ       ((IRQn_Type)(-666))
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* External variables --------------------------------------------------------*/
[#if BspIpDatas??]
	[#list 0..(nbInstance-1) as i]
		[#if myHash["bspName"+i] == "Serial Link for Logs"]
/**
  * @brief ${myHash["IpInstance"+i]} handle
  */
extern UART_HandleTypeDef h${myHash["IpInstance"+i]?lower_case?replace("s","")};
		[/#if]
	[/#list]
[/#if]

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

/* Private variables ---------------------------------------------------------*/
[#if BspIpDatas??]
	[#list 0..(nbInstance-1) as i]
		[#if myHash["bspName"+i] == "Serial Link for Logs"]
uint8_t receive_after_transmit = 0; /* Whether the UART should be in RX after a Transmit */

/**
  * @brief buffer to receive 1 character
  */
uint8_t charRx;

		[/#if]
	[/#list]
[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Private function prototypes -----------------------------------------------*/
[#if BspIpDatas??]
	[#list 0..(nbInstance-1) as i]
		[#if myHash["bspName"+i] == "Serial Link for Logs"]
/**
  * @brief  TX complete callback
  * @return none
  */
static void (*TxCpltCallback)(void *);
static void (*RxCpltCallback)(uint8_t *pdata, uint16_t size, uint8_t error);

		[/#if]
	[/#list]
[/#if]
[#if BspIpDatas??]
	[#list 0..(nbInstance-1) as i]
		[#if myHash["bspName"+i] == "Serial Link for Logs"]
static void ${myHash["IpInstance"+i]}_DMA_MspDeInit(void);
		[/#if]
	[/#list]
[/#if]

[#if BspIpDatas??]
	[#list 0..(nbInstance-1) as i]
		[#if myHash["bspName"+i] == "Serial Link for Logs"]
static void UsartIf_TxCpltCallback(UART_HandleTypeDef *huart);
static void UsartIf_RxCpltCallback(UART_HandleTypeDef *huart);
static IRQn_Type get_IRQn_Type_from_DMA_HandleTypeDef(DMA_HandleTypeDef * dma_handler);
		[/#if]
	[/#list]
[/#if]

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

UTIL_ADV_TRACE_Status_t UART_Init(  void (*cb)(void *))
{
  /* USER CODE BEGIN UART_Init 1 */

  /* USER CODE END UART_Init 1 */
[#if !BspIpDatas??]

  return UTIL_ADV_TRACE_UNKNOWN_ERROR;

  /* USER CODE BEGIN UART_Init 2 */

  /* USER CODE END UART_Init 2 */
}
[#else]
	[#if is_for_BLE_TM_and_BLE_Skeleton_only != 0]

  return UTIL_ADV_TRACE_UNKNOWN_ERROR;

  /* USER CODE BEGIN UART_Init 2 */

  /* USER CODE END UART_Init 2 */
}
	[#else]

		[#list 0..(nbInstance-1) as i]
			[#if myHash["bspName"+i] == "Serial Link for Logs"]
  MX_${myHash["IpInstance"+i]}_UART_Init();

			[/#if]
		[/#list]
  /* USER CODE BEGIN UART_Init 2 */

  /* USER CODE END UART_Init 2 */

  /* Two layer callbacks: perhaps smarter way to do it? */
  TxCpltCallback = cb;

		[#list 0..(nbInstance-1) as i]
			[#if myHash["bspName"+i] == "Serial Link for Logs"]
  h${myHash["IpInstance"+i]?lower_case?replace("s","")}.TxCpltCallback = UsartIf_TxCpltCallback;

			[/#if]
		[/#list]

  /* USER CODE BEGIN UART_Init 3 */

  /* USER CODE END UART_Init 3 */

  /* USER CODE BEGIN UART_Init 4 */

  /* USER CODE END UART_Init 4 */

  return UTIL_ADV_TRACE_OK;
}
	[/#if]
[/#if]

UTIL_ADV_TRACE_Status_t UART_DeInit( void )
{
[#if !BspIpDatas??]
  /* USER CODE BEGIN UART_DeInit 1 */

  /* USER CODE END UART_DeInit 1 */

  /* USER CODE BEGIN UART_DeInit 2 */

  /* USER CODE END UART_DeInit 2 */

  return UTIL_ADV_TRACE_UNKNOWN_ERROR;
}
[#else]
	[#if is_for_BLE_TM_and_BLE_Skeleton_only != 0]
  /* USER CODE BEGIN UART_DeInit 1 */

  /* USER CODE END UART_DeInit 1 */

  /* USER CODE BEGIN UART_DeInit 2 */

  /* USER CODE END UART_DeInit 2 */

  return UTIL_ADV_TRACE_UNKNOWN_ERROR;
}
	[#else]	
  IRQn_Type use_dma;
  HAL_StatusTypeDef result;

  /* USER CODE BEGIN UART_DeInit 1 */

  /* USER CODE END UART_DeInit 1 */

		[#list 0..(nbInstance-1) as i]
			[#if myHash["bspName"+i] == "Serial Link for Logs"]
  ${myHash["IpInstance"+i]}_DMA_MspDeInit();
			[/#if]
		[/#list]

  /* USER CODE BEGIN UART_DeInit 2 */

  /* USER CODE END UART_DeInit 2 */

		[#list 0..(nbInstance-1) as i]
			[#if myHash["bspName"+i] == "Serial Link for Logs"]
  result = HAL_UART_DeInit(&h${myHash["IpInstance"+i]?lower_case?replace("s","")});
  if (result != HAL_OK)
  {
    h${myHash["IpInstance"+i]?lower_case?replace("s","")}.TxCpltCallback = NULL;
    return UTIL_ADV_TRACE_UNKNOWN_ERROR;
  }

			[/#if]
		[/#list]

  /* USER CODE BEGIN UART_DeInit 3 */

  /* USER CODE END UART_DeInit 3 */

		[#list 0..(nbInstance-1) as i]
			[#if myHash["bspName"+i] == "Serial Link for Logs"]
  use_dma = get_IRQn_Type_from_DMA_HandleTypeDef(h${myHash["IpInstance"+i]?lower_case?replace("s","")}.hdmatx);

  if (use_dma == GPDMA1_Channel0_IRQn || use_dma == GPDMA1_Channel1_IRQn
      || use_dma == GPDMA1_Channel2_IRQn || use_dma == GPDMA1_Channel3_IRQn
      || use_dma == GPDMA1_Channel4_IRQn || use_dma == GPDMA1_Channel5_IRQn
      || use_dma == GPDMA1_Channel6_IRQn || use_dma == GPDMA1_Channel7_IRQn)
  {
    result = HAL_DMA_DeInit(h${myHash["IpInstance"+i]?lower_case?replace("s","")}.hdmatx);
    if (result != HAL_OK)
    {
      return UTIL_ADV_TRACE_UNKNOWN_ERROR;
    }
  }

			[/#if]
		[/#list]

  /* USER CODE BEGIN UART_DeInit 4 */

  /* USER CODE END UART_DeInit 4 */

		[#list 0..(nbInstance-1) as i]
			[#if myHash["bspName"+i] == "Serial Link for Logs"]
  use_dma = get_IRQn_Type_from_DMA_HandleTypeDef(h${myHash["IpInstance"+i]?lower_case?replace("s","")}.hdmarx);

  if (use_dma == GPDMA1_Channel0_IRQn || use_dma == GPDMA1_Channel1_IRQn
      || use_dma == GPDMA1_Channel2_IRQn || use_dma == GPDMA1_Channel3_IRQn
      || use_dma == GPDMA1_Channel4_IRQn || use_dma == GPDMA1_Channel5_IRQn
      || use_dma == GPDMA1_Channel6_IRQn || use_dma == GPDMA1_Channel7_IRQn)
  {
    result = HAL_DMA_DeInit(h${myHash["IpInstance"+i]?lower_case?replace("s","")}.hdmarx);
    if (result != HAL_OK)
    {
      return UTIL_ADV_TRACE_UNKNOWN_ERROR;
    }
  }

			[/#if]
		[/#list]

  /* USER CODE BEGIN UART_DeInit 5 */

  /* USER CODE END UART_DeInit 5 */

  /* USER CODE BEGIN UART_DeInit 6 */

  /* USER CODE END UART_DeInit 6 */

  return UTIL_ADV_TRACE_OK;
}
	[/#if]
[/#if]

UTIL_ADV_TRACE_Status_t UART_StartRx(void (*cb)(uint8_t *pdata, uint16_t size, uint8_t error))
{
[#if !BspIpDatas??]
  /* USER CODE BEGIN UART_StartRx 1 */

  /* USER CODE END UART_StartRx 1 */

  /* USER CODE BEGIN UART_StartRx 2 */

  /* USER CODE END UART_StartRx 2 */

  return UTIL_ADV_TRACE_UNKNOWN_ERROR;
}
[#else]
	[#if is_for_BLE_TM_and_BLE_Skeleton_only != 0]
  /* USER CODE BEGIN UART_StartRx 1 */

  /* USER CODE END UART_StartRx 1 */

  /* USER CODE BEGIN UART_StartRx 2 */

  /* USER CODE END UART_StartRx 2 */

  return UTIL_ADV_TRACE_UNKNOWN_ERROR;
}
	[#else]
  /* USER CODE BEGIN UART_StartRx 1 */

  /* USER CODE END UART_StartRx 1 */

		[#list 0..(nbInstance-1) as i]
			[#if myHash["bspName"+i] == "Serial Link for Logs"]
  /* Configure UART1 in Receive mode */
  HAL_UART_Receive_IT(&h${myHash["IpInstance"+i]?lower_case?replace("s","")}, &charRx, 1);
  h${myHash["IpInstance"+i]?lower_case?replace("s","")}.RxCpltCallback = &UsartIf_RxCpltCallback;

			[/#if]
		[/#list]
  if (cb != NULL)
  {
    RxCpltCallback = cb;
  }

  /* USER CODE BEGIN UART_StartRx 2 */

  /* USER CODE END UART_StartRx 2 */

  /* USER CODE BEGIN UART_StartRx 3 */

  /* USER CODE END UART_StartRx 3 */

  return UTIL_ADV_TRACE_OK;
}
	[/#if]
[/#if]

UTIL_ADV_TRACE_Status_t UART_TransmitDMA ( uint8_t *pdata, uint16_t size )
{
[#if !BspIpDatas??]
  /* USER CODE BEGIN UART_TransmitDMA 1 */

  /* USER CODE END UART_TransmitDMA 1 */

  /* USER CODE BEGIN UART_TransmitDMA 2 */

  /* USER CODE END UART_TransmitDMA 2 */

  return UTIL_ADV_TRACE_UNKNOWN_ERROR;
}
[#else]
	[#if is_for_BLE_TM_and_BLE_Skeleton_only != 0]
  /* USER CODE BEGIN UART_TransmitDMA 1 */

  /* USER CODE END UART_TransmitDMA 1 */

  /* USER CODE BEGIN UART_TransmitDMA 2 */

  /* USER CODE END UART_TransmitDMA 2 */

  return UTIL_ADV_TRACE_UNKNOWN_ERROR;
}
	[#else]
  HAL_StatusTypeDef result;
  IRQn_Type use_dma_tx;
  UTIL_ADV_TRACE_Status_t status = UTIL_ADV_TRACE_OK;

  /* USER CODE BEGIN UART_TransmitDMA 1 */

  /* USER CODE END UART_TransmitDMA 1 */

  /* USER CODE BEGIN UART_TransmitDMA 2 */

  /* USER CODE END UART_TransmitDMA 2 */

		[#list 0..(nbInstance-1) as i]
			[#if myHash["bspName"+i] == "Serial Link for Logs"]
  use_dma_tx = get_IRQn_Type_from_DMA_HandleTypeDef(h${myHash["IpInstance"+i]?lower_case?replace("s","")}.hdmatx);

  if ( (use_dma_tx == GPDMA1_Channel0_IRQn ) || ( use_dma_tx == GPDMA1_Channel1_IRQn )
      || ( use_dma_tx == GPDMA1_Channel2_IRQn ) || ( use_dma_tx == GPDMA1_Channel3_IRQn )
      || ( use_dma_tx == GPDMA1_Channel4_IRQn ) || ( use_dma_tx == GPDMA1_Channel5_IRQn )
      || ( use_dma_tx == GPDMA1_Channel6_IRQn ) || ( use_dma_tx == GPDMA1_Channel7_IRQn ) )
  {
    result = HAL_UART_Transmit_DMA(&h${myHash["IpInstance"+i]?lower_case?replace("s","")}, pdata, size);
  }
  else
  {
    result = HAL_UART_Transmit_IT(&h${myHash["IpInstance"+i]?lower_case?replace("s","")}, pdata, size);
  }

  if (result != HAL_OK)
  {
    status = UTIL_ADV_TRACE_HW_ERROR;
  }

  /* Check whether the UART should return in Receiver mode */
  if(receive_after_transmit)
  {
    HAL_UART_Receive_IT(&h${myHash["IpInstance"+i]?lower_case?replace("s","")}, &charRx, 1);
  }

			[/#if]
		[/#list]
  /* USER CODE BEGIN UART_TransmitDMA 3 */

  /* USER CODE END UART_TransmitDMA 3 */

  /* USER CODE BEGIN UART_TransmitDMA 4 */

  /* USER CODE END UART_TransmitDMA 4 */

  return status;
}
	[/#if]
[/#if]

[#if !BspIpDatas??]
[#else]
	[#if is_for_BLE_TM_and_BLE_Skeleton_only == 0]
		[#list 0..(nbInstance-1) as i]
			[#if myHash["bspName"+i] == "Serial Link for Logs"]
static void ${myHash["IpInstance"+i]}_DMA_MspDeInit(void)
{
  IRQn_Type use_dma_tx;

  /* USER CODE BEGIN ${myHash["IpInstance"+i]}_DMA_MspDeInit 1 */

  /* USER CODE END ${myHash["IpInstance"+i]}_DMA_MspDeInit 1 */

  /* Disable ${myHash["IpInstance"+i]} clock */
  __HAL_RCC_${myHash["IpInstance"+i]}_CLK_DISABLE();

  /* Disable interrupts for ${myHash["IpInstance"+i]} */
  HAL_NVIC_DisableIRQ(${myHash["IpInstance"+i]}_IRQn);

  /* GPDMA1 controller clock disable */
  __HAL_RCC_GPDMA1_CLK_DISABLE();

  /* DMA interrupt init */
  use_dma_tx = get_IRQn_Type_from_DMA_HandleTypeDef(h${myHash["IpInstance"+i]?lower_case?replace("s","")}.hdmatx);

  if ( use_dma_tx != IRQ_BADIRQ )
  {
    HAL_NVIC_DisableIRQ(use_dma_tx);
  }

  /* USER CODE BEGIN ${myHash["IpInstance"+i]}_DMA_MspDeInit 2 */

  /* USER CODE END ${myHash["IpInstance"+i]}_DMA_MspDeInit 2 */
}
			[/#if]
		[/#list]
	[/#if]
[/#if]

[#if !BspIpDatas??]
[#else]
	[#if is_for_BLE_TM_and_BLE_Skeleton_only == 0]
static void UsartIf_TxCpltCallback(UART_HandleTypeDef *huart)
{
  /* USER CODE BEGIN UsartIf_TxCpltCallback 1 */

  /* USER CODE END UsartIf_TxCpltCallback 1 */

  /* ADV Trace callback */
  TxCpltCallback(NULL);

  /* USER CODE BEGIN UsartIf_TxCpltCallback 2 */

  /* USER CODE END UsartIf_TxCpltCallback 2 */
}

static void UsartIf_RxCpltCallback(UART_HandleTypeDef *huart)
{
  /* USER CODE BEGIN UsartIf_RxCpltCallback 1 */

  /* USER CODE END UsartIf_RxCpltCallback 1 */

  RxCpltCallback(&charRx, 1, 0);
		[#list 0..(nbInstance-1) as i]
			[#if myHash["bspName"+i] == "Serial Link for Logs"]
  HAL_UART_Receive_IT(&h${myHash["IpInstance"+i]?lower_case?replace("s","")}, &charRx, 1);
			[/#if]
		[/#list]

  /* USER CODE BEGIN UsartIf_RxCpltCallback 2 */

  /* USER CODE END UsartIf_RxCpltCallback 2 */
}

/**
  * The purpose of this function is to match a DMA_HandleTypeDef as key with the corresponding IRQn_Type as value.
  *
  * TAKE CARE : in case of an invalid parameter or e.g. an usart/lpuart not initialized, this will lead to hard fault.
  *             it is up to the user to ensure the serial link is in a valid state.
  */
static IRQn_Type get_IRQn_Type_from_DMA_HandleTypeDef(DMA_HandleTypeDef * dma_handler)
{
  if (dma_handler->Instance == GPDMA1_Channel0) { return GPDMA1_Channel0_IRQn; }
  if (dma_handler->Instance == GPDMA1_Channel1) { return GPDMA1_Channel1_IRQn; }
  if (dma_handler->Instance == GPDMA1_Channel2) { return GPDMA1_Channel2_IRQn; }
  if (dma_handler->Instance == GPDMA1_Channel3) { return GPDMA1_Channel3_IRQn; }
  if (dma_handler->Instance == GPDMA1_Channel4) { return GPDMA1_Channel4_IRQn; }
  if (dma_handler->Instance == GPDMA1_Channel5) { return GPDMA1_Channel5_IRQn; }
  if (dma_handler->Instance == GPDMA1_Channel6) { return GPDMA1_Channel6_IRQn; }
  if (dma_handler->Instance == GPDMA1_Channel7) { return GPDMA1_Channel7_IRQn; }

  /* Values from (-1) to (-15) are already in used. This value isn't used so it should be safe.
     So, if you see this value, it means you used an invalid DMA handler as input. */
  return IRQ_BADIRQ;
}
	[/#if]
[/#if]

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
