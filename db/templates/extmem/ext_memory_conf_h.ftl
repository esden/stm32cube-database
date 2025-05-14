[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : stm32_extmem_conf.h
  * @version        : ${version}
[#--  * @packageVersion : ${fwVersion} --]
  * @brief          : Header for extmem.c file.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM32_EXTMEM_CONF__H__
#define __STM32_EXTMEM_CONF__H__

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#assign RefParam_EXTMEM_Number_of_Memory_value = "not defined"]
[#assign RefParam_EXTMEM_SFDP_value = "false"]
[#assign RefParam_EXTMEM_PSRAM_value = "false"]
[#assign RefParam_EXTMEM_SDCARD_value = "false"]
[#assign RefParam_EXTMEM_USER_value = "false"]
[#assign RefParam_EXTMEM_SAL_XSPI_value = "false"]
[#assign RefParam_EXTMEM_SAL_SD_value = "false"]

[#-- Boot info --]
[#assign RefParam_BOOT_selection_value = "not defined"]
[#assign RefParam_BOOT_enable_value = "not defined"]
[#assign RefParam_XIP_memory_value = "not defined"]
[#assign RefParam_LRUN_SRC_memory_value = "not defined"]
[#assign RefParam_LRUN_SRC_offset_value = "not defined"]
[#assign RefParam_LRUN_SRC_size_value = "not defined"]
[#assign RefParam_LRUN_DEST_memory_value = "not defined"]
[#assign RefParam_LRUN_DEST_offset_value = "not defined"]

[#-- Memory 1 info --]
[#assign RefParam_MEMORY_1_Driver_Selection_value = "not defined"]
[#assign RefParam_MEMORY_1_Instance_value = "not defined"]
[#assign RefParam_MEMORY_1_ConfigType_value = "not defined"]
[#assign RefParam_MEMORY_1_Size_value = "not defined"]
[#assign RefParam_MEMORY_1_FreqMax_value = "not defined"]
[#assign RefParam_MEMORY_1_ReadReg_value = "not defined"]
[#assign RefParam_MEMORY_1_WriteReg_value = "not defined"]
[#assign RefParam_MEMORY_1_RegSize_value = "not defined"]
[#assign RefParam_MEMORY_1_RegDummyCycle_value = "not defined"]
[#assign RefParam_MEMORY_1_WriteCommand_value = "not defined"]
[#assign RefParam_MEMORY_1_WriteDummyCycle_value = "not defined"]
[#assign RefParam_MEMORY_1_ReadCommand_value = "not defined"]
[#assign RefParam_MEMORY_1_WrapReadCommand_value = "not defined"]
[#assign RefParam_MEMORY_1_ReadDummyCycle_value = "not defined"]
[#assign RefParam_MEMORY_1_NumberOfConfig_value = "not defined"]
[#assign RefParam_MEMORY_1_Config1_WriteMask_value = "not defined"]
[#assign RefParam_MEMORY_1_Config1_WriteValue_value = "not defined"]
[#assign RefParam_MEMORY_1_Config1_RegAddress_value = "not defined"]
[#assign RefParam_MEMORY_1_Config2_WriteMask_value = "not defined"]
[#assign RefParam_MEMORY_1_Config2_WriteValue_value = "not defined"]
[#assign RefParam_MEMORY_1_Config2_RegAddress_value = "not defined"]
[#assign RefParam_MEMORY_1_Config3_WriteMask_value = "not defined"]
[#assign RefParam_MEMORY_1_Config3_WriteValue_value = "not defined"]
[#assign RefParam_MEMORY_1_Config3_RegAddress_value = "not defined"]
[#-- Memory 1 info --]
[#assign RefParam_MEMORY_2_Driver_Selection_value = "not defined"]
[#assign RefParam_MEMORY_2_Instance_value = "not defined"]
[#assign RefParam_MEMORY_2_ConfigType_value = "not defined"]
[#assign RefParam_MEMORY_2_Size_value = "not defined"]
[#assign RefParam_MEMORY_2_FreqMax_value = "not defined"]
[#assign RefParam_MEMORY_2_ReadReg_value = "not defined"]
[#assign RefParam_MEMORY_2_WriteReg_value = "not defined"]
[#assign RefParam_MEMORY_2_RegSize_value = "not defined"]
[#assign RefParam_MEMORY_2_RegDummyCycle_value = "not defined"]
[#assign RefParam_MEMORY_2_WriteCommand_value = "not defined"]
[#assign RefParam_MEMORY_2_WriteDummyCycle_value = "not defined"]
[#assign RefParam_MEMORY_2_ReadCommand_value = "not defined"]
[#assign RefParam_MEMORY_2_WrapReadCommand_value = "not defined"]
[#assign RefParam_MEMORY_2_ReadDummyCycle_value = "not defined"]
[#assign RefParam_MEMORY_2_NumberOfConfig_value = "not defined"]
[#assign RefParam_MEMORY_2_Config1_WriteMask_value = "not defined"]
[#assign RefParam_MEMORY_2_Config1_WriteValue_value = "not defined"]
[#assign RefParam_MEMORY_2_Config1_RegAddress_value = "not defined"]
[#assign RefParam_MEMORY_2_Config2_WriteMask_value = "not defined"]
[#assign RefParam_MEMORY_2_Config2_WriteValue_value = "not defined"]
[#assign RefParam_MEMORY_2_Config2_RegAddress_value = "not defined"]
[#assign RefParam_MEMORY_2_Config3_WriteMask_value = "not defined"]
[#assign RefParam_MEMORY_2_Config3_WriteValue_value = "not defined"]
[#assign RefParam_MEMORY_2_Config3_RegAddress_value = "not defined"]

[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign Value = definition.value]
    [#assign Name = definition.name]

    [#if Name == "RefParam_EXTMEM_Number_of_Memory"]
      [#assign RefParam_EXTMEM_Number_of_Memory_value = Value]
    [/#if]
    [#if Name == "RefParam_EXTMEM_SFDP_AUTO"]
      [#assign RefParam_EXTMEM_SFDP_value = Value]
    [/#if]
    [#if Name == "RefParam_EXTMEM_PSRAM_AUTO"]
      [#assign RefParam_EXTMEM_PSRAM_value = Value]
    [/#if]
    [#if Name == "RefParam_EXTMEM_SDCARD_AUTO"]
      [#assign RefParam_EXTMEM_SDCARD_value = Value]
    [/#if]
    [#if Name == "RefParam_EXTMEM_USER_AUTO"]
      [#assign RefParam_EXTMEM_USER_value = Value]
    [/#if]
    [#if Name == "RefParam_EXTMEM_SAL_XSPI_AUTO"]
      [#assign RefParam_EXTMEM_SAL_XSPI_value = Value]
    [/#if]
    [#if Name == "RefParam_EXTMEM_SAL_SD_AUTO"]
      [#assign RefParam_EXTMEM_SAL_SD_value = Value]
    [/#if]

    [#-- Boot info --]
    [#if Name == "RefParam_BOOT_selection"]
      [#assign RefParam_BOOT_selection_value = Value]
    [/#if]
    [#if Name == "RefParam_BOOT_enable"]
      [#assign RefParam_BOOT_enable_value = Value]
    [/#if]
    [#if Name == "RefParam_XIP_memory"]
      [#assign RefParam_XIP_memory_value = Value]
    [/#if]
    [#if Name == "RefParam_LRUN_SRC_memory"]
      [#assign RefParam_LRUN_SRC_memory_value = Value]
    [/#if]
    [#if Name == "RefParam_LRUN_SRC_offset"]
      [#assign RefParam_LRUN_SRC_offset_value = Value]
    [/#if]
    [#if Name == "RefParam_LRUN_SRC_size"]
      [#assign RefParam_LRUN_SRC_size_value = Value]
    [/#if]
    [#if Name == "RefParam_LRUN_DEST_memory"]
      [#assign RefParam_LRUN_DEST_memory_value = Value]
    [/#if]
    [#if Name == "RefParam_LRUN_DEST_offset"]
      [#assign RefParam_LRUN_DEST_offset_value = Value]
    [/#if]

    [#-- Memory 1 info --]
    [#if Name == "RefParam_MEMORY_1_Driver_Selection"]
      [#assign RefParam_MEMORY_1_Driver_Selection_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_1_Instance"]
      [#assign RefParam_MEMORY_1_Instance_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_1_ConfigType"]
      [#assign RefParam_MEMORY_1_ConfigType_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_1_Size"]
      [#assign RefParam_MEMORY_1_Size_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_1_FreqMax"]
      [#assign RefParam_MEMORY_1_FreqMax_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_1_ReadReg"]
      [#assign RefParam_MEMORY_1_ReadReg_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_1_WriteReg"]
      [#assign RefParam_MEMORY_1_WriteReg_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_1_RegSize"]
      [#assign RefParam_MEMORY_1_RegSize_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_1_RegDummyCycle"]
      [#assign RefParam_MEMORY_1_RegDummyCycle_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_1_WriteCommand"]
      [#assign RefParam_MEMORY_1_WriteCommand_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_1_WriteDummyCycle"]
      [#assign RefParam_MEMORY_1_WriteDummyCycle_value = Value]
    [/#if]
	[#if Name == "RefParam_MEMORY_1_ReadCommand"]
      [#assign RefParam_MEMORY_1_ReadCommand_value = Value]
    [/#if]
	[#if Name == "RefParam_MEMORY_1_WrapReadCommand"]
      [#assign RefParam_MEMORY_1_WrapReadCommand_value = Value]
    [/#if]
	[#if Name == "RefParam_MEMORY_1_ReadDummyCycle"]
      [#assign RefParam_MEMORY_1_ReadDummyCycle_value = Value]
    [/#if]
	[#if Name == "RefParam_MEMORY_1_NumberOfConfig"]
      [#assign RefParam_MEMORY_1_NumberOfConfig_value = Value]
    [/#if]
    [#if Name == "RefParam_MEMORY_1_Config1_WriteMask"]
      [#assign RefParam_MEMORY_1_Config1_WriteMask_value = Value]
    [/#if]
    [#if Name == "RefParam_MEMORY_1_Config1_WriteValue"]
      [#assign RefParam_MEMORY_1_Config1_WriteValue_value = Value]
    [/#if]
      [#if Name == "RefParam_MEMORY_1_Config1_RegAddress"]
        [#assign RefParam_MEMORY_1_Config1_RegAddress_value = Value]
      [/#if]
      [#if Name == "RefParam_MEMORY_1_Config2_WriteMask"]
        [#assign RefParam_MEMORY_1_Config2_WriteMask_value = Value]
      [/#if]
      [#if Name == "RefParam_MEMORY_1_Config2_WriteValue"]
        [#assign RefParam_MEMORY_1_Config2_WriteValue_value = Value]
      [/#if]
      [#if Name == "RefParam_MEMORY_1_Config2_RegAddress"]
        [#assign RefParam_MEMORY_1_Config2_RegAddress_value = Value]
      [/#if]
      [#if Name == "RefParam_MEMORY_1_Config3_WriteMask"]
        [#assign RefParam_MEMORY_1_Config3_WriteMask_value = Value]
      [/#if]
      [#if Name == "RefParam_MEMORY_1_Config3_WriteValue"]
        [#assign RefParam_MEMORY_1_Config3_WriteValue_value = Value]
      [/#if]
      [#if Name == "RefParam_MEMORY_1_Config3_RegAddress"]
        [#assign RefParam_MEMORY_1_Config3_RegAddress_value = Value]
      [/#if]

    [#-- Memory 2 info --]
    [#if Name == "RefParam_MEMORY_2_Driver_Selection"]
      [#assign RefParam_MEMORY_2_Driver_Selection_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_2_Instance"]
      [#assign RefParam_MEMORY_2_Instance_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_2_ConfigType"]
      [#assign RefParam_MEMORY_2_ConfigType_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_2_Size"]
      [#assign RefParam_MEMORY_2_Size_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_2_FreqMax"]
      [#assign RefParam_MEMORY_2_FreqMax_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_2_ReadReg"]
      [#assign RefParam_MEMORY_2_ReadReg_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_2_WriteReg"]
      [#assign RefParam_MEMORY_2_WriteReg_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_2_RegSize"]
      [#assign RefParam_MEMORY_2_RegSize_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_2_RegDummyCycle"]
      [#assign RefParam_MEMORY_2_RegDummyCycle_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_2_WriteCommand"]
      [#assign RefParam_MEMORY_2_WriteCommand_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_2_WriteDummyCycle"]
      [#assign RefParam_MEMORY_2_WriteDummyCycle_value = Value]
    [/#if]
  	[#if Name == "RefParam_MEMORY_2_ReadCommand"]
      [#assign RefParam_MEMORY_2_ReadCommand_value = Value]
    [/#if]
	[#if Name == "RefParam_MEMORY_2_WrapReadCommand"]
      [#assign RefParam_MEMORY_2_WrapReadCommand_value = Value]
    [/#if]
	[#if Name == "RefParam_MEMORY_2_ReadDummyCycle"]
      [#assign RefParam_MEMORY_2_ReadDummyCycle_value = Value]
    [/#if]
		[#if Name == "RefParam_MEMORY_2_NumberOfConfig"]
      [#assign RefParam_MEMORY_2_NumberOfConfig_value = Value]
    [/#if]
    [#if Name == "RefParam_MEMORY_2_Config1_WriteMask"]
      [#assign RefParam_MEMORY_2_Config1_WriteMask_value = Value]
    [/#if]
    [#if Name == "RefParam_MEMORY_2_Config1_WriteValue"]
      [#assign RefParam_MEMORY_2_Config1_WriteValue_value = Value]
    [/#if]
    [#if Name == "RefParam_MEMORY_2_Config1_RegAddress"]
      [#assign RefParam_MEMORY_2_Config1_RegAddress_value = Value]
    [/#if]
    [#if Name == "RefParam_MEMORY_2_Config2_WriteMask"]
      [#assign RefParam_MEMORY_2_Config2_WriteMask_value = Value]
    [/#if]
    [#if Name == "RefParam_MEMORY_2_Config2_WriteValue"]
      [#assign RefParam_MEMORY_2_Config2_WriteValue_value = Value]
    [/#if]
    [#if Name == "RefParam_MEMORY_2_Config2_RegAddress"]
      [#assign RefParam_MEMORY_2_Config2_RegAddress_value = Value]
    [/#if]
    [#if Name == "RefParam_MEMORY_2_Config3_WriteMask"]
      [#assign RefParam_MEMORY_2_Config3_WriteMask_value = Value]
    [/#if]
    [#if Name == "RefParam_MEMORY_2_Config3_WriteValue"]
      [#assign RefParam_MEMORY_2_Config3_WriteValue_value = Value]
    [/#if]
    [#if Name == "RefParam_MEMORY_2_Config3_RegAddress"]
      [#assign RefParam_MEMORY_2_Config3_RegAddress_value = Value]
    [/#if]
    [#-- ExtMemLoader info --]
    [#if Name == "RefParam_ELOADER_memory"]
      [#assign RefParam_ELOADER_memory_value = Value]
    [/#if]
  [/#list]
[/#if]
[/#list]
[/#compress]
[#-- Define includes --]
#n

/*
  @brief management of the driver layer enable
*/

[#assign SD_EL_USED = false]
[#if (contextFolder=="ExtMemLoader/" && RefParam_ELOADER_memory_value == "EXTMEM1")]
  [#if RefParam_MEMORY_1_Instance_value == "SDMMC1" || RefParam_MEMORY_1_Instance_value == "SDMMC2"]
    [#assign SD_EL_USED = true]
  [/#if]
[#elseif (contextFolder=="ExtMemLoader/" && RefParam_ELOADER_memory_value == "EXTMEM2")]
  [#if RefParam_MEMORY_2_Instance_value == "SDMMC1" || RefParam_MEMORY_2_Instance_value == "SDMMC2"]
    [#assign SD_EL_USED = true]
  [/#if]
[/#if]

[#if RefParam_EXTMEM_SFDP_value == "true"]
#define EXTMEM_DRIVER_NOR_SFDP   1
[#else]
#define EXTMEM_DRIVER_NOR_SFDP   0
[/#if]
[#if RefParam_EXTMEM_PSRAM_value == "true"]
#define EXTMEM_DRIVER_PSRAM      1
[#else]
#define EXTMEM_DRIVER_PSRAM      0
[/#if]
[#if RefParam_EXTMEM_SDCARD_value == "true"]
[#if (contextFolder=="ExtMemLoader/")]
    [#if SD_EL_USED == true]
#define EXTMEM_DRIVER_SDCARD     1
    [#else]
#define EXTMEM_DRIVER_SDCARD     0
    [/#if]
[#else]
#define EXTMEM_DRIVER_SDCARD     1
[/#if]
[#else]
#define EXTMEM_DRIVER_SDCARD     0
[/#if]
[#if RefParam_EXTMEM_USER_value == "true"]
#define EXTMEM_DRIVER_USER       1
[#else]
#define EXTMEM_DRIVER_USER       0
[/#if]

/*
  @brief management of the sal layer enable
*/
[#if RefParam_EXTMEM_SAL_XSPI_value == "true"]
#define EXTMEM_SAL_XSPI   1
[#else]
#define EXTMEM_SAL_XSPI   0
[/#if]
[#if RefParam_EXTMEM_SAL_SD_value == "true"]
[#if (contextFolder=="ExtMemLoader/")]
    [#if SD_EL_USED == true]
#define EXTMEM_SAL_SD     1
    [#else]
#define EXTMEM_SAL_SD     0
    [/#if]
[#else]
#define EXTMEM_SAL_SD     1
[/#if]
[#else]
#define EXTMEM_SAL_SD     0
[/#if]

/* Includes ------------------------------------------------------------------*/
#include "${FamilyName?lower_case}xx_hal.h"
#include "stm32_extmem.h"
#include "stm32_extmem_type.h"
[#if RefParam_BOOT_enable_value == "true"]
    [#if RefParam_BOOT_selection_value == "XIP"]
#include "boot/stm32_boot_xip.h"
    [/#if]
    [#if RefParam_BOOT_selection_value == "LRUN"]
#include "boot/stm32_boot_lrun.h"
    [/#if]
[/#if]
[#if includes??]
[#list includes as include]
#include "${include}"
[/#list]
[/#if]

/* USER CODE BEGIN INCLUDE */

/* USER CODE END INCLUDE */
[#-- Global variables --]
/* Private variables ---------------------------------------------------------*/
[#if RefParam_EXTMEM_Number_of_Memory_value == "1" || RefParam_EXTMEM_Number_of_Memory_value == "2"]
[#if (contextFolder!="ExtMemLoader/") || (contextFolder=="ExtMemLoader/" && RefParam_ELOADER_memory_value == "EXTMEM1")]
[#if RefParam_MEMORY_1_Driver_Selection_value != "EXTMEM_USER"]
 [#if RefParam_MEMORY_1_Instance_value == "SDMMC1"]
   [#assign RefParam_MEMORY_1_Instance_value = "sd1"]
extern SD_HandleTypeDef hsd1;
 [#else]
  [#if RefParam_MEMORY_1_Instance_value == "SDMMC2"]
    [#assign RefParam_MEMORY_1_Instance_value = "sd2"]
extern SD_HandleTypeDef hsd2;
  [#else]
extern XSPI_HandleTypeDef h${RefParam_MEMORY_1_Instance_value?lower_case};
  [/#if]
 [/#if]
[/#if]
[/#if][#-- "ExtMemLoader/" --]
[/#if]
[#if RefParam_EXTMEM_Number_of_Memory_value == "2"]
[#if (contextFolder!="ExtMemLoader/") || (contextFolder=="ExtMemLoader/" && RefParam_ELOADER_memory_value == "EXTMEM2")]
[#if RefParam_MEMORY_1_Driver_Selection_value != "EXTMEM_USER"]
 [#if RefParam_MEMORY_2_Instance_value == "SDMMC1"]
   [#assign RefParam_MEMORY_2_Instance_value = "sd1"]
extern SD_HandleTypeDef hsd1;
 [#else]
   [#if RefParam_MEMORY_2_Instance_value == "SDMMC2" ]
     [#assign RefParam_MEMORY_2_Instance_value = "sd2"]
extern SD_HandleTypeDef hsd2;
   [#else]
extern XSPI_HandleTypeDef h${RefParam_MEMORY_2_Instance_value?lower_case};
   [/#if]
 [/#if]
[/#if]
[/#if][#-- "ExtMemLoader/" --]
[/#if]


/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Exported constants --------------------------------------------------------*/
/** @defgroup EXTMEM_CONF_Exported_constants EXTMEM_CONF exported constants
  * @{
  */
[#if RefParam_EXTMEM_Number_of_Memory_value == "1"]
enum {
  EXTMEMORY_1  = 0 /*!< ID=0 for the first memory  */
};
[/#if]
[#if RefParam_EXTMEM_Number_of_Memory_value == "2"]
enum {
  EXTMEMORY_1  = 0, /*!< ID=0 for the first external memory  */
  EXTMEMORY_2  = 1, /*!< ID=1 for the second external memory */
};
[/#if]

[#if RefParam_BOOT_enable_value == "true"]
/*
  @brief management of the boot layer
*/
 [#if RefParam_BOOT_selection_value == "XIP"]
   [#if RefParam_XIP_memory_value == "EXTMEM1"]
#define EXTMEM_MEMORY_BOOTXIP  EXTMEMORY_1
   [/#if]
   [#if RefParam_XIP_memory_value == "EXTMEM2"]
#define EXTMEM_MEMORY_BOOTXIP  EXTMEMORY_2
   [/#if]
[/#if]

[#if RefParam_BOOT_selection_value == "LRUN"]
  [#if RefParam_LRUN_SRC_memory_value == "EXTMEM1"]
#define EXTMEM_LRUN_SOURCE EXTMEMORY_1
  [/#if]
  [#if RefParam_LRUN_SRC_memory_value == "EXTMEM2"]
#define EXTMEM_LRUN_SOURCE EXTMEMORY_2
  [/#if]
#define EXTMEM_LRUN_SOURCE_ADDRESS  ${RefParam_LRUN_SRC_offset_value}u
#define EXTMEM_LRUN_SOURCE_SIZE     ${RefParam_LRUN_SRC_size_value}u
  [#if RefParam_LRUN_DEST_memory_value == "EXTMEM1"]
#define EXTMEM_LRUN_DESTINATIONSOURCE EXTMEMORY_1
  [/#if]
  [#if RefParam_LRUN_DEST_memory_value == "EXTMEM2"]
#define EXTMEM_LRUN_DESTINATION EXTMEMORY_2
  [/#if]
  [#if RefParam_LRUN_DEST_memory_value == "INTERNALMEM"]
#define EXTMEM_LRUN_DESTINATION_INTERNAL  1
  [/#if]
#define EXTMEM_LRUN_DESTINATION_ADDRESS ${RefParam_LRUN_DEST_offset_value}u
 [/#if]
[/#if]

/* USER CODE BEGIN PV */

/* USER CODE END PV */


/* Exported configuration --------------------------------------------------------*/
/** @defgroup EXTMEM_CONF_Exported_configuration EXTMEM_CONF exported configuration definition
  * @{
  */
[#assign extmem_list_size = RefParam_EXTMEM_Number_of_Memory_value]
[#if (contextFolder=="ExtMemLoader/" && extmem_list_size == "2")]
[#assign extmem_list_size = "1"]
[/#if]

[#if RefParam_EXTMEM_Number_of_Memory_value == "1" || RefParam_EXTMEM_Number_of_Memory_value == "2"]
extern EXTMEM_DefinitionTypeDef extmem_list_config[${extmem_list_size}];
#if defined(EXTMEM_C)
EXTMEM_DefinitionTypeDef extmem_list_config[${extmem_list_size}];
#endif /* EXTMEM_C */
[/#if]



/**
  * @}
  */

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/*
 * -- Insert your variables declaration here --
 */
/* USER CODE BEGIN VARIABLES */

/* USER CODE END VARIABLES */

/*
 * -- Insert functions declaration here --
 */
/* USER CODE BEGIN FD */

/* USER CODE END FD */

#ifdef __cplusplus
}
#endif

#endif /* __STM32_EXTMEM_CONF__H__ */