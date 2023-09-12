[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : usbh_platform.h
[#--  * @packageVersion : ${fwVersion} --]
  * @brief          : Header for usbh_platform.c file.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __USBH_PLATFORM_H__
#define __USBH_PLATFORM_H__

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "usb_host.h"

/* USER CODE BEGIN INCLUDE */

/* USER CODE END INCLUDE */

[#assign instNameFS = ""]
[#assign instNameHS = ""]
[#list BspIpDatas as SWIP] 
[#if SWIP.ipName?contains("FS")]
	[#assign instNameFS = "FS"] 
[/#if]
[#if SWIP.ipName?contains("HS")]
	[#assign instNameHS = "HS"] 
[/#if]
[/#list]
[#if instNameFS != ""]
void MX_DriverVbusFS(uint8_t state); 
[/#if]
[#if instNameHS != ""]
void MX_DriverVbusHS(uint8_t state); 
[/#if]



#ifdef __cplusplus
}
#endif

#endif /* __USBH_PLATFORM_H__ */

