[#ftl]
/* USER CODE BEGIN Header */
[#assign s = name]
[#assign titi = s?replace("App/","")]
[#assign toto = titi?replace(".","__")]
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
[#if includes??]
[#list includes as include]
#include "${include}"
[/#list]
[/#if]
#include "usbd_def.h"

[#assign useLPM=false]
[#-- IPdatas is a list of IPconfigModel --]
[#if configs??]
   [#list configs as config]
        [#list config.peripheralParams?keys as PeripheralParams]
            [#if PeripheralParams=="USB"]            
                [#assign values = config.peripheralParams[PeripheralParams]][#-- values is a hash list --]
                 [#if values["lpm_enable"]??] 
                	[#if values["lpm_enable"]=="ENABLE"]                	
						[#assign useLPM=true]			 
                	[/#if]
                [/#if]
            [/#if]
        [/#list]
    [/#list]
 [/#if]
/* USER CODE BEGIN INCLUDE */

/* USER CODE END INCLUDE */

/** @addtogroup STM32_USB_OTG_DEVICE_LIBRARY
  * @{
  */

/** @defgroup USBD_DESC USBD_DESC
  * @brief Usb device descriptors module.
  * @{
  */
  
/** @defgroup USBD_DESC_Exported_Constants USBD_DESC_Exported_Constants
  * @brief Constants.
  * @{
  */
#define         DEVICE_ID1          (UID_BASE)
#define         DEVICE_ID2          (UID_BASE + 0x4)
#define         DEVICE_ID3          (UID_BASE + 0x8)

#define         USB_SIZ_STRING_SERIAL       0x1A

[#if family?contains("STM32F7") || family?contains("STM32F4") || family?contains("STM32L4")  || family?contains("STM32WB") || family?contains("STM32G4") || family?contains("STM32L5")]
[#if useLPM=true]
#define         USB_SIZ_BOS_DESC            0x0C
[/#if]
[/#if]

/* USER CODE BEGIN EXPORTED_CONSTANTS */

/* USER CODE END EXPORTED_CONSTANTS */

/**
  * @}
  */


/** @defgroup USBD_DESC_Exported_Defines USBD_DESC_Exported_Defines
  * @brief Defines.
  * @{
  */

/* USER CODE BEGIN EXPORTED_DEFINES */

/* USER CODE END EXPORTED_DEFINES */

/**
  * @}
  */


/** @defgroup USBD_DESC_Exported_TypesDefinitions USBD_DESC_Exported_TypesDefinitions
  * @brief Types.
  * @{
  */

/* USER CODE BEGIN EXPORTED_TYPES */

/* USER CODE END EXPORTED_TYPES */

/**
  * @}
  */


/** @defgroup USBD_DESC_Exported_Macros USBD_DESC_Exported_Macros
  * @brief Aliases.
  * @{
  */

/* USER CODE BEGIN EXPORTED_MACRO */

/* USER CODE END EXPORTED_MACRO */

/**
  * @}
  */


/** @defgroup USBD_DESC_Exported_Variables USBD_DESC_Exported_Variables
  * @brief Public variables.
  * @{
  */

[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]
[#compress]
[#if SWIP.defines??]
	[#list SWIP.defines as definition]
	[#assign value = definition.value]
	[#assign paramName = definition.paramName]	
	[#if definition.paramName == "PID"]
		[#assign FS = 1]
	[/#if]
[#if definition.paramName == "CLASS_NAME_FS"]
	[#assign CLASS_FS = value]	
extern USBD_DescriptorsTypeDef #t#t${CLASS_FS}_Desc;
[/#if]
	[/#list]
[/#if]
[/#compress]
[/#list]


/* USER CODE BEGIN EXPORTED_VARIABLES */

/* USER CODE END EXPORTED_VARIABLES */

/**
  * @}
  */


/** @defgroup USBD_DESC_Exported_FunctionsPrototype USBD_DESC_Exported_FunctionsPrototype
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

#endif /* __${inclusion_protection}__ */

