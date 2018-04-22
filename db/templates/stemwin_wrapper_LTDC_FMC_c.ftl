[#ftl]
  /**
  ******************************************************************************
  * @file    STemWin_wrapper.c
  * @author  MCD Application Team
  * @brief   This file implements the configuration for the GUI library
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
[#assign layers="0"]
[#assign XsizePHYS="0"]
[#assign YSIZEPHYS="0"]
[#assign NUM_BUFFERS="0"]
[#assign multipleBuffers="0"]
[#assign Num_VScreens="0"]
[#assign LIN_Color_Conversion_Layer0="0"]
[#assign LIN_Display_Driver_Layer0="0"]
[#assign LIN_Color_Conversion_Layer1="0"]
[#assign LIN_Display_Driver_Layer1="0"]
[#assign Frame_Buffer_StartAddress_Layer0_DPI_DSI="0"]
[#assign Frame_Buffer_StartAddress_Layer1_DPI_DSI="0"]
[#assign dma2d="0"]
[#assign useIli9341="0"]
[#assign OTM="0"]
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
[#assign layers = "1"] 
[/#if]

[#-- ELSE IF --]
[#elseif definition.name = "Xsize_PHYS"]
[#assign XsizePHYS = definition.value ] 

[#-- ELSE IF --]
[#elseif definition.name = "Ysize_PHYS"]
[#assign YSIZEPHYS = definition.value] 

[#-- ELSE IF --]
[#elseif definition.name = "Num_MultBuffers"]
[#assign NUM_BUFFERS = definition.value] 
[#if definition.value =="2" || definition.value =="3"   ]
[#assign multipleBuffers = "1"]
[/#if]

[#-- ELSE IF --]
[#elseif definition.name = "Num_VScreens"]
[#assign Num_VScreens = definition.value] 

[#-- ELSE IF --]
[#elseif definition.name = "LIN_Color_Conversion_Layer0"]
[#assign LIN_Color_Conversion_Layer0 = definition.value] 

[#-- ELSE IF --]
[#elseif definition.name = "LIN_Display_Driver_Layer0"]
[#assign LIN_Display_Driver_Layer0 = definition.value] 

[#-- ELSE IF --]
[#elseif definition.name = "LIN_Color_Conversion_Layer1"]
[#assign LIN_Color_Conversion_Layer1 = definition.value] 


[#-- ELSE IF --]
[#elseif definition.name = "LIN_Display_Driver_Layer1"]
[#assign LIN_Display_Driver_Layer1 = definition.value] 


[#-- ELSE IF --]
[#elseif definition.name = "Frame_Buffer_StartAddress_Layer0_DPI_DSI"]
[#assign Frame_Buffer_StartAddress_Layer0_DPI_DSI = definition.value] 

[#-- ELSE IF --]
[#elseif definition.name = "Frame_Buffer_StartAddress_Layer1_DPI_DSI"]
[#if layers?? &&  layers== "1" ]
[#assign Frame_Buffer_StartAddress_Layer1_DPI_DSI = definition.value] 
[/#if]



[#-- ELSE IF --]
[#elseif definition.name = "DMA2D_Graphics"]
[#if definition.value != "0" ]
[#assign dma2d="1"] 
[/#if]
[#-- ELSE IF --]
[#elseif definition.name = "Use_ili9341"]
[#if definition.value == "1" ]
[#assign useIli9341="1"] 
[/#if]


[/#if]
[/#list]
[/#if]
[/#list]

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

#define XSIZE_PHYS      ${XsizePHYS}
#define YSIZE_PHYS      ${YSIZEPHYS}   

#define NUM_BUFFERS         ${NUM_BUFFERS}   /* Number of multiple buffers to be used */
#define NUM_VSCREENS        ${Num_VScreens}  /* Number of virtual screens to be used */

#define COLOR_CONVERSION_0      ${LIN_Color_Conversion_Layer0}
#define DISPLAY_DRIVER_0        ${LIN_Display_Driver_Layer0}

[#if layers?? &&  layers== "1" ]
#define COLOR_CONVERSION_1      ${LIN_Color_Conversion_Layer1}
#define DISPLAY_DRIVER_1        ${LIN_Display_Driver_Layer1}
[/#if]

#define LCD_LAYER0_FRAME_BUFFER        ((uint32_t)${Frame_Buffer_StartAddress_Layer0_DPI_DSI}) /* LTDC Layer 0 frame buffer */
[#if layers?? &&  layers== "1" ]
#define LCD_LAYER1_FRAME_BUFFER        ((uint32_t)${Frame_Buffer_StartAddress_Layer1_DPI_DSI}) /* LTDC Layer 0 frame buffer */
[/#if]

extern LTDC_HandleTypeDef    hltdc;
[#if dma2d != "0" ]
extern DMA2D_HandleTypeDef   hdma2d;
[/#if]

extern volatile GUI_TIMER_TIME OS_TimeMS;

static          LCD_LayerPropTypedef          layer_prop[GUI_NUM_LAYERS];
volatile char   TransferInProgress  = 0;

[#if useIli9341?? && useIli9341=="1"]
[#assign objectConstructor = "freemarker.template.utility.ObjectConstructor"?new()]
[#assign file = objectConstructor("java.io.File",workspace+"/"+"STemWin/stemWin_Wrapper_STM32F429_tmp.c")]
  [#assign exist = file.exists()]
  [#if exist]
 [@common.optinclude name="STemWin/stemWin_Wrapper_STM32F429_tmp.c"/] 
  [#else]
/**
  * @brief  Configures the LCD_SPI interface.
  */
__weak void LCD_IO_Init(void)
{
   /* USER CODE BEGIN LCD_IO_Init */

   /* USER CODE END LCD_IO_Init */
}

/**
  * @brief  Writes register address.
  */
__weak void LCD_IO_WriteReg(uint8_t Reg) 
{
   /* USER CODE BEGIN LCD_IO_WriteReg */

   /* USER CODE END LCD_IO_WriteReg */
}
/**
  * @brief  Writes register value.
  */

__weak void LCD_IO_WriteData(uint16_t RegValue) 
{
   /* USER CODE BEGIN LCD_IO_WriteData */

   /* USER CODE END LCD_IO_WriteData */
}

/**
  * @brief  Reads register value.
  * @param  RegValue Address of the register to read
  * @param  ReadSize Number of bytes to read
  * @retval Content of the register value
  */

__weak uint32_t LCD_IO_ReadData(uint16_t RegValue, uint8_t ReadSize) 
{
   /* USER CODE BEGIN LCD_IO_ReadData */

   /* USER CODE END LCD_IO_ReadData */
  
  return 0;
}
  [/#if]

/**
  * @brief  Wait for loop in ms.
  * @param  Delay in ms.
  */
void LCD_Delay(uint32_t Delay)
{
  HAL_Delay(Delay);
}

[/#if]



static const LCD_API_COLOR_CONV * apColorConvAPI[] = 
{
  COLOR_CONVERSION_0,
#if GUI_NUM_LAYERS > 1
  COLOR_CONVERSION_1,
#endif
};

[#if dma2d=="1"] 
/**
  * @}
  */ 
/** @defgroup LCD CONFIGURATION_Private_FunctionPrototypes
  * @{
  */ 
static U32      GetPixelformat(U32 LayerIndex);
static U32      GetBufferSize(U32 LayerIndex);

static void     DMA2D_CopyBufferWithAlpha(U32 LayerIndex, void * pSrc, void * pDst, U32 xSize, U32 ySize, U32 OffLineSrc, U32 OffLineDst);
static void     DMA2D_CopyBuffer         (U32 LayerIndex, void * pSrc, void * pDst, U32 xSize, U32 ySize, U32 OffLineSrc, U32 OffLineDst);
static void     DMA2D_FillBuffer(U32 LayerIndex, void * pDst, U32 xSize, U32 ySize, U32 OffLine, U32 ColorIndex);

static void     LCD_LL_CopyBuffer(int LayerIndex, int IndexSrc, int IndexDst);
static void     LCD_LL_CopyRect(int LayerIndex, int x0, int y0, int x1, int y1, int xSize, int ySize);
static void     LCD_LL_FillRect(int LayerIndex, int x0, int y0, int x1, int y1, U32 PixelIndex);
static void     LCD_LL_DrawBitmap8bpp(int LayerIndex, int x, int y, U8 const * p, int xSize, int ySize, int BytesPerLine);
void            LCD_LL_DrawBitmap16bpp(int LayerIndex, int x, int y, U16 const * p, int xSize, int ySize, int BytesPerLine);
static void     LCD_LL_DrawBitmap32bpp(int LayerIndex, int x, int y, U8 const * p,  int xSize, int ySize, int BytesPerLine);





static void _DMA_Index2ColorBulk(void * pIndex, LCD_COLOR * pColor, U32 NumItems, U8 SizeOfIndex, U32 PixelFormat);
static void _DMA_Color2IndexBulk(LCD_COLOR * pColor, void * pIndex, U32 NumItems, U8 SizeOfIndex, U32 PixelFormat);

/*********************************************************************
*
*       Redirect bulk conversion to DMA2D routines
*/
#define DEFINE_DMA2D_COLORCONVERSION(PFIX, PIXELFORMAT)                                                        \
static void _Color2IndexBulk_##PFIX##_DMA2D(LCD_COLOR * pColor, void * pIndex, U32 NumItems, U8 SizeOfIndex) { \
  _DMA_Color2IndexBulk(pColor, pIndex, NumItems, SizeOfIndex, PIXELFORMAT);                                    \
}                                                                                                              \
static void _Index2ColorBulk_##PFIX##_DMA2D(void * pIndex, LCD_COLOR * pColor, U32 NumItems, U8 SizeOfIndex) { \
  _DMA_Index2ColorBulk(pIndex, pColor, NumItems, SizeOfIndex, PIXELFORMAT);                                    \
}

DEFINE_DMA2D_COLORCONVERSION(M8888I, LTDC_PIXEL_FORMAT_ARGB8888)
DEFINE_DMA2D_COLORCONVERSION(M888,   LTDC_PIXEL_FORMAT_ARGB8888) // Internal pixel format of emWin is 32 bit, because of that ARGB8888
DEFINE_DMA2D_COLORCONVERSION(M565,   LTDC_PIXEL_FORMAT_RGB565)
DEFINE_DMA2D_COLORCONVERSION(M1555I, LTDC_PIXEL_FORMAT_ARGB1555)
DEFINE_DMA2D_COLORCONVERSION(M4444I, LTDC_PIXEL_FORMAT_ARGB4444)




/*********************************************************************
*
*       _DMA_ExecOperation
*/
static void _DMA_ExecOperation(void) {

  /* Wait until transfer is done */
  if ( TransferInProgress == 0 )
    return;
  
  while(TransferInProgress) {
  }
}



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
  } else if ((apColorConvAPI[LayerIndex] == GUICC_565) | (apColorConvAPI[LayerIndex] == GUICC_M565) ) {
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

/***************************************************************************************************************************/
/* DMA2D API */

/**
  * @brief  DMA2D Transfer completed callback
  * @param  hdma2d: DMA2D handle.
  * @note   This example shows a simple way to report end of DMA2D transfer, and
  *         you can add your own implementation.
  * @retval None
  */
static void TransferComplete(DMA2D_HandleTypeDef *hdma2d)
{
  TransferInProgress = 0; 
}

/**
  * @brief  Initialize the DMA2D.
  * @param  None
  * @retval None
  */
void DMA2D_Init(void) 
{
   /* Configure the DMA2D transfer complete callback mode */ 
	hdma2d.XferCpltCallback  = TransferComplete;	
	
  if (HAL_DMA2D_Init(&hdma2d) != HAL_OK)
  {
    _Error_Handler(__FILE__, __LINE__);
  }

  if (HAL_DMA2D_ConfigLayer(&hdma2d, 1) != HAL_OK)
  {
    _Error_Handler(__FILE__, __LINE__);
  }

}


/**
  * @brief  Return Pixel format for a given layer
  * @param  LayerIndex : Layer Index 
  * @retval Status ( 0 : 0k , 1: error)
  */
static void DMA2D_CopyBuffer(U32 LayerIndex, void * pSrc, void * pDst, U32 xSize, U32 ySize, U32 OffLineSrc, U32 OffLineDst)
{
  U32 PixelFormat;

  _DMA_ExecOperation();
   
  TransferInProgress = 1;	
	
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

_DMA_ExecOperation();

}

/*********************************************************************
*
*       CopyBuffer
*/
static void DMA2D_CopyBufferWithAlpha(U32 LayerIndex, void * pSrc, void * pDst, U32 xSize, U32 ySize, U32 OffLineSrc, U32 OffLineDst)
{
  uint32_t PixelFormat;

  _DMA_ExecOperation();
   
  TransferInProgress = 1;	
	
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
  _DMA_ExecOperation();
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

  _DMA_ExecOperation();
   
  TransferInProgress = 1;	
	
  PixelFormat = GetPixelformat(LayerIndex);

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

  DMA2D->CR     |= (DMA2D_CR_START | DMA2D_IT_TC); 

  /* Wait until transfer is done */
  _DMA_ExecOperation();
}

/*********************************************************************
*
*       _DMA_ConvertColor
*/
static void _DMA_ConvertColor(void * pSrc, void * pDst,  U32 PixelFormatSrc, U32 PixelFormatDst, U32 NumItems) {

  /* Set up mode */
  _DMA_ExecOperation();
  
  TransferInProgress = 1;

  DMA2D->CR      = 0x00010000UL | (1 << 9);         /* Control Register (Memory to memory with pixel format conversion and TCIE) */

  /* Set up pointers */
  DMA2D->FGMAR   = (U32)pSrc;                       /* Foreground Memory Address Register (Source address)  */
  DMA2D->OMAR    = (U32)pDst;                       /* Output Memory Address Register (Destination address) */

  /* Set up offsets */
  DMA2D->FGOR    = 0;                               /* Foreground Offset Register (Source line offset)  */
  DMA2D->OOR     = 0;                               /* Output Offset Register (Destination line offset) */

  /* Set up pixel format */
  DMA2D->FGPFCCR = PixelFormatSrc;                  /* Foreground PFC Control Register (Defines the input pixel format) */
  DMA2D->OPFCCR  = PixelFormatDst;                  /* Output PFC Control Register (Defines the output pixel format)    */

  /* Set up size */
  DMA2D->NLR     = (U32)(NumItems << 16) | 1;       /* Number of Line Register (Size configuration of area to be transfered) */

  /* Execute operation */
  DMA2D->CR     |= (1|DMA2D_IT_TC);
  
  _DMA_ExecOperation();
}


/*********************************************************************
*
*       _DMA_Index2ColorBulk
*
* Purpose:
*   This routine is used by the emWin color conversion routines to use DMA2D for
*   color conversion. It converts the given index values to 32 bit colors.
*   Because emWin uses ABGR internally and 0x00 and 0xFF for opaque and fully
*   transparent the color array needs to be converted after DMA2D has been used.
*/
static void _DMA_Index2ColorBulk(void * pIndex, LCD_COLOR * pColor, U32 NumItems, U8 SizeOfIndex, U32 PixelFormat) {
#if (GUI_USE_ARGB)

  /* Use DMA2D for the conversion */
  _DMA_ConvertColor(pIndex, pColor, PixelFormat, LTDC_PIXEL_FORMAT_ARGB8888, NumItems);
#else

  /* Use DMA2D for the conversion */
  _DMA_ConvertColor(pIndex, pColor, PixelFormat, LTDC_PIXEL_FORMAT_ARGB8888, NumItems);

  /* Convert colors from ARGB to ABGR and invert alpha values */
  _InvertAlpha_SwapRB_MOD(pColor, NumItems);
#endif
}


/*********************************************************************
*
*       _DMA_Color2IndexBulk
*
* Purpose:
*   This routine is used by the emWin color conversion routines to use DMA2D for
*   color conversion. It converts the given 32 bit color array to index values.
*   Because emWin uses ABGR internally and 0x00 and 0xFF for opaque and fully
*   transparent the given color array needs to be converted before DMA2D can be used.
*/
static void _DMA_Color2IndexBulk(LCD_COLOR * pColor, void * pIndex, U32 NumItems, U8 SizeOfIndex, U32 PixelFormat) {
#if (GUI_USE_ARGB)

  /* Use DMA2D for the conversion */
  _DMA_ConvertColor(pColor, pIndex, LTDC_PIXEL_FORMAT_ARGB8888, PixelFormat, NumItems);
#else

  /* Convert colors from ABGR to ARGB and invert alpha values */
  _InvertAlpha_SwapRB_CPY(pColor, _pBuffer_DMA2D, NumItems);

  /* Use DMA2D for the conversion */
  _DMA_ConvertColor(_pBuffer_DMA2D, pIndex, LTDC_PIXEL_FORMAT_ARGB8888, PixelFormat, NumItems);
#endif
}

/**
  * @brief  Get buffer size
  * @param  LayerIndex : Layer Index           
  * @retval None.
  */
static U32 GetBufferSize(U32 LayerIndex) 
{
  return (layer_prop[LayerIndex].xSize * layer_prop[LayerIndex].ySize * layer_prop[LayerIndex].BytesPerPixel);
}

/**
  * @brief  Customized copy buffer
  * @param  LayerIndex : Layer Index
  * @param  IndexSrc:    index source
  * @param  IndexDst:    index destination           
  * @retval None.
  */
static void LCD_LL_CopyBuffer(int LayerIndex, int IndexSrc, int IndexDst) 
{
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
static void LCD_LL_CopyRect(int LayerIndex, int x0, int y0, int x1, int y1, int xSize, int ySize) 
{
  U32 BufferSize, AddrSrc, AddrDst;

  BufferSize = GetBufferSize(LayerIndex);
  AddrSrc = layer_prop[LayerIndex].address + BufferSize * layer_prop[LayerIndex].pending_buffer + (y0 * layer_prop[LayerIndex].xSize + x0) * layer_prop[LayerIndex].BytesPerPixel;
  AddrDst = layer_prop[LayerIndex].address + BufferSize * layer_prop[LayerIndex].pending_buffer + (y1 * layer_prop[LayerIndex].xSize + x1) * layer_prop[LayerIndex].BytesPerPixel;
  DMA2D_CopyBuffer(LayerIndex, (void *)AddrSrc, (void *)AddrDst, xSize, ySize, layer_prop[LayerIndex].xSize - xSize, 0);
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
static void LCD_LL_FillRect(int LayerIndex, int x0, int y0, int x1, int y1, U32 PixelIndex) 
{
  U32 BufferSize, AddrDst;
  int xSize, ySize;

  if (GUI_GetDrawMode() == GUI_DM_XOR) 
  {		
    LCD_SetDevFunc(LayerIndex, LCD_DEVFUNC_FILLRECT, NULL);
    LCD_FillRect(x0, y0, x1, y1);
    LCD_SetDevFunc(LayerIndex, LCD_DEVFUNC_FILLRECT, (void(*)(void))LCD_LL_FillRect);
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
static void DMA2D_DrawBitmapL8(void * pSrc, void * pDst,  U32 OffSrc, U32 OffDst, U32 PixelFormatDst, U32 xSize, U32 ySize)
{	
	
  _DMA_ExecOperation();
   
  TransferInProgress = 1;
	
  /* Set up mode */
  DMA2D->CR      = 0x00010000UL | (1 << 9);         /* Control Register (Memory to memory with pixel format conversion and TCIE) */

  /* Set up pointers */
  DMA2D->FGMAR   = (U32)pSrc;                       /* Foreground Memory Address Register (Source address) */
  DMA2D->OMAR    = (U32)pDst;                       /* Output Memory Address Register (Destination address) */

  /* Set up offsets */
  DMA2D->FGOR    = OffSrc;                          /* Foreground Offset Register (Source line offset) */
  DMA2D->OOR     = OffDst;                          /* Output Offset Register (Destination line offset) */

  /* Set up pixel format */
  DMA2D->FGPFCCR = LTDC_PIXEL_FORMAT_L8;             /* Foreground PFC Control Register (Defines the input pixel format) */
  DMA2D->OPFCCR  = PixelFormatDst;                   /* Output PFC Control Register (Defines the output pixel format) */

  /* Set up size */
  DMA2D->NLR     = (U32)(xSize << 16) | ySize;       /* Number of Line Register (Size configuration of area to be transfered) */

  /* Execute operation */
  DMA2D->CR     |= DMA2D_CR_START;                   /* Start operation */

  /* Wait until transfer is done */
  _DMA_ExecOperation();	
}


/*********************************************************************
*
*       _DMA_DrawAlphaBitmap
*/
/**/
static void _DMA_DrawAlphaBitmap(void * pDst, const void * pSrc, int xSize, int ySize, int OffLineSrc, int OffLineDst, int PixelFormat) {

  _DMA_ExecOperation();
   
  TransferInProgress = 1;
	
  DMA2D->CR      = 0x00020000UL | (1 << 9);         /* Control Register (Memory to memory with blending of FG and BG and TCIE) */
  DMA2D->FGMAR   = (U32)pSrc;                       /* Foreground Memory Address Register (Source address)                     */
  DMA2D->BGMAR   = (U32)pDst;                       /* Background Memory Address Register (Destination address)                */
  DMA2D->OMAR    = (U32)pDst;                       /* Output Memory Address Register (Destination address)                    */
  DMA2D->FGOR    = OffLineSrc;                      /* Foreground Offset Register (Source line offset)                         */
  DMA2D->BGOR    = OffLineDst;                      /* Background Offset Register (Destination line offset)                    */
  DMA2D->OOR     = OffLineDst;                      /* Output Offset Register (Destination line offset)                        */
  DMA2D->FGPFCCR = LTDC_PIXEL_FORMAT_ARGB8888;      /* Foreground PFC Control Register (Defines the input pixel format)        */
  DMA2D->BGPFCCR = PixelFormat;                     /* Background PFC Control Register (Defines the destination pixel format)  */
  DMA2D->OPFCCR  = PixelFormat;                     /* Output     PFC Control Register (Defines the output pixel format)       */
  DMA2D->NLR     = (U32)(xSize << 16) | (U16)ySize; /* Number of Line Register (Size configuration of area to be transfered)   */
  
  DMA2D->CR     |= (1|DMA2D_IT_TC);

_DMA_ExecOperation();  
}


/*********************************************************************
*
*       _LCD_DrawBitmapAlpha
*/
static void _LCD_DrawBitmapAlpha(int LayerIndex, int x, int y, const void * p, int xSize, int ySize, int BytesPerLine) {
  U32 BufferSize, AddrDst;
  int OffLineSrc, OffLineDst;
  U32 PixelFormat;

  PixelFormat = GetPixelformat(LayerIndex);
  BufferSize = GetBufferSize(LayerIndex);
  AddrDst = layer_prop[LayerIndex].address + BufferSize * layer_prop[LayerIndex].buffer_index + (y * layer_prop[LayerIndex].xSize + x) * layer_prop[LayerIndex].BytesPerPixel;
  OffLineSrc = (BytesPerLine / 4) - xSize;
  OffLineDst = layer_prop[LayerIndex].xSize - xSize;
  _DMA_DrawAlphaBitmap((void *)AddrDst, p, xSize, ySize, OffLineSrc, OffLineDst, PixelFormat);
}


/*********************************************************************
*
*       _LCD_DrawMemdevAlpha
*/
static void _LCD_DrawMemdevAlpha(void * pDst, const void * pSrc, int xSize, int ySize, int BytesPerLineDst, int BytesPerLineSrc) {
  int OffLineSrc, OffLineDst;

  OffLineSrc = (BytesPerLineSrc / 4) - xSize;
  OffLineDst = (BytesPerLineDst / 4) - xSize;
  _DMA_DrawAlphaBitmap(pDst, pSrc, xSize, ySize, OffLineSrc, OffLineDst, LTDC_PIXEL_FORMAT_ARGB8888);
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
void LCD_LL_DrawBitmap16bpp(int LayerIndex, int x, int y, U16 const * p, int xSize, int ySize, int BytesPerLine)
{
  U32 BufferSize, AddrDst;
  int OffLineSrc, OffLineDst;

  BufferSize = GetBufferSize(LayerIndex);
  AddrDst = layer_prop[LayerIndex].address + BufferSize * layer_prop[LayerIndex].buffer_index + (y * layer_prop[LayerIndex].xSize + x) * layer_prop[LayerIndex].BytesPerPixel;
  OffLineSrc = (BytesPerLine / 2) - xSize;
  OffLineDst = layer_prop[LayerIndex].xSize - xSize;
  DMA2D_CopyBuffer(LayerIndex, (void *)p, (void *)AddrDst, xSize, ySize, OffLineSrc, OffLineDst);
}

static void LCD_LL_DrawBitmap32bpp(int LayerIndex, int x, int y, U8 const * p, int xSize, int ySize, int BytesPerLine)
{
  U32 BufferSize, AddrDst;
  int OffLineSrc, OffLineDst;

  BufferSize = GetBufferSize(LayerIndex);
  AddrDst = layer_prop[LayerIndex].address + BufferSize * layer_prop[LayerIndex].buffer_index + (y * layer_prop[LayerIndex].xSize + x) * layer_prop[LayerIndex].BytesPerPixel;
  OffLineSrc = (BytesPerLine / 4) - xSize;
  OffLineDst = layer_prop[LayerIndex].xSize - xSize;
  DMA2D_CopyBufferWithAlpha(LayerIndex, (void *)p, (void *)AddrDst, xSize, ySize, OffLineSrc, OffLineDst);
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
static void LCD_LL_DrawBitmap8bpp(int LayerIndex, int x, int y, U8 const * p, int xSize, int ySize, int BytesPerLine)
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
[/#if]



/**
  * @brief  Line Event callback.
  * @param  hltdc: pointer to a LTDC_HandleTypeDef structure that contains
  *                the configuration information for the specified LTDC.
  * @retval None
  */
void HAL_LTDC_LineEvenCallback(LTDC_HandleTypeDef *hltdc) 
{
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

 

/**
  * @brief  Called during the initialization process in order to set up the
  *         display driver configuration
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

    /* Remember color depth for further operations */
    layer_prop[i].BytesPerPixel = LCD_GetBitsPerPixelEx(i) >> 3;
[#if dma2d=="1" ]
    /* Set custom functions for several operations */
    LCD_SetDevFunc(i, LCD_DEVFUNC_COPYBUFFER, (void(*)(void))LCD_LL_CopyBuffer);
    LCD_SetDevFunc(i, LCD_DEVFUNC_COPYRECT,   (void(*)(void))LCD_LL_CopyRect);

    /* Filling via DMA2D does only work with 16bpp or more */
    LCD_SetDevFunc(i, LCD_DEVFUNC_FILLRECT, (void(*)(void))LCD_LL_FillRect);
    LCD_SetDevFunc(i, LCD_DEVFUNC_DRAWBMP_8BPP, (void(*)(void))LCD_LL_DrawBitmap8bpp);
    LCD_SetDevFunc(i, LCD_DEVFUNC_DRAWBMP_16BPP, (void(*)(void))LCD_LL_DrawBitmap16bpp);  
    LCD_SetDevFunc(i, LCD_DEVFUNC_DRAWBMP_32BPP, (void(*)(void))LCD_LL_DrawBitmap32bpp);
 [/#if] 
    /* Set VRAM address */
    LCD_SetVRAMAddrEx(i, (void *)(layer_prop[i].address));
  }
[#if dma2d=="1" ]
  // Set up custom color conversion using DMA2D, works only for direct color modes because of missing LUT for DMA2D destination
  
  GUICC_M1555I_SetCustColorConv(_Color2IndexBulk_M1555I_DMA2D, _Index2ColorBulk_M1555I_DMA2D); // Set up custom bulk color conversion using DMA2D for ARGB1555
  GUICC_M565_SetCustColorConv  (_Color2IndexBulk_M565_DMA2D,   _Index2ColorBulk_M565_DMA2D);   // Set up custom bulk color conversion using DMA2D for RGB565 (does not speed up conversion, default method is slightly faster!)
  GUICC_M4444I_SetCustColorConv(_Color2IndexBulk_M4444I_DMA2D, _Index2ColorBulk_M4444I_DMA2D); // Set up custom bulk color conversion using DMA2D for ARGB4444
  GUICC_M888_SetCustColorConv  (_Color2IndexBulk_M888_DMA2D,   _Index2ColorBulk_M888_DMA2D);   // Set up custom bulk color conversion using DMA2D for RGB888
  GUICC_M8888I_SetCustColorConv(_Color2IndexBulk_M8888I_DMA2D, _Index2ColorBulk_M8888I_DMA2D); // Set up custom bulk color conversion using DMA2D for ARGB8888
 	
	GUI_SetFuncDrawAlpha(_LCD_DrawMemdevAlpha, _LCD_DrawBitmapAlpha);
[/#if]	
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

void GRAPHICS_IncTick(void){
  
   OS_TimeMS++;
} 


void GRAPHICS_HW_Init(void)
{ 
  MX_FMC_Init(); 
  MX_SDRAM_InitEx();
  MX_LCD_Init();      /* LTDC struc, layer struct */
[#if  dma2d=="1" ]
  MX_DMA2D_Init();
  DMA2D_Init();
[/#if]
 
}


void GRAPHICS_Init(void)
{
  /* Initialize the GUI */
  GUI_Init();

[#if multipleBuffers?? && multipleBuffers == "1"]
   WM_MULTIBUF_Enable(1);
[/#if]	
/* Enable the multi-buffering functionality */
[#if multipleBuffers?? && multipleBuffers == "0"]
  // WM_MULTIBUF_Enable(1);
[/#if]

  /* Activate the use of memory device feature */
     /* USER CODE BEGIN WM_SetCreateFlags */
      //WM_SetCreateFlags(WM_CF_MEMDEV);
    /* USER CODE END WM_SetCreateFlags */
}


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
