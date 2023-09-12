[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_azure_rtos.h
  * @author  MCD Application Team
  * @brief   app_azure_rtos application header file
  ******************************************************************************
 [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */


[#assign TX_ENABLED = "true"]
[#assign FX_ENABLED = "false"]
[#assign NX_ENABLED = "false"]
[#assign UX_HOST_ENABLED = "false"]
[#assign UX_DEVICE_ENABLED = "false"]
[#assign USBPD_DEVICE_ENABLED = "false"]
[#assign TOUCHSENSING_ENABLED = "false"]
[#assign GUI_INTERFACE_ENABLED = "false"]
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
	
    [#if name == "FILEX_ENABLED" && value == "true"]
      [#assign FX_ENABLED = value]
    [/#if]    
	[#if name == "NETXDUO_ENABLED" && value == "true"]
      [#assign NX_ENABLED = value]
    [/#if]
	[#if name == "USBXDEVICE_ENABLED" && value == "true"]
      [#assign UX_DEVICE_ENABLED = value]
    [/#if]
	[#if name == "USBXHOST_ENABLED" && value == "true"]
      [#assign UX_HOST_ENABLED = value]
    [/#if]
	[#if name == "USBPD_ENABLED" && value == "true"]
      [#assign USBPD_DEVICE_ENABLED = value]
    [/#if]
	[#if name == "TSC_ENABLED" && value == "true"]
      [#assign TOUCHSENSING_ENABLED = value]
    [/#if]
    [#if name == "GUI_INTERFACE_ENABLED" && value == "true"]
      [#assign GUI_INTERFACE_ENABLED = value]
    [/#if]
	
    [/#list]
[/#if]
[/#list]
[/#compress]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef APP_AZURE_RTOS_H
#define APP_AZURE_RTOS_H
#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/

#include "${FamilyName?lower_case}xx_hal.h"
#include "app_azure_rtos_config.h"
[#if TX_ENABLED == "true"]
#include "app_threadx.h"
[/#if]
[#if FX_ENABLED == "true"]
#include "app_filex.h"
[/#if]

[#if NX_ENABLED == "true"]
#include "app_netxduo.h"
[/#if]

[#if UX_HOST_ENABLED == "true"]
#include "app_usbx_host.h"
[/#if]

[#if UX_DEVICE_ENABLED == "true"]
#include "app_usbx_device.h"
[/#if]
[#if USBPD_DEVICE_ENABLED == "true"]
#include "usbpd.h"
[/#if]
[#if TOUCHSENSING_ENABLED == "true"]
#include "touchsensing.h"
[/#if]
[#if GUI_INTERFACE_ENABLED == "true"]
#include "gui_api.h"
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

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

#ifdef __cplusplus
}
#endif
#endif /* APP_AZURE_RTOS_H */

