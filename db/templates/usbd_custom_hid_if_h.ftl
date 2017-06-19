[#ftl]
/**
  ******************************************************************************
  * @file           : usbd_custom_hid_if_if.h
  * @brief          : header file for the usbd_custom_hid_if.c file
  ******************************************************************************
[@common.optinclude name="Src/license.tmp"/][#--include License text --]
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

#ifdef __cplusplus
 extern "C" {
#endif
/* Includes ------------------------------------------------------------------*/
#include "usbd_customhid.h"
/* USER CODE BEGIN INCLUDE */
/* USER CODE END INCLUDE */

/** @addtogroup STM32_USB_OTG_DEVICE_LIBRARY
  * @{
  */
  
/** @defgroup USBD_CUSTOM_HID
  * @brief header 
  * @{
  */ 

/** @defgroup USBD_CUSTOM_HID_Exported_Defines
  * @{
  */ 
/* USER CODE BEGIN EXPORTED_DEFINES */
/* USER CODE END EXPORTED_DEFINES */

/**
  * @}
  */ 


/** @defgroup USBD_CUSTOM_HID_Exported_Types
  * @{
  */  
/* USER CODE BEGIN EXPORTED_TYPES */
/* USER CODE END EXPORTED_TYPES */

/**
  * @}
  */ 



/** @defgroup USBD_CUSTOM_HID_Exported_Macros
  * @{
  */ 
/* USER CODE BEGIN EXPORTED_MACRO */
/* USER CODE END EXPORTED_MACRO */

/**
  * @}
  */ 

/** @defgroup USBD_CUSTOM_HID_Exported_Variables
  * @{
  */ 
[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]  
#textern USBD_CUSTOM_HID_ItfTypeDef  USBD_CustomHID_fops_FS;
[/#if]
[#if handleNameHS == "HS"]
#textern USBD_CUSTOM_HID_ItfTypeDef  USBD_CustomHID_fops_HS;
[/#if]

/* USER CODE BEGIN EXPORTED_VARIABLES */
/* USER CODE END EXPORTED_VARIABLES */

/**
  * @}
  */ 

/** @defgroup USBD_CUSTOM_HID_Exported_FunctionsPrototype
  * @{
  */ 



/* USER CODE BEGIN EXPORTED_FUNCTIONS */
/* USER CODE END EXPORTED_FUNCTIONS */
/**
  * @}
  */
   
/**
  * @}
  */ 

/**
* @}
*/
 
#ifdef __cplusplus
}
#endif

#endif /* __USBD_CUSTOM_HID_IF_H_ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
