[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    gatt_client_app.c
  * @author  MCD Application Team
  * @brief   GATT Client Application
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2024 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign myHash = {}]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#assign myHash = {definition.name:definition.value} + myHash]
        [/#list]
    [/#if]
[/#list]
[#--
Key & Value:
[#list myHash?keys as key]
Key: ${key}; Value: ${myHash[key]}
[/#list]
--]

/* Includes ------------------------------------------------------------------*/

#include "main.h"
#include "app_common.h"
#include "ble.h"
#include "gatt_client_app.h"
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
#include "stm32_seq.h"
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

[/#if]
#include "app_ble.h"
#include "ble_evt.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/

/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

typedef enum
{
  NOTIFICATION_INFO_RECEIVED_EVT,
  /* USER CODE BEGIN GATT_CLIENT_APP_Opcode_t */

  /* USER CODE END GATT_CLIENT_APP_Opcode_t */
}GATT_CLIENT_APP_Opcode_t;

typedef struct
{
  uint8_t *p_Payload;
  uint8_t length;
}GATT_CLIENT_APP_Data_t;

typedef struct
{
  GATT_CLIENT_APP_Opcode_t Client_Evt_Opcode;
  GATT_CLIENT_APP_Data_t   DataTransfered;
}GATT_CLIENT_APP_Notification_evt_t;

typedef struct
{
  GATT_CLIENT_APP_State_t state;

  APP_BLE_ConnStatus_t connStatus;
  uint16_t connHdl;

  uint16_t ALLServiceStartHdl;
  uint16_t ALLServiceEndHdl;

  uint16_t GAPServiceStartHdl;
  uint16_t GAPServiceEndHdl;

  uint16_t GATTServiceStartHdl;
  uint16_t GATTServiceEndHdl;

  uint16_t ServiceChangedCharStartHdl;
  uint16_t ServiceChangedCharValueHdl;
  uint16_t ServiceChangedCharDescHdl;
  uint16_t ServiceChangedCharEndHdl;

  /* USER CODE BEGIN BleClientAppContext_t */

/* USER CODE END BleClientAppContext_t */

}BleClientAppContext_t;

/* Private defines ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macros -------------------------------------------------------------*/
#define UNPACK_2_BYTE_PARAMETER(ptr)  \
        (uint16_t)((uint16_t)(*((uint8_t *)ptr))) |   \
        (uint16_t)((((uint16_t)(*((uint8_t *)ptr + 1))) << 8))
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
static BleClientAppContext_t a_ClientContext[BLE_CFG_MAX_NBR_GATT_EVT_HANDLERS];
[#else]
static BleClientAppContext_t a_ClientContext[GATT_CLT_MAX_NUM_SERVERS];
[/#if]
static uint16_t gattCharStartHdl = 0;
static uint16_t gattCharValueHdl = 0;

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Global variables ----------------------------------------------------------*/

/* USER CODE BEGIN GV */

/* USER CODE END GV */

/* Private function prototypes -----------------------------------------------*/

[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
static BLEEVT_EvtAckStatus_t P2P_CLIENT_EventHandler(aci_blecore_event *p_evt);
[#else]
static BLEEVT_EvtAckStatus_t P2P_ROUTER_EventHandler(aci_blecore_event *p_evt);
[/#if]
static void gatt_parse_services(aci_att_clt_read_by_group_type_resp_event_rp0 *p_evt);
static void gatt_parse_services_by_UUID(aci_att_clt_find_by_type_value_resp_event_rp0 *p_evt);
static void gatt_parse_chars(aci_att_clt_read_by_type_resp_event_rp0 *p_evt);
static void gatt_parse_descs(aci_att_clt_find_info_resp_event_rp0 *p_evt);
static void gatt_parse_notification(aci_gatt_clt_notification_event_rp0 *p_evt);
static void gatt_Notification(GATT_CLIENT_APP_Notification_evt_t *p_Notif);
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
static void client_discover_all(void);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
static void client_discover_all_Entry(unsigned long thread_input);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
static void ClientDiscover_Task_Entry(void* argument);
[/#if]
static void gatt_cmd_resp_release(void);
static void gatt_cmd_resp_wait(void);
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Functions Definition ------------------------------------------------------*/
/**
 * @brief  Service initialization
 * @param  None
 * @retval None
 */
void GATT_CLIENT_APP_Init(void)
{
  uint8_t index =0;
[#if (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled")]
  int ret;

[/#if]
  /* USER CODE BEGIN GATT_CLIENT_APP_Init_1 */

  /* USER CODE END GATT_CLIENT_APP_Init_1 */
  
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
  for(index = 0; index < BLE_CFG_MAX_NBR_GATT_EVT_HANDLERS; index++)
[#else]
  for(index = 0; index < GATT_CLT_MAX_NUM_SERVERS; index++)
[/#if]
  {
    a_ClientContext[index].connStatus = APP_BLE_IDLE;
  }

  /**
   *  Register the event handler to the BLE controller
   */
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
  BLEEVT_RegisterGattEvtHandler(P2P_CLIENT_EventHandler);

[#else]
  ret = BLEEVT_RegisterGattEvtHandler(P2P_ROUTER_EventHandler);
  if (ret != 0)  
  {
    Error_Handler();
  }
[/#if]
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  /* Register a task allowing to discover all services and characteristics and enable all notifications */
  UTIL_SEQ_RegTask(1U << CFG_TASK_DISCOVER_SERVICES_ID, UTIL_SEQ_RFU, client_discover_all);
[/#if]

  /* USER CODE BEGIN GATT_CLIENT_APP_Init_2 */

  /* USER CODE END GATT_CLIENT_APP_Init_2 */
  return;
}

void GATT_CLIENT_APP_Notification(GATT_CLIENT_APP_ConnHandle_Notif_evt_t *p_Notif)
{
  /* USER CODE BEGIN GATT_CLIENT_APP_Notification_1 */

  /* USER CODE END GATT_CLIENT_APP_Notification_1 */
  switch(p_Notif->ConnOpcode)
  {
    /* USER CODE BEGIN ConnOpcode */

    /* USER CODE END ConnOpcode */

    case PEER_CONN_HANDLE_EVT :
      /* USER CODE BEGIN PEER_CONN_HANDLE_EVT */

      /* USER CODE END PEER_CONN_HANDLE_EVT */
      break;

    case PEER_DISCON_HANDLE_EVT :
      /* USER CODE BEGIN PEER_DISCON_HANDLE_EVT */

      /* USER CODE END PEER_DISCON_HANDLE_EVT */
      break;

    default:
      /* USER CODE BEGIN ConnOpcode_Default */

      /* USER CODE END ConnOpcode_Default */
      break;
  }
  /* USER CODE BEGIN GATT_CLIENT_APP_Notification_2 */

  /* USER CODE END GATT_CLIENT_APP_Notification_2 */
  return;
}

uint8_t GATT_CLIENT_APP_Set_Conn_Handle(uint8_t index, uint16_t connHdl)
{
  uint8_t ret;

[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
  if (index < BLE_CFG_MAX_NBR_GATT_EVT_HANDLERS)
[#else]
  if (index < GATT_CLT_MAX_NUM_SERVERS)
[/#if]
  {
    a_ClientContext[index].connHdl = connHdl;
    ret = 0;
  }
  else
  {
    ret = 1;
  }

  return ret;
}

uint8_t GATT_CLIENT_APP_Get_State(uint8_t index)
{
  return a_ClientContext[index].state;
}

void GATT_CLIENT_APP_Discover_services(uint8_t index)
{
  GATT_CLIENT_APP_Procedure_Gatt(index, PROC_GATT_DISC_ALL_PRIMARY_SERVICES);
  GATT_CLIENT_APP_Procedure_Gatt(index, PROC_GATT_DISC_ALL_CHARS);
  GATT_CLIENT_APP_Procedure_Gatt(index, PROC_GATT_DISC_ALL_DESCS);
  GATT_CLIENT_APP_Procedure_Gatt(index, PROC_GATT_ENABLE_ALL_NOTIFICATIONS);

  return;
}

uint8_t GATT_CLIENT_APP_Procedure_Gatt(uint8_t index, ProcGattId_t GattProcId)
{
  tBleStatus result = BLE_STATUS_SUCCESS;
  uint8_t status;

[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
  if (index >= BLE_CFG_MAX_NBR_GATT_EVT_HANDLERS)
[#else]
  if (index >= GATT_CLT_MAX_NUM_SERVERS)
[/#if]
  {
    status = 1;
  }
  else
  {
    status = 0;
    switch (GattProcId)
    {
      case PROC_GATT_DISC_ALL_PRIMARY_SERVICES:
      {
        a_ClientContext[index].state = GATT_CLIENT_APP_DISCOVER_SERVICES;

        APP_DBG_MSG("GATT services discovery\n");
        result = aci_gatt_clt_disc_all_primary_services(a_ClientContext[index].connHdl, BLE_GATT_UNENHANCED_ATT_L2CAP_CID);

        if (result == BLE_STATUS_SUCCESS)
        {
          gatt_cmd_resp_wait();
          APP_DBG_MSG("PROC_GATT_CTL_DISC_ALL_PRIMARY_SERVICES services discovered Successfully\n\n");
        }
        else
        {
          APP_DBG_MSG("PROC_GATT_CTL_DISC_ALL_PRIMARY_SERVICES aci_gatt_clt_disc_all_primary_services cmd NOK status =0x%02X\n\n", result);
        }
      }

      break; /* PROC_GATT_DISC_ALL_PRIMARY_SERVICES */

      case PROC_GATT_DISC_ALL_CHARS:
      {
        a_ClientContext[index].state = GATT_CLIENT_APP_DISCOVER_CHARACS;

        APP_DBG_MSG("DISCOVER_ALL_CHARS ConnHdl=0x%04X ALLServiceHandle[0x%04X - 0x%04X]\n",
                          a_ClientContext[index].connHdl,
                          a_ClientContext[index].ALLServiceStartHdl,
                          a_ClientContext[index].ALLServiceEndHdl);
        result = aci_gatt_clt_disc_all_char_of_service(
                           a_ClientContext[index].connHdl,
                           BLE_GATT_UNENHANCED_ATT_L2CAP_CID,
                           a_ClientContext[index].ALLServiceStartHdl,
                           a_ClientContext[index].ALLServiceEndHdl);
        if (result == BLE_STATUS_SUCCESS)
        {
          gatt_cmd_resp_wait();
          APP_DBG_MSG("All characteristics discovered Successfully\n\n");
        }
        else
        {
          APP_DBG_MSG("All characteristics discovery Failed, status =0x%02X\n\n", result);
        }
      }
      break; /* PROC_GATT_DISC_ALL_CHARS */

      case PROC_GATT_DISC_ALL_DESCS:
      {
        a_ClientContext[index].state = GATT_CLIENT_APP_DISCOVER_WRITE_DESC;

        APP_DBG_MSG("DISCOVER_ALL_CHAR_DESCS [0x%04X - 0x%04X]\n",
                         a_ClientContext[index].ALLServiceStartHdl,
                         a_ClientContext[index].ALLServiceEndHdl);
        result = aci_gatt_clt_disc_all_char_desc(
                           a_ClientContext[index].connHdl,
						   BLE_GATT_UNENHANCED_ATT_L2CAP_CID,
                           a_ClientContext[index].ALLServiceStartHdl,
                           a_ClientContext[index].ALLServiceEndHdl);
        if (result == BLE_STATUS_SUCCESS)
        {
          gatt_cmd_resp_wait();
          APP_DBG_MSG("All characteristic descriptors discovered Successfully\n\n");
        }
        else
        {
          APP_DBG_MSG("All characteristic descriptors discovery Failed, status =0x%02X\n\n", result);
        }
      }
      break; /* PROC_GATT_DISC_ALL_DESCS */
      case PROC_GATT_ENABLE_ALL_NOTIFICATIONS:
      {
        uint16_t enable = 0x0001; /* Buffer must be kept valid for aci_gatt_clt_write until a gatt procedure complete is received. */

        if (a_ClientContext[index].ServiceChangedCharDescHdl != 0x0000)
        {
          result = aci_gatt_clt_write(a_ClientContext[index].connHdl,
                                      BLE_GATT_UNENHANCED_ATT_L2CAP_CID,
                                      a_ClientContext[index].ServiceChangedCharDescHdl,
                                      2,
                                      (uint8_t *) &enable);
          gatt_cmd_resp_wait();
          APP_DBG_MSG(" ServiceChangedCharDescHdl =0x%04X\n",a_ClientContext[index].ServiceChangedCharDescHdl);
        }
        /* USER CODE BEGIN PROC_GATT_ENABLE_ALL_NOTIFICATIONS */

        /* USER CODE END PROC_GATT_ENABLE_ALL_NOTIFICATIONS */

        if (result == BLE_STATUS_SUCCESS)
        {
          APP_DBG_MSG("All notifications enabled Successfully\n\n");
        }
        else
        {
          APP_DBG_MSG("All notifications enabled Failed, status =0x%02X\n\n", result);
        }
      }
      break; /* PROC_GATT_ENABLE_ALL_NOTIFICATIONS */
    default:
      break;
    }
  }

  return status;
}


/* USER CODE BEGIN FD */

/* USER CODE END FD */

/*************************************************************
 *
 * LOCAL FUNCTIONS
 *
 *************************************************************/

/**
 * @brief  Event handler
 * @param  Event: Address of the buffer holding the Event
 * @retval Ack: Return whether the Event has been managed or not
 */
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
static BLEEVT_EvtAckStatus_t P2P_CLIENT_EventHandler(aci_blecore_event *p_evt)
[#else]
static BLEEVT_EvtAckStatus_t P2P_ROUTER_EventHandler(aci_blecore_event *p_evt)
[/#if]
{
  BLEEVT_EvtAckStatus_t return_value = BLEEVT_NoAck;
  GATT_CLIENT_APP_Notification_evt_t Notification;
  UNUSED(Notification);

  return_value = BLEEVT_NoAck;


  switch (p_evt->ecode)
  {
    case ACI_ATT_CLT_READ_BY_GROUP_TYPE_RESP_VSEVT_CODE:
    {
      aci_att_clt_read_by_group_type_resp_event_rp0 *p_evt_rsp = (void*)p_evt->data;
      gatt_parse_services((aci_att_clt_read_by_group_type_resp_event_rp0 *)p_evt_rsp);
    }
    break; /* ACI_ATT_READ_BY_GROUP_TYPE_RESP_VSEVT_CODE */
  case ACI_ATT_CLT_FIND_BY_TYPE_VALUE_RESP_VSEVT_CODE:
    {
      aci_att_clt_find_by_type_value_resp_event_rp0 *p_evt_rsp = (void*) p_evt->data;
      gatt_parse_services_by_UUID((aci_att_clt_find_by_type_value_resp_event_rp0 *)p_evt_rsp);
    }
    break; /* ACI_ATT_FIND_BY_TYPE_VALUE_RESP_VSEVT_CODE */
    case ACI_ATT_CLT_READ_BY_TYPE_RESP_VSEVT_CODE:
    {
      aci_att_clt_read_by_type_resp_event_rp0 *p_evt_rsp = (void*)p_evt->data;
      gatt_parse_chars((aci_att_clt_read_by_type_resp_event_rp0 *)p_evt_rsp);
    }
    break; /* ACI_ATT_READ_BY_TYPE_RESP_VSEVT_CODE */
    case ACI_ATT_CLT_FIND_INFO_RESP_VSEVT_CODE:
    {
      aci_att_clt_find_info_resp_event_rp0 *p_evt_rsp = (void*)p_evt->data;
      gatt_parse_descs((aci_att_clt_find_info_resp_event_rp0 *)p_evt_rsp);
    }
    break; /* ACI_ATT_FIND_INFO_RESP_VSEVT_CODE */
    case ACI_GATT_CLT_NOTIFICATION_VSEVT_CODE:
    {
      aci_gatt_clt_notification_event_rp0 *p_evt_rsp = (void*)p_evt->data;
      gatt_parse_notification((aci_gatt_clt_notification_event_rp0 *)p_evt_rsp);
    }
    break;/* ACI_GATT_NOTIFICATION_VSEVT_CODE */
    case ACI_GATT_CLT_PROC_COMPLETE_VSEVT_CODE:
    {
      aci_gatt_clt_proc_complete_event_rp0 *p_evt_rsp = (void*)p_evt->data;

      uint8_t index;
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
      for (index = 0 ; index < BLE_CFG_MAX_NBR_GATT_EVT_HANDLERS ; index++)
[#else]
      for (index = 0 ; index < GATT_CLT_MAX_NUM_SERVERS ; index++)
[/#if]
      {
        if (a_ClientContext[index].connHdl == p_evt_rsp->Connection_Handle)
        {
          break;
        }
      }

      if (a_ClientContext[index].connHdl == p_evt_rsp->Connection_Handle)
      {
        gatt_cmd_resp_release();
      }
    }
    break;/* ACI_GATT_PROC_COMPLETE_VSEVT_CODE */
    case ACI_GATT_TX_POOL_AVAILABLE_VSEVT_CODE:
    {
    aci_att_exchange_mtu_resp_event_rp0 *tx_pool_available;
    tx_pool_available = (aci_att_exchange_mtu_resp_event_rp0 *)p_evt->data;
    UNUSED(tx_pool_available);
    /* USER CODE BEGIN ACI_GATT_TX_POOL_AVAILABLE_VSEVT_CODE */

    /* USER CODE END ACI_GATT_TX_POOL_AVAILABLE_VSEVT_CODE */
    }
    break;/* ACI_GATT_TX_POOL_AVAILABLE_VSEVT_CODE*/
    case ACI_ATT_EXCHANGE_MTU_RESP_VSEVT_CODE:
    {
    aci_att_exchange_mtu_resp_event_rp0 * exchange_mtu_resp;
    exchange_mtu_resp = (aci_att_exchange_mtu_resp_event_rp0 *)p_evt->data;
    APP_DBG_MSG("  MTU exchanged size = %d\n",exchange_mtu_resp->MTU );
    UNUSED(exchange_mtu_resp);
    /* USER CODE BEGIN ACI_ATT_EXCHANGE_MTU_RESP_VSEVT_CODE */

    /* USER CODE END ACI_ATT_EXCHANGE_MTU_RESP_VSEVT_CODE */
    }
    break;
    /* USER CODE BEGIN BLECORE_EVT */

    /* USER CODE END BLECORE_EVT */
    default:
[#if (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled")]
      APP_DBG_MSG("EVENT OPCODE: 0x%04X\n", p_evt->ecode);
[/#if]
      break;
  }/* end switch (p_evt->ecode) */

  return(return_value);
}

__USED static void gatt_Notification(GATT_CLIENT_APP_Notification_evt_t *p_Notif)
{
  /* USER CODE BEGIN gatt_Notification_1*/

  /* USER CODE END gatt_Notification_1 */
  switch (p_Notif->Client_Evt_Opcode)
  { 
    /* USER CODE BEGIN Client_Evt_Opcode */

    /* USER CODE END Client_Evt_Opcode */

    case NOTIFICATION_INFO_RECEIVED_EVT:
      /* USER CODE BEGIN NOTIFICATION_INFO_RECEIVED_EVT */

      /* USER CODE END NOTIFICATION_INFO_RECEIVED_EVT */
      break;

    default:
      /* USER CODE BEGIN Client_Evt_Opcode_Default */

      /* USER CODE END Client_Evt_Opcode_Default */
      break;
  }
  /* USER CODE BEGIN gatt_Notification_2*/

  /* USER CODE END gatt_Notification_2 */
  return;
}

/**
* function of GATT service parse
*/
static void gatt_parse_services(aci_att_clt_read_by_group_type_resp_event_rp0 *p_evt)
{
  uint16_t uuid, ServiceStartHdl, ServiceEndHdl;
  uint8_t uuid_offset, uuid_size, uuid_short_offset;
  uint8_t i, idx, numServ, index;

  APP_DBG_MSG("ACI_ATT_READ_BY_GROUP_TYPE_RESP_VSEVT_CODE - ConnHdl=0x%04X\n",
                p_evt->Connection_Handle);

[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
  for (index = 0 ; index < BLE_CFG_MAX_NBR_GATT_EVT_HANDLERS ; index++)
[#else]
  for (index = 0 ; index < GATT_CLT_MAX_NUM_SERVERS ; index++)
[/#if]
  {
    if (a_ClientContext[index].connHdl == p_evt->Connection_Handle)
    {
      break;
    }
  }

  /* check connection handle related to response before processing */
  if (a_ClientContext[index].connHdl == p_evt->Connection_Handle)
  {
    /* Number of attribute value tuples */
    numServ = (p_evt->Data_Length) / p_evt->Attribute_Data_Length;

    /* event data in Attribute_Data_List contains:
    * 2 bytes for start handle
    * 2 bytes for end handle
    * 2 or 16 bytes data for UUID
    */
    if (p_evt->Attribute_Data_Length == 20) /* we are interested in the UUID is 128 bit.*/
    {
      idx = 16;                /*UUID index of 2 bytes read part in Attribute_Data_List */
      uuid_offset = 4;         /*UUID offset in bytes in Attribute_Data_List */
      uuid_size = 16;          /*UUID size in bytes */
      uuid_short_offset = 12;  /*UUID offset of 2 bytes read part in UUID field*/
    }
    if (p_evt->Attribute_Data_Length == 6) /* we are interested in the UUID is 16 bit.*/
    {
      idx = 4;
      uuid_offset = 4;
      uuid_size = 2;
      uuid_short_offset = 0;
    }
    UNUSED(idx);
    UNUSED(uuid_size);

    /* Loop on number of attribute value tuples */
    for (i = 0; i < numServ; i++)
    {
      ServiceStartHdl =  UNPACK_2_BYTE_PARAMETER(&p_evt->Attribute_Data_List[uuid_offset - 4]);
      ServiceEndHdl = UNPACK_2_BYTE_PARAMETER(&p_evt->Attribute_Data_List[uuid_offset - 2]);
      uuid = UNPACK_2_BYTE_PARAMETER(&p_evt->Attribute_Data_List[uuid_offset + uuid_short_offset]);
      APP_DBG_MSG("  %d/%d short UUID=0x%04X, handle [0x%04X - 0x%04X]",
                   i + 1, numServ, uuid, ServiceStartHdl,ServiceEndHdl);

      /* complete context fields */
      if ( (a_ClientContext[index].ALLServiceStartHdl == 0x0000) || (ServiceStartHdl < a_ClientContext[index].ALLServiceStartHdl) )
      {
        a_ClientContext[index].ALLServiceStartHdl = ServiceStartHdl;
      }
      if ( (a_ClientContext[index].ALLServiceEndHdl == 0x0000) || (ServiceEndHdl > a_ClientContext[index].ALLServiceEndHdl) )
      {
        a_ClientContext[index].ALLServiceEndHdl = ServiceEndHdl;
      }

      if (uuid == GAP_SERVICE_UUID)
      {
        a_ClientContext[index].GAPServiceStartHdl = ServiceStartHdl;
        a_ClientContext[index].GAPServiceEndHdl = ServiceEndHdl;

        APP_DBG_MSG(", GAP_SERVICE_UUID found\n");
      }
      else if (uuid == GATT_SERVICE_UUID)
      {
        a_ClientContext[index].GATTServiceStartHdl = ServiceStartHdl;
        a_ClientContext[index].GATTServiceEndHdl = ServiceEndHdl;

        APP_DBG_MSG(", GENERIC_ATTRIBUTE_SERVICE_UUID found\n");
      }
/* USER CODE BEGIN gatt_parse_services_1 */

/* USER CODE END gatt_parse_services_1 */
      else
      {
        APP_DBG_MSG("\n");
      }

      uuid_offset += p_evt->Attribute_Data_Length;
    }
  }
  else
  {
    APP_DBG_MSG("ACI_ATT_READ_BY_GROUP_TYPE_RESP_VSEVT_CODE, failed no free index in connection table !\n");
  }

  return;
}

/**
* function of GATT service parse by UUID
*/
static void gatt_parse_services_by_UUID(aci_att_clt_find_by_type_value_resp_event_rp0 *p_evt)
{
  uint8_t i;

  APP_DBG_MSG("ACI_ATT_FIND_BY_TYPE_VALUE_RESP_VSEVT_CODE - ConnHdl=0x%04X, Num_of_Handle_Pair=%d\n",
                p_evt->Connection_Handle,
                p_evt->Num_of_Handle_Pair);

  for(i = 0 ; i < p_evt->Num_of_Handle_Pair ; i++)
  {
    APP_DBG_MSG("ACI_ATT_FIND_BY_TYPE_VALUE_RESP_VSEVT_CODE - PaitId=%d Found_Attribute_Handle=0x%04X, Group_End_Handle=0x%04X\n",
                  i,
                  p_evt->Attribute_Group_Handle_Pair[i].Found_Attribute_Handle,
                  p_evt->Attribute_Group_Handle_Pair[i].Group_End_Handle);
  }

/* USER CODE BEGIN gatt_parse_services_by_UUID_1 */

/* USER CODE END gatt_parse_services_by_UUID_1 */

  return;
}

/**
* function of GATT characteristics parse
*/
static void gatt_parse_chars(aci_att_clt_read_by_type_resp_event_rp0 *p_evt)
{
  uint16_t uuid, CharStartHdl, CharValueHdl;
  uint8_t uuid_offset, uuid_size, uuid_short_offset;
  uint8_t i, idx, numHdlValuePair, index;
  uint8_t CharProperties;

  APP_DBG_MSG("ACI_ATT_READ_BY_TYPE_RESP_VSEVT_CODE - ConnHdl=0x%04X\n",
                p_evt->Connection_Handle);

[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
  for (index = 0 ; index < BLE_CFG_MAX_NBR_GATT_EVT_HANDLERS ; index++)
[#else]
  for (index = 0 ; index < GATT_CLT_MAX_NUM_SERVERS ; index++)
[/#if]
  {
    if (a_ClientContext[index].connHdl == p_evt->Connection_Handle)
    {
      break;
    }
  }

  if (a_ClientContext[index].connHdl == p_evt->Connection_Handle)
  {
    /* event data in Attribute_Data_List contains:
    * 2 bytes for start handle
    * 1 byte char properties
    * 2 bytes handle
    * 2 or 16 bytes data for UUID
    */

    /* Number of attribute value tuples */
    numHdlValuePair = p_evt->Data_Length / p_evt->Handle_Value_Pair_Length;

    if (p_evt->Handle_Value_Pair_Length == 21) /* we are interested in  128 bit UUIDs */
    {
      idx = 17;                /* UUID index of 2 bytes read part in Attribute_Data_List */
      uuid_offset = 5;         /* UUID offset in bytes in Attribute_Data_List */
      uuid_size = 16;          /* UUID size in bytes */
      uuid_short_offset = 12;  /* UUID offset of 2 bytes read part in UUID field */
    }
    if (p_evt->Handle_Value_Pair_Length == 7) /* we are interested in  16 bit UUIDs */
    {
      idx = 5;
      uuid_offset = 5;
      uuid_size = 2;
      uuid_short_offset = 0;
    }
    UNUSED(idx);
    UNUSED(uuid_size);

    p_evt->Data_Length -= 1;

    APP_DBG_MSG("  ConnHdl=0x%04X, number of value pair = %d\n", a_ClientContext[index].connHdl, numHdlValuePair);
    /* Loop on number of attribute value tuples */
    for (i = 0; i < numHdlValuePair; i++)
    {
      CharStartHdl = UNPACK_2_BYTE_PARAMETER(&p_evt->Handle_Value_Pair_Data[uuid_offset - 5]);
      CharProperties = p_evt->Handle_Value_Pair_Data[uuid_offset - 3];
      CharValueHdl = UNPACK_2_BYTE_PARAMETER(&p_evt->Handle_Value_Pair_Data[uuid_offset - 2]);
      uuid = UNPACK_2_BYTE_PARAMETER(&p_evt->Handle_Value_Pair_Data[uuid_offset + uuid_short_offset]);

      if ( (uuid != 0x0) && (CharProperties != 0x0) && (CharStartHdl != 0x0) && (CharValueHdl != 0) )
      {
        APP_DBG_MSG("    %d/%d short UUID=0x%04X, Properties=0x%04X, CharHandle [0x%04X - 0x%04X]",
                     i + 1, numHdlValuePair, uuid, CharProperties, CharStartHdl, CharValueHdl);

        if (uuid == DEVICE_NAME_UUID)
        {
          APP_DBG_MSG(", GAP DEVICE_NAME charac found\n");
        }
        else if (uuid == APPEARANCE_UUID)
        {
          APP_DBG_MSG(", GAP APPEARANCE charac found\n");
        }
        else if (uuid == SERVICE_CHANGED_UUID)
        {
          a_ClientContext[index].ServiceChangedCharStartHdl = CharStartHdl;
          a_ClientContext[index].ServiceChangedCharValueHdl = CharValueHdl;
          APP_DBG_MSG(", GATT SERVICE_CHANGED_CHARACTERISTIC_UUID charac found\n");
        }
/* USER CODE BEGIN gatt_parse_chars_1 */

/* USER CODE END gatt_parse_chars_1 */
        else
        {
          APP_DBG_MSG("\n");
        }

      }
      uuid_offset += p_evt->Handle_Value_Pair_Length;
    }
  }
  else
  {
    APP_DBG_MSG("ACI_ATT_READ_BY_TYPE_RESP_VSEVT_CODE, failed handle not found in connection table !\n");
  }

  return;
}
/**
* function of GATT descriptor parse
*/
static void gatt_parse_descs(aci_att_clt_find_info_resp_event_rp0 *p_evt)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
{
  uint16_t uuid, handle;
  uint8_t uuid_offset, uuid_size, uuid_short_offset;
  uint8_t i, numDesc, handle_uuid_pair_size, index;

  APP_DBG_MSG("ACI_ATT_FIND_INFO_RESP_VSEVT_CODE - ConnHdl=0x%04X\n",
              p_evt->Connection_Handle);

[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
  for (index = 0 ; index < BLE_CFG_MAX_NBR_GATT_EVT_HANDLERS ; index++)
[#else]
  for (index = 0 ; index < GATT_CLT_MAX_NUM_SERVERS ; index++)
[/#if]
  {
    if (a_ClientContext[index].connHdl == p_evt->Connection_Handle)
    {
      break;
    }
  }

  if (a_ClientContext[index].connHdl == p_evt->Connection_Handle)
  {
    /* event data in Attribute_Data_List contains:
    * 2 bytes handle
    * 2 or 16 bytes data for UUID
    */
    if (p_evt->Format == UUID_TYPE_16)
    {
      uuid_size = 2;
      uuid_offset = 2;
      uuid_short_offset = 0;
      handle_uuid_pair_size = 4;
    }
    if (p_evt->Format == UUID_TYPE_128)
    {
      uuid_size = 16;
      uuid_offset = 2;
      uuid_short_offset = 12;
      handle_uuid_pair_size = 18;
    }
    UNUSED(uuid_size);

    /* Number of handle uuid pairs */
    numDesc = (p_evt->Event_Data_Length) / handle_uuid_pair_size;

    for (i = 0; i < numDesc; i++)
    {
      handle = UNPACK_2_BYTE_PARAMETER(&p_evt->Handle_UUID_Pair[uuid_offset - 2]);
      uuid = UNPACK_2_BYTE_PARAMETER(&p_evt->Handle_UUID_Pair[uuid_offset + uuid_short_offset]);

      if (uuid == PRIMARY_SERVICE_UUID)
      {
        APP_DBG_MSG("PRIMARY_SERVICE_UUID=0x%04X handle=0x%04X\n", uuid, handle);
      }
      else if (uuid == CHARACTERISTIC_UUID)
      {
        /* reset UUID & handle */
        gattCharStartHdl = 0;
        gattCharValueHdl = 0;

        gattCharStartHdl = handle;
        APP_DBG_MSG("reset - UUID & handle - CHARACTERISTIC_UUID=0x%04X CharStartHandle=0x%04X\n", uuid, handle);
      }
      else if ( (uuid == CHAR_EXTENDED_PROPERTIES_DESCRIPTOR_UUID)
             || (uuid == CLIENT_CHAR_CONFIG_DESCRIPTOR_UUID) )
      {

        APP_DBG_MSG("Descriptor UUID=0x%04X, handle=0x%04X-0x%04X-0x%04X",
                      uuid,
                      gattCharStartHdl,
                      gattCharValueHdl,
                      handle);
        if (a_ClientContext[index].ServiceChangedCharValueHdl == gattCharValueHdl)
        {
          a_ClientContext[index].ServiceChangedCharDescHdl = handle;
          APP_DBG_MSG(", Service Changed found\n");
        }
/* USER CODE BEGIN gatt_parse_descs_1 */

/* USER CODE END gatt_parse_descs_1 */
        else
        {
          APP_DBG_MSG("\n");
        }
      }
      else
      {
        gattCharValueHdl = handle;

        APP_DBG_MSG("  UUID=0x%04X, handle=0x%04X", uuid, handle);

        if (uuid == DEVICE_NAME_UUID)
        {
          APP_DBG_MSG(", found GAP DEVICE_NAME_UUID\n");
        }
        else if (uuid == APPEARANCE_UUID)
        {
          APP_DBG_MSG(", found GAP APPEARANCE_UUID\n");
        }
        else if (uuid == SERVICE_CHANGED_UUID)
        {
          APP_DBG_MSG(", found GATT SERVICE_CHANGED_CHARACTERISTIC_UUID\n");
        }
/* USER CODE BEGIN gatt_parse_descs_2 */

/* USER CODE END gatt_parse_descs_2 */
        else
        {
          APP_DBG_MSG("\n");
        }
      }
    uuid_offset += handle_uuid_pair_size;
    }
  }
  else
  {
    APP_DBG_MSG("ACI_ATT_FIND_INFO_RESP_VSEVT_CODE, failed handle not found in connection table !\n");
  }

  return;
}

static void gatt_parse_notification(aci_gatt_clt_notification_event_rp0 *p_evt)
{
  APP_DBG_MSG("ACI_GATT_NOTIFICATION_VSEVT_CODE - ConnHdl=0x%04X, Attribute_Handle=0x%04X\n",
              p_evt->Connection_Handle,
              p_evt->Attribute_Handle);
/* USER CODE BEGIN gatt_parse_notification_1 */

/* USER CODE END gatt_parse_notification_1 */

  return;
}
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]

static void client_discover_all(void)
{
  GATT_CLIENT_APP_Discover_services(0);
  return;
}
[/#if]

static void gatt_cmd_resp_release(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetEvt(1U << CFG_IDLEEVT_PROC_GATT_COMPLETE);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_put(&PROC_GATT_COMPLETE_Sem);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

[/#if]
  return;
}

static void gatt_cmd_resp_wait(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_WaitEvt(1U << CFG_IDLEEVT_PROC_GATT_COMPLETE);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_get(&PROC_GATT_COMPLETE_Sem, TX_WAIT_FOREVER);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

[/#if]
  return;
}

/* USER CODE BEGIN LF */

/* USER CODE END LF */
