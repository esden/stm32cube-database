[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name?remove_beginning("Modules/NVM/")}
  * @author  MCD Application Team
  * @brief   Function for managing HCI interface.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "app_common.h"
#include "nvm_arbiter.h"
#include "stm32_seq.h"
#ifdef NVM_ADAPT
#include "app_conf.h"

#else /* NVM_ADAPT */
#include "ee.h"
#include "dbg_gpio.h"
#include "host_sys.h"
#endif /* NVM_ADAPT */
/* Private typedef -----------------------------------------------------------*/
typedef enum
{
  PROCESS_IDLE,                 /** The NVMA Process has nothing to do */
  PROCESS_WAIT_SEM,             /** The NVMA Process is waiting for the semaphore to be free */
  PROCESS_WRITE_ONGOING,        /** The NVMA Process is writing data in NVM */
  PROCESS_WRITE_COMPLETE,       /** The NVMA Process has written all data in NVM and needs to notify the user */
  PROCESS_CLEANUP,              /** The NVMA Process is cleaning the NVM */
} Process_FlashStatus_t;

typedef enum
{
  PROCESS_SRAM_IDLE,         /** The SRAM Process has nothing to do */
  PROCESS_SRAM_WAIT_SEM,     /** The SRAM NVMA Process is waiting for the semaphore to be free */
} Process_SramStatus_t;

/* NVMA NVM request */
typedef enum
{
  REQUEST_SEM_POLL,    /** The NVM Arbiter requests access the Semaphore in polling mode */
  REQUEST_SEM_IT,      /** The NVM Arbiter requests access to Semaphore in interrupt mode */
  RELEASE_SEM,         /** The NVM Arbiter releases the Semaphore */
} SemReq_t;

typedef enum
{
  REQUEST_SEM_DONE,      /** The action requested has been done */
  REQUEST_SEM_PENDING,   /** The action requested has not been done, an interrupt has been configured to retry later on */
} SemReqStatus_t;


typedef struct
{
  uint32_t             *src;          /**< Start address of the data to be written in the NVM */
  uint32_t             offset_dest;   /**< Start address in the NVM where the data shall be written */
  uint32_t             size;          /**< Size of data to be written */
} UserContext_t;

typedef struct
{
  Process_FlashStatus_t Process_FlashStatus;
  NVMA_DbId_t           DbId;          /**< Identifier of the user that needs to store data in NVM */
  uint32_t              WriteCurrentSize;
} NVMA_FlashContext_t;

typedef struct
{
  NVMA_Nvm_Location_Config_t  NvmLocationConfig;
  uint32_t                    NvmRamAddress;
} NVMA_Config_t;


/* Private defines -----------------------------------------------------------*/
#define BLE_DB_START_ADR        ( 0 )
#define THREAD_DB_STRT_ADR      ( CFG_NVM_BLE_MAX_SIZE )

/* Private macros ------------------------------------------------------------*/
/* Public variables ----------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
#ifndef NVM_ADAPT
PLACE_IN_SECTION("NVM_AREA") const uint8_t NVM_AREA[CFG_EE_BANK0_SIZE];
#endif /* NVM_ADAPT */
static NVMA_ActivityStatusCb_t aActivityStatusFlashCbList[NVMA_NUMBER_OF_DATABASE];
static NVMA_FlashContext_t NVMA_FlashContext;

static NVMA_Cmd_Status_t CmdStatus;
static UserContext_t  aUserContext[NVMA_NUMBER_OF_DATABASE];
static NVMA_Config_t aNVMA_Config[NVMA_NUMBER_OF_DATABASE];

static NVMA_ActivityStatusCb_t ActivityStatusSramBleCb;
static Process_SramStatus_t  Process_SramBleStatus;

static NVMA_ActivityStatusCb_t ActivityStatusSramThreadCb;
static Process_SramStatus_t  Process_SramThreadStatus;



static uint32_t NVMA_aBleLocalCache[CFG_NVM_BLE_MAX_SIZE];


/* Private function prototypes -----------------------------------------------*/
static void NVMA_Process(void);
static void NVMA_SramBleProcess(void);
static void NVMA_SramThreadProcess(void);
static SemReqStatus_t ReqSem(SemReq_t SemReq, uint32_t SemId);


