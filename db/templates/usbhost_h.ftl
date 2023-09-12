[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : ${name?lower_case}.h
  * @version        : ${version}
[#--  * @packageVersion : ${fwVersion} --]
  * @brief          : Header for usb_host.c file.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${name?upper_case}__H__
#define __${name?upper_case}__H__

#ifdef __cplusplus
 extern "C" {
#endif
[#assign ipName=""]
[#assign useOs=""]

/* Includes ------------------------------------------------------------------*/
[#if includes??]
[#list includes as include]
#include "${include}"
[/#list]
[/#if]

/* USER CODE BEGIN INCLUDE */

/* USER CODE END INCLUDE */

/** @addtogroup USBH_OTG_DRIVER
  * @{
  */

/** @defgroup USBH_HOST USBH_HOST
  * @brief Host file for Usb otg low level driver.
  * @{
  */

/** @defgroup USBH_HOST_Exported_Variables USBH_HOST_Exported_Variables
  * @brief Public variables.
  * @{
  */


[#list IPdatas as IP]
[#assign ipvar = IP]
[#-- Global variables --]
[#if IP.variables??]
	[#list IP.variables as variable]
	[#--[#if variable.value?contains("Handle")]--]
[#--extern ${variable.value} ${variable.name};--]
	[#--[/#if]--]
	[/#list]
[/#if]
[#-- Global variables --]

/**
  * @}
  */

[#-- extract hal mode list used by all instances of the ip --]
[#assign halModeList= ""]

[#list ipvar.instances.entrySet() as entry]
        [#if halModeList?contains(entry.value)]
        [#else]
            [#assign halModeList = halModeList + " " +entry.value]
        [/#if]
[/#list]
[#list IP.configModelList as instanceData]
        [#assign instName = instanceData.instanceName]
        [#assign instMode= instanceData.halMode]
        [#assign ipName = instanceData.ipName]
[/#list]

/** Status of the application. */
typedef enum {
  APPLICATION_IDLE = 0,
  APPLICATION_START,
  APPLICATION_READY,
  APPLICATION_DISCONNECT
}ApplicationTypeDef;

/** @defgroup USBH_HOST_Exported_FunctionsPrototype USBH_HOST_Exported_FunctionsPrototype
  * @brief Declaration of public functions for Usb host.
  * @{
  */

/* Exported functions -------------------------------------------------------*/

/** @brief USB Host initialization function. */
void MX_${ipName}_Init(void);

[#if !FREERTOS??]
void MX_${ipName}_Process(void);
[/#if]

[#list halModeList?split(" ") as mode]
[#if mode !=""]
void HAL_${mode}_BspInit(${mode}_HandleTypeDef* h${mode?lower_case});
void HAL_${mode}_BspDeInit(${mode}_HandleTypeDef* h${mode?lower_case});
[/#if]
[/#list]

[/#list]

[#--void ${ipName}_Init(void);--]

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

#endif /* __${name?upper_case}__H__ */

