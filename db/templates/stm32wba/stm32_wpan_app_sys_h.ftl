[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_sys.h
  * @author  MCD Application Team
  * @brief   Header for app_sys.c
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
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
#ifndef APP_SYS_H
#define APP_SYS_H

[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled") || (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")]
#include "main.h"
[/#if]

/* Exported constants --------------------------------------------------------*/

/* The RADIO_DEEPSLEEP_WAKEUP_TIME_US macro allows to define when the system 
 * needs to wake up before "handle next event".
 * This macro is the sum of the durations of standby exit and Link Layer 
 * deep sleep mode exit. 
 */
#define RADIO_DEEPSLEEP_WAKEUP_TIME_US (CFG_LPM_STDBY_WAKEUP_TIME)

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported functions prototypes ---------------------------------------------*/

[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
void APP_SYS_BLE_EnterDeepSleep(void);
[#else]
void APP_SYS_LPM_EnterLowPowerMode(void);
void APP_SYS_LinkLayer_BackgroundProcessInit(void);
[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#endif /* APP_SYS_H */
