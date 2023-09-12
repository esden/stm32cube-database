[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${FamilyName?lower_case}xx_hal_timebase_RTC_ALARM.c 
  * @brief   HAL time base based on the hardware RTC_ALARM.
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

/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
RTC_HandleTypeDef        hrtc;
/* Private function prototypes -----------------------------------------------*/
void RTC_IRQHandler(void);
/* Private functions ---------------------------------------------------------*/

/**
  * @brief  This function configures the RTC_ALARM as a time base source. 
  *         The time source is configured  to have 1ms time base with a dedicated 
  *         Tick interrupt priority. 
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
      
      /* Disable the Alarm A interrupt */
      __HAL_RTC_ALARMA_DISABLE(&hrtc);
      
      /* Clear flag alarm A */
      __HAL_RTC_ALARM_CLEAR_FLAG(&hrtc, RTC_FLAG_ALRAF);
      
      counter = 0;
      /* Wait till RTC ALRAWF flag is set and if Time out is reached exit */
      while(__HAL_RTC_ALARM_GET_FLAG(&hrtc, RTC_FLAG_ALRAWF) == RESET)
      {
        if(counter++ == 20000)
        {
          return HAL_ERROR;
        } 
      }
      
      hrtc.Instance->ALRMAR = (uint32_t)0x1;
      
      /* Configure the Alarm state: Enable Alarm */
      __HAL_RTC_ALARMA_ENABLE(&hrtc);
      /* Configure the Alarm interrupt */
      __HAL_RTC_ALARM_ENABLE_IT(&hrtc,RTC_IT_ALRA);
      
      /* RTC Alarm Interrupt Configuration: EXTI configuration */
      __HAL_RTC_ALARM_EXTI_ENABLE_IT();
      __HAL_RTC_ALARM_EXTI_ENABLE_RISING_EDGE();
      
      /* Check if the Initialization mode is set */
      if((hrtc.Instance->ISR & RTC_ISR_INITF) == (uint32_t)RESET)
      {
        /* Set the Initialization mode */
        hrtc.Instance->ISR = (uint32_t)RTC_INIT_MASK;
        counter = 0;
        while((hrtc.Instance->ISR & RTC_ISR_INITF) == (uint32_t)RESET)
        {
          if(counter++ == 20000)
          {
            return HAL_ERROR;
          }      
        }
      }
      hrtc.Instance->DR = 0;
      hrtc.Instance->TR = 0;
      
      hrtc.Instance->ISR &= (uint32_t)~RTC_ISR_INIT; 
      
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
  * @note   Disable the tick increment by disabling RTC ALARM interrupt.
  * @param  None
  * @retval None
  */
void HAL_SuspendTick(void)
{
/* Disable RTC ALARM update Interrupt */
  __HAL_RTC_ALARM_DISABLE_IT(&hrtc,RTC_IT_ALRA);                                               
}

/**
  * @brief  Resume Tick increment.
  * @note   Enable the tick increment by Enabling RTC ALARM interrupt.
  * @param  None
  * @retval None
  */
void HAL_ResumeTick(void)
{
  /* Enable RTC ALARM Update interrupt */
  __HAL_RTC_ALARM_ENABLE_IT(&hrtc,RTC_IT_ALRA);
}

/**
  * @brief  Wake Up Timer Event Callback in non blocking mode
  * @note   This function is called  when RTC_ALARM interrupt took place, inside
  * RTC_ALARM_IRQHandler(). It makes a direct call to HAL_IncTick() to increment
  * a global variable "uwTick" used as application time base.
  * @param  hrtc : RTC handle
  * @retval None
  */
void HAL_RTC_AlarmAEventCallback(RTC_HandleTypeDef *hrtc)
{
  __IO uint32_t counter = 0;
  
  HAL_IncTick();
  
  __HAL_RTC_WRITEPROTECTION_DISABLE(hrtc);  

  /* Set the Initialization mode */
  hrtc->Instance->ISR = (uint32_t)RTC_INIT_MASK;
  
  while((hrtc->Instance->ISR & RTC_ISR_INITF) == (uint32_t)RESET)
  {
    if(counter++ == 20000)
    {
      break;
    }
  }
  
  hrtc->Instance->DR = 0;
  hrtc->Instance->TR = 0;
  
  hrtc->Instance->ISR &= (uint32_t)~RTC_ISR_INIT; 
  
  /* Enable the write protection for RTC registers */
  __HAL_RTC_WRITEPROTECTION_ENABLE(hrtc);  
}

/**
  * @brief  This function handles RTC ALARM interrupt request.
  * @param  None
  * @retval None
  */
[#--void RTC_Alarm_IRQHandler(void)
{
  HAL_RTC_AlarmIRQHandler(&hrtc);
}--]

/**
  * @}
  */ 

/**
  * @}
  */ 
