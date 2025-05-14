[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_databuffers.c
  * @author  GPM WBL Application Team
  * @brief   Manages RAM data buffers for the SubGHz Hardware.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include "wl3sfx_databuffers.h"

#ifdef __ICCARM__
#pragma data_alignment = 4
#endif
__ALIGN_BEGIN volatile uint8_t wl3sfx_databuf0[WL3SFX_DATABUFFERS_SIZE] __ALIGN_END;
#ifdef __ICCARM__
#pragma data_alignment = 4
#endif
__ALIGN_BEGIN volatile uint8_t wl3sfx_databuf1[WL3SFX_DATABUFFERS_SIZE] __ALIGN_END;

WL3SFX_DATABUFFERS_StatusTypeDef wl3sfx_databuffers_use(uint32_t size)
{
  if (size > WL3SFX_DATABUFFERS_SIZE)
    return WL3SFX_DATABUFFERS_TOO_LARGE;

  MR_SUBG_GLOB_STATIC->DATABUFFER0_PTR = (uint32_t)&wl3sfx_databuf0[0];
  MR_SUBG_GLOB_STATIC->DATABUFFER1_PTR = (uint32_t)&wl3sfx_databuf1[0];

  MODIFY_REG_FIELD(MR_SUBG_GLOB_STATIC->DATABUFFER_SIZE, MR_SUBG_GLOB_STATIC_DATABUFFER_SIZE_DATABUFFER_SIZE, size);

  return WL3SFX_DATABUFFERS_OK;
}

WL3SFX_DATABUFFERS_StatusTypeDef wl3sfx_databuffers_reset(void)
{
  for (uint16_t i = 0; i < WL3SFX_DATABUFFERS_SIZE; ++i) {
    wl3sfx_databuf0[i] = 0x00;
    wl3sfx_databuf1[i] = 0x00;
  }

  return WL3SFX_DATABUFFERS_OK;
}

volatile uint8_t* wl3sfx_databuffers_get(uint8_t id)
{
  return id ? wl3sfx_databuf1 : wl3sfx_databuf0;
}