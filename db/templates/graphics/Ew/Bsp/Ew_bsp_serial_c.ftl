[#ftl]
[#assign objectConstructor = "freemarker.template.utility.ObjectConstructor"?new()]
[#assign file = objectConstructor("java.io.File",workspace+"/"+"ST-EmbeddedWizard/Ew_init_UART_tmp.c")]
  [#assign exist = file.exists()]
[#if exist]
[@common.optinclude name="ST-EmbeddedWizard/Ew_init_UART_tmp.c"/]
[#assign UseUART ="1"]
[#else]
  /**
  ******************************************************************************
  * @file    ew_bsp_serial.c
  * @author  MCD Application Team
  * @brief   This file is part of the interface (glue layer) between an Embedded 
  *          Wizard generated UI application and the board support package 
  *          (BSP) of a dedicated target.   
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2018 STMicroelectronics International N.V. 
  * All rights reserved.</center></h2>
  *
  * Redistribution and use in source and binary forms, with or without 
  * modification, are permitted, provided that the following conditions are met:
  *
  * 1. Redistribution of source code must retain the above copyright notice, 
  *    this list of conditions and the following disclaimer.
  * 2. Redistributions in binary form must reproduce the above copyright notice,
  *    this list of conditions and the following disclaimer in the documentation
  *    and/or other materials provided with the distribution.
  * 3. Neither the name of STMicroelectronics nor the names of other 
  *    contributors to this software may be used to endorse or promote products 
  *    derived from this software without specific written permission.
  * 4. This software, including modifications and/or derivative works of this 
  *    software, must execute solely and exclusively on microcontroller or
  *    microprocessor devices manufactured by or for STMicroelectronics.
  * 5. Redistribution and use of this software other than as permitted under 
  *    this license is void and will automatically terminate your rights under 
  *    this license. 
  *
  * THIS SOFTWARE IS PROVIDED BY STMICROELECTRONICS AND CONTRIBUTORS "AS IS" 
  * AND ANY EXPRESS, IMPLIED OR STATUTORY WARRANTIES, INCLUDING, BUT NOT 
  * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
  * PARTICULAR PURPOSE AND NON-INFRINGEMENT OF THIRD PARTY INTELLECTUAL PROPERTY
  * RIGHTS ARE DISCLAIMED TO THE FULLEST EXTENT PERMITTED BY LAW. IN NO EVENT 
  * SHALL STMICROELECTRONICS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
  * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
  * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
  * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
  * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
  * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  * DESCRIPTION:
  *   This template is responsible to establish a serial connection in order
  *   to send debug messages to a PC terminal tool, or to receive key events
  *   for the UI application.
  ******************************************************************************
  */


#include "${FamilyName?lower_case}xx_hal.h"

#include "ew_bsp_serial.h"



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
    /*  USER CODE BEGIN  BspConfigSerial */

   /*   USER CODE END BspConfigSerial */
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
   /*  USER CODE BEGIN BspPutCharacter */

   /*  USER CODE END  BspPutCharacter */
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
   /*  USER CODE BEGIN BspGetCharacter */

    return 0 ;

   /* USER CODE END  BspGetCharacter  */

}

/* msy */
[/#if]