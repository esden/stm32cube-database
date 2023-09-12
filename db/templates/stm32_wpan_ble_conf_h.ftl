[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name}
  * @author  MCD Application Team
  * @brief   Configuration file for BLE Middleware.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign BLE_TRANSPARENT_MODE_UART = 0]
[#assign BLE_TRANSPARENT_MODE_VCP = 0]
[#assign BT_SIG_BEACON = "0"]
[#assign BT_SIG_BLOOD_PRESSURE_SENSOR = 0]
[#assign BT_SIG_HEALTH_THERMOMETER_SENSOR = 0]
[#assign BT_SIG_HEART_RATE_SENSOR = 0]
[#assign CUSTOM_OTA = 0]
[#assign CUSTOM_P2P_CLIENT = 0]
[#assign CUSTOM_P2P_ROUTER = 0]
[#assign CUSTOM_P2P_SERVER = 0]
[#assign CUSTOM_TEMPLATE = 0]
[#assign FREERTOS_STATUS = 0]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
            [#if (definition.name == "BLE_TRANSPARENT_MODE_UART") && (definition.value == "Enabled")]
                [#assign BLE_TRANSPARENT_MODE_UART = 1]
            [/#if]
            [#if (definition.name == "BLE_TRANSPARENT_MODE_VCP") && (definition.value == "Enabled")]
                [#assign BLE_TRANSPARENT_MODE_VCP = 1]
            [/#if]
            [#if (definition.name == "BT_SIG_BEACON") && (definition.value != "Disabled")]
                [#assign BT_SIG_BEACON = 1]
            [/#if]
            [#if (definition.name == "BT_SIG_BLOOD_PRESSURE_SENSOR") && (definition.value == "Enabled")]
                [#assign BT_SIG_BLOOD_PRESSURE_SENSOR = 1]
            [/#if]
            [#if (definition.name == "BT_SIG_HEALTH_THERMOMETER_SENSOR") && (definition.value == "Enabled")]
                [#assign BT_SIG_HEALTH_THERMOMETER_SENSOR = 1]
            [/#if]
            [#if (definition.name == "BT_SIG_HEART_RATE_SENSOR") && (definition.value == "Enabled")]
                [#assign BT_SIG_HEART_RATE_SENSOR = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_OTA") && (definition.value == "Enabled")]
                [#assign CUSTOM_OTA = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_P2P_CLIENT") && (definition.value == "Enabled")]
                [#assign CUSTOM_P2P_CLIENT = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_P2P_ROUTER") && (definition.value == "Enabled")]
                [#assign CUSTOM_P2P_ROUTER = 1]
            [/#if]
            [#if (definition.name == "CUSTOM_P2P_SERVER") && (definition.value == "Enabled")]
                [#assign CUSTOM_P2P_SERVER = 1]
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
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_PERIPHERAL"]
				[#lt]#define ${definition.name}                                                     ${definition.value}

                [/#if]
		[/#list]
	[/#if]
[/#list]
/**
 * This setting shall be set to '1' if the device needs to support the Central Role
 * In the MS configuration, both BLE_CFG_PERIPHERAL and BLE_CFG_CENTRAL shall be set to '1'
 */
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_CENTRAL"]
				[#lt]#define ${definition.name}                                                        ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]

/**
 * There is one handler per service enabled
 * Note: There is no handler for the Device Information Service
 *
 * This shall take into account all registered handlers
 * (from either the provided services or the custom services)
 */
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_SVC_MAX_NBR_CB"]
				[#lt]#define ${definition.name}                                                 ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]

[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_CLT_MAX_NBR_CB"]
				[#lt]#define ${definition.name}                                                 ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]

[#if (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1) || (BLE_TRANSPARENT_MODE_UART = 1) || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1)]
/******************************************************************************
 * Device Information Service (DIS)
 ******************************************************************************/
/**< Options: Supported(1) or Not Supported(0) */
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_DIS_MANUFACTURER_NAME_STRING"]
				[#lt]#define ${definition.name}                                   ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_DIS_MODEL_NUMBER_STRING"]
				[#lt]#define ${definition.name}                                        ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_DIS_SERIAL_NUMBER_STRING"]
				[#lt]#define ${definition.name}                                       ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_DIS_HARDWARE_REVISION_STRING"]
				[#lt]#define ${definition.name}                                   ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_DIS_FIRMWARE_REVISION_STRING"]
				[#lt]#define ${definition.name}                                   ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_DIS_SOFTWARE_REVISION_STRING"]
				[#lt]#define ${definition.name}                                   ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_DIS_SYSTEM_ID"]
				[#lt]#define ${definition.name}                                                  ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_DIS_IEEE_CERTIFICATION"]
				[#lt]#define ${definition.name}                                         ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_DIS_PNP_ID"]
				[#lt]#define ${definition.name}                                                     ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]

/**
 * device information service characteristic lengths
 */
#define BLE_CFG_DIS_SYSTEM_ID_LEN_MAX                                        (8)
#define BLE_CFG_DIS_MODEL_NUMBER_STRING_LEN_MAX                              (32)
#define BLE_CFG_DIS_SERIAL_NUMBER_STRING_LEN_MAX                             (32)
#define BLE_CFG_DIS_FIRMWARE_REVISION_STRING_LEN_MAX                         (32)
#define BLE_CFG_DIS_HARDWARE_REVISION_STRING_LEN_MAX                         (32)
#define BLE_CFG_DIS_SOFTWARE_REVISION_STRING_LEN_MAX                         (32)
#define BLE_CFG_DIS_MANUFACTURER_NAME_STRING_LEN_MAX                         (32)
#define BLE_CFG_DIS_IEEE_CERTIFICATION_LEN_MAX                               (32)
#define BLE_CFG_DIS_PNP_ID_LEN_MAX                                           (7)

[/#if]
[#if (BT_SIG_HEART_RATE_SENSOR = 1)]
/******************************************************************************
 * Heart Rate Service (HRS)
 ******************************************************************************/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_HRS_BODY_SENSOR_LOCATION_CHAR"]
				[#lt]#define ${definition.name}               ${definition.value}/**< BODY SENSOR LOCATION CHARACTERISTIC */
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_HRS_ENERGY_EXPENDED_INFO_FLAG"]
				[#lt]#define ${definition.name}               ${definition.value}/**< ENERGY EXTENDED INFO FLAG */
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_HRS_ENERGY_RR_INTERVAL_FLAG"]
				[#lt]#define ${definition.name}                 ${definition.value}/**< Max number of RR interval values - Shall not be greater than 9 */
			[/#if]
		[/#list]
	[/#if]
[/#list]
[/#if]

[#if (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)]
/******************************************************************************
 * Health Thermometer Service (HTS)
 ******************************************************************************/
/**
 * TEMPERATURE TYPE
 * When set to '1', the TEMPERATURE TYPE characteristic shall be added and the Temperature type Info flag shall not be present
 * When set to '0', the TEMPERATURE TYPE characteristic shall not be supported and the Temperature type Info flag shall be present
 */


[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_HTS_TEMPERATURE_TYPE_VALUE_STATIC"]
				[#lt]#define ${definition.name}               ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]

[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_HTS_INTERMEDIATE_TEMPERATURE"]
				[#lt]#define ${definition.name}               ${definition.value}  /**< Intermediate Temperature characteristic */
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_HTS_MEASUREMENT_INTERVAL"]
				[#lt]#define ${definition.name}               ${definition.value}  /**< Measurement Interval characteristic */
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_HTS_MEASUREMENT_INTERVAL_IND_PROP"]
				[#lt]#define ${definition.name}               ${definition.value}  /**< Measurement Interval characteristic Indicate property*/
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_HTS_MEASUREMENT_INTERVAL_WR_PROP"]
				[#lt]#define ${definition.name}               ${definition.value}  /**< Measurement Interval characteristic Write property */
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_HTS_TIME_STAMP_FLAG"]
				[#lt]#define ${definition.name}               ${definition.value}  /**< Time Stamp Info Flag */
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_HTS_TEMPERATURE_INTERVAL_MIN_VALUE"]
				[#lt]#define ${definition.name}               ${definition.value}  /**< Min Interval Value supported */
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_HTS_TEMPERATURE_INTERVAL_MAX_VALUE"]
				[#lt]#define ${definition.name}               ${definition.value} /**< Max Interval Value supported */
			[/#if]
		[/#list]
	[/#if]
[/#list]
[/#if]

[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1)]
 /******************************************************************************
 * Blood Pressure Service (BLS)
 ******************************************************************************/
/**
 * MEASUREMENT STATUS
 * When set to '1', the MEASUREMENT STATUS field  shall be added and the Measurement status Info flag shall not be present
 * When set to '0', the MEASUREMENT STATUS field shall not be added and the Measurement status Info flag shall be present
 * The same logic apply to PULSE RATE, Time Stamp and USER ID fields
 */
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_BLS_MEASUREMENT_STATUS_FLAG"]
				[#lt]#define ${definition.name}                 ${definition.value}/**< Measurement Status info flag */
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_BLS_PULSE_RATE_FLAG"]
				[#lt]#define ${definition.name}                         ${definition.value}/**< Pulse Rate info flag */
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_BLS_USER_ID_FLAG"]
				[#lt]#define ${definition.name}                            ${definition.value}/**< User ID info flag */
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_BLS_TIME_STAMP_FLAG"]
				[#lt]#define ${definition.name}                         ${definition.value}/**< Time Stamp Info Flag */
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_BLS_INTERMEDIATE_CUFF_PRESSURE"]
				[#lt]#define ${definition.name}              ${definition.value}/**< Intermediate Cuff Pressure characteristic */
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_BLS_SUPPORTED_FEATURES"]
				[#lt]#define ${definition.name}                      ${definition.value}/**< Blood Pressure Feature characteristic */
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_BLS_PULSE_RATE_LOWER_LIMIT"]
				[#lt]#define ${definition.name}                 ${definition.value}/**< Lower Pulse Rate supported */
			[/#if]
		[/#list]
	[/#if]
[/#list]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_BLS_PULSE_RATE_UPPER_LIMIT"]
				[#lt]#define ${definition.name}                 ${definition.value}/**< Upper Pulse Rate supported */
			[/#if]
		[/#list]
	[/#if]
[/#list]
[/#if]

/******************************************************************************
 * GAP Service - Appearance
 ******************************************************************************/

#define BLE_CFG_UNKNOWN_APPEARANCE                  (0)
#define BLE_CFG_HR_SENSOR_APPEARANCE                (832)
[#if (BT_SIG_HEART_RATE_SENSOR = 1)]
#define BLE_CFG_GAP_APPEARANCE                      (BLE_CFG_HR_SENSOR_APPEARANCE)
[#else]
#define BLE_CFG_GAP_APPEARANCE                      (BLE_CFG_UNKNOWN_APPEARANCE)
[/#if]

[#if (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1)]
/******************************************************************************
 * Over The Air Feature (OTA) - STM Proprietary
 ******************************************************************************/
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_CFG_OTA_REBOOT_CHAR"]
				[#lt]#define ${definition.name}         ${definition.value}/**< REBOOT OTA MODE CHARACTERISTIC */
			[/#if]
		[/#list]
	[/#if]
[/#list]
[/#if]

#endif /*BLE_CONF_H */