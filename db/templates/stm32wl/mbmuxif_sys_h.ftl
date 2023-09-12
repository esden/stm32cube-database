[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    mbmuxif_sys.h
  * @author  MCD Application Team
  * @brief   API for ${CPUCORE} application to handle the SYSTEM MBMUX channel
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
#define CFG_MB_LORA_PROCESS_NAME                   "MB_LORA_PROCESS"
#define CFG_MB_LORA_PROCESS_ATTR_BITS              (0)
#define CFG_MB_LORA_PROCESS_CB_MEM                 (0)
#define CFG_MB_LORA_PROCESS_CB_SIZE                (0)
#define CFG_MB_LORA_PROCESS_STACK_MEM              (0)
#define CFG_MB_LORA_PROCESS_PRIORITY               osPriorityNone
#define CFG_MB_LORA_PROCESS_STACK_SIZE             (128 * 10)
[/#if]

[#if SUBGHZ_APPLICATION?contains("SIGFOX")]
/*Mailbox Sigfox*/
#define CFG_MB_SIGFOX_PROCESS_NAME                 "MB_SIGFOX_PROCESS"
#define CFG_MB_SIGFOX_PROCESS_ATTR_BITS            (0)
#define CFG_MB_SIGFOX_PROCESS_CB_MEM               (0)
#define CFG_MB_SIGFOX_PROCESS_CB_SIZE              (0)
#define CFG_MB_SIGFOX_PROCESS_STACK_MEM            (0)
#define CFG_MB_SIGFOX_PROCESS_PRIORITY             osPriorityNone
#define CFG_MB_SIGFOX_PROCESS_STACK_SIZE           (128 * 10)
[/#if]

/*Mailbox Radio*/
#define CFG_MB_RADIO_PROCESS_NAME                  "MB_RADIO_PROCESS"
#define CFG_MB_RADIO_PROCESS_ATTR_BITS             (0)
#define CFG_MB_RADIO_PROCESS_CB_MEM                (0)
#define CFG_MB_RADIO_PROCESS_CB_SIZE               (0)
#define CFG_MB_RADIO_PROCESS_STACK_MEM             (0)
#define CFG_MB_RADIO_PROCESS_PRIORITY              osPriorityNone
#define CFG_MB_RADIO_PROCESS_STACK_SIZE            (128 * 10)

/*Mailbox Sys*/
#define CFG_MB_SYS_PROCESS_NAME                    "MB_SYS_PROCESS"
#define CFG_MB_SYS_PROCESS_ATTR_BITS               (0)
#define CFG_MB_SYS_PROCESS_CB_MEM                  (0)
#define CFG_MB_SYS_PROCESS_CB_SIZE                 (0)
#define CFG_MB_SYS_PROCESS_STACK_MEM               (0)
#define CFG_MB_SYS_PROCESS_PRIORITY                osPriorityNone
#define CFG_MB_SYS_PROCESS_STACK_SIZE              (128 * 10)

/*Mailbox Kms*/
#define CFG_MB_KMS_PROCESS_NAME                    "MB_KMS_PROCESS"
#define CFG_MB_KMS_PROCESS_ATTR_BITS               (0)
#define CFG_MB_KMS_PROCESS_CB_MEM                  (0)
#define CFG_MB_KMS_PROCESS_CB_SIZE                 (0)
#define CFG_MB_KMS_PROCESS_STACK_MEM               (0)
#define CFG_MB_KMS_PROCESS_PRIORITY                osPriorityNone
#define CFG_MB_KMS_PROCESS_STACK_SIZE              (128 * 10)

[#if SUBGHZ_APPLICATION?contains("LORA")]
/*Send*/
#define CFG_APP_LORA_PROCESS_NAME                  "LORA_SEND_PROCESS"
#define CFG_APP_LORA_PROCESS_ATTR_BITS             (0)
#define CFG_APP_LORA_PROCESS_CB_MEM                (0)
#define CFG_APP_LORA_PROCESS_CB_SIZE               (0)
#define CFG_APP_LORA_PROCESS_STACK_MEM             (0)
#define CFG_APP_LORA_PROCESS_PRIORITY              osPriorityNone
#define CFG_APP_LORA_PROCESS_STACK_SIZE            (128 * 10)

/*Store Context*/
#define CFG_APP_LORA_STORE_CONTEXT_NAME            "LORA_STORE_CONTEXT"
#define CFG_APP_LORA_STORE_CONTEXT_ATTR_BITS       (0)
#define CFG_APP_LORA_STORE_CONTEXT_CB_MEM          (0)
#define CFG_APP_LORA_STORE_CONTEXT_CB_SIZE         (0)
#define CFG_APP_LORA_STORE_CONTEXT_STACK_MEM       (0)
#define CFG_APP_LORA_STORE_CONTEXT_PRIORITY        osPriorityNone
#define CFG_APP_LORA_STORE_CONTEXT_STACK_SIZE      (128 * 10)

/*Stop Join*/
#define CFG_APP_LORA_STOP_JOIN_NAME                "LORA_STOP_JOIN"
#define CFG_APP_LORA_STOP_JOIN_ATTR_BITS           (0)
#define CFG_APP_LORA_STOP_JOIN_CB_MEM              (0)
#define CFG_APP_LORA_STOP_JOIN_CB_SIZE             (0)
#define CFG_APP_LORA_STOP_JOIN_STACK_MEM           (0)
#define CFG_APP_LORA_STOP_JOIN_PRIORITY            osPriorityNone
#define CFG_APP_LORA_STOP_JOIN_STACK_SIZE          (128 * 10)

[/#if]
[#if SUBGHZ_APPLICATION?contains("SIGFOX")]
/*Send*/
#define CFG_APP_SIGFOX_PROCESS_NAME                "SIGFOX_SEND_PROCESS"
#define CFG_APP_SIGFOX_PROCESS_ATTR_BITS           (0)
#define CFG_APP_SIGFOX_PROCESS_CB_MEM              (0)
#define CFG_APP_SIGFOX_PROCESS_CB_SIZE             (0)
#define CFG_APP_SIGFOX_PROCESS_STACK_MEM           (0)
#define CFG_APP_SIGFOX_PROCESS_PRIORITY            osPriorityNone
#define CFG_APP_SIGFOX_PROCESS_STACK_SIZE          (128 * 10)

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
/**
  * @brief Inits the MBMUX and registers SYS channel to the mailbox and SYS task to the sequencer
  * @retval   0: OK;
             -1: no more ipcc channel available;
             -2: feature not provided by CM0PLUS;
             -3: callback error on CM0PLUS
[#if THREADX??]
             -10: threadx TX_POOL_ERROR
             -11: threadx TX_THREAD_ERROR
             -12: threadx TX_SEMAPHORE_ERROR
[/#if]
  */
int8_t MBMUXIF_SystemInit(void);

[#if CPUCORE == "CM4"]
/**
  * @brief   gives back the pointer to the com buffer associated to System feature Cmd
  * @param   SystemPrioFeat ID of the feature
  * @retval  return pointer to the com param buffer
  */
MBMUX_ComParam_t *MBMUXIF_GetSystemFeatureCmdComPtr(FEAT_INFO_IdTypeDef SystemPrioFeat);

/**
  * @brief   Registers to the mailbox a SYSTEM feature channel used on higher PRIORITY
  * @param   SystemPrioFeat ID of the feature
  * @retval  0: OK; -1: no more ipcc channel available; -2: feature not provided by CM0PLUS
  */
int8_t MBMUXIF_SystemPrio_Add(FEAT_INFO_IdTypeDef SystemPrioFeat);

/**
  * @brief   Set synchro flag between the two CPUs
  * @param   flag 0xFFFF: hold Cm0 before it runs its MBMUX_Init,
  *               0x5555: Cm0 allowed to run its MBMUX_Init
  *               0xAAAA: Cm0 has completed initialization
  *               0x9999: RTC PRIO CHANNEL has been registered
  */
void MBMUXIF_SetCpusSynchroFlag(uint16_t flag);

/**
  * @brief gives green light to Cm0 to Initialized MBMUX on its side
  */
void MBMUXIF_WaitCm0MbmuxIsInitialized(void);

/**
  * @brief   To allow SystemCmd to use the sequencer (hence entering in low power)
  * @note    For compatibility with RTOS, the sequencer (scheduler) is not used until the main loop process is reached (after Init). The application can call this API at the end of the Init
  */
void MBMUXIF_SystemAllowSequencerForSysCmd(void);

/**
  * @brief   Sends a System-Cmd via Ipcc and Wait for the response
  * @param   SystemPrioFeat ID of the feature
  */
void MBMUXIF_SystemSendCmd(FEAT_INFO_IdTypeDef SystemPrioFeat);

/**
  * @brief   Sends a System-Ack  via Ipcc without waiting for the ack
  * @param   SystemPrioFeat ID of the feature
  */
void MBMUXIF_SystemSendAck(FEAT_INFO_IdTypeDef SystemPrioFeat);
[#else]
/**
  * @brief   Get synchro flag between the two CPUs
  * @return  flag: 0xFFFF: hold Cm0 before it runs its MBMUX_Init,
  *                0x5555: Cm0 allowed to run its MBMUX_Init
  *                0xAAAA: Cm0 has completed initialization
  *                0x9999: RTC PRIO CHANNEL has been registered
  */
uint16_t MBMUXIF_GetCpusSynchroFlag(void);

/**
  * @brief   gives back the pointer to the com buffer associated to System feature Notif
  * @param   SystemPrioFeat ID of the feature
  * @retval  return pointer to the com param buffer
  */
MBMUX_ComParam_t *MBMUXIF_GetSystemFeatureNotifComPtr(FEAT_INFO_IdTypeDef SystemPrioFeat);

/**
  * @brief   Sends a System-Notif via Ipcc and Wait for the ack
  * @param   SystemPrioFeat ID of the feature
  */
void MBMUXIF_SystemSendNotif(FEAT_INFO_IdTypeDef SystemPrioFeat);

/**
  * @brief   Sends a Trace-Notif via Ipcc without waiting for the ack
  * @param   SystemPrioFeat ID of the feature
  */
void MBMUXIF_SystemSendNotif_NoWait(FEAT_INFO_IdTypeDef SystemPrioFeat);

/**
  * @brief   Sends a System-Resp  via Ipcc without waiting for the response
  * @param   SystemPrioFeat ID of the feature
  */
void MBMUXIF_SystemSendResp(FEAT_INFO_IdTypeDef SystemPrioFeat);
[/#if]

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Exported services --------------------------------------------------------*/
[#if CPUCORE == "CM4"]
/**
  * @brief   Gets the pointer to CM0PLUS capabilities info table
  * @retval  pointer to CM0PLUS capabilities info table
  */
FEAT_INFO_List_t *MBMUXIF_SystemSendCm0plusInfoListReq(void);

/**
  * @brief   returns the pointer to the Capability Info table of a given feature
  * @param   e_featID ID of the feature from which retrieve the ptr
  * @retval  LoRaMacInfoTable pointer
  */
FEAT_INFO_Param_t *MBMUXIF_SystemGetFeatCapabInfoPtr(FEAT_INFO_IdTypeDef e_featID);

/**
  * @brief   Asks CM0PLUS to register its Cmd and Ack callbacks relative to the requested feature
  * @param   e_featID ID of the feature (Lora, Sigfox, etc).
  * @retval  0 ok, else error code
  */
int8_t MBMUXIF_SystemSendCm0plusRegistrationCmd(FEAT_INFO_IdTypeDef e_featID);
[#else]
/**
  * @brief   Get the chip revision ID from Mbmux table
  * @retval  Values between Min_Data=0x00 and Max_Data=0xFFFF
  */
int16_t MBMUXIF_ChipRevId(void);
[/#if]

/* USER CODE BEGIN ExpoS */

/* USER CODE END ExpoS */

#ifdef __cplusplus
}
#endif

#endif /*__MBMUXIF_SYS_${CPUCORE}_H__ */
