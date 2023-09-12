[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ux_device_rndis.h
  * @author  MCD Application Team
  * @brief   USBX Device RNDIS applicative header file
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2022 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __UX_DEVICE_RNDIS_H__
#define __UX_DEVICE_RNDIS_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "ux_api.h"
#include "ux_device_class_rndis.h"
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
    [#if name == "REG_UX_DEVICE_RNDIS"]
      [#assign REG_UX_DEVICE_RNDIS_value = value]
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
[#if REG_UX_DEVICE_RNDIS_value == "1"]
VOID USBD_RNDIS_Activate(VOID *rndis_instance);
VOID USBD_RNDIS_Deactivate(VOID *rndis_instance);
VOID USBD_RNDIS_GetMacAdd(UCHAR *mac_add, UCHAR *mac_node);
[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

[#if REG_UX_DEVICE_RNDIS_value == "1"]
#ifndef USBD_RNDIS_DRIVER_VERSION
#define USBD_RNDIS_DRIVER_VERSION  0x1127
#endif

[/#if]
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif
#endif  /* __UX_DEVICE_RNDIS_H__ */
