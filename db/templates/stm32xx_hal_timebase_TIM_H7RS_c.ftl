[#ftl]
/**
  ******************************************************************************
  * @file    ${FamilyName?lower_case}xx_hal_timebase_tim.c
  * @author  MCD Application Team
  * @brief   Template for HAL time base based on the peripheral hardware ${instance}.
  *
  *          This file override the native HAL time base functions (defined as weak)
  *          the TIM time base:
  *           + Initializes the ${instance} peripheral to generate a Period elapsed Event each 1ms
  *           + HAL_IncTick is called inside HAL_TIM_PeriodElapsedCallback ie each 1ms
  *
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2024 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************/

/* Includes ------------------------------------------------------------------*/
#include "${FamilyName?lower_case}xx_hal.h"
[#if USBPD?? && (USBPD_CORELIB != "USBPDCORE_LIB_NO_PD")]
#include "usbpd.h"
[/#if]

/** @addtogroup STM32H7RSxx_HAL_Driver
  * @{
  */

/** @addtogroup HAL_TimeBase
  * @{
  */
 
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
#define TIM_CNT_FREQ 1000000U /* Timer counter frequency : 1 MHz */
#define TIM_FREQ     1000U    /* Timer frequency : 1 kHz => to have 1 ms interrupt */

/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
TIM_HandleTypeDef h${instance?lower_case};

/* Private function prototypes -----------------------------------------------*/
#if (USE_HAL_TIM_REGISTER_CALLBACKS == 1U)
void TimeBase_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim);
#endif /* USE_HAL_TIM_REGISTER_CALLBACKS */
[#if isTim_callback?? && isTim_callback=="1"]
 void TimeBase_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim);
 [/#if]
/* Private functions ---------------------------------------------------------*/

/**
  * @brief  This function configures the ${instance} as a time base source. 
  *         The time source is configured  to have 1ms time base with a dedicated 
  *         Tick interrupt priority. 
  * @note   This function is called  automatically at the beginning of program after
  *         reset by HAL_Init() or at any time when clock is configured, by HAL_RCC_ClockConfig(). 
  * @param  TickPriority Tick interrupt priority.
  * @retval HAL status
  */
[#assign APB = "APB1"]
[#assign DIV = "DIV1"]
[#assign PCLK = "PCLK1"]
[#if instance=="TIM1"||instance=="TIM9"||instance=="TIM15"||instance=="TIM16"||instance=="TIM17"]
[#assign APB = "APB2"]
[#assign DIV = "DIV2"]
[#assign PCLK = "PCLK2"]
[/#if]
HAL_StatusTypeDef HAL_InitTick(uint32_t TickPriority)
{
  RCC_ClkInitTypeDef    clkconfig;
  uint32_t              uwTimclock;
  uint32_t              uw${APB}Prescaler;
  uint32_t              uwPrescalerValue;
  uint32_t              pFLatency;
  HAL_StatusTypeDef     Status;

[#if FamilyName=="STM32H7"]
/*Configure the ${instance} IRQ priority */
  if (TickPriority < (1UL << __NVIC_PRIO_BITS))
  {
  HAL_NVIC_SetPriority(${timeBaseInterrupt}, TickPriority ,0U); 
  
  /* Enable the ${instance} global Interrupt */
  HAL_NVIC_EnableIRQ(${timeBaseInterrupt}); 
    uwTickPrio = TickPriority;
    }
  else
  {
    return HAL_ERROR;
  }
[/#if]
#n
  /* Enable ${instance} clock */
  __HAL_RCC_${instance}_CLK_ENABLE();

  
  /* Get clock configuration */
  HAL_RCC_GetClockConfig(&clkconfig, &pFLatency);

  /* Get ${APB} prescaler */
  uw${APB}Prescaler = clkconfig.${APB}CLKDivider; 

  /* Compute ${instance} clock */
  if (uw${APB}Prescaler == RCC_${APB}_DIV1)
  {
    uwTimclock = HAL_RCC_Get${PCLK}Freq();
  }
  else if (uw${APB}Prescaler == RCC_${APB}_DIV2)
  {
    uwTimclock = 2UL * HAL_RCC_Get${PCLK}Freq();
  }
  else
  {
    if (__HAL_RCC_GET_TIMCLKPRESCALER() == RCC_TIMPRES_DISABLE)
    {
      uwTimclock = 2UL * HAL_RCC_Get${PCLK}Freq();
    }
    else
    {
      uwTimclock = 4UL * HAL_RCC_Get${PCLK}Freq();
    }
  }



  /* Compute the prescaler value to have ${instance} counter clock equal to TIM_CNT_FREQ */
  uwPrescalerValue = (uint32_t)((uwTimclock / TIM_CNT_FREQ) - 1U);
  
  /* Initialize ${instance} */
  h${instance?lower_case}.Instance = ${instance};
  
  /* Initialize TIMx peripheral as follow:
  + Period = [uwTickFreq * (TIM_CNT_FREQ/TIM_FREQ) - 1]. to have a (uwTickFreq/TIM_FREQ) s time base.
  + Prescaler = (uwTimclock/TIM_CNT_FREQ - 1) to have a TIM_CNT_FREQ counter clock.
  + ClockDivision = 0
  + Counter direction = Up
  */
  h${instance?lower_case}.Init.Period = ((uint32_t)uwTickFreq  * (TIM_CNT_FREQ / TIM_FREQ)) - 1U;
  h${instance?lower_case}.Init.Prescaler = uwPrescalerValue;
  h${instance?lower_case}.Init.ClockDivision = 0;
  h${instance?lower_case}.Init.CounterMode = TIM_COUNTERMODE_UP;
  h${instance?lower_case}.Init.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_DISABLE;
  Status = HAL_TIM_Base_Init(&h${instance?lower_case});
  if (Status == HAL_OK)
  {
#if (USE_HAL_TIM_REGISTER_CALLBACKS == 1U)
    HAL_TIM_RegisterCallback(&h${instance?lower_case}, HAL_TIM_PERIOD_ELAPSED_CB_ID, TimeBase_TIM_PeriodElapsedCallback);
#endif /* USE_HAL_TIM_REGISTER_CALLBACKS */
    /* Start the TIM time Base generation in interrupt mode */
    Status = HAL_TIM_Base_Start_IT(&h${instance?lower_case});
    if (Status == HAL_OK)
    {
      if (TickPriority < (1UL << __NVIC_PRIO_BITS))
      {
        /* Configure the ${instance} global Interrupt priority */
        HAL_NVIC_SetPriority(${timeBaseInterrupt}, TickPriority, 0);

        /* Enable the ${instance} global Interrupt */
        HAL_NVIC_EnableIRQ(${timeBaseInterrupt});

        uwTickPrio = TickPriority;
      }
      else
      {
        Status = HAL_ERROR;
      }
    }
  }

  /* Return function status */
  return Status;
}

/**
  * @brief  Suspend Tick increment.
  * @note   Disable the tick increment by disabling ${instance} update interrupt.
  * @retval None
  */
void HAL_SuspendTick(void)
{
  /* Disable ${instance} update interrupt */
  __HAL_TIM_DISABLE_IT(&h${instance?lower_case}, TIM_IT_UPDATE);
}

/**
  * @brief  Resume Tick increment.
  * @note   Enable the tick increment by enabling ${instance} update interrupt.
  * @retval None
  */
void HAL_ResumeTick(void)
{
  /* Enable ${instance} update interrupt */
  __HAL_TIM_ENABLE_IT(&h${instance?lower_case}, TIM_IT_UPDATE);
}

[#if isTim_callback?? && isTim_callback=="1"]
 /**
  * @brief  Period elapsed callback in non blocking mode
  * @note   This function is called  when ${instance} interrupt took place, inside
  * HAL_TIM_IRQHandler(). It makes a direct call to HAL_IncTick() to increment
  * a global variable "uwTick" used as application time base.
  * @param  htim TIM handle
  * @retval None
  */

void TimeBase_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim)
{
  /* Prevent unused argument(s) compilation warning */
  UNUSED(htim);

  HAL_IncTick();


}
[/#if]

/**
  * @brief  Period elapsed callback in non blocking mode
  * @note   This function is called  when ${instance} interrupt took place, inside
  * HAL_${instance}_IRQHandler(). It makes a direct call to HAL_IncTick() to increment
  * a global variable "uwTick" used as application time base.
  * @param  htim TIM handle
  * @retval None
  */
#if (USE_HAL_TIM_REGISTER_CALLBACKS == 1U)
void TimeBase_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim)
{
  /* Prevent unused argument(s) compilation warning */
  UNUSED(htim);

  HAL_IncTick();

  [#if USBPD?? && (USBPD_CORELIB != "USBPDCORE_LIB_NO_PD")]
  USBPD_DPM_TimerCounter();
  [/#if]

  [#if GUI_INTERFACE??]
  GUI_TimerCounter();
  [/#if]
}
#endif /* USE_HAL_TIM_REGISTER_CALLBACKS */
/**
  * @}
  */

/**
  * @}
  */