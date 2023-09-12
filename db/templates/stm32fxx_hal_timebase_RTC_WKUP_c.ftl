[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${FamilyName?lower_case}_hal_timebase_RTC_WKUP.c 
  * @brief   HAL time base based on the hardware RTC_WKUP.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "${FamilyName?lower_case}xx_hal.h"
/** @addtogroup ${FamilyName}xx_HAL_Examples
  * @{
  */

/** @addtogroup HAL_TimeBase
  * @{
  */ 

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
#define RTC_ASYNCH_PREDIV  0
#define RTC_SYNCH_PREDIV   (LSI_VALUE/1000)-1
#define RTC_COUNTER (LSI_VALUE/1000)/2
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
RTC_HandleTypeDef        hrtc;
/* Private function prototypes -----------------------------------------------*/
void RTC_IRQHandler(void);
/* Private functions ---------------------------------------------------------*/

/**
  * @brief  This function configures the RTC_WKUP as a time base source. 
  *         The time source is configured  to have 1ms time base with a dedicated 
  *         Tick interrupt priority. 
  *         Wakeup Time Base = 2 /(32 KHz) = ~0,0625 ms
  *         Wakeup Time = 1ms = 0,0625 ms  * WakeUpCounter (16) 
  * @note   This function is called  automatically at the beginning of program after
  *         reset by HAL_Init() or at any time when clock is configured, by HAL_RCC_ClockConfig(). 
  * @param  TickPriority: Tick interrupt priority.
  * @retval HAL status
  */
HAL_StatusTypeDef HAL_InitTick(uint32_t TickPriority)
{
  __IO uint32_t counter = 0;
  RCC_OscInitTypeDef        RCC_OscInitStruct;
  RCC_PeriphCLKInitTypeDef  PeriphClkInitStruct;
  
  RCC_OscInitStruct.OscillatorType =  RCC_OSCILLATORTYPE_LSI;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_NONE;
  RCC_OscInitStruct.LSIState = RCC_LSI_ON;
    if(HAL_RCC_OscConfig(&RCC_OscInitStruct) == HAL_OK)
  {
    PeriphClkInitStruct.PeriphClockSelection = RCC_PERIPHCLK_RTC;
    PeriphClkInitStruct.RTCClockSelection = RCC_RTCCLKSOURCE_LSI;
    
    if(HAL_RCCEx_PeriphCLKConfig(&PeriphClkInitStruct) == HAL_OK)
    { 
      /* Enable RTC Clock */ 
      __HAL_RCC_RTC_ENABLE(); 

      hrtc.Instance = RTC;
      
      hrtc.Init.HourFormat = RTC_HOURFORMAT_24;
      hrtc.Init.AsynchPrediv = RTC_ASYNCH_PREDIV;
      hrtc.Init.SynchPrediv = RTC_SYNCH_PREDIV;
      hrtc.Init.OutPut = RTC_OUTPUT_DISABLE;
      hrtc.Init.OutPutPolarity = RTC_OUTPUT_POLARITY_HIGH;
      hrtc.Init.OutPutType = RTC_OUTPUT_TYPE_OPENDRAIN;
      HAL_RTC_Init(&hrtc);
      
      /* Disable the write protection for RTC registers */
      __HAL_RTC_WRITEPROTECTION_DISABLE(&hrtc);
      
      /* Disable the Wake-up Timer */
      __HAL_RTC_WAKEUPTIMER_DISABLE(&hrtc);
      
      /* In case of interrupt mode is used, the interrupt source must disabled */ 
      __HAL_RTC_WAKEUPTIMER_DISABLE_IT(&hrtc,RTC_IT_WUT);
      
      /* Wait till RTC WUTWF flag is set  */
      while(__HAL_RTC_WAKEUPTIMER_GET_FLAG(&hrtc, RTC_FLAG_WUTWF) == RESET)
      {
        if(counter++ == 200000)
        {
          return HAL_ERROR;
        }
      }

      /* Clear PWR wake up Flag */
      __HAL_PWR_CLEAR_FLAG(PWR_FLAG_WU);
      
      /* Clear RTC Wake Up timer Flag */
      __HAL_RTC_WAKEUPTIMER_CLEAR_FLAG(&hrtc, RTC_FLAG_WUTF);
      
      /* Configure the Wake-up Timer counter */
      hrtc.Instance->WUTR = (uint32_t)RTC_COUNTER;
      
      /* Clear the Wake-up Timer clock source bits in CR register */
      hrtc.Instance->CR &= (uint32_t)~RTC_CR_WUCKSEL;
      
      /* Configure the clock source */
      hrtc.Instance->CR |= (uint32_t)RTC_WAKEUPCLOCK_RTCCLK_DIV2;
      
      /* RTC WakeUpTimer Interrupt Configuration: EXTI configuration */
      __HAL_RTC_WAKEUPTIMER_EXTI_ENABLE_IT();
      
      __HAL_RTC_WAKEUPTIMER_EXTI_ENABLE_RISING_EDGE();
      
      /* Configure the Interrupt in the RTC_CR register */
      __HAL_RTC_WAKEUPTIMER_ENABLE_IT(&hrtc,RTC_IT_WUT);
      
      /* Enable the Wake-up Timer */
      __HAL_RTC_WAKEUPTIMER_ENABLE(&hrtc);
      
      /* Enable the write protection for RTC registers */
      __HAL_RTC_WRITEPROTECTION_ENABLE(&hrtc);   
      
      HAL_NVIC_SetPriority(${timeBaseInterrupt}, TickPriority, 0);  
      HAL_NVIC_EnableIRQ(${timeBaseInterrupt}); 
      return HAL_OK;
    }
  }
  return HAL_ERROR;
}

/**
  * @brief  Suspend Tick increment.
  * @note   Disable the tick increment by disabling RTC_WKUP interrupt.
  * @param  None
  * @retval None
  */
void HAL_SuspendTick(void)
{
  /* Disable WAKE UP TIMER Interrupt */
  __HAL_RTC_WAKEUPTIMER_DISABLE_IT(&hrtc, RTC_IT_WUT);
}

/**
  * @brief  Resume Tick increment.
  * @note   Enable the tick increment by Enabling RTC_WKUP interrupt.
  * @param  None
  * @retval None
  */
void HAL_ResumeTick(void)
{
  /* Enable  WAKE UP TIMER  interrupt */
  __HAL_RTC_WAKEUPTIMER_ENABLE_IT(&hrtc, RTC_IT_WUT);  
}

/**
  * @brief  Wake Up Timer Event Callback in non blocking mode
  * @note   This function is called  when RTC_WKUP interrupt took place, inside
  * RTC_WKUP_IRQHandler(). It makes a direct call to HAL_IncTick() to increment
  * a global variable "uwTick" used as application time base.
  * @param  hrtc : RTC handle
  * @retval None
  */
void HAL_RTCEx_WakeUpTimerEventCallback(RTC_HandleTypeDef *hrtc)
{
  HAL_IncTick();
}
[#--
/**
  * @brief  This function handles  WAKE UP TIMER  interrupt request.
  * @param  None
  * @retval None
  */
void RTC_WKUP_IRQHandler(void)
{
  HAL_RTCEx_WakeUpTimerIRQHandler(&hrtc);
}--]

/**
  * @}
  */ 

/**
  * @}
  */ 
