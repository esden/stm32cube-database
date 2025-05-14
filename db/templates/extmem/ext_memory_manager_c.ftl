[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : mx_extmem.c
  * @version        : ${version}
[#--  * @packageVersion : ${fwVersion} --]
  * @brief          : This file implements the extmem configuration
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#-- Create global variables --]

/* Includes ------------------------------------------------------------------*/
#include "extmem_manager.h"
#include <string.h>
[#assign RefParam_EXTMEM_Number_of_Memory_value = "not defined"]
[#assign RefParam_MEMORY_1_Instance_value = "not defined"]
[#assign RefParam_MEMORY_2_Instance_value = "not defined"]
[#assign RefParam_ClockProtection_value = "not defined"]
[#assign RefParam_MEMORY_1_Driver_Selection_value = "not defined"]
[#assign RefParam_MEMORY_1_Driver_Selection_value = "not defined"]

[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign Value = definition.value]
    [#assign Name = definition.name]

    [#if Name == "RefParam_EXTMEM_Number_of_Memory"]
      [#assign RefParam_EXTMEM_Number_of_Memory_value = Value]
    [/#if]
    [#if Name == "RefParam_MEMORY_1_Instance"]
      [#assign RefParam_MEMORY_1_Instance_value = Value]
    [/#if]
    [#if Name == "RefParam_MEMORY_2_Instance"]
      [#assign RefParam_MEMORY_2_Instance_value = Value]
    [/#if]
    [#if Name == "RefParam_MEMORY_1_Driver_Selection"]
      [#assign RefParam_MEMORY_1_Driver_Selection_value = Value]
    [/#if]
    [#if Name == "RefParam_MEMORY_2_Driver_Selection"]
      [#assign RefParam_MEMORY_2_Driver_Selection_value = Value]
    [/#if]
  	[#if Name == "RefParam_ClockProtection"]
      [#assign RefParam_ClockProtection_value = Value]
    [/#if]
    [#if Name == "RefParam_ELOADER_memory"]
      [#assign RefParam_ELOADER_memory_value = Value]
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

[#-- IP Handles definition --]
[#if RefParam_EXTMEM_Number_of_Memory_value == "1" || RefParam_EXTMEM_Number_of_Memory_value == "2"]
[#if (contextFolder!="ExtMemLoader/") || (contextFolder=="ExtMemLoader/" && RefParam_ELOADER_memory_value == "EXTMEM1")]
[#if RefParam_MEMORY_1_Driver_Selection_value != "EXTMEM_USER"]
 [#if RefParam_MEMORY_1_Instance_value == "SDMMC1"]
   [#assign RefParam_MEMORY_1_Instance_value = "sd1"]
 [#else]
  [#if RefParam_MEMORY_1_Instance_value == "SDMMC2"]
    [#assign RefParam_MEMORY_1_Instance_value = "sd2"]
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
 [#else]
   [#if RefParam_MEMORY_2_Instance_value == "SDMMC2" ]
     [#assign RefParam_MEMORY_2_Instance_value = "sd2"]
   [/#if]
 [/#if]
[/#if]
[/#if][#-- "ExtMemLoader/" --]
[/#if]


[#-- Define includes --]
#n
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* USER CODE BEGIN PV */
/* Private variables ---------------------------------------------------------*/

/* USER CODE END PV */

/* USER CODE BEGIN PFP */
/* Private function prototypes -----------------------------------------------*/

/* USER CODE END PFP */

[#-- Global variables --]
#n
/*
 * -- Insert your variables declaration here --
 */
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

#n
/*
 * -- Insert your external function declaration here --
 */
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
#n

/**
  * Init External memory manager
  * @retval None
  */
void MX_EXTMEM_MANAGER_Init(void)
{

#t/* USER CODE BEGIN MX_EXTMEM_Init_PreTreatment */

#t/* USER CODE END MX_EXTMEM_Init_PreTreatment */
[#if RefParam_ClockProtection_value != ""]
[#if RefParam_MEMORY_1_Driver_Selection_value = "EXTMEM_USER" && RefParam_MEMORY_2_Driver_Selection_value = "EXTMEM_USER"] 
[#else]
[#if contextFolder=="ExtMemLoader/"]
#tHAL_RCCEx_DisableClockProtection(${RefParam_ClockProtection_value});
[#else]
#tHAL_RCCEx_EnableClockProtection(${RefParam_ClockProtection_value});
[/#if]
[/#if]
[/#if]

[#if (RefParam_MEMORY_2_Driver_Selection_value == "EXTMEM_NOT_USED")]
  [#assign RefParam_EXTMEM_Number_of_Memory_value = "1"]
[/#if]

[#assign extmem_list_size = RefParam_EXTMEM_Number_of_Memory_value]
[#assign idx = 1]
[#if (contextFolder=="ExtMemLoader/" && extmem_list_size == "2")]
  [#assign extmem_list_size = "1"]
  [#assign idx = 0]
[/#if]

[#if RefParam_EXTMEM_Number_of_Memory_value == "1" || RefParam_EXTMEM_Number_of_Memory_value == "2"]
  /* Initialization of the memory parameters */
  memset(extmem_list_config, 0x0, sizeof(extmem_list_config));

[#if (contextFolder!="ExtMemLoader/") || (contextFolder=="ExtMemLoader/" && RefParam_ELOADER_memory_value == "EXTMEM1")]
  /* EXTMEMORY_1 */
  extmem_list_config[0].MemType = ${RefParam_MEMORY_1_Driver_Selection_value};
[#if RefParam_MEMORY_1_Driver_Selection_value != "EXTMEM_USER"]
  extmem_list_config[0].Handle = (void*)&h${RefParam_MEMORY_1_Instance_value?lower_case};
  extmem_list_config[0].ConfigType = ${RefParam_MEMORY_1_ConfigType_value};

[#if RefParam_MEMORY_1_Driver_Selection_value == "EXTMEM_PSRAM"]
  extmem_list_config[0].PsramObject.psram_public.MemorySize = ${RefParam_MEMORY_1_Size_value};
  extmem_list_config[0].PsramObject.psram_public.FreqMax = ${RefParam_MEMORY_1_FreqMax_value} * 1000000u;
  extmem_list_config[0].PsramObject.psram_public.NumberOfConfig = ${RefParam_MEMORY_1_NumberOfConfig_value}u;

[#if RefParam_MEMORY_1_NumberOfConfig_value == "1" || RefParam_MEMORY_1_NumberOfConfig_value == "2" || RefParam_MEMORY_1_NumberOfConfig_value == "3"]
  /* Config */
  extmem_list_config[0].PsramObject.psram_public.config[0].WriteMask = ${RefParam_MEMORY_1_Config1_WriteMask_value}u;
  extmem_list_config[0].PsramObject.psram_public.config[0].WriteValue = ${RefParam_MEMORY_1_Config1_WriteValue_value}u;
  extmem_list_config[0].PsramObject.psram_public.config[0].REGAddress = ${RefParam_MEMORY_1_Config1_RegAddress_value}u;
[/#if]
[#if RefParam_MEMORY_1_NumberOfConfig_value == "2" || RefParam_MEMORY_1_NumberOfConfig_value == "3"]

  extmem_list_config[0].PsramObject.psram_public.config[1].WriteMask = ${RefParam_MEMORY_1_Config2_WriteMask_value}u;
  extmem_list_config[0].PsramObject.psram_public.config[1].WriteValue = ${RefParam_MEMORY_1_Config2_WriteValue_value}u;
  extmem_list_config[0].PsramObject.psram_public.config[1].REGAddress = ${RefParam_MEMORY_1_Config2_RegAddress_value}u;

[/#if]
[#if RefParam_MEMORY_1_NumberOfConfig_value == "3"]

  extmem_list_config[0].PsramObject.psram_public.config[2].WriteMask = ${RefParam_MEMORY_1_Config3_WriteMask_value}u;
  extmem_list_config[0].PsramObject.psram_public.config[2].WriteValue = ${RefParam_MEMORY_1_Config3_WriteValue_value}u;
  extmem_list_config[0].PsramObject.psram_public.config[2].REGAddress = ${RefParam_MEMORY_1_Config3_RegAddress_value}u;

[/#if]
  /* Memory command configuration */
  extmem_list_config[0].PsramObject.psram_public.ReadREG           = ${RefParam_MEMORY_1_ReadReg_value}u;
  extmem_list_config[0].PsramObject.psram_public.WriteREG          = ${RefParam_MEMORY_1_WriteReg_value}u;
  extmem_list_config[0].PsramObject.psram_public.ReadREGSize       = ${RefParam_MEMORY_1_RegSize_value}u;
  extmem_list_config[0].PsramObject.psram_public.REG_DummyCycle    = ${RefParam_MEMORY_1_RegDummyCycle_value}u;
  extmem_list_config[0].PsramObject.psram_public.Write_command     = ${RefParam_MEMORY_1_WriteCommand_value}u;
  extmem_list_config[0].PsramObject.psram_public.Write_DummyCycle  = ${RefParam_MEMORY_1_WriteDummyCycle_value}u;
  extmem_list_config[0].PsramObject.psram_public.Read_command      = ${RefParam_MEMORY_1_ReadCommand_value}u;
  extmem_list_config[0].PsramObject.psram_public.WrapRead_command  = ${RefParam_MEMORY_1_WrapReadCommand_value}u;
  extmem_list_config[0].PsramObject.psram_public.Read_DummyCycle   = ${RefParam_MEMORY_1_ReadDummyCycle_value}u;

[/#if]
[/#if]
[/#if][#-- "ExtMemLoader/" --]

[#if RefParam_EXTMEM_Number_of_Memory_value == "2"]
[#if (contextFolder!="ExtMemLoader/") || (contextFolder=="ExtMemLoader/" && RefParam_ELOADER_memory_value == "EXTMEM2")]
  /* EXTMEMORY_2 */
  extmem_list_config[${idx}].MemType = ${RefParam_MEMORY_2_Driver_Selection_value};
[#if RefParam_MEMORY_2_Driver_Selection_value != "EXTMEM_USER"]
  extmem_list_config[${idx}].Handle = (void*)&h${RefParam_MEMORY_2_Instance_value?lower_case};
  extmem_list_config[${idx}].ConfigType = ${RefParam_MEMORY_2_ConfigType_value};

[#if RefParam_MEMORY_2_Driver_Selection_value == "EXTMEM_PSRAM"]
  extmem_list_config[${idx}].PsramObject.psram_public.MemorySize = ${RefParam_MEMORY_2_Size_value};
  extmem_list_config[${idx}].PsramObject.psram_public.FreqMax = ${RefParam_MEMORY_2_FreqMax_value} * 1000000u;
  extmem_list_config[${idx}].PsramObject.psram_public.NumberOfConfig = ${RefParam_MEMORY_2_NumberOfConfig_value}u;

[#if RefParam_MEMORY_2_NumberOfConfig_value == "1" || RefParam_MEMORY_2_NumberOfConfig_value == "2" || RefParam_MEMORY_2_NumberOfConfig_value == "3"]
  /* Config */
  extmem_list_config[${idx}].PsramObject.psram_public.config[0].WriteMask = ${RefParam_MEMORY_2_Config1_WriteMask_value}u;
  extmem_list_config[${idx}].PsramObject.psram_public.config[0].WriteValue = ${RefParam_MEMORY_2_Config1_WriteValue_value}u;
  extmem_list_config[${idx}].PsramObject.psram_public.config[0].REGAddress = ${RefParam_MEMORY_2_Config1_RegAddress_value}u;

[/#if]
[#if RefParam_MEMORY_2_NumberOfConfig_value == "2" || RefParam_MEMORY_2_NumberOfConfig_value == "3"]
  extmem_list_config[${idx}].PsramObject.psram_public.config[1].WriteMask = ${RefParam_MEMORY_2_Config2_WriteMask_value}u;
  extmem_list_config[${idx}].PsramObject.psram_public.config[1].WriteValue = ${RefParam_MEMORY_2_Config2_WriteValue_value}u;
  extmem_list_config[${idx}].PsramObject.psram_public.config[1].REGAddress = ${RefParam_MEMORY_2_Config2_RegAddress_value}u;

[/#if]
[#if RefParam_MEMORY_2_NumberOfConfig_value == "3"]
  extmem_list_config[${idx}].PsramObject.psram_public.config[2].WriteMask = ${RefParam_MEMORY_2_Config3_WriteMask_value}u;
  extmem_list_config[${idx}].PsramObject.psram_public.config[2].WriteValue = ${RefParam_MEMORY_2_Config3_WriteValue_value}u;
  extmem_list_config[${idx}].PsramObject.psram_public.config[2].REGAddress = ${RefParam_MEMORY_2_Config3_RegAddress_value}u;

[/#if]
  /* Memory command configuration */
  extmem_list_config[${idx}].PsramObject.psram_public.ReadREG           = ${RefParam_MEMORY_2_ReadReg_value}u;
  extmem_list_config[${idx}].PsramObject.psram_public.WriteREG          = ${RefParam_MEMORY_2_WriteReg_value}u;
  extmem_list_config[${idx}].PsramObject.psram_public.ReadREGSize       = ${RefParam_MEMORY_2_RegSize_value}u;
  extmem_list_config[${idx}].PsramObject.psram_public.REG_DummyCycle    = ${RefParam_MEMORY_2_RegDummyCycle_value}u;
  extmem_list_config[${idx}].PsramObject.psram_public.Write_command     = ${RefParam_MEMORY_2_WriteCommand_value}u;
  extmem_list_config[${idx}].PsramObject.psram_public.Write_DummyCycle  = ${RefParam_MEMORY_2_WriteDummyCycle_value}u;
  extmem_list_config[${idx}].PsramObject.psram_public.Read_command      = ${RefParam_MEMORY_2_ReadCommand_value}u;
  extmem_list_config[${idx}].PsramObject.psram_public.WrapRead_command  = ${RefParam_MEMORY_2_WrapReadCommand_value}u;
  extmem_list_config[${idx}].PsramObject.psram_public.Read_DummyCycle   = ${RefParam_MEMORY_2_ReadDummyCycle_value}u;
[/#if]
[/#if][#-- "ExtMemLoader/" --]
[/#if]
[/#if]

[/#if]

[#if RefParam_EXTMEM_Number_of_Memory_value == "1" || RefParam_EXTMEM_Number_of_Memory_value == "2"]
[#if RefParam_MEMORY_1_Driver_Selection_value = "EXTMEM_USER"]
[#if contextFolder=="ExtMemLoader/" && RefParam_ELOADER_memory_value != "EXTMEM1"]
[#else]
  EXTMEM_Init(EXTMEMORY_1, 0);
[/#if]
[#else]
[#if contextFolder=="ExtMemLoader/" && RefParam_ELOADER_memory_value != "EXTMEM1"]
[#else]
[#if RefParam_MEMORY_1_Instance_value = "sd1" || RefParam_MEMORY_1_Instance_value = "sd2"]
  EXTMEM_Init(EXTMEMORY_1, HAL_RCCEx_GetPeriphCLKFreq(RCC_PERIPHCLK_SDMMC12));
[#else]
  EXTMEM_Init(EXTMEMORY_1, HAL_RCCEx_GetPeriphCLKFreq(RCC_PERIPHCLK_${RefParam_MEMORY_1_Instance_value}));
[/#if]
[/#if]
[/#if]
[/#if]
[#if RefParam_EXTMEM_Number_of_Memory_value == "2"]
[#if RefParam_MEMORY_2_Driver_Selection_value == "EXTMEM_USER"]
[#if contextFolder=="ExtMemLoader/" && RefParam_ELOADER_memory_value != "EXTMEM2"]
[#else]
  EXTMEM_Init(EXTMEMORY_2, 0);
[/#if]
[#else]
[#if contextFolder=="ExtMemLoader/" && RefParam_ELOADER_memory_value != "EXTMEM2"]
[#else]
[#if RefParam_MEMORY_2_Instance_value = "sd1" || RefParam_MEMORY_2_Instance_value = "sd2"]
  EXTMEM_Init(EXTMEMORY_2, HAL_RCCEx_GetPeriphCLKFreq(RCC_PERIPHCLK_SDMMC12));
[#else]
  EXTMEM_Init(EXTMEMORY_2, HAL_RCCEx_GetPeriphCLKFreq(RCC_PERIPHCLK_${RefParam_MEMORY_2_Instance_value}));
[/#if]
[/#if]
[/#if]
[/#if]

#t/* USER CODE BEGIN MX_EXTMEM_Init_PostTreatment */
#t
#t/* USER CODE END MX_EXTMEM_Init_PostTreatment */
}