/*************************************************************
 *
 * PUBLIC FUNCTIONS
 *
 *************************************************************/
void NVMA_Init(void)
{
#ifndef NVM_ADAPT
  int eeprom_init_status;
  uint32_t cpu_boot_address;
#endif

  uint32_t local_loop;

  (void)ReqSem(REQUEST_SEM_POLL, CFG_HW_FLASH_SEMID);
#ifndef NVM_ADAPT
  (void)HAL_FLASH_Unlock( );
#endif /* NVM_ADAPT */


  UTIL_SEQ_RegTask((1<<CFG_TASK_NVM_PROCESS), UTIL_SEQ_RFU, NVMA_Process);
  UTIL_SEQ_RegTask(1<<CFG_TASK_NVM_SRAM_BLE_PROCESS, UTIL_SEQ_RFU, NVMA_SramBleProcess);
  UTIL_SEQ_RegTask(1<<CFG_TASK_NVM_SRAM_THREAD_PROCESS, UTIL_SEQ_RFU, NVMA_SramThreadProcess);

  /**
   * Enable the HSEM interrupt
   *
   * The HSEM interrupt is shared with the IPCC
   * The NVIC is already set in hw_ipcc.c
   */

  CmdStatus = NVMA_CMD_OK;
  for(local_loop = 0; local_loop < NVMA_NUMBER_OF_DATABASE; local_loop++)
  {
    aActivityStatusFlashCbList[local_loop] = 0;
    aNVMA_Config[local_loop].NvmLocationConfig = NVMA_NVM_IN_FLASH;
    aNVMA_Config[local_loop].NvmRamAddress = 0;
  }

  NVMA_FlashContext.Process_FlashStatus = PROCESS_IDLE;
  Process_SramBleStatus = PROCESS_SRAM_IDLE;
  Process_SramThreadStatus = PROCESS_SRAM_IDLE;

#ifndef NVM_ADAPT
  cpu_boot_address = ((READ_BIT(FLASH->SRRVR, FLASH_SRRVR_SBRV))) << 2;

  eeprom_init_status = EE_Init( 0, HW_FLASH_ADDRESS + cpu_boot_address + (uint32_t)NVM_AREA );

  if(eeprom_init_status != EE_OK)
  {
    EE_Init( 1, HW_FLASH_ADDRESS + cpu_boot_address + (uint32_t)NVM_AREA );
  }

  (void)HAL_FLASH_Lock();
#endif  /* NVM_ADAPT */
  (void)ReqSem(RELEASE_SEM, CFG_HW_FLASH_SEMID);

  return;
}

                  
void NVMA_SetNvmConfig(NVMA_Nvm_Location_Config_t BleConfig, NVMA_Nvm_Location_Config_t ThreadConfig, uint32_t BleNvmRamAddress, uint32_t ThreadNvmRamAddress)
{
  aNVMA_Config[NVMA_DB_ID_BLE].NvmLocationConfig = BleConfig;
  aNVMA_Config[NVMA_DB_ID_THREAD].NvmLocationConfig = ThreadConfig;
  aNVMA_Config[NVMA_DB_ID_BLE].NvmRamAddress = BleNvmRamAddress;
  aNVMA_Config[NVMA_DB_ID_THREAD].NvmRamAddress = ThreadNvmRamAddress;

  return;
}

