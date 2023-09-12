[#ftl]
  /**
  ******************************************************************************
  * @file    ew_bsp_display.c
  * @author  MCD Application Team
  * @brief   This file is part of the interface (glue layer) between an Embedded 
  *          Wizard generated UI application and the board support package 
  *          (BSP) of a dedicated target.   
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
  * DESCRIPTION:
  *   This template is responsible to initialize the display hardware of 
  *   the board and to provide the necessary access to update the display 
  *   content. 
  ******************************************************************************
  */


#include "${FamilyName?lower_case}xx_hal.h"
[#assign useOTM="0"]
[#assign doubleBuffer="0"]
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


[#if definition.name = "USE_OTM8009A"]
[#if definition.value == "1"  ]
[#assign useOTM = "1"]
[/#if]

[#-- ELSE IF --]
[#elseif definition.name = "EW_USE_DOUBLE_BUFFER"]
[#if definition.value =="1"  ]
[#assign doubleBuffer="1"]
[/#if]

#include "ewrte.h"
#include "ewgfx.h"
#include "ewextgfx.h"
#include "ewgfxdefs.h"

#include "ew_bsp_graphics.h"
#include "ew_bsp_display.h"
#include "ew_bsp_clock.h"
[#if  useOTM == "1"  ]
#include "otm8009a.h"
[/#if]

#if EW_USE_FREE_RTOS == 1

  #include "cmsis_os.h"

  static osSemaphoreId        LcdUpdateSemaphoreId = 0;

#endif

#define LAYER_INDEX           0

#define NO_AREA               0
#define LEFT_AREA             1
#define RIGHT_AREA            2


#define __DSI_MASK_TE()       (GPIOJ->AFR[0] &= (0xFFFFF0FFU))   /* Mask DSI TearingEffect Pin*/
#define __DSI_UNMASK_TE()     (GPIOJ->AFR[0] |= ((uint32_t)(GPIO_AF13_DSI) << 8)) /* UnMask DSI TearingEffect Pin*/

extern LTDC_HandleTypeDef     hltdc;
extern DSI_HandleTypeDef      hdsi;
extern LTDC_LayerCfgTypeDef   pLayerCfg;


static uint32_t               CurrentFramebufferAddress = 0;
static volatile int32_t       ActiveArea  = LEFT_AREA;

[#if useOTM?? &&  useOTM == "1"  ]
static uint8_t pColLeft[]   = {0x00, 0x00, 0x01, 0x8F}; /*   0 -> 399 */
static uint8_t pColRight[]  = {0x01, 0x90, 0x03, 0x1F}; /* 400 -> 799 */
static uint8_t pPage[]      = {0x00, 0x00, 0x01, 0xDF}; /*   0 -> 479 */

[/#if]
[#if useOTM?? &&  useOTM == "0"  ]
/* static uint8_t pColLeft[]   = {0x00, 0x00, 0x01, 0x8F};   0 -> 399 */
/* static uint8_t pColRight[]  = {0x01, 0x90, 0x03, 0x1F};  400 -> 799 */
/* static uint8_t pPage[]      = {0x00, 0x00, 0x01, 0xDF};    0 -> 479 */

[/#if]
[#if useOTM == "1" ]

#ifdef EW_USE_DOUBLE_BUFFER
  static uint8_t pScanCol[] = {0x01, 0xB0};             /* Scan @ 432 */
#else
  static uint8_t pScanCol[] = {0x02, 0x40};             /* Scan @ 576 */
#endif
[/#if]

[#if useOTM == "0" ]
/* #ifdef EW_USE_DOUBLE_BUFFER */
/* static uint8_t pScanCol[] = {0x01, 0xB0};              Scan @ 432 */
/* #else */
/* static uint8_t pScanCol[] = {0x02, 0x40};              Scan @ 576 */
/* #endif */
[/#if]



/*******************************************************************************
* FUNCTION:
*   GFX_Config_Display
*
* DESCRIPTION:
*   Configures the display hardware.
*
* ARGUMENTS:
*   aWidth   - Width of the framebuffer in pixel.
*
* RETURN VALUE:
*   None
*
*******************************************************************************/


void GFX_Config_Display(int aWidth)
{

 ActiveArea = NO_AREA;

  #if EW_USE_FREE_RTOS == 1

    /* Create the LCD update semaphore */
    osSemaphoreDef( LcdUpdateSemaphore );
    LcdUpdateSemaphoreId = osSemaphoreCreate( osSemaphore( LcdUpdateSemaphore ), 1 );

  #endif
    __HAL_DSI_WRAPPER_DISABLE(&hdsi);
  /* Update pitch : the draw is done on the whole physical X Size */
  HAL_LTDC_SetPitch( &hltdc, aWidth, LAYER_INDEX );
    
  __HAL_DSI_WRAPPER_ENABLE(&hdsi);
  [#if useOTM == "1" ]
  HAL_DSI_LongWrite( &hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 4, OTM8009A_CMD_CASET, pColLeft );
  HAL_DSI_LongWrite( &hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 4, OTM8009A_CMD_PASET, pPage );

  HAL_DSI_LongWrite(&hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 2, OTM8009A_CMD_WRTESCN, pScanCol);
 [/#if]

  [#if useOTM == "0" ]
 /* Configures the LCD screen driver.  */                    
 /*    USER CODE BEGIN  LCD_screen_driver1 */

    /*     HAL_DSI_LongWrite( &hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 4, OTM8009A_CMD_CASET, pColLeft );   */
    /*     HAL_DSI_LongWrite( &hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 4, OTM8009A_CMD_PASET, pPage );     */

    /*     HAL_DSI_LongWrite(&hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 2, OTM8009A_CMD_WRTESCN, pScanCol); */

   /*  USER CODE END LCD_screen_driver1 */
 [/#if]

  /* short delay necessary to ensure proper DSI update... */
  HAL_Delay( 100 );

  #if EW_USE_FREE_RTOS == 1

    /* initially take the LcdUpdate token for the first LCD update */
    osSemaphoreWait( LcdUpdateSemaphoreId , 1000 );

  #endif

}


/*******************************************************************************
* FUNCTION:
*   EwBspConfigDisplay
*
* DESCRIPTION:
*   Configures the display hardware.
*
* ARGUMENTS:
*   aWidth   - Width of the framebuffer in pixel.
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspConfigDisplay(int aWidth)
{
   GFX_Config_Display(aWidth);
}



/*******************************************************************************
* FUNCTION:
*   EwBspWaitForDisplayCompletion
*
* DESCRIPTION:
*   The function EwBspWaitForDisplayCompletion returns as soon as the LCD update
*   has been completed.
*
* ARGUMENTS:
*   None
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
static void EwBspWaitForDisplayCompletion( void )
{
  if ( ActiveArea == NO_AREA )
    return;

  CPU_LOAD_SET_IDLE();

  #if EW_USE_FREE_RTOS == 1

    osSemaphoreWait( LcdUpdateSemaphoreId , 1000 );
    ActiveArea = NO_AREA;

  #else

  while ( ActiveArea != NO_AREA )
    ;

  #endif

  CPU_LOAD_SET_ACTIVE();
}


/*******************************************************************************
* FUNCTION:
*   EwBspUpdateDisplay
*
* DESCRIPTION:
*   Starts the transfer of the framebuffer content via DSI to update the LCD.
*
* ARGUMENTS:
*   None
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspUpdateDisplay( void )
{
  
/* ensure that LCD update is finished */
  EwBspWaitForDisplayCompletion();

  /* prepare the update of the left display area */
  ActiveArea = LEFT_AREA;

  /* change address within layer configuration structure */
  pLayerCfg.FBStartAdress = CurrentFramebufferAddress;

  /* change layer configuration */
  if ( HAL_LTDC_ConfigLayer( &hltdc, &pLayerCfg, LAYER_INDEX ) != HAL_OK )
    EwPrint( "EwBspUpdateDisplay: Could not change layer configuration!\n" );

  /* Disable DSI Wrapper */
  __HAL_DSI_WRAPPER_DISABLE( &hdsi );

  /* Update LTDC configuaration */
  LTDC_LAYER( &hltdc, LAYER_INDEX )->CFBAR = pLayerCfg.FBStartAdress ;
  __HAL_LTDC_RELOAD_CONFIG( &hltdc );

  /* Enable DSI Wrapper */
  __HAL_DSI_WRAPPER_ENABLE( &hdsi );
[#if useOTM?? &&  useOTM == "1"  ]
  HAL_DSI_LongWrite( &hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 4, OTM8009A_CMD_CASET, pColLeft );
[/#if]

[#if useOTM?? &&  useOTM == "0"  ]
 /* Configures the LCD screen driver. */
      /*  USER CODE BEGIN LCD_screen_driver2 */

       /*    HAL_DSI_LongWrite( &hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 4, OTM8009A_CMD_CASET, pColLeft ); */

     /*  USER CODE END LCD_screen_driver2 */
[/#if]


  /* start the update of the LCD via DSI */
  __DSI_UNMASK_TE();

  #if EW_USE_DOUBLE_BUFFER == 1

    /* reserve the memory bandwidth for the DSI update */
    EwBspGraphicsConcurrentOperation( 0 );

  #else

    /* ensure that LCD update is finished */
    EwBspWaitForDisplayCompletion();

  #endif

}

/*******************************************************************************
* FUNCTION:
*   HAL_DSI_TearingEffectCallback
*
* DESCRIPTION:
*   Tearing Effect DSI callback.
*
* ARGUMENTS:
*   hdsi - Pointer to a DSI_HandleTypeDef structure that contains the
*     configuration information for the DSI.
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void HAL_DSI_TearingEffectCallback( DSI_HandleTypeDef* hdsi )
{
  /* Mask the TE */
  __DSI_MASK_TE();

  /* Refresh the left part of the display */
  HAL_DSI_Refresh( hdsi );
}


/*******************************************************************************
* FUNCTION:
*   HAL_DSI_EndOfRefreshCallback
*
* DESCRIPTION:
*   End of Refresh DSI callback.
*
* ARGUMENTS:
*   hdsi - Pointer to a DSI_HandleTypeDef structure that contains the
*     configuration information for the DSI.
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void HAL_DSI_EndOfRefreshCallback( DSI_HandleTypeDef* hdsi )
{

  if ( ActiveArea == LEFT_AREA )
  {
    /* Disable DSI Wrapper */
    __HAL_DSI_WRAPPER_DISABLE( hdsi );

    /* Update LTDC configuaration */
    LTDC_LAYER( &hltdc, LAYER_INDEX )->CFBAR = pLayerCfg.FBStartAdress + pLayerCfg.ImageWidth * FRAME_BUFFER_DEPTH;
    __HAL_LTDC_RELOAD_CONFIG( &hltdc );

    /* Enable DSI Wrapper */
    __HAL_DSI_WRAPPER_ENABLE( hdsi );
     [#if useOTM?? &&  useOTM == "1"  ]
    HAL_DSI_LongWrite( hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 4, OTM8009A_CMD_CASET, pColRight );
    [/#if]

   [#if useOTM?? &&  useOTM == "0"  ]
    /* Configures the LCD screen driver. */

      /*  USER CODE BEGIN LCD_screen_driver3*/

        /* HAL_DSI_LongWrite( hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 4, OTM8009A_CMD_CASET, pColRight ); */

     /*   USER CODE END LCD_screen_driver3 */
    [/#if]

    /* Refresh the display */
    HAL_DSI_Refresh( hdsi );

    ActiveArea = RIGHT_AREA;
  }
  else
  {

    #if EW_USE_FREE_RTOS == 1

      osSemaphoreRelease( LcdUpdateSemaphoreId );

    #else

      ActiveArea = NO_AREA;

    #endif

    /* DSI update is done, now let the DMA2D work in parallel with CPU */
    EwBspGraphicsConcurrentOperation( 1 );
  }

}


/*******************************************************************************
* FUNCTION:
*   EwBspSetFramebufferAddress
*
* DESCRIPTION:
*   The function EwBspSetFramebufferAddress is called from the Graphics Engine
*   in order to change the currently active framebuffer address. If the display
*   is running in a double-buffering mode, the function is called after each
*   screen update.
*   Changing the framebuffer address should be synchronized with V-sync.
*   In case of double-buffering, the function has to wait and return after
*   the V-sync was detected.
*
* ARGUMENTS:
*   aAddress - New address of the framebuffer to be shown on the display.
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspSetFramebufferAddress( unsigned long aAddress )
{
  CurrentFramebufferAddress = (uint32_t)aAddress;
}


/*******************************************************************************
* FUNCTION:
*   EwBspSetFramebufferClut
*
* DESCRIPTION:
*   The function EwBspSetFramebufferClut is called from the Graphics Engine
*   in order to update the hardware CLUT of the current framebuffer.
*   The function is only called when the color format of the framebuffer is
*   Index8 or LumA44.
*
* ARGUMENTS:
*   aClut - Pointer to a color lookup table with 256 enries.
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspSetFramebufferClut( unsigned long* aClut )
{
  __HAL_DSI_WRAPPER_DISABLE( &hdsi);

  /* short delay necessary to ensure proper DSI update... */
  HAL_Delay( 100 );

  if ( HAL_LTDC_ConfigCLUT( &hltdc, (uint32_t*)aClut, 256, LAYER_INDEX ) != HAL_OK )
    EwPrint( "EwBspSetFramebufferClut: Could not configure layer CLUT!\n" );
  if ( HAL_LTDC_EnableCLUT( &hltdc, LAYER_INDEX ) != HAL_OK )
    EwPrint( "EwBspSetFramebufferClut: Could not enable layer CLUT!\n" );

  /* short delay necessary to ensure proper DSI update... */
  HAL_Delay( 100 );

  __HAL_DSI_WRAPPER_ENABLE( &hdsi );

  /* short delay necessary to ensure proper DSI update... */
  HAL_Delay( 100 );
}


/* msy */

[/#if]
[/#list]
[/#if]
[/#list]
