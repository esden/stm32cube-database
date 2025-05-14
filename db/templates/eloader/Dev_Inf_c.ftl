[#ftl]
/**
  ******************************************************************************
  * @file    Dev_Inf.c
  * @author  MCD Application Team
  * @brief   This file defines the structure containing information about the
  *          external flash memory used by STM32CubeProgrammer in programming/erasing
  *          the device.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

#include "Dev_Inf.h"
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
  [/#list]
[/#if]
[/#list]
[/#compress]

/* This structure contains information used by STM32CubeProgrammer to program and erase the device */
#if defined (__ICCARM__)
__root sStorageInfo const StorageInfo  =  {
#else
sStorageInfo const StorageInfo  =  {
#endif
   "ELOADER_STM32H7S78-DK",                   // Device Name
   NOR_FLASH,                                 // Device Type
   ${RefParam_ELOADER_ADDRESS_value},                                // Device Start Address
   0x10000000,                                // Device Size in Bytes (128 MBytes)
   0x100,                                     // Programming Page Size in Bytes (256 Bytes)
   0xFF,                                      // Initial Content of Erased Memory
// Specify Size and Address of Sectors (view example below)
   ${RefParam_SECTORS_NBR_value},  ${RefParam_SECTORS_SIZE_value},                    // Sector Num ,Sector Size
   0x00000000, 0x00000000,
};
