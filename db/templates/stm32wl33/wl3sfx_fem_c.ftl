[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_fem.c
  * @author  GPM WBL Application Team
  * @brief   Helpers for configuring and using front-end modules with Sigfox on the STM32WL3.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stdint.h>
#include <string.h>
#include "stm32wl3x_hal.h"
#include "stm32wl3x_ll_gpio.h"
#include "wl3sfx_fem.h"
#include "wl3sfx_log.h"

/*  ----------------------------- Private static state ----------------------------- */

ST_SFX_FEMConfiguration _configuration = { .model = ST_SFX_FEM_NONE };
uint8_t _fem_pa_enabled = 0;

/*  ---------------------------- Private static helpers ---------------------------- */

/* Configure GPIO pin as output */
static void _init_gpio_pin(const ST_SFX_FEMGPIOConfiguration* config)
{
  LL_AHB1_GRP1_EnableClock(config->periph);
  LL_GPIO_SetPinMode(config->port, config->pin, LL_GPIO_MODE_OUTPUT);
  LL_GPIO_SetPinSpeed(config->port, config->pin, LL_GPIO_SPEED_FREQ_HIGH);
  LL_GPIO_SetPinOutputType(config->port, config->pin, LL_GPIO_OUTPUT_PUSHPULL);
  LL_GPIO_SetPinPull(config->port, config->pin, LL_GPIO_PULL_NO);
}

/* Initialize GPIO pins connected to CSD, CPS and CTX of them FEM */
static void _init_gpio(void)
{
  _init_gpio_pin(&_configuration.csd);
  _init_gpio_pin(&_configuration.cps);
  _init_gpio_pin(&_configuration.ctx);
}

/*  ----------------------------- Public WL3SFX FEM API ----------------------------- */
void wl3sfx_fem_set_pa_enabled(uint8_t enabled)
{
  _fem_pa_enabled = enabled;
}

void wl3sfx_set_fem_configuration(const ST_SFX_FEMConfiguration* configuration)
{
  memcpy(&_configuration, configuration, sizeof(ST_SFX_FEMConfiguration));
}

void wl3sfx_fem_start_tx(void)
{
  if (_configuration.model != ST_SFX_FEM_NONE) {
    _init_gpio();

    LL_GPIO_SetOutputPin(_configuration.csd.port, _configuration.csd.pin);
    LL_GPIO_SetOutputPin(_configuration.ctx.port, _configuration.ctx.pin);

    if (_fem_pa_enabled) {
      /* TX PA mode: CSD = 1, CTX = 1, CPS = 1 */
      LL_GPIO_SetOutputPin(_configuration.cps.port, _configuration.cps.pin);
    } else {
      /* TX bypass mode: CSD = 1, CTX = 1, CPS = 0 */
      LL_GPIO_ResetOutputPin(_configuration.cps.port, _configuration.cps.pin);
    }
  }
}

void wl3sfx_fem_start_rx(void)
{
  if (_configuration.model != ST_SFX_FEM_NONE) {
    _init_gpio();

    /* CSD = 1, CTX = 0, CPS = 1 */
    LL_GPIO_SetOutputPin(_configuration.csd.port, _configuration.csd.pin);
    LL_GPIO_ResetOutputPin(_configuration.ctx.port, _configuration.ctx.pin);
    LL_GPIO_SetOutputPin(_configuration.cps.port, _configuration.cps.pin);
  }
}

void wl3sfx_fem_stop(void)
{
  if (_configuration.model != ST_SFX_FEM_NONE) {
    _init_gpio();

    /* CSD = 0, CTX = 0, CPS = 0 */
    LL_GPIO_ResetOutputPin(_configuration.csd.port, _configuration.csd.pin);
    LL_GPIO_ResetOutputPin(_configuration.ctx.port, _configuration.ctx.pin);
    LL_GPIO_ResetOutputPin(_configuration.cps.port, _configuration.cps.pin);
  }
}

void wl3sfx_fem_get_pulse_shaping_settings(WL3SFX_FEM_PulseShapingSettings* settings)
{
  settings->gainFactor1 = 0x00;
  settings->gainFactor2 = 0x00;

  switch (_configuration.model) {
  case ST_SFX_FEM_NONE:
    settings->maxPower = 81;
    break;
  case ST_SFX_FEM_CUSTOM:
    /* USER CODE BEGIN 1 */

    /* USER CODE END 1 */
    break;
  }
}
