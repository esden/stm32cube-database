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
            [#if ("${definition.value}"=="valueNotSetted")]
              [#assign myHash = {definition.name:0} + myHash]
            [#else]
              [#assign myHash = {definition.name:definition.value} + myHash]
            [/#if]
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
 * BLE Event Handler configuration
 *
 ******************************************************************************/

/**
 * There is one handler per BLE service
 */
[#if  (myHash["BLE_MODE_PERIPHERAL"] == "Enabled") && (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] != "Enabled")]
#define BLE_CFG_MAX_NBR_GATT_EVT_HANDLERS                       (${myHash["NUMBER_OF_SERVICES"]})
[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled") || (myHash["BLE_MODE_BROADCASTER"] == "Enabled")]
#define BLE_CFG_MAX_NBR_GATT_EVT_HANDLERS                       (${myHash["BLE_CFG_MAX_NBR_GATT_EVT_HANDLERS"]})
[/#if]

/* USER CODE BEGIN ble_conf_1 */

/* USER CODE END ble_conf_1 */

#endif /*BLE_CONF_H */
