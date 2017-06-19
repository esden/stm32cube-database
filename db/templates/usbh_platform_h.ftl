[#ftl]
/**
  ******************************************************************************
  * @file           : usbh_platform.h
  * @brief          : header file for the usbh_platform file
  ******************************************************************************
[@common.optinclude name="Src/license.tmp"/][#--include License text --]
  ******************************************************************************
*/
#include "usb_host.h"
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