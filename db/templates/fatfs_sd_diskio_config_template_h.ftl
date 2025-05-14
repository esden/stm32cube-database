[#ftl]
/**
  ******************************************************************************
  * @file    sd_diskio_config.h
  * @brief   Template for the sd_diskio_config.h. This file should be copied and
             under project.
  ******************************************************************************
  [#if FamilyName=="STM32H7RS"]
* @attention
  *
  * Copyright (c) 2024 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
[#else]
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
[/#if]
  ******************************************************************************
  */

[#assign SD_TIMEOUT=""]
[#assign ENABLE_SD_INIT="0"]
[#assign ENABLE_SD_DMA_CACHE_MAINTENANCE="0"]

[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
      [#if (definition.name == "SD_TIMEOUT")]
        [#assign SD_TIMEOUT = definition.value]
      [/#if]
      [#if (definition.name == "ENABLE_SD_INIT")]
        [#assign ENABLE_SD_INIT = definition.value]
      [/#if]
      [#if (definition.name == "ENABLE_SD_DMA_CACHE_MAINTENANCE")]
        [#assign ENABLE_SD_DMA_CACHE_MAINTENANCE = definition.value]
      [/#if]
    [/#list]
  [/#if]
[/#list]

[#assign familyName=FamilyName?lower_case]
[#if FamilyName=="STM32H7RS"]
#ifndef __SD_DISKIO_CONFIG_H
#define __SD_DISKIO_CONFIG_H
[#else]
#ifndef SD_DISKIO_CONFIG_H
#define SD_DISKIO_CONFIG_H
[/#if]


#ifdef __cplusplus
extern "C" {
#endif
/* Includes ------------------------------------------------------------------*/

#include "${familyName}xx_hal.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/

/* Maximum waiting time to do an operation in the HAL_SD_ReadBlocks() and HAL_SD_WriteBlocks() */
#define SD_TIMEOUT    ${SD_TIMEOUT}

/*
 * Depending on the usecase, the SD card initialization could be done at the
 * application level, if it is the case define the flag below to enable
 * the MX_SD_Init().
 */
#define ENABLE_SD_INIT ${ENABLE_SD_INIT}

/*
 * when using cacheable memory region, it may be needed to maintain the cache
 * validity. Enable the define below to activate a cache maintenance at each
 * read and write operation.
 * Notice: This is applicable only for cortex M7 based platform.
 */

#define ENABLE_SD_DMA_CACHE_MAINTENANCE  ${ENABLE_SD_DMA_CACHE_MAINTENANCE}


extern SD_HandleTypeDef hsd1;

/* Default handle used in sd_diskio.c file */
#define sdmmc_handle hsd1

/* Default Init function of sdmmc IP used in sd_diskio.c file */
#if (ENABLE_SD_INIT == 1)
extern void MX_SDMMC1_SD_Init(void);
#define sdmmc_sd_init MX_SDMMC1_SD_Init
#endif

#ifdef __cplusplus
}
#endif

[#if FamilyName=="STM32H7RS"]
#endif /* __SD_DISKIO_CONFIG_H */
[#else]
#endif /* SD_DISKIO_CONFIG_H */
[/#if]