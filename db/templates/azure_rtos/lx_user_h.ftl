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
[#if FamilyName?lower_case?starts_with("stm32mp") || FamilyName?lower_case?starts_with("stm32wb")]
/*                                                           6.1.7        */
[#else]
/*                                                           6.3.0        */
[/#if]
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
[#if !FamilyName?lower_case?starts_with("stm32mp") && !FamilyName?lower_case?starts_with("stm32wb")]
/*  03-08-2023     Xiuwen Cai               Modified comment(s), and      */
/*                                            added new NAND options,     */
/*                                            resulting in version 6.2.1  */
/*  10-31-2023     Xiuwen Cai               Modified comment(s),          */
/*                                            added options for mapping , */
/*                                            bitmap cache and obsolete   */
/*                                            count cache,                */
/*                                            resulting in version 6.3.0  */
[/#if]
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

    [#if name == "LX_NOR_DISABLE_EXTENDED_CACHE"]
      [#assign LX_NOR_DISABLE_EXTENDED_CACHE_value = value]
    [/#if]    
	
	[#if name == "LX_NAND_FLASH_MAX_METADATA_BLOCKS"]
      [#assign LX_NAND_FLASH_MAX_METADATA_BLOCKS_value = value]
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

	[#if name == "LX_NOR_ENABLE_MAPPING_BITMAP"]
      [#assign LX_NOR_ENABLE_MAPPING_BITMAP_value = value]
    [/#if]

	[#if name == "LX_NOR_ENABLE_OBSOLETE_COUNT_CACHE"]
      [#assign LX_NOR_ENABLE_OBSOLETE_COUNT_CACHE_value = value]
    [/#if]

	[#if name == "LX_NOR_OBSOLETE_COUNT_CACHE_TYPE"]
      [#assign LX_NOR_OBSOLETE_COUNT_CACHE_TYPE_value = value]
    [/#if]

	[#if name == "LX_NOR_SECTOR_SIZE"]
      [#assign LX_NOR_SECTOR_SIZE_value = value]
    [/#if]

    [/#list]
[/#if]
[/#list]
[/#compress]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

[#if LX_NOR_ENABLED_Value == "true"]
/* Defined, this option bypasses the NOR flash driver read routine in favor or reading
   the NOR memory directly, resulting in a significant performance increase.
*/

[#if LX_DIRECT_READ_value == "1"]
#define LX_DIRECT_READ
[#else]
/* #define LX_DIRECT_READ */
[/#if]

/* Defined, this causes the LevelX NOR instance open logic to verify free NOR
   sectors are all ones.
*/

[#if LX_FREE_SECTOR_DATA_VERIFY_value == "1"]
#define LX_FREE_SECTOR_DATA_VERIFY
[#else]
/* #define LX_FREE_SECTOR_DATA_VERIFY */
[/#if]

/* Defined, this disabled the extended NOR cache.  */

[#if LX_NOR_DISABLE_EXTENDED_CACHE_value == "1"]
#define LX_NOR_DISABLE_EXTENDED_CACHE
[#else]
/* #define LX_NOR_DISABLE_EXTENDED_CACHE */
[/#if]

/* By default this value is 8, which represents a maximum of 8 sectors that
   can be cached in a NOR instance.
*/

[#if LX_NOR_EXTENDED_CACHE_SIZE_value == "8"]
/* #define LX_NOR_EXTENDED_CACHE_SIZE         8 */
[#else]
#define LX_NOR_EXTENDED_CACHE_SIZE         ${LX_NOR_EXTENDED_CACHE_SIZE_value}
[/#if]

/* By default this value is 16 and defines the logical sector mapping cache size.
   Large values improve performance, but cost memory. The minimum size is 8 and all
   values must be a power of 2.
*/

[#if LX_NOR_SECTOR_MAPPING_CACHE_SIZE_value == "16"]
/* #define LX_NOR_SECTOR_MAPPING_CACHE_SIZE         16 */
[#else]
#define LX_NOR_SECTOR_MAPPING_CACHE_SIZE         ${LX_NOR_SECTOR_MAPPING_CACHE_SIZE_value}
[/#if]
[/#if]

[#if LX_NOR_ENABLE_MAPPING_BITMAP_value??]
/* Determine if logical sector mapping bitmap should be enabled in extended cache.
   Cache memory will be allocated to sector mapping bitmap first. One bit can be allocated for each physical sector.
*/

[#if LX_NOR_ENABLE_MAPPING_BITMAP_value == "1"]
#define LX_NOR_ENABLE_MAPPING_BITMAP
[#else]
/* #define LX_NOR_ENABLE_MAPPING_BITMAP */
[/#if]
[/#if]

[#if LX_NOR_ENABLE_OBSOLETE_COUNT_CACHE_value??]
/* Determine if obsolete count cache should be enabled in extended cache.
   Cache memory will be allocated to obsolete count cache after the mapping bitmap if enabled,
   and the rest of the cache memory is allocated to sector cache.
*/

[#if LX_NOR_ENABLE_OBSOLETE_COUNT_CACHE_value == "1"]
#define LX_NOR_ENABLE_OBSOLETE_COUNT_CACHE
[#else]
/* #define LX_NOR_ENABLE_OBSOLETE_COUNT_CACHE */
[/#if]
[/#if]

[#if LX_NOR_OBSOLETE_COUNT_CACHE_TYPE_value??]
/* Defines obsolete count cache element size. If number of sectors per block is greater than 256, use USHORT instead of UCHAR. */

[#if LX_NOR_OBSOLETE_COUNT_CACHE_TYPE_value == "UCHAR"]
/* #define LX_NOR_OBSOLETE_COUNT_CACHE_TYPE            UCHAR */
[#else]
#define LX_NOR_OBSOLETE_COUNT_CACHE_TYPE            USHORT
[/#if]
[/#if]

[#if LX_NOR_SECTOR_SIZE_value??]
/* Define the logical sector size for NOR flash. The sector size is in units of 32-bit words.
   This sector size should match the sector size used in file system.  */

[#if LX_NOR_SECTOR_SIZE_value == "512"]
/* #define LX_NOR_SECTOR_SIZE         (512/sizeof(ULONG)) */
[#else]
#define LX_NOR_SECTOR_SIZE         (${LX_NOR_SECTOR_SIZE_value}/sizeof(ULONG))
[/#if]
[/#if]

[#if LX_NAND_FLASH_MAX_METADATA_BLOCKS_value??]
/* By default this value is 4, which represents a maximum of 4 blocks that 
   can be allocated for metadata.
*/
[#if LX_NAND_FLASH_MAX_METADATA_BLOCKS_value == "4"]
/* #define LX_NAND_FLASH_MAX_METADATA_BLOCKS         4 */
[#else]
#define LX_NAND_FLASH_MAX_METADATA_BLOCKS         ${LX_NAND_FLASH_MAX_METADATA_BLOCKS_value}
[/#if]
[/#if]

/* Defined, this makes LevelX thread-safe by using a ThreadX mutex object
   throughout the API.
*/

[#if LX_THREAD_SAFE_ENABLE_value == "1"]
#define LX_THREAD_SAFE_ENABLE
[#else]
/* #define LX_THREAD_SAFE_ENABLE */
[/#if]

/* Defined, LevelX will be used in standalone mode (without Azure RTOS ThreadX) */

[#if LX_STANDALONE_ENABLE_value??]
[#if LX_STANDALONE_ENABLE_value == "1"]
#define LX_STANDALONE_ENABLE
[#else]
/* #define LX_STANDALONE_ENABLE */
[/#if]
[/#if]

/* USER CODE BEGIN 2 */

/* Define user extension for NOR flash control block.  */

/* #define LX_NOR_FLASH_USER_EXTENSION    ???? */

/* USER CODE END 2 */

#endif
