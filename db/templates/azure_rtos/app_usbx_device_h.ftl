[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_usbx_device.h
  * @author  MCD Application Team
  * @brief   USBX Device applicative header file
  ******************************************************************************
 [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __APP_USBX_DEVICE_H__
#define __APP_USBX_DEVICE_H__

#ifdef __cplusplus
extern "C" {
#endif

[#assign USBX_DEVICE_CLASS_NB = 0]
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
    [#if name == "USBX_DEVICE_SYS_SIZE"]
      [#assign USBX_DEVICE_SYS_SIZE_value = value]
    [/#if]
    [#if name == "USBX_DEVICE_APP_THREAD_PRIO"]
      [#assign USBX_DEVICE_APP_THREAD_PRIO_value = value]
    [/#if]
    [#if name == "USBX_DEVICE_APP_THREAD_NAME"]
      [#assign USBX_DEVICE_APP_THREAD_NAME_value = value]
    [/#if]
    [#if name == "USBX_DEVICE_APP_THREAD_Size"]
      [#assign USBX_DEVICE_APP_THREAD_Size_value = value]
    [/#if]
    [#if name == "UX_Device_CoreStack"]
      [#assign UX_Device_CoreStack_value = value]
    [/#if]
    [#if name == "UX_DEVICE_HID_CORE"]
      [#assign UX_DEVICE_HID_CORE_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_HID_MOUSE"]
      [#assign REG_UX_DEVICE_HID_MOUSE_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_HID_KEYBOARD"]
      [#assign REG_UX_DEVICE_HID_KEYBOARD_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_HID_CUSTOM"]
      [#assign REG_UX_DEVICE_HID_CUSTOM_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_STORAGE"]
      [#assign REG_UX_DEVICE_STORAGE_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_CDC_ACM"]
      [#assign REG_UX_DEVICE_CDC_ACM_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_CDC_ECM"]
      [#assign REG_UX_DEVICE_CDC_ECM_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_DFU"]
      [#assign REG_UX_DEVICE_DFU_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_PIMA_MTP"]
      [#assign REG_UX_DEVICE_PIMA_MTP_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_RNDIS"]
      [#assign REG_UX_DEVICE_RNDIS_value = value]
    [/#if]
    [#if name == "REG_USBX_DEVICE_CON_CK"]
      [#assign REG_USBX_DEVICE_CON_CK_value = value]
    [/#if]
   [/#list]
[/#if]
[/#list]
[/#compress]
/* Includes ------------------------------------------------------------------*/
#include "ux_api.h"
[#if UX_DEVICE_HID_CORE_value == "1"]
#include "ux_device_class_hid.h"
[/#if]
[#if UX_Device_CoreStack_value  == "1"]
[#if REG_UX_DEVICE_HID_MOUSE_value == "1"]
[#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
#include "ux_device_mouse.h"
[/#if]
[#if REG_UX_DEVICE_HID_KEYBOARD_value == "1"]
[#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
#include "ux_device_keyboard.h"
[/#if]
[#if REG_UX_DEVICE_HID_CUSTOM_value == "1"]
[#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
#include "ux_device_customhid.h"
[/#if]
[#if REG_UX_DEVICE_STORAGE_value == "1"]
[#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
#include "ux_device_msc.h"
[/#if]
[#if REG_UX_DEVICE_CDC_ACM_value == "1"]
[#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
#include "ux_device_cdc_acm.h"
[/#if]
[#if REG_UX_DEVICE_CDC_ECM_value == "1"]
[#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
#include "ux_device_cdc_ecm.h"
[/#if]
[#if REG_UX_DEVICE_DFU_value == "1"]
[#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
#include "ux_device_dfu_media.h"
[/#if]
[#if REG_UX_DEVICE_PIMA_MTP_value == "1"]
[#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
#include "ux_device_pima_mtp.h"
[/#if]
[#if REG_UX_DEVICE_RNDIS_value == "1"]
[#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
#include "ux_device_rndis.h"
[/#if]
[#if USBX_DEVICE_CLASS_NB != 0 ]
#include "ux_device_descriptors.h"
[/#if]
[/#if]
#include "app_azure_rtos_config.h"
#include "ux_dcd_stm32.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
#define USBX_DEVICE_MEMORY_STACK_SIZE       ${USBX_DEVICE_SYS_SIZE_value}

#define UX_DEVICE_APP_THREAD_STACK_SIZE   ${USBX_DEVICE_APP_THREAD_Size_value}
#define UX_DEVICE_APP_THREAD_PRIO         ${USBX_DEVICE_APP_THREAD_PRIO_value}

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
UINT MX_USBX_Device_Init(VOID *memory_ptr);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */
#ifndef UX_DEVICE_APP_THREAD_NAME
#define UX_DEVICE_APP_THREAD_NAME  "USBX Device App Main Thread"
#endif

#ifndef UX_DEVICE_APP_THREAD_PREEMPTION_THRESHOLD
#define UX_DEVICE_APP_THREAD_PREEMPTION_THRESHOLD  UX_DEVICE_APP_THREAD_PRIO
#endif

#ifndef UX_DEVICE_APP_THREAD_TIME_SLICE
#define UX_DEVICE_APP_THREAD_TIME_SLICE  TX_NO_TIME_SLICE
#endif

#ifndef UX_DEVICE_APP_THREAD_START_OPTION
#define UX_DEVICE_APP_THREAD_START_OPTION  TX_AUTO_START
#endif

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif
#endif /* __APP_USBX_DEVICE_H__ */