NVMA_Cmd_Status_t NVMA_Write( NVMA_Write_Parameter_t  *p_WriteParameter )
{
  NVMA_Cmd_Status_t return_value;

  if(aNVMA_Config[p_WriteParameter->DbId].NvmLocationConfig == NVMA_NVM_IN_FLASH)
  {
    /**
     * The data are requested to be stored in Flash
     */
    aActivityStatusFlashCbList[p_WriteParameter->DbId] = p_WriteParameter->arbiter_status_cb;

    if(CmdStatus == NVMA_CMD_OK)
    {
      /**
       * There is no command already pending for flash programming.
       * Need to check now if the flash IP is available
       */
      if( ReqSem(REQUEST_SEM_IT, CFG_HW_FLASH_SEMID) == REQUEST_SEM_DONE)
      {
        /**
         * The Semaphore is free - the flash is available
         */
        CmdStatus = NVMA_CMD_BUSY;
        return_value = NVMA_CMD_OK;


        if(p_WriteParameter->DbId == NVMA_DB_ID_BLE)
        {
          memcpy( NVMA_aBleLocalCache, p_WriteParameter->src, (p_WriteParameter->size)<<2);
          aUserContext[NVMA_DB_ID_BLE].src = NVMA_aBleLocalCache;
        }
        else

        {
          aUserContext[NVMA_DB_ID_THREAD].src = p_WriteParameter->src;
        }
        NVMA_FlashContext.DbId = p_WriteParameter->DbId;
        aUserContext[NVMA_FlashContext.DbId].offset_dest = p_WriteParameter->offset_dest;
        aUserContext[NVMA_FlashContext.DbId].size = p_WriteParameter->size;
        NVMA_FlashContext.WriteCurrentSize = 0;
        NVMA_FlashContext.Process_FlashStatus = PROCESS_WRITE_ONGOING;

        (void)HAL_FLASH_Unlock();

        UTIL_SEQ_SetTask(1<<CFG_TASK_NVM_PROCESS , CFG_SCH_PRIO_0);
      }
      else
      {
        /**
         * The semaphore is busy
         * An interrupt will be generated when the semaphore is getting free and the user callback will be called
         */
        NVMA_FlashContext.Process_FlashStatus = PROCESS_WAIT_SEM;
        return_value = NVMA_CMD_BUSY;
      }
#ifndef NVM_ADAPT
      /* Reports to the CPU1 some data need to be written in flash */
      HOST_SYS_StartWrite(aUserContext[NVMA_FlashContext.DbId].size);
#endif /* NVM_ADAPT */
    }
    else
    {
      return_value = NVMA_CMD_BUSY;
    }
  }
  else if( (p_WriteParameter->DbId == NVMA_DB_ID_BLE) && (aNVMA_Config[NVMA_DB_ID_BLE].NvmRamAddress != 0) )
  {
    /**
     * The BLE data is requested to be store in external SRAM
     */
    if( ReqSem(REQUEST_SEM_IT, CFG_HW_BLE_NVM_SRAM_SEMID) == REQUEST_SEM_DONE)
    {
      /**
       * The semaphore is available, the data may be copied in shared unsecure SRAM
       */
      memcpy( (void*)(aNVMA_Config[NVMA_DB_ID_BLE].NvmRamAddress + ((p_WriteParameter->offset_dest)<<2)), p_WriteParameter->src, (p_WriteParameter->size)<<2);
#ifndef NVM_ADAPT
      HOST_SYS_BleNvmRamUpdate(aNVMA_Config[NVMA_DB_ID_BLE].NvmRamAddress + ((p_WriteParameter->offset_dest)<<2), (p_WriteParameter->size)<<2);
#endif /* NVM_ADAPT */
      ReqSem(RELEASE_SEM, CFG_HW_BLE_NVM_SRAM_SEMID);
      return_value = NVMA_CMD_OK;
    }
    else
    {
      /**
       * The callback is required only in the busy use case
       * Otherwise, we need to call the complete callback just after
       * the data has been copied in that same function
       */
      ActivityStatusSramBleCb = p_WriteParameter->arbiter_status_cb;

      /**
       * The semaphore is busy. The CPU1 is currently reading data from shared unsecure SRAM
       */
      Process_SramBleStatus = PROCESS_SRAM_WAIT_SEM;
      return_value = NVMA_CMD_BUSY;
    }
  }
  else if( (p_WriteParameter->DbId == NVMA_DB_ID_THREAD) && (aNVMA_Config[NVMA_DB_ID_THREAD].NvmRamAddress != 0) )
  {
    /**
     * The Thread data is requested to be store in external SRAM
     */
    if( ReqSem(REQUEST_SEM_IT, CFG_HW_THREAD_NVM_SRAM_SEMID) == REQUEST_SEM_DONE)
    {
      /**
       * The semaphore is available, the data may be copied in shared unsecure SRAM
       */
      memcpy( (void*)(aNVMA_Config[NVMA_DB_ID_THREAD].NvmRamAddress + ((p_WriteParameter->offset_dest)<<2)), p_WriteParameter->src, (p_WriteParameter->size)<<2);
#ifndef NVM_ADAPT
      HOST_SYS_ThreadNvmRamUpdate(aNVMA_Config[NVMA_DB_ID_THREAD].NvmRamAddress + ((p_WriteParameter->offset_dest)<<2), (p_WriteParameter->size)<<2);
#endif /* NVM_ADAPT */
      ReqSem(RELEASE_SEM, CFG_HW_THREAD_NVM_SRAM_SEMID);
      return_value = NVMA_CMD_OK;
    }
    else
    {
      /**
       * The callback is required only in the busy use case
       * Otherwise, we need to call the complete callback just after
       * the data has been copied in that same function
       */
      ActivityStatusSramThreadCb = p_WriteParameter->arbiter_status_cb;

      /**
       * The semaphore is busy. The CPU1 is currently reading data from shared unsecure SRAM
       */
      Process_SramThreadStatus = PROCESS_SRAM_WAIT_SEM;
      return_value = NVMA_CMD_BUSY;
    }
  }
  else
  {
    /**
     * It is requested to keep the data in SRAM. Do not use any NVM mechanism
     * Nothing is store anywhere
     */
    return_value = NVMA_CMD_OK;
  }

  return return_value;
}

