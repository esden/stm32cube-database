[#ftl]
/**
  ******************************************************************************
  * @file    Tara_wrapper.h
  * @author  MCD Application Team
  * @version V1.2.0
  * @date    24-Février-2017
  * @brief   This file implements the configuration for the GUI library
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2016 STMicroelectronics International N.V. 
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
  
#ifndef TARA_WRAPPER_H
#define TARA_WRAPPER_H

/* Includes ------------------------------------------------------------------*/
#include "${FamilyName?lower_case}xx_hal.h"

#include <stdio.h>

#if EW_USE_FREE_RTOS == 1
  #include "cmsis_os.h"
#endif

#include "xprintf.h"
#include "tlsf.h"

#include "ewrte.h"
#include "ewgfx.h"
#include "ewextgfx.h"
#include "ewgfxdefs.h"
#include "Core.h"
#include "Graphics.h"

#include "ew_bsp_clock.h"
#include "ew_bsp_event.h"
#include "ew_bsp_display.h"
#include "ew_bsp_touch.h"
#include <stdio.h>
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
[#if definition.name = "UART_Traces" ]
[#if definition.value =="1"  ]
#include "ew_bsp_serial.h"
[/#if]

/* Exported constants --------------------------------------------------------*/
#if EW_USE_FREE_RTOS == 1
  #define semtstSTACK_SIZE    configMINIMAL_STACK_SIZE * 10
#endif

[#elseif definition.name = "EW_Frame_Buffer_Width"]
/* define pyhiscal dimension of the LCD framebuffer */
#define FRAME_BUFFER_WIDTH   #t#t ${definition.value} 
[#-- ELSE IF --]
[#elseif definition.name = "EW_Frame_Buffer_Height" ]
#define FRAME_BUFFER_HEIGHT  #t#t ${definition.value}

/* calculated addresses for framebuffer(s) and memory manager */
#define FRAME_BUFFER_SIZE     FRAME_BUFFER_WIDTH * FRAME_BUFFER_HEIGHT * FRAME_BUFFER_DEPTH
[#-- ELSE IF --]
[#elseif definition.name = "EW_FrameBuffer_StartAddress_DPI_DSI"]
#define FRAME_BUFFER_ADDR     (void*) #t#t ${definition.value}


#ifdef EW_USE_DOUBLE_BUFFER
#define DOUBLE_BUFFER_ADDR  (void*)((unsigned char*)FRAME_BUFFER_ADDR + FRAME_BUFFER_SIZE)
#define DOUBLE_BUFFER_SIZE  FRAME_BUFFER_SIZE
#else
#define DOUBLE_BUFFER_ADDR  (void*)(0)
#define DOUBLE_BUFFER_SIZE  0
#endif

[#-- ELSE IF --]
[#elseif definition.name = "EW_Memory_Pool_Size"]
#define MEMORY_POOL_ADDR      (void*)((unsigned char*)FRAME_BUFFER_ADDR + FRAME_BUFFER_SIZE + DOUBLE_BUFFER_SIZE)
#define MEMORY_POOL_SIZE      ${definition.value} - FRAME_BUFFER_SIZE - DOUBLE_BUFFER_SIZE

#undef USE_TERMINAL_INPUT

#if EW_USE_FREE_RTOS == 1
#define GRAPHICS_TaskPRIORITY     osPriorityNormal
#define GRAPHICS_TaskSTACK_SIZE   (configMINIMAL_STACK_SIZE * 12)
#endif

/* Functions prototypes-------------------------------------------------------*/
void GRAPHICS_Init(void);
void GRAPHICS_MainTask(void const *argument);
void GRAPHICS_IncTick(void);

#endif /* TARA_WRAPPER_H */

[/#if]
[/#list]
[/#if]
[/#list]

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/