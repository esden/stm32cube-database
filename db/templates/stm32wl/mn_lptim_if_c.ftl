[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    mn_lptim_if.c
  * @author  MCD Application Team
  * @brief   Interface between Sigfox monarch and lptim
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign IpInstance = ""]
[#assign IpName = ""]
[#if BspIpDatas??]
    [#list BspIpDatas as SWIP]
        [#if SWIP.variables??]
            [#list SWIP.variables as variables]
                [#if variables.name?contains("IpInstance")]
                    [#assign IpInstance = variables.value]
                [/#if]
                [#if variables.name?contains("IpName")]
                    [#assign IpName = variables.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]

/* Includes ------------------------------------------------------------------*/
#include "mn_lptim_if.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
/**
  * @brief LPTIM handle
  */
extern LPTIM_HandleTypeDef h${IpInstance?lower_case};

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
void MN_LPTIM_IF_Init(void)
{
  /* USER CODE BEGIN MN_LPTIM_IF_Init_0 */

  /* USER CODE END MN_LPTIM_IF_Init_0 */

  /* Force the ${IpInstance} Peripheral Clock Reset */
  __HAL_RCC_${IpInstance}_FORCE_RESET();
  /* Release the ${IpInstance} Peripheral Clock Reset */
  __HAL_RCC_${IpInstance}_RELEASE_RESET();

  /* USER CODE BEGIN MN_LPTIM_IF_Init_1 */

  /* USER CODE END MN_LPTIM_IF_Init_1 */

  MX_${IpInstance}_Init();

  /* USER CODE BEGIN MN_LPTIM_IF_Init_2 */

  /* USER CODE END MN_LPTIM_IF_Init_2 */

  /* w.a.: LL_EXTI_LINE_X should be enabled in HAL_LPTIM_MspInit */
[#if (IpInstance == "LPTIM1") ]
  LL_EXTI_EnableIT_0_31(LL_EXTI_LINE_29);
[#elseif (IpInstance == "LPTIM2") ]
  LL_EXTI_EnableIT_0_31(LL_EXTI_LINE_30);
[#elseif (IpInstance == "LPTIM3") ]
  LL_EXTI_EnableIT_0_31(LL_EXTI_LINE_31);
[/#if]

  /* USER CODE BEGIN MN_LPTIM_IF_Init_3 */

  /* USER CODE END MN_LPTIM_IF_Init_3 */
}

void MN_LPTIM_IF_DeInit(void)
{
  RCC_PeriphCLKInitTypeDef RCC_PeriphCLKInitStruct;

  /* USER CODE BEGIN MN_LPTIM_IF_DeInit_0 */

  /* USER CODE END MN_LPTIM_IF_DeInit_0 */

  if (HAL_LPTIM_DeInit(&h${IpInstance?lower_case}) != HAL_OK)
  {
    Error_Handler();
  }

  /* USER CODE BEGIN MN_LPTIM_IF_DeInit_1 */

  /* USER CODE END MN_LPTIM_IF_DeInit_1 */

  /* Select the PCLK clock as ${IpInstance} peripheral clock */
  RCC_PeriphCLKInitStruct.PeriphClockSelection = RCC_PERIPHCLK_${IpInstance};
  RCC_PeriphCLKInitStruct.${IpInstance?lower_case?replace("l","L")}ClockSelection = RCC_${IpInstance}CLKSOURCE_PCLK1;
  HAL_RCCEx_PeriphCLKConfig(&RCC_PeriphCLKInitStruct);

  /* USER CODE BEGIN MN_LPTIM_IF_DeInit_2 */

  /* USER CODE END MN_LPTIM_IF_DeInit_2 */

  /* Force the ${IpInstance} Peripheral Clock Reset */
  __HAL_RCC_${IpInstance}_FORCE_RESET();

  /* Release the ${IpInstance} Peripheral Clock Reset */
  __HAL_RCC_${IpInstance}_RELEASE_RESET();

  /* USER CODE BEGIN MN_LPTIM_IF_DeInit_3 */

  /* USER CODE END MN_LPTIM_IF_DeInit_3 */

}

/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/
/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
