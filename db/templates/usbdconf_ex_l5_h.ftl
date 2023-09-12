[#ftl]
/* USER CODE BEGIN Header */
[#assign s = name]
[#assign titi = s?replace("Target/","")]
[#assign toto = titi?replace(".","__")]
[#assign CLASS_FS = ""]
/**
  ******************************************************************************
  * @file           : ${titi}
  * @version        : ${version}
[#--  * @packageVersion : ${fwVersion} --]
  * @brief          : Header for usbd_conf.c file.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign inclusion_protection = toto?upper_case]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${inclusion_protection}__
#define __${inclusion_protection}__

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
[#if SWIncludes??]
[#list SWIncludes as include]
[#assign includeFile = include]
[#if  includeFile!="usbd_def.h"]
#include "${includeFile}"
[/#if]
[/#list]
[/#if]
[#assign useBCD=false]
[#-- IPdatas is a list of IPconfigModel --]
[#if configs??]
   [#list configs as config]
        [#list config.peripheralParams?keys as PeripheralParams]
            [#if PeripheralParams=="USB"]
                [#assign values = config.peripheralParams[PeripheralParams]][#-- values is a hash list --]
                [#if values["battery_charging_enable"]=="ENABLE"]	
[#assign useBCD=true]			 
                [/#if]
            [/#if]
        [/#list]
    [/#list]
 [/#if]

/* USER CODE BEGIN INCLUDE */

/* USER CODE END INCLUDE */

/** @addtogroup USBD_OTG_DRIVER
  * @brief Driver for Usb device.
  * @{
  */

/** @defgroup USBD_CONF USBD_CONF
  * @brief Configuration file for Usb otg low level driver.
  * @{
  */

/** @defgroup USBD_CONF_Exported_Variables USBD_CONF_Exported_Variables
  * @brief Public variables.
  * @{
  */

[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]
[#-- Global variables --]
[#if SWIP.variables??]
	[#list SWIP.variables as variable]
/** Usb device data object. */
extern ${variable.value} ${variable.name};
	[/#list]
[/#if]
[#-- Global variables --]

/* Private variables ---------------------------------------------------------*/
[#if useBCD]
typedef enum
{
  USB_BCD_ERROR                     = 0xFF,
  USB_BCD_CONTACT_DETECTION         = 0xFE,
  USB_BCD_STD_DOWNSTREAM_PORT       = 0xFD,
  USB_BCD_CHARGING_DOWNSTREAM_PORT  = 0xFC,
  USB_BCD_DEDICATED_CHARGING_PORT   = 0xFB,
  USB_BCD_DISCOVERY_COMPLETED       = 0xFA,
  USB_BCD_DEVICE_DISCONNECTED       = 0xF9,
  USB_BCD_IDLE                      = 0x00,
} USB_BCD_Status;
[/#if]
/* USER CODE BEGIN PV */
/* USER CODE END PV */
/**
  * @}
  */


[#assign instName = SWIP.ipName]
[#assign fileName = SWIP.fileName]
[#assign version = SWIP.version]


/** @defgroup USBD_CONF_Exported_Defines USBD_CONF_Exported_Defines
  * @brief Defines for configuration of the Usb device.
  * @{
  */

[#compress]
[#if SWIP.defines??]
	[#list SWIP.defines as definition]
	[#assign value = definition.value]
	[#assign paramName = definition.paramName]
	[#if definition.paramName == "CLASS_NAME_FS"]
		[#assign CLASS_FS = value]
	[/#if]
	[#if value!="valueNotSetted"]
/*---------- [#if definition.comments??]${definition.comments} [/#if] -----------*/
[#-- Tracker 253306 --]
    [#if definition.name="USBD_DFU_APP_DEFAULT_ADD"]
#define ${definition.name} #t#t${value}U
    [/#if]
    [#if definition.name!="USBD_DFU_APP_DEFAULT_ADD" && paramName!="CLASS_NAME_FS"]
#define ${definition.name} #t#t${value}U
    [/#if]
[#-- Tracker 253306 --]
	[#if definition.description??]${definition.description} [/#if]
	[/#if]
	[/#list]
[/#if]
[/#compress]
[/#list]
#n

[#if CLASS_FS == "CUSTOM_HID"]
/* #define USBD_CUSTOMHID_CTRL_REQ_GET_REPORT_ENABLED */
/* #define USBD_CUSTOMHID_OUT_PREPARE_RECEIVE_DISABLED */
/* #define USBD_CUSTOMHID_EP0_OUT_PREPARE_RECEIVE_DISABLED */
/* #define USBD_CUSTOMHID_CTRL_REQ_COMPLETE_CALLBACK_ENABLED */
[/#if]

/****************************************/
/* #define for FS and HS identification */
#define DEVICE_FS 		0

/**
  * @}
  */


/** @defgroup USBD_CONF_Exported_Macros USBD_CONF_Exported_Macros
  * @brief Aliases.
  * @{
  */

/* Memory management macros */
/** Alias for memory allocation. */
#define USBD_malloc         (void *)USBD_static_malloc

/** Alias for memory release. */
#define USBD_free           USBD_static_free

/** Alias for memory set. */
#define USBD_memset         memset

/** Alias for memory copy. */
#define USBD_memcpy         memcpy

/** Alias for delay. */
#define USBD_Delay          HAL_Delay
/* DEBUG macros */


#if (USBD_DEBUG_LEVEL > 0)
#define USBD_UsrLog(...)    printf(__VA_ARGS__);\
                            printf("\n");
#else
#define USBD_UsrLog(...)
#endif /* (USBD_DEBUG_LEVEL > 0U) */


#if (USBD_DEBUG_LEVEL > 1)

#define USBD_ErrLog(...)    printf("ERROR: ");\
                            printf(__VA_ARGS__);\
                            printf("\n");
#else
#define USBD_ErrLog(...)
#endif /* (USBD_DEBUG_LEVEL > 1U) */


#if (USBD_DEBUG_LEVEL > 2)
#define USBD_DbgLog(...)    printf("DEBUG : ");\
                            printf(__VA_ARGS__);\
                            printf("\n");
#else
#define USBD_DbgLog(...)
#endif /* (USBD_DEBUG_LEVEL > 2U) */

/**
  * @}
  */


/** @defgroup USBD_CONF_Exported_Types USBD_CONF_Exported_Types
  * @brief Types.
  * @{
  */

/**
  * @}
  */


/** @defgroup USBD_CONF_Exported_FunctionsPrototype USBD_CONF_Exported_FunctionsPrototype
  * @brief Declaration of public functions for Usb device.
  * @{
  */

/* Exported functions -------------------------------------------------------*/
void *USBD_static_malloc(uint32_t size);
void USBD_static_free(void *p);

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

#endif /* __${inclusion_protection}__ */

