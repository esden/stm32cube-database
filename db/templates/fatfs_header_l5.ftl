[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file   app_fatfs.h
  * @brief  Header for fatfs applications
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __APP_FATFS_H
#define __APP_FATFS_H

[#compress]
/* Includes ------------------------------------------------------------------*/
#include "ff.h"
#include "ff_gen_drv.h"
[#list SWIPdatas as SWIP]
 [#if SWIP.defines??]
  [#list SWIP.defines as definition]
   [#if definition.name="_FS_FATFS_SDIO"]
    [#if definition.value="1"]  [#-- SD Card mode on --]
#include "sd_diskio.h" /* defines SD_Driver as external */
    [/#if]
   [/#if]
   [#if definition.name="_FS_FATFS_SRAM"]
    [#if definition.value="1"]  [#-- External SRAM mode on --]
#include "sram_diskio.h" /* defines SRAMDISK_Driver as external */
    [/#if]
   [/#if]
   [#if definition.name="DISKIO_CODE"]  [#-- User Defined mode on --]
#include "user_diskio.h" /* defines USER_Driver as external */
   [/#if]
  [/#list]
 [/#if]
[/#list]
[/#compress]

#n
/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */     

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
int32_t MX_FATFS_Init(void);
int32_t MX_FATFS_Process(void);
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN Private defines */
#define APP_OK                      0
#define APP_ERROR                  -1
#define APP_SD_UNPLUGGED           -2
/* USER CODE END Private defines */

[#-- [@common.optinclude name=mxTmpFolder+"/fatfs_ext_vars.tmp"/] --]
[#list SWIPdatas as SWIP]
 [#if SWIP.defines??]
  [#list SWIP.defines as definition]
   [#if definition.name="_FS_FATFS_SDIO"]
    [#if definition.value="1"]  [#-- SD Card mode on --]
extern FATFS SDFatFS;    /* File system object for SD logical drive */
extern FIL SDFile;       /* File object for SD */
extern char SDPath[4];   /* SD logical drive path */
    [/#if]
   [/#if]  
   [#if definition.name="_FS_FATFS_SRAM"]
    [#if definition.value="1"] [#-- External SRAM mode on --]
extern FATFS SRAMDISKFatFS;    /* File system object for SRAMDISK logical drive */
extern FIL SRAMDISKFile;       /* File object for SRAMDISK */
extern char SRAMDISKPath[4];   /* SRAMDISK logical drive path */
    [/#if]
   [/#if]
   [#if definition.name="DISKIO_CODE"] [#-- User Defined mode on --]
extern FATFS USERFatFs;    /* File system object for USER logical drive */
extern FIL USERFile;       /* File  object for USER */
extern char USERPath[4];   /* USER logical drive path */
   [/#if]
  [/#list]
 [/#if]
[/#list]

#endif /*__APP_FATFS_H */


