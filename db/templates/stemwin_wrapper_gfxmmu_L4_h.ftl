[#ftl]
  /**
  ******************************************************************************
  * @file    STemWin_wrapper.h
  * @author  MCD Application Team
  * @brief   Header for STemWin_wrapper.c module
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
  
#include "main.h"
#include "GUIDRV_Lin.h"
#include <stdint.h>

#ifndef STEMWIN_WRAPPER_H
#define STEMWIN_WRAPPER_H
[#assign I2C_Exist ="0"]
[#assign MFX_value ="0"]
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

[#if definition.name = "RES_Signal" ]
[#if definition.value == "MFX-IO-PIN9" ]
[#assign MFX_value="MFX-IO-PIN9"] 
[/#if]
[#if definition.value == "MFX-IO-PIN10" ]
[#assign MFX_value="MFX-IO-PIN10"] 
[/#if]

[/#if]
[/#list]
[/#if]
[/#list]
[#assign objectConstructor = "freemarker.template.utility.ObjectConstructor"?new()]
[#assign file = objectConstructor("java.io.File",workspace+"/"+"STemWin/Target/hw_init_L4_tmp.c")]
  [#assign exist = file.exists()]
  [#if exist]
  [#assign I2C_Exist ="1"]
[/#if] 

[#if I2C_Exist =="1"]
[#if MFX_value=="MFX-IO-PIN9"]
/*##################### MFX ##########################*/    

#define IO_PIN_9                  ((uint32_t)0x00000200)
#define IO_PIN_ALL                ((uint32_t)0x0003FFFF)  

#define IO_I2C_ADDRESS            ((uint16_t) 0x84)
[/#if]
[#if MFX_value=="MFX-IO-PIN10"]
/*##################### MFX ##########################*/    

#define IO_PIN_8                  ((uint32_t)0x00000100)
#define IO_PIN_10                 ((uint32_t)0x00000400)
#define AGPIO_PIN_2               ((uint32_t)0x00040000)
#define IO_PIN_ALL                ((uint32_t)0x0003FFFF)  

#define IO_I2C_ADDRESS            ((uint16_t) 0x84)
[/#if]
[#if MFX_value=="0"]
#define IO_PIN_11                 ((uint32_t)0x00000800)
#define IO_PIN_12                 ((uint32_t)0x00001000)
#define IO_PIN_ALL                ((uint32_t)0x0003FFFF)  

#define IO_I2C_ADDRESS            (0x84)
[/#if]
[/#if] 

typedef enum 
{
  IO_OK       = 0x00,
  IO_ERROR    = 0x01,
  IO_TIMEOUT  = 0x02
}IO_StatusTypeDef;

typedef struct
{
  int32_t      address;          
  int32_t      pending_buffer;   
  int32_t      buffer_index;     
  int32_t      xSize;            
  int32_t      ySize;            
  int32_t      BytesPerPixel;
  LCD_API_COLOR_CONV   *pColorConvAPI;
}
LCD_LayerPropTypedef;

void LCD_WaitForDisplayCompletion( void );
void GRAPHICS_HW_Init(void);
void GRAPHICS_Init(void);
void GRAPHICS_IncTick(void);

#endif /* STEMWIN_WRAPPER_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
