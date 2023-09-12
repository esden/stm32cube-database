[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : usbd_cdc_if.h
  * @version        : ${version}
[#--  * @packageVersion : ${fwVersion} --]
  * @brief          : Header for usbd_cdc_if.c file.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __USBD_CDC_IF_H__
#define __USBD_CDC_IF_H__

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

[#--  BZ 74391 REJECTED --]
[#assign RX_DATA_SIZE = 4]
[#assign TX_DATA_SIZE = 4]
[#list SWIPdatas as SWIP]
[#compress]
[#if SWIP.defines??]
	[#list SWIP.defines as definition]		
    [#if definition.name?contains("APP_RX_DATA_SIZE")]	    
[#assign RX_DATA_SIZE = definition.value]
    [/#if]
	[#if definition.name?contains("APP_TX_DATA_SIZE")]
[#assign TX_DATA_SIZE = definition.value]
    [/#if]
	[/#list]
[/#if]
[/#compress]
[/#list]


#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "usbd_cdc.h"

/* USER CODE BEGIN INCLUDE */

/* USER CODE END INCLUDE */

/** @addtogroup STM32_USB_OTG_DEVICE_LIBRARY
  * @brief For Usb device.
  * @{
  */
  
/** @defgroup USBD_CDC_IF USBD_CDC_IF
  * @brief Usb VCP device module
  * @{
  */ 

/** @defgroup USBD_CDC_IF_Exported_Defines USBD_CDC_IF_Exported_Defines
  * @brief Defines.
  * @{
  */
[#-- BZ 102389 Generate RX, TX Buffer size  out of user code section --]
[#--  BZ 74391 --]
/* Define size for the receive and transmit buffer over CDC */
[#--  /* It's up to user to redefine and/or remove those define */ --]
#define APP_RX_DATA_SIZE  ${RX_DATA_SIZE}
#define APP_TX_DATA_SIZE  ${TX_DATA_SIZE}
/* USER CODE BEGIN EXPORTED_DEFINES */

/* USER CODE END EXPORTED_DEFINES */

/**
  * @}
  */


/** @defgroup USBD_CDC_IF_Exported_Types USBD_CDC_IF_Exported_Types
  * @brief Types.
  * @{
  */

/* USER CODE BEGIN EXPORTED_TYPES */

/* USER CODE END EXPORTED_TYPES */

/**
  * @}
  */

/** @defgroup USBD_CDC_IF_Exported_Macros USBD_CDC_IF_Exported_Macros
  * @brief Aliases.
  * @{
  */

/* USER CODE BEGIN EXPORTED_MACRO */

/* USER CODE END EXPORTED_MACRO */

/**
  * @}
  */

/** @defgroup USBD_CDC_IF_Exported_Variables USBD_CDC_IF_Exported_Variables
  * @brief Public variables.
  * @{
  */

[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
/** CDC Interface callback. */
extern USBD_CDC_ItfTypeDef USBD_Interface_fops_FS;
[/#if]
[#if handleNameHS == "HS"]
/** CDC Interface callback. */
extern USBD_CDC_ItfTypeDef USBD_Interface_fops_HS;
[/#if]

/* USER CODE BEGIN EXPORTED_VARIABLES */

/* USER CODE END EXPORTED_VARIABLES */

/**
  * @}
  */


/** @defgroup USBD_CDC_IF_Exported_FunctionsPrototype USBD_CDC_IF_Exported_FunctionsPrototype
  * @brief Public functions declaration.
  * @{
  */

[#if handleNameFS == "FS"]
uint8_t CDC_Transmit_FS(uint8_t* Buf, uint16_t Len);
[/#if]
[#if handleNameUSB_FS == "FS"]
uint8_t CDC_Transmit_FS(uint8_t* Buf, uint16_t Len);
[/#if]
[#if handleNameHS == "HS"]
uint8_t CDC_Transmit_HS(uint8_t* Buf, uint16_t Len);
[/#if]

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

#endif /* __USBD_CDC_IF_H__ */

