[#ftl]
/**
  ******************************************************************************
  * @file           : bus_spi.h
  * @brief          : header file for the BSP BUS IO driver over SPI
  ******************************************************************************
[@common.optinclude name=sourceDir+"Src/license.tmp"/][#--include License text --]
  ******************************************************************************
*/
[#assign IpInstance = ""]
[#list BspIpDatas as SWIP] 
	[#if SWIP.variables??]
		[#list SWIP.variables as variables]
		[#if variables.name?contains("IpName")]
			[#assign IpName = variables.value]
		[/#if]
		[#if variables.name?contains("IpInstance")]
			[#assign IpInstance = variables.value]
		[/#if]	
		[#if variables.name?contains("I2CAddr")]
			[#assign I2CAddr = variables.value]
		[/#if]
		[#if variables.name?contains("I2CReg")]
			[#assign I2CReg = variables.value]
		[/#if]		
		[/#list]
	[/#if]
[/#list]	

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __BUS_SPI_H
#define __BUS_SPI_H

#ifdef __cplusplus
 extern "C" {
#endif

/* Common Error codes */
#define BSP_ERROR_NONE                    0
#define BSP_ERROR_NO_INIT                -1
#define BSP_ERROR_WRONG_PARAM            -2
#define BSP_ERROR_BUSY                   -3
#define BSP_ERROR_PERIPH_FAILURE         -4
#define BSP_ERROR_COMPONENT_FAILURE      -5
#define BSP_ERROR_UNKNOWN_FAILURE        -6
#define BSP_ERROR_UNKNOWN_COMPONENT      -7 
#define BSP_ERROR_BUS_FAILURE            -8 
#define BSP_ERROR_CLOCK_FAILURE          -9  
#define BSP_ERROR_MSP_FAILURE            -10  
 
/* Includes ------------------------------------------------------------------*/
#include <stdint.h>

int32_t BSP_${IpInstance}_Init(void);
int32_t BSP_${IpInstance}_DeInit(void);
int32_t BSP_${IpInstance}_Send(uint16_t DevAddr, uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_Recv(uint16_t DevAddr, uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_SendRecv(uint16_t DevAddr, uint8_t *pTxdata, uint8_t *pRxdata, uint16_t Length);
int32_t BSP_GetTick(void);

#ifdef __cplusplus
}
#endif

#endif

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
