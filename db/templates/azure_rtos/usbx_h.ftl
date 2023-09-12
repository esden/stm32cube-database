[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : app_usbx.h
  * Description        : This file provides code for the configuration
  *                      of the ${name?lower_case} instances.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __usbx_H
#define __usbx_H
#ifdef __cplusplus
 extern "C" {
#endif

[#-- IPdatas is a list of IPconfigModel --] 
/* Includes ------------------------------------------------------------------*/
#include "ux_api.h"

[#assign USBX_HOST_ENABLED = "false" ]
[#assign USBX_DEVICE_ENABLED = "1" ]
 [#compress]
[#if SWIPdatas??]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as variable]
    [#assign value = variable.value]
    [#assign name = variable.name]
[#if name?contains("UX_Host_CoreStack") && value == "1"]
[#assign USBX_HOST_ENABLED = "true" ]
[/#if]
[#if name?contains("UX_Device_CoreStack") && value == "1"]
[#assign USBX_DEVICE_ENABLED = "true" ]
[/#if]
[/#list]
[/#if]
[/#list]
[/#if]
[/#compress]

[#if USBX_DEVICE_ENABLED == "true"]
UINT MX_USBX_Device_Init(VOID *memory_ptr);
[/#if]
[#if USBX_HOST_ENABLED == "true"]
UINT MX_USBX_Host_Init(VOID *memory_ptr);
[/#if]	
UINT MX_USBX_Init(void);

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
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */



/* USER CODE BEGIN 1 */

/* USER CODE END 1 */


#ifdef __cplusplus
 }
#endif
#endif  /* __APP_USBX_DEVICE_H__ */
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/