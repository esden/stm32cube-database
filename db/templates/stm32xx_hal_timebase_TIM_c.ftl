[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${FamilyName?lower_case}xx_hal_timebase_TIM.c 
  * @brief   HAL time base based on the hardware TIM.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "${FamilyName?lower_case}xx_hal.h"
#include "${FamilyName?lower_case}xx_hal_tim.h"
 
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
TIM_HandleTypeDef        h${instance?lower_case}; 
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/**
  * @brief  This function configures the ${instance} as a time base source. 
  *         The time source is configured  to have 1ms time base with a dedicated 
  *         Tick interrupt priority. 
  * @note   This function is called  automatically at the beginning of program after
  *         reset by HAL_Init() or at any time when clock is configured, by HAL_RCC_ClockConfig(). 
  * @param  TickPriority: Tick interrupt priority.
  * @retval HAL status
  */
[#assign APB = "APB2"]
[#if instance=="TIM2"||instance=="TIM3"||instance=="TIM4"||instance=="TIM5"||instance=="TIM6"||instance=="TIM7"||instance=="TIM12"||instance=="TIM13"||instance=="TIM14"||instance=="TIM18"]
[#assign APB = "APB1"]
[/#if]
[#if FamilyName=="STM32F0"]
[#assign APB = "APB1"]
[/#if]
[#if FamilyName=="STM32G0"]
[#assign APB = "APB1"]
[/#if]
HAL_StatusTypeDef HAL_InitTick(uint32_t TickPriority)
{
  RCC_ClkInitTypeDef    clkconfig;
[#if FamilyName!="STM32H7"]
  uint32_t              uwTimclock = 0;
  uint32_t              uwPrescalerValue = 0;
[/#if]
[#if FamilyName=="STM32H7"]
[#if APB=="APB1"]
  uint32_t              uwTimclock, uwAPB1Prescaler;
[#else]
  uint32_t              uwTimclock;
[/#if]

  uint32_t              uwPrescalerValue;
[/#if]
  uint32_t              pFLatency;
[#if FamilyName=="STM32WL"]
  HAL_StatusTypeDef     status = HAL_OK;

[/#if]
[#if FamilyName=="STM32G4"]
  HAL_StatusTypeDef     status = HAL_OK;
[/#if]
[#if FamilyName!="STM32WL" && FamilyName!="STM32H7" && FamilyName!="STM32G4"]
  /*Configure the ${instance} IRQ priority */
  HAL_NVIC_SetPriority(${timeBaseInterrupt}, TickPriority ,0); 
  
  /* Enable the ${instance} global Interrupt */
  HAL_NVIC_EnableIRQ(${timeBaseInterrupt}); 
[/#if]
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
[#if FamilyName=="STM32MP1"]
  __HAL_RCC_${instance}_FORCE_RESET();
  __HAL_RCC_${instance}_RELEASE_RESET();
[/#if]
  
  /* Get clock configuration */
  HAL_RCC_GetClockConfig(&clkconfig, &pFLatency);
  
[#if FamilyName=="STM32H7"]
 [#if APB=="APB1"]
  /* Get ${APB} prescaler */
  uw${APB}Prescaler = clkconfig.${APB}CLKDivider; 
[/#if] 
[/#if]
[#if FamilyName=="STM32H7"]
  /* Compute ${instance} clock */
    [#if APB=="APB1"]
  if (uwAPB1Prescaler == RCC_HCLK_DIV1)
  {
    uwTimclock = HAL_RCC_GetPCLK1Freq();
  }
  else
  {
    uwTimclock = 2UL * HAL_RCC_GetPCLK1Freq();
  }
        
    [#else]
        
  [#if TIMAPB2Presc?? && TIMAPB2Presc!="1"]
  uwTimclock = ${TIMAPB2Presc}*HAL_RCC_GetPCLK2Freq();
        [#else]
  uwTimclock = HAL_RCC_GetPCLK2Freq();
        [/#if]
     
    [/#if]
   [/#if]
[#if FamilyName!="STM32H7"]
  /* Compute ${instance} clock */
    [#if APB=="APB1"]
        [#if TIMAPB1Presc?? && TIMAPB1Presc!="1"]
  uwTimclock = ${TIMAPB1Presc}*HAL_RCC_GetPCLK1Freq();
        [#else]
  uwTimclock = HAL_RCC_GetPCLK1Freq();
        [/#if]
    [#else]
        [#if TIMAPB2Presc?? && TIMAPB2Presc!="1"]
  uwTimclock = ${TIMAPB2Presc}*HAL_RCC_GetPCLK2Freq();
        [#else]
  uwTimclock = HAL_RCC_GetPCLK2Freq();
        [/#if]
    [/#if]
   [/#if]
  /* Compute the prescaler value to have ${instance} counter clock equal to 1MHz */
  uwPrescalerValue = (uint32_t) ((uwTimclock / 1000000U) - 1U);
  
  /* Initialize ${instance} */
  h${instance?lower_case}.Instance = ${instance};
  
  /* Initialize TIMx peripheral as follow:
  + Period = [(${instance}CLK/1000) - 1]. to have a (1/1000) s time base.
  + Prescaler = (uwTimclock/1000000 - 1) to have a 1MHz counter clock.
  + ClockDivision = 0
  + Counter direction = Up
  */
  h${instance?lower_case}.Init.Period = (1000000U / 1000U) - 1U;
  h${instance?lower_case}.Init.Prescaler = uwPrescalerValue;
  h${instance?lower_case}.Init.ClockDivision = 0;
  h${instance?lower_case}.Init.CounterMode = TIM_COUNTERMODE_UP;
[#if FamilyName=="STM32WL" || FamilyName=="STM32G4"]

  status = HAL_TIM_Base_Init(&h${instance?lower_case});
  if (status == HAL_OK)
  {
    /* Start the TIM time Base generation in interrupt mode */
    status = HAL_TIM_Base_Start_IT(&h${instance?lower_case});
    if (status == HAL_OK)
    {
    /* Enable the ${instance} global Interrupt */
        HAL_NVIC_EnableIRQ(${timeBaseInterrupt}); 
      /* Configure the SysTick IRQ priority */
      if (TickPriority < (1UL << __NVIC_PRIO_BITS))
      {
        /* Configure the TIM IRQ priority */
        HAL_NVIC_SetPriority(${timeBaseInterrupt}, TickPriority, 0U);
        uwTickPrio = TickPriority;
      }
      else
      {
        status = HAL_ERROR;
      }
    }
  }
 /* Return function status */
  return status;
[#else]
#n
  if(HAL_TIM_Base_Init(&h${instance?lower_case}) == HAL_OK)
  {
    /* Start the TIM time Base generation in interrupt mode */
    return HAL_TIM_Base_Start_IT(&h${instance?lower_case});
  }
  
  /* Return function status */
  return HAL_ERROR;
[/#if]
}

/**
  * @brief  Suspend Tick increment.
  * @note   Disable the tick increment by disabling ${instance} update interrupt.
  * @param  None
  * @retval None
  */
void HAL_SuspendTick(void)
{
  /* Disable ${instance} update Interrupt */
  __HAL_TIM_DISABLE_IT(&h${instance?lower_case}, TIM_IT_UPDATE);                                                  
}

/**
  * @brief  Resume Tick increment.
  * @note   Enable the tick increment by Enabling ${instance} update interrupt.
  * @param  None
  * @retval None
  */
void HAL_ResumeTick(void)
{
  /* Enable ${instance} Update interrupt */
  __HAL_TIM_ENABLE_IT(&h${instance?lower_case}, TIM_IT_UPDATE);
}

[#--/**
  * @brief  Period elapsed callback in non blocking mode
  * @note   This function is called  when ${instance} interrupt took place, inside
  * HAL_TIM_IRQHandler(). It makes a direct call to HAL_IncTick() to increment
  * a global variable "uwTick" used as application time base.
  * @param  htim : TIM handle
  * @retval None
  */
void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim)
{
  HAL_IncTick();
}
--]

[#--/**
  * @brief  This function handles TIM interrupt request.
  * @param  None
  * @retval None
  */
void TIM6_DAC_IRQHandler(void) 
{
  HAL_TIM_IRQHandler(&h${instance});
}--]


