[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    lorawan_conf.h
  * @author  MCD Application Team
  * @brief   Header for LoRaWAN middleware instances
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
[#assign LORAMAC_SPECIFICATION_VERSION = "0x01000300"]
[#assign REGION = ""]
[#assign HYBRID_ENABLED = "0"]
[#assign KEY_EXTRACTABLE = "0"]
[#assign CONTEXT_MANAGEMENT_ENABLED = "0"]
[#assign LORAMAC_CLASSB_ENABLED = "0"]
[#assign LORAWAN_DATA_DISTRIB_MGT = "0"]
[#assign LORAWAN_PACKAGES_VERSION = ""]
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
[#assign REGION_AS923_DEFAULT_CHANNEL_PLAN = ""]
[#assign SUBGHZ_APPLICATION = ""]
[#assign ipNameList = configs[0].peripheralParams?keys]
[#assign useKMS = ipNameList?seq_contains("KMS")]
[#assign LORAWAN_KMS = "0"]
[#assign INTERNAL_LORAWAN_FUOTA = "0"]
[#assign SECURE_PROJECTS = "0"]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "LORAMAC_SPECIFICATION_VERSION"]
                    [#assign LORAMAC_SPECIFICATION_VERSION = definition.value]
                [/#if]
                [#if definition.name == "REGION"]
                    [#assign REGION = definition.value]
                [/#if]
                [#if definition.name == "HYBRID_ENABLED"]
                    [#if definition.value == "true"]
                        [#assign HYBRID_ENABLED = "1"]
                    [/#if]
                [/#if]
                [#if definition.name == "LORAWAN_KMS"]
                    [#if definition.value == "true"]
                        [#assign LORAWAN_KMS = "1"]
                    [/#if]
                [/#if]
                [#if definition.name == "KEY_EXTRACTABLE"]
                    [#if definition.value == "true"]
                        [#assign KEY_EXTRACTABLE = "1"]
                    [/#if]
                [/#if]
                [#if definition.name == "CONTEXT_MANAGEMENT_ENABLED"]
                    [#if definition.value == "true"]
                        [#assign CONTEXT_MANAGEMENT_ENABLED = "1"]
                    [/#if]
                [/#if]
                [#if definition.name == "LORAMAC_CLASSB_ENABLED"]
                    [#if definition.value == "true"]
                        [#assign LORAMAC_CLASSB_ENABLED = "1"]
                    [/#if]
                [/#if]
                [#if definition.name == "LORAWAN_DATA_DISTRIB_MGT"]
                    [#if definition.value == "true"]
                        [#assign LORAWAN_DATA_DISTRIB_MGT = "1"]
                    [/#if]
                [/#if]
                [#if definition.name == "LORAWAN_PACKAGES_VERSION"]
                    [#assign LORAWAN_PACKAGES_VERSION = definition.value]
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
                [#if definition.name == "REGION_AS923_DEFAULT_CHANNEL_PLAN"]
                    [#assign REGION_AS923_DEFAULT_CHANNEL_PLAN = definition.value]
                [/#if]
                [#if definition.name == "SUBGHZ_APPLICATION"]
                    [#assign SUBGHZ_APPLICATION = definition.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __LORAWAN_CONF_H__
#define __LORAWAN_CONF_H__

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
[#if CPUCORE != "CM4"]
#if defined(__ICCARM__)
#define SOFT_SE_PLACE_IN_NVM_START _Pragma(" default_variable_attributes = @ \".USER_embedded_Keys\"")
#elif defined(__CC_ARM)
#define SOFT_SE_PLACE_IN_NVM_START _Pragma("  arm section rodata = \".USER_embedded_Keys\"")
#elif defined(__GNUC__)
#define SOFT_SE_PLACE_IN_NVM_START __attribute__((section(".USER_embedded_Keys")))
#endif /* __ICCARM__ | __CC_ARM | __GNUC__ */

/* Stop placing data in specified section*/
#if defined(__ICCARM__)
#define SOFT_SE_PLACE_IN_NVM_STOP _Pragma("default_variable_attributes =")
#elif defined(__CC_ARM)
#define SOFT_SE_PLACE_IN_NVM_STOP _Pragma("arm section code")
#endif /* __ICCARM__ | __CC_ARM | __GNUC__ */

/*!
 * @brief LoRaWAN version definition
 * @note  possible values:
 *        - 0x01000300: Link Layer(L2) v1.0.3 + Regional Parameters(RP) v1.0.3
 *        - 0x01000400: Link Layer TS001-1.0.4 + Regional Parameters RP002-1.0.1
 *        - 0x01010100: soon available ...
 */
#define LORAMAC_SPECIFICATION_VERSION                   ${LORAMAC_SPECIFICATION_VERSION}

[#if (CPUCORE == "CM0PLUS") || (INTERNAL_LORAWAN_FUOTA == "1")]
[#if (useKMS)]
/*!
 * @brief LoRaWAN Keys integrated in KMS Middleware
[#if ((INTERNAL_LORAWAN_FUOTA == "0") && (SECURE_PROJECTS == "0"))]
 * @note  To configure LoRaWAN to use the KMS Middleware, following files in the DualCore example project must be completed:
 *  - CM0PLUS/Core/Inc/kms_platf_objects_config.h : Add all LoRaWAN keys as kms_object_keyhead_32_t structures.
 *  - CM0PLUS/Core/Inc/kms_platf_objects_interface.h : Add all LoRaWAN key indexes
 *  - CM0PLUS/Core/Inc/nvms_low_level.h : Enable the NVMS (Non Volatile Memory) to store the session keys
 *  - CM0PLUS/Core/Src/nvms_low_level.c : Implement the Flash read/write functions to manage the NVMS items
 *  Then LORAWAN_KMS flag can be set to 1
[/#if]
 */
#define LORAWAN_KMS                                     ${LORAWAN_KMS}
[/#if]

[/#if]
/*!
 * @brief Enable the additional LoRaWAN packages
 * @note  LoRaWAN Packages available when enabled:
 *  - Application Layer Clock Synchronization (Package ID: 1, Default Port: 202)
 *  - Remote Multicast Setup (Package ID: 2, Default Port: 200)
 *  - Fragmented Data Block Transport (Package ID: 3, Default Port: 201)
 *  - Firmware Management Protocol (Package ID: 4, Default Port: 203)
 *  The Certification Protocol is also defined as a mandatory package (Package ID: 0, Default Port: 224)
 */
#define LORAWAN_DATA_DISTRIB_MGT                        ${LORAWAN_DATA_DISTRIB_MGT}

/*!
 * @brief LoRaWAN packages version
 * @note  When LORAWAN_DATA_DISTRIB_MGT is enabled, 2 possibles values:
 *        - 1: v1.0.0 packages including:
 *             - Application Layer Clock Synchronization v1.0.0
 *             - Remote Multicast Setup v1.0.0
 *             - Fragmented Data Block Transport v1.0.0
 *        - 2: v2.0.0 packages including:
 *             - Application Layer Clock Synchronization v2.0.0
 *             - Remote Multicast Setup v2.0.0
 *             - Fragmented Data Block Transport v2.0.0
 *             - Firmware Management Protocol v1.0.0
 */
#define LORAWAN_PACKAGES_VERSION                        ${LORAWAN_PACKAGES_VERSION}

/* Region ------------------------------------*/
[#if CPUCORE == ""][#-- single core --]
/* the region listed here will be linked in the MW code */
/* the application (on sys_conf.h) shall just configure one region at the time */
[#else][#-- CM0PLUS --]
/* the region listed here will be linked in the CM0 MW code */
/* the application (on CM4/sys_conf.h) shall just configure one region at the time */
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

/*!
 * @brief Default channel plan for region AS923
 * @note  Possible selections:
 *        - CHANNEL_PLAN_GROUP_AS923_1    (Default configuration. Freq offset = 0.0 MHz / Freq range = 915-928MHz)
 *        - CHANNEL_PLAN_GROUP_AS923_2    (Freq offset = -1.80 MHz / Freq range = 915-928MHz)
 *        - CHANNEL_PLAN_GROUP_AS923_3    (Freq offset = -6.60 MHz / Freq range = 915-928MHz)
 *        - CHANNEL_PLAN_GROUP_AS923_4    (Freq offset = -5.90 MHz / Freq range = 917-920MHz)
 *        - CHANNEL_PLAN_GROUP_AS923_1_JP (Freq offset = 0.0 MHz   / Freq range = 920.6-923.4MHz)
 */
#define REGION_AS923_DEFAULT_CHANNEL_PLAN              ${REGION_AS923_DEFAULT_CHANNEL_PLAN}

/*!
 * @brief Limits the number usable channels by default for AU915, CN470 and US915 regions
 * @note  the default channel mask with this option activates the first 8 channels. \
 *        this default mask can be modified in the RegionXXXXXInitDefaults function associated with the active region.
 */
#define HYBRID_ENABLED                                  ${HYBRID_ENABLED}

/*!
 * @brief Define the read access of the keys in memory
 * @note  this value should be disabled after the development process
 */
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
#define KEY_EXTRACTABLE                                 ${KEY_EXTRACTABLE}
[#else]
/* USER CODE BEGIN KEY_EXTRACTABLE */
#define KEY_EXTRACTABLE                                 0
/* USER CODE END KEY_EXTRACTABLE */
[/#if]

/*!
 * @brief Enables/Disables the context storage management storage
 * @note  Must be enabled for LoRaWAN 1.0.4 or later.
 */
#define CONTEXT_MANAGEMENT_ENABLED                      ${CONTEXT_MANAGEMENT_ENABLED}

/* Class B ------------------------------------*/
/*!
 * @brief Enables/Disables the LoRaWAN Class B (Periodic ping downlink slots + Beacon for synchronization)
 */
#define LORAMAC_CLASSB_ENABLED                          ${LORAMAC_CLASSB_ENABLED}

#if ( LORAMAC_CLASSB_ENABLED == 1 )
/* CLASS B LSE crystal calibration*/
/*!
 * @brief Temperature coefficient of the clock source
 */
#define RTC_TEMP_COEFFICIENT                            ( -0.035 )

/*!
 * @brief Temperature coefficient deviation of the clock source
 */
#define RTC_TEMP_DEV_COEFFICIENT                        ( 0.0035 )

/*!
 * @brief Turnover temperature of the clock source
 */
#define RTC_TEMP_TURNOVER                               ( 25.0 )

/*!
 * @brief Turnover temperature deviation of the clock source
 */
#define RTC_TEMP_DEV_TURNOVER                           ( 5.0 )
#endif /* LORAMAC_CLASSB_ENABLED == 1 */

/*!
 * @brief Disable the ClassA receive windows after Tx (after the Join Accept if OTAA mode defined)
 * @note  Behavior to reduce power consumption but not compliant with LoRa Alliance recommendations.
 *        All device parameters (Spreading Factor, channels selection, Tx Power, ...) should be fixed
 *        and the adaptive datarate should be disabled.
 * @warning This limitation may have consequences for the proper functioning of the device,
 *          if the LoRaMac ever generates MAC commands that require a response.
 */
#define DISABLE_LORAWAN_RX_WINDOW                       0

[/#if][#--  CPUCORE != "CM4" --]
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

[/#if][#--  CPUCORE != "CM4" --]
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __LORAWAN_CONF_H__ */
