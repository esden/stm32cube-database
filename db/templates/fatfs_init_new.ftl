[#ftl]
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
[@common.optinclude name=mxTmpFolder+"/fatfs_vars.tmp"/][#--do not place these vars in user section, or it will stay there, even if the mode is disabled --]
/* USER CODE BEGIN PV */
FS_FileOperationsTypeDef Appli_state = APPLICATION_IDLE;
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
[@common.optinclude name=mxTmpFolder+"/fatfs_HalInit.tmp"/][#--do not place init code in user section, or it will stay there, even if the mode is disabled --]
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

/* USER CODE BEGIN Application */
     
/* USER CODE END Application */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
