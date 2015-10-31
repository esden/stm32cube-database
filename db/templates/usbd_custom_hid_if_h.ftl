[#ftl]
/**
  ******************************************************************************
  * @file           : usbd_custom_hid_if_if.h
  * @author         : MCD Application Team
  * @version        : V2.2.0
  * @date           : 13-June-2014
  * @brief          : header file for the usbd_custom_hid_if.c file
  ******************************************************************************
  * COPYRIGHT(c) ${year} STMicroelectronics
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  * 1. Redistributions of source code must retain the above copyright notice,
  * this list of conditions and the following disclaimer.
  * 2. Redistributions in binary form must reproduce the above copyright notice,
  * this list of conditions and the following disclaimer in the documentation
  * and/or other materials provided with the distribution.
  * 3. Neither the name of STMicroelectronics nor the names of its contributors
  * may be used to endorse or promote products derived from this software
  * without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
  * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
  * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
*/

/* Define to prevent recursive inclusion -------------------------------------*/

#ifndef __USBD_CUSTOM_HID_IF_H_
#define __USBD_CUSTOM_HID_IF_H_
[#assign handleNameFS = ""]
[#assign handleNameUSB_FS = ""]
[#assign handleNameHS = ""]
[#list SWIPdatas as SWIP]  
[#compress]
[#-- Section2: Create global Variables for each middle ware instance --] 
[#-- Global variables --]
[#if SWIP.variables??]
	[#list SWIP.variables as variable]	
		[#-- extern ${variable.type} --][#if variable.value??][#--${variable.value};--]				
		[#if variable.value?contains("OTG_FS")][#assign handleNameFS = "FS"][/#if]
		[#if variable.value?contains("USB_FS")][#assign handleNameUSB_FS = "FS"][/#if]				
		[#if variable.value?contains("OTG_HS")][#assign handleNameHS = "HS"][/#if]
		[/#if]		
	[/#list]
[/#if]
[#-- Global variables --]
[/#compress]
[/#list]

/* Includes ------------------------------------------------------------------*/
#include "usbd_customhid.h"

/** @addtogroup STM32_USB_OTG_DEVICE_LIBRARY
  * @{
  */
  
/** @defgroup USBD_CUSTOM_HID
  * @{
  */ 

/** @defgroup USBD_CUSTOM_HID_Exported_Defines
  * @{
  */ 
/**
  * @}
  */ 


/** @defgroup USBD_CUSTOM_HID_Exported_Types
  * @{
  */


/**
  * @}
  */ 



/** @defgroup USBD_CUSTOM_HID_Exported_Macros
  * @{
  */ 

/**
  * @}
  */ 

/** @defgroup USBD_CUSTOM_HID_Exported_Variables
  * @{
  */ 
[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]  
extern USBD_CUSTOM_HID_ItfTypeDef  USBD_CustomHID_fops_FS;
[/#if]
[#if handleNameHS == "HS"]
extern USBD_CUSTOM_HID_ItfTypeDef  USBD_CustomHID_fops_HS;
[/#if]
/**
  * @}
  */ 

/** @defgroup USBD_CUSTOM_HID_Exported_FunctionsPrototype
  * @{
  */ 


/**
  * @}
  */ 

#endif /* __USBD_CUSTOM_HID_IF_H_ */

/**
  * @}
  */ 

/**
* @}
*/ 
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/