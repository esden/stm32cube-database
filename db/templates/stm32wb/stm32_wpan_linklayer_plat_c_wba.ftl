[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    linklayer_plat.c
  * @author  MCD Application Team
  * @brief   Source file for the linklayer plateform adaptation layer
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */


#include "app_common.h"
#include "stm32wbaxx_hal.h"
#include "linklayer_plat.h"
#include "stm32wbaxx_hal_conf.h"
#include "stm32wbaxx_ll_rcc.h"
#include "app_conf.h"
#include "scm.h"

#define max(a,b) ((a) > (b) ? a : b)

/* 2.4GHz RADIO ISR callbacks */
void (*radio_callback)(void) = NULL;
void (*low_isr_callback)(void) = NULL;

/* RNG handle */
extern RNG_HandleTypeDef hrng;
extern void HAL_Generate_Random_Bytes_To( uint8_t* out, uint8_t n );

/* Radio critical sections */
int32_t int_state_counter = 0;
uint32_t system_interrupt_state[TOTAL_NUM_IRQ] = {0};
volatile int32_t prio_counter = 0;
volatile int32_t irq_counter = 0;

/**
  * @brief  Configure the necessary clock sources for the radio :
  *         -  HSE32 (bus clk)
  *         -  LSE  (sleep clk)
  *         Enable radio AHB5ENR peripheral bus clock
  * @param  None
  * @retval None
  */
void LINKLAYER_PLAT_ClockInit()
{
  /* Select LSE as Sleep CLK */
  __HAL_RCC_RADIOSLPTIM_CONFIG(RCC_RADIOSTCLKSOURCE_LSE);

  /* Enable AHB5ENR peripheral clock (bus CLK) */
  __HAL_RCC_RADIO_CLK_ENABLE();
}

void LINKLAYER_PLAT_DelayUs(uint32_t delay)
{
__IO register uint32_t Delay = delay * (SystemCoreClock / 1000000U);
	do
	{
		__NOP();
	}
	while (Delay --);
}

void LINKLAYER_PLAT_Assert(uint8_t condition)
{
  assert_param(condition);
}

void LINKLAYER_PLAT_HclkEnable()
{
  __HAL_RCC_RADIO_CLK_ENABLE();
}

void LINKLAYER_PLAT_HclkDisable()
{
  __HAL_RCC_RADIO_CLK_DISABLE();
}

void LINKLAYER_PLAT_AclkCtrl(uint8_t enable)
{
  if(enable){
    /* Enable RADIO baseband clock (active CLK) */
    HAL_RCCEx_EnableRadioBBClock();

    /* Polling on HSE32 activation */
    while ( LL_RCC_HSE_IsReady() == 0);
  }
  else
  {
    /* Disable RADIO baseband clock (active CLK) */
    HAL_RCCEx_DisableRadioBBClock();
  }
}

void LINKLAYER_PLAT_GetRNG(uint8_t *ptr_rnd, uint32_t len)
{
  HAL_Generate_Random_Bytes_To( ptr_rnd, (uint8_t)len );
}

void LINKLAYER_PLAT_SetupRadioIT(void (*intr_cb)())
{
  radio_callback = intr_cb;
  HAL_NVIC_SetPriority((IRQn_Type) RADIO_INTR_NUM, RADIO_INTR_PRIO_HIGH, 0);
  HAL_NVIC_EnableIRQ((IRQn_Type) RADIO_INTR_NUM);
}

void LINKLAYER_PLAT_SetupSwLowIT(void (*intr_cb)())
{
  low_isr_callback = intr_cb;

  HAL_NVIC_SetPriority((IRQn_Type) RADIO_SW_LOW_INTR_NUM, RADIO_SW_LOW_INTR_PRIO, 0);
  HAL_NVIC_EnableIRQ((IRQn_Type) RADIO_SW_LOW_INTR_NUM);
}

void LINKLAYER_PLAT_TriggerSwLowIT(void)
{
  HAL_NVIC_SetPendingIRQ((IRQn_Type) RADIO_SW_LOW_INTR_NUM);
}

void LINKLAYER_PLAT_EnableIRQ(void)
{
  irq_counter = max(0,irq_counter-1);

  if(irq_counter == 0)
  {
    __enable_irq();
  }
  else if (irq_counter < 0) {
    LINKLAYER_PLAT_Assert(0);
  }
}

void LINKLAYER_PLAT_DisableIRQ(void)
{
  __disable_irq();
  irq_counter ++;
}

void LINKLAYER_PLAT_SetITPrioLvl(int32_t prio_level)
{
    int i = 0;

    prio_counter++;
    if(prio_counter == 1)
    {
      if (int_state_counter == 0) {
        for (i = 0 ; i < TOTAL_NUM_IRQ ;i++ ){
            if (NVIC_GetEnableIRQ((IRQn_Type) i) && (NVIC_GetPriority((IRQn_Type) i) > prio_level)) {
                system_interrupt_state[i] =  1;
                HAL_NVIC_DisableIRQ((IRQn_Type) i);
            }
        }
      }
    ++int_state_counter;
    }
}

void LINKLAYER_PLAT_RestoreITPrioLvl(void)
{
  int i = 0;
  prio_counter--;
  if(prio_counter == 0)
  {
    --int_state_counter;
    if (int_state_counter == 0) {
      for (i = 0 ; i < TOTAL_NUM_IRQ ;i++ ) {
        if (system_interrupt_state[i]) {
          system_interrupt_state[i] =  0;
          HAL_NVIC_EnableIRQ((IRQn_Type) i);
        }
      }
    }
  }
  else if (prio_counter < 0) {
    assert_param(0);
  }
}

void LINKLAYER_PLAT_EnableRadioIT(void)
{
  HAL_NVIC_EnableIRQ((IRQn_Type) RADIO_INTR_NUM);
}

void LINKLAYER_PLAT_DisableRadioIT(void)
{
  HAL_NVIC_DisableIRQ((IRQn_Type) RADIO_INTR_NUM);
}

void LINKLAYER_PLAT_StartRadioEvt(void)
{
  __HAL_RCC_RADIO_CLK_SLEEP_ENABLE();
  NVIC_SetPriority(RADIO_INTR_NUM, RADIO_INTR_PRIO_HIGH);
  scm_notifyradiostate(SCM_RADIO_ACTIVE); 
}

void LINKLAYER_PLAT_StopRadioEvt(void)
{
  __HAL_RCC_RADIO_CLK_SLEEP_DISABLE();
  NVIC_SetPriority(RADIO_INTR_NUM, RADIO_INTR_PRIO_LOW);
  scm_notifyradiostate(SCM_RADIO_NOT_ACTIVE);
}