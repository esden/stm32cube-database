[#ftl]
[#assign use_dma=0]
[#if SWIPdatas??]
[#list SWIPdatas as SWIP]  
[#if SWIP.defines??]
 [#list SWIP.defines as definition] 
  [#if definition.name="USE_DMA_CODE_USBH"]
   [#if definition.value="1"]
    [#assign use_dma=1]
   [/#if]
  [/#if]
 [/#list]
[/#if]
[/#list]
[/#if]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
[#if use_dma = 1]
  * @file    usbh_diskio.h (based on usbh_diskio_dma_template.h v2.0.2)
[#else]
  * @file    usbh_diskio.h (based on usbh_diskio_template.h v2.0.2)
[/#if]
  * @brief   Header for usbh_diskio.c module
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __USBH_DISKIO_H
#define __USBH_DISKIO_H

/* USER CODE BEGIN firstSection */ 
/* can be used to modify / undefine following code or add new definitions */
/* USER CODE END firstSection */

/* Includes ------------------------------------------------------------------*/
#include "usbh_core.h"
#include "usbh_msc.h"
/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */
extern const Diskio_drvTypeDef  USBH_Driver;

/* USER CODE BEGIN lastSection */ 
/* can be used to modify / undefine previous code or add new definitions */
/* USER CODE END lastSection */

#endif /* __USBH_DISKIO_H */

