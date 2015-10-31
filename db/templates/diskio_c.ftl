[#ftl]
/**
 ******************************************************************************
  * File Name          : mx_diskio.c
  * Date               : ${date}
  * Description        : This file provides code for the configuration
  *                      of the ${comment} instances.
  ******************************************************************************
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "diskio.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
#define BLOCK_SIZE                512 /* Block Size in Bytes */

/* Private variables ---------------------------------------------------------*/
static volatile DSTATUS Stat = STA_NOINIT; /* Disk status */
/* Private function prototypes -----------------------------------------------*/
[#list SWIPdatas as SWIP]  
DSTATUS ${comment}_initialize (void);
DSTATUS ${comment}_status (void);
DRESULT ${comment}_read (BYTE*, DWORD, BYTE);
DRESULT ${comment}_write (const BYTE*, DWORD, BYTE);
DRESULT ${comment}_ioctl (BYTE, void*);

/* Private functions ---------------------------------------------------------*/

/**
  * @brief  Initializes a Drive
  * @param  drv: Drive index
  * @retval DSTATUS: Operation status
  */
DSTATUS ${comment}_initialize(void)
{  
    Stat &= ~STA_NOINIT;
    return Stat;
}

/**
  * @brief  Gets Disk Status 
  * @param  drv: Drive index
  * @retval DSTATUS: Operation status
  */
DSTATUS ${comment}_status(void)
{  
  Stat = STA_NOINIT;

  // ici on ne doit pas etre board dependant
  if(STM324x9i_SD_GetStatus() == 0)
  {
    Stat &= ~STA_NOINIT;
  }
  
  return Stat;  
}

/**
  * @brief  Reads Sector(s) 
  * @param  drv: Drive index
  * @param  *buff: Data buffer to store read data
  * @param  sector: Sector address (LBA)
  * @param  count: Number of sectors to read (1..128)
  * @retval DSTATUS: Operation status
  */
DRESULT ${comment}_read(BYTE *buff, DWORD sector, BYTE count)
{
  uint32_t timeout = 100000;
  DWORD scratch [BLOCK_SIZE / 4];  /* Alignment ensured, need enough stack */
  HAL_SD_ErrorTypedef SD_state = SD_OK;
    
  if ((DWORD)buff & 3) /* DMA Alignment issue, do single up to aligned buffer */
  {
    while (count--)
    {
	 // ici on ne doit pas etre board dependant
      SD_state = STM324x9i_SD_ReadBlocks_DMA((uint32_t*)scratch, (uint64_t) ((sector + count) * BLOCK_SIZE), BLOCK_SIZE, 1);
      
      while(STM324x9i_SD_GetStatus() != SD_TRANSFER_OK)
      {
        if (timeout-- == 0)
        {
          return RES_ERROR;
        }
      }
      memcpy (&buff[count * BLOCK_SIZE] ,scratch, BLOCK_SIZE);
    }
  }
  else
  {
   // ici on ne doit pas etre board dependant
     SD_state = STM324x9i_SD_ReadBlocks_DMA((uint32_t*)buff, (uint64_t) (sector * BLOCK_SIZE), BLOCK_SIZE, count);
    
    while(STM324x9i_SD_GetStatus() != SD_TRANSFER_OK)
    {  
      if (timeout-- == 0)
      {
        return RES_ERROR;
      }
    }
  }
  if (SD_state == SD_OK)
  {
    return RES_OK;
  }
  
  return RES_ERROR;
}

/**
  * @brief  Writes Sector(s)  
  * @param  drv: Drive index
  * @param  *buff: Data to be written
  * @param  sector: Sector address (LBA)
  * @param  count: Number of sectors to write (1..128)
  * @retval DSTATUS: Operation status
  */
DRESULT ${comment}_write(const BYTE *buff, DWORD sector, BYTE count)
{
  uint32_t timeout = 100000;
  DWORD scratch [BLOCK_SIZE / 4];  /* Alignment ensured, need enough stack */ 
  HAL_SD_ErrorTypedef SD_state = SD_OK;
  
  if ((DWORD)buff & 3) // DMA Alignment issue, do single up to aligned buffer
  {
    while (count--)
    {
      memcpy (scratch, &buff[count * BLOCK_SIZE], BLOCK_SIZE);  

      SD_state = STM324x9i_SD_WriteBlocks_DMA((uint32_t*)scratch, (uint64_t)((sector + count) * BLOCK_SIZE), BLOCK_SIZE, 1);
      
      while(STM324x9i_SD_GetStatus() != SD_TRANSFER_OK)
      {
        if (timeout-- == 0)
        {
          return RES_ERROR;
        }
      }
    }
  }
  else
  {
      SD_state = STM324x9i_SD_WriteBlocks_DMA((uint32_t*)buff, (uint64_t)(sector * BLOCK_SIZE), BLOCK_SIZE, count);
      
    while(STM324x9i_SD_GetStatus() != SD_TRANSFER_OK)
    {
      if (timeout-- == 0)
      {
        return RES_ERROR;
      }
    }
  }
  if (SD_state == SD_OK)
  {
    return RES_OK;
  }
  
  return RES_ERROR;
}

/**
  * @brief  I/O control operation  
  * @param  drv: Drive index
  * @param  cmd: Control code
  * @param  *buff: Buffer to send/receive control data
  * @retval DSTATUS: Operation status
  */
DRESULT ${comment}_ioctl(BYTE cmd, void *buff)
{
  DRESULT res = RES_ERROR;
  HAL_SD_CardInfoTypedef CardInfo;
  
  if (Stat & STA_NOINIT) return RES_NOTRDY;
  
  switch (cmd) 
  {
  case CTRL_SYNC :	    /* Make sure that no pending write process */
    res = RES_OK;
    break;
    
  case GET_SECTOR_COUNT :   /* Get number of sectors on the disk (DWORD) */
    CardInfo = STM324x9i_SD_GetCardInfo();  
    *(DWORD*)buff = CardInfo.CardCapacity / 512; 
    res = RES_OK;
    break;
    
  case GET_SECTOR_SIZE :    /* Get R/W sector size (WORD) */
    *(WORD*)buff = 512;
    res = RES_OK;
    break;
    
  case GET_BLOCK_SIZE :	    /* Get erase block size in unit of sector (DWORD) */
    *(DWORD*)buff = 512;
    break;
    
  default:
    res = RES_PARERR;
  }
  
  return res;
}
 [/#list] 
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/