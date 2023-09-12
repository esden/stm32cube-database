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
/** LevelX Component                                                      */
/**                                                                       */
/**   User Specific                                                       */
/**                                                                       */
/**************************************************************************/
/**************************************************************************/


/**************************************************************************/
/*                                                                        */
/*  PORT SPECIFIC C INFORMATION                            RELEASE        */
/*                                                                        */
/*    lx_user.h                                           PORTABLE C      */
/*                                                           6.1.7        */
/*                                                                        */
/*  AUTHOR                                                                */
/*                                                                        */
/*    William E. Lamie, Microsoft Corporation                             */
/*                                                                        */
/*  DESCRIPTION                                                           */
/*                                                                        */
/*    This file contains user defines for configuring LevelX in specific  */
/*    ways. This file will have an effect only if the application and     */
/*    LevelX library are built with LX_INCLUDE_USER_DEFINE_FILE defined.  */
/*    Note that all the defines in this file may also be made on the      */
/*    command line when building LevelX library and application objects.  */
/*                                                                        */
/*  RELEASE HISTORY                                                       */
/*                                                                        */
/*    DATE              NAME                      DESCRIPTION             */
/*                                                                        */
/*  11-09-2020     William E. Lamie         Initial Version 6.1.2         */
/*  06-02-2021     Bhupendra Naphade        Modified comment(s), and      */
/*                                            added standalone support,   */
/*                                            resulting in version 6.1.7  */
/*                                                                        */
/**************************************************************************/

#ifndef LX_USER_H
#define LX_USER_H

[#compress]

[#assign LX_NOR_ENABLED_Value = "false"]
[#assign LX_NAND_ENABLED_Value  = "false"]
[#assign LX_STANDALONE_ENABLE_Value  = "0"]

[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
  [#list SWIP.variables as define]
	[#assign name = define.name]
	[#assign value = define.value]
[#if name?contains("LX_NOR_Flash_Support") && (value=="1")]
[#assign LX_NOR_ENABLED_Value = "true"]
[/#if]

[#if name?contains("LX_NAND_Flash_Support") && (value=="1")]
[#assign LX_NAND_ENABLED_Value = "true"]
[/#if]

[/#list]
[/#if]
[/#list]

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
	
    [#if name == "LX_STANDALONE_ENABLE"]
      [#assign LX_STANDALONE_ENABLE_value = value]
    [/#if]

    [/#list]
[/#if]
[/#list]
[/#compress]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

[#if LX_NOR_ENABLED_Value == "true"]
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
[/#if]

[#if LX_NAND_ENABLED_Value == "true"]
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
[/#if]

/* Configure the LevelX in Standalone mode. */


[#if LX_STANDALONE_ENABLE_value??]
[#if LX_STANDALONE_ENABLE_value == "1"]
#define LX_STANDALONE_ENABLE
[#else]
/* #define LX_STANDALONE_ENABLE */
[/#if]
[/#if]


[#if LX_THREAD_SAFE_ENABLE_value == "1"]
#define LX_THREAD_SAFE_ENABLE
[#else]
/* #define LX_THREAD_SAFE_ENABLE */
[/#if]

/* USER CODE BEGIN 2 */

/* USER CODE END 2 */

#endif
