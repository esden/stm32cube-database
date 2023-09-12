[#ftl]
/**
  ******************************************************************************
  * @file           : ${BoardName}_bus.h
  * @brief          : header file for the BSP BUS IO driver
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
*/


/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${BoardName?upper_case}_BUS_H
#define __${BoardName?upper_case}_BUS_H

#ifdef __cplusplus
 extern "C" {
#endif

#define USE_HAL_SPI_REGISTER_CALLBACKS 0 
#define USE_HAL_I2C_REGISTER_CALLBACKS 0 


#if (USE_HAL_I2C_REGISTER_CALLBACKS == 1)
typedef struct
{
  pI2C_CallbackTypeDef  pMspI2cInitCb;
  pI2C_CallbackTypeDef  pMspI2cDeInitCb;
}BSP_I2C_Cb_t;
#endif /* (USE_HAL_I2C_REGISTER_CALLBACKS == 1) */

#if (USE_HAL_SPI_REGISTER_CALLBACKS == 1) 
typedef struct
{
  pSPI_CallbackTypeDef  pMspSpiInitCb;
  pSPI_CallbackTypeDef  pMspSpiDeInitCb;
}BSP_SPI_Cb_t;
#endif /* (USE_HAL_SPI_REGISTER_CALLBACKS == 1) */
 

/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
[#assign IpName = ""]
[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign I2CIpInstance = ""]
[#assign I2CIpInstanceList = ""]
[#assign I2C = ""]
[#assign I2CInstance = ""]
[#assign SPI = ""]
[#assign SPIInstance = ""]
[#assign SPIDone = ""]
[#list BspIpDatas as SWIP] 
	[#if SWIP.bsp??]
		[#list SWIP.bsp as bsp]
			[#assign IpName = bsp.bspIpName]			
			[#if IpName??]
				[#switch IpName]
					[#case "SPI"]					
					[#if SpiIpInstanceList == ""]
/* BUS IO driver over SPI Peripheral */
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = bsp.solution]
						[@generateBspSPI_Driver SpiIpInstance/]						
					[#elseif !SpiIpInstanceList?contains(bsp.solution)]
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = SpiIpInstanceList + ", " + bsp.solution]
						[@generateBspSPI_Driver SpiIpInstance/]
					[/#if]
				[#break]
				[#case "I2C"]
					[#if I2CIpInstanceList == ""]
/* BUS IO driver over I2C Peripheral */
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = bsp.solution]
						[@generateBspI2C_Driver I2CIpInstance/]						
					[#elseif !I2CIpInstanceList?contains(bsp.solution)]
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = I2CIpInstanceList + ", " + bsp.solution]
						[@generateBspI2C_Driver I2CIpInstance/]
					[/#if]
				[#break]  
				[#default]
					...
				[/#switch]
			[/#if]			
		[/#list]
	[/#if]
[/#list]

[#-- macro generateBspI2C_Driver --]
[#macro generateBspI2C_Driver IpInstance]
int32_t BSP_${IpInstance}_Init(void);
int32_t BSP_${IpInstance}_DeInit(void);
int32_t BSP_${IpInstance}_IsReady(void);
int32_t BSP_${IpInstance}_WriteReg(uint16_t Addr, uint16_t Reg, uint8_t *pData, uint16_t len);
int32_t BSP_${IpInstance}_ReadReg(uint16_t Addr, uint16_t Reg, uint8_t *pData, uint16_t len);
int32_t BSP_${IpInstance}_WriteReg16(uint16_t Addr, uint16_t Reg, uint8_t *pData, uint16_t len);
int32_t BSP_${IpInstance}_ReadReg16(uint16_t Addr, uint16_t Reg, uint8_t *pData, uint16_t len);
int32_t BSP_${IpInstance}_Send(uint16_t DevAddr, uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_Recv(uint16_t DevAddr, uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_SendRecv(uint16_t DevAddr, uint8_t *pTxdata, uint8_t *pRxdata, uint16_t Length);
[#-- __weak void MX_${IpInstance}_Init(void); --]
[#-- __weak HAL_StatusTypeDef MX_${IpInstance}_Init(I2C_HandleTypeDef* hi2c); --] [#--  Removed as expected by Maher and Carlo--]
[/#macro]
[#-- End macro generateBspI2C_Driver --]

[#-- macro generateBspSPI_Driver --]
[#macro generateBspSPI_Driver IpInstance]
int32_t BSP_${IpInstance}_Init(void);
int32_t BSP_${IpInstance}_DeInit(void);
int32_t BSP_${IpInstance}_Send(uint8_t *pData, uint16_t len);
int32_t BSP_${IpInstance}_Recv(uint8_t *pData, uint16_t len);
int32_t BSP_${IpInstance}_SendRecv(uint8_t *pTxData, uint8_t *pRxData, uint16_t len);
[#-- __weak void MX_${IpInstance}_Init(void); --]
[#-- __weak HAL_StatusTypeDef MX_${IpInstance}_Init(SPI_HandleTypeDef* hspi); --] [#--  Removed as expected by Maher and Carlo--]
[/#macro]
[#-- End macro generateBspSPI_Driver --]


int32_t BSP_GetTick(void);

#if (USE_HAL_SPI_REGISTER_CALLBACKS == 1)
int32_t BSP_BUS_RegisterDefaultMspCallbacks (void);
int32_t BSP_BUS_RegisterMspCallbacks (BSP_BUS_Cb_t *Callbacks);
#endif /* ((USE_HAL_I2C_REGISTER_CALLBACKS == 1) || (USE_HAL_SPI_REGISTER_CALLBACKS == 1)) */


#ifdef __cplusplus
}
#endif

#endif /* __${BoardName?upper_case}_BUS_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
