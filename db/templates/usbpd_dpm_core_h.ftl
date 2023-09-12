[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    usbpd_dpm_core.h
  * @author  MCD Application Team
  * @brief   Header file for usbpd_dpm_core.c file
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign USBPDCORE_LIB_NO_PD = false]

[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name == "USBPD_CoreLib" && definition.value == "USBPDCORE_LIB_NO_PD"]
                [#assign USBPDCORE_LIB_NO_PD = true]
            [/#if]
        [/#list]
    [/#if]
[/#list]


#ifndef __USBPD_DPM_CORE_H_
#define __USBPD_DPM_CORE_H_

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported typedef ----------------------------------------------------------*/
/* USER CODE BEGIN typedef */

/* USER CODE END typedef */

/* Exported define -----------------------------------------------------------*/

/* USER CODE BEGIN define */

/* USER CODE END define */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN constants */

/* USER CODE END constants */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN macro */

/* USER CODE END macro */

/* Exported variables --------------------------------------------------------*/
extern USBPD_ParamsTypeDef DPM_Params[USBPD_PORT_COUNT];
/* USER CODE BEGIN variables */

/* USER CODE END variables */

/* Exported functions --------------------------------------------------------*/
USBPD_StatusTypeDef USBPD_DPM_InitCore(void);
USBPD_StatusTypeDef USBPD_DPM_InitOS(void);
void USBPD_DPM_Run(void);
[#if !USBPDCORE_LIB_NO_PD]
void                USBPD_DPM_TimerCounter(void);
[/#if]
/* USER CODE BEGIN functions */

/* USER CODE END functions */

#ifdef __cplusplus
}
#endif

#endif /* __USBPD_DPM_CORE_H_ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
