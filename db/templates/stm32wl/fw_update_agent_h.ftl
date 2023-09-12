[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    fw_update_agent.h
  * @author  MCD Application Team
  * @brief   This file provides set of functions to manage Firmware Update functionalities.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __FW_UPDATE_AGENT_H__
#define __FW_UPDATE_AGENT_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "platform.h"
#include "frag_decoder_if.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
#if (INTEROP_TEST_MODE == 0)
/**
  * @brief  Run FW Update process.
  * @param  None
  * @retval None
  */
void FwUpdateAgent_Run(void);
#endif /* INTEROP_TEST_MODE == 0 */

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__FW_UPDATE_AGENT_H__*/
