[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ble_dbg_conf.h
  * @author  MCD Application Team
  * @brief   Debug configuration file for BLE Middleware.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef BLE_DBG_CONF_H
#define BLE_DBG_CONF_H

/**
 * Enable or Disable traces from BLE
 */

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

#define BLE_DBG_APP_EN             ${myHash["BLE_DBG_APP_EN"]}

/**
 * Macro definition
 */
#if (BLE_DBG_APP_EN != 0)
#define BLE_DBG_APP_MSG             PRINT_MESG_DBG
#else
#define BLE_DBG_APP_MSG             PRINT_NO_MESG
#endif

#endif /*BLE_DBG_CONF_H */
