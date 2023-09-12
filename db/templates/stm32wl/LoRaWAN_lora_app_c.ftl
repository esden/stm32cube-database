[#ftl]
/**
  ******************************************************************************
  * @file    lora_app.c
  * @author  MCD Application Team
  * @brief   Application of the LRWAN Middleware
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
[#assign SUBGHZ_APPLICATION = ""]

[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "SUBGHZ_APPLICATION"]
                [#assign SUBGHZ_APPLICATION = definition.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]
/* Includes ------------------------------------------------------------------*/
#include "platform.h"
#include "Region.h" /* Needed for LORAWAN_DEFAULT_DATA_RATE */
#include "sys_app.h"
#include "lora_app.h"
[#if !FREERTOS??][#-- If FreeRtos is not used --]
#include "stm32_seq.h"
[#else]
#include "cmsis_os.h"
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
#include "stm32_timer.h"
#include "utilities_def.h"
#include "lora_app_version.h"
[#if CPUCORE == ""]
#include "lorawan_version.h"
#include "subghz_phy_version.h"
[/#if]
[/#if]
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
[#if CPUCORE == ""]
#include "lora_info.h"
[/#if]
[/#if]
#include "LmHandler.h"
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
#include "stm32_lpm.h"
#include "adc_if.h"
#include "sys_conf.h"
#include "CayenneLpp.h"
#include "sys_sensors.h"
[#elseif (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
#include "lora_command.h"
#include "lora_at.h"
[/#if]
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
[#if (CPUCORE == "CM4")]
#include "mbmuxif_sys.h"
[/#if]
[/#if]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
/**
  * @brief LoRa State Machine states
  */
typedef enum TxEventType_e
{
  /**
    * @brief AppdataTransmition issue based on timer every TxDutyCycleTime
    */
  TX_ON_TIMER,
  /**
    * @brief AppdataTransmition external event plugged on OnSendEvent( )
    */
  TX_ON_EVENT
  /* USER CODE BEGIN TxEventType_t */

  /* USER CODE END TxEventType_t */
} TxEventType_t;

[/#if]
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private function prototypes -----------------------------------------------*/
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
/**
  * @brief  LoRa endNode send request
  * @param  none
  * @retval none
  */
static void SendTxData(void);

/**
  * @brief  TX timer callback function
  * @param  timer context
  * @retval none
  */
static void OnTxTimerEvent(void *context);

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
/**
  * @brief  LED Tx timer callback function
  * @param  LED context
  * @retval none
  */
static void OnTxTimerLedEvent(void *context);

/**
  * @brief  LED Rx timer callback function
  * @param  LED context
  * @retval none
  */
static void OnRxTimerLedEvent(void *context);

/**
  * @brief  LED Join timer callback function
  * @param  LED context
  * @retval none
  */
static void OnJoinTimerLedEvent(void *context);

[/#if]
/**
  * @brief  join event callback function
  * @param  params
  * @retval none
  */
static void OnJoinRequest(LmHandlerJoinParams_t *joinParams);

/**
  * @brief  tx event callback function
  * @param  params
  * @retval none
  */
static void OnTxData(LmHandlerTxParams_t *params);

/**
  * @brief callback when LoRa endNode has received a frame
  * @param appData
  * @param params
  * @retval None
  */
static void OnRxData(LmHandlerAppData_t *appData, LmHandlerRxParams_t *params);

/*!
 * Will be called each time a Radio IRQ is handled by the MAC layer
 *
[#if CPUCORE == "CM4"]
 * \remark OnMacProcessNotify not needed on dual Core as OnMacProcessNotify is processed on M0+
[/#if]
 */
static void OnMacProcessNotify(void);

[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
/**
  * @brief  call back when LoRaWan Stack needs update
  * @param  none
  * @retval none
  */
static void CmdProcessNotify(void);

[/#if]
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private variables ---------------------------------------------------------*/
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
/**
  * @brief User application buffer
  */
static uint8_t AppDataBuffer[LORAWAN_APP_DATA_BUFFER_MAX_SIZE];

/**
  * @brief User application data structure
  */
static LmHandlerAppData_t AppData = { 0, 0, AppDataBuffer };

static ActivationType_t ActivationType = LORAWAN_DEFAULT_ACTIVATION_TYPE;

[/#if]
/**
  * @brief LoRaWAN handler Callbacks
  */
static LmHandlerCallbacks_t LmHandlerCallbacks =
{
  .GetBatteryLevel =           GetBatteryLevel,
  .GetTemperature =            GetTemperatureLevel,
  .OnMacProcess =              OnMacProcessNotify,
  .OnJoinRequest =             OnJoinRequest,
  .OnTxData =                  OnTxData,
  .OnRxData =                  OnRxData
};

[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
/**
  * @brief LoRaWAN handler parameters
  */
static LmHandlerParams_t LmHandlerParams =
{
  .ActiveRegion =             ACTIVE_REGION,
  .DefaultClass =             LORAWAN_DEFAULT_CLASS,
  .AdrEnable =                LORAWAN_ADR_STATE,
  .TxDatarate =               LORAWAN_DEFAULT_DATA_RATE,
  .PingPeriodicity =          LORAWAN_DEFAULT_PING_SLOT_PERIODICITY
};

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
/**
  * @brief Specifies the state of the application LED
  */
static uint8_t AppLedStateOn = RESET;

/**
  * @brief Type of Event to generate application Tx
  */
static TxEventType_t EventType = TX_ON_TIMER;

/**
  * @brief Timer to handle the application Tx
  */
static UTIL_TIMER_Object_t TxTimer;

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
/**
  * @brief Timer to handle the application Tx Led to toggle
  */
static UTIL_TIMER_Object_t TxLedTimer;

/**
  * @brief Timer to handle the application Rx Led to toggle
  */
static UTIL_TIMER_Object_t RxLedTimer;

/**
  * @brief Timer to handle the application Join Led to toggle
  */
static UTIL_TIMER_Object_t JoinLedTimer;

[#if FREERTOS??][#-- If FreeRtos is used --]
osThreadId_t Thd_LoraSendProcessId;

const osThreadAttr_t Thd_LoraSendProcess_attr = {
    .name = CFG_APP_LORA_PROCESS_NAME,
    .attr_bits = CFG_APP_LORA_PROCESS_ATTR_BITS,
    .cb_mem = CFG_APP_LORA_PROCESS_CB_MEM,
    .cb_size = CFG_APP_LORA_PROCESS_CB_SIZE,
    .stack_mem = CFG_APP_LORA_PROCESS_STACK_MEM,
    .priority = CFG_APP_LORA_PROCESS_PRIORITY,
    .stack_size = CFG_APP_LORA_PROCESS_STACk_SIZE
};
static void Thd_LoraSendProcess(void *argument);

[/#if]
[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Exported functions ---------------------------------------------------------*/
/* USER CODE BEGIN EF */

/* USER CODE END EF */

void LoRaWAN_Init(void)
{
[#if (CPUCORE == "CM4") && (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
  FEAT_INFO_Param_t *p_cm0plus_specific_features_info;
  uint32_t lora_cm0plus_app;

[/#if]
  /* USER CODE BEGIN LoRaWAN_Init_1 */

  /* USER CODE END LoRaWAN_Init_1 */
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
#if defined(USE_BSP_DRIVER)
  BSP_LED_Init(LED_BLUE);
  BSP_LED_Init(LED_GREEN);
  BSP_LED_Init(LED_RED);
  BSP_PB_Init(BUTTON_SW2, BUTTON_MODE_EXTI);
#elif defined(MX_BOARD_PSEUDODRIVER)
  SYS_LED_Init(SYS_LED_BLUE);
  SYS_LED_Init(SYS_LED_GREEN);
  SYS_LED_Init(SYS_LED_RED);
  SYS_PB_Init(SYS_BUTTON2, SYS_BUTTON_MODE_EXTI);
#else
#error user to provide its board code or to call his board driver functions
#endif  /* USE_BSP_DRIVER || MX_BOARD_PSEUDODRIVER */
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]

  CMD_Init(CmdProcessNotify);
[/#if]

[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
[#if CPUCORE == "CM4"]
  /* Get CM4 LoRa APP version*/
  APP_LOG(TS_OFF, VLEVEL_M, "M4 APP_VERSION:     V%X.%X.%X\r\n",
          (uint8_t)(__CM4_APP_VERSION >> __APP_VERSION_MAIN_SHIFT),
          (uint8_t)(__CM4_APP_VERSION >> __APP_VERSION_SUB1_SHIFT),
          (uint8_t)(__CM4_APP_VERSION >> __APP_VERSION_SUB2_SHIFT));

  /* Get CM0 LoRa APP version*/
  p_cm0plus_specific_features_info = MBMUXIF_SystemGetFeatCapabInfoPtr(FEAT_INFO_SYSTEM_ID);
  lora_cm0plus_app = p_cm0plus_specific_features_info->Feat_Info_Feature_Version ;
  APP_LOG(TS_OFF, VLEVEL_M, "M0PLUS_APP_VERSION: V%X.%X.%X\r\n",
          (uint8_t)(lora_cm0plus_app >> __APP_VERSION_MAIN_SHIFT),
          (uint8_t)(lora_cm0plus_app >> __APP_VERSION_SUB1_SHIFT),
          (uint8_t)(lora_cm0plus_app >> __APP_VERSION_SUB2_SHIFT));

  /* Get MW LoraWAN info */
  p_cm0plus_specific_features_info = MBMUXIF_SystemGetFeatCapabInfoPtr(FEAT_INFO_LORAWAN_ID);
  lora_cm0plus_app = p_cm0plus_specific_features_info->Feat_Info_Feature_Version ;
  APP_LOG(TS_OFF, VLEVEL_M, "MW_LORAWAN_VERSION: V%X.%X.%X\r\n",
          (uint8_t)(lora_cm0plus_app >> __APP_VERSION_MAIN_SHIFT),
          (uint8_t)(lora_cm0plus_app >> __APP_VERSION_SUB1_SHIFT),
          (uint8_t)(lora_cm0plus_app >> __APP_VERSION_SUB2_SHIFT));

  /* Get MW SubGhz_Phy info */
  p_cm0plus_specific_features_info = MBMUXIF_SystemGetFeatCapabInfoPtr(FEAT_INFO_RADIO_ID);
  lora_cm0plus_app = p_cm0plus_specific_features_info->Feat_Info_Feature_Version ;
  APP_LOG(TS_OFF, VLEVEL_M, "MW_RADIO_VERSION:   V%X.%X.%X\r\n",
          (uint8_t)(lora_cm0plus_app >> __APP_VERSION_MAIN_SHIFT),
          (uint8_t)(lora_cm0plus_app >> __APP_VERSION_SUB1_SHIFT),
          (uint8_t)(lora_cm0plus_app >> __APP_VERSION_SUB2_SHIFT));
[#else]
  /* Get LoRa APP version*/
  APP_LOG(TS_OFF, VLEVEL_M, "APP_VERSION:        V%X.%X.%X\r\n",
          (uint8_t)(__LORA_APP_VERSION >> __APP_VERSION_MAIN_SHIFT),
          (uint8_t)(__LORA_APP_VERSION >> __APP_VERSION_SUB1_SHIFT),
          (uint8_t)(__LORA_APP_VERSION >> __APP_VERSION_SUB2_SHIFT));

  /* Get MW LoraWAN info */
  APP_LOG(TS_OFF, VLEVEL_M, "MW_LORAWAN_VERSION: V%X.%X.%X\r\n",
          (uint8_t)(__LORAWAN_VERSION >> __APP_VERSION_MAIN_SHIFT),
          (uint8_t)(__LORAWAN_VERSION >> __APP_VERSION_SUB1_SHIFT),
          (uint8_t)(__LORAWAN_VERSION >> __APP_VERSION_SUB2_SHIFT));

  /* Get MW SubGhz_Phy info */
  APP_LOG(TS_OFF, VLEVEL_M, "MW_RADIO_VERSION:   V%X.%X.%X\r\n",
          (uint8_t)(__SUBGHZ_PHY_VERSION >> __APP_VERSION_MAIN_SHIFT),
          (uint8_t)(__SUBGHZ_PHY_VERSION >> __APP_VERSION_SUB1_SHIFT),
          (uint8_t)(__SUBGHZ_PHY_VERSION >> __APP_VERSION_SUB2_SHIFT));
[/#if]
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]

  UTIL_TIMER_Create(&TxLedTimer, 0xFFFFFFFFU, UTIL_TIMER_ONESHOT, OnTxTimerLedEvent, NULL);
  UTIL_TIMER_Create(&RxLedTimer, 0xFFFFFFFFU, UTIL_TIMER_ONESHOT, OnRxTimerLedEvent, NULL);
  UTIL_TIMER_Create(&JoinLedTimer, 0xFFFFFFFFU, UTIL_TIMER_PERIODIC, OnJoinTimerLedEvent, NULL);
  UTIL_TIMER_SetPeriod(&TxLedTimer, 500);
  UTIL_TIMER_SetPeriod(&RxLedTimer, 500);
  UTIL_TIMER_SetPeriod(&JoinLedTimer, 500);

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
[#if CPUCORE == "CM4"]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_MbLoRaSendOnTxTimerOrButtonEvent), UTIL_SEQ_RFU, SendTxData);
[#else]
  Thd_LoraSendProcessId = osThreadNew(Thd_LoraSendProcess, NULL, &Thd_LoraSendProcess_attr);
[/#if]
[#else]
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_LmHandlerProcess), UTIL_SEQ_RFU, LmHandlerProcess);
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_LoRaSendOnTxTimerOrButtonEvent), UTIL_SEQ_RFU, SendTxData);
[/#if]
[#elseif (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
[#if CPUCORE == "CM4"]
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_MbLmHandlerProcess), UTIL_SEQ_RFU, LmHandlerProcess);
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_MbVcom), UTIL_SEQ_RFU, CMD_Process);
[#else]
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_LmHandlerProcess), UTIL_SEQ_RFU, LmHandlerProcess);
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_Vcom), UTIL_SEQ_RFU, CMD_Process);

[/#if]
[/#if]
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
[#if CPUCORE == "CM4"]
[#else]
  /* Init Info table used by LmHandler*/
  LoraInfo_Init();

[/#if]
[/#if]
  /* Init the Lora Stack*/
  LmHandlerInit(&LmHandlerCallbacks);

[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
  LmHandlerConfigure(&LmHandlerParams);

  UTIL_TIMER_Start(&JoinLedTimer);

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
  LmHandlerJoin(ActivationType);

  if (EventType == TX_ON_TIMER)
  {
    /* send every time timer elapses */
    UTIL_TIMER_Create(&TxTimer,  0xFFFFFFFFU, UTIL_TIMER_ONESHOT, OnTxTimerEvent, NULL);
    UTIL_TIMER_SetPeriod(&TxTimer,  APP_TX_DUTYCYCLE);
    UTIL_TIMER_Start(&TxTimer);
  }
  else
  {
    /* send every time button is pushed */
#if defined(USE_BSP_DRIVER)
    BSP_PB_Init(BUTTON_SW1, BUTTON_MODE_EXTI);
#elif defined(MX_BOARD_PSEUDODRIVER)
    SYS_PB_Init(SYS_BUTTON1, SYS_BUTTON_MODE_EXTI);
#endif /* USE_BSP_DRIVER || MX_BOARD_PSEUDODRIVER */
  }

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
  APP_PPRINTF("ATtention command interface\r\n");
  APP_PPRINTF("AT? to list all available functions\r\n");
[/#if]
  /* USER CODE BEGIN LoRaWAN_Init_Last */

  /* USER CODE END LoRaWAN_Init_Last */
}

[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
#if defined(USE_BSP_DRIVER)
void BSP_PB_Callback(Button_TypeDef Button)
{
#warning: adapt stm32wlxx_it.c to call BSP_PB_IRQHandler if you want to use BSP
  /* USER CODE BEGIN BSP_PB_Callback_1 */

  /* USER CODE END BSP_PB_Callback_1 */
  switch (Button)
  {
    case  BUTTON_SW1:
[#if CPUCORE == "CM4"]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
      UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_MbLoRaSendOnTxTimerOrButtonEvent), CFG_SEQ_Prio_0);
[#else]
      osThreadFlagsSet( Thd_LoraSendProcessId, 1 );
[/#if]
[#else]
      UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_LoRaSendOnTxTimerOrButtonEvent), CFG_SEQ_Prio_0);
[/#if]
      /* USER CODE BEGIN PB_Callback 1 */
      /* USER CODE END PB_Callback 1 */
      break;
    case  BUTTON_SW2:
      /* USER CODE BEGIN PB_Callback 2 */
      /* USER CODE END PB_Callback 2 */
      break;
    case  BUTTON_SW3:
      /* USER CODE BEGIN PB_Callback 3 */
      /* USER CODE END PB_Callback 3 */
      break;
    default:
      break;
  }
  /* USER CODE BEGIN BSP_PB_Callback_Last */

  /* USER CODE END BSP_PB_Callback_Last */
}

#elif defined(MX_BOARD_PSEUDODRIVER)

/* Note: Current MX does not support EXTI IP neither BSP. */
/* In order to get a push button IRS by code automatically generated */
/* this function is today the only available possibility. */
/* Calling BSP_PB_Callback() from here it shortcuts the BSP. */
/* If users wants to go through the BSP, it can remove BSP_PB_Callback() from here */
/* and add a call to BSP_PB_IRQHandler() in the USER CODE SESSION of the */
/* correspondent EXTIn_IRQHandler() in the stm32wlxx_it.c */
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
{
  /* USER CODE BEGIN HAL_GPIO_EXTI_Callback_1 */

  /* USER CODE END HAL_GPIO_EXTI_Callback_1 */
  switch (GPIO_Pin)
  {
    case  SYS_BUTTON1_PIN:
      /* Note: when "EventType == TX_ON_TIMER" this GPIO is not initialised */
[#if CPUCORE == "CM4"]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
      UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_MbLoRaSendOnTxTimerOrButtonEvent), CFG_SEQ_Prio_0);
[#else]
      osThreadFlagsSet( Thd_LoraSendProcessId, 1 );
[/#if]
[#else]
      UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_LoRaSendOnTxTimerOrButtonEvent), CFG_SEQ_Prio_0);
[/#if]
      /* USER CODE BEGIN EXTI_Callback_Switch_B1 */
      /* USER CODE END EXTI_Callback_Switch_B1 */
      break;
    case  SYS_BUTTON2_PIN:
      /* USER CODE BEGIN EXTI_Callback_Switch_B2 */
      /* USER CODE END EXTI_Callback_Switch_B2 */
      break;
    /* USER CODE BEGIN EXTI_Callback_Switch_case */

    /* USER CODE END EXTI_Callback_Switch_case */
    default:
    /* USER CODE BEGIN EXTI_Callback_Switch_default */
    /* USER CODE END EXTI_Callback_Switch_default */
      break;
  }
  /* USER CODE BEGIN HAL_GPIO_EXTI_Callback_Last */

  /* USER CODE END HAL_GPIO_EXTI_Callback_Last */
}
#else
#error user to provide its board code or to call his board driver functions
#endif  /* USE_BSP_DRIVER || MX_BOARD_PSEUDODRIVER*/

[/#if]
/* Private functions ---------------------------------------------------------*/
/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
[#if FREERTOS??][#-- If FreeRtos is used --]

static void Thd_LoraSendProcess(void *argument)
{
  /* USER CODE BEGIN Thd_LoraSendProcess_1 */

  /* USER CODE END Thd_LoraSendProcess_1 */
  UNUSED(argument);
  for(;;)
  {
    osThreadFlagsWait( 1, osFlagsWaitAny, osWaitForever);
    SendTxData( ); /*what you want to do*/
  }
  /* USER CODE BEGIN Thd_LoraSendProcess_2 */

  /* USER CODE END Thd_LoraSendProcess_2 */
}
[/#if]
[/#if]

static void OnRxData(LmHandlerAppData_t *appData, LmHandlerRxParams_t *params)
{
  /* USER CODE BEGIN OnRxData_1 */

  /* USER CODE END OnRxData_1 */
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
  if ((appData != NULL) && (params != NULL))
  {
#if defined(USE_BSP_DRIVER)
    BSP_LED_On(LED_BLUE) ;
#elif defined(MX_BOARD_PSEUDODRIVER)
    SYS_LED_On(SYS_LED_BLUE) ;
#endif /* USE_BSP_DRIVER || MX_BOARD_PSEUDODRIVER */
    UTIL_TIMER_Start(&RxLedTimer);

[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
    static const char *slotStrings[] = { "1", "2", "C", "C Multicast", "B Ping-Slot", "B Multicast Ping-Slot" };

    APP_LOG(TS_OFF, VLEVEL_M, "\r\n###### ========== MCPS-Indication ==========\r\n");
    APP_LOG(TS_OFF, VLEVEL_H, "###### D/L FRAME:%04d | SLOT:%s | PORT:%d | DR:%d | RSSI:%d | SNR:%d\r\n",
            params->DownlinkCounter, slotStrings[params->RxSlot], appData->Port, params->Datarate, params->Rssi, params->Snr);
    switch (appData->Port)
    {
      case LORAWAN_SWITCH_CLASS_PORT:
        /*this port switches the class*/
        if (appData->BufferSize == 1)
        {
          switch (appData->Buffer[0])
          {
            case 0:
            {
              LmHandlerRequestClass(CLASS_A);
              break;
            }
            case 1:
            {
              LmHandlerRequestClass(CLASS_B);
              break;
            }
            case 2:
            {
              LmHandlerRequestClass(CLASS_C);
              break;
            }
            default:
              break;
          }
        }
        break;
      case LORAWAN_USER_APP_PORT:
        if (appData->BufferSize == 1)
        {
          AppLedStateOn = appData->Buffer[0] & 0x01;
          if (AppLedStateOn == RESET)
          {
            APP_LOG(TS_OFF, VLEVEL_H,   "LED OFF\r\n");

#if defined(USE_BSP_DRIVER)
            BSP_LED_Off(LED_RED) ;
#elif defined(MX_BOARD_PSEUDODRIVER)
            SYS_LED_Off(SYS_LED_RED) ;
#endif /* USE_BSP_DRIVER || MX_BOARD_PSEUDODRIVER */
          }
          else
          {
            APP_LOG(TS_OFF, VLEVEL_H, "LED ON\r\n");
#if defined(USE_BSP_DRIVER)
            BSP_LED_On(LED_RED) ;
#elif defined(MX_BOARD_PSEUDODRIVER)
            SYS_LED_On(SYS_LED_RED) ;
#endif /* USE_BSP_DRIVER || MX_BOARD_PSEUDODRIVER */
          }
        }
        break;
    /* USER CODE BEGIN OnRxData_Switch_case */

    /* USER CODE END OnRxData_Switch_case */
      default:
    /* USER CODE BEGIN OnRxData_Switch_default */

    /* USER CODE END OnRxData_Switch_default */
        break;
    }
[#elseif (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
    AT_event_receive(appData, params);
[/#if]
  }

  /* USER CODE BEGIN OnRxData_2 */

  /* USER CODE END OnRxData_2 */
[/#if]
}

[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
static void SendTxData(void)
{
  uint16_t pressure = 0;
  int16_t temperature = 0;
  sensor_t sensor_data;
  UTIL_TIMER_Time_t nextTxIn = 0;

#ifdef CAYENNE_LPP
  uint8_t channel = 0;
#else
  uint16_t humidity = 0;
  uint32_t i = 0;
  int32_t latitude = 0;
  int32_t longitude = 0;
  uint16_t altitudeGps = 0;
#endif /* CAYENNE_LPP */
  /* USER CODE BEGIN SendTxData_1 */

  /* USER CODE END SendTxData_1 */

  EnvSensors_Read(&sensor_data);
  temperature = (SYS_GetTemperatureLevel() >> 8);
  pressure    = (uint16_t)(sensor_data.pressure * 100 / 10);      /* in hPa / 10 */

  AppData.Port = LORAWAN_USER_APP_PORT;

#ifdef CAYENNE_LPP
  CayenneLppReset();
  CayenneLppAddBarometricPressure(channel++, pressure);
  CayenneLppAddTemperature(channel++, temperature);
  CayenneLppAddRelativeHumidity(channel++, (uint16_t)(sensor_data.humidity));

  if ((LmHandlerParams.ActiveRegion != LORAMAC_REGION_US915) && (LmHandlerParams.ActiveRegion != LORAMAC_REGION_AU915)
      && (LmHandlerParams.ActiveRegion != LORAMAC_REGION_AS923))
  {
    CayenneLppAddDigitalInput(channel++, GetBatteryLevel());
    CayenneLppAddDigitalOutput(channel++, AppLedStateOn);
  }

  CayenneLppCopy(AppData.Buffer);
  AppData.BufferSize = CayenneLppGetSize();
#else  /* not CAYENNE_LPP */
  humidity    = (uint16_t)(sensor_data.humidity * 10);            /* in %*10     */

  AppData.Buffer[i++] = AppLedStateOn;
  AppData.Buffer[i++] = (uint8_t)((pressure >> 8) & 0xFF);
  AppData.Buffer[i++] = (uint8_t)(pressure & 0xFF);
  AppData.Buffer[i++] = (uint8_t)(temperature & 0xFF);
  AppData.Buffer[i++] = (uint8_t)((humidity >> 8) & 0xFF);
  AppData.Buffer[i++] = (uint8_t)(humidity & 0xFF);

  if ((LmHandlerParams.ActiveRegion == LORAMAC_REGION_US915) || (LmHandlerParams.ActiveRegion == LORAMAC_REGION_AU915)
      || (LmHandlerParams.ActiveRegion == LORAMAC_REGION_AS923))
  {
    AppData.Buffer[i++] = 0;
    AppData.Buffer[i++] = 0;
    AppData.Buffer[i++] = 0;
    AppData.Buffer[i++] = 0;
  }
  else
  {
    latitude = sensor_data.latitude;
    longitude = sensor_data.longitude;

    AppData.Buffer[i++] = GetBatteryLevel();        /* 1 (very low) to 254 (fully charged) */
    AppData.Buffer[i++] = (uint8_t)((latitude >> 16) & 0xFF);
    AppData.Buffer[i++] = (uint8_t)((latitude >> 8) & 0xFF);
    AppData.Buffer[i++] = (uint8_t)(latitude & 0xFF);
    AppData.Buffer[i++] = (uint8_t)((longitude >> 16) & 0xFF);
    AppData.Buffer[i++] = (uint8_t)((longitude >> 8) & 0xFF);
    AppData.Buffer[i++] = (uint8_t)(longitude & 0xFF);
    AppData.Buffer[i++] = (uint8_t)((altitudeGps >> 8) & 0xFF);
    AppData.Buffer[i++] = (uint8_t)(altitudeGps & 0xFF);
  }

  AppData.BufferSize = i;
#endif /* CAYENNE_LPP */

  if (LORAMAC_HANDLER_SUCCESS == LmHandlerSend(&AppData, LORAWAN_DEFAULT_CONFIRMED_MSG_STATE, &nextTxIn, false))
  {
    APP_LOG(TS_ON, VLEVEL_L, "SEND REQUEST\r\n");
  }
  else if (nextTxIn > 0)
  {
    APP_LOG(TS_ON, VLEVEL_L, "Next Tx in  : ~%d second(s)\r\n", (nextTxIn / 1000));
  }
  /* USER CODE BEGIN SendTxData_2 */

  /* USER CODE END SendTxData_2 */
}

static void OnTxTimerEvent(void *context)
{
  /* USER CODE BEGIN OnTxTimerEvent_1 */

  /* USER CODE END OnTxTimerEvent_1 */
[#if CPUCORE == "CM4"]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_MbLoRaSendOnTxTimerOrButtonEvent), CFG_SEQ_Prio_0);
[#else]
  osThreadFlagsSet( Thd_LoraSendProcessId, 1 );
[/#if]
[#else]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_LoRaSendOnTxTimerOrButtonEvent), CFG_SEQ_Prio_0);
[/#if]

  /*Wait for next tx slot*/
  UTIL_TIMER_Start(&TxTimer);
  /* USER CODE BEGIN OnTxTimerEvent_2 */

  /* USER CODE END OnTxTimerEvent_2 */
}

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
static void OnTxTimerLedEvent(void *context)
{
  /* USER CODE BEGIN OnTxTimerLedEvent_1 */

  /* USER CODE END OnTxTimerLedEvent_1 */
#if defined(USE_BSP_DRIVER)
  BSP_LED_Off(LED_GREEN) ;
#else
  SYS_LED_Off(SYS_LED_GREEN) ;
#endif /* USE_BSP_DRIVER || MX_BOARD_PSEUDODRIVER */
  /* USER CODE BEGIN OnTxTimerLedEvent_2 */

  /* USER CODE END OnTxTimerLedEvent_2 */
}

static void OnRxTimerLedEvent(void *context)
{
  /* USER CODE BEGIN OnRxTimerLedEvent_1 */

  /* USER CODE END OnRxTimerLedEvent_1 */
#if defined(USE_BSP_DRIVER)
  BSP_LED_Off(LED_BLUE) ;
#else
  SYS_LED_Off(SYS_LED_BLUE) ;
#endif /* USE_BSP_DRIVER || MX_BOARD_PSEUDODRIVER */
  /* USER CODE BEGIN OnRxTimerLedEvent_2 */

  /* USER CODE END OnRxTimerLedEvent_2 */
}

static void OnJoinTimerLedEvent(void *context)
{
  /* USER CODE BEGIN OnJoinTimerLedEvent_1 */

  /* USER CODE END OnJoinTimerLedEvent_1 */
#if defined(USE_BSP_DRIVER)
  BSP_LED_Toggle(LED_RED) ;
#else
  SYS_LED_Toggle(SYS_LED_RED) ;
#endif /* USE_BSP_DRIVER || MX_BOARD_PSEUDODRIVER */
  /* USER CODE BEGIN OnJoinTimerLedEvent_2 */

  /* USER CODE END OnJoinTimerLedEvent_2 */
}

[/#if]
static void OnTxData(LmHandlerTxParams_t *params)
{
  /* USER CODE BEGIN OnTxData_1 */

  /* USER CODE END OnTxData_1 */
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
  if ((params != NULL) && (params->IsMcpsConfirm != 0))
  {
#if defined(USE_BSP_DRIVER)
    BSP_LED_On(LED_GREEN) ;
#elif defined(MX_BOARD_PSEUDODRIVER)
    SYS_LED_On(SYS_LED_GREEN) ;
#endif /* USE_BSP_DRIVER || MX_BOARD_PSEUDODRIVER */
    UTIL_TIMER_Start(&TxLedTimer);
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]

    APP_LOG(TS_OFF, VLEVEL_M, "\r\n###### ========== MCPS-Confirm =============\r\n");
    APP_LOG(TS_OFF, VLEVEL_H, "###### U/L FRAME:%04d | PORT:%d | DR:%d | PWR:%d", params->UplinkCounter,
            params->AppData.Port, params->Datarate, params->TxPower);

    APP_LOG(TS_OFF, VLEVEL_H, " | MSG TYPE:");
    if (params->MsgType == LORAMAC_HANDLER_CONFIRMED_MSG)
    {
      APP_LOG(TS_OFF, VLEVEL_H, "CONFIRMED [%s]\r\n", (params->AckReceived != 0) ? "ACK" : "NACK");
    }
    else
    {
      APP_LOG(TS_OFF, VLEVEL_H, "UNCONFIRMED\r\n");
    }
  }
[#elseif (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
  }
  AT_event_confirm(params);
[/#if]

  /* USER CODE BEGIN OnTxData_2 */

  /* USER CODE END OnTxData_2 */
[/#if]
}

static void OnJoinRequest(LmHandlerJoinParams_t *joinParams)
{
  /* USER CODE BEGIN OnJoinRequest_1 */

  /* USER CODE END OnJoinRequest_1 */
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
  if (joinParams != NULL)
  {
    if (joinParams->Status == LORAMAC_HANDLER_SUCCESS)
    {
      UTIL_TIMER_Stop(&JoinLedTimer);

#if defined(USE_BSP_DRIVER)
      BSP_LED_Off(LED_RED) ;
#elif defined(MX_BOARD_PSEUDODRIVER)
      SYS_LED_Off(SYS_LED_RED) ;
#endif /* USE_BSP_DRIVER || MX_BOARD_PSEUDODRIVER */

[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
      APP_LOG(TS_OFF, VLEVEL_M, "\r\n###### = JOINED = ");
      if (joinParams->Mode == ACTIVATION_TYPE_ABP)
      {
        APP_LOG(TS_OFF, VLEVEL_M, "ABP ======================\r\n");
      }
      else
      {
        APP_LOG(TS_OFF, VLEVEL_M, "OTAA =====================\r\n");
      }
    }
    else
    {
      APP_LOG(TS_OFF, VLEVEL_M, "\r\n###### = JOIN FAILED\r\n");
    }
  }
[#elseif (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
    }
  }
  AT_event_join(joinParams);
[/#if]
[/#if]

  /* USER CODE BEGIN OnJoinRequest_2 */

  /* USER CODE END OnJoinRequest_2 */
}

[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
static void CmdProcessNotify(void)
{
  /* USER CODE BEGIN CmdProcessNotify_1 */

  /* USER CODE END CmdProcessNotify_1 */
[#if CPUCORE == "CM4"]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_MbVcom), 0);
[#else]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_Vcom), 0);
[/#if]
  /* USER CODE BEGIN CmdProcessNotify_2 */

  /* USER CODE END CmdProcessNotify_2 */
}

[/#if]
static void OnMacProcessNotify(void)
{
  /* USER CODE BEGIN OnMacProcessNotify_1 */

  /* USER CODE END OnMacProcessNotify_1 */
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
[#if CPUCORE != "CM4"]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_LmHandlerProcess), CFG_SEQ_Prio_0);
[/#if]
  /* USER CODE BEGIN OnMacProcessNotify_2 */

  /* USER CODE END OnMacProcessNotify_2 */
[/#if]
}

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
