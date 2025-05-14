[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_rf_api.c
  * @author  GPM WBL Application Team
  * @brief   Application configuration file for STM32WPAN Middleware
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stdint.h>

#include "stm32wl3x_hal.h"

#include "wl3sfx_nvm_boarddata.h"
#include "wl3sfx_databuffers.h"
#include "wl3sfx_txsymbols.h"
#include "wl3sfx_rf_state.h"
#include "wl3sfx_timer.h"
#include "wl3sfx_pn9tx.h"
#include "wl3sfx_log.h"
#include "wl3sfx_oob.h"
#include "wl3sfx_fem.h"
#include "wl3sfx_it.h"

#include "sigfox_types.h"
#include "sigfox_api.h"
#include "rf_api.h"

/*  ----------------------------- Private static variables ----------------------------- */

/* MCU_API Version Information */
static const uint8_t _api_version[] = { 'v', '1', '.', '0', '.', '0' };

/* Stores whether radio configuration for listen-before-talk (LBT) carrier sensing is currently active */
static uint8_t _lbt_active = 0;

/*  ----------------------------- Private helper functions ----------------------------- */
/*
 * TX DBPSK Modulator Helpers
 */
static void _tx_wait_symbol(void)
{
  uint8_t buf = wl3sfx_databuffers_current();
  while (buf == wl3sfx_databuffers_current()) {};
}

static void _tx_add_beforeframe(const WL3SFX_FEM_PulseShapingSettings* settings)
{
  wl3sfx_txsymbols_generate(WL3SFX_TXSYMBOL_BEFOREFRAME1, settings, wl3sfx_databuffers_get(wl3sfx_databuffers_current()));
  wl3sfx_txsymbols_generate(WL3SFX_TXSYMBOL_BEFOREFRAME2, settings, wl3sfx_databuffers_get(!wl3sfx_databuffers_current()));
}

static void _tx_add_afterframe(const WL3SFX_FEM_PulseShapingSettings* settings)
{
  _tx_wait_symbol();
  wl3sfx_txsymbols_generate(WL3SFX_TXSYMBOL_AFTERFRAME1, settings, wl3sfx_databuffers_get(!wl3sfx_databuffers_current()));
  _tx_wait_symbol();
  wl3sfx_txsymbols_generate(WL3SFX_TXSYMBOL_AFTERFRAME2, settings, wl3sfx_databuffers_get(!wl3sfx_databuffers_current()));
  _tx_wait_symbol();
  wl3sfx_txsymbols_generate(WL3SFX_TXSYMBOL_AFTERFRAME3, settings, wl3sfx_databuffers_get(!wl3sfx_databuffers_current()));
  _tx_wait_symbol();
  wl3sfx_txsymbols_generate(WL3SFX_TXSYMBOL_AFTERFRAME4, settings, wl3sfx_databuffers_get(!wl3sfx_databuffers_current()));
}

static void _tx_add_symbol(const WL3SFX_FEM_PulseShapingSettings* settings, uint8_t value)
{
  _tx_wait_symbol();
  wl3sfx_txsymbols_generate(value ? WL3SFX_TXSYMBOL_ONE : WL3SFX_TXSYMBOL_ZERO, settings, wl3sfx_databuffers_get(!wl3sfx_databuffers_current()));
}

/*  ----------------------------- Sigfox RF_API Implementation ----------------------------- */
sfx_u8 RF_API_init(sfx_rf_mode_t rf_mode)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called %d %d", rf_mode, _lbt_active);

  if (rf_mode == SFX_RF_MODE_RX) {
    /* Configure intermediate frequency (IF) to 300kHz through IF_CTRL */
    static const uint32_t if_hz = 300000;
    uint32_t if_reg = if_hz * 4 * (1ull << 8) / 16000000ul * (1ull << 6);
    MODIFY_REG_FIELD(MR_SUBG_GLOB_STATIC->IF_CTRL, MR_SUBG_GLOB_STATIC_IF_CTRL_IF_OFFSET_ANA, if_reg);
    MODIFY_REG_FIELD(MR_SUBG_GLOB_STATIC->IF_CTRL, MR_SUBG_GLOB_STATIC_IF_CTRL_IF_OFFSET_DIG, if_reg);

    /*
     * RX Radio Initialization:
     * --> GFSK modulation
     * --> 600bps baud rate
     * --> 800 Hz frequency deviation
     * --> Small channel bandwidth (2.1kHz)
     * --> Bitrate 500: Byte couples are sampled from the Databuffer at 8 times this rate, i.e. 4000Hz.
     * --> Databuffer mode
     */
    HAL_MRSubG_SetModulation(MOD_2GFSK1, 0);
    HAL_MRSubG_SetDatarate(600);
    HAL_MRSubG_SetFrequencyDev(800);
    HAL_MRSubG_SetChannelBW(2100);

    static MRSubG_PcktBasicFields rxPacketBasicInit = { .PreambleLength = 0,
      .PostambleLength = 0,
      .SyncLength = 15,
      .SyncWord = 0xb2270000,
      .FixVarLength = FIXED,
      .PreambleSequence = PRE_SEQ_0101,
      .CrcMode = PKT_NO_CRC,
      .Coding = CODING_NONE,
      .DataWhitening = DISABLE,
      .SyncPresent = ENABLE };

    /* Perform VCO calibration */
    SET_BIT(MR_SUBG_GLOB_DYNAMIC->VCO_CAL_CONFIG, MR_SUBG_GLOB_DYNAMIC_VCO_CAL_CONFIG_VCO_CALIB_REQ);

    /*
     * RX Payload configuration:
     * --> Set Databuffer size
     * --> Set PCKTLEN = 15 for 15-byte RX
     */
    HAL_MRSubG_PacketBasicInit(&rxPacketBasicInit);
    __HAL_MRSUBG_SET_RX_MODE(RX_NORMAL);
    MODIFY_REG_FIELD(MR_SUBG_GLOB_DYNAMIC->PCKTLEN_CONFIG, MR_SUBG_GLOB_DYNAMIC_PCKTLEN_CONFIG_PCKTLEN, 15);

    /*
     * RX detection / loop configuration
     * --> RSSI_THR = 44 (corresponds to -139dBm detection threshold)
     * --> Tune parameters for best performance.
     */
    MR_SUBG_RADIO->AFC2_CONFIG = 0x00;
    MODIFY_REG_FIELD(MR_SUBG_GLOB_STATIC->AS_QI_CTRL, MR_SUBG_GLOB_STATIC_AS_QI_CTRL_RSSI_THR, 44);
    MR_SUBG_RADIO->CLKREC_CTRL0 = 0xb0;
    MR_SUBG_RADIO->CLKREC_CTRL0 = 0x10;

    /* No timeout: Timeout is handled by RTC timer */
    MODIFY_REG_FIELD(MR_SUBG_GLOB_DYNAMIC->RX_TIMER, MR_SUBG_GLOB_DYNAMIC_RX_TIMER_RX_TIMEOUT, 0);
  } else if ((rf_mode == SFX_RF_MODE_TX || rf_mode == SFX_RF_MODE_CS200K_RX || rf_mode == SFX_RF_MODE_CS300K_RX) && !_lbt_active) {
    /*
     * TX initialization is performed either:
     * - when the Sigfox library calls RF_API_init with SFX_RF_MODE_TX
     * - when the Sigfox library calls RF_API_init with SFX_RF_MODE_CS200K_RX or SFX_RF_MODE_CS300K_RX
     * In the latter case, the Sigfox library wants to perform carrier sensing before TX.
     *
     * However, to make sure that we are fast enough when switching from RX to TX after carrier sensing,
     * we already initialize all TX-related registers before actually transmitting.
     * If this is the case, we store this information in the static _lbt_active variable.
     */

    /* Perform VCO calibration */
    SET_BIT(MR_SUBG_GLOB_DYNAMIC->VCO_CAL_CONFIG, MR_SUBG_GLOB_DYNAMIC_VCO_CAL_CONFIG_VCO_CALIB_REQ);

    /*
     * TX Radio Initialization:
     * --> Direct polar mode
     * --> Bitrate 500: Byte couples are sampled from the Databuffer at 8 times this rate, i.e. 4000Hz.
     * --> Programmed frequency deviation: 2000 Hz. For an instanteneous frequency deviation of f_{dev_fifo_sample}
     * = 127 / -128, this should result in a 180 degrees phase shift.
     * --> Databuffer mode
     */
    HAL_MRSubG_SetModulation(MOD_POLAR, 0);
    HAL_MRSubG_SetFrequencyDev(2000);
    MODIFY_REG_FIELD(MR_SUBG_GLOB_STATIC->PCKT_CTRL, MR_SUBG_GLOB_STATIC_PCKT_CTRL_TX_MODE, 0x1);
    MODIFY_REG_FIELD(MR_SUBG_GLOB_DYNAMIC->MOD0_CONFIG, MR_SUBG_GLOB_DYNAMIC_MOD0_CONFIG_PA_CLKON_LOCKONTX, 0x1u);

    /*
     * Integrated power amplifier (PA) configuration
     * MR_SUBG_GLOB_STATIC_PA_CONFIG_PA_MODE = 0x00: default
     * MR_SUBG_GLOB_STATIC_PA_CONFIG_PA_DRV_MODE: 0x2: 14 dBm, 0x3: 20dBm
     */
    MODIFY_REG_FIELD(MR_SUBG_GLOB_STATIC->PA_CONFIG, MR_SUBG_GLOB_STATIC_PA_CONFIG_PA_MODE, 0x00);
#if defined(WL3SFX_PA_DRV_MODE_20dBm)
    LL_PWR_SMPS_SetOutputVoltageLevel(LL_PWR_SMPS_OUTPUT_VOLTAGE_1V70);
    MODIFY_REG_FIELD(MR_SUBG_GLOB_STATIC->PA_CONFIG, MR_SUBG_GLOB_STATIC_PA_CONFIG_PA_DRV_MODE, 0x3);
#elif defined(WL3SFX_PA_DRV_MODE_14dBm)
    MODIFY_REG_FIELD(MR_SUBG_GLOB_STATIC->PA_CONFIG, MR_SUBG_GLOB_STATIC_PA_CONFIG_PA_DRV_MODE, 0x2);
#else
#if defined(__GNUC__)
#pragma GCC warning "WL3SFX: No PA_DRV_MODE configuration!"
#else
#warning "WL3SFX: No PA_DRV_MODE configuration!"
#endif
#endif
    MODIFY_REG_FIELD(MR_SUBG_GLOB_STATIC->PA_CONFIG, MR_SUBG_GLOB_STATIC_PA_CONFIG_PA_INTERP_EN, 0);

    /*
     * TX Payload configuration:
     * --> Set PCKTLEN = 0 for infinite TX
     * --> Use allocated databuffers
     */
    MODIFY_REG_FIELD(MR_SUBG_GLOB_DYNAMIC->PCKTLEN_CONFIG, MR_SUBG_GLOB_DYNAMIC_PCKTLEN_CONFIG_PCKTLEN, 0);

    /* if carrier sensing before TX, initialize carrier sensing RX registers */
    if (rf_mode == SFX_RF_MODE_CS200K_RX || rf_mode == SFX_RF_MODE_CS300K_RX) {
      /* Perform VCO calibration */
      SET_BIT(MR_SUBG_GLOB_DYNAMIC->VCO_CAL_CONFIG, MR_SUBG_GLOB_DYNAMIC_VCO_CAL_CONFIG_VCO_CALIB_REQ);

      /* Configure intermediate frequency (IF) through IF_CTRL */
      static const uint32_t if_hz = 600000;
      uint32_t if_reg = if_hz * 4 * (1ull << 8) / 16000000ul * (1ull << 6);

      MODIFY_REG_FIELD(MR_SUBG_GLOB_STATIC->IF_CTRL, MR_SUBG_GLOB_STATIC_IF_CTRL_IF_OFFSET_ANA, if_reg);
      MODIFY_REG_FIELD(MR_SUBG_GLOB_STATIC->IF_CTRL, MR_SUBG_GLOB_STATIC_IF_CTRL_IF_OFFSET_DIG, if_reg);

      /* Configure channel filter depending on carrier sense bandwidth */
      HAL_MRSubG_SetChannelBW(rf_mode == SFX_RF_MODE_CS200K_RX ? 200000 : 300000);

      /* RX Mode */
      __HAL_MRSUBG_SET_RX_MODE(RX_NORMAL);

      /* remember that LBT mode is currently active */
      _lbt_active = 1;
    }
  } else if (rf_mode == SFX_RF_MODE_MONARCH) {
    /*
     * Reset status flags
     */
    MR_SUBG_GLOB_STATUS->RFSEQ_IRQ_STATUS = 0xffffffff;

    /* Perform VCO calibration */
    SET_BIT(MR_SUBG_GLOB_DYNAMIC->VCO_CAL_CONFIG, MR_SUBG_GLOB_DYNAMIC_VCO_CAL_CONFIG_VCO_CALIB_REQ);

    /* Configure intermediate frequency (IF) to 600kHz through IF_CTRL */
    static const uint32_t if_hz = 600000ul;
    uint32_t if_reg = if_hz * 4ul * (1ul << 8ul) / 16000000ul * (1ul << 6ul);
    MODIFY_REG_FIELD(MR_SUBG_GLOB_STATIC->IF_CTRL, MR_SUBG_GLOB_STATIC_IF_CTRL_IF_OFFSET_ANA, if_reg);
    MODIFY_REG_FIELD(MR_SUBG_GLOB_STATIC->IF_CTRL, MR_SUBG_GLOB_STATIC_IF_CTRL_IF_OFFSET_DIG, if_reg);

    // Note: The monarch channel bandwidth may need to be adapted depending on XTAL stability
    HAL_MRSubG_SetChannelBW(33700ul);
    HAL_MRSubG_SetDatarate(16384ul);
    HAL_MRSubG_SetModulation(MOD_OOK, 0);

    /* Configure OOK Peak Decay = 0, RSSI_FLT = 14, RSSI_TH = 10 (corresponding to -156dBm) */
    /*MODIFY_REG_FIELD(MR_SUBG_GLOB_STATIC->AS_QI_CTRL, MR_SUBG_GLOB_STATIC_AS_QI_CTRL_RSSI_THR, 10);*/
    MODIFY_REG_FIELD(MR_SUBG_RADIO->RSSI_FLT, MR_SUBG_RADIO_RSSI_FLT_OOK_PEAK_DECAY, 0x3);
    MODIFY_REG_FIELD(MR_SUBG_RADIO->RSSI_FLT, MR_SUBG_RADIO_RSSI_FLT_RSSI_FLT, 14);

    /* No SubGHz hardware timeout: Timeout is handled in software */
    MODIFY_REG_FIELD(MR_SUBG_GLOB_DYNAMIC->RX_TIMER, MR_SUBG_GLOB_DYNAMIC_RX_TIMER_RX_TIMEOUT, 0);

    /* Switch to databuffer mode */
    __HAL_MRSUBG_SET_RX_MODE(RX_DIRECT_BUFFERS);

    /*
     * AGC measure time must be at least 1/1024s (max. OOK pattern period), but should not be much larger than that
     * to avoid "blank" times; therefore, choose AGC_MEAS_TIME = 14, corresponding to 4.096ms.
     */
    MODIFY_REG_FIELD(MR_SUBG_RADIO->AGC1_CTRL, MR_SUBG_RADIO_AGC1_CTRL_AGC_MIN_THR, 2);
    MODIFY_REG_FIELD(MR_SUBG_RADIO->AGC1_CTRL, MR_SUBG_RADIO_AGC1_CTRL_AGC_MAX_THR, 6);

    MODIFY_REG_FIELD(MR_SUBG_RADIO->AGC2_CTRL, MR_SUBG_RADIO_AGC2_CTRL_AGC_FREEZE_ON_STEADY, 1);
    MODIFY_REG_FIELD(MR_SUBG_RADIO->AGC2_CTRL, MR_SUBG_RADIO_AGC2_CTRL_AGC_START_MAX_ATTEN, 0);
    MODIFY_REG_FIELD(MR_SUBG_RADIO->AGC2_CTRL, MR_SUBG_RADIO_AGC2_CTRL_AGC_MEAS_TIME, 0xd);

    MODIFY_REG_FIELD(MR_SUBG_RADIO->AGC3_CTRL, MR_SUBG_RADIO_AGC3_CTRL_AGC_MAX_ATTEN, 9);
    MODIFY_REG_FIELD(MR_SUBG_RADIO->AGC3_CTRL, MR_SUBG_RADIO_AGC3_CTRL_AGC_MIN_ATTEN, 0);

    MODIFY_REG_FIELD(MR_SUBG_RADIO->AGC4_CTRL, MR_SUBG_RADIO_AGC4_CTRL_AGC_FREEZE_THR, 4);
  }

  _lbt_active = (rf_mode == SFX_RF_MODE_CS200K_RX || rf_mode == SFX_RF_MODE_CS300K_RX);

  return SFX_ERR_NONE;
}

