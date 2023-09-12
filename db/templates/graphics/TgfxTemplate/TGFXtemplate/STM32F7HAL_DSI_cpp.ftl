[#ftl]
[#if SWIPdatas??]
	[#list SWIPdatas as SWIP]  
		[#if SWIP.defines??]
			[#list SWIP.defines as definition]	
			[#-- IF to take care of the specific formatting of each argument of this file  --]
				[#if definition.name = "OTM8009A_PixelFormat" ]
					[#assign OTM8009A_PixelFormat = definition.value]
				[/#if]
			[/#list]
                [/#if]
	[/#list]
[/#if]
#include <touchgfx/hal/OSWrappers.hpp>
#include <touchgfx/lcd/LCD.hpp>
#include <touchgfx/hal/GPIO.hpp>

#include <STM32F7HAL_DSI.hpp>
#include <STM32F7DMA.hpp>
#n
/* USER CODE BEGIN user includes */

/* USER CODE END user includes */
#n
/**
 * About this implementation:
 * This class is for use ONLY with the DSI peripheral. If you have a regular RGB interface display, use the STM32F4HAL.cpp class instead.
 *
 * This implementation assumes that the DSI is configured to be in adapted command mode, with tearing effect set to external pin.
 * Display will only be updated when there has actually been changes to the frame buffer.
 */

extern "C"
{
#include "stm32f7xx.h"
#include "stm32f7xx_hal_dsi.h"
#include "stm32f7xx_hal_ltdc.h"
#include "stm32f7xx_hal_gpio.h"

extern LTDC_HandleTypeDef hltdc;
extern DSI_HandleTypeDef hdsi;

/* Request tear interrupt at specific scanline. Implemented in BoardConfiguration.cpp */
void LCD_ReqTear();

/* Configures display to update indicated region of the screen (200pixel wide chunks) - 16bpp mode */
void LCD_SetUpdateRegion(int idx);

/* Configures display to update left half of the screen. Implemented in BoardConfiguration.cpp  - 24bpp mode*/
void LCD_SetUpdateRegionLeft();

/* Configures display to update right half of the screen. Implemented in BoardConfiguration.cpp - 24bpp mode*/
void LCD_SetUpdateRegionRight();
}

static volatile bool displayRefreshing = false;
static volatile bool refreshRequested = false;
static volatile int updateRegion = 0;

static bool doubleBufferingEnabled = false;
static uint16_t* currFbBase = 0;
[#if OTM8009A_PixelFormat == "0" ]
//static uint16_t bitDepth = 0;
[/#if]
[#if OTM8009A_PixelFormat != "0" ]
static uint16_t bitDepth = 0;
[/#if]
#ifndef __HAL_LTDC_RELOAD_IMMEDIATE_CONFIG
#define __HAL_LTDC_RELOAD_IMMEDIATE_CONFIG(__HANDLE__)  ((__HANDLE__)->Instance->SRCR |= LTDC_SRCR_IMR)
#endif

uint16_t* STM32F7HAL_DSI::getTFTFrameBuffer() const
{
    return currFbBase;
}

void STM32F7HAL_DSI::setFrameBufferStartAddress(void* adr, uint16_t depth, bool useDoubleBuffering, bool useAnimationStorage)
{
    // Make note of whether we are using double buffering.
    doubleBufferingEnabled = useDoubleBuffering;
    currFbBase = (uint16_t*)adr;
    [#if OTM8009A_PixelFormat == "0" ]
    // bitDepth = depth;
    [/#if]
    [#if OTM8009A_PixelFormat != "0" ]
    bitDepth = depth;
    [/#if]
    HAL::setFrameBufferStartAddress(adr, depth, useDoubleBuffering, useAnimationStorage);
}

void STM32F7HAL_DSI::setTFTFrameBuffer(uint16_t* adr)
{
    if (doubleBufferingEnabled)
    {
        __HAL_DSI_WRAPPER_DISABLE(&hdsi);
        LTDC_LAYER(&hltdc, 0)->CFBAR = (uint32_t)adr;
        __HAL_LTDC_RELOAD_IMMEDIATE_CONFIG(&hltdc);
        currFbBase = adr;
        __HAL_DSI_WRAPPER_ENABLE(&hdsi);
    }
}

void STM32F7HAL_DSI::configureInterrupts()
{
    // These two priorities MUST be EQUAL, and MUST be functionally lower than RTOS scheduler interrupts.
    NVIC_SetPriority(DMA2D_IRQn, 7);
    NVIC_SetPriority(DSI_IRQn, 7);
}

/* Enable LCD line interrupt, when entering video (active) area */ 
void STM32F7HAL_DSI::enableLCDControllerInterrupt()
{
    LCD_ReqTear();
    __HAL_DSI_CLEAR_FLAG(&hdsi, DSI_FLAG_ER);
    __HAL_DSI_CLEAR_FLAG(&hdsi, DSI_FLAG_TE);
    __HAL_DSI_ENABLE_IT(&hdsi, DSI_IT_TE);
    __HAL_DSI_ENABLE_IT(&hdsi, DSI_IT_ER);
    LTDC->IER = 3; /* Enable line and FIFO underrun interrupts */
}

void STM32F7HAL_DSI::disableInterrupts()
{
    NVIC_DisableIRQ(DMA2D_IRQn);
    NVIC_DisableIRQ(DSI_IRQn);
    NVIC_DisableIRQ(LTDC_ER_IRQn);
}

void STM32F7HAL_DSI::enableInterrupts()
{
    NVIC_EnableIRQ(DMA2D_IRQn);
    NVIC_EnableIRQ(DSI_IRQn);
    NVIC_EnableIRQ(LTDC_ER_IRQn);
}

bool STM32F7HAL_DSI::beginFrame()
{
    refreshRequested = false;
    return HAL::beginFrame();
}

void STM32F7HAL_DSI::endFrame()
{
    HAL::endFrame();
    if (frameBufferUpdatedThisFrame)
    {
        refreshRequested = true;
    }
}

[#if OTM8009A_PixelFormat != "0" ]
extern "C"
void HAL_DSI_TearingEffectCallback(DSI_HandleTypeDef *hdsi)
{
    GPIO::set(GPIO::VSYNC_FREQ);

    HAL::getInstance()->vSync();
    OSWrappers::signalVSync();

    if (!doubleBufferingEnabled && HAL::getInstance())
    {
        // In single buffering, only require that the system waits for display update to be finished if we
        // actually intend to update the display in this frame.
        HAL::getInstance()->lockDMAToFrontPorch(refreshRequested);
    }

    if (refreshRequested && !displayRefreshing)
    {
        // We have an update pending.
        if (doubleBufferingEnabled && HAL::getInstance())
        {
            // Swap frame buffers immediately instead of waiting for the task to be scheduled in.
            // Note: task will also swap when it wakes up, but that operation is guarded and will not have
            // any effect if already swapped.
            HAL::getInstance()->swapFrameBuffers();
        }

        // Update region 0 = first area of display (First quarter for 16bpp, first half for 24bpp)
        updateRegion = 0;

        //Set update region based on bit depth of framebuffer. 16pp or 24bpp.
        if (bitDepth == 24)
        {
            LCD_SetUpdateRegionLeft();
        }
        //Default to 16 bpp
        else
        {
            LCD_SetUpdateRegion(updateRegion);
        }

        // Transfer a quarter screen of pixel data.
        HAL_DSI_Refresh(hdsi);
        displayRefreshing = true;
    } else
    {
        GPIO::clear(GPIO::VSYNC_FREQ);
    }
}

extern "C"
void HAL_DSI_EndOfRefreshCallback(DSI_HandleTypeDef *hdsi)
{
    if (displayRefreshing)
    {
        if (bitDepth == 24)
        {
            if (updateRegion == 0)
            {
                // If we transferred the left half, also transfer right half.
                __HAL_DSI_WRAPPER_DISABLE(hdsi);
                LTDC_LAYER(&hltdc, 0)->CFBAR = ((uint32_t)currFbBase) + (HAL::FRAME_BUFFER_WIDTH / 2) * 3;
                __HAL_LTDC_RELOAD_IMMEDIATE_CONFIG(&hltdc);
                LCD_SetUpdateRegionRight(); //Set display column to 400-799
                __HAL_DSI_WRAPPER_ENABLE(hdsi);
                updateRegion = 1;
                HAL_DSI_Refresh(hdsi);
            }
            else
            {
                // Otherwise we are done refreshing.
                __HAL_DSI_WRAPPER_DISABLE(hdsi);
                LTDC_LAYER(&hltdc, 0)->CFBAR = (uint32_t)currFbBase;
                __HAL_LTDC_RELOAD_IMMEDIATE_CONFIG(&hltdc);
                LCD_SetUpdateRegionLeft(); //Set display column to 0-399
                __HAL_DSI_WRAPPER_ENABLE(hdsi);

                GPIO::clear(GPIO::VSYNC_FREQ);

                displayRefreshing = false;
                if (HAL::getInstance())
                {
                    // Signal to the framework that display update has finished.
                    HAL::getInstance()->frontPorchEntered();
                }
            }
        } else //Default to 16bpp
        {
            updateRegion++;
            if (updateRegion < 4)
            {
                __HAL_DSI_WRAPPER_DISABLE(hdsi);
                LTDC_LAYER(&hltdc, 0)->CFBAR = (uint32_t)currFbBase + (updateRegion * HAL::FRAME_BUFFER_WIDTH) / 2;
                __HAL_LTDC_RELOAD_IMMEDIATE_CONFIG(&hltdc);
                LCD_SetUpdateRegion(updateRegion);
                __HAL_DSI_WRAPPER_ENABLE(hdsi);
                HAL_DSI_Refresh(hdsi);
            }
            else
            {
                __HAL_DSI_WRAPPER_DISABLE(hdsi);
                LTDC_LAYER(&hltdc, 0)->CFBAR = (uint32_t)currFbBase;
                __HAL_LTDC_RELOAD_IMMEDIATE_CONFIG(&hltdc);
                LCD_SetUpdateRegion(0);
                __HAL_DSI_WRAPPER_ENABLE(hdsi);

                GPIO::clear(GPIO::VSYNC_FREQ);

                displayRefreshing = false;
                if (HAL::getInstance())
                {
                    // Signal to the framework that display update has finished.
                    HAL::getInstance()->frontPorchEntered();
                }
            }
        }
    }
}
[/#if]

[#if OTM8009A_PixelFormat == "0" ]

extern "C"
 void HAL_DSI_TearingEffectCallback(DSI_HandleTypeDef *hdsi)
{
/* USER CODE BEGIN DSI_TearingEffectCallback */

 /* Used when the OTM8009 LCD driver is selected  */

 /* GPIO::set(GPIO::VSYNC_FREQ);

    HAL::getInstance()->vSync();
    OSWrappers::signalVSync();

    if (!doubleBufferingEnabled && HAL::getInstance())
    {
        // In single buffering, only require that the system waits for display update to be finished if we
        // actually intend to update the display in this frame.
        HAL::getInstance()->lockDMAToFrontPorch(refreshRequested);
    }

    if (refreshRequested && !displayRefreshing)
    {
        // We have an update pending.
        if (doubleBufferingEnabled && HAL::getInstance())
        {
            // Swap frame buffers immediately instead of waiting for the task to be scheduled in.
            // Note: task will also swap when it wakes up, but that operation is guarded and will not have
            // any effect if already swapped.
            HAL::getInstance()->swapFrameBuffers();
        }

        // Update region 0 = first area of display (First quarter for 16bpp, first half for 24bpp)
        updateRegion = 0;

        //Set update region based on bit depth of framebuffer. 16pp or 24bpp.
        if (bitDepth == 24)
        {
            LCD_SetUpdateRegionLeft();
        }
        //Default to 16 bpp
        else
        {
            LCD_SetUpdateRegion(updateRegion);
        }

        // Transfer a quarter screen of pixel data.
        HAL_DSI_Refresh(hdsi);
        displayRefreshing = true;
    } else
    {
        GPIO::clear(GPIO::VSYNC_FREQ);
    }
*/
/* USER CODE END DSI_TearingEffectCallback */
} 


extern "C"

 void HAL_DSI_EndOfRefreshCallback(DSI_HandleTypeDef *hdsi)
{
/* USER CODE BEGIN DSI_EndOfRefreshCallback */

 /*  Used when the OTM8009 LCD driver is selected  */
/*    if (displayRefreshing)
    {
        if (bitDepth == 24)
        {
            if (updateRegion == 0)
            {
                // If we transferred the left half, also transfer right half.
                __HAL_DSI_WRAPPER_DISABLE(hdsi);
                LTDC_LAYER(&hltdc, 0)->CFBAR = ((uint32_t)currFbBase) + (HAL::FRAME_BUFFER_WIDTH / 2) * 3;
                __HAL_LTDC_RELOAD_IMMEDIATE_CONFIG(&hltdc);
                LCD_SetUpdateRegionRight(); //Set display column to 400-799
                __HAL_DSI_WRAPPER_ENABLE(hdsi);
                updateRegion = 1;
                HAL_DSI_Refresh(hdsi);
            }
            else
            {
                // Otherwise we are done refreshing.
                __HAL_DSI_WRAPPER_DISABLE(hdsi);
                LTDC_LAYER(&hltdc, 0)->CFBAR = (uint32_t)currFbBase;
                __HAL_LTDC_RELOAD_IMMEDIATE_CONFIG(&hltdc);
                LCD_SetUpdateRegionLeft(); //Set display column to 0-399
                __HAL_DSI_WRAPPER_ENABLE(hdsi);

                GPIO::clear(GPIO::VSYNC_FREQ);

                displayRefreshing = false;
                if (HAL::getInstance())
                {
                    // Signal to the framework that display update has finished.
                    HAL::getInstance()->frontPorchEntered();
                }
            }
        } else //Default to 16bpp
        {
            updateRegion++;
            if (updateRegion < 4)
            {
                __HAL_DSI_WRAPPER_DISABLE(hdsi);
                LTDC_LAYER(&hltdc, 0)->CFBAR = (uint32_t)currFbBase + (updateRegion * HAL::FRAME_BUFFER_WIDTH) / 2;
                __HAL_LTDC_RELOAD_IMMEDIATE_CONFIG(&hltdc);
                LCD_SetUpdateRegion(updateRegion);
                __HAL_DSI_WRAPPER_ENABLE(hdsi);
                HAL_DSI_Refresh(hdsi);
            }
            else
            {
                __HAL_DSI_WRAPPER_DISABLE(hdsi);
                LTDC_LAYER(&hltdc, 0)->CFBAR = (uint32_t)currFbBase;
                __HAL_LTDC_RELOAD_IMMEDIATE_CONFIG(&hltdc);
                LCD_SetUpdateRegion(0);
                __HAL_DSI_WRAPPER_ENABLE(hdsi);

                GPIO::clear(GPIO::VSYNC_FREQ);

                displayRefreshing = false;
                if (HAL::getInstance())
                {
                    // Signal to the framework that display update has finished.
                    HAL::getInstance()->frontPorchEntered();
                }
            }
        }
    }
*/
/* USER CODE END DSI_EndOfRefreshCallback */
}

[/#if]