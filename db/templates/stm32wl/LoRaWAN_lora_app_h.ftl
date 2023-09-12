[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    lora_app.h
  * @author  MCD Application Team
  * @brief   Header of application of the LRWAN Middleware
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
[#assign ACTIVE_REGION = ""]
[#assign APP_TX_DUTYCYCLE = ""]
[#assign LORAWAN_SWITCH_CLASS_PORT = ""]
[#assign LORAWAN_USER_APP_PORT = ""]
[#assign LORAWAN_DEFAULT_CLASS = ""]
[#assign LORAWAN_DEFAULT_CONFIRMED_MSG_STATE = ""]
[#assign LORAWAN_ADR_STATE = ""]
[#assign LORAWAN_DEFAULT_ACTIVATION_TYPE = ""]
[#assign LORAWAN_FORCE_REJOIN_AT_BOOT = ""]
[#assign LORAWAN_DEFAULT_DATA_RATE = ""]
[#assign LORAWAN_DEFAULT_TX_POWER = ""]
[#assign LORAWAN_DEFAULT_PING_SLOT_PERIODICITY = ""]
[#assign LORAWAN_DEFAULT_CLASS_B_C_RESP_TIMEOUT = ""]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "SUBGHZ_APPLICATION"]
                    [#assign SUBGHZ_APPLICATION = definition.value]
                [/#if]
                [#if definition.name == "ACTIVE_REGION"]
                    [#assign ACTIVE_REGION = definition.value]
                [/#if]
                [#if definition.name == "APP_TX_DUTYCYCLE"]
                    [#assign APP_TX_DUTYCYCLE = definition.value]
                [/#if]
                [#if definition.name == "LORAWAN_SWITCH_CLASS_PORT"]
                    [#assign LORAWAN_SWITCH_CLASS_PORT = definition.value]
                [/#if]
                [#if definition.name == "LORAWAN_USER_APP_PORT"]
                    [#assign LORAWAN_USER_APP_PORT = definition.value]
                [/#if]
                [#if definition.name == "LORAWAN_DEFAULT_CLASS"]
                    [#assign LORAWAN_DEFAULT_CLASS = definition.value]
                [/#if]
                [#if definition.name == "LORAWAN_DEFAULT_CONFIRMED_MSG_STATE"]
                    [#assign LORAWAN_DEFAULT_CONFIRMED_MSG_STATE = definition.value]
                [/#if]
                [#if definition.name == "LORAWAN_ADR_STATE"]
                    [#assign LORAWAN_ADR_STATE = definition.value]
                [/#if]
                [#if definition.name == "LORAWAN_DEFAULT_ACTIVATION_TYPE"]
                    [#assign LORAWAN_DEFAULT_ACTIVATION_TYPE = definition.value]
                [/#if]
                [#if definition.name == "LORAWAN_FORCE_REJOIN_AT_BOOT"]
                    [#assign LORAWAN_FORCE_REJOIN_AT_BOOT = definition.value]
                [/#if]
                [#if definition.name == "LORAWAN_DEFAULT_DATA_RATE"]
                    [#assign LORAWAN_DEFAULT_DATA_RATE = definition.value]
                [/#if]
                [#if definition.name == "LORAWAN_DEFAULT_TX_POWER"]
                    [#assign LORAWAN_DEFAULT_TX_POWER = definition.value]
                [/#if]
                [#if definition.name == "LORAWAN_DEFAULT_PING_SLOT_PERIODICITY"]
                    [#assign LORAWAN_DEFAULT_PING_SLOT_PERIODICITY = definition.value]
                [/#if]
                [#if definition.name == "LORAWAN_DEFAULT_CLASS_B_C_RESP_TIMEOUT"]
                    [#assign LORAWAN_DEFAULT_CLASS_B_C_RESP_TIMEOUT = definition.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __LORA_APP_H__
#define __LORA_APP_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if (CPUCORE != "CM0PLUS")]

[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
/* LoraWAN application configuration (Mw is configured by lorawan_conf.h) */
#define ACTIVE_REGION                               ${ACTIVE_REGION}

[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
/* USER CODE BEGIN EC_CAYENNE_LPP */
/*!
 * CAYENNE_LPP is myDevices Application server.
 */
/*#define CAYENNE_LPP*/
/* USER CODE END EC_CAYENNE_LPP */

/*!
 * Defines the application data transmission duty cycle. 10s, value in [ms].
 */
#define APP_TX_DUTYCYCLE                            ${APP_TX_DUTYCYCLE}

/*!
 * LoRaWAN User application port
 * @note do not use 224. It is reserved for certification
 */
#define LORAWAN_USER_APP_PORT                       ${LORAWAN_USER_APP_PORT}

/*!
 * LoRaWAN Switch class application port
 * @note do not use 224. It is reserved for certification
 */
#define LORAWAN_SWITCH_CLASS_PORT                   ${LORAWAN_SWITCH_CLASS_PORT}

/*!
 * LoRaWAN default class
 */
#define LORAWAN_DEFAULT_CLASS                       ${LORAWAN_DEFAULT_CLASS}

/*!
 * LoRaWAN default confirm state
 */
#define LORAWAN_DEFAULT_CONFIRMED_MSG_STATE         ${LORAWAN_DEFAULT_CONFIRMED_MSG_STATE}

[/#if][#--  SUBGHZ_APPLICATION == "LORA_END_NODE" --]
/*!
 * LoRaWAN Adaptive Data Rate
 * @note Please note that when ADR is enabled the end-device should be static
 */
#define LORAWAN_ADR_STATE                           ${LORAWAN_ADR_STATE}

/*!
 * LoRaWAN Default Data Rate
 * @note Please note that LORAWAN_DEFAULT_DATA_RATE is used only when LORAWAN_ADR_STATE is disabled
 */
#define LORAWAN_DEFAULT_DATA_RATE                   ${LORAWAN_DEFAULT_DATA_RATE}

/*!
 * LoRaWAN Default Tx output power
 * @note LORAWAN_DEFAULT_TX_POWER must be defined in the [XXXX_MIN_TX_POWER - XXXX_MAX_TX_POWER] range,
         else the end-device uses the XXXX_DEFAULT_TX_POWER value
 */
#define LORAWAN_DEFAULT_TX_POWER                    ${LORAWAN_DEFAULT_TX_POWER}

[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
/*!
 * LoRaWAN default activation type
 */
#define LORAWAN_DEFAULT_ACTIVATION_TYPE             ${LORAWAN_DEFAULT_ACTIVATION_TYPE}

/*!
 * LoRaWAN force rejoin even if the NVM context is restored
 * @note useful only when context management is enabled by CONTEXT_MANAGEMENT_ENABLED
 */
#define LORAWAN_FORCE_REJOIN_AT_BOOT                ${LORAWAN_FORCE_REJOIN_AT_BOOT}

/*!
 * User application data buffer size
 */
#define LORAWAN_APP_DATA_BUFFER_MAX_SIZE            242

[/#if][#--  SUBGHZ_APPLICATION == "LORA_END_NODE" --]
/*!
 * Default Unicast ping slots periodicity
 *
 * \remark periodicity is equal to 2^LORAWAN_DEFAULT_PING_SLOT_PERIODICITY seconds
 *         example: 2^4 = 16 seconds. The end-device will open an Rx slot every 16 seconds.
 */
#define LORAWAN_DEFAULT_PING_SLOT_PERIODICITY       ${LORAWAN_DEFAULT_PING_SLOT_PERIODICITY}

/*!
 * Default response timeout for class b and class c confirmed
 * downlink frames in milli seconds.
 *
 * The value shall not be smaller than RETRANSMIT_TIMEOUT plus
 * the maximum time on air.
 */
#define LORAWAN_DEFAULT_CLASS_B_C_RESP_TIMEOUT      ${LORAWAN_DEFAULT_CLASS_B_C_RESP_TIMEOUT}

[/#if][#--  SUBGHZ_APPLICATION != "LORA_USER_APPLICATION --]
[/#if][#--  CPUCORE != "CM0PLUS" --]
[#if FREERTOS??][#-- If FreeRtos is used --]
[#if (CPUCORE == "") && (SUBGHZ_APPLICATION == "LORA_END_NODE")]
/*Send*/
#define CFG_APP_LORA_PROCESS_NAME                  "LORA_SEND_PROCESS"
#define CFG_APP_LORA_PROCESS_ATTR_BITS             (0)
#define CFG_APP_LORA_PROCESS_CB_MEM                (0)
#define CFG_APP_LORA_PROCESS_CB_SIZE               (0)
#define CFG_APP_LORA_PROCESS_STACK_MEM             (0)
#define CFG_APP_LORA_PROCESS_PRIORITY              osPriorityNone
#define CFG_APP_LORA_PROCESS_STACK_SIZE            1024

/*Store Context*/
#define CFG_APP_LORA_STORE_CONTEXT_NAME            "LORA_STORE_CONTEXT"
#define CFG_APP_LORA_STORE_CONTEXT_ATTR_BITS       (0)
#define CFG_APP_LORA_STORE_CONTEXT_CB_MEM          (0)
#define CFG_APP_LORA_STORE_CONTEXT_CB_SIZE         (0)
#define CFG_APP_LORA_STORE_CONTEXT_STACK_MEM       (0)
#define CFG_APP_LORA_STORE_CONTEXT_PRIORITY        osPriorityNone
#define CFG_APP_LORA_STORE_CONTEXT_STACK_SIZE      1024

/*Stop Join*/
#define CFG_APP_LORA_STOP_JOIN_NAME                "LORA_STOP_JOIN"
#define CFG_APP_LORA_STOP_JOIN_ATTR_BITS           (0)
#define CFG_APP_LORA_STOP_JOIN_CB_MEM              (0)
#define CFG_APP_LORA_STOP_JOIN_CB_SIZE             (0)
#define CFG_APP_LORA_STOP_JOIN_STACK_MEM           (0)
#define CFG_APP_LORA_STOP_JOIN_PRIORITY            osPriorityNone
#define CFG_APP_LORA_STOP_JOIN_STACK_SIZE          1024

[/#if]
[#if (CPUCORE == "") && ((SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "LORA_END_NODE"))]
/*LM Handler*/
#define CFG_LM_HANDLER_PROCESS_NAME                "LM_HANDLER_PROCESS"
#define CFG_LM_HANDLER_PROCESS_ATTR_BITS           (0)
#define CFG_LM_HANDLER_PROCESS_CB_MEM              (0)
#define CFG_LM_HANDLER_PROCESS_CB_SIZE             (0)
#define CFG_LM_HANDLER_PROCESS_STACK_MEM           (0)
#define CFG_LM_HANDLER_PROCESS_PRIORITY            osPriorityNone
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
#define CFG_LM_HANDLER_PROCESS_STACK_SIZE          1024
[#else]
#define CFG_LM_HANDLER_PROCESS_STACK_SIZE          1536
[/#if]

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
/*Vcom*/
#define CFG_VCOM_PROCESS_NAME                      "VCOM_PROCESS"
#define CFG_VCOM_PROCESS_ATTR_BITS                 (0)
#define CFG_VCOM_PROCESS_CB_MEM                    (0)
#define CFG_VCOM_PROCESS_CB_SIZE                   (0)
#define CFG_VCOM_PROCESS_STACK_MEM                 (0)
#define CFG_VCOM_PROCESS_PRIORITY                  osPriorityNone
#define CFG_VCOM_PROCESS_STACK_SIZE                1024

[/#if]
[/#if][#--  FREERTOS --]
[#if THREADX??]
/* USER CODE BEGIN THREADX_EC */
/*!
 * THREADs configuration defines: stack size and priorities
 * of the different Azure RTOS threads used by the LoRaWAN application.
 */
#define CFG_APP_LORA_THREAD_STACK_SIZE                   1024
#define CFG_APP_LORA_THREAD_PRIO                         10
#define CFG_APP_LORA_THREAD_PREEMPTION_THRESHOLD         CFG_APP_LORA_THREAD_PRIO

[#if (CPUCORE == "") && ((SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "LORA_END_NODE"))]
#define CFG_LM_HANDLER_THREAD_STACK_SIZE                 1536
#define CFG_LM_HANDLER_THREAD_PRIO                       CFG_APP_LORA_THREAD_PRIO
#define CFG_LM_HANDLER_THREAD_PREEMPTION_THRESHOLD       CFG_APP_LORA_THREAD_PRIO

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
#define CFG_APP_LORA_STORE_CONTEXT_STACK_SIZE            1024
#define CFG_APP_LORA_STORE_CONTEXT_PRIO                  CFG_APP_LORA_THREAD_PRIO
#define CFG_APP_LORA_STORE_CONTEXT_PREEMPTION_THRESHOLD  CFG_APP_LORA_THREAD_PRIO

[#if (SECURE_PROJECTS == "0")]
#define CFG_APP_LORA_STOP_JOIN_STACK_SIZE                1024
#define CFG_APP_LORA_STOP_JOIN_PRIO                      CFG_APP_LORA_THREAD_PRIO
#define CFG_APP_LORA_STOP_JOIN_PREEMPTION_THRESHOLD      CFG_APP_LORA_THREAD_PRIO

[/#if]
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
#define CFG_VCOM_THREAD_STACK_SIZE                       1024
#define CFG_VCOM_THREAD_PRIO                             CFG_APP_LORA_THREAD_PRIO
#define CFG_VCOM_THREAD_PREEMPTION_THRESHOLD             CFG_APP_LORA_THREAD_PRIO

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
#define CFG_AT_THREAD_STACK_SIZE                         1536
#define CFG_AT_THREAD_PRIO                               CFG_APP_LORA_THREAD_PRIO
#define CFG_AT_THREAD_PREEMPTION_THRESHOLD               CFG_APP_LORA_THREAD_PRIO

[/#if]
/* USER CODE END THREADX_EC */

[/#if][#--  THREADX --]
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macros -----------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
[#if (CPUCORE == "CM0PLUS")]

void InitPackageProcess(void);

void OnMacProcessNotify(void);
[#else]
/**
  * @brief  Init Lora Application
  */
void LoRaWAN_Init(void);
[/#if][#--  CPUCORE == CM4 vs CM0 vs SINGLE --]

[#if THREADX??]
/**
  * @brief  Function implementing the LoraWAN Main Thread thread.
  * @param  thread_input: Not used
  * @retval None
  */
void App_Main_Thread_Entry(unsigned long thread_input);
[/#if][#--  THREADX --]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__LORA_APP_H__*/
