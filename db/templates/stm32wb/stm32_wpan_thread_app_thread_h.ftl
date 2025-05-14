[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
 * File Name          : ${name}
  * Description        : Header for Thread Application.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
 */
/* USER CODE END Header */
[#assign THREAD_APPLICATION = 0]
[#assign FREERTOS_STATUS = 0]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
            [#if (definition.name == "THREAD_APPLICATION") ]
                [#assign THREAD_APPLICATION = definition.value]
            [/#if]
			[#if (definition.name == "FREERTOS_STATUS")  && (definition.value == "1")]
                [#assign FREERTOS_STATUS = 1]
            [/#if]
		[/#list]
	[/#if]
[/#list]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef APP_THREAD_H
#define APP_THREAD_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
/* Private includes ----------------------------------------------------------*/
#include "tl.h"
#include "stm32wbxx_core_interface_def.h"
#include "tl_thread_hci.h"

/* OpenThread Library */
#include OPENTHREAD_CONFIG_FILE

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/

/* Thread application generic defines */
/*------------------------------------*/
typedef enum
{
  APP_THREAD_LIMITED,
  APP_THREAD_FULL,
} APP_THREAD_InitMode_t;

[#if (THREAD_APPLICATION != "FTD_CLI")]
/* ipv6-addressing defines        */
/*------------------------------------*/
/* Key Point: A major difference between FTDs and MTDs are that FTDs subscribe to the ff03::2 multicast address.
 * MTDs do not. */

#define MULICAST_FTD_MED            "ff03::1"
#define MULICAST_FTD_BORDER_ROUTER  "ff03::2"
[/#if]

/* Application errors                 */
/*------------------------------------*/

/*
 *  List of all errors tracked by the Thread application
 *  running on M4. Some of these errors may be fatal
 *  or just warnings
 */
typedef enum
{
  ERR_REC_MULTI_MSG_FROM_M0,
  ERR_THREAD_SET_STATE_CB,
[#if (THREAD_APPLICATION != "FTD_CLI")]
  ERR_THREAD_SET_CHANNEL,
  ERR_THREAD_SET_PANID,
  ERR_THREAD_IPV6_ENABLE,
  ERR_THREAD_START,
[/#if]
  ERR_THREAD_ERASE_PERSISTENT_INFO,
  ERR_THREAD_SET_NETWORK_KEY,
[#if ((THREAD_APPLICATION = "MTD") && (FREERTOS_STATUS = 1)) ||(THREAD_APPLICATION = "MTD")]
  ERR_THREAD_LINK_MODE,
[/#if]
/* USER CODE BEGIN ERROR_APPLI_ENUM */

/* USER CODE END ERROR_APPLI_ENUM */
  ERR_THREAD_CHECK_WIRELESS
  } ErrAppliIdEnum_t;
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macros ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions ------------------------------------------------------- */
void APP_THREAD_Init( void );
void APP_THREAD_Error(uint32_t ErrId, uint32_t ErrCode);
void APP_THREAD_RegisterCmdBuffer(TL_CmdPacket_t* p_buffer);
void APP_THREAD_ProcessMsgM0ToM4(void);
void APP_THREAD_Init_UART_CLI(void);
void APP_THREAD_TL_THREAD_INIT(void);
/* USER CODE BEGIN EF */

/* USER CODE END EF */

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* APP_THREAD_H */
