[#ftl]
/**
  ******************************************************************************
  * @file    lora_command.h
  * @author  MCD Application Team
  * @brief   Header for driver command.c module
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __LORA_COMMAND_H__
#define __LORA_COMMAND_H__

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
/* Character added when a RX error has been detected */
#define AT_ERROR_RX_CHAR 0x01

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/**
  * @brief Initializes command module
  *
  * @param [IN] cb to signal appli that character has been received
  * @retval None
  */
void CMD_Init(void (*CmdProcessNotify)(void));

/**
  * @brief Process the command
  *
  * @param [IN] None
  * @retval None
  */
void CMD_Process(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __LORA_COMMAND_H__*/

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
