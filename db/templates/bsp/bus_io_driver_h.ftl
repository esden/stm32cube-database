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

[#assign DMAisTrue = false]

[#if busIODriverWithDma??]
    [#assign DMAisTrue = true]
[/#if]

[#list BspIpDatas as SWIP]
    [#assign IpName = "?"]
    [#list SWIP.variables as variables]
        [#if variables.name?contains("IpName")]
            [#assign IpName = variables.value]
        [/#if]	
    [/#list]
    [#if SWIP.bsp??]
        [#list SWIP.bsp as bsp]
            [#if IpName??]
                [#switch IpName]
                    [#case "SPI"]
                    [#assign SPIisTrue = true]
                    [#if SpiIpInstanceList == ""]
                        [#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = bsp.solution]
[#-- A.T Include temporary generated files for the generated code for IP used by the Platform Settings --]
                        [@common.optinclude name=mxTmpFolder+"/${SpiIpInstance?lower_case}_define_h.tmp"/]
#ifndef BUS_${SpiIpInstance}_POLL_TIMEOUT
  #define BUS_${SpiIpInstance}_POLL_TIMEOUT                   0x1000U
#endif
/* ${SpiIpInstance} Baud rate in bps  */
#ifndef BUS_${SpiIpInstance}_BAUDRATE
   #define BUS_${SpiIpInstance}_BAUDRATE   10000000U /* baud rate of SPIn = 10 Mbps*/
#endif
                    [#elseif !SpiIpInstanceList?contains(bsp.solution)]
                        [#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
[#-- A.T Include temporary generated files for the generated code for IP used by the Platform Settings --]
                        [@common.optinclude name=mxTmpFolder+"/${SpiIpInstance?lower_case}_define_h.tmp"/]
#ifndef BUS_${SpiIpInstance}_POLL_TIMEOUT
  #define BUS_${SpiIpInstance}_POLL_TIMEOUT                   0x1000U
#endif
/* ${SpiIpInstance} Baud rate in bps  */
#ifndef BUS_${SpiIpInstance}_BAUDRATE
   #define BUS_${SpiIpInstance}_BAUDRATE   10000000U /* baud rate of SPIn = 10 Mbps*/
#endif
                    [/#if]
                [#break]
                [#case "I2C"]
                    [#assign I2CisTrue = true]
                    [#if I2CIpInstanceList == ""]
                        [#assign I2CIpInstance = bsp.solution]
                        [#assign I2CIpInstanceList = bsp.solution]
[#-- A.T Include temporary generated files for the generated code for IP used by the Platform Settings --]
                        [@common.optinclude name=mxTmpFolder+"/${I2CIpInstance?lower_case}_define_h.tmp"/]
#ifndef BUS_${I2CIpInstance}_POLL_TIMEOUT
   #define BUS_${I2CIpInstance}_POLL_TIMEOUT                0x1000U
#endif
/* ${I2CIpInstance} Frequeny in Hz  */
#ifndef BUS_${I2CIpInstance}_FREQUENCY
   #define BUS_${I2CIpInstance}_FREQUENCY  1000000U /* Frequency of I2Cn = 100 KHz*/
#endif
                    [#elseif !I2CIpInstanceList?contains(bsp.solution)]
                        [#assign I2CIpInstance = bsp.solution]
                        [#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
[#-- A.T Include temporary generated files for the generated code for IP used by the Platform Settings --]
                        [@common.optinclude name=mxTmpFolder+"/${I2CIpInstance?lower_case}_define_h.tmp"/]
#ifndef BUS_${I2CIpInstance}_POLL_TIMEOUT
   #define BUS_${I2CIpInstance}_POLL_TIMEOUT                0x1000U
#endif
/* ${I2CIpInstance} Frequeny in Hz  */
#ifndef BUS_${I2CIpInstance}_FREQUENCY
   #define BUS_${I2CIpInstance}_FREQUENCY  1000000U /* Frequency of I2Cn = 100 KHz*/
#endif
                    [/#if]
                [#break]
                [#case "UART"]
                [#assign USARTisTrue = true]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
[#-- A.T Include temporary generated files for the generated code for IP used by the Platform Settings --]
                        [@common.optinclude name=mxTmpFolder+"/${UsartIpInstance?lower_case}_define_h.tmp"/]
#ifndef BUS_${UsartIpInstance}_BAUDRATE
   #define BUS_${UsartIpInstance}_BAUDRATE  9600U /* baud rate of UARTn = 9600 baud*/
#endif
#ifndef BUS_${UsartIpInstance}_POLL_TIMEOUT
   #define BUS_${UsartIpInstance}_POLL_TIMEOUT                9600U
#endif
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
[#-- A.T Include temporary generated files for the generated code for IP used by the Platform Settings --]
                        [@common.optinclude name=mxTmpFolder+"/${UsartIpInstance?lower_case}_define_h.tmp"/]
#ifndef BUS_${UsartIpInstance}_BAUDRATE
   #define BUS_${UsartIpInstance}_BAUDRATE  9600U /* baud rate of UARTn = 9600 baud*/
#endif
#ifndef BUS_${UsartIpInstance}_POLL_TIMEOUT
   #define BUS_${UsartIpInstance}_POLL_TIMEOUT                9600U
#endif
                    [/#if]
                [#break]
                [#case "USART"]
                [#assign USARTisTrue = true]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
[#-- A.T Include temporary generated files for the generated code for IP used by the Platform Settings --]
                        [@common.optinclude name=mxTmpFolder+"/${UsartIpInstance?lower_case}_define_h.tmp"/]
#ifndef BUS_${UsartIpInstance}_BAUDRATE
   #define BUS_${UsartIpInstance}_BAUDRATE  9600U /* baud rate of UARTn = 9600 baud*/
#endif
#ifndef BUS_${UsartIpInstance}_POLL_TIMEOUT
   #define BUS_${UsartIpInstance}_POLL_TIMEOUT                9600U
#endif
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
[#-- A.T Include temporary generated files for the generated code for IP used by the Platform Settings --]
                        [@common.optinclude name=mxTmpFolder+"/${UsartIpInstance?lower_case}_define_h.tmp"/]
#ifndef BUS_${UsartIpInstance}_BAUDRATE
   #define BUS_${UsartIpInstance}_BAUDRATE  9600U /* baud rate of UARTn = 9600 baud*/
#endif
#ifndef BUS_${UsartIpInstance}_POLL_TIMEOUT
   #define BUS_${UsartIpInstance}_POLL_TIMEOUT                9600U
#endif
                    [/#if]
                [#break]
                [#case "LPUART"]
                [#assign USARTisTrue = true]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
[#-- A.T Include temporary generated files for the generated code for IP used by the Platform Settings --]
                        [@common.optinclude name=mxTmpFolder+"/${UsartIpInstance?lower_case}_define_h.tmp"/]
#ifndef BUS_${UsartIpInstance}_BAUDRATE
   #define BUS_${UsartIpInstance}_BAUDRATE  9600U /* baud rate of UARTn = 9600 baud*/
#endif
#ifndef BUS_${UsartIpInstance}_POLL_TIMEOUT
   #define BUS_${UsartIpInstance}_POLL_TIMEOUT                9600U
#endif
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
[#-- A.T Include temporary generated files for the generated code for IP used by the Platform Settings --]
                        [@common.optinclude name=mxTmpFolder+"/${UsartIpInstance?lower_case}_define_h.tmp"/]
#ifndef BUS_${UsartIpInstance}_BAUDRATE
   #define BUS_${UsartIpInstance}_BAUDRATE  9600U /* baud rate of UARTn = 9600 baud*/
#endif
#ifndef BUS_${UsartIpInstance}_POLL_TIMEOUT
   #define BUS_${UsartIpInstance}_POLL_TIMEOUT                9600U
#endif
                    [/#if]
                [#break]
                [/#switch]
            [/#if]
        [/#list]
    [/#if]
[/#list]

/**
  * @}
  */

/** @defgroup ${BoardName?upper_case}_BUS_Private_Types ${BoardName?upper_case} BUS Private types
  * @{
  */
[#if I2CisTrue]
#if (USE_HAL_I2C_REGISTER_CALLBACKS == 1U)
typedef struct
{
  pI2C_CallbackTypeDef  pMspInitCb;
  pI2C_CallbackTypeDef  pMspDeInitCb;
}BSP_I2C_Cb_t;
#endif /* (USE_HAL_I2C_REGISTER_CALLBACKS == 1U) */
[/#if]
[#if SPIisTrue]
#if (USE_HAL_SPI_REGISTER_CALLBACKS == 1U)
typedef struct
{
  pSPI_CallbackTypeDef  pMspInitCb;
  pSPI_CallbackTypeDef  pMspDeInitCb;
}BSP_SPI_Cb_t;
#endif /* (USE_HAL_SPI_REGISTER_CALLBACKS == 1U) */
[/#if]
[#if USARTisTrue]
#if (USE_HAL_UART_REGISTER_CALLBACKS  == 1U)
typedef struct
{
  pUART_CallbackTypeDef  pMspInitCb;
  pUART_CallbackTypeDef  pMspDeInitCb;
}BSP_UART_Cb_t;
#endif /* (USE_HAL_UART_REGISTER_CALLBACKS == 1U) */

[/#if]
/**
  * @}
  */

/** @defgroup ${BoardName?upper_case}_LOW_LEVEL_Exported_Variables LOW LEVEL Exported Constants
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
    [#assign IpName = "?"]
    [#list SWIP.variables as variables]
        [#if variables.name?contains("IpName")]
            [#assign IpName = variables.value]
        [/#if]	
    [/#list]
    [#if SWIP.bsp??]
        [#list SWIP.bsp as bsp]
            [#if IpName??]
                [#switch IpName]
                    [#case "SPI"]
                    [#assign SPIisTrue = true]
                    [#if SpiIpInstanceList == ""]
                        [#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = bsp.solution]
extern SPI_HandleTypeDef h${SpiIpInstance?lower_case};
                    [#elseif !SpiIpInstanceList?contains(bsp.solution)]
                        [#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = SpiIpInstanceList + "," + bsp.solution]
extern SPI_HandleTypeDef h${SpiIpInstance?lower_case};
                    [/#if]
                [#break]
                [#case "I2C"]
                    [#assign I2CisTrue = true]
                    [#if I2CIpInstanceList == ""]
                        [#assign I2CIpInstance = bsp.solution]
                        [#assign I2CIpInstanceList = bsp.solution]
extern I2C_HandleTypeDef h${I2CIpInstance?lower_case};
                    [#elseif !I2CIpInstanceList?contains(bsp.solution)]
                        [#assign I2CIpInstance = bsp.solution]
                        [#assign I2CIpInstanceList = I2CIpInstanceList + "," + bsp.solution]
extern I2C_HandleTypeDef h${I2CIpInstance?lower_case};
                    [/#if]
                [#break]
                [#case "UART"]
                [#assign USARTisTrue = true]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
extern UART_HandleTypeDef h${UsartIpInstance?lower_case?replace("s","")};
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
extern UART_HandleTypeDef h${UsartIpInstance?lower_case?replace("s","")};
                    [/#if]
                [#break]
                [#case "USART"]
                [#assign USARTisTrue = true]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
extern UART_HandleTypeDef h${UsartIpInstance?lower_case?replace("s","")};
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
extern UART_HandleTypeDef h${UsartIpInstance?lower_case?replace("s","")};
                    [/#if]
                [#break]
                [#case "LPUART"]
                [#assign USARTisTrue = true]
                    [#if UsartIpInstanceList == ""]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = bsp.solution]
extern UART_HandleTypeDef h${UsartIpInstance?lower_case?replace("s","")};
                    [#elseif !UsartIpInstanceList?contains(bsp.solution)]
                        [#assign UsartIpInstance = bsp.solution]
                        [#assign UsartIpInstanceList = UsartIpInstanceList + "," + bsp.solution]
extern UART_HandleTypeDef h${UsartIpInstance?lower_case?replace("s","")};
                    [/#if]
                [#break]
                [/#switch]
            [/#if]
        [/#list]
    [/#if]
[/#list]

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
[#assign USARTDmaIsTrue = false]

[#assign SpiIpInstance = ""]
[#assign SpiIpInstanceList = ""]
[#assign SPI = ""]
[#assign SPIInstance = ""]
[#assign SPIDone = ""]
[#assign SPIDmaIsTrue = false]


[#assign I2CIpInstance = ""]
[#assign I2CIpInstanceList = ""]
[#assign I2C = ""]
[#assign I2CInstance = ""]
[#assign I2CDmaIsTrue = false]

[#list BspIpDatas as SWIP]
    [#assign IpName = "?"]
    [#list SWIP.variables as variables]
        [#if variables.name?contains("IpName")]
            [#assign IpName = variables.value]
        [/#if]	
    [/#list]
    [#if SWIP.bsp??]
        [#list SWIP.bsp as bsp]
            [#if IpName??]
                [#switch IpName]
                    [#case "SPI"]
                    [#if SpiIpInstanceList == ""]
/* BUS IO driver over SPI Peripheral */
                        [#assign SpiIpInstance = bsp.solution]
                        [#assign SpiIpInstanceList = bsp.solution]
                        [#assign SPIDmaIsTrue = bsp.dmaUsed]
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
                        [#assign I2CDmaIsTrue = bsp.dmaUsed]
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
                        [#assign USARTDmaIsTrue = bsp.dmaUsed]
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
                        [#assign USARTDmaIsTrue = bsp.dmaUsed]
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
                        [#assign USARTDmaIsTrue = bsp.dmaUsed]
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
#if (USE_HAL_I2C_REGISTER_CALLBACKS == 1U)
int32_t BSP_${IpInstance}_RegisterDefaultMspCallbacks (void);
int32_t BSP_${IpInstance}_RegisterMspCallbacks (BSP_I2C_Cb_t *Callbacks);
#endif /* (USE_HAL_I2C_REGISTER_CALLBACKS == 1U) */
[#if I2CDmaIsTrue]
int32_t BSP_${IpInstance}_Send_DMA(uint16_t DevAddr, uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_Recv_DMA(uint16_t DevAddr, uint8_t *pData, uint16_t Length);
[/#if]
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
#if (USE_HAL_SPI_REGISTER_CALLBACKS == 1U)
int32_t BSP_${IpInstance}_RegisterDefaultMspCallbacks (void);
int32_t BSP_${IpInstance}_RegisterMspCallbacks (BSP_SPI_Cb_t *Callbacks);
#endif /* (USE_HAL_SPI_REGISTER_CALLBACKS == 1U) */
[#if SPIDmaIsTrue]
int32_t BSP_${IpInstance}_Send_DMA(uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_Recv_DMA(uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_SendRecv_DMA(uint8_t *pTxData, uint8_t *pRxData, uint16_t Length);
[/#if]
[/#macro]
[#-- End macro generateBspSPI_Driver --]

[#-- macro generateBspUSART_Driver --]
[#macro generateBspUSART_Driver IpInstance]
HAL_StatusTypeDef MX_${IpInstance}_Init(UART_HandleTypeDef* huart);
int32_t BSP_${IpInstance}_Init(void);
int32_t BSP_${IpInstance}_DeInit(void);
int32_t BSP_${IpInstance}_Send(uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_Recv(uint8_t *pData, uint16_t Length);
#if (USE_HAL_UART_REGISTER_CALLBACKS == 1U)
int32_t BSP_${IpInstance}_RegisterDefaultMspCallbacks (void);
int32_t BSP_${IpInstance}_RegisterMspCallbacks (BSP_UART_Cb_t *Callbacks);
#endif /* (USE_HAL_UART_REGISTER_CALLBACKS == 1U)  */
[#if USARTDmaIsTrue]
int32_t BSP_${IpInstance}_Send_DMA(uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_Recv_DMA(uint8_t *pData, uint16_t Length);
int32_t BSP_${IpInstance}_SendRecv_DMA(uint8_t *pTxData, uint8_t *pRxData, uint16_t Length);
[/#if]
[/#macro]
[#-- End macro generateBspUSART_Driver --]


int32_t BSP_GetTick(void);

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
