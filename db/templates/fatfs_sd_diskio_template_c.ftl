[#ftl]
[#assign use_dma=0]
[#assign use_rtos=0]
[#if SWIPdatas??]
[#list SWIPdatas as SWIP]  
[#if SWIP.defines??]
 [#list SWIP.defines as definition] 
  [#if definition.name="USE_DMA_CODE_SD"]
   [#if definition.value="1"]
    [#assign use_dma=1]
   [/#if]
  [/#if]
  [#if definition.name="_FS_REENTRANT"]
   [#if definition.value="1"]
    [#assign use_rtos=1]
   [/#if]
  [/#if]
 [/#list]
[/#if]
[/#list]
[/#if]
/**
  ******************************************************************************
[#if use_dma = 1]
 [#if use_rtos = 1]
  * @file    sd_diskio.c (based on sd_diskio_dma_rtos_template.c)
 [#else]
  * @file    sd_diskio.c (based on sd_diskio_dma_template.c)
 [/#if]
[#else]
  * @file    sd_diskio.c (based on sd_diskio_template.c)
[/#if]
  * @brief   SD Disk I/O driver
  ******************************************************************************
[@common.optinclude name="Src/license.tmp"/][#--include License text --]
  ******************************************************************************
  */ 
/* USER CODE BEGIN firstSection */
/* can be used to modify / undefine following code or add new definitions */
/* USER CODE END firstSection*/

/* Includes ------------------------------------------------------------------*/
#include "ff_gen_drv.h"
#include "sd_diskio.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
[#if use_dma = 1]
[#if use_rtos = 1]   [#-- use rtos code only if dma was selected (no sd_diskio_rtos_template.c alone) --]
#define QUEUE_SIZE         (uint32_t) 10
#define READ_CPLT_MSG      (uint32_t) 1
#define WRITE_CPLT_MSG     (uint32_t) 2 
[/#if]
[/#if]
/* Private variables ---------------------------------------------------------*/
/* Disk status */
static volatile DSTATUS Stat = STA_NOINIT;
[#if use_dma = 1]
 [#if use_rtos = 1]
static osMessageQId SDQueueID;
 [#else]
static volatile  UINT  WriteStatus = 0, ReadStatus = 0;
 [/#if]
[/#if]
/* Private function prototypes -----------------------------------------------*/
static DSTATUS SD_CheckStatus(BYTE lun);
DSTATUS SD_initialize (BYTE);
DSTATUS SD_status (BYTE);
DRESULT SD_read (BYTE, BYTE*, DWORD, UINT);
#if _USE_WRITE == 1
  DRESULT SD_write (BYTE, const BYTE*, DWORD, UINT);
#endif /* _USE_WRITE == 1 */
#if _USE_IOCTL == 1
  DRESULT SD_ioctl (BYTE, BYTE, void*);
#endif  /* _USE_IOCTL == 1 */
  
const Diskio_drvTypeDef  SD_Driver =
{
  SD_initialize,
  SD_status,
  SD_read, 
#if  _USE_WRITE == 1
  SD_write,
#endif /* _USE_WRITE == 1 */
  
#if  _USE_IOCTL == 1
  SD_ioctl,
#endif /* _USE_IOCTL == 1 */
};

/* USER CODE BEGIN beforeFunctionSection */
/* can be used to modify / undefine following code or add new code */
/* USER CODE END beforeFunctionSection */

/* Private functions ---------------------------------------------------------*/
static DSTATUS SD_CheckStatus(BYTE lun)
{
  Stat = STA_NOINIT;

  if(BSP_SD_GetCardState() == MSD_OK)
  {
    Stat &= ~STA_NOINIT;
  }
  
  return Stat;
}

/**
  * @brief  Initializes a Drive
  * @param  lun : not used 
  * @retval DSTATUS: Operation status
  */
DSTATUS SD_initialize(BYTE lun)
{
  return SD_CheckStatus(lun);
}

/**
  * @brief  Gets Disk Status
  * @param  lun : not used
  * @retval DSTATUS: Operation status
  */
DSTATUS SD_status(BYTE lun)
{
  return SD_CheckStatus(lun);
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
DRESULT SD_read(BYTE lun, BYTE *buff, DWORD sector, UINT count)
{
  DRESULT res = RES_ERROR;
[#if use_dma = 1]
 [#if use_rtos = 1]
  osEvent event;
 [#else]
  ReadStatus = 0;
 [/#if]
[/#if]

[#if use_dma = 1]
  if(BSP_SD_ReadBlocks_DMA((uint32_t*)buff, 
                           (uint32_t) (sector), 
                           count) == MSD_OK)
[#else]
  if(BSP_SD_ReadBlocks((uint32_t*)buff, 
                       (uint32_t) (sector), 
                       count, SDMMC_DATATIMEOUT) == MSD_OK)
[/#if]
  {
[#if use_dma = 1]
 [#if use_rtos = 1]
    /* Get the message from the queue */
    event = osMessageGet(SDQueueID, osWaitForever);
    
    if (event.status == osEventMessage)
    {
      if (event.value.v == READ_CPLT_MSG)
      {
        while(BSP_SD_GetCardState())
        {
        }
        res = RES_OK;
      }
    }
  }  
 [#else]
    /* Wait for the reading process is completed */
    while(ReadStatus == 0)
    {
    }
    ReadStatus = 0;
    
    while(BSP_SD_GetCardState())
    {
    }
    
    res = RES_OK;
  }  
 [/#if]
[#else]
    /* wait until the read operation is finished */
    while(BSP_SD_GetCardState()!= MSD_OK)
    {
    }
    res = RES_OK;
  }
[/#if]
  return res;
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
DRESULT SD_write(BYTE lun, const BYTE *buff, DWORD sector, UINT count)
{
  DRESULT res = RES_ERROR;
[#if use_dma = 1]
 [#if use_rtos = 1]
  osEvent event;
 [#else]
  WriteStatus = 0;
 [/#if]
[/#if]

[#if use_dma = 1]
  if(BSP_SD_WriteBlocks_DMA((uint32_t*)buff, 
                           (uint32_t) (sector), 
                           count) == MSD_OK)
[#else]
  if(BSP_SD_WriteBlocks((uint32_t*)buff, 
                        (uint32_t)(sector), 
                        count, SDMMC_DATATIMEOUT) == MSD_OK)
[/#if]
  {
[#if use_dma = 1]
 [#if use_rtos = 1]
    /* Get the message from the queue */
    event = osMessageGet(SDQueueID, osWaitForever);
    
    if (event.status == osEventMessage)
    {
      if (event.value.v == WRITE_CPLT_MSG)
      {
        while(BSP_SD_GetCardState())
        {
        }
        res = RES_OK;
      }
    }
  }
 [#else]
    /* Wait for the writing process is completed */
    while(WriteStatus == 0)
    {
    }
    WriteStatus = 0;
    
    while(BSP_SD_GetCardState())
    {
    }
    
    res = RES_OK;
  }
 [/#if]
[#else]
	/* wait until the Write operation is finished */
    while(BSP_SD_GetCardState() != MSD_OK)
    {
    }    
    res = RES_OK;
  }
[/#if]

  return res;
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
DRESULT SD_ioctl(BYTE lun, BYTE cmd, void *buff)
{
  DRESULT res = RES_ERROR;
  BSP_SD_CardInfo CardInfo;
  
  if (Stat & STA_NOINIT) return RES_NOTRDY;
  
  switch (cmd)
  {
  /* Make sure that no pending write process */
  case CTRL_SYNC :
    res = RES_OK;
    break;
  
  /* Get number of sectors on the disk (DWORD) */
  case GET_SECTOR_COUNT :
    BSP_SD_GetCardInfo(&CardInfo);
    *(DWORD*)buff = CardInfo.LogBlockNbr;
    res = RES_OK;
    break;
  
  /* Get R/W sector size (WORD) */
  case GET_SECTOR_SIZE :
    BSP_SD_GetCardInfo(&CardInfo);
    *(WORD*)buff = CardInfo.LogBlockSize;
    res = RES_OK;
    break;
  
  /* Get erase block size in unit of sector (DWORD) */
  case GET_BLOCK_SIZE :
    BSP_SD_GetCardInfo(&CardInfo);
    *(DWORD*)buff = CardInfo.LogBlockSize;
    res = RES_OK;
    break;
  
  default:
    res = RES_PARERR;
  }
  
  return res;
}
#endif /* _USE_IOCTL == 1 */

/* USER CODE BEGIN afterIoctlSection */
/* can be used to modify previous code / undefine following code / add new code */
/* USER CODE END afterIoctlSection */

[#if use_dma = 1]
/* USER CODE BEGIN callbackSection */ 
/* can be used to modify / following code or add new code */
/* USER CODE END callbackSection */
/**
  * @brief Tx Transfer completed callbacks
  * @param hsd: SD handle
  * @retval None
  */
 /*
   ===============================================================================
    Select the correct function signature depending on your platform.
    please refer to the file "stm32xxxx_eval_sd.h" to verify the correct function 
    prototype
   ===============================================================================
  */
//void BSP_SD_WriteCpltCallback(uint32_t SdCard)
void BSP_SD_WriteCpltCallback()
{
[#if use_rtos = 1]
  osMessagePut(SDQueueID, WRITE_CPLT_MSG, osWaitForever);
[#else]
  WriteStatus = 1;
[/#if]
}

/**
  * @brief Rx Transfer completed callbacks
  * @param hsd: SD handle
  * @retval None
  */
  
  /*
   ===============================================================================
    Select the correct function signature depending on your platform.
    please refer to the file "stm32xxxx_eval_sd.h" to verify the correct function 
    prototype
   ===============================================================================
  */
//void BSP_SD_ReadCpltCallback(uint32_t SdCard)
void BSP_SD_ReadCpltCallback()
{
[#if use_rtos = 1]
  osMessagePut(SDQueueID, READ_CPLT_MSG, osWaitForever);
[#else]
  ReadStatus = 1;
[/#if]
}
[/#if]

/* USER CODE BEGIN lastSection */ 
/* can be used to modify / undefine previous code or add new code */
/* USER CODE END lastSection */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

