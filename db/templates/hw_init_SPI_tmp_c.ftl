[#ftl]

[#-- BspIpDatas is a list of SWIPconfigModel --] 

[#assign IpName = ""]
[#if BspIpDatas??]

[#list BspIpDatas  as BSPIP]

	
	[#if BSPIP.variables??]
		[#list BSPIP.variables as variables]
		[#if variables.name?contains("IpName")]
			[#assign IpName = variables.value]
                         

		[/#if]
               [#if variables.name?contains("IpInstance")]
			[#assign IpInstance = variables.value]
extern SPI_HandleTypeDef  ${IpInstance?replace("SPI","hspi")};
[#assign spihandler = IpInstance?replace("SPI","hspi")]
[#assign spiIndex = IpInstance?replace("SPI","")]
		[/#if]
	        [/#list]
	[/#if]
 [/#list]

[/#if]

/**
  * @brief  SPIx error treatment function.
  */
static void SPIx_Error(void)
{
  /* De-initialize the SPI communication BUS */
  HAL_SPI_DeInit(&${spihandler});
  
  /* Re- Initialize the SPI communication BUS */
  MX_SPI${spiIndex}_Init();
}

/**
  * @brief  Reads 4 bytes from device.
  * @param  ReadSize: Number of bytes to read (max 4 bytes)
  * @retval Value read on the SPI
  */
static uint32_t SPIx_Read(uint8_t ReadSize)
{
  HAL_StatusTypeDef status = HAL_OK;
  uint32_t readvalue;
  
  status = HAL_SPI_Receive(&${spihandler}, (uint8_t*) &readvalue, ReadSize, 0x1000);
  
  /* Check the communication status */
  if(status != HAL_OK)
  {
    /* Re-Initialize the BUS */
    SPIx_Error();
  }
  
  return readvalue;
}

/**
  * @brief  Writes a byte to device.
  * @param  Value: value to be written
  */
static void SPIx_Write(uint16_t Value)
{
  HAL_StatusTypeDef status = HAL_OK;
  
  status = HAL_SPI_Transmit(&${spihandler}, (uint8_t*) &Value, 1, 0x1000);
  
  /* Check the communication status */
  if(status != HAL_OK)
  {
    /* Re-Initialize the BUS */
    SPIx_Error();
  }
}

/**
  * @brief  Configures the LCD_SPI interface.
  */
void LCD_IO_Init(void)
{
   /* Set or Reset the control line */
    LCD_CS_LOW();
    LCD_CS_HIGH();
    
    MX_SPI${spiIndex}_Init();
}

/**
  * @brief  Writes register address.
  */
void LCD_IO_WriteReg(uint8_t Reg) 
{
  /* Reset WRX to send command */
  LCD_WRX_LOW();
  
  /* Reset LCD control line(/CS) and Send command */
  LCD_CS_LOW();
  SPIx_Write(Reg);
  
  /* Deselect: Chip Select high */
  LCD_CS_HIGH();
}
/**
  * @brief  Writes register value.
  */
void LCD_IO_WriteData(uint16_t RegValue) 
{
  /* Set WRX to send data */
  LCD_WRX_HIGH();
  
  /* Reset LCD control line(/CS) and Send data */  
  LCD_CS_LOW();
  SPIx_Write(RegValue);
  
  /* Deselect: Chip Select high */
  LCD_CS_HIGH();
}

/**
  * @brief  Reads register value.
  * @param  RegValue Address of the register to read
  * @param  ReadSize Number of bytes to read
  * @retval Content of the register value
  */
uint32_t LCD_IO_ReadData(uint16_t RegValue, uint8_t ReadSize) 
{
  uint32_t readvalue = 0;

  /* Select: Chip Select low */
  LCD_CS_LOW();

  /* Reset WRX to send command */
  LCD_WRX_LOW();
  
  SPIx_Write(RegValue);
  
  readvalue = SPIx_Read(ReadSize);

  /* Set WRX to send data */
  LCD_WRX_HIGH();

  /* Deselect: Chip Select high */
  LCD_CS_HIGH();
  
  return readvalue;
}
