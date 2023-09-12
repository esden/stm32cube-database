[#ftl]
/* USER CODE BEGIN Header */
/**
  ****************************************************************************
  * @file    rf_api.c
  * @author  MCD Application Team
  * @brief   rf library interface
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
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
[#assign SUBGHZ_APPLICATION = ""]
[#assign FILL_UCS = ""]
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

/* includes -----------------------------------------------------------*/
#include "stdint.h"
#include "sigfox_types.h"
#include "sigfox_api.h"
#include "rf_api.h"
#include "radio.h"
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
[#if THREADX??][#-- If AzRtos is used --]
#include "app_azure_rtos.h"
#include "tx_api.h"
[#else]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
#include "stm32_seq.h"
[#else]
#include "cmsis_os.h"
[/#if]
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]
#include "stm32_mem.h"
#include "utilities_def.h"
#include "sgfx_eeprom_if.h"
#include "sys_debug.h"
#include "sgfx_cstimer.h"
#include "stm32_timer.h"
#include "sys_app.h" /*for APP_LOG*/
#include "platform.h"
[/#if][#--  SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION" --]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
[#if THREADX??]
extern TX_SEMAPHORE  Sem_TxTimeout;
extern TX_SEMAPHORE  Sem_Timeout;

[#elseif FREERTOS??][#-- If FreeRtos is used --]
extern osSemaphoreId_t Sem_TxTimeout;
extern osSemaphoreId_t Sem_Timeout;

[/#if]
[/#if][#--  SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION" --]
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
#define RF_VER                   "RF_API_V1.0"
#define SFX_PREAMBLE_LENGTH      2
#define MONARCH_PREAMBLE_LENGTH (65535/8) /*max length to never synchronize*/
#define SFX_MAX_PAYLOAD_LENGTH   15
#define SFX_DATARATE_600         600
#define SFX_DATARATE_100         100

[/#if]
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]

static sfx_u8 rf_api_version[] = RF_VER;

static uint8_t *RxFrame;

static int16_t RxRssi;

static sfx_u8 RxPacketReceived = 0;
[/#if]

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
/*!
  * \brief Waits End of Rx, either by a successful Reception or by a timeout
  * \Return 0 when timeOut or 1 when successful Reception
  */
static sfx_u8 sfx_wait_end_of_rx(void);

[/#if]
/*!
  * \brief Function to be executed on Radio Tx Done event
  */
static void OnTxDone(void);

/*!
  * \brief Function to be executed on Radio Rx Done event
  */
static void OnRxDone(uint8_t *payload, uint16_t size, int16_t rssi, int8_t snr);

/*!
  * \brief Function executed on Radio Tx Timeout event
  */
static void OnTxTimeout(void);

/*!
  * \brief Function executed on Radio Rx Timeout event
  */
static void OnRxTimeout(void);

/*!
  * \brief Function executed on Radio Rx Error event
  */
static void OnRxError(void);

[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
/*use for CS*/
static bool RF_API_isChannelFree(int16_t rssiThresh, uint32_t maxCarrierSenseTime);

[/#if]
const RadioEvents_t RfApiRadioEvents =
{
  OnTxDone,
  OnTxTimeout,
  OnRxDone,
  OnRxTimeout,
  OnRxError,
};

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/
sfx_u8 RF_API_init(sfx_rf_mode_t rf_mode)
{
  sfx_u8 status = SFX_ERR_NONE;
  /* USER CODE BEGIN RF_API_init_1 */

  /* USER CODE END RF_API_init_1 */
  /* Put here all RF initialization concerning the RC IC you are using. */

  switch (rf_mode)
  {
    case SFX_RF_MODE_TX:
    {
      /* USER CODE BEGIN SFX_RF_MODE_TX_1 */

      /* USER CODE END SFX_RF_MODE_TX_1 */
      /* Initialize Tx if necessary*/
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
      APP_LOG(TS_ON, VLEVEL_M, "RF_API_init in TX\n\r");
[/#if]

      /* USER CODE BEGIN SFX_RF_MODE_TX_2 */

      /* USER CODE END SFX_RF_MODE_TX_2 */
      break;
    }
    case SFX_RF_MODE_RX:
    {
      /* Configure the RF_IP IC in RX mode : GFSK 600bps*/
      /* RF IC must configure the SYNCHRO BIT = 0xAAAAAAAAAA and synchro frame = 0xB227 */
      /* USER CODE BEGIN SFX_RF_MODE_RX_1 */

      /* USER CODE END SFX_RF_MODE_RX_1 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
      APP_LOG(TS_ON, VLEVEL_M, "RF_API_init in RX\n\r");
      Radio.SetRxConfig(MODEM_SIGFOX_RX, 1600,
                        SFX_DATARATE_600, NA,
                        NA, SFX_PREAMBLE_LENGTH,
                        1000, true,
                        SFX_MAX_PAYLOAD_LENGTH,
                        false, NA, NA,
                        NA, true);
[/#if]

      /* USER CODE BEGIN SFX_RF_MODE_RX_2 */

      /* USER CODE END SFX_RF_MODE_RX_2 */
      break;
    }
    case SFX_RF_MODE_CS200K_RX:
    {
      /* USER CODE BEGIN SFX_RF_MODE_CS200K_RX_1 */

      /* USER CODE END SFX_RF_MODE_CS200K_RX_1 */
      /* configure the RF_IP into sensing 200KHz bandwidth to be able to read out RSSI level */
      /* RSSI level will extracted during the RF_API_wait_for_clear_channel function */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
      APP_LOG(TS_ON, VLEVEL_M, "RF_API_init in CS200\n\r");

      Radio.SetRxConfig(MODEM_SIGFOX_RX, 200000,
                        SFX_DATARATE_600, NA,
                        NA, SFX_PREAMBLE_LENGTH,
                        1000, true,
                        SFX_MAX_PAYLOAD_LENGTH,
                        false, NA, NA,
                        NA, true);
[/#if]

      /* USER CODE BEGIN SFX_RF_MODE_CS200K_RX_2 */

      /* USER CODE END SFX_RF_MODE_CS200K_RX_2 */
      break;
    }
    case SFX_RF_MODE_CS300K_RX:
    {
      /* USER CODE BEGIN SFX_RF_MODE_CS300K_RX_1 */

      /* USER CODE END SFX_RF_MODE_CS300K_RX_1 */

      /* configure the RF_IP into sensing 300KHz bandwidth to be able to read out RSSI level */
      /* RSSI level will extracted during the RF_API_wait_for_clear_channel function. */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
      APP_LOG(TS_ON, VLEVEL_M, "RF_API_init in CS300\n\r");

      Radio.SetRxConfig(MODEM_SIGFOX_RX, 300000,
                        SFX_DATARATE_600, NA,
                        NA, SFX_PREAMBLE_LENGTH,
                        1000, true,
                        SFX_MAX_PAYLOAD_LENGTH,
                        false, NA, NA,
                        NA, true);
[/#if]

      /* USER CODE BEGIN SFX_RF_MODE_CS300K_RX_2 */

      /* USER CODE END SFX_RF_MODE_CS300K_RX_2 */
      break;
    }
    case SFX_RF_MODE_MONARCH:
    {
      /* USER CODE BEGIN SFX_RF_MODE_MONARCH_1 */

      /* USER CODE END SFX_RF_MODE_MONARCH_1 */

      /* configure the RF_IP into sensing 20KHz bandwidth */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
      APP_LOG(TS_ON, VLEVEL_M, "RF_API_init in MN20\n\r");
      /* APP_LOG(TS_ON, VLEVEL_L,"RxBw=20kHz\n\r"); */
      Radio.SetRxConfig(MODEM_SIGFOX_RX, 20000,
                        SFX_DATARATE_100, NA,
                        NA, MONARCH_PREAMBLE_LENGTH,
                        1000, true,
                        SFX_MAX_PAYLOAD_LENGTH,
                        false, NA, NA,
                        NA, true);
[/#if]

      /* USER CODE BEGIN SFX_RF_MODE_MONARCH_2 */

      /* USER CODE END SFX_RF_MODE_MONARCH_2 */
      break;
    }
    default :
      status = RF_ERR_API_INIT;
      break;
  }
  /* USER CODE BEGIN RF_API_init_2 */

  /* USER CODE END RF_API_init_2 */
  return status;
}

sfx_u8 RF_API_stop(void)
{
  sfx_u8 status = SFX_ERR_NONE;
  /* USER CODE BEGIN RF_API_stop_1 */

  /* USER CODE END RF_API_stop_1 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  APP_LOG(TS_ON, VLEVEL_M, "RF_API_stop\n\r");

  Radio.Sleep();
[/#if]
  /* USER CODE BEGIN RF_API_stop_2 */

  /* USER CODE END RF_API_stop_2 */

  return status;
}

sfx_u8 RF_API_send(sfx_u8 *stream, sfx_modulation_type_t type, sfx_u8 size)
{
  sfx_u8 status = SFX_ERR_NONE;
  /* USER CODE BEGIN RF_API_send_1 */

  /* USER CODE END RF_API_send_1 */

[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  uint32_t datarate;

  int8_t power = E2P_Read_Power(E2P_Read_Rc());

  APP_LOG(TS_ON, VLEVEL_M, "TX START:nB=%d\n\r", size);
[/#if]
  switch (type)
  {
    case SFX_DBPSK_100BPS :
      /* USER CODE BEGIN RF_API_send_DBPSK_100BPS_1 */

      /* USER CODE END RF_API_send_DBPSK_100BPS_1 */
      /* Send to the RF_IP the stream built by the sigfox lib @100bps:
       * this bitstream contains all data including synchro bits+frame and CRC.*/
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
      datarate = SFX_DATARATE_100;
[/#if]

      /* USER CODE BEGIN RF_API_send_DBPSK_100BPS_2 */

      /* USER CODE END RF_API_send_DBPSK_100BPS_2 */
      break;
    case SFX_DBPSK_600BPS :
      /* USER CODE BEGIN RF_API_send_DBPSK_600BPS_1 */

      /* USER CODE END RF_API_send_DBPSK_600BPS_1 */
      /* Send to the RF_IP the stream built by the sigfox lib @600bps:
       * this bitstream contains all data including synchro bits+frame and CRC.*/
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
      datarate = SFX_DATARATE_600;
[/#if]

      /* USER CODE BEGIN RF_API_send_DBPSK_600BPS_2 */

      /* USER CODE END RF_API_send_DBPSK_600BPS_2 */

      break;
    default :
      status = RF_ERR_API_SEND;
      break;
  }
  /* USER CODE BEGIN RF_API_send_2 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION") && (FILL_UCS == "true")]
  HAL_GPIO_WritePin(LED1_GPIO_Port, LED1_Pin, GPIO_PIN_SET); /* LED_BLUE */
[/#if]

  /* USER CODE END RF_API_send_2 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  if (status == SFX_ERR_NONE)
  {
    Radio.SetTxConfig(MODEM_SIGFOX_TX, power, NA,
                      NA, datarate,
                      NA, NA,
                      NA, NA, NA,
                      NA, NA, 3000);

    Radio.Send(stream, size);

    APP_LOG(TS_ON, VLEVEL_M, "Wait For End of Tx\n\r");

[#if THREADX??][#-- If AzRtos is used --]
    while (tx_semaphore_get(&Sem_TxTimeout, TX_WAIT_FOREVER) != TX_SUCCESS) {}
[#else]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
    UTIL_SEQ_WaitEvt(1 << CFG_SEQ_Evt_TxTimeout);
[#else]
    osSemaphoreAcquire(Sem_TxTimeout, osWaitForever);
[/#if]
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]

    APP_LOG(TS_ON, VLEVEL_M, "End Of Tx\n\r");

  }

  APP_LOG(TS_ON, VLEVEL_M, "TX END\n\r");
[/#if][#--  SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION" --]
  /* USER CODE BEGIN RF_API_send_3 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION") && (FILL_UCS == "true")]
  HAL_GPIO_WritePin(LED1_GPIO_Port, LED1_Pin, GPIO_PIN_RESET); /* LED_BLUE */
[/#if]

  /* USER CODE END RF_API_send_3 */
  return status;

}

sfx_u8 RF_API_start_continuous_transmission(sfx_modulation_type_t type)
{
  sfx_u8 status = SFX_ERR_NONE;
  /* USER CODE BEGIN RF_API_start_continuous_transmission_1 */

  /* USER CODE END RF_API_start_continuous_transmission_1 */

[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  int8_t power = E2P_Read_Power(E2P_Read_Rc());
[/#if]

  switch (type)
  {
    case SFX_NO_MODULATION :
      /* Starts CW continuous Tx at the frequency given by the RF_API_change_frequency()*/

      /* USER CODE BEGIN RF_API_start_continuous_transmission_NO_MODULATION_1 */

      /* USER CODE END RF_API_start_continuous_transmission_NO_MODULATION_1 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
      Radio.TxCw(power);
[/#if]

      /* USER CODE BEGIN RF_API_start_continuous_transmission_NO_MODULATION_2 */

      /* USER CODE END RF_API_start_continuous_transmission_NO_MODULATION_2 */
      break;
    case SFX_DBPSK_100BPS :
      /* Starts an infinite DBPSK 100bps modulation on the RF IC at the frequency given by the RF_API_change_frequency() */

      /* USER CODE BEGIN RF_API_start_continuous_transmission_DBPSK_100BPS_1 */

      /* USER CODE END RF_API_start_continuous_transmission_DBPSK_100BPS_1 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
      Radio.SetTxConfig(MODEM_SIGFOX_TX, power, NA,
                        NA, SFX_DATARATE_100,
                        NA, NA,
                        NA, NA, NA,
                        NA, NA, 3000);
      Radio.TxPrbs();
[/#if]
      /* USER CODE BEGIN RF_API_start_continuous_transmission_DBPSK_100BPS_2 */

      /* USER CODE END RF_API_start_continuous_transmission_DBPSK_100BPS_2 */
      break;
    case SFX_DBPSK_600BPS :
      /* Starts an infinite DBPSK 600bps modulation on the RF IC at the frequency given by the RF_API_change_frequency() */

      /* USER CODE BEGIN RF_API_start_continuous_transmission_DBPSK_600BPS_1 */

      /* USER CODE END RF_API_start_continuous_transmission_DBPSK_600BPS_1 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
      Radio.SetTxConfig(MODEM_SIGFOX_TX, power, NA,
                        NA, SFX_DATARATE_600,
                        NA, NA,
                        NA, NA, NA,
                        NA, NA, 3000);
      Radio.TxPrbs();
[/#if]
      /* USER CODE BEGIN RF_API_start_continuous_transmission_DBPSK_600BPS_2 */

      /* USER CODE END RF_API_start_continuous_transmission_DBPSK_600BPS_2 */
      break;
    default :
      status = RF_ERR_API_SEND;
      break;
  }
  /* USER CODE BEGIN RF_API_start_continuous_transmission_2 */

  /* USER CODE END RF_API_start_continuous_transmission_2 */
  return status;
}

sfx_u8 RF_API_stop_continuous_transmission(void)
{
  sfx_u8 status = SFX_ERR_NONE;
  /* stop continuous Tx */

  /* USER CODE BEGIN RF_API_stop_continuous_transmission_1 */

  /* USER CODE END RF_API_stop_continuous_transmission_1 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  APP_LOG(TS_ON, VLEVEL_M, "RF_API_stop\n\r");

  Radio.Sleep();
[/#if]
  /* USER CODE BEGIN RF_API_stop_continuous_transmission_2 */

  /* USER CODE END RF_API_stop_continuous_transmission_2 */
  return status;
}

sfx_u8 RF_API_change_frequency(sfx_u32 frequency)
{
  sfx_u8 status = SFX_ERR_NONE;
  /* set rf frequency for Rx or Tx*/

  /* USER CODE BEGIN RF_API_change_frequency_1 */

  /* USER CODE END RF_API_change_frequency_1 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  APP_LOG(TS_ON, VLEVEL_M, "RF at Freq %d\n\r", frequency);

  Radio.SetChannel(frequency);
[/#if]
  /* USER CODE BEGIN RF_API_change_frequency_2 */

  /* USER CODE END RF_API_change_frequency_2 */
  return status;
}

sfx_u8 RF_API_wait_frame(sfx_u8 *frame, sfx_s16 *rssi, sfx_rx_state_enum_t *state)
{
  sfx_u8 status = SFX_ERR_NONE;
  sfx_s16 res_rssi = 0;
  sfx_rx_state_enum_t ret_state = DL_TIMEOUT;
  /* USER CODE BEGIN RF_API_wait_frame_1 */

  /* USER CODE END RF_API_wait_frame_1 */
  /* Starts Rx Windows and wait up to the end of frame or end of rx window*/
  /*  Wait for 2 events :
   *  event from your RF_IP indicating a buffer is received or
   *  event from the timer end : event_timer (see mcu_api.c)
   * If buffer is received, then copy the buffer in frame buffer and update the state parameter*/
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]

  APP_LOG(TS_ON, VLEVEL_M, "RX START\n\r");

  Radio.RxBoosted(0);

  /*save address for callback*/
  RxFrame = frame;

  if (sfx_wait_end_of_rx() == 1)
  {
    status = SFX_ERR_NONE;
    ret_state = DL_PASSED;
  }
  else
  {
    ret_state = DL_TIMEOUT;
    status = SFX_ERR_NONE;
  }

  res_rssi = (sfx_s16) RxRssi;

  APP_LOG(TS_ON, VLEVEL_M, "RX END\n\r");
  /* USER CODE BEGIN RF_API_wait_frame_2 */

  /* USER CODE END RF_API_wait_frame_2 */
[#else]
  /* USER CODE BEGIN RF_API_wait_frame_2 */

  /* USER CODE END RF_API_wait_frame_2 */
[/#if][#--  SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION" --]
  *state = ret_state;
  *rssi = res_rssi;
  return status;
}

sfx_u8 RF_API_wait_for_clear_channel(sfx_u8 cs_min, sfx_s8 cs_threshold, sfx_rx_state_enum_t *state)
{
  sfx_u8 status = SFX_ERR_NONE;
  sfx_rx_state_enum_t cs_state = DL_TIMEOUT;
  /* Starts Rx Windows to sense if channel is occupied or clear*
   * If the channel is clear during the minimum carrier sense
   * value (cs_min), under the limit of the cs_threshold,
   * the functions returns with SFX_ERR_NONE (transmission
   * allowed). Otherwise it continues to listen to the channel till the expiration of the
   * carrier sense maximum window and then updates the state ( with timeout enum ).*/

  /* USER CODE BEGIN RF_API_wait_for_clear_channel_1 */

  /* USER CODE END RF_API_wait_for_clear_channel_1 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]

  RxCarrierSenseInitStatus();

  Radio.Rx(0);

  HAL_Delay(Radio.GetWakeupTime());

  APP_LOG(TS_ON, VLEVEL_M, "CS start cs_min=%dms, cs_threshold=%dBm\n\r", cs_min, cs_threshold);

  while (RxCarrierSenseGetStatus() == 0)
  {
    if (RF_API_isChannelFree((int16_t) cs_threshold, (uint32_t) cs_min) == true)
    {
      cs_state = DL_PASSED;
      break;
    }
  }
  Radio.Standby();

  if (cs_state == DL_PASSED)
  {
    APP_LOG(TS_ON, VLEVEL_M, "LBT Channel Free\n\r");
  }
  else
  {
    APP_LOG(TS_ON, VLEVEL_M, "LBT Channel Busy\n\r");
  }

[/#if]
  /* USER CODE BEGIN RF_API_wait_for_clear_channel_2 */

  /* USER CODE END RF_API_wait_for_clear_channel_2 */
  *state = cs_state;
  return status;
}

sfx_u8 RF_API_get_version(sfx_u8 **version, sfx_u8 *size)
{
  sfx_u8 status = SFX_ERR_NONE;
  /* return version and size of the version buffer*/
  /* USER CODE BEGIN RF_API_get_version_1 */

  /* USER CODE END RF_API_get_version_1 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]

  *version = (sfx_u8 *)rf_api_version;
  if (size == SFX_NULL)
  {
    return RF_ERR_API_GET_VERSION;
  }
  *size = sizeof(rf_api_version);
[/#if]
  /* USER CODE BEGIN RF_API_get_version_2 */

  /* USER CODE END RF_API_get_version_2 */
  return status;
}

/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/

static void OnTxDone(void)
{
  /* USER CODE BEGIN OnTxDone_1 */

  /* USER CODE END OnTxDone_1 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
[#if THREADX??][#-- If AzRtos is used --]
  /* Set the semaphore to release the Sem_TxTimeout Thread */
  tx_semaphore_put(&Sem_TxTimeout);
[#else]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_SetEvt(1 << CFG_SEQ_Evt_TxTimeout);
[#else]
  osSemaphoreRelease(Sem_TxTimeout);
[/#if]
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]

  APP_LOG(TS_ON, VLEVEL_M, "OnTxDone\n\r");

[/#if][#--  SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION" --]
  /* USER CODE BEGIN OnTxDone_2 */

  /* USER CODE END OnTxDone_2 */
}

static void OnRxDone(uint8_t *payload, uint16_t size, int16_t rssi, int8_t offset)
{
  /* USER CODE BEGIN OnRxDone_1 */

  /* USER CODE END OnRxDone_1 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  UTIL_MEM_cpy_8(RxFrame, payload, size);

  RxRssi = rssi;

  RxPacketReceived = 1;
  /*wakes up the MCU at line UTIL_SEQ_WaitEvt( 1 << CFG_SEQ_Evt_Timeout );*/
[#if THREADX??][#-- If AzRtos is used --]
  /* Set the semaphore to release the Sem_Timeout Thread */
  tx_semaphore_put(&Sem_Timeout);
[#else]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_SetEvt(1 << CFG_SEQ_Evt_Timeout);
[#else]
  osSemaphoreRelease(Sem_Timeout);
[/#if]
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]

  APP_LOG(TS_ON, VLEVEL_M, "OnRxDone\n\r");

[/#if][#--  SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION" --]
  /* USER CODE BEGIN OnRxDone_2 */

  /* USER CODE END OnRxDone_2 */
}

static void OnTxTimeout(void)
{
  /* USER CODE BEGIN OnTxTimeout_1 */

  /* USER CODE END OnTxTimeout_1 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
[#if THREADX??][#-- If AzRtos is used --]
  /* Set the semaphore to release the Sem_TxTimeout Thread */
  tx_semaphore_put(&Sem_TxTimeout);
[#else]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_SetEvt(1 << CFG_SEQ_Evt_TxTimeout);
[#else]
  osSemaphoreRelease(Sem_TxTimeout);
[/#if]
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]

  APP_LOG(TS_ON, VLEVEL_M,  "OnTxTimeout\n\r");

[/#if][#--  SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION" --]
  /* USER CODE BEGIN OnTxTimeout_2 */

  /* USER CODE END OnTxTimeout_2 */
}

static void OnRxTimeout(void)
{
  /* USER CODE BEGIN OnRxTimeout_1 */

  /* USER CODE END OnRxTimeout_1 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  RxPacketReceived = 0;

[#if THREADX??][#-- If AzRtos is used --]
  /* Set the semaphore to release the Sem_Timeout Thread */
  tx_semaphore_put(&Sem_Timeout);
[#else]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_SetEvt(1 << CFG_SEQ_Evt_Timeout);
[#else]
  osSemaphoreRelease(Sem_Timeout);
[/#if]
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]

  APP_LOG(TS_ON, VLEVEL_M,  "OnRxTimeout\n\r");

[/#if][#--  SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION" --]
  /* USER CODE BEGIN OnRxTimeout_2 */

  /* USER CODE END OnRxTimeout_2 */
}

static void OnRxError(void)
{
  /* USER CODE BEGIN OnRxError_1 */

  /* USER CODE END OnRxError_1 */
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
  RxPacketReceived = 0;

[#if THREADX??][#-- If AzRtos is used --]
  /* Set the semaphore to release the Sem_Timeout Thread */
  tx_semaphore_put(&Sem_Timeout);
[#else]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_SetEvt(1 << CFG_SEQ_Evt_Timeout);
[#else]
  osSemaphoreRelease(Sem_Timeout);
[/#if]
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]

  APP_LOG(TS_ON, VLEVEL_M, "OnRxError\n\r");

[/#if][#--  SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION" --]
  /* USER CODE BEGIN OnRxError_2 */

  /* USER CODE END OnRxError_2 */
}

[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
static sfx_u8 sfx_wait_end_of_rx(void)
{
  /* USER CODE BEGIN sfx_wait_end_of_rx_1 */

  /* USER CODE END sfx_wait_end_of_rx_1 */
  RxPacketReceived = 0;

  RxRssi = -150;

  APP_LOG(TS_ON, VLEVEL_M, "Wait For End of Rx\n\r");

[#if THREADX??][#-- If AzRtos is used --]
  while (tx_semaphore_get(&Sem_Timeout, TX_WAIT_FOREVER) != TX_SUCCESS) {}
[#else]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_ClrEvt(1 << CFG_SEQ_Evt_Timeout);

  UTIL_SEQ_WaitEvt(1 << CFG_SEQ_Evt_Timeout);
[#else]
  osSemaphoreAcquire(Sem_Timeout, osWaitForever);
[/#if]
[/#if][#--  THREADX vs FREERTOS vs SEQUENCER --]

  APP_LOG(TS_ON, VLEVEL_M, "End Of Rx\n\r");

  return RxPacketReceived;
  /* USER CODE BEGIN sfx_wait_end_of_rx_2 */

  /* USER CODE END sfx_wait_end_of_rx_2 */
}

bool RF_API_isChannelFree(int16_t rssiThresh, uint32_t maxCarrierSenseTime)
{
  /* USER CODE BEGIN RF_API_isChannelFree_1 */

  /* USER CODE END RF_API_isChannelFree_1 */
  bool status = true;
  int16_t rssi = 0;
  uint32_t carrierSenseTime = 0;

  carrierSenseTime = UTIL_TIMER_GetCurrentTime();

  /* Perform carrier sense for maxCarrierSenseTime */
  while (UTIL_TIMER_GetElapsedTime(carrierSenseTime) < maxCarrierSenseTime)
  {
    rssi = Radio.Rssi(MODEM_FSK);

    if (rssi > rssiThresh)
    {
      status = false;
      break;
    }
  }
  return status;
  /* USER CODE BEGIN RF_API_isChannelFree_2 */

  /* USER CODE END RF_API_isChannelFree_2 */
}
[/#if][#--  SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION" --]

/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
