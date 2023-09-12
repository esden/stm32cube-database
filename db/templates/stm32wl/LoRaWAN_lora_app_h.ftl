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
[#assign ACTIVE_REGION = ""]
[#assign APP_TX_DUTYCYCLE = ""]
[#assign LORAWAN_SWITCH_CLASS_PORT = ""]
[#assign LORAWAN_USER_APP_PORT = ""]
[#assign LORAWAN_DEFAULT_CLASS = ""]
[#assign LORAWAN_DEFAULT_CONFIRMED_MSG_STATE = ""]
[#assign LORAWAN_ADR_STATE = ""]
[#assign LORAWAN_DEFAULT_ACTIVATION_TYPE = ""]
[#assign LORAWAN_DEFAULT_DATA_RATE = ""]
[#assign LORAWAN_DEFAULT_PING_SLOT_PERIODICITY = ""]
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
                [#if definition.name == "LORAWAN_DEFAULT_DATA_RATE"]
                    [#assign LORAWAN_DEFAULT_DATA_RATE = definition.value]
                [/#if]
                [#if definition.name == "LORAWAN_DEFAULT_PING_SLOT_PERIODICITY"]
                    [#assign LORAWAN_DEFAULT_PING_SLOT_PERIODICITY = definition.value]
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
/*!
 * CAYENNE_LPP is myDevices Application server.
 */
/*#define CAYENNE_LPP*/

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

[/#if]
/*!
 * LoRaWAN default endNode class port
 */
#define LORAWAN_DEFAULT_CLASS                       ${LORAWAN_DEFAULT_CLASS}

[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
/*!
 * LoRaWAN default confirm state
 */
#define LORAWAN_DEFAULT_CONFIRMED_MSG_STATE         ${LORAWAN_DEFAULT_CONFIRMED_MSG_STATE}

[/#if]
/*!
 * LoRaWAN Adaptive Data Rate
 * @note Please note that when ADR is enabled the end-device should be static
 */
#define LORAWAN_ADR_STATE                           ${LORAWAN_ADR_STATE}

/*!
 * LoRaWAN Default data Rate Data Rate
 * @note Please note that LORAWAN_DEFAULT_DATA_RATE is used only when LORAWAN_ADR_STATE is disabled
 */
#define LORAWAN_DEFAULT_DATA_RATE                   ${LORAWAN_DEFAULT_DATA_RATE}

[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
/*!
 * LoRaWAN default activation type
 */
#define LORAWAN_DEFAULT_ACTIVATION_TYPE             ${LORAWAN_DEFAULT_ACTIVATION_TYPE}

/*!
 * User application data buffer size
 */
#define LORAWAN_APP_DATA_BUFFER_MAX_SIZE            242

[/#if]
/*!
 * Default Unicast ping slots periodicity
 *
 * \remark periodicity is equal to 2^LORAWAN_DEFAULT_PING_SLOT_PERIODICITY seconds
 *         example: 2^3 = 8 seconds. The end-device will open an Rx slot every 8 seconds.
 */
#define LORAWAN_DEFAULT_PING_SLOT_PERIODICITY       ${LORAWAN_DEFAULT_PING_SLOT_PERIODICITY}

[/#if]
[/#if]
[#if CPUCORE == ""]
[#if FREERTOS??][#-- If FreeRtos is used --]
/*Send*/
#define CFG_APP_LORA_PROCESS_NAME                  "LORA_SEND_PROCESS"
#define CFG_APP_LORA_PROCESS_ATTR_BITS             (0)
#define CFG_APP_LORA_PROCESS_CB_MEM                (0)
#define CFG_APP_LORA_PROCESS_CB_SIZE               (0)
#define CFG_APP_LORA_PROCESS_STACK_MEM             (0)
#define CFG_APP_LORA_PROCESS_PRIORITY              osPriorityNone
#define CFG_APP_LORA_PROCESS_STACk_SIZE            (256 * 4)

/*LM Handler*/
#define CFG_LM_HANDLER_PROCESS_NAME                "LM_HANDLER_PROCESS"
#define CFG_LM_HANDLER_PROCESS_ATTR_BITS           (0)
#define CFG_LM_HANDLER_PROCESS_CB_MEM              (0)
#define CFG_LM_HANDLER_PROCESS_CB_SIZE             (0)
#define CFG_LM_HANDLER_PROCESS_STACK_MEM           (0)
#define CFG_LM_HANDLER_PROCESS_PRIORITY            osPriorityNone
#define CFG_LM_HANDLER_PROCESS_STACk_SIZE          (256 * 4)

[/#if]
[/#if]
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
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
[/#if]

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__LORA_APP_H__*/

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
