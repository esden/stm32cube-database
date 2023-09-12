[#ftl]
  /**
  ******************************************************************************
  * @file    ew_bsp_graphics.c
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
  *   This file contains an interface to the DMA2D hardware of the STM32 target
  *   in order to provide graphics acceleration for the Embedded Wizard 
  *   generated UI applications.  
  *   This interface is intended to be used only by the Graphics Engine of
  *   Embedded Wizard.
  *
  ******************************************************************************
  */


#include "${FamilyName?lower_case}xx_hal.h"

#include <string.h>

#include "ew_bsp_graphics.h"
#include "ew_bsp_clock.h"

#if EW_USE_FREE_RTOS == 1
  #include "cmsis_os.h"
  osSemaphoreId AcceleratorSemaphoreId;
#endif

static volatile char       TransferInProgress  = 0;
static char                ConcurrentOperation = 1;
extern DMA2D_HandleTypeDef hdma2d;


/*******************************************************************************
* FUNCTION:
*   XferCpltCallback
*
* DESCRIPTION:
*   Initialize the DMA2D graphics accelerator transfer complete callback.
*
* ARGUMENTS:
*   hdma2d - hdma2d handler
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
static void XferCpltCallback(DMA2D_HandleTypeDef *hdma2d)
{
  if ( hdma2d->State == HAL_DMA2D_STATE_READY )
  {
    #if EW_USE_FREE_RTOS == 1

      osSemaphoreRelease( AcceleratorSemaphoreId );

    #else

      TransferInProgress = 0;

    #endif
  }
}


/*******************************************************************************
* FUNCTION:
*   EwBspGraphicsInit
*
* DESCRIPTION:
*   Initialize the DMA2D graphics accelerator.
*
* ARGUMENTS:
*   aDstColorMode - Colorformat of the destination bitmap
*
* RETURN VALUE:
*   If successful, returns != 0.
*
*******************************************************************************/
int EwBspGraphicsInit( uint32_t aDstColorMode )
{
  /* clear entire accelerator struct including layer configurations */
  memset( &hdma2d, 0, sizeof( DMA2D_HandleTypeDef ));

  #if EW_USE_FREE_RTOS == 1

    /* Create the accelerator semaphore */
    osSemaphoreDef(AcceleratorSemaphore);
    AcceleratorSemaphoreId = osSemaphoreCreate(osSemaphore(AcceleratorSemaphore), 1);

    /* initially take the accelerator token for the first DMA2D transfer */
    osSemaphoreWait( AcceleratorSemaphoreId, 1000 );

  #endif

  TransferInProgress  = 0;
  ConcurrentOperation = 1;

  hdma2d.Instance = DMA2D;
  hdma2d.XferCpltCallback = XferCpltCallback;
  if (HAL_DMA2D_Init(&hdma2d) != HAL_OK)
  {
    return 0;
  }

  return 1;
}


/*******************************************************************************
* FUNCTION:
*   EwBspGraphicsDone
*
* DESCRIPTION:
*   Deinitialize the DMA2D graphics accelerator.
*
* ARGUMENTS:
*   None
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspGraphicsDone( void )
{
  /* deinitialize the DMA2D graphics accelerator */
  HAL_DMA2D_DeInit( &hdma2d );
}


/*******************************************************************************
* FUNCTION:
*   EwBspGraphicsWaitForCompletion
*
* DESCRIPTION:
*   The function EwBspGraphicsWaitForCompletion returns as soon as the DMA2D has
*   completed a pending graphics instruction. If the DMA2D is in idle mode,
*   the function returns immediately.
*
* ARGUMENTS:
*   None
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspGraphicsWaitForCompletion()
{
  /* return immediately if no DMA2D transfer is ongoing */
  if ( TransferInProgress == 0 )
    return;

  CPU_LOAD_SET_IDLE();

#ifdef EW_USE_DMA2D_INTERRUPT_MODE

  #if EW_USE_FREE_RTOS == 1

    osSemaphoreWait( AcceleratorSemaphoreId, 1000 );
    TransferInProgress = 0;

  #else

    /* wait until DMA2D transfer is done */
    while( TransferInProgress )
      ;

  #endif

