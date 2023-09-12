[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/**
  ******************************************************************************
  * @file    mbmuxif_sys.h
  * @author  MCD Application Team
  * @brief   API for ${CPUCORE} applic to handle the SYSTEM MBMUX channel
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MBMUXIF_SYS_${CPUCORE}_H__
#define __MBMUXIF_SYS_${CPUCORE}_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if CPUCORE == "CM4"]
#include "main.h"
[/#if]
#include "mbmux.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if CPUCORE == "CM4"]
[#if FREERTOS??][#-- If FreeRtos is used --]
/* -- FreeRTOS tasks configuration -- */
[#if SUBGHZ_APPLICATION?contains("LORA")]
/*Mailbox Lora*/
#define CFG_MB_LORA_PROCESS_NAME                  "MB_LORA_PROCESS"
#define CFG_MB_LORA_PROCESS_ATTR_BITS             (0)
#define CFG_MB_LORA_PROCESS_CB_MEM                (0)
#define CFG_MB_LORA_PROCESS_CB_SIZE               (0)
#define CFG_MB_LORA_PROCESS_STACK_MEM             (0)
#define CFG_MB_LORA_PROCESS_PRIORITY              osPriorityNone
#define CFG_MB_LORA_PROCESS_STACk_SIZE            (128 * 10)
[/#if]

[#if SUBGHZ_APPLICATION?contains("SIGFOX")]
/*Mailbox Sigfox*/
#define CFG_MB_SIGFOX_PROCESS_NAME                  "MB_SIGFOX_PROCESS"
#define CFG_MB_SIGFOX_PROCESS_ATTR_BITS             (0)
#define CFG_MB_SIGFOX_PROCESS_CB_MEM                (0)
#define CFG_MB_SIGFOX_PROCESS_CB_SIZE               (0)
#define CFG_MB_SIGFOX_PROCESS_STACK_MEM             (0)
#define CFG_MB_SIGFOX_PROCESS_PRIORITY              osPriorityNone
#define CFG_MB_SIGFOX_PROCESS_STACk_SIZE            (128 * 10)
[/#if]

/*Mailbox Radio*/
#define CFG_MB_RADIO_PROCESS_NAME                  "MB_RADIO_PROCESS"
#define CFG_MB_RADIO_PROCESS_ATTR_BITS             (0)
#define CFG_MB_RADIO_PROCESS_CB_MEM                (0)
#define CFG_MB_RADIO_PROCESS_CB_SIZE               (0)
#define CFG_MB_RADIO_PROCESS_STACK_MEM             (0)
#define CFG_MB_RADIO_PROCESS_PRIORITY              osPriorityNone
#define CFG_MB_RADIO_PROCESS_STACk_SIZE            (128 * 10)

/*Mailbox Sys*/
#define CFG_MB_SYS_PROCESS_NAME                  "MB_SYS_PROCESS"
#define CFG_MB_SYS_PROCESS_ATTR_BITS             (0)
#define CFG_MB_SYS_PROCESS_CB_MEM                (0)
#define CFG_MB_SYS_PROCESS_CB_SIZE               (0)
#define CFG_MB_SYS_PROCESS_STACK_MEM             (0)
#define CFG_MB_SYS_PROCESS_PRIORITY              osPriorityNone
#define CFG_MB_SYS_PROCESS_STACk_SIZE            (128 * 10)

/*Mailbox Kms*/
#define CFG_MB_KMS_PROCESS_NAME                  "MB_KMS_PROCESS"
#define CFG_MB_KMS_PROCESS_ATTR_BITS             (0)
#define CFG_MB_KMS_PROCESS_CB_MEM                (0)
#define CFG_MB_KMS_PROCESS_CB_SIZE               (0)
#define CFG_MB_KMS_PROCESS_STACK_MEM             (0)
#define CFG_MB_KMS_PROCESS_PRIORITY              osPriorityNone
#define CFG_MB_KMS_PROCESS_STACk_SIZE            (128 * 10)

[#if SUBGHZ_APPLICATION?contains("LORA")]
/*Send*/
#define CFG_APP_LORA_PROCESS_NAME                  "LORA_SEND_PROCESS"
#define CFG_APP_LORA_PROCESS_ATTR_BITS             (0)
#define CFG_APP_LORA_PROCESS_CB_MEM                (0)
#define CFG_APP_LORA_PROCESS_CB_SIZE               (0)
#define CFG_APP_LORA_PROCESS_STACK_MEM             (0)
#define CFG_APP_LORA_PROCESS_PRIORITY              osPriorityNone
#define CFG_APP_LORA_PROCESS_STACk_SIZE            (128 * 10)

[/#if]
[#if SUBGHZ_APPLICATION?contains("SIGFOX")]
/*Send*/
#define CFG_APP_SIGFOX_PROCESS_NAME                  "SIGFOX_SEND_PROCESS"
#define CFG_APP_SIGFOX_PROCESS_ATTR_BITS             (0)
#define CFG_APP_SIGFOX_PROCESS_CB_MEM                (0)
#define CFG_APP_SIGFOX_PROCESS_CB_SIZE               (0)
#define CFG_APP_SIGFOX_PROCESS_STACK_MEM             (0)
#define CFG_APP_SIGFOX_PROCESS_PRIORITY              osPriorityNone
#define CFG_APP_SIGFOX_PROCESS_STACk_SIZE            (128 * 10)

[/#if]
[/#if]
[/#if]

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions ------------------------------------------------------- */
int8_t MBMUXIF_SystemInit(void);
[#if CPUCORE == "CM4"]
MBMUX_ComParam_t *MBMUXIF_GetSystemFeatureCmdComPtr(FEAT_INFO_IdTypeDef SystemPrioFeat);
int8_t MBMUXIF_SystemPrio_Add(FEAT_INFO_IdTypeDef SystemPrioFeat);
void MBMUXIF_SetCpusSynchroFlag(uint16_t flag);
void MBMUXIF_WaitCm0MbmuxIsInitialised(void);
void MBMUXIF_SystemAllowSequencerForSysCmd(void);
void MBMUXIF_SystemSendCmd(FEAT_INFO_IdTypeDef SystemPrioFeat);
void MBMUXIF_SystemSendAck(FEAT_INFO_IdTypeDef SystemPrioFeat);
[#else]
uint16_t MBMUXIF_GetCpusSynchroFlag(void);
MBMUX_ComParam_t *MBMUXIF_GetSystemFeatureNotifComPtr(FEAT_INFO_IdTypeDef SystemPrioFeat);
void MBMUXIF_SystemSendNotif(FEAT_INFO_IdTypeDef SystemPrioFeat);
void MBMUXIF_SystemSendNotif_NoWait(FEAT_INFO_IdTypeDef SystemPrioFeat);
void MBMUXIF_SystemSendResp(FEAT_INFO_IdTypeDef SystemPrioFeat);
[/#if]

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Exported services --------------------------------------------------------*/
[#if CPUCORE == "CM4"]
FEAT_INFO_List_t *MBMUXIF_SystemSendCm0plusInfoListReq(void);
FEAT_INFO_Param_t *MBMUXIF_SystemGetFeatCapabInfoPtr(FEAT_INFO_IdTypeDef e_featID);
int8_t MBMUXIF_SystemSendCm0plusRegistrationCmd(FEAT_INFO_IdTypeDef e_featID);
[#else]
int16_t MBMUXIF_ChipRevId(void);
[/#if]

/* USER CODE BEGIN ExpoS */

/* USER CODE END ExpoS */

#ifdef __cplusplus
}
#endif

#endif /*__MBMUXIF_SYS_${CPUCORE}_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
