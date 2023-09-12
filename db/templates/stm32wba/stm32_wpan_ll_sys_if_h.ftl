[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ll_sys_if.h
  * @author  MCD Application Team
  * @brief   Header file for initiating system
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign PG_FILL_UCS = "False"]
[#assign PG_BSP_NUCLEO_WBA52CG = 0]
[#assign myHash = {}]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef LL_SYS_IF_H
#define LL_SYS_IF_H

/* Includes ------------------------------------------------------------------*/
[#if myHash["THREADX_STATUS"]?number == 1 ]
#include "tx_api.h"
[/#if]

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
[#if myHash["THREADX_STATUS"]?number == 1 ]
/* LINK_LAYER_TASK related resources */
extern TX_MUTEX LINK_LAYER_Thread_Mutex;

[/#if]
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions ---------------------------------------------*/
/* USER CODE BEGIN EF */

/* USER CODE END EF */

#ifdef __cplusplus
}
#endif

#endif /*LL_SYS_IF_H */
