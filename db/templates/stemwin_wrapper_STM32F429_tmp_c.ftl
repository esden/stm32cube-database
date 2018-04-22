[#ftl]

[#-- BspIpDatas is a list of SWIPconfigModel --] 

[#assign IpName = ""]
[#assign spihandler = "hspi"]
[#assign spiExist = "0"]
[#if BspIpDatas??]
[#assign i = 0]
[#list BspIpDatas  as BSPIP]

	[#assign type="CS"]
	[#if BSPIP.variables??]

		[#list BSPIP.variables as variables]
		[#if variables.name?contains("IpName")]
			[#assign IpName = variables.value]
                            
		[/#if]
               [#if variables.name?contains("IpInstance")]

                    [#assign IpInstance = variables.value]

[#if IpInstance?contains("GPIO")]
                    [#if i == 0] [#assign type0="CS"] [#assign port0=IpName][#assign pin0=IpInstance][/#if]
                    [#if i == 1] [#assign type1="WRX"][#assign port1=IpName][#assign pin1=IpInstance][/#if]
                    [#if i == 2] [#assign type2="RDX"][#assign port2=IpName][#assign pin2=IpInstance][/#if]



 [#assign i = i + 1]
[/#if]

[#if IpInstance?contains("SPI")]
[#assign spiExist = "1"]
extern void MX_${IpInstance}_Init(void);
extern SPI_HandleTypeDef  ${IpInstance?replace("SPI","hspi")};
[#assign spihandler = IpInstance?replace("SPI","hspi")]
[#assign spiIndex = IpInstance?replace("SPI","")]
[/#if]	
[/#if]
	        [/#list]

	[/#if]
 [/#list]
[/#if]



[#if spiExist == "1" && type0?? &&  type1?? && type2?? ]
/* In case of use of STM32429-DISCO board */
[#if type0??]
#n
/* Chip Select macro definition */
#define LCD_${type0}_LOW()       HAL_GPIO_WritePin(${port0}, ${pin0}, GPIO_PIN_RESET)
#define LCD_${type0}_HIGH()      HAL_GPIO_WritePin(${port0}, ${pin0}, GPIO_PIN_SET)
[/#if]
[#if type1??]
#n
/* Set ${type1} High to send data */
#define LCD_${type1}_LOW()       HAL_GPIO_WritePin(${port1},  ${pin1}, GPIO_PIN_RESET)
#define LCD_${type1}_HIGH()      HAL_GPIO_WritePin(${port1}, ${pin1}, GPIO_PIN_SET)
[/#if]
[#if type2??]
#n
/* Set ${type2} High to send data */
#define LCD_${type2}_LOW()       HAL_GPIO_WritePin(${port2},  ${pin2}, GPIO_PIN_RESET)
#define LCD_${type2}_HIGH()      HAL_GPIO_WritePin(${port2}, ${pin2}, GPIO_PIN_SET)
[/#if]


/**
  * @brief  SPIx error treatment function.
  */
static void SPIx_Error(void)
{
  /* De-initialize the SPI communication BUS */
  HAL_SPI_DeInit(&${spihandler});
  
  /* Re- Initialize the SPI communication BUS */
  [#if spiIndex??]
   MX_SPI${spiIndex}_Init();
  [#else]
   //MX_SPIx_Init();
   [/#if]
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
__weak void LCD_IO_Init(void)
{
   /* Set or Reset the control line */
    LCD_CS_LOW();
    LCD_CS_HIGH();
    [#if spiIndex??]
    MX_SPI${spiIndex}_Init();
    [#else]
     //MX_SPIx_Init();
    [/#if]
}

/**
  * @brief  Writes register address.
  */
__weak void LCD_IO_WriteReg(uint8_t Reg) 
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

__weak void LCD_IO_WriteData(uint16_t RegValue) 
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

__weak uint32_t LCD_IO_ReadData(uint16_t RegValue, uint8_t ReadSize) 
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

[#else]
/**
  * @brief  Configures the LCD_SPI interface.
  */
__weak void LCD_IO_Init(void)
{
   /* USER CODE BEGIN LCD_IO_Init */

   /* USER CODE END LCD_IO_Init */
}

/**
  * @brief  Writes register address.
  */
__weak void LCD_IO_WriteReg(uint8_t Reg) 
{
   /* USER CODE BEGIN LCD_IO_WriteReg */

   /* USER CODE END LCD_IO_WriteReg */
}
/**
  * @brief  Writes register value.
  */

__weak void LCD_IO_WriteData(uint16_t RegValue) 
{
   /* USER CODE BEGIN LCD_IO_WriteData */

   /* USER CODE END LCD_IO_WriteData */
}

/**
  * @brief  Reads register value.
  * @param  RegValue Address of the register to read
  * @param  ReadSize Number of bytes to read
  * @retval Content of the register value
  */

__weak uint32_t LCD_IO_ReadData(uint16_t RegValue, uint8_t ReadSize) 
{
   /* USER CODE BEGIN LCD_IO_ReadData */

   /* USER CODE END LCD_IO_ReadData */
  
  return 0;
}

[/#if]



