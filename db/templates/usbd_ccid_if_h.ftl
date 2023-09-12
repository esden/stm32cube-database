[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : usbd_ccid_if.h
[#--  * @packageVersion : ${fwVersion} --]
  * @brief          : Header for usbd_ccid_if.c file.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __USBD_CCID_IF_H__
#define __USBD_CCID_IF_H__

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
#include "usbd_ccid.h"

/* USER CODE BEGIN INCLUDE */
/* USER CODE END INCLUDE */

/** @addtogroup STM32_USB_OTG_DEVICE_LIBRARY
  * @brief For Usb device.
  * @{
  */
  
/** @defgroup USBD_CCID_IF USBD_CCID_IF
  * @brief header 
  * @{
  */ 

/** @defgroup USBD_CCID_IF_Exported_Defines USBD_CCID_IF_Exported_Defines
  * @brief Defines.
  * @{
  */ 
/* USER CODE BEGIN EXPORTED_DEFINES */

/* USER CODE END EXPORTED_DEFINES */

/**
  * @}
  */ 


/** @defgroup USBD_CCID_IF_Exported_Types USBD_CCID_IF_Exported_Types
  * @brief Types.
  * @{
  */  
/* USER CODE BEGIN EXPORTED_TYPES */

/* USER CODE END EXPORTED_TYPES */

/**
  * @}
  */

/** @defgroup USBD_CCID_IF_Exported_Macros USBD_CCID_IF_Exported_Macros
  * @brief Aliases.
  * @{
  */

/* USER CODE BEGIN EXPORTED_MACRO */

/* USER CODE END EXPORTED_MACRO */

/**
  * @}
  */

/** @defgroup USBD_CCID_IF_Exported_Variables USBD_CCID_IF_Exported_Variables
  * @brief Public variables.
  * @{
  */

[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
/** CCID Interface callback. */
extern USBD_CCID_ItfTypeDef USBD_CCID_fops_FS;
[/#if]
[#if handleNameHS == "HS"]
/** CCID Interface callback. */
extern USBD_CCID_ItfTypeDef USBD_CCID_fops_HS;
[/#if]

/* USER CODE BEGIN EXPORTED_VARIABLES */

/* USER CODE END EXPORTED_VARIABLES */

/**
  * @}
  */


/** @defgroup USBD_CCID_IF_Exported_FunctionsPrototype USBD_CCID_IF_Exported_FunctionsPrototype
  * @brief Public functions declaration.
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

#endif /* __USBD_CCID_IF_H__ */
