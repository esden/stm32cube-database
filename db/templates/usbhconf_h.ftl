[#ftl]
/* USER CODE BEGIN Header */
[#assign s = name]
[#assign titi = s?replace("Target/","")]
[#assign toto = titi?replace(".","__")]
/**
  ******************************************************************************
  * @file           : ${name}
  * @version        : ${version}
[#--  * @packageVersion : ${fwVersion} --]
  * @brief          : Header for usbh_conf.c file.
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
#include "main.h"



[#if SWIncludes??]
[#list SWIncludes as include]
#include "${include}"
[/#list]
[/#if]

/* USER CODE BEGIN INCLUDE */

/* USER CODE END INCLUDE */

/** @addtogroup STM32_USB_HOST_LIBRARY
  * @{
  */

/** @defgroup USBH_CONF
  * @brief usb host low level driver configuration file
  * @{
  */

/** @defgroup USBH_CONF_Exported_Variables USBH_CONF_Exported_Variables
  * @brief Public variables.
  * @{
  */

[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]
[#-- Global variables --]
[#if SWIP.variables??]
	[#list SWIP.variables as variable]
/** Usb host data object. */
extern ${variable.value} ${variable.name};
	[/#list]
[/#if]
[#-- Global variables --]

/**
  * @}
  */


[#assign instName = SWIP.ipName]
[#assign fileName = SWIP.fileName]
[#assign version = SWIP.version]
[#assign os_priority = ""]
[#assign os_stacksize = ""]


/** @defgroup USBH_CONF_Exported_Defines USBH_CONF_Exported_Defines
  * @brief Defines for configuration of the Usb host.
  * @{
  */


[#if SWIP.defines??]
	[#list SWIP.defines as definition]
[#if definition.name="USBH_PROCESS_PRIO"]
	[#assign os_priority = definition.value]
[/#if]
[#if definition.name="USBH_PROCESS_STACK_SIZE"]
	[#assign os_stacksize = definition.value]
[/#if]
[#if definition.name!="USBH_PROCESS_STACK_SIZE" && definition.name!="USBH_PROCESS_PRIO"]
/*---------- [#if definition.comments??]${definition.comments} [/#if] -----------*/
#define ${definition.name} #t#t ${definition.value}U
[/#if]
[#if definition.description??]${definition.description} [/#if]
	[/#list]
[/#if]



[/#list]
#n

/****************************************/
/* #define for FS and HS identification */
#define HOST_HS 		0
#define HOST_FS 		1


#if (USBH_USE_OS == 1)
  #include "cmsis_os.h"
  #define USBH_PROCESS_PRIO          ${os_priority}
  #define USBH_PROCESS_STACK_SIZE    ((uint16_t)${os_stacksize})
#endif /* (USBH_USE_OS == 1) */

/**
  * @}
  */


/** @defgroup USBH_CONF_Exported_Macros USBH_CONF_Exported_Macros
  * @brief Aliases.
  * @{
  */

/* Memory management macros */

/** Alias for memory allocation. */
#define USBH_malloc         malloc

/** Alias for memory release. */
#define USBH_free           free

/** Alias for memory set. */
#define USBH_memset         memset

/** Alias for memory copy. */
#define USBH_memcpy         memcpy

/* DEBUG macros */


#if (USBH_DEBUG_LEVEL > 0U)
#define  USBH_UsrLog(...)   do { \
                            printf(__VA_ARGS__); \
                            printf("\n"); \
} while (0)
#else
#define USBH_UsrLog(...) do {} while (0)
#endif

#if (USBH_DEBUG_LEVEL > 1U)

#define  USBH_ErrLog(...) do { \
[#if FamilyName.contains("STM32F7") | FamilyName.contains("STM32G0")]
                            printf("ERROR: "); \
[#else]
                            printf("ERROR: "); \
[/#if]
                            printf(__VA_ARGS__); \
                            printf("\n"); \
} while (0)
#else
#define USBH_ErrLog(...) do {} while (0)
#endif

#if (USBH_DEBUG_LEVEL > 2U)
#define  USBH_DbgLog(...)   do { \
[#if FamilyName.contains("STM32F7") | FamilyName.contains("STM32G0")]
                            printf("ERROR: "); \
[#else]
                            printf("DEBUG : "); \
[/#if]
                            printf(__VA_ARGS__); \
                            printf("\n"); \
} while (0)
#else
#define USBH_DbgLog(...) do {} while (0)
#endif

/**
  * @}
  */


/** @defgroup USBH_CONF_Exported_Types USBH_CONF_Exported_Types
  * @brief Types.
  * @{
  */

/**
  * @}
  */


/** @defgroup USBH_CONF_Exported_FunctionsPrototype USBH_CONF_Exported_FunctionsPrototype
  * @brief Declaration of public functions for Usb host.
  * @{
  */

/* Exported functions -------------------------------------------------------*/

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