#else

  /* wait until DMA2D transfer is done */
  HAL_DMA2D_PollForTransfer( &hdma2d, 1000 );
  TransferInProgress = 0;

#endif

  CPU_LOAD_SET_ACTIVE();
}


/*******************************************************************************
* FUNCTION:
*   EwBspGraphicsConcurrentOperation
*
* DESCRIPTION:
*   The function EwBspGraphicsConcurrentOperation configures the operation mode
*   of DMA2D and CPU. If concurrent operation is enabled, the CPU will work in
*   parallel while the DMA2D is transferring data. If concurrent operation is
*   disabled, the CPU will wait everytime the DMA2D is active.
*   This feature is intended to limit the memory bandwidth, e.g. during display
*   update or other bandwidth consuming activities.
*
* ARGUMENTS:
*   aEnable - flag to switch on/off concurrent operation mode.
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspGraphicsConcurrentOperation( int aEnable )
{
  ConcurrentOperation = (char)aEnable;
}


/*******************************************************************************
* FUNCTION:
*   EwBspGraphicsFill
*
* DESCRIPTION:
*   The function EwBspGraphicsFill is used by the Graphics Engine, when a
*   rectangular area should be filled with a constant color by using the DMA2D
*   functionality.
*
* ARGUMENTS:
*   aDstAddr      - Destination address of the transfer.
*   aDstOffset    - Offset in pixel to next row within the destination.
*   aWidth,
*   aHeight       - Size of the area to fill.
*   aDstColorMode - Colorformat of the destination.
*   aSrcColor     - Color to fill the rectangular area.
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspGraphicsFill( uint32_t aDstAddr, uint32_t aDstOffset, uint32_t aWidth,
  uint32_t aHeight, uint32_t aDstColorMode, uint32_t aSrcColor )
{
  /* ensure that previous DMA2D instruction is finished */
  EwBspGraphicsWaitForCompletion();

  /* prepare destination output configuration */
  hdma2d.Init.Mode                  = DMA2D_R2M;
  hdma2d.Init.ColorMode             = aDstColorMode;
  hdma2d.Init.OutputOffset          = aDstOffset;

  /* initialize the DMA2D graphics accelerator */
  HAL_DMA2D_Init( &hdma2d );

  /* set the flag for DMA2D transfer */
  TransferInProgress = 1;

#ifdef EW_USE_DMA2D_INTERRUPT_MODE

  /* start the transfer */
  HAL_DMA2D_Start_IT( &hdma2d, aSrcColor, aDstAddr, aWidth, aHeight );

#else

  /* start the transfer */
  HAL_DMA2D_Start( &hdma2d, aSrcColor, aDstAddr, aWidth, aHeight );

#endif

  /* check for immediate completion of drawing operation */
  if ( !ConcurrentOperation )
    EwBspGraphicsWaitForCompletion();
}


