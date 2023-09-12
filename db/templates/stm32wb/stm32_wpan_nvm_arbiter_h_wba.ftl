[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name?remove_beginning("System/Modules/NVM/")}
  * @author  MCD Application Team
  * @brief   Header for the NVM Arbiter module
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef NVMA_H
#define NVMA_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
/* Exported macros -----------------------------------------------------------*/
/**
 * The NVM Arbiter shall allocate a NVM storage that can hold  ( x + y ) data
 * The number of sectors required to store ( x + y ) data depends on several factors
 *      + The need to add a 32bits ID for a 32bits value ( 2x the real space of data required )
 *      + The need of a space to swap banks ( 2x the size from the calculation above)
 *      + The cycling of the flash - depending on how often the data are written in the NVM versus the maximum cycle supported by
 *        the flash ( 10K ) and the lifetime needed for the product ( 10 years ). - This needs additional flash sectors to round robin
 *        the write procedure in the flash
 * Whatever is the numbers of sectors required in the EEPROM emulator, the NVM arbiter will write data in the EEPROM emulator at an address
 * in the range of [ 0 : (x+y-1)]
 * The address translation between the input of the NVM arbiter to the input to the EEPROM emulator is done by the NVM arbiter
 * Currently, the translation could be:
 * BLE[0 : (x-1) ] -> EEPROM [ 0 : (x-1) ]
 * THREAD [ 0 : (y-1) ] -> EEPROM [ x : (x+y-1) ]
 *
 */

/* Exported types ------------------------------------------------------------*/

/* NVM Configuration */
typedef enum
{
  NVMA_NVM_IN_FLASH,
  NVMA_NVM_IN_SRAM,
} NVMA_Nvm_Location_Config_t;

/* DataBase Ids */
typedef enum
{
  NVMA_DB_ID_BLE,             /** BLE Database ID */
  NVMA_DB_ID_THREAD,          /** THREAD Database ID */
  NVMA_NUMBER_OF_DATABASE,    /** Shall be last - Number of database listed in the enum */
} NVMA_DbId_t;

/* NVMA process status */
typedef enum
{
  NVMA_RELEASED,      /** The NVM Arbiter has been released and may receive a new write command */
  NVMA_DATA_WRITTEN,  /** The data have been written in NVM */
} NVMA_Activity_Status_t;

/* NVMA command status */
typedef enum
{
  NVMA_CMD_OK,              /** The NVM Arbiter was free and the write in NVM will be processed */
  NVMA_CMD_BUSY,            /** The NVM Arbiter was busy. The callback has been registered and will be called when the Arbiter gets free */
} NVMA_Cmd_Status_t;

typedef void (*NVMA_ActivityStatusCb_t)( NVMA_Activity_Status_t Status );

typedef struct{
  uint32_t            *src;                   /**< Start address of the data to be written in the NVM
                                                     The source shall be 32bits aligned */
  uint32_t            offset_dest;            /**< Offset from 0 in the NVM
                                                     This is a number of 32bits - offset 1 means the second 32bits value */
  uint32_t            size;                   /**< Size of data to be written
                                                     This is a number of 32bits values - size 2 means 8 bytes shall be written  */
  NVMA_ActivityStatusCb_t arbiter_status_cb;  /**< Callback to notify the user that either the NVM Arbiter has been freed or
                                                     the data have been written in NVM
                                                     The status parameter is used to distinguish the two cases */
  NVMA_DbId_t         DbId;                   /**< Identifier of the user that needs to store data in NVM */
} NVMA_Write_Parameter_t;


/* Exported functions ------------------------------------------------------- */

/*
 * NVMA_Init
 *
 * @param  None
 *
 * @retval None
 *
 */
void NVMA_Init(void);

/*
 * NVMA_SetNvmConfig
 *
 * @param  BleConfig : Location of the BLE NVM
 * @param  ThreadConfig : Location of the THREAD NVM
 * @param  BleNvmRamAddress : Address of the external SRAM to be used for BLE
 * @param  ThreadNvmRamAddress : Address of the external SRAM to be used for OT
 *
 * @retval None
 *
 */
void NVMA_SetNvmConfig(NVMA_Nvm_Location_Config_t BleConfig, NVMA_Nvm_Location_Config_t ThreadConfig, uint32_t BleNvmRamAddress, uint32_t ThreadNvmRamAddress);

/*
 * NVMA_Write
 *
 * @param  p_WriteParameter : Address of the function parameters
 *
 * @retval NVMA_Command_Status_t : return whereas the command has been processed successfully or not because the Arbiter is already busy
 *
 */
NVMA_Cmd_Status_t NVMA_Write( NVMA_Write_Parameter_t  *p_WriteParameter );

/*
 * NVMA_Read
 *
 * @param  DbId :       Identifier of the user that needs to read data from NVM
 * @param  OffsetSrc :  The offset from 0 of the NVM to be read - This is a number of 32bits value
 *                      OffsetSrc = 1 means the second 32bits value shall be read
 * @param  Dest :       Start address of the area where the NVM Arbiter shall write the data read from NVM
 *                      The destination shall be 32bits aligned
 * @param  Size :       Size of data to be read ( number of 32bits value to read )
 *
 * @retval None
 *
 */
void NVMA_Read( NVMA_DbId_t DbId, uint32_t OffsetSrc, uint32_t * Dest, uint32_t Size );

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* NVMA_H */
