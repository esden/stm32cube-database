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
#ifndef ${BoardName?upper_case}_BUS_H
#define ${BoardName?upper_case}_BUS_H

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "${BoardName}_conf.h"
#include "${BoardName}_errno.h"

/** @addtogroup BSP
  * @{
  */

/** @addtogroup ${BoardName?upper_case}
  * @{
  */

/** @defgroup ${BoardName?upper_case}_BUS ${BoardName?upper_case} BUS
  * @{
  */

/** @defgroup ${BoardName?upper_case}_BUS_Exported_Constants ${BoardName?upper_case} BUS Exported Constants
  * @{
  */
[#assign IpName = ""]

[#assign UsartIpInstance = ""]
[#assign UsartIpInstanceList = ""]
[#assign USART = ""]
[#assign USARTisTrue = false]
[#assign USARTInstance = ""]

[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign SPI = ""]
[#assign SPIisTrue = false]
[#assign SPIInstance = ""]
[#assign SPIDone = ""]

[#assign I2CIpInstance = ""]
[#assign I2CIpInstanceList = ""]
[#assign I2C = ""]
[#assign I2CisTrue = false]
[#assign I2CInstance = ""]


[#list BspIpDatas as SWIP] 
	[#if SWIP.bsp??]
		[#list SWIP.bsp as bsp]
			[#assign IpName = bsp.bspIpName]			
			[#if IpName??]
				[#switch IpName]
					[#case "SPI"]
					[#assign SPIisTrue = true]					
					[#if SpiIpInstanceList == ""]
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = bsp.solution]					
					[#elseif !SpiIpInstanceList?contains(bsp.solution)]
						[#assign SpiIpInstance = bsp.solution]
						[#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
					[/#if]
				[#break]
				[#case "I2C"]
					[#assign I2CisTrue = true]
					[#if I2CIpInstanceList == ""]
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = bsp.solution]						
					[#elseif !I2CIpInstanceList?contains(bsp.solution)]
						[#assign I2CIpInstance = bsp.solution]
						[#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
					[/#if]
				[#break] 
                [#case "UART"]
				[#assign USARTisTrue = true]
					[#if UsartIpInstanceList == ""]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = bsp.solution]						
					[#elseif !UsartIpInstanceList?contains(bsp.solution)]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
					[/#if]
				[#break]
				[#case "USART"]
				[#assign USARTisTrue = true]
					[#if UsartIpInstanceList == ""]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = bsp.solution]						
					[#elseif !UsartIpInstanceList?contains(bsp.solution)]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
					[/#if]
				[#break]
				[#case "LPUART"]
				[#assign USARTisTrue = true]
					[#if UsartIpInstanceList == ""]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = bsp.solution]						
					[#elseif !UsartIpInstanceList?contains(bsp.solution)]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
					[/#if]
				[#break]
				[/#switch]
			[/#if]			
		[/#list]
	[/#if]
[/#list]
  
[#if  I2CisTrue]
#ifndef BUS_I2C1_POLL_TIMEOUT
   #define BUS_I2C1_POLL_TIMEOUT                0x1000U   
#endif
/* ${I2CInstance} Frequeny in Hz  */
#ifndef BUS_${I2CInstance}_FREQUENCY  
   #define BUS_${I2CInstance}_FREQUENCY  1000000U /* Frequency of I2Cn = 100 KHz*/
#endif
[/#if] 

[#if  SPIisTrue]
#ifndef BUS_SPI1_POLL_TIMEOUT
  #define BUS_SPI1_POLL_TIMEOUT                   0x1000
#endif
/* ${SpiIpInstance} Baud rate in bps  */
#ifndef BUS_${SpiIpInstance}_BAUDRATE   
   #define BUS_${SpiIpInstance}_BAUDRATE   10000000U /* baud rate of SPIn = 10 Mbps*/
#endif
[/#if] 

[#if  USARTisTrue]
#ifndef BUS_UART1_BAUDRATE 
   #define BUS_UART1_BAUDRATE  9600U /* baud rate of UARTn = 9600 baud*/
#endif  
#ifndef BUS_UART1_POLL_TIMEOUT
   #define BUS_UART1_POLL_TIMEOUT                9600U   
#endif  
[/#if] 

/**
  * @}
  */

/** @defgroup ${BoardName?upper_case}_BUS_Private_Types ${BoardName?upper_case} BUS Private types
  * @{
  */
[#if I2CisTrue]
#if (USE_HAL_I2C_REGISTER_CALLBACKS == 1)
typedef struct
{
  pI2C_CallbackTypeDef  pMspInitCb;
  pI2C_CallbackTypeDef  pMspDeInitCb;
}BSP_${IpInstance}_Cb_t;
#endif /* (USE_HAL_I2C_REGISTER_CALLBACKS == 1) */
[/#if]
[#if SPIisTrue]
#if (USE_HAL_SPI_REGISTER_CALLBACKS == 1) 
typedef struct
{
  pSPI_CallbackTypeDef  pMspInitCb;
  pSPI_CallbackTypeDef  pMspDeInitCb;
}BSP_${IpInstance}_Cb_t;
#endif /* (USE_HAL_SPI_REGISTER_CALLBACKS == 1) */
[/#if] 
[#if USARTisTrue]
#if (USE_HAL_UART_REGISTER_CALLBACKS  == 1) 
typedef struct
{
  pUART_CallbackTypeDef  pMspInitCb;
  pUART_CallbackTypeDef  pMspDeInitCb;
}BSP_UART_Cb_t;
#endif /* (USE_HAL_UART_REGISTER_CALLBACKS == 1) */

[/#if]
/**
  * @}
  */
  
/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_Exported_Variables LOW LEVEL Exported Constants
  * @{
  */ 
[#if I2CisTrue]
extern I2C_HandleTypeDef h${I2CIpInstance?lower_case};	
[/#if]
[#if SPIisTrue]
extern SPI_HandleTypeDef h${SpiIpInstance?lower_case};	
[/#if]
[#if USARTisTrue]
extern UART_HandleTypeDef h${UsartIpInstance?lower_case};	
[/#if]
/**
  * @}
  */

/** @addtogroup ${BoardName?upper_case}_BUS_Exported_Functions
  * @{
  */    


[#assign IpName = ""]

[#assign UsartIpInstance = ""]
[#assign UsartIpInstanceList = ""]
[#assign USART = ""]
[#assign USARTisTrue = false]
[#assign USARTInstance = ""]

[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign SPI = ""]
[#assign SPIInstance = ""]
[#assign SPIDone = ""]

[#assign I2CIpInstance = ""]
[#assign I2CIpInstanceList = ""]
[#assign I2C = ""]
[#assign I2CInstance = ""]

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
						[#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
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
						[#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
						[@generateBspI2C_Driver I2CIpInstance/]
					[/#if]
				[#break] 
				[#case "UART"]
				[#assign USARTisTrue = true]
					[#if UsartIpInstanceList == ""]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = bsp.solution]
						[@generateBspUSART_Driver UsartIpInstance/]						
					[#elseif !UsartIpInstanceList?contains(bsp.solution)]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
						[@generateBspUSART_Driver UsartIpInstance/]	
					[/#if]
				[#break]
				[#case "USART"]
				[#assign USARTisTrue = true]
					[#if UsartIpInstanceList == ""]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = bsp.solution]
						[@generateBspUSART_Driver UsartIpInstance/]							
					[#elseif !UsartIpInstanceList?contains(bsp.solution)]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
						[@generateBspUSART_Driver UsartIpInstance/]	
					[/#if]
				[#break]				
				[#case "LPUART"]
				[#assign USARTisTrue = true]
					[#if UsartIpInstanceList == ""]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = bsp.solution]
						[@generateBspUSART_Driver UsartIpInstance/]							
					[#elseif !UsartIpInstanceList?contains(bsp.solution)]
						[#assign UsartIpInstance = bsp.solution]
						[#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
						[@generateBspUSART_Driver UsartIpInstance/]	
					[/#if]
				[#break]	
				[/#switch]
			[/#if]			
		[/#list]
	[/#if]
[/#list]

  
[#-- macro generateBspI2C_Driver --]
[#macro generateBspI2C_Driver IpInstance]
HAL_StatusTypeDef MX_${IpInstance}_Init(I2C_HandleTypeDef* hi2c);
int32_t BSP_${IpInstance}_Init(void);
int32_t BSP_${IpInstance}_DeInit(void);
int32_t BSP_${IpInstance}_IsReady(uint16_t DevAddr, uint32_t Trials);
int32_t BSP_${IpInstance}_WriteReg(uint16_t Addr, uint16_t Reg, uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_ReadReg(uint16_t Addr, uint16_t Reg, uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_WriteReg16(uint16_t Addr, uint16_t Reg, uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_ReadReg16(uint16_t Addr, uint16_t Reg, uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_Send(uint16_t DevAddr, uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_Recv(uint16_t DevAddr, uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_SendRecv(uint16_t DevAddr, uint8_t *pTxdata, uint8_t *pRxdata, uint16_t Length);
[/#macro]
[#-- End macro generateBspI2C_Driver --]

[#-- macro generateBspSPI_Driver --]
[#macro generateBspSPI_Driver IpInstance]
HAL_StatusTypeDef MX_${IpInstance}_Init(SPI_HandleTypeDef* hspi);
int32_t BSP_${IpInstance}_Init(void);
int32_t BSP_${IpInstance}_DeInit(void);
int32_t BSP_${IpInstance}_Send(uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_Recv(uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_SendRecv(uint8_t *pTxData, uint8_t *pRxData, uint16_t Length);

[/#macro]
[#-- End macro generateBspSPI_Driver --]

[#-- macro generateBspUSART_Driver --]
[#macro generateBspUSART_Driver IpInstance]
HAL_StatusTypeDef MX_${IpInstance}_Init(UART_HandleTypeDef* huart);
int32_t BSP_${IpInstance}_Init(BUS_UART_InitTypeDef *Init);
int32_t BSP_${IpInstance}_DeInit(void);
int32_t BSP_${IpInstance}_Send(uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_Recv(uint8_t *pData, uint16_t Length);

[/#macro]
[#-- End macro generateBspUSART_Driver --]


int32_t BSP_GetTick(void);

[#if I2CisTrue]
#if (USE_HAL_I2C_REGISTER_CALLBACKS == 1)
int32_t BSP_${IpInstance}_RegisterDefaultMspCallbacks (void);
int32_t BSP_${IpInstance}_RegisterMspCallbacks (BSP_${IpInstance}_Cb_t *Callbacks);
#endif /* (USE_HAL_I2C_REGISTER_CALLBACKS == 1) */
[/#if]

[#if SPIisTrue]
#if (USE_HAL_SPI_REGISTER_CALLBACKS == 1)
int32_t BSP_${IpInstance}_RegisterDefaultMspCallbacks (void);
int32_t BSP_${IpInstance}_RegisterMspCallbacks (BSP_${IpInstance}_Cb_t *Callbacks);
#endif /* (USE_HAL_SPI_REGISTER_CALLBACKS == 1) */
[/#if]

[#if SPIisTrue]
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1)
int32_t BSP_${IpInstance}_RegisterDefaultMspCallbacks (void);
int32_t BSP_${IpInstance}_RegisterMspCallbacks (BSP_${IpInstance}_Cb_t *Callbacks);
#endif /* (USE_HAL_UART_REGISTER_CALLBACKS == 1)  */
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

#endif /* ${BoardName?upper_case}_BUS_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
