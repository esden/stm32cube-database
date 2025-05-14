[#ftl]

[#assign moduleName = "ThreadX"]
[#if ModuleName??]
    [#assign moduleName = ModuleName]
[/#if]

/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_azure_rtos_config.h
  * @author  MCD Application Team
  * @brief   app_azure_rtos config header file
  ******************************************************************************
 [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef APP_AZURE_RTOS_CONFIG_H
#define APP_AZURE_RTOS_CONFIG_H
#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/

[#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = "1"]
[#assign TX_APP_MEM_POOL_SIZE_VAL = "0"]
[#assign FX_APP_MEM_POOL_SIZE_VAL = "0"]
[#assign NX_APP_MEM_POOL_SIZE_VAL = "0"]
[#assign UX_HOST_APP_MEM_POOL_SIZE_VAL = "0"]
[#assign UX_DEVICE_APP_MEM_POOL_SIZE_VAL = "0"]
[#assign USBPD_DEVICE_APP_MEM_POOL_SIZE_VAL = "0"]
[#assign TOUCHSENSING_APP_MEM_POOL_SIZE_Val = "0"]
[#assign GUI_INTERFACE_APP_MEM_POOL_SIZE_VAL = "0"]
[#assign STM32WPAN_APP_MEM_POOL_SIZE_Val = "0"]
[#assign SECURE_MANAGER_API_APP_MEM_POOL_SIZE_VAL = "512"]

[#assign TX_ENABLED = "true"]
[#assign FX_ENABLED = "false"]
[#assign NX_ENABLED = "false"]
[#assign UX_HOST_ENABLED = "false"]
[#assign UX_DEVICE_ENABLED = "false"]
[#assign USBPD_DEVICE_ENABLED = "false"]
[#assign TOUCHSENSING_ENABLED = "false"]
[#assign GUI_INTERFACE_ENABLED = "false"]
[#assign STM32WPAN_ENABLED = "false"]
[#assign SECURE_MANAGER_API_ENABLED = "false"]
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]

  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
    [#if name == "FILEX_ENABLED" && value == "true"]
      [#assign FX_ENABLED = value]
    [/#if]    
	[#if name == "NETXDUO_ENABLED" && value == "true"]
      [#assign NX_ENABLED = value]
    [/#if]
	[#if name == "USBXDEVICE_ENABLED" && value == "true"]
      [#assign UX_DEVICE_ENABLED = value]
    [/#if]
	[#if name == "USBXHOST_ENABLED" && value == "true"]
      [#assign UX_HOST_ENABLED = value]
    [/#if]
	[#if name == "USBPD_ENABLED" && value == "true"]
      [#assign USBPD_DEVICE_ENABLED = value]
    [/#if]
	[#if name == "TSC_ENABLED" && value == "true"]
      [#assign TOUCHSENSING_ENABLED = value]
    [/#if]
    [#if name == "GUI_INTERFACE_ENABLED" && value == "true"]
      [#assign GUI_INTERFACE_ENABLED = value]
    [/#if]
    [#if name == "WPAN_ENABLED" && value == "true"]
      [#assign STM32WPAN_ENABLED = value]
    [/#if]
	[#if name == "SECURE_MANAGER_API_ENABLED" && value == "true"]
      [#assign SECURE_MANAGER_API_ENABLED = value]
    [/#if]
	
	
    [#if name.contains("AZRTOS_APP_MEM_ALLOCATION_METHOD")]
      [#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = value]
    [/#if]
    [#if name.contains("TX_APP_MEM_POOL_SIZE")]
      [#assign TX_APP_MEM_POOL_SIZE_VAL = value]
    [/#if]
    [#if name.contains("FX_APP_MEM_POOL_SIZE")]
      [#assign FX_APP_MEM_POOL_SIZE_VAL = value]
    [/#if]
    [#if name.contains("NX_APP_MEM_POOL_SIZE")]
      [#assign NX_APP_MEM_POOL_SIZE_VAL = value]
    [/#if]
    [#if name.contains("UX_HOST_APP_MEM_POOL_SIZE")]
      [#assign UX_HOST_APP_MEM_POOL_SIZE_VAL = value]
    [/#if]
	[#if name.contains("UX_DEVICE_APP_MEM_POOL_SIZE")]
	  [#assign UX_DEVICE_APP_MEM_POOL_SIZE_VAL = value]
	[/#if]
	[#if name.contains("USBPD_DEVICE_APP_MEM_POOL_SIZE")]
	  [#assign USBPD_DEVICE_APP_MEM_POOL_SIZE_VAL = value]
	[/#if]
	[#if name.contains("TOUCHSENSING_APP_MEM_POOL_SIZE")]
	  [#assign TOUCHSENSING_APP_MEM_POOL_SIZE_VAL = value]
	[/#if]
    [#if name.contains("GUI_INTERFACE_APP_MEM_POOL_SIZE")]
      [#assign GUI_INTERFACE_APP_MEM_POOL_SIZE_VAL = value]
    [/#if]
    [#if name.contains("STM32WPAN_APP_MEM_POOL_SIZE")]
	  [#assign STM32WPAN_APP_MEM_POOL_SIZE_VAL = value]
	[/#if]
	[#if name.contains("SECURE_MANAGER_API_APP_MEM_POOL_SIZE_VAL")]
	  [#assign SECURE_MANAGER_API_APP_MEM_POOL_SIZE_VAL = value]
	[/#if]
    [/#list]
[/#if]
[/#list]
[/#compress]

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if  AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL == "1"]
/* Using static memory allocation via threadX Byte memory pools */

#define USE_STATIC_ALLOCATION                    ${AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL}

[#if TX_ENABLED == "true" && TX_APP_MEM_POOL_SIZE_VAL != "valueNotSetted"]
#define TX_APP_MEM_POOL_SIZE                     ${TX_APP_MEM_POOL_SIZE_VAL}
[/#if]

[#if FX_ENABLED == "true" && FX_APP_MEM_POOL_SIZE_VAL != "valueNotSetted"]
#define FX_APP_MEM_POOL_SIZE                     ${FX_APP_MEM_POOL_SIZE_VAL}
[/#if]

[#if NX_ENABLED == "true" && NX_APP_MEM_POOL_SIZE_VAL != "valueNotSetted"]
#define NX_APP_MEM_POOL_SIZE                     ${NX_APP_MEM_POOL_SIZE_VAL}
[/#if]

[#if UX_HOST_ENABLED == "true" && UX_HOST_APP_MEM_POOL_SIZE_VAL != "valueNotSetted"]
#define UX_HOST_APP_MEM_POOL_SIZE                ${UX_HOST_APP_MEM_POOL_SIZE_VAL}
[/#if]

[#if UX_DEVICE_ENABLED == "true" && UX_DEVICE_APP_MEM_POOL_SIZE_VAL != "valueNotSetted"]
#define UX_DEVICE_APP_MEM_POOL_SIZE              ${UX_DEVICE_APP_MEM_POOL_SIZE_VAL}
[/#if]

[#if USBPD_DEVICE_ENABLED == "true" && USBPD_DEVICE_APP_MEM_POOL_SIZE_VAL != "valueNotSetted"]
#define USBPD_DEVICE_APP_MEM_POOL_SIZE              ${USBPD_DEVICE_APP_MEM_POOL_SIZE_VAL}
[/#if]
[#if TOUCHSENSING_ENABLED == "true" && TOUCHSENSING_APP_MEM_POOL_SIZE_VAL != "valueNotSetted"]
#define TOUCHSENSING_APP_MEM_POOL_SIZE              ${TOUCHSENSING_APP_MEM_POOL_SIZE_VAL}
[/#if]

[#if GUI_INTERFACE_ENABLED == "true" && GUI_INTERFACE_APP_MEM_POOL_SIZE_VAL != "valueNotSetted" ]
#define GUI_INTERFACE_APP_MEM_POOL_SIZE              ${GUI_INTERFACE_APP_MEM_POOL_SIZE_VAL}
[/#if]
[#if STM32WPAN_ENABLED == "true" && STM32WPAN_APP_MEM_POOL_SIZE_VAL != "valueNotSetted"]
#define STM32WPAN_APP_MEM_POOL_SIZE              ${STM32WPAN_APP_MEM_POOL_SIZE_VAL}
[/#if]
[#if SECURE_MANAGER_API_ENABLED == "true" && SECURE_MANAGER_API_APP_MEM_POOL_SIZE_VAL != "valueNotSetted"]
#define SECURE_MANAGER_API_APP_MEM_POOL_SIZE    ${SECURE_MANAGER_API_APP_MEM_POOL_SIZE_VAL}
[/#if]

[#if packs??]
[#list packs as variables]
[@common.optinclude name=contextFolder + mxTmpFolder+"/RTOS_defines_${variables.name}.tmp"/]
[/#list]
[/#if]

[#else]
/*  To enable static memory allocation using threadx memory pools the following defines should be set */
/* #define USE_STATIC_ALLOCATION               1 */

[#if TX_ENABLED == "true"]
/* #define TX_APP_MEM_POOL_SIZE                     <Add TX memory pool Size> */
[/#if]

[#if FX_ENABLED == "true"]
/* #define FX_APP_MEM_POOL_SIZE                     <Add the FX memory pool Size> */
[/#if]

[#if NX_ENABLED == "true" ]
/* #define NX_APP_MEM_POOL_SIZE                    <Add the NX memory pool Size> */
[/#if]

[#if UX_HOST_ENABLED == "true"]
/* #define UX_HOST_APP_MEM_POOL_SIZE                <Add the UXHost memory pool Size> */
[/#if]

[#if UX_DEVICE_ENABLED == "true"]
/* #define UX_DEVICE_APP_MEM_POOL_SIZE               <Add the UXDevice memory pool Size> */
[/#if]

[#if USBPD_DEVICE_ENABLED == "true"]
/* #define USBPD_DEVICE_APP_MEM_POOL_SIZE               <Add the USBPD memory pool Size> */
[/#if]
[#if TOUCHSENSING_ENABLED == "true"]
/* #define TOUCHSENSING_APP_MEM_POOL_SIZE               <Add the TOUCHSENSING memory pool Size> */
[/#if]

[#if GUI_INTERFACE_ENABLED == "true"]
/* #define GUI_INTERFACE_APP_MEM_POOL_SIZE               <Add the GUI_INTERFACE memory pool Size> */
[/#if]

[#if STM32WPAN_ENABLED == "true"]
/* #define STM32WPAN_APP_MEM_POOL_SIZE               <Add the STM32WPAN memory pool Size> */
[/#if]

[#if SECURE_MANAGER_API_ENABLED == "true"]
/* #define SECURE_MANAGER_API_APP_MEM_POOL_SIZE      <Add the SECURE MANAGER API memory pool Size> */
[/#if]

[/#if]
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */


#ifdef __cplusplus
}
#endif

#endif /* APP_AZURE_RTOS_CONFIG_H */

