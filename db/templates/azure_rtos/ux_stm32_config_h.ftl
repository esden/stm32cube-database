[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ux_stm32_config.h
  * @author  MCD Application Team
  * @brief   USBX STM32 config header file
  ******************************************************************************
  [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
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

[#if DIE=="DIE482"]
#define UX_DCD_STM32_MAX_ED                   6
#define UX_HCD_STM32_MAX_NB_CHANNELS          12
[/#if]

[#if DIE=="DIE481" || DIE=="DIE476"]
#define UX_DCD_STM32_MAX_ED                   9
#define UX_HCD_STM32_MAX_NB_CHANNELS          16
[/#if]

[#if DIE=="DIE455"]
#define UX_DCD_STM32_MAX_ED                   8
#define UX_HCD_STM32_MAX_NB_CHANNELS          8
[/#if]

[#if FamilyName?lower_case == "stm32h5"]
#define UX_DCD_STM32_MAX_ED                   8
#define UX_HCD_STM32_MAX_NB_CHANNELS          8
[/#if]

[#if FamilyName?lower_case == "stm32wba"]
#define UX_DCD_STM32_MAX_ED                   8
#define UX_HCD_STM32_MAX_NB_CHANNELS          8
[/#if]

/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif
#endif  /* __UX_STM32_CONFIG_H__ */

