[#ftl]
/* USER CODE BEGIN Header */
[#assign s = "App/usbd_desc.h"]
[#assign titi = s?replace("App/","")]
[#assign toto = titi?replace(".","_")]
/**
  ******************************************************************************
  * @file           ${titi}
  * @author         MCD Application Team
[#--  * @packageVersion : ${fwVersion} --]
  * @brief          Header for usbd_desc.c file.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */  
[#assign inclusion_protection = toto?upper_case]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${inclusion_protection}
#define __${inclusion_protection}


[#assign className = ""]
[#list SWIPdatas as SWIP]
	[#compress]
		[#if SWIP.parameters??]
			[#if SWIP.parameters?contains("MSC")][#assign className = "MSC"][/#if]
			[#if SWIP.parameters?contains("DFU")][#assign className = "DFU"][/#if]
			[#if SWIP.parameters?contains("HID_NOT_CUSTOM")][#assign className = "HID"][/#if]
			[#if SWIP.parameters?contains("AUDIO")][#assign className = "AUDIO"][/#if]
			[#if SWIP.parameters?contains("CCID")][#assign className = "CCID"][/#if]
			[#if SWIP.parameters?contains("MTP")][#assign className = "MTP"][/#if]
			[#if SWIP.parameters?contains("CDC")][#assign className = "CDC"][/#if]
			[#if SWIP.parameters?contains("HID_CUSTOM")][#assign className = "CUSTOMHID"][/#if]
		[/#if]
	[/#compress]
[/#list]

/* Includes ------------------------------------------------------------------*/
[#if includes??]
[#list includes as include]
#include "${include}"
[/#list]
[/#if]
#include "usbd_def.h"

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
#define         DEVICE_ID1          (UID_BASE)
#define         DEVICE_ID2          (UID_BASE + 0x4)
#define         DEVICE_ID3          (UID_BASE + 0x8)

#define  USB_SIZ_STRING_SERIAL       0x1A
/* Exported macro ------------------------------------------------------------*/
/* Exported functions --------------------------------------------------------*/
[#-- SWIPdatas is a list of SWIPconfigModel --]
[#assign HS = 0]
[#assign FS = 0]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
	[#list SWIP.defines as definition]
	[#if definition.name == "PID_HS"]
		[#assign HS = 1]
	[/#if]
	[#if definition.name == "PID_FS"]
		[#assign FS = 1]
	[/#if]
	[/#list]
[/#if]
[/#list]

extern USBD_DescriptorsTypeDef ${className}_Desc;

#endif /* __${inclusion_protection} */

