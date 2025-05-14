[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    gatt_client_app.c
  * @author  MCD Application Team
  * @brief   GATT Client Application
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign PG_FILL_UCS = "False"]
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
#include "log_module.h"
#include "app_common.h"
#include "dbg_trace.h"
#include "ble.h"
#include "gatt_client_app.h"
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
#include "stm32_seq.h"
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
#include "app_threadx.h"
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
#include "cmsis_os2.h"
[/#if]
#include "app_ble.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PCLIENT")]
#include "stm32wbaxx_nucleo.h"
[/#if]
[/#if]
/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/

/* USER CODE BEGIN PTD */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PCLIENT")]

typedef struct
{
  uint8_t selection;
  uint8_t level;
}P2PButton_t;
[/#if]
[/#if]

/* USER CODE END PTD */

typedef enum
{
  NOTIFICATION_INFO_RECEIVED_EVT,
  /* USER CODE BEGIN GATT_CLIENT_APP_Opcode_t */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PCLIENT")]
  P2P_START_TIMER_EVT,
  P2P_STOP_TIMER_EVT,
  P2P_NOTIFICATION_INFO_RECEIVED_EVT,
[/#if]
[/#if]

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

[#if (myHash["BLE_OPTIONS_ENHANCED_ATT"] == "BLE_OPTIONS_ENHANCED_ATT")]
typedef struct
{
  EATTC_STM_Payload_t TxData;
  EATTC_App_Transfer_Req_Status_t NotificationTransferReq;
  EATTC_App_Transfer_Req_Status_t ButtonTransferReq;
  EATTC_App_Flow_Status_t DtFlowStatus;
  uint8_t connectionstatus;
} EATTC_Context_t;

typedef struct
{
  EATTC_STM_Payload_t     DataTransfered;
  uint16_t                ConnectionHandle;
  uint8_t                 ServiceInstance;

  /* USER CODE BEGIN Service1_NotificationEvt_t */
  GATT_CLIENT_APP_Opcode_t       EvtOpcode;
  /* USER CODE END Service1_NotificationEvt_t */

} EATT_CLI_NotificationEvt_t;

[/#if]

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
  uint8_t ServiceChangedCharProperties;
[#if (myHash["BLE_OPTIONS_ENHANCED_ATT"] == "BLE_OPTIONS_ENHANCED_ATT")]
  /* EATT bearer */
  uint16_t EATT_Bearer_connHdl[6];
  /* handles of the P2P service */
  uint16_t EATTServiceHdl;
  uint16_t EATTServiceEndHdl;

  /* handles of the Tx characteristic - Write To Server */
  uint16_t EATTChar1CharHdl;
  uint16_t EATTChar1ValueHdl;
  uint16_t EATTChar1DescHdl;

  /* handles of the Rx characteristic - Notification From Server */
  uint16_t EATTChar2CharHdl;
  uint16_t EATTChar2ValueHdl;
  uint16_t EATTChar2DescHdl;
  uint16_t MTUSizeValue;

[/#if]
  /* USER CODE BEGIN BleClientAppContext_t */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PCLIENT")]
  /* handles of the P2P service */
  uint16_t P2PServiceHdl;
  uint16_t P2PServiceEndHdl;

  /* handles of the Tx characteristic - Write To Server */
  uint16_t P2PWriteToServerCharHdl;
  uint16_t P2PWriteToServerValueHdl;
  uint16_t P2PWriteToServerDescHdl;

  /* handles of the Rx characteristic - Notification From Server */
  uint16_t P2PNotificationCharHdl;
  uint16_t P2PNotificationValueHdl;
  uint16_t P2PNotificationDescHdl;

  /* handles of the Tx characteristic - Write To Server with response */
  uint16_t P2PWriteWithResToServerCharHdl;
  uint16_t P2PWriteWithResToServerValueHdl;
  uint16_t P2PWriteWithResToServerDescHdl;
[/#if]
[/#if]

/* USER CODE END BleClientAppContext_t */

}BleClientAppContext_t;

/* Private defines ------------------------------------------------------------*/
[#if (myHash["BLE_OPTIONS_ENHANCED_ATT"] == "BLE_OPTIONS_ENHANCED_ATT")]
#define GATT_EAB_PREFIX                         0xEAU

[/#if]
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macros -------------------------------------------------------------*/
#define UNPACK_2_BYTE_PARAMETER(ptr)  \
        (uint16_t)((uint16_t)(*((uint8_t *)ptr))) |   \
        (uint16_t)((((uint16_t)(*((uint8_t *)ptr + 1))) << 8))
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

static BleClientAppContext_t a_ClientContext[BLE_CFG_CLT_MAX_NBR_CB];
static uint16_t gattCharStartHdl = 0;
static uint16_t gattCharValueHdl = 0;
[#if myHash["FREERTOS_STATUS"]?number == 1 ]

static osThreadId_t     ClientDiscoverTaskHandle;
static osSemaphoreId_t  ClientDiscoverSemaphore;

const osThreadAttr_t ClientDiscoverTask_attributes = {
  .name         = "Client Discover Task",
  .priority     = TASK_PRIO_CLIENT_DISCOVER,
  .stack_size   = TASK_STACK_SIZE_CLIENT_DISCOVER,
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM
};

const osSemaphoreAttr_t ClientDiscoverSemaphore_attributes = {
  .name         = "Client Discover Semaphore",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE
};
[/#if]

/* USER CODE BEGIN PV */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PCLIENT")]
static uint8_t P2PLedSelection;
static uint8_t P2PLedLevel;

static P2PButton_t P2PButtonData;
[/#if]
[/#if]

/* USER CODE END PV */

/* Global variables ----------------------------------------------------------*/
[#if myHash["THREADX_STATUS"]?number == 1 ]
/* CLIENT_DISCOVER_Thread related resources */
TX_THREAD CLIENT_DISCOVER_Thread;

/* client_discover related resources */
TX_SEMAPHORE client_discover_Thread_Sem;

/* PROC_GATT_COMPLETE related resources */
TX_SEMAPHORE PROC_GATT_COMPLETE_Sem;

[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
/* Client discover related resources */
osSemaphoreId_t         ClientDiscoverSemaphore;
osThreadId_t            ClientDiscoverThread;

[/#if]
/* USER CODE BEGIN GV */

/* USER CODE END GV */

/* Private function prototypes -----------------------------------------------*/
static SVCCTL_EvtAckStatus_t Event_Handler(void *Event);
static void gatt_parse_services(aci_att_read_by_group_type_resp_event_rp0 *p_evt);
static void gatt_parse_services_by_UUID(aci_att_find_by_type_value_resp_event_rp0 *p_evt);
static void gatt_parse_chars(aci_att_read_by_type_resp_event_rp0 *p_evt);
static void gatt_parse_descs(aci_att_find_info_resp_event_rp0 *p_evt);
static void gatt_parse_notification(aci_gatt_notification_event_rp0 *p_evt);
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
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PCLIENT")]
static void P2Pclient_write_char(void);
[/#if]
[/#if]

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
  /* USER CODE BEGIN GATT_CLIENT_APP_Init_1 */

  /* USER CODE END GATT_CLIENT_APP_Init_1 */
  for(index = 0; index < BLE_CFG_CLT_MAX_NBR_CB; index++)
  {
    a_ClientContext[index].connStatus = APP_BLE_IDLE;
  }

  /* Register the event handler to the BLE controller */
  SVCCTL_RegisterCltHandler(Event_Handler);

[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  /* Register a task allowing to discover all services and characteristics and enable all notifications */
  UTIL_SEQ_RegTask(1U << CFG_TASK_DISCOVER_SERVICES_ID, UTIL_SEQ_RFU, client_discover_all);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  /* Create Gatt Client Discover FreeRTOS objects */

  ClientDiscoverTaskHandle = osThreadNew(ClientDiscover_Task_Entry, NULL, &ClientDiscoverTask_attributes);

  ClientDiscoverSemaphore = osSemaphoreNew(1U, 0U, &ClientDiscoverSemaphore_attributes);
  
  if((ClientDiscoverTaskHandle == NULL) || (ClientDiscoverSemaphore == NULL) )
  {
    LOG_ERROR_APP( "Client Discover FreeRTOS objects creation FAILED");
    Error_Handler();
  }

[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  UINT TXstatus;
  CHAR *pStack;
  
  /* Create Gatt Client Discover ThreadX objects */

  TXstatus = tx_byte_allocate(pBytePool, (void **)&pStack, CLIENT_DISCOVER_TASK_STACK_SIZE, TX_NO_WAIT);

  if( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create(&ClientDiscoverTaskHandle, "Client Discover  Task", BLE_TIMER_Task_Entry, 0,
                                 pStack, TASK_STACK_SIZE_CLIENT_DISCOVER,
                                 TASK_PRIO_CLIENT_DISCOVER, TASK_PREEMP_CLIENT_DISCOVER,
                                 TX_NO_TIME_SLICE, TX_AUTO_START);
                                 
    TXstatus |= tx_semaphore_create(&ClientDiscoverSemaphore, "BLE Timer Semaphore", 0);
  }

  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "Client Discover ThreadX objects creation FAILED, status: %d", TXstatus);
    Error_Handler();
  }
[/#if]

  /* USER CODE BEGIN GATT_CLIENT_APP_Init_2 */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PCLIENT")]
  UTIL_SEQ_RegTask(1U << CFG_TASK_P2PC_WRITE_CHAR_ID, UTIL_SEQ_RFU, P2Pclient_write_char);

  P2PLedSelection = 0x00;
  P2PLedLevel = 0x00;

  P2PButtonData.selection = 0x01;
  P2PButtonData.level = 0x00;
[/#if]
[/#if]

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
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PCLIENT")]
    {
      uint8_t index = 0;

      while((index < BLE_CFG_CLT_MAX_NBR_CB) &&
            (a_ClientContext[index].state != GATT_CLIENT_APP_IDLE))
      {
        a_ClientContext[index].state = GATT_CLIENT_APP_IDLE;
      }
    }
[/#if]
[/#if]

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

  if (index < BLE_CFG_CLT_MAX_NBR_CB)
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
  GATT_CLIENT_APP_Procedure_Gatt(index, PROC_GATT_PROPERTIES_ENABLE_ALL);
  
[#if (myHash["BLE_OPTIONS_GATT_CACHING"] == "BLE_OPTIONS_GATT_CACHING")]
  GATT_CLIENT_APP_Procedure_Gatt(index, PROC_GATT_ENABLE_ROBUST_CACHING);
  GATT_CLIENT_APP_Procedure_Gatt(index, PROC_GATT_READ_USING_CHAR_UUID);

[/#if]
  return;
}

uint8_t GATT_CLIENT_APP_Procedure_Gatt(uint8_t index, ProcGattId_t GattProcId)
{
  tBleStatus result = BLE_STATUS_SUCCESS;
  uint8_t status;

  if (index >= BLE_CFG_CLT_MAX_NBR_CB)
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

        LOG_INFO_APP("GATT services discovery\n");
        result = aci_gatt_disc_all_primary_services(a_ClientContext[index].connHdl);

        if (result == BLE_STATUS_SUCCESS)
        {
          gatt_cmd_resp_wait();
          LOG_INFO_APP("PROC_GATT_DISC_ALL_PRIMARY_SERVICES services discovered Successfully\n\n");
        }
        else
        {
          LOG_INFO_APP("PROC_GATT_DISC_ALL_PRIMARY_SERVICES aci_gatt_disc_all_primary_services cmd NOK status =0x%02X\n\n", result);
        }
      }
      break; /* PROC_GATT_DISC_ALL_PRIMARY_SERVICES */

      case PROC_GATT_DISC_ALL_CHARS:
      {
        a_ClientContext[index].state = GATT_CLIENT_APP_DISCOVER_CHARACS;

        LOG_INFO_APP("DISCOVER_ALL_CHARS ConnHdl=0x%04X ALLServiceHandle[0x%04X - 0x%04X]\n",
                          a_ClientContext[index].connHdl,
                          a_ClientContext[index].ALLServiceStartHdl,
                          a_ClientContext[index].ALLServiceEndHdl);

        result = aci_gatt_disc_all_char_of_service(
                           a_ClientContext[index].connHdl,
                           a_ClientContext[index].ALLServiceStartHdl,
                           a_ClientContext[index].ALLServiceEndHdl);

        if (result == BLE_STATUS_SUCCESS)
        {
          gatt_cmd_resp_wait();
          LOG_INFO_APP("All characteristics discovered Successfully\n\n");
        }
        else
        {
          LOG_INFO_APP("All characteristics discovery Failed, status =0x%02X\n\n", result);
        }
      }
      break; /* PROC_GATT_DISC_ALL_CHARS */

      case PROC_GATT_DISC_ALL_DESCS:
      {
        a_ClientContext[index].state = GATT_CLIENT_APP_DISCOVER_WRITE_DESC;

        LOG_INFO_APP("DISCOVER_ALL_CHAR_DESCS [0x%04X - 0x%04X]\n",
                         a_ClientContext[index].ALLServiceStartHdl,
                         a_ClientContext[index].ALLServiceEndHdl);
        result = aci_gatt_disc_all_char_desc(
                         a_ClientContext[index].connHdl,
                         a_ClientContext[index].ALLServiceStartHdl,
                         a_ClientContext[index].ALLServiceEndHdl);

        if (result == BLE_STATUS_SUCCESS)
        {
          gatt_cmd_resp_wait();
          LOG_INFO_APP("All characteristic descriptors discovered Successfully\n\n");
        }
        else
        {
          LOG_INFO_APP("All characteristic descriptors discovery Failed, status =0x%02X\n\n", result);
        }
      }
      break; /* PROC_GATT_DISC_ALL_DESCS */
      case PROC_GATT_PROPERTIES_ENABLE_ALL:
      {
        uint16_t charPropVal = 0x0000;

        if (a_ClientContext[index].ServiceChangedCharDescHdl != 0x0000)
        {
          if(((a_ClientContext[index].ServiceChangedCharProperties) & CHAR_PROP_NOTIFY) == CHAR_PROP_NOTIFY)
          {
            charPropVal = 0x0001;
          }
          if(((a_ClientContext[index].ServiceChangedCharProperties) & CHAR_PROP_INDICATE) == CHAR_PROP_INDICATE)
          {
            charPropVal = 0x0002;
          }
          result = aci_gatt_write_char_desc(a_ClientContext[index].connHdl,
                                            a_ClientContext[index].ServiceChangedCharDescHdl,
                                            2,
                                            (uint8_t *) &charPropVal);
          gatt_cmd_resp_wait();
          LOG_INFO_APP(" ServiceChangedCharDescHdl =0x%04X\n",a_ClientContext[index].ServiceChangedCharDescHdl);
        }
        /* USER CODE BEGIN PROC_GATT_PROPERTIES_ENABLE_ALL */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PCLIENT")]
        if(a_ClientContext[index].P2PNotificationDescHdl != 0x0000)
        {
          result |= aci_gatt_write_char_desc(a_ClientContext[index].connHdl,
                                            a_ClientContext[index].P2PNotificationDescHdl,
                                            2,
                                            (uint8_t *) &enable);
          gatt_cmd_resp_wait();
          LOG_INFO_APP(" P2PNotificationDescHdl =0x%04X\n",a_ClientContext[index].P2PNotificationDescHdl);
        }
[/#if]
[/#if]

        /* USER CODE END PROC_GATT_PROPERTIES_ENABLE_ALL */

        if (result == BLE_STATUS_SUCCESS)
        {
          LOG_INFO_APP("All notifications enabled Successfully\n\n");
        }
        else
        {
          LOG_INFO_APP("All notifications enabled Failed, status =0x%02X\n\n", result);
        }
      }
      break; /* PROC_GATT_PROPERTIES_ENABLE_ALL */
	  
[#if (myHash["BLE_OPTIONS_GATT_CACHING"] == "BLE_OPTIONS_GATT_CACHING")]
	  case PROC_GATT_READ_USING_CHAR_UUID:
      {
        a_ClientContext[index].state = GATT_CLIENT_READ_USING_CHAR_UUID;
        UTIL_SEQ_SetTask(1U << CFG_TASK_READ_CHAR_UUID_ID, CFG_SEQ_PRIO_0);        
        /* USER CODE BEGIN PROC_GATT_READ_USING_CHAR_UUID */

        /* USER CODE END PROC_GATT_READ_USING_CHAR_UUID */
      }
      break;
      case PROC_GATT_ENABLE_ROBUST_CACHING:
      {
        uint16_t enable_robust_caching =0x01;
        a_ClientContext[index].state = GATT_CLIENT_ENABLE_ROBUST_CACHING;
        if (a_ClientContext[index].ClientSupportedFeatureCharStartHdl != 0x0000)
        {
          result = aci_gatt_write_char_value(a_ClientContext[index].connHdl,
                                            a_ClientContext[index].ClientSupportedFeatureCharValueHdl,
                                            1,
                                            (uint8_t *) &enable_robust_caching);
          gatt_cmd_resp_wait();
          APP_DBG_MSG(" ClientSupportedFeatureCharValueHdl =0x%04X\n",a_ClientContext[index].ClientSupportedFeatureCharValueHdl);
        }

        if (result == BLE_STATUS_SUCCESS)
        {
          LOG_INFO_APP("Robust caching feature enabled Successfully\n\n");
        }
        else
        {
          LOG_INFO_APP("Robust caching feature enabled Failed, status =0x%02X\n\n", result);
        }
        
      }
      break;
[/#if]

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
static SVCCTL_EvtAckStatus_t Event_Handler(void *Event)
{
  SVCCTL_EvtAckStatus_t return_value;
  hci_event_pckt *event_pckt;
  evt_blecore_aci *p_blecore_evt;

  GATT_CLIENT_APP_Notification_evt_t Notification;
  UNUSED(Notification);

  return_value = SVCCTL_EvtNotAck;
  event_pckt = (hci_event_pckt *)(((hci_uart_pckt*)Event)->data);

  switch (event_pckt->evt)
  {
    case HCI_VENDOR_SPECIFIC_DEBUG_EVT_CODE:
    {
      p_blecore_evt = (evt_blecore_aci*)event_pckt->data;
      switch (p_blecore_evt->ecode)
      {
        case ACI_ATT_READ_BY_GROUP_TYPE_RESP_VSEVT_CODE:
        {
          aci_att_read_by_group_type_resp_event_rp0 *p_evt_rsp = (void*)p_blecore_evt->data;
          gatt_parse_services((aci_att_read_by_group_type_resp_event_rp0 *)p_evt_rsp);
        }
        break; /* ACI_ATT_READ_BY_GROUP_TYPE_RESP_VSEVT_CODE */
        case ACI_ATT_FIND_BY_TYPE_VALUE_RESP_VSEVT_CODE:
        {
          aci_att_find_by_type_value_resp_event_rp0 *p_evt_rsp = (void*) p_blecore_evt->data;
          gatt_parse_services_by_UUID((aci_att_find_by_type_value_resp_event_rp0 *)p_evt_rsp);
        }
        break; /* ACI_ATT_FIND_BY_TYPE_VALUE_RESP_VSEVT_CODE */
        case ACI_ATT_READ_BY_TYPE_RESP_VSEVT_CODE:
        {
          aci_att_read_by_type_resp_event_rp0 *p_evt_rsp = (void*)p_blecore_evt->data;
          gatt_parse_chars((aci_att_read_by_type_resp_event_rp0 *)p_evt_rsp);
        }
        break; /* ACI_ATT_READ_BY_TYPE_RESP_VSEVT_CODE */
        case ACI_ATT_FIND_INFO_RESP_VSEVT_CODE:
        {
          aci_att_find_info_resp_event_rp0 *p_evt_rsp = (void*)p_blecore_evt->data;
          gatt_parse_descs((aci_att_find_info_resp_event_rp0 *)p_evt_rsp);
        }
        break; /* ACI_ATT_FIND_INFO_RESP_VSEVT_CODE */
        case ACI_GATT_NOTIFICATION_VSEVT_CODE:
        {
          aci_gatt_notification_event_rp0 *p_evt_rsp = (void*)p_blecore_evt->data;
          gatt_parse_notification((aci_gatt_notification_event_rp0 *)p_evt_rsp);
        }
        break;/* ACI_GATT_NOTIFICATION_VSEVT_CODE */
        case ACI_GATT_PROC_COMPLETE_VSEVT_CODE:
        {
          aci_gatt_proc_complete_event_rp0 *p_evt_rsp = (void*)p_blecore_evt->data;

          uint8_t index;
          for (index = 0 ; index < BLE_CFG_CLT_MAX_NBR_CB ; index++)
          {
            if (a_ClientContext[index].connHdl == p_evt_rsp->Connection_Handle)
            {
              gatt_cmd_resp_release();
              break;
            }
          }
[#if (myHash["BLE_OPTIONS_GATT_CACHING"] == "BLE_OPTIONS_GATT_CACHING")]
		/* if GATT DB has changed */
          if (DBHashModified == 1) 
          {
            LOG_INFO_APP("  GATT Database has changed, need to restart discovery of service/charac \r\n");
            DBHashModified = 0;
            UTIL_SEQ_SetTask(1U << CFG_TASK_DISCOVER_SERVICES_ID, CFG_SEQ_PRIO_0);
          }
[/#if]
        }
        break;/* ACI_GATT_PROC_COMPLETE_VSEVT_CODE */
        case ACI_GATT_TX_POOL_AVAILABLE_VSEVT_CODE:
        {
          aci_att_exchange_mtu_resp_event_rp0 *tx_pool_available;
          tx_pool_available = (aci_att_exchange_mtu_resp_event_rp0 *)p_blecore_evt->data;
          UNUSED(tx_pool_available);
          /* USER CODE BEGIN ACI_GATT_TX_POOL_AVAILABLE_VSEVT_CODE */

          /* USER CODE END ACI_GATT_TX_POOL_AVAILABLE_VSEVT_CODE */
        }
        break;/* ACI_GATT_TX_POOL_AVAILABLE_VSEVT_CODE*/
        case ACI_ATT_EXCHANGE_MTU_RESP_VSEVT_CODE:
        {
          aci_att_exchange_mtu_resp_event_rp0 * exchange_mtu_resp;
          exchange_mtu_resp = (aci_att_exchange_mtu_resp_event_rp0 *)p_blecore_evt->data;
          LOG_INFO_APP("  MTU exchanged size = %d\n",exchange_mtu_resp->Server_RX_MTU );
          UNUSED(exchange_mtu_resp);
          /* USER CODE BEGIN ACI_ATT_EXCHANGE_MTU_RESP_VSEVT_CODE */

          /* USER CODE END ACI_ATT_EXCHANGE_MTU_RESP_VSEVT_CODE */
        }
        break;
		
[#if (myHash["BLE_OPTIONS_GATT_CACHING"] == "BLE_OPTIONS_GATT_CACHING")]
		case ACI_ATT_READ_RESP_VSEVT_CODE:
        {
          aci_att_read_resp_event_rp0 *aci_att_read_resp;
          aci_att_read_resp = (aci_att_read_resp_event_rp0 *)p_blecore_evt->data;
          UNUSED(aci_att_read_resp);
          LOG_INFO_APP("  ACI_ATT_READ_RESP_VSEVT_CODE: 0x%x \n\r", aci_att_read_resp->Attribute_Value[0]);
        }
        break;
        case ACI_GATT_READ_EXT_VSEVT_CODE:
        {
          aci_gatt_read_ext_event_rp0 *aci_att_read_ext;
          aci_att_read_ext = (aci_gatt_read_ext_event_rp0 *)p_blecore_evt->data;
          UNUSED(aci_att_read_ext);
          LOG_INFO_APP("  ACI_GATT_READ_EXT_VSEVT_CODE \n\r");
        }
        break;
        case ACI_GATT_ERROR_RESP_VSEVT_CODE:
        {
          aci_gatt_error_resp_event_rp0 *aci_gatt_error_resp;
          aci_gatt_error_resp = (aci_gatt_error_resp_event_rp0 *)p_blecore_evt->data;
          UNUSED(aci_gatt_error_resp);
          LOG_INFO_APP("  ACI_GATT_ERROR_RESP_VSEVT_CODE: 0x%x \n\r", aci_gatt_error_resp->Error_Code);
          
        }
        break;
        case ACI_GATT_DISC_READ_CHAR_BY_UUID_RESP_VSEVT_CODE:
        {
          aci_gatt_disc_read_char_by_uuid_resp_event_rp0 * aci_gatt_disc_read_char_by_uuid_resp;
          aci_gatt_disc_read_char_by_uuid_resp = (aci_gatt_disc_read_char_by_uuid_resp_event_rp0 *)p_blecore_evt->data;
          UNUSED(aci_gatt_disc_read_char_by_uuid_resp);
          /* USER CODE BEGIN ACI_GATT_DISC_READ_CHAR_BY_UUID_RESP_VSEVT_CODE */
          uint8_t i;
          LOG_INFO_APP("  GATT disc read char by uuid length = 0x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x \n", 
                                                                        aci_gatt_disc_read_char_by_uuid_resp->Attribute_Value[15],aci_gatt_disc_read_char_by_uuid_resp->Attribute_Value[14],
                                                                        aci_gatt_disc_read_char_by_uuid_resp->Attribute_Value[13],aci_gatt_disc_read_char_by_uuid_resp->Attribute_Value[12],
                                                                        aci_gatt_disc_read_char_by_uuid_resp->Attribute_Value[11],aci_gatt_disc_read_char_by_uuid_resp->Attribute_Value[10],
                                                                        aci_gatt_disc_read_char_by_uuid_resp->Attribute_Value[9],aci_gatt_disc_read_char_by_uuid_resp->Attribute_Value[8],
                                                                        aci_gatt_disc_read_char_by_uuid_resp->Attribute_Value[7],aci_gatt_disc_read_char_by_uuid_resp->Attribute_Value[6],
                                                                        aci_gatt_disc_read_char_by_uuid_resp->Attribute_Value[5],aci_gatt_disc_read_char_by_uuid_resp->Attribute_Value[4],
                                                                        aci_gatt_disc_read_char_by_uuid_resp->Attribute_Value[3],aci_gatt_disc_read_char_by_uuid_resp->Attribute_Value[2],
                                                                        aci_gatt_disc_read_char_by_uuid_resp->Attribute_Value[1],aci_gatt_disc_read_char_by_uuid_resp->Attribute_Value[0]);
          
          if (ConnectionFlag == 1)
          {
            /* Compare actual databaseHash with stored one */
            for (i=0;i<16;i++)
            {
              if (a_ClientContext[0].DatabaseHashCharValue[i] != aci_gatt_disc_read_char_by_uuid_resp->Attribute_Value[i])
              {
                ConnectionFlag = 0;
                DBHashModified = 1;
                break;
              }
            }
          }
          else
          {
            /* Database discovered */
            ConnectionFlag = 1;
            /* Store databaseHash value */
            for (i=0;i<16;i++)
            {
              a_ClientContext[0].DatabaseHashCharValue[i] = aci_gatt_disc_read_char_by_uuid_resp->Attribute_Value[i];
            }
          }
          UTIL_SEQ_SetTask(1U << CFG_TASK_CONN_UPDATE_ID, CFG_SEQ_PRIO_0);
          
          /* USER CODE END ACI_GATT_DISC_READ_CHAR_BY_UUID_RESP_VSEVT_CODE */
          
        } /*ACI_GATT_DISC_READ_CHAR_BY_UUID_RESP_VSEVT_CODE */
        break;
[/#if]
[#if (myHash["BLE_OPTIONS_ENHANCED_ATT"] == "BLE_OPTIONS_ENHANCED_ATT")]
        case (ACI_GATT_EATT_BEARER_VSEVT_CODE):
        {
          aci_gatt_eatt_bearer_event_rp0 *eatt_bearer_event;
		  uint8_t index;

          eatt_bearer_event = (aci_gatt_eatt_bearer_event_rp0*)p_blecore_evt->data;
          APP_DBG_MSG(">>== ACI_GATT_EATT_BEARER_VSEVT_CODE\n");
          APP_DBG_MSG(">>== Channel_Index = %d\n",eatt_bearer_event->Channel_Index );

          /* USER CODE BEGIN ACI_GATT_EATT_BEARER_VSEVT_CODE_1 */

          /* USER CODE END ACI_GATT_EATT_BEARER_VSEVT_CODE_1 */
		  for(index = 0; index < BLE_CFG_CLT_MAX_NBR_CB; index++)
          {
            a_ClientContext[index].EATT_Bearer_connHdl[eatt_bearer_event->Channel_Index] = (GATT_EAB_PREFIX << 8) | eatt_bearer_event->Channel_Index;
          }
		  
		  /* USER CODE BEGIN ACI_GATT_EATT_BEARER_VSEVT_CODE_2 */

          /* USER CODE END ACI_GATT_EATT_BEARER_VSEVT_CODE_2 */
        } 
        break;
		
[/#if]
        default:
          break;
      }/* end switch (p_blecore_evt->ecode) */
    }
    break; /* HCI_VENDOR_SPECIFIC_DEBUG_EVT_CODE */
    default:
      break;
  }/* end switch (event_pckt->evt) */

  return(return_value);
}

__USED static void gatt_Notification(GATT_CLIENT_APP_Notification_evt_t *p_Notif)
{
  /* USER CODE BEGIN gatt_Notification_1*/

  /* USER CODE END gatt_Notification_1 */
  switch (p_Notif->Client_Evt_Opcode)
  {
    /* USER CODE BEGIN Client_Evt_Opcode */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PCLIENT")]
    case P2P_NOTIFICATION_INFO_RECEIVED_EVT:
    {
      P2PLedSelection = p_Notif->DataTransfered.p_Payload[0];
      UNUSED(P2PLedSelection);
      P2PLedLevel = p_Notif->DataTransfered.p_Payload[1];

      if (P2PLedLevel == 0x00)
      {
        BSP_LED_Off(LED_BLUE);
        LOG_INFO_APP("  P2P APPLICATION CLIENT : NOTIFICATION RECEIVED - LED OFF \n");
      }
      else
      {
        BSP_LED_On(LED_BLUE);
        LOG_INFO_APP("  P2P APPLICATION CLIENT : NOTIFICATION RECEIVED - LED ON\n");
      }
      break;
    }
[/#if]
[/#if]

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
static void gatt_parse_services(aci_att_read_by_group_type_resp_event_rp0 *p_evt)
{
  uint16_t uuid, ServiceStartHdl, ServiceEndHdl;
  uint8_t uuid_offset, uuid_size = 0U, uuid_short_offset = 0U;
  uint8_t i, idx, numServ, index;

  LOG_INFO_APP("ACI_ATT_READ_BY_GROUP_TYPE_RESP_VSEVT_CODE - ConnHdl=0x%04X\n",
                p_evt->Connection_Handle);

  for (index = 0 ; index < BLE_CFG_CLT_MAX_NBR_CB ; index++)
  {
    if (a_ClientContext[index].connHdl == p_evt->Connection_Handle)
    {
      break;
    }
  }

  /* index < BLE_CFG_CLT_MAX_NBR_CB means connection handle identified */
  if (index < BLE_CFG_CLT_MAX_NBR_CB)
  {
    /* Number of attribute value tuples */
    numServ = (p_evt->Data_Length) / p_evt->Attribute_Data_Length;

    /* event data in Attribute_Data_List contains:
    * 2 bytes for start handle
    * 2 bytes for end handle
    * 2 or 16 bytes data for UUID
    */
    uuid_offset = 4;           /*UUID offset in bytes in Attribute_Data_List */
    if (p_evt->Attribute_Data_Length == 20) /* we are interested in the UUID is 128 bit.*/
    {
      idx = 16;                /*UUID index of 2 bytes read part in Attribute_Data_List */
      uuid_size = 16;          /*UUID size in bytes */
      uuid_short_offset = 12;  /*UUID offset of 2 bytes read part in UUID field*/
    }
    if (p_evt->Attribute_Data_Length == 6) /* we are interested in the UUID is 16 bit.*/
    {
      idx = 4;
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
      LOG_INFO_APP("  %d/%d short UUID=0x%04X, handle [0x%04X - 0x%04X]",
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

        LOG_INFO_APP(", GAP_SERVICE_UUID found\n");
      }
      else if (uuid == GENERIC_ATTRIBUTE_SERVICE_UUID)
      {
        a_ClientContext[index].GATTServiceStartHdl = ServiceStartHdl;
        a_ClientContext[index].GATTServiceEndHdl = ServiceEndHdl;

        LOG_INFO_APP(", GENERIC_ATTRIBUTE_SERVICE_UUID found\n");
      }
/* USER CODE BEGIN gatt_parse_services_1 */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PCLIENT")]
      else if (uuid == P2P_SERVICE_UUID)
      {
        a_ClientContext[index].P2PServiceHdl = ServiceStartHdl;
        a_ClientContext[index].P2PServiceEndHdl = ServiceEndHdl;

        LOG_INFO_APP(", P2P_SERVICE_UUID found\n");
      }
[/#if]
[/#if]

/* USER CODE END gatt_parse_services_1 */
      else
      {
        LOG_INFO_APP("\n");
      }

      uuid_offset += p_evt->Attribute_Data_Length;
    }
  }
  else
  {
    LOG_INFO_APP("ACI_ATT_READ_BY_GROUP_TYPE_RESP_VSEVT_CODE, failed no free index in connection table !\n");
  }

  return;
}

/**
* function of GATT service parse by UUID
*/
static void gatt_parse_services_by_UUID(aci_att_find_by_type_value_resp_event_rp0 *p_evt)
{
  uint8_t i;

  LOG_INFO_APP("ACI_ATT_FIND_BY_TYPE_VALUE_RESP_VSEVT_CODE - ConnHdl=0x%04X, Num_of_Handle_Pair=%d\n",
                p_evt->Connection_Handle,
                p_evt->Num_of_Handle_Pair);

  for(i = 0 ; i < p_evt->Num_of_Handle_Pair ; i++)
  {
    LOG_INFO_APP("ACI_ATT_FIND_BY_TYPE_VALUE_RESP_VSEVT_CODE - PaitId=%d Found_Attribute_Handle=0x%04X, Group_End_Handle=0x%04X\n",
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
static void gatt_parse_chars(aci_att_read_by_type_resp_event_rp0 *p_evt)
{
  uint16_t uuid, CharStartHdl, CharValueHdl;
  uint8_t uuid_offset, uuid_size = 0U, uuid_short_offset = 0U;
  uint8_t i, idx, numHdlValuePair, index;
  uint8_t CharProperties;

  LOG_INFO_APP("ACI_ATT_READ_BY_TYPE_RESP_VSEVT_CODE - ConnHdl=0x%04X\n",
                p_evt->Connection_Handle);

  for (index = 0 ; index < BLE_CFG_CLT_MAX_NBR_CB ; index++)
  {
    if (a_ClientContext[index].connHdl == p_evt->Connection_Handle)
    {
      break;
    }
  }

  /* index < BLE_CFG_CLT_MAX_NBR_CB means connection handle identified */
  if (index < BLE_CFG_CLT_MAX_NBR_CB)
  {
    /* event data in Attribute_Data_List contains:
    * 2 bytes for start handle
    * 1 byte char properties
    * 2 bytes handle
    * 2 or 16 bytes data for UUID
    */

    /* Number of attribute value tuples */
    numHdlValuePair = p_evt->Data_Length / p_evt->Handle_Value_Pair_Length;

    uuid_offset = 5;           /* UUID offset in bytes in Attribute_Data_List */
    if (p_evt->Handle_Value_Pair_Length == 21) /* we are interested in  128 bit UUIDs */
    {
      idx = 17;                /* UUID index of 2 bytes read part in Attribute_Data_List */
      uuid_size = 16;          /* UUID size in bytes */
      uuid_short_offset = 12;  /* UUID offset of 2 bytes read part in UUID field */
    }
    if (p_evt->Handle_Value_Pair_Length == 7) /* we are interested in  16 bit UUIDs */
    {
      idx = 5;
      uuid_size = 2;
      uuid_short_offset = 0;
    }
    UNUSED(idx);
    UNUSED(uuid_size);

    p_evt->Data_Length -= 1;

    LOG_INFO_APP("  ConnHdl=0x%04X, number of value pair = %d\n", a_ClientContext[index].connHdl, numHdlValuePair);
    /* Loop on number of attribute value tuples */
    for (i = 0; i < numHdlValuePair; i++)
    {
      CharStartHdl = UNPACK_2_BYTE_PARAMETER(&p_evt->Handle_Value_Pair_Data[uuid_offset - 5]);
      CharProperties = p_evt->Handle_Value_Pair_Data[uuid_offset - 3];
      CharValueHdl = UNPACK_2_BYTE_PARAMETER(&p_evt->Handle_Value_Pair_Data[uuid_offset - 2]);
      uuid = UNPACK_2_BYTE_PARAMETER(&p_evt->Handle_Value_Pair_Data[uuid_offset + uuid_short_offset]);

      if ( (uuid != 0x0) && (CharProperties != 0x0) && (CharStartHdl != 0x0) && (CharValueHdl != 0) )
      {
        LOG_INFO_APP("    %d/%d short UUID=0x%04X, Properties=0x%04X, CharHandle [0x%04X - 0x%04X]",
                     i + 1, numHdlValuePair, uuid, CharProperties, CharStartHdl, CharValueHdl);

        if (uuid == DEVICE_NAME_UUID)
        {
          LOG_INFO_APP(", GAP DEVICE_NAME charac found\n");
        }
        else if (uuid == APPEARANCE_UUID)
        {
          LOG_INFO_APP(", GAP APPEARANCE charac found\n");
        }
        else if (uuid == SERVICE_CHANGED_CHARACTERISTIC_UUID)
        {
          a_ClientContext[index].ServiceChangedCharStartHdl = CharStartHdl;
          a_ClientContext[index].ServiceChangedCharValueHdl = CharValueHdl;
          LOG_INFO_APP(", GATT SERVICE_CHANGED_CHARACTERISTIC_UUID charac found\n");
        }
/* USER CODE BEGIN gatt_parse_chars_1 */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PCLIENT")]
        else if (uuid == ST_P2P_NOTIFY_CHAR_UUID)
        {
          a_ClientContext[index].P2PNotificationCharHdl = CharStartHdl;
          a_ClientContext[index].P2PNotificationValueHdl = CharValueHdl;
          LOG_INFO_APP(", ST_P2P_NOTIFY_CHAR_UUID charac found\n");
        }
        else if (uuid == ST_P2P_WRITE_CHAR_UUID)
        {
          a_ClientContext[index].P2PWriteToServerCharHdl = CharStartHdl;
          a_ClientContext[index].P2PWriteToServerValueHdl = CharValueHdl;
          LOG_INFO_APP(", ST_P2P_WRITE_CHAR_UUID charac found\n");
        }
        else if (uuid == ST_P2P_WRITE_WITH_RES_CHAR_UUID)
        {
          a_ClientContext[0].P2PWriteWithResToServerCharHdl = CharStartHdl;
          a_ClientContext[0].P2PWriteWithResToServerValueHdl = CharValueHdl;
          LOG_INFO_APP(", ST_P2P_WRITE_WITH_RES_CHAR_UUID charac found\n");
        }
[/#if]
[/#if]

/* USER CODE END gatt_parse_chars_1 */
        else
        {
          LOG_INFO_APP("\n");
        }

      }
      uuid_offset += p_evt->Handle_Value_Pair_Length;
    }
  }
  else
  {
    LOG_INFO_APP("ACI_ATT_READ_BY_TYPE_RESP_VSEVT_CODE, failed handle not found in connection table !\n");
  }

  return;
}
/**
* function of GATT descriptor parse
*/
static void gatt_parse_descs(aci_att_find_info_resp_event_rp0 *p_evt)
{
  uint16_t uuid, handle;
  uint8_t uuid_offset, uuid_size, uuid_short_offset, handle_uuid_pair_size;
  uint8_t i, numDesc, index;

  LOG_INFO_APP("ACI_ATT_FIND_INFO_RESP_VSEVT_CODE - ConnHdl=0x%04X\n",
              p_evt->Connection_Handle);

  for (index = 0 ; index < BLE_CFG_CLT_MAX_NBR_CB ; index++)
  {
    if (a_ClientContext[index].connHdl == p_evt->Connection_Handle)
    {
      break;
    }
  }

  /* index < BLE_CFG_CLT_MAX_NBR_CB means connection handle identified */
  if (index < BLE_CFG_CLT_MAX_NBR_CB)
  {
    /* event data in Attribute_Data_List contains:
    * 2 bytes handle
    * 2 or 16 bytes data for UUID
    */
    uuid_offset = 2;
    if (p_evt->Format == UUID_TYPE_16)
    {
      uuid_size = 2;
      uuid_short_offset = 0;
      handle_uuid_pair_size = 4;
    }
    else if (p_evt->Format == UUID_TYPE_128)
    {
      uuid_size = 16;
      uuid_short_offset = 12;
      handle_uuid_pair_size = 18;
    }
    else
    {
      return;
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
        LOG_INFO_APP("PRIMARY_SERVICE_UUID=0x%04X handle=0x%04X\n", uuid, handle);
      }
      else if (uuid == CHARACTERISTIC_UUID)
      {
        /* reset UUID & handle */
        gattCharStartHdl = 0;
        gattCharValueHdl = 0;

        gattCharStartHdl = handle;
        LOG_INFO_APP("reset - UUID & handle - CHARACTERISTIC_UUID=0x%04X CharStartHandle=0x%04X\n", uuid, handle);
      }
      else if ( (uuid == CHAR_EXTENDED_PROPERTIES_DESCRIPTOR_UUID)
             || (uuid == CLIENT_CHAR_CONFIG_DESCRIPTOR_UUID) )
      {

        LOG_INFO_APP("Descriptor UUID=0x%04X, handle=0x%04X-0x%04X-0x%04X",
                      uuid,
                      gattCharStartHdl,
                      gattCharValueHdl,
                      handle);
        if (a_ClientContext[index].ServiceChangedCharValueHdl == gattCharValueHdl)
        {
          a_ClientContext[index].ServiceChangedCharDescHdl = handle;
          LOG_INFO_APP(", Service Changed found\n");
        }
/* USER CODE BEGIN gatt_parse_descs_1 */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PCLIENT")]
        else if (a_ClientContext[index].P2PWriteToServerValueHdl == gattCharValueHdl)
        {
          a_ClientContext[index].P2PWriteToServerDescHdl = handle;
          LOG_INFO_APP("P2PWrite found : Desc UUID=0x%04X handle=0x%04X-0x%04X-0x%04X\n",
                       uuid, gattCharStartHdl, gattCharValueHdl, handle);
        }
        else if (a_ClientContext[index].P2PNotificationValueHdl == gattCharValueHdl)
        {
          a_ClientContext[index].P2PNotificationDescHdl = handle;
          LOG_INFO_APP("P2PNotification found : Desc UUID=0x%04X handle=0x%04X-0x%04X-0x%04X\n",
                       uuid, gattCharStartHdl, gattCharValueHdl, handle);
        }
        else if (a_ClientContext[index].P2PWriteWithResToServerValueHdl == gattCharValueHdl)
        {
          a_ClientContext[index].P2PWriteWithResToServerDescHdl = handle;
          LOG_INFO_APP("P2PWrite with Response found : Desc UUID=0x%04X handle=0x%04X-0x%04X-0x%04X\n",
                       uuid, gattCharStartHdl, gattCharValueHdl, handle);
        }
[/#if]
[/#if]
/* USER CODE END gatt_parse_descs_1 */
        else
        {
          LOG_INFO_APP("\n");
        }
        UNUSED(gattCharStartHdl);
      }
      else
      {
        gattCharValueHdl = handle;

        LOG_INFO_APP("  UUID=0x%04X, handle=0x%04X", uuid, handle);

        if (uuid == DEVICE_NAME_UUID)
        {
          LOG_INFO_APP(", found GAP DEVICE_NAME_UUID\n");
        }
        else if (uuid == APPEARANCE_UUID)
        {
          LOG_INFO_APP(", found GAP APPEARANCE_UUID\n");
        }
        else if (uuid == SERVICE_CHANGED_CHARACTERISTIC_UUID)
        {
          LOG_INFO_APP(", found GATT SERVICE_CHANGED_CHARACTERISTIC_UUID\n");
        }
/* USER CODE BEGIN gatt_parse_descs_2 */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PCLIENT")]
        else if (uuid == ST_P2P_WRITE_CHAR_UUID)
        {
          LOG_INFO_APP(", found ST_P2P_WRITE_CHAR_UUID\n");
        }
        else if (uuid == ST_P2P_NOTIFY_CHAR_UUID)
        {
          LOG_INFO_APP(", found ST_P2P_NOTIFY_CHAR_UUID\n");
        }
        else if (uuid == ST_P2P_WRITE_WITH_RES_CHAR_UUID)
        {
          LOG_INFO_APP(", found ST_P2P_WRITE_WITH_RES_CHAR_UUID\n");
        }
[/#if]
[/#if]

/* USER CODE END gatt_parse_descs_2 */
        else
        {
          LOG_INFO_APP("\n");
        }
      }
    uuid_offset += handle_uuid_pair_size;
    }
  }
  else
  {
    LOG_INFO_APP("ACI_ATT_FIND_INFO_RESP_VSEVT_CODE, failed handle not found in connection table !\n");
  }

  return;
}

static void gatt_parse_notification(aci_gatt_notification_event_rp0 *p_evt)
{
  LOG_DEBUG_APP("ACI_GATT_NOTIFICATION_VSEVT_CODE - ConnHdl=0x%04X, Attribute_Handle=0x%04X\n",
                p_evt->Connection_Handle,
                p_evt->Attribute_Handle);
/* USER CODE BEGIN gatt_parse_notification_1 */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PCLIENT")]
  GATT_CLIENT_APP_Notification_evt_t Notification;
  uint8_t index;

  for (index = 0 ; index < BLE_CFG_CLT_MAX_NBR_CB ; index++)
  {
    if (a_ClientContext[index].connHdl == p_evt->Connection_Handle)
    {
      break;
    }
  }

  /* index < BLE_CFG_CLT_MAX_NBR_CB means connection handle identified */
  if (index < BLE_CFG_CLT_MAX_NBR_CB)
  {
    if (p_evt->Attribute_Handle == a_ClientContext[index].P2PNotificationValueHdl)
    {
      LOG_INFO_APP("  Incoming Nofification received P2P Server information\n");
      Notification.Client_Evt_Opcode = P2P_NOTIFICATION_INFO_RECEIVED_EVT;
      Notification.DataTransfered.length = p_evt->Attribute_Value_Length;
      Notification.DataTransfered.p_Payload = &p_evt->Attribute_Value[0];

      gatt_Notification(&Notification);
    }
  }
  else
  {
    LOG_INFO_APP("ACI_GATT_NOTIFICATION_VSEVT_CODE, failed handle not found in connection table !\n");
  }
[/#if]
[/#if]

/* USER CODE END gatt_parse_notification_1 */

  return;
}
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]

static void client_discover_all(void)
{
  uint8_t index = 0;
  /* USER CODE BEGIN client_discover_1 */

  /* USER CODE END client_discover_1 */
  
  GATT_CLIENT_APP_Discover_services(index);
  
  /* USER CODE BEGIN client_discover_2 */

  /* USER CODE END client_discover_2 */
  return;
}
[#elseif myHash["THREADX_STATUS"]?number == 1 ]

void client_discover_all_Entry(unsigned long thread_input)
{
  UNUSED(thread_input);
  uint8_t index = 0;

  while(1)
  {
    tx_semaphore_get(&client_discover_Thread_Sem, TX_WAIT_FOREVER);

    /* USER CODE BEGIN client_discover_1 */

    /* USER CODE END client_discover_1 */
	
    GATT_CLIENT_APP_Discover_services(index);
	
    /* USER CODE BEGIN client_discover_2 */

    /* USER CODE END client_discover_2 */
  }
}
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

static void ClientDiscover_Task_Entry(void* argument)
{
  UNUSED(argument);
  uint8_t index = 0;

  while(1)
  {
    osSemaphoreAcquire(ClientDiscoverSemaphore, osWaitForever);
    /* USER CODE BEGIN client_discover_1 */

    /* USER CODE END client_discover_1 */
	
    GATT_CLIENT_APP_Discover_services(index);

    /* USER CODE BEGIN client_discover_2 */

    /* USER CODE END client_discover_2 */
	osThreadYield();
  }
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
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PCLIENT")]
static void P2Pclient_write_char(void)
{
  uint8_t index = 0;
  tBleStatus ret;

  if (P2PButtonData.level == 0x00)
  {
    P2PButtonData.level = 0x01;
  }
  else
  {
    P2PButtonData.level = 0x00;
  }

  for(index = 0; index < BLE_CFG_CLT_MAX_NBR_CB; index++)
  {
    if (a_ClientContext[index].state != GATT_CLIENT_APP_IDLE)
    {
      ret = aci_gatt_write_without_resp(a_ClientContext[index].connHdl,
                                        a_ClientContext[index].P2PWriteToServerValueHdl,
                                        2,
                                        (uint8_t *)&P2PButtonData);

      if (ret != BLE_STATUS_SUCCESS)
      {
        LOG_INFO_APP("aci_gatt_write_without_resp failed, connHdl=0x%04X, ValueHdl=0x%04X\n",
                a_ClientContext[index].connHdl,
                a_ClientContext[index].P2PWriteToServerValueHdl);
      }
      else
      {
        LOG_INFO_APP("aci_gatt_write_without_resp success, connHdl=0x%04X, ValueHdl=0x%04X\n",
          a_ClientContext[index].connHdl,
          a_ClientContext[index].P2PWriteToServerValueHdl);
      }
    }
  }

  return;
}
[/#if]
[/#if]

/* USER CODE END LF */
