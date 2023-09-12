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
[#assign UTIL_SEQ_EN_M4 = "true"]
[#assign UTIL_SEQ_EN_M0 = "true"]
[#assign FILL_UCS = ""]
[#assign INTERNAL_USER_SUBGHZ_APP = ""]
[#assign STM32WL5MXX = "false"]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "SUBGHZ_APPLICATION"]
                    [#assign SUBGHZ_APPLICATION = definition.value]
                [/#if]
                [#if definition.name == "UTIL_SEQ_EN_M4"]
                    [#assign UTIL_SEQ_EN_M4 = definition.value]
                [/#if]
                [#if definition.name == "UTIL_SEQ_EN_M0"]
                    [#assign UTIL_SEQ_EN_M0 = definition.value]
                [/#if]
                [#if definition.name == "FILL_UCS"]
                    [#assign FILL_UCS = definition.value]
                [/#if]
                [#if definition.name == "STM32WL5MXX"]
                    [#assign STM32WL5MXX = definition.value]
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
[#if (SUBGHZ_APPLICATION != "SUBGHZ_AT_SLAVE")]
#include "radio.h"
[#else][#-- SUBGHZ_AT_SLAVE --]
#include "stm32_timer.h"
[#if ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
#include "stm32_seq.h"
[/#if]
#include "utilities_def.h"
#include "app_version.h"
#include "subghz_phy_version.h"
#include "subg_command.h"
#include "subg_at.h"
[/#if][#-- SUBGHZ_AT_SLAVE --]
[#if THREADX??][#-- If AzRtos is used --]
#include "app_azure_rtos.h"
#include "tx_api.h"
[#if (SUBGHZ_APPLICATION == "SUBGHZ_AT_SLAVE")]
#include "test_rf.h"
[/#if]
[#elseif FREERTOS??][#-- If FreeRtos is used --]
#include "cmsis_os.h"
[#if (SUBGHZ_APPLICATION == "SUBGHZ_AT_SLAVE")]
#include "test_rf.h"
[/#if]
[/#if][#-- If THREADX vs FREERTOS is used --]

/* USER CODE BEGIN Includes */
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_AT_SLAVE") && (FILL_UCS == "true")]
#include "stm32_timer.h"
[#if THREADX??][#-- THREADX done above --]
[#elseif FREERTOS??][#-- FreeRtos done above --]
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
#include "stm32_seq.h"
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
#include "utilities_def.h"
#include "app_version.h"
[#if CPUCORE == ""]
#include "subghz_phy_version.h"
[/#if]
[#if (CPUCORE == "CM4")]
#include "mbmuxif_sys.h"
[/#if]
[#else]

[/#if]
/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
[#if THREADX??][#-- If AzRtos is used --]
extern TX_THREAD App_MainThread;
extern TX_BYTE_POOL *byte_pool;
extern CHAR *pointer;

[#if (SUBGHZ_APPLICATION == "SUBGHZ_AT_SLAVE")]
TX_THREAD Thd_VcomProcessId;
[/#if]
[/#if]
[#if FREERTOS??][#-- If FreeRtos is used --]
[#if (SUBGHZ_APPLICATION == "SUBGHZ_AT_SLAVE")]
osThreadId_t Thd_VcomProcessId;

const osThreadAttr_t Thd_VcomProcess_attr =
{
  .name = CFG_VCOM_PROCESS_NAME,
  .attr_bits = CFG_VCOM_PROCESS_ATTR_BITS,
  .cb_mem = CFG_VCOM_PROCESS_CB_MEM,
  .cb_size = CFG_VCOM_PROCESS_CB_SIZE,
  .stack_mem = CFG_VCOM_PROCESS_STACK_MEM,
  .priority = CFG_VCOM_PROCESS_PRIORITY,
  .stack_size = CFG_VCOM_PROCESS_STACK_SIZE
};
static void Thd_VcomProcess(void *argument);

[/#if]
[/#if][#--  FREERTOS --]
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */
[#if (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
typedef enum
{
  RX,
  RX_TIMEOUT,
  RX_ERROR,
  TX,
  TX_TIMEOUT,
} States_t;
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_FHSS") || (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_SWITCH_MODULATION")]
typedef struct
{
  lr_fhss_v1_cr_t coding_rate;
  uint8_t header_count[4];
} SubghzPhyTxPayloadLen_t;
[/#if]
[/#if][#--  FILL_UCS --]

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */
[#if (FILL_UCS == "true")]
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

#if (( USE_MODEM_LORA == 1 ) && ( USE_MODEM_FSK == 0 ))
/* 0: Tx Long packet shall be disable when USE_MODEM_LORA*/
#define APP_LONG_PACKET              0
/* Application buffer 255 max when USE_MODEM_LORA */
#define MAX_APP_BUFFER_SIZE              255
#elif (( USE_MODEM_LORA == 0 ) && ( USE_MODEM_FSK == 1 ))
/* 0: Tx Long packet disable*/
/* 1: Tx Long packet enable(payload can be greater than 255bytes. Available on stm32wl revision Y)*/
#define APP_LONG_PACKET               0
/* Application buffer, can be increased further*/
#define MAX_APP_BUFFER_SIZE           1000
#else
#error "Please define a modem in the compiler subghz_phy_app.h."
#endif /* USE_MODEM_LORA | USE_MODEM_FSK */

#if (PAYLOAD_LEN>MAX_APP_BUFFER_SIZE)
#error increase MAX_APP_BUFFER_SIZE
#endif /* (PAYLOAD_LEN>MAX_APP_BUFFER_SIZE) */

#if ((APP_LONG_PACKET==0) && PAYLOAD_LEN>255)
#error in case PAYLOAD_LEN>255, APP_LONG_PACKET shall be defined to 1
#endif /* ((APP_LONG_PACKET==0) && PAYLOAD_LEN>255) */
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_FHSS") || (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_SWITCH_MODULATION")]
/* Configurations */
#define TX_TIMEOUT_VALUE              3000
#define PRBS9_INIT                    ( ( uint16_t) 2 )
/* Application buffer, can be increased further*/
#define MAX_APP_BUFFER_SIZE 255
#if (PAYLOAD_LEN>MAX_APP_BUFFER_SIZE)
#error please, decrease PAYLOAD_LEN
#endif /* (PAYLOAD_LEN>MAX_APP_BUFFER_SIZE) */
[/#if]
[/#if][#--  FILL_UCS --]

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */
[#if (FILL_UCS == "true") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_AT_SLAVE") && ((INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_FHSS") || (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_SWITCH_MODULATION"))]
#define STRUCT_FIELD_SIZE(s, f)   sizeof(((s *)0)->f)
[/#if]

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
[#if THREADX??][#-- If AzRtos is used --]
/* If resume happens when the task is running, task will not be suspended at next loop */
static __IO uint8_t App_MainThread_RescheduleFlag = 0;
[/#if]
[#if (SUBGHZ_APPLICATION != "SUBGHZ_AT_SLAVE")]
/* Radio events function pointer */
static RadioEvents_t RadioEvents;

[/#if]
/* USER CODE BEGIN PV */
[#if (FILL_UCS == "true")]
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
#if (TEST_MODE == RADIO_TX)
static uint16_t payloadLenMax = MAX_APP_BUFFER_SIZE;
#endif /* TEST_MODE == RADIO_TX */

#if (( USE_MODEM_LORA == 0 ) && ( USE_MODEM_FSK == 1 ))
static uint8_t syncword[] = { 0xC1, 0x94, 0xC1};
#endif /* USE_MODEM_FSK */

uint32_t count_RxOk = 0;
uint32_t count_RxKo = 0;
uint32_t PER = 0;

static int32_t packetCnt = 0;

/* TxPayloadMode
 * 0: byte Inc e.g payload=0x00, 0x01, ..,payloadLen-1
 * 1: prbs9  */
static __IO uint8_t TxPayloadMode = 0;
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_FHSS") || (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_SWITCH_MODULATION")]
static __IO uint32_t RadioTxDone_flag = 0;
static __IO uint32_t RadioTxTimeout_flag = 0;

uint8_t data_buffer[MAX_APP_BUFFER_SIZE] UTIL_MEM_ALIGN(4);
uint16_t data_offset = 0;

static __IO uint16_t payloadLen = PAYLOAD_LEN;
static uint16_t payloadLenMax = PAYLOAD_LEN;
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_SWITCH_MODULATION")]
static __IO uint8_t ModemConfig = MODEM_FSK;
static __IO uint8_t ModemConfigChange = 0;
static __IO uint8_t LrFhssParamSwitch = 0;

static uint8_t syncword[] = { 0xC1, 0x94, 0xC1};
[/#if]

uint32_t count_RxOk = 0;
uint32_t count_RxKo = 0;
uint32_t PER = 0;

static uint32_t packetCnt = 0;

static const uint8_t lr_fhss_sync_word[LR_FHSS_SYNC_WORD_BYTES] = { 0x2C, 0x0F, 0x79, 0x95 };

/* TxPayloadMode
 * 0: prbs9 mode
 * 1: ramp mode e.g payload=0x00, 0x01, ..,payloadLen-1*/
static __IO uint8_t TxPayloadMode = 0;

static const SubghzPhyTxPayloadLen_t txPayloadLen[] =
{
  {LR_FHSS_V1_CR_5_6, {0, 189, 178, 167}},
  {LR_FHSS_V1_CR_2_3, {0, 151, 142, 133}},
  {LR_FHSS_V1_CR_1_2, {0, 112, 105, 99}},
  {LR_FHSS_V1_CR_1_3, {0, 74, 69, 65}}
};
[/#if]
[/#if][#--  FILL_UCS --]

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
[#if (SUBGHZ_APPLICATION != "SUBGHZ_AT_SLAVE")]
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

[#else][#--  SUBGHZ_AT_SLAVE --]
/**
  * @brief  call back when LoRaWan Stack needs update
  */
static void CmdProcessNotify(void);

[#if THREADX??][#-- If AzRtos is used --]
/**
  * @brief  Entry point for the thread when receiving MailBox Vcom Notification .
  * @param  thread_input: Not used
  * @retval None
  */
static void Thd_VcomProcess_Entry(unsigned long thread_input);

[/#if][#--  THREADX --]
[/#if][#--  SUBGHZ_AT_SLAVE --]
/* USER CODE BEGIN PFP */
[#if (FILL_UCS == "true")]
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

[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_FHSS")]
/**
  * @brief Packet Error Rate state machine implementation
  */
static void LrFhss_Process(void);

[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_SWITCH_MODULATION")]
/**
  * @brief Configure the radio for Fsk transmission
  */
static void Radio_Fsk_TxConfig(void);

/**
  * @brief Configure the radio for Lora transmission
  */
static void Radio_Lora_TxConfig(void);

/**
  * @brief Configure the radio for LrFhss transmission
  */
static void Radio_LrFhss_TxConfig(void);

/**
  * @brief Packet Error Rate state machine implementation
  */
static void Switch_Modulation_Process(void);

[/#if]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
#if (TEST_MODE == RADIO_TX)
[/#if]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")  || (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_FHSS") || (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_SWITCH_MODULATION")]
/**
  * @brief Generates a PRBS9 sequence
  * @retval 0
  */
static int32_t tx_payload_generator(void);

[/#if]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
#endif /* TEST_MODE == RADIO_TX */

[/#if]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_FHSS") || (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_SWITCH_MODULATION")]
/**
  * @brief Calculate payloadLenMax depending on Init Param (CR and nr of headers)
  */
static void set_tx_payload_len_max(lr_fhss_v1_cr_t cr, uint8_t hc);

[/#if]
[/#if][#--  FILL_UCS --]

/* USER CODE END PFP */

/* Exported functions ---------------------------------------------------------*/
void SubghzApp_Init(void)
{
[#if (SUBGHZ_APPLICATION == "SUBGHZ_AT_SLAVE")]
  CMD_Init(CmdProcessNotify);

[/#if]
  /* USER CODE BEGIN SubghzApp_Init_1 */
[#if (FILL_UCS == "true")]
[#if (CPUCORE == "CM4") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION")]
  FEAT_INFO_Param_t *p_cm0plus_specific_features_info;
  uint32_t feature_version = 0UL;
[/#if]

[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
  APP_LOG(TS_OFF, VLEVEL_M, "\n\rPING PONG\n\r");
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
#if  (( USE_MODEM_LORA == 0 ) && ( USE_MODEM_FSK == 1 ) && (TEST_MODE == RADIO_RX))
  RxConfigGeneric_t RxConfig = {0};
#elif (( USE_MODEM_LORA == 0 ) && ( USE_MODEM_FSK == 1 ) && (TEST_MODE == RADIO_TX))
  TxConfigGeneric_t TxConfig;
#else
#endif /* TEST_MODE */
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_FHSS")]
  radio_lr_fhss_cfg_params_t radio_lr_fhss_cfg_params;
  radio_lr_fhss_time_on_air_params_t time_on_air;
[/#if][#--  INTERNAL_USER_SUBGHZ_APP --]
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION")]
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
[/#if][#--  CPUCORE == CM4 vs CM0 vs SINGLE --]
[/#if][#--  SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION" --]

[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
  /* Led Timers*/
  UTIL_TIMER_Create(&timerLed, LED_PERIOD_MS, UTIL_TIMER_ONESHOT, OnledEvent, NULL);
  UTIL_TIMER_Start(&timerLed);
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
  APP_LOG(TS_OFF, VLEVEL_M, "---------------\n\r");
#if (( USE_MODEM_LORA == 1 ) && ( USE_MODEM_FSK == 0 ))
  APP_LOG(TS_OFF, VLEVEL_M, "LORA_MODULATION\n\r");
  APP_LOG(TS_OFF, VLEVEL_M, "LORA_BW=%d Hz\n\r", 125000);
#elif (( USE_MODEM_LORA == 0 ) && ( USE_MODEM_FSK == 1 ))
  APP_LOG(TS_OFF, VLEVEL_M, "FSK_MODULATION\n\r");
  APP_LOG(TS_OFF, VLEVEL_M, "FSK_BW=%d Hz\n\r", FSK_BANDWIDTH);
  APP_LOG(TS_OFF, VLEVEL_M, "FSK_DR=%d bits/s\n\r", FSK_DATARATE);
#if (TEST_MODE == RADIO_RX)
  APP_LOG(TS_OFF, VLEVEL_M, "Rx Mode\n\r", FSK_DATARATE);
#elif (TEST_MODE == RADIO_TX)
  APP_LOG(TS_OFF, VLEVEL_M, "Tx Mode\n\r", FSK_DATARATE);
#endif /* TEST_MODE */
#else
#error "Please define a modem in the compiler subghz_phy_app.h."
#endif /* USE_MODEM_LORA | USE_MODEM_FSK */
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_FHSS")]
  APP_LOG(TS_OFF, VLEVEL_M, "---------------\n\r");
  APP_LOG(TS_OFF, VLEVEL_M, "LRFHSS_MODULATION\n\r");
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_SWITCH_MODULATION")]
  APP_LOG(TS_OFF, VLEVEL_M, "---------------\n\r");
  if (ModemConfig == MODEM_LORA)
  {
    APP_LOG(TS_OFF, VLEVEL_M, "LORA_MODULATION\n\r");
    APP_LOG(TS_OFF, VLEVEL_M, "LORA_BW=%d Hz\n\r", 125000);
  }
  else if (ModemConfig == MODEM_FSK)
  {
    APP_LOG(TS_OFF, VLEVEL_M, "FSK_MODULATION\n\r");
    APP_LOG(TS_OFF, VLEVEL_M, "FSK_BW=%d Hz\n\r", FSK_BANDWIDTH);
    APP_LOG(TS_OFF, VLEVEL_M, "FSK_DR=%d bits/s\n\r", FSK_DATARATE);
  }
  else
  {
    APP_LOG(TS_OFF, VLEVEL_M, "LRFHSS_MODULATION\n\r");
  }
[/#if][#--  INTERNAL_USER_SUBGHZ_APP --]
[#else]

[/#if][#--  FILL_UCS --]
  /* USER CODE END SubghzApp_Init_1 */

[#if (SUBGHZ_APPLICATION != "SUBGHZ_AT_SLAVE")]
  /* Radio initialization */
  RadioEvents.TxDone = OnTxDone;
  RadioEvents.RxDone = OnRxDone;
  RadioEvents.TxTimeout = OnTxTimeout;
  RadioEvents.RxTimeout = OnRxTimeout;
  RadioEvents.RxError = OnRxError;

  Radio.Init(&RadioEvents);
[#else][#--  SUBGHZ_AT_SLAVE --]
[#if THREADX??][#-- If AzRtos is used --]
  /* Allocate the stack for Thd_VcomProcess.  */
  if (tx_byte_allocate(byte_pool, (VOID **) &pointer, CFG_VCOM_THREAD_STACK_SIZE, TX_NO_WAIT) != TX_SUCCESS)
  {
    Error_Handler();
  }
  if (tx_thread_create(&Thd_VcomProcessId, "Thread VcomProcess", Thd_VcomProcess_Entry, 0,
                       pointer, CFG_VCOM_THREAD_STACK_SIZE,
                       CFG_VCOM_THREAD_PRIO, CFG_VCOM_THREAD_PREEMPTION_THRESHOLD,
                       TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
  {
    Error_Handler();
  }
[#if (SUBGHZ_APPLICATION == "SUBGHZ_AT_SLAVE")]
  /* Create the semaphore for RfTest.  */
  if (TST_Semaphore_Init() < 0)
  {
    Error_Handler();
  }
[/#if]
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  Thd_VcomProcessId = osThreadNew(Thd_VcomProcess, NULL, &Thd_VcomProcess_attr);
  if (Thd_VcomProcessId == NULL)
  {
    Error_Handler();
  }
[#if (SUBGHZ_APPLICATION == "SUBGHZ_AT_SLAVE")]
  /* Create the semaphore for RfTest.  */
  TST_Semaphore_Init();
[/#if]
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
  /* Register Virtual-Com task then radio goes in Sleep/Stop mode waiting an AT cmd */
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_Vcom), UTIL_SEQ_RFU, CMD_Process);
[#else]
    /* Use your OS to schedule Vcom task */
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
[/#if]

  /* USER CODE BEGIN SubghzApp_Init_2 */
[#if (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
  /*calculate random delay for synchronization*/
  random_delay = (Radio.Random()) >> 22; /*10bits random e.g. from 0 to 1023 ms*/

  /* Radio Set frequency */
  Radio.SetChannel(RF_FREQUENCY);

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
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  /* FREERTOS tbd  */
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
  /*register task to to be run in while(1) after Radio IT*/
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), UTIL_SEQ_RFU, PingPong_Process);
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
  /* Radio Set frequency */
  Radio.SetChannel(RF_FREQUENCY);

  data_offset = 0;
#if (TEST_MODE == RADIO_RX)
#if (( USE_MODEM_LORA == 1 ) && ( USE_MODEM_FSK == 0 ))
  APP_TPRINTF("Rx LORA Test\r\n");
  /* RX Continuous */
  Radio.SetRxConfig(MODEM_LORA, LORA_BANDWIDTH, LORA_SPREADING_FACTOR,
                    LORA_CODINGRATE, 0, LORA_PREAMBLE_LENGTH,
                    LORA_SYMBOL_TIMEOUT, LORA_FIX_LENGTH_PAYLOAD_ON,
                    0, true, 0, 0, LORA_IQ_INVERSION_ON, true);

  Radio.SetMaxPayloadLength(MODEM_LORA, MAX_APP_BUFFER_SIZE);
#elif (( USE_MODEM_LORA == 0 ) && ( USE_MODEM_FSK == 1 ))
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
#else
#error "Please define a modem in the compiler subghz_phy_app.h."
#endif /* USE_MODEM_LORA | USE_MODEM_FSK */

#if (APP_LONG_PACKET==0)
  Radio.Rx(RX_TIMEOUT_VALUE);
#else
  (void) Radio.ReceiveLongPacket(0, RX_TIMEOUT_VALUE, RxLongPacketChunk);
#endif /* APP_LONG_PACKET */

#elif (TEST_MODE == RADIO_TX)
  tx_payload_generator();

#if (( USE_MODEM_LORA == 1 ) && ( USE_MODEM_FSK == 0 ))
  /*lora modulation*/
  Radio.SetTxConfig(MODEM_LORA, TX_OUTPUT_POWER, 0, LORA_BANDWIDTH,
                    LORA_SPREADING_FACTOR, LORA_CODINGRATE,
                    LORA_PREAMBLE_LENGTH, LORA_FIX_LENGTH_PAYLOAD_ON,
                    true, 0, 0, LORA_IQ_INVERSION_ON, TX_TIMEOUT_VALUE);

  Radio.SetMaxPayloadLength(MODEM_LORA, MAX_APP_BUFFER_SIZE);
#elif (( USE_MODEM_LORA == 0 ) && ( USE_MODEM_FSK == 1 ))
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
#else
#error "Please define a modem in the compiler subghz_phy_app.h."
#endif /* USE_MODEM_LORA | USE_MODEM_FSK */

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
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  /* FREERTOS tbd  */
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
  /*register task to to be run in while(1) after Radio IT*/
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), UTIL_SEQ_RFU, Per_Process);
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_FHSS")]
  /* Build payload */
  tx_payload_generator();

  /* Configure Tx parameters */
  radio_lr_fhss_cfg_params.tx_rf_pwr_in_dbm                              = 14;

  radio_lr_fhss_cfg_params.radio_lr_fhss_params.center_frequency_in_hz         = RF_FREQUENCY;
  radio_lr_fhss_cfg_params.radio_lr_fhss_params.device_offset                  = 0;
  radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.sync_word       = lr_fhss_sync_word;
  radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.modulation_type = LR_FHSS_V1_MODULATION_TYPE_GMSK_488;
  radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.cr              = LR_FHSS_V1_CR_5_6;
  radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.grid            = LR_FHSS_V1_GRID_3906_HZ;
  radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.bw              = LR_FHSS_V1_BW_136719_HZ;
  radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.enable_hopping  = true;
  radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.header_count    = 2;
  radio_lr_fhss_cfg_params.tx_timeout_in_ms = 0 ;

  /* Set max payload*/
  set_tx_payload_len_max(radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.cr,
                         radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.header_count);
  /* Get time on air*/
  time_on_air.radio_lr_fhss_params = radio_lr_fhss_cfg_params.radio_lr_fhss_params;
  time_on_air.pld_len_in_bytes = payloadLen;
  Radio.LrFhssGetTimeOnAirInMs(&time_on_air, &radio_lr_fhss_cfg_params.tx_timeout_in_ms);
  /* Apply 50 ms margin*/
  radio_lr_fhss_cfg_params.tx_timeout_in_ms += 50;

  if (0UL != Radio.LrFhssSetCfg(&radio_lr_fhss_cfg_params))
  {
    while (1);
  }
  /* Send Tx Data*/
  if (Radio.Send(data_buffer, payloadLen) != RADIO_STATUS_OK)
  {
    APP_TPRINTF("Error when sending the first packet \r\n");
  }

[#if THREADX??][#-- If AzRtos is used --]
  /* No need to allocate the stack and create thread for SubGHz_Phy_App_Process. */
  /* App_MainThread is used for it (see app_sigfox.c)  */
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  /* FREERTOS tbd  */
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
  /*register task to to be run in while(1) after Radio IT*/
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), UTIL_SEQ_RFU, LrFhss_Process);
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_SWITCH_MODULATION")]
  data_offset = 0;

  /* Build payload */
  tx_payload_generator();

  Radio.SetPublicNetwork(true);

  if (ModemConfig == MODEM_FSK)
  {
    Radio_Fsk_TxConfig();
  }
  else if (ModemConfig == MODEM_LORA)
  {
    Radio_Lora_TxConfig();
  }
  else
  {
    Radio_LrFhss_TxConfig();
  }

  /* Send Tx Data*/
  if (Radio.Send(data_buffer, payloadLen) != RADIO_STATUS_OK)
  {
    APP_TPRINTF("Error when sending the first packet \r\n");
  }

[#if THREADX??][#-- If AzRtos is used --]
  /* No need to allocate the stack and create thread for SubGHz_Phy_App_Process. */
  /* App_MainThread is used for it (see app_sigfox.c)  */
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  /* FREERTOS tbd  */
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
  /*register task to to be run in while(1) after Radio IT*/
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), UTIL_SEQ_RFU, Switch_Modulation_Process);
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
[/#if][#--  INTERNAL_USER_SUBGHZ_APP --]
[#if (SUBGHZ_APPLICATION == "SUBGHZ_AT_SLAVE")]
  APP_PPRINTF("ATtention command interface (only for TST_RF)\r\n");
  APP_PPRINTF("AT? to list all available functions\r\n");

[/#if]
[#else][#-- not FILL_UCS--]

[/#if][#--  FILL_UCS --]
  /* USER CODE END SubghzApp_Init_2 */
}

/* USER CODE BEGIN EF */
[#if (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_SWITCH_MODULATION")]
static void Radio_LrFhss_TxConfig(void)
{
  radio_lr_fhss_cfg_params_t radio_lr_fhss_cfg_params;
  radio_lr_fhss_time_on_air_params_t time_on_air;

  /* Configure Tx parameters*/
  radio_lr_fhss_cfg_params.tx_rf_pwr_in_dbm                              = 14;

  radio_lr_fhss_cfg_params.radio_lr_fhss_params.center_frequency_in_hz         = LRFHSS_FREQUENCY;
  radio_lr_fhss_cfg_params.radio_lr_fhss_params.device_offset                  = 0;
  radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.sync_word       = lr_fhss_sync_word;
  radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.modulation_type = LR_FHSS_V1_MODULATION_TYPE_GMSK_488;
  radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.cr              = (lr_fhss_v1_cr_t)(LrFhssParamSwitch % (LR_FHSS_V1_CR_1_3 + 1));
  radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.grid            = LR_FHSS_V1_GRID_3906_HZ;
  radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.bw              = (lr_fhss_v1_bw_t)(LrFhssParamSwitch % (LR_FHSS_V1_BW_1574219_HZ + 1));
  radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.enable_hopping  = true;
  radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.header_count    = 1 + (LrFhssParamSwitch % 3);
  radio_lr_fhss_cfg_params.tx_timeout_in_ms = 0 ;

  APP_TPRINTF("lr_fhss_params - cr: %d, bw: %d, hc: %d \r\n",
              radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.cr,
              radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.bw,
              radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.header_count);

  /* Set max payload*/
  set_tx_payload_len_max(radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.cr,
                         radio_lr_fhss_cfg_params.radio_lr_fhss_params.lr_fhss_params.header_count);
  /* Get time on air*/
  time_on_air.radio_lr_fhss_params = radio_lr_fhss_cfg_params.radio_lr_fhss_params;
  time_on_air.pld_len_in_bytes = payloadLen;
  Radio.LrFhssGetTimeOnAirInMs(&time_on_air, &radio_lr_fhss_cfg_params.tx_timeout_in_ms);
  /* Apply 50 ms margin*/
  radio_lr_fhss_cfg_params.tx_timeout_in_ms += 50;

  if (0UL != Radio.LrFhssSetCfg(&radio_lr_fhss_cfg_params))
  {
    while (1);
  }
}

static void Radio_Lora_TxConfig(void)
{

  /* Radio Set frequency */
  Radio.SetChannel(LORA_FREQUENCY);

#if 1
#define CRC_ON 1
#define IQ_NORMAL 0
  Radio.SetTxConfig(MODEM_LORA, TX_OUTPUT_POWER, 0, LORA_BANDWIDTH,
                    LORA_SPREADING_FACTOR, LORA_CODINGRATE,
                    LORA_PREAMBLE_LENGTH, LORA_FIX_LENGTH_PAYLOAD_ON,
                    CRC_ON, 0, 0, IQ_NORMAL, TX_TIMEOUT_VALUE);

  Radio.SetMaxPayloadLength(MODEM_LORA, MAX_APP_BUFFER_SIZE);
#else
  TxConfigGeneric_t TxConfig;

  /*lora modulation*/
  TxConfig.lora.SpreadingFactor = RADIO_LORA_SF12;
  TxConfig.lora.Bandwidth = RADIO_LORA_BW_125;
  TxConfig.lora.Coderate = RADIO_LORA_CR_4_5;
  TxConfig.lora.LowDatarateOptimize = RADIO_LORA_LOWDR_OPT_AUTO;
  TxConfig.lora.PreambleLen = 8;
  TxConfig.lora.LengthMode = RADIO_LORA_PACKET_EXPLICIT;
  TxConfig.lora.CrcMode = RADIO_LORA_CRC_ON;
  TxConfig.lora.IqInverted = RADIO_LORA_IQ_NORMAL;

  if (0UL != Radio.RadioSetTxGenericConfig(GENERIC_LORA, &TxConfig, TX_OUTPUT_POWER, TX_TIMEOUT_VALUE))
  {
    while (1);
  }
#endif /* SetTxConfig or SetTxGenericConfig */
}

static void Radio_Fsk_TxConfig(void)
{
  TxConfigGeneric_t TxConfig;

  /* Radio Set frequency */
  Radio.SetChannel(FSK_FREQUENCY);

  /*fsk modulation*/
  TxConfig.fsk.ModulationShaping = RADIO_FSK_MOD_SHAPING_G_BT_1;
  TxConfig.fsk.FrequencyDeviation = FSK_FDEV;
  TxConfig.fsk.BitRate = FSK_DATARATE; /*BitRate*/
  TxConfig.fsk.PreambleLen = 5;   /*in Byte        */
  TxConfig.fsk.SyncWordLength = sizeof(syncword); /*in Byte        */
  TxConfig.fsk.SyncWord = syncword; /*SyncWord Buffer*/
  TxConfig.fsk.whiteSeed =  0x01FF; /*WhiteningSeed  */
#if (APP_LONG_PACKET==0)
  TxConfig.fsk.HeaderType  = RADIO_FSK_PACKET_VARIABLE_LENGTH; /*legacy: payload length field is 1 byte long*/
#else
  TxConfig.fsk.HeaderType  = RADIO_FSK_PACKET_2BYTES_LENGTH;  /* payload length field is 2 bytes long */
#endif /* APP_LONG_PACKET */
  TxConfig.fsk.CrcLength = RADIO_FSK_CRC_2_BYTES_CCIT;       /* Size of the CRC block in the GFSK packet*/
  TxConfig.fsk.CrcPolynomial = 0x8005;
  TxConfig.fsk.CrcSeed = 0xFFFF;
  TxConfig.fsk.Whitening = RADIO_FSK_DC_FREEWHITENING;
  if (0UL != Radio.RadioSetTxGenericConfig(GENERIC_FSK, &TxConfig, TX_OUTPUT_POWER, TX_TIMEOUT_VALUE))
  {
    while (1);
  }
}
[/#if][#--  INTERNAL_USER_SUBGHZ_APP --]
[/#if][#--  FILL_UCS --]

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
    if (App_MainThread_RescheduleFlag > 0)
    {
      /* if RescheduleFlag was set during Process() don't suspend  */
      App_MainThread_RescheduleFlag--;
    }
    else
    {
      tx_thread_suspend(&App_MainThread);
      /* if RescheduleFlag was set during suspend it should be reset */
      App_MainThread_RescheduleFlag = 0;
    }
    /*do what else you want*/
    /* USER CODE BEGIN App_Main_Thread_Entry_Loop */
[#if (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
    PingPong_Process();
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
    Per_Process();
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_FHSS")]
    LrFhss_Process();
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_SWITCH_MODULATION")]
    Switch_Modulation_Process();
[/#if]
[/#if]

    /* USER CODE END App_Main_Thread_Entry_Loop */
  }
  /* Following USER CODE SECTION will be never reached */
  /* it can be use for compilation flag like #else or #endif */
  /* USER CODE BEGIN App_Main_Thread_Entry_Last */

  /* USER CODE END App_Main_Thread_Entry_Last */
}

[/#if][#--  THREADX --]
[#if (SUBGHZ_APPLICATION == "SUBGHZ_AT_SLAVE")]
static void CmdProcessNotify(void)
{
  /* USER CODE BEGIN CmdProcessNotify_1 */

  /* USER CODE END CmdProcessNotify_1 */
[#if THREADX??][#-- If AzRtos is used --]
  tx_thread_resume(&Thd_VcomProcessId);
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  osThreadFlagsSet(Thd_VcomProcessId, 1);
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
  UTIL_SEQ_SetTask(1 << CFG_SEQ_Task_Vcom, CFG_SEQ_Prio_0);
[#else]
    /* USER CODE BEGIN CmdProcessNotify_OS */

    /* USER CODE END CmdProcessNotify_OS */
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
  /* USER CODE BEGIN CmdProcessNotify_2 */

  /* USER CODE END CmdProcessNotify_2 */
}
[#if THREADX??][#-- If AzRtos is used --]

static void Thd_VcomProcess_Entry(ULONG thread_input)
{
  /* USER CODE BEGIN Thd_VcomProcess_Entry_1 */

  /* USER CODE END Thd_VcomProcess_Entry_1 */
  (void) thread_input;
  /* Infinite loop */
  for (;;)
  {
    tx_thread_suspend(&Thd_VcomProcessId);
    CMD_Process();  /*what you want to do*/
    /* USER CODE BEGIN Thd_VcomProcess_Entry_2 */

    /* USER CODE END Thd_VcomProcess_Entry_2 */
  }
  /* Following USER CODE SECTION will be never reached */
  /* it can be use for compilation flag like #else or #endif */
  /* USER CODE BEGIN Thd_VcomProcess_Entry_Last */

  /* USER CODE END Thd_VcomProcess_Entry_Last */
}
[/#if]
[#if FREERTOS??][#-- If FreeRtos is used --]

static void Thd_VcomProcess(void *argument)
{
  /* USER CODE BEGIN Thd_VcomProcess_1 */

  /* USER CODE END Thd_VcomProcess_1 */
  UNUSED(argument);
  for (;;)
  {
    osThreadFlagsWait(1, osFlagsWaitAny, osWaitForever);
    CMD_Process(); /*what you want to do*/
  }
  /* USER CODE BEGIN Thd_VcomProcess_2 */

  /* USER CODE END Thd_VcomProcess_2 */
}
[/#if]
[/#if][#--  (SUBGHZ_APPLICATION == "SUBGHZ_AT_SLAVE") --]
[#if (SUBGHZ_APPLICATION != "SUBGHZ_AT_SLAVE")]
static void OnTxDone(void)
{
  /* USER CODE BEGIN OnTxDone */
[#if (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
  APP_LOG(TS_ON, VLEVEL_L, "OnTxDone\n\r");
  /* Update the State of the FSM*/
  State = TX;
[#if THREADX??]
  if (App_MainThread_RescheduleFlag < 255)
  {
    App_MainThread_RescheduleFlag++;
  }
  tx_thread_resume(&App_MainThread);
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  /* FREERTOS tbd  */
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
  /* Run PingPong process in background*/
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER") || (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_FHSS") || (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_SWITCH_MODULATION")]
  RadioTxDone_flag = 1;
[#if THREADX??]
  if (App_MainThread_RescheduleFlag < 255)
  {
    App_MainThread_RescheduleFlag++;
  }
  tx_thread_resume(&App_MainThread);
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  /* FREERTOS tbd  */
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
[/#if][#--  INTERNAL_USER_SUBGHZ_APP --]
[/#if][#--  FILL_UCS --]
  /* USER CODE END OnTxDone */
}

static void OnRxDone(uint8_t *payload, uint16_t size, int16_t rssi, int8_t LoraSnr_FskCfo)
{
  /* USER CODE BEGIN OnRxDone */
[#if (FILL_UCS == "true")]
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
  for (int32_t i = 0; i < PAYLOAD_LEN; i++)
  {
    APP_LOG(TS_OFF, VLEVEL_H, "%02X", BufferRx[i]);
    if (i % 16 == 15)
    {
      APP_LOG(TS_OFF, VLEVEL_H, "\n\r");
    }
  }
  APP_LOG(TS_OFF, VLEVEL_H, "\n\r");
[#if THREADX??]
  if (App_MainThread_RescheduleFlag < 255)
  {
    App_MainThread_RescheduleFlag++;
  }
  tx_thread_resume(&App_MainThread);
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  /* FREERTOS tbd  */
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
  /* Run PingPong process in background*/
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
  last_rx_rssi = rssi;
  last_rx_cfo = LoraSnr_FskCfo;

  /* Set Rxdone flag */
  RadioRxDone_flag = 1;
[#if THREADX??]
  if (App_MainThread_RescheduleFlag < 255)
  {
    App_MainThread_RescheduleFlag++;
  }
  tx_thread_resume(&App_MainThread);
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  /* FREERTOS tbd  */
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
  /* Run Per process in background*/
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
#if (APP_LONG_PACKET==0)
  memcpy(data_buffer, payload, size);
  payloadLen = size;
#else
  /*from chunk*/
  payloadLen = data_offset;
  /*payload data are not relevant in long packet mode*/
#endif /* APP_LONG_PACKET */
[/#if][#--  INTERNAL_USER_SUBGHZ_APP --]
[/#if][#--  FILL_UCS --]
  /* USER CODE END OnRxDone */
}

static void OnTxTimeout(void)
{
  /* USER CODE BEGIN OnTxTimeout */
[#if (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
  APP_LOG(TS_ON, VLEVEL_L, "OnTxTimeout\n\r");
  /* Update the State of the FSM*/
  State = TX_TIMEOUT;
[#if THREADX??]
  if (App_MainThread_RescheduleFlag < 255)
  {
    App_MainThread_RescheduleFlag++;
  }
  tx_thread_resume(&App_MainThread);
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  /* FREERTOS tbd  */
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
  /* Run PingPong process in background*/
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER") || (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_FHSS") || (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_SWITCH_MODULATION")]
  RadioTxTimeout_flag = 1;
[#if THREADX??]
  if (App_MainThread_RescheduleFlag < 255)
  {
    App_MainThread_RescheduleFlag++;
  }
  tx_thread_resume(&App_MainThread);
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  /* FREERTOS tbd  */
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
  /* Run process in background*/
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
[/#if][#--  INTERNAL_USER_SUBGHZ_APP --]
[/#if][#--  FILL_UCS --]
  /* USER CODE END OnTxTimeout */
}

static void OnRxTimeout(void)
{
  /* USER CODE BEGIN OnRxTimeout */
[#if (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
  APP_LOG(TS_ON, VLEVEL_L, "OnRxTimeout\n\r");
  /* Update the State of the FSM*/
  State = RX_TIMEOUT;
[#if THREADX??]
  if (App_MainThread_RescheduleFlag < 255)
  {
    App_MainThread_RescheduleFlag++;
  }
  tx_thread_resume(&App_MainThread);
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  /* FREERTOS tbd  */
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
  /* Run PingPong process in background*/
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
  RadioRxTimeout_flag = 1;
[#if THREADX??]
  if (App_MainThread_RescheduleFlag < 255)
  {
    App_MainThread_RescheduleFlag++;
  }
  tx_thread_resume(&App_MainThread);
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  /* FREERTOS tbd  */
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
  /* Run Per process in background*/
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
[/#if][#--  INTERNAL_USER_SUBGHZ_APP --]
[/#if][#--  FILL_UCS --]
  /* USER CODE END OnRxTimeout */
}

static void OnRxError(void)
{
  /* USER CODE BEGIN OnRxError */
[#if (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PINGPONG")]
  APP_LOG(TS_ON, VLEVEL_L, "OnRxError\n\r");
  /* Update the State of the FSM*/
  State = RX_ERROR;
[#if THREADX??]
  if (App_MainThread_RescheduleFlag < 255)
  {
    App_MainThread_RescheduleFlag++;
  }
  tx_thread_resume(&App_MainThread);
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  /* FREERTOS tbd  */
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
  /* Run PingPong process in background*/
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
  RadioError_flag = 1;
[#if THREADX??]
  if (App_MainThread_RescheduleFlag < 255)
  {
    App_MainThread_RescheduleFlag++;
  }
  tx_thread_resume(&App_MainThread);
[#elseif FREERTOS??][#-- If FreeRtos is used --]
  /* FREERTOS tbd  */
[#elseif ((UTIL_SEQ_EN_M0 == "true") && (CPUCORE == "CM0PLUS")) || ((UTIL_SEQ_EN_M4 == "true") && (CPUCORE != "CM0PLUS"))]
  /* Run Per process in background*/
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_SubGHz_Phy_App_Process), CFG_SEQ_Prio_0);
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
[/#if][#--  INTERNAL_USER_SUBGHZ_APP --]
[/#if][#--  FILL_UCS --]
  /* USER CODE END OnRxError */
}

[/#if]
/* USER CODE BEGIN PrFD */
[#if (FILL_UCS == "true")]
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

[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
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
  for (int32_t i = 0; i < chunk_size; i++)
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
    for (int32_t i = 0; i < payloadLen; i++)
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
  /* This delay is only to give enough time to allow DMA to empty printf queue*/
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

[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_FHSS")]
static void LrFhss_Process(void)
{
  packetCnt++;

  HAL_GPIO_WritePin(LED1_GPIO_Port, LED1_Pin, GPIO_PIN_RESET); /* LED_BLUE */
  if (RadioTxDone_flag == 1)
  {
    APP_TPRINTF("OnTxDone\r\n");
  }

  if (RadioTxTimeout_flag == 1)
  {
    APP_TPRINTF("OnTxTimeout\r\n");
  }
  /* Clear TxDone or TxTimeout flags */
  RadioTxDone_flag = 0;
  RadioTxTimeout_flag = 0;

  /* This delay is only to give enough time to allow DMA to empty printf queue*/
  HAL_Delay(500);
  /* Build payload */
  tx_payload_generator();

  /* Send Tx Data*/
  if (Radio.Send(data_buffer, payloadLen) == RADIO_STATUS_OK)
  {
    APP_TPRINTF("Tx %d \r\n", packetCnt);
    HAL_GPIO_WritePin(LED1_GPIO_Port, LED1_Pin, GPIO_PIN_SET); /* LED_BLUE */
  }
  else
  {
    APP_TPRINTF("Tx error with packet %d \r\n", packetCnt);
    APP_TPRINTF("LrFhss_Process will not be reschedule, please restart to debug \r\n");
  }
}

[#elseif (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_SWITCH_MODULATION")]
static void Switch_Modulation_Process(void)
{
  packetCnt++;

  HAL_GPIO_WritePin(LED1_GPIO_Port, LED1_Pin, GPIO_PIN_RESET); /* LED_BLUE */
  if (RadioTxDone_flag == 1)
  {
    APP_TPRINTF("OnTxDone\r\n");
  }

  if (RadioTxTimeout_flag == 1)
  {
    APP_TPRINTF("OnTxTimeout\r\n");
  }

  if (ModemConfig == MODEM_FSK)
  {
    if (ModemConfigChange)
    {
      Radio_Fsk_TxConfig();
      APP_TPRINTF("Config changed to MODEM_FSK\r\n");
      ModemConfigChange = 0;
    }
    else
    {
      APP_TPRINTF("MODEM_FSK\r\n");
    }
    HAL_Delay(1500); /* to differentiate the blinking */
  }
  else if (ModemConfig == MODEM_LORA)
  {
    if (ModemConfigChange)
    {
      Radio_Lora_TxConfig();
      APP_TPRINTF("Config changed to MODEM_LORA\r\n");
      ModemConfigChange = 0;
    }
    else
    {
      APP_TPRINTF("MODEM_LORA\r\n");
    }
  }
  else /* MODEM FHSS */
  {
    if (ModemConfigChange)
    {
      APP_TPRINTF("Config changes to MODEM_FHSS\r\n");
      Radio_LrFhss_TxConfig();
      LrFhssParamSwitch++;
      ModemConfigChange = 0;
    }
    else
    {
      APP_TPRINTF("MODEM_FHSS\r\n");
    }
  }

  /* This delay to give enough time to allow DMA to empty printf queue*/
  HAL_Delay(800);
  /* Reset TX Done or timeout flags */
  RadioTxDone_flag = 0;
  RadioTxTimeout_flag = 0;

  /* Build payload */
  tx_payload_generator();

  /* Send Tx Data*/
  if (Radio.Send(data_buffer, payloadLen) == RADIO_STATUS_OK)
  {
    APP_TPRINTF("Tx %d \r\n", packetCnt);
    HAL_GPIO_WritePin(LED1_GPIO_Port, LED1_Pin, GPIO_PIN_SET); /* LED_BLUE */
  }
  else
  {
    APP_TPRINTF("Tx error with packet %d \r\n", packetCnt);
    APP_TPRINTF("LrFhss_Process will not be reschedule, please restart to debug \r\n");
  }
}

[/#if][#--  INTERNAL_USER_SUBGHZ_APP --]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
#if (TEST_MODE == RADIO_TX)
[/#if]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER") || (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_FHSS") || (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_SWITCH_MODULATION")]
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
{
  switch (GPIO_Pin)
  {
    case  BUT1_Pin:
[#if (INTERNAL_USER_SUBGHZ_APP != "SUBGHZ_SWITCH_MODULATION")]
      /* Increment by 16*/
      payloadLen += 16;
      if (payloadLen > payloadLenMax)
      {
        payloadLen = 16;
      }
      APP_TPRINTF("New Tx Payload Length= %d\r\n", payloadLen);
[#else]
      /* Switch Configuration mode*/
      if (!ModemConfigChange)
      {
        ModemConfigChange = 1;
        ModemConfig = (ModemConfig + 1) % 3;
      }
[/#if]
      break;
[#if STM32WL5MXX=="false"]
    case  BUT2_Pin:
      /* Increment by 1*/
      payloadLen += 1;
      if (payloadLen > payloadLenMax)
      {
        payloadLen = 1;
      }
      APP_TPRINTF("New Tx Payload Length= %d\r\n", payloadLen);

      break;
    case  BUT3_Pin:
      /* Toggle TxPayloadMode*/
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
[/#if]
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
[/#if][#--  INTERNAL_USER_SUBGHZ_APP --]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
#endif /* TEST_MODE */
[/#if]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_FHSS") || (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_SWITCH_MODULATION")]

static void set_tx_payload_len_max(lr_fhss_v1_cr_t cr, uint8_t hc)
{
  /* The limit is due to a 255-byte maximum physical payload size */
  /*  (after encoding and packet construction)                    */
  if ((hc != 0) && (hc < STRUCT_FIELD_SIZE(SubghzPhyTxPayloadLen_t, header_count)))
  {
    for (uint32_t index = 0; index < (sizeof(txPayloadLen) / sizeof(SubghzPhyTxPayloadLen_t)); index++)
    {
      if (cr == txPayloadLen[index].coding_rate)
      {
        payloadLenMax = txPayloadLen[index].header_count[hc];
        break;
      }
    }
  }
}
[/#if][#--  INTERNAL_USER_SUBGHZ_APP --]
[#else]

[/#if][#--  FILL_UCS --]
/* USER CODE END PrFD */
