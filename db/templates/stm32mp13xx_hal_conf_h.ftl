[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    stm32mp13xx_hal_conf.h
  * @brief   HAL configuration file.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2020 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */ 
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef STM32MP13xx_HAL_CONF_H
#define STM32MP13xx_HAL_CONF_H

#ifdef __cplusplus
 extern "C" {
#endif

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/

/* ########################## Module Selection ############################## */
/**
  * @brief This is the list of modules to be used in the HAL driver 
  */
#define HAL_MODULE_ENABLED 
  [#assign aes=0]
  [#assign allModules = ["ADC","BSEC","CRC","AES","CRYP","DCMIPP","DDR", "DFSDM","DTS","ETH","FDCAN","HASH","HCD","I2C","I2S","IWDG","LPTIM","LTDC","MCE","MDMA","PCD","PKA","RNG","RTC","SAI","SPDIFRX","SD","MMC","SMARTCARD","SMBUS","SPI","SRAM","TIM","UART","USART","ETZPC"]]
  [#list allModules as module]
	[#if isModuleUsed(module)]
	  [#if module=="AES"]
		[#assign aes=1]
	  [/#if]
[#compress]#define HAL_${module?replace("QUADSPI","QSPI")?replace("AES","CRYP")?replace("SCRYP","CRYP")?replace("OCTOSPI","OSPI")}_MODULE_ENABLED[/#compress]
    [#else]
	  [#if aes==1 && module=="CRYP"]
	  [#else]
/*#define HAL_${module?replace("QUADSPI","QSPI")?replace("AES","CRYP")?replace("SCRYP","CRYP")?replace("OCTOSPI","OSPI")}_MODULE_ENABLED */
	[/#if]
	[/#if]	
  [/#list]
  [#function isModuleUsed moduleName]
	[#assign used=false]
	[#list modules as usedModule]
	[#if moduleName=="CRYP" && aes==1]
		[#assign used=false]
		[#return false]
	[/#if]
		[#if usedModule==moduleName]
			[#assign used=true]
			[#return true]
		[/#if]
	[/#list]
	[#return used]
  [/#function]

#define HAL_GPIO_MODULE_ENABLED
#define HAL_EXTI_MODULE_ENABLED
#define HAL_DMA_MODULE_ENABLED
#define HAL_MDMA_MODULE_ENABLED
#define HAL_RCC_MODULE_ENABLED
#define HAL_PWR_MODULE_ENABLED
#define HAL_CORTEX_MODULE_ENABLED

/* ########################## Register Callbacks selection ############################## */
/**
  * @brief This is the list of modules where register callback can be used
  */
#define USE_HAL_ADC_REGISTER_CALLBACKS         0U
#define USE_HAL_CRYP_REGISTER_CALLBACKS        0U
#define USE_HAL_DFSDM_REGISTER_CALLBACKS       0U
#define USE_HAL_DTS_REGISTER_CALLBACKS         0U
#define USE_HAL_ETH_REGISTER_CALLBACKS         0U
#define USE_HAL_HASH_REGISTER_CALLBACKS        0U
#define USE_HAL_HCD_REGISTER_CALLBACKS         0U
#define USE_HAL_I2C_REGISTER_CALLBACKS         0U
#define USE_HAL_I2S_REGISTER_CALLBACKS         0U
#define USE_HAL_IWDG_REGISTER_CALLBACKS        0U
#define USE_HAL_LPTIM_REGISTER_CALLBACKS       0U
#define USE_HAL_LTDC_REGISTER_CALLBACKS        0U
#define USE_HAL_MMC_REGISTER_CALLBACKS         0U
#define USE_HAL_PCD_REGISTER_CALLBACKS         0U
#define USE_HAL_PKA_REGISTER_CALLBACKS         0U
#define USE_HAL_QSPI_REGISTER_CALLBACKS        0U
#define USE_HAL_RNG_REGISTER_CALLBACKS         0U
#define USE_HAL_RTC_REGISTER_CALLBACKS         0U
#define USE_HAL_SAI_REGISTER_CALLBACKS         0U
#define USE_HAL_SD_REGISTER_CALLBACKS          0U
#define USE_HAL_SMARTCARD_REGISTER_CALLBACKS   0U
#define USE_HAL_SMBUS_REGISTER_CALLBACKS       0U
#define USE_HAL_SPI_REGISTER_CALLBACKS         0U
#define USE_HAL_TIM_REGISTER_CALLBACKS         0U
#define USE_HAL_UART_REGISTER_CALLBACKS        0U
#define USE_HAL_USART_REGISTER_CALLBACKS       0U

/* ################## SPI peripheral configuration ########################## */

/* CRC FEATURE: Use to activate CRC feature inside HAL SPI Driver
* Activated: CRC code is present inside driver
* Deactivated: CRC code cleaned from driver
*/
#define USE_SPI_CRC                   [#if CRC_SPI??]${CRC_SPI}[#else]1U[/#if]

/* ########################## Oscillator Values adaptation ####################*/
/**
  * @brief Adjust the value of External High Speed oscillator (HSE) used in your application.
  *        This value is used by the RCC HAL module to compute the system frequency
  *        (when HSE is used as system clock source, directly or through the PLL).  
  */
#if !defined  (HSE_VALUE) 
#define HSE_VALUE    ([#if hse_value??]${hse_value}[#else]24000000[/#if]U) /*!< Value of the External oscillator in Hz */
#endif /* HSE_VALUE */

/**
  * @brief In the following line adjust the External High Speed oscillator (HSE) Startup 
  *        Timeout value 
  */
#if !defined  (HSE_STARTUP_TIMEOUT)
  #define HSE_STARTUP_TIMEOUT    ([#if HSE_Timout??]${HSE_Timout}[#if HSE_Timout?matches("(0x[0-9]*[a-f]*[A-F]*)|([0-9]*)")]U[/#if][#else]100U[/#if])   /*!< Time out for HSE start up, in ms */
#endif /* HSE_STARTUP_TIMEOUT */

/**
  * @brief Internal High Speed oscillator (HSI) value.
  *        This value is used by the RCC HAL module to compute the system frequency
  *        (when HSI is used as system clock source, directly or through the PLL). 
  */
#if !defined  (HSI_VALUE)
  #define HSI_VALUE            64000000U /*!< Value of the Internal oscillator in Hz*/
#endif /* HSI_VALUE */

/**
  * @brief In the following line adjust the Internal High Speed oscillator (HSI) Startup 
  *        Timeout value 
  */
#if !defined  (HSI_STARTUP_TIMEOUT) 
  #define HSI_STARTUP_TIMEOUT  5000U     /*!< Time out for HSI start up */
#endif /* HSI_STARTUP_TIMEOUT */  

/**
  * @brief Internal Low Speed oscillator (LSI) value.
  */
#if !defined  (LSI_VALUE) 
  #define LSI_VALUE            32000U
#endif /* LSI_VALUE */                   /*!< Value of the Internal Low Speed oscillator in Hz
The real value may vary depending on the variations
in voltage and temperature.  */

/**
  * @brief External Low Speed oscillator (LSE) value.
  *        This value is used by the UART, RTC HAL module to compute the system frequency
  */
#if !defined  (LSE_VALUE)
  #define LSE_VALUE            (uint32_t)[#if lse_value??]${lse_value}[#else]32768[/#if]U /*!< Value of the External Low Speed oscillator in Hz*/
#endif /* LSE_VALUE */

/**
  * @brief Time out for LSE start up value in ms.
  */
#if !defined  (LSE_STARTUP_TIMEOUT)
  #define LSE_STARTUP_TIMEOUT    ((uint32_t)[#if LSE_Timout??]${LSE_Timout}[#if LSE_Timout?matches("(0x[0-9]*[a-f]*[A-F]*)|([0-9]*)")]U[/#if][#else]5000U[/#if])     /*!< Time out for LSE start up, in ms */
#endif /* LSE_STARTUP_TIMEOUT */

/**
  * @brief Internal  oscillator (CSI) default value.
  *        This value is the default CSI value after Reset.
  */
#if !defined  (CSI_VALUE)
  #define CSI_VALUE    4000000U /*!< Value of the Internal oscillator in Hz*/
#endif /* CSI_VALUE */

/**
  * @brief External clock source for I2S peripheral
  *        This value is used by the I2S HAL module to compute the I2S clock source 
  *        frequency, this source is inserted directly through I2S_CKIN pad. 
  */
#if !defined  (EXTERNAL_CLOCK_VALUE)
  #define EXTERNAL_CLOCK_VALUE    [#if external_clock_value??]${external_clock_value}[#else]12288000[/#if]U /*!< Value of the External clock in Hz*/
#endif /* EXTERNAL_CLOCK_VALUE */

/* Tip: To avoid modifying this file each time you need to use different HSE,
   ===  you can define the HSE value in your toolchain compiler preprocessor. */

/* ########################### System Configuration ######################### */
/**
  * @brief This is the HAL system configuration section
  */     
#define  VDD_VALUE                    [#if vdd_value??]${vdd_value}[#else]3300[/#if]U /*!< Value of VDD in mv */
#define  TICK_INT_PRIORITY            [#if TICK_INT_PRIORITY??]${TICK_INT_PRIORITY}U[#else]((uint32_t)(1U<<4U) - 1U)[/#if] /*!< tick interrupt priority (lowest by default) */
/*  Warning: Must be set to higher priority for HAL_Delay()  */
/*  and HAL_GetTick() usage under interrupt context          */
#define  USE_RTOS                     [#if advancedSettings?? && advancedSettings.USE_RTOS??]${advancedSettings.USE_RTOS}[#else]0[/#if]U
#define  PREFETCH_ENABLE              [#if PREFETCH_ENABLEY??]${PREFETCH_ENABLE}[#else]0[/#if]U
#define  INSTRUCTION_CACHE_ENABLE     [#if INSTRUCTION_CACHE_ENABLE??]${INSTRUCTION_CACHE_ENABLE}[#else]0[/#if]U
#define  DATA_CACHE_ENABLE            [#if DATA_CACHE_ENABLE??]${DATA_CACHE_ENABLE}[#else]0[/#if]U

/* ########################## Assert Selection ############################## */
/**
  * @brief Uncomment the line below to expanse the "assert_param" macro in the 
  *        HAL drivers code
  */
[#if !fullAssert??]/*[/#if] #define USE_FULL_ASSERT    1U [#if !fullAssert??]*/[/#if] 

/* Includes ------------------------------------------------------------------*/
/**
  * @brief Include module's header file 
  */

#ifdef HAL_RCC_MODULE_ENABLED
#include "stm32mp13xx_hal_rcc.h"
#endif /* HAL_RCC_MODULE_ENABLED */

#ifdef HAL_DMA_MODULE_ENABLED
#include "stm32mp13xx_hal_dma.h"
#endif /* HAL_DMA_MODULE_ENABLED */

#ifdef HAL_MDMA_MODULE_ENABLED
#include "stm32mp13xx_hal_mdma.h"
#endif /* HAL_MDMA_MODULE_ENABLED */

#ifdef HAL_ADC_MODULE_ENABLED
#include "stm32mp13xx_hal_adc.h"
#endif /* HAL_ADC_MODULE_ENABLED */

#ifdef HAL_BSEC_MODULE_ENABLED
#include "stm32mp13xx_hal_bsec.h"
#endif /* HAL_BSEC_MODULE_ENABLED */

#ifdef HAL_CRC_MODULE_ENABLED
#include "stm32mp13xx_hal_crc.h"
#endif /* HAL_CRC_MODULE_ENABLED */

#ifdef HAL_CRYP_MODULE_ENABLED
#include "stm32mp13xx_hal_cryp.h"
#endif /* HAL_CRYP_MODULE_ENABLED */

#ifdef HAL_DCMIPP_MODULE_ENABLED
#include "stm32mp13xx_hal_dcmipp.h"
#endif /* HAL_DCMIPP_MODULE_ENABLED */

#ifdef HAL_DDR_MODULE_ENABLED
#include "stm32mp13xx_hal_ddr.h"
#endif /* HAL_DDR_MODULE_ENABLED */

#ifdef HAL_DFSDM_MODULE_ENABLED
#include "stm32mp13xx_hal_dfsdm.h"
#endif /* HAL_DFSDM_MODULE_ENABLED */

#ifdef HAL_DTS_MODULE_ENABLED
#include "stm32mp13xx_hal_dts.h"
#endif /* HAL_DTS_MODULE_ENABLED */

#ifdef HAL_ETH_MODULE_ENABLED
#include "stm32mp13xx_hal_eth.h"
#endif /* HAL_ETH_MODULE_ENABLED */

#ifdef HAL_EXTI_MODULE_ENABLED
#include "stm32mp13xx_hal_exti.h"
#endif /* HAL_EXTI_MODULE_ENABLED */

#ifdef HAL_FDCAN_MODULE_ENABLED
#include "stm32mp13xx_hal_fdcan.h"
#endif /* HAL_FDCAN_MODULE_ENABLED */

#ifdef HAL_GPIO_MODULE_ENABLED
#include "stm32mp13xx_hal_gpio.h"
#endif /* HAL_GPIO_MODULE_ENABLED */

#ifdef HAL_HASH_MODULE_ENABLED
#include "stm32mp13xx_hal_hash.h"
#endif /* HAL_HASH_MODULE_ENABLED */

#ifdef HAL_HCD_MODULE_ENABLED
#include "stm32mp13xx_hal_hcd.h"
#endif /* HAL_HCD_MODULE_ENABLED */

#ifdef HAL_I2C_MODULE_ENABLED
#include "stm32mp13xx_hal_i2c.h"
#endif /* HAL_I2C_MODULE_ENABLED */

#ifdef HAL_I2S_MODULE_ENABLED
 #include "stm32mp13xx_hal_i2s.h"
#endif /* HAL_I2S_MODULE_ENABLED */

#ifdef HAL_IWDG_MODULE_ENABLED
#include "stm32mp13xx_hal_iwdg.h"
#endif /* HAL_IWDG_MODULE_ENABLED */

#ifdef HAL_LPTIM_MODULE_ENABLED
#include "stm32mp13xx_hal_lptim.h"
#endif /* HAL_LPTIM_MODULE_ENABLED */

#ifdef HAL_LTDC_MODULE_ENABLED
#include "stm32mp13xx_hal_ltdc.h"
#endif /* HAL_LTDC_MODULE_ENABLED */

#ifdef HAL_MCE_MODULE_ENABLED
#include "stm32mp13xx_hal_mce.h"
#endif /* HAL_MCE_MODULE_ENABLED */

#ifdef HAL_MMC_MODULE_ENABLED
 #include "stm32mp13xx_hal_mmc.h"
#endif /* HAL_MMC_MODULE_ENABLED */

#ifdef HAL_PCD_MODULE_ENABLED
#include "stm32mp13xx_hal_pcd.h"
#endif /* HAL_PCD_MODULE_ENABLED */

#ifdef HAL_PKA_MODULE_ENABLED
#include "stm32mp13xx_hal_pka.h"
#endif /* HAL_PKA_MODULE_ENABLED */

#ifdef HAL_PWR_MODULE_ENABLED
#include "stm32mp13xx_hal_pwr.h"
#endif /* HAL_PWR_MODULE_ENABLED */

#ifdef HAL_QSPI_MODULE_ENABLED
#include "stm32mp13xx_hal_qspi.h"
#endif /* HAL_QSPI_MODULE_ENABLED */

#ifdef HAL_RNG_MODULE_ENABLED
#include "stm32mp13xx_hal_rng.h"
#endif /* HAL_RNG_MODULE_ENABLED */

#ifdef HAL_RTC_MODULE_ENABLED
#include "stm32mp13xx_hal_rtc.h"
#endif /* HAL_RTC_MODULE_ENABLED */

#ifdef HAL_SAI_MODULE_ENABLED
#include "stm32mp13xx_hal_sai.h"
#endif /* HAL_SAI_MODULE_ENABLED */

#ifdef HAL_SD_MODULE_ENABLED
#include "stm32mp13xx_hal_sd.h"
#endif /* HAL_SD_MODULE_ENABLED */

#ifdef HAL_SMARTCARD_MODULE_ENABLED
#include "stm32mp13xx_hal_smartcard.h"
#endif /* HAL_SMARTCARD_MODULE_ENABLED */

#ifdef HAL_SMBUS_MODULE_ENABLED
#include "stm32mp13xx_hal_smbus.h"
#endif /* HAL_SMBUS_MODULE_ENABLED */

#ifdef HAL_SPDIFRX_MODULE_ENABLED
#include "stm32mp13xx_hal_spdifrx.h"
#endif /* HAL_SPDIFRX_MODULE_ENABLED */

#ifdef HAL_SPI_MODULE_ENABLED
#include "stm32mp13xx_hal_spi.h"
#endif /* HAL_SPI_MODULE_ENABLED */

#ifdef HAL_SRAM_MODULE_ENABLED
 #include "stm32mp1xx_hal_sram.h"
#endif /* HAL_SRAM_MODULE_ENABLED */

#ifdef HAL_TIM_MODULE_ENABLED
#include "stm32mp13xx_hal_tim.h"
#endif /* HAL_TIM_MODULE_ENABLED */

#ifdef HAL_UART_MODULE_ENABLED
#include "stm32mp13xx_hal_uart.h"
#endif /* HAL_UART_MODULE_ENABLED */

#ifdef HAL_USART_MODULE_ENABLED
#include "stm32mp13xx_hal_usart.h"
#endif /* HAL_USART_MODULE_ENABLED */

#ifdef HAL_ETZPC_MODULE_ENABLED
 #include "stm32mp13xx_hal_etzpc.h"
#endif /* HAL_ETZPC_MODULE_ENABLED */

/* Exported macro ------------------------------------------------------------*/
#ifdef  USE_FULL_ASSERT
/**
  * @brief  The assert_param macro is used for function's parameters check.
  * @param  expr: If expr is false, it calls assert_failed function
  *         which reports the name of the source file and the source
  *         line number of the call that failed. 
  *         If expr is true, it returns no value.
  * @retval None
  */
  #define assert_param(expr) ((expr) ? (void)0U : assert_failed((uint8_t *)__FILE__, __LINE__))
/* Exported functions ------------------------------------------------------- */
  void assert_failed(uint8_t* file, uint32_t line);
#else
  #define assert_param(expr) ((void)0U)
#endif /* USE_FULL_ASSERT */    
    
#ifdef __cplusplus
}
#endif

#endif /* STM32MP13xx_HAL_CONF_H */