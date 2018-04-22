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


extern UART_HandleTypeDef                     ${IpInstance?replace("UART","huart")};

/*******************************************************************************
* FUNCTION:
*   EwBspConfigSerial
*
* DESCRIPTION:
*   The function EwBspConfigSerial initializes a serial connection via UART/USART
*   interface used to print error and trace messages from an Embedded Wizard
*   GUI application.
*   This implementation uses the following configuration:
*   - BaudRate = 115200 baud
*   - Word Length = 8 Bits
*   - One Stop Bit
*   - No parity
*   - Hardware flow control disabled (RTS and CTS signals)
*   - Receive and transmit enabled
*
* ARGUMENTS:
*   None
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspConfigSerial( void )
{
  
}

/*******************************************************************************
* FUNCTION:
*   EwBspPutCharacter
*
* DESCRIPTION:
*   The function EwBspPutCharacter sends the given character to the serial
*   interface.
*
* ARGUMENTS:
*   aCharacter - The character to be send via the serial interface.
*
* RETURN VALUE:
*   None
*
*******************************************************************************/
void EwBspPutCharacter( unsigned char aCharacter )
{
  HAL_UART_Transmit( &${IpInstance?replace("UART","huart")}, (uint8_t*)&aCharacter, 1, 10 );
}

/*******************************************************************************
* FUNCTION:
*   EwBspGetCharacter
*
* DESCRIPTION:
*   The function EwBspGetCharacter returns the current character from the serial
*   interface. If no character is available within the input buffer, 0 is
*   returned.
*
* ARGUMENTS:
*   None
*
* RETURN VALUE:
*   Current character from serial input buffer or 0.
*
*******************************************************************************/
unsigned char EwBspGetCharacter( void )
{
  uint8_t ret;
  HAL_UART_Receive( &${IpInstance?replace("UART","huart")}, &ret, 1, 10 );
  return ret;
}

/* msy */
		[/#if]
	        [/#list]
	[/#if]
 [/#list]

[/#if]

