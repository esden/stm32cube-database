[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    radio_conf.h
  * @author  MCD Application Team
  * @brief   Header of Radio configuration
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
[#assign INTERNAL_USER_SUBGHZ_APP = ""]
[#assign FILL_UCS = ""]
[#assign Activate_DEBUG_LINE = "false"]
[#assign RF_WAKEUP_TIME="0"]
[#assign SECURE_PROJECTS = "0"]
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
                [#if definition.name == "Activate_DEBUG_LINE"]
                    [#assign Activate_DEBUG_LINE = definition.value]
                [/#if]
                [#if definition.name == "RF_WAKEUP_TIME"]
                    [#assign RF_WAKEUP_TIME = definition.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]
[#assign PROBE_LINE = {"1": "0", "2": "0", "3": "0", "4": "0"}]
[#if BspIpDatas??]
    [#list BspIpDatas as SWIP]
        [#if SWIP.variables??]
            [#list SWIP.variables as variables]
                [#if variables.name?contains("IpInstance")]
                    [#assign IpInstance = variables.value]
                [/#if]
                [#if variables.name?contains("IpName")]
                    [#assign IpName = variables.value]
                [/#if]
                [#-- User BSP Debug --]
                [#if variables.value?contains("Debug ") ]
                    [#assign i = (variables.value?substring((variables.value?last_index_of(" ") + 1) ,variables.value?length))]
                    [#assign PROBE_LINE = PROBE_LINE + {i: "1"}]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __RADIO_CONF_H__
#define __RADIO_CONF_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "platform.h"
[#if HALCompliant??]
#include "main.h"
[#else]
#include "subghz.h"
[/#if]
#include "stm32_mem.h"       /* RADIO_MEMSET8 def in this file */
[#if (SECURE_PROJECTS == "1")]
#include "stm32_seq.h"
[/#if]
#include "mw_log_conf.h"     /* mw trace conf */
#include "radio_board_if.h"  /* low layer api (bsp) */
#include "utilities_def.h"  /* low layer api (bsp) */
[#if CPUCORE == "CM0PLUS"]
#include "mbmuxif_sys.h"
[/#if]
[#if ((SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION"))]
#include "sys_debug.h"
[/#if]
/* USER CODE BEGIN include */

/* USER CODE END include */

/* Exported types ------------------------------------------------------------*/
[#if HALCompliant??]
extern SUBGHZ_HandleTypeDef hsubghz;
[/#if]
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if CPUCORE == "CM0PLUS"]
/**
  * @brief Max payload buffer size
  */
#define RADIO_RX_BUF_SIZE          255

/**
  * @brief Get the chip revision ID from Mbmux table
  */
#define LL_DBGMCU_GetRevisionID() MBMUXIF_ChipRevId()

[/#if]

/**
  * @brief drive value used anytime radio is NOT in TX low power mode
  * @note override the default configuration of radio_driver.c
  */
#define SMPS_DRIVE_SETTING_DEFAULT  SMPS_DRV_40

/**
  * @brief drive value used anytime radio is in TX low power mode
  *        TX low power mode is the worst case because the PA sinks from SMPS
  *        while in high power mode, current is sunk directly from the battery
  * @note override the default configuration of radio_driver.c
  */
#define SMPS_DRIVE_SETTING_MAX      SMPS_DRV_60

/**
  * @brief Provides the frequency of the chip running on the radio and the frequency step
  * @remark These defines are used for computing the frequency divider to set the RF frequency
  * @note override the default configuration of radio_driver.c
  */
#define XTAL_FREQ                   ( 32000000UL )

/**
  * @brief in XO mode, set internal capacitor (from 0x00 to 0x2F starting 11.2pF with 0.47pF steps)
  * @note override the default configuration of radio_driver.c
  */
#define XTAL_DEFAULT_CAP_VALUE      ( 0x20UL )

/**
  * @brief voltage of vdd tcxo.
  * @note override the default configuration of radio_driver.c
  */
#define TCXO_CTRL_VOLTAGE           TCXO_CTRL_1_7V

/**
  * @brief Radio maximum wakeup time (in ms)
  * @note override the default configuration of radio_driver.c
  */
#define RF_WAKEUP_TIME              ( ${RF_WAKEUP_TIME}UL )

/**
  * @brief DCDC is enabled
  * @remark this define is only used if the DCDC is present on the board
  * @note override the default configuration of radio_driver.c
  */
#define DCDC_ENABLE                 ( 1UL )

[#if (SECURE_PROJECTS == "1")]
#define RADIO_IRQ_PROCESS_INIT()   do{ UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_RadioIrq_Process), UTIL_SEQ_RFU, RadioIrqProcess); \
                                       UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_RadioRxTimeout_Process), UTIL_SEQ_RFU, RadioOnRxTimeoutProcess);\
                                       UTIL_SEQ_RegTask((1 << CFG_SEQ_Task_RadioTxTimeout_Process), UTIL_SEQ_RFU, RadioOnTxTimeoutProcess);} while(0)

#define RADIO_IRQ_PROCESS()        do{ UTIL_SEQ_SetTask(1 << CFG_SEQ_Task_RadioIrq_Process, CFG_SEQ_Prio_0); } while(0)
#define RADIO_RX_TIMEOUT_PROCESS() do{ UTIL_SEQ_SetTask(1 << CFG_SEQ_Task_RadioRxTimeout_Process, CFG_SEQ_Prio_0); } while(0)
#define RADIO_TX_TIMEOUT_PROCESS() do{ UTIL_SEQ_SetTask(1 << CFG_SEQ_Task_RadioTxTimeout_Process, CFG_SEQ_Prio_0); } while(0)

[/#if]
/* USER CODE BEGIN EC */
[#if  (FILL_UCS == "true")]
[#if (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (INTERNAL_USER_SUBGHZ_APP == "SUBGHZ_PER")]
/**
  * @brief enables the RFW module
  * @note disabled by default
  */
#define RFW_ENABLE 1

/**
  * @brief enables the RFW long packet feature
  * @note disabled by default
  */
#define RFW_LONGPACKET_ENABLE 1

/**
  * @brief enables the RFW module log
  * @note disabled by default
  */
#define RFW_MW_LOG_ENABLE

[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION")]
/**
  * @brief disable the Sigfox radio modulation
  * @note enabled by default
  */
#define RADIO_SIGFOX_ENABLE 0

/**
  * @brief disable the radio generic features
  * @note enabled by default
  */
#define RADIO_GENERIC_CONFIG_ENABLE 0

[#elseif (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
/**
  * @brief disable the Sigfox radio modulation
  * @note enabled by default
  */
#define RADIO_SIGFOX_ENABLE 0

/**
  * @brief disable the radio generic features
  * @note enabled by default
  */
#define RADIO_GENERIC_CONFIG_ENABLE 1

[/#if]
[#if ((Activate_DEBUG_LINE == "false") || (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION") || (SUBGHZ_APPLICATION == "SUBGHZ_USER_APPLICATION") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION"))]
#define DBG_GPIO_RADIO_RX(set_rst) /*PROBE_GPIO_##set_rst##_LINE(PROBE_LINE1_PORT, PROBE_LINE1_PIN);*/
#define DBG_GPIO_RADIO_TX(set_rst) /*PROBE_GPIO_##set_rst##_LINE(PROBE_LINE2_PORT, PROBE_LINE2_PIN);*/
[#else]
/**
  * @brief Set RX pin to high or low level
  */
[#if PROBE_LINE["1"] == "1"]
#define DBG_GPIO_RADIO_RX(set_rst) PROBE_GPIO_##set_rst##_LINE(PROBE_LINE1_PORT, PROBE_LINE1_PIN);
[#else]
#define DBG_GPIO_RADIO_RX(set_rst) /*PROBE_GPIO_##set_rst##_LINE(PROBE_LINE1_PORT, PROBE_LINE1_PIN);*/
[/#if]

/**
  * @brief Set TX pin to high or low level
  */
[#if PROBE_LINE["2"] == "1"]
#define DBG_GPIO_RADIO_TX(set_rst) PROBE_GPIO_##set_rst##_LINE(PROBE_LINE2_PORT, PROBE_LINE2_PIN);
[#else]
#define DBG_GPIO_RADIO_TX(set_rst) /*PROBE_GPIO_##set_rst##_LINE(PROBE_LINE2_PORT, PROBE_LINE2_PIN);*/
[/#if]
[/#if]
[/#if]

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macros -----------------------------------------------------------*/
#ifndef CRITICAL_SECTION_BEGIN
/**
  * @brief macro used to enter the critical section
  */
#define CRITICAL_SECTION_BEGIN( )      UTILS_ENTER_CRITICAL_SECTION( )
#endif /* !CRITICAL_SECTION_BEGIN */
#ifndef CRITICAL_SECTION_END
/**
  * @brief macro used to exit the critical section
  */
#define CRITICAL_SECTION_END( )        UTILS_EXIT_CRITICAL_SECTION( )
#endif /* !CRITICAL_SECTION_END */

/* Function mapping */
/**
  * @brief SUBGHZ interface init to radio Middleware
  */
#define RADIO_INIT                              MX_SUBGHZ_Init

/**
  * @brief Delay interface to radio Middleware
  */
#define RADIO_DELAY_MS                          HAL_Delay

/**
  * @brief Memset utilities interface to radio Middleware
  */
#define RADIO_MEMSET8( dest, value, size )      UTIL_MEM_set_8( dest, value, size )

/**
  * @brief Memcpy utilities interface to radio Middleware
  */
#define RADIO_MEMCPY8( dest, src, size )        UTIL_MEM_cpy_8( dest, src, size )

/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __RADIO_CONF_H__*/
