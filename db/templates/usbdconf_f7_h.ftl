[#ftl]
/**
  ******************************************************************************
  * @file           : ${name}
  * @version        : ${version}
[#--  * @packageVersion : ${fwVersion} --]
  * @brief          : Header for usbd_conf file.
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

/** @addtogroup USBD_OTG_DRIVER
  * @{
  */
  
/** @defgroup USBD_CONF
  * @brief usb otg low level driver configuration file
  * @{
  */ 

/** @defgroup USBD_CONF_Exported_Defines
  * @{
  */ 
[#-- SWIPdatas is a list of SWIPconfigModel --]  
[#list SWIPdatas as SWIP]  
[#-- Global variables --]
[#if SWIP.variables??]
	[#list SWIP.variables as variable]
extern ${variable.value} ${variable.name};
	[/#list]
[/#if]

[#-- Global variables --]

[#assign instName = SWIP.ipName]   
[#assign fileName = SWIP.fileName]   
[#assign version = SWIP.version]   

[#compress]
[#if SWIP.defines??]
	[#list SWIP.defines as definition]	
	[#assign value = definition.value]
	[#if value!="valueNotSetted"]
/*---------- [#if definition.comments??]${definition.comments} [/#if] -----------*/
[#-- Tracker 253306 --]
    [#if definition.name="USBD_DFU_APP_DEFAULT_ADD"]  
#define ${definition.name} #t#t${value}  
    [/#if]	
    [#if definition.name!="USBD_DFU_APP_DEFAULT_ADD"]  
#define ${definition.name} #t#t${value}  
    [/#if]
[#-- Tracker 253306 --]
	[#if definition.description??]${definition.description} [/#if]
	[/#if]	
	[/#list]
[/#if]
[/#compress]
[/#list]
#n

/****************************************/
/* #define for FS and HS identification */
#define DEVICE_FS 		0
[#-- Tracker 253309 --]
#define DEVICE_HS 		1
[#-- Tracker 253309 --]

/** @defgroup USBD_Exported_Macros
  * @{
  */ 

 /* Memory management macros */   
#define USBD_malloc               malloc
#define USBD_free                 free
#define USBD_memset               memset
#define USBD_memcpy               memcpy

#define USBD_Delay   HAL_Delay
    
 /* DEBUG macros */  

  
#if (USBD_DEBUG_LEVEL > 0)
#define  USBD_UsrLog(...)   printf(__VA_ARGS__);\
                            printf("\n");
#else
#define USBD_UsrLog(...)   
#endif 
                            
                            
#if (USBD_DEBUG_LEVEL > 1)

#define  USBD_ErrLog(...)   printf("ERROR: ") ;\
                            printf(__VA_ARGS__);\
                            printf("\n");
#else
#define USBD_ErrLog(...)   
#endif 
                            
                            
#if (USBD_DEBUG_LEVEL > 2)                         
#define  USBD_DbgLog(...)   printf("DEBUG : ") ;\
                            printf(__VA_ARGS__);\
                            printf("\n");
#else
#define USBD_DbgLog(...)                         
#endif
                            
/**
  * @}
  */ 
 
    
    
/**
  * @}
  */ 


/** @defgroup USBD_CONF_Exported_Types
  * @{
  */ 
/**
  * @}
  */ 


/** @defgroup USBD_CONF_Exported_Macros
  * @{
  */ 
/**
  * @}
  */ 

/** @defgroup USBD_CONF_Exported_Variables
  * @{
  */ 
/**
  * @}
  */ 

/** @defgroup USBD_CONF_Exported_FunctionsPrototype
  * @{
  */ 
/**
  * @}
  */ 
#ifdef __cplusplus
}
#endif

#endif /*__USBD_CONF__H__*/


/**
  * @}
  */ 

/**
  * @}
  */ 
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

