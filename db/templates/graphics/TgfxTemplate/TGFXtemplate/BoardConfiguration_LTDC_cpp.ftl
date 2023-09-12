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
                                [#if definition.name = "DMA2D_Graphics" ]
					[#assign DMA2D_Graphics = definition.value]
				[/#if]
                                [#if definition.name = "TGFX_Frame_Buffer_StartAddress_DPI_DSI" ]
					[#assign Frame_Buffer_StartAddress = definition.value]
				[/#if]
                                [#if definition.name  = "Use_ili9341"]
                                  [#if definition.value == "1"]
                                    [#assign useIli9341="1"] 
                                  [/#if]
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
#include <platform/driver/lcd/LCD16bpp.hpp> /* generated when a RGB565 16bit framebuffer is selected */
#include <platform/driver/lcd/LCD24bpp.hpp> /* generated when a RGB888 24bit framebuffer is selected */
[/#if]

[#if FamilyName=="STM32F4"]
#include <STM32F4HAL.hpp>
#include <STM32F4DMA.hpp>
[/#if]
[#if FamilyName=="STM32F7"]
#include <STM32F7HAL.hpp>
#include <STM32F7DMA.hpp>
[/#if]

[#if FamilyName=="STM32F4"]
#include <STM32F4Instrumentation.hpp>
#include <STM32F4TouchController.hpp>
[/#if]
[#if FamilyName=="STM32F7"]
#include <STM32F7TouchController.hpp>
#include <STM32F7Instrumentation.hpp>
[/#if]
#n
/* USER CODE BEGIN user includes */

/* USER CODE END user includes */
#n

/***********************************************************
 ******   Single buffer in internal RAM              *******
 ***********************************************************
 * On this platform, TouchGFX is able to run using a single
 * frame buffer in internal SRAM, thereby avoiding the need
 * for external SDRAM.
 * This feature was introduced in TouchGFX 4.7.0. To enable it,
 * uncomment the define below. The function touchgfx_init()
 * later in this file will check for this define and configure
 * TouchGFX accordingly.
 * For details on the single buffer strategy, please refer to
 * the knowledge base article "Single vs double buffering in TouchGFX"
 * on our support site.
 */
//#define SINGLE_FRAME_BUFFER_INTERNAL

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
[#if FamilyName=="STM32F7"]
extern "C"
{
#include "stm32f7xx.h"
#include "stm32f7xx_hal_dma.h"
#include "stm32f7xx_hal_rcc_ex.h"
#include "stm32f7xx_hal_tim.h"
}
[/#if]

[#if FamilyName=="STM32F4"]
extern "C"
{

#include "stm32f4xx.h"
#include "stm32f4xx_hal_dma.h"
#include "stm32f4xx_hal_rcc_ex.h"
#include "stm32f4xx_hal_tim.h"

}
[/#if]

static uint32_t frameBuf0 = (uint32_t)(${Frame_Buffer_StartAddress});
extern "C" {

[#if useIli9341?? && useIli9341=="1" ]
[#assign objectConstructor = "freemarker.template.utility.ObjectConstructor"?new()]
[#assign file = objectConstructor("java.io.File",workspace+"/"+"TouchGFX/Target/stemWin_Wrapper_STM32F429_tmp.c")]
  [#assign exist = file.exists()]
  [#if exist]
 [@common.optinclude name="TouchGFX/Target/stemWin_Wrapper_STM32F429_tmp.c"/] 
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

uint32_t LCD_GetXSize(void)
{
  return ${WIDTH};
}

uint32_t LCD_GetYSize(void)
{
  return ${HEIGHT};
}
}


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
    

    /* Initialize the SDRAM */
    MX_FMC_Init();
    MX_SDRAM_InitEx();

    /* Configure LCD */
    MX_LCD_Init();
    GPIO::init();

[#if FamilyName=="STM32F7"]
//Deactivate speculative/cache access to first FMC Bank to save FMC bandwidth
    FMC_Bank1->BTCR[0] = 0x000030D2;
[/#if]
}


[#if FamilyName=="STM32F7"]
STM32F7DMA dma;
STM32F7TouchController tc;
STM32F7Instrumentation mcuInstr;
[/#if]
[#if FamilyName=="STM32F4"]
STM32F4DMA dma;
STM32F4TouchController tc;
STM32F4Instrumentation mcuInstr;
[/#if]

[#if TGFX_depth=="16" || TGFX_depth=="0" ]
static LCD16bpp display;
static uint16_t bitdepth = 16;
[/#if]
[#if TGFX_depth=="24"]
static LCD24bpp display;
static uint16_t bitdepth = 24;
[/#if]

namespace touchgfx
{
void touchgfx_init()
{
  uint16_t dispWidth = ${WIDTH};
  uint16_t dispHeight = ${HEIGHT};  
  
[#if FamilyName=="STM32F4"]
  HAL& hal = touchgfx_generic_init<STM32F4HAL>(dma, display, tc, dispWidth, dispHeight,(uint16_t*) ${CACHE_ADDR}, 
                                               ${CACHE_SIZE}, ${Cache_Count}); 

[/#if]
[#if FamilyName=="STM32F7"]
    HAL& hal = touchgfx_generic_init<STM32F7HAL>(dma, display, tc, dispWidth, dispHeight,(uint16_t*) ${CACHE_ADDR}, 
                                               ${CACHE_SIZE}, ${Cache_Count});

[/#if]

   [#if Buffer_COUNT == "2" ]
    hal.setFrameBufferStartAddress((uint16_t*)frameBuf0, bitdepth ,true , true);
[/#if]

[#if Buffer_COUNT == "1" ]
    hal.setFrameBufferStartAddress((uint16_t*)frameBuf0, bitdepth, false, false);
[/#if]

    hal.setTouchSampleRate(2);
    hal.setFingerSize(1);

    // By default frame rate compensation is off.
    // Enable frame rate compensation to smooth out animations in case there is periodic slow frame rates.
    hal.setFrameRateCompensation(false);

    // This platform can handle simultaneous DMA and TFT accesses to SDRAM, so disable lock to increase performance.
    hal.lockDMAToFrontPorch(false);

    mcuInstr.init();

    //Set MCU instrumentation and Load calculation
    hal.setMCUInstrumentation(&mcuInstr);
    hal.enableMCULoadCalculation(true);
}
}

void GRAPHICS_Init()
{
   touchgfx::touchgfx_init();
}

void GRAPHICS_MainTask(void)
{
    touchgfx::HAL::getInstance()->taskEntry();
}
