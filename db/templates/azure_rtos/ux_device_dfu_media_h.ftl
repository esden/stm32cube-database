[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ux_device_dfu_media.h
  * @author  MCD Application Team
  * @brief   USBX Device DFU interface header file
  ******************************************************************************
  [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __UX_DEVICE_DFU_MEDIA_H__
#define __UX_DEVICE_DFU_MEDIA_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "ux_api.h"
#include "ux_device_class_dfu.h"
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
    [#if name == "REG_UX_DEVICE_DFU"]
      [#assign REG_UX_DEVICE_DFU_value = value]
    [/#if]
   [/#list]
[/#if]
[/#list]
[/#compress]

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
[#if REG_UX_DEVICE_DFU_value == "1"]
VOID USBD_DFU_Activate(VOID *dfu_instance);
VOID USBD_DFU_Deactivate(VOID *dfu_instance);
UINT USBD_DFU_GetStatus(VOID *dfu_instance, ULONG *media_status);
UINT USBD_DFU_Read(VOID *dfu_instance, ULONG block_number, UCHAR *data_pointer,
                   ULONG length, ULONG *actual_length);
UINT USBD_DFU_Write(VOID *dfu_instance, ULONG block_number, UCHAR *data_pointer,
                    ULONG length, ULONG *media_status);
UINT USBD_DFU_Notify(VOID *dfu_instance, ULONG notification);
#ifdef UX_DEVICE_CLASS_DFU_CUSTOM_REQUEST_ENABLE
UINT USBD_DFU_CustomRequest(VOID *dfu_instance, UX_SLAVE_TRANSFER *transfer);
#endif /* UX_DEVICE_CLASS_DFU_CUSTOM_REQUEST_ENABLE */

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
#endif  /* __UX_DEVICE_DFU_MEDIA_H__ */
