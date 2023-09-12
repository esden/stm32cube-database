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
[#assign SpiIpInstance = ""]
[#assign I2CInstance = ""]
[#assign I2CisTrue = false]
[#assign SPIisTrue = false]
[#list BspIpDatas as SWIP] 
	[#if SWIP.bsp??]
		[#list SWIP.bsp as bsp]
			[#assign IpName = bsp.bspIpName]			
			[#if IpName??]
				[#switch IpName]
					[#case "SPI"]	
						[#assign SPIisTrue = true]	
						[#assign SpiIpInstance = bsp.solution]										
				[#break]
				[#case "I2C"]
					[#assign I2CisTrue = true]					
					[#assign I2CInstance = bsp.solution]
				[#break]  				
				[/#switch]
			[/#if]			
		[/#list]
	[/#if]
[/#list]
/* COM Feature define */
#define USE_BSP_COM_FEATURE                 1U
  
/* COM define */
#define USE_COM_LOG                         1U
   
/* IRQ priorities */
#define BSP_BUTTON_KEY_IT_PRIORITY          15U

/* I2C1 Frequeny in Hz  */
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

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
