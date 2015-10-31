[#ftl]
/**
  ******************************************************************************
  * @file           : usbd_dfu_if.c
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
[#assign DFU_MEDIA = ""]
[#list SWIPdatas as SWIP]  
[#compress]
[#-- Section2: Create global Variables for each middle ware instance --] 
[#-- Global variables --]
[#if SWIP.variables??]
	[#list SWIP.variables as variable]	
		[#-- extern ${variable.type} --][#if variable.value??][#--${variable.value};--]				
		[#if variable.value?contains("OTG_FS")][#assign handleNameFS = "FS"][/#if]	
		[#if variable.value?contains("USB_FS")][#assign handleNameUSB_FS = "FS"][/#if]		
		[#if variable.value?contains("OTG_HS")][#assign handleNameHS = "HS"][/#if]
		[/#if]		
	[/#list]
[/#if]

[#if SWIP.defines??]
[#list SWIP.defines as definition]	
[#assign value = definition.value]
[#if definition.name="USBD_DFU_MEDIA"] 
[#assign DFU_MEDIA = definition.value]
[/#if]
[/#list]
[/#if]

[#-- Global variables --]
[/#compress]
[/#list]


/* Includes ------------------------------------------------------------------*/
#include "usbd_dfu_if.h"


/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
#define FLASH_DESC_STR      "${DFU_MEDIA}"
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
static uint16_t MEM_If_Init_FS(void);
static uint16_t MEM_If_Erase_FS (uint32_t Add);
static uint16_t MEM_If_Write_FS (uint8_t *src, uint8_t *dest, uint32_t Len);
static uint8_t *MEM_If_Read_FS  (uint8_t *src, uint8_t *dest, uint32_t Len);
static uint16_t MEM_If_DeInit_FS(void);
static uint16_t MEM_If_GetStatus_FS (uint32_t Add, uint8_t Cmd, uint8_t *buffer);
[/#if]

[#if handleNameHS == "HS"]
static uint16_t MEM_If_Init_HS(void);
static uint16_t MEM_If_Erase_HS (uint32_t Add);
static uint16_t MEM_If_Write_HS (uint8_t *src, uint8_t *dest, uint32_t Len);
static uint8_t *MEM_If_Read_HS  (uint8_t *src, uint8_t *dest, uint32_t Len);
static uint16_t MEM_If_DeInit_HS(void);
static uint16_t MEM_If_GetStatus_HS (uint32_t Add, uint8_t Cmd, uint8_t *buffer);
[/#if]

#if defined ( __ICCARM__ ) /*!< IAR Compiler */
  #pragma data_alignment=4   
#endif
[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
__ALIGN_BEGIN USBD_DFU_MediaTypeDef USBD_DFU_fops_FS __ALIGN_END =
{
   (uint8_t*)FLASH_DESC_STR,
    MEM_If_Init_FS,
    MEM_If_DeInit_FS,
    MEM_If_Erase_FS,
    MEM_If_Write_FS,
    MEM_If_Read_FS,
    MEM_If_GetStatus_FS,   
};
[/#if]

[#if handleNameHS == "HS"]
__ALIGN_BEGIN USBD_DFU_MediaTypeDef USBD_DFU_fops_HS __ALIGN_END =
{
    (uint8_t*)FLASH_DESC_STR,
    MEM_If_Init_HS,
    MEM_If_DeInit_HS,
    MEM_If_Erase_HS,
    MEM_If_Write_HS,
    MEM_If_Read_HS,
    MEM_If_GetStatus_HS,   
};
[/#if]

[#if handleNameFS == "FS" || handleNameUSB_FS == "FS"]
/**
  * @brief  MEM_If_Init_FS
  *         Memory initialization routine.
  * @param  None
  * @retval 0 if operation is successful, MAL_FAIL else.
  */
uint16_t MEM_If_Init_FS(void)
{ 
  /* USER CODE BEGIN 0 */ 
  return (USBD_OK);
  /* USER CODE END 0 */ 
}

/**
  * @brief  MEM_If_DeInit_FS
  *         De-Initializes Memory.
  * @param  None
  * @retval 0 if operation is successful, MAL_FAIL else.
  */
uint16_t MEM_If_DeInit_FS(void)
{ 
  /* USER CODE BEGIN 1 */ 
  return (USBD_OK);
  /* USER CODE END 1 */ 
}

/**
  * @brief  MEM_If_Erase_FS
  *         Erase sector.
  * @param  Add: Address of sector to be erased.
  * @retval 0 if operation is successful, MAL_FAIL else.
  */
uint16_t MEM_If_Erase_FS(uint32_t Add)
{
  /* USER CODE BEGIN 2 */ 
  return (USBD_OK);
  /* USER CODE END 2 */ 
}

/**
  * @brief  MEM_If_Write_FS
  *         Memory write routine.
  * @param  src: Pointer to the source buffer. Address to be written to.
  * @param  dest: Pointer to the destination buffer.
  * @param  Len: Number of data to be written (in bytes).
  * @retval 0 if operation is successful, MAL_FAIL else.
  */
uint16_t MEM_If_Write_FS(uint8_t *src, uint8_t *dest, uint32_t Len)
{
  /* USER CODE BEGIN 3 */ 
  return (USBD_OK);
  /* USER CODE END 3 */ 
}

/**
  * @brief  MEM_If_Read_FS
  *         Memory read routine.
  * @param  src: Pointer to the source buffer. Address to be written to.
  * @param  dest: Pointer to the destination buffer.
  * @param  Len: Number of data to be read (in bytes).
  * @retval Pointer to the physical address where data should be read.
  */
uint8_t *MEM_If_Read_FS (uint8_t *src, uint8_t *dest, uint32_t Len)
{
  /* Return a valid address to avoid HardFault */
  /* USER CODE BEGIN 4 */ 
  return (uint8_t*)(USBD_OK);
  /* USER CODE END 4 */ 
}

/**
  * @brief  Flash_If_GetStatus_FS
  *         Get status routine.
  * @param  Add: Address to be read from.
  * @param  Cmd: Number of data to be read (in bytes).
  * @param  buffer: used for returning the time necessary for a program or an erase operation
  * @retval 0 if operation is successful
  */
uint16_t MEM_If_GetStatus_FS (uint32_t Add, uint8_t Cmd, uint8_t *buffer)
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
  return  (USBD_OK);
  /* USER CODE END 6 */  
}
[/#if]

[#if handleNameHS == "HS"]
/**
  * @brief  MEM_If_Init_HS
  *         Memory initialization routine.
  * @param  None
  * @retval 0 if operation is successful, MAL_FAIL else.
  */
uint16_t MEM_If_Init_HS(void)
{ 
  /* USER CODE BEGIN 7 */ 
  return (USBD_OK);
  /* USER CODE END 7 */ 
}

/**
  * @brief  MEM_If_DeInit_HS
   *         De-Initializes Memory.
  * @param  None
  * @retval 0 if operation is successful, MAL_FAIL else.
  */
uint16_t MEM_If_DeInit_HS(void)
{ 
  /* USER CODE BEGIN 8 */ 
  return (USBD_OK);
  /* USER CODE END 8 */ 
}

/**
  * @brief  MEM_If_Erase_HS
  *         Erase sector.
  * @param  Add: Address of sector to be erased.
  * @retval 0 if operation is successful, MAL_FAIL else.
  */
uint16_t MEM_If_Erase_HS(uint32_t Add)
{
  /* USER CODE BEGIN 9 */ 
  return (USBD_OK);
  /* USER CODE END 9 */ 
}

/**
  * @brief  MEM_If_Write_HS
  *         Memory write routine.
  * @param  src: Pointer to the source buffer. Address to be written to.
  * @param  dest: Pointer to the destination buffer.
  * @param  Len: Number of data to be written (in bytes).
  * @retval 0 if operation is successful, MAL_FAIL else.
  */
uint16_t MEM_If_Write_HS(uint8_t *src, uint8_t *dest, uint32_t Len)
{
  /* USER CODE BEGIN 10 */ 
  return (USBD_OK);
  /* USER CODE END 10 */ 
}

/**
  * @brief  MEM_If_Read_HS
  *         Memory read routine.
  * @param  src: Pointer to the source buffer. Address to be written to.
  * @param  dest: Pointer to the destination buffer.
  * @param  Len: Number of data to be read (in bytes).
  * @retval Pointer to the physical address where data should be read.
  */
uint8_t *MEM_If_Read_HS (uint8_t *src, uint8_t *dest, uint32_t Len)
{
  /* Return a valid address to avoid HardFault */
  /* USER CODE BEGIN 11 */ 
  return (uint8_t*)(USBD_OK);
  /* USER CODE END 11 */ 
}

/**
  * @brief  Flash_If_GetStatus_HS
  *         Get status routine.
  * @param  Add: Address to be read from.
  * @param  Cmd: Number of data to be read (in bytes).
  * @param  buffer: used for returning the time necessary for a program or an erase operation
  * @retval 0 if operation is successful
  */
uint16_t MEM_If_GetStatus_HS (uint32_t Add, uint8_t Cmd, uint8_t *buffer)
{
  /* USER CODE BEGIN 12 */ 
  switch (Cmd)
  {
  case DFU_MEDIA_PROGRAM:

    break;
    
  case DFU_MEDIA_ERASE:
  default:

    break;
  }                             
  return  (USBD_OK);
  /* USER CODE END 12 */  
}
[/#if]
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