/*******************************************************************************
* FUNCTION:
*   EwBspGraphicsFillBlend
*
* DESCRIPTION:
*   The function EwBspGraphicsFillBlend is used by the Graphics Engine, when a
*   rectangular area should be blended with a constant color by using the DMA2D
*   functionality.
*
* ARGUMENTS:
*   aDstAddr      - Destination address of the transfer.
*   aDstOffset    - Offset in pixel to next row within the destination.
*   aWidth,
*   aHeight       - Size of the area to blend.
*   aDstColorMode - Colorformat of the destination.
*   aSrcColor     - Color to blend the rectangular area.
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspGraphicsFillBlend( uint32_t aDstAddr, uint32_t aDstOffset, uint32_t aWidth,
  uint32_t aHeight, uint32_t aDstColorMode, uint32_t aSrcColor )
{
  /* ensure that previous DMA2D instruction is finished */
  EwBspGraphicsWaitForCompletion();

  /* prepare destination output configuration */
  hdma2d.Init.Mode                  = DMA2D_M2M_BLEND;
  hdma2d.Init.ColorMode             = aDstColorMode;
  hdma2d.Init.OutputOffset          = aDstOffset;

  /* prepare destination input configuration */
  hdma2d.LayerCfg[0].InputOffset    = aDstOffset;
  hdma2d.LayerCfg[0].InputColorMode = aDstColorMode;
  hdma2d.LayerCfg[0].AlphaMode      = DMA2D_COMBINE_ALPHA;
  hdma2d.LayerCfg[0].InputAlpha     = 255;

  /* replace alpha channel if destination does not provide one */
  if (( aDstColorMode == DMA2D_OUTPUT_RGB888 ) || ( aDstColorMode == DMA2D_OUTPUT_RGB565 ))
    hdma2d.LayerCfg[0].AlphaMode    = DMA2D_REPLACE_ALPHA;

  /* foreground layer configuration is used as source of transfer */
  hdma2d.LayerCfg[1].InputOffset    = 0x00; /* no offset in input */
  hdma2d.LayerCfg[1].InputColorMode = DMA2D_INPUT_A8;
  hdma2d.LayerCfg[1].AlphaMode      = DMA2D_REPLACE_ALPHA;
  hdma2d.LayerCfg[1].InputAlpha     = aSrcColor;

  /* initialize the DMA2D graphics accelerator */
  HAL_DMA2D_Init( &hdma2d );

  /* set the layer configurtation (foreground layer) */
  HAL_DMA2D_ConfigLayer( &hdma2d, 1 );

  /* set the layer configurtation (background layer) */
  HAL_DMA2D_ConfigLayer( &hdma2d, 0 );

  /* set the flag for DMA2D transfer */
  TransferInProgress = 1;

#ifdef EW_USE_DMA2D_INTERRUPT_MODE

  /* start the transfer */
  HAL_DMA2D_BlendingStart_IT( &hdma2d, aDstAddr, aDstAddr, aDstAddr, aWidth, aHeight );

#else

  /* start the transfer */
  HAL_DMA2D_BlendingStart( &hdma2d, aDstAddr, aDstAddr, aDstAddr, aWidth, aHeight );

#endif

  /* check for immediate completion of drawing operation */
  if ( !ConcurrentOperation )
    EwBspGraphicsWaitForCompletion();
}


/*******************************************************************************
* FUNCTION:
*   EwBspGraphicsCopy
*
* DESCRIPTION:
*   The function EwBspGraphicsCopy is used by the Graphics Engine, when a source
*   bitmap should be copied into a destination bitmap by using the DMA2D
*   functionality.
*
* ARGUMENTS:
*   aDstAddr      - Destination address of the transfer.
*   aSrcAddr      - Source address of the transfer.
*   aDstOffset    - Offset in pixel to next row within the destination bitmap.
*   aSrcOffset    - Offset in pixel to next row within the source bitmap.
*   aWidth,
*   aHeight       - Size of the area to transfer the bitmap.
*   aDstColorMode - Colorformat of the destination bitmap
*   aSrcColorMode - Colorformat of the source bitmap.
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspGraphicsCopy( uint32_t aDstAddr, uint32_t aSrcAddr, uint32_t aDstOffset,
  uint32_t aSrcOffset, uint32_t aWidth, uint32_t aHeight, uint32_t aDstColorMode,
  uint32_t aSrcColorMode )
{
  /* ensure that previous DMA2D instruction is finished */
  EwBspGraphicsWaitForCompletion();

  /* prepare destination output configuration */
  hdma2d.Init.Mode                  = ( aDstColorMode == aSrcColorMode ) ? DMA2D_M2M : DMA2D_M2M_PFC;
  hdma2d.Init.ColorMode             = aDstColorMode;
  hdma2d.Init.OutputOffset          = aDstOffset;

  /* prepare source input configuration */
  hdma2d.LayerCfg[1].InputOffset    = aSrcOffset;
  hdma2d.LayerCfg[1].InputColorMode = aSrcColorMode;
  hdma2d.LayerCfg[1].AlphaMode      = DMA2D_NO_MODIF_ALPHA;
  hdma2d.LayerCfg[1].InputAlpha     = 0;

  /* initialize the DMA2D graphics accelerator */
  HAL_DMA2D_Init( &hdma2d );

  /* set the layer configurtation (foreground layer) */
  HAL_DMA2D_ConfigLayer( &hdma2d, 1 );

  /* set the flag for DMA2D transfer */
  TransferInProgress = 1;

