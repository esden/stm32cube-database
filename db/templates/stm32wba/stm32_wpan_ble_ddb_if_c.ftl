[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ddb_if.c
  * @author  MCD Application Team
  * @brief   routines for database storage service needed by the BLE Host Stack
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include "app_conf.h"
#include "ble_ddb_if.h"
#include "nvm_arbiter.h" 
#include "stm32_wpan_common.h"
#include "compiler.h"    

/* Private typedef -----------------------------------------------------------*/
typedef enum
{
  BLE_NVM_WRITE_NOT_REQUESTED,
  BLE_NVM_WRITE_REQUESTED,
} BLE_NwmWriteReqStatus_t;

/* Private defines -----------------------------------------------------------*/

/*
 * size in 32 bits of the BLE Database
 */ 
#define CFG_BLE_DDB_MAX_SIZE                ((CFG_BLE_MAX_DDB_ENTRIES * DEVICE_SLOT_SIZE)/4u)
/* Private macros ------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
static NVMA_Write_Parameter_t  NvmaWriteParameter;
static NVMA_Cmd_Status_t BLE_NvmaCmdStatus;  
/* 
 * RAM reserved to store all the BLE database information
 */
static uint32_t ble_database[CFG_BLE_DDB_MAX_SIZE];

/* Private functions prototypes-----------------------------------------------*/
static void nvm_init(void);
static void BLE_NvmaReportCb( NVMA_Activity_Status_t Status );
static uint32_t* ble_ddb_get_start_addr( void);
/* Functions Definition ------------------------------------------------------*/

/*
 * ble_ddb_read
 * This function is called by the ble host to get ble database.
 * This operation consists to read the data from the Non-Volatile Memory
 * in which the BLE database is saved and provide the pointer on the 
 * reserved data buffer.
 * 
 * @param  pBleDatabase : return pointer on buffer allocated to store
 *                        temporarily the ble database in RAM
 *
 * @retval None
 *
 */
void ble_ddb_read(uint32_t **pBleDatabase){
  
  /* Initialize the NVM module*/
  nvm_init();
  
  *pBleDatabase = (uint32_t *)ble_database;
  
  /*read data store in persistent memory*/
  NVMA_Read( NVMA_DB_ID_BLE, 0, (uint32_t *)ble_database, CFG_BLE_DDB_MAX_SIZE );
 
}

/*
 * ble_ddb_write
 * This function is called by the ble host to indicate the the Non-Volatile
 * Memory IP that data should be saved in persistent memory.
 * 
 * @param  src : memory address of buffer to store in persistent memory
 * @param  Size : number of byte to write
 *      
 * @retval None
 *
 */
void ble_ddb_write(const uint32_t *Src,uint32_t Size)
{
  uint32_t new_start_offset, previous_start_offset;
  uint32_t new_end_offset, previous_end_offset;

  new_start_offset = ((uint32_t)(Src) - (uint32_t)ble_ddb_get_start_addr()) >> 2;
  new_end_offset = new_start_offset + Size;

  if(BLE_NvmaCmdStatus != NVMA_CMD_OK)
  {
    previous_start_offset = NvmaWriteParameter.offset_dest;
    previous_end_offset = previous_start_offset + NvmaWriteParameter.size;

    if(new_start_offset  <  previous_start_offset)
    {
      NvmaWriteParameter.offset_dest = new_start_offset;
    }

    if(new_end_offset  >  previous_end_offset)
    {
      NvmaWriteParameter.size = new_end_offset - NvmaWriteParameter.offset_dest;
    }
    else
    {
      NvmaWriteParameter.size = previous_end_offset - NvmaWriteParameter.offset_dest;
    }
  }
  else
  {
    NvmaWriteParameter.offset_dest = new_start_offset;
    NvmaWriteParameter.size = new_end_offset - NvmaWriteParameter.offset_dest;
  }

  NvmaWriteParameter.src = (uint32_t *)ble_ddb_get_start_addr() + NvmaWriteParameter.offset_dest;

  BLE_NvmaCmdStatus = NVMA_Write( &NvmaWriteParameter );

  return;
}

static void nvm_init(void){
  
  NvmaWriteParameter.arbiter_status_cb = BLE_NvmaReportCb;
  NvmaWriteParameter.DbId = NVMA_DB_ID_BLE;
  BLE_NvmaCmdStatus = NVMA_CMD_OK;
}

static void BLE_NvmaReportCb( NVMA_Activity_Status_t Status )
{

  if (BLE_NvmaCmdStatus != NVMA_CMD_OK)
  {
    /**
     * The NVM arbiter was busy because either
     *    - another protocol stack was using it (Status reported is NVMA_RELEASED)
     *    - BLE Data were being written when new BLE  have been requested (Status reported is NVMA_DATA_WRITTEN)
     * Try again to write the data
     */
    BLE_NvmaCmdStatus = NVMA_Write( &NvmaWriteParameter );
  }

  return;
}

/*
 * ble_ddb_get_start_addr
 * This function is called by application layer to get the start address of the memory 
 * from which the database is allocated in RAM by the Host.
 *
 * @retval Start address of the area used o store database in the Host
 *
 */
static uint32_t* ble_ddb_get_start_addr( void){
  
  return &ble_database[0];
}
