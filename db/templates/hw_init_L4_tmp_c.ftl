[#ftl]

[#-- BspIpDatas is a list of SWIPconfigModel --] 

[#assign IpName = ""]
[#assign IpInstance = ""]
[#if BspIpDatas??]
[#list BspIpDatas  as BSPIP]
	[#if BSPIP.variables??]
		[#list BSPIP.variables as variables]
		[#if variables.name?contains("IpName")]
			[#assign IpName = variables.value]
		[/#if]
               [#if variables.name?contains("IpInstance")]
			[#assign IpInstance = variables.value]
		[/#if]
	        [/#list]
	[/#if]
 [/#list]
[/#if]
extern I2C_HandleTypeDef                    ${IpInstance?replace("I2C","hi2c")};


/********************************* LINK MFX ***********************************/
/******************************* I2C Routines**********************************/
/**
  * @brief Discovery I2C1 error treatment function
  * @retval None
  */
static void I2C_Error(void)
{
  /* De-initialize the I2C communication BUS */
  HAL_I2C_MspDeInit(&${IpInstance?replace("I2C","hi2c")});
 
  /* Re- Initiaize the I2C communication BUS */
  MX_${IpInstance}_Init();
}

/**
  * @brief  Write a value in a register of the device through BUS.
  * @param  Addr: Device address on BUS Bus.
  * @param  Reg: The target register address to write
  * @param  RegSize: The target register size (can be 8BIT or 16BIT)
  * @param  Value: The target register value to be written
  * @retval None
  */
static void I2C_WriteData(uint16_t Addr, uint16_t Reg, uint16_t RegSize, uint8_t Value)
{
  HAL_StatusTypeDef status = HAL_OK;

  status = HAL_I2C_Mem_Write(&${IpInstance?replace("I2C","hi2c")}, Addr, (uint16_t)Reg, RegSize, &Value, 1, 3000);

  /* Check the communication status */
  if(status != HAL_OK)
  {
    /* Re-Initiaize the BUS */
    I2C_Error();
  }
}

/**
  * @brief  Write a value in a register of the device through BUS.
  * @param  Addr: Device address on BUS Bus.
  * @param  Reg: The target register address to write
  * @param  RegSize: The target register size (can be 8BIT or 16BIT)
  * @param  pBuffer: The target register value to be written
  * @param  Length: buffer size to be written
  * @retval None
  */
static HAL_StatusTypeDef I2C_WriteBuffer(uint16_t Addr, uint16_t Reg, uint16_t RegSize, uint8_t *pBuffer, uint16_t Length)
{
  HAL_StatusTypeDef status = HAL_OK;

  status = HAL_I2C_Mem_Write(&${IpInstance?replace("I2C","hi2c")}, Addr, (uint16_t)Reg, RegSize, pBuffer, Length, 3000);

  /* Check the communication status */
  if(status != HAL_OK)
  {
    /* Re-Initiaize the BUS */
    I2C_Error();
  }

  return status;
}

/**
  * @brief  Read a register of the device through BUS
  * @param  Addr: Device address on BUS
  * @param  Reg: The target register address to read
  * @param  RegSize: The target register size (can be 8BIT or 16BIT)
  * @retval read register value
  */
static uint8_t I2C_ReadData(uint16_t Addr, uint16_t Reg, uint16_t RegSize)
{
  HAL_StatusTypeDef status = HAL_OK;
  uint8_t value = 0x0;

  status = HAL_I2C_Mem_Read(&${IpInstance?replace("I2C","hi2c")}, Addr, Reg, RegSize, &value, 1, 3000);

  /* Check the communication status */
  if(status != HAL_OK)
  {
    /* Re-Initiaize the BUS */
    I2C_Error();
  }

  return value;
}

/**
* @brief  Checks if target device is ready for communication.
* @note   This function is used with Memory devices
* @param  DevAddress: Target device address
* @param  Trials: Number of trials
* @retval HAL status
*/
static uint8_t I2C_isDeviceReady(uint16_t Addr, uint32_t trial)
{
  HAL_StatusTypeDef status = HAL_OK;

  status = HAL_I2C_IsDeviceReady(&${IpInstance?replace("I2C","hi2c")}, Addr, trial, 50);

  /* Check the communication status */
  if(status != HAL_OK)
  {
    /* Re-Initiaize the BUS */
    I2C_Error();
  }

  return status;
}

/**
  * @brief  Reads multiple data on the BUS.
  * @param  Addr: I2C Address
  * @param  Reg: Reg Address
  * @param  RegSize : The target register size (can be 8BIT or 16BIT)
  * @param  pBuffer: pointer to read data buffer
  * @param  Length: length of the data
  * @retval 0 if no problems to read multiple data
  */
static HAL_StatusTypeDef I2C_ReadBuffer(uint16_t Addr, uint16_t Reg, uint16_t RegSize, uint8_t *pBuffer, uint16_t Length)
{
  HAL_StatusTypeDef status = HAL_OK;

  status = HAL_I2C_Mem_Read(&${IpInstance?replace("I2C","hi2c")}, Addr, (uint16_t)Reg, RegSize, pBuffer, Length, 3000);

  /* Check the communication status */
  if(status != HAL_OK)
  {
    /* Re-Initiaize the BUS */
    I2C_Error();
  }

  return status;
}