sfx_u8 RF_API_stop(void)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  wl3sfx_rf_state_transition(WL3SFX_RF_STATE_IDLE);
  wl3sfx_it_unregister_all();

  return SFX_ERR_NONE;
}

sfx_u8 RF_API_send(sfx_u8* stream, sfx_modulation_type_t type, sfx_u8 size)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");
  wl3sfx_log_bytearray(WL3SFX_SEV_INFO, "stream = ", stream, size);

  /* depending on front-end module, have to use different pulse shapes */
  WL3SFX_FEM_PulseShapingSettings settings;
  wl3sfx_fem_get_pulse_shaping_settings(&settings);
  wl3sfx_log(WL3SFX_SEV_INFO, "gF1: %d, gF2: %d, mP: %d", settings.gainFactor1, settings.gainFactor2, settings.maxPower);

  /* select DBPSK data rate (100bps vs 600bps) */
  HAL_MRSubG_SetDatarate(type == SFX_DBPSK_100BPS ? 500 : 3000);

  /* Use common databuffers, set databuffer size */
  wl3sfx_databuffers_use(WL3SFX_TXSYMBOLS_BUFFERSIZE);

  /* add "Extra Symbol Before Frame" ramp-up */
  _tx_add_beforeframe(&settings);
  wl3sfx_rf_state_transition(WL3SFX_RF_STATE_TX);

  for (size_t byte_idx = 0; byte_idx < size; ++byte_idx)
    for (int8_t bit_idx = 7; bit_idx >= 0; --bit_idx)
      _tx_add_symbol(&settings, (1 << bit_idx) & stream[byte_idx]);

  /*
   * Now, towards the end of the transmission, battery voltage should be the worst (lowest)
   * This moment is a good opportunity to measure it and store it for a potential OOB frame later on
   */
  wl3sfx_oob_update_tx_voltage();

  /*
   * Start 500ms inter-frame timer *now*, just in case there is another TX frame;
   * 250ms of the inter-frame period are spent in DEEPSTOP, the rest is spent awake so that XTAL can stabilize.
   * Do not shorten this time, or performance will deteriorate.
   */
  wl3sfx_timer_start_milliseconds(WL3SFX_TIMER_INTERFRAME_WAKEUP, 250, NULL);
  wl3sfx_timer_start_milliseconds(WL3SFX_TIMER_INTERFRAME, 500, NULL);

  _tx_add_afterframe(&settings);

  return SFX_ERR_NONE;
}

