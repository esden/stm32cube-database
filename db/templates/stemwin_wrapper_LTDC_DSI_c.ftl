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
[#elseif definition.name = "ZONE"]
#define ZONES       #t#t ${definition.value}   /* expected value 2,4 */
#define HACT            XSIZE_PHYS/ZONES      /* SCREEN DIVIDED INTO TWO AREAS  */

[#-- ELSE IF --]
[#elseif definition.name = "Num_MultBuffers"]
#define NUM_BUFFERS     #t#t ${definition.value}  /* Number of multiple buffers to be used */
[#if definition.value !="1"  ]
[#assign multipleBuffers = "1"]
[/#if]
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


[#-- ELSE IF --]
[#elseif definition.name = "Frame_Buffer_StartAddress_Layer0_DPI_DSI"]
#define LCD_LAYER0_FRAME_BUFFER   #t#t ((uint32_t)${definition.value}) /* LTDC Layer 0 frame buffer */
[#-- ELSE IF --]
[#elseif definition.name = "Frame_Buffer_StartAddress_Layer1_DPI_DSI"]
[#if layers?? &&  layers== "1" ]
#define LCD_LAYER1_FRAME_BUFFER   #t#t ((uint32_t)${definition.value})  /* LTDC Layer 1 frame buffer */
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

/**
  * @}
  */ 

#define __DSI_MASK_TE()   (GPIOJ->AFR[0] &= (0xFFFFF0FFU))                    /* Mask DSI TearingEffect Pin*/
#define __DSI_UNMASK_TE() (GPIOJ->AFR[0] |= ((uint32_t)(GPIO_AF13_DSI) << 8)) /* UnMask DSI TearingEffect Pin*/



extern LTDC_HandleTypeDef    hltdc;
extern DSI_HandleTypeDef     hdsi;
extern void MX_FMC_Init(void);
[#assign UseSDRAM="0"]
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
[#assign OTM="0"] 
[#elseif definition.name = "OTM8009A_Orientation" ]
[#if definition.value != "0" ]
[#assign OTM="1"]
uint8_t pPage[]       = {0x00, 0x00, 0x01, 0xDF}; /*   0 -> 479 */


/* Constant .. To be generated with OTM8009 LCD driver */
uint8_t pCols[ZONES][4] =
{
#if (ZONES == 4 )
  {0x00, 0x00, 0x00, 0xC7}, /*   0 -> 199 */
  {0x00, 0xC8, 0x01, 0x8F}, /* 200 -> 399 */
  {0x01, 0x90, 0x02, 0x57}, /* 400 -> 599 */
  {0x02, 0x58, 0x03, 0x1F}, /* 600 -> 799 */
#elif (ZONES == 2 )
  {0x00, 0x00, 0x01, 0x8F}, /*   0 -> 399 */
  {0x01, 0x90, 0x03, 0x1F}  
#endif  
};
[/#if]
static LCD_LayerPropTypedef          layer_prop[GUI_NUM_LAYERS];
volatile int32_t LCD_ActiveRegion    = 1;
volatile int32_t LCD_Refershing      = 0;

static const LCD_API_COLOR_CONV * apColorConvAPI[] = 
{
  COLOR_CONVERSION_0,
#if GUI_NUM_LAYERS > 1
  COLOR_CONVERSION_1,
#endif
};

#if GUI_NUM_LAYERS < 2
U32 LCD_Addr[GUI_NUM_LAYERS] = {LCD_LAYER0_FRAME_BUFFER};
#else
U32 LCD_Addr[GUI_NUM_LAYERS] = {LCD_LAYER0_FRAME_BUFFER, LCD_LAYER1_FRAME_BUFFER};
#endif

/**
  * @}
  */ 
[#-- ELSE IF --]
[#elseif definition.name = "DMA2D_Graphics"]
[#if definition.value != "0" ]
[#assign dma2d="1"] 
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
[/#if]
void            LCD_ReqTear(void);
void            DSI_IRQHandler(void);
[#if OTM?? && OTM== "1" ]
void            LCD_SetUpdateRegion(int idx);
[/#if]


[@common.optinclude name="STemWin/hw_init_LCD_Reset_tmp.c"/] 


/**
  * @brief  DCS or Generic short/long write command
  * @param  NbParams: Number of parameters. It indicates the write command mode:
  *                 If inferior to 2, a long write command is performed else short.
  * @param  pParams: Pointer to parameter values table.
  * @retval HAL status
  */
void DSI_IO_WriteCmd(uint32_t NbrParams, uint8_t *pParams)
{
  if(NbrParams <= 1)
  {
    HAL_DSI_ShortWrite(&hdsi, 0, DSI_DCS_SHORT_PKT_WRITE_P1, pParams[0], pParams[1]); 
  }
  else
  {
    HAL_DSI_LongWrite(&hdsi,  0, DSI_DCS_LONG_PKT_WRITE, NbrParams, pParams[NbrParams], pParams); 
  } 
} 

[#if OTM?? && OTM== "1" ]
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
[#if dma2d?? && dma2d=="1" ]
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
  * @brief  Return Pixel format for a given layer
  * @param  LayerIndex : Layer Index 
  * @retval Status ( 0 : 0k , 1: error)
  */
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
  while (DMA2D->CR & DMA2D_CR_START)
  {
  }	
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
[#if OTM?? && OTM=="1" ]
/**
  * @brief  Set LCD updated region.
  * @param  idx: active region index.
  * @retval None
  */
void LCD_SetUpdateRegion(int idx)
{
  HAL_DSI_LongWrite(&hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 4, OTM8009A_CMD_CASET, pCols[idx]);
}
[/#if]
/**
  * @brief  Tearing Effect DSI callback.
  * @param  hdsi: pointer to a DSI_HandleTypeDef structure that contains
  *               the configuration information for the DSI.
  * @retval None
  */
void HAL_DSI_TearingEffectCallback(DSI_HandleTypeDef *hdsi)
{
  uint32_t index = 0;

  if(!LCD_Refershing)
  {
    for(index = 0; index < GUI_NUM_LAYERS; index ++)
    {
      if(layer_prop[index].pending_buffer >= 0)
      {
        GUI_MULTIBUF_ConfirmEx(index,  layer_prop[index].pending_buffer);
        layer_prop[index].pending_buffer = -1;
      } 
    }    
    LCD_Refershing = 1;
    LCD_ActiveRegion = 1;
    HAL_DSI_Refresh(hdsi); 
  }
}  
[#if OTM?? && OTM== "1" ]
/**
  * @brief  End of Refresh DSI callback.
  * @param  hdsi: pointer to a DSI_HandleTypeDef structure that contains
  *               the configuration information for the DSI.
  * @retval None
  */
void HAL_DSI_EndOfRefreshCallback(DSI_HandleTypeDef *hdsi)
{
  uint32_t index = 0;

  if(LCD_ActiveRegion < ZONES )
  {
    LCD_Refershing = 1;
    /* Disable DSI Wrapper */
    __HAL_DSI_WRAPPER_DISABLE(hdsi);
    for(index = 0; index < GUI_NUM_LAYERS; index ++)
    {
      /* Update LTDC configuaration */
      LTDC_LAYER(&hltdc, index)->CFBAR  = LCD_Addr[index] + LCD_ActiveRegion  * (layer_prop[0].xSize/ZONES) * layer_prop[0].BytesPerPixel;
    }
    __HAL_LTDC_RELOAD_CONFIG(&hltdc);
    __HAL_DSI_WRAPPER_ENABLE(hdsi);
    LCD_SetUpdateRegion(LCD_ActiveRegion++);
    /* Refresh the right part of the display */
    HAL_DSI_Refresh(hdsi);
  }
  else
  {
    LCD_Refershing = 0;
    
    __HAL_DSI_WRAPPER_DISABLE(hdsi);
    for(index = 0; index < GUI_NUM_LAYERS; index ++)
    {
      LTDC_LAYER(&hltdc, index)->CFBAR  = LCD_Addr[index];
    }
    __HAL_LTDC_RELOAD_CONFIG(&hltdc);
    __HAL_DSI_WRAPPER_ENABLE(hdsi);  
    LCD_SetUpdateRegion(0); 
  }
}
[/#if]

[#if  OTM== "0" ]
/**
  * @brief  End of Refresh DSI callback.
  * @param  hdsi: pointer to a DSI_HandleTypeDef structure that contains
  *               the configuration information for the DSI.
  * @retval None
  */
void HAL_DSI_EndOfRefreshCallback(DSI_HandleTypeDef *hdsi)
{

}
[/#if]
[#if OTM?? && OTM== "1" ]
/**
  * @brief  Request TE at scanline.
  * @param  None
  * @retval None
  */
void LCD_ReqTear(void)
{
  static uint8_t ScanLineParams[2];
#if (ZONES == 4 )
  uint16_t scanline = 283;
#elif (ZONES == 2 )
  uint16_t scanline = 200;
#endif
  ScanLineParams[0] = scanline >> 8;
  ScanLineParams[1] = scanline & 0x00FF;
  
  HAL_DSI_LongWrite(&hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 2, 0x44, ScanLineParams);     
  /* set_tear_on */
  HAL_DSI_ShortWrite(&hdsi, 0, DSI_DCS_SHORT_PKT_WRITE_P1, OTM8009A_CMD_TEEON, 0x00);  
}
[/#if]

[#if  OTM== "0" ]
/**
  * @brief  Request TE at scanline.
  * @param  None
  * @retval None
  */
void LCD_ReqTear(void)
{
   
}
[/#if]


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
[#if dma2d?? && dma2d=="1" ]
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

  
  MX_LCD_Init(); /* LTDC struc, layer struct */
  [#assign objectConstructor = "freemarker.template.utility.ObjectConstructor"?new()]

 [#assign file = objectConstructor("java.io.File",workspace+"/"+"STemWin/hw_init_LCD_Reset_tmp.c")]
  [#assign exist = file.exists()]
  [#if exist]
    LCD_LL_Reset();
 [/#if]
  
[#if dma2d?? && dma2d=="1" ]
  MX_DMA2D_Init();
[/#if]
  MX_DSI_Init();
[#if OTM?? && OTM== "1" ]
  HAL_DSI_LongWrite(&hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 4, OTM8009A_CMD_CASET, pCols[0]);
  HAL_DSI_LongWrite(&hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 4, OTM8009A_CMD_PASET, pPage);
 [/#if]
  /* Update pitch : the draw is done on the whole physical X Size */
  HAL_LTDC_SetPitch(&hltdc, XSIZE_PHYS, 0);
#if (GUI_NUM_LAYERS > 1)    
  HAL_LTDC_SetPitch(&hltdc, XSIZE_PHYS, 1);
#endif

  HAL_Delay(20);

  LCD_ReqTear();
[#if OTM?? && OTM=="1" ]
  /* Send Display off DCS Command to display */
  HAL_DSI_ShortWrite(&(hdsi),
                     0,
                     DSI_DCS_SHORT_PKT_WRITE_P1,
                     OTM8009A_CMD_DISPON,
                     0x00);
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

  LCD_X_SHOWBUFFER_INFO * p;  
  switch (Cmd) 
  {   
  case LCD_X_SETORG: 
    addr = layer_prop[LayerIndex].address + ((LCD_X_SETORG_INFO *)pData)->yPos * layer_prop[LayerIndex].xSize * layer_prop[LayerIndex].BytesPerPixel;
    HAL_LTDC_SetAddress(&hltdc, addr, LayerIndex);
    break;

  case LCD_X_SHOWBUFFER: 
    p = (LCD_X_SHOWBUFFER_INFO *)pData;
    LCD_Addr[LayerIndex] = layer_prop[LayerIndex].address + \
      layer_prop[LayerIndex].xSize * layer_prop[LayerIndex].ySize * layer_prop[LayerIndex].BytesPerPixel * p->Index;
    layer_prop[LayerIndex].pending_buffer = p->Index;
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
      __HAL_DSI_WRAPPER_DISABLE(&hdsi);
      __HAL_LTDC_LAYER_ENABLE(&hdsi, LayerIndex); 
      __HAL_DSI_WRAPPER_ENABLE(&hdsi);
    }
    else
    {
      __HAL_DSI_WRAPPER_DISABLE(&hdsi);
      __HAL_LTDC_LAYER_DISABLE(&hdsi, LayerIndex); 
      __HAL_DSI_WRAPPER_ENABLE(&hdsi);
    }
    __HAL_LTDC_RELOAD_CONFIG(&hltdc);  

    HAL_DSI_Refresh(&hdsi); 
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
