[#ftl]
[#if SWIPdatas??]
	[#list SWIPdatas as SWIP]  
		[#if SWIP.defines??]
			[#list SWIP.defines as definition]	
			[#-- IF to take care of the specific formatting of each argument of this file  --]
				[#if definition.name = "TGFX_depth" ]
					[#assign TGFX_depth = definition.value]
				[/#if]
				[#if definition.name = "TGFX_Buffer_Width" ]
					[#assign WIDTH = definition.value]
				[/#if]
				[#if definition.name = "TGFX_Buffer_Height" ]
					[#assign HEIGHT = definition.value]
				[/#if]
				[#if definition.name = "TGFX_cache_size" ]
					[#assign CACHE_SIZE = definition.value]
				[/#if]
				[#if definition.name = "TGFX_cache_Address" ]
					[#assign CACHE_ADDR = definition.value]
				[/#if]
				[#if definition.name = "TGFX_cache_count" ]
					[#assign Cache_Count = definition.value]
				[/#if]
				[#if definition.name = "TGFX_buffers_count" ]
					[#assign Buffer_COUNT = definition.value]
				[/#if]
                                [#if definition.name = "Use_DSI" ]
					[#assign Use_DSI = definition.value]
				[/#if]		
                                [#if definition.name = "DMA2D_Graphics" ]
					[#assign DMA2D_Graphics = definition.value]
				[/#if]
                                [#if definition.name = "OTM8009A_PixelFormat" ]
					[#assign OTM8009A_PixelFormat = definition.value]
				[/#if]
                                [#if definition.name = "TGFX_Frame_Buffer_StartAddress_DPI_DSI" ]
					[#assign Frame_Buffer_StartAddress = definition.value]
				[/#if]
			[/#list]
[/#if]
	[/#list]
[/#if]
#include <common/TouchGFXInit.hpp>
#include <touchgfx/hal/BoardConfiguration.hpp>
#include <touchgfx/hal/GPIO.hpp>
[#if TGFX_depth=="16"]
#include <platform/driver/lcd/LCD16bpp.hpp> 
[/#if]
[#if TGFX_depth=="24"]
#include <platform/driver/lcd/LCD24bpp.hpp> 
[/#if]
[#if TGFX_depth=="0"]
#include <platform/driver/lcd/LCD16bpp.hpp> 
#include <platform/driver/lcd/LCD24bpp.hpp>
[/#if]

[#if FamilyName=="STM32F4"]
#include <STM32F4DMA.hpp> /* generated for F4 DMA2D acceleration */
#include <STM32F4HAL_DSI.hpp> /* generated when a DSI display is selected on F4 */
[/#if]
[#if FamilyName=="STM32F7"]
#include <STM32F7DMA.hpp> /* generated for F7 DMA2D acceleration */
#include <STM32F7HAL_DSI.hpp> /* generated when a DSI display is selected on F7 */
[/#if]
[#if FamilyName=="STM32F4"]
#include <STM32F4Instrumentation.hpp>
[/#if]
[#if FamilyName=="STM32F7"]
#include <STM32F7Instrumentation.hpp>
[/#if]
[#if FamilyName=="STM32H7"]
#include <STM32H7DMA.hpp> /* generated for H7 DMA2D acceleration */
#include <STM32H7HAL_DSI.hpp> /* generated when a DSI display is selected on H7 */
[/#if]
[#if FamilyName=="STM32H7"]
#include <STM32H7Instrumentation.hpp>
[/#if]




[#if OTM8009A_PixelFormat != "0" ]
#include <OTM8009TouchController.hpp>
#include <otm8009a.h>


[#else ]
    [#if FamilyName=="STM32F4"]
#include <STM32F4TouchController.hpp>
    [/#if]
    [#if FamilyName=="STM32F7"]
#include <STM32F7TouchController.hpp>
    [/#if]
    [#if FamilyName=="STM32H7"]
#include <STM32H7TouchController.hpp>
 [/#if]
[/#if]
#n
/* USER CODE BEGIN user includes */

/* USER CODE END user includes */
#n

/**
 * In order to use double buffering, simply enable the USE_DOUBLE_BUFFERING #define below
 * Enabling double buffering will yield a performance increase (potentionally higher frame rate),
 * at the expense of consuming an additional frame buffer's worth of external RAM - e.g. 800 * 480 * 2 bytes (16 bpp)
 */
//#define USE_DOUBLE_BUFFERING 1

/***********************************************************
 ******         24 Bits Per Pixel Support            *******
 ***********************************************************
 *
 * The default bit depth of the framebuffer is 16bpp. If you want 24bpp support, define the symbol "USE_BPP" with a value
 * of "24", e.g. "USE_BPP=24". This symbol affects the following:
 *
 * 1. Type of TouchGFX LCD (16bpp vs 24bpp)
 * 2. Bit depth of the framebuffer(s)
 * 3. TFT controller configuration.
 *
 * WARNING: Remember to modify your image formats accordingly in app/config/. Please see the following knowledgebase article
 * for further details on how to choose and configure the appropriate image formats for your application:
 *
 * https://touchgfx.zendesk.com/hc/en-us/articles/206725849
 */
#include "HW_Init.hpp"
extern "C"
{
[#if FamilyName=="STM32F4"]
#include "stm32f4xx_hal.h" 
#include "stm32f4xx_hal_dsi.h"
[/#if]
[#if FamilyName=="STM32F7"]
#include "stm32f7xx_hal.h"
#include "stm32f7xx_hal_dsi.h"
[/#if]
[#if FamilyName=="STM32H7"]
#include "stm32h7xx_hal.h"
#include "stm32h7xx_hal_dsi.h"
[/#if]

extern DSI_HandleTypeDef    hdsi;


[#if OTM8009A_PixelFormat != "0" ]
uint32_t LCD_GetXSize()
{
    return OTM8009A_800X480_WIDTH;
}

uint32_t LCD_GetYSize()
{
    return OTM8009A_800X480_HEIGHT;
}
[/#if]
[#if OTM8009A_PixelFormat == "0" ]
uint32_t LCD_GetXSize()
{
    return ${WIDTH};
}

uint32_t LCD_GetYSize()
{
    return ${HEIGHT};
}
[/#if]

#define LAYER0_ADDRESS  (${Frame_Buffer_StartAddress})

}

[#if OTM8009A_PixelFormat != "0" ]
uint8_t pCols[4][4] =
{
    {0x00, 0x00, 0x00, 0xC7}, /*   0 -> 199 */
    {0x00, 0xC8, 0x01, 0x8F}, /* 200 -> 399 */
    {0x01, 0x90, 0x02, 0x57}, /* 400 -> 599 */
    {0x02, 0x58, 0x03, 0x1F}, /* 600 -> 799 */
};

uint8_t pColLeft[]    = {0x00, 0x00, 0x01, 0x8F}; /*   0 -> 399 */
uint8_t pColRight[]   = {0x01, 0x90, 0x03, 0x1F}; /* 400 -> 799 */
[/#if]

[#if OTM8009A_PixelFormat == "0" ]
/* Constant .. To be generated with OTM8009 LCD driver */
// uint8_t pCols[4][4] =
//{
//    {0x00, 0x00, 0x00, 0xC7}, /*   0 -> 199 */
//    {0x00, 0xC8, 0x01, 0x8F}, /* 200 -> 399 */
//    {0x01, 0x90, 0x02, 0x57}, /* 400 -> 599 */
//    {0x02, 0x58, 0x03, 0x1F}, /* 600 -> 799 */
//};

// uint8_t pColLeft[]    = {0x00, 0x00, 0x01, 0x8F}; /*   0 -> 399 */
// uint8_t pColRight[]   = {0x01, 0x90, 0x03, 0x1F}; /* 400 -> 799 */
[/#if]

static uint32_t frameBuf0 = (uint32_t)(LAYER0_ADDRESS);


/**
  * @brief  DCS or Generic short/long write command
  * @param  NbParams: Number of parameters. It indicates the write command mode:
  *                 If inferior to 2, a long write command is performed else short.
  * @param  pParams: Pointer to parameter values table.
  * @retval HAL status
  */
extern "C" void DSI_IO_WriteCmd(uint32_t NbrParams, uint8_t *pParams)
{
    if (NbrParams <= 1)
        HAL_DSI_ShortWrite(&hdsi, 0, DSI_DCS_SHORT_PKT_WRITE_P1, pParams[0], pParams[1]);
    else
        HAL_DSI_LongWrite(&hdsi, 0, DSI_DCS_LONG_PKT_WRITE, NbrParams, pParams[NbrParams], pParams); 
}


[#if OTM8009A_PixelFormat != "0" ]
extern "C"
{
    /**
     * Request TE at scanline.
     */
    void LCD_ReqTear(void)
    {
        uint8_t ScanLineParams[2];
        uint16_t scanline = 533;

        ScanLineParams[0] = scanline >> 8;
        ScanLineParams[1] = scanline & 0x00FF;

        HAL_DSI_LongWrite(&hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 2, OTM8009A_CMD_WRTESCN, ScanLineParams);
        HAL_DSI_ShortWrite(&hdsi, 0, DSI_DCS_SHORT_PKT_WRITE_P1, OTM8009A_CMD_TEEON, OTM8009A_TEEON_TELOM_VBLANKING_INFO_ONLY);
    }

    void LCD_SetUpdateRegion(int idx)
    {
        HAL_DSI_LongWrite(&hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 4, OTM8009A_CMD_CASET, pCols[idx]);
    }

    void LCD_SetUpdateRegionLeft()
    {
        HAL_DSI_LongWrite(&hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 4, OTM8009A_CMD_CASET, pColLeft);
    }

    void LCD_SetUpdateRegionRight()
    {
        HAL_DSI_LongWrite(&hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 4, OTM8009A_CMD_CASET, pColRight);
    }
}
[/#if]
[#if OTM8009A_PixelFormat == "0" ]
extern "C"
{
    /**
     * Request TE at scanline.
     */

/* Used when the OTM8009 LCD driver is selected  */

   void LCD_ReqTear(void)
    {
    /* USER CODE BEGIN LCD_ReqTear */
      //  uint8_t ScanLineParams[2];
     //   uint16_t scanline = 533;

     //   ScanLineParams[0] = scanline >> 8;
     //   ScanLineParams[1] = scanline & 0x00FF;
    
     

      //   HAL_DSI_LongWrite(&hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 2, OTM8009A_CMD_WRTESCN, ScanLineParams);
      //   HAL_DSI_ShortWrite(&hdsi, 0, DSI_DCS_SHORT_PKT_WRITE_P1, OTM8009A_CMD_TEEON, OTM8009A_TEEON_TELOM_VBLANKING_INFO_ONLY);

     /* USER CODE END LCD_ReqTear */
    }

    void LCD_SetUpdateRegion(int idx)
    {
      /* USER CODE BEGIN SetUpdateRegion */

        //   HAL_DSI_LongWrite(&hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 4, OTM8009A_CMD_CASET, pCols[idx]);

      /* USER CODE END SetUpdateRegion */
    }

    void LCD_SetUpdateRegionLeft()
    {
      /* USER CODE BEGIN SetUpdateRegionLeft */

        //   HAL_DSI_LongWrite(&hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 4, OTM8009A_CMD_CASET, pColLeft);

      /* USER CODE END SetUpdateRegionLeft */
    }

    void LCD_SetUpdateRegionRight()
    {
     /* USER CODE BEGIN LCD_SetUpdateRegionRight */

       //   HAL_DSI_LongWrite(&hdsi, 0, DSI_DCS_LONG_PKT_WRITE, 4, OTM8009A_CMD_CASET, pColRight);

     /* USER CODE BEGIN LCD_SetUpdateRegionRight */
    }

} 
[/#if]
[#assign objectConstructor = "freemarker.template.utility.ObjectConstructor"?new()]
[#assign file = objectConstructor("java.io.File",workspace+"/"+"TouchGFX/Target/touchGFX_LCD_Reset_tmp.c")]
  [#assign exist = file.exists()]
  [#if exist]
 [@common.optinclude name="TouchGFX/Target/touchGFX_LCD_Reset_tmp.c"/] 
  [#else]
   /* Configures the LCD reset pin. */

     /* USER CODE BEGIN Config_LCD_Reset_Pin */
      //  static void LCD_LL_Reset(void)
        //   {
                
         //  }  
     /* USER CODE END Config_LCD_Reset_Pin */
  [/#if]



using namespace touchgfx;
void GRAPHICS_HW_Init()
{
     
   [#assign objectConstructor = "freemarker.template.utility.ObjectConstructor"?new()]

 [#assign file = objectConstructor("java.io.File",workspace+"/"+"TouchGFX/Target/Ew_QUADSPI_tmp.c")]
  [#assign exist = file.exists()]
  [#if exist]
 /* Enable the QSPI in memory-mapped mode */
 /* QSPI_EnableMemoryMappedMode(); */
 HAL_NVIC_DisableIRQ(QUADSPI_IRQn);
[/#if]
    
    MX_FMC_Init();
    MX_SDRAM_InitEx();
[#assign objectConstructor = "freemarker.template.utility.ObjectConstructor"?new()]
[#assign file = objectConstructor("java.io.File",workspace+"/"+"TouchGFX/Target/touchGFX_LCD_Reset_tmp.c")]
  [#assign exist = file.exists()]
  [#if exist]
    LCD_LL_Reset();
  [#else]
  /* Configures the LCD reset pin. */
      /* USER CODE BEGIN LCD_reset_pin */

    //  LCD_LL_Reset(); 

     /* USER CODE END LCD_reset_pin */
  [/#if]
    MX_LCD_Init();
    [#if Use_DSI=="1"]
    MX_DSI_Init();
    [/#if]

    GPIO::init();

	[#if FamilyName=="STM32F7"]
    //Deactivate speculative/cache access to first FMC Bank to save FMC bandwidth
    FMC_Bank1->BTCR[0] = 0x000030D2;
	[/#if]
       
}

[#if OTM8009A_PixelFormat != "0" ]
__weak void OTM8009A_IO_Delay(uint32_t Delay)
{
  HAL_Delay(Delay);
}
[/#if]

namespace touchgfx
{
[#if FamilyName=="STM32F4"]
STM32F4DMA dma; /* generated DMA2D acceleration module declaration for F4 devices */
[/#if]
[#if FamilyName=="STM32F7"]
STM32F7DMA dma; /* generated DMA2D acceleration module declaration for F7 devices */
[/#if]
[#if FamilyName=="STM32H7"]
STM32H7DMA dma; /* generated DMA2D acceleration module declaration for H7 devices */
[/#if]
[#if OTM8009A_PixelFormat != "0" ]
OTM8009TouchController tc;
[/#if]
[#if OTM8009A_PixelFormat == "0" && FamilyName=="STM32F4" ]
STM32F4TouchController tc;
[/#if]
[#if OTM8009A_PixelFormat == "0" && FamilyName=="STM32F7" ]
STM32F7TouchController tc;
[/#if]
[#if OTM8009A_PixelFormat == "0" && FamilyName=="STM32H7" ]
STM32H7TouchController tc;
[/#if]
[#if FamilyName=="STM32F4"]
STM32F4Instrumentation mcuInstr;
[/#if]
[#if FamilyName=="STM32F7"]
STM32F7Instrumentation mcuInstr;
[/#if]
[#if FamilyName=="STM32H7"]
STM32H7Instrumentation mcuInstr;
[/#if]

[#if TGFX_depth=="16" || TGFX_depth=="0" ]
static LCD16bpp display;
static uint16_t bitdepth = 16;
[/#if]
[#if TGFX_depth=="24"]
static LCD24bpp display;
static uint16_t bitdepth = 24;
[/#if]

void touchgfx_init()
{ 
  uint16_t dispWidth = ${WIDTH};
  uint16_t dispHeight = ${HEIGHT};

[#if FamilyName=="STM32F4"]
  HAL& hal = touchgfx_generic_init<STM32F4HAL_DSI>(dma, display, tc, dispWidth, dispHeight, (uint16_t*) ${CACHE_ADDR}, 
                                               ${CACHE_SIZE}, ${Cache_Count});                                                     
[/#if]
[#if FamilyName=="STM32F7"]
  HAL& hal = touchgfx_generic_init<STM32F7HAL_DSI>(dma, display, tc, dispWidth, dispHeight, (uint16_t*) ${CACHE_ADDR}, 
                                               ${CACHE_SIZE}, ${Cache_Count}); 
[/#if]
[#if FamilyName=="STM32H7"]
  HAL& hal = touchgfx_generic_init<STM32H7HAL_DSI>(dma, display, tc, dispWidth, dispHeight, (uint16_t*) ${CACHE_ADDR}, 
                                               ${CACHE_SIZE}, ${Cache_Count}); 
[/#if]

[#if Buffer_COUNT == "2" ]
    hal.setFrameBufferStartAddress((uint16_t*)frameBuf0, bitdepth ,true , true);
[/#if]
  [#if Buffer_COUNT == "1" ]
    hal.setFrameBufferStartAddress((uint16_t*)frameBuf0, bitdepth, false, false);
[/#if]

    // By default frame rate compensation is off.
    // Enable frame rate compensation to smooth out animations in case there is periodic slow frame rates.
    hal.setFrameRateCompensation(false);

    hal.setTouchSampleRate(2);
    hal.setFingerSize(1);

    // This platform can handle simultaneous DMA and TFT accesses to SDRAM, so disable lock to increase performance.
    hal.lockDMAToFrontPorch(false);

    mcuInstr.init();

    //Set MCU instrumentation and Load calculation
    hal.setMCUInstrumentation(&mcuInstr);
    hal.enableMCULoadCalculation(true);  
}
}
using namespace touchgfx;

void GRAPHICS_Init()
{
   touchgfx::touchgfx_init();
}

void GRAPHICS_MainTask(void)
{
    touchgfx::HAL::getInstance()->taskEntry();
}
