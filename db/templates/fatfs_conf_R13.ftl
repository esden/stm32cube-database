[#ftl]
[#assign s = name]
[#assign temp = s?replace(".","__")]
[#assign inclusion_protection = temp?upper_case]
/**
  ******************************************************************************
  *  FatFs - FAT file system module configuration file  R0.13 (C)ChaN, 2017
  ******************************************************************************
[@common.optinclude name=sourceDir+"Src/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

#ifndef FFCONF_DEF
#define FFCONF_DEF 87030	/* Revision ID */

/*-----------------------------------------------------------------------------/
/ Additional user header to be used  
/-----------------------------------------------------------------------------*/
[#assign usbhInUse = 0]
#include "${FamilyName?lower_case}xx_hal.h"
[#list SWIPdatas as SWIP]  
[#if SWIP.defines??]
[#list SWIP.defines as definition]
[#if definition.name="_FS_FATFS_SDIO"]
[#if definition.value="1"]
#include "bsp_driver_sd.h"
[/#if]
[/#if]
[#if definition.name="_FS_FATFS_SDRAM"]
[#if definition.value="1"]
#include "bsp_driver_sdram.h"
[/#if]
[/#if]
[#if definition.name="_FS_FATFS_SRAM"]
[#if definition.value="1"]
#include "bsp_driver_sram.h"
[/#if]
[/#if]
[#if definition.name="_FS_FATFS_USB"]
[#if definition.value="1"]
#include "usbh_core.h"
#include "usbh_msc.h"
[#assign usbhInUse = 1]
[/#if]
[/#if]
[#if definition.name="_FS_REENTRANT"]
[#if definition.value="1"]
#include "cmsis_os.h"    /* FF_FS_REENTRANT set to 1 */
[/#if] 
[/#if]
[/#list]
[/#if]

[#if includes??]
[#list includes as include]
#include "${include}"
[/#list]
[/#if]

[#-- Global variables --]
[#if SWIP.variables??]
	[#list SWIP.variables as variable]
	   [#if variable.name != "HALCompliant"]
extern ${variable.value} ${variable.name};
       [/#if]
	[/#list]
[/#if]

[#-- Global variables --]
[#if SWIP.defines??]
    [#list SWIP.defines as definition]
      [#if definition.name="_HUSBH"]
        [#if usbhInUse == 1]
/* Handle for USB Host */
#define hUSB_Host ${definition.value}
        [/#if]
      [/#if] 
      [#if definition.name=="_FS_TINY"]
          [#assign valueTiny = definition.value]
      [/#if]
      [#if definition.name=="_FS_READONLY"]
          [#assign valueReadonly = definition.value]
      [/#if]
      [#if definition.name=="_FS_MINIMIZE"]
          [#assign valueMinimize = definition.value]
      [/#if]
      [#if definition.name=="_USE_STRFUNC"]
          [#assign valueUseStrfunc = definition.value]
      [/#if]
      [#if definition.name=="_USE_FIND"]                   [#-- New in R0.11 --]
          [#assign valueUseFind = definition.value]
      [/#if]
      [#if definition.name=="_USE_MKFS"]
          [#assign valueUseMkfs = definition.value]
      [/#if]
      [#if definition.name=="_USE_FASTSEEK"]
          [#assign valueUseFastseek = definition.value]
      [/#if]
      [#if definition.name=="_USE_LABEL"]
          [#assign valueUseLabel = definition.value]
      [/#if]
      [#if definition.name=="_USE_FORWARD"]
          [#assign valueUseForward = definition.value]
      [/#if]
      [#if definition.name=="_CODE_PAGE"]
          [#assign valueCodePage = definition.value]
      [/#if]
      [#if definition.name=="_USE_LFN"]
          [#assign valueUseLfn = definition.value]
      [/#if]
      [#if definition.name=="_MAX_LFN"]
          [#assign valueMaxLfn = definition.value]
      [/#if]
      [#if definition.name=="_LFN_UNICODE"]
          [#assign valueLfnUnicode = definition.value]
      [/#if]
      [#if definition.name=="_STRF_ENCODE"]
          [#assign valueStrfEncode = definition.value]
      [/#if]
      [#if definition.name=="_FS_RPATH"]
          [#assign valueRpath = definition.value]
      [/#if]
      [#if definition.name=="_VOLUMES"]
          [#assign valueVolumes = definition.value]
      [/#if]
      [#if definition.name=="_MULTI_PARTITION"]
          [#assign valueMultiPartition = definition.value]
      [/#if]
      [#if definition.name=="_MAX_SS"]
          [#assign valueMaxSectorSize = definition.value]
      [/#if]
      [#if definition.name=="_MIN_SS"]
          [#assign valueMinSectorSize = definition.value]
      [/#if]
      [#if definition.name=="_USE_TRIM"]          [#-- Renamed in R0.11 --]
          [#assign valueUseTrim = definition.value]
      [/#if]
      [#if definition.name=="_FS_NOFSINFO"]
          [#assign valueNoFsinfo = definition.value]
      [/#if]
      [#if definition.name=="_FS_NORTC"]           [#-- New in R0.11 --]
          [#assign valueNoRtc = definition.value]
      [/#if]
      [#if definition.name=="_NORTC_YEAR"]         [#-- New in R0.11 --]
          [#assign valueNoRtcYear = definition.value]
      [/#if]
      [#if definition.name=="_NORTC_MON"]          [#-- New in R0.11 --]
          [#assign valueNoRtcMonth = definition.value]
      [/#if]
      [#if definition.name=="_NORTC_MDAY"]         [#-- New in R0.11 --]
          [#assign valueNoRtcDay = definition.value]
      [/#if]
      [#if definition.name=="_FS_REENTRANT"]
          [#assign valueReentrant = definition.value]
      [/#if]
      [#if definition.name=="_FS_TIMEOUT"]
          [#assign valueTimeout = definition.value]
      [/#if]
      [#if definition.name=="_SYNC_t"]
          [#assign valueSynct = definition.value]
      [/#if]
      [#if definition.name=="_FS_LOCK"]
          [#assign valueLock = definition.value]
      [/#if]
      [#if definition.name=="_USE_EXPAND"]       [#-- New in R0.12 --]
          [#assign valueUseExpand = definition.value]
      [/#if]
      [#if definition.name=="_USE_CHMOD"]        [#-- New in R0.12 --]
          [#assign valueUseChmod = definition.value]
      [/#if]
      [#if definition.name=="_FS_EXFAT"]         [#-- New in R0.12 --]
          [#assign valueExFat = definition.value]
      [/#if]
    [/#list]
[/#if]

[/#list]

/*-----------------------------------------------------------------------------/
/ Function Configurations
/-----------------------------------------------------------------------------*/

#define FF_FS_READONLY       ${valueReadonly}      /* 0:Read/Write or 1:Read only */
/* This option switches read-only configuration. (0:Read/Write or 1:Read-only)
/  Read-only configuration removes writing API functions, f_write(), f_sync(),
/  f_unlink(), f_mkdir(), f_chmod(), f_rename(), f_truncate(), f_getfree()
/  and optional writing functions as well. */

#define FF_FS_MINIMIZE       ${valueMinimize}      /* 0 to 3 */
/* This option defines minimization level to remove some basic API functions.
/
/   0: All basic functions are enabled.
/   1: f_stat(), f_getfree(), f_unlink(), f_mkdir(), f_truncate() and f_rename()
/      are removed.
/   2: f_opendir(), f_readdir() and f_closedir() are removed in addition to 1.
/   3: f_lseek() function is removed in addition to 2. */

#define FF_USE_STRFUNC       ${valueUseStrfunc}      /* 0:Disable or 1-2:Enable */
/* This option switches string functions, f_gets(), f_putc(), f_puts() and f_printf().
/
/  0: Disable string functions.
/  1: Enable without LF-CRLF conversion.
/  2: Enable with LF-CRLF conversion. */

#define FF_USE_FIND          ${valueUseFind}
/* This option switches filtered directory read functions, f_findfirst() and
/  f_findnext(). (0:Disable, 1:Enable 2:Enable with matching altname[] too) */

#define FF_USE_MKFS          ${valueUseMkfs}
/* This option switches f_mkfs() function. (0:Disable or 1:Enable) */

#define FF_USE_FASTSEEK      ${valueUseFastseek}
/* This option switches fast seek feature. (0:Disable or 1:Enable) */

#define	FF_USE_EXPAND		${valueUseExpand}
/* This option switches f_expand function. (0:Disable or 1:Enable) */

#define FF_USE_CHMOD		${valueUseChmod}
/* This option switches attribute manipulation functions, f_chmod() and f_utime().
/  (0:Disable or 1:Enable) Also FF_FS_READONLY needs to be 0 to enable this option. */

#define FF_USE_LABEL           ${valueUseLabel}
/* This option switches volume label functions, f_getlabel() and f_setlabel().
/  (0:Disable or 1:Enable) */

#define FF_USE_FORWARD         ${valueUseForward}
/* This option switches f_forward() function. (0:Disable or 1:Enable) */

/*-----------------------------------------------------------------------------/
/ Locale and Namespace Configurations
/-----------------------------------------------------------------------------*/

#define FF_CODE_PAGE         ${valueCodePage}
/* This option specifies the OEM code page to be used on the target system.
/  Incorrect code page setting can cause a file open failure.
/
/   437 - U.S.
/   720 - Arabic
/   737 - Greek
/   771 - KBL
/   775 - Baltic
/   850 - Latin 1
/   852 - Latin 2
/   855 - Cyrillic
/   857 - Turkish
/   860 - Portuguese
/   861 - Icelandic
/   862 - Hebrew
/   863 - Canadian French
/   864 - Arabic
/   865 - Nordic
/   866 - Russian
/   869 - Greek 2
/   932 - Japanese (DBCS)
/   936 - Simplified Chinese (DBCS)
/   949 - Korean (DBCS)
/   950 - Traditional Chinese (DBCS)
/     0 - Include all code pages above and configured by f_setcp()
*/

#define FF_USE_LFN     ${valueUseLfn}    /* 0 to 3 */
#define FF_MAX_LFN     ${valueMaxLfn}  /* Maximum LFN length to handle (12 to 255) */
/* The FF_USE_LFN switches the support of long file name (LFN).
/
/   0: Disable LFN. FF_MAX_LFN has no effect.
/   1: Enable LFN with static working buffer on the BSS. Always NOT thread-safe.
/   2: Enable LFN with dynamic working buffer on the STACK.
/   3: Enable LFN with dynamic working buffer on the HEAP
/
/  To enable the LFN, Unicode handling functions (option/unicode.c) must be added
/  to the project. The working buffer occupies (FF_MAX_LFN + 1) * 2 bytes and
/  additional 608 bytes at exFAT enabled. FF_MAX_LFN can be in range from 12 to 255.
/  It should be set 255 to support full featured LFN operations.
/  When use stack for the working buffer, take care on stack overflow. When use heap
/  memory for the working buffer, memory management functions, ff_memalloc() and
/  ff_memfree(), must be added to the project. */

#define FF_LFN_UNICODE    ${valueLfnUnicode} /* 0:ANSI/OEM or 1:Unicode */
/* This option switches character encoding on the API, 0:ANSI/OEM or 1:UTF-16,
/  when LFN is enabled. Also behavior of string I/O functions will be affected by
/  this option. When LFN is not enabled, this option has no effect.
*/

#define FF_STRF_ENCODE    ${valueStrfEncode}
/* When FF_LFN_UNICODE = 1 with LFN enabled, string I/O functions, f_gets(),
/  f_putc(), f_puts and f_printf() convert the character encoding in it.
/  This option selects assumption of character encoding ON THE FILE to be
/  read/written via those functions.
/
/   0: ANSI/OEM
/   1: UTF-16LE
/   2: UTF-16BE
/   3: UTF-8
*/

#define FF_FS_RPATH       ${valueRpath} /* 0 to 2 */
/* This option configures support for relative path.
/
/   0: Disable relative path and remove related functions.
/   1: Enable relative path. f_chdir() and f_chdrive() are available.
/   2: f_getcwd() function is available in addition to 1.
*/


/*---------------------------------------------------------------------------/
/ Drive/Volume Configurations
/----------------------------------------------------------------------------*/

#define FF_VOLUMES    ${valueVolumes}
/* Number of volumes (logical drives) to be used. (1-10) */

/* USER CODE BEGIN Volumes */  
#define FF_STR_VOLUME_ID          0	/* 0:Use only 0-9 for drive ID, 1:Use strings for drive ID */
#define FF_VOLUME_STRS            "RAM","NAND","CF","SD1","SD2","USB1","USB2","USB3"
/* FF_STR_VOLUME_ID switches string support of volume ID.
/  When FF_STR_VOLUME_ID is set to 1, also pre-defined strings can be used as drive
/  number in the path name. FF_VOLUME_STRS defines the drive ID strings for each
/  logical drives. Number of items must be equal to _VOLUMES. Valid characters for
/  the drive ID strings are: A-Z and 0-9. */
/* USER CODE END Volumes */  

#define FF_MULTI_PARTITION     ${valueMultiPartition} /* 0:Single partition, 1:Multiple partition */
/* This option switches support for multiple volumes on the physical drive.
/  By default (0), each logical drive number is bound to the same physical drive
/  number and only an FAT volume found on the physical drive will be mounted.
/  When this function is enabled (1), each logical drive number can be bound to
/  arbitrary physical drive and partition listed in the VolToPart[]. Also f_fdisk()
/  funciton will be available. */

#define FF_MIN_SS    ${valueMinSectorSize}  /* 512, 1024, 2048 or 4096 */
#define FF_MAX_SS    ${valueMaxSectorSize}  /* 512, 1024, 2048 or 4096 */
/* This set of options configures the range of sector size to be supported. (512,
/  1024, 2048 or 4096) Always set both 512 for most systems, generic memory card and
/  harddisk. But a larger value may be required for on-board flash memory and some
/  type of optical media. When FF_MAX_SS is larger than FF_MIN_SS, FatFs is configured
/  for variable sector size mode and disk_ioctl() function needs to implement
/  GET_SECTOR_SIZE command. */

#define	FF_USE_TRIM      ${valueUseTrim}
/* This option switches support for ATA-TRIM. (0:Disable or 1:Enable)
/  To enable Trim function, also CTRL_TRIM command should be implemented to the
/  disk_ioctl() function. */

#define FF_FS_NOFSINFO    ${valueNoFsinfo} /* 0,1,2 or 3 */
/* If you need to know correct free space on the FAT32 volume, set bit 0 of this
/  option, and f_getfree() function at first time after volume mount will force
/  a full FAT scan. Bit 1 controls the use of last allocated cluster number.
/
/  bit0=0: Use free cluster count in the FSINFO if available.
/  bit0=1: Do not trust free cluster count in the FSINFO.
/  bit1=0: Use last allocated cluster number in the FSINFO if available.
/  bit1=1: Do not trust last allocated cluster number in the FSINFO.
*/

/*---------------------------------------------------------------------------/
/ System Configurations
/----------------------------------------------------------------------------*/

#define FF_FS_TINY    ${valueTiny}      /* 0:Normal or 1:Tiny */
/* This option switches tiny buffer configuration. (0:Normal or 1:Tiny)
/  At the tiny configuration, size of file object (FIL) is reduced FF_MAX_SS bytes.
/  Instead of private sector buffer eliminated from the file object, common sector
/  buffer in the file system object (FATFS) is used for the file data transfer. */

#define FF_FS_EXFAT	${valueExFat}
/* This option switches support of exFAT file system. (0:Disable or 1:Enable)
/  When enable exFAT, also LFN needs to be enabled. (_USE_LFN >= 1)
/  Note that enabling exFAT discards C89 compatibility. */

#define FF_FS_NORTC	${valueNoRtc}
#define FF_NORTC_MON	${valueNoRtcMonth}     /* default value: 5 in R13 */
#define FF_NORTC_MDAY	${valueNoRtcDay}
#define FF_NORTC_YEAR	${valueNoRtcYear}      /* default value: 2017 in R13 */
/* The option FF_FS_NORTC switches timestamp functiton. If the system does not have
/  any RTC function or valid timestamp is not needed, set FF_FS_NORTC = 1 to disable
/  the timestamp function. All objects modified by FatFs will have a fixed timestamp
/  defined by FF_NORTC_MON, FF_NORTC_MDAY and FF_NORTC_YEAR in local time.
/  To enable timestamp function (FF_FS_NORTC = 0), get_fattime() function need to be
/  added to the project to read current time form real-time clock. FF_NORTC_MON,
/  FF_NORTC_MDAY and FF_NORTC_YEAR have no effect.
/  These options have no effect at read-only configuration (FF_FS_READONLY = 1). */

#define FF_FS_LOCK    ${valueLock}     /* 0:Disable or >=1:Enable */
/* The option FF_FS_LOCK switches file lock function to control duplicated file open
/  and illegal operation to open objects. This option must be 0 when _FS_READONLY
/  is 1.
/
/  0:  Disable file lock function. To avoid volume corruption, application program
/      should avoid illegal open, remove and rename to the open objects.
/  >0: Enable file lock function. The value defines how many files/sub-directories
/      can be opened simultaneously under file lock control. Note that the file
/      lock control is independent of re-entrancy. */

#define FF_FS_REENTRANT    ${valueReentrant}  /* 0:Disable or 1:Enable */
#define FF_FS_TIMEOUT      ${valueTimeout} /* Timeout period in unit of time ticks */
#define FF_SYNC_t          ${valueSynct} 
/* The option FF_FS_REENTRANT switches the re-entrancy (thread safe) of the FatFs
/  module itself. Note that regardless of this option, file access to different
/  volume is always re-entrant and volume control functions, f_mount(), f_mkfs()
/  and f_fdisk() function, are always not re-entrant. Only file/directory access
/  to the same volume is under control of this function.
/
/   0: Disable re-entrancy. FF_FS_TIMEOUT and FF_SYNC_t have no effect.
/   1: Enable re-entrancy. Also user provided synchronization handlers,
/      ff_req_grant(), ff_rel_grant(), ff_del_syncobj() and ff_cre_syncobj()
/      function, must be added to the project. Samples are available in
/      option/syscall.c.
/
/  The FF_FS_TIMEOUT defines timeout period in unit of time tick.
/  The FF_SYNC_t defines O/S dependent sync object type. e.g. HANDLE, ID, OS_EVENT*,
/  SemaphoreHandle_t and etc.. A header file for O/S definitions needs to be
/  included somewhere in the scope of ff.h. */

/* define the ff_malloc ff_free macros as standard malloc free */
#if !defined(ff_malloc) && !defined(ff_free)
#include <stdlib.h>
#define ff_malloc  malloc
#define ff_free  free
#endif

#endif /* _FFCONF */
