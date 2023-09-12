[#ftl]
/**
  ******************************************************************************
  * @file    sram_diskio.c (based on sram_diskio_template.c v2.0.2)
  * @brief   SRAM Disk I/O driver
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE BEGIN firstSection */ 
/* can be used to modify / undefine following code or add new definitions */
/* USER CODE END firstSection */ 

/* Includes ------------------------------------------------------------------*/
#include "ff_gen_drv.h"
#include "sram_diskio.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Block Size in Bytes */
#define BLOCK_SIZE                512

/* Private variables ---------------------------------------------------------*/
/* Disk status */
static volatile DSTATUS Stat = STA_NOINIT;

/* Private function prototypes -----------------------------------------------*/
DSTATUS SRAMDISK_initialize (BYTE);
DSTATUS SRAMDISK_status (BYTE);
DRESULT SRAMDISK_read (BYTE, BYTE*, DWORD, UINT);
#if _USE_WRITE == 1
  DRESULT SRAMDISK_write (BYTE, const BYTE*, DWORD, UINT);
#endif /* _USE_WRITE == 1 */
#if _USE_IOCTL == 1
  DRESULT SRAMDISK_ioctl (BYTE, BYTE, void*);
#endif /* _USE_IOCTL == 1 */

const Diskio_drvTypeDef SRAMDISK_Driver =
{
  SRAMDISK_initialize,
  SRAMDISK_status,
  SRAMDISK_read,
#if  _USE_WRITE == 1
  SRAMDISK_write,
#endif /* _USE_WRITE == 1 */
#if  _USE_IOCTL == 1
  SRAMDISK_ioctl,
#endif /* _USE_IOCTL == 1 */
};

/* USER CODE BEGIN beforeFunctionSection */
/* can be used to modify / undefine following code or add new code */
/* USER CODE END beforeFunctionSection */

/* Private functions ---------------------------------------------------------*/

/**
  * @brief  Initializes a Drive
  * @param  lun : not used
  * @retval DSTATUS: Operation status
  */
DSTATUS SRAMDISK_initialize(BYTE lun)
{
  Stat = STA_NOINIT;

  /* Configure the SRAM device */
  if(BSP_SRAM_Init() == SRAM_OK)
  {
     Stat &= ~STA_NOINIT;
  }

  return Stat;
}

/**
  * @brief  Gets Disk Status
  * @param  lun : not used
  * @retval DSTATUS: Operation status
  */
DSTATUS SRAMDISK_status(BYTE lun)
{
  return Stat;
}

/* USER CODE BEGIN beforeReadSection */
/* can be used to modify previous code / undefine following code / add new code */
/* USER CODE END beforeReadSection */

/**
  * @brief  Reads Sector(s)
  * @param  lun : not used
  * @param  *buff: Data buffer to store read data
  * @param  sector: Sector address (LBA)
  * @param  count: Number of sectors to read (1..128)
  * @retval DRESULT: Operation result
  */
DRESULT SRAMDISK_read(BYTE lun, BYTE *buff, DWORD sector, UINT count)
{
  uint32_t BufferSize = (BLOCK_SIZE * count);
  uint8_t *pMem = (uint8_t *) (SRAM_DEVICE_ADDR + (sector * BLOCK_SIZE));

  for(; BufferSize != 0; BufferSize--)
  {
    *buff++ = *(__IO uint8_t *)pMem++;
  }

  return RES_OK;
}

/* USER CODE BEGIN beforeWriteSection */
/* can be used to modify previous code / undefine following code / add new code */
/* USER CODE END beforeWriteSection */

/**
  * @brief  Writes Sector(s)
  * @param  lun : not used
  * @param  *buff: Data to be written
  * @param  sector: Sector address (LBA)
  * @param  count: Number of sectors to write (1..128)
  * @retval DRESULT: Operation result
  */
#if _USE_WRITE == 1
DRESULT SRAMDISK_write(BYTE lun, const BYTE *buff, DWORD sector, UINT count)
{
  uint32_t BufferSize = (BLOCK_SIZE * count);
  uint8_t *pMem = (uint8_t *) (SRAM_DEVICE_ADDR + (sector * BLOCK_SIZE));

  for(; BufferSize != 0; BufferSize--)
  {
    *(__IO uint8_t *)pMem++ = *buff++;
  }

  return RES_OK;
}
#endif /* _USE_WRITE == 1 */

/* USER CODE BEGIN beforeIoctlSection */
/* can be used to modify previous code / undefine following code / add new code */
/* USER CODE END beforeIoctlSection */

/**
  * @brief  I/O control operation
  * @param  lun : not used
  * @param  cmd: Control code
  * @param  *buff: Buffer to send/receive control data
  * @retval DRESULT: Operation result
  */
#if _USE_IOCTL == 1
DRESULT SRAMDISK_ioctl(BYTE lun, BYTE cmd, void *buff)
{
  DRESULT res = RES_ERROR;

  if (Stat & STA_NOINIT) return RES_NOTRDY;

  switch (cmd)
  {
  /* Make sure that no pending write process */
  case CTRL_SYNC :
    res = RES_OK;
    break;

  /* Get number of sectors on the disk (DWORD) */
  case GET_SECTOR_COUNT :
    *(DWORD*)buff = SRAM_DEVICE_SIZE / BLOCK_SIZE;
    res = RES_OK;
    break;

  /* Get R/W sector size (WORD) */
  case GET_SECTOR_SIZE :
    *(WORD*)buff = BLOCK_SIZE;
    res = RES_OK;
    break;

  /* Get erase block size in unit of sector (DWORD) */
  case GET_BLOCK_SIZE :
    *(DWORD*)buff = 1;
    res = RES_OK;
    break;

  default:
    res = RES_PARERR;
  }

  return res;
}
#endif /* _USE_IOCTL == 1 */

/* USER CODE BEGIN lastSection */ 
/* can be used to modify / undefine previous code or add new code */
/* USER CODE END lastSection */ 
  
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