sfx_u8 RF_API_start_continuous_transmission(sfx_modulation_type_t type)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  sfx_u8 err = SFX_ERR_NONE;

  if (type == SFX_NO_MODULATION) {
    /*
     * Simply use radio's integrated continuous CW mode.
     * Frequency selection and TX RF initialization is performed by the Sigfox library beforehand.
     */
    HAL_MRSubG_SetModulation(MOD_CW, 0);
  } else if (type == SFX_DBPSK_100BPS || type == SFX_DBPSK_600BPS) {
    /* depending on front-end module, have to use different pulse shapes */
    WL3SFX_FEM_PulseShapingSettings settings;
    wl3sfx_fem_get_pulse_shaping_settings(&settings);

    /* Configure data rate */
    HAL_MRSubG_SetDatarate(type == SFX_DBPSK_100BPS ? 500 : 3000);

    /*
     * Add ramp-up for the first two databuffers, then rely on PN9
     * signal generator engine for generating arbitrary DPBSK signal.
     */
    _tx_add_beforeframe(&settings);
    wl3sfx_pn9tx_start();
  } else {
    err = SFX_ERR_API_START_CONTINUOUS_TRANSMISSION;
  }

  /* If RF configuration was successful, actually start transmission */
  if (err == SFX_ERR_NONE)
    wl3sfx_rf_state_transition(WL3SFX_RF_STATE_TX);

  return SFX_ERR_NONE;
}

