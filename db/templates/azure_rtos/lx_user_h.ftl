[#ftl]
/**************************************************************************/
/*                                                                        */
/*       Copyright (c) Microsoft Corporation. All rights reserved.        */
/*                                                                        */
/*       This software is licensed under the Microsoft Software License   */
/*       Terms for Microsoft Azure RTOS. Full text of the license can be  */
/*       found in the LICENSE file at https://aka.ms/AzureRTOS_EULA       */
/*       and in the root directory of this software.                      */
/*                                                                        */
/**************************************************************************/


/**************************************************************************/
/**************************************************************************/
/**                                                                       */
/** LevelX Component                                                       */
/**                                                                       */
/**   User Specific                                                       */
/**                                                                       */
/**************************************************************************/
/**************************************************************************/

#ifndef LX_USER_H
#define LX_USER_H

[#compress]

[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]

    [#if name == "LX_DIRECT_READ"]
      [#assign LX_DIRECT_READ_value = value]
    [/#if]

    [#if name == "LX_FREE_SECTOR_DATA_VERIFY"]
      [#assign LX_FREE_SECTOR_DATA_VERIFY_value = value]
    [/#if]

    [#if name == "LX_NAND_SECTOR_MAPPING_CACHE_SIZE"]
      [#assign LX_NAND_SECTOR_MAPPING_CACHE_SIZE_value = value]
    [/#if]

    [#if name == "LX_NAND_FLASH_DIRECT_MAPPING_CACHE"]
      [#assign LX_NAND_FLASH_DIRECT_MAPPING_CACHE_value = value]
    [/#if]

    [#if name == "LX_NOR_DISABLE_EXTENDED_CACHE"]
      [#assign LX_NOR_DISABLE_EXTENDED_CACHE_value = value]
    [/#if]

    [#if name == "LX_NOR_EXTENDED_CACHE_SIZE"]
      [#assign LX_NOR_EXTENDED_CACHE_SIZE_value = value]
    [/#if]

    [#if name == "LX_NOR_SECTOR_MAPPING_CACHE_SIZE"]
      [#assign LX_NOR_SECTOR_MAPPING_CACHE_SIZE_value = value]
    [/#if]

    [#if name == "LX_THREAD_SAFE_ENABLE"]
      [#assign LX_THREAD_SAFE_ENABLE_value = value]
    [/#if]

    [/#list]
[/#if]
[/#list]
[/#compress]


[#if LX_DIRECT_READ_value == "1"]
#define LX_DIRECT_READ
[#else]
/* #define LX_DIRECT_READ */
[/#if]

[#if LX_FREE_SECTOR_DATA_VERIFY_value == "1"]
#define LX_FREE_SECTOR_DATA_VERIFY
[#else]
/* #define LX_FREE_SECTOR_DATA_VERIFY */
[/#if]

[#if LX_NAND_SECTOR_MAPPING_CACHE_SIZE_value == "128"]
/* #define LX_NAND_SECTOR_MAPPING_CACHE_SIZE         128 */
[#else]
#define LX_NAND_SECTOR_MAPPING_CACHE_SIZE         ${LX_NAND_SECTOR_MAPPING_CACHE_SIZE_value}
[/#if]

[#if LX_NAND_FLASH_DIRECT_MAPPING_CACHE_value == "1"]
#define LX_NAND_FLASH_DIRECT_MAPPING_CACHE
[#else]
/* #define LX_NAND_FLASH_DIRECT_MAPPING_CACHE */
[/#if]

[#if LX_NOR_DISABLE_EXTENDED_CACHE_value == "1"]
#define LX_NOR_DISABLE_EXTENDED_CACHE
[#else]
/* #define LX_NOR_DISABLE_EXTENDED_CACHE */
[/#if]

[#if LX_NOR_EXTENDED_CACHE_SIZE_value == "8"]
/* #define LX_NOR_EXTENDED_CACHE_SIZE         8 */
[#else]
#define LX_NOR_EXTENDED_CACHE_SIZE         ${LX_NOR_EXTENDED_CACHE_SIZE_value}
[/#if]

[#if LX_NOR_SECTOR_MAPPING_CACHE_SIZE_value == "16"]
/* #define LX_NOR_SECTOR_MAPPING_CACHE_SIZE         16 */
[#else]
#define LX_NOR_SECTOR_MAPPING_CACHE_SIZE         ${LX_NOR_SECTOR_MAPPING_CACHE_SIZE_value}
[/#if]

[#if LX_THREAD_SAFE_ENABLE_value == "1"]
#define LX_THREAD_SAFE_ENABLE
[#else]
/* #define LX_THREAD_SAFE_ENABLE */
[/#if]

#endif
