[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_ble.h
  * @author  MCD Application Team
  * @brief   Header for ble application
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign PG_FILL_UCS = "False"]
[#assign PG_BSP_NUCLEO_WBA52CG = 0]
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef APP_BLE_H
#define APP_BLE_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if myHash["THREADX_STATUS"]?number == 1 ]
#include "tx_api.h"
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
#include "cmsis_os2.h"
[/#if]

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/

[#--
[#if  ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled")) && (myHash["BLE_MODE_CENTRAL"] == "Disabled") && (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
typedef enum
{
  APP_BLE_IDLE,
  APP_BLE_FAST_ADV,
  APP_BLE_LP_ADV,
  APP_BLE_SCAN,
  APP_BLE_LP_CONNECTING,
  APP_BLE_CONNECTED_SERVER,
  APP_BLE_CONNECTED_CLIENT
} APP_BLE_ConnStatus_t;
[/#if]

[#if  (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
typedef enum
{
  APP_BLE_IDLE,
  APP_BLE_FAST_ADV,
  APP_BLE_LP_ADV,
  APP_BLE_SCAN,
  APP_BLE_LP_CONNECTING,
  APP_BLE_CONNECTED_SERVER,
  APP_BLE_CONNECTED_CLIENT,

  APP_BLE_DISCOVER_SERVICES,
  APP_BLE_DISCOVER_CHARACS,
  APP_BLE_DISCOVER_WRITE_DESC,
  APP_BLE_DISCOVER_NOTIFICATION_CHAR_DESC,
  APP_BLE_ENABLE_NOTIFICATION_DESC,
  APP_BLE_DISABLE_NOTIFICATION_DESC
} APP_BLE_ConnStatus_t;
[/#if]

[#if  (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled")]
typedef enum
{
  APP_BLE_IDLE,
  APP_BLE_FAST_ADV,
  APP_BLE_LP_ADV,
  APP_BLE_SCAN,
  APP_BLE_CONNECTING,
  APP_BLE_CONNECTED,

  APP_BLE_DISCOVER_SERVICES,
  APP_BLE_DISCOVER_CHARACS,
  APP_BLE_DISCOVER_LED_CHAR_DESC,
  APP_BLE_DISCOVER_BUTTON_CHAR_DESC,
  APP_BLE_DISCOVER_NOTIFICATION_CHAR_DESC,
  APP_BLE_ENABLE_NOTIFICATION_BUTTON_DESC,
  APP_BLE_DISABLE_NOTIFICATION_TX_DESC
} APP_BLE_ConnStatus_t;
[/#if]
--]
[#if (myHash["BLE_MODE_HOST_SKELETON"] != "Enabled")]
typedef enum
{
  APP_BLE_IDLE,
  APP_BLE_LP_CONNECTING,
  APP_BLE_CONNECTED_SERVER,
  APP_BLE_CONNECTED_CLIENT,
[#if  (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
  APP_BLE_ADV_FAST,
  APP_BLE_ADV_LP,
  APP_BLE_ADV_NON_CONN_FAST,
  APP_BLE_ADV_NON_CONN_LP,
[/#if]
[#if  (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
  APP_BLE_SCANNING,
  APP_BLE_CONNECTED,
  APP_BLE_DISCOVERING_SERVICES,
  APP_BLE_DISCOVERING_CHARACS,
[/#if]
  /* USER CODE BEGIN APP_BLE_ConnStatus_t */

  /* USER CODE END APP_BLE_ConnStatus_t */
} APP_BLE_ConnStatus_t;
[/#if]

/**
  * HCI Event Packet Types
  */
typedef __PACKED_STRUCT
{
  uint32_t *next;
  uint32_t *prev;
} BleEvtPacketHeader_t;

typedef __PACKED_STRUCT
{
  uint8_t   evtcode;
  uint8_t   plen;
  uint8_t   payload[1];
} BleEvt_t;

typedef __PACKED_STRUCT
{
  uint8_t   type;
  BleEvt_t  evt;
} BleEvtSerial_t;

typedef __PACKED_STRUCT __ALIGNED(4)
{
  BleEvtPacketHeader_t  header;
  BleEvtSerial_t        evtserial;
} BleEvtPacket_t;

[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
typedef enum
{
  PROC_GAP_GEN_PHY_TOGGLE,
  PROC_GAP_GEN_CONN_TERMINATE,
  PROC_GATT_EXCHANGE_CONFIG,
  /* USER CODE BEGIN ProcGapGeneralId_t */

  /* USER CODE END ProcGapGeneralId_t */
}ProcGapGeneralId_t;
[/#if]

[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
typedef enum
{
  PROC_GAP_PERIPH_ADVERTISE_START_LP,
  PROC_GAP_PERIPH_ADVERTISE_START_FAST,
  PROC_GAP_PERIPH_ADVERTISE_NON_CONN_START_LP,
  PROC_GAP_PERIPH_ADVERTISE_NON_CONN_START_FAST,
  PROC_GAP_PERIPH_ADVERTISE_STOP,
  PROC_GAP_PERIPH_ADVERTISE_DATA_UPDATE,
  PROC_GAP_PERIPH_CONN_PARAM_UPDATE,
  /* USER CODE BEGIN ProcGapPeripheralId_t */

  /* USER CODE END ProcGapPeripheralId_t */
}ProcGapPeripheralId_t;
[/#if]

[#if ((myHash["BLE_OPTIONS_ENHANCED_ATT"] == "BLE_OPTIONS_ENHANCED_ATT") && (myHash["BLE_MODE_PERIPHERAL"] == "Enabled"))]
typedef struct
{
  uint16_t Conn_Handle;
  uint16_t Max_Transmission_Unit;
  uint16_t Max_Payload_Size;
  uint16_t Initial_Credits;
  uint16_t SPSM;
  uint8_t Channel_Number;
  uint8_t Channel_Index_List;
  uint16_t EATT_Bearer_connHdl[6];
  /* USER CODE BEGIN BleCoCEATTContext_t */

  /* USER CODE END BleCoCEATTContext_t */
}BleCoCEATTContext_t;

[/#if]
[#if ((myHash["BLE_OPTIONS_ENHANCED_ATT"] == "BLE_OPTIONS_ENHANCED_ATT") && (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
typedef enum
{
  BLE_CONN_HANDLE_EVT,
  BLE_DISCON_HANDLE_EVT,
  BLE_CONN_UPDATE_EVT,
  BLE_PAIRING_COMPLETE_EVT,
  EXCHANGE_ATT_MTU,
  BLE_SEND_DATA,
} CoC_EATT_APP_Opcode_Notification_evt_t;

typedef struct
{
  uint8_t *pPayload;
  uint32_t pPayload_n_1;
  uint32_t pPayload_n;
} CoC_Payload_t;

typedef struct
{
  CoC_EATT_APP_Opcode_Notification_evt_t     CoC_EATT_Evt_Opcode;
  CoC_Payload_t                         DataTransfered;
  uint16_t                              ConnectionHandle;
  uint8_t                               DataLength;
} COC_EATT_APP_ConnHandle_Not_evt_t;
[/#if]

[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
typedef enum
{
  PROC_GAP_CENTRAL_SCAN_START,
  PROC_GAP_CENTRAL_SCAN_TERMINATE,
  /* USER CODE BEGIN ProcGapCentralId_t */

  /* USER CODE END ProcGapCentralId_t */
}ProcGapCentralId_t;
[/#if]

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
/**
  * Event type
  */

/**
  * This the payload of TL_Evt_t for a command status event
  */
typedef __PACKED_STRUCT
{
  uint8_t   status;
  uint8_t   numcmd;
  uint16_t  cmdcode;
} TL_CsEvt_t;

/**
  * This the payload of TL_Evt_t for a command complete event
  */
typedef __PACKED_STRUCT
{
  uint8_t   numcmd;
  uint16_t  cmdcode;
  uint8_t   payload[1];
} TL_CcEvt_t;

/**
  * This the payload of TL_Evt_t for an asynchronous event
  */
typedef __PACKED_STRUCT
{
  uint16_t  subevtcode;
  uint8_t   payload[1];
} TL_AsynchEvt_t;


/**
  * LHCI Command Types
  */
typedef __PACKED_STRUCT
{
  uint32_t *next;
  uint32_t *prev;
} BleCmdPacketHeader_t;

typedef __PACKED_STRUCT
{
  uint16_t   cmdcode;
  uint8_t   plen;
  uint8_t   payload[255];
} BleCmd_t;

typedef __PACKED_STRUCT
{
  uint8_t   type;
  BleCmd_t  cmd;
} BleCmdSerial_t;

typedef __PACKED_STRUCT
{
  BleCmdPacketHeader_t  header;
  BleCmdSerial_t     cmdserial;
} BleCmdPacket_t;

[/#if]
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
#define TL_LOCCMD_PKT_TYPE             ( 0x20 )
#define TL_LOCRSP_PKT_TYPE             ( 0x21 )
#define TL_EVT_CS_PAYLOAD_SIZE         ( 4 )
[/#if]
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/

[#if myHash["THREADX_STATUS"]?number == 1 ]
extern TX_SEMAPHORE       BleHostSemaphore;
extern TX_SEMAPHORE       GapProcCompleteSemaphore;

[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
extern osSemaphoreId_t    BleHostSemaphore;
extern osSemaphoreId_t    GapProcCompleteSemaphore;

[/#if]
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
[#if (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
#define SCAN_WIN_MS(x) ((uint16_t)((x)/0.625f))
#define SCAN_INT_MS(x) ((uint16_t)((x)/0.625f))
#define CONN_INT_MS(x) ((uint16_t)((x)/1.25f))
#define CONN_SUP_TIMEOUT_MS(x) ((uint16_t)((x)/10.0f))
#define CONN_CE_LENGTH_MS(x) ((uint16_t)((x)/0.625f))

#define HCI_LE_ADVERTISING_REPORT_RSSI(p) \
        (*(int8_t*)((&((hci_le_advertising_report_event_rp0*)(p))-> \
                      Advertising_Report[0].Length_Data) + 1 + \
                    ((hci_le_advertising_report_event_rp0*)(p))-> \
                    Advertising_Report[0].Length_Data))
[/#if]
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
void APP_BLE_Init(void);
[#if  (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
APP_BLE_ConnStatus_t APP_BLE_Get_Server_Connection_Status(void);
[/#if]
[#if  (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
APP_BLE_ConnStatus_t APP_BLE_Get_Client_Connection_Status( uint16_t Connection_Handle );
[/#if]
[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
void APP_BLE_Procedure_Gap_General(ProcGapGeneralId_t ProcGapGeneralId);
[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
void APP_BLE_Procedure_Gap_Peripheral(ProcGapPeripheralId_t ProcGapPeripheralId);
[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
void APP_BLE_Procedure_Gap_Central(ProcGapCentralId_t ProcGapCentralId);
[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled")]
const uint8_t* BleGetBdAddress(void);
[/#if]
[#if ((myHash["BLE_OPTIONS_ENHANCED_ATT"] == "BLE_OPTIONS_ENHANCED_ATT") && (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
void COC_EATT_CENTRAL_APP_Notification(COC_EATT_APP_ConnHandle_Not_evt_t *pNotification);
[/#if]
[#if ((myHash["BLE_OPTIONS_ENHANCED_ATT"] == "BLE_OPTIONS_ENHANCED_ATT") && (myHash["BLE_MODE_PERIPHERAL"] == "Enabled"))]
extern BleCoCEATTContext_t BleCoCEATTContext;
[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*APP_BLE_H */