sfx_u8 RF_API_stop_continuous_transmission(void)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  /* depending on front-end module, have to use different pulse shapes */
  WL3SFX_FEM_PulseShapingSettings settings;
  wl3sfx_fem_get_pulse_shaping_settings(&settings);

  /* Add ramp-down, but only if modulation is DBPSK (not CW test) */
  if (HAL_MRSubG_GetModulation() != MOD_CW) {
    wl3sfx_pn9tx_stop();
    _tx_add_afterframe(&settings);
  }

  return SFX_ERR_NONE;
}

sfx_u8 RF_API_change_frequency(sfx_u32 frequency)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");
  wl3sfx_log(WL3SFX_SEV_INFO, "target frequency = %ld Hz", frequency);

  HAL_MRSubG_SetFrequencyBase(frequency);

  return SFX_ERR_NONE;
}

sfx_u8 RF_API_wait_frame(sfx_u8* frame, sfx_s16* rssi, sfx_rx_state_enum_t* state)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  /* Use common databuffers, but RX frame size is only 15 bytes */
  wl3sfx_databuffers_use(15);
  wl3sfx_rf_state_transition(WL3SFX_RF_STATE_RX);

  /* Reset IRQ status register */
  MR_SUBG_GLOB_STATUS->RFSEQ_IRQ_STATUS = 0xffffffff;

  while (1) {
    uint32_t irq = READ_REG(MR_SUBG_GLOB_STATUS->RFSEQ_IRQ_STATUS);

    if (irq & MR_SUBG_GLOB_STATUS_RFSEQ_IRQ_STATUS_RX_OK_F) {
      /* downlink was received successfully */
      MR_SUBG_GLOB_STATUS->RFSEQ_IRQ_STATUS = MR_SUBG_GLOB_STATUS_RFSEQ_IRQ_STATUS_RX_OK_F;

      /* read RSSI */
      uint16_t rssi_raw = READ_REG(MR_SUBG_GLOB_STATUS->RX_INDICATOR) & MR_SUBG_GLOB_STATUS_RX_INDICATOR_RSSI_LEVEL_ON_SYNC;
      int32_t rssi_offset = 0;
      wl3sfx_nvm_boarddata_get(WL3SFX_BOARDDATA_RSSI_OFFSET, &rssi_offset);
      *rssi = rssi_raw / 2 - 161 + rssi_offset;

      *state = DL_PASSED;

      /* copy received frame from databuffer to frame buffer */
      volatile uint8_t* databuffer = wl3sfx_databuffers_get(wl3sfx_databuffers_current());
      for (uint8_t i = 0; i < 15; ++i)
        frame[i] = databuffer[i];

      /* log raw received data */
      wl3sfx_log(WL3SFX_SEV_INFO, "RX received");
      wl3sfx_log_bytearray(WL3SFX_SEV_INFO, "received frame: ", frame, 15);

      break;
    } else if (wl3sfx_timer_expired(WL3SFX_TIMER_GENERIC) && !(irq & MR_SUBG_GLOB_STATUS_RFSEQ_IRQ_STATUS_SYNC_VALID_F)) {
      /* abort RX with timeout - but only, if SYNC_VALID valid is not set */
      *state = DL_TIMEOUT;
      wl3sfx_log(WL3SFX_SEV_WARN, "RX timeout");
      break;
    }
  }

  return SFX_ERR_NONE;
}

