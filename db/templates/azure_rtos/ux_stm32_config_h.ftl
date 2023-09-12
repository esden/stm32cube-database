[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ux_stm32_config.h
  * @author  MCD Application Team
  * @brief   USBX STM32 config header file
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2020 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under Ultimate Liberty license
  * SLA0044, the "License"; You may not use this file except in compliance with
  * the License. You may obtain a copy of the License at:
  *                             www.st.com/SLA0044
  *
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __UX_STM32_CONFIG_H__
#define __UX_STM32_CONFIG_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "${FamilyName?lower_case}xx_hal.h"

/* USER CODE BEGIN Private Includes */

/* USER CODE BEGIN Private Includes */

/* Private defines -----------------------------------------------------------*/

[#if FamilyName?lower_case == "stm32u5"]
#define UX_DCD_STM32_MAX_ED                   6
#define UX_HCD_STM32_MAX_NB_CHANNELS          12
[/#if]

/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif
#endif  /* __UX_STM32_CONFIG_H__ */
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
