[#ftl]
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
[#assign SUBGHZ_APPLICATION = ""]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "SUBGHZ_APPLICATION"]
                [#assign SUBGHZ_APPLICATION = definition.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]
/**
  ******************************************************************************
[#if ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION"))]
  * @file    lora_app_version.h
[#elseif ((SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION")) ]
  * @file    sgfx_app_version.h
[#else]
  * @file    app_version.h
[/#if]
  * @author  MCD Application Team
[#if (CPUCORE == "")]
  * @brief   Definition the version of the application
[#else]
  * @brief   Definition the version of the ${CPUCORE} application
[/#if]
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __APP_VERSION_H__
#define __APP_VERSION_H__

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
#define __APP_VERSION_MAIN   (0x01U) /*!< [31:24] main version */
#define __APP_VERSION_SUB1   (0x00U) /*!< [23:16] sub1 version */
#define __APP_VERSION_SUB2   (0x00U) /*!< [15:8]  sub2 version */
#define __APP_VERSION_RC     (0x00U) /*!< [7:0]  release candidate */

#define __APP_VERSION_MAIN_SHIFT 24  /*!< main byte shift */
#define __APP_VERSION_SUB1_SHIFT 16  /*!< sub1 byte shift */
#define __APP_VERSION_SUB2_SHIFT 8   /*!< sub2 byte shift */
#define __APP_VERSION_RC_SHIFT   0   /*!< release candidate byte shift */

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macros -----------------------------------------------------------*/
/**
  * @brief Application version
  */
#define __APP_VERSION         ((__APP_VERSION_MAIN  << __APP_VERSION_MAIN_SHIFT)\
                               |(__APP_VERSION_SUB1 << __APP_VERSION_SUB1_SHIFT)\
                               |(__APP_VERSION_SUB2 << __APP_VERSION_SUB2_SHIFT)\
                               |(__APP_VERSION_RC   << __APP_VERSION_RC_SHIFT))

[#if ((SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION")) ]
    [#if (CPUCORE == "")]
/**
  * @brief Sigfox application version
  */
#define __SGFX_APP_VERSION            __APP_VERSION
    [#elseif (CPUCORE == "CM4")]
/**
  * @brief Sigfox CM4 application version
  */
#define __CM4_APP_VERSION             __APP_VERSION

/**
  * @brief Sigfox CM0PLUS minimum required version
  */
#define __LAST_COMPATIBLE_CM0_RELEASE __APP_VERSION
    [#else]
/**
  * @brief Sigfox CM0PLUS application version
  */
#define __CM0_APP_VERSION             __APP_VERSION
    [/#if]
[#elseif ((SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION"))]
    [#if (CPUCORE == "")]
/**
  * @brief LoRaWAN application version
  */
#define __LORA_APP_VERSION            __APP_VERSION
    [#elseif (CPUCORE == "CM4")]
/**
  * @brief LoRaWAN CM4 application version
  */
#define __CM4_APP_VERSION             __APP_VERSION

/**
  * @brief LoRaWAN CM0PLUS minimum required version
  */
#define __LAST_COMPATIBLE_CM0_RELEASE __APP_VERSION
    [#else]
/**
  * @brief LoRaWAN CM0PLUS application version
  */
#define __CM0_APP_VERSION             __APP_VERSION
    [/#if]
[#elseif (SUBGHZ_APPLICATION == "SUBGHZ_PINGPONG") || (SUBGHZ_APPLICATION == "SUBGHZ_USER_APPLICATION")]
    [#if (CPUCORE == "CM4")]
/**
  * @brief Subghz_Phy CM4 application version
  */
#define __CM4_APP_VERSION             __APP_VERSION

/**
  * @brief Subghz_Phy CM0PLUS minimum required version
  */
#define __LAST_COMPATIBLE_CM0_RELEASE __APP_VERSION
    [#elseif (CPUCORE == "CM0PLUS")]
/**
  * @brief LoRaWAN CM0PLUS application version
  */
#define __CM0_APP_VERSION             __APP_VERSION
    [/#if]
[/#if]

/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__APP_VERSION_H__*/

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