void NVMA_Read( NVMA_DbId_t DbId, uint32_t OffsetSrc, uint32_t * Dest, uint32_t Size )
{
#ifndef NVM_ADAPT
  uint32_t db_offset;

  if(DbId == NVMA_DB_ID_BLE)
  {
    db_offset = BLE_DB_START_ADR;
  }
  else
  {
    db_offset = THREAD_DB_STRT_ADR;
  }

  if(aNVMA_Config[DbId].NvmLocationConfig == NVMA_NVM_IN_FLASH)
  {

    /**
     * In the current application, the NVMA_Read() is used only to dump the NVM to the SRAM
     * at startup.
     *
     * In case there are some use cases where the application needs to read only 1 data,
     * a test versus the Size needs to be implemented
     * The algorithm to use depends on the way the application stores the data in NVM but most of the time,
     * EE_Read() should be used when Size = 1 and EE_Dump() otherwise
     */
    EE_Dump( 0, (uint16_t)(OffsetSrc + db_offset), Dest, Size);
  }
  else
  {
#endif /* NVM_ADAPT */
    if(aNVMA_Config[DbId].NvmRamAddress != 0)
    {
      memcpy(Dest,(uint32_t*)(aNVMA_Config[DbId].NvmRamAddress + (OffsetSrc*4)), Size*4);
    }
#ifndef NVM_ADAPT
  }
#endif  /* NVM_ADAPT */

  return;
}

/*************************************************************
 *
 * LOCAL FUNCTIONS
 *
 *************************************************************/
