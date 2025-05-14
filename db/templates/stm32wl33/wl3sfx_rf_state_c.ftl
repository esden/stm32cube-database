[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_rf_state.c
  * @author  GPM WBL Application Team
  * @brief   Management of the SubGHz state machine's state (Idle / TX / RX) for Sigfox on the STM32WL3.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stdint.h>

#include "stm32wl3x_hal.h"

#include "wl3sfx_rf_state.h"
#include "wl3sfx_fem.h"

static WL3SFX_RF_State _current_state = WL3SFX_RF_STATE_IDLE;

uint8_t wl3sfx_rf_state_transition(WL3SFX_RF_State newstate)
{
  if (newstate == WL3SFX_RF_STATE_IDLE || _current_state == WL3SFX_RF_STATE_IDLE) {
    /* actual transition can only occur from IDLE state into some non-IDLE state and back */
    if (newstate == WL3SFX_RF_STATE_TX) {
      wl3sfx_fem_start_tx();
      __HAL_MRSUBG_STROBE_CMD(CMD_TX);

      while ((MR_SUBG_GLOB_STATUS->RADIO_FSM_INFO & MR_SUBG_GLOB_STATUS_RADIO_FSM_INFO_RADIO_FSM_STATE) != 0x0a) {};
    } else if (newstate == WL3SFX_RF_STATE_RX) {
      wl3sfx_fem_start_rx();
      /* Perform VCO calibration */
      LL_MRSubG_VCOCalibReq(SET);       
      __HAL_MRSUBG_STROBE_CMD(CMD_RX);

      while ((MR_SUBG_GLOB_STATUS->RADIO_FSM_INFO & MR_SUBG_GLOB_STATUS_RADIO_FSM_INFO_RADIO_FSM_STATE) != 0x10) {};
    } else if (newstate == WL3SFX_RF_STATE_IDLE) {
      uint8_t is_idle = (MR_SUBG_GLOB_STATUS->RADIO_FSM_INFO & MR_SUBG_GLOB_STATUS_RADIO_FSM_INFO_RADIO_FSM_STATE) == 0;

      /* wait until radio is actually idle */
      if (!is_idle) {
        __HAL_MRSUBG_STROBE_CMD(CMD_SABORT);
        while ((MR_SUBG_GLOB_STATUS->RFSEQ_IRQ_STATUS & MR_SUBG_GLOB_STATUS_RFSEQ_IRQ_STATUS_SABORT_DONE_F) == 0) {};
        MR_SUBG_GLOB_STATUS->RFSEQ_IRQ_STATUS = MR_SUBG_GLOB_STATUS_RFSEQ_IRQ_STATUS_SABORT_DONE_F;
      }

      wl3sfx_fem_stop();
    } else {
      return WL3SFX_RF_STATE_TRANSITION_INVALID;
    }
  } else if (newstate == WL3SFX_RF_STATE_RX && _current_state == WL3SFX_RF_STATE_RX) {
    /* restart RX when currently already in RX state; when performing multiple receptions in sequence (required for a Sigfox test mode) */
    __HAL_MRSUBG_STROBE_CMD(CMD_RX);

    while ((MR_SUBG_GLOB_STATUS->RADIO_FSM_INFO & MR_SUBG_GLOB_STATUS_RADIO_FSM_INFO_RADIO_FSM_STATE) != 0x10) {};
  } else {
    return WL3SFX_RF_STATE_TRANSITION_ILLEGAL;
  }

  _current_state = newstate;

  return WL3SFX_RF_STATE_TRANSITION_OK;
}