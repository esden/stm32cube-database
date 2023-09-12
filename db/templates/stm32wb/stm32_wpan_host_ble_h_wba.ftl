[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    host_ble.h
  * @author  MCD Application Team
  * @brief   Header for ${name?remove_beginning("Modules/")?replace(".h", ".c")}
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef HOST_BLE_H
#define HOST_BLE_H

#ifdef __cplusplus
extern "C" {
#endif

  /* Includes ------------------------------------------------------------------*/

  /* Exported types ------------------------------------------------------------*/
  
  /* Exported constants --------------------------------------------------------*/
  /* External variables --------------------------------------------------------*/
  /* Exported macros -----------------------------------------------------------*/
  /* Exported functions ------------------------------------------------------- */
/**
 * @brief  BLE Host initialization
 *
 * @param  None
 * @retval None
 */
uint8_t  HOST_BLE_Init(void);

#ifdef __cplusplus
}
#endif

#endif /*HOST_BLE_H */
