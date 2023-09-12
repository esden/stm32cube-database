[#ftl]
/**
  ******************************************************************************
  * @file           : ${BoardName}_bus.h
  * @brief          : header file for the BSP BUS IO driver over SPI
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
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
#ifndef __${BoardName?upper_case}_BUS_H
#define __${BoardName?upper_case}_BUS_H

#ifdef __cplusplus
 extern "C" {
#endif
/* Includes ------------------------------------------------------------------*/
#include <stdint.h>

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
 
 #if (USE_HAL_SPI_REGISTER_CALLBACKS == 1)
typedef struct
{
  pSPI_CallbackTypeDef  pMspSpiInitCb;
  pSPI_CallbackTypeDef  pMspSpiDeInitCb;
}BSP_BUS_Cb_t;
#endif /* ((USE_HAL_I2C_REGISTER_CALLBACKS == 1) || (USE_HAL_SPI_REGISTER_CALLBACKS == 1)) */
 

/* BUS IO driver over SPI Peripheral */
int32_t BSP_${IpInstance}_Init(void);
int32_t BSP_${IpInstance}_DeInit(void);
int32_t BSP_${IpInstance}_Send(uint8_t *pData, uint16_t len);
int32_t BSP_${IpInstance}_Recv(uint8_t *pData, uint16_t len);
int32_t BSP_${IpInstance}_SendRecv(uint8_t *pTxData, uint8_t *pRxData, uint16_t len);
int32_t BSP_GetTick(void);
__weak void MX_${IpInstance}_Init(void);

#if (USE_HAL_SPI_REGISTER_CALLBACKS == 1)
int32_t BSP_BUS_RegisterDefaultMspCallbacks (uint32_t Instance);
int32_t BSP_BUS_RegisterMspCallbacks (uint32_t Instance, BSP_BUS_Cb_t *Callbacks);
#endif /* ((USE_HAL_I2C_REGISTER_CALLBACKS == 1) || (USE_HAL_SPI_REGISTER_CALLBACKS == 1)) */

#ifdef __cplusplus
}
#endif

#endif /* __${BoardName?upper_case}_BUS_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
