[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    sram_diskio.h (based on sram_diskio_template.h v2.0.2)
  * @brief   Header for sram_diskio.c module
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */ 
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __SRAM_DISKIO_H
#define __SRAM_DISKIO_H

/* USER CODE BEGIN firstSection */ 
/* can be used to modify / undefine following code or add new definitions */
/* USER CODE END firstSection */ 

/* Includes ------------------------------------------------------------------*/
#include "bsp_driver_sram.h"
/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */
extern const Diskio_drvTypeDef  SRAMDISK_Driver;

/* USER CODE BEGIN lastSection */ 
/* can be used to modify / undefine previous code or add new definitions */
/* USER CODE END lastSection */

#endif /* __SRAM_DISKIO_H */
