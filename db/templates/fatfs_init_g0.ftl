[#ftl]
[#-- Version only for G0 --]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file   app_fatfs.c
  * @brief  Code for fatfs applications
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign usbMode = "0"]
[#assign userMode = "0"]
[#assign diskioCode = "0"]
[#list SWIPdatas as SWIP]
 [#if SWIP.defines??]
  [#list SWIP.defines as definition]
   [#if definition.name="_FS_FATFS_USB"]
    [#if definition.value="1"]
      [#assign usbMode = "1"]
    [/#if]
   [/#if]
   [#if definition.name="_FS_FATFS_USER"]
    [#if definition.value="1"]
      [#assign userMode = "1"]
    [/#if]
   [/#if]
   [#if definition.name="DISKIO_CODE"]
     [#if definition.value="1"]
      [#assign diskioCode = "1"]
     [/#if]
   [/#if]
  [/#list]
 [/#if]
[/#list]
[#if diskioCode = "1"]
  [#assign userMode = "2"]
[/#if]

/* Includes ------------------------------------------------------------------*/
#include "app_fatfs.h"
#include "main.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */
typedef enum {
  APPLICATION_IDLE = 0,
  APPLICATION_INIT,
  APPLICATION_RUNNING,
  APPLICATION_SD_UNPLUGGED,
}FS_FileOperationsTypeDef;
/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
[#--[@common.optinclude name=mxTmpFolder+"/fatfs_vars.tmp"/] --]
[#--do not place these vars in user section, or it will stay there, even if the mode is changed (SD/USER) --]
[#if usbMode = "1"]
FATFS USBHFatFs;  /* File system object for USBH logical drive */
FIL USBHFile;     /* File  object for USBH */
char USBHPath[4]; /* USBH logical drive path */
[/#if]
[#if userMode = "1"]
FATFS USERFatFs;  /* File system object for USER logical drive */
FIL USERFile;     /* File  object for USER */
char USERPath[4]; /* USER logical drive path */
[/#if]
[#if userMode = "2"]
FATFS SDFatFs;    /* File system object for SD logical drive */
FIL SDFile;       /* File  object for SD */
char SDPath[4];   /* SD logical drive path */
[/#if]
/* USER CODE BEGIN PV */
[#--  Note: conflict with Appli_state also defined in usb_host.c --]
[#if usbMode = "1"]
FS_FileOperationsTypeDef AppliState = APPLICATION_IDLE;
[#else]
FS_FileOperationsTypeDef Appli_state = APPLICATION_IDLE;
[/#if]
/* USER CODE END PV */

[#list SWIPdatas as SWIP]  
 [#if SWIP.defines??]
  [#list SWIP.defines as definition]
   [#if definition.name="_MULTI_PARTITION"] 
    [#if definition.value="1"]
/* USER CODE BEGIN VolToPart */
/* Volume - Partition resolution table should be user defined in case of Multiple partition */
/* When multi-partition feature is enabled (1), each logical drive number is bound to arbitrary physical drive and partition
listed in the VolToPart[] */
PARTITION VolToPart[];
/* USER CODE END VolToPart */  
    [/#if] 
   [/#if]
  [/#list]
 [/#if]
[/#list]

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/**
  * @brief  FatFs initialization
  * @param  None
  * @retval Initialization result 
  */
int32_t MX_FATFS_Init(void) 
{
[#--[@common.optinclude name=mxTmpFolder+"/fatfs_HalInit.tmp"/] --]
  /*## FatFS: Link the disk I/O driver(s)  ###########################*/
[#if usbMode = "1" && userMode = "0"]
  if (FATFS_LinkDriver(&USBH_Driver, USBHPath) != 0)
[/#if]
[#if usbMode = "1" && userMode = "1"]
  if ((FATFS_LinkDriver(&USBH_Driver, USBHPath) != 0) && (FATFS_LinkDriver(&USER_Driver, USERPath) != 0))
[/#if]
[#if usbMode = "0" && userMode = "1"]
  if (FATFS_LinkDriver(&USER_Driver, USERPath) != 0)
[/#if]
[#-- that SD card mode cannot happen with USB mode at the same time (DISKIO param not enabled for G0Bx/G0Cx) --]
[#if userMode = "2"]
  if (FATFS_LinkDriver(&SD_Driver, SDPath) != 0)
[/#if]
  /* USER CODE BEGIN FATFS_Init */
  {
    return APP_ERROR;
  }
  else
  {
[#--  Note: conflict with Appli_state also defined in usb_host.c --]
[#if usbMode = "1"]
    AppliState = APPLICATION_INIT;
[#else]
    Appli_state = APPLICATION_INIT; // also defined in usb_host.c
[/#if]
    return APP_OK;
  }
  /* USER CODE END FATFS_Init */
}

/**
  * @brief  FatFs application main process
  * @param  None
  * @retval Process result 
  */
int32_t MX_FATFS_Process(void)
{
  /* USER CODE BEGIN FATFS_Process */
  int32_t process_res = APP_OK;  
    
  return process_res;
  /* USER CODE END FATFS_Process */
}  

[#list SWIPdatas as SWIP]  
 [#if SWIP.defines??]
  [#list SWIP.defines as definition]
   [#if definition.name="_FS_NORTC"]                           
    [#if definition.value="0"]
/**
  * @brief  Gets Time from RTC (generated when FS_NORTC==0; see ff.c)
  * @param  None
  * @retval Time in DWORD
  */
DWORD get_fattime(void)
{
#t/* USER CODE BEGIN get_fattime */
  return 0;
#t/* USER CODE END get_fattime */  
}
    [/#if] 
   [/#if]
  [/#list]
 [/#if]
[/#list]

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN Application */
     
/* USER CODE END Application */
