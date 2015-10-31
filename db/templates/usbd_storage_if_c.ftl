[#ftl]
/**
  ******************************************************************************
  * @file           : usbd_storage_if.c
  * @author         : MCD Application Team
  * @version        : V1.1.0
  * @date           : 19-March-2012
  * @brief          : Memory management layer
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
#include "usbd_storage_if.h"


/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Extern function prototypes ------------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

#define STORAGE_LUN_NBR                  1  
#define STORAGE_BLK_NBR                  0x10000  
#define STORAGE_BLK_SIZ                  0x200

int8_t STORAGE_Init (uint8_t lun);

int8_t STORAGE_GetCapacity (uint8_t lun, 
                           uint32_t *block_num, 
                           uint16_t *block_size);

int8_t  STORAGE_IsReady (uint8_t lun);

int8_t  STORAGE_IsWriteProtected (uint8_t lun);

int8_t STORAGE_Read (uint8_t lun, 
                        uint8_t *buf, 
                        uint32_t blk_addr,
                        uint16_t blk_len);

int8_t STORAGE_Write (uint8_t lun, 
                        uint8_t *buf, 
                        uint32_t blk_addr,
                        uint16_t blk_len);

int8_t STORAGE_GetMaxLun (void);

/* USB Mass storage Standard Inquiry Data */
int8_t  STORAGE_Inquirydata[] = {//36
  
  /* LUN 0 */
  0x00,		
  0x80,		
  0x02,		
  0x02,
  (STANDARD_INQUIRY_DATA_LEN - 5),
  0x00,
  0x00,	
  0x00,
  'S', 'T', 'M', ' ', ' ', ' ', ' ', ' ', /* Manufacturer : 8 bytes */
  'P', 'r', 'o', 'd', 'u', 'c', 't', ' ', /* Product      : 16 Bytes */
  ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
  '0', '.', '0' ,'1',                     /* Version      : 4 Bytes */
}; 

USBD_StorageTypeDef USBD_Storage_Interface_fops =
{
  STORAGE_Init,
  STORAGE_GetCapacity,
  STORAGE_IsReady,
  STORAGE_IsWriteProtected,
  STORAGE_Read,
  STORAGE_Write,
  STORAGE_GetMaxLun,
  STORAGE_Inquirydata,
  
};
/*******************************************************************************
* Function Name  : STORAGE_Init
* Description    : 
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
int8_t STORAGE_Init (uint8_t lun)
{
  /* USER CODE BEGIN 0 */ 
  return (0);
  /* USER CODE END 0 */ 
}

/*******************************************************************************
* Function Name  : STORAGE_GetCapacity
* Description    : 
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
int8_t STORAGE_GetCapacity (uint8_t lun, uint32_t *block_num, uint16_t *block_size)
{
  /* USER CODE BEGIN 1 */   
  *block_num  = STORAGE_BLK_NBR;
  *block_size = STORAGE_BLK_SIZ;
  return (0);
  /* USER CODE END 1 */ 
}

/*******************************************************************************
* Function Name  : STORAGE_IsReady
* Description    : 
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
int8_t  STORAGE_IsReady (uint8_t lun)
{
  /* USER CODE BEGIN 2 */ 
  return (0);
  /* USER CODE END 2 */ 
}

/*******************************************************************************
* Function Name  : STORAGE_IsWriteProtected
* Description    : 
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
int8_t  STORAGE_IsWriteProtected (uint8_t lun)
{
  /* USER CODE BEGIN 3 */ 
  return (0);
  /* USER CODE END 3 */ 
}

/*******************************************************************************
* Function Name  : STORAGE_Read
* Description    : 
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
int8_t STORAGE_Read (uint8_t lun, 
                 uint8_t *buf, 
                 uint32_t blk_addr,                       
                 uint16_t blk_len)
{
  /* USER CODE BEGIN 4 */ 
  return (0);
  /* USER CODE END 4 */ 

}
/*******************************************************************************
* Function Name  : STORAGE_Write
* Description    :
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
int8_t STORAGE_Write (uint8_t lun, 
                  uint8_t *buf, 
                  uint32_t blk_addr,
                  uint16_t blk_len)
{
  /* USER CODE BEGIN 5 */ 
  return (0);
  /* USER CODE END 5 */ 

}
/*******************************************************************************
* Function Name  : STORAGE_GetMaxLun
* Description    : 
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
int8_t STORAGE_GetMaxLun (void)
{

  return (STORAGE_LUN_NBR - 1);
}

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

