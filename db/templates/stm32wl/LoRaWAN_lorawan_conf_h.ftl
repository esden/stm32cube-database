[#ftl]
/**
  ******************************************************************************
  * @file    lorawan_conf.h
  * @author  MCD Application Team
  * @brief   Header for LoRaWAN middleware instances
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2020 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the
  * License. You may obtain a copy of the License at:
  *                        opensource.org/licenses/BSD-3-Clause
  *
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
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
[#assign REGION = ""]
[#assign HYBRID_ENABLED = "0"]
[#assign KEY_LOG_ENABLED = "0"]
[#assign LORAMAC_CLASSB_ENABLED = "0"]
[#assign REGION_AS923 = ""]
[#assign REGION_AU915 = ""]
[#assign REGION_CN470 = ""]
[#assign REGION_CN779 = ""]
[#assign REGION_EU433 = ""]
[#assign REGION_EU868 = ""]
[#assign REGION_KR920 = ""]
[#assign REGION_IN865 = ""]
[#assign REGION_US915 = ""]
[#assign REGION_RU864 = ""]
[#assign SUBGHZ_APPLICATION = ""]
[#assign ipNameList = configs[0].peripheralParams?keys]
[#assign useKMS = ipNameList?seq_contains("KMS")]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "REGION"]
                [#assign REGION = definition.value]
            [/#if]
            [#if definition.name == "HYBRID_ENABLED"]
                [#if definition.value == "true"]
                    [#assign HYBRID_ENABLED = "1"]
                [/#if]
            [/#if]
            [#if definition.name == "KEY_LOG_ENABLED"]
                [#if definition.value == "true"]
                    [#assign KEY_LOG_ENABLED = "1"]
                [/#if]
            [/#if]
            [#if definition.name == "LORAMAC_CLASSB_ENABLED"]
                [#if definition.value == "true"]
                    [#assign LORAMAC_CLASSB_ENABLED = "1"]
                [/#if]
            [/#if]
            [#if definition.name == "REGION_AS923"]
                [#assign REGION_AS923 = definition.value]
            [/#if]
            [#if definition.name == "REGION_AU915"]
                [#assign REGION_AU915 = definition.value]
            [/#if]
            [#if definition.name == "REGION_CN470"]
                [#assign REGION_CN470 = definition.value]
            [/#if]
            [#if definition.name == "REGION_CN779"]
                [#assign REGION_CN779 = definition.value]
            [/#if]
            [#if definition.name == "REGION_EU433"]
                [#assign REGION_EU433 = definition.value]
            [/#if]
            [#if definition.name == "REGION_EU868"]
                [#assign REGION_EU868 = definition.value]
            [/#if]
            [#if definition.name == "REGION_KR920"]
                [#assign REGION_KR920 = definition.value]
            [/#if]
            [#if definition.name == "REGION_IN865"]
                [#assign REGION_IN865 = definition.value]
            [/#if]
            [#if definition.name == "REGION_US915"]
                [#assign REGION_US915 = definition.value]
            [/#if]
            [#if definition.name == "REGION_RU864"]
                [#assign REGION_RU864 = definition.value]
            [/#if]
            [#if definition.name == "SUBGHZ_APPLICATION"]
                [#assign SUBGHZ_APPLICATION = definition.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __LORAWAN_CONF_H__
#define __LORAWAN_CONF_H__

#ifdef __cplusplus
extern "C" {
#endif
/* Includes ------------------------------------------------------------------*/
#include "stm32_systime.h"
[#if CPUCORE != "CM4"]
#include "sys_app.h"   /* needed for APP_PRINTF */
[/#if]
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if CPUCORE != "CM4"]
[#if CPUCORE == "CM0PLUS"]
[#if useKMS]
/* To enable the KMS Middleware with LoRaWAN, you must update these files from the DualCore example project:
   - CM0PLUS/Core/Inc/kms_platf_objects_config.h : Add all LoRaWAN keys as kms_object_keyhead_32_t structures.
   - CM0PLUS/Core/Inc/kms_platf_objects_interface.h : Add all LoRaWAN key indexes
   - CM0PLUS/Core/Inc/nvms_low_level.h : Enable the NVMS (Non Volatile Memory) to store the session keys
   - CM0PLUS/Core/Src/nvms_low_level.c : Implement the Flash read/write functions to manage the NVMS items
   And finally, change the LORAWAN_KMS define to 1
*/
[/#if]
/* USER CODE BEGIN LORAWAN_KMS */
#define LORAWAN_KMS 0
/* USER CODE END LORAWAN_KMS */

#if (!defined (LORAWAN_KMS) || (LORAWAN_KMS == 0))
#else /* LORAWAN_KMS == 1 */
#define OVER_THE_AIR_ACTIVATION 1
#define ACTIVATION_BY_PERSONALISATION 1
#endif
[/#if]

/* Region ------------------------------------*/
[#if CPUCORE == ""]
/* the region listed here will be linked in the MW code */
/* the applic (on sys_conf.h) shall just configure one region at the time */
[#else]
/* the region listed here will be linked in the CM0 MW code */
/* the applic (on CM4/sys_conf.h) shall just configure one region at the time */
[/#if]
[#if REGION_AS923 == "true"]
#define REGION_AS923
[#else]
/*#define REGION_AS923*/
[/#if]
[#if REGION_AU915 == "true"]
#define REGION_AU915
[#else]
/*#define REGION_AU915*/
[/#if]
[#if REGION_CN470 == "true"]
#define REGION_CN470
[#else]
/*#define REGION_CN470*/
[/#if]
[#if REGION_CN779 == "true"]
#define REGION_CN779
[#else]
/*#define REGION_CN779*/
[/#if]
[#if REGION_EU433 == "true"]
#define REGION_EU433
[#else]
/*#define REGION_EU433*/
[/#if]
[#if REGION_EU868 == "true"]
#define REGION_EU868
[#else]
/*#define REGION_EU868*/
[/#if]
[#if REGION_KR920 == "true"]
#define REGION_KR920
[#else]
/*#define REGION_KR920*/
[/#if]
[#if REGION_IN865 == "true"]
#define REGION_IN865
[#else]
/*#define REGION_IN865*/
[/#if]
[#if REGION_US915 == "true"]
#define REGION_US915
[#else]
/*#define REGION_US915*/
[/#if]
[#if REGION_RU864 == "true"]
#define REGION_RU864
[#else]
/*#define REGION_RU864*/
[/#if]

#define HYBRID_ENABLED          ${HYBRID_ENABLED}

[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
#define KEY_LOG_ENABLED         ${KEY_LOG_ENABLED}
[#else]
/* USER CODE BEGIN KEY_LOG_ENABLED */
#define KEY_LOG_ENABLED         0
/* USER CODE END KEY_LOG_ENABLED */
[/#if]

/* Class B ------------------------------------*/
#define LORAMAC_CLASSB_ENABLED  ${LORAMAC_CLASSB_ENABLED}

#if ( LORAMAC_CLASSB_ENABLED == 1 )
/* CLASS B LSE crystall calibration*/
/**
  * \brief Temperature coefficient of the clock source
  */
#define RTC_TEMP_COEFFICIENT                            ( -0.035 )

/**
  * \brief Temperature coefficient deviation of the clock source
  */
#define RTC_TEMP_DEV_COEFFICIENT                        ( 0.0035 )

/**
  * \brief Turnover temperature of the clock source
  */
#define RTC_TEMP_TURNOVER                               ( 25.0 )

/**
  * \brief Turnover temperature deviation of the clock source
  */
#define RTC_TEMP_DEV_TURNOVER                           ( 5.0 )
#endif /* LORAMAC_CLASSB_ENABLED == 1 */

[/#if]
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
[#if CPUCORE != "CM4"]
#ifndef CRITICAL_SECTION_BEGIN
#define CRITICAL_SECTION_BEGIN( )      UTILS_ENTER_CRITICAL_SECTION( )
#endif /* !CRITICAL_SECTION_BEGIN */
#ifndef CRITICAL_SECTION_END
#define CRITICAL_SECTION_END( )        UTILS_EXIT_CRITICAL_SECTION( )
#endif /* !CRITICAL_SECTION_END */

[/#if]
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __LORAWAN_CONF_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
