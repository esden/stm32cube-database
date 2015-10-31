[#ftl]
/**
  ******************************************************************************
  * @file           : usbd_dfu_if.c
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
#include "usbd_dfu_if.h"


/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Extern function prototypes ------------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
uint16_t MEM_If_Init(void);
uint16_t MEM_If_Erase (uint32_t Add);
uint16_t MEM_If_Write (uint8_t *src, uint8_t *dest, uint32_t Len);
uint8_t *MEM_If_Read  (uint8_t *src, uint8_t *dest, uint32_t Len);
uint16_t MEM_If_DeInit(void);
uint16_t MEM_If_GetStatus (uint32_t Add, uint8_t Cmd, uint8_t *buffer);

USBD_DFU_MediaTypeDef USBD_DFU_fops =
{
    "DFU MEDIA",
    MEM_If_Init,
    MEM_If_DeInit,
    MEM_If_Erase,
    MEM_If_Write,
    MEM_If_Read,
    MEM_If_GetStatus,
   
};
/**
  * @brief  MEM_If_Init
  *         Memory initialization routine.
  * @param  None
  * @retval 0 if operation is successeful, MAL_FAIL else.
  */
uint16_t MEM_If_Init(void)
{ 
  /* USER CODE BEGIN 0 */ 
  return (0);
  /* USER CODE END 0 */ 
}

/**
  * @brief  MEM_If_DeInit
  *         Memory deinitialization routine.
  * @param  None
  * @retval 0 if operation is successeful, MAL_FAIL else.
  */
uint16_t MEM_If_DeInit(void)
{ 
  /* USER CODE BEGIN 1 */ 
  return (0);
  /* USER CODE END 1 */ 
}

/**
  * @brief  MEM_If_Erase
  *         Erase sector.
  * @param  Add: Address of sector to be erased.
  * @retval 0 if operation is successeful, MAL_FAIL else.
  */
uint16_t MEM_If_Erase(uint32_t Add)
{
  /* USER CODE BEGIN 2 */ 
  return (0);
  /* USER CODE END 2 */ 
}

/**
  * @brief  MEM_If_Write
  *         Memory write routine.
  * @param  Add: Address to be written to.
  * @param  Len: Number of data to be written (in bytes).
  * @retval 0 if operation is successeful, MAL_FAIL else.
  */
uint16_t MEM_If_Write(uint8_t *src, uint8_t *dest, uint32_t Len)
{
  /* USER CODE BEGIN 3 */ 
  return (0);
  /* USER CODE END 3 */ 
}

/**
  * @brief  MEM_If_Read
  *         Memory read routine.
  * @param  Add: Address to be read from.
  * @param  Len: Number of data to be read (in bytes).
  * @retval Pointer to the phyisical address where data should be read.
  */
uint8_t *MEM_If_Read (uint8_t *src, uint8_t *dest, uint32_t Len)
{
  /* Return a valid address to avoid HardFault */
  /* USER CODE BEGIN 4 */ 
  return (uint8_t*)(0);
  /* USER CODE END 4 */ 
}

/**
  * @brief  Flash_If_GetStatus
  *         Memory read routine.
  * @param  Add: Address to be read from.
  * @param  cmd: Number of data to be read (in bytes).
  * @retval Pointer to the phyisical address where data should be read.
  */
uint16_t MEM_If_GetStatus (uint32_t Add, uint8_t Cmd, uint8_t *buffer)
{
  /* USER CODE BEGIN 5 */ 
  switch (Cmd)
  {
  case DFU_MEDIA_PROGRAM:

    break;
    
  case DFU_MEDIA_ERASE:
  default:

    break;
  }                             
  return  (0);
  /* USER CODE END 6 */  
}
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

