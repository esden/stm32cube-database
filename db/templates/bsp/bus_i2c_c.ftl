[#ftl]
/**
  ******************************************************************************
  * @file           : bus_i2c.c
  * @brief          : source file for the BSP BUS IO driver over I2C
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
		[#if variables.name?contains("I2CAddr")]
			[#assign I2CAddr = variables.value]
		[/#if]
		[#if variables.name?contains("I2CReg")]
			[#assign I2CReg = variables.value]
		[/#if]		
		[/#list]
	[/#if]
[/#list]	
                                              
/* Includes ------------------------------------------------------------------*/
#include "bus_i2c.h"
[#if isHalSupported?? && isHALUsed?? ]
#include "${FamilyName?lower_case}xx_hal.h"
[/#if]

extern I2C_HandleTypeDef h${IpHandle};
extern void MX_${IpInstance}_Init(void);

#define TIMEOUT_DURATION 1000

/*******************************************************************************
                            BUS OPERATIONS
*******************************************************************************/
/**
  * @brief  Initialize a bus
  * @param None
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Init(void) {

  if (HAL_I2C_GetState(&h${IpHandle}) == HAL_I2C_STATE_RESET) {
		MX_${IpInstance}_Init();
  }

  return BSP_ERROR_NONE;
}


/**
  * @brief  DeInitialize a bus
  * @param None
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_DeInit(void) {
  int32_t ret = BSP_ERROR_BUS_FAILURE;
  
  if (HAL_I2C_DeInit(&h${IpHandle}) == HAL_OK) {
    ret = BSP_ERROR_NONE;
  }
  
  return ret;
}

/**
  * @brief Return the status of the Bus
  *	@retval bool
  */
int32_t BSP_${IpInstance}_IsReady(void) {
	return (HAL_I2C_GetMode(&h${IpHandle}) == HAL_I2C_STATE_READY);
}


/**
  * @brief  Write registers through bus (8 bits)
  * @param  Addr: Device address on Bus.
  * @param  Reg: The target register address to write
  * @param  Value: The target register value to be written
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_WriteReg(uint16_t DevAddr, uint16_t Reg, uint8_t *pData, uint16_t len) {
  int32_t ret = BSP_ERROR_BUS_FAILURE;

  if(HAL_I2C_Mem_Write(&h${IpHandle}, (uint8_t)DevAddr,
                       (uint16_t)Reg, I2C_MEMADD_SIZE_8BIT,
                       (uint8_t *)pData, len, TIMEOUT_DURATION) == HAL_OK)
  {
    ret = BSP_ERROR_NONE;
  }

  return ret;
}


/**
  * @brief  Read registers through a bus (8 bits)
  * @param  DevAddr: Device address on BUS
  * @param  Reg: The target register address to read
  * @retval BSP status
  */
int32_t  BSP_${IpInstance}_ReadReg(uint16_t DevAddr, uint16_t Reg, uint8_t *pData, uint16_t len) {
  int32_t ret = BSP_ERROR_BUS_FAILURE;

  if (HAL_I2C_Mem_Read(&h${IpHandle}, DevAddr, (uint16_t)Reg,
                       I2C_MEMADD_SIZE_8BIT, pData,
                       len, TIMEOUT_DURATION) == HAL_OK)
  {
    ret = HAL_OK;
  }

  return ret;
}


/**
  * @brief  Write registers through bus (16 bits)
  * @param  Addr: Device address on Bus.
  * @param  Reg: The target register address to write
  * @param  Value: The target register value to be written
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_WriteReg16(uint16_t DevAddr, uint16_t Reg, uint8_t *pData, uint16_t len) {
  int32_t ret = BSP_ERROR_BUS_FAILURE;
  
  if(HAL_I2C_Mem_Write(&h${IpHandle}, (uint8_t)DevAddr,
                       (uint16_t)Reg, I2C_MEMADD_SIZE_16BIT,
                       (uint8_t *)pData, len, TIMEOUT_DURATION) == HAL_OK)
  {
    ret = BSP_ERROR_NONE;
  }
 
  return ret;
}


/**
  * @brief  Read registers through a bus (16 bits)
  * @param  DevAddr: Device address on BUS
  * @param  Reg: The target register address to read
  * @retval BSP status
  */
int32_t  BSP_${IpInstance}_ReadReg16(uint16_t DevAddr, uint16_t Reg, uint8_t *pData, uint16_t len) {
  int32_t ret = BSP_ERROR_BUS_FAILURE;
  
  if (HAL_I2C_Mem_Read(&h${IpHandle}, DevAddr, (uint16_t)Reg,
                       I2C_MEMADD_SIZE_16BIT, pData,
                       len, TIMEOUT_DURATION) == HAL_OK)
  {
    ret = BSP_ERROR_NONE;
  }
  
  return ret;
}


/**
  * @brief  Send an amount width data through bus (Simplex)
  * @param  DevAddr: Device address on Bus.
  * @param  pData: Data pointer
  * @param  Length: Data length
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Send(uint16_t DevAddr, uint8_t *pData, uint16_t len) {
	int32_t ret = BSP_ERROR_BUS_FAILURE;

	if (HAL_I2C_Master_Transmit (&h${IpHandle}, DevAddr, pData, len, TIMEOUT_DURATION) == HAL_OK) {
		ret = len;
	}

	return ret;
}


/**
  * @brief  Receive an amount of data through a bus (Simplex)
  * @param  DevAddr: Device address on Bus.
  * @param  pData: Data pointer
  * @param  Length: Data length
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_Recv(uint16_t DevAddr, uint8_t *pData, uint16_t len) {
	int32_t ret = BSP_ERROR_BUS_FAILURE;

	if (HAL_I2C_Master_Receive (&h${IpHandle}, DevAddr, pData, len, TIMEOUT_DURATION) == HAL_OK) {
		ret = len;
	}

	return ret;
}

/**
  * @brief  Send and receive an amount of data through bus (Full duplex)
  * @param  DevAddr: Device address on Bus.
  * @param  pTxdata: Transmit data pointer
  * @param 	pRxdata: Receive data pointer
  * @param  Length: Data length
  * @retval BSP status
  */
int32_t BSP_${IpInstance}_SendRecv(uint16_t DevAddr, uint8_t *pTxdata, uint8_t *pRxdata, uint16_t len) {
	int32_t ret = BSP_ERROR_BUS_FAILURE;
	
	/*
	 * Send and receive an amount of data through bus (Full duplex)
	 * I2C is Half-Duplex protocol
	 */
	if ((BSP_${IpInstance}_Send(DevAddr, pTxdata, len) == len) && \
		(BSP_${IpInstance}_Recv(DevAddr, pRxdata, len) == len))
			{
				ret = len;
			}
			
	return ret;
}

/**
  * @brief  Return system tick in ms
  * @retval Current HAL time base time stamp
  */
int32_t BSP_GetTick(void) {
  return HAL_GetTick();
}


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
