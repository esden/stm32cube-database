[#ftl]
/**
 ******************************************************************************
  * @file    user_diskio.c
  * @brief   This file includes a diskio driver skeleton to be completed by the user.
  ******************************************************************************
  *
  * COPYRIGHT(c) ${year} STMicroelectronics
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  *   1. Redistributions of source code must retain the above copyright notice,
  *      this list of conditions and the following disclaimer.
  *   2. Redistributions in binary form must reproduce the above copyright notice,
  *      this list of conditions and the following disclaimer in the documentation
  *      and/or other materials provided with the distribution.
  *   3. Neither the name of STMicroelectronics nor the names of its contributors
  *      may be used to endorse or promote products derived from this software
  *      without specific prior written permission.
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

[#-- SWIPdatas is a list of SWIPconfigModel --]  
[#list SWIPdatas as SWIP]  
[#assign NEW_DISKIO_API = "0"]
 [#if SWIP.defines??]
	[#list SWIP.defines as definition]	
      [#if definition.name=="NEW_DISKIO_API"]
	      [#assign NEW_DISKIO_API = definition.value]
	  [/#if]
	[/#list]
 [/#if]
[/#list]  

/* USER CODE BEGIN 0 */

/* Includes ------------------------------------------------------------------*/
#include <string.h>
#include "ff_gen_drv.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/


/* Private variables ---------------------------------------------------------*/
/* Disk status */
static volatile DSTATUS Stat = STA_NOINIT;

/* Private function prototypes -----------------------------------------------*/
[#if NEW_DISKIO_API=="2"]         [#-- Aligned with R0.11 --]  
DSTATUS USER_initialize (BYTE);
DSTATUS USER_status (BYTE);
DRESULT USER_read (BYTE, BYTE*, DWORD, UINT);
#if _USE_WRITE == 1
  DRESULT USER_write (BYTE, const BYTE*, DWORD, UINT);  
#endif /* _USE_WRITE == 1 */
#if _USE_IOCTL == 1
  DRESULT USER_ioctl (BYTE, BYTE, void*);  
#endif /* _USE_IOCTL == 1 */
[/#if]

[#if NEW_DISKIO_API=="1"]         [#-- Aligned with R0.10b --]  
DSTATUS USER_initialize (void);
DSTATUS USER_status (void);
DRESULT USER_read (BYTE*, DWORD, UINT);
#if _USE_WRITE == 1
  DRESULT USER_write (const BYTE*, DWORD, UINT);
#endif /* _USE_WRITE == 1 */
#if _USE_IOCTL == 1
  DRESULT USER_ioctl (BYTE, void*);
#endif /* _USE_IOCTL == 1 */
[/#if]

[#if NEW_DISKIO_API=="0"]         [#-- Aligned with R0.10 --]  
DSTATUS USER_initialize (void);
DSTATUS USER_status (void);
DRESULT USER_read (BYTE*, DWORD, BYTE);
#if _USE_WRITE == 1
  DRESULT USER_write (const BYTE*, DWORD, BYTE);
#endif /* _USE_WRITE == 1 */
#if _USE_IOCTL == 1
  DRESULT USER_ioctl (BYTE, void*);
#endif /* _USE_IOCTL == 1 */
[/#if]
 
Diskio_drvTypeDef  USER_Driver =
{
  USER_initialize,
  USER_status,
  USER_read, 
#if  _USE_WRITE
  USER_write,
#endif  /* _USE_WRITE == 1 */  
#if  _USE_IOCTL == 1
  USER_ioctl,
#endif /* _USE_IOCTL == 1 */
};

/* Private functions ---------------------------------------------------------*/

[#if NEW_DISKIO_API=="2"]         [#-- Aligned with R0.11 --]
/**
  * @brief  Initializes a Drive
  * @param  pdrv: Physical drive number (0..)
  * @retval DSTATUS: Operation status
  */
DSTATUS USER_initialize (
	BYTE pdrv           /* Physical drive nmuber to identify the drive */
)
[#else]
/**
  * @brief  Initializes a Drive
  * @param  None
  * @retval DSTATUS: Operation status
  */
DSTATUS USER_initialize(void)
[/#if]
{
  Stat = STA_NOINIT;
  
  /* USER CODE HERE */
  
  Stat &= ~STA_NOINIT;
  return Stat;
}


[#if NEW_DISKIO_API=="2"]         [#-- Aligned with R0.11 --]  
/**
  * @brief  Gets Disk Status 
  * @param  pdrv: Physical drive number (0..)
  * @retval DSTATUS: Operation status
  */
DSTATUS USER_status (
	BYTE pdrv       /* Physical drive nmuber to identify the drive */
)
[#else]
/**
  * @brief  Gets Disk Status
  * @param  None
  * @retval DSTATUS: Operation status
  */
DSTATUS USER_status(void)
[/#if]
{
  Stat = STA_NOINIT;
  
  Stat &= ~STA_NOINIT;

  return Stat;
}


[#if NEW_DISKIO_API=="2"]
/**
  * @brief  Reads Sector(s) 
  * @param  pdrv: Physical drive number (0..)
  * @param  *buff: Data buffer to store read data
  * @param  sector: Sector address (LBA)
  * @param  count: Number of sectors to read (1..128)
  * @retval DRESULT: Operation result
  */
DRESULT USER_read (
	BYTE pdrv,      /* Physical drive nmuber to identify the drive */
	BYTE *buff,     /* Data buffer to store read data */
	DWORD sector,   /* Sector address in LBA */
	UINT count      /* Number of sectors to read */
)
[/#if]
[#if NEW_DISKIO_API=="1"]
/**
  * @brief  Reads Sector(s)
  * @param  *buff: Data buffer to store read data
  * @param  sector: Sector address (LBA)
  * @param  count: Number of sectors to read (1..128)
  * @retval DRESULT: Operation result
  */
DRESULT USER_read(BYTE *buff, DWORD sector, UINT count)
[/#if]
[#if NEW_DISKIO_API=="0"]
/**
  * @brief  Reads Sector(s)
  * @param  *buff: Data buffer to store read data
  * @param  sector: Sector address (LBA)
  * @param  count: Number of sectors to read (1..128)
  * @retval DRESULT: Operation result
  */
DRESULT USER_read(BYTE *buff, DWORD sector, BYTE count)
[/#if]
{
  /* USER CODE HERE */
  
  return RES_OK;
}


[#if NEW_DISKIO_API=="2"]
/**
  * @brief  Writes Sector(s)  
  * @param  pdrv: Physical drive number (0..)
  * @param  *buff: Data to be written
  * @param  sector: Sector address (LBA)
  * @param  count: Number of sectors to write (1..128)
  * @retval DRESULT: Operation result
  */
#if _USE_WRITE == 1
DRESULT USER_write (
	BYTE pdrv,          /* Physical drive nmuber to identify the drive */
	const BYTE *buff,   /* Data to be written */
	DWORD sector,       /* Sector address in LBA */
	UINT count          /* Number of sectors to write */
)
[/#if]
[#if NEW_DISKIO_API=="1"]
/**
  * @brief  Writes Sector(s)
  * @param  *buff: Data to be written
  * @param  sector: Sector address (LBA)
  * @param  count: Number of sectors to write (1..128)
  * @retval DRESULT: Operation result
  */
#if _USE_WRITE == 1
DRESULT USER_write(const BYTE *buff, DWORD sector, UINT count)
[/#if]
[#if NEW_DISKIO_API=="0"]
/**
  * @brief  Writes Sector(s)
  * @param  *buff: Data to be written
  * @param  sector: Sector address (LBA)
  * @param  count: Number of sectors to write (1..128)
  * @retval DRESULT: Operation result
  */
#if _USE_WRITE == 1
DRESULT USER_write(const BYTE *buff, DWORD sector, BYTE count)
[/#if]
{ 
  /* USER CODE HERE */

  return RES_OK;
}
#endif /* _USE_WRITE == 1 */

[#if NEW_DISKIO_API=="2"]
/**
  * @brief  I/O control operation  
  * @param  pdrv: Physical drive number (0..)
  * @param  cmd: Control code
  * @param  *buff: Buffer to send/receive control data
  * @retval DRESULT: Operation result
  */
#if _USE_IOCTL == 1
DRESULT USER_ioctl (
	BYTE pdrv,      /* Physical drive nmuber (0..) */
	BYTE cmd,       /* Control code */
	void *buff      /* Buffer to send/receive control data */
)
{
  DRESULT res = RES_ERROR;
  
  /* USER CODE HERE */

  return res;
}
#endif /* _USE_IOCTL == 1 */
[#else]
/**
  * @brief  I/O control operation
  * @param  cmd: Control code
  * @param  *buff: Buffer to send/receive control data
  * @retval DRESULT: Operation result
  */
#if _USE_IOCTL == 1
DRESULT USER_ioctl(BYTE cmd, void *buff)
{
  DRESULT res = RES_ERROR;
  
  /* USER CODE HERE */

  return res;
}
#endif /* _USE_IOCTL == 1 */
[/#if]


/* USER CODE END 0 */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/