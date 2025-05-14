[#ftl]
/**
  ******************************************************************************
  * @file    usbh_diskio_config.h
  * @author  MCD Application Team
  * @brief   Template for the usbh_diskio_config.h. This file should be copied and
             under project.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */


[#assign USB_BLOCK_SIZE="512"]

[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
      [#if (definition.name == "USB_BLOCK_SIZE")]
        [#assign USB_BLOCK_SIZE = definition.value]
      [/#if]
    [/#list]
  [/#if]
[/#list]

#ifndef USBH_DISKIO_CONFIG_H
#define USBH_DISKIO_CONFIG_H


#ifdef __cplusplus
extern "C" {
#endif
/* Includes ------------------------------------------------------------------*/

#include "usbh_msc.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Block size */
#define USB_BLOCK_SIZE ${USB_BLOCK_SIZE}

extern USBH_HandleTypeDef hUsbHost;

/* Default handle used in usbh_diskio.c file */
#define hUsb_Host hUsbHost

#ifdef __cplusplus
}
#endif

#endif /* USBH_DISKIO_CONFIG_H */