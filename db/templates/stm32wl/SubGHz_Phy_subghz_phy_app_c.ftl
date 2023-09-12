[#ftl]
[#--
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                ${definition.name}: ${definition.value}
            [/#list]
        [/#if]
    [/#list]
[/#if]
--]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
[#assign SUBGHZ_APPLICATION = ""]
[#assign FILL_UCS = ""]
[#assign INTERNAL_USER_SUBGHZ_APP = ""]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "SUBGHZ_APPLICATION"]
                    [#assign SUBGHZ_APPLICATION = definition.value]
                [/#if]
                [#if definition.name == "FILL_UCS"]
                    [#assign FILL_UCS = definition.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    subghz_phy_app.c
  * @author  MCD Application Team
  * @brief   Application of the SubGHz_Phy Middleware
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "platform.h"
#include "sys_app.h"
#include "subghz_phy_app.h"
#include "radio.h"
[#if THREADX??][#-- If AzRtos is used --]
#include "app_azure_rtos.h"
#include "tx_api.h"
[/#if]

/* USER CODE BEGIN Includes */
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (FILL_UCS == "true")]
#include "stm32_timer.h"
[#if !THREADX??][#-- If AzRtos is not used --]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
#include "stm32_seq.h"
[#else]
#include "cmsis_os.h"
[/#if]
[/#if]
#include "utilities_def.h"
#include "app_version.h"
[#if CPUCORE == ""]
#include "subghz_phy_version.h"
[/#if]
[#if (CPUCORE == "CM4")]
#include "mbmuxif_sys.h"
[/#if]
[/#if]
/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
[#if THREADX??][#-- If AzRtos is used --]
extern TX_THREAD App_MainThread;
extern  TX_BYTE_POOL *byte_pool;
extern  CHAR *pointer;
[/#if]
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/

/* USER CODE BEGIN PTD */
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG") && (FILL_UCS == "true")]
typedef enum
{
  RX,
  RX_TIMEOUT,
  RX_ERROR,
  TX,
  TX_TIMEOUT,
} States_t;
[/#if]
/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
/* Configurations */
/*Timeout*/
#define RX_TIMEOUT_VALUE              3000
#define TX_TIMEOUT_VALUE              3000
/* PING string*/
#define PING "PING"
/* PONG string*/
#define PONG "PONG"
/*Size of the payload to be sent*/
/* Size must be greater of equal the PING and PONG*/
#define MAX_APP_BUFFER_SIZE          255
#if (PAYLOAD_LEN > MAX_APP_BUFFER_SIZE)
#error PAYLOAD_LEN must be less or equal than MAX_APP_BUFFER_SIZE
#endif /* (PAYLOAD_LEN > MAX_APP_BUFFER_SIZE) */
/* wait for remote to be in Rx, before sending a Tx frame*/
#define RX_TIME_MARGIN                200
/* Afc bandwidth in Hz */
#define FSK_AFC_BANDWIDTH             83333
/* LED blink Period*/
#define LED_PERIOD_MS                 200
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
/* Configurations */
/*Timeout*/
#define RX_TIMEOUT_VALUE              2000
#define TX_TIMEOUT_VALUE              3000
/* Definitions */
#define RX_CONTINUOUS_ON              1
#define RADIO_TX                      0 /* do not change*/
#define RADIO_RX                      1 /* do not change*/
#define PRBS9_INIT                    ( ( uint16_t) 2 )

/* Test Configurations */
/*if TEST_MODE is RADIO_TX, board will send packet indefinitely*/
/*if TEST_MODE is RADIO_RX, board will receive packet indefinitely*/
#define TEST_MODE                     RADIO_TX

/* 0: Tx Long packet disable*/
/* 1: Tx Long packet enable(payload can be greater than 255bytes. Available on stm32wl revision Y)*/
#define APP_LONG_PACKET               0
/* Application buffer, can be increased further*/
#define MAX_APP_BUFFER_SIZE 1000
#if (PAYLOAD_LEN>MAX_APP_BUFFER_SIZE)
#error increase MAX_APP_BUFFER_SIZE
#endif /* (PAYLOAD_LEN>MAX_APP_BUFFER_SIZE) */

#if ((APP_LONG_PACKET==0) && PAYLOAD_LEN>255)
#error in case PAYLOAD_LEN>255, APP_LONG_PACKET shall be defined to 1
#endif /* ((APP_LONG_PACKET==0) && PAYLOAD_LEN>255) */
[/#if]
[/#if]
/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/* Radio events function pointer */
static RadioEvents_t RadioEvents;
/* USER CODE BEGIN PV */

[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
/*Ping Pong FSM states */
static States_t State = RX;
/* App Rx Buffer*/
static uint8_t BufferRx[MAX_APP_BUFFER_SIZE];
/* App Tx Buffer*/
static uint8_t BufferTx[MAX_APP_BUFFER_SIZE];
/* Last  Received Buffer Size*/
uint16_t RxBufferSize = 0;
/* Last  Received packer Rssi*/
int8_t RssiValue = 0;
/* Last  Received packer SNR (in Lora modulation)*/
int8_t SnrValue = 0;
/* Led Timers objects*/
static UTIL_TIMER_Object_t timerLed;
/* device state. Master: true, Slave: false*/
bool isMaster = true;
/* random delay to make sure 2 devices will sync*/
/* the closest the random delays are, the longer it will
   take for the devices to sync when started simultaneously*/
static int32_t random_delay;
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
static __IO uint32_t RadioTxDone_flag = 0;
static __IO uint32_t RadioTxTimeout_flag = 0;
static __IO uint32_t RadioRxDone_flag = 0;
static __IO uint32_t RadioRxTimeout_flag = 0;
static __IO uint32_t RadioError_flag = 0;
static __IO int16_t last_rx_rssi = 0;
static __IO int8_t last_rx_cfo = 0;

uint8_t data_buffer[MAX_APP_BUFFER_SIZE] UTIL_MEM_ALIGN(4);
uint16_t data_offset = 0;

static __IO uint16_t payloadLen = PAYLOAD_LEN;

static uint8_t syncword[] = { 0xC1, 0x94, 0xC1};

uint32_t count_RxOk = 0;
uint32_t count_RxKo = 0;
uint32_t PER = 0;

static int packetCnt = 0;

/* TxPayloadMode
 * 0: byte Inc e.g payload=0x00, 0x01, ..,payloadLen-1
 * 1: prbs9  */
static __IO uint8_t TxPayloadMode = 0;
[/#if]
[/#if]
/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/*!
 * @brief Function to be executed on Radio Tx Done event
 */
static void OnTxDone(void);

/**
  * @brief Function to be executed on Radio Rx Done event
  * @param  payload ptr of buffer received
  * @param  size buffer size
  * @param  rssi
  * @param  LoraSnr_FskCfo
  */
static void OnRxDone(uint8_t *payload, uint16_t size, int16_t rssi, int8_t LoraSnr_FskCfo);

/**
  * @brief Function executed on Radio Tx Timeout event
  */
static void OnTxTimeout(void);

/**
  * @brief Function executed on Radio Rx Timeout event
  */
static void OnRxTimeout(void);

/**
  * @brief Function executed on Radio Rx Error event
  */
static void OnRxError(void);

/* USER CODE BEGIN PFP */
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
/**
  * @brief  Function executed on when led timer elapses
  * @param  context ptr of LED context
  */
static void OnledEvent(void *context);

/**
  * @brief PingPong state machine implementation
  */
static void PingPong_Process(void);
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
/**
  * @brief Packet Error Rate state machine implementation
  */
static void Per_Process(void);

#if (TEST_MODE == RADIO_TX)
/**
  * @brief Generates a PRBS9 sequence
  * @retval 0
  */
static int32_t tx_payload_generator(void);
#endif /* TEST_MODE == RADIO_TX */

#if (APP_LONG_PACKET != 0)
/**
  * @brief Process next Tx chunk of payload
  * @param buffer
  * @param buffer_size
  */
void TxLongPacketGetNextChunk(uint8_t **buffer, uint8_t buffer_size);

/**
  * @brief Process next Rx chunk of payload
  * @param buffer
  * @param chunk_size
  */
void RxLongPacketChunk(uint8_t *buffer, uint8_t chunk_size);
#endif /* APP_LONG_PACKET != 0 */
[/#if]
[/#if]
/* USER CODE END PFP */

/* Exported functions ---------------------------------------------------------*/
void SubghzApp_Init(void)
{
  /* USER CODE BEGIN SubghzApp_Init_1 */
[#if (CPUCORE == "CM4") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (FILL_UCS == "true")]
  FEAT_INFO_Param_t *p_cm0plus_specific_features_info;
  uint32_t feature_version = 0UL;
[/#if]

[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
  APP_LOG(TS_OFF, VLEVEL_M, "\n\rPING PONG\n\r");
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
#if (TEST_MODE == RADIO_RX)
  RxConfigGeneric_t RxConfig = {0};
#elif (TEST_MODE == RADIO_TX)
  TxConfigGeneric_t TxConfig;
#else
#endif /* TEST_MODE */
[/#if]
[#if CPUCORE == "CM4"]
  /* Get CM4 SubGHY_Phy APP version*/
  APP_LOG(TS_OFF, VLEVEL_M, "M4 APP_VERSION:      V%X.%X.%X\r\n",
          (uint8_t)(APP_VERSION_MAIN),
          (uint8_t)(APP_VERSION_SUB1),
          (uint8_t)(APP_VERSION_SUB2));

  /* Get CM0 SubGHY_Phy APP version*/
  p_cm0plus_specific_features_info = MBMUXIF_SystemGetFeatCapabInfoPtr(FEAT_INFO_SYSTEM_ID);
  feature_version = p_cm0plus_specific_features_info->Feat_Info_Feature_Version;
  APP_LOG(TS_OFF, VLEVEL_M, "M0PLUS_APP_VERSION:  V%X.%X.%X\r\n",
          (uint8_t)(feature_version >> 24),
          (uint8_t)(feature_version >> 16),
          (uint8_t)(feature_version >> 8));

  /* Get MW SubGhz_Phy info */
  p_cm0plus_specific_features_info = MBMUXIF_SystemGetFeatCapabInfoPtr(FEAT_INFO_RADIO_ID);
  feature_version = p_cm0plus_specific_features_info->Feat_Info_Feature_Version;
  APP_LOG(TS_OFF, VLEVEL_M, "MW_RADIO_VERSION:    V%X.%X.%X\r\n",
          (uint8_t)(feature_version >> 24),
          (uint8_t)(feature_version >> 16),
          (uint8_t)(feature_version >> 8));
[#else]
  /* Get SubGHY_Phy APP version*/
  APP_LOG(TS_OFF, VLEVEL_M, "APPLICATION_VERSION: V%X.%X.%X\r\n",
          (uint8_t)(APP_VERSION_MAIN),
          (uint8_t)(APP_VERSION_SUB1),
          (uint8_t)(APP_VERSION_SUB2));

  /* Get MW SubGhz_Phy info */
  APP_LOG(TS_OFF, VLEVEL_M, "MW_RADIO_VERSION:    V%X.%X.%X\r\n",
          (uint8_t)(SUBGHZ_PHY_VERSION_MAIN),
          (uint8_t)(SUBGHZ_PHY_VERSION_SUB1),
          (uint8_t)(SUBGHZ_PHY_VERSION_SUB2));
[/#if]

[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
  /* Led Timers*/
  UTIL_TIMER_Create(&timerLed, LED_PERIOD_MS, UTIL_TIMER_ONESHOT, OnledEvent, NULL);
  UTIL_TIMER_Start(&timerLed);
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
  APP_LOG(TS_OFF, VLEVEL_M, "---------------\n\r");
  APP_LOG(TS_OFF, VLEVEL_M, "FSK_MODULATION\n\r");
  APP_LOG(TS_OFF, VLEVEL_M, "FSK_BW=%d Hz\n\r", FSK_BANDWIDTH);
  APP_LOG(TS_OFF, VLEVEL_M, "FSK_DR=%d bits/s\n\r", FSK_DATARATE);
#if (TEST_MODE == RADIO_RX)
  APP_LOG(TS_OFF, VLEVEL_M, "Rx Mode\n\r", FSK_DATARATE);
#elif (TEST_MODE == RADIO_TX)
  APP_LOG(TS_OFF, VLEVEL_M, "Tx Mode\n\r", FSK_DATARATE);
#endif /* TEST_MODE */
[/#if]
[/#if]
  /* USER CODE END SubghzApp_Init_1 */

  /* Radio initialization */
  RadioEvents.TxDone = OnTxDone;
  RadioEvents.RxDone = OnRxDone;
  RadioEvents.TxTimeout = OnTxTimeout;
  RadioEvents.RxTimeout = OnRxTimeout;
  RadioEvents.RxError = OnRxError;

  Radio.Init(&RadioEvents);

  /* USER CODE BEGIN SubghzApp_Init_2 */
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
  /*calculate random delay for synchronization*/
  random_delay = (Radio.Random()) >> 22; /*10bits random e.g. from 0 to 1023 ms*/

[/#if]
  /* Radio Set frequency */
  Radio.SetChannel(RF_FREQUENCY);

[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
  /* Radio configuration */
#if ((USE_MODEM_LORA == 1) && (USE_MODEM_FSK == 0))
  APP_LOG(TS_OFF, VLEVEL_M, "---------------\n\r");
  APP_LOG(TS_OFF, VLEVEL_M, "LORA_MODULATION\n\r");
  APP_LOG(TS_OFF, VLEVEL_M, "LORA_BW=%d kHz\n\r", (1 << LORA_BANDWIDTH) * 125);
  APP_LOG(TS_OFF, VLEVEL_M, "LORA_SF=%d\n\r", LORA_SPREADING_FACTOR);

  Radio.SetTxConfig(MODEM_LORA, TX_OUTPUT_POWER, 0, LORA_BANDWIDTH,
                    LORA_SPREADING_FACTOR, LORA_CODINGRATE,
                    LORA_PREAMBLE_LENGTH, LORA_FIX_LENGTH_PAYLOAD_ON,
                    true, 0, 0, LORA_IQ_INVERSION_ON, TX_TIMEOUT_VALUE);

  Radio.SetRxConfig(MODEM_LORA, LORA_BANDWIDTH, LORA_SPREADING_FACTOR,
                    LORA_CODINGRATE, 0, LORA_PREAMBLE_LENGTH,
                    LORA_SYMBOL_TIMEOUT, LORA_FIX_LENGTH_PAYLOAD_ON,
                    0, true, 0, 0, LORA_IQ_INVERSION_ON, true);

  Radio.SetMaxPayloadLength(MODEM_LORA, MAX_APP_BUFFER_SIZE);

#elif ((USE_MODEM_LORA == 0) && (USE_MODEM_FSK == 1))
  APP_LOG(TS_OFF, VLEVEL_M, "---------------\n\r");
  APP_LOG(TS_OFF, VLEVEL_M, "FSK_MODULATION\n\r");
  APP_LOG(TS_OFF, VLEVEL_M, "FSK_BW=%d Hz\n\r", FSK_BANDWIDTH);
  APP_LOG(TS_OFF, VLEVEL_M, "FSK_DR=%d bits/s\n\r", FSK_DATARATE);

  Radio.SetTxConfig(MODEM_FSK, TX_OUTPUT_POWER, FSK_FDEV, 0,
                    FSK_DATARATE, 0,
                    FSK_PREAMBLE_LENGTH, FSK_FIX_LENGTH_PAYLOAD_ON,
                    true, 0, 0, 0, TX_TIMEOUT_VALUE);

  Radio.SetRxConfig(MODEM_FSK, FSK_BANDWIDTH, FSK_DATARATE,
                    0, FSK_AFC_BANDWIDTH, FSK_PREAMBLE_LENGTH,
                    0, FSK_FIX_LENGTH_PAYLOAD_ON, 0, true,
                    0, 0, false, true);

  Radio.SetMaxPayloadLength(MODEM_FSK, MAX_APP_BUFFER_SIZE);

#else
#error "Please define a modulation in the subghz_phy_app.h file."
#endif /* USE_MODEM_LORA | USE_MODEM_FSK */

  /*fills tx buffer*/
  memset(BufferTx, 0x0, MAX_APP_BUFFER_SIZE);

  APP_LOG(TS_ON, VLEVEL_L, "rand=%d\n\r", random_delay);
  /*starts reception*/
  Radio.Rx(RX_TIMEOUT_VALUE + random_delay);

[#if THREADX??][#-- If AzRtos is used --]
  /* No need to allocate the stack and create thread for SubGHz_Phy_App_Process. */
  /* App_MainThread is used for it (see app_sigfox.c)  */
[#else][#-- not THREADX--]
  /*register task to to be run in while(1) after Radio IT*/
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), UTIL_SEQ_RFU, PingPong_Process);
[/#if]
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
  data_offset = 0;
#if (TEST_MODE == RADIO_RX)
  APP_TPRINTF("Rx FSK Test\r\n");
  /* RX Continuous */
  RxConfig.fsk.ModulationShaping = RADIO_FSK_MOD_SHAPING_G_BT_05;
  RxConfig.fsk.Bandwidth = FSK_BANDWIDTH;
  RxConfig.fsk.BitRate = FSK_DATARATE; /*BitRate*/
  RxConfig.fsk.PreambleLen = 4; /*in Byte*/
  RxConfig.fsk.SyncWordLength = sizeof(syncword); /*in Byte*/
  RxConfig.fsk.PreambleMinDetect = RADIO_FSK_PREAMBLE_DETECTOR_08_BITS;
  RxConfig.fsk.SyncWord = syncword; /*SyncWord Buffer*/
  RxConfig.fsk.whiteSeed = 0x01FF; /*WhiteningSeed*/
#if (APP_LONG_PACKET==0)
  RxConfig.fsk.LengthMode  = RADIO_FSK_PACKET_VARIABLE_LENGTH; /* legacy: payload length field is 1 byte long*/
#else
  RxConfig.fsk.LengthMode  = RADIO_FSK_PACKET_2BYTES_LENGTH;  /* payload length field is 2 bytes long */
#endif /* APP_LONG_PACKET */
  RxConfig.fsk.CrcLength = RADIO_FSK_CRC_2_BYTES_IBM;       /* Size of the CRC block in the GFSK packet*/
  RxConfig.fsk.CrcPolynomial = 0x8005;
  RxConfig.fsk.CrcSeed = 0xFFFF;
  RxConfig.fsk.Whitening = RADIO_FSK_DC_FREEWHITENING;
  RxConfig.fsk.MaxPayloadLength = MAX_APP_BUFFER_SIZE;
  RxConfig.fsk.StopTimerOnPreambleDetect = 0;
  RxConfig.fsk.AddrComp = RADIO_FSK_ADDRESSCOMP_FILT_OFF;
  if (0UL != Radio.RadioSetRxGenericConfig(GENERIC_FSK, &RxConfig, RX_CONTINUOUS_ON, 0))
  {
    while (1);
  }
#if (APP_LONG_PACKET==0)
  Radio.Rx(RX_TIMEOUT_VALUE);
#else
  (void) Radio.ReceiveLongPacket(0, RX_TIMEOUT_VALUE, RxLongPacketChunk);
#endif /* APP_LONG_PACKET */

#elif (TEST_MODE == RADIO_TX)
  tx_payload_generator();

  /*fsk modulation*/
  TxConfig.fsk.ModulationShaping = RADIO_FSK_MOD_SHAPING_G_BT_05;
  TxConfig.fsk.FrequencyDeviation = FSK_FDEV;
  TxConfig.fsk.BitRate = FSK_DATARATE; /*BitRate*/
  TxConfig.fsk.PreambleLen = 4;   /*in Byte        */
  TxConfig.fsk.SyncWordLength = sizeof(syncword); /*in Byte        */
  TxConfig.fsk.SyncWord = syncword; /*SyncWord Buffer*/
  TxConfig.fsk.whiteSeed =  0x01FF; /*WhiteningSeed  */
#if (APP_LONG_PACKET==0)
  TxConfig.fsk.HeaderType  = RADIO_FSK_PACKET_VARIABLE_LENGTH; /*legacy: payload length field is 1 byte long*/
#else
  TxConfig.fsk.HeaderType  = RADIO_FSK_PACKET_2BYTES_LENGTH;  /* payload length field is 2 bytes long */
#endif /* APP_LONG_PACKET */
  TxConfig.fsk.CrcLength = RADIO_FSK_CRC_2_BYTES_IBM;       /* Size of the CRC block in the GFSK packet*/
  TxConfig.fsk.CrcPolynomial = 0x8005;
  TxConfig.fsk.CrcSeed = 0xFFFF;
  TxConfig.fsk.Whitening = RADIO_FSK_DC_FREEWHITENING;
  if (0UL != Radio.RadioSetTxGenericConfig(GENERIC_FSK, &TxConfig, TX_OUTPUT_POWER, TX_TIMEOUT_VALUE))
  {
    while (1);
  }
#if (APP_LONG_PACKET==0)
  Radio.Send(data_buffer, payloadLen);
#else
  if (0UL != Radio.TransmitLongPacket(payloadLen, TX_TIMEOUT_VALUE, TxLongPacketGetNextChunk))
  {
    while (1);
  }
#endif /* APP_LONG_PACKET */
#else
#error should be either Tx or Rx
#endif /* TEST_MODE */

[#if THREADX??][#-- If AzRtos is used --]
  /* No need to allocate the stack and create thread for SubGHz_Phy_App_Process. */
  /* App_MainThread is used for it (see app_sigfox.c)  */
[#else][#-- not THREADX--]
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), UTIL_SEQ_RFU, Per_Process);
[/#if]
[/#if]
[#else] [#-- not FILL_UCS--]

[/#if]
  /* USER CODE END SubghzApp_Init_2 */
}

/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private functions ---------------------------------------------------------*/
[#if THREADX??][#-- If AzRtos is used --]

void App_Main_Thread_Entry(unsigned long thread_input)
{
  (void) thread_input;

  /* USER CODE BEGIN App_Main_Thread_Entry_1 */

  /* USER CODE END App_Main_Thread_Entry_1 */
  SystemApp_Init();
  SubghzApp_Init();
  /* USER CODE BEGIN App_Main_Thread_Entry_2 */

  /* USER CODE END App_Main_Thread_Entry_2 */

  /* Infinite loop */
  while (1)
  {
    tx_thread_suspend(&App_MainThread);
    /*do what else you want*/
    /* USER CODE BEGIN App_Main_Thread_Entry_Loop */
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
    PingPong_Process();
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
    Per_Process();
[/#if]
[/#if]
    /* USER CODE END App_Main_Thread_Entry_Loop */
  }
  /* Following USER CODE SECTION will be never reached */
  /* it can be use for compilation flag like #else or #endif */
  /* USER CODE BEGIN App_Main_Thread_Entry_Last */

  /* USER CODE END App_Main_Thread_Entry_Last */
}

[/#if]
static void OnTxDone(void)
{
  /* USER CODE BEGIN OnTxDone */
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
  APP_LOG(TS_ON, VLEVEL_L, "OnTxDone\n\r");
  /* Update the State of the FSM*/
  State = TX;
[#if THREADX??]
  tx_thread_resume(&App_MainThread);
[#else]
  /* Run PingPong process in background*/
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if]
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
  RadioTxDone_flag = 1;
[#if THREADX??]
  tx_thread_resume(&App_MainThread);
[#else]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if]
[/#if]
[/#if]
  /* USER CODE END OnTxDone */
}

static void OnRxDone(uint8_t *payload, uint16_t size, int16_t rssi, int8_t LoraSnr_FskCfo)
{
  /* USER CODE BEGIN OnRxDone */
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
  APP_LOG(TS_ON, VLEVEL_L, "OnRxDone\n\r");
#if ((USE_MODEM_LORA == 1) && (USE_MODEM_FSK == 0))
  APP_LOG(TS_ON, VLEVEL_L, "RssiValue=%d dBm, SnrValue=%ddB\n\r", rssi, LoraSnr_FskCfo);
  /* Record payload Signal to noise ratio in Lora*/
  SnrValue = LoraSnr_FskCfo;
#endif /* USE_MODEM_LORA | USE_MODEM_FSK */
#if ((USE_MODEM_LORA == 0) && (USE_MODEM_FSK == 1))
  APP_LOG(TS_ON, VLEVEL_L, "RssiValue=%d dBm, Cfo=%dkHz\n\r", rssi, LoraSnr_FskCfo);
  SnrValue = 0; /*not applicable in GFSK*/
#endif /* USE_MODEM_LORA | USE_MODEM_FSK */
  /* Update the State of the FSM*/
  State = RX;
  /* Clear BufferRx*/
  memset(BufferRx, 0, MAX_APP_BUFFER_SIZE);
  /* Record payload size*/
  RxBufferSize = size;
  if (RxBufferSize <= MAX_APP_BUFFER_SIZE)
  {
    memcpy(BufferRx, payload, RxBufferSize);
  }
  /* Record Received Signal Strength*/
  RssiValue = rssi;
  /* Record payload content*/
  APP_LOG(TS_ON, VLEVEL_H, "payload. size=%d \n\r", size);
  for (int i = 0; i < PAYLOAD_LEN; i++)
  {
    APP_LOG(TS_OFF, VLEVEL_H, "%02X", BufferRx[i]);
    if (i % 16 == 15)
    {
      APP_LOG(TS_OFF, VLEVEL_H, "\n\r");
    }
  }
  APP_LOG(TS_OFF, VLEVEL_H, "\n\r");
[#if THREADX??]
  tx_thread_resume(&App_MainThread);
[#else]
  /* Run PingPong process in background*/
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if]
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
  last_rx_rssi = rssi;
  last_rx_cfo = LoraSnr_FskCfo;

  /* Set Rxdone flag */
  RadioRxDone_flag = 1;
[#if THREADX??]
  tx_thread_resume(&App_MainThread);
[#else]
  /* Run Per process in background*/
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if]
#if (APP_LONG_PACKET==0)
  memcpy(data_buffer, payload, size);
  payloadLen = size;
#else
  /*from chunk*/
  payloadLen = data_offset;
  /*payload data are not relevant in long packet mode*/
#endif /* APP_LONG_PACKET */
[/#if]
[/#if]
  /* USER CODE END OnRxDone */
}

static void OnTxTimeout(void)
{
  /* USER CODE BEGIN OnTxTimeout */
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
  APP_LOG(TS_ON, VLEVEL_L, "OnTxTimeout\n\r");
  /* Update the State of the FSM*/
  State = TX_TIMEOUT;
[#if THREADX??]
  tx_thread_resume(&App_MainThread);
[#else]
  /* Run PingPong process in background*/
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if]
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
  RadioTxTimeout_flag = 1;
[#if THREADX??]
  tx_thread_resume(&App_MainThread);
[#else]
  /* Run Per process in background*/
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if]
[/#if]
[/#if]
  /* USER CODE END OnTxTimeout */
}

static void OnRxTimeout(void)
{
  /* USER CODE BEGIN OnRxTimeout */
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
  APP_LOG(TS_ON, VLEVEL_L, "OnRxTimeout\n\r");
  /* Update the State of the FSM*/
  State = RX_TIMEOUT;
[#if THREADX??]
  tx_thread_resume(&App_MainThread);
[#else]
  /* Run PingPong process in background*/
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if]
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
  RadioRxTimeout_flag = 1;
[#if THREADX??]
  tx_thread_resume(&App_MainThread);
[#else]
  /* Run Per process in background*/
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if]
[/#if]
[/#if]
  /* USER CODE END OnRxTimeout */
}

static void OnRxError(void)
{
  /* USER CODE BEGIN OnRxError */
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
  APP_LOG(TS_ON, VLEVEL_L, "OnRxError\n\r");
  /* Update the State of the FSM*/
  State = RX_ERROR;
[#if THREADX??]
  tx_thread_resume(&App_MainThread);
[#else]
  /* Run PingPong process in background*/
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if]
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
  RadioError_flag = 1;
[#if THREADX??]
  tx_thread_resume(&App_MainThread);
[#else]
  /* Run Per process in background*/
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if]
[/#if]
[/#if]
  /* USER CODE END OnRxError */
}

/* USER CODE BEGIN PrFD */
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
static void PingPong_Process(void)
{
  Radio.Sleep();

  switch (State)
  {
    case RX:

      if (isMaster == true)
      {
        if (RxBufferSize > 0)
        {
          if (strncmp((const char *)BufferRx, PONG, sizeof(PONG) - 1) == 0)
          {
            UTIL_TIMER_Stop(&timerLed);
            /* switch off green led */
            HAL_GPIO_WritePin(LED2_GPIO_Port, LED2_Pin, GPIO_PIN_RESET); /* LED_GREEN */
            /* master toggles red led */
            HAL_GPIO_TogglePin(LED3_GPIO_Port, LED3_Pin); /* LED_RED */
            /* Add delay between RX and TX */
            HAL_Delay(Radio.GetWakeupTime() + RX_TIME_MARGIN);
            /* master sends PING*/
            APP_LOG(TS_ON, VLEVEL_L, "..."
                    "PING"
                    "\n\r");
            APP_LOG(TS_ON, VLEVEL_L, "Master Tx start\n\r");
            memcpy(BufferTx, PING, sizeof(PING) - 1);
            Radio.Send(BufferTx, PAYLOAD_LEN);
          }
          else if (strncmp((const char *)BufferRx, PING, sizeof(PING) - 1) == 0)
          {
            /* A master already exists then become a slave */
            isMaster = false;
            APP_LOG(TS_ON, VLEVEL_L, "Slave Rx start\n\r");
            Radio.Rx(RX_TIMEOUT_VALUE);
          }
          else /* valid reception but neither a PING or a PONG message */
          {
            /* Set device as master and start again */
            isMaster = true;
            APP_LOG(TS_ON, VLEVEL_L, "Master Rx start\n\r");
            Radio.Rx(RX_TIMEOUT_VALUE);
          }
        }
      }
      else
      {
        if (RxBufferSize > 0)
        {
          if (strncmp((const char *)BufferRx, PING, sizeof(PING) - 1) == 0)
          {
            UTIL_TIMER_Stop(&timerLed);
            /* switch off red led */
            HAL_GPIO_WritePin(LED3_GPIO_Port, LED3_Pin, GPIO_PIN_RESET); /* LED_RED */
            /* slave toggles green led */
            HAL_GPIO_TogglePin(LED2_GPIO_Port, LED2_Pin); /* LED_GREEN */
            /* Add delay between RX and TX */
            HAL_Delay(Radio.GetWakeupTime() + RX_TIME_MARGIN);
            /*slave sends PONG*/
            APP_LOG(TS_ON, VLEVEL_L, "..."
                    "PONG"
                    "\n\r");
            APP_LOG(TS_ON, VLEVEL_L, "Slave  Tx start\n\r");
            memcpy(BufferTx, PONG, sizeof(PONG) - 1);
            Radio.Send(BufferTx, PAYLOAD_LEN);
          }
          else /* valid reception but not a PING as expected */
          {
            /* Set device as master and start again */
            isMaster = true;
            APP_LOG(TS_ON, VLEVEL_L, "Master Rx start\n\r");
            Radio.Rx(RX_TIMEOUT_VALUE);
          }
        }
      }
      break;
    case TX:
      APP_LOG(TS_ON, VLEVEL_L, "Rx start\n\r");
      Radio.Rx(RX_TIMEOUT_VALUE);
      break;
    case RX_TIMEOUT:
    case RX_ERROR:
      if (isMaster == true)
      {
        /* Send the next PING frame */
        /* Add delay between RX and TX*/
        /* add random_delay to force sync between boards after some trials*/
        HAL_Delay(Radio.GetWakeupTime() + RX_TIME_MARGIN + random_delay);
        APP_LOG(TS_ON, VLEVEL_L, "Master Tx start\n\r");
        /* master sends PING*/
        memcpy(BufferTx, PING, sizeof(PING) - 1);
        Radio.Send(BufferTx, PAYLOAD_LEN);
      }
      else
      {
        APP_LOG(TS_ON, VLEVEL_L, "Slave Rx start\n\r");
        Radio.Rx(RX_TIMEOUT_VALUE);
      }
      break;
    case TX_TIMEOUT:
      APP_LOG(TS_ON, VLEVEL_L, "Slave Rx start\n\r");
      Radio.Rx(RX_TIMEOUT_VALUE);
      break;
    default:
      break;
  }
}

static void OnledEvent(void *context)
{
  HAL_GPIO_TogglePin(LED2_GPIO_Port, LED2_Pin); /* LED_GREEN */
  HAL_GPIO_TogglePin(LED3_GPIO_Port, LED3_Pin); /* LED_RED */
  UTIL_TIMER_Start(&timerLed);
}

[/#if]
[/#if]
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
#if (APP_LONG_PACKET!=0)
void RxLongPacketChunk(uint8_t *buffer, uint8_t chunk_size)
{
  uint8_t *rxdata = &data_buffer[data_offset];
  uint8_t *rxbuffer = buffer;

  if (data_offset + chunk_size > MAX_APP_BUFFER_SIZE)
  {
    __NOP();
    return;
  }
  for (int i = 0; i < chunk_size; i++)
  {
    *rxdata++ = *rxbuffer++;
  }
  data_offset += chunk_size;
}

void TxLongPacketGetNextChunk(uint8_t **buffer, uint8_t chunk_size)
{
  *buffer = &data_buffer[data_offset];
  data_offset += chunk_size;
  /* APP_TPRINTF("Tx chunk: chunk_size=%d, data_offset=%d\r\n",chunk_size, data_offset); */
}
#endif /* APP_LONG_PACKET */
uint8_t buffer_error = 0;
static void Per_Process(void)
{
  packetCnt++;
  data_offset = 0;
#if (TEST_MODE == RADIO_RX)
  if (RadioRxDone_flag == 1)
  {
    int16_t rssi = last_rx_rssi;
    int8_t cfo = last_rx_cfo;
    HAL_GPIO_WritePin(LED2_GPIO_Port, LED2_Pin, GPIO_PIN_SET); /* LED_GREEN */
    APP_TPRINTF("OnRxDone\r\n");
    APP_TPRINTF("RssiValue=%d dBm, cfo=%d kHz\r\n", rssi, cfo);
    APP_TPRINTF("payloadLen=%d bytes\r\n", payloadLen);
#if 0
    /* warning, delay between 2 consecutive Tx may be increased to allow DMA to empty printf queue*/
    APP_PPRINTF("data=0x \n\r");
    for (int i = 0; i < payloadLen; i++)
    {
      APP_PRINTF("%02X ", data_buffer[i]);
      if ((i % 16) == 15)
      {
        APP_PPRINTF("\n\r");
      }
    }
    APP_PPRINTF("\n\r");
#endif /* 0 */
  }
  else
  {
    HAL_GPIO_WritePin(LED3_GPIO_Port, LED3_Pin, GPIO_PIN_SET); /* LED_RED */
  }

  if (RadioRxTimeout_flag == 1)
  {
    APP_TPRINTF("OnRxTimeout\r\n");
  }

  if (RadioError_flag == 1)
  {
    APP_TPRINTF("OnRxError\r\n");
  }

  /*check flag*/
  if ((RadioRxTimeout_flag == 1) || (RadioError_flag == 1))
  {
    count_RxKo++;
  }
  if (RadioRxDone_flag == 1)
  {
    count_RxOk++;
  }
  /* Reset timeout flag */
  RadioRxDone_flag = 0;
  RadioRxTimeout_flag = 0;
  RadioError_flag = 0;

  /* Compute PER */
  PER = (100 * (count_RxKo)) / (count_RxKo + count_RxOk);
  APP_TPRINTF("Rx %d>>> PER= %d %%\r\n", packetCnt, PER);
#if (APP_LONG_PACKET==0)
  Radio.Rx(RX_TIMEOUT_VALUE);
#else
  (void) Radio.ReceiveLongPacket(0, RX_TIMEOUT_VALUE, RxLongPacketChunk);
#endif /* APP_LONG_PACKET */
  HAL_Delay(10);
  HAL_GPIO_WritePin(LED2_GPIO_Port, LED2_Pin, GPIO_PIN_RESET); /* LED_GREEN */
  HAL_GPIO_WritePin(LED3_GPIO_Port, LED3_Pin, GPIO_PIN_RESET); /* LED_RED */
#elif (TEST_MODE == RADIO_TX)
  HAL_GPIO_WritePin(LED1_GPIO_Port, LED1_Pin, GPIO_PIN_RESET); /* LED_BLUE */
  if (RadioTxDone_flag == 1)
  {
    APP_TPRINTF("OnTxDone\r\n");
  }

  if (RadioTxTimeout_flag == 1)
  {
    APP_TPRINTF("OnTxTimeout\r\n");
  }

  if (RadioError_flag == 1)
  {
    APP_TPRINTF("OnRxError\r\n");
  }
  /* this delay is only to give enough time to allow DMA to empty printf queue*/
  HAL_Delay(500);
  /* Reset TX Done or timeout flags */
  RadioTxDone_flag = 0;
  RadioTxTimeout_flag = 0;
  RadioError_flag = 0;

  tx_payload_generator();
#if (APP_LONG_PACKET==0)
  Radio.Send(data_buffer, payloadLen);
#else
  if (0UL != Radio.TransmitLongPacket(payloadLen, TX_TIMEOUT_VALUE, TxLongPacketGetNextChunk))
  {
    while (1);
  }
#endif /* APP_LONG_PACKET */
  APP_TPRINTF("Tx %d \r\n", packetCnt);
  HAL_GPIO_WritePin(LED1_GPIO_Port, LED1_Pin, GPIO_PIN_SET); /* LED_BLUE */
#endif /* TEST_MODE */
}

#if (TEST_MODE == RADIO_TX)
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
{
  switch (GPIO_Pin)
  {
    case  BUT1_Pin:
      /* Note: when "EventType == TX_ON_TIMER" this GPIO is not initialized */
      /*increment by 16*/
      payloadLen += 16;
      if (payloadLen > MAX_APP_BUFFER_SIZE)
      {
        payloadLen = 1;
      }
      APP_TPRINTF("New Tx Payload Length= %d\r\n", payloadLen);

      break;
    case  BUT2_Pin:
      /*increment by 1*/
      payloadLen += 1;
      if (payloadLen > MAX_APP_BUFFER_SIZE)
      {
        payloadLen = 1;
      }
      APP_TPRINTF("New Tx Payload Length= %d\r\n", payloadLen);

      break;
    case  BUT3_Pin:
      TxPayloadMode = (TxPayloadMode + 1) % 2;
      if (TxPayloadMode == 1)
      {
        APP_TPRINTF("Payload PRBS9 mode\r\n");
      }
      else
      {
        APP_TPRINTF("Payload Inc mode\r\n");
      }
      break;
    default:
      break;
  }
}

static int32_t tx_payload_generator(void)
{
  if (TxPayloadMode == 1)
  {
    uint16_t prbs9_val = PRBS9_INIT;
    for (int32_t i = 0; i < payloadLen; i++)
    {
      data_buffer[i] = 0;
    }
    for (int32_t i = 0; i < payloadLen * 8; i++)
    {
      /*fill buffer with prbs9 sequence*/
      int32_t newbit = (((prbs9_val >> 8) ^ (prbs9_val >> 4)) & 1);
      prbs9_val = ((prbs9_val << 1) | newbit) & 0x01ff;
      data_buffer[i / 8] |= ((prbs9_val & 0x1) << (i % 8));
    }
  }
  else
  {
    for (int32_t i = 0; i < payloadLen; i++)
    {
      data_buffer[i] = i;
    }
  }
  return 0;
}
#endif /* TEST_MODE */
[/#if]
[/#if]
/* USER CODE END PrFD */
