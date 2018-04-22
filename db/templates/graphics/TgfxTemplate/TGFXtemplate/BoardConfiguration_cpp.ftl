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
					[#assign CACHE_OBJECTS = definition.value]
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

			[/#list]
		[/#if]
	[/#list]
[/#if]

#include <common/TouchGFXInit.hpp>
#include <touchgfx/hal/BoardConfiguration.hpp>
#include <touchgfx/hal/GPIO.hpp>

#include <platform/driver/lcd/LCD16bpp.hpp> /* generated when a RGB565 16bit framebuffer is selected */
#include <platform/driver/lcd/LCD24bpp.hpp> /* generated when a RGB888 24bit framebuffer is selected */
[#if FamilyName=="STM32F4"]
[#if DMA2D_Graphics=="1"]
#include <STM32F4DMA.hpp> /* generated for F4 DMA2D acceleration */
[/#if]
#include <STM32F4HAL.hpp> /* generated when LTDC parallel display is selected on F4 */
[#if Use_DSI=="1"]
#include <STM32F4HAL_DSI.hpp> /* generated when a DSI display is selected on F4 */
[/#if]
[/#if]
[#if FamilyName=="STM32F7"]
[#if DMA2D_Graphics=="1"]
#include <STM32F7DMA.hpp> /* generated for F7 DMA2D acceleration */
[/#if]
#include <STM32F7HAL.hpp> /* generated when LTDC parallel display is selected on F7 */
[#if Use_DSI=="1"]
#include <STM32F7HAL_DSI.hpp> /* generated when a DSI display is selected on F7 */
[/#if]
[/#if]
#include <STM32TouchController.hpp>
[#if FamilyName=="STM32F4"]
#include "stm32f4xx_hal.h" /* generated when a F4 device is selected */
[/#if]
[#if FamilyName=="STM32F7"]
#include "stm32f7xx_hal.h" /* generated when a F7 device is selected */
[/#if]
bool os_inited = false;

extern LTDC_HandleTypeDef hltdc;
[#if Use_DSI=="1"]
extern DSI_HandleTypeDef hdsi;
[/#if]
[#if DMA2D_Graphics=="1"]
extern DMA2D_HandleTypeDef hdma2d;
[/#if]
extern "C" void MX_FMC_Init();
[#if Use_DSI=="1"]
extern "C" void MX_DSI_Init();
[/#if]
extern "C" void MX_LCD_Init();
[#if DMA2D_Graphics=="1"]
extern "C" void MX_DMA2D_Init();
[/#if]
void GRAPHICS_Init(void);
namespace touchgfx
{
void hw_init()
{
    MX_FMC_Init();
    [#if Use_DSI=="1"]
    MX_DSI_Init();
    [/#if]
    MX_LCD_Init();
[#if DMA2D_Graphics=="1"]
    MX_DMA2D_Init();
[/#if]
    GPIO::init();
}

[#if DMA2D_Graphics=="1"]
[#if FamilyName=="STM32F4"]
STM32F4DMA dma; /* generated DMA2D acceleration module declaration for F4 devices */
[/#if]
[#if FamilyName=="STM32F7"]
STM32F7DMA dma; /* generated DMA2D acceleration module declaration for F7 devices */
[/#if]
[/#if]
STM32TouchController tc;
[#if TGFX_depth=="16"]

static LCD16bpp display; /* generated when a RGB565 16bit framebuffer is selected */
[/#if]
[#if TGFX_depth=="24"]
static LCD24bpp display; /* generated when a RGB888 24bit framebuffer is selected */
[/#if]
void touchgfx_init()
{
    /* STM32FxHAL for a LTDC parallel displaty and STM32FxHAL_DSI for DSI display */
[#if FamilyName=="STM32F4"]
    [#if Use_DSI=="1"]
        HAL& hal = touchgfx_generic_init<STM32F4HAL_DSI>(dma, display, tc, ${WIDTH}, ${HEIGHT},    
                                                                                        ${CACHE_ADDR}, ${CACHE_SIZE}, ${CACHE_OBJECTS});
    [#else]
        HAL& hal = touchgfx_generic_init<STM32F4HAL>(dma, display, tc, ${WIDTH}, ${HEIGHT},    
                                                                                        ${CACHE_ADDR}, ${CACHE_SIZE}, ${CACHE_OBJECTS});
    [/#if]
[/#if]
[#if FamilyName=="STM32F7"]
    [#if Use_DSI=="1"]
        HAL& hal = touchgfx_generic_init<STM32F7HAL_DSI>(dma, display, tc, ${WIDTH}, ${HEIGHT},    
                                                                                        ${CACHE_ADDR}, ${CACHE_SIZE}, ${CACHE_OBJECTS});
    [#else]
        HAL& hal = touchgfx_generic_init<STM32F7HAL>(dma, display, tc, ${WIDTH}, ${HEIGHT},    
                                                                                        ${CACHE_ADDR}, ${CACHE_SIZE}, ${CACHE_OBJECTS});
    [/#if]
[/#if]
    os_inited = true;

    hal.setFrameBufferStartAddress((uint16_t*)${Buffer_COUNT}, ${TGFX_depth},[#if Buffer_COUNT=="1"] true[#else] false[/#if]);

    hal.setFrameRateCompensation(false);

    hal.setTouchSampleRate(1);
    hal.setFingerSize(3);

    hal.lockDMAToFrontPorch(false);
    hal.enableMCULoadCalculation(false);
}
}

void GRAPHICS_Init()
{
    hw_init();
	touchgfx_init();
}
