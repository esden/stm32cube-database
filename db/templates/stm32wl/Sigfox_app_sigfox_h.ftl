[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_sigfox.h
  * @author  MCD Application Team
  * @brief   Header of application of the Sigfox Middleware
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
[#assign ipNameList = configs[0].peripheralParams?keys]
[#assign useKMS = ipNameList?seq_contains("KMS")]
[#assign SIGFOX_KMS = "0"]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "SUBGHZ_APPLICATION"]
                    [#assign SUBGHZ_APPLICATION = definition.value]
                [/#if]
                [#if definition.name == "SIGFOX_KMS"]
                    [#if definition.value == "true"]
                        [#assign SIGFOX_KMS = "1"]
                    [/#if]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __APP_SIGFOX_H__
#define __APP_SIGFOX_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if THREADX??]
#include <stdint.h>
[/#if]
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if (CPUCORE == "CM0PLUS")]
[#if useKMS]

/* To configure Sigfox to use the KMS Middleware, following files in the DualCore example project must be completed:
   - CM0PLUS/Core/Inc/kms_platf_objects_config.h : Add all Sigfox keys as kms_object_keyhead_32_t structures.
   - CM0PLUS/Core/Inc/kms_platf_objects_interface.h : Add all Sigfox key indexes
   - CM0PLUS/Core/Inc/nvms_low_level.h : Enable the NVMS (Non Volatile Memory) to store the session keys
   - CM0PLUS/Core/Src/nvms_low_level.c : Implement the Flash read/write functions to manage the NVMS items
   Then SIGFOX_KMS flag can be set to 1 */
#define SIGFOX_KMS ${SIGFOX_KMS}

[/#if]
[#elseif (CPUCORE == "CM4")]
#define DEFAULT_RC SFX_RC1
[/#if]
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported Functions Prototypes ---------------------------------------------*/
/**
  * @brief  Init Sigfox Application
  */
[#if !THREADX??][#-- If AzRtos is not used --]
void MX_Sigfox_Init(void);
[#else]
uint32_t MX_Sigfox_Init(void *memory_ptr);
[/#if]

[#if !FREERTOS??][#-- If FreeRtos, only available in CM4 is not used --]
[#if !THREADX??][#-- If AzRtos is not used --]
/**
  * @brief  entry Sigfox Process or scheduling
  */
void MX_Sigfox_Process(void);
[/#if]
[/#if]

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__APP_SIGFOX_H__*/
