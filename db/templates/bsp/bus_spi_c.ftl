[#ftl]
/**
  ******************************************************************************
  * @file           : bus_spi.c
  * @brief          : source file for the BSP BUS IO driver over SPI
  ******************************************************************************
[@common.optinclude name=sourceDir+"Src/license.tmp"/][#--include License text --]
  ******************************************************************************
*/
[#assign IpInstance = ""]
[#assign IpHandle = ""]
[#list BspIpDatas as SWIP] 
	[#if SWIP.variables??]
		[#list SWIP.variables as variables]
		[#if variables.name?contains("IpName")]
			[#assign IpName = variables.value]
		[/#if]
		[#if variables.name?contains("IpInstance")]
			[#assign IpInstance = variables.value]
			[#assign IpHandle = IpInstance?lower_case]
		[/#if]	
		[/#list]
	[/#if]
[/#list]	
                                              
/* Includes ------------------------------------------------------------------*/
#include "bus_spi.h"
[#if isHalSupported?? && isHALUsed?? ]
#include "${FamilyName?lower_case}xx_hal.h"
[/#if]

extern void MX_${IpInstance}_Init(void);
extern SPI_HandleTypeDef h${IpHandle};

#define TIMEOUT_DURATION 1000

/*******************************************************************************
                            BUS OPERATIONS
*******************************************************************************/
/**
  * @brief  Initializes SPI HAL.
  * @retval None
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Init(void) {

  if (HAL_SPI_GetState(&h${IpHandle}) == HAL_SPI_STATE_RESET) {
		MX_${IpInstance}_Init();
  }

  return BSP_ERROR_NONE;
}


/**
  * @brief  DeInitializes SPI HAL.
  * @retval None
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_DeInit(void) {
  int32_t ret = BSP_ERROR_BUS_FAILURE;
  
  if (HAL_SPI_DeInit(&h${IpHandle}) == HAL_OK) {
    ret = BSP_ERROR_NONE;
  }
  
  return ret;
}


/**
  * @brief  Write Data through SPI BUS.
  * @param  pData: Data
  * @param  len: Length of data in byte
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Send(uint16_t DevAddr, uint8_t *pData, uint16_t len)
{
  int32_t ret = BSP_ERROR_UNKNOWN_FAILURE;
  
  if(HAL_SPI_Transmit(&h${IpHandle}, pData, len, TIMEOUT_DURATION) == HAL_OK)
  {
      ret = len;
  }
  return ret;
}


/**
  * @brief  Receive Data from SPI BUS
  * @param  pData: Data
  * @param  len: Length of data in byte
  * @retval BSP status
  */
int32_t  BSP_${IpInstance}_Recv(uint16_t DevAddr, uint8_t *pData, uint16_t len)
{
  int32_t ret = BSP_ERROR_UNKNOWN_FAILURE;
  
  if(HAL_SPI_Receive(&h${IpHandle}, pData, len, TIMEOUT_DURATION) == HAL_OK)
  {
      ret = len;
  }
  return ret;
}


/**
  * @brief  Send and Receive data to/from SPI BUS (Full duplex)
  * @param  pData: Data
  * @param  len: Length of data in byte
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_SendRecv(uint16_t DevAddr, uint8_t *pTxData, uint8_t *pRxData, uint16_t len)
{
  int32_t ret = BSP_ERROR_UNKNOWN_FAILURE;
  
  if(HAL_SPI_TransmitReceive(&h${IpHandle}, pTxData, pRxData, len, TIMEOUT_DURATION) == HAL_OK)
  {
      ret = len;
  }
  return ret;
}


/**
  * @brief  Return system tick (ms) function .
  * @retval Current HAL time base time stamp
  */
int32_t BSP_GetTick(void)
{
  return HAL_GetTick();
}


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
