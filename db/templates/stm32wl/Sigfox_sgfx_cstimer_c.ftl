[#ftl]
/**
  ******************************************************************************
  * @file    sgfx_cstimer.c
  * @author  MCD Application Team
  * @brief   manages carrier sense timer.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "sgfx_cstimer.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
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
static int32_t rxCarrierSenseFlag = 0;

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/
void RxCarrierSenseInitStatus(void)
{
  /* USER CODE BEGIN RxCarrierSenseInitStatus_1 */

  /* USER CODE END RxCarrierSenseInitStatus_1 */
  /*Initialises the Flag*/
  rxCarrierSenseFlag = 0;
  /* USER CODE BEGIN RxCarrierSenseInitStatus_2 */

  /* USER CODE END RxCarrierSenseInitStatus_2 */
}

int32_t RxCarrierSenseGetStatus(void)
{
  /* USER CODE BEGIN RxCarrierSenseGetStatus_1 */

  /* USER CODE END RxCarrierSenseGetStatus_1 */
  return rxCarrierSenseFlag ;
  /* USER CODE BEGIN RxCarrierSenseGetStatus_2 */

  /* USER CODE END RxCarrierSenseGetStatus_2 */
}

void OnTimerTimeoutCsEvt(void *context)
{
  /* USER CODE BEGIN OnTimerTimeoutCsEvt_1 */

  /* USER CODE END OnTimerTimeoutCsEvt_1 */
  rxCarrierSenseFlag = 1;
  /* USER CODE BEGIN OnTimerTimeoutCsEvt_2 */

  /* USER CODE END OnTimerTimeoutCsEvt_2 */
}

/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/
/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
