[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ble_if.c
  * @author  MCD Application Team
  * @brief   BLE Application
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2023 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "app_common.h"
#include "ble.h"
#include "skel_ble.h"
#include "ll_sys_if.h"
#include "stm_list.h"
#include "blestack.h"
#include "host_stack_if.h"
/* Private includes ----------------------------------------------------------*/

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/

/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private defines -----------------------------------------------------------*/
/* GATT buffer size (in bytes)*/
#define BLE_GATT_BUF_SIZE \
          BLE_TOTAL_BUFFER_SIZE_GATT(CFG_BLE_NUM_GATT_ATTRIBUTES, \
                                     CFG_BLE_NUM_GATT_SERVICES, \
                                     CFG_BLE_ATT_VALUE_ARRAY_SIZE)
     

#define BLE_DYN_ALLOC_SIZE \
        (BLE_TOTAL_BUFFER_SIZE(CFG_BLE_NUM_LINK, CFG_BLE_MBLOCK_COUNT))

          
/* Flag define */
#define APP_FLAG_BLE_HOST               1
#define APP_FLAG_HCI_ASYNCH_EVT_ID      2  
#define APP_FLAG_LINK_LAYER             3
/* USER CODE BEGIN Flag */
/* USER CODE END Flag */
#define APP_FLAG_GET(flag)                  VariableBit_Get_BB(((uint32_t)&APP_State), flag)
#define APP_FLAG_SET(flag)                  VariableBit_Set_BB(((uint32_t)&APP_State), flag)
#define APP_FLAG_RESET(flag)                VariableBit_Reset_BB(((uint32_t)&APP_State), flag)

#define CFG_BD_ADDRESS                    (0x0080E12A1234)

/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/

/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
static volatile uint32_t APP_State = 0x00000000;

static tListNode BleAsynchEventQueue;

static const uint8_t a_MBdAddr[BD_ADDR_SIZE] =
{
  (uint8_t)((CFG_BD_ADDRESS & 0x0000000000FF)),
  (uint8_t)((CFG_BD_ADDRESS & 0x00000000FF00) >> 8),
  (uint8_t)((CFG_BD_ADDRESS & 0x000000FF0000) >> 16),
  (uint8_t)((CFG_BD_ADDRESS & 0x0000FF000000) >> 24),
  (uint8_t)((CFG_BD_ADDRESS & 0x00FF00000000) >> 32),
  (uint8_t)((CFG_BD_ADDRESS & 0xFF0000000000) >> 40)
};


static const char a_GapDeviceName[] = {  'S', 'T', 'M', '3', '2', 'W', 'B', 'A' }; /* Gap Device Name */


/* Host stack init variables */
static uint32_t buffer[DIVC(BLE_DYN_ALLOC_SIZE, 4)];
static uint32_t gatt_buffer[DIVC(BLE_GATT_BUF_SIZE, 4)];
static BleStack_init_t pInitParams;

/* USER CODE BEGIN PV */
/* USER CODE END PV */

/* Global variables ----------------------------------------------------------*/

/* USER CODE BEGIN GV */

/* USER CODE END GV */

/* Private function prototypes -----------------------------------------------*/
static void BleStack_Process_BG(void);
static void Ble_UserEvtRx(void);
static void Ble_Hci_Gap_Gatt_Init(void);
static uint8_t  HOST_BLE_Init(void);

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* External variables --------------------------------------------------------*/

/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Functions Definition ------------------------------------------------------*/
void BLE_Init(void)
{
  /* USER CODE BEGIN APP_BLE_Init_1 */

  /* USER CODE END APP_BLE_Init_1 */

  LST_init_head(&BleAsynchEventQueue);
  
  /* USER CODE BEGIN APP_BLE_Init_2 */

  /* USER CODE END APP_BLE_Init_2 */

  /* Initialize the BLE Host */
  if (HOST_BLE_Init() == 0u)
  {
    /* Initialization of HCI & GATT & GAP layer */
    Ble_Hci_Gap_Gatt_Init();

    /* Initialization of the BLE Services */
    SVCCTL_Init();

    /* USER CODE BEGIN APP_BLE_Init_3 */

    /* USER CODE END APP_BLE_Init_3 */
  }  
  /* USER CODE BEGIN APP_BLE_Init_4 */

  /* USER CODE END APP_BLE_Init_4 */

  return;
}



SVCCTL_UserEvtFlowStatus_t SVCCTL_App_Notification(void *p_Pckt)
{
  hci_event_pckt    *p_event_pckt;
  evt_le_meta_event *p_meta_evt;

  p_event_pckt = (hci_event_pckt*) ((hci_uart_pckt *) p_Pckt)->data;
  
  /* USER CODE BEGIN SVCCTL_App_Notification */

  /* USER CODE END SVCCTL_App_Notification */

  switch (p_event_pckt->evt)
  {
    case HCI_DISCONNECTION_COMPLETE_EVT_CODE:
    {
      hci_disconnection_complete_event_rp0 *p_disconnection_complete_event;
      p_disconnection_complete_event = (hci_disconnection_complete_event_rp0 *) p_event_pckt->data;
      UNUSED(p_disconnection_complete_event);

      /* USER CODE BEGIN EVT_DISCONN_COMPLETE_1 */
      /* USER CODE END EVT_DISCONN_COMPLETE_1 */
      break; /* HCI_DISCONNECTION_COMPLETE_EVT_CODE */
    }

    case HCI_LE_META_EVT_CODE:
    {
      p_meta_evt = (evt_le_meta_event*) p_event_pckt->data;
      /* USER CODE BEGIN EVT_LE_META_EVENT */

      /* USER CODE END EVT_LE_META_EVENT */

      switch (p_meta_evt->subevent)
      {
        case HCI_LE_CONNECTION_COMPLETE_SUBEVT_CODE:
        {
          hci_le_connection_complete_event_rp0 *p_conn_complete;
          p_conn_complete = (hci_le_connection_complete_event_rp0 *) p_meta_evt->data;
          UNUSED(p_conn_complete);
          /* USER CODE BEGIN HCI_EVT_LE_CONN_COMPLETE */

          /* USER CODE END HCI_EVT_LE_CONN_COMPLETE */
          break; /* HCI_LE_CONNECTION_COMPLETE_SUBEVT_CODE */
        }
        /* USER CODE BEGIN SUBEVENT */

        /* USER CODE END SUBEVENT */
        default:
        {
          /* USER CODE BEGIN SUBEVENT_DEFAULT */

          /* USER CODE END SUBEVENT_DEFAULT */
          break;
        }
      }

      /* USER CODE BEGIN META_EVT */

      /* USER CODE END META_EVT */
      break; /* HCI_LE_META_EVT_CODE */
    }
    /* USER CODE BEGIN EVENT_PCKT */

    /* USER CODE END EVENT_PCKT */
    default:
    {
      /* USER CODE BEGIN EVENT_PCKT_DEFAULT*/

      /* USER CODE END EVENT_PCKT_DEFAULT*/
      break;
    }
  }
  /* USER CODE BEGIN SVCCTL_App_Notification_1 */

  /* USER CODE END SVCCTL_App_Notification_1 */

  return (SVCCTL_UserEvtFlowEnable);
}



/**
  * @brief  loop function calling process request.
  * @param  None
  * @retval None
  */
void BLE_Process(void){
  if (APP_FLAG_GET(APP_FLAG_LINK_LAYER) == 1){
    APP_FLAG_RESET(APP_FLAG_LINK_LAYER);
    ll_sys_bg_process();
  }
  
  if (APP_FLAG_GET(APP_FLAG_BLE_HOST) == 1)
  {
    APP_FLAG_RESET(APP_FLAG_BLE_HOST);
    BleStack_Process_BG();
  }
  
  if (APP_FLAG_GET(APP_FLAG_HCI_ASYNCH_EVT_ID) == 1)
  {
    APP_FLAG_RESET(APP_FLAG_HCI_ASYNCH_EVT_ID);
    Ble_UserEvtRx();
  }
  /* USER CODE BEGIN BLE_Process */

  /* USER CODE END BLE_Process */

}


/*************************************************************
 *
 * LOCAL FUNCTIONS
 *
 *************************************************************/
uint8_t HOST_BLE_Init(void)
{
  tBleStatus return_status = BLE_STATUS_FAILED;

  pInitParams.numAttrRecord           = CFG_BLE_NUM_GATT_ATTRIBUTES;
  pInitParams.numAttrServ             = CFG_BLE_NUM_GATT_SERVICES;
  pInitParams.attrValueArrSize        = CFG_BLE_ATT_VALUE_ARRAY_SIZE;
  pInitParams.prWriteListSize         = CFG_BLE_ATTR_PREPARE_WRITE_VALUE_SIZE;
  pInitParams.attMtu                  = CFG_BLE_ATT_MTU_MAX;
  pInitParams.max_coc_nbr             = CFG_BLE_COC_NBR_MAX;
  pInitParams.max_coc_mps             = CFG_BLE_COC_MPS_MAX;
  pInitParams.max_coc_initiator_nbr   = CFG_BLE_COC_INITIATOR_NBR_MAX;
  pInitParams.numOfLinks              = CFG_BLE_NUM_LINK;
  pInitParams.mblockCount             = CFG_BLE_MBLOCK_COUNT;
  pInitParams.bleStartRamAddress      = (uint8_t*)buffer;
  pInitParams.total_buffer_size       = BLE_DYN_ALLOC_SIZE;
  pInitParams.bleStartRamAddress_GATT = (uint8_t*)gatt_buffer;
  pInitParams.total_buffer_size_GATT  = BLE_GATT_BUF_SIZE;
  pInitParams.options                 = CFG_BLE_OPTIONS;
  pInitParams.debug                   = 0U;
/* USER CODE BEGIN HOST_BLE_Init_Params */

/* USER CODE END HOST_BLE_Init_Params */
  return_status = BleStack_Init(&pInitParams);
/* USER CODE BEGIN HOST_BLE_Init */

/* USER CODE END HOST_BLE_Init */
  return ((uint8_t)return_status);
}

static void Ble_Hci_Gap_Gatt_Init(void)
{
  uint8_t role;
  uint16_t gap_service_handle, gap_dev_name_char_handle, gap_appearance_char_handle;
  tBleStatus ret = BLE_STATUS_INVALID_PARAMS;

  /* USER CODE BEGIN Ble_Hci_Gap_Gatt_Init*/

  /* USER CODE END Ble_Hci_Gap_Gatt_Init*/


  ret = aci_hal_write_config_data(CONFIG_DATA_PUBADDR_OFFSET,
                                  CONFIG_DATA_PUBADDR_LEN,
                                  (uint8_t*) a_MBdAddr);
  if (ret != BLE_STATUS_SUCCESS)
  {
    Error_Handler();
  }



  /* Initialize GATT interface */
  ret = aci_gatt_init();
  if (ret != BLE_STATUS_SUCCESS)
  {
    Error_Handler();
  }


  /* Initialize GAP interface */
  role = 0x01;

  /* USER CODE BEGIN Role_Mngt*/

  /* USER CODE END Role_Mngt */

  if (role > 0)
  {
    ret = aci_gap_init(role,
                       PRIVACY_DISABLED,
                       sizeof(a_GapDeviceName),
                       &gap_service_handle,
                       &gap_dev_name_char_handle,
                       &gap_appearance_char_handle);

    if (ret != BLE_STATUS_SUCCESS)
    {
      Error_Handler();
    }
  }


  return;
}

/* USER CODE BEGIN FD_LOCAL_FUNCTION */

/* USER CODE END FD_LOCAL_FUNCTION */

/*************************************************************
 *
 * WRAP FUNCTIONS
 *
 *************************************************************/

static void Ble_UserEvtRx( void)
{
  SVCCTL_UserEvtFlowStatus_t svctl_return_status;
  BleEvtPacket_t *phcievt;

  LST_remove_head ( &BleAsynchEventQueue, (tListNode **)&phcievt );
  
  svctl_return_status = SVCCTL_UserEvtRx((void *)&(phcievt->evtserial));
  
  if (svctl_return_status != SVCCTL_UserEvtFlowDisable) 
  {
    free(phcievt);
  }
  else                                                                 
  {
    LST_insert_head ( &BleAsynchEventQueue, (tListNode *)phcievt );
  }
  
  if ((LST_is_empty(&BleAsynchEventQueue) == FALSE) && (svctl_return_status != SVCCTL_UserEvtFlowDisable) )
  {
    APP_FLAG_SET(APP_FLAG_HCI_ASYNCH_EVT_ID);
  }

  /* set the BG_BleStack_Process task for scheduling */
  BleStackCB_Process();
}


static void BleStack_Process_BG(void)
{
  if (BleStack_Process( ) == 0x0)
  {
    BleStackCB_Process( );
  }
}


tBleStatus BLECB_Indication( const uint8_t* data,
                          uint16_t length,
                          const uint8_t* ext_data,
                          uint16_t ext_length )
{
  uint8_t status = BLE_STATUS_FAILED;
  BleEvtPacket_t *phcievt;
  uint16_t total_length = (length+ext_length);

  UNUSED(ext_data);

  if (data[0] == HCI_EVENT_PKT_TYPE)
  {
    phcievt = malloc(sizeof(BleEvtPacketHeader_t) + total_length);    
    phcievt->evtserial.type = HCI_EVENT_PKT_TYPE;
    phcievt->evtserial.evt.evtcode = data[1];
    phcievt->evtserial.evt.plen  = data[2];
    memcpy( (void*)&phcievt->evtserial.evt.payload, &data[3], data[2]);
    LST_insert_tail(&BleAsynchEventQueue, (tListNode *)phcievt);
    
  
    APP_FLAG_SET(APP_FLAG_HCI_ASYNCH_EVT_ID);
    status = BLE_STATUS_SUCCESS;
  }
  else if (data[0] == HCI_ACLDATA_PKT_TYPE)
  {
    status = BLE_STATUS_SUCCESS;
  }
  return status;
}


/**
  * @brief  LL processing callback.
  * @param  None
  * @retval None
  */
void ll_process(void)
{
  APP_FLAG_SET(APP_FLAG_LINK_LAYER);
}

/* USER CODE BEGIN FD_WRAP_FUNCTIONS */

/* USER CODE END FD_WRAP_FUNCTIONS */

/*************************************************************
 *
 * HOST_STACK
 *
 *************************************************************/
/**
  * @brief  BLE Host stack processing callback.
  * @param  None
  * @retval None
  */
void Ble_HostStack_Process(void)
{
  APP_FLAG_SET(APP_FLAG_BLE_HOST);
}

/*************************************************************/

/* Link Layer debug API definition (Unused)*/
void LINKLAYER_DEBUG_SIGNAL_SET(void* signal)
{
  return;
}

void LINKLAYER_DEBUG_SIGNAL_RESET(void* signal)
{
  return;
}

void LINKLAYER_DEBUG_SIGNAL_TOGGLE(void* signal)
{
  return;
}

