[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ux_device_msc.h
  * @author  MCD Application Team
  * @brief   USBX Device MSC header file
  ******************************************************************************
 [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __UX_DEVICE_MSC_H__
#define __UX_DEVICE_MSC_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "ux_api.h"
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
    [#if name == "REG_UX_DEVICE_STORAGE"]
      [#assign REG_UX_DEVICE_STORAGE_value = value]
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
[#if REG_UX_DEVICE_STORAGE_value == "1"]
VOID USBD_STORAGE_Activate(VOID *storage_instance);
VOID USBD_STORAGE_Deactivate(VOID *storage_instance);
UINT USBD_STORAGE_Read(VOID *storage_instance, ULONG lun, UCHAR *data_pointer,
                       ULONG number_blocks, ULONG lba, ULONG *media_status);
UINT USBD_STORAGE_Write(VOID *storage_instance, ULONG lun, UCHAR *data_pointer,
                        ULONG number_blocks, ULONG lba, ULONG *media_status);
UINT USBD_STORAGE_Flush(VOID *storage_instance, ULONG lun, ULONG number_blocks,
                        ULONG lba, ULONG *media_status);
UINT USBD_STORAGE_Status(VOID *storage_instance, ULONG lun, ULONG media_id,
                         ULONG *media_status);
UINT USBD_STORAGE_Notification(VOID *storage_instance, ULONG lun, ULONG media_id,
                               ULONG notification_class, UCHAR **media_notification,
                               ULONG *media_notification_length);
ULONG USBD_STORAGE_GetMediaLastLba(VOID);
ULONG USBD_STORAGE_GetMediaBlocklength(VOID);

[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

[#if REG_UX_DEVICE_STORAGE_value == "1"]
#ifndef STORAGE_NUMBER_LUN
#define STORAGE_NUMBER_LUN   1
#endif

#ifndef STORAGE_REMOVABLE_FLAG
#define STORAGE_REMOVABLE_FLAG   0x80U
#endif 

#ifndef STORAGE_READ_ONLY
#define STORAGE_READ_ONLY    UX_FALSE
#endif 
[/#if]
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif
#endif  /* __UX_DEVICE_MSC_H__ */
