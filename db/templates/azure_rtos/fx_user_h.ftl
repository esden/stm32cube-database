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
/** FileX Component                                                       */
/**                                                                       */
/**   User Specific                                                       */
/**                                                                       */
/**************************************************************************/
/**************************************************************************/

[#assign familyName=FamilyName?lower_case]
/**************************************************************************/
/*                                                                        */
/*  PORT SPECIFIC C INFORMATION                            RELEASE        */
/*                                                                        */
/*    fx_user.h                                           PORTABLE C      */
/*                                                           6.1.10       */
/*                                                                        */
/*  AUTHOR                                                                */
/*                                                                        */
/*    William E. Lamie, Microsoft Corporation                             */
/*                                                                        */
/*  DESCRIPTION                                                           */
/*                                                                        */
/*    This file contains user defines for configuring FileX in specific   */
/*    ways. This file will have an effect only if the application and     */
/*    FileX library are built with FX_INCLUDE_USER_DEFINE_FILE defined.   */
/*    Note that all the defines in this file may also be made on the      */
/*    command line when building FileX library and application objects.   */
/*                                                                        */
/*  RELEASE HISTORY                                                       */
/*                                                                        */
/*    DATE              NAME                      DESCRIPTION             */
/*                                                                        */
/*  05-19-2020     William E. Lamie         Initial Version 6.0           */
/*  09-30-2020     William E. Lamie         Modified comment(s), and      */
/*                                            added product constants     */
/*                                            to enable code              */
/*                                            size optimization,          */
/*                                            resulting in version 6.1    */
/*  03-02-2021     William E. Lamie         Modified comment(s), and      */
/*                                            added standalone support,   */
/*                                            resulting in version 6.1.5  */
/*  01-31-2022     Bhupendra Naphade        Modified comment(s), and      */
/*                                            added product constant to   */
/*                                            support variable sector     */
/*                                            size in exFAT,              */
/*                                            resulting in version 6.1.10 */
/*                                                                        */
/**************************************************************************/

#ifndef FX_USER_H
#define FX_USER_H

[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
    [#if name == "FX_DISABLE_DIRECT_DATA_READ_CACHE_FILL"]
      [#assign FX_DISABLE_DIRECT_DATA_READ_CACHE_FILL_value = value]
    [/#if]

    [#if name == "FX_DISABLE_ERROR_CHECKING"]
      [#assign FX_DISABLE_ERROR_CHECKING_value = value]
    [/#if]

    [#if name == "FX_DONT_UPDATE_OPEN_FILES"]
      [#assign FX_DONT_UPDATE_OPEN_FILES_value = value]
    [/#if]

    [#if name == "FX_DRIVER_USE_64BIT_LBA"]
      [#assign FX_DRIVER_USE_64BIT_LBA_value = value]
    [/#if]

    [#if name == "FX_ENABLE_EXFAT"]
      [#assign FX_ENABLE_EXFAT_value = value]
    [/#if]

    [#if name == "FX_ENABLE_FAULT_TOLERANT"]
      [#assign FX_ENABLE_FAULT_TOLERANT_value = value]
    [/#if]

    [#if name == "FX_FAT_MAP_SIZE"]
      [#assign FX_FAT_MAP_SIZE_value = value]
    [/#if]

    [#if name == "FX_FAULT_TOLERANT"]
      [#assign FX_FAULT_TOLERANT_value = value]
    [/#if]

    [#if name == "FX_FAULT_TOLERANT_BOOT_INDEX"]
      [#assign FX_FAULT_TOLERANT_BOOT_INDEX_value = value]
    [/#if]

    [#if name == "FX_FAULT_TOLERANT_DATA"]
      [#assign FX_FAULT_TOLERANT_DATA_value = value]
    [/#if]

    [#if name == "FX_MAX_FAT_CACHE"]
      [#assign FX_MAX_FAT_CACHE_value = value]
    [/#if]

    [#if name == "FX_MAX_LAST_NAME_LEN"]
      [#assign FX_MAX_LAST_NAME_LEN_value = value]
    [/#if]

    [#if name == "FX_MAX_LONG_NAME_LEN"]
      [#assign FX_MAX_LONG_NAME_LEN_value = value]
    [/#if]

    [#if name == "FX_MAX_SECTOR_CACHE"]
      [#assign FX_MAX_SECTOR_CACHE_value = value]
    [/#if]

    [#if name == "FX_MEDIA_DISABLE_SEARCH_CACHE"]
      [#assign FX_MEDIA_DISABLE_SEARCH_CACHE_value = value]
    [/#if]

    [#if name == "FX_MEDIA_STATISTICS_DISABLE"]
      [#assign FX_MEDIA_STATISTICS_DISABLE_value = value]
    [/#if]

    [#if name == "FX_RENAME_PATH_INHERIT"]
      [#assign FX_RENAME_PATH_INHERIT_value = value]
    [/#if]

    [#if name == "FX_SINGLE_OPEN_LEGACY"]
      [#assign FX_SINGLE_OPEN_LEGACY_value = value]
    [/#if]

    [#if name == "FX_UPDATE_RATE_IN_SECONDS"]
      [#assign FX_UPDATE_RATE_IN_SECONDS_value = value]
    [/#if]

    [#if name == "FX_UPDATE_RATE_IN_TICKS"]
      [#assign FX_UPDATE_RATE_IN_TICKS_value = value]
    [/#if]

    [#if name == "ULONG_64_DEFINED"]
      [#assign ULONG_64_DEFINED_value = value]
    [/#if]

	[#if name == "FX_STANDALONE_ENABLE"]
      [#assign FX_STANDALONE_ENABLE_value = value]
    [/#if]
	
	[#if name == "FX_SINGLE_THREAD"]
      [#assign FX_SINGLE_THREAD_value = value]
    [/#if]
	
	[#if name == "FX_NO_LOCAL_PATH"]
      [#assign FX_NO_LOCAL_PATH_value = value]
    [/#if]
	
	[#if name == "FX_NO_TIMER"]
      [#assign FX_NO_TIMER_value = value]
    [/#if]
	
	[#if name == "FX_DISABLE_CACHE"]
      [#assign FX_DISABLE_CACHE_value = value]
    [/#if]

    [#if name == "FX_DISABLE_FILE_CLOSE"]
      [#assign FX_DISABLE_FILE_CLOSE_value = value]
    [/#if]

    [#if name == "FX_DISABLE_FAST_OPEN"]
      [#assign FX_DISABLE_FAST_OPEN_value = value]
    [/#if]

    [#if name == "FX_DISABLE_FORCE_MEMORY_OPERATION"]
      [#assign FX_DISABLE_FORCE_MEMORY_OPERATION_value = value]
    [/#if]

    [#if name == "FX_DISABLE_BUILD_OPTIONS"]
      [#assign FX_DISABLE_BUILD_OPTIONS_value = value]
    [/#if]

    [#if name == "FX_DISABLE_ONE_LINE_FUNCTION"]
      [#assign FX_DISABLE_ONE_LINE_FUNCTION_value = value]
    [/#if]

    [#if name == "FX_DISABLE_FAT_ENTRY_REFRESH"]
      [#assign FX_DISABLE_FAT_ENTRY_REFRESH_value = value]
    [/#if]

    [#if name == "FX_DISABLE_CONSECUTIVE_DETECT"]
      [#assign FX_DISABLE_CONSECUTIVE_DETECT_value = value]
    [/#if]

    [#if name == "FX_EXFAT_MAX_CACHE_SIZE"]
      [#assign FX_EXFAT_MAX_CACHE_SIZE_value = value]
    [/#if]

    [#if name == "FX_FAULT_TOLERANT_CACHE_SIZE"]
      [#assign FX_FAULT_TOLERANT_CACHE_SIZE_value = value]
    [/#if]

    [/#list]
[/#if]
[/#list]
[/#compress]
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

/* Define various build options for the FileX port.  The application should either make changes
   here by commenting or un-commenting the conditional compilation defined OR supply the defines though the compiler's equivalent of the -D option.  */

/* Override various options with default values already assigned in fx_api.h or fx_port.h.
  Please also refer to fx_port.h for descriptions on each of these options.  */

[#if ULONG_64_DEFINED_value == "true"]
/* Avoid doule definition warning, as ULONG64 typedef is already defined by ThreadX */
#define ULONG64_DEFINED
[#else]
/* #define ULONG64_DEFINED */
[/#if]

[#if familyName?starts_with("stm32c0")]
/* Defined, the direct read sector update of cache is disabled.  */
[#else]
/* Direct read sector cache will be disabled if cache is disabled.  */
[/#if]

[#if FX_DISABLE_DIRECT_DATA_READ_CACHE_FILL_value == "1"]
#define FX_DISABLE_DIRECT_DATA_READ_CACHE_FILL
[#else]
/* #define FX_DISABLE_DIRECT_DATA_READ_CACHE_FILL */
[/#if]


/* Determine if error checking is desired.  If so, map API functions
   to the appropriate error checking front-ends.  Otherwise, map API
   functions to the core functions that actually perform the work.
   Note: error checking is enabled by default.  */

[#if FX_DISABLE_ERROR_CHECKING_value == "1"]
#define FX_DISABLE_ERROR_CHECKING
[#else]
/* #define FX_DISABLE_ERROR_CHECKING */
[/#if]


/* Defined, FileX does not update already opened files.  */

[#if FX_DONT_UPDATE_OPEN_FILES_value == "1"]
#define FX_DONT_UPDATE_OPEN_FILES
[#else]
/* #define FX_DONT_UPDATE_OPEN_FILES */
[/#if]


/* Defined, enables 64-bits sector addresses used in I/O driver.  */

[#if FX_DRIVER_USE_64BIT_LBA_value == "1"]
#define FX_DRIVER_USE_64BIT_LBA
[#else]
/* #define FX_DRIVER_USE_64BIT_LBA */
[/#if]


/* Defined, FileX is able to access exFAT file system.

   FileX supports the Microsoft exFAT file system format.
   Your use of exFAT technology in your products requires a separate
   license from Microsoft. Please see the following link for further
   details on exFAT licensing:

   https://www.microsoft.com/en-us/legal/intellectualproperty/mtl/exfat-licensing.aspx
*/

[#if FX_ENABLE_EXFAT_value == "1"]
#define FX_ENABLE_EXFAT
[#else]
/* #define FX_ENABLE_EXFAT */
[/#if]


/* Defined, enables FileX fault tolerant service.  */

[#if FX_ENABLE_FAULT_TOLERANT_value == "1"]
#define FX_ENABLE_FAULT_TOLERANT
[#else]
/* #define FX_ENABLE_FAULT_TOLERANT */
[/#if]


/* Defines the size in bytes of the bit map used to update the secondary FAT sectors.
   The larger the value the less unnecessary secondary FAT sector writes.   */

[#if FX_FAT_MAP_SIZE_value == "128"]
/* #define FX_FAT_MAP_SIZE         128 */
[#else]
#define FX_FAT_MAP_SIZE         ${FX_FAT_MAP_SIZE_value}
[/#if]


/* Defined, data sector write requests are flushed immediately to the driver.  */

[#if FX_FAULT_TOLERANT_value == "1"]
#define FX_FAULT_TOLERANT
[#else]
/* #define FX_FAULT_TOLERANT */
[/#if]


/* Define byte offset in boot sector where the cluster number of the Fault Tolerant Log file is.
   Note that this field (byte 116 to 119) is marked as reserved by FAT 12/16/32/exFAT specification. */

[#if FX_FAULT_TOLERANT_BOOT_INDEX_value == "116"]
/* #define FX_FAULT_TOLERANT_BOOT_INDEX         116 */
[#else]
#define FX_FAULT_TOLERANT_BOOT_INDEX  ${FX_FAULT_TOLERANT_BOOT_INDEX_value}
[/#if]


/* Defined, data sector write requests are flushed immediately to the driver.  */

[#if FX_FAULT_TOLERANT_DATA_value == "1"]
#define FX_FAULT_TOLERANT_DATA
[#else]
/* #define FX_FAULT_TOLERANT_DATA */
[/#if]


/* Defines the number of entries in the FAT cache.  */

[#if FX_MAX_FAT_CACHE_value == "16"]
/* #define FX_MAX_FAT_CACHE         16 */
[#else]
#define FX_MAX_FAT_CACHE        ${FX_MAX_FAT_CACHE_value}
[/#if]


/* Defines the maximum size of long file names supported by FileX.
   The minimum value is 13 and the maximum value is 256.  */

[#if FX_MAX_LAST_NAME_LEN_value == "256"]
/* #define FX_MAX_LAST_NAME_LEN         256 */
[#else]
#define FX_MAX_LAST_NAME_LEN      ${FX_MAX_LAST_NAME_LEN_value}
[/#if]

[#if familyName?starts_with("stm32c0")]
#define FX_MAX_SHORT_NAME_LEN                  13       /* Only allowed value is 13.  */
[/#if]


[#if FX_MAX_LONG_NAME_LEN_value == "256"]
/* #define FX_MAX_LONG_NAME_LEN         256 */
[#else]
#define FX_MAX_LONG_NAME_LEN      ${FX_MAX_LONG_NAME_LEN_value}
[/#if]


/* Defines the maximum number of logical sectors that can be cached by FileX. The cache memory
   supplied to FileX at fx_media_open determines how many sectors can actually be cached.  */

[#if FX_MAX_SECTOR_CACHE_value == "256"]
/* #define FX_MAX_SECTOR_CACHE         256 */
[#else]
#define FX_MAX_SECTOR_CACHE       ${FX_MAX_SECTOR_CACHE_value}
[/#if]
 

/* Defined, the file search cache optimization is disabled.  */

[#if FX_MEDIA_DISABLE_SEARCH_CACHE_value == "1"]
#define FX_MEDIA_DISABLE_SEARCH_CACHE
[#else]
/* #define FX_MEDIA_DISABLE_SEARCH_CACHE */
[/#if]
 

/* Defined, gathering of media statistics is disabled.  */

[#if FX_MEDIA_STATISTICS_DISABLE_value == "1"]
#define FX_MEDIA_STATISTICS_DISABLE
[#else]
/* #define FX_MEDIA_STATISTICS_DISABLE */
[/#if]


/* Defined, local path logic is disabled.  */

[#if FX_NO_LOCAL_PATH_value == "1"]
#define FX_NO_LOCAL_PATH
[#else]
/* #define FX_NO_LOCAL_PATH */
[/#if]


/* Defined, FileX is built without update to the time parameters.  */

[#if FX_NO_TIMER_value == "1"]
#define FX_NO_TIMER
[#else]
/* #define FX_NO_TIMER */
[/#if]


/* Defined, renaming inherits path information.  */

[#if FX_RENAME_PATH_INHERIT_value == "1"]
#define FX_RENAME_PATH_INHERIT
[#else]
/* #define FX_RENAME_PATH_INHERIT */
[/#if]


/* Defined, legacy single open logic for the same file is enabled.  */

[#if FX_SINGLE_OPEN_LEGACY_value == "1"]
#define FX_SINGLE_OPEN_LEGACY
[#else]
/* #define FX_SINGLE_OPEN_LEGACY */
[/#if]


/* Define FileX internal protection macros.  If FX_SINGLE_THREAD is defined,
   these protection macros are effectively disabled.  However, for multi-thread
   uses, the macros are setup to utilize a ThreadX mutex for multiple thread
   access control into an open media.  */

[#if FX_SINGLE_THREAD_value == "1"]
#define FX_SINGLE_THREAD
[#else]
/* #define FX_SINGLE_THREAD */
[/#if]

[#if !familyName?starts_with("stm32c0")]
/* Configure the FileX in Standalone mode */
[/#if]

[#if FX_STANDALONE_ENABLE_value == "1"]
#define FX_STANDALONE_ENABLE
[#else]
/* #define FX_STANDALONE_ENABLE */
[/#if]

/* Defines the number of seconds the time parameters are updated in FileX.  */

[#if FX_UPDATE_RATE_IN_SECONDS_value == "10"]
/* #define FX_UPDATE_RATE_IN_SECONDS         10 */
[#else]
#define FX_UPDATE_RATE_IN_SECONDS   ${FX_UPDATE_RATE_IN_SECONDS_value}
[/#if]


/* Defines the number of ThreadX timer ticks required to achieve the update rate specified by
   FX_UPDATE_RATE_IN_SECONDS defined previously. By default, the ThreadX timer tick is 10ms,
   so the default value for this constant is 1000.  */

[#if FX_UPDATE_RATE_IN_TICKS_value == "1000"]
/* #define FX_UPDATE_RATE_IN_TICKS         1000 */
[#else]
#define FX_UPDATE_RATE_IN_TICKS     ${FX_UPDATE_RATE_IN_TICKS_value}
[/#if]

[#if familyName?starts_with("stm32c0")]
/* If defined, cache is disabled.  */
[#else]
/* Determine if cache is disabled.  */
[/#if]

[#if FX_DISABLE_CACHE_value == "1"]
#define FX_DISABLE_CACHE
[#else]
/*#define FX_DISABLE_CACHE   */
[/#if]


/* If defined, file close is disabled.  */

[#if FX_DISABLE_FILE_CLOSE_value == "1"]
#define FX_DISABLE_FILE_CLOSE
[#else]
/* #define FX_DISABLE_FILE_CLOSE */
[/#if]


/* If defined, fast open is disabled.  */

[#if FX_DISABLE_FAST_OPEN_value == "1"]
#define FX_DISABLE_FAST_OPEN
[#else]
/* #define FX_DISABLE_FAST_OPEN */
[/#if]


/* If defined, force memory operations are disabled.  */

[#if FX_DISABLE_FORCE_MEMORY_OPERATION_value == "1"]
#define FX_DISABLE_FORCE_MEMORY_OPERATION
[#else]
/* #define FX_DISABLE_FORCE_MEMORY_OPERATION */
[/#if]


/* If defined, build options is disabled.  */

[#if FX_DISABLE_BUILD_OPTIONS_value == "1"]
#define FX_DISABLE_BUILD_OPTIONS
[#else]
/* #define FX_DISABLE_BUILD_OPTIONS */
[/#if]


/* If defined, one line function is disabled.  */

[#if FX_DISABLE_ONE_LINE_FUNCTION_value == "1"]
#define FX_DISABLE_ONE_LINE_FUNCTION
[#else]
/* #define FX_DISABLE_ONE_LINE_FUNCTION */
[/#if]


/* If defined, FAT entry refresh is disabled.  */

[#if FX_DISABLE_FAT_ENTRY_REFRESH_value == "1"]
#define FX_DISABLE_FAT_ENTRY_REFRESH
[#else]
/* #define FX_DISABLE_FAT_ENTRY_REFRESH */
[/#if]


/* If defined, consecutive detect is disabled.  */

[#if FX_DISABLE_CONSECUTIVE_DETECT_value == "1"]
#define FX_DISABLE_CONSECUTIVE_DETECT
[#else]
/* #define FX_DISABLE_CONSECUTIVE_DETECT */
[/#if]

[#if FX_EXFAT_MAX_CACHE_SIZE_value??]
/* Define bitmap cache size for exFAT. Size should be minimum one sector size and maximum 4096. For applications using multiple media devices with varying sector size, the value should be set to the size of largest sector size.
The FX_EXFAT_MAX_CACHE_SIZE is 2 power of FX_EXFAT_MAX_CACHE_SIZE_NB_BIT.  */

[#if FX_EXFAT_MAX_CACHE_SIZE_value == "512"]
/*
#define FX_EXFAT_MAX_CACHE_SIZE            512
*/
[#else]
#define FX_EXFAT_MAX_CACHE_SIZE            ${FX_EXFAT_MAX_CACHE_SIZE_value}
[/#if]
[/#if]

[#if FX_FAULT_TOLERANT_CACHE_SIZE_value??]
/* Define the size of fault tolerant cache, which is used when freeing FAT chain.
	The FX_FAULT_TOLERANT_CACHE_SIZE is 2 power of FX_FAULT_TOLERANT_CACHE_SIZE_NB_SIZE.  */

[#if FX_FAULT_TOLERANT_CACHE_SIZE_value == "1024"]
/*
#define FX_FAULT_TOLERANT_CACHE_SIZE            1024
*/
[#else]
#define FX_FAULT_TOLERANT_CACHE_SIZE            ${FX_FAULT_TOLERANT_CACHE_SIZE_value}
[/#if]
[/#if]


/* USER CODE BEGIN 2 */

/* USER CODE END 2 */

#endif