static void NVMA_Process( void )
{
  uint32_t db_index;
  uint32_t local_current_size;

  NVMA_ActivityStatusCb_t current_activity_status_cb;
#ifndef NVM_ADAPT
  uint32_t db_offset;
  int ee_status;
  DBG_GPIO_Gr1Set( DBG_GPIO_GR1_NVM_PROCESS );
#endif /* NVM_ADAPT */
  switch(NVMA_FlashContext.Process_FlashStatus)
  {
    case PROCESS_IDLE:
      /**
       * This is added in case in some implementation, the NVMA_Process() is called in a while loop
       * without any condition.
       * Just exit if there is nothing to do.
       */
      break;

    case PROCESS_WAIT_SEM:
#ifndef NVM_ADAPT
      DBG_GPIO_Gr1Set(DBG_GPIO_GR1_NVMA_START);
#endif /* NVM_ADAPT */

      /**
       * Notify registered client the NVMA is ready to receive operation
       */
      for(db_index = 0 ;  db_index < NVMA_NUMBER_OF_DATABASE ; db_index++)
      {
        if(aActivityStatusFlashCbList[db_index] != 0)
        {
          current_activity_status_cb = aActivityStatusFlashCbList[db_index];
          aActivityStatusFlashCbList[db_index] = 0;
          current_activity_status_cb( NVMA_RELEASED );
        }
      }
#ifndef NVM_ADAPT
      DBG_GPIO_Gr1Reset(DBG_GPIO_GR1_NVMA_START);
#endif /* NVM_ADAPT */
      break;

    case PROCESS_WRITE_ONGOING:
#ifndef NVM_ADAPT
      DBG_GPIO_Gr1Set(DBG_GPIO_GR1_NVMA_WRITE_ONGOING);

      if(NVMA_FlashContext.DbId == NVMA_DB_ID_BLE)
      {
        db_offset = BLE_DB_START_ADR;
      }
      else
      {
        db_offset = THREAD_DB_STRT_ADR;
      }
#endif /* NVM_ADAPT */
      NVMA_FlashContext.Process_FlashStatus = PROCESS_WRITE_COMPLETE;

      for( local_current_size = NVMA_FlashContext.WriteCurrentSize; local_current_size < aUserContext[NVMA_FlashContext.DbId].size; local_current_size++ )
      {
        
#ifndef NVM_ADAPT
        ee_status = EE_Write( 0, (uint16_t)(aUserContext[NVMA_FlashContext.DbId].offset_dest + local_current_size + db_offset), *(aUserContext[NVMA_FlashContext.DbId].src + local_current_size) );
        if(ee_status != EE_OK)
        {
          /**
           * Currently assuming either EE_OK or EE_CLEAN_NEEDED can be returned
           */
          NVMA_FlashContext.Process_FlashStatus = PROCESS_CLEANUP;
          NVMA_FlashContext.WriteCurrentSize = local_current_size;
          break; /** move out the for loop */
        }
#endif /* NVM_ADAPT */
      }

      UTIL_SEQ_SetTask((1<<CFG_TASK_NVM_PROCESS) , CFG_SCH_PRIO_0);

#ifndef NVM_ADAPT
      DBG_GPIO_Gr1Reset(DBG_GPIO_GR1_NVMA_WRITE_ONGOING);
#endif /* NVM_ADAPT */
      break;

    case PROCESS_WRITE_COMPLETE:
#ifndef NVM_ADAPT
      DBG_GPIO_Gr1Set(DBG_GPIO_GR1_NVMA_WRITE_COMPLETE);
#endif /* NVM_ADAPT */

#ifndef NVM_ADAPT
      (void)HAL_FLASH_Lock();
#endif /* NVM_ADAPT */

      (void)ReqSem(RELEASE_SEM, CFG_HW_FLASH_SEMID);
#ifndef NVM_ADAPT
      /* Reports to the CPU1 all data have been written */
      HOST_SYS_EndWrite();
#endif /* NVM_ADAPT */

      NVMA_FlashContext.Process_FlashStatus = PROCESS_IDLE;

      if(aActivityStatusFlashCbList[NVMA_FlashContext.DbId] != 0)
      {
        current_activity_status_cb = aActivityStatusFlashCbList[NVMA_FlashContext.DbId];
        aActivityStatusFlashCbList[NVMA_FlashContext.DbId] = 0;
        current_activity_status_cb( NVMA_DATA_WRITTEN );
      }

      CmdStatus = NVMA_CMD_OK;

      for(db_index = 0 ;  db_index < NVMA_NUMBER_OF_DATABASE ; db_index++)
      {
        if(aActivityStatusFlashCbList[db_index] != 0)
        {
          current_activity_status_cb = aActivityStatusFlashCbList[db_index];
          aActivityStatusFlashCbList[db_index] = 0;
          current_activity_status_cb( NVMA_RELEASED );
        }
      }
#ifndef NVM_ADAPT
      DBG_GPIO_Gr1Reset(DBG_GPIO_GR1_NVMA_WRITE_COMPLETE);
#endif /* NVM_ADAPT */

      break;

    case PROCESS_CLEANUP:
#ifndef NVM_ADAPT
      DBG_GPIO_Gr1Set(DBG_GPIO_GR1_NVMA_CLEANUP);
#endif /* NVM_ADAPT */

      /**
       * Once the cleanup is done, get back to PROCESS_WRITE_ONGOING to check if other data need to be written
       */
      NVMA_FlashContext.Process_FlashStatus = PROCESS_WRITE_ONGOING;

      /**
       * Enable BLE timing protection versus flash erase
       */
#ifndef NVM_ADAPT
      HOST_SYS_EraseNotification( (1<<HOST_SYS_ERASE_NOTIFICATION_USERID_NVM_ARBITER), HOST_SYS_ERASE_NOTIFICATION_ON );
#endif /* NVM_ADAPT */

      /**
       *  The notification to the CPU1 of the start of the erase process is done in hw_flash.c
       *  to be able to provide the number of sectors to be erased
       */
#ifndef NVM_ADAPT
      /**
       * EE_Clean() will get out only when all pages are erased
       */
      EE_Clean(0,1);
#endif /* NVM_ADAPT */
      
#ifndef NVM_ADAPT      
      /* Reports to the CPU1 all required sectors have been erased in flash */
      HOST_SYS_EndErase();
#endif /* NVM_ADAPT */
      /**
       * Disable BLE timing protection versus flash erase
       */

#ifndef NVM_ADAPT
      HOST_SYS_EraseNotification( (1<<HOST_SYS_ERASE_NOTIFICATION_USERID_NVM_ARBITER), HOST_SYS_ERASE_NOTIFICATION_OFF );
#endif /* NVM_ADAPT */

      UTIL_SEQ_SetTask((1<<CFG_TASK_NVM_PROCESS) , CFG_SCH_PRIO_0);

#ifndef NVM_ADAPT
      DBG_GPIO_Gr1Reset(DBG_GPIO_GR1_NVMA_CLEANUP);
#endif /* NVM_ADAPT */
      break;

    default:
      break;
  }
#ifndef NVM_ADAPT
  DBG_GPIO_Gr1Reset( DBG_GPIO_GR1_NVM_PROCESS );
#endif /* NVM_ADAPT */

  return;
}

