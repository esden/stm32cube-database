[#ftl]
[#assign contextFolder=""]
[#if cpucore!=""]    
[#assign contextFolder = cpucore?replace("ARM_CORTEX_","C")+"/"]
[/#if]
/**
  ******************************************************************************
  * @file   fatfs.c
  * @brief  Code for fatfs applications
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

#include "fatfs.h"

[@common.optinclude name=contextFolder+mxTmpFolder+"/fatfs_vars.tmp"/]

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

/* USER CODE BEGIN Variables */

/* USER CODE END Variables */    

void MX_FATFS_Init(void) 
{
[@common.optinclude name=contextFolder+mxTmpFolder+"/fatfs_HalInit.tmp"/]

#t/* USER CODE BEGIN Init */
#t/* additional user code for init */     
#t/* USER CODE END Init */
}

[#list SWIPdatas as SWIP]  
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="_FS_NORTC"]                           
				[#if definition.value="0"]
/**
  * @brief  Gets Time from RTC 
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
