[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ble_conf.h
  * @author  MCD Application Team
  * @brief   Configuration file for BLE Middleware.
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef BLE_CONF_H
#define BLE_CONF_H

#include "app_conf.h"

/******************************************************************************
 *
 * Service Controller configuration
 *
 ******************************************************************************/

/**
 * There is one handler per BLE service
 * Note: There is no handler for the Device Information Service
 */
#define BLE_CFG_SVC_MAX_NBR_CB                    (${myHash["BLE_CFG_SVC_MAX_NBR_CB"]})
#define BLE_CFG_CLT_MAX_NBR_CB                    (${myHash["BLE_CFG_CLT_MAX_NBR_CB"]})

/* USER CODE BEGIN ble_conf_1 */

/* USER CODE END ble_conf_1 */

#endif /*BLE_CONF_H */
