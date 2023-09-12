[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
 * File Name          : ${name}
 * Description        : Transparent mode
 ******************************************************************************
 * [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
 ******************************************************************************
 */
/* USER CODE END Header */
[#assign FREERTOS_STATUS = 0]
[#assign CFG_UART_GUI = ""]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
            [#if (definition.name == "FREERTOS_STATUS") && (definition.value == "1")]
                [#assign FREERTOS_STATUS = 1]
            [/#if]
            [#if (definition.name == "CFG_UART_GUI")  && (definition.value != "0")]
                [#assign CFG_UART_GUI = definition.value]
            [/#if]
        [/#list]
	[/#if]
[/#list]

/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "app_common.h"
#include "tl.h"
#include "mbox_def.h"
#include "lhci.h"
#include "shci.h"
#include "stm_list.h"
#include "tm.h"
#include "lpm.h"
#include "shci_tl.h"
#include "scheduler.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
typedef enum
{
  LOW_POWER_MODE_DISABLE,
  LOW_POWER_MODE_ENABLE,
}LowPowerModeStatus_t;

typedef enum
{
  WAITING_TYPE,
  WAITING_LENGTH,
  WAITING_PAYLOAD
}HciReceiveStatus_t;

typedef enum
{
  TX_ONGOING,
  TX_DONE
}HostTxStatus_t;
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macros -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
PLACE_IN_SECTION("MB_MEM2") static TL_CmdPacket_t BleCmdBuffer;
PLACE_IN_SECTION("MB_MEM2") static uint8_t HciAclDataBuffer[sizeof(TL_PacketHeader_t) + 5 + 251];

static uint8_t RxHostData[5];
static HciReceiveStatus_t HciReceiveStatus;
static TL_CmdPacket_t SysLocalCmd;
static uint8_t *pHostRx;
static tListNode  HostTxQueue;
static TL_EvtPacket_t *pTxToHostPacket;
static HostTxStatus_t HostTxStatus;
static MB_RefTable_t * p_RefTable;
static uint8_t SysLocalCmdStatus;
static LowPowerModeStatus_t LowPowerModeStatus;
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
static void RxCpltCallback(void);
static void HostTxCb( void );
static void TM_SysLocalCmd( void );
static void TM_TxToHost( void );
static void TM_BleEvtRx( TL_EvtPacket_t *phcievt );
static void TM_AclDataAck( void );
#if (CFG_HW_LPUART1_ENABLED == 1)
extern void MX_LPUART1_UART_Init(void);
#endif
#if (CFG_HW_USART1_ENABLED == 1)
extern void MX_USART1_UART_Init(void);
#endif
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Functions Definition ------------------------------------------------------*/
void TM_Init( void  )
{
/* USER CODE BEGIN TM_Init_1 */

/* USER CODE END TM_Init_1 */
  TL_BLE_InitConf_t tl_ble_init_conf;
  uint32_t ipccdba;
  SHCI_C2_Ble_Init_Cmd_Packet_t ble_init_cmd_packet =
  {
    {{0,0,0}},                          /**< Header unused */
    {0,                                 /** pBleBufferAddress not used */
    0,                                  /** BleBufferSize not used */
    CFG_BLE_NUM_GATT_ATTRIBUTES,
    CFG_BLE_NUM_GATT_SERVICES,
    CFG_BLE_ATT_VALUE_ARRAY_SIZE,
    CFG_BLE_NUM_LINK,
    CFG_BLE_DATA_LENGTH_EXTENSION,
    CFG_BLE_PREPARE_WRITE_LIST_SIZE,
    CFG_BLE_MBLOCK_COUNT,
    CFG_BLE_MAX_ATT_MTU,
    CFG_BLE_SLAVE_SCA,
    CFG_BLE_MASTER_SCA,
    CFG_BLE_LSE_SOURCE,
    CFG_BLE_MAX_CONN_EVENT_LENGTH,
    CFG_BLE_HSE_STARTUP_TIME,
    CFG_BLE_VITERBI_MODE,
    CFG_BLE_LL_ONLY,
    0}                                  /** TODO Should be read from HW */
  };



  ipccdba = READ_BIT( FLASH->IPCCBR, FLASH_IPCCBR_IPCCDBA );
  p_RefTable = (MB_RefTable_t*)((ipccdba<<2) + SRAM2A_BASE);

  tl_ble_init_conf.p_cmdbuffer = (uint8_t*)&BleCmdBuffer;
  tl_ble_init_conf.p_AclDataBuffer = HciAclDataBuffer;
  tl_ble_init_conf.IoBusEvtCallBack = TM_BleEvtRx;
  tl_ble_init_conf.IoBusAclDataTxAck = TM_AclDataAck;
  TL_BLE_Init( (void*) &tl_ble_init_conf );

  LPM_SetOffMode(1 << CFG_LPM_APP, LPM_OffMode_Dis);
  LPM_SetStopMode( 1<<CFG_LPM_APP, LPM_StopMode_Dis);
  LowPowerModeStatus = LOW_POWER_MODE_DISABLE;

  SysLocalCmdStatus = 0;

  SHCI_C2_BLE_Init( &ble_init_cmd_packet );

  SCH_RegTask( CFG_TASK_SYS_LOCAL_CMD_ID, TM_SysLocalCmd);
  SCH_RegTask( CFG_TASK_BLE_HCI_CMD_ID, (void (*)( void )) TL_BLE_SendCmd);
  SCH_RegTask( CFG_TASK_TX_TO_HOST_ID, TM_TxToHost);
  SCH_RegTask( CFG_TASK_SYS_HCI_CMD_ID, (void (*)( void )) TL_SYS_SendCmd);
  SCH_RegTask( CFG_TASK_HCI_ACL_DATA_ID, (void (*)( void )) TL_BLE_SendAclData);

  HostTxStatus = TX_DONE;
  pTxToHostPacket = 0;

  LST_init_head (&HostTxQueue);

[#if CFG_UART_GUI = "hw_lpuart1" ]
  MX_LPUART1_UART_Init();
[/#if]
[#if CFG_UART_GUI = "hw_uart1" ]
  MX_USART1_UART_Init();
[/#if]

  pHostRx = RxHostData;
  HciReceiveStatus = WAITING_TYPE;

  HW_UART_Receive_IT(CFG_UART_GUI, pHostRx, 1, RxCpltCallback);

/* USER CODE BEGIN TM_Init_2 */

/* USER CODE END TM_Init_2 */
  return;
}

void TM_SysCmdRspCb (TL_EvtPacket_t * p_cmd_resp)
{
/* USER CODE BEGIN TM_SysCmdRspCb_1 */

/* USER CODE END TM_SysCmdRspCb_1 */
  if(SysLocalCmdStatus != 0)
  {
    SysLocalCmdStatus = 0;
    SCH_SetEvt( 1<< CFG_IDLEEVT_SYSTEM_HCI_CMD_EVT_RSP_ID );
  }
  else
  {
    LST_insert_tail (&HostTxQueue, (tListNode *)p_cmd_resp);

    SCH_SetTask( 1<<CFG_TASK_TX_TO_HOST_ID,CFG_SCH_PRIO_0);
  }
/* USER CODE BEGIN TM_SysCmdRspCb_2 */

/* USER CODE END TM_SysCmdRspCb_2 */
  return;
}

/* USER CODE BEGIN FD */

/* USER CODE END FD */

/*************************************************************
 *
 * LOCAL FUNCTIONS
 *
 *************************************************************/
static void TM_TxToHost( void )
{
  BACKUP_PRIMASK();

  if(HostTxStatus == TX_DONE)
  {
    HostTxStatus = TX_ONGOING;

    LST_remove_head( &HostTxQueue, (tListNode **)&pTxToHostPacket );

    if(LowPowerModeStatus == LOW_POWER_MODE_DISABLE)
    {
      if(pTxToHostPacket->evtserial.type == TL_ACL_DATA_PKT_TYPE)
      {
        /**
         * The uart interrupt shall be disable when the HAL is called to send data
         * This is because in the Rx uart handler, the HAL is called to receive new data
         */
        DISABLE_IRQ();
        HW_UART_Transmit_IT(CFG_UART_GUI, (uint8_t *)&((TL_AclDataPacket_t *)pTxToHostPacket)->AclDataSerial, ((TL_AclDataPacket_t *)pTxToHostPacket)->AclDataSerial.length + 5, HostTxCb);
        RESTORE_PRIMASK();
      }
      else
      {
        /**
         * The uart interrupt shall be disable when the HAL is called to send data
         * This is because in the Rx uart handler, the HAL is called to receive new data
         */
        DISABLE_IRQ();
        HW_UART_Transmit_IT(CFG_UART_GUI, (uint8_t *)&pTxToHostPacket->evtserial, pTxToHostPacket->evtserial.evt.plen + TL_EVT_HDR_SIZE, HostTxCb);
        RESTORE_PRIMASK();
      }
    }
    else
    {
      HostTxCb( );
    }
  }

  return;
}

static void TM_SysLocalCmd ( void )
{
  switch( SysLocalCmd.cmdserial.cmd.cmdcode )
  {
    case LHCI_OPCODE_C1_WRITE_REG:
      LHCI_C1_Write_Register( &SysLocalCmd );
      break;

    case LHCI_OPCODE_C1_READ_REG:
      LHCI_C1_Read_Register( &SysLocalCmd );
      break;

    case LHCI_OPCODE_C1_DEVICE_INF:
      LHCI_C1_Read_Device_Information( &SysLocalCmd );
      break;

    default:
      ((TL_CcEvt_t *)(((TL_EvtPacket_t*)&SysLocalCmd)->evtserial.evt.payload))->cmdcode = SysLocalCmd.cmdserial.cmd.cmdcode;
      ((TL_CcEvt_t *)(((TL_EvtPacket_t*)&SysLocalCmd)->evtserial.evt.payload))->payload[0] = 0x01;
      ((TL_CcEvt_t *)(((TL_EvtPacket_t*)&SysLocalCmd)->evtserial.evt.payload))->numcmd = 1;
      ((TL_EvtPacket_t*)&SysLocalCmd)->evtserial.type = TL_BLEEVT_PKT_TYPE;
      ((TL_EvtPacket_t*)&SysLocalCmd)->evtserial.evt.evtcode = TL_BLEEVT_CC_OPCODE;
      ((TL_EvtPacket_t*)&SysLocalCmd)->evtserial.evt.plen = TL_EVT_CS_PAYLOAD_SIZE;

      break;
  }

  LST_insert_tail (&HostTxQueue, (tListNode *)&SysLocalCmd);
  SCH_SetTask( 1<<CFG_TASK_TX_TO_HOST_ID,CFG_SCH_PRIO_0);

  return;
}

static void RxCpltCallback( void )
{
  uint16_t nb_bytes_to_receive;
  uint16_t buffer_index;
  uint8_t packet_indicator;

  switch (HciReceiveStatus)
  {
    case WAITING_TYPE:
    {
      packet_indicator = pHostRx[0];
      switch(packet_indicator)
      {
        case TL_BLECMD_PKT_TYPE:
        case TL_SYSCMD_PKT_TYPE:
        case TL_LOCCMD_PKT_TYPE:
          HciReceiveStatus = WAITING_LENGTH;
          nb_bytes_to_receive = 3;
          buffer_index = 1;
          break;

        case TL_ACL_DATA_PKT_TYPE:
          HciReceiveStatus = WAITING_LENGTH;
          nb_bytes_to_receive = 4;
          buffer_index = 1;
          break;

        default:
          nb_bytes_to_receive = 1;
          buffer_index = 0;
          break;
      }
    }
    break;

    case WAITING_LENGTH:
      packet_indicator = pHostRx[0];

      switch( packet_indicator )
      {
        case TL_SYSCMD_PKT_TYPE:
          nb_bytes_to_receive = pHostRx[3];
          pHostRx = (uint8_t*)&(((TL_CmdPacket_t*)(p_RefTable->p_sys_table->pcmd_buffer))->cmdserial);
          memcpy(pHostRx, RxHostData, 4);
          buffer_index = 4;
          break;

        case TL_LOCCMD_PKT_TYPE:
          nb_bytes_to_receive = pHostRx[3];
          pHostRx = (uint8_t*)&SysLocalCmd.cmdserial;
          memcpy(pHostRx, RxHostData, 4);
          buffer_index = 4;
          break;

        case TL_ACL_DATA_PKT_TYPE:
          nb_bytes_to_receive = pHostRx[3] + (pHostRx[4] << 8);
          pHostRx = (uint8_t*)&(((TL_AclDataPacket_t*)(p_RefTable->p_ble_table->phci_acl_data_buffer))->AclDataSerial);
          memcpy(pHostRx, RxHostData, 5);
          buffer_index = 5;
          break;

        default:
          nb_bytes_to_receive = pHostRx[3];
          pHostRx = (uint8_t*)&(((TL_CmdPacket_t*)(p_RefTable->p_ble_table->pcmd_buffer))->cmdserial);
          memcpy(pHostRx, RxHostData, 4);
          buffer_index = 4;
          break;
      }

      if(nb_bytes_to_receive)
      {
        HciReceiveStatus = WAITING_PAYLOAD;
      }
      else
      {
        switch ( packet_indicator )
        {
          case TL_SYSCMD_PKT_TYPE:
            SCH_SetTask( 1<<CFG_TASK_SYS_HCI_CMD_ID,CFG_SCH_PRIO_0);
            break;

          case TL_LOCCMD_PKT_TYPE:
            SCH_SetTask( 1<<CFG_TASK_SYS_LOCAL_CMD_ID,CFG_SCH_PRIO_0);
            break;

          case TL_ACL_DATA_PKT_TYPE:
            SCH_SetTask( 1<<CFG_TASK_HCI_ACL_DATA_ID,CFG_SCH_PRIO_0);
            break;

          default:
            SCH_SetTask( 1<<CFG_TASK_BLE_HCI_CMD_ID,CFG_SCH_PRIO_0);
            break;
        }

        HciReceiveStatus = WAITING_TYPE;
        nb_bytes_to_receive = 1;
        buffer_index = 0;
        pHostRx = RxHostData;
      }
      break;

        case WAITING_PAYLOAD:
          packet_indicator = pHostRx[0];

          switch ( packet_indicator )
          {
            case TL_SYSCMD_PKT_TYPE:
              SCH_SetTask( 1<<CFG_TASK_SYS_HCI_CMD_ID,CFG_SCH_PRIO_0);
              break;

            case TL_LOCCMD_PKT_TYPE:
              SCH_SetTask( 1<<CFG_TASK_SYS_LOCAL_CMD_ID,CFG_SCH_PRIO_0);
              break;

            case TL_ACL_DATA_PKT_TYPE:
              SCH_SetTask( 1<<CFG_TASK_HCI_ACL_DATA_ID,CFG_SCH_PRIO_0);
              break;

            default:
              SCH_SetTask( 1<<CFG_TASK_BLE_HCI_CMD_ID,CFG_SCH_PRIO_0);
              break;
          }

          HciReceiveStatus = WAITING_TYPE;
          nb_bytes_to_receive = 1;
          buffer_index = 0;
          pHostRx = RxHostData;

          break;

            default:
              break;
  }

  HW_UART_Receive_IT(CFG_UART_GUI, &pHostRx[buffer_index], nb_bytes_to_receive, RxCpltCallback);

  return;
}

static void HostTxCb( void )
{
  HostTxStatus = TX_DONE;

  if( (pTxToHostPacket >= (TL_EvtPacket_t *)(p_RefTable->p_mem_manager_table->blepool)) && (pTxToHostPacket < ( (TL_EvtPacket_t *)((p_RefTable->p_mem_manager_table->blepool) + p_RefTable->p_mem_manager_table->blepoolsize))))
  {
    TL_MM_EvtDone(pTxToHostPacket);
  }

  if ( LST_is_empty( &HostTxQueue ) == FALSE )
  {
    SCH_SetTask( 1<<CFG_TASK_TX_TO_HOST_ID,CFG_SCH_PRIO_0 );
  }

  return;
}

static void TM_BleEvtRx( TL_EvtPacket_t *phcievt )
{
  LST_insert_tail ( &HostTxQueue, (tListNode *)phcievt );

  SCH_SetTask( 1<<CFG_TASK_TX_TO_HOST_ID,CFG_SCH_PRIO_0 );

  return;
}

static void TM_AclDataAck( void )
{
  /**
   * The current implementation assumes the GUI will not send a new HCI ACL DATA packet before this ack is received
   * ( which means the CPU2 has handled the previous packet )
   * In order to implement a secure mechanism, it is required either
   * - a flow control with the GUI
   * - a local pool of buffer to store packets received from the GUI
   */
  return;
}

/* USER CODE BEGIN FD_LOCAL_FUNCTIONS*/

/* USER CODE END FD_LOCAL_FUNCTIONS*/
/*************************************************************
 *
 * WRAP FUNCTIONS
 *
 *************************************************************/
void shci_send( TL_CmdPacket_t * p_cmd, TL_EvtPacket_t * p_rsp )
{
  TL_CmdPacket_t *p_cmd_buffer;

  SysLocalCmdStatus = 1;

  p_cmd_buffer = (TL_CmdPacket_t *)(p_RefTable->p_sys_table->pcmd_buffer);

  memcpy( p_cmd_buffer, p_cmd, p_cmd->cmdserial.cmd.plen + sizeof( TL_PacketHeader_t ) + TL_CMD_HDR_SIZE );

  TL_SYS_SendCmd( 0, 0 );

  SCH_WaitEvt( 1<< CFG_IDLEEVT_SYSTEM_HCI_CMD_EVT_RSP_ID );

  memcpy( &(p_rsp->evtserial), &(p_cmd_buffer->cmdserial), ((TL_EvtPacket_t*)p_cmd_buffer)->evtserial.evt.plen + TL_BLEEVT_CS_PACKET_SIZE );

  return;
}

/* USER CODE BEGIN FD_WRAP_FUNCTIONS*/

/* USER CODE END FD_WRAP_FUNCTIONS*/

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/