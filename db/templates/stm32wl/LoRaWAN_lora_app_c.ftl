[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    lora_app.c
  * @author  MCD Application Team
  * @brief   Application of the LRWAN Middleware
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
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
[#assign SUBGHZ_APPLICATION = ""]
[#assign SECURE_PROJECTS = "0"]
[#assign INTROPACK_EXAMPLE = ""]
[#assign FILL_UCS = ""]
[#assign LORAWAN_TIMER_OR_BUTTON = ""]
[#assign LORAWAN_FUOTA = "0"]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "SUBGHZ_APPLICATION"]
                    [#assign SUBGHZ_APPLICATION = definition.value]
                [/#if]
                [#if definition.name == "INTROPACK_EXAMPLE"]
                    [#assign INTROPACK_EXAMPLE = definition.value]
                [/#if]
                [#if definition.name == "FILL_UCS"]
                    [#assign FILL_UCS = definition.value]
                [/#if]
                [#if definition.name == "LORAWAN_TIMER_OR_BUTTON"]
                    [#assign LORAWAN_TIMER_OR_BUTTON = definition.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]

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
[#if (SECURE_PROJECTS == "1") && (CPUCORE == "CM4") ]
#if defined (DEBUGGER_ENABLED) && ( DEBUGGER_ENABLED == 1 )
extern __IO uint32_t lets_go_on;
#elif !defined (DEBUGGER_ENABLED)
#error "DEBUGGER_ENABLED not defined or out of range <0,1>"
#endif /* DEBUGGER_ENABLED */
[/#if]
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
    * @brief Appdata Transmission issue based on timer every TxDutyCycleTime
    */
  TX_ON_TIMER,
  /**
    * @brief Appdata Transmission external event plugged on OnSendEvent( )
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
  * @brief  LoRa End Node send request
  */
static void SendTxData(void);

/**
  * @brief  TX timer callback function
  * @param  context ptr of timer context
  */
static void OnTxTimerEvent(void *context);

[/#if]
/**
  * @brief  join event callback function
  * @param  joinParams status of join
  */
static void OnJoinRequest(LmHandlerJoinParams_t *joinParams);

/**
  * @brief  tx event callback function
  * @param  params status of last Tx
  */
static void OnTxData(LmHandlerTxParams_t *params);

/**
  * @brief callback when LoRa application has received a frame
  * @param appData data received in the last Rx
  * @param params status of last Rx
  */
static void OnRxData(LmHandlerAppData_t *appData, LmHandlerRxParams_t *params);

[#if (LORAWAN_FUOTA == "1")]
/**
  * @brief callback when LoRa application Class is changed
  * @param deviceClass new class
  */
static void OnClassChange(DeviceClass_t deviceClass );

[/#if]
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
  */
static void CmdProcessNotify(void);

[/#if]
/* USER CODE BEGIN PFP */

[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")) && (FILL_UCS == "true")]
/**
  * @brief  LED Tx timer callback function
  * @param  context ptr of LED context
  */
static void OnTxTimerLedEvent(void *context);

/**
  * @brief  LED Rx timer callback function
  * @param  context ptr of LED context
  */
static void OnRxTimerLedEvent(void *context);

/**
  * @brief  LED Join timer callback function
  * @param  context ptr of LED context
  */
static void OnJoinTimerLedEvent(void *context);

[/#if]
/* USER CODE END PFP */

/* Private variables ---------------------------------------------------------*/
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
static ActivationType_t ActivationType = LORAWAN_DEFAULT_ACTIVATION_TYPE;

[/#if]
/**
  * @brief LoRaWAN handler Callbacks
  */
static LmHandlerCallbacks_t LmHandlerCallbacks =
{
  .GetBatteryLevel =           GetBatteryLevel,
  .GetTemperature =            GetTemperatureLevel,
[#if CPUCORE == ""]
  .GetUniqueId =               GetUniqueId,
  .GetDevAddr =                GetDevAddr,
[/#if]
  .OnMacProcess =              OnMacProcessNotify,
  .OnJoinRequest =             OnJoinRequest,
  .OnTxData =                  OnTxData,
[#if (LORAWAN_FUOTA == "1")]
  .OnRxData =                  OnRxData,
  .OnClassChange =             OnClassChange
[#else]
  .OnRxData =                  OnRxData
[/#if]
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
  * @brief Type of Event to generate application Tx
  */
static TxEventType_t EventType = ${LORAWAN_TIMER_OR_BUTTON};

/**
  * @brief Timer to handle the application Tx
  */
static UTIL_TIMER_Object_t TxTimer;

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
[#if FREERTOS??][#-- If FreeRtos is used --]
osThreadId_t Thd_LoraSendProcessId;

const osThreadAttr_t Thd_LoraSendProcess_attr =
{
  .name = CFG_APP_LORA_PROCESS_NAME,
  .attr_bits = CFG_APP_LORA_PROCESS_ATTR_BITS,
  .cb_mem = CFG_APP_LORA_PROCESS_CB_MEM,
  .cb_size = CFG_APP_LORA_PROCESS_CB_SIZE,
  .stack_mem = CFG_APP_LORA_PROCESS_STACK_MEM,
  .priority = CFG_APP_LORA_PROCESS_PRIORITY,
  .stack_size = CFG_APP_LORA_PROCESS_STACk_SIZE
};
static void Thd_LoraSendProcess(void *argument);

[#if  (CPUCORE == "") ] [#-- If FreeRtos is used and single core--]
osThreadId_t Thd_LmHandlerProcessId;

const osThreadAttr_t Thd_LmHandlerProcess_attr = {
    .name = CFG_LM_HANDLER_PROCESS_NAME,
    .attr_bits = CFG_LM_HANDLER_PROCESS_ATTR_BITS,
    .cb_mem = CFG_LM_HANDLER_PROCESS_CB_MEM,
    .cb_size = CFG_LM_HANDLER_PROCESS_CB_SIZE,
    .stack_mem = CFG_LM_HANDLER_PROCESS_STACK_MEM,
    .priority = CFG_LM_HANDLER_PROCESS_PRIORITY,
    .stack_size = CFG_LM_HANDLER_PROCESS_STACk_SIZE
};
static void Thd_LmHandlerProcess(void *argument);
[/#if]
[/#if]
[/#if]
/* USER CODE BEGIN PV */
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") && (FILL_UCS == "true")]
/**
  * @brief User application buffer
  */
static uint8_t AppDataBuffer[LORAWAN_APP_DATA_BUFFER_MAX_SIZE];

/**
  * @brief User application data structure
  */
static LmHandlerAppData_t AppData = { 0, 0, AppDataBuffer };

/**
  * @brief Specifies the state of the application LED
  */
static uint8_t AppLedStateOn = RESET;

[/#if]
[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")) && (FILL_UCS == "true")]
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

[/#if]
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
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
  CMD_Init(CmdProcessNotify);

[/#if]
  /* USER CODE BEGIN LoRaWAN_Init_1 */

[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")) && (FILL_UCS == "true")]
  BSP_LED_Init(LED_BLUE);
  BSP_LED_Init(LED_GREEN);
  BSP_LED_Init(LED_RED);
  BSP_PB_Init(BUTTON_SW2, BUTTON_MODE_EXTI);

[/#if]
[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")) && (FILL_UCS == "true")]
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
  UTIL_TIMER_Create(&TxLedTimer, 0xFFFFFFFFU, UTIL_TIMER_ONESHOT, OnTxTimerLedEvent, NULL);
  UTIL_TIMER_Create(&RxLedTimer, 0xFFFFFFFFU, UTIL_TIMER_ONESHOT, OnRxTimerLedEvent, NULL);
  UTIL_TIMER_Create(&JoinLedTimer, 0xFFFFFFFFU, UTIL_TIMER_PERIODIC, OnJoinTimerLedEvent, NULL);
  UTIL_TIMER_SetPeriod(&TxLedTimer, 500);
  UTIL_TIMER_SetPeriod(&RxLedTimer, 500);
  UTIL_TIMER_SetPeriod(&JoinLedTimer, 500);

[/#if]
  /* USER CODE END LoRaWAN_Init_1 */

[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
[#if CPUCORE == "CM4"] [#-- dualCore CM4 --]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_MbLoRaSendOnTxTimerOrButtonEvent), UTIL_SEQ_RFU, SendTxData);
[#else]
  Thd_LoraSendProcessId = osThreadNew(Thd_LoraSendProcess, NULL, &Thd_LoraSendProcess_attr);
[/#if]
[#else] [#-- Single Core--]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_LmHandlerProcess), UTIL_SEQ_RFU, LmHandlerProcess);
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_LoRaSendOnTxTimerOrButtonEvent), UTIL_SEQ_RFU, SendTxData);
[#else]
  Thd_LoraSendProcessId = osThreadNew(Thd_LoraSendProcess, NULL, &Thd_LoraSendProcess_attr);
  if (Thd_LoraSendProcessId==NULL)
  {
    Error_Handler();
  }
  Thd_LmHandlerProcessId = osThreadNew(Thd_LmHandlerProcess, NULL, &Thd_LmHandlerProcess_attr);
  if (Thd_LmHandlerProcessId==NULL)
  {
    Error_Handler();
  }

[/#if]
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

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
  /* USER CODE BEGIN LoRaWAN_Init_2 */
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") && (FILL_UCS == "true")]
  UTIL_TIMER_Start(&JoinLedTimer);

[/#if]
  /* USER CODE END LoRaWAN_Init_2 */

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
    /* USER CODE BEGIN LoRaWAN_Init_3 */
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") && (FILL_UCS == "true")]

    /* send every time button is pushed */
    BSP_PB_Init(BUTTON_SW1, BUTTON_MODE_EXTI);
[/#if]
    /* USER CODE END LoRaWAN_Init_3 */
  }

[/#if]

  /* USER CODE BEGIN LoRaWAN_Init_Last */
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")  && (FILL_UCS == "true")]
  UTIL_TIMER_Start(&JoinLedTimer);

  APP_PPRINTF("ATtention command interface\r\n");
  APP_PPRINTF("AT? to list all available functions\r\n");
[/#if]

  /* USER CODE END LoRaWAN_Init_Last */
}

/* USER CODE BEGIN PB_Callbacks */
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") && (FILL_UCS == "true")]
/* Note: Current the stm32wlxx_it.c generated by STM32CubeMX does not support BSP for PB in EXTI mode. */
/* In order to get a push button IRS by code automatically generated */
/* HAL_GPIO_EXTI_Callback is today the only available possibility. */
/* Using HAL_GPIO_EXTI_Callback() shortcuts the BSP. */
/* If users wants to go through the BSP, stm32wlxx_it.c should be updated  */
/* in the USER CODE SESSION of the correspondent EXTIn_IRQHandler() */
/* to call the BSP_PB_IRQHandler() or the HAL_EXTI_IRQHandler(&H_EXTI_n);. */
/* Then the below HAL_GPIO_EXTI_Callback() can be replaced by BSP callback */
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
{
  switch (GPIO_Pin)
  {
    case  BUTTON_SW1_PIN:
      /* Note: when "EventType == TX_ON_TIMER" this GPIO is not initialized */
[#if !FREERTOS??][#-- If FreeRtos is not used --]
[#if CPUCORE == "CM4"]
      UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_MbLoRaSendOnTxTimerOrButtonEvent), CFG_SEQ_Prio_0);
[#else]
      UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_LoRaSendOnTxTimerOrButtonEvent), CFG_SEQ_Prio_0);
[/#if]
[#else]
      osThreadFlagsSet(Thd_LoraSendProcessId, 1);
[/#if]
      break;
    case  BUTTON_SW2_PIN:
[#if (SECURE_PROJECTS == "1") && (CPUCORE == "CM4") ]
#if defined (DEBUGGER_ENABLED) && ( DEBUGGER_ENABLED == 1 )
      lets_go_on = 1;
#elif !defined (DEBUGGER_ENABLED)
#error "DEBUGGER_ENABLED not defined or out of range <0,1>"
#endif /* DEBUGGER_ENABLED */
[/#if]
      break;
    case  BUTTON_SW3_PIN:
      break;
    default:
      break;
  }
}
[/#if]

/* USER CODE END PB_Callbacks */

/* Private functions ---------------------------------------------------------*/
/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
[#if FREERTOS??][#-- If FreeRtos is used --]
[#if CPUCORE == ""] [#-- singleCore --]

static void Thd_LmHandlerProcess(void *argument)
{
  /* USER CODE BEGIN Thd_LmHandlerProcess_1 */

  /* USER CODE END Thd_LmHandlerProcess_1 */
  UNUSED(argument);
  for(;;)
  {
    osThreadFlagsWait( 1, osFlagsWaitAny, osWaitForever);
    LmHandlerProcess( ); /*what you want to do*/
  }
  /* USER CODE BEGIN Thd_LmHandlerProcess_2 */

  /* USER CODE END Thd_LmHandlerProcess_2 */
}
[/#if]

static void Thd_LoraSendProcess(void *argument)
{
  /* USER CODE BEGIN Thd_LoraSendProcess_1 */

  /* USER CODE END Thd_LoraSendProcess_1 */
  UNUSED(argument);
  for (;;)
  {
    osThreadFlagsWait(1, osFlagsWaitAny, osWaitForever);
    SendTxData();  /*what you want to do*/
  }

  /* USER CODE BEGIN Thd_LoraSendProcess_2 */

  /* USER CODE END Thd_LoraSendProcess_2 */
}
[/#if]
[/#if]

static void OnRxData(LmHandlerAppData_t *appData, LmHandlerRxParams_t *params)
{
  /* USER CODE BEGIN OnRxData_1 */
[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")) && (FILL_UCS == "true")]
  if ((appData != NULL) || (params != NULL))
  {
    BSP_LED_On(LED_BLUE) ;

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
            BSP_LED_Off(LED_RED) ;
          }
          else
          {
            APP_LOG(TS_OFF, VLEVEL_H, "LED ON\r\n");
            BSP_LED_On(LED_RED) ;
          }
        }
        break;

      default:

        break;
    }
[#elseif (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
    AT_event_receive(appData, params);
[/#if]
  }
[/#if]
  /* USER CODE END OnRxData_1 */
}

[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
static void SendTxData(void)
{
  /* USER CODE BEGIN SendTxData_1 */
[#if (FILL_UCS == "true")]
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
[/#if]

  /* USER CODE END SendTxData_1 */
}

[#if (LORAWAN_FUOTA == "1")]
static void OnClassChange(DeviceClass_t deviceClass )
{
  /*
   * This implementation should be modified to adapt to the network configuration.
   * This custom code allows to temporarily remove the Tx transactions from the device
   * during the class C session, in order to avoid any conflict during
   * the reception of frames in Multicast Class C.
   */
  if (deviceClass == CLASS_C)
  {
    UTIL_TIMER_Stop(&TxTimer);
  }
  else
  {
    UTIL_TIMER_Start(&TxTimer);
  }
}

[/#if]
static void OnTxTimerEvent(void *context)
{
  /* USER CODE BEGIN OnTxTimerEvent_1 */

  /* USER CODE END OnTxTimerEvent_1 */
[#if !FREERTOS??][#-- If FreeRtos is not used --]
[#if CPUCORE == "CM4"]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_MbLoRaSendOnTxTimerOrButtonEvent), CFG_SEQ_Prio_0);
[#else]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_LoRaSendOnTxTimerOrButtonEvent), CFG_SEQ_Prio_0);
[/#if]
[#else]
  osThreadFlagsSet(Thd_LoraSendProcessId, 1);
[/#if]

  /*Wait for next tx slot*/
  UTIL_TIMER_Start(&TxTimer);
  /* USER CODE BEGIN OnTxTimerEvent_2 */

  /* USER CODE END OnTxTimerEvent_2 */
}
[/#if]

/* USER CODE BEGIN PrFD_LedEvents */
[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")) && (FILL_UCS == "true")]
static void OnTxTimerLedEvent(void *context)
{
  BSP_LED_Off(LED_GREEN) ;
}

static void OnRxTimerLedEvent(void *context)
{
  BSP_LED_Off(LED_BLUE) ;
}

static void OnJoinTimerLedEvent(void *context)
{
  BSP_LED_Toggle(LED_RED) ;
}
[/#if]

/* USER CODE END PrFD_LedEvents */

static void OnTxData(LmHandlerTxParams_t *params)
{
  /* USER CODE BEGIN OnTxData_1 */
[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")) && (FILL_UCS == "true")]
  if ((params != NULL))
  {
    /* Process Tx event only if its a mcps response to prevent some internal events (mlme) */
    if (params->IsMcpsConfirm != 0)
    {
      BSP_LED_On(LED_GREEN) ;
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
  }
[/#if]
  /* USER CODE END OnTxData_1 */
}

static void OnJoinRequest(LmHandlerJoinParams_t *joinParams)
{
  /* USER CODE BEGIN OnJoinRequest_1 */
[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")) && (FILL_UCS == "true")]
  if (joinParams != NULL)
  {
    if (joinParams->Status == LORAMAC_HANDLER_SUCCESS)
    {
      UTIL_TIMER_Stop(&JoinLedTimer);
      BSP_LED_Off(LED_RED) ;

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
[#if (LORAWAN_FUOTA == "1")]

      /* Force a clock synchronization to be able to start a Multicast Session */
      LmHandlerDeviceTimeReq();
[/#if]
    }
    else
    {
      APP_LOG(TS_OFF, VLEVEL_M, "\r\n###### = JOIN FAILED\r\n");
    }
[#elseif (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
    }
    AT_event_join(joinParams);
[/#if]
  }
[/#if]
  /* USER CODE END OnJoinRequest_1 */
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
[#if !FREERTOS??][#-- If FreeRtos is used --]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_LmHandlerProcess), CFG_SEQ_Prio_0);
[#else]
  osThreadFlagsSet( Thd_LmHandlerProcessId, 1 );
[/#if]

  /* USER CODE BEGIN OnMacProcessNotify_2 */

  /* USER CODE END OnMacProcessNotify_2 */
[/#if]
[/#if]
}

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
