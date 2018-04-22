[#ftl]
/**
  ******************************************************************************
  * @file    STemWin_wrapper.c
  * @author  MCD Application Team
  * @version V1.0.0RC1
  * @date    19-June-2017
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

/* Includes ------------------------------------------------------------------*/
#include "STemWin_wrapper.h"
#include "GUI_Private.h"
#include "WM.h"

/** @addtogroup LCD CONFIGURATION
* @{
*/

/** @defgroup LCD CONFIGURATION
* @brief This file contains the LCD Configuration
* @{
*/ 

/** @defgroup LCD CONFIGURATION_Private_TypesDefinitions
* @{
*/ 
/**
* @}
*/ 

/** @defgroup LCD CONFIGURATION_Private_Defines
* @{
*/ 

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
        [#if definition.name = "GUI_NUM_LAYERS" ]
[#if definition.value == "2" ]
[#assign layers="1"] 
[/#if]

[#-- ELSE IF --]
[#elseif definition.name = "Xsize_PHYS"]
#define XSIZE_PHYS  #t#t ${definition.value} 
[#-- ELSE IF --]
[#elseif definition.name = "Ysize_PHYS"]
#define YSIZE_PHYS  #t#t ${definition.value} 

 [#-- ELSE IF --]
[#elseif definition.name = "Num_MultBuffers"]
#define NUM_BUFFERS     #t#t ${definition.value}  /* Number of multiple buffers to be used */
[#-- ELSE IF --]
[#elseif definition.name = "Num_VScreens"]
#define NUM_VSCREENS    #t#t ${definition.value}  /* Number of virtual screens to be used */

[#-- ELSE IF --]
[#elseif definition.name = "LIN_Color_Conversion_Layer0"]
#define COLOR_CONVERSION_0  #t#t ${definition.value}
[#-- ELSE IF --]
[#elseif definition.name = "LIN_Display_Driver_Layer0"]
#define DISPLAY_DRIVER_0   #t#t ${definition.value}


[#-- ELSE IF --]
[#elseif definition.name = "LIN_Color_Conversion_Layer1"]
[#if layers?? &&  layers== "1" ]
#define COLOR_CONVERSION_1  #t#t ${definition.value}
[/#if]
[#-- ELSE IF --]
[#elseif definition.name = "LIN_Display_Driver_Layer1"]
[#if layers?? &&  layers== "1" ]
#define DISPLAY_DRIVER_1    #t#t ${definition.value}
[/#if]
/* From SDRAM */
[#-- ELSE IF --]
[#elseif definition.name = "Frame_Buffer_StartAddress_Layer0_DPI_DSI"]
#define LCD_LAYER0_FRAME_BUFFER   #t#t ((uint32_t)${definition.value})
[#-- ELSE IF --]
[#elseif definition.name = "Frame_Buffer_StartAddress_Layer1_DPI_DSI"]
[#if layers?? &&  layers== "1" ]
#define LCD_LAYER1_FRAME_BUFFER   #t#t ((uint32_t)${definition.value})
[/#if]

[#-- ELSE IF --]
[#elseif definition.name = "RefreshCount_SDRAM"]
[#if definition.value != "0" ]
#define REFRESH_COUNT   #t#t ${definition.value}

#define SDRAM_TIMEOUT                    		 ((uint32_t)0xFFFF)
#define SDRAM_MODEREG_BURST_LENGTH_1             ((uint16_t)0x0000)
#define SDRAM_MODEREG_BURST_LENGTH_2             ((uint16_t)0x0001)
#define SDRAM_MODEREG_BURST_LENGTH_4             ((uint16_t)0x0002)
#define SDRAM_MODEREG_BURST_LENGTH_8             ((uint16_t)0x0004)
#define SDRAM_MODEREG_BURST_TYPE_SEQUENTIAL      ((uint16_t)0x0000)
#define SDRAM_MODEREG_BURST_TYPE_INTERLEAVED     ((uint16_t)0x0008)
#define SDRAM_MODEREG_CAS_LATENCY_2              ((uint16_t)0x0020)
#define SDRAM_MODEREG_CAS_LATENCY_3              ((uint16_t)0x0030)
#define SDRAM_MODEREG_OPERATING_MODE_STANDARD    ((uint16_t)0x0000)
#define SDRAM_MODEREG_WRITEBURST_MODE_PROGRAMMED ((uint16_t)0x0000) 
#define SDRAM_MODEREG_WRITEBURST_MODE_SINGLE     ((uint16_t)0x0200) 
[/#if]

/** @defgroup LCD CONFIGURATION_Private_Variables
* @{
*/
extern LTDC_HandleTypeDef            hltdc;  
[#-- ELSE IF --]
[#elseif definition.name = "Use_SDRAM"]

  [#if definition.value == "SDRAM1_BANK1" | definition.value == "SDRAM2_BANK1"  ]
  [#assign UseSDRAM="1"] 
  [#assign AutoRefreshNumber ="8"] 
  [#assign sdramBank ="FMC_SDRAM_CMD_TARGET_BANK1"] 
   [/#if]
   [#if definition.value == "SDRAM1_BANK2" |  definition.value == "SDRAM2_BANK2" ]
   [#assign UseSDRAM="1"] 
   [#assign AutoRefreshNumber ="4"] 
   [#assign sdramBank ="FMC_SDRAM_CMD_TARGET_BANK2"] 
   [/#if]
      
   [#if UseSDRAM?? && UseSDRAM=="1" ]
        [#if definition.value == "SDRAM1_BANK1" | definition.value == "SDRAM1_BANK2"]
                    [#assign  hsdramvalue="hsdram1"]
              extern SDRAM_HandleTypeDef hsdram1;
          [/#if]
         [#if definition.value == "SDRAM2_BANK1" | definition.value == "SDRAM2_BANK2"]
                               [#assign  hsdramvalue="hsdram2"]
               extern SDRAM_HandleTypeDef hsdram2;
            [/#if]
   extern FMC_SDRAM_TimingTypeDef SdramTiming;
    static FMC_SDRAM_CommandTypeDef Command;
[/#if]
static LCD_LayerPropTypedef          layer_prop[GUI_NUM_LAYERS];

static const LCD_API_COLOR_CONV * apColorConvAPI[] = 
{
  COLOR_CONVERSION_0,
#if GUI_NUM_LAYERS > 1
  COLOR_CONVERSION_1,
#endif
};

/**
* @}
*/ 

/** @defgroup LCD CONFIGURATION_Private_FunctionPrototypes
* @{
*/ 
[#-- ELSE IF --]
[#elseif definition.name = "DMA2D_Graphics"]
[#if definition.value != "0" ]
[#assign dma2d="1"] 
static void     DMA2D_CopyBufferWithAlpha(U32 LayerIndex, void * pSrc, void * pDst, U32 xSize, U32 ySize, U32 OffLineSrc, U32 OffLineDst);
static void     DMA2D_CopyBuffer         (U32 LayerIndex, void * pSrc, void * pDst, U32 xSize, U32 ySize, U32 OffLineSrc, U32 OffLineDst);
static void     DMA2D_FillBuffer(U32 LayerIndex, void * pDst, U32 xSize, U32 ySize, U32 OffLine, U32 ColorIndex);

static void     CUSTOM_CopyBuffer(int LayerIndex, int IndexSrc, int IndexDst);
static void     CUSTOM_CopyRect(int LayerIndex, int x0, int y0, int x1, int y1, int xSize, int ySize);
static void     CUSTOM_FillRect(int LayerIndex, int x0, int y0, int x1, int y1, U32 PixelIndex);
static void     CUSTOM_DrawBitmap8bpp(int LayerIndex, int x, int y, U8 const * p, int xSize, int ySize, int BytesPerLine);
static void     CUSTOM_DrawBitmap16bpp(int LayerIndex, int x, int y, U16 const * p, int xSize, int ySize, int BytesPerLine);
static void     CUSTOM_DrawBitmap32bpp(int LayerIndex, int x, int y, U8 const * p,  int xSize, int ySize, int BytesPerLine);
static U32      GetBufferSize(U32 LayerIndex);
/**
* @}
*/ 

/**
  * @brief  Return Pixel format for a given layer
  * @param  LayerIndex : Layer Index 
  * @retval Status ( 0 : 0k , 1: error)
  */
static U32 GetPixelformat(U32 LayerIndex) {
  

  if (LayerIndex >= GUI_COUNTOF(apColorConvAPI)) {
    return 0;
  }

  if ((apColorConvAPI[LayerIndex] == GUICC_M8888I)| (apColorConvAPI[LayerIndex] == GUICC_M8888)|(apColorConvAPI[LayerIndex] == GUICC_8888))
  {
    return LTDC_PIXEL_FORMAT_ARGB8888;
  } else if ( (apColorConvAPI[LayerIndex] == GUICC_M888) | (apColorConvAPI[LayerIndex] == GUICC_888)   ) {
    return LTDC_PIXEL_FORMAT_RGB888;
  } else if ( (apColorConvAPI[LayerIndex] == GUICC_565) | (apColorConvAPI[LayerIndex] == GUICC_M565) ) {
    return LTDC_PIXEL_FORMAT_RGB565;
  } else if (apColorConvAPI[LayerIndex] == GUICC_M1555I) {
    return LTDC_PIXEL_FORMAT_ARGB1555;
  } else if (apColorConvAPI[LayerIndex] == GUICC_M4444I) {
    return LTDC_PIXEL_FORMAT_ARGB4444;
  } else if ( (apColorConvAPI[LayerIndex] == GUICC_822216) | (apColorConvAPI[LayerIndex] == GUICC_84444) | (apColorConvAPI[LayerIndex] == GUICC_8666) |  (apColorConvAPI[LayerIndex]== GUICC_8666_1)) {
    return LTDC_PIXEL_FORMAT_L8;
  } else if (apColorConvAPI[LayerIndex] == GUICC_1616I ) {
    return LTDC_PIXEL_FORMAT_AL44;
  } else if (apColorConvAPI[LayerIndex] == GUICC_88666I) {
    return LTDC_PIXEL_FORMAT_AL88;
  }
  while (1); // Error
} 

/*********************************************************************
*
*       CopyBuffer
*/
static void DMA2D_CopyBufferWithAlpha(U32 LayerIndex, void * pSrc, void * pDst, U32 xSize, U32 ySize, U32 OffLineSrc, U32 OffLineDst)
{
  uint32_t PixelFormat;
  
  PixelFormat = GetPixelformat(LayerIndex);
  DMA2D->CR      = 0x00000000UL | (1 << 9) | (0x2 << 16);   
  
  /* Set up pointers */
  DMA2D->FGMAR   = (U32)pSrc;                       
  DMA2D->OMAR    = (U32)pDst;                       
  DMA2D->BGMAR   = (U32)pDst; 
  DMA2D->FGOR    = OffLineSrc;                      
  DMA2D->OOR     = OffLineDst; 
  DMA2D->BGOR     = OffLineDst; 
  
  /* Set up pixel format */  
  DMA2D->FGPFCCR = LTDC_PIXEL_FORMAT_ARGB8888;  
  DMA2D->BGPFCCR = PixelFormat;
  DMA2D->OPFCCR = PixelFormat;
  
  /*  Set up size */
  DMA2D->NLR     = (U32)(xSize << 16) | (U16)ySize; 
  
  DMA2D->CR     |= DMA2D_CR_START;   
  
  /* Wait until transfer is done */
  while (DMA2D->CR & DMA2D_CR_START) 
  {
  }
}

static void DMA2D_CopyBuffer(U32 LayerIndex, void * pSrc, void * pDst, U32 xSize, U32 ySize, U32 OffLineSrc, U32 OffLineDst)
{
  U32 PixelFormat;

  PixelFormat = GetPixelformat(LayerIndex);
  DMA2D->CR      = 0x00000000UL | (1 << 9);  
  	
  /* Set up pointers */
  DMA2D->FGMAR   = (U32)pSrc;                       
  DMA2D->OMAR    = (U32)pDst;                       
  DMA2D->FGOR    = OffLineSrc;                      
  DMA2D->OOR     = OffLineDst; 
  
  /* Set up pixel format */  
  DMA2D->FGPFCCR = PixelFormat;  
  
  /*  Set up size */
  DMA2D->NLR     = (U32)(xSize << 16) | (U16)ySize; 
  
  DMA2D->CR     |= DMA2D_CR_START;   
 
  /* Wait until transfer is done */
  while (DMA2D->CR & DMA2D_CR_START) 
  {
  }
}

/**
  * @brief  Fill Buffer
  * @param  LayerIndex : Layer Index
  * @param  pDst:        pointer to destination
  * @param  xSize:       X size
  * @param  ySize:       Y size
  * @param  OffLine:     offset after each line
  * @param  ColorIndex:  color to be used.           
  * @retval None.
  */
static void DMA2D_FillBuffer(U32 LayerIndex, void * pDst, U32 xSize, U32 ySize, U32 OffLine, U32 ColorIndex) 
{

  U32 PixelFormat;

  PixelFormat = LCD_LL_GetPixelformat(LayerIndex);
	
  /* Set up mode */
  DMA2D->CR      = 0x00030000UL | (1 << 9);        
  DMA2D->OCOLR   = ColorIndex;                     

  /* Set up pointers */
  DMA2D->OMAR    = (U32)pDst;                      

  /* Set up offsets */
  DMA2D->OOR     = OffLine;                        

  /* Set up pixel format */
  DMA2D->OPFCCR  = PixelFormat;                    

  /*  Set up size */
  DMA2D->NLR     = (U32)(xSize << 16) | (U16)ySize;
    
  DMA2D->CR     |= DMA2D_CR_START; 
  
  /* Wait until transfer is done */
  while (DMA2D->CR & DMA2D_CR_START) 
  {
  }
}


/**
  * @brief  Get buffer size
  * @param  LayerIndex : Layer Index           
  * @retval None.
  */
static U32 GetBufferSize(U32 LayerIndex) 
{
  U32 BufferSize;

  BufferSize = layer_prop[LayerIndex].xSize * layer_prop[LayerIndex].ySize * layer_prop[LayerIndex].BytesPerPixel;
  return BufferSize;
}

/**
  * @brief  Customized copy buffer
  * @param  LayerIndex : Layer Index
  * @param  IndexSrc:    index source
  * @param  IndexDst:    index destination           
  * @retval None.
  */
static void CUSTOM_CopyBuffer(int LayerIndex, int IndexSrc, int IndexDst) {
  U32 BufferSize, AddrSrc, AddrDst;

  BufferSize = GetBufferSize(LayerIndex);
  AddrSrc    = layer_prop[LayerIndex].address + BufferSize * IndexSrc;
  AddrDst    = layer_prop[LayerIndex].address + BufferSize * IndexDst;
  DMA2D_CopyBuffer(LayerIndex, (void *)AddrSrc, (void *)AddrDst, layer_prop[LayerIndex].xSize, layer_prop[LayerIndex].ySize, 0, 0);
  layer_prop[LayerIndex].buffer_index = IndexDst;
}

/**
  * @brief  Copy rectangle
  * @param  LayerIndex : Layer Index
  * @param  x0:          X0 position
  * @param  y0:          Y0 position
  * @param  x1:          X1 position
  * @param  y1:          Y1 position
  * @param  xSize:       X size. 
  * @param  ySize:       Y size.            
  * @retval None.
  */
static void CUSTOM_CopyRect(int LayerIndex, int x0, int y0, int x1, int y1, int xSize, int ySize) 
{
  U32 AddrSrc, AddrDst;  

  AddrSrc = layer_prop[LayerIndex].address + (y0 * layer_prop[LayerIndex].xSize + x0) * layer_prop[LayerIndex].BytesPerPixel;
  AddrDst = layer_prop[LayerIndex].address + (y1 * layer_prop[LayerIndex].xSize + x1) * layer_prop[LayerIndex].BytesPerPixel;
  DMA2D_CopyBuffer(LayerIndex, (void *)AddrSrc, (void *)AddrDst, xSize, ySize, layer_prop[LayerIndex].xSize - xSize, layer_prop[LayerIndex].xSize - xSize);
}

/**
  * @brief  Fill rectangle
  * @param  LayerIndex : Layer Index
  * @param  x0:          X0 position
  * @param  y0:          Y0 position
  * @param  x1:          X1 position
  * @param  y1:          Y1 position
  * @param  PixelIndex:  Pixel index.             
  * @retval None.
  */
static void CUSTOM_FillRect(int LayerIndex, int x0, int y0, int x1, int y1, U32 PixelIndex) 
{
  U32 BufferSize, AddrDst;
  int xSize, ySize;


  if (GUI_GetDrawMode() == GUI_DM_XOR) 
  {		
    LCD_SetDevFunc(LayerIndex, LCD_DEVFUNC_FILLRECT, NULL);
    LCD_FillRect(x0, y0, x1, y1);
    LCD_SetDevFunc(LayerIndex, LCD_DEVFUNC_FILLRECT, (void(*)(void))CUSTOM_FillRect);
  } 
  else 
  {
    xSize = x1 - x0 + 1;
    ySize = y1 - y0 + 1;
    BufferSize = GetBufferSize(LayerIndex);
		AddrDst = layer_prop[LayerIndex].address + BufferSize * layer_prop[LayerIndex].buffer_index + (y0 * layer_prop[LayerIndex].xSize + x0) * layer_prop[LayerIndex].BytesPerPixel;
    DMA2D_FillBuffer(LayerIndex, (void *)AddrDst, xSize, ySize, layer_prop[LayerIndex].xSize - xSize, PixelIndex);
	}
}


/**
* @brief  Draw 8bpp bitmap file
* @param  LayerIndex: Layer Index
* @param  x:          X position
* @param  y:          Y position
* @param  p:          pointer to destination address 
* @param  xSize:      X size
* @param  ySize:      Y size
* @param  BytesPerLine
* @retval None
*/
static void CUSTOM_DrawBitmap8bpp(int LayerIndex, int x, int y, U8 const * p, int xSize, int ySize, int BytesPerLine)
{
  U32 BufferSize, AddrDst;
  int OffLineSrc, OffLineDst;
  U32 PixelFormat;
  
  BufferSize = GetBufferSize(LayerIndex);
  AddrDst = layer_prop[LayerIndex].address + BufferSize * layer_prop[LayerIndex].buffer_index + (y * layer_prop[LayerIndex].xSize + x) * layer_prop[LayerIndex].BytesPerPixel;
  OffLineSrc = BytesPerLine - xSize;
  OffLineDst = layer_prop[LayerIndex].xSize - xSize;
  PixelFormat = GetPixelformat(LayerIndex);
  DMA2D_DrawBitmapL8((void *)p, (void *)AddrDst, OffLineSrc, OffLineDst, PixelFormat, xSize, ySize);
}

/**
* @brief  Draw 16bpp bitmap file
* @param  LayerIndex: Layer Index
* @param  x:          X position
* @param  y:          Y position
* @param  p:          pointer to destination address
* @param  xSize:      X size
* @param  ySize:      Y size
* @param  BytesPerLine
* @retval None
*/


static void CUSTOM_DrawBitmap16bpp(int LayerIndex, int x, int y, U16 const * p, int xSize, int ySize, int BytesPerLine)
{
  U32 BufferSize, AddrDst;
  int OffLineSrc, OffLineDst;
  
  BufferSize = GetBufferSize(LayerIndex);
  AddrDst = layer_prop[LayerIndex].address + BufferSize * layer_prop[LayerIndex].buffer_index + (y * layer_prop[LayerIndex].xSize + x) * layer_prop[LayerIndex].BytesPerPixel;
  OffLineSrc = (BytesPerLine / 2) - xSize;
  OffLineDst = layer_prop[LayerIndex].xSize - xSize;
  DMA2D_CopyBuffer(LayerIndex, (void *)p, (void *)AddrDst, xSize, ySize, OffLineSrc, OffLineDst);
}

/**
  * @brief  Draw indirect color bitmap
  * @param  pSrc: pointer to the source
  * @param  pDst: pointer to the destination
  * @param  OffSrc: offset source
  * @param  OffDst: offset destination
  * @param  PixelFormatDst: pixel format for destination
  * @param  xSize: X size
  * @param  ySize: Y size
  * @retval None
  */
static void CUSTOM_DrawBitmap32bpp(int LayerIndex, int x, int y, U8 const * p, int xSize, int ySize, int BytesPerLine)
{
  U32 BufferSize, AddrDst;
  int OffLineSrc, OffLineDst;

  BufferSize = GetBufferSize(LayerIndex);
  AddrDst = layer_prop[LayerIndex].address + BufferSize * layer_prop[LayerIndex].buffer_index + (y * layer_prop[LayerIndex].xSize + x) * layer_prop[LayerIndex].BytesPerPixel;
  OffLineSrc = (BytesPerLine / 4) - xSize;
  OffLineDst = layer_prop[LayerIndex].xSize - xSize;
  DMA2D_CopyBuffer(LayerIndex, (void *)p, (void *)AddrDst, xSize, ySize, OffLineSrc, OffLineDst);
}

[/#if]
/**
  * @brief  Line Event callback.
  * @param  hltdc: pointer to a LTDC_HandleTypeDef structure that contains
  *                the configuration information for the specified LTDC.
  * @retval None
  */
void HAL_LTDC_LineEvenCallback(LTDC_HandleTypeDef *hltdc) {
  U32 Addr;
  U32 layer;

  for (layer = 0; layer < GUI_NUM_LAYERS; layer++)
  {
    if (layer_prop[layer].pending_buffer >= 0) 
    {
      /* Calculate address of buffer to be used  as visible frame buffer */
      Addr = layer_prop[layer].address + \
             layer_prop[layer].xSize * layer_prop[layer].ySize * layer_prop[layer].pending_buffer * layer_prop[layer].BytesPerPixel;
      
      __HAL_LTDC_LAYER(hltdc, layer)->CFBAR = Addr;
     
      __HAL_LTDC_RELOAD_CONFIG(hltdc);
      
      /* Notify STemWin that buffer is used */
      GUI_MULTIBUF_ConfirmEx(layer, layer_prop[layer].pending_buffer);

      /* Clear pending buffer flag of layer */
      layer_prop[layer].pending_buffer = -1;
    }
  }
  
  HAL_LTDC_ProgramLineEvent(hltdc, 0);
}

/*******************************************************************************
                          Display configuration
*******************************************************************************/
/**
  * @brief  Called during the initialization process in order to set up the
  *          display driver configuration
  * @param  None
  * @retval None
  */
void LCD_X_Config(void) 
{
  U32 i;

  /* At first initialize use of multiple buffers on demand */
#if (NUM_BUFFERS > 1)
    for (i = 0; i < GUI_NUM_LAYERS; i++) 
    {
      GUI_MULTIBUF_ConfigEx(i, NUM_BUFFERS);
    }
#endif

  /* Set display driver and color conversion for 1st layer */
  GUI_DEVICE_CreateAndLink(DISPLAY_DRIVER_0, COLOR_CONVERSION_0, 0, 0);
  
  /* Set size of 1st layer */
  if (LCD_GetSwapXYEx(0)) {
    LCD_SetSizeEx (0, YSIZE_PHYS, XSIZE_PHYS);
    LCD_SetVSizeEx(0, YSIZE_PHYS * NUM_VSCREENS, XSIZE_PHYS);
  } else {
    LCD_SetSizeEx (0, XSIZE_PHYS, YSIZE_PHYS);
    LCD_SetVSizeEx(0, XSIZE_PHYS, YSIZE_PHYS * NUM_VSCREENS);
  }
  #if (GUI_NUM_LAYERS > 1)
    
    /* Set display driver and color conversion for 2nd layer */
    GUI_DEVICE_CreateAndLink(DISPLAY_DRIVER_1, COLOR_CONVERSION_1, 0, 1);
    
    /* Set size of 2nd layer */
    if (LCD_GetSwapXYEx(1)) {
      LCD_SetSizeEx (1, YSIZE_PHYS, XSIZE_PHYS);
      LCD_SetVSizeEx(1, YSIZE_PHYS * NUM_VSCREENS, XSIZE_PHYS);
    } else {
      LCD_SetSizeEx (1, XSIZE_PHYS, YSIZE_PHYS);
      LCD_SetVSizeEx(1, XSIZE_PHYS, YSIZE_PHYS * NUM_VSCREENS);
    }
  #endif
  
    
    /*Initialize GUI Layer structure */
    layer_prop[0].address = LCD_LAYER0_FRAME_BUFFER;
    
#if (GUI_NUM_LAYERS > 1)
    layer_prop[1].address = LCD_LAYER1_FRAME_BUFFER; 
#endif
       
   /* Setting up VRam address and custom functions for CopyBuffer-, CopyRect- and FillRect operations */
  for (i = 0; i < GUI_NUM_LAYERS; i++) 
  {

    layer_prop[i].pColorConvAPI = (LCD_API_COLOR_CONV *)apColorConvAPI[i];
     
    layer_prop[i].pending_buffer = -1;

    /* Set VRAM address */
    LCD_SetVRAMAddrEx(i, (void *)(layer_prop[i].address));

    /* Remember color depth for further operations */
    layer_prop[i].BytesPerPixel = LCD_GetBitsPerPixelEx(i) >> 3;
 [#if dma2d?? && dma2d=="1" ]

    /* Set custom functions for several operations */
    LCD_SetDevFunc(i, LCD_DEVFUNC_COPYBUFFER, (void(*)(void))CUSTOM_CopyBuffer);
    LCD_SetDevFunc(i, LCD_DEVFUNC_COPYRECT,   (void(*)(void))CUSTOM_CopyRect);
    LCD_SetDevFunc(i, LCD_DEVFUNC_FILLRECT, (void(*)(void))CUSTOM_FillRect);

    /* Set up drawing routine for 32bpp bitmap using DMA2D */
    if (LCD_LL_GetPixelformat(i) == LTDC_PIXEL_FORMAT_ARGB8888) {
     LCD_SetDevFunc(i, LCD_DEVFUNC_DRAWBMP_32BPP, (void(*)(void))CUSTOM_DrawBitmap32bpp);     /* Set up drawing routine for 32bpp bitmap using DMA2D. Makes only sense with ARGB8888 */
     LCD_SetDevFunc(i, LCD_DEVFUNC_DRAWBMP_16BPP, (void(*)(void))CUSTOM_DrawBitmap16bpp);     /* Set up drawing routine for 16bpp bitmap using DMA2D. Makes only sense with ARGB8888 */
     LCD_SetDevFunc(i, LCD_DEVFUNC_DRAWBMP_8BPP, (void(*)(void))CUSTOM_DrawBitmap8bpp);     /* Set up drawing routine for 8bpp bitmap using DMA2D. Makes only sense with ARGB8888 */
    }   
 [/#if]
  
  }
}

/**
  * @brief  This function is called by the display driver for several purposes.
  *         To support the according task the routine needs to be adapted to
  *         the display controller. Please note that the commands marked with
  *         'optional' are not cogently required and should only be adapted if
  *         the display controller supports these features
  * @param  LayerIndex: Index of layer to be configured 
  * @param  Cmd       :Please refer to the details in the switch statement below
  * @param  pData     :Pointer to a LCD_X_DATA structure
  * @retval Status (-1 : Error,  0 : Ok)
  */
int LCD_X_DisplayDriver(unsigned LayerIndex, unsigned Cmd, void * pData) 
{
  int r = 0;
  U32 addr;
  int xPos, yPos;
  U32 Color;
    
  switch (Cmd) 
  {
  case LCD_X_INITCONTROLLER: 
  MX_LCD_Init();

[#if dma2d?? && dma2d=="1" ]
 MX_DMA2D_Init();
 [/#if]


    break;

  case LCD_X_SETORG: 
    addr = layer_prop[LayerIndex].address + ((LCD_X_SETORG_INFO *)pData)->yPos * layer_prop[LayerIndex].xSize * layer_prop[LayerIndex].BytesPerPixel;
    HAL_LTDC_SetAddress(&hltdc, addr, LayerIndex);
    break;

  case LCD_X_SHOWBUFFER: 
    layer_prop[LayerIndex].pending_buffer = ((LCD_X_SHOWBUFFER_INFO *)pData)->Index;
    break;

  case LCD_X_SETLUTENTRY: 
    HAL_LTDC_ConfigCLUT(&hltdc, (uint32_t *)&(((LCD_X_SETLUTENTRY_INFO *)pData)->Color), 1, LayerIndex);
    break;

  case LCD_X_ON: 
    __HAL_LTDC_ENABLE(&hltdc);
    break;

  case LCD_X_OFF: 
    __HAL_LTDC_DISABLE(&hltdc);
    break;
    
  case LCD_X_SETVIS:
    if(((LCD_X_SETVIS_INFO *)pData)->OnOff  == ENABLE )
    {
      __HAL_LTDC_LAYER_ENABLE(&hltdc, LayerIndex); 
    }
    else
    {
      __HAL_LTDC_LAYER_DISABLE(&hltdc, LayerIndex); 
    }
    __HAL_LTDC_RELOAD_CONFIG(&hltdc); 
    break;
    
  case LCD_X_SETPOS: 
    HAL_LTDC_SetWindowPosition(&hltdc, 
                               ((LCD_X_SETPOS_INFO *)pData)->xPos, 
                               ((LCD_X_SETPOS_INFO *)pData)->yPos, 
                               LayerIndex);
    break;

  case LCD_X_SETSIZE:
    GUI_GetLayerPosEx(LayerIndex, &xPos, &yPos);
    layer_prop[LayerIndex].xSize = ((LCD_X_SETSIZE_INFO *)pData)->xSize;
    layer_prop[LayerIndex].ySize = ((LCD_X_SETSIZE_INFO *)pData)->ySize;
    HAL_LTDC_SetWindowPosition(&hltdc, xPos, yPos, LayerIndex);
    break;

  case LCD_X_SETALPHA:
    HAL_LTDC_SetAlpha(&hltdc, ((LCD_X_SETALPHA_INFO *)pData)->Alpha, LayerIndex);
    break;

  case LCD_X_SETCHROMAMODE:
    if(((LCD_X_SETCHROMAMODE_INFO *)pData)->ChromaMode != 0)
    {
      HAL_LTDC_EnableColorKeying(&hltdc, LayerIndex);
    }
    else
    {
      HAL_LTDC_DisableColorKeying(&hltdc, LayerIndex);      
    }
    break;

  case LCD_X_SETCHROMA:

    Color = ((((LCD_X_SETCHROMA_INFO *)pData)->ChromaMin & 0xFF0000) >> 16) |\
             (((LCD_X_SETCHROMA_INFO *)pData)->ChromaMin & 0x00FF00) |\
            ((((LCD_X_SETCHROMA_INFO *)pData)->ChromaMin & 0x0000FF) << 16);
    
    HAL_LTDC_ConfigColorKeying(&hltdc, Color, LayerIndex);
    break;

  default:
    r = -1;
  }
  return r;
}

[#if   UseSDRAM?? && UseSDRAM!="0"    ]
 
/**
  * @brief  Programs the SDRAM device.
  * @retval None
  */
void SDRAM_Initialization_sequence(void)
{
  __IO uint32_t tmpmrd = 0;
  
  /* Step 1: Configure a clock configuration enable command */
  Command.CommandMode            = FMC_SDRAM_CMD_CLK_ENABLE;
  Command.CommandTarget          =  ${sdramBank};
  Command.AutoRefreshNumber      = 1;
  Command.ModeRegisterDefinition = 0;

  /* Send the command */
  HAL_SDRAM_SendCommand(&${hsdramvalue}, &Command, SDRAM_TIMEOUT);

  /* Step 2: Insert 100 us minimum delay */ 
  /* Inserted delay is equal to 1 ms due to systick time base unit (ms) */
  HAL_Delay(1);
    
  /* Step 3: Configure a PALL (precharge all) command */ 
  Command.CommandMode            = FMC_SDRAM_CMD_PALL;
  Command.CommandTarget          = ${sdramBank};
  Command.AutoRefreshNumber      = 1;
  Command.ModeRegisterDefinition = 0;

  /* Send the command */
  HAL_SDRAM_SendCommand(&${hsdramvalue}, &Command, SDRAM_TIMEOUT);  
  
  /* Step 4: Configure an Auto Refresh command */ 
  Command.CommandMode            = FMC_SDRAM_CMD_AUTOREFRESH_MODE;
  Command.CommandTarget          = ${sdramBank};
  Command.AutoRefreshNumber      = ${AutoRefreshNumber};
  Command.ModeRegisterDefinition = 0;

  /* Send the command */
  HAL_SDRAM_SendCommand(&${hsdramvalue}, &Command, SDRAM_TIMEOUT);
  
  /* Step 5: Program the external memory mode register */
  tmpmrd = (uint32_t)SDRAM_MODEREG_BURST_LENGTH_1          |\
                     SDRAM_MODEREG_BURST_TYPE_SEQUENTIAL   |\
                     SDRAM_MODEREG_CAS_LATENCY_3           |\
                     SDRAM_MODEREG_OPERATING_MODE_STANDARD |\
                     SDRAM_MODEREG_WRITEBURST_MODE_SINGLE;

  Command.CommandMode            = FMC_SDRAM_CMD_LOAD_MODE;
  Command.CommandTarget          = ${sdramBank};
  Command.AutoRefreshNumber      = 1;
  Command.ModeRegisterDefinition = tmpmrd;

  /* Send the command */
  HAL_SDRAM_SendCommand(&${hsdramvalue}, &Command, SDRAM_TIMEOUT);
  
  /* Step 6: Set the refresh rate counter */
  /* Set the device refresh rate */
  HAL_SDRAM_ProgramRefreshRate(&${hsdramvalue}, REFRESH_COUNT); 
}
[/#if]
void GRAPHICS_Init(void)
{
[#if UseSDRAM?? &&  UseSDRAM=="1" ]

  /* Init the memory used by the LCD Frame buffer */
/* Initializes the SDRAM device */
  MX_FMC_Init(); 
  SDRAM_Initialization_sequence();
  
[/#if]
[#if UseSDRAM?? &&  UseSDRAM =="0" ]

 /* Init the memory used by the LCD Frame buffer */
/* Initializes the SDRAM device */
[/#if]

[/#if]
[/#list]
[/#if]
[/#list]

  /* Initialize the GUI */
  GUI_Init();

[#if multipleBuffers?? &&  multipleBuffers =="1" ]
  /* Enable the multi-buffering functionality */
  //WM_MULTIBUF_Enable(1);
  [/#if]

  /* Activate the use of memory device feature */
  WM_SetCreateFlags(WM_CF_MEMDEV);
}
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
