[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    tm.h
  * @author  MCD Application Team
  * @brief   Transparent mode interface
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign BLE_MODE_TRANSPARENT_UART = 0]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
            [#if (definition.name == "BLE_MODE_TRANSPARENT_UART") && (definition.value == "1")]
                [#assign BLE_MODE_TRANSPARENT_UART = 1]
            [/#if]
        [/#list]
	[/#if]
[/#list]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef TM_H
#define TM_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "tl.h"

/* Private includes ----------------------------------------------------------*/
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

/* Exported macros ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions ---------------------------------------------*/
  /**
   * @brief  Transparent mode initialization
   *
   * @param  None
   * @retval None
   */
  void TM_Init( void );
  /**
   * @brief  Call back to receive system command response
   *
   * @param  None
   * @retval None
   */
  void TM_SysCmdRspCb(TL_EvtPacket_t * p_cmd_resp);

  /**
   * @brief  Call back to receive system user user
   *
   * @param  None
   * @retval None
   */
  void TM_SysUserEvtRxCb(TL_EvtPacket_t * p_evt_rx);

[#if  (BLE_MODE_TRANSPARENT_UART = 1)]
  /**
   * @brief  Set the low power mode
   *
   * @param  None
   * @retval None
   */
  void TM_SetLowPowerMode( void );

[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*TM_H */
