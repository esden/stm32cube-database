[#ftl]
/**
  ******************************************************************************
  * @file           : usbd_audio_if.h
  * @brief          : header file for the usbd_audio_if file
  ******************************************************************************
[@common.optinclude name="Src/license.tmp"/][#--include License text --]
  ******************************************************************************
*/

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __USBD_AUDIO_IF_H
#define __USBD_AUDIO_IF_H
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
#include "usbd_audio.h"
/* USER CODE BEGIN INCLUDE */
/* USER CODE END INCLUDE */

/** @addtogroup STM32_USB_OTG_DEVICE_LIBRARY
  * @{
  */
  
/** @defgroup USBD_AUDIO_IF
  * @brief header 
  * @{
  */ 

/** @defgroup USBD_AUDIO_IF_Exported_Defines
  * @{
  */ 
/* USER CODE BEGIN EXPORTED_DEFINES */
/* USER CODE END  EXPORTED_DEFINES */

/**
  * @}
  */ 

/** @defgroup USBD_AUDIO_IF_Exported_Types
  * @{
  */  
/* USER CODE BEGIN EXPORTED_TYPES */
/* USER CODE END EXPORTED_TYPES */

/**
  * @}
  */ 

/** @defgroup USBD_AUDIO_IF_Exported_Macros
  * @{
  */ 
/* USER CODE BEGIN EXPORTED_MACRO */
/* USER CODE END EXPORTED_MACRO */

/**
  * @}
  */ 

/** @defgroup USBD_AUDIO_IF_Exported_Variables
  * @{
  */ 
[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
#textern USBD_AUDIO_ItfTypeDef  USBD_AUDIO_fops_FS;
[/#if]
[#if handleNameHS == "HS"]
#textern USBD_AUDIO_ItfTypeDef  USBD_AUDIO_fops_HS;
[/#if]

/* USER CODE BEGIN EXPORTED_VARIABLES */
/* USER CODE END EXPORTED_VARIABLES */

/**
  * @}
  */ 


/** @defgroup USBD_AUDIO_IF_Exported_FunctionsPrototype
  * @{
  */ 
[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
/**
  * @brief  Manages the DMA full Transfer complete event.
  * @param  None
  * @retval None
  */
#tvoid TransferComplete_CallBack_FS(void);

/**
  * @brief  Manages the DMA Half Transfer complete event.
  * @param  None
  * @retval None
  */
#tvoid HalfTransfer_CallBack_FS(void);
[/#if]
[#if handleNameHS == "HS"]
/**
  * @brief  Manages the DMA full Transfer complete event.
  * @param  None
  * @retval None
  */
#tvoid TransferComplete_CallBack_HS(void);

/**
  * @brief  Manages the DMA Half Transfer complete event.
  * @param  None
  * @retval None
  */
#tvoid HalfTransfer_CallBack_HS(void);
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

#endif /* __USBD_AUDIO_IF_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
