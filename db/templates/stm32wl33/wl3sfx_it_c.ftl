[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_it.c
  * @author  GPM WBL Application Team
  * @brief   Management of interrupt callbacks for handling the MR_SUBG_IRQ interrupt for Sigfox on the STM32WL3.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stddef.h>
#include <stdint.h>

#include "stm32wl3x_hal.h"
#include "wl3sfx_it.h"

/** Interrupt callback registration structure */
typedef struct {
  /** Bitmask for RFSEQ_IRQ_STATUS register that interrupt waits for */
  uint32_t flag_mask;

  /** Callback function pointer */
  wl3sfx_IT_Callback cb;
} interrupt_cb;

#define INTERRUPTS_COUNT WL3SFX_IT_MAX

static interrupt_cb _interrupt_callbacks[INTERRUPTS_COUNT] = { 0 };

static void _update_irq(void)
{
  /* read list of registered callbacks (_interrupt_callbacks) to determine IRQ enable flags */
  uint32_t irq_enable_mask = 0;
  for (uint8_t type = 0; type < INTERRUPTS_COUNT; ++type)
    irq_enable_mask |= _interrupt_callbacks[type].flag_mask;

  MR_SUBG_GLOB_DYNAMIC->RFSEQ_IRQ_ENABLE |= irq_enable_mask;

  /* enable IRQHandler interrupt only if at least one flag bit is watched */
  if (irq_enable_mask != 0)
    HAL_NVIC_EnableIRQ(MR_SUBG_IRQn);
  else
    HAL_NVIC_DisableIRQ(MR_SUBG_IRQn);
}

void wl3sfx_it_register(wl3sfx_IT_Type type, uint32_t flag_mask, wl3sfx_IT_Callback cb)
{
  /* remember interrupt configuration */
  _interrupt_callbacks[type].flag_mask = flag_mask;
  _interrupt_callbacks[type].cb = cb;

  _update_irq();
}

void wl3sfx_it_unregister(wl3sfx_IT_Type type)
{
  _interrupt_callbacks[type].flag_mask = 0;
  _interrupt_callbacks[type].cb = NULL;

  _update_irq();
}

void wl3sfx_it_unregister_all(void)
{
  for (uint8_t type = 0; type < INTERRUPTS_COUNT; ++type)
    wl3sfx_it_unregister((wl3sfx_IT_Type)type);
}

void MRSUBG_IRQHandler(void)
{
  /* execute callback function for every interrupt that has been registered and at least one interrupt flag corresponding to the flag_mask
   * is raised  */
  for (uint8_t type = 0; type < INTERRUPTS_COUNT; ++type) {
    if ((_interrupt_callbacks[type].flag_mask & MR_SUBG_GLOB_STATUS->RFSEQ_IRQ_STATUS) != 0)
      _interrupt_callbacks[type].cb();
  }

  /* Clear all flags that are taken care of by interrupt */
  MR_SUBG_GLOB_STATUS->RFSEQ_IRQ_STATUS = MR_SUBG_GLOB_DYNAMIC->RFSEQ_IRQ_ENABLE;
}