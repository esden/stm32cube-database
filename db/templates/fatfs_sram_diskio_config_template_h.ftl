[#ftl]
/**
  ******************************************************************************
  * @file    sram_diskio_config.h
  * @author  MCD Application Team
  * @brief   Template for the sram_diskio_config.h. This file should be copied and
             under project.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

[#assign BLOCK_SIZE="512"]
[#assign SRAM_DISK_BASE_ADDR="0x24000000"]
[#assign SRAM_DISK_SIZE=32768]

[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
      [#if (definition.name == "BLOCK_SIZE")]
        [#assign BLOCK_SIZE = definition.value]
      [/#if]
      [#if (definition.name == "SRAM_DISK_BASE_ADDR")]
        [#assign SRAM_DISK_BASE_ADDR = definition.value]
      [/#if]
      [#if (definition.name == "SRAM_DISK_SIZE")]
        [#assign SRAM_DISK_SIZE = definition.value]
      [/#if]
    [/#list]
  [/#if]
[/#list]

[#assign familyName=FamilyName?lower_case]

#include "${familyName}xx_hal.h"

#ifndef SRAM_DISKIO_CONFIG_H
#define SRAM_DISKIO_CONFIG_H


#ifdef __cplusplus
extern "C" {
#endif
/* Includes ------------------------------------------------------------------*/

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Block size */
#define BLOCK_SIZE                ${BLOCK_SIZE}

/* Base Address */
#define SRAM_DISK_BASE_ADDR       ${SRAM_DISK_BASE_ADDR}

/* SRAM Disk size in bytes */
#define SRAM_DISK_SIZE            ${SRAM_DISK_SIZE}


#ifdef __cplusplus
}
#endif

#endif /* SRAM_DISKIO_CONFIG_H */