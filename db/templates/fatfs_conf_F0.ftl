
[#ftl]
[#assign s = name]
[#assign temp = s?replace(".","__")]
[#assign inclusion_protection = temp?upper_case]
/*---------------------------------------------------------------------------/
/  FatFs - FAT file system module configuration file  R0.10  (C)ChaN, 2013
/----------------------------------------------------------------------------/
/
/ CAUTION! Do not forget to make clean the project after any changes to
/ the configuration options.
/
/----------------------------------------------------------------------------*/
#ifndef _FFCONF
#define _FFCONF 80960	/* Revision ID */

/*-----------------------------------------------------------------------------/
/ Additional user header to be used  
/-----------------------------------------------------------------------------*/

#include "stm32f0xx_hal.h"
[#list SWIPdatas as SWIP]  
[#if SWIP.defines??]
[#list SWIP.defines as definition] 
[#if definition.name="_FS_REENTRANT"]                           
[#if definition.value="1"]
#include "cmsis_os.h"    /* _FS_REENTRANT set to 1 */                
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
extern ${variable.value} ${variable.name};
	[/#list]
[/#if]

[#-- Global variables --]
[#if SWIP.defines??]
	[#list SWIP.defines as definition]	
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
      [#if definition.name=="_USE_ERASE"]
	      [#assign valueUseErase = definition.value]
	  [/#if]	  	  
      [#if definition.name=="_FS_NOFSINFO"]
	      [#assign valueNoFsinfo = definition.value]
	  [/#if]		  	  
      [#if definition.name=="_WORD_ACCESS"]
	      [#assign valueWordAccess = definition.value]
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
	[/#list]
[/#if]

[/#list]

/*-----------------------------------------------------------------------------/
/ Functions and Buffer Configurations
/-----------------------------------------------------------------------------*/

#define _FS_TINY             ${valueTiny}      /* 0:Normal or 1:Tiny */
/* When _FS_TINY is set to 1, FatFs uses the sector buffer in the file system
/  object instead of the sector buffer in the individual file object for file
/  data transfer. This reduces memory consumption 512 bytes each file object. */


#define _FS_READONLY         ${valueReadonly}      /* 0:Read/Write or 1:Read only */
/* Setting _FS_READONLY to 1 defines read only configuration. This removes
/  writing functions, f_write, f_sync, f_unlink, f_mkdir, f_chmod, f_rename,
/  f_truncate and useless f_getfree. */


#define _FS_MINIMIZE         ${valueMinimize}      /* 0 to 3 */
/* The _FS_MINIMIZE option defines minimization level to remove some functions.
/
/   0: Full function.
/   1: f_stat, f_getfree, f_unlink, f_mkdir, f_chmod, f_truncate, f_utime 
/      and f_rename are removed.
/   2: f_opendir and f_readdir are removed in addition to 1.
/   3: f_lseek is removed in addition to 2. */


#define _USE_STRFUNC         ${valueUseStrfunc}      /* 0:Disable or 1-2:Enable */
/* To enable string functions, set _USE_STRFUNC to 1 or 2. */


#define _USE_MKFS            ${valueUseMkfs}      /* 0:Disable or 1:Enable */
/* To enable f_mkfs function, set _USE_MKFS to 1 and set _FS_READONLY to 0 */


#define _USE_FASTSEEK        ${valueUseFastseek}      /* 0:Disable or 1:Enable */
/* To enable fast seek feature, set _USE_FASTSEEK to 1. */


#define _USE_LABEL           ${valueUseLabel}      /* 0:Disable or 1:Enable */
/* To enable volume label functions, set _USE_LABEL to 1 */


#define _USE_FORWARD         ${valueUseForward}      /* 0:Disable or 1:Enable */
/* To enable f_forward function, set _USE_FORWARD to 1 and set _FS_TINY to 1. */


/*-----------------------------------------------------------------------------/
/ Locale and Namespace Configurations
/-----------------------------------------------------------------------------*/

#define _CODE_PAGE         ${valueCodePage}
/* The _CODE_PAGE specifies the OEM code page to be used on the target system.
/  Incorrect setting of the code page can cause a file open failure.
/
/   932  - Japanese Shift-JIS (DBCS, OEM, Windows)
/   936  - Simplified Chinese GBK (DBCS, OEM, Windows)
/   949  - Korean (DBCS, OEM, Windows)
/   950  - Traditional Chinese Big5 (DBCS, OEM, Windows)
/   1250 - Central Europe (Windows)
/   1251 - Cyrillic (Windows)
/   1252 - Latin 1 (Windows)
/   1253 - Greek (Windows)
/   1254 - Turkish (Windows)
/   1255 - Hebrew (Windows)
/   1256 - Arabic (Windows)
/   1257 - Baltic (Windows)
/   1258 - Vietnam (OEM, Windows)
/   437  - U.S. (OEM)
/   720  - Arabic (OEM)
/   737  - Greek (OEM)
/   775  - Baltic (OEM)
/   850  - Multilingual Latin 1 (OEM)
/   858  - Multilingual Latin 1 + Euro (OEM)
/   852  - Latin 2 (OEM)
/   855  - Cyrillic (OEM)
/   866  - Russian (OEM)
/   857  - Turkish (OEM)
/   862  - Hebrew (OEM)
/   874  - Thai (OEM, Windows)
/     1  - ASCII only (Valid for non LFN cfg.)
*/


#define _USE_LFN     ${valueUseLfn}    /* 0 to 3 */
#define _MAX_LFN     ${valueMaxLfn}  /* Maximum LFN length to handle (12 to 255) */
/* The _USE_LFN option switches the LFN feature.
/
/   0: Disable LFN feature. _MAX_LFN has no effect.
/   1: Enable LFN with static working buffer on the BSS. Always NOT reentrant.
/   2: Enable LFN with dynamic working buffer on the STACK.
/   3: Enable LFN with dynamic working buffer on the HEAP.
/
/  To enable LFN feature, Unicode handling functions ff_convert() and 
/  ff_wtoupper() function must be added to the project.
/  The LFN working buffer occupies (_MAX_LFN + 1) * 2 bytes. When use stack for 
/  the working buffer, take care on stack overflow. When use heap memory for the
/  working buffer, memory management functions, ff_memalloc() and ff_memfree(), 
/  must be added to the project. */


#define _LFN_UNICODE    ${valueLfnUnicode} /* 0:ANSI/OEM or 1:Unicode */
/* To switch the character encoding on the FatFs API to Unicode, enable LFN 
/  feature and set _LFN_UNICODE to 1. */


#define _STRF_ENCODE    ${valueStrfEncode} /* 0:ANSI/OEM, 1:UTF-16LE, 2:UTF-16BE, 3:UTF-8 */
/* When Unicode API is enabled, character encoding on the all FatFs API is 
/  switched to Unicode. This option selects the character encoding on the 
/  file to be read/written via string functions, f_gets(), f_putc(), f_puts 
/  and f_printf().
/  This option has no effect when _LFN_UNICODE is 0. */


#define _FS_RPATH       ${valueRpath} /* 0 to 2 */
/* The _FS_RPATH option configures relative path feature.
/
/   0: Disable relative path feature and remove related functions.
/   1: Enable relative path. f_chdrive() and f_chdir() function are available.
/   2: f_getcwd() function is available in addition to 1.
/
/  Note that output of the f_readdir() function is affected by this option. */


/*---------------------------------------------------------------------------/
/ Drive/Volume Configurations
/----------------------------------------------------------------------------*/

#define _VOLUMES    ${valueVolumes}
/* Number of volumes (logical drives) to be used. */


#define _MULTI_PARTITION     ${valueMultiPartition} /* 0:Single partition, 1:Multiple partition */
/* When set to 0, each volume is bound to the same physical drive number and
/ it can mount only first primaly partition. When it is set to 1, each volume
/ is tied to the partitions listed in VolToPart[]. */


#define _MAX_SS    ${valueMaxSectorSize}  /* 512, 1024, 2048 or 4096 */
/* Maximum sector size to be handled.
/  Always set 512 for memory card and hard disk but a larger value may be
/  required for on-board flash memory, floppy disk and optical disk.
/  When _MAX_SS is larger than 512, it configures FatFs to variable sector size
/  and GET_SECTOR_SIZE command must be implemented to the disk_ioctl() function.
*/


#define _USE_ERASE     ${valueUseErase} /* 0:Disable or 1:Enable */
/* To enable sector erase feature, set _USE_ERASE to 1. Also CTRL_ERASE_SECTOR 
/  command should be added to the disk_ioctl() function. */


#define _FS_NOFSINFO    ${valueNoFsinfo} /* 0 or 1 */
/* If you need to know the correct free space on the FAT32 volume, set this
/  option to 1 and f_getfree() function at first time after volume mount will
/  force a full FAT scan.
/
/  0: Load all informations in the FSINFO if available.
/  1: Do not trust free cluster count in the FSINFO.
*/


/*---------------------------------------------------------------------------/
/ System Configurations
/----------------------------------------------------------------------------*/

#define _WORD_ACCESS    ${valueWordAccess} /* 0 or 1 */
/* The _WORD_ACCESS option is an only platform dependent option. It defines
/  which access method is used to the word data on the FAT volume.
/
/   0: Byte-by-byte access. Always compatible with all platforms.
/   1: Word access. Do not choose this unless under both the following 
/   conditions.
/     * Byte order on the memory is little-endian.
/     * Address miss-aligned word access is always allowed for all instructions.
/
/  If it is the case, _WORD_ACCESS can also be set to 1 to improve performance
/  and reduce code size.
*/


/* A header file that defines sync object types on the O/S, such as
/  windows.h, ucos_ii.h and semphr.h, must be included prior to ff.h. */

#define _FS_REENTRANT    ${valueReentrant}  /* 0:Disable or 1:Enable */
#define _FS_TIMEOUT      ${valueTimeout} /* Timeout period in unit of time ticks */
#define _SYNC_t          ${valueSynct} 
/* O/S dependent type of sync object. e.g. HANDLE, OS_EVENT*, ID and etc.. */

/* The _FS_REENTRANT option switches the re-entrancy (thread safe) of the FatFs 
/  module.
/   0: Disable re-entrancy. _SYNC_t and _FS_TIMEOUT have no effect.
/   1: Enable re-entrancy. Also user provided synchronization handlers,
/      ff_req_grant(), ff_rel_grant(), ff_del_syncobj() and ff_cre_syncobj()
/      function must be added to the project. */


#define _FS_LOCK    ${valueLock}     /* 0:Disable or >=1:Enable */
/* To enable file lock control feature, set _FS_LOCK to 1 or greater.
   The value defines how many files can be opened simultaneously. */


#endif /* _FFCONFIG */

