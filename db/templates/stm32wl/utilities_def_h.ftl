[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    utilities_def.h
  * @author  MCD Application Team
  * @brief   Definitions for modules requiring utilities
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
#ifndef __UTILITIES_DEF_H__
#define __UTILITIES_DEF_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/******************************************************************************
  * LOW POWER MANAGER
  ******************************************************************************/
/**
  * Supported requester to the MCU Low Power Manager - can be increased up  to 32
  * It lists a bit mapping of all user of the Low Power Manager
  */
typedef enum
{
  /* USER CODE BEGIN CFG_LPM_Id_t_0 */

  /* USER CODE END CFG_LPM_Id_t_0 */
[#if ((SUBGHZ_APPLICATION != "LORA_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SUBGHZ_USER_APPLICATION") && (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")) ]
  CFG_LPM_APPLI_Id,
  CFG_LPM_UART_TX_Id,
[#else]
  CFG_LPM_DUMMY_Id,
[/#if]
[#if ((SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")) ]
  CFG_LPM_SGFX_MN_Id,
[/#if]
  /* USER CODE BEGIN CFG_LPM_Id_t */

  /* USER CODE END CFG_LPM_Id_t */
} CFG_LPM_Id_t;
[#if !FREERTOS??][#-- If FreeRtos is not used --]

/*---------------------------------------------------------------------------*/
/*                             sequencer definitions                         */
/*---------------------------------------------------------------------------*/

/**
  * This is the list of priority required by the application
  * Each Id shall be in the range 0..31
  */
typedef enum
{
  CFG_SEQ_Prio_0,
  /* USER CODE BEGIN CFG_SEQ_Prio_Id_t */

  /* USER CODE END CFG_SEQ_Prio_Id_t */
  CFG_SEQ_Prio_NBR,
} CFG_SEQ_Prio_Id_t;


/**
  * This is the list of task id required by the application
  * Each Id shall be in the range 0..31
  */
typedef enum
{
[#if (CPUCORE == "CM0PLUS")]
  /* CM0PLUS */
  CFG_SEQ_Task_MbSystemCmdRcv,
  CFG_SEQ_Task_MbTraceAckRcv,
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION")]
  CFG_SEQ_Task_MbLoRaCmdRcv,
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION") ]
  CFG_SEQ_Task_MbSigfoxCmdRcv,
[/#if]
  CFG_SEQ_Task_MbRadioCmdRcv,
  CFG_SEQ_Task_MbRadioNotifSnd,
[#if ((SUBGHZ_APPLICATION != "SUBGHZ_ADV_APPLICATION")) ]
  CFG_SEQ_Task_MbKmsCmdRcv,
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION")]
  CFG_SEQ_Task_MbLmHandlerProcess,
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION") ]
  CFG_SEQ_Task_MbSigfoxNotifRcv,
  CFG_SEQ_Task_Monarch,
[/#if]
[#if (SECURE_PROJECTS == "1")]
  CFG_SEQ_Task_RadioIrq_Process,
  CFG_SEQ_Task_RadioRxTimeout_Process,
  CFG_SEQ_Task_RadioTxTimeout_Process,
  CFG_SEQ_Task_UtilTimer_Process,
[/#if]
[#elseif (CPUCORE == "CM4")]
  /* CM4 */
  /* USER CODE BEGIN CFG_SEQ_Task_Id_t_0 */

  /* USER CODE END CFG_SEQ_Task_Id_t_0 */
[#if (SUBGHZ_APPLICATION == "SUBGHZ_ADV_APPLICATION")]
  CFG_SEQ_Task_SubGHz_Phy_App_Process,
[/#if]
  CFG_SEQ_Task_MbSystemNotifRcv,
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION")]
  CFG_SEQ_Task_MbLoRaNotifRcv,
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION") ]
  CFG_SEQ_Task_MbSigfoxNotifRcv,
[/#if]
  CFG_SEQ_Task_MbRadioNotifRcv,
[#if (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")]
  CFG_SEQ_Task_Pb,
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") || (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE")]
  CFG_SEQ_Evt_Monarch,
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") ]
  CFG_SEQ_Task_Vcom,
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
  CFG_SEQ_Task_MbVcom,
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_END_NODE")]
  CFG_SEQ_Task_MbLoRaSendOnTxTimerOrButtonEvent,
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "LORA_END_NODE")]
  CFG_SEQ_Task_MbLmHandlerProcess,
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
  CFG_SEQ_Task_LoRaCertifTx,
[/#if]
[#else]
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
  CFG_SEQ_Task_Vcom,
  CFG_SEQ_Task_LmHandlerProcess,
  CFG_SEQ_Task_LoRaCertifTx,
[#elseif (SUBGHZ_APPLICATION == "LORA_END_NODE")]
  CFG_SEQ_Task_LmHandlerProcess,
  CFG_SEQ_Task_LoRaSendOnTxTimerOrButtonEvent,
[#elseif (SUBGHZ_APPLICATION == "SUBGHZ_ADV_APPLICATION")]
  CFG_SEQ_Task_SubGHz_Phy_App_Process,
[#elseif (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") ]
  CFG_SEQ_Task_Vcom,
  CFG_SEQ_Task_Monarch,
[#elseif (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")]
  CFG_SEQ_Task_Pb,
  CFG_SEQ_Task_Monarch,
[/#if]
[/#if]
  /* USER CODE BEGIN CFG_SEQ_Task_Id_t */

  /* USER CODE END CFG_SEQ_Task_Id_t */
  CFG_SEQ_Task_NBR
} CFG_SEQ_Task_Id_t;

[#if ((CPUCORE != "") || (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")) ]
/**
  * This is a bit mapping over 32bits listing all events id supported in the application
  */
typedef enum
{
[#if (CPUCORE == "CM0PLUS")]
  /* CM0PLUS */
  CFG_SEQ_Evt_MbSystemAckRcv,
  CFG_SEQ_Evt_MbTraceAckRcv,
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "LORA_END_NODE")  || (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION")]
  CFG_SEQ_Evt_MbLoraAckRcv,
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION")]
  CFG_SEQ_Evt_MbSigfoxAckRcv,
  CFG_SEQ_Evt_Monarch,
[/#if]
  CFG_SEQ_Evt_MbRadioAckRcv,
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON")]
  CFG_SEQ_Evt_Timeout,
  CFG_SEQ_Evt_TxTimeout,
  CFG_SEQ_Evt_Delay,
[/#if]
[#elseif (CPUCORE == "CM4")]
  /* CM4 */
  CFG_SEQ_Evt_MbSystemRespRcv,
[#if ((SUBGHZ_APPLICATION != "SUBGHZ_ADV_APPLICATION"))]
  CFG_SEQ_Evt_MbKmsRespRcv,
[/#if]
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE") || (SUBGHZ_APPLICATION == "LORA_END_NODE") || (SUBGHZ_APPLICATION == "LORA_USER_APPLICATION")]
  CFG_SEQ_Evt_MbLoRaRespRcv,
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") || (SUBGHZ_APPLICATION == "SIGFOX_USER_APPLICATION")]
  CFG_SEQ_Evt_MbSigfoxRespRcv,
[/#if]
  CFG_SEQ_Evt_MbRadioRespRcv,
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
  CFG_SEQ_Evt_RadioOnTstRF,
[/#if]
[#else]
[#if (SUBGHZ_APPLICATION == "LORA_AT_SLAVE")]
  CFG_SEQ_Evt_RadioOnTstRF,
[/#if]
[#if (SUBGHZ_APPLICATION == "SIGFOX_AT_SLAVE") || (SUBGHZ_APPLICATION == "SIGFOX_PUSHBUTTON") ]
  CFG_SEQ_Evt_Timeout,
  CFG_SEQ_Evt_TxTimeout,
  CFG_SEQ_Evt_Delay,
  CFG_SEQ_Evt_Monarch,
[/#if]
[/#if]
  /* USER CODE BEGIN CFG_SEQ_IdleEvt_Id_t */

  /* USER CODE END CFG_SEQ_IdleEvt_Id_t */
  CFG_SEQ_Evt_NBR
} CFG_SEQ_IdleEvt_Id_t;

[/#if]
[/#if]
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __UTILITIES_DEF_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
