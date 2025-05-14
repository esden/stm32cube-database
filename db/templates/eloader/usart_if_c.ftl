[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    usart_if.c
  * @author  MCD Application Team
  * @brief   Configuration of UART driver interface for hyperterminal communication
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign UsartInstance = ""]
[#assign IpInstance = ""]
[#if BspIpDatas??]
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
            [/#list]
        [/#if]
    [/#list]
[/#if]

/* Includes ------------------------------------------------------------------*/
#include "usart_if.h"
#include <string.h>

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
/**
  * @brief UART handle
  */
extern UART_HandleTypeDef h${IpInstance?lower_case?replace("s","")};

/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/

/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/

[#--  __weak HAL_StatusTypeDef MX_${UsartInstance}_UART_Init(UART_HandleTypeDef* huart);--]
void MX_EXTMEM_Trace_Init(void)
{
  /* USER CODE BEGIN traceInit_1 */

  /* USER CODE END traceInit_1 */

[#if IpInstance?starts_with("UART")]
  MX_${IpInstance}_Init();
[#else]
  MX_${IpInstance}_UART_Init();
[/#if]

  /* USER CODE BEGIN traceInit_2 */

  /* USER CODE END traceInit_2 */
}

void MX_EXTMEM_Trace_DeInit(void)
{
  /* USER CODE BEGIN traceDeInit_1 */

  /* USER CODE END traceDeInit_1 */

  HAL_UART_MspDeInit(&h${IpInstance?lower_case?replace("s","")});

  /* USER CODE BEGIN traceDeInit_2 */

  /* USER CODE END traceDeInit_2 */
}

void MX_EXTMEM_Trace(uint8_t *p_data)
{
  /* USER CODE BEGIN EXTMEM_TRACE_1 */

  /* USER CODE END EXTMEM_TRACE_1 */

  HAL_UART_Transmit(&h${IpInstance?lower_case?replace("s","")}, p_data, strlen((char *)p_data), 1000);

  /* USER CODE BEGIN EXTMEM_TRACE_2 */

  /* USER CODE END EXTMEM_TRACE_2 */
}

/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
