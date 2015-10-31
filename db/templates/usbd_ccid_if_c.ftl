/**
  ******************************************************************************
  * @file           : usbd_ccid_if.c
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
[#assign handleNameFS = ""]
[#assign handleNameHS = ""]
[#assign handleNameUSB_FS = ""]
[#list SWIPdatas as SWIP]  
[#compress]
[#-- Section2: Create global Variables for each middle ware instance --] 
[#-- Global variables --]
[#if SWIP.variables??]
	[#list SWIP.variables as variable]	
		[#-- extern ${variable.type} --][#if variable.value??][#--${variable.value};--]				
		[#if variable.value?contains("FS")][#assign handleNameFS = "FS"][/#if]		
		[#if variable.value?contains("USB_FS")][#assign handleNameUSB_FS = "FS"][/#if]		
		[#if variable.value?contains("HS")][#assign handleNameHS = "HS"][/#if]
		[/#if]		
	[/#list]
[/#if]
[#-- Global variables --]
[/#compress]
[/#list]

/* Includes ------------------------------------------------------------------*/
#include "usbd_ccid_if.h"


/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* USB handler declaration */
[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
/* Handle for USB Full Speed IP */
USBD_HandleTypeDef  *hUsbDevice_0;
[/#if]

[#if handleNameHS == "HS"]
/* Handle for USB High Speed IP */
USBD_HandleTypeDef  *hUsbDevice_1;
[/#if]
  
[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
extern USBD_HandleTypeDef hUsbDeviceFS;
[/#if]
[#if handleNameHS == "HS"]
extern USBD_HandleTypeDef hUsbDeviceHS;  
[/#if]

/* Private function prototypes -----------------------------------------------*/
/* Extern function prototypes ------------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
static int8_t SC_If_Init_FS(void);
static int8_t SC_If_DeInit_FS(void);
static int8_t SC_If_Decode_FS (uint8_t msg, uint8_t *pbuf, uint16_t length);
[/#if]

[#if handleNameHS == "HS"]
static int8_t SC_If_Init_HS(void);
static int8_t SC_If_DeInit_HS(void);
static int8_t SC_If_Decode_HS (uint8_t msg, uint8_t *pbuf, uint16_t length);
[/#if]

[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
USBD_CCID_ItfTypeDef USBD_CCID_fops_FS =
{
    SC_If_Init_FS,
    SC_If_DeInit_FS,
    SC_If_Decode_FS,  
};
[/#if]

[#if handleNameHS == "HS"]
USBD_CCID_ItfTypeDef USBD_CCID_fops_HS =
{
    SC_If_Init_HS,
    SC_If_DeInit_HS,
    SC_If_Decode_HS,  
};
[/#if]

[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
/**
  * @brief  SC_If_Init_FS
  *         Memory initialization routine.
  * @param  None
  * @retval 0 if operation is successeful, MAL_FAIL else.
  */
int8_t SC_If_Init_FS(void)
{ 
  /* USER CODE BEGIN 0 */ 
  return (USBD_OK);
  /* USER CODE END 0 */ 
}

/**
  * @brief  SC_If_DeInit_FS
  *         Memory deinitialization routine.
  * @param  None
  * @retval 0 if operation is successeful, MAL_FAIL else.
  */
int8_t SC_If_DeInit_FS(void)
{ 
  /* USER CODE BEGIN 1 */ 
  return (USBD_OK);
  /* USER CODE END 1 */ 
}

/**
  * @brief  SC_If_Decode_FS
  *         Erase sector.
  * @param  Add: Address of sector to be erased.
  * @retval 0 if operation is successeful, MAL_FAIL else.
  */
int8_t SC_If_Decode_FS (uint8_t msg, uint8_t *pbuf, uint16_t length)
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
  return (USBD_OK);
  /* USER CODE END 2 */   
}
[/#if]

[#if handleNameHS == "HS"]
/**
  * @brief  SC_If_Init_HS
  *         Memory initialization routine.
  * @param  None
  * @retval 0 if operation is successeful, MAL_FAIL else.
  */
int8_t SC_If_Init_HS(void)
{ 
  /* USER CODE BEGIN 3 */ 
  return (USBD_OK);
  /* USER CODE END 3 */ 
}

/**
  * @brief  SC_If_DeInit_HS
  *         Memory deinitialization routine.
  * @param  None
  * @retval 0 if operation is successeful, MAL_FAIL else.
  */
int8_t SC_If_DeInit_HS(void)
{ 
  /* USER CODE BEGIN 4 */ 
  return (USBD_OK);
  /* USER CODE END 4 */ 

}

/**
  * @brief  SC_If_Decode_HS
  *         Erase sector.
  * @param  Add: Address of sector to be erased.
  * @retval 0 if operation is successeful, MAL_FAIL else.
  */
int8_t SC_If_Decode_HS (uint8_t msg, uint8_t *pbuf, uint16_t length)
{
  /* USER CODE BEGIN 5 */ 
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
  return (USBD_OK);
  /* USER CODE END 5 */   
}
[/#if]
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/