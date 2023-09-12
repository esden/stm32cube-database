[#ftl]
/**
 ******************************************************************************
  * File Name          : jdata_conf.c
  * Description        : This file implements LibJPEG file based read/write functions.
  *
  ******************************************************************************
  *
  * Copyright (c) 2019 STMicroelectronics. All rights reserved.
  *
  * This software component is licensed by ST under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the
  * License. You may obtain a copy of the License at:
  *                       opensource.org/licenses/BSD-3-Clause
  *
  ******************************************************************************
**/

/* Includes ------------------------------------------------------------------*/

[#list SWIPdatas as SWIP]  
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="LIBJPEG_FS_type"]
				[#if (definition.value="FatFS") || (definition.value="FatFS_Ronly")]
/*FatFS is chosen for File storage*/
					[#lt]#include "jdata_conf.h"
				[/#if]
			[/#if]
		[/#list]
	[/#if]
[/#list]

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

[#list SWIPdatas as SWIP]  
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="LIBJPEG_FS_type"]
				[#if (definition.value="FatFS") || (definition.value="FatFS_Ronly")]
					[#lt]size_t read_file (FIL  *file, uint8_t *buf, uint32_t sizeofbuf)
					[#lt]{
					[#lt]static size_t BytesReadfile ;  
					[#lt]f_read (file, buf , sizeofbuf, &BytesReadfile); 
					[#lt]return BytesReadfile;    
					[#lt]}
				[/#if]

				[#if (definition.value="FatFS")]
					[#lt]size_t write_file (FIL  *file, uint8_t *buf, uint32_t sizeofbuf)
					[#lt]{
   				[#lt]static size_t BytesWritefile;  
   				[#lt]f_write (file, buf , sizeofbuf, &BytesWritefile); 
   				[#lt]return BytesWritefile; 
					[#lt]}
				[#elseif (definition.value="FatFS_Ronly")]
					[#lt]size_t write_file (FIL  *file, uint8_t *buf, uint32_t sizeofbuf)
					[#lt]{
   				[#lt]static size_t BytesWritefile = 0;  
/* USER CODE BEGIN 0 */
/*FatFS is in "Ronly mode" : LibJPEG File based data "destination" manager should not be used.
In case it is used, this function will returns "0 byte written" systematically.
You can keep this code as it or implement you own "write_file" routine here.*/

/* USER CODE END 0 */
   				[#lt]return BytesWritefile; 
					[#lt]}
				[/#if]
			[/#if]
		[/#list]
	[/#if]
[/#list]


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
