[#ftl]
[#assign use_dma=0]
[#assign use_rtos=0]
[#if SWIPdatas??]
[#list SWIPdatas as SWIP]  
[#if SWIP.defines??]
 [#list SWIP.defines as definition] 
  [#if definition.name="USE_DMA_CODE_SD"]
   [#if definition.value="1"]
    [#assign use_dma=1]
   [/#if]
  [/#if]
  [#if definition.name="_FS_REENTRANT"]
   [#if definition.value="1"]
    [#assign use_rtos=1]
   [/#if]
  [/#if]
 [/#list]
[/#if]
[/#list]
[/#if]
/**
  ******************************************************************************
[#if use_dma = 1]
 [#if use_rtos = 1]
  * @file    sd_diskio.h (based on sd_diskio_dma_rtos_template.h v2.0.2)
 [#else]
  * @file    sd_diskio.h (based on sd_diskio_dma_template.h v2.0.2)
 [/#if]
[#else]
  * @file    sd_diskio.h (based on sd_diskio_template.h v2.0.2)
[/#if]
  * @brief   Header for sd_diskio.c module
  ******************************************************************************
[@common.optinclude name=sourceDir+"Src/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __SD_DISKIO_H
#define __SD_DISKIO_H

/* USER CODE BEGIN firstSection */ 
/* can be used to modify / undefine following code or add new definitions */
/* USER CODE END firstSection */

/* Includes ------------------------------------------------------------------*/
#include "bsp_driver_sd.h"
/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */
extern const Diskio_drvTypeDef  SD_Driver;

/* USER CODE BEGIN lastSection */ 
/* can be used to modify / undefine previous code or add new definitions */
/* USER CODE END lastSection */

#endif /* __SD_DISKIO_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

