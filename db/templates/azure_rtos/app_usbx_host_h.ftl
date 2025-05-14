[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_usbx_host.h
  * @author  MCD Application Team
  * @brief   USBX Host applicative header file
  ******************************************************************************
  [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __APP_USBX_HOST_H__
#define __APP_USBX_HOST_H__

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
    [#if name == "AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE"]
      [#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE_VAL = value]
    [/#if]
	[#if name == "USBX_HOST_SYS_SIZE"]
      [#assign USBX_HOST_SYS_SIZE_value = value]
    [/#if]
    [#if name == "REG_UX_HOST_HUB"]
      [#assign REG_UX_HOST_HUB_value = value]
    [/#if]
    [#if name == "REG_UX_HOST_HID_MOUSE"]
      [#assign REG_UX_HOST_HID_MOUSE_value = value]
    [/#if]
    [#if name == "REG_UX_HOST_HID_KEYBOARD"]
      [#assign REG_UX_HOST_HID_KEYBOARD_value = value]
    [/#if]
    [#if name == "REG_UX_HOST_Mass_Storage"]
      [#assign REG_UX_HOST_MSC_value = value]
    [/#if]
    [#if name == "REG_UX_HOST_CDC_ACM"]
      [#assign REG_UX_HOST_CDC_ACM_value = value]
    [/#if]
    [#if name == "REG_UX_HOST_CORE"]
    [#assign REG_UX_HOST_CORE_value = value]
    [/#if]
    [#if name == "REG_UX_HOST_THREAD"]
      [#assign REG_UX_HOST_THREAD_value = value]
    [/#if]
    [#if name == "USBX_HOST_APP_THREAD_Size"]
      [#assign USBX_HOST_APP_THREAD_Size_value = value]
    [/#if]
    [#if name == "USBX_HOST_APP_THREAD_PRIO"]
      [#assign USBX_HOST_APP_THREAD_PRIO_value = value]
    [/#if]
    [#if name == "UX_HOST_APP_MEM_POOL_SIZE_STANDALONE"]
      [#assign UX_HOST_APP_MEM_POOL_SIZE_STANDALONE_value = value]
    [/#if]
    [#if name == "REG_UX_HOST_HID_RCU"]
      [#assign REG_UX_HOST_HID_RCU_value = value]
    [/#if]
    [#if name == "UX_STANDALONE"]
      [#assign UX_STANDALONE_ENABLED_Value = value]
    [/#if]

   [/#list]
[/#if]
[/#list]
[/#compress]

/* Includes ------------------------------------------------------------------*/
#include "ux_api.h"
#include "main.h"
[#if REG_UX_HOST_CORE_value == "true"]
[#if REG_UX_HOST_HUB_value??]
[#if REG_UX_HOST_HUB_value == "1"]
#include "ux_host_class_hub.h"
[/#if]
[/#if]
[#if REG_UX_HOST_HID_MOUSE_value == "1"]
#include "ux_host_mouse.h"
[/#if]
[#if REG_UX_HOST_HID_KEYBOARD_value == "1"]
#include "ux_host_keyboard.h"
[/#if]
[#if REG_UX_HOST_HID_RCU_value == "1"]
#include "ux_host_remote_control.h"
[/#if]
[#if REG_UX_HOST_MSC_value == "1"]
#include "ux_host_msc.h"
[/#if]
[#if REG_UX_HOST_CDC_ACM_value == "1"]
#include "ux_host_cdc_acm.h"
[/#if]
[/#if]

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if !FamilyName?lower_case?starts_with("stm32n6")]
[#if UX_STANDALONE_ENABLED_Value == "1" && AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE_VAL  != "0" ]
#define UX_HOST_APP_MEM_POOL_SIZE  ${UX_HOST_APP_MEM_POOL_SIZE_STANDALONE_value}
[/#if]
[#if REG_UX_HOST_CORE_value == "true"]
#define USBX_HOST_MEMORY_STACK_SIZE     ${USBX_HOST_SYS_SIZE_value}
[/#if]
[/#if]

[#if REG_UX_HOST_THREAD_value == "1" && UX_STANDALONE_ENABLED_Value == "0"]

#define UX_HOST_APP_THREAD_STACK_SIZE   ${USBX_HOST_APP_THREAD_Size_value}
#define UX_HOST_APP_THREAD_PRIO         ${USBX_HOST_APP_THREAD_PRIO_value}
[/#if]
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
[#if UX_STANDALONE_ENABLED_Value == "1"]
UINT MX_USBX_Host_Init(VOID);
[#else]
UINT MX_USBX_Host_Init(VOID *memory_ptr);
[/#if]

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

[#if REG_UX_HOST_THREAD_value == "1" && UX_STANDALONE_ENABLED_Value == "0"]
#ifndef UX_HOST_APP_THREAD_NAME
#define UX_HOST_APP_THREAD_NAME  "USBX App Host Main Thread"
#endif

#ifndef UX_HOST_APP_THREAD_PREEMPTION_THRESHOLD
#define UX_HOST_APP_THREAD_PREEMPTION_THRESHOLD  UX_HOST_APP_THREAD_PRIO
#endif

#ifndef UX_HOST_APP_THREAD_TIME_SLICE
#define UX_HOST_APP_THREAD_TIME_SLICE  TX_NO_TIME_SLICE
#endif

#ifndef UX_HOST_APP_THREAD_START_OPTION
#define UX_HOST_APP_THREAD_START_OPTION  TX_AUTO_START
#endif

[/#if]
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif
#endif /* __APP_USBX_HOST_H__ */
