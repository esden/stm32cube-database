[#ftl]
  /**
  ******************************************************************************
  * @file    HW_Init.h 
  * @author  MCD Application Team
  * @brief   Header for HW_Init.c module
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2018 STMicroelectronics International N.V. 
  * All rights reserved.</center></h2>
  *
  * Redistribution and use in source and binary forms, with or without 
  * modification, are permitted, provided that the following conditions are met:
  *
  * 1. Redistribution of source code must retain the above copyright notice, 
  *    this list of conditions and the following disclaimer.
  * 2. Redistributions in binary form must reproduce the above copyright notice,
  *    this list of conditions and the following disclaimer in the documentation
  *    and/or other materials provided with the distribution.
  * 3. Neither the name of STMicroelectronics nor the names of other 
  *    contributors to this software may be used to endorse or promote products 
  *    derived from this software without specific written permission.
  * 4. This software, including modifications and/or derivative works of this 
  *    software, must execute solely and exclusively on microcontroller or
  *    microprocessor devices manufactured by or for STMicroelectronics.
  * 5. Redistribution and use of this software other than as permitted under 
  *    this license is void and will automatically terminate your rights under 
  *    this license. 
  *
  * THIS SOFTWARE IS PROVIDED BY STMICROELECTRONICS AND CONTRIBUTORS "AS IS" 
  * AND ANY EXPRESS, IMPLIED OR STATUTORY WARRANTIES, INCLUDING, BUT NOT 
  * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
  * PARTICULAR PURPOSE AND NON-INFRINGEMENT OF THIRD PARTY INTELLECTUAL PROPERTY
  * RIGHTS ARE DISCLAIMED TO THE FULLEST EXTENT PERMITTED BY LAW. IN NO EVENT 
  * SHALL STMICROELECTRONICS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
  * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
  * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
  * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
  * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
  * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __HW_INIT_H
#define __HW_INIT_H

[#assign Use_ili9341 ="0"] 
[#-- SWIPdatas is a list of SWIPconfigModel --]  
[#list SWIPdatas as SWIP]  
[#-- Global variables --]
[#if SWIP.variables??]
	[#list SWIP.variables as variable]
extern ${variable.value} ${variable.name};
	[/#list]
[/#if]
[#if SWIP.defines??]
	[#list SWIP.defines as definition]	
	[#-- IF to take care of the specific formatting of each argument of this file  --]
[#-- ELSE IF --]
[#if definition.name = "Use_ili9341_Check"]
         [#if definition.value == "1" ]
[#assign Use_ili9341 ="1"] 
[/#if]
/* Includes ------------------------------------------------------------------*/
#include "${main_h}"
[#if Use_ili9341?? && Use_ili9341=="1"]
#include "ili9341.h"
[/#if]

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/


      
void MX_FMC_Init(void);
void MX_SDRAM_InitEx(void);
void MX_LCD_Init(void);
  [#elseif definition.name = "DMA2D_Graphics" ]
         [#if definition.value != "0" ] 
             [#assign dma2d ="1"] 
void MX_DMA2D_Init(void);
[/#if]
[#assign objectConstructor = "freemarker.template.utility.ObjectConstructor"?new()]
 [#assign file = objectConstructor("java.io.File",workspace+"/"+"ST-EmbeddedWizard/Ew_QUADSPI_tmp.c")]
  [#assign exist = file.exists()]
  [#if exist]
/* uint8_t QSPI_EnableMemoryMappedMode(void); */
[/#if]
[/#if]
[/#list]
[/#if]
[/#list]

#endif /* __HW_INIT_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
