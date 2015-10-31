/**
  ******************************************************************************
  * @file           : usbd_ccid_if.c
  * @author         : MCD Application Team
  * @version        : V1.1.0
  * @date           : 19-March-2012
  * @brief          :
  ******************************************************************************
  * COPYRIGHT(c) ${year} STMicroelectronics
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  * 1. Redistributions of source code must retain the above copyright notice,
  * this list of conditions and the following disclaimer.
  * 2. Redistributions in binary form must reproduce the above copyright notice,
  * this list of conditions and the following disclaimer in the documentation
  * and/or other materials provided with the distribution.
  * 3. Neither the name of STMicroelectronics nor the names of its contributors
  * may be used to endorse or promote products derived from this software
  * without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
  * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
  * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
*/


/* Includes ------------------------------------------------------------------*/
#include "usbd_ccid_if.h"


/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Extern function prototypes ------------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
int8_t SC_If_Init(void);
int8_t SC_If_DeInit(void);
int8_t SC_If_Decode (uint8_t msg, uint8_t *pbuf, uint16_t length);

USBD_CCID_ItfTypeDef USBD_CCID_fops =
{
    SC_If_Init,
    SC_If_DeInit,
    SC_If_Decode,
  
};
/**
  * @brief  SC_If_Init
  *         Memory initialization routine.
  * @param  None
  * @retval 0 if operation is successeful, MAL_FAIL else.
  */
int8_t SC_If_Init(void)
{ 
  /* USER CODE BEGIN 0 */ 
  return 0;
  /* USER CODE END 0 */ 
}

/**
  * @brief  SC_If_DeInit
  *         Memory deinitialization routine.
  * @param  None
  * @retval 0 if operation is successeful, MAL_FAIL else.
  */
int8_t SC_If_DeInit(void)
{ 
  /* USER CODE BEGIN 1 */ 
  return 0;
  /* USER CODE END 1 */ 

}

/**
  * @brief  SC_If_Decode
  *         Erase sector.
  * @param  Add: Address of sector to be erased.
  * @retval 0 if operation is successeful, MAL_FAIL else.
  */
int8_t SC_If_Decode (uint8_t msg, uint8_t *pbuf, uint16_t length)
{
  /* USER CODE BEGIN 2 */ 
 switch (msg)
  {
  case PC_TO_RDR_ICCPOWERON:
    break;
  case PC_TO_RDR_ICCPOWEROFF:
    break;
  case PC_TO_RDR_GETSLOTSTATUS:
    break;
  case PC_TO_RDR_XFRBLOCK:
    break;
  case PC_TO_RDR_GETPARAMETERS:
    break;
  case PC_TO_RDR_RESETPARAMETERS:
    break;
  case PC_TO_RDR_SETPARAMETERS:
    break;
  case PC_TO_RDR_ESCAPE:
    break;
  case PC_TO_RDR_ICCCLOCK:
    break;
  case PC_TO_RDR_ABORT:
    break;
  case PC_TO_RDR_T0APDU:
    break;
  case PC_TO_RDR_MECHANICAL:
    break;   
  case PC_TO_RDR_SETDATARATEANDCLOCKFREQUENCY:
    break;
  case PC_TO_RDR_SECURE:
    break;
  default:
    break;
  }
  return 0;
  /* USER CODE END 2 */   
}

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

