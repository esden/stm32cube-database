[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_usbx.h
  * @author  MCD Application Team
  * @brief   USBX applicative header file
  ******************************************************************************
 [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __APP_USBX_H__
#define __APP_USBX_H__

#ifdef __cplusplus
extern "C" {
#endif
[#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE_VAL = "1" ]
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
    [#if name == "USBXDEVICE_ENABLED"]
      [#assign USBXDEVICE_ENABLED_value = value]
    [/#if]
	[#if name == "USBXHOST_ENABLED"]
      [#assign USBXHOST_ENABLED_value = value]
    [/#if]
	[#if name == "USBX_SYS_SIZE"]
      [#assign USBX_SYS_SIZE_value = value]
    [/#if]
	[#if name == "UX_APP_MEM_POOL_SIZE_STANDALONE"]
      [#assign UX_APP_MEM_POOL_SIZE_STANDALONE_value = value]
    [/#if]
	[#if name == "UX_STANDALONE"]
      [#assign UX_STANDALONE_ENABLED_Value = value]
    [/#if]
	[#if name == "AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE"]
	  [#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE_VAL = value]
	[/#if]
   [/#list]
[/#if]
[/#list]
[/#compress]


/* Includes ------------------------------------------------------------------*/
#include "ux_api.h"

[#if USBXDEVICE_ENABLED_value == "true"]
#include "app_usbx_device.h"
[/#if]
[#if USBXHOST_ENABLED_value == "true"]
#include "app_usbx_host.h"
[/#if]

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if UX_STANDALONE_ENABLED_Value == "1" && AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE_VAL  != "0" ]
#define USBX_APP_MEM_POOL_SIZE       ${UX_APP_MEM_POOL_SIZE_STANDALONE_value}
[/#if]
#define USBX_MEMORY_STACK_SIZE       ${USBX_SYS_SIZE_value}

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported functions prototypes ---------------------------------------------*/
[#if UX_STANDALONE_ENABLED_Value == "0"]
UINT MX_USBX_Init(VOID *memory_ptr);
[#else]
UINT MX_USBX_Init(VOID);
[/#if]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif
#endif /* __APP_USBX_H__ */