[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    LmHandler_mbwrapper.h
  * @author  MCD Application Team
  * @brief   This file implements the ${CPUCORE} side wrapper of the LmHandler
  *          interface shared between M0 and M4.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __LMHANDLER_MBWRAPPER_${CPUCORE}_H__
#define __LMHANDLER_MBWRAPPER_${CPUCORE}_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "mbmux_table.h"

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
[#if CPUCORE == "CM4"]
/**
  * @brief  This function processes the LmHandler events callbacks from CM0+
  * @param  ComObj exchange buffer parameter
  */
void Process_Lora_Notif(MBMUX_ComParam_t *ComObj);
[#else]
/**
  * @brief  This function processes the LmHandler events callbacks from CM4
  * @param  ComObj exchange buffer parameter
  */
void Process_Lora_Cmd(MBMUX_ComParam_t *ComObj);
[/#if]

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__LMHANDLER_MBWRAPPER_${CPUCORE}_H__ */