sfx_u8 RF_API_wait_for_clear_channel(sfx_u8 cs_min, sfx_s8 cs_threshold, sfx_rx_state_enum_t* state)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");
  wl3sfx_log(WL3SFX_SEV_INFO, "cs_min = %d ms, cs_threshold = %d dB", cs_min, cs_threshold);

  /* RSSI threshold setting, static carrier sensing */
  int32_t rssi_offset = 0;
  int32_t lbt_thr_offset = 0;
  wl3sfx_nvm_boarddata_get(WL3SFX_BOARDDATA_RSSI_OFFSET, &rssi_offset);
  wl3sfx_nvm_boarddata_get(WL3SFX_BOARDDATA_LBT_THR_OFFSET, &lbt_thr_offset);
  wl3sfx_log(WL3SFX_SEV_INFO, "rssi_offset = %d dB", rssi_offset);
  wl3sfx_log(WL3SFX_SEV_INFO, "lbt_thr_offset = %d dB", lbt_thr_offset);
  uint8_t rssi_thr = ((int16_t)cs_threshold + (int16_t)161 - rssi_offset - lbt_thr_offset) * 2;
  MODIFY_REG_FIELD(MR_SUBG_GLOB_STATIC->AS_QI_CTRL, MR_SUBG_GLOB_STATIC_AS_QI_CTRL_RSSI_THR, rssi_thr);
  MODIFY_REG_FIELD(MR_SUBG_GLOB_STATIC->AS_QI_CTRL, MR_SUBG_GLOB_STATIC_AS_QI_CTRL_CS_MODE, 0);

  /* Stop the timer at RSSI above THR */
  SET_BIT(MR_SUBG_GLOB_DYNAMIC->RX_TIMER, MR_SUBG_GLOB_DYNAMIC_RX_TIMER_RX_CS_TIMEOUT_MASK);

  /* Start RX with timeout - calibrate LSI to 16MHz clock */
  uint16_t slow_clock_freq = 32000;
  uint16_t scm_counter_currval = READ_REG_FIELD(MR_SUBG_GLOB_MISC->SCM_COUNTER_VAL, MR_SUBG_GLOB_MISC_SCM_COUNTER_VAL_SCM_COUNTER_CURRVAL);
  if (scm_counter_currval != 0)
    slow_clock_freq = 32ull * 16000000ull / scm_counter_currval;
  uint32_t interpolated_absolute_time = 16u * slow_clock_freq;
  uint16_t rx_timeout = interpolated_absolute_time * cs_min / 1000;

  MODIFY_REG_FIELD(MR_SUBG_GLOB_DYNAMIC->RX_TIMER, MR_SUBG_GLOB_DYNAMIC_RX_TIMER_RX_TIMEOUT, rx_timeout);
  MR_SUBG_GLOB_STATUS->RFSEQ_IRQ_STATUS = 0xffffffff;
  wl3sfx_rf_state_transition(WL3SFX_RF_STATE_RX);

  *state = DL_TIMEOUT;
  while (*state != DL_PASSED && !wl3sfx_timer_expired(WL3SFX_TIMER_CS)) {
    /*
     * Wait until either:
     * --> CDT_F flag is raised, i.e. the RSSI is above the threshold, channel is occupied (retry...)
     * --> RX_TIMEOUT_F flag is raised, i.e. channel has been clear for a duration of RX_TIMEOUT, can transmit :)
     * --> carrier sense timer timeout occurs, i.e. channel has not been clear for a while now, abort :(
     */
    while ((MR_SUBG_GLOB_STATUS->RFSEQ_IRQ_STATUS & MR_SUBG_GLOB_STATUS_RFSEQ_IRQ_STATUS_RX_TIMEOUT_F) == 0
      && (MR_SUBG_GLOB_STATUS->RFSEQ_IRQ_STATUS & MR_SUBG_GLOB_STATUS_RFSEQ_IRQ_STATUS_RXTIMER_STOP_CDT_F) == 0
      && !wl3sfx_timer_expired(WL3SFX_TIMER_CS)) {};

    if (READ_BIT(MR_SUBG_GLOB_STATUS->RFSEQ_IRQ_STATUS, MR_SUBG_GLOB_STATUS_RFSEQ_IRQ_STATUS_RXTIMER_STOP_CDT_F)) {
      /* Clear interrupt flags */
      MR_SUBG_GLOB_STATUS->RFSEQ_IRQ_STATUS = 0xffffffff;

      /* RSSI is *over* threshold (CS_F must have been raised), have to keep waiting :( ... Retry. */
      MODIFY_REG_FIELD(MR_SUBG_GLOB_DYNAMIC->RX_TIMER, MR_SUBG_GLOB_DYNAMIC_RX_TIMER_RX_TIMEOUT, rx_timeout);
      __HAL_MRSUBG_STROBE_CMD(CMD_RELOAD_RX_TIMER);
    } else if (READ_BIT(MR_SUBG_GLOB_STATUS->RFSEQ_IRQ_STATUS, MR_SUBG_GLOB_STATUS_RFSEQ_IRQ_STATUS_RX_TIMEOUT_F)) {
      /* RSSI has been *below* threshold for whole RX timeout duration :), we are clear to transmit. */
      *state = DL_PASSED;
    }
  }

  if (*state == DL_TIMEOUT) {
    wl3sfx_log(WL3SFX_SEV_WARN, "Giving up on carrier sense, channel is blocked");
  }

  return SFX_ERR_NONE;
}

sfx_u8 RF_API_get_version(sfx_u8** version, sfx_u8* size)
{
  wl3sfx_log(WL3SFX_SEV_TRACE, "called");

  *version = (sfx_u8*)_api_version;
  *size = sizeof(_api_version);

  return SFX_ERR_NONE;
}
