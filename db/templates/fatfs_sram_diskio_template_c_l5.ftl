[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    sram_diskio.c (for L5)
  * @brief   SRAM Disk I/O driver
  * @note    To be completed by the user according to the project board in use.
  *          (see templates available in the FW pack, Middlewares\Third_Party\FatFs\src\drivers folder).
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */ 

/* Includes ------------------------------------------------------------------*/
#include "ff_gen_drv.h"
#include "sram_diskio.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN PV */
/* Disk status */
static volatile DSTATUS Stat = STA_NOINIT;
/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
DSTATUS SRAMDISK_initialize (BYTE);
DSTATUS SRAMDISK_status (BYTE);
DRESULT SRAMDISK_read (BYTE, BYTE*, DWORD, UINT);
#if _USE_WRITE == 1
  DRESULT SRAMDISK_write (BYTE, const BYTE*, DWORD, UINT);
#endif /* _USE_WRITE == 1 */
#if _USE_IOCTL == 1
  DRESULT SRAMDISK_ioctl (BYTE, BYTE, void*);
#endif  /* _USE_IOCTL == 1 */

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

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

/* Private functions ---------------------------------------------------------*/

/**
  * @brief  Initializes a Drive
  * @param  lun : not used
  * @retval DSTATUS: Operation status
  */
DSTATUS SRAMDISK_initialize(BYTE lun)
{
  /* USER CODE BEGIN SRAMDISK_initialize */
  Stat = STA_NOINIT;
  
  /* Configure the SRAM device */
  /* Place for user code (may require BSP functions/defines to be added to the project) */

  return Stat;
  /* USER CODE END SRAMDISK_initialize */
}

/**
  * @brief  Gets Disk Status
  * @param  lun : not used
  * @retval DSTATUS: Operation status
  */
DSTATUS SRAMDISK_status(BYTE lun)
{
  /* USER CODE BEGIN SRAMDISK_status */
  
  return Stat;
  
  /* USER CODE END SRAMDISK_status */
}

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
  /* USER CODE BEGIN SRAMDISK_read */

  /* Place for user code (may require BSP functions/defines to be added to the project) */

  return RES_OK;

  /* USER CODE END SRAMDISK_read */
}

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
  /* USER CODE BEGIN SRAMDISK_write */

  /* Place for user code (may require BSP functions/defines to be added to the project) */

  return RES_OK;

  /* USER CODE END SRAMDISK_write */
}
#endif /* _USE_WRITE == 1 */

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
  /* USER CODE BEGIN SRAMDISK_ioctl */

  DRESULT res = RES_ERROR;

  /* Place for user code (may require BSP functions/defines to be added to the project) */

  return res;
  
  /* USER CODE END SRAMDISK_ioctl */
}
#endif /* _USE_IOCTL == 1 */


/* USER CODE BEGIN UserCode */
/* can be used to add code */
/* USER CODE END UserCode */
