[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    sgfx_command.h
  * @author  MCD Application Team
  * @brief   Header for sgfx_command.c
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __SGFX_COMMAND_H__
#define __SGFX_COMMAND_H__

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
  * @param CmdProcessNotify cb to signal application that character has been received
  */
void CMD_Init(void (*CmdProcessNotify)(void));

/**
  * @brief Process the command
  */
void CMD_Process(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __SGFX_COMMAND_H__*/

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
