[#ftl]
[#assign coreDir=sourceDir]


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


[#if definition.name = "Instrumentation"]
[#assign tim_index = definition.value ]

[/#if]
[/#list]
[/#if]
[/#list]

#include <STM32H7Instrumentation.hpp>

#ifdef STM32H743xx
#include <stdio.h>
#include <string.h>

#include <stm32h7xx_hal.h>
#include <stm32h7xx_hal_uart.h>

extern UART_HandleTypeDef UartHandle;
#endif

extern "C"
{
#include "stm32h7xx_hal_rcc.h"
#include "stm32h7xx_hal_rcc_ex.h"
#include "stm32h7xx_hal_tim.h"
}
#n
/* USER CODE BEGIN user includes */

/* USER CODE END user includes */
#n
namespace touchgfx
{
static TIM_HandleTypeDef htim${tim_index};

void STM32H7Instrumentation::init()
{
   RCC_ClkInitTypeDef clkconfig;
    uint32_t uwTimclock, uwAPB1Prescaler = 0U;
    uint32_t pFLatency;

    __TIM2_CLK_ENABLE();

    
    [@common.optinclude name=mxTmpFolder+"/tim${tim_index}_HalInit.tmp"/]

    /* Get clock configuration */
    HAL_RCC_GetClockConfig(&clkconfig, &pFLatency);

    /* TIM2 is on APB1 bus */
    uwAPB1Prescaler = clkconfig.APB1CLKDivider;

    if (uwAPB1Prescaler == RCC_HCLK_DIV1)
        uwTimclock = HAL_RCC_GetPCLK1Freq();
    else
        uwTimclock = 2 * HAL_RCC_GetPCLK1Freq();

    m_sysclkRatio = HAL_RCC_GetHCLKFreq() / uwTimclock;

    HAL_TIM_Base_Start(&htim${tim_index});
}

//Board specific clockfrequency
unsigned int STM32H7Instrumentation::getElapsedUS(unsigned int start, unsigned int now, unsigned int clockfrequency)
{
    return ((now - start) + (clockfrequency / 2)) / clockfrequency;
}

unsigned int STM32H7Instrumentation::getCPUCycles()
{
    return __HAL_TIM_GET_COUNTER(&htim${tim_index}) * m_sysclkRatio;
}

void STM32H7Instrumentation::setMCUActive(bool active)
{
    if (active) //idle task sched out
    {
        cc_consumed += getCPUCycles() - cc_in;
    }
    else //idle task sched in
    {
        cc_in = getCPUCycles();
    }
}

}
