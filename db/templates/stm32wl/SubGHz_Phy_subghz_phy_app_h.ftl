[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    subghz_phy_app.h
  * @author  MCD Application Team
  * @brief   Header of application of the SubGHz_Phy Middleware
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
[#assign INTERNAL_USER_SUBGHZ_APP = ""]
[#assign RF_FREQUENCY = ""]
[#assign MODEM_USED = ""]
[#assign REGION = ""]
[#assign LORA_BANDWIDTH = ""]
[#assign LORA_SPREADING_FACTOR = ""]
[#assign LORA_CODINGRATE = ""]
[#assign LORA_PREAMBLE_LENGTH = ""]
[#assign LORA_SYMBOL_TIMEOUT = ""]
[#assign LORA_FIX_LENGTH_PAYLOAD_ON = ""]
[#assign LORA_IQ_INVERSION_ON = ""]
[#assign FSK_FDEV = ""]
[#assign FSK_DATARATE = ""]
[#assign FSK_BANDWIDTH = ""]
[#assign FSK_PREAMBLE_LENGTH = ""]
[#assign FSK_FIX_LENGTH_PAYLOAD_ON = ""]
[#assign PAYLOAD_LEN = ""]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "SUBGHZ_APPLICATION"]
                    [#assign SUBGHZ_APPLICATION = definition.value]
                [/#if]
                [#if definition.name == "RF_FREQUENCY"]
                    [#assign RF_FREQUENCY = definition.value]
                [/#if]
                [#if definition.name == "MODEM_USED"]
                    [#assign MODEM_USED = definition.value]
                [/#if]
                [#if definition.name == "REGION"]
                    [#assign REGION = definition.value]
                [/#if]
                [#if definition.name == "LORA_BANDWIDTH"]
                    [#assign LORA_BANDWIDTH = definition.value]
                [/#if]
                [#if definition.name == "LORA_SPREADING_FACTOR"]
                    [#assign LORA_SPREADING_FACTOR = definition.value]
                [/#if]
                [#if definition.name == "LORA_CODINGRATE"]
                    [#assign LORA_CODINGRATE = definition.value]
                [/#if]
                [#if definition.name == "LORA_PREAMBLE_LENGTH"]
                    [#assign LORA_PREAMBLE_LENGTH = definition.value]
                [/#if]
                [#if definition.name == "LORA_SYMBOL_TIMEOUT"]
                    [#assign LORA_SYMBOL_TIMEOUT = definition.value]
                [/#if]
                [#if definition.name == "LORA_FIX_LENGTH_PAYLOAD_ON"]
                    [#assign LORA_FIX_LENGTH_PAYLOAD_ON = definition.value]
                [/#if]
                [#if definition.name == "LORA_IQ_INVERSION_ON"]
                    [#assign LORA_IQ_INVERSION_ON = definition.value]
                [/#if]
                [#if definition.name == "FSK_FDEV"]
                    [#assign FSK_FDEV = definition.value]
                [/#if]
                [#if definition.name == "FSK_DATARATE"]
                    [#assign FSK_DATARATE = definition.value]
                [/#if]
                [#if definition.name == "FSK_BANDWIDTH"]
                    [#assign FSK_BANDWIDTH = definition.value]
                [/#if]
                [#if definition.name == "FSK_PREAMBLE_LENGTH"]
                    [#assign FSK_PREAMBLE_LENGTH = definition.value]
                [/#if]
                [#if definition.name == "FSK_FIX_LENGTH_PAYLOAD_ON"]
                    [#assign FSK_FIX_LENGTH_PAYLOAD_ON = definition.value]
                [/#if]
                [#if definition.name == "PAYLOAD_LEN"]
                    [#assign PAYLOAD_LEN = definition.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __SUBGHZ_PHY_APP_H__
#define __SUBGHZ_PHY_APP_H__

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
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_AT_SLAVE")]
[#if (MODEM_USED == "USE_MODEM_FSK")]
/* MODEM type: one shall be 1 the other shall be 0 */
#define USE_MODEM_LORA  0
#define USE_MODEM_FSK   1
[#elseif (MODEM_USED == "USE_MODEM_LORA")]
/* MODEM type: one shall be 1 the other shall be 0 */
#define USE_MODEM_LORA  1
#define USE_MODEM_FSK   0
[/#if]

#define RF_FREQUENCY                                ${RF_FREQUENCY} /* Hz */

#ifndef TX_OUTPUT_POWER   /* please, to change this value, redefine it in USER CODE SECTION */
#define TX_OUTPUT_POWER                             14        /* dBm */
#endif /* TX_OUTPUT_POWER */

[#if (MODEM_USED == "USE_MODEM_FSK") || (MODEM_USED == "USE_MODEM_LORA")]
#if (( USE_MODEM_LORA == 1 ) && ( USE_MODEM_FSK == 0 ))
#define LORA_BANDWIDTH                              ${LORA_BANDWIDTH}         /* [0: 125 kHz, 1: 250 kHz, 2: 500 kHz, 3: Reserved] */
#define LORA_SPREADING_FACTOR                       ${LORA_SPREADING_FACTOR}         /* [SF7..SF12] */
#define LORA_CODINGRATE                             ${LORA_CODINGRATE}         /* [1: 4/5, 2: 4/6, 3: 4/7, 4: 4/8] */
#define LORA_PREAMBLE_LENGTH                        ${LORA_PREAMBLE_LENGTH}         /* Same for Tx and Rx */
#define LORA_SYMBOL_TIMEOUT                         ${LORA_SYMBOL_TIMEOUT}         /* Symbols */
#define LORA_FIX_LENGTH_PAYLOAD_ON                  ${LORA_FIX_LENGTH_PAYLOAD_ON}
#define LORA_IQ_INVERSION_ON                        ${LORA_IQ_INVERSION_ON}

#elif (( USE_MODEM_LORA == 0 ) && ( USE_MODEM_FSK == 1 ))

#define FSK_FDEV                                    ${FSK_FDEV}     /* Hz */
#define FSK_DATARATE                                ${FSK_DATARATE}     /* bps */
#define FSK_BANDWIDTH                               ${FSK_BANDWIDTH}     /* Hz */
#define FSK_PREAMBLE_LENGTH                         ${FSK_PREAMBLE_LENGTH}         /* Same for Tx and Rx */
#define FSK_FIX_LENGTH_PAYLOAD_ON                   ${FSK_FIX_LENGTH_PAYLOAD_ON}

#else
#error "Please define a modem in the compiler subghz_phy_app.h."
#endif /* USE_MODEM_LORA | USE_MODEM_FSK */
[/#if]

#define PAYLOAD_LEN                                 ${PAYLOAD_LEN}
[/#if][#--  SUBGHZ_APPLICATION  --]

[#if THREADX??]
/* USER CODE BEGIN THREADX_EC */
/*
 * THREADs configuration defines: stack size and priorities
 * of the different Azure RTOS threads used by the RF application.
 */
#define CFG_APP_SUBGHZ_THREAD_STACK_SIZE                   1024
#define CFG_APP_SUBGHZ_THREAD_PRIO                         10
#define CFG_APP_SUBGHZ_THREAD_PREEMPTION_THRESHOLD         CFG_APP_SUBGHZ_THREAD_PRIO

[#if (SUBGHZ_APPLICATION == "SUBGHZ_AT_SLAVE")]
#define CFG_VCOM_THREAD_STACK_SIZE                       1024
#define CFG_VCOM_THREAD_PRIO                             CFG_APP_SUBGHZ_THREAD_PRIO
#define CFG_VCOM_THREAD_PREEMPTION_THRESHOLD             CFG_APP_SUBGHZ_THREAD_PRIO

[/#if]
[#if (SUBGHZ_APPLICATION == "SUBGHZ_AT_SLAVE")]
#define CFG_AT_THREAD_STACK_SIZE                         1536
#define CFG_AT_THREAD_PRIO                               CFG_APP_SUBGHZ_THREAD_PRIO
#define CFG_AT_THREAD_PREEMPTION_THRESHOLD               CFG_APP_SUBGHZ_THREAD_PRIO

[/#if]
/* USER CODE END THREADX_EC */

[#elseif FREERTOS??][#-- If FreeRtos is used --]
/* USER CODE BEGIN FREERTOS_EC */
#define CFG_VCOM_PROCESS_NAME                      "VCOM_PROCESS"
#define CFG_VCOM_PROCESS_ATTR_BITS                 (0)
#define CFG_VCOM_PROCESS_CB_MEM                    (0)
#define CFG_VCOM_PROCESS_CB_SIZE                   (0)
#define CFG_VCOM_PROCESS_STACK_MEM                 (0)
#define CFG_VCOM_PROCESS_PRIORITY                  osPriorityNone
#define CFG_VCOM_PROCESS_STACK_SIZE                1024

/* USER CODE END FREERTOS_EC */

[/#if]
/* USER CODE BEGIN EC */
[#if (FILL_UCS == "true")]
[#if (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_SWITCH_MODULATION")]
#define LORA_FREQUENCY                              868500000 /* Hz */
#define LORA_BANDWIDTH                              0         /* [0: 125 kHz, 1: 250 kHz, 2: 500 kHz, 3: Reserved] */
#define LORA_SPREADING_FACTOR                       7         /* [SF7..SF12] */
#define LORA_CODINGRATE                             1         /* [1: 4/5, 2: 4/6, 3: 4/7, 4: 4/8] */
#define LORA_PREAMBLE_LENGTH                        8         /* Same for Tx and Rx */
#define LORA_SYMBOL_TIMEOUT                         5         /* Symbols */
#define LORA_FIX_LENGTH_PAYLOAD_ON                  false
#define LORA_IQ_INVERSION_ON                        false

#define FSK_FREQUENCY                               869100000 /* Hz */
#define FSK_FDEV                                    25000     /* Hz */
#define FSK_DATARATE                                50000     /* bps */
#define FSK_BANDWIDTH                               125000    /* Hz */
#define FSK_PREAMBLE_LENGTH                         5         /* Same for Tx and Rx */
#define FSK_FIX_LENGTH_PAYLOAD_ON                   false

#define LRFHSS_FREQUENCY                            868000000 /* Hz */
[/#if][#--  INTERNAL_USER_SUBGHZ_APP --]
[/#if][#--  FILL_UCS --]

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macros -----------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/**
  * @brief  Init Subghz Application
  */
void SubghzApp_Init(void);

[#if THREADX??]
/**
  * @brief  Function implementing the Sigfox Main Thread thread.
  * @param  thread_input: Not used
  * @retval None
  */
void App_Main_Thread_Entry(unsigned long thread_input);
[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__SUBGHZ_PHY_APP_H__*/
