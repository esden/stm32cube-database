[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    sys_conf.h
  * @author  MCD Application Team
  * @brief   Applicative configuration, e.g. : debug, trace, low power, sensors
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
[#assign VERBOSE_LEVEL = ""]
[#assign APP_LOG_ENABLED = "0"]
[#assign SENSOR_ENABLED = "0"]
[#assign DEBUGGER_ON = "0"]
[#assign DEBUG_SUBGHZSPI_MONITORING = "0"]
[#assign DEBUG_RF_NRESET = "0"]
[#assign DEBUG_RF_HSE32RDY = "0"]
[#assign DEBUG_RF_SMPSRDY = "0"]
[#assign DEBUG_RF_LDORDY = "0"]
[#assign DEBUG_RF_DTB1 = "0"]
[#assign DEBUG_RF_BUSY = "0"]
[#assign LOW_POWER_DISABLE = "0"]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "SUBGHZ_APPLICATION"]
                    [#assign SUBGHZ_APPLICATION = definition.value]
                [/#if]
                [#if definition.name == "DEBUGGER_ON"]
                    [#if definition.value == "true"]
                        [#assign DEBUGGER_ON = "1"]
                    [/#if]
                [/#if]
                [#if definition.name == "DEBUG_SUBGHZSPI_MONITORING"]
                    [#if definition.value == "true"]
                        [#assign DEBUG_SUBGHZSPI_MONITORING = "1"]
                    [/#if]
                [/#if]
                [#if definition.name == "DEBUG_RF_NRESET"]
                    [#if definition.value == "true"]
                        [#assign DEBUG_RF_NRESET = "1"]
                    [/#if]
                [/#if]
                [#if definition.name == "DEBUG_RF_HSE32RDY"]
                    [#if definition.value == "true"]
                        [#assign DEBUG_RF_HSE32RDY = "1"]
                    [/#if]
                [/#if]
                [#if definition.name == "DEBUG_RF_SMPSRDY"]
                    [#if definition.value == "true"]
                        [#assign DEBUG_RF_SMPSRDY = "1"]
                    [/#if]
                [/#if]
                [#if definition.name == "DEBUG_RF_LDORDY"]
                    [#if definition.value == "true"]
                        [#assign DEBUG_RF_LDORDY = "1"]
                    [/#if]
                [/#if]
                [#if definition.name == "DEBUG_RF_DTB1"]
                    [#if definition.value == "true"]
                        [#assign DEBUG_RF_DTB1 = "1"]
                    [/#if]
                [/#if]
                [#if definition.name == "DEBUG_RF_BUSY"]
                    [#if definition.value == "true"]
                        [#assign DEBUG_RF_BUSY = "1"]
                    [/#if]
                [/#if]
                [#if (CPUCORE == "")]
                    [#if definition.name == "VERBOSE_LEVEL"]
                        [#assign VERBOSE_LEVEL = definition.value]
                    [/#if]
                    [#if definition.name == "APP_LOG_ENABLED"]
                        [#if definition.value == "true"]
                            [#assign APP_LOG_ENABLED = "1"]
                        [/#if]
                    [/#if]
                    [#if definition.name == "SENSOR_ENABLED"]
                        [#if definition.value == "true"]
                            [#assign SENSOR_ENABLED = "1"]
                        [/#if]
                    [/#if]
                    [#if definition.name == "LOW_POWER_DISABLE"]
                        [#if definition.value == "true"]
                            [#assign LOW_POWER_DISABLE = "1"]
                        [/#if]
                    [/#if]
                [#elseif (CPUCORE == "CM0PLUS")]
                    [#if definition.name == "VERBOSE_LEVEL_CM0PLUS"]
                        [#assign VERBOSE_LEVEL = definition.value]
                    [/#if]
                    [#if definition.name == "APP_LOG_ENABLED_CM0PLUS"]
                        [#if definition.value == "true"]
                            [#assign APP_LOG_ENABLED = "1"]
                        [/#if]
                    [/#if]
                    [#if definition.name == "LOW_POWER_DISABLE_CM0PLUS"]
                        [#if definition.value == "true"]
                            [#assign LOW_POWER_DISABLE = "1"]
                        [/#if]
                    [/#if]
                [#elseif (CPUCORE == "CM4")]
                    [#if definition.name == "VERBOSE_LEVEL_CM4"]
                        [#assign VERBOSE_LEVEL = definition.value]
                    [/#if]
                    [#if definition.name == "APP_LOG_ENABLED_CM4"]
                        [#if definition.value == "true"]
                            [#assign APP_LOG_ENABLED = "1"]
                        [/#if]
                    [/#if]
                    [#if definition.name == "SENSOR_ENABLED_CM4"]
                        [#if definition.value == "true"]
                            [#assign SENSOR_ENABLED = "1"]
                        [/#if]
                    [/#if]
                    [#if definition.name == "LOW_POWER_DISABLE_CM4"]
                        [#if definition.value == "true"]
                            [#assign LOW_POWER_DISABLE = "1"]
                        [/#if]
                    [/#if]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __SYS_CONF_H__
#define __SYS_CONF_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION")]
[#if CPUCORE == "CM0PLUS"]
#include "sgfx_eeprom_if.h"
[/#if]
[/#if]
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/

[#if ((SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") || (SUBGHZ_APPLICATION == "LORA_END_NODE"))]
[#if CPUCORE != "CM0PLUS"]
/**
  * @brief Temperature and pressure values are retrieved from sensors shield
  *        (instead of sending dummy values). It requires MEMS IKS shield
  */
#define SENSOR_ENABLED                       ${SENSOR_ENABLED}
[/#if]
[/#if]

/**
  * @brief ${CPUCORE} Verbose level for all trace logs
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") && (CPUCORE == "CM4")]
  * @note In AT_SLAVE usart speed is just 9600. VLEVEL_H will not work
[/#if]
  */
#define VERBOSE_LEVEL                        ${VERBOSE_LEVEL}

/**
  * @brief Enable trace logs
  */
#define APP_LOG_ENABLED                      ${APP_LOG_ENABLED}

/**
  * @brief Activate monitoring (probes) of some internal RF signals for debug purpose
  */
#define DEBUG_SUBGHZSPI_MONITORING_ENABLED   ${DEBUG_SUBGHZSPI_MONITORING}

#define DEBUG_RF_NRESET_ENABLED_ENABLED      ${DEBUG_RF_NRESET}

#define DEBUG_RF_HSE32RDY_ENABLED_ENABLED    ${DEBUG_RF_HSE32RDY}

#define DEBUG_RF_SMPSRDY_ENABLED             ${DEBUG_RF_SMPSRDY}

#define DEBUG_RF_LDORDY_ENABLED              ${DEBUG_RF_LDORDY}

#define DEBUG_RF_DTB1_ENABLED                ${DEBUG_RF_DTB1}

#define DEBUG_RF_BUSY_ENABLED                ${DEBUG_RF_BUSY}

[#if CPUCORE != "CM0PLUS"]
/**
  * @brief Enable/Disable MCU Debugger pins (dbg serial wires)
  * @note  by HW serial wires are ON by default, need to put them OFF to save power
  */
#define DEBUGGER_ENABLED                     ${DEBUGGER_ON}

[/#if]
/**
  * @brief Disable Low Power mode
  * @note  0: LowPowerMode enabled. MCU enters stop2 mode, 1: LowPowerMode disabled. MCU enters sleep mode only
  */
#define LOW_POWER_DISABLE                    ${LOW_POWER_DISABLE}

[#if (SECURE_PROJECTS == "1") && (CPUCORE == "CM0PLUS") ]
/**
  * @brief Enable unprivilege mode
  * @note 1: execute the code in unprivileged mode, 0: execute the code fully in privileged mode
  */
#define SECURE_UNPRIVILEGE_ENABLE            1

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

#ifdef __cplusplus
}
#endif

#endif /* __SYS_CONF_H__ */
