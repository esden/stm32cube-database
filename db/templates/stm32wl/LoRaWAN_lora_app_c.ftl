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
#include "sys_app.h"
#include "lora_app.h"
[#if THREADX??][#-- If AzRtos is used --]
#include "app_azure_rtos.h"
#include "tx_api.h"
[#else]
[#if !FREERTOS??][#-- If FreeRtos is not used --]
#include "stm32_seq.h"
[#else]
#include "cmsis_os.h"
[/#if]
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
#include "stm32_timer.h"
#include "utilities_def.h"
#include "lora_app_version.h"
[#if CPUCORE == ""]
#include "lorawan_version.h"
#include "subghz_phy_version.h"
[/#if]
[#elseif (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION")]
#include "lora_app_version.h"
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
#include "CayenneLpp.h"
#include "sys_sensors.h"
#include "flash_if.h"
[#elseif (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
#include "lora_command.h"
#include "lora_at.h"
#include "flash_if.h"
[#if THREADX??][#-- If AzRtos is used --]
#include "test_rf.h"
[/#if]
[#if FREERTOS??][#-- If FreeRtos is used --]
#include "test_rf.h"
[/#if]
[/#if]
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
[#if (CPUCORE == "CM4")]
#include "mbmuxif_sys.h"
[/#if]
[/#if]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
[#if THREADX??][#-- If AzRtos is used --]
extern  TX_THREAD App_MainThread;
extern  TX_BYTE_POOL *byte_pool;
extern  CHAR *pointer;
[/#if]
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
/**
  * LEDs period value of the timer in ms
  */
#define LED_PERIOD_TIME 500

[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
/**
  * Join switch period value of the timer in ms
  */
#define JOIN_TIME 2000

/*---------------------------------------------------------------------------*/
/*                             LoRaWAN NVM configuration                     */
/*---------------------------------------------------------------------------*/
/**
  * @brief LoRaWAN NVM Flash address
  * @note last 2 sector of a 128kBytes device
  */
[#if (CPUCORE == "CM4")]
[#if (LORAWAN_FUOTA == "0") && (SECURE_PROJECTS == "1")]
#define LORAWAN_NVM_BASE_ADDRESS                    ((uint32_t)0x0801B000UL)
[#elseif (LORAWAN_FUOTA == "1") && (SECURE_PROJECTS == "1")]
#define LORAWAN_NVM_BASE_ADDRESS                    ((uint32_t)0x0801E000UL)
[#else]
#define LORAWAN_NVM_BASE_ADDRESS                    ((uint32_t)0x0801F000UL)
[/#if]
[#else]
#define LORAWAN_NVM_BASE_ADDRESS                    ((uint32_t)0x0803F000UL)
[/#if]

[/#if]
/* USER CODE BEGIN PD */
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") && (FILL_UCS == "true")]
static const char *slotStrings[] = { "1", "2", "C", "C_MC", "P", "P_MC" };
[#else]

[/#if]
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
  * @brief callback when LoRaWAN application has sent a frame
  * @brief  tx event callback function
  * @param  params status of last Tx
  */
static void OnTxData(LmHandlerTxParams_t *params);

/**
  * @brief callback when LoRaWAN application has received a frame
  * @param appData data received in the last Rx
  * @param params status of last Rx
  */
static void OnRxData(LmHandlerAppData_t *appData, LmHandlerRxParams_t *params);

/**
  * @brief callback when LoRaWAN Beacon status is updated
  * @param params status of Last Beacon
  */
static void OnBeaconStatusChange(LmHandlerBeaconParams_t *params);

/**
  * @brief callback when LoRaWAN application Class is changed
  * @param deviceClass new class
  */
static void OnClassChange(DeviceClass_t deviceClass);

[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
/**
  * @brief  LoRa store context in Non Volatile Memory
  */
static void StoreContext(void);

[#if (SECURE_PROJECTS == "0")]
/**
  * @brief  stop current LoRa execution to switch into non default Activation mode
  */
static void StopJoin(void);

/**
  * @brief  Join switch timer callback function
  * @param  context ptr of Join switch context
  */
static void OnStopJoinTimerEvent(void *context);

[/#if]
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
/**
  * @brief  Notifies the upper layer that the NVM context has changed
  * @param  state Indicates if we are storing (true) or restoring (false) the NVM context
  */
static void OnNvmDataChange(LmHandlerNvmContextStates_t state);

/**
  * @brief  Store the NVM Data context to the Flash
  * @param  nvm ptr on nvm structure
  * @param  nvm_size number of data bytes which were stored
  */
static void OnStoreContextRequest(void *nvm, uint32_t nvm_size);

/**
  * @brief  Restore the NVM Data context from the Flash
  * @param  nvm ptr on nvm structure
  * @param  nvm_size number of data bytes which were restored
  */
static void OnRestoreContextRequest(void *nvm, uint32_t nvm_size);

[/#if]

/**
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
/**
  * @brief Change the periodicity of the uplink frames
  * @param periodicity uplink frames period in ms
  * @note Compliance test protocol callbacks
  */
static void OnTxPeriodicityChanged(uint32_t periodicity);

/**
  * @brief Change the confirmation control of the uplink frames
  * @param isTxConfirmed Indicates if the uplink requires an acknowledgement
  * @note Compliance test protocol callbacks
  */
static void OnTxFrameCtrlChanged(LmHandlerMsgTypes_t isTxConfirmed);

/**
  * @brief Change the periodicity of the ping slot frames
  * @param pingSlotPeriodicity ping slot frames period in ms
  * @note Compliance test protocol callbacks
  */
static void OnPingSlotPeriodicityChanged(uint8_t pingSlotPeriodicity);

/**
  * @brief Will be called to reset the system
  * @note Compliance test protocol callbacks
  */
static void OnSystemReset(void);

[#if THREADX??][#-- If AzRtos is used --]
[#if  (CPUCORE == "") ]
/**
  * @brief  Entry point for the thread when receiving MailBox LmHandler Notification
  * @param  thread_input Not used
  */
static void Thd_LmHandlerProcess_Entry(unsigned long thread_input);

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
/**
  * @brief  Entry point for the thread when receiving MailBox Vcom Notification .
  * @param  thread_input Not used
  */
static void Thd_VcomProcess_Entry(unsigned long thread_input);

[#elseif (SUBGHZ_APPLICATION == "LORA_END_NODE")]
/**
  * @brief  Entry point for the thread when receiving Store Context Notification
  * @param  thread_input Not used
  */
static void Thd_StoreContext_Entry(unsigned long thread_input);

[#if (SECURE_PROJECTS == "0")]
/**
  * @brief  Entry point for the thread when receiving stop and change join mode request
  * @param  thread_input Not used
  */
static void Thd_StopJoin_Entry(unsigned long thread_input);

[/#if]
[/#if]
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
[#if THREADX??][#-- If AzRtos is used --]
[#if  (CPUCORE == "") ]
TX_THREAD Thd_LmHandlerProcessId;
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
TX_THREAD Thd_VcomProcessId;
[#elseif (SUBGHZ_APPLICATION == "LORA_END_NODE")]
TX_THREAD Thd_LoraStoreContextId;
[#if (SECURE_PROJECTS == "0")]
TX_THREAD Thd_LoraStopJoinId;
[/#if]
[/#if]

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
/**
  * @brief LoRaWAN default activation type
  */
static ActivationType_t ActivationType = LORAWAN_DEFAULT_ACTIVATION_TYPE;

/**
  * @brief LoRaWAN force rejoin even if the NVM context is restored
  */
static bool ForceRejoin = LORAWAN_FORCE_REJOIN_AT_BOOT;

[/#if]
/**
  * @brief LoRaWAN handler Callbacks
  */
static LmHandlerCallbacks_t LmHandlerCallbacks =
{
  .GetBatteryLevel =              GetBatteryLevel,
  .GetTemperature =               GetTemperatureLevel,
[#if CPUCORE == ""]
  .GetUniqueId =                  GetUniqueId,
  .GetDevAddr =                   GetDevAddr,
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
  .OnRestoreContextRequest =      OnRestoreContextRequest,
  .OnStoreContextRequest =        OnStoreContextRequest,
  .OnMacProcess =                 OnMacProcessNotify,
  .OnNvmDataChange =              OnNvmDataChange,
[#else]
  .OnMacProcess =                 OnMacProcessNotify,
[/#if]
  .OnJoinRequest =                OnJoinRequest,
  .OnTxData =                     OnTxData,
  .OnRxData =                     OnRxData,
  .OnBeaconStatusChange =         OnBeaconStatusChange,
  .OnClassChange =                OnClassChange,
  .OnTxPeriodicityChanged =       OnTxPeriodicityChanged,
  .OnTxFrameCtrlChanged =         OnTxFrameCtrlChanged,
  .OnPingSlotPeriodicityChanged = OnPingSlotPeriodicityChanged,
  .OnSystemReset =                OnSystemReset,
};

[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
/**
  * @brief LoRaWAN handler parameters
  */
static LmHandlerParams_t LmHandlerParams =
{
  .ActiveRegion =             ACTIVE_REGION,
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
  .DefaultClass =             LORAWAN_DEFAULT_CLASS,
[#else]
  .DefaultClass =             CLASS_A,
[/#if]
  .AdrEnable =                LORAWAN_ADR_STATE,
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
  .IsTxConfirmed =            LORAWAN_DEFAULT_CONFIRMED_MSG_STATE,
[/#if]
  .TxDatarate =               LORAWAN_DEFAULT_DATA_RATE,
  .PingSlotPeriodicity =      LORAWAN_DEFAULT_PING_SLOT_PERIODICITY,
  .RxBCTimeout =              LORAWAN_DEFAULT_CLASS_B_C_RESP_TIMEOUT
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

/**
  * @brief Tx Timer period
  */
static UTIL_TIMER_Time_t TxPeriodicity = APP_TX_DUTYCYCLE;

[#if (SECURE_PROJECTS == "0")]
/**
  * @brief Join Timer period
  */
static UTIL_TIMER_Object_t StopJoinTimer;

[/#if]
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
[#if FREERTOS??][#-- If FreeRtos is used --]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
osThreadId_t Thd_LoraSendProcessId;

const osThreadAttr_t Thd_LoraSendProcess_attr =
{
  .name = CFG_APP_LORA_PROCESS_NAME,
  .attr_bits = CFG_APP_LORA_PROCESS_ATTR_BITS,
  .cb_mem = CFG_APP_LORA_PROCESS_CB_MEM,
  .cb_size = CFG_APP_LORA_PROCESS_CB_SIZE,
  .stack_mem = CFG_APP_LORA_PROCESS_STACK_MEM,
  .priority = CFG_APP_LORA_PROCESS_PRIORITY,
  .stack_size = CFG_APP_LORA_PROCESS_STACK_SIZE
};
static void Thd_LoraSendProcess(void *argument);

osThreadId_t Thd_LoraStoreContextId;

const osThreadAttr_t Thd_LoraStoreContext_attr =
{
  .name = CFG_APP_LORA_STORE_CONTEXT_NAME,
  .attr_bits = CFG_APP_LORA_STORE_CONTEXT_ATTR_BITS,
  .cb_mem = CFG_APP_LORA_STORE_CONTEXT_CB_MEM,
  .cb_size = CFG_APP_LORA_STORE_CONTEXT_CB_SIZE,
  .stack_mem = CFG_APP_LORA_STORE_CONTEXT_STACK_MEM,
  .priority = CFG_APP_LORA_STORE_CONTEXT_PRIORITY,
  .stack_size = CFG_APP_LORA_STORE_CONTEXT_STACK_SIZE
};
static void Thd_LoraStoreContext(void *argument);

[#if (SECURE_PROJECTS == "0")]
osThreadId_t Thd_LoraStopJoinId;

const osThreadAttr_t Thd_LoraStopJoin_attr =
{
  .name = CFG_APP_LORA_STOP_JOIN_NAME,
  .attr_bits = CFG_APP_LORA_STOP_JOIN_ATTR_BITS,
  .cb_mem = CFG_APP_LORA_STOP_JOIN_CB_MEM,
  .cb_size = CFG_APP_LORA_STOP_JOIN_CB_SIZE,
  .stack_mem = CFG_APP_LORA_STOP_JOIN_STACK_MEM,
  .priority = CFG_APP_LORA_STOP_JOIN_PRIORITY,
  .stack_size = CFG_APP_LORA_STOP_JOIN_STACK_SIZE
};
static void Thd_LoraStopJoin(void *argument);

[/#if]
[/#if]
[#if  (CPUCORE == "")][#-- If FreeRtos is used and single core--]
osThreadId_t Thd_LmHandlerProcessId;

const osThreadAttr_t Thd_LmHandlerProcess_attr =
{
  .name = CFG_LM_HANDLER_PROCESS_NAME,
  .attr_bits = CFG_LM_HANDLER_PROCESS_ATTR_BITS,
  .cb_mem = CFG_LM_HANDLER_PROCESS_CB_MEM,
  .cb_size = CFG_LM_HANDLER_PROCESS_CB_SIZE,
  .stack_mem = CFG_LM_HANDLER_PROCESS_STACK_MEM,
  .priority = CFG_LM_HANDLER_PROCESS_PRIORITY,
  .stack_size = CFG_LM_HANDLER_PROCESS_STACK_SIZE
};
static void Thd_LmHandlerProcess(void *argument);

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
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
  /* USER CODE BEGIN LoRaWAN_Init_LV */
[#if (CPUCORE == "CM4") && (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (FILL_UCS == "true")]
  FEAT_INFO_Param_t *p_cm0plus_specific_features_info;
[/#if]
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (FILL_UCS == "true")]
  uint32_t feature_version = 0UL;
[#else]

[/#if]
  /* USER CODE END LoRaWAN_Init_LV */

[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
  CMD_Init(CmdProcessNotify);

[/#if]
  /* USER CODE BEGIN LoRaWAN_Init_1 */

[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")) && (FILL_UCS == "true")]
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
[#if CPUCORE == "CM4"]
  /* Get CM4 LoRaWAN APP version*/
  APP_LOG(TS_OFF, VLEVEL_M, "M4_APP_VERSION:      V%X.%X.%X\r\n",
          (uint8_t)(APP_VERSION_MAIN),
          (uint8_t)(APP_VERSION_SUB1),
          (uint8_t)(APP_VERSION_SUB2));

  /* Get CM0 LoRaWAN APP version*/
  p_cm0plus_specific_features_info = MBMUXIF_SystemGetFeatCapabInfoPtr(FEAT_INFO_SYSTEM_ID);
  feature_version = p_cm0plus_specific_features_info->Feat_Info_Feature_Version;
  APP_LOG(TS_OFF, VLEVEL_M, "M0PLUS_APP_VERSION:  V%X.%X.%X\r\n",
          (uint8_t)(feature_version >> 24),
          (uint8_t)(feature_version >> 16),
          (uint8_t)(feature_version >> 8));

  /* Get MW LoRaWAN info */
  p_cm0plus_specific_features_info = MBMUXIF_SystemGetFeatCapabInfoPtr(FEAT_INFO_LORAWAN_ID);
  feature_version = p_cm0plus_specific_features_info->Feat_Info_Feature_Version;
  APP_LOG(TS_OFF, VLEVEL_M, "MW_LORAWAN_VERSION:  V%X.%X.%X\r\n",
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

  /* Get LoRaWAN Link Layer info */
  LmHandlerGetVersion(LORAMAC_HANDLER_L2_VERSION, &feature_version);
  APP_LOG(TS_OFF, VLEVEL_M, "L2_SPEC_VERSION:     V%X.%X.%X\r\n",
          (uint8_t)(feature_version >> 24),
          (uint8_t)(feature_version >> 16),
          (uint8_t)(feature_version >> 8));

  /* Get LoRaWAN Regional Parameters info */
  LmHandlerGetVersion(LORAMAC_HANDLER_REGION_VERSION, &feature_version);
  APP_LOG(TS_OFF, VLEVEL_M, "RP_SPEC_VERSION:     V%X-%X.%X.%X\r\n",
          (uint8_t)(feature_version >> 24),
          (uint8_t)(feature_version >> 16),
          (uint8_t)(feature_version >> 8),
          (uint8_t)(feature_version));
[#else]
  /* Get LoRaWAN APP version*/
  APP_LOG(TS_OFF, VLEVEL_M, "APPLICATION_VERSION: V%X.%X.%X\r\n",
          (uint8_t)(APP_VERSION_MAIN),
          (uint8_t)(APP_VERSION_SUB1),
          (uint8_t)(APP_VERSION_SUB2));

  /* Get MW LoRaWAN info */
  APP_LOG(TS_OFF, VLEVEL_M, "MW_LORAWAN_VERSION:  V%X.%X.%X\r\n",
          (uint8_t)(LORAWAN_VERSION_MAIN),
          (uint8_t)(LORAWAN_VERSION_SUB1),
          (uint8_t)(LORAWAN_VERSION_SUB2));

  /* Get MW SubGhz_Phy info */
  APP_LOG(TS_OFF, VLEVEL_M, "MW_RADIO_VERSION:    V%X.%X.%X\r\n",
          (uint8_t)(SUBGHZ_PHY_VERSION_MAIN),
          (uint8_t)(SUBGHZ_PHY_VERSION_SUB1),
          (uint8_t)(SUBGHZ_PHY_VERSION_SUB2));

  /* Get LoRaWAN Link Layer info */
  LmHandlerGetVersion(LORAMAC_HANDLER_L2_VERSION, &feature_version);
  APP_LOG(TS_OFF, VLEVEL_M, "L2_SPEC_VERSION:     V%X.%X.%X\r\n",
          (uint8_t)(feature_version >> 24),
          (uint8_t)(feature_version >> 16),
          (uint8_t)(feature_version >> 8));

  /* Get LoRaWAN Regional Parameters info */
  LmHandlerGetVersion(LORAMAC_HANDLER_REGION_VERSION, &feature_version);
  APP_LOG(TS_OFF, VLEVEL_M, "RP_SPEC_VERSION:     V%X-%X.%X.%X\r\n",
          (uint8_t)(feature_version >> 24),
          (uint8_t)(feature_version >> 16),
          (uint8_t)(feature_version >> 8),
          (uint8_t)(feature_version));
[/#if]

[/#if]
  UTIL_TIMER_Create(&TxLedTimer, LED_PERIOD_TIME, UTIL_TIMER_ONESHOT, OnTxTimerLedEvent, NULL);
  UTIL_TIMER_Create(&RxLedTimer, LED_PERIOD_TIME, UTIL_TIMER_ONESHOT, OnRxTimerLedEvent, NULL);
  UTIL_TIMER_Create(&JoinLedTimer, LED_PERIOD_TIME, UTIL_TIMER_PERIODIC, OnJoinTimerLedEvent, NULL);

[/#if]
  /* USER CODE END LoRaWAN_Init_1 */

[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") && (SECURE_PROJECTS == "0")]
  UTIL_TIMER_Create(&StopJoinTimer, JOIN_TIME, UTIL_TIMER_ONESHOT, OnStopJoinTimerEvent, NULL);

[/#if]
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
[#if CPUCORE == ""][#-- single core --]
[#if THREADX??]
  /* Allocate the stack and create thread for LmHandlerProcess.  */
  if (tx_byte_allocate(byte_pool, (VOID **) &pointer, CFG_LM_HANDLER_THREAD_STACK_SIZE, TX_NO_WAIT) != TX_SUCCESS)
  {
    Error_Handler();
  }
  if (tx_thread_create(&Thd_LmHandlerProcessId, "Thread LmHandlerProcess", Thd_LmHandlerProcess_Entry, 0,
                       pointer, CFG_LM_HANDLER_THREAD_STACK_SIZE,
                       CFG_LM_HANDLER_THREAD_PRIO, CFG_LM_HANDLER_THREAD_PREEMPTION_THRESHOLD,
                       TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
  {
    Error_Handler();
  }
[#elseif FREERTOS??]
  Thd_LmHandlerProcessId = osThreadNew(Thd_LmHandlerProcess, NULL, &Thd_LmHandlerProcess_attr);
  if (Thd_LmHandlerProcessId == NULL)
  {
    Error_Handler();
  }
[#else]
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_LmHandlerProcess), UTIL_SEQ_RFU, LmHandlerProcess);
[/#if]

[/#if]
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
[#if THREADX??]
  /* No need to allocate the stack and create thread for Thd_LoraSendProcess. */
  /* App_MainThread is used for it (see app_lorawan.c)  */

  if (tx_byte_allocate(byte_pool, (VOID **) &pointer, CFG_APP_LORA_STORE_CONTEXT_STACK_SIZE, TX_NO_WAIT) != TX_SUCCESS)
  {
    Error_Handler();
  }
  if (tx_thread_create(&Thd_LoraStoreContextId, "Thread StoreContext", Thd_StoreContext_Entry, 0,
                       pointer, CFG_APP_LORA_STORE_CONTEXT_STACK_SIZE,
                       CFG_APP_LORA_STORE_CONTEXT_PRIO, CFG_APP_LORA_STORE_CONTEXT_PREEMPTION_THRESHOLD,
                       TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
  {
    Error_Handler();
  }

[#if (SECURE_PROJECTS == "0")]
  if (tx_byte_allocate(byte_pool, (VOID **) &pointer, CFG_APP_LORA_STOP_JOIN_STACK_SIZE, TX_NO_WAIT) != TX_SUCCESS)
  {
    Error_Handler();
  }
  if (tx_thread_create(&Thd_LoraStopJoinId, "Thread StopJoin", Thd_StopJoin_Entry, 0,
                       pointer, CFG_APP_LORA_STOP_JOIN_STACK_SIZE,
                       CFG_APP_LORA_STOP_JOIN_PRIO, CFG_APP_LORA_STOP_JOIN_PREEMPTION_THRESHOLD,
                       TX_NO_TIME_SLICE, TX_AUTO_START) != TX_SUCCESS)
  {
    Error_Handler();
  }
[/#if]
[#elseif FREERTOS??]
  Thd_LoraSendProcessId = osThreadNew(Thd_LoraSendProcess, NULL, &Thd_LoraSendProcess_attr);
  if (Thd_LoraSendProcessId == NULL)
  {
    Error_Handler();
  }
  Thd_LoraStoreContextId = osThreadNew(Thd_LoraStoreContext, NULL, &Thd_LoraStoreContext_attr);
  if (Thd_LoraStoreContextId == NULL)
  {
    Error_Handler();
  }
[#if (SECURE_PROJECTS == "0")]
  Thd_LoraStopJoinId = osThreadNew(Thd_LoraStopJoin, NULL, &Thd_LoraStopJoin_attr);
  if (Thd_LoraStopJoinId == NULL)
  {
    Error_Handler();
  }
[/#if]
[#else]
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_LoRaSendOnTxTimerOrButtonEvent), UTIL_SEQ_RFU, SendTxData);
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_LoRaStoreContextEvent), UTIL_SEQ_RFU, StoreContext);
[#if (SECURE_PROJECTS == "0")]
  UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_LoRaStopJoinEvent), UTIL_SEQ_RFU, StopJoin);
[/#if]
[/#if]

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
[#if THREADX??]
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
  /* Create the semaphore for RfTest.  */
  if (TST_Semaphore_Init() < 0)
  {
    Error_Handler();
  }
[#elseif FREERTOS??]
  Thd_VcomProcessId = osThreadNew(Thd_VcomProcess, NULL, &Thd_VcomProcess_attr);
  if (Thd_VcomProcessId == NULL)
  {
    Error_Handler();
  }
  /* Create the semaphore for RfTest.  */
  TST_Semaphore_Init();
[#else]
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
  LmHandlerInit(&LmHandlerCallbacks, APP_VERSION);

[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
  LmHandlerConfigure(&LmHandlerParams);

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
  /* USER CODE BEGIN LoRaWAN_Init_2 */
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") && (FILL_UCS == "true")]
  UTIL_TIMER_Start(&JoinLedTimer);

[/#if]
  /* USER CODE END LoRaWAN_Init_2 */

  LmHandlerJoin(ActivationType, ForceRejoin);

  if (EventType == TX_ON_TIMER)
  {
    /* send every time timer elapses */
    UTIL_TIMER_Create(&TxTimer, TxPeriodicity, UTIL_TIMER_ONESHOT, OnTxTimerEvent, NULL);
    UTIL_TIMER_Start(&TxTimer);
  }
  else
  {
    /* USER CODE BEGIN LoRaWAN_Init_3 */

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
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]

[#if (FILL_UCS != "true")]
#if 0 /* User should remove the #if 0 statement and adapt the below code according with his needs*/
[/#if]
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
{
  switch (GPIO_Pin)
  {
    case  BUT1_Pin:
      /* Note: when "EventType == TX_ON_TIMER" this GPIO is not initialized */
      if (EventType == TX_ON_EVENT)
      {
[#if THREADX??]
        tx_thread_resume(&App_MainThread);
[#elseif FREERTOS??]
        osThreadFlagsSet(Thd_LoraSendProcessId, 1);
[#else]
        UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_LoRaSendOnTxTimerOrButtonEvent), CFG_SEQ_Prio_0);
[/#if]
      }
      break;
    case  BUT2_Pin:
[#if (SECURE_PROJECTS == "1")]
[#if (CPUCORE == "CM4")]
#if defined (DEBUGGER_ENABLED) && ( DEBUGGER_ENABLED == 1 )
      lets_go_on = 1;
#elif !defined (DEBUGGER_ENABLED)
#error "DEBUGGER_ENABLED not defined or out of range <0,1>"
#endif /* DEBUGGER_ENABLED */
[/#if]
[#else]
[#if THREADX??]
      tx_thread_resume(&Thd_LoraStopJoinId);
[#elseif FREERTOS??]
      osThreadFlagsSet(Thd_LoraStopJoinId, 1);
[#else]
      UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_LoRaStopJoinEvent), CFG_SEQ_Prio_0);
[/#if]
[/#if]
      break;
    case  BUT3_Pin:
[#if THREADX??]
      tx_thread_resume(&Thd_LoraStoreContextId);
[#elseif FREERTOS??]
      osThreadFlagsSet(Thd_LoraStoreContextId, 1);
[#else]
      UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_LoRaStoreContextEvent), CFG_SEQ_Prio_0);
[/#if]
      break;
    default:
      break;
  }
}
[#if (FILL_UCS != "true")]
#endif
[/#if]
[/#if]

/* USER CODE END PB_Callbacks */

/* Private functions ---------------------------------------------------------*/
/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
[#if THREADX??][#-- If AzRtos is used --]

void App_Main_Thread_Entry(unsigned long thread_input)
{
  (void) thread_input;

  /* USER CODE BEGIN App_Main_Thread_Entry_1 */

  /* USER CODE END App_Main_Thread_Entry_1 */
  SystemApp_Init();
  LoRaWAN_Init();
  /* USER CODE BEGIN App_Main_Thread_Entry_2 */

  /* USER CODE END App_Main_Thread_Entry_2 */

  /* Infinite loop */
  while (1)
  {
    tx_thread_suspend(&App_MainThread);
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
    SendTxData();
[/#if]
    /*do what you want*/
    /* USER CODE BEGIN App_Main_Thread_Entry_Loop */

    /* USER CODE END App_Main_Thread_Entry_Loop */
  }
  /* Following USER CODE SECTION will be never reached */
  /* it can be use for compilation flag like #else or #endif */
  /* USER CODE BEGIN App_Main_Thread_Entry_Last */

  /* USER CODE END App_Main_Thread_Entry_Last */
}
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
[#if CPUCORE == ""][#-- singleCore --]
[#if THREADX??]

static void Thd_LmHandlerProcess_Entry(unsigned long thread_input)
{
  /* USER CODE BEGIN Thd_LmHandlerProcess_Entry_1 */

  /* USER CODE END Thd_LmHandlerProcess_Entry_1 */
  (void) thread_input;
  /* Infinite loop */
  for (;;)
  {
    tx_thread_suspend(&Thd_LmHandlerProcessId);
    LmHandlerProcess();
    /* USER CODE BEGIN Thd_LmHandlerProcess_Entry_2 */

    /* USER CODE END Thd_LmHandlerProcess_Entry_2 */
  }
  /* Following USER CODE SECTION will be never reached */
  /* it can be use for compilation flag like #else or #endif */
  /* USER CODE BEGIN Thd_LmHandlerProcess_Entry_Last */

  /* USER CODE END Thd_LmHandlerProcess_Entry_Last */
}
[#elseif FREERTOS??]

static void Thd_LmHandlerProcess(void *argument)
{
  /* USER CODE BEGIN Thd_LmHandlerProcess_1 */

  /* USER CODE END Thd_LmHandlerProcess_1 */
  UNUSED(argument);
  for (;;)
  {
    osThreadFlagsWait(1, osFlagsWaitAny, osWaitForever);
    LmHandlerProcess(); /*what you want to do*/
    /* USER CODE BEGIN Thd_LmHandlerProcess_2 */

    /* USER CODE END Thd_LmHandlerProcess_2 */
  }
}
[/#if]
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
[#if THREADX??]

static void Thd_StoreContext_Entry(unsigned long thread_input)
{
  /* USER CODE BEGIN Thd_StoreContext_Entry_1 */

  /* USER CODE END Thd_StoreContext_Entry_1 */
  (void) thread_input;
  /* Infinite loop */
  for (;;)
  {
    tx_thread_suspend(&Thd_LoraStoreContextId);
    StoreContext();
    /* USER CODE BEGIN Thd_StoreContext_Entry_2 */

    /* USER CODE END Thd_StoreContext_Entry_2 */
  }
  /* Following USER CODE SECTION will be never reached */
  /* it can be use for compilation flag like #else or #endif */
  /* USER CODE BEGIN Thd_StoreContext_Entry_Last */

  /* USER CODE END Thd_StoreContext_Entry_Last */
}
[#if (SECURE_PROJECTS == "0")]

static void Thd_StopJoin_Entry(unsigned long thread_input)
{
  /* USER CODE BEGIN Thd_StopJoin_Entry_1 */

  /* USER CODE END Thd_StopJoin_Entry_1 */
  (void) thread_input;
  /* Infinite loop */
  for (;;)
  {
    tx_thread_suspend(&Thd_LoraStopJoinId);
    StopJoin();
    /* USER CODE BEGIN Thd_StopJoin_Entry_2 */

    /* USER CODE END Thd_StopJoin_Entry_2 */
  }
  /* Following USER CODE SECTION will be never reached */
  /* it can be use for compilation flag like #else or #endif */
  /* USER CODE BEGIN Thd_StopJoin_Entry_Last */

  /* USER CODE END Thd_StopJoin_Entry_Last */
}
[/#if]
[#elseif FREERTOS??]

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

static void Thd_LoraStoreContext(void *argument)
{
  /* USER CODE BEGIN Thd_LoraStoreContext_1 */

  /* USER CODE END Thd_LoraStoreContext_1 */
  UNUSED(argument);
  for (;;)
  {
    osThreadFlagsWait(1, osFlagsWaitAny, osWaitForever);
    StoreContext();  /*what you want to do*/
  }

  /* USER CODE BEGIN Thd_LoraStoreContext_2 */

  /* USER CODE END Thd_LoraStoreContext_2 */
}
[#if (SECURE_PROJECTS == "0")]

static void Thd_LoraStopJoin(void *argument)
{
  /* USER CODE BEGIN Thd_LoraStopJoin_1 */

  /* USER CODE END Thd_LoraStopJoin_1 */
  UNUSED(argument);
  for (;;)
  {
    osThreadFlagsWait(1, osFlagsWaitAny, osWaitForever);
    StopJoin();  /*what you want to do*/
  }

  /* USER CODE BEGIN Thd_LoraStopJoin_2 */

  /* USER CODE END Thd_LoraStopJoin_2 */
}
[/#if]
[/#if]
[#elseif (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
[#if THREADX??]

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
[#elseif FREERTOS??]

static void Thd_VcomProcess(void *argument)
{
  /* USER CODE BEGIN Thd_VcomProcess_1 */

  /* USER CODE END Thd_VcomProcess_1 */
  UNUSED(argument);
  for (;;)
  {
    osThreadFlagsWait(1, osFlagsWaitAny, osWaitForever);
    CMD_Process();  /*what you want to do*/
  }

  /* USER CODE BEGIN Thd_VcomProcess_2 */

  /* USER CODE END Thd_VcomProcess_2 */
}
[/#if]
[/#if]
[/#if]

static void OnRxData(LmHandlerAppData_t *appData, LmHandlerRxParams_t *params)
{
  /* USER CODE BEGIN OnRxData_1 */
[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")) && (FILL_UCS == "true")]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
  uint8_t RxPort = 0;

  if (params != NULL)
[#elseif (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
  if ((appData != NULL) || (params != NULL))
[/#if]
  {
    HAL_GPIO_WritePin(LED1_GPIO_Port, LED1_Pin, GPIO_PIN_SET); /* LED_BLUE */

    UTIL_TIMER_Start(&RxLedTimer);

[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
    if (params->IsMcpsIndication)
    {
      if (appData != NULL)
      {
        RxPort = appData->Port;
        if (appData->Buffer != NULL)
        {
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
                  APP_LOG(TS_OFF, VLEVEL_H, "LED OFF\r\n");
                  HAL_GPIO_WritePin(LED3_GPIO_Port, LED3_Pin, GPIO_PIN_RESET); /* LED_RED */
                }
                else
                {
                  APP_LOG(TS_OFF, VLEVEL_H, "LED ON\r\n");
                  HAL_GPIO_WritePin(LED3_GPIO_Port, LED3_Pin, GPIO_PIN_SET); /* LED_RED */
                }
              }
              break;

            default:

              break;
          }
        }
      }
    }
    if (params->RxSlot < RX_SLOT_NONE)
    {
      APP_LOG(TS_OFF, VLEVEL_H, "###### D/L FRAME:%04d | PORT:%d | DR:%d | SLOT:%s | RSSI:%d | SNR:%d\r\n",
              params->DownlinkCounter, RxPort, params->Datarate, slotStrings[params->RxSlot], params->Rssi, params->Snr);
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
  LmHandlerErrorStatus_t status = LORAMAC_HANDLER_ERROR;
  uint8_t batteryLevel = GetBatteryLevel();
  sensor_t sensor_data;
  UTIL_TIMER_Time_t nextTxIn = 0;

#ifdef CAYENNE_LPP
  uint8_t channel = 0;
#else
  uint16_t pressure = 0;
  int16_t temperature = 0;
  uint16_t humidity = 0;
  uint32_t i = 0;
  int32_t latitude = 0;
  int32_t longitude = 0;
  uint16_t altitudeGps = 0;
#endif /* CAYENNE_LPP */

  EnvSensors_Read(&sensor_data);

  APP_LOG(TS_ON, VLEVEL_M, "VDDA: %d\r\n", batteryLevel);
  APP_LOG(TS_ON, VLEVEL_M, "temp: %d\r\n", (int16_t)(sensor_data.temperature));

  AppData.Port = LORAWAN_USER_APP_PORT;

#ifdef CAYENNE_LPP
  CayenneLppReset();
  CayenneLppAddBarometricPressure(channel++, sensor_data.pressure);
  CayenneLppAddTemperature(channel++, sensor_data.temperature);
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
  temperature = (int16_t)(sensor_data.temperature);
  pressure = (uint16_t)(sensor_data.pressure * 100 / 10); /* in hPa / 10 */

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

  if ((JoinLedTimer.IsRunning) && (LmHandlerJoinStatus() == LORAMAC_HANDLER_SET))
  {
    UTIL_TIMER_Stop(&JoinLedTimer);
    HAL_GPIO_WritePin(LED3_GPIO_Port, LED3_Pin, GPIO_PIN_RESET); /* LED_RED */
  }

  status = LmHandlerSend(&AppData, LmHandlerParams.IsTxConfirmed, false);
  if (LORAMAC_HANDLER_SUCCESS == status)
  {
    APP_LOG(TS_ON, VLEVEL_L, "SEND REQUEST\r\n");
  }
  else if (LORAMAC_HANDLER_DUTYCYCLE_RESTRICTED == status)
  {
    nextTxIn = LmHandlerGetDutyCycleWaitTime();
    if (nextTxIn > 0)
    {
      APP_LOG(TS_ON, VLEVEL_L, "Next Tx in  : ~%d second(s)\r\n", (nextTxIn / 1000));
    }
  }

  if (EventType == TX_ON_TIMER)
  {
    UTIL_TIMER_Stop(&TxTimer);
    UTIL_TIMER_SetPeriod(&TxTimer, MAX(nextTxIn, TxPeriodicity));
    UTIL_TIMER_Start(&TxTimer);
  }
[/#if]

  /* USER CODE END SendTxData_1 */
}

static void OnTxTimerEvent(void *context)
{
  /* USER CODE BEGIN OnTxTimerEvent_1 */

  /* USER CODE END OnTxTimerEvent_1 */
[#if THREADX??]
  /* Reactivate App_MainThread */
  tx_thread_resume(&App_MainThread);
[#elseif FREERTOS??]
  osThreadFlagsSet(Thd_LoraSendProcessId, 1);
[#else]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_LoRaSendOnTxTimerOrButtonEvent), CFG_SEQ_Prio_0);
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
  HAL_GPIO_WritePin(LED2_GPIO_Port, LED2_Pin, GPIO_PIN_RESET); /* LED_GREEN */
}

static void OnRxTimerLedEvent(void *context)
{
  HAL_GPIO_WritePin(LED1_GPIO_Port, LED1_Pin, GPIO_PIN_RESET); /* LED_BLUE */
}

static void OnJoinTimerLedEvent(void *context)
{
  HAL_GPIO_TogglePin(LED3_GPIO_Port, LED3_Pin); /* LED_RED */
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
      HAL_GPIO_WritePin(LED2_GPIO_Port, LED2_Pin, GPIO_PIN_SET); /* LED_GREEN */
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
      HAL_GPIO_WritePin(LED3_GPIO_Port, LED3_Pin, GPIO_PIN_RESET); /* LED_RED */

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

static void OnBeaconStatusChange(LmHandlerBeaconParams_t *params)
{
  /* USER CODE BEGIN OnBeaconStatusChange_1 */
[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")) && (FILL_UCS == "true")]
  if (params != NULL)
  {
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
    switch (params->State)
    {
      default:
      case LORAMAC_HANDLER_BEACON_LOST:
      {
        APP_LOG(TS_OFF, VLEVEL_M, "\r\n###### BEACON LOST\r\n");
        break;
      }
      case LORAMAC_HANDLER_BEACON_RX:
      {
        APP_LOG(TS_OFF, VLEVEL_M,
                "\r\n###### BEACON RECEIVED | DR:%d | RSSI:%d | SNR:%d | FQ:%d | TIME:%d | DESC:%d | "
                "INFO:02X%02X%02X %02X%02X%02X\r\n",
                params->Info.Datarate, params->Info.Rssi, params->Info.Snr, params->Info.Frequency,
                params->Info.Time.Seconds, params->Info.GwSpecific.InfoDesc,
                params->Info.GwSpecific.Info[0], params->Info.GwSpecific.Info[1],
                params->Info.GwSpecific.Info[2], params->Info.GwSpecific.Info[3],
                params->Info.GwSpecific.Info[4], params->Info.GwSpecific.Info[5]);
        break;
      }
      case LORAMAC_HANDLER_BEACON_NRX:
      {
        APP_LOG(TS_OFF, VLEVEL_M, "\r\n###### BEACON NOT RECEIVED\r\n");
        break;
      }
    }
[#elseif (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
    AT_event_Beacon(params);
[/#if]
  }
[/#if]
  /* USER CODE END OnBeaconStatusChange_1 */
}

static void OnClassChange(DeviceClass_t deviceClass)
{
  /* USER CODE BEGIN OnClassChange_1 */
[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")) && (FILL_UCS == "true")]
[#if (LORAWAN_FUOTA == "1")]
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
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
  APP_LOG(TS_OFF, VLEVEL_M, "Switch to Class %c done\r\n", "ABC"[deviceClass]);
[#elseif (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
  AT_event_ClassUpdate(deviceClass);
[/#if]
[/#if]
  /* USER CODE END OnClassChange_1 */
}

[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
static void CmdProcessNotify(void)
{
  /* USER CODE BEGIN CmdProcessNotify_1 */

  /* USER CODE END CmdProcessNotify_1 */
[#if THREADX??]
  tx_thread_resume(&Thd_VcomProcessId);
[#elseif FREERTOS??]
  osThreadFlagsSet(Thd_VcomProcessId, 1);
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
[#if THREADX??]
  tx_thread_resume(&Thd_LmHandlerProcessId);
[#elseif FREERTOS??]
  osThreadFlagsSet(Thd_LmHandlerProcessId, 1);
[#else]
  UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_LmHandlerProcess), CFG_SEQ_Prio_0);
[/#if]

  /* USER CODE BEGIN OnMacProcessNotify_2 */

  /* USER CODE END OnMacProcessNotify_2 */
[/#if]
[/#if]
}

static void OnTxPeriodicityChanged(uint32_t periodicity)
{
  /* USER CODE BEGIN OnTxPeriodicityChanged_1 */

  /* USER CODE END OnTxPeriodicityChanged_1 */
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
  TxPeriodicity = periodicity;

  if (TxPeriodicity == 0)
  {
    /* Revert to application default periodicity */
    TxPeriodicity = APP_TX_DUTYCYCLE;
  }

  /* Update timer periodicity */
  UTIL_TIMER_Stop(&TxTimer);
  UTIL_TIMER_SetPeriod(&TxTimer, TxPeriodicity);
  UTIL_TIMER_Start(&TxTimer);
  /* USER CODE BEGIN OnTxPeriodicityChanged_2 */

  /* USER CODE END OnTxPeriodicityChanged_2 */
[/#if]
}

static void OnTxFrameCtrlChanged(LmHandlerMsgTypes_t isTxConfirmed)
{
  /* USER CODE BEGIN OnTxFrameCtrlChanged_1 */

  /* USER CODE END OnTxFrameCtrlChanged_1 */
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
  LmHandlerParams.IsTxConfirmed = isTxConfirmed;
  /* USER CODE BEGIN OnTxFrameCtrlChanged_2 */

  /* USER CODE END OnTxFrameCtrlChanged_2 */
[/#if]
}

static void OnPingSlotPeriodicityChanged(uint8_t pingSlotPeriodicity)
{
  /* USER CODE BEGIN OnPingSlotPeriodicityChanged_1 */

  /* USER CODE END OnPingSlotPeriodicityChanged_1 */
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
  LmHandlerParams.PingSlotPeriodicity = pingSlotPeriodicity;
  /* USER CODE BEGIN OnPingSlotPeriodicityChanged_2 */

  /* USER CODE END OnPingSlotPeriodicityChanged_2 */
[/#if]
}

static void OnSystemReset(void)
{
  /* USER CODE BEGIN OnSystemReset_1 */

  /* USER CODE END OnSystemReset_1 */
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
  if ((LORAMAC_HANDLER_SUCCESS == LmHandlerHalt()) && (LmHandlerJoinStatus() == LORAMAC_HANDLER_SET))
  {
    NVIC_SystemReset();
  }
  /* USER CODE BEGIN OnSystemReset_Last */

  /* USER CODE END OnSystemReset_Last */
[/#if]
}

[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
[#if (SECURE_PROJECTS == "0")]
static void StopJoin(void)
{
  /* USER CODE BEGIN StopJoin_1 */
[#if (FILL_UCS == "true")]
  HAL_GPIO_WritePin(LED1_GPIO_Port, LED1_Pin, GPIO_PIN_SET); /* LED_BLUE */
  HAL_GPIO_WritePin(LED2_GPIO_Port, LED2_Pin, GPIO_PIN_SET); /* LED_GREEN */
  HAL_GPIO_WritePin(LED3_GPIO_Port, LED3_Pin, GPIO_PIN_SET); /* LED_RED */
[#else]

[/#if]
  /* USER CODE END StopJoin_1 */

  UTIL_TIMER_Stop(&TxTimer);

  if (LORAMAC_HANDLER_SUCCESS != LmHandlerStop())
  {
    APP_LOG(TS_OFF, VLEVEL_M, "LmHandler Stop on going ...\r\n");
  }
  else
  {
    APP_LOG(TS_OFF, VLEVEL_M, "LmHandler Stopped\r\n");
    if (LORAWAN_DEFAULT_ACTIVATION_TYPE == ACTIVATION_TYPE_ABP)
    {
      ActivationType = ACTIVATION_TYPE_OTAA;
      APP_LOG(TS_OFF, VLEVEL_M, "LmHandler switch to OTAA mode\r\n");
    }
    else
    {
      ActivationType = ACTIVATION_TYPE_ABP;
      APP_LOG(TS_OFF, VLEVEL_M, "LmHandler switch to ABP mode\r\n");
    }
    LmHandlerConfigure(&LmHandlerParams);
    LmHandlerJoin(ActivationType, true);
    UTIL_TIMER_Start(&TxTimer);
  }
  UTIL_TIMER_Start(&StopJoinTimer);
  /* USER CODE BEGIN StopJoin_Last */

  /* USER CODE END StopJoin_Last */
}

static void OnStopJoinTimerEvent(void *context)
{
  /* USER CODE BEGIN OnStopJoinTimerEvent_1 */

  /* USER CODE END OnStopJoinTimerEvent_1 */
  if (ActivationType == LORAWAN_DEFAULT_ACTIVATION_TYPE)
  {
[#if THREADX??]
    tx_thread_resume(&Thd_LoraStopJoinId);
[#elseif FREERTOS??]
    osThreadFlagsSet(Thd_LoraStopJoinId, 1);
[#else]
    UTIL_SEQ_SetTask((1 << CFG_SEQ_Task_LoRaStopJoinEvent), CFG_SEQ_Prio_0);
[/#if]
  }
  /* USER CODE BEGIN OnStopJoinTimerEvent_Last */
[#if (FILL_UCS == "true")]
  HAL_GPIO_WritePin(LED1_GPIO_Port, LED1_Pin, GPIO_PIN_RESET); /* LED_BLUE */
  HAL_GPIO_WritePin(LED2_GPIO_Port, LED2_Pin, GPIO_PIN_RESET); /* LED_GREEN */
  HAL_GPIO_WritePin(LED3_GPIO_Port, LED3_Pin, GPIO_PIN_RESET); /* LED_RED */
[#else]

[/#if]
  /* USER CODE END OnStopJoinTimerEvent_Last */
}

[/#if]
static void StoreContext(void)
{
  LmHandlerErrorStatus_t status = LORAMAC_HANDLER_ERROR;

  /* USER CODE BEGIN StoreContext_1 */

  /* USER CODE END StoreContext_1 */
  status = LmHandlerNvmDataStore();

  if (status == LORAMAC_HANDLER_NVM_DATA_UP_TO_DATE)
  {
    APP_LOG(TS_OFF, VLEVEL_M, "NVM DATA UP TO DATE\r\n");
  }
  else if (status == LORAMAC_HANDLER_ERROR)
  {
    APP_LOG(TS_OFF, VLEVEL_M, "NVM DATA STORE FAILED\r\n");
  }
  /* USER CODE BEGIN StoreContext_Last */

  /* USER CODE END StoreContext_Last */
}

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
static void OnNvmDataChange(LmHandlerNvmContextStates_t state)
{
  /* USER CODE BEGIN OnNvmDataChange_1 */

  /* USER CODE END OnNvmDataChange_1 */
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
  AT_event_OnNvmDataChange(state);
[#else]
  if (state == LORAMAC_HANDLER_NVM_STORE)
  {
    APP_LOG(TS_OFF, VLEVEL_M, "NVM DATA STORED\r\n");
  }
  else
  {
    APP_LOG(TS_OFF, VLEVEL_M, "NVM DATA RESTORED\r\n");
  }
[/#if]
  /* USER CODE BEGIN OnNvmDataChange_Last */

  /* USER CODE END OnNvmDataChange_Last */
}

static void OnStoreContextRequest(void *nvm, uint32_t nvm_size)
{
  /* USER CODE BEGIN OnStoreContextRequest_1 */

  /* USER CODE END OnStoreContextRequest_1 */
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
  AT_event_OnStoreContextRequest(nvm, nvm_size);
[#else]
  /* store nvm in flash */
  if (HAL_FLASH_Unlock() == HAL_OK)
  {
    if (FLASH_IF_EraseByPages(PAGE(LORAWAN_NVM_BASE_ADDRESS), 1, 0U) == FLASH_OK)
    {
      FLASH_IF_Write(LORAWAN_NVM_BASE_ADDRESS, (uint8_t *)nvm, nvm_size, NULL);
    }
    HAL_FLASH_Lock();
  }
[/#if]
  /* USER CODE BEGIN OnStoreContextRequest_Last */

  /* USER CODE END OnStoreContextRequest_Last */
}

static void OnRestoreContextRequest(void *nvm, uint32_t nvm_size)
{
  /* USER CODE BEGIN OnRestoreContextRequest_1 */

  /* USER CODE END OnRestoreContextRequest_1 */
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
  AT_event_OnRestoreContextRequest(nvm, nvm_size);
[#else]
  UTIL_MEM_cpy_8(nvm, (void *)LORAWAN_NVM_BASE_ADDRESS, nvm_size);
[/#if]
  /* USER CODE BEGIN OnRestoreContextRequest_Last */

  /* USER CODE END OnRestoreContextRequest_Last */
}

[/#if]
