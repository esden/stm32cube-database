[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    device_context_switch.c
  * @author  GPM WBL Application Team
  * @brief   STM32WL3 context switch
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "device_context_switch.h"

/* Private includes ----------------------------------------------------------*/

/* Private typedef -----------------------------------------------------------*/

/* Private define ------------------------------------------------------------*/

/* System Tick Priority register */
#define SHPR3_REG 0xE000ED20
  
/* Private macro -------------------------------------------------------------*/

/* Private variables ---------------------------------------------------------*/

/* Private function prototypes -----------------------------------------------*/
static void APB0periphContextSave(apb0PeriphT *apb0);
static void APB1periphContextSave(apb1PeriphT *apb1);
static void APB2periphContextSave(apb2PeriphT *apb2);
static void AHB0periphContextSave(ahb0PeriphT *ahb0);
static void cstackContextSave(uint32_t *cStackPreamble);
static void cpuPeriphContextSave(cpuPeriphT *cpuPeriph);
static void APB0periphContextRestore(apb0PeriphT *apb0);
static void APB1periphContextRestore(apb1PeriphT *apb1);
static void APB2periphContextRestore(apb2PeriphT *apb2);
static void AHB0periphContextRestore(ahb0PeriphT *ahb0);
static void cstackContextRestore(uint32_t *cStackPreamble);
static void cpuPeriphContextRestore(cpuPeriphT *cpuPeriph);

/* Private user code ---------------------------------------------------------*/

/**
  * @brief  Save the APB0 peripheral registers content.
  * @param  apb0 Pointer to a APB0 structure
  * @retval None
  */
static void APB0periphContextSave(apb0PeriphT *apb0)
{
  if (LL_APB0_GRP1_IsEnabledClock(LL_APB0_GRP1_PERIPH_SYSCFG)) 
  {
    Osal_MemCpy4((uint32_t *)&apb0->SYSCFG_vr, (uint32_t *)SYSCFG, sizeof(SYSCFG_TypeDef));
  }

  if (LL_APB0_GRP1_IsEnabledClock(LL_APB0_GRP1_PERIPH_TIM2))
  {
    Osal_MemCpy4((uint32_t *)&apb0->TIM2_vr, (uint32_t *)TIM2, sizeof(TIM_TypeDef));
  }

  if (LL_APB0_GRP1_IsEnabledClock(LL_APB0_GRP1_PERIPH_TIM16))
  {
    Osal_MemCpy4((uint32_t *)&apb0->TIM16_vr, (uint32_t *)TIM16, sizeof(TIM_TypeDef));
  }
 
  apb0->wdg_to_be_enabled = FALSE;
  if (LL_APB0_GRP1_IsEnabledClock(LL_APB0_GRP1_PERIPH_WDG))
  {
    if (apb0->deepstop_wdg_state == DISABLE)
    {
      apb0->wdg_to_be_enabled = TRUE;
      LL_APB0_GRP1_DisableClock(LL_APB0_GRP1_PERIPH_WDG);
    }
  }
  
  apb0->FLASH_CONFIG_vr = FLASH->CONFIG;
}

/**
  * @brief  Save the APB1 peripheral registers content.
  * @param  apb1 Pointer to a APB1 structure
  * @retval None
  */
static void APB1periphContextSave(apb1PeriphT *apb1)
{
  if (LL_APB1_GRP1_IsEnabledClock(LL_APB1_GRP1_PERIPH_SPI3)) 
  {
    Osal_MemCpy4((uint32_t *)&apb1->SPI3_vr, (uint32_t *)SPI3, sizeof(SPI_TypeDef));
  }

  if (LL_APB1_GRP1_IsEnabledClock(LL_APB1_GRP1_PERIPH_ADCDIG)) 
  {
    Osal_MemCpy4((uint32_t *)&apb1->ADC_vr, (uint32_t *)ADC1, sizeof(ADC_TypeDef));
  }

  if (LL_APB1_GRP1_IsEnabledClock(LL_APB1_GRP1_PERIPH_LPUART1) && 
     (LL_RCC_GetLPUARTClockSource() == LL_RCC_LPUCLKSEL_CLK16M))
  {
    Osal_MemCpy4((uint32_t *)&apb1->LPUART_vr, (uint32_t *)LPUART1, sizeof(USART_TypeDef));
  }

  if (LL_APB1_GRP1_IsEnabledClock(LL_APB1_GRP1_PERIPH_USART1))
  {
    Osal_MemCpy4((uint32_t *)&apb1->USART_vr, (uint32_t *)USART1, sizeof(USART_TypeDef));
  }

  if (LL_APB1_GRP1_IsEnabledClock(LL_APB1_GRP1_PERIPH_SPI1)) 
  {
    Osal_MemCpy4((uint32_t *)&apb1->SPI1_vr, (uint32_t *)SPI1, sizeof(SPI_TypeDef));
  }

  if (LL_APB1_GRP1_IsEnabledClock(LL_APB1_GRP1_PERIPH_I2C2)) 
  {
    Osal_MemCpy4((uint32_t *)&apb1->I2C2_vr, (uint32_t *)I2C2, sizeof(I2C_TypeDef));
  }

  if (LL_APB1_GRP1_IsEnabledClock(LL_APB1_GRP1_PERIPH_I2C1)) 
  {
    Osal_MemCpy4((uint32_t *)&apb1->I2C1_vr, (uint32_t *)I2C1, sizeof(I2C_TypeDef));
  }
}

/**
  * @brief  Save the APB2 peripheral registers content.
  * @param  apb2 Pointer to a APB2 structure
  * @retval None
  */
static void APB2periphContextSave(apb2PeriphT *apb2)
{
  if (LL_APB2_GRP1_IsEnabledClock(LL_APB2_GRP1_PERIPH_MRSUBG)) 
  {
    Osal_MemCpy4((uint32_t *)&apb2->MRSUBG_Radio_vr,   (uint32_t *)MR_SUBG_RADIO,        sizeof(MR_SUBG_RADIO_TypeDef));
    Osal_MemCpy4((uint32_t *)&apb2->MRSUBG_Static_vr,  (uint32_t *)MR_SUBG_GLOB_STATIC,  sizeof(MR_SUBG_GLOB_STATIC_TypeDef));
    Osal_MemCpy4((uint32_t *)&apb2->MRSUBG_Dynamic_vr, (uint32_t *)MR_SUBG_GLOB_DYNAMIC, sizeof(MR_SUBG_GLOB_DYNAMIC_TypeDef));
    Osal_MemCpy4((uint32_t *)&apb2->MRSUBG_Misc_vr,    (uint32_t *)MR_SUBG_GLOB_MISC,    sizeof(MR_SUBG_GLOB_MISC_TypeDef));
  }  
}

/**
  * @brief  Save the AHB0 peripheral registers content.
  * @param  ahb0 Pointer to a AHB0 structure
  * @retval None
  */
static void AHB0periphContextSave(ahb0PeriphT *ahb0)
{
  if (LL_AHB1_GRP1_IsEnabledClock(LL_AHB1_GRP1_PERIPH_DMA)) {
    Osal_MemCpy4((uint32_t *)ahb0->DMAMUX_vr, (uint32_t *)DMAMUX1, 8*sizeof(DMAMUX_Channel_TypeDef));
    Osal_MemCpy4((uint32_t *)ahb0->DMA_vr, (uint32_t *)DMA1, 8*sizeof(DMA_Channel_TypeDef));
  }
    
  if (LL_AHB1_GRP1_IsEnabledClock(LL_AHB1_GRP1_PERIPH_RNG)) {
    Osal_MemCpy4((uint32_t *)&ahb0->RNG_vr, (uint32_t *)RNG, sizeof(RNG_TypeDef));
  }

  if (LL_AHB1_GRP1_IsEnabledClock(LL_AHB1_GRP1_PERIPH_CRC)) {
    Osal_MemCpy4((uint32_t *)&ahb0->CRC_vr, (uint32_t *)CRC, sizeof(CRC_TypeDef));
  }

  if (LL_AHB1_GRP1_IsEnabledClock(LL_AHB1_GRP1_PERIPH_GPIOA)) {
    Osal_MemCpy4((uint32_t *)&ahb0->GPIOA_vr, (uint32_t *)GPIOA, sizeof(GPIO_TypeDef));
  }

  if (LL_AHB1_GRP1_IsEnabledClock(LL_AHB1_GRP1_PERIPH_GPIOB)) {
    Osal_MemCpy4((uint32_t *)&ahb0->GPIOB_vr, (uint32_t *)GPIOB, sizeof(GPIO_TypeDef));
  }
  
  if (LL_AHB1_GRP1_IsEnabledClock(LL_AHB1_GRP1_PERIPH_AES)) {
    Osal_MemCpy4((uint32_t *)&ahb0->AES_vr, (uint32_t *)AES, sizeof(GPIO_TypeDef));
  }

  ahb0->RCC_AHBRSTR_vr  = RCC->AHBRSTR;
  ahb0->RCC_APB1RSTR_vr = RCC->APB1RSTR;
  ahb0->RCC_AHBENR_vr   = RCC->AHBENR;
  ahb0->RCC_APB1ENR_vr  = RCC->APB1ENR;
}

/**
  * @brief  Save the first N c-stack location that will be restored at wakeup reset.
  * @param  cStackPreamble Pointer to store the c-stack location
  * @retval None
  */
static void cstackContextSave(uint32_t *cStackPreamble)
{
  uint8_t i;
  volatile uint32_t *ptr;
  
  i = 0;
  ptr = __vector_table[0].__ptr ;
  ptr -= CSTACK_PREAMBLE_NUMBER;
  do 
  {
    cStackPreamble[i] = *ptr;
    i++;
    ptr++;
  } while (i < CSTACK_PREAMBLE_NUMBER); 

}

/**
  * @brief  Save the CPU peripheral configuration (NVIC, SysTick, Vector Table).
  * @param  cpuPeriph Pointer to a cpu peripheral structure
  * @retval None
  */
static void cpuPeriphContextSave(cpuPeriphT *cpuPeriph)
{
  uint8_t i;
  
  cpuPeriph->SCB_VTOR_vr = SCB->VTOR;
  cpuPeriph->NVIC_ISER_vr = NVIC->ISER[0];
  for (i=0; i<8; i++) 
  {
   cpuPeriph->NVIC_IPR_vr[i] = NVIC->IP[i];
  }
  cpuPeriph->SYSTICK_IPR_vr = *(volatile uint32_t *)SHPR3_REG;
  cpuPeriph->SYST_CSR_vr = SysTick->CTRL;
  cpuPeriph->SYST_RVR_vr = SysTick->LOAD;
}

/**
  * @brief  Restore the APB0 peripheral registers content.
  * @param  apb0 Pointer to a APB0 structure
  * @retval None
  */
static void APB0periphContextRestore(apb0PeriphT *apb0)
{
  if (LL_APB0_GRP1_IsEnabledClock(LL_APB0_GRP1_PERIPH_SYSCFG)) 
  {
    Osal_MemCpy4((uint32_t *)SYSCFG, (uint32_t *)&apb0->SYSCFG_vr, sizeof(SYSCFG_TypeDef));
  }

  if (LL_APB0_GRP1_IsEnabledClock(LL_APB0_GRP1_PERIPH_TIM2)) 
  {
    uint32_t app;
    app = apb0->TIM2_vr.CR1;
    apb0->TIM2_vr.CR1 &= ~TIM_CR1_CEN;    
    Osal_MemCpy4((uint32_t *)TIM2, (uint32_t *)&apb0->TIM2_vr, sizeof(TIM_TypeDef));
    TIM2->CR1 = app;
  }

  if (LL_APB0_GRP1_IsEnabledClock(LL_APB0_GRP1_PERIPH_TIM16)) 
  {
    uint32_t app;
    app = apb0->TIM16_vr.CR1;
    apb0->TIM16_vr.CR1 &= ~TIM_CR1_CEN;    
    Osal_MemCpy4((uint32_t *)TIM16, (uint32_t *)&apb0->TIM16_vr, sizeof(TIM_TypeDef));
    TIM16->CR1 = app;
  }
   
  apb0->FLASH_CONFIG_vr = FLASH->CONFIG;
}

/**
  * @brief  Restore the APB1 peripheral registers content.
  * @param  apb1 Pointer to a APB1 structure
  * @retval None
  */
static void APB1periphContextRestore(apb1PeriphT *apb1)
{
  if (LL_APB1_GRP1_IsEnabledClock(LL_APB1_GRP1_PERIPH_SPI3)) 
  {
    uint32_t app;
    app = apb1->SPI3_vr.CR1;
    apb1->SPI3_vr.CR1 &= ~SPI_CR1_SPE;
    Osal_MemCpy4((uint32_t *)SPI3, (uint32_t *)&apb1->SPI3_vr, 12); /* Skip DR */
    Osal_MemCpy4((uint32_t *)(&(SPI3->CRCPR)), (uint32_t *)(&apb1->SPI3_vr.CRCPR), 20);
    SPI3->CR1 = app;
  }

  if (LL_APB1_GRP1_IsEnabledClock(LL_APB1_GRP1_PERIPH_SPI1)) 
  {
    uint32_t app;
    app = apb1->SPI1_vr.CR1;
    apb1->SPI1_vr.CR1 &= ~SPI_CR1_SPE;
    Osal_MemCpy4((uint32_t *)SPI1, (uint32_t *)&apb1->SPI1_vr, 12); /* Skip DR */
    Osal_MemCpy4((uint32_t *)(&(SPI1->CRCPR)), (uint32_t *)(&apb1->SPI1_vr.CRCPR), 20);
    SPI1->CR1 = app;
  }
    
  if (LL_APB1_GRP1_IsEnabledClock(LL_APB1_GRP1_PERIPH_ADCDIG)) 
  {
    Osal_MemCpy4((uint32_t *)&apb1->ADC_vr, (uint32_t *)ADC1, sizeof(ADC_TypeDef));
  }

  if (LL_APB1_GRP1_IsEnabledClock(LL_APB1_GRP1_PERIPH_LPUART1) && 
     (LL_RCC_GetLPUARTClockSource() == LL_RCC_LPUCLKSEL_CLK16M))
  {
    uint32_t app;
    app = apb1->LPUART_vr.CR1;
    apb1->LPUART_vr.CR1 &= ~USART_CR1_UE;
    Osal_MemCpy4((uint32_t *)LPUART1, (uint32_t *)&apb1->LPUART_vr, 36); /* Skip RDR and TDR */
    LPUART1->PRESC = apb1->LPUART_vr.PRESC;
    LPUART1->CR1 = app;
  }

  if (LL_APB1_GRP1_IsEnabledClock(LL_APB1_GRP1_PERIPH_USART1))
  {
    uint32_t app;
    app = apb1->USART_vr.CR1;
    apb1->USART_vr.CR1 &= ~USART_CR1_UE;
    Osal_MemCpy4((uint32_t *)USART1, (uint32_t *)&apb1->USART_vr, 36); /* Skip RDR and TDR */
    USART1->PRESC = apb1->USART_vr.PRESC;
    USART1->CR1 = app;
  }

  if (LL_APB1_GRP1_IsEnabledClock(LL_APB1_GRP1_PERIPH_I2C1)) 
  {
    uint32_t app;
    app = apb1->I2C1_vr.CR1;
    apb1->I2C1_vr.CR1 &= ~I2C_CR1_PE;
    Osal_MemCpy4((uint32_t *)I2C1, (uint32_t *)&apb1->I2C1_vr, 32); /* Skip PECR, RDR and TDR */
    I2C1->CR1 = app;
  }

  if (LL_APB1_GRP1_IsEnabledClock(LL_APB1_GRP1_PERIPH_I2C2)) 
  {
    uint32_t app;
    app = apb1->I2C2_vr.CR1;
    apb1->I2C2_vr.CR1 &= ~I2C_CR1_PE;
    Osal_MemCpy4((uint32_t *)I2C2, (uint32_t *)&apb1->I2C2_vr, 32); /* Skip PECR, RDR and TDR */
    I2C2->CR1 = app;
  }

}

/**
  * @brief  Restore the APB2 peripheral registers content.
  * @param  apb2 Pointer to a APB2 structure
  * @retval None
  */
static void APB2periphContextRestore(apb2PeriphT *apb2)
{
  if (LL_APB2_GRP1_IsEnabledClock(LL_APB2_GRP1_PERIPH_MRSUBG)) 
  {
    Osal_MemCpy4((uint32_t *)MR_SUBG_RADIO,        (uint32_t *)&apb2->MRSUBG_Radio_vr,   sizeof(MR_SUBG_RADIO_TypeDef));
    Osal_MemCpy4((uint32_t *)MR_SUBG_GLOB_STATIC,  (uint32_t *)&apb2->MRSUBG_Static_vr,  sizeof(MR_SUBG_GLOB_STATIC_TypeDef));
    /* Cleared the COMMAND_ID field to avoid command triggering during the restore procedure */
    apb2->MRSUBG_Dynamic_vr.COMMAND &= ~MR_SUBG_GLOB_DYNAMIC_COMMAND_COMMAND_ID;
    Osal_MemCpy4((uint32_t *)MR_SUBG_GLOB_DYNAMIC, (uint32_t *)&apb2->MRSUBG_Dynamic_vr, sizeof(MR_SUBG_GLOB_DYNAMIC_TypeDef));
    Osal_MemCpy4((uint32_t *)MR_SUBG_GLOB_MISC,    (uint32_t *)&apb2->MRSUBG_Misc_vr,    sizeof(MR_SUBG_GLOB_MISC_TypeDef));        
  }
}

/**
  * @brief  Restore the AHB0 peripheral registers content.
  * @param  ahb0 Pointer to a AHB0 structure
  * @retval None
  */
static void AHB0periphContextRestore(ahb0PeriphT *ahb0)
{
  RCC->AHBRSTR = ahb0->RCC_AHBRSTR_vr;
  RCC->APB1RSTR = ahb0->RCC_APB1RSTR_vr;
  RCC->AHBENR = ahb0->RCC_AHBENR_vr;
  RCC->APB1ENR = ahb0->RCC_APB1ENR_vr;
  
  if (LL_AHB1_GRP1_IsEnabledClock(LL_AHB1_GRP1_PERIPH_DMA)) {
    Osal_MemCpy4((uint32_t *)DMAMUX1, (uint32_t *)ahb0->DMAMUX_vr, 8*sizeof(DMAMUX_Channel_TypeDef));
    ahb0->DMA_vr[0].CNDTR = 0;
    ahb0->DMA_vr[1].CNDTR = 0;
    ahb0->DMA_vr[2].CNDTR = 0;
    ahb0->DMA_vr[3].CNDTR = 0;
    ahb0->DMA_vr[4].CNDTR = 0;
    ahb0->DMA_vr[5].CNDTR = 0;
    ahb0->DMA_vr[6].CNDTR = 0;
    ahb0->DMA_vr[7].CNDTR = 0;
    Osal_MemCpy4((uint32_t *)DMA1, (uint32_t *)ahb0->DMA_vr, 8*sizeof(DMA_Channel_TypeDef));
  }
    
  if (LL_AHB1_GRP1_IsEnabledClock(LL_AHB1_GRP1_PERIPH_RNG)) {
    Osal_MemCpy4((uint32_t *)RNG, (uint32_t *)&ahb0->RNG_vr, sizeof(RNG_TypeDef));
  }

  if (LL_AHB1_GRP1_IsEnabledClock(LL_AHB1_GRP1_PERIPH_AES)) {
    Osal_MemCpy4((uint32_t *)AES, (uint32_t *)&ahb0->AES_vr, sizeof(AES_TypeDef));
  }

  if (LL_AHB1_GRP1_IsEnabledClock(LL_AHB1_GRP1_PERIPH_CRC)) {
    Osal_MemCpy4((uint32_t *)CRC, (uint32_t *)&ahb0->CRC_vr, sizeof(CRC_TypeDef));
  }

  if (LL_AHB1_GRP1_IsEnabledClock(LL_AHB1_GRP1_PERIPH_GPIOA)) {
    GPIOA->AFR[0] = ahb0->GPIOA_vr.AFR[0]; /* To avoid glitch in the line when an AF is set */
    GPIOA->AFR[1] = ahb0->GPIOA_vr.AFR[1];
    GPIOA->ODR = ahb0->GPIOA_vr.ODR;       /* To avoid glitch in the line when GPIO_MODE_OUTPUT is set */    
    Osal_MemCpy4((uint32_t *)GPIOA, (uint32_t *)&ahb0->GPIOA_vr, sizeof(GPIO_TypeDef));
  }

  if (LL_AHB1_GRP1_IsEnabledClock(LL_AHB1_GRP1_PERIPH_GPIOB)) {
    GPIOB->AFR[0] = ahb0->GPIOB_vr.AFR[0]; /* To avoid glitch in the line when an AF is set */
    GPIOB->AFR[1] = ahb0->GPIOB_vr.AFR[1];
    GPIOB->ODR = ahb0->GPIOB_vr.ODR;       /* To avoid glitch in the line when GPIO_MODE_OUTPUT is set */    
    Osal_MemCpy4((uint32_t *)GPIOB, (uint32_t *)&ahb0->GPIOB_vr, sizeof(GPIO_TypeDef));
  }
}

/**
  * @brief  Restore the first N c-stack location after wake-up reset.
  * @param  cStackPreamble Pointer to store the c-stack location
  * @retval None
  */
static void cstackContextRestore(uint32_t *cStackPreamble)
{
  uint8_t i;
  volatile uint32_t *ptr;
  
  i = 0;
  ptr = __vector_table[0].__ptr ;
  ptr -= CSTACK_PREAMBLE_NUMBER;
  do 
  {
    *ptr = cStackPreamble[i];
    i++;
    ptr++;
  } while (i < CSTACK_PREAMBLE_NUMBER); 

}

/**
  * @brief  Restore the CPU peripheral configuration (NVIC, SysTick, Vector Table).
  * @param  cpuPeriph Pointer to a cpu peripheral structure
  * @retval None
  */
static void cpuPeriphContextRestore(cpuPeriphT *cpuPeriph)
{
  uint8_t i;
  
  SCB->VTOR = cpuPeriph->SCB_VTOR_vr;
  NVIC->ISER[0] = cpuPeriph->NVIC_ISER_vr;
  for (i=0; i<8; i++) 
  {
   NVIC->IP[i] = cpuPeriph->NVIC_IPR_vr[i];
  }
  *(volatile uint32_t *)SHPR3_REG = cpuPeriph->SYSTICK_IPR_vr;
  SysTick->CTRL = cpuPeriph->SYST_CSR_vr;
  SysTick->VAL = 0;
  SysTick->LOAD = cpuPeriph->SYST_RVR_vr;
}

/**
  * @brief  Prepare the device for the low power mode. All peripheral registers
  *         and some CPU configuration registers are saved in a 
  *         context and retained in RAM.
  * @param  Structure to save the peripherals configuration
  * @retval None
  */
void prepareDeviceLowPower(apb0PeriphT *apb0, apb1PeriphT *apb1, 
                           apb2PeriphT *apb2, ahb0PeriphT *ahb0, 
                           cpuPeriphT *cpuPeriph, uint32_t *cStackPreamble)
{   
  /* Reset the wakeup flag before the low power mode */
  RAM_VR.WakeupFromSleepFlag = 0;
  
  /* Save the APB0 peripheral configuration */
  APB0periphContextSave(apb0);
  
  /* Save the APB1 peripheral configuration */
  APB1periphContextSave(apb1);

  /* Save the APB2 peripheral configuration */
  APB2periphContextSave(apb2);
  
  /* Save the AHB0 peripheral configuration */
  AHB0periphContextSave(ahb0);
  
  /* Save the first N c-stack location that will be restored at wakeup reset */
  cstackContextSave(cStackPreamble);
  
  /* Save the CPU peripheral configuration (NVIC, SysTick, Vector Table) */
  cpuPeriphContextSave(cpuPeriph);
}

/**
  * @brief  Restore the device configuration after wake-up from low power mode. 
  *         All peripheral registers and CPU configuration registers 
  *         are restored.
  * @param  Structure with the stored peripherals configuration
  * @retval None
  */
void restoreDeviceLowPower(apb0PeriphT *apb0, apb1PeriphT *apb1, 
                           apb2PeriphT *apb2, ahb0PeriphT *ahb0, 
                           cpuPeriphT *cpuPeriph, uint32_t *cStackPreamble)
{
  /* Enable Watchdog IP if previous disabled */
  if (apb0->wdg_to_be_enabled)
  {
    apb0->wdg_to_be_enabled = FALSE;
    LL_APB0_GRP1_EnableClock(LL_APB0_GRP1_PERIPH_WDG);
  }
  
  /* No Wakeup from DEEPSTOP, so the peripehral configuration is not lost */
  if (RAM_VR.WakeupFromSleepFlag == 0)
  {
    return;
  }

  /* Restore the first N c-stack location that will be restored at wakeup reset */
  cstackContextRestore(cStackPreamble);
  
  /* Restore the CPU peripheral configuration (NVIC, SysTick, Vector Table) */
  cpuPeriphContextRestore(cpuPeriph);  

  /* Restore the AHB0 peripheral configuration */
  AHB0periphContextRestore(ahb0);  

  /* Restore the APB0 peripheral configuration */
  APB0periphContextRestore(apb0);
  
  /* Restore the APB1 peripheral configuration */
  APB1periphContextRestore(apb1);
  
  /* Restore the APB2 peripheral configuration */
  APB2periphContextRestore(apb2);
}