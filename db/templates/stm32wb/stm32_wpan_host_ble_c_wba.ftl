[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    host_ble.c
  * @author  MCD Application Team
  * @brief   ${name?remove_beginning("App/")?remove_ending(".c")} definition.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "stm32_wpan_common.h"
#include "stm32wbaxx.h"
#include "host_ble.h"
#include "ble.h"
#include "app_conf.h"
#include "stm32_seq.h"
#include "blestack.h"
#include "ble_types.h"
/* Private typedef -----------------------------------------------------------*/
/* Private defines -----------------------------------------------------------*/
/*****************************************************************************/

/* GATT buffer size (in bytes) */
#define BLE_GATT_BUF_SIZE \
          BLE_TOTAL_BUFFER_SIZE_GATT(CFG_BLE_NUM_GATT_ATTRIBUTES, \
                                     CFG_BLE_NUM_GATT_SERVICES, \
                                     CFG_BLE_ATT_VALUE_ARRAY_SIZE)

/*****************************************************************************/


#define MBLOCK_COUNT              (BLE_MBLOCKS_CALC(PREP_WRITE_LIST_SIZE, \
                                                    CFG_BLE_MAX_ATT_MTU, \
                                                    CFG_BLE_NUM_LINK) \
                                   + CFG_BLE_MBLOCK_COUNT_MARGIN)

#define BLE_DYN_ALLOC_SIZE \
        (BLE_TOTAL_BUFFER_SIZE(CFG_BLE_NUM_LINK, MBLOCK_COUNT))
/* Private macros ------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
static uint32_t buffer[BLE_DYN_ALLOC_SIZE];
static uint32_t gatt_buffer[BLE_GATT_BUF_SIZE];
static BleStack_init_t pInitParams;

/* Global variables ----------------------------------------------------------*/


/* Private function prototypes -----------------------------------------------*/

/* External function prototypes -----------------------------------------------*/

/* Functions Definition ------------------------------------------------------*/

/*************************************************************
 *
 * PUBLIC FUNCTIONS
 *
 *************************************************************/


uint8_t HOST_BLE_Init(void)
{
  tBleStatus return_status = 0; /* i.e. BLE_STATUS_SUCCESS in BLE Stack Lib */

  pInitParams.numAttrRecord = CFG_BLE_NUM_GATT_ATTRIBUTES;
  pInitParams.numAttrServ = CFG_BLE_NUM_GATT_SERVICES;
  pInitParams.attrValueArrSize = CFG_BLE_ATT_VALUE_ARRAY_SIZE;
  pInitParams.prWriteListSize = CFG_BLE_ATTR_PREPARE_WRITE_VALUE_SIZE;
  pInitParams.attMtu = CFG_BLE_MAX_ATT_MTU;
  pInitParams.max_coc_nbr = CFG_BLE_MAX_COC_NUMBER;
  pInitParams.max_coc_initiator_nbr = CFG_BLE_MAX_COC_INITIATOR_NBR;
  pInitParams.numOfLinks = CFG_BLE_NUM_LINK;
  pInitParams.mblockCount = CFG_BLE_MBLOCK_COUNT;
  pInitParams.bleStartRamAddress = (uint8_t*)buffer;
  pInitParams.total_buffer_size = BLE_DYN_ALLOC_SIZE;
  pInitParams.bleStartRamAddress_GATT = (uint8_t*)gatt_buffer;
  pInitParams.total_buffer_size_GATT = BLE_GATT_BUF_SIZE;
  pInitParams.debug = 0x10;/*static random address generation*/
  pInitParams.options = 0x0;
  BleStack_Init(&pInitParams);

  return ((uint8_t)return_status);
}
