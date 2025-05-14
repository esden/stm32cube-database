[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_pn9tx.c
  * @author  GPM WBL Application Team
  * @brief   Automatic, interrupt-based generator for a pseudorandom (PN9) sequence of Sigfox DBPSK symbols.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stdint.h>

#include "wl3sfx_databuffers.h"
#include "wl3sfx_txsymbols.h"
#include "wl3sfx_pn9tx.h"
#include "wl3sfx_fem.h"
#include "wl3sfx_log.h"
#include "wl3sfx_it.h"

#include "sigfox_types.h"
#include "sigfox_api.h"

#include "stm32wl3x_hal.h"

/*  ----------------------------- Static (Private) State ----------------------------- */
static uint16_t _current_pn9;
static uint8_t _current_pn9_bitindex;

/*  ----------------------------- Static Helper Functions ----------------------------- */
static void _pn9_init(void)
{
  _current_pn9 = 0x01ff;
  _current_pn9_bitindex = 8;
}

static void _pn9_next(uint16_t* last)
{
  uint16_t retval;
  retval = (((*last & 0x20) >> 5) ^ *last) << 8;
  retval |= (*last >> 1) & 0xff;
  *last = retval & 0x1ff;
}

static uint16_t _pn9_next_byte(uint16_t state)
{
  for (int i = 0; i < 8; i++)
    _pn9_next(&state);

  return state;
}

static void _databuffer_interrupt()
{
  /* Generate next bit to transmit according to PN9 sequence */
  uint8_t bit = (_current_pn9 >> _current_pn9_bitindex) & 0x01;
  if (_current_pn9_bitindex == 0) {
    _current_pn9_bitindex = 8;
    _current_pn9 = _pn9_next_byte(_current_pn9);
  } else {
    _current_pn9_bitindex--;
  }

  /* Copy matching DBPSK symbol for current bit to data buffer */  
  WL3SFX_FEM_PulseShapingSettings settings;
  wl3sfx_fem_get_pulse_shaping_settings(&settings);
  wl3sfx_txsymbols_generate(bit ? WL3SFX_TXSYMBOL_ONE : WL3SFX_TXSYMBOL_ZERO, &settings, wl3sfx_databuffers_get(wl3sfx_databuffers_current()));
}

/*  ----------------------------- WL3SFX_PN9TX API ----------------------------- */
void wl3sfx_pn9tx_start(void)
{
  /* Use common databuffers */
  wl3sfx_databuffers_use(WL3SFX_TXSYMBOLS_BUFFERSIZE);

  /* Initialize databuffer used interrupt */
  wl3sfx_it_register(WL3SFX_IT_PN9TX,
    MR_SUBG_GLOB_DYNAMIC_RFSEQ_IRQ_ENABLE_DATABUFFER0_USED_E | MR_SUBG_GLOB_DYNAMIC_RFSEQ_IRQ_ENABLE_DATABUFFER1_USED_E,
    _databuffer_interrupt);

  /* Initialize PN9 generator */
  _pn9_init();
}

void wl3sfx_pn9tx_stop(void)
{
  wl3sfx_it_unregister(WL3SFX_IT_PN9TX);
}