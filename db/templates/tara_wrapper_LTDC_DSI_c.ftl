[#ftl]
/**
  ******************************************************************************
  * @file    Tara_wrapper.c
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
/**
* @}
*/ 
#include "tara_wrapper.h"
#include "hw_init.h"

tlsf_t MemPool;

static CoreRoot               rootObject;
static XViewport*             viewport;

/*******************************************************************************
* FUNCTION:
*   Update
*
* DESCRIPTION:
*   The function Update performs the screen update of the dirty area.
*
* ARGUMENTS:
*   aViewPort    - Viewport used for the screen update.
*   aApplication - Root object used for the screen update.
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
static void Update( XViewport* aViewport, CoreRoot aApplication )
{
  XBitmap*       bitmap     = EwBeginUpdate( aViewport );
  GraphicsCanvas canvas     = EwNewObject( GraphicsCanvas, 0 );
  XRect          updateRect = {{ 0, 0 }, { 0, 0 }};

  /* let's redraw the dirty area of the screen. Cover the returned bitmap
     objects within a canvas, so Mosaic can draw to it. */
  if ( bitmap && canvas )
  {
    GraphicsCanvas__AttachBitmap( canvas, (XUInt32)bitmap );
    updateRect = CoreRoot__UpdateGE20( aApplication, canvas );
    GraphicsCanvas__DetachBitmap( canvas );
  }

  /* complete the update */
  if ( bitmap )
    EwEndUpdate( aViewport, updateRect );

  /* check if there is a dirty area so that the screen should be updated */
  if (( updateRect.Point2.X - updateRect.Point1.X <= 0 ) || ( updateRect.Point2.Y - updateRect.Point1.Y <= 0 ))
    return;

  /* start the update of the LCD via DSI */
  EwBspUpdateDisplay();
}



[@common.optinclude name="EmbeddedWizard/tara_wrapper_LCD_Reset_tmp.c"/] 

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
               [#if definition.name = "OTM8009A_Orientation" ]

[#if definition.value != "0" ]

/**************************** LINK OTM8009A (Display driver) ******************/
/**
  * @brief  OTM8009A delay
  * @param  Delay: Delay in ms
  */
void OTM8009A_IO_Delay(uint32_t Delay)
{
  HAL_Delay(Delay);
}
[/#if]

void GRAPHICS_HW_Init(void)
{
   [#assign objectConstructor = "freemarker.template.utility.ObjectConstructor"?new()]
[#assign file = objectConstructor("java.io.File",workspace+"/"+"EmbeddedWizard/tara_wrapper_LCD_Reset_tmp.c")]
  [#assign exist = file.exists()]
  [#if exist]
   LCD_LL_Reset();
 [/#if]
   MX_FMC_Init();
   MX_SDRAM_InitEx();
   MX_LCD_Init();
   MX_DSI_Init();
}

void GRAPHICS_IncTick(void){
  EwBspSystemTickIncrement();
} 

void GRAPHICS_Init(void)
{
  /* configure system tick counter */
  EwBspConfigSystemTick();

[#assign useUART="0"]
[#elseif definition.name = "UART_Traces" ]
[#if definition.value != "0"  ]
[#assign useUART="1"]
  xdev_out( EwBspPutCharacter );
[/#if]
  EwBspConfigDisplay(FRAME_BUFFER_WIDTH);
  [#if useUART == "1" ]
  xputs( "[OK]\n" );
 [/#if]
  /* initialize touchscreen */
  [#if useUART == "1" ]
  EwPrint( "Initialize Touch Driver...                   " );
 [/#if]
  EwBspConfigTouch( FRAME_BUFFER_WIDTH, FRAME_BUFFER_HEIGHT );
[#if useUART == "1" ]
  EwPrint( "[OK]\n" );
  [/#if]
  /* initialize tlsf memory manager */
  /* please note, that the first part of SDRAM is reserved for framebuffer */
[#if useUART == "1" ]
  EwPrint( "Initialize Memory Manager...                 " );
 [/#if]
  MemPool = tlsf_create_with_pool( MEMORY_POOL_ADDR, MEMORY_POOL_SIZE );
[#if useUART == "1" ]
  EwPrint( "[OK]\n" );

  EwPrint( "MemoryPool at address 0x%08X size 0x%08X\n", MEMORY_POOL_ADDR, MEMORY_POOL_SIZE );
 [/#if]
  /* initialize the Graphics Engine and Runtime Environment */
[#if useUART == "1" ]
  EwPrint( "Initialize Graphics Engine...                " );
 [/#if]
  if ( !EwInitGraphicsEngine( 0 ))
    return;
[#if useUART == "1" ]
  EwPrint( "[OK]\n" );
 [/#if]
  /* create the applications root object ... */
[#if useUART == "1" ]
  EwPrint( "Create Embedded Wizard Root Object...        " );
[/#if]
  rootObject = (CoreRoot)EwNewObjectIndirect( EwApplicationClass, 0 );
  EwLockObject( rootObject );
  CoreRoot__Initialize( rootObject, EwScreenSize );
[#if useUART == "1" ]
  EwPrint( "[OK]\n" );
[/#if]
  /* create Embedded Wizard viewport object to provide uniform access to the framebuffer */
[#if useUART == "1" ]
  EwPrint( "Create Embedded Wizard Viewport...           " );
[/#if]
  viewport = EwInitViewport( EwScreenSize, EwNewRect( 0, 0, FRAME_BUFFER_WIDTH, FRAME_BUFFER_HEIGHT ),
    0, 255, FRAME_BUFFER_ADDR, DOUBLE_BUFFER_ADDR, 0, 0 );
[#if useUART == "1" ]
  EwPrint( "[OK]\n" );
[/#if]
}


void GRAPHICS_MainTask(void const *argument)
{
  int        touched = 0;
  XPoint     touchPos;

  /* start the EmWi main loop and process all user inputs, timers and signals */
  while( 1 )
  {
    int timers  = 0;
    int signals = 0;
    int events  = 0;

    /* receive touch inputs and provide the application with them */
    if ( EwBspGetTouchPosition( &touchPos ))
    {
      /* begin of touch cycle */
      if ( touched == 0 )
        CoreRoot__DriveCursorHitting( rootObject, 1, 0, touchPos );

      /* movement during touch cycle */
      else if ( touched == 1 )
        CoreRoot__DriveCursorMovement( rootObject, touchPos );

      touched = 1;
      events  = 1;
    }
    /* end of touch cycle */
    else if ( touched == 1 )
    {
      CoreRoot__DriveCursorHitting( rootObject, 0, 0, touchPos );
      touched = 0;
      events  = 1;
    }

    /* process expired timers */
    timers = EwProcessTimers();

    /* process the pending signals */
    signals = EwProcessSignals();

    /* refresh the screen, if something has changed and draw its content */
    if ( timers || signals || events )
    {
      Update( viewport, rootObject );

      /* after each processed message start the garbage collection */
      EwReclaimMemory();

      /* print current memory statistic to serial interface - uncomment if needed */
      //  EwPrintProfilerStatistic( 0 );
    }
    /* otherwise sleep/suspend the UI application until a certain event occurs or a timer expires... */
    else
      EwBspWaitForSystemEvent( EwNextTimerExpiration());
  }
}
[/#if]
[/#list]
[/#if]
[/#list]
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
