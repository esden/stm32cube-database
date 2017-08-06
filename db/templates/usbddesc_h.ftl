[#ftl]
/**
  ******************************************************************************
  * @file           : ${name}
  * @version        : ${version}
[#-- * @packageVersion : ${fwVersion} --]
  * @brief          : Header for usbd_desc file.
  ******************************************************************************
[@common.optinclude name="Src/license.tmp"/][#--include License text --]
  ******************************************************************************
*/

[#assign s = name]
[#assign toto = s?replace(".","__")]
[#assign inclusion_protection = toto?upper_case]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${inclusion_protection}__
#define __${inclusion_protection}__

#ifdef __cplusplus
 extern "C" {
#endif
/* Includes ------------------------------------------------------------------*/
[#if includes??]
[#list includes as include]
#include "${include}"
[/#list]
[/#if]
#include "usbd_def.h"

/** @addtogroup STM32_USB_OTG_DEVICE_LIBRARY
  * @{
  */
  
/** @defgroup USB_DESC
  * @brief general defines for the usb device library file
  * @{
  */ 

/** @defgroup USB_DESC_Exported_Defines
  * @{
  */

/**
  * @}
  */ 


/** @defgroup USBD_DESC_Exported_TypesDefinitions
  * @{
  */
/**
  * @}
  */ 



/** @defgroup USBD_DESC_Exported_Macros
  * @{
  */ 
/**
  * @}
  */ 

/** @defgroup USBD_DESC_Exported_Variables
  * @{
  */ 
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
[#if HS == 1]	
extern USBD_DescriptorsTypeDef HS_Desc;
[/#if]
[#if FS == 1]	
extern USBD_DescriptorsTypeDef FS_Desc;
[/#if]
/**
  * @}
  */ 

/** @defgroup USBD_DESC_Exported_FunctionsPrototype
  * @{
  */ 
  
/**
  * @}
  */ 
#ifdef __cplusplus
}
#endif

#endif /* __USBD_DESC_H */

/**
  * @}
  */ 

/**
* @}
*/ 
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
