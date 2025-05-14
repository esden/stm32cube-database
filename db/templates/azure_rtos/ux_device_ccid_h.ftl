[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ux_device_ccid.h
  * @author  MCD Application Team
  * @brief   USBX Device CCID header file
  ******************************************************************************
 [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __UX_DEVICE_CCID_H__
#define __UX_DEVICE_CCID_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "ux_api.h"
#include "ux_device_class_ccid.h"
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]

    [#if name == "REG_UX_DEVICE_CCID"]
      [#assign REG_UX_DEVICE_CCID_value = value]
    [/#if]

  [/#list]
[/#if]
[/#list]
[/#compress]

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
[#if REG_UX_DEVICE_CCID_value == "1"]
#include "ux_device_descriptors.h"

[/#if]
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
[#if REG_UX_DEVICE_CCID_value == "1"]
VOID USBD_CCID_Activate(VOID *ccid_instance);
VOID USBD_CCID_Deactivate(VOID *ccid_instance);

UINT USBD_CCID_icc_power_on(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg);
UINT USBD_CCID_icc_power_off(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg);
UINT USBD_CCID_get_slot_status(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg);
UINT USBD_CCID_xfr_block(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg);
UINT USBD_CCID_get_parameters(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg);
UINT USBD_CCID_reset_parameters(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg);
UINT USBD_CCID_set_parameters(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg);
UINT USBD_CCID_escape(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg);
UINT USBD_CCID_icc_clock(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg);
UINT USBD_CCID_t0_apdu(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg);
UINT USBD_CCID_secure(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg);
UINT USBD_CCID_mechanical(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg);
UINT USBD_CCID_abort(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg);
UINT USBD_CCID_set_data_rate_and_clock_frequency(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg);

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
#endif  /* __UX_DEVICE_CCID_H__ */
