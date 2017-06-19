[#ftl]
/**
  ******************************************************************************
  * @file           : usbd_storage_if.h
  * @brief          : header file for the usbd_storage_if.c file
  ******************************************************************************
[@common.optinclude name="Src/license.tmp"/][#--include License text --]
  ******************************************************************************
*/

/* Define to prevent recursive inclusion -------------------------------------*/

#ifndef __USBD_STORAGE_IF_H_
#define __USBD_STORAGE_IF_H_
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
#include "usbd_msc.h"
/* USER CODE BEGIN INCLUDE */
/* USER CODE END INCLUDE */

/** @addtogroup STM32_USB_OTG_DEVICE_LIBRARY
  * @{
  */
  
/** @defgroup USBD_STORAGE
  * @brief header file for the USBD_STORAGE.c file
  * @{
  */ 

/** @defgroup USBD_STORAGE_Exported_Defines
  * @{
  */ 
/* USER CODE BEGIN EXPORTED_DEFINES */
/* USER CODE END  EXPORTED_DEFINES */

/**
  * @}
  */ 


/** @defgroup USBD_STORAGE_Exported_Types
  * @{
  */  
/* USER CODE BEGIN EXPORTED_TYPES */
/* USER CODE END  EXPORTED_TYPES */

/**
  * @}
  */ 



/** @defgroup USBD_STORAGE_Exported_Macros
  * @{
  */ 
/* USER CODE BEGIN EXPORTED_MACRO */
/* USER CODE END  EXPORTED_MACRO */

/**
  * @}
  */ 

/** @defgroup USBD_STORAGE_Exported_Variables
  * @{
  */ 
[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]  
#textern USBD_StorageTypeDef  USBD_Storage_Interface_fops_FS;
[/#if]
[#if handleNameHS == "HS"]
#textern USBD_StorageTypeDef  USBD_Storage_Interface_fops_HS;
[/#if]

/* USER CODE BEGIN EXPORTED_VARIABLES */
/* USER CODE END  EXPORTED_VARIABLES */

/**
  * @}
  */ 

/** @defgroup USBD_STORAGE_Exported_FunctionsPrototype
  * @{
  */ 

/* USER CODE BEGIN EXPORTED_FUNCTIONS */
/* USER CODE END  EXPORTED_FUNCTIONS */
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

#endif /* __USBD_STORAGE_IF_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
