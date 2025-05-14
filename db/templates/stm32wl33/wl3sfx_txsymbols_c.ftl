[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_txsymbols.c
  * @author  GPM WBL Application Team
  * @brief   Manages the generation of DBPSK symbols for Sigfox uplink transmissions.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stdint.h>
#include <string.h>

#include "wl3sfx_databuffers.h"
#include "wl3sfx_txsymbols.h"
#include "wl3sfx_fem.h"
#include "wl3sfx_log.h"

/*  ------------------------------ Static state variables ------------------------------ */
int8_t _power_reduction;

/*  ----------------------------- Static helper functions ------------------------------ */
/* subtract, but saturate at 0 */
static uint8_t _subtract_saturate(uint8_t subtrahend, uint8_t minuend)
{
  return (minuend < subtrahend) ? (subtrahend - minuend) : 0;
}

/*  ---------------------------- Public function interface ---------------------------- */
void wl3sfx_txsymbols_generate(
  WL3SFX_TXSymbols_Type type, const WL3SFX_FEM_PulseShapingSettings* settings, volatile uint8_t target[WL3SFX_TXSYMBOLS_BUFFERSIZE])
{
  const uint8_t start_stop_ramp[] = { 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 80, 80, 80, 80, 80, 80, 80,
    80, 79, 79, 79, 79, 79, 79, 79, 78, 78, 78, 78, 78, 78, 77, 77, 77, 77, 77, 76, 76, 76, 76, 76, 75, 75, 75, 75, 74, 74, 73, 73, 72, 72,
    71, 71, 69, 69, 67, 66, 65, 64, 62, 60, 58, 56, 51, 47, 42, 37, 31, 22, 15, 12, 2, 0, 0, 0, 0, 0, 0, 0, 0 };

  uint8_t j = 0;

  switch (type) {
  case WL3SFX_TXSYMBOL_ZERO: {
    /*
     * 40 phase / power couples:
     * [ 0 -  7] constant maxPower
     * [ 8 - 24] ramp-down
     * [   24  ] phase shift
     * [24 - 39] ramp-up
     */
    uint8_t pulseShape[] = { 81, 81, 80, 80, 79, 78, 76, 74, 71, 68, 63, 59, 55, 51, 38, 0 };

    if (settings->gainFactor1 == 0x00) {
      pulseShape[9] = 67;
      pulseShape[10] = 62;
      pulseShape[11] = 58;
      pulseShape[12] = 52;
      pulseShape[13] = 43;
      pulseShape[14] = 28;
    }

    // reduce ramp-up / ramp-down power if specified
    for (uint8_t i = 0; i < 15; i++)
      pulseShape[i] -= settings->gainFactor1;

    // constant maxPower
    for (j = 0; j < 8; ++j) {
      target[2 * j + 0] = 0;
      target[2 * j + 1] = settings->maxPower;
    }

    // ramp-down
    for (j = 0; j < sizeof(pulseShape); ++j) {
      target[8 * 2 + 2 * j + 0] = 0;
      target[8 * 2 + 2 * j + 1] = pulseShape[j];
    }

    // ramp-up
    for (j = 0; j < sizeof(pulseShape); ++j) {
      target[WL3SFX_TXSYMBOLS_BUFFERSIZE - 2 * j - 2] = 0;
      target[WL3SFX_TXSYMBOLS_BUFFERSIZE - 2 * j - 1] = pulseShape[j];
    }

    // 180deg phase shift
    target[48] = 0x80;

    break;
  }

  case WL3SFX_TXSYMBOL_ONE: {
    /*
     * 40 phase / power couples:
     * [ 0 - 39] constant maxPower
     */
    for (j = 0; j < WL3SFX_TXSYMBOLS_COUPLES; ++j) {
      target[2 * j + 0] = 0;
      target[2 * j + 1] = settings->maxPower;
    }

    break;
  }

  case WL3SFX_TXSYMBOL_AFTERFRAME1: {
    /*
     * 40 phase / power couples:
     * [ 0 -  7] constant maxPower
     * [ 8 - 39] power values 8-39 of start / stop ram
     */
    for (j = 0; j < 8; ++j) {
      target[2 * j + 0] = 0;
      target[2 * j + 1] = settings->maxPower;
    }

    for (j = 8; j < WL3SFX_TXSYMBOLS_COUPLES; ++j) {
      target[2 * j + 0] = 0;
      target[2 * j + 1] = _subtract_saturate(start_stop_ramp[j], settings->gainFactor1 + settings->gainFactor2);
    }

    break;
  }

  case WL3SFX_TXSYMBOL_AFTERFRAME2: {
    /* power values 40-79 of start / stop ramp */
    for (j = 0; j < WL3SFX_TXSYMBOLS_COUPLES; ++j) {
      target[2 * j + 0] = 0;
      target[2 * j + 1] = _subtract_saturate(start_stop_ramp[40 + j], settings->gainFactor1 + settings->gainFactor2);
    }

    break;
  }

  case WL3SFX_TXSYMBOL_AFTERFRAME3:
  case WL3SFX_TXSYMBOL_AFTERFRAME4: {
    /* just a zero symbol to bridge the time until SABORT */
    for (uint8_t i = 0; i < WL3SFX_TXSYMBOLS_BUFFERSIZE; ++i)
      target[i] = 0;

    break;
  }

  case WL3SFX_TXSYMBOL_BEFOREFRAME1: {
    /* power values 48-87 of start / stop ramp *in reverse* */
    for (j = 0; j < WL3SFX_TXSYMBOLS_COUPLES; ++j) {
      target[2 * j + 0] = 0;
      target[2 * j + 1] = _subtract_saturate(start_stop_ramp[87 - j], settings->gainFactor1 + settings->gainFactor2);
    }

    break;
  }

  case WL3SFX_TXSYMBOL_BEFOREFRAME2: {
    /* power values 8-47 of start / stop ramp *in reverse* */
    for (j = 0; j < WL3SFX_TXSYMBOLS_COUPLES; ++j) {
      target[2 * j + 0] = 0;
      target[2 * j + 1] = _subtract_saturate(start_stop_ramp[47 - j], settings->gainFactor1 + settings->gainFactor2);
    }

    break;
  }
  }

  /* Apply power reduction */
  for (j = 0; j < WL3SFX_TXSYMBOLS_COUPLES; ++j) {
    target[2 * j + 1] = _subtract_saturate(target[2 * j + 1], _power_reduction * 2);
  }
}

void wl3sfx_txsymbols_set_power_reduction(int8_t reduction)
{
  _power_reduction = reduction;
}