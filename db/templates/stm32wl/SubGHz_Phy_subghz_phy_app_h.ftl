[#ftl]
/**
  ******************************************************************************
  * @file    subghz_phy_app.h
  * @author  MCD Application Team
  * @brief   Header of application of the SubGHz_Phy Middleware
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
[#--
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
                ${definition.name}: ${definition.value}
        [/#list]
    [/#if]
[/#list]
--]

[#assign SUBGHZ_APPLICATION = ""]
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
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "SUBGHZ_APPLICATION"]
                [#assign SUBGHZ_APPLICATION = definition.value]
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
        [/#list]
    [/#if]
[/#list]
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
/* MODEM type: one shall be 1 the other shall be 0 */
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION")]
[#if (MODEM_USED == "USE_MODEM_FSK")]
#define USE_MODEM_LORA  0
#define USE_MODEM_FSK   1
[#else]
#define USE_MODEM_LORA  1
#define USE_MODEM_FSK   0
[/#if]

#define ${REGION}

#if defined( REGION_AS923 )

#define RF_FREQUENCY                                923000000 /* Hz */
#elif defined( REGION_AU915 )

#define RF_FREQUENCY                                915000000 /* Hz */

#elif defined( REGION_CN470 )

#define RF_FREQUENCY                                470000000 /* Hz */

#elif defined( REGION_CN779 )

#define RF_FREQUENCY                                779000000 /* Hz */

#elif defined( REGION_EU433 )

#define RF_FREQUENCY                                433000000 /* Hz */

#elif defined( REGION_EU868 )

#define RF_FREQUENCY                                868000000 /* Hz */

#elif defined( REGION_KR920 )

#define RF_FREQUENCY                                920000000 /* Hz */

#elif defined( REGION_IN865 )

#define RF_FREQUENCY                                865000000 /* Hz */

#elif defined( REGION_US915 )

#define RF_FREQUENCY                                915000000 /* Hz */

#elif defined( REGION_RU864 )

#define RF_FREQUENCY                                864000000 /* Hz */

#else
#error "Please define a frequency band in the compiler options."
#endif /* REGION_XXxxx */

#define TX_OUTPUT_POWER                             14        /* dBm */

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
#define FSK_AFC_BANDWIDTH                           83333     /* Hz */
#define FSK_PREAMBLE_LENGTH                         ${FSK_PREAMBLE_LENGTH}         /* Same for Tx and Rx */
#define FSK_FIX_LENGTH_PAYLOAD_ON                   ${FSK_FIX_LENGTH_PAYLOAD_ON}

#else
#error "Please define a modem in the compiler subghz_phy_app.h."
#endif /* USE_MODEM_LORA | USE_MODEM_FSK */

#define RX_TIMEOUT_VALUE                            2000
#define TX_TIMEOUT_VALUE                            3000
#define BUFFER_SIZE                                 64  /* Define the payload size here */
#define LED_PERIOD_MS                               200

#define TCXO_WORKAROUND_TIME_MARGIN                 50  /* 50ms margin */

[/#if]
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */


/* Exported functions prototypes ---------------------------------------------*/
/**
  * @brief  Init Subghz Application
  * @param None
  * @retval None
  */
void SubghzApp_Init(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__SUBGHZ_PHY_APP_H__*/

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
