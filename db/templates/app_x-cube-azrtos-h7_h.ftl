[#ftl]

[#assign moduleName = "none"]
[#if ModuleName??]
    [#assign moduleName = ModuleName]
[/#if]

/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_${moduleName?lower_case}.h
  * @author  MCD Application Team
  * @brief   ${moduleName?lower_case} application header file
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
#ifndef APP_${ModuleName?upper_case?replace("-","_")}_H
#define APP_${ModuleName?upper_case?replace("-","_")}_H
#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if RTEdatas??]
[#list RTEdatas as define]

[#if define?contains("THREADX_ENABLED")]
#include "app_threadx.h"
[/#if]

[#if define?contains("FILEX_ENABLED")]
#include "app_filex.h"
[/#if]

[#if define?contains("NETXDUO_ENABLED")]
#include "app_netxduo.h"
[/#if]

[#if define?contains("USBXHOST_ENABLED")]
#include "app_usbx_host.h"
[/#if]

[#if define?contains("USBXDEVICE_ENABLED")]
#include "app_usbx_device.h"
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
void ${fctName}(void);
void ${fctProcessName}(void);
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

#ifdef __cplusplus
}
#endif

#endif /* APP_${ModuleName?upper_case?replace("-","_")}_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