static void NVMA_SramBleProcess(void)
{
  NVMA_ActivityStatusCb_t current_activity_status_cb;

  switch(Process_SramBleStatus)
  {
    case PROCESS_SRAM_IDLE:
      /**
       * This is added in case in some implementation, the NVMA_Process() is called in a while loop
       * without any condition.
       * Just exit if there is nothing to do.
       */
      break;

    case PROCESS_SRAM_WAIT_SEM:
      /**
       * Notify registered client the NVMA is ready to receive operation
       */
      if(ActivityStatusSramBleCb != 0)
      {
        current_activity_status_cb = ActivityStatusSramBleCb;
        ActivityStatusSramBleCb = 0;
        current_activity_status_cb( NVMA_RELEASED );
      }

      break;

    default:
      break;
  }
  return;
}

static void NVMA_SramThreadProcess(void)
{
  NVMA_ActivityStatusCb_t current_activity_status_cb;

  switch(Process_SramThreadStatus)
  {
    case PROCESS_SRAM_IDLE:
      /**
       * This is added in case in some implementation, the NVMA_Process() is called in a while loop
       * without any condition.
       * Just exit if there is nothing to do.
       */
      break;

    case PROCESS_SRAM_WAIT_SEM:
      /**
       * Notify registered client the NVMA is ready to receive operation
       */
      if(ActivityStatusSramThreadCb != 0)
      {
        current_activity_status_cb = ActivityStatusSramThreadCb;
        ActivityStatusSramThreadCb = 0;
        current_activity_status_cb( NVMA_RELEASED );
      }

      break;

    default:
      break;
  }
  return;
}

static SemReqStatus_t ReqSem(SemReq_t SemReq, uint32_t SemId)
{
  SemReqStatus_t return_value = REQUEST_SEM_DONE;
#ifndef NVM_ADAPT
  switch(SemReq)
  {
    case REQUEST_SEM_POLL:
      
      while( LL_HSEM_1StepLock( HSEM, SemId ) );
      break;

    case REQUEST_SEM_IT:
      LL_HSEM_ClearFlag_C2ICR(HSEM, 1<<SemId);
      if( LL_HSEM_1StepLock( HSEM, SemId ) != 0 )
      {
        /**
         * Semaphore is busy
         * Enable interrupt
         */
        LL_HSEM_EnableIT_C2IER(HSEM, 1<<SemId);
        return_value = REQUEST_SEM_PENDING;
      }
      break;

    case RELEASE_SEM:
      LL_HSEM_ReleaseLock( HSEM, SemId, 0 );
      break;

    default:
      break;
  }
#endif /* NVM_ADAPT */
  return(return_value);
}

/*************************************************************
 *
 * WRAP FUNCTIONS
 *
 *************************************************************/
