[#ftl]
/**
  ******************************************************************************
  * @file    stm32f1xx_hal_conf.h
  * @brief   HAL configuration file.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT(c) ${year} STMicroelectronics</center></h2>
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  *   1. Redistributions of source code must retain the above copyright notice,
  *      this list of conditions and the following disclaimer.
  *   2. Redistributions in binary form must reproduce the above copyright notice,
  *      this list of conditions and the following disclaimer in the documentation
  *      and/or other materials provided with the distribution.
  *   3. Neither the name of STMicroelectronics nor the names of its contributors
  *      may be used to endorse or promote products derived from this software
  *      without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
  * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
  * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */ 

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM32F1xx_HAL_CONF_H
#define __STM32F1xx_HAL_CONF_H

#ifdef __cplusplus
 extern "C" {
#endif

#include "main.h"
/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/

/* ########################## Module Selection ############################## */
/**
  * @brief This is the list of modules to be used in the HAL driver 
  */
  
#define HAL_MODULE_ENABLED  
  [#assign allModules = ["ADC","AES","CAN","CEC","CORTEX","CRC","DAC","DMA","ETH","FLASH","GPIO","I2C","I2S","IRDA","IWDG","NOR","NAND","PCCARD","PCD","HCD","PWR","RCC","RTC","SD","MMC","SDRAM","SMARTCARD","SPI","SRAM","TIM","UART","USART","WWDG"]]
  [#list allModules as module]
	[#if isModuleUsed(module)]
[#compress]#define HAL_${module?replace("AES","CRYP")}_MODULE_ENABLED[/#compress]
	[#else]
/*#define HAL_${module?replace("AES","CRYP")}_MODULE_ENABLED   */
	[/#if]	
  [/#list]
  [#function isModuleUsed moduleName]
	[#assign used=false]
	[#list modules as usedModule]
		[#if usedModule==moduleName]
			[#assign used=true]
			[#return true]
		[/#if]
	[/#list]
	[#return used]
  [/#function]

#define HAL_CORTEX_MODULE_ENABLED
#define HAL_DMA_MODULE_ENABLED
#define HAL_FLASH_MODULE_ENABLED
#define HAL_GPIO_MODULE_ENABLED
#define HAL_PWR_MODULE_ENABLED
#define HAL_RCC_MODULE_ENABLED

/* ########################## Oscillator Values adaptation ####################*/
/**
  * @brief Adjust the value of External High Speed oscillator (HSE) used in your application.
  *        This value is used by the RCC HAL module to compute the system frequency
  *        (when HSE is used as system clock source, directly or through the PLL).  
  */
#if !defined  (HSE_VALUE) 
  #define HSE_VALUE    ((uint32_t)[#if hse_value??]${hse_value}[#else]8000000[/#if]) /*!< Value of the External oscillator in Hz */
#endif /* HSE_VALUE */

#if !defined  (HSE_STARTUP_TIMEOUT)
  #define HSE_STARTUP_TIMEOUT    ((uint32_t)[#if HSE_Timout??]${HSE_Timout}[#else]5000[/#if])   /*!< Time out for HSE start up, in ms */
#endif /* HSE_STARTUP_TIMEOUT */

/**
  * @brief Internal High Speed oscillator (HSI) value.
  *        This value is used by the RCC HAL module to compute the system frequency
  *        (when HSI is used as system clock source, directly or through the PLL). 
  */
#if !defined  (HSI_VALUE)
  #define HSI_VALUE    ((uint32_t)8000000) /*!< Value of the Internal oscillator in Hz*/
#endif /* HSI_VALUE */

/**
  * @brief Internal Low Speed oscillator (LSI) value.
  */
#if !defined  (LSI_VALUE) 
 #define LSI_VALUE               40000U    /*!< LSI Typical Value in Hz */
#endif /* LSI_VALUE */                     /*!< Value of the Internal Low Speed oscillator in Hz
                                                The real value may vary depending on the variations
                                                in voltage and temperature. */

/**
  * @brief External Low Speed oscillator (LSE) value.
  *        This value is used by the UART, RTC HAL module to compute the system frequency
  */
#if !defined  (LSE_VALUE)
  #define LSE_VALUE    ((uint32_t)[#if lse_value??]${lse_value}[#else]32768[/#if]) /*!< Value of the External oscillator in Hz*/
#endif /* LSE_VALUE */


#if !defined  (LSE_STARTUP_TIMEOUT)
  #define LSE_STARTUP_TIMEOUT    ((uint32_t)[#if LSE_Timout??]${LSE_Timout}[#else]5000[/#if])   /*!< Time out for LSE start up, in ms */
#endif /* LSE_STARTUP_TIMEOUT */


/* Tip: To avoid modifying this file each time you need to use different HSE,
   ===  you can define the HSE value in your toolchain compiler preprocessor. */

/* ########################### System Configuration ######################### */
/**
  * @brief This is the HAL system configuration section
  */     
#define  VDD_VALUE                    ((uint32_t)[#if vdd_value??]${vdd_value})[#else]3300)[/#if] /*!< Value of VDD in mv */           
#define  TICK_INT_PRIORITY            ((uint32_t)[#if TICK_INT_PRIORITY??]${TICK_INT_PRIORITY}[#else](1<<__NVIC_PRIO_BITS) - 1[/#if])    /*!< tick interrupt priority (lowest by default)  */            
#define  USE_RTOS                     [#if advancedSettings?? && advancedSettings.USE_RTOS??]${advancedSettings.USE_RTOS}[#else]0[/#if]
#define  PREFETCH_ENABLE              [#if PREFETCH_ENABLE??]${PREFETCH_ENABLE}[#else]1[/#if]

/* ########################## Assert Selection ############################## */
/**
  * @brief Uncomment the line below to expanse the "assert_param" macro in the 
  *        HAL drivers code
  */
[#if !fullAssert??]/*[/#if] #define USE_FULL_ASSERT    1U [#if !fullAssert??]*/[/#if]


/* ################## Ethernet peripheral configuration ##################### */

/* Section 1 : Ethernet peripheral configuration */

/* MAC ADDRESS: MAC_ADDR0:MAC_ADDR1:MAC_ADDR2:MAC_ADDR3:MAC_ADDR4:MAC_ADDR5 */
#define MAC_ADDR0   2
#define MAC_ADDR1   0
#define MAC_ADDR2   0
#define MAC_ADDR3   0
#define MAC_ADDR4   0
#define MAC_ADDR5   0

/* Definition of the Ethernet driver buffers size and count */   
#define ETH_RX_BUF_SIZE                ETH_MAX_PACKET_SIZE /* buffer size for receive               */
#define ETH_TX_BUF_SIZE                ETH_MAX_PACKET_SIZE /* buffer size for transmit              */
#define ETH_RXBUFNB                    ((uint32_t)[#if PETH_RXBUFNB??]${ETH_RXBUFNB}[#else]8[/#if])       /* 4 Rx buffers of size ETH_RX_BUF_SIZE  */
#define ETH_TXBUFNB                    ((uint32_t)[#if ETH_TXBUFNB??]${ETH_TXBUFNB}[#else]4[/#if])       /* 4 Tx buffers of size ETH_TX_BUF_SIZE  */

/* Section 2: PHY configuration section */

/* [#if PHY_Name??]${PHY_Name}[#else]DP83848_PHY_ADDRESS[/#if] Address*/ 
#define [#if PHY_Name??]${PHY_Name}[#else]DP83848_PHY_ADDRESS[/#if]           [#if PHY_Value??]0x${PHY_Value}U[#else]0x01U[/#if]
/* PHY Reset delay these values are based on a 1 ms Systick interrupt*/ 
#define PHY_RESET_DELAY                 ((uint32_t)[#if PHY_RESET_DELAY??]${PHY_RESET_DELAY}[#else]0x000000FF[/#if])
/* PHY Configuration delay */
#define PHY_CONFIG_DELAY                ((uint32_t)[#if PHY_CONFIG_DELAY??]${PHY_CONFIG_DELAY}[#else]0x00000FFF[/#if])

#define PHY_READ_TO                     ((uint32_t)[#if PHY_READ_TO??]${PHY_READ_TO}[#else]0x0000FFFF[/#if])
#define PHY_WRITE_TO                    ((uint32_t)[#if PHY_WRITE_TO??]${PHY_WRITE_TO}[#else]0x0000FFFF[/#if])

/* Section 3: Common PHY Registers */

#define PHY_BCR                         ((uint16_t)[#if PHY_BCR??]${PHY_BCR}[#else]0x00[/#if])    /*!< Transceiver Basic Control Register   */
#define PHY_BSR                         ((uint16_t)[#if PHY_BSR??]${PHY_BSR}[#else]0x01[/#if])    /*!< Transceiver Basic Status Register    */
 
#define PHY_RESET                       ((uint16_t)[#if PHY_RESET??]${PHY_RESET}[#else]0x8000[/#if])  /*!< PHY Reset */
#define PHY_LOOPBACK                    ((uint16_t)[#if PHY_LOOPBACK??]${PHY_LOOPBACK}[#else]0x4000[/#if])  /*!< Select loop-back mode */
#define PHY_FULLDUPLEX_100M             ((uint16_t)[#if PHY_FULLDUPLEX_100M??]${PHY_FULLDUPLEX_100M}[#else]0x2100[/#if])  /*!< Set the full-duplex mode at 100 Mb/s */
#define PHY_HALFDUPLEX_100M             ((uint16_t)[#if PHY_HALFDUPLEX_100M??]${PHY_HALFDUPLEX_100M}[#else]0x2000[/#if])  /*!< Set the half-duplex mode at 100 Mb/s */
#define PHY_FULLDUPLEX_10M              ((uint16_t)[#if PHY_FULLDUPLEX_10M??]${PHY_FULLDUPLEX_10M}[#else]0x0100[/#if])  /*!< Set the full-duplex mode at 10 Mb/s  */
#define PHY_HALFDUPLEX_10M              ((uint16_t)[#if PHY_HALFDUPLEX_10M??]${PHY_HALFDUPLEX_10M}[#else]0x0000[/#if])  /*!< Set the half-duplex mode at 10 Mb/s  */
#define PHY_AUTONEGOTIATION             ((uint16_t)[#if PHY_AUTONEGOTIATION??]${PHY_AUTONEGOTIATION}[#else]0x1000[/#if])  /*!< Enable auto-negotiation function     */
#define PHY_RESTART_AUTONEGOTIATION     ((uint16_t)[#if PHY_RESTART_AUTONEGOTIATION??]${PHY_RESTART_AUTONEGOTIATION}[#else]0x0200[/#if])  /*!< Restart auto-negotiation function    */
#define PHY_POWERDOWN                   ((uint16_t)[#if PHY_POWERDOWN??]${PHY_POWERDOWN}[#else]0x0800[/#if])  /*!< Select the power down mode           */
#define PHY_ISOLATE                     ((uint16_t)[#if PHY_ISOLATE??]${PHY_ISOLATE}[#else]0x0400[/#if])  /*!< Isolate PHY from MII                 */

#define PHY_AUTONEGO_COMPLETE           ((uint16_t)[#if PHY_AUTONEGO_COMPLETE??]${PHY_AUTONEGO_COMPLETE}[#else]0x0020[/#if])  /*!< Auto-Negotiation process completed   */
#define PHY_LINKED_STATUS               ((uint16_t)[#if PHY_LINKED_STATUS??]${PHY_LINKED_STATUS}[#else]0x0004[/#if])  /*!< Valid link established               */
#define PHY_JABBER_DETECTION            ((uint16_t)[#if PHY_JABBER_DETECTION??]${PHY_JABBER_DETECTION}[#else]0x0002[/#if])  /*!< Jabber condition detected            */
  
/* Section 4: Extended PHY Registers */
[#--Common define--]
#define PHY_SR                          ((uint16_t)[#if PHY_SR??]${PHY_SR}[#else]0x10[/#if]U)    /*!< PHY status register Offset                      */
[#if PHY_Name?? && (PHY_Name=="DP83848_PHY_ADDRESS"||PHY_Name=="DP83848")] 
#define PHY_MICR                        ((uint16_t)[#if PHY_MICR??]${PHY_MICR}[#else]0x11[/#if]U)    /*!< MII Interrupt Control Register                  */
#define PHY_MISR                        ((uint16_t)[#if PHY_MISR??]${PHY_MISR}[#else]0x12[/#if]U)    /*!< MII Interrupt Status and Misc. Control Register */
#n#define PHY_LINK_STATUS                 ((uint16_t)[#if PHY_LINK_STATUS??]${PHY_LINK_STATUS}[#else]0x0001[/#if]U)  /*!< PHY Link mask                                   */
[#else]
#n
[/#if]
[#--Common define--]
#define PHY_SPEED_STATUS                ((uint16_t)[#if PHY_SPEED_STATUS??]${PHY_SPEED_STATUS}[#else]0x0002[/#if]U)  /*!< PHY Speed mask                                  */
#define PHY_DUPLEX_STATUS               ((uint16_t)[#if PHY_DUPLEX_STATUS??]${PHY_DUPLEX_STATUS}[#else]0x0004[/#if]U)  /*!< PHY Duplex mask                                 */
[#if PHY_Name?? && (PHY_Name=="DP83848_PHY_ADDRESS"||PHY_Name=="DP83848")]
#n#define PHY_MICR_INT_EN                 ((uint16_t)[#if PHY_MICR_INT_EN??]${PHY_MICR_INT_EN}[#else]0x0002[/#if]U)  /*!< PHY Enable interrupts                           */
#define PHY_MICR_INT_OE                 ((uint16_t)[#if PHY_MICR_INT_OE??]${PHY_MICR_INT_OE}[#else]0x0001[/#if]U)  /*!< PHY Enable output interrupt events              */
#n#define PHY_MISR_LINK_INT_EN            ((uint16_t)[#if PHY_MISR_LINK_INT_EN??]${PHY_MISR_LINK_INT_EN}[#else]0x0020[/#if]U)  /*!< Enable Interrupt on change of link status       */
#define PHY_LINK_INTERRUPT              ((uint16_t)[#if PHY_LINK_INTERRUPT??]${PHY_LINK_INTERRUPT}[#else]0x2000[/#if]U)  /*!< PHY link status interrupt mask                  */
[/#if]
[#if PHY_Name?? && (PHY_Name=="LAN8742A_PHY_ADDRESS")]
#n#define PHY_ISFR                        ((uint16_t)[#if PHY_ISFR??]${PHY_ISFR}[#else]0x1D[/#if]U)    /*!< PHY Interrupt Source Flag register Offset   */
#define PHY_ISFR_INT4                   ((uint16_t)[#if PHY_ISFR_INT4??]${PHY_ISFR_INT4}[#else]0x0010[/#if]U)  /*!< PHY Link down inturrupt       */  
[/#if]


/* Includes ------------------------------------------------------------------*/
/**
  * @brief Include module's header file 
  */

#ifdef HAL_RCC_MODULE_ENABLED
 #include "stm32f1xx_hal_rcc.h"
#endif /* HAL_RCC_MODULE_ENABLED */

#ifdef HAL_GPIO_MODULE_ENABLED
 #include "stm32f1xx_hal_gpio.h"
#endif /* HAL_GPIO_MODULE_ENABLED */
   
#ifdef HAL_DMA_MODULE_ENABLED
  #include "stm32f1xx_hal_dma.h"
#endif /* HAL_DMA_MODULE_ENABLED */
   
#ifdef HAL_ETH_MODULE_ENABLED
  #include "stm32f1xx_hal_eth.h"
#endif /* HAL_ETH_MODULE_ENABLED */  
   
#ifdef HAL_CAN_MODULE_ENABLED
 #include "stm32f1xx_hal_can.h"
#endif /* HAL_CAN_MODULE_ENABLED */

#ifdef HAL_CEC_MODULE_ENABLED
 #include "stm32f1xx_hal_cec.h"
#endif /* HAL_CEC_MODULE_ENABLED */

#ifdef HAL_CORTEX_MODULE_ENABLED
 #include "stm32f1xx_hal_cortex.h"
#endif /* HAL_CORTEX_MODULE_ENABLED */

#ifdef HAL_ADC_MODULE_ENABLED
 #include "stm32f1xx_hal_adc.h"
#endif /* HAL_ADC_MODULE_ENABLED */

#ifdef HAL_CRC_MODULE_ENABLED
 #include "stm32f1xx_hal_crc.h"
#endif /* HAL_CRC_MODULE_ENABLED */

#ifdef HAL_DAC_MODULE_ENABLED
 #include "stm32f1xx_hal_dac.h"
#endif /* HAL_DAC_MODULE_ENABLED */

#ifdef HAL_FLASH_MODULE_ENABLED
 #include "stm32f1xx_hal_flash.h"
#endif /* HAL_FLASH_MODULE_ENABLED */

#ifdef HAL_SRAM_MODULE_ENABLED
 #include "stm32f1xx_hal_sram.h"
#endif /* HAL_SRAM_MODULE_ENABLED */

#ifdef HAL_NOR_MODULE_ENABLED
 #include "stm32f1xx_hal_nor.h"
#endif /* HAL_NOR_MODULE_ENABLED */

#ifdef HAL_I2C_MODULE_ENABLED
 #include "stm32f1xx_hal_i2c.h"
#endif /* HAL_I2C_MODULE_ENABLED */

#ifdef HAL_I2S_MODULE_ENABLED
 #include "stm32f1xx_hal_i2s.h"
#endif /* HAL_I2S_MODULE_ENABLED */

#ifdef HAL_IWDG_MODULE_ENABLED
 #include "stm32f1xx_hal_iwdg.h"
#endif /* HAL_IWDG_MODULE_ENABLED */

#ifdef HAL_PWR_MODULE_ENABLED
 #include "stm32f1xx_hal_pwr.h"
#endif /* HAL_PWR_MODULE_ENABLED */

#ifdef HAL_RTC_MODULE_ENABLED
 #include "stm32f1xx_hal_rtc.h"
#endif /* HAL_RTC_MODULE_ENABLED */

#ifdef HAL_PCCARD_MODULE_ENABLED
 #include "stm32f1xx_hal_pccard.h"
#endif /* HAL_PCCARD_MODULE_ENABLED */ 

#ifdef HAL_SD_MODULE_ENABLED
 #include "stm32f1xx_hal_sd.h"
#endif /* HAL_SD_MODULE_ENABLED */  

#ifdef HAL_MMC_MODULE_ENABLED
 #include "stm32f1xx_hal_mmc.h"
#endif /* HAL_MMC_MODULE_ENABLED */

#ifdef HAL_NAND_MODULE_ENABLED
 #include "stm32f1xx_hal_nand.h"
#endif /* HAL_NAND_MODULE_ENABLED */     

#ifdef HAL_SPI_MODULE_ENABLED
 #include "stm32f1xx_hal_spi.h"
#endif /* HAL_SPI_MODULE_ENABLED */

#ifdef HAL_TIM_MODULE_ENABLED
 #include "stm32f1xx_hal_tim.h"
#endif /* HAL_TIM_MODULE_ENABLED */

#ifdef HAL_UART_MODULE_ENABLED
 #include "stm32f1xx_hal_uart.h"
#endif /* HAL_UART_MODULE_ENABLED */

#ifdef HAL_USART_MODULE_ENABLED
 #include "stm32f1xx_hal_usart.h"
#endif /* HAL_USART_MODULE_ENABLED */

#ifdef HAL_IRDA_MODULE_ENABLED
 #include "stm32f1xx_hal_irda.h"
#endif /* HAL_IRDA_MODULE_ENABLED */

#ifdef HAL_SMARTCARD_MODULE_ENABLED
 #include "stm32f1xx_hal_smartcard.h"
#endif /* HAL_SMARTCARD_MODULE_ENABLED */

#ifdef HAL_WWDG_MODULE_ENABLED
 #include "stm32f1xx_hal_wwdg.h"
#endif /* HAL_WWDG_MODULE_ENABLED */

#ifdef HAL_PCD_MODULE_ENABLED
 #include "stm32f1xx_hal_pcd.h"
#endif /* HAL_PCD_MODULE_ENABLED */


#ifdef HAL_HCD_MODULE_ENABLED
 #include "stm32f1xx_hal_hcd.h"
#endif /* HAL_HCD_MODULE_ENABLED */   
   

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

#endif /* __STM32F1xx_HAL_CONF_H */


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
