
#include <touchgfx/hal/HAL.hpp>
#include <STM32F7Instrumentation.hpp>

extern "C"
{
#include "stm32f7xx_hal_dma.h"
#include "stm32f7xx_hal_qspi.h"
#include "stm32f7xx_hal_rcc_ex.h"
#include "stm32f7xx_hal_tim.h"
}

namespace touchgfx
{
TIM_HandleTypeDef tim;

void STM32F7Instrumentation::init()
{
    __TIM2_CLK_ENABLE();
    tim.Instance = TIM2;
    tim.Init.ClockDivision = TIM_CLOCKDIVISION_DIV1;
    tim.Init.CounterMode = TIM_COUNTERMODE_UP;
    tim.Init.Period = 0xFFFFFFFF;
    tim.Init.Prescaler = 0;
    tim.Init.RepetitionCounter = 1;
    HAL_TIM_Base_Init(&tim);
    HAL_TIM_Base_Start(&tim);
}

//Board specific clockfrequency
unsigned int STM32F7Instrumentation::getElapsedUS(unsigned int start, unsigned int now, unsigned int clockfrequency)
{
    return ((now - start) + (clockfrequency / 2)) / clockfrequency;
}


unsigned int STM32F7Instrumentation::getCPUCycles()
{
    return __HAL_TIM_GET_COUNTER(&tim) * 3;
}

void STM32F7Instrumentation::setMCUActive(bool active)
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
