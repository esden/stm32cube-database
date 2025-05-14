[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_txsymbols.h
  * @author  GPM WBL Application Team
  * @brief   Manages the generation of DBPSK symbols for Sigfox uplink transmissions.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stdint.h>

#include "wl3sfx_fem.h"

#ifndef __WL3SFX_TXSYMBOLS_H
#define __WL3SFX_TXSYMBOLS_H

/**
 * @addtogroup WL3SFX
 * @{
 * @addtogroup WL3SFX_TXSYMBOLS Transmit Symbol Generation
 * @brief Functions for configuration and generating DBPSK transmit symbols for the Sigfox uplink.
 * @{
 */

#define WL3SFX_TXSYMBOLS_COUPLES 40
#define WL3SFX_TXSYMBOLS_BUFFERSIZE (WL3SFX_TXSYMBOLS_COUPLES * 2)

/** Type of DBPSK transmit symbol */
typedef enum {
  /** Zero, i.e. 180 degrees phase shift */
  WL3SFX_TXSYMBOL_ZERO = 0,

  /** One, i.e. no phase shift */
  WL3SFX_TXSYMBOL_ONE,

  /** After-frame ramp-down part 1 */
  WL3SFX_TXSYMBOL_AFTERFRAME1,

  /** After-frame ramp-down part 2 */
  WL3SFX_TXSYMBOL_AFTERFRAME2,

  /** After-frame ramp-down part 3, output power zero */
  WL3SFX_TXSYMBOL_AFTERFRAME3,

  /** After-frame ramp-down part 4, output power zero */
  WL3SFX_TXSYMBOL_AFTERFRAME4,

  /** Before-frame ramp-up part 1 */
  WL3SFX_TXSYMBOL_BEFOREFRAME1,

  /** Before-frame ramp-up part 2 */
  WL3SFX_TXSYMBOL_BEFOREFRAME2
} WL3SFX_TXSymbols_Type;

/**
 * @brief Generate databuffer content for given type of symbol (DBPSK one / zero or ramp).
 *
 * @param[in] type Type of symbol (e.g. one / zero / part of ramp-up / part of ramp-down)
 * @param[in] settings Pulse-shaping settings determined by front-end module configuration
 * @param[out] target Databuffer that symbol is written to
 *
 * @retval None
 */
void wl3sfx_txsymbols_generate(
  WL3SFX_TXSymbols_Type type, const WL3SFX_FEM_PulseShapingSettings* settings, volatile uint8_t target[WL3SFX_TXSYMBOLS_BUFFERSIZE]);

/**
 * @brief Reduce output power by some specified amount
 *
 * @param[in] reduction Power reduction, in dBm
 *
 * @retval None
 */
void wl3sfx_txsymbols_set_power_reduction(int8_t reduction);

/** @}@} */

#endif