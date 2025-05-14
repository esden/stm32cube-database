[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_it.h
  * @author  GPM WBL Application Team
  * @brief   Management of interrupt callbacks for handling the MR_SUBG_IRQ interrupt for Sigfox on the STM32WL3.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stdint.h>

/* SubGHz Interrupt management for Sigfox */

#ifndef __WL3SFX_IT_H
#define __WL3SFX_IT_H

/**
 * @brief Types of SubGHz interrupts used by Sigfox
 */
typedef enum {
  /** "Symbol used" interrupt for continuous PN9 DBPSK sequence transmission */
  WL3SFX_IT_PN9TX = 0,

  /** "Buffer full" interrupt for Monarch beacon detection */
  WL3SFX_IT_MONARCH,

  /** (do not use, marks end of enumeration) */
  WL3SFX_IT_MAX
} wl3sfx_IT_Type;

typedef void (*wl3sfx_IT_Callback)(void);

/**
 * @brief Register RFSEQ_IRQ interrupt callback
 *
 * @param type Type of interrupt to register
 * @param flag_mask Bit mask of interrupt flags to watch. Callback is only called if flag_mask | RFSEQ_IRQ_STATUS != 0, i.e. at least one
 * watched flag is raised.
 * @param cb Callback function that is executed when interrupt occurs.
 *
 * @retval None
 */
void wl3sfx_it_register(wl3sfx_IT_Type type, uint32_t flag_mask, wl3sfx_IT_Callback cb);

/**
 * @brief Unregister RFSEQ_IRQ interrupt callback
 *
 * @param type Type of interrupt to unregister
 */
void wl3sfx_it_unregister(wl3sfx_IT_Type type);

/**
 * @brief Unregister all RFSEQ_IRQ interrupt callbacks
 *
 * @retval None
 */

void wl3sfx_it_unregister_all(void);

/**
 * @brief Handles MRSUBG interrupt callbacks
 * @retval None
 */
void MRSUBG_IRQHandler(void);
#endif