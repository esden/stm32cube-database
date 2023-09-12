[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/**
  ******************************************************************************
  * @file    radio_conf.h
  * @author  MCD Application Team
  * @brief   Header of Radio configuration
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

[#--
********************************
SWIP Datas:
[#if SWIPdatas??]
  [#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
Defines:
      [#list SWIP.defines as definition]
        ${definition.name}: ${definition.value}
      [/#list]
    [/#if]
  [/#list]
[/#if]
********************************
--]
[#assign SUBGHZ_APPLICATION = ""]
[#assign Activate_DEBUG_LINE = ""]
[#list SWIPdatas as SWIP]
  [#if SWIP.defines??]
    [#list SWIP.defines as definition]
            [#if definition.name == "SUBGHZ_APPLICATION"]
                [#assign SUBGHZ_APPLICATION = definition.value]
            [/#if]
            [#if definition.name == "Activate_DEBUG_LINE"]
                [#assign Activate_DEBUG_LINE = definition.value]
            [/#if]
    [/#list]
  [/#if]
[/#list]
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
[#if (CPUCORE != "CM0PLUS") || (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION") || (SUBGHZ_APPLICATION == "SUBGHZ_USER_APPLICATION") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION")]
#include "stm32_mem.h"
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
[#if ((SUBGHZ_APPLICATION == "LORA_USER_APPLICATION") || (SUBGHZ_APPLICATION == "SUBGHZ_USER_APPLICATION") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION") || (Activate_DEBUG_LINE == "false"))]
/* USER CODE BEGIN DBG_GPIO_RADIO */
#define DBG_GPIO_RADIO_RX(set_rst) /*DBG_GPIO_##set_rst##_LINE(DGB_LINE1_PORT, DGB_LINE1_PIN);*/
#define DBG_GPIO_RADIO_TX(set_rst) /*DBG_GPIO_##set_rst##_LINE(DGB_LINE2_PORT, DGB_LINE2_PIN);*/
/* USER CODE END DBG_GPIO_RADIO */
[#else]
/**
  * @brief Set RX pin to high or low level
  */
#define DBG_GPIO_RADIO_RX(set_rst) DBG_GPIO_##set_rst##_LINE(DGB_LINE1_PORT, DGB_LINE1_PIN);

/**
  * @brief Set TX pin to high or low level
  */
#define DBG_GPIO_RADIO_TX(set_rst) DBG_GPIO_##set_rst##_LINE(DGB_LINE2_PORT, DGB_LINE2_PIN);
[/#if]

/**
  * @brief Max payload buffer size
  */
#define RADIO_RX_BUF_SIZE          255

[#if CPUCORE == "CM0PLUS"]
/**
  * @brief Get the chip revision ID from Mbmux table
  */
#define LL_DBGMCU_GetRevisionID() MBMUXIF_ChipRevId()

[/#if]
/**
  * @brief drive value used anytime radio is NOT in TX low power mode
  */
#define SMPS_DRIVE_SETTING_DEFAULT  SMPS_DRV_40

/**
  * @brief drive value used anytime radio is in TX low power mode
  *        TX low power mode is the worst case because the PA sinks from SMPS
  *        while in high power mode, current is sunk directly from the battery
  */
#define SMPS_DRIVE_SETTING_MAX      SMPS_DRV_60

/**
  * @brief in XO mode, set internal capacitor (from 0x00 to 0x2F starting 11.2pF with 0.47pF steps)
  */
#define XTAL_DEFAULT_CAP_VALUE      0x20

/**
  * @brief Frequency error (in Hz) can be compensated here.
  *        warning XO frequency error generates (de)modulator sampling time error which can not be compensated
  */
#define RF_FREQUENCY_ERROR          ((int32_t) 0)

/**
  * @brief voltage of vdd tcxo.
  */
#define TCXO_CTRL_VOLTAGE           TCXO_CTRL_1_7V

/* USER CODE BEGIN EC */

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

/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __RADIO_CONF_H__*/

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
