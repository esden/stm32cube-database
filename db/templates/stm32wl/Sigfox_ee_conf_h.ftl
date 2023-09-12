[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ee_conf.h
  * @author  MCD Application Team
  * @brief   Header for eeprom configuration
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
[#assign SECURE_PROJECTS = "0"]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "SUBGHZ_APPLICATION"]
                    [#assign SUBGHZ_APPLICATION = definition.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __EE_CONF_H__
#define __EE_CONF_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if CPUCORE == "CM0PLUS"]
[#if (SECURE_PROJECTS == "1")]
[#if (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") ]
#if defined(__ARMCC_VERSION)
#include "mapping_sbsfu.h"
#elif defined (__ICCARM__) || defined(__GNUC__)
#include "mapping_export.h"
#endif /* __ARMCC_VERSION */
[/#if]
[/#if]
[/#if]
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if ((SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")) ]
[#if (SECURE_PROJECTS == "1") && (CPUCORE == "CM0PLUS")]
/**
  * @brief Flash address
  */
#define HW_FLASH_ADDRESS                FLASH_BASE

/**
  * @brief Flash page size in bytes
  */
#define HW_FLASH_PAGE_SIZE              FLASH_PAGE_SIZE
[#else]
/**
  * @brief Flash address
  */
#define HW_FLASH_ADDRESS                (0x08000000UL)

/**
  * @brief Flash page size in bytes
  */
#define HW_FLASH_PAGE_SIZE              (0x00000800UL)
[/#if]

/**
  * @brief Flash width in bytes
  */
#define HW_FLASH_WIDTH                  8

/**
  * @brief Flash bank0 size in bytes
  */
#define CFG_EE_BANK0_SIZE               2*HW_FLASH_PAGE_SIZE

/**
  * @brief Maximum number of data that can be stored in bank0
  */
#define CFG_EE_BANK0_MAX_NB             EE_ID_COUNT<<2 /*from uint32 to byte*/

/* Unused Bank1 */
/**
  * @brief Flash bank1 size in bytes
  */
#define CFG_EE_BANK1_SIZE              0

/**
  * @brief Maximum number of data that can be stored in bank1
  */
#define CFG_EE_BANK1_MAX_NB            0

[#if (SECURE_PROJECTS == "1") && (CPUCORE == "CM0PLUS")]
/**
  * @brief EEPROM Flash address
  */
#define EE_BASE_ADRESS                  EE_DATASTORAGE_START
[#else]
/**
  * @brief EEPROM Flash address
  * @note last 2 sector of a 128kBytes device
  */
#define EE_BASE_ADRESS                  (0x0801D000UL)
[/#if]

[/#if][#--  SUBGHZ_APPLICATION == "SIGFOX_XXX" --]

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macros -----------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__EE_CONF_H__ */
