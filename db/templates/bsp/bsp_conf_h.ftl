[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : ${BoardName}_conf.h
  * @brief          : Configuration file
  ******************************************************************************
[@common.optinclude name=mxTmpFolder + "/license.tmp"/][#--include License text --]
  ******************************************************************************
*/
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef ${BoardName?upper_case}_CONF_H
#define ${BoardName?upper_case}_CONF_H

#ifdef __cplusplus
 extern "C" {
#endif
/* Includes ------------------------------------------------------------------*/
[#if isHalSupported?? && isHALUsed?? ]
    [#if FamilyName?matches("STM32W(B0|L3)*")]
#include "${FamilyName?lower_case}x_hal.h"
    [#else]
#include "${FamilyName?lower_case}xx_hal.h"
    [/#if]
[/#if]
[#assign STM32WL=false]
[#if FamilyName?lower_case?contains("wl")]
[#assign STM32WL=true]
[/#if]
[#assign STM32WB=false]
[#if FamilyName?lower_case?contains("wb")]
[#assign STM32WB=true]
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
[#if !RTOS_ACTIVATED??]
#define BSP_BUTTON_USER_IT_PRIORITY         15U
[#else]
#define BSP_BUTTON_USER_IT_PRIORITY         14U
[/#if]

[#if STM32WL || STM32WL]
#define BSP_BUTTON_SWx_IT_PRIORITY         BSP_BUTTON_USER_IT_PRIORITY
[/#if]

/* I2C1 Frequency in Hz  */
#define BUS_I2C1_FREQUENCY                  100000U /* Frequency of I2C1 = 100 KHz*/

/* SPI1 Baud rate in bps  */
#define BUS_SPI1_BAUDRATE                   16000000U /* baud rate of SPIn = 16 Mbps */

/* UART1 Baud rate in bps  */
#define BUS_UART1_BAUDRATE                  9600U /* baud rate of UARTn = 9600 baud */

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

