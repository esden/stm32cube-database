[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    device_context_switch.h
  * @author  GPM WBL Application Team
  * @brief   Header file of Device Context Switch module.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef DEVICE_CONTEXT_SWITCH_H
#define DEVICE_CONTEXT_SWITCH_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32wl3x_hal.h"
#include "osal.h"

/* Exported types ------------------------------------------------------------*/
/* APB0 structure with all the virtual register 
   used in low power to save the context */
typedef struct apb0PeriphS
{
  SYSCFG_TypeDef SYSCFG_vr;
  uint32_t FLASH_CONFIG_vr;
  TIM_TypeDef TIM2_vr;
  TIM_TypeDef TIM16_vr;
  uint32_t wdg_to_be_enabled;
  uint32_t deepstop_wdg_state;
} apb0PeriphT;


/* APB1 structure with all the virtual register 
   used in low power to save the context */
typedef struct apb1PeriphS
{
  I2C_TypeDef I2C1_vr;
  I2C_TypeDef I2C2_vr;
  SPI_TypeDef SPI1_vr;
  USART_TypeDef LPUART_vr;
  USART_TypeDef USART_vr;
  ADC_TypeDef ADC_vr;
  SPI_TypeDef SPI3_vr;
} apb1PeriphT;

/* APB2 structure with all the virtual register 
   used in low power to save the context */
typedef struct apb2PeriphS
{
  MR_SUBG_RADIO_TypeDef MRSUBG_Radio_vr;
  MR_SUBG_GLOB_STATIC_TypeDef  MRSUBG_Static_vr;
  MR_SUBG_GLOB_DYNAMIC_TypeDef MRSUBG_Dynamic_vr;
  MR_SUBG_GLOB_MISC_TypeDef MRSUBG_Misc_vr;
} apb2PeriphT;

/* AHB0 structure with all the virtual register 
   used in low power to save the context */
typedef struct ahb0PeriphS
{
  GPIO_TypeDef GPIOA_vr;
  GPIO_TypeDef GPIOB_vr;
  CRC_TypeDef CRC_vr;
  RNG_TypeDef RNG_vr;
  DMA_Channel_TypeDef DMA_vr[8];
  DMAMUX_Channel_TypeDef DMAMUX_vr[8];
  AES_TypeDef AES_vr;
  uint32_t RCC_AHBRSTR_vr;
  uint32_t RCC_APB1RSTR_vr;
  uint32_t RCC_AHBENR_vr;
  uint32_t RCC_APB1ENR_vr;
  uint32_t RCC_CR_vr;
} ahb0PeriphT;

typedef struct cpuPeriphS
{
  uint32_t SCB_VTOR_vr;
  uint32_t NVIC_ISER_vr;
  uint32_t NVIC_IPR_vr[8];
  uint32_t SYSTICK_IPR_vr;
  uint32_t SYST_CSR_vr;
  uint32_t SYST_RVR_vr;
} cpuPeriphT;

/* Exported constants --------------------------------------------------------*/

/* Important note: The SystemInit() function is critical for waking up from 
   deep sleep and it should not use more that 8 stack positions
   otherwise a stack corruption will occur when waking up from deep sleep.
   For this reason we are saving and restoring the first 8 words of the stack that 
   will be corrupted during the wake-up procedure from deep sleep.
   If the SystemInit() will be modified, this define shall be modified according
   the new function implementation
*/
#define CSTACK_PREAMBLE_NUMBER 8

/* Exported macros -----------------------------------------------------------*/

/* Exported functions --------------------------------------------------------*/
void prepareDeviceLowPower(apb0PeriphT *apb0, apb1PeriphT *apb1, 
                           apb2PeriphT *apb2, ahb0PeriphT *ahb0,
                           cpuPeriphT *cpuPeriph, uint32_t *cStackPreamble);
   
void restoreDeviceLowPower(apb0PeriphT *apb0, apb1PeriphT *apb1, 
                           apb2PeriphT *apb2, ahb0PeriphT *ahb0, 
                           cpuPeriphT *cpuPeriph, uint32_t *cStackPreamble);

#ifdef __cplusplus
}
#endif

#endif /* DEVICE_CONTEXT_SWITCH_H */