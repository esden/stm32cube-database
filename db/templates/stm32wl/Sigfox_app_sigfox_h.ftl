[#ftl]
/**
  ******************************************************************************
  * @file    app_sigfox.h
  * @author  MCD Application Team
  * @brief   Header of application of the Sigfox Middleware
   ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
[#assign SUBGHZ_APPLICATION = ""]
[#assign ipNameList = configs[0].peripheralParams?keys]
[#assign useKMS = ipNameList?seq_contains("KMS")]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "SUBGHZ_APPLICATION"]
                [#assign SUBGHZ_APPLICATION = definition.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __APP_SIGFOX_H__
#define __APP_SIGFOX_H__

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
[#if (CPUCORE == "CM0PLUS")]
[#if useKMS]
/* To enable the KMS Middleware with Sigfox, you must update these files from the DualCore example project:
   - CM0PLUS/Core/Inc/kms_platf_objects_config.h : Add all Sigfox keys as kms_object_keyhead_32_t structures.
   - CM0PLUS/Core/Inc/kms_platf_objects_interface.h : Add all Sigfox key indexes
   - CM0PLUS/Core/Inc/nvms_low_level.h : Enable the NVMS (Non Volatile Memory) to store the session keys
   - CM0PLUS/Core/Src/nvms_low_level.c : Implement the Flash read/write functions to manage the NVMS items
   And finally, change the SIGFOX_KMS define to 1
*/
[/#if]
/* USER CODE BEGIN SIGFOX_KMS */
#define SIGFOX_KMS 0
/* USER CODE END SIGFOX_KMS */
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

/* Exported functions prototypes ---------------------------------------------*/
/**
  * @brief  Init Sigfox Application
  * @param None
  * @retval None
  */
void MX_Sigfox_Init(void);

/**
  * @brief  entry Sigfox Process or scheduling
  * @param None
  * @retval None
  */
void MX_Sigfox_Process(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__APP_SIGFOX_H__*/

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
