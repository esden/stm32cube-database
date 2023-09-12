[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name?remove_beginning("App/%")?replace("%_app.h", "_app.h")}
  * @author  MCD Application Team
  * @brief   Header for ${name?remove_beginning("App/%")?replace("%_app.h", "_app.c")}
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign SvcNbr = "0"]
[#assign myHash = {}]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if SvcNbr == "0"]
                [#assign SvcNbr = definition.name?remove_beginning("SERVICE")?remove_ending("_SHORT_NAME")]
            [/#if]
            [#assign myHash = {definition.name:definition.value} + myHash]
        [/#list]
    [/#if]
[/#list]
[#--
Key & Value:
[#list myHash?keys as key]
Key: ${key}; Value: ${myHash[key]}
[/#list]
--]

[#assign SERVICE_SHORT_NAME_UpperCase = myHash["SERVICE"+SvcNbr+"_SHORT_NAME"]?upper_case]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef ${SERVICE_SHORT_NAME_UpperCase}_APP_H
#define ${SERVICE_SHORT_NAME_UpperCase}_APP_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
typedef enum
{
  ${SERVICE_SHORT_NAME_UpperCase}_CONN_HANDLE_EVT,
  ${SERVICE_SHORT_NAME_UpperCase}_DISCON_HANDLE_EVT,

  /* USER CODE BEGIN Service${SvcNbr}_OpcodeNotificationEvt_t */

  /* USER CODE END Service${SvcNbr}_OpcodeNotificationEvt_t */

  ${SERVICE_SHORT_NAME_UpperCase}_LAST_EVT,
} ${SERVICE_SHORT_NAME_UpperCase}_APP_OpcodeNotificationEvt_t;

typedef struct
{
  ${SERVICE_SHORT_NAME_UpperCase}_APP_OpcodeNotificationEvt_t          EvtOpcode;
  uint16_t                                 ConnectionHandle;
} ${SERVICE_SHORT_NAME_UpperCase}_APP_ConnHandleNotEvt_t;
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macros -----------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions ------------------------------------------------------- */
void ${SERVICE_SHORT_NAME_UpperCase}_APP_Init(void);
void ${SERVICE_SHORT_NAME_UpperCase}_APP_EvtRx(${SERVICE_SHORT_NAME_UpperCase}_APP_ConnHandleNotEvt_t *p_Notification);
/* USER CODE BEGIN EF */

/* USER CODE END EF */

#ifdef __cplusplus
}
#endif

#endif /*${SERVICE_SHORT_NAME_UpperCase}_APP_H */
