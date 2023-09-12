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
[#assign LORAWAN_KMS = "0"]
[#assign LORAWAN_FUOTA = "0"]
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
 * @note  possible values: 0x01000300 or 0x01000400
 */
#define LORAMAC_SPECIFICATION_VERSION                   ${LORAMAC_SPECIFICATION_VERSION}

[#if (CPUCORE == "CM0PLUS") || (LORAWAN_FUOTA == "1")]
[#if (useKMS) && (LORAWAN_FUOTA == "0")]
/* To enable the KMS Middleware with LoRaWAN, you must update these files from the DualCore example project:
   - CM0PLUS/Core/Inc/kms_platf_objects_config.h : Add all LoRaWAN keys as kms_object_keyhead_32_t structures.
   - CM0PLUS/Core/Inc/kms_platf_objects_interface.h : Add all LoRaWAN key indexes
   - CM0PLUS/Core/Inc/nvms_low_level.h : Enable the NVMS (Non Volatile Memory) to store the session keys
   - CM0PLUS/Core/Src/nvms_low_level.c : Implement the Flash read/write functions to manage the NVMS items
   And finally, change the LORAWAN_KMS define to 1
*/
[/#if]
/* USER CODE BEGIN LORAWAN_KMS */
#define LORAWAN_KMS ${LORAWAN_KMS}
/* USER CODE END LORAWAN_KMS */

#if (!defined (LORAWAN_KMS) || (LORAWAN_KMS == 0))
#else /* LORAWAN_KMS == 1 */
#define OVER_THE_AIR_ACTIVATION 1
#define ACTIVATION_BY_PERSONALIZATION 1
#endif /* LORAWAN_KMS */

[#if (LORAWAN_FUOTA == "1")]
#define LORAWAN_DATA_DISTRIB_MGT   1

[/#if]
[/#if]
/* Region ------------------------------------*/
[#if CPUCORE == ""]
/* the region listed here will be linked in the MW code */
/* the application (on sys_conf.h) shall just configure one region at the time */
[#else]
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

/**
  * \brief Limits the number usable channels by default for AU915, CN470 and US915 regions
  * \note the default channel mask with this option activates the first 8 channels. \
  *       this default mask can be modified in the RegionXXXXXInitDefaults function associated with the active region.
  */
#define HYBRID_ENABLED                                  ${HYBRID_ENABLED}

/**
  * \brief Define the read access of the keys in memory
  * \note this value should be disabled after the development process
  */
[#if (SUBGHZ_APPLICATION != "LORA_USER_APPLICATION")]
#define KEY_EXTRACTABLE                                 ${KEY_EXTRACTABLE}
[#else]
/* USER CODE BEGIN KEY_EXTRACTABLE */
#define KEY_EXTRACTABLE                                 0
/* USER CODE END KEY_EXTRACTABLE */
[/#if]

/*!
 * Enables/Disables the context storage management storage.
 * Must be enabled for LoRaWAN 1.0.4 or later.
 */
#define CONTEXT_MANAGEMENT_ENABLED                      ${CONTEXT_MANAGEMENT_ENABLED}

/* Class B ------------------------------------*/
#define LORAMAC_CLASSB_ENABLED                          ${LORAMAC_CLASSB_ENABLED}

#if ( LORAMAC_CLASSB_ENABLED == 1 )
/* CLASS B LSE crystal calibration*/
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

/**
  * \brief Disable the ClassA receive windows after Tx (after the Join Accept if OTAA mode defined)
  * \note  Behavior to reduce power consumption but not compliant with LoRa Alliance recommendations.
  *        All device parameters (Spreading Factor, channels selection, Tx Power, ...) should be fixed
  *        and the adaptive datarate should be disabled.
  * /warning This limitation may have consequences for the proper functioning of the device,
             if the LoRaMac ever generates MAC commands that require a response.
  */
#define DISABLE_LORAWAN_RX_WINDOW                       0

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
