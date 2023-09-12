[#ftl]
/**
  ******************************************************************************
  * @file           : ${BoardName}_conf.h
  * @brief          : Configuration file
  ******************************************************************************
[@common.optinclude name="Src/license.tmp"/][#--include License text --]
  ******************************************************************************
*/


/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef ${BoardName?upper_case}_CONF_H
#define ${BoardName?upper_case}_CONF_H

#ifdef __cplusplus
 extern "C" {
#endif
/* Includes ------------------------------------------------------------------*/
[#if isHalSupported?? && isHALUsed?? ]
#include "${FamilyName?lower_case}xx_hal.h"
[/#if]
[#assign STM32WL=false]
[#if FamilyName?lower_case?contains("wl")]
[#assign STM32WL=true]
[/#if]


/** @addtogroup BSP
  * @{
  */
  
/** @addtogroup ${BoardName?upper_case}
  * @{
  */

/** @defgroup ${BoardName?upper_case}_CONFIG Config
  * @{
  */ 
  
/** @defgroup ${BoardName?upper_case}_CONFIG_Exported_Constants
  * @{
  */ 
[#assign IpName = ""]
[#assign IpInstance = ""]
[#assign UsartInstance = ""]
[#assign useUSART = false]
[#list BspIpDatas as SWIP] 
    [#if SWIP.variables??]
        [#list SWIP.variables as variables]
            [#if variables.name?contains("IpInstance")]
                [#assign IpInstance = variables.value]
            [/#if]
            [#if variables.name?contains("IpName")]
                [#assign IpName = variables.value]
            [/#if]	            
            [#if variables.value?contains("BSP USART")]
                [#assign UsartInstance = IpInstance]				
				[#assign useUSART = true]
            [/#if]           
        [/#list]
    [/#if]
    [#-- BZ 94788 --]
    [#if SWIP.bsp??]        
     	[#list SWIP.bsp as bsp]
     		[#if bsp.bspName?contains("BSP USART")]
     			[#assign useUSART = true]
     		[/#if]
     	[/#list]
    [/#if]
[/#list] 
/* COM Feature define */
[#if useUSART]
#define USE_BSP_COM_FEATURE                 1U

[#else]
#define USE_BSP_COM_FEATURE                 0U
[/#if]
  
/* COM define */
#define USE_COM_LOG                         1U
   
/* IRQ priorities */
#define BSP_BUTTON_USER_IT_PRIORITY         15U

/* I2C1 Frequeny in Hz  */
#define BUS_I2C1_FREQUENCY                  100000U /* Frequency of I2C1 = 100 KHz*/

/* SPI1 Baud rate in bps  */
#define BUS_SPI1_BAUDRATE                   16000000U /* baud rate of SPIn = 16 Mbps */

/* UART1 Baud rate in bps  */
#define BUS_UART1_BAUDRATE                  9600U /* baud rate of UARTn = 9600 baud */

[#if STM32WL]
/* Radio maximum wakeup time (in ms) */
#define RF_WAKEUP_TIME                     100U

/* Indicates whether or not TCXO is supported by the board
 * 0: TCXO not supported
 * 1: TCXO supported
 */
#define IS_TCXO_SUPPORTED                   0U

/* Indicates whether or not DCDC is supported by the board
 * 0: DCDC not supported
 * 1: DCDC supported
 */
#define IS_DCDC_SUPPORTED                   1U
[/#if]
/**
  * @}
  */

/**
  * @}
  */
  
/**
  * @}
  */
  
/**
  * @}
  */
  
#ifdef __cplusplus
}
#endif   
#endif  /* ${BoardName?upper_case}_CONF_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
