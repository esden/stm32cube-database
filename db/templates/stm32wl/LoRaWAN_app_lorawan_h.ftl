[#ftl]
/**
  ******************************************************************************
  * @file    app_lorawan.h
  * @author  MCD Application Team
  * @brief   Header of application of the LRWAN Middleware
   ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __APP_LORAWAN_H__
#define __APP_LORAWAN_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
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

/* Exported Functions Prototypes------------------------------------------------------- */
/**
  * @brief  Init Lora Application
  * @param None
  * @retval None
  */
void MX_LoRaWAN_Init(void);

/**
  * @brief  Entry Lora Process or scheduling
  * @param None
  * @retval None
  */
void MX_LoRaWAN_Process(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__APP_LORAWAN_H__*/

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
