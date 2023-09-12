[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
  * File Name          : jdata_conf.h
  * Description        : This file provides header to "jdata_conf.h" module.
  *                      It implements also file based read/write functions.
  *
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2019 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
**/
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/

[#list SWIPdatas as SWIP]  
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="LIBJPEG_FS_type"]
				[#if (definition.value="FatFS") || (definition.value="FatFS_Ronly")]
/*FatFS is chosen for File storage*/
					[#lt]#include "ff.h"
				[#elseif definition.value="Stdio"]
/*Stdio is chosen for File storage*/
					[#lt]#include <stdio.h>
				[#elseif definition.value="NoFS"]
					[#lt]#include <stdio.h>
				[/#if]
			[/#if]
		[/#list]
	[/#if]
[/#list]

[#list SWIPdatas as SWIP]  
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="LIBJPEG_with_FREERTOS"]
				[#if definition.value="1"]
/*FreeRtos Api*/				
					[#lt]#include "cmsis_os.h"
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
			[#if definition.name="LIBJPEG_with_FREERTOS"]
/*This defines the memory allocation methods.*/
				[#if definition.value="1"]
					[#lt]#define JMALLOC   pvPortMalloc
					[#lt]#define JFREE     vPortFree
				[#elseif definition.value="0"]
					[#lt]#define JMALLOC   malloc
					[#lt]#define JFREE     free
				[/#if]
			[/#if]
		[/#list]
	[/#if]
[/#list]

		
[#list SWIPdatas as SWIP]  
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if (definition.name="LIBJPEG_FS_type")]
/*This defines the File data manager type.*/
				[#if (definition.value="FatFS") || (definition.value="FatFS_Ronly")]
					[#lt]#define JFILE            FIL

					[#lt]size_t read_file (FIL  *file, uint8_t *buf, uint32_t sizeofbuf);
					[#lt]size_t write_file (FIL  *file, uint8_t *buf, uint32_t sizeofbuf) ;

					[#lt]#define JFREAD(file,buf,sizeofbuf)  \
								[#lt]read_file (file,buf,sizeofbuf)

					[#lt]#define JFWRITE(file,buf,sizeofbuf)  \
								[#lt]write_file (file,buf,sizeofbuf)
				[#elseif definition.value="Stdio"]
					[#lt]#define JFILE            FILE

					[#lt]#define JFREAD(file,buf,sizeofbuf)  \
								[#lt]((size_t) fread((void *) (buf), (size_t) 1, (size_t) (sizeofbuf), (file)))

					[#lt]#define JFWRITE(file,buf,sizeofbuf)  \
								[#lt]((size_t) fwrite((const void *) (buf), (size_t) 1, (size_t) (sizeofbuf), (file)))
				[#elseif definition.value="NoFS"]
					[#lt]#undef JFILE
				[/#if]
			[/#if]
		[/#list]
	[/#if]
[/#list]

