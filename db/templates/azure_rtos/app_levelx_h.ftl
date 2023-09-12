[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : app_levelx.h
  * Description        : This file provides code for the configuration
  *                      of the levelx instances.
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
#ifndef __APP_LEVELX_H__
#define __APP_LEVELX_H__

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "lx_api.h"
[#if SWIPdatas??]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as variable]
[#if variable.name?contains("LX_NOR_Simulator_Interface") && variable.value == "1"]
#include "lx_stm32_nor_simulator_driver.h"
[/#if]
[#if variable.name?contains("LX_NOR_Custom_Interface") && variable.value == "1"]
#include "lx_stm32_nor_custom_driver.h"
[/#if]
[#if variable.name?contains("LX_NAND_Simulator_Interface") && variable.value == "1"]
#include "lx_stm32_nand_simulator_driver.h"
[/#if]
[#if variable.name?contains("LX_NAND_Custom_Interface") && variable.value == "1"]
#include "lx_stm32_nand_custom_driver.h"
[/#if]
[#if variable.name?contains("LX_OctoSPI_Memory_Interface") && variable.value == "1"]
#include "lx_stm32_ospi_driver.h"
[/#if]
[/#list]
[/#if]
[/#list]
[/#if]
/* Private includes ----------------------------------------------------------*/
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
void MX_LevelX_Init(void);
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
#ifdef __cplusplus
}
#endif
#endif /* __APP_LEVELX_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/