#ifdef EW_USE_DMA2D_INTERRUPT_MODE

  /* start the transfer */
  HAL_DMA2D_Start_IT( &hdma2d, aSrcAddr, aDstAddr, aWidth, aHeight );

#else

  /* start the transfer */
  HAL_DMA2D_Start( &hdma2d, aSrcAddr, aDstAddr, aWidth, aHeight );

#endif

  /* check for immediate completion of drawing operation */
  if ( !ConcurrentOperation )
    EwBspGraphicsWaitForCompletion();
}


/*******************************************************************************
* FUNCTION:
*   EwBspGraphicsCopyBlend
*
* DESCRIPTION:
*   The function EwBspGraphicsCopyBlend is used by the Graphics Engine, when a
*   source bitmap should be blended over a destination bitmap by using the DMA2D
*   functionality.
*
* ARGUMENTS:
*   aDstAddr      - Destination address of the transfer.
*   aSrcAddr      - Source address of the transfer.
*   aDstOffset    - Offset in pixel to next row within the destination bitmap.
*   aSrcOffset    - Offset in pixel to next row within the source bitmap.
*   aWidth,
*   aHeight       - Size of the area to transfer the bitmap.
*   aDstColorMode - Colorformat of the destination bitmap
*   aSrcColorMode - Colorformat of the source bitmap.
*   aSrcColor     - Color/alpha value to be used for the transfer.
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspGraphicsCopyBlend( uint32_t aDstAddr, uint32_t aSrcAddr, uint32_t aDstOffset,
  uint32_t aSrcOffset, uint32_t aWidth, uint32_t aHeight, uint32_t aDstColorMode,
  uint32_t aSrcColorMode, uint32_t aSrcColor )
{
  /* ensure that previous DMA2D instruction is finished */
  EwBspGraphicsWaitForCompletion();

  /* prepare destination output configuration */
  hdma2d.Init.Mode                  = DMA2D_M2M_BLEND;
  hdma2d.Init.ColorMode             = aDstColorMode;
  hdma2d.Init.OutputOffset          = aDstOffset;

  /* prepare destination input configuration */
  hdma2d.LayerCfg[0].InputOffset    = aDstOffset;
  hdma2d.LayerCfg[0].InputColorMode = aDstColorMode;
  hdma2d.LayerCfg[0].AlphaMode      = DMA2D_NO_MODIF_ALPHA;
  hdma2d.LayerCfg[0].InputAlpha     = 0;

  /* prepare source input configuration */
  hdma2d.LayerCfg[1].InputOffset    = aSrcOffset;
  hdma2d.LayerCfg[1].InputColorMode = aSrcColorMode;

  if ( aSrcColorMode == DMA2D_INPUT_A8 )
  {
    hdma2d.LayerCfg[1].AlphaMode    = DMA2D_COMBINE_ALPHA;
    hdma2d.LayerCfg[1].InputAlpha   = aSrcColor;
  }
  else
  {
    unsigned char alpha = (unsigned char)( aSrcColor >> 24 );
    hdma2d.LayerCfg[1].AlphaMode = (alpha == 0xFF) ? DMA2D_NO_MODIF_ALPHA : DMA2D_COMBINE_ALPHA;
    hdma2d.LayerCfg[1].InputAlpha = alpha;
  }

  /* initialize the DMA2D graphics accelerator */
  HAL_DMA2D_Init( &hdma2d );

  /* set the layer configurtation (foreground layer) */
  HAL_DMA2D_ConfigLayer( &hdma2d, 1 );

  /* set the layer configurtation (background layer) */
  HAL_DMA2D_ConfigLayer( &hdma2d, 0 );

  /* set the flag for DMA2D transfer */
  TransferInProgress = 1;

#ifdef EW_USE_DMA2D_INTERRUPT_MODE

  /* start the transfer */
  HAL_DMA2D_BlendingStart_IT( &hdma2d, aSrcAddr, aDstAddr, aDstAddr, aWidth, aHeight );

