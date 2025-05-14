[#ftl]
[#assign RefParam_ELOADER_ADDRESS_value = 0]
[#assign RefParam_ELOADER_END_ADDRESS_value = 0]
[#assign RefParam_ELOADER_SIZE_value = 0]
[#assign RefParam_SECTORS_NBR_value = 0]
[#assign RefParam_SECTORS_SIZE_value = 0]

[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign Value = definition.value]
    [#assign Name = definition.name]

    [#if Name == "RefParam_ELOADER_ADDRESS"]
      [#assign RefParam_ELOADER_ADDRESS_value = Value]
    [/#if]
    [#if Name == "RefParam_ELOADER_END_ADDRESS"]
      [#assign RefParam_ELOADER_END_ADDRESS_value = Value]
    [/#if]
    [#if Name == "RefParam_SECTORS_NBR"]
      [#assign RefParam_SECTORS_NBR_value = Value]
    [/#if]
	[#if Name == "RefParam_SECTORS_SIZE"]
      [#assign RefParam_SECTORS_SIZE_value = Value]
    [/#if]
    [#if Name == "RefParam_ELOADER_memory"]
      [#assign RefParam_ELOADER_memory_value = Value]
    [/#if]

    [#if Name == "RefParam_PAGE_SIZE"]
          [#assign RefParam_PAGE_SIZE_value = Value]
   [/#if]
   [#if Name == "RefParam_INIT_VAL"]
         [#assign RefParam_INIT_VAL_value = Value]
   [/#if]
   [#if Name == "RefParam_Loader_Name"]
         [#assign RefParam_Loader_Name_value = Value]
   [/#if]
   [#if Name == "RefParam_MEM_SIZE"]
         [#assign RefParam_MEM_SIZE_value = Value]
   [/#if]
   [#if Name == "RefParam_PAGE_TIMEOUT"]
         [#assign RefParam_PAGE_TIMEOUT_value = Value]
   [/#if]
   [#if Name == "RefParam_SECTOR_TIMEOUT"]
         [#assign RefParam_SECTOR_TIMEOUT_value = Value]
   [/#if]
  [/#list]
[/#if]
[/#list]
[/#compress]

/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    stm32_extmemloader_conf.h
  * @author  MCD Application Team
  * @brief   This file contains the device information.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#ifndef __EXTMEMLOADER_CONF_H_
#define __EXTMEMLOADER_CONF_H_

#include "extmemloader_init.h"
#include "stm32_extmem_conf.h"

[#if RefParam_ELOADER_memory_value == "EXTMEM1"]
#define STM32EXTLOADER_DEVICE_MEMORY_ID       EXTMEMORY_1
[#else]
#define STM32EXTLOADER_DEVICE_MEMORY_ID       EXTMEMORY_2
[/#if]
#define	STM32EXTLOADER_DEVICE_NAME            "${RefParam_Loader_Name_value}"
#define STM32EXTLOADER_DEVICE_TYPE            NOR_FLASH		
#define	STM32EXTLOADER_DEVICE_ADDR            ${RefParam_ELOADER_ADDRESS_value}
[#--#define	STM32EXTLOADER_DEVICE_SIZE            ${RefParam_ELOADER_ADDRESS_value?replace("0x","")?number - RefParam_ELOADER_END_ADDRESS_value?replace("0x","")?number}//0x8000000--]
#define	STM32EXTLOADER_DEVICE_SIZE            ${RefParam_MEM_SIZE_value}
#define	STM32EXTLOADER_DEVICE_SECTOR_NUMBERS  ${RefParam_SECTORS_NBR_value}
#define	STM32EXTLOADER_DEVICE_SECTOR_SIZE     ${RefParam_SECTORS_SIZE_value}
#define	STM32EXTLOADER_DEVICE_PAGE_SIZE       ${RefParam_PAGE_SIZE_value}
#define	STM32EXTLOADER_DEVICE_INITIAL_CONTENT ${RefParam_INIT_VAL_value}
#define STM32EXTLOADER_DEVICE_PAGE_TIMEOUT    ${RefParam_PAGE_TIMEOUT_value}
#define STM32EXTLOADER_DEVICE_SECTOR_TIMEOUT  ${RefParam_SECTOR_TIMEOUT_value}


#endif /* __EXTMEMLOADER_CONF_H_ */