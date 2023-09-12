[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ux_device_mouse.h
  * @author  MCD Application Team
  * @brief   USBX Device Mouse header file
  ******************************************************************************
  [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __UX_DEVICE_MOUSE_H__
#define __UX_DEVICE_MOUSE_H__

#ifdef __cplusplus
extern "C" {
#endif
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
    [#if name == "REG_UX_DEVICE_HID_MOUSE"]
      [#assign REG_UX_DEVICE_HID_MOUSE_value = value]
    [/#if]
   [/#list]
[/#if]
[/#list]
[/#compress]
/* Includes ------------------------------------------------------------------*/
#include "ux_api.h"
#include "ux_device_class_hid.h"
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
[#if REG_UX_DEVICE_HID_MOUSE_value == "1"]
VOID USBD_HID_Mouse_Activate(VOID *hid_instance);
VOID USBD_HID_Mouse_Deactivate(VOID *hid_instance);
UINT USBD_HID_Mouse_SetReport(UX_SLAVE_CLASS_HID *hid_instance,
                              UX_SLAVE_CLASS_HID_EVENT *hid_event);
UINT USBD_HID_Mouse_GetReport(UX_SLAVE_CLASS_HID *hid_instance,
                              UX_SLAVE_CLASS_HID_EVENT *hid_event);

[/#if]
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
#endif  /* __UX_DEVICE_MOUSE_H__ */

