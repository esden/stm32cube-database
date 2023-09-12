[#ftl]
  /**
  ******************************************************************************
  * @file    ew_bsp_graphics.h
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


#ifndef EW_BSP_GRAPHICS_H
#define EW_BSP_GRAPHICS_H

#include "${FamilyName?lower_case}xx_hal.h"

#ifdef __cplusplus
  extern "C"
  {
#endif


/*
  EW_USE_DMA2D_INTERRUPT_MODE - Flag to switch on/off the usage of the interrupt
  mode for the DMA2D (graphics accelerator).
  Per default, the usage of the interrupt mode is enabled. If the interrupt mode
  is swtched off, polling mode is used instead. To switch off the usage of the
  DMA2D interrupt mode, please set the macro EW_USE_DMA2D_INTERRUPT_MODE to 0
  within your makefile. This can be achieved by using the compiler flag
  -DEW_USE_DMA2D_INTERRUPT_MODE=0
*/
#ifndef EW_USE_DMA2D_INTERRUPT_MODE
  #define EW_USE_DMA2D_INTERRUPT_MODE 1
#endif

#if EW_USE_DMA2D_INTERRUPT_MODE == 0
  #undef EW_USE_DMA2D_INTERRUPT_MODE
#endif


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
int EwBspGraphicsInit
(
  uint32_t          aDstColorMode
);


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
void EwBspGraphicsDone( void );


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
void EwBspGraphicsWaitForCompletion( void );


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
void EwBspGraphicsConcurrentOperation
(
  int               aEnable
);


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
void EwBspGraphicsFill
(
  uint32_t          aDstAddr,
  uint32_t          aDstOffset,
  uint32_t          aWidth,
  uint32_t          aHeight,
  uint32_t          aDstColorMode,
  uint32_t          aSrcColor
);


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
void EwBspGraphicsFillBlend
(
  uint32_t          aDstAddr,
  uint32_t          aDstOffset,
  uint32_t          aWidth,
  uint32_t          aHeight,
  uint32_t          aDstColorMode,
  uint32_t          aSrcColor
);


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
void EwBspGraphicsCopy
(
  uint32_t          aDstAddr,
  uint32_t          aSrcAddr,
  uint32_t          aDstOffset,
  uint32_t          aSrcOffset,
  uint32_t          aWidth,
  uint32_t          aHeight,
  uint32_t          aDstColorMode,
  uint32_t          aSrcColorMode
);


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
void EwBspGraphicsCopyBlend
(
  uint32_t          aDstAddr,
  uint32_t          aSrcAddr,
  uint32_t          aDstOffset,
  uint32_t          aSrcOffset,
  uint32_t          aWidth,
  uint32_t          aHeight,
  uint32_t          aDstColorMode,
  uint32_t          aSrcColorMode,
  uint32_t          aSrcColor
);


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
void EwBspGraphicsCopyWithClut
(
  uint32_t          aDstAddr,
  uint32_t          aSrcAddr,
  uint32_t          aDstOffset,
  uint32_t          aSrcOffset,
  uint32_t          aWidth,
  uint32_t          aHeight,
  uint32_t          aDstColorMode,
  uint32_t          aClutAddr,
  uint32_t          aClutSize
);


#ifdef __cplusplus
  }
#endif

#endif /* EW_BSP_GRAPHICS_H */

