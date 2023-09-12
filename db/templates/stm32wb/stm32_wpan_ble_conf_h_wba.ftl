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

[#assign BLE_TRANSPARENT_MODE_UART = 0]
[#assign CUSTOM_P2P_CLIENT = 0]
[#assign CUSTOM_P2P_ROUTER = 0]
[#assign CUSTOM_TEMPLATE = 0]
[#assign FREERTOS_STATUS = 0]

[#assign BLE_CFG_PERIPHERAL = 0]
[#assign BLE_CFG_CENTRAL = 0]
[#assign BLE_CFG_SVC_MAX_NBR_CB = 0]
[#assign BLE_CFG_CLT_MAX_NBR_CB = 0]
[#assign BLE_CFG_DIS_MANUFACTURER_NAME_STRING = ""]
[#assign BLE_CFG_DIS_MODEL_NUMBER_STRING = ""]
[#assign BLE_CFG_DIS_SERIAL_NUMBER_STRING = ""]
[#assign BLE_CFG_DIS_HARDWARE_REVISION_STRING = ""]
[#assign BLE_CFG_DIS_FIRMWARE_REVISION_STRING = ""]
[#assign BLE_CFG_DIS_SOFTWARE_REVISION_STRING = ""]
[#assign BLE_CFG_DIS_SYSTEM_ID = ""]
[#assign BLE_CFG_DIS_IEEE_CERTIFICATION = ""]
[#assign BLE_CFG_DIS_PNP_ID = ""]

[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
            [#if (definition.name == "BLE_TRANSPARENT_MODE_UART") && (definition.value == "Enabled")]
                [#assign BLE_TRANSPARENT_MODE_UART = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_P2P_CLIENT") && (definition.value == "Enabled")]
                [#assign CUSTOM_P2P_CLIENT = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_P2P_ROUTER") && (definition.value == "Enabled")]
                [#assign CUSTOM_P2P_ROUTER = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_TEMPLATE") && (definition.value == "Enabled")]
                [#assign CUSTOM_TEMPLATE = 1]
            [/#if]
            [#if definition.name == "BLE_APPLICATION_TYPE"]
                [#assign BLE_APPLICATION_TYPE = definition.value]
            [/#if]
            [#if (definition.name == "FREERTOS_STATUS") && (definition.value == "1")]
                [#assign FREERTOS_STATUS = 1]
            [/#if]
            [#if (definition.name == "BLE_CFG_PERIPHERAL") && (definition.value == "1")]
                [#assign BLE_CFG_PERIPHERAL = 1]
            [/#if]
            [#if (definition.name == "BLE_CFG_CENTRAL") && (definition.value == "1")]
                [#assign BLE_CFG_CENTRAL = 1]
            [/#if]
            [#if (definition.name == "BLE_CFG_SVC_MAX_NBR_CB") && (definition.value == "1")]
                [#assign BLE_CFG_SVC_MAX_NBR_CB = definition.value]
            [/#if]
            [#if (definition.name == "BLE_CFG_CLT_MAX_NBR_CB") && (definition.value == "1")]
                [#assign BLE_CFG_CLT_MAX_NBR_CB = definition.value]
            [/#if]
            [#if (definition.name == "BLE_CFG_DIS_MANUFACTURER_NAME_STRING")]
                [#assign BLE_CFG_DIS_MANUFACTURER_NAME_STRING = definition.value]
            [/#if]
            [#if (definition.name == "BLE_CFG_DIS_MODEL_NUMBER_STRING")]
                [#assign BLE_CFG_DIS_MODEL_NUMBER_STRING = definition.value]
            [/#if]
            [#if (definition.name == "BLE_CFG_DIS_SERIAL_NUMBER_STRING")]
                [#assign BLE_CFG_DIS_SERIAL_NUMBER_STRING = definition.value]
            [/#if]
            [#if (definition.name == "BLE_CFG_DIS_HARDWARE_REVISION_STRING")]
                [#assign BLE_CFG_DIS_HARDWARE_REVISION_STRING = definition.value]
            [/#if]
            [#if (definition.name == "BLE_CFG_DIS_FIRMWARE_REVISION_STRING")]
                [#assign BLE_CFG_DIS_FIRMWARE_REVISION_STRING = definition.value]
            [/#if]
            [#if (definition.name == "BLE_CFG_DIS_SOFTWARE_REVISION_STRING")]
                [#assign BLE_CFG_DIS_SOFTWARE_REVISION_STRING = definition.value]
            [/#if]
            [#if (definition.name == "BLE_CFG_DIS_SYSTEM_ID")]
                [#assign BLE_CFG_DIS_SYSTEM_ID = definition.value]
            [/#if]
            [#if (definition.name == "BLE_CFG_DIS_IEEE_CERTIFICATION")]
                [#assign BLE_CFG_DIS_IEEE_CERTIFICATION = definition.value]
            [/#if]
            [#if (definition.name == "BLE_CFG_DIS_PNP_ID")]
                [#assign BLE_CFG_DIS_PNP_ID = definition.value]
            [/#if]
		[/#list]
	[/#if]
[/#list]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef BLE_CONF_H
#define BLE_CONF_H

#include "app_conf.h"

/******************************************************************************
 *
 * BLE SERVICES CONFIGURATION
 * blesvc
 *
 ******************************************************************************/

/**
 * This setting shall be set to '1' if the device needs to support the Peripheral Role
 * In the MS configuration, both BLE_CFG_PERIPHERAL and BLE_CFG_CENTRAL shall be set to '1'
 */
#define BLE_CFG_PERIPHERAL                                                     ${BLE_CFG_PERIPHERAL}

/**
 * This setting shall be set to '1' if the device needs to support the Central Role
 * In the MS configuration, both BLE_CFG_PERIPHERAL and BLE_CFG_CENTRAL shall be set to '1'
 */
#define BLE_CFG_CENTRAL                                                        ${BLE_CFG_CENTRAL}

/**
 * There is one handler per service enabled
 * Note: There is no handler for the Device Information Service
 *
 * This shall take into account all registered handlers
 * (from either the provided services or the custom services)
 */
#define BLE_CFG_SVC_MAX_NBR_CB                                                 ${BLE_CFG_SVC_MAX_NBR_CB}
#define BLE_CFG_CLT_MAX_NBR_CB                                                 ${BLE_CFG_CLT_MAX_NBR_CB}

[#if (BLE_TRANSPARENT_MODE_UART = 1)]
/******************************************************************************
 * Device Information Service (DIS)
 ******************************************************************************/
/**< Options: Supported(1) or Not Supported(0) */
#define BLE_CFG_DIS_MANUFACTURER_NAME_STRING                                   ${BLE_CFG_DIS_MANUFACTURER_NAME_STRING}
#define BLE_CFG_DIS_MODEL_NUMBER_STRING                                        ${BLE_CFG_DIS_MODEL_NUMBER_STRING}
#define BLE_CFG_DIS_SERIAL_NUMBER_STRING                                       ${BLE_CFG_DIS_SERIAL_NUMBER_STRING}
#define BLE_CFG_DIS_HARDWARE_REVISION_STRING                                   ${BLE_CFG_DIS_HARDWARE_REVISION_STRING}
#define BLE_CFG_DIS_FIRMWARE_REVISION_STRING                                   ${BLE_CFG_DIS_FIRMWARE_REVISION_STRING}
#define BLE_CFG_DIS_SOFTWARE_REVISION_STRING                                   ${BLE_CFG_DIS_SOFTWARE_REVISION_STRING}
#define BLE_CFG_DIS_SYSTEM_ID                                                  ${BLE_CFG_DIS_SYSTEM_ID}
#define BLE_CFG_DIS_IEEE_CERTIFICATION                                         ${BLE_CFG_DIS_IEEE_CERTIFICATION}
#define BLE_CFG_DIS_PNP_ID                                                     ${BLE_CFG_DIS_PNP_ID}

/**
 * device information service characteristic lengths
 */
#define BLE_CFG_DIS_SYSTEM_ID_LEN_MAX                                          (8)
#define BLE_CFG_DIS_MODEL_NUMBER_STRING_LEN_MAX                                (32)
#define BLE_CFG_DIS_SERIAL_NUMBER_STRING_LEN_MAX                               (32)
#define BLE_CFG_DIS_FIRMWARE_REVISION_STRING_LEN_MAX                           (32)
#define BLE_CFG_DIS_HARDWARE_REVISION_STRING_LEN_MAX                           (32)
#define BLE_CFG_DIS_SOFTWARE_REVISION_STRING_LEN_MAX                           (32)
#define BLE_CFG_DIS_MANUFACTURER_NAME_STRING_LEN_MAX                           (32)
#define BLE_CFG_DIS_IEEE_CERTIFICATION_LEN_MAX                                 (32)
#define BLE_CFG_DIS_PNP_ID_LEN_MAX                                             (7)

[/#if]

/******************************************************************************
 * GAP Service - Appearance
 ******************************************************************************/

#define BLE_CFG_UNKNOWN_APPEARANCE                  (0)
#define BLE_CFG_HR_SENSOR_APPEARANCE                (832)
#define BLE_CFG_GAP_APPEARANCE                      (BLE_CFG_UNKNOWN_APPEARANCE)

#endif /*BLE_CONF_H */