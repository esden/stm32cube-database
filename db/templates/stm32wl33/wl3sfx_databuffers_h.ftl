[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_databuffers.h
  * @author  GPM WBL Application Team
  * @brief   Manages RAM data buffers for the SubGHz Hardware.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include "stm32wl3x_hal.h"

#ifndef __WL3SFX_BUFFERS_H
#define __WL3SFX_BUFFERS_H

/**
 * @addtogroup WL3SFX
 * @{
 * @addtogroup WL3SFX_DATABUFFERS SubGHz Databuffer Management
 * @brief Controls usage and size of SubGHz hardware databuffer for TX / RX and provides buffer contents.
 * @{
 */

/*
 * Allocate static databuffers in RAM. For transmissions, these databuffers are filled
 * with couples of control values that drive the FREQ SYNTH / PA components.
 *
 * These buffers are used for normal TX operation (RF_API_send),
 * RF emission testing (RF_API_start_continuous_transmission) and Monarch.
 *
 * wl3sfx_databuffers_current() indicates which data buffer is currently in use by the SubGHz radio.
 */
#define WL3SFX_DATABUFFERS_SIZE 120

#define wl3sfx_databuffers_current()                                                                                                        \
  (READ_BIT(MR_SUBG_GLOB_STATUS->DATABUFFER_INFO, MR_SUBG_GLOB_STATUS_DATABUFFER_INFO_CURRENT_DATABUFFER) ? 1 : 0)

/** Return state of databuffer functions */
typedef enum {
  /** Request was successful */
  WL3SFX_DATABUFFERS_OK = 0,

  /** Unable to fulfill request, requested databuffer size was too large */
  WL3SFX_DATABUFFERS_TOO_LARGE
} WL3SFX_DATABUFFERS_StatusTypeDef;

/**
 * @brief Tell SubGHz hardware to use data buffers provided by wl3sfx_databuffers
 *
 * @param size Requested databuffer size, may not exceed WL3SFX_DATABUFFERS_SIZE, but may be lower. Both databuffers are the same size.
 *
 * @retval Result of operation, success or type of failure
 */
WL3SFX_DATABUFFERS_StatusTypeDef wl3sfx_databuffers_use(uint32_t size);

/**
 * @brief Reset (clear) databuffers
 *
 * @retval Result of operation, success or type of failure
 */
WL3SFX_DATABUFFERS_StatusTypeDef wl3sfx_databuffers_reset(void);

/**
 * @brief Obtain pointer to DATABUFFER0 or DATABUFFER1
 *
 * @param id: 0 for DATABUFFER0, 1 for DATABUFFER1
 *
 * @retval Pointer to databuffer in memory
 */
volatile uint8_t* wl3sfx_databuffers_get(uint8_t id);

/** @}@} */

#endif