#else

  /* start the transfer */
  HAL_DMA2D_BlendingStart( &hdma2d, aSrcAddr, aDstAddr, aDstAddr, aWidth, aHeight );

#endif

  /* check for immediate completion of drawing operation */
  if ( !ConcurrentOperation )
    EwBspGraphicsWaitForCompletion();
}


/*******************************************************************************
* FUNCTION:
*   EwBspGraphicsCopyWithClut
*
* DESCRIPTION:
*   The function EwBspGraphicsCopyWithClut is used by the Graphics Engine, when
*   a Index8 source bitmap should be copied into a destination bitmap by using
*   the DMA2D functionality. The colors of the source bitmap are stored within
*   the given CLUT.
*
* ARGUMENTS:
*   aDstAddr      - Destination address of the transfer.
*   aSrcAddr      - Source address of the transfer.
*   aDstOffset    - Offset in pixel to next row within the destination bitmap.
*   aSrcOffset    - Offset in pixel to next row within the source bitmap.
*   aWidth,
*   aHeight       - Size of the area to transfer the bitmap.
*   aDstColorMode - Colorformat of the destination bitmap
*   aClutAddr     - Address of the first color entry of the CLUT.
*   aClutSize     - Number of color entries within the CLUT.
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspGraphicsCopyWithClut( uint32_t aDstAddr, uint32_t aSrcAddr, uint32_t aDstOffset,
  uint32_t aSrcOffset, uint32_t aWidth, uint32_t aHeight, uint32_t aDstColorMode,
  uint32_t aClutAddr, uint32_t aClutSize )
{
  DMA2D_CLUTCfgTypeDef clutCfg;

  /* ensure that previous DMA2D instruction is finished */
  EwBspGraphicsWaitForCompletion();

  /* prepare destination output configuration */
  hdma2d.Init.Mode                  = DMA2D_M2M_PFC;
  hdma2d.Init.ColorMode             = aDstColorMode;
  hdma2d.Init.OutputOffset          = aDstOffset;

  /* prepare source input configuration */
  hdma2d.LayerCfg[1].InputOffset    = aSrcOffset;
  hdma2d.LayerCfg[1].InputColorMode = DMA2D_INPUT_L8;
  hdma2d.LayerCfg[1].AlphaMode      = DMA2D_NO_MODIF_ALPHA;
  hdma2d.LayerCfg[1].InputAlpha     = 0;

  /* prepare CLUT configuration */
  clutCfg.pCLUT         = (uint32_t*)aClutAddr;
  clutCfg.CLUTColorMode = DMA2D_CCM_ARGB8888;
  clutCfg.Size          = aClutSize - 1; /* size is expected as size - 1 ... */

  /* initialize the DMA2D graphics accelerator */
  HAL_DMA2D_Init( &hdma2d );

  /* set the layer configurtation (foreground layer) */
  HAL_DMA2D_ConfigLayer( &hdma2d, 1 );

  /* set the flag for CLUT transfer */
  TransferInProgress = 1;

#ifdef EW_USE_DMA2D_INTERRUPT_MODE

  /* start the transfer */
  HAL_DMA2D_CLUTLoad_IT( &hdma2d, clutCfg, 1 );

#else

  /* start the transfer */
  HAL_DMA2D_CLUTLoad( &hdma2d, clutCfg, 1 );

#endif

  /* wait for immediate completion of CLUT loading */
  EwBspGraphicsWaitForCompletion();

  /* set the flag for DMA2D transfer */
  TransferInProgress = 1;

#ifdef EW_USE_DMA2D_INTERRUPT_MODE

  /* start the transfer */
  HAL_DMA2D_Start_IT( &hdma2d, aSrcAddr, aDstAddr, aWidth, aHeight );

#else

  /* start the transfer */
  HAL_DMA2D_Start( &hdma2d, aSrcAddr, aDstAddr, aWidth, aHeight );

#endif

  /* check for immediate completion of drawing operation */
  if ( !ConcurrentOperation )
    EwBspGraphicsWaitForCompletion();
}

/* msy */

