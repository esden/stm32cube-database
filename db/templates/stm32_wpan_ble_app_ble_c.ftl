[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name}
  * @author  MCD Application Team
  * @brief   BLE Application
  *****************************************************************************
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
[#assign BLE_APPLICATION_TYPE = "This text shouldn't appear"]
[#assign LOCAL_NAME_FORMATTED = "This text shouldn't appear"]
[#assign LOCAL_NAME = "STM32WB"]
[#assign P2P_SERVER_NUMBER = ""]
[#assign ADV_TYPE = ""]
[#assign BLE_ADDR_TYPE = ""]
[#assign ADV_FILTER = ""]
[#assign GAP_PERIPHERAL_ROLE = ""]
[#assign GAP_BROADCASTER_ROLE = ""]
[#assign GAP_CENTRAL_ROLE = ""]
[#assign GAP_OBSERVER_ROLE = ""]
[#assign CFG_GAP_DEVICE_NAME = ""]
[#assign CFG_GAP_DEVICE_NAME_LENGTH = ""]
[#assign CFG_FAST_CONN_ADV_INTERVAL_MIN = ""]
[#assign CFG_FAST_CONN_ADV_INTERVAL_MAX = ""]
[#assign AD_DATA_LENGTH = ""]
[#assign INCLUDE_AD_TYPE_TX_POWER_LEVEL = ""]
[#assign AD_TYPE_TX_POWER_LEVEL_LENGTH = ""]
[#assign AD_TYPE_TX_POWER_LEVEL = ""]
[#assign AD_TYPE_TX_POWER_LEVEL_DBM = ""]
[#assign INCLUDE_AD_TYPE_COMPLETE_LOCAL_NAME = ""]
[#assign AD_TYPE_COMPLETE_LOCAL_NAME_LENGTH = ""]
[#assign AD_TYPE_COMPLETE_LOCAL_NAME = ""]
[#assign INCLUDE_AD_TYPE_SHORTENED_LOCAL_NAME  = ""]
[#assign AD_TYPE_SHORTENED_LOCAL_NAME_LENGTH = ""]
[#assign AD_TYPE_SHORTENED_LOCAL_NAME  = ""]
[#assign INCLUDE_AD_TYPE_APPEARANCE = ""]
[#assign AD_TYPE_APPEARANCE_LENGTH = ""]
[#assign AD_TYPE_APPEARANCE = ""]
[#assign INCLUDE_AD_TYPE_ADVERTISING_INTERVAL = ""]
[#assign AD_TYPE_ADVERTISING_INTERVAL_LENGTH = ""]
[#assign AD_TYPE_ADVERTISING_INTERVAL = ""]
[#assign AD_TYPE_ADVERTISING_INTERVAL_VALUE = ""]
[#assign AD_TYPE_ADVERTISING_INTERVAL_VALUE_HEXA = ""]
[#assign CFG_FAST_CONN_ADV_INTERVAL_MAX_HEXA = 0]
[#assign CFG_SC_SUPPORT = 0]
[#assign CFG_KEYPRESS_NOTIFICATION_SUPPORT = 0]
[#assign INCLUDE_AD_TYPE_LE_ROLE = ""]
[#assign AD_TYPE_LE_ROLE_LENGTH = ""]
[#assign AD_TYPE_LE_ROLE = ""]
[#assign INCLUDE_AD_TYPE_16_BIT_SERV_UUID_CMPLT_LIST = ""]
[#assign AD_TYPE_16_BIT_SERV_UUID_CMPLT_LIST_LENGTH = ""]
[#assign AD_SERVICE_CLASS_UUID_NBR = ""]
[#assign AD_SERVICE_CLASS_UUID_TABLE = []]
[#assign AD_SERVICE_CLASS_UUID_1 = ""]
[#assign AD_SERVICE_CLASS_UUID_2 = ""]
[#assign AD_SERVICE_CLASS_UUID_3 = ""]
[#assign AD_SERVICE_CLASS_UUID_4 = ""]
[#assign AD_SERVICE_CLASS_UUID_5 = ""]
[#assign AD_SERVICE_CLASS_UUID_6 = ""]
[#assign AD_SERVICE_CLASS_UUID_7 = ""]
[#assign AD_SERVICE_CLASS_UUID_8 = ""]
[#assign AD_SERVICE_CLASS_UUID_9 = ""]
[#assign AD_SERVICE_CLASS_UUID_10 = ""]
[#assign AD_SERVICE_CLASS_UUID_11 = ""]
[#assign AD_SERVICE_CLASS_UUID_12 = ""]
[#assign AD_SERVICE_CLASS_UUID_1_INV = ""]
[#assign AD_SERVICE_CLASS_UUID_2_INV = ""]
[#assign AD_SERVICE_CLASS_UUID_3_INV = ""]
[#assign AD_SERVICE_CLASS_UUID_4_INV = ""]
[#assign AD_SERVICE_CLASS_UUID_5_INV = ""]
[#assign AD_SERVICE_CLASS_UUID_6_INV = ""]
[#assign AD_SERVICE_CLASS_UUID_7_INV = ""]
[#assign AD_SERVICE_CLASS_UUID_8_INV = ""]
[#assign AD_SERVICE_CLASS_UUID_9_INV = ""]
[#assign AD_SERVICE_CLASS_UUID_10_INV = ""]
[#assign AD_SERVICE_CLASS_UUID_11_INV = ""]
[#assign AD_SERVICE_CLASS_UUID_12_INV = ""]
[#assign INCLUDE_AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST = ""]
[#assign AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST_LENGTH = ""]
[#assign AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST = ""]
[#assign AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST_INV = ""]
[#assign INCLUDE_AD_TYPE_SLAVE_CONN_INTERVAL = ""]
[#assign AD_TYPE_SLAVE_CONN_INTERVAL_LENGTH = ""]
[#assign AD_TYPE_SLAVE_CONN_INTERVAL_MIN_MAX = ""]
[#assign AD_TYPE_SLAVE_CONN_INTERVAL_MIN = ""]
[#assign AD_TYPE_SLAVE_CONN_INTERVAL_MIN_HEXA = ""]
[#assign AD_TYPE_SLAVE_CONN_INTERVAL_MAX = ""]
[#assign AD_TYPE_SLAVE_CONN_INTERVAL_MAX_HEXA = ""]
[#assign INCLUDE_AD_TYPE_URI = ""]
[#assign AD_TYPE_URI_LENGTH = ""]
[#assign AD_TYPE_URI_CODE_POINT = ""]
[#assign AD_TYPE_URI_DATA = ""]
[#assign AD_TYPE_URI_DATA_LENGTH = ""]
[#assign INCLUDE_AD_TYPE_MANUFACTURER_SPECIFIC_DATA = ""]
[#assign AD_TYPE_MANUFACTURER_SPECIFIC_DATA_LENGTH = ""]
[#assign AD_TYPE_MANUFACTURER_SPECIFIC_DATA_COMPANY_IDENTIFIER = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_NBR = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_TABLE = []]
[#assign AD_TYPE_MANUFACTURER_DATA_1 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_1 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_2 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_2 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_3 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_3 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_4 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_4 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_5 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_5 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_6 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_6 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_7 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_7 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_8 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_8 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_9 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_9 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_10 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_10 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_11 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_11 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_12 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_12 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_13 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_13 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_14 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_14 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_15 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_15 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_16 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_16 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_17 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_17 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_18 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_18 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_19 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_19 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_20 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_20 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_21 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_21 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_22 = ""]
[#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_22 = ""]
[#assign DIE = DIE]
[#assign CFG_STATIC_RANDOM_ADDRESS = ""]
[#assign CFG_RNG = ""]
[#assign CFG_IDENTITY_ADDRESS = "GAP_PUBLIC_ADDR"]
[#assign CFG_PRIVACY = "PRIVACY_DISABLED"]
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
                [#assign BT_SIG_BEACON = definition.value]
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
            [#if (definition.name == "CUSTOM_P2P_ROUTER") && (definition.value =="Enabled")]
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
            [#if definition.name == "LOCAL_NAME_FORMATTED"]
                [#assign LOCAL_NAME_FORMATTED = definition.value]
            [/#if]
            [#if definition.name == "LOCAL_NAME"]
                [#assign LOCAL_NAME = definition.value]
            [/#if]
            [#if definition.name == "P2P_SERVER_NUMBER"]
                [#assign P2P_SERVER_NUMBER = definition.value]
            [/#if]
            [#if definition.name == "ADV_TYPE"]
                [#assign ADV_TYPE = definition.value]
            [/#if]
            [#if definition.name == "BLE_ADDR_TYPE"]
                [#assign BLE_ADDR_TYPE = definition.value]
            [/#if]
            [#if definition.name == "ADV_FILTER"]
                [#assign ADV_FILTER = definition.value]
            [/#if]
            [#if definition.name == "GAP_PERIPHERAL_ROLE"]
                [#assign GAP_PERIPHERAL_ROLE = definition.value]
            [/#if]
            [#if definition.name == "GAP_BROADCASTER_ROLE"]
                [#assign GAP_BROADCASTER_ROLE = definition.value]
            [/#if]
            [#if definition.name == "GAP_CENTRAL_ROLE"]
                [#assign GAP_CENTRAL_ROLE = definition.value]
            [/#if]
            [#if definition.name == "GAP_OBSERVER_ROLE"]
                [#assign GAP_OBSERVER_ROLE = definition.value]
            [/#if]
            [#if definition.name == "CFG_GAP_DEVICE_NAME"]
                [#assign CFG_GAP_DEVICE_NAME = definition.value]
            [/#if]
            [#if definition.name == "CFG_GAP_DEVICE_NAME_LENGTH"]
                [#assign CFG_GAP_DEVICE_NAME_LENGTH = definition.value]
            [/#if]
            [#if definition.name == "CFG_FAST_CONN_ADV_INTERVAL_MIN"]
                [#assign CFG_FAST_CONN_ADV_INTERVAL_MIN = definition.value]
            [/#if]
            [#if definition.name == "CFG_FAST_CONN_ADV_INTERVAL_MAX"]
                [#assign CFG_FAST_CONN_ADV_INTERVAL_MAX = definition.value]
            [/#if]
            [#if definition.name == "CFG_FAST_CONN_ADV_INTERVAL_MAX_HEXA"]
                [#assign CFG_FAST_CONN_ADV_INTERVAL_MAX_HEXA = definition.value]
            [/#if]
            [#if definition.name == "CFG_SC_SUPPORT"]
                [#assign CFG_SC_SUPPORT = definition.value]
            [/#if]
            [#if definition.name == "CFG_KEYPRESS_NOTIFICATION_SUPPORT"]
                [#assign CFG_KEYPRESS_NOTIFICATION_SUPPORT = definition.value]
            [/#if]
            [#if definition.name == "AD_DATA_LENGTH"]
                [#assign AD_DATA_LENGTH = definition.value]
            [/#if]
            [#if definition.name == "INCLUDE_AD_TYPE_TX_POWER_LEVEL"]
                [#assign INCLUDE_AD_TYPE_TX_POWER_LEVEL = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_TX_POWER_LEVEL_LENGTH"]
                [#assign AD_TYPE_TX_POWER_LEVEL_LENGTH = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_TX_POWER_LEVEL"]
                [#assign AD_TYPE_TX_POWER_LEVEL = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_TX_POWER_LEVEL_DBM"]
                [#assign AD_TYPE_TX_POWER_LEVEL_DBM = definition.value]
            [/#if]
            [#if definition.name == "INCLUDE_AD_TYPE_COMPLETE_LOCAL_NAME"]
                [#assign INCLUDE_AD_TYPE_COMPLETE_LOCAL_NAME = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_COMPLETE_LOCAL_NAME_LENGTH"]
                [#assign AD_TYPE_COMPLETE_LOCAL_NAME_LENGTH = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_COMPLETE_LOCAL_NAME"]
                [#assign AD_TYPE_COMPLETE_LOCAL_NAME = definition.value]
            [/#if]
            [#if definition.name == "INCLUDE_AD_TYPE_SHORTENED_LOCAL_NAME"]
                [#assign INCLUDE_AD_TYPE_SHORTENED_LOCAL_NAME  = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_SHORTENED_LOCAL_NAME_LENGTH"]
                [#assign AD_TYPE_SHORTENED_LOCAL_NAME_LENGTH = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_SHORTENED_LOCAL_NAME"]
                [#assign AD_TYPE_SHORTENED_LOCAL_NAME  = definition.value]
            [/#if]
            [#if definition.name == "INCLUDE_AD_TYPE_APPEARANCE"]
                [#assign INCLUDE_AD_TYPE_APPEARANCE = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_APPEARANCE_LENGTH"]
                [#assign AD_TYPE_APPEARANCE_LENGTH = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_APPEARANCE"]
                [#assign AD_TYPE_APPEARANCE = definition.value]
            [/#if]
            [#if definition.name == "INCLUDE_AD_TYPE_ADVERTISING_INTERVAL"]
                [#assign INCLUDE_AD_TYPE_ADVERTISING_INTERVAL = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_ADVERTISING_INTERVAL_VALUE"]
                [#assign AD_TYPE_ADVERTISING_INTERVAL_VALUE = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_ADVERTISING_INTERVAL_VALUE_HEXA"]
                [#assign AD_TYPE_ADVERTISING_INTERVAL_VALUE_HEXA = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_ADVERTISING_INTERVAL_LENGTH"]
                [#assign AD_TYPE_ADVERTISING_INTERVAL_LENGTH = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_ADVERTISING_INTERVAL"]
                [#assign AD_TYPE_ADVERTISING_INTERVAL = definition.value]
            [/#if]
            [#if definition.name == "INCLUDE_AD_TYPE_LE_ROLE"]
                [#assign INCLUDE_AD_TYPE_LE_ROLE = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_LE_ROLE_LENGTH"]
                [#assign AD_TYPE_LE_ROLE_LENGTH = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_LE_ROLE"]
                [#assign AD_TYPE_LE_ROLE = definition.value]
            [/#if]
            [#if definition.name == "INCLUDE_AD_TYPE_16_BIT_SERV_UUID_CMPLT_LIST"]
                [#assign INCLUDE_AD_TYPE_16_BIT_SERV_UUID_CMPLT_LIST = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_16_BIT_SERV_UUID_CMPLT_LIST_LENGTH"]
                [#assign AD_TYPE_16_BIT_SERV_UUID_CMPLT_LIST_LENGTH = definition.value]
            [/#if]
            [#if definition.name == "AD_SERVICE_CLASS_UUID_NBR"]
                [#assign AD_SERVICE_CLASS_UUID_NBR = definition.value]
            [/#if]
            [#if definition.name == "AD_SERVICE_CLASS_UUID_1_INV"]
                [#assign AD_SERVICE_CLASS_UUID_1_INV = definition.value]
                [#if AD_SERVICE_CLASS_UUID_1_INV = "00 00"]
                [#assign AD_SERVICE_CLASS_UUID_1_INV = "[00, 00]"]
                [/#if]
                [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_1_INV]]
            [/#if]
            [#if definition.name == "AD_SERVICE_CLASS_UUID_2_INV"]
                [#assign AD_SERVICE_CLASS_UUID_2_INV = definition.value]
                [#if AD_SERVICE_CLASS_UUID_2_INV = "00 00"]
                [#assign AD_SERVICE_CLASS_UUID_2_INV = "[00, 00]"]
                [/#if]
                [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_2_INV]]
            [/#if]
            [#if definition.name == "AD_SERVICE_CLASS_UUID_3_INV"]
                [#assign AD_SERVICE_CLASS_UUID_3_INV = definition.value]
                [#if AD_SERVICE_CLASS_UUID_3_INV = "00 00"]
                [#assign AD_SERVICE_CLASS_UUID_3_INV = "[00, 00]"]
                [/#if]
                [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_3_INV]]
            [/#if]
            [#if definition.name == "AD_SERVICE_CLASS_UUID_4_INV"]
                [#assign AD_SERVICE_CLASS_UUID_4_INV = definition.value]
                [#if AD_SERVICE_CLASS_UUID_4_INV = "00 00"]
                [#assign AD_SERVICE_CLASS_UUID_4_INV = "[00, 00]"]
                [/#if]
                [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_4_INV]]
            [/#if]
            [#if definition.name == "AD_SERVICE_CLASS_UUID_5_INV"]
                [#assign AD_SERVICE_CLASS_UUID_5_INV = definition.value]
                [#if AD_SERVICE_CLASS_UUID_5_INV = "00 00"]
                [#assign AD_SERVICE_CLASS_UUID_5_INV = "[00, 00]"]
                [/#if]
                [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_5_INV]]
            [/#if]
            [#if definition.name == "AD_SERVICE_CLASS_UUID_6_INV"]
                [#assign AD_SERVICE_CLASS_UUID_6_INV = definition.value]
                [#if AD_SERVICE_CLASS_UUID_6_INV = "00 00"]
                [#assign AD_SERVICE_CLASS_UUID_6_INV = "[00, 00]"]
                [/#if]
                [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_6_INV]]
            [/#if]
            [#if definition.name == "AD_SERVICE_CLASS_UUID_7_INV"]
                [#assign AD_SERVICE_CLASS_UUID_7_INV = definition.value]
                [#if AD_SERVICE_CLASS_UUID_7_INV = "00 00"]
                [#assign AD_SERVICE_CLASS_UUID_7_INV = "[00, 00]"]
                [/#if]
                [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_7_INV]]
            [/#if]
            [#if definition.name == "AD_SERVICE_CLASS_UUID_8_INV"]
                [#assign AD_SERVICE_CLASS_UUID_8_INV = definition.value]
                [#if AD_SERVICE_CLASS_UUID_8_INV = "00 00"]
                [#assign AD_SERVICE_CLASS_UUID_8_INV = "[00, 00]"]
                [/#if]
                [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_8_INV]]
            [/#if]
            [#if definition.name == "AD_SERVICE_CLASS_UUID_9_INV"]
                [#assign AD_SERVICE_CLASS_UUID_9_INV = definition.value]
                [#if AD_SERVICE_CLASS_UUID_9_INV = "00 00"]
                [#assign AD_SERVICE_CLASS_UUID_9_INV = "[00, 00]"]
                [/#if]
                [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_9_INV]]
            [/#if]
            [#if definition.name == "AD_SERVICE_CLASS_UUID_10_INV"]
                [#assign AD_SERVICE_CLASS_UUID_10_INV = definition.value]
                [#if AD_SERVICE_CLASS_UUID_10_INV = "00 00"]
                [#assign AD_SERVICE_CLASS_UUID_10_INV = "[00, 00]"]
                [/#if]
                [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_10_INV]]
            [/#if]
            [#if definition.name == "AD_SERVICE_CLASS_UUID_11_INV"]
                [#assign AD_SERVICE_CLASS_UUID_11_INV = definition.value]
                [#if AD_SERVICE_CLASS_UUID_11_INV = "00 00"]
                [#assign AD_SERVICE_CLASS_UUID_11_INV = "[00, 00]"]
                [/#if]
                [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_11_INV]]
            [/#if]
            [#if definition.name == "AD_SERVICE_CLASS_UUID_12_INV"]
                [#assign AD_SERVICE_CLASS_UUID_12_INV = definition.value]
                [#if AD_SERVICE_CLASS_UUID_12_INV = "00 00"]
                [#assign AD_SERVICE_CLASS_UUID_12_INV = "[00, 00]"]
                [/#if]
                [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_12_INV]]
            [/#if]
            [#if definition.name == "INCLUDE_AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST"]
                [#assign INCLUDE_AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST_LENGTH"]
                [#assign AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST_LENGTH = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST"]
                [#assign AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST_INV"]
                [#assign AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST_INV = definition.value]
                [#if AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST_INV = "00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00"]
                [#assign AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST_INV = "[00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00]"]
                [/#if]
            [/#if]
            [#if definition.name == "INCLUDE_AD_TYPE_SLAVE_CONN_INTERVAL"]
                [#assign INCLUDE_AD_TYPE_SLAVE_CONN_INTERVAL = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_SLAVE_CONN_INTERVAL_LENGTH"]
                [#assign AD_TYPE_SLAVE_CONN_INTERVAL_LENGTH = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_SLAVE_CONN_INTERVAL_MIN_MAX"]
                [#assign AD_TYPE_SLAVE_CONN_INTERVAL_MIN_MAX = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_SLAVE_CONN_INTERVAL_MIN"]
                [#assign AD_TYPE_SLAVE_CONN_INTERVAL_MIN = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_SLAVE_CONN_INTERVAL_MIN_HEXA"]
                [#assign AD_TYPE_SLAVE_CONN_INTERVAL_MIN_HEXA = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_SLAVE_CONN_INTERVAL_MAX"]
                [#assign AD_TYPE_SLAVE_CONN_INTERVAL_MAX = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_SLAVE_CONN_INTERVAL_MAX_HEXA"]
                [#assign AD_TYPE_SLAVE_CONN_INTERVAL_MAX_HEXA = definition.value]
            [/#if]
            [#if definition.name == "INCLUDE_AD_TYPE_URI"]
                [#assign INCLUDE_AD_TYPE_URI = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_URI_LENGTH"]
                [#assign AD_TYPE_URI_LENGTH = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_URI_CODE_POINT"]
                [#assign AD_TYPE_URI_CODE_POINT = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_URI_DATA"]
                [#assign AD_TYPE_URI_DATA = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_URI_DATA_LENGTH"]
                [#assign AD_TYPE_URI_DATA_LENGTH = definition.value]
            [/#if]
            [#if definition.name == "INCLUDE_AD_TYPE_MANUFACTURER_SPECIFIC_DATA"]
                [#assign INCLUDE_AD_TYPE_MANUFACTURER_SPECIFIC_DATA = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_SPECIFIC_DATA_LENGTH"]
                [#assign AD_TYPE_MANUFACTURER_SPECIFIC_DATA_LENGTH = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_SPECIFIC_DATA_COMPANY_IDENTIFIER"]
                [#assign AD_TYPE_MANUFACTURER_SPECIFIC_DATA_COMPANY_IDENTIFIER = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_NBR"]
                [#assign AD_TYPE_MANUFACTURER_DATA_NBR = definition.value]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_1"]
                [#assign AD_TYPE_MANUFACTURER_DATA_1 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_1]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_1"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_1 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_1]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_2"]
                [#assign AD_TYPE_MANUFACTURER_DATA_2 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_2]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_2"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_2 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_2]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_3"]
                [#assign AD_TYPE_MANUFACTURER_DATA_3 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_3]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_3"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_3 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_3]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_4"]
                [#assign AD_TYPE_MANUFACTURER_DATA_4 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_4]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_4"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_4 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_4]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_5"]
                [#assign AD_TYPE_MANUFACTURER_DATA_5 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_5]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_5"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_5 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_5]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_6"]
                [#assign AD_TYPE_MANUFACTURER_DATA_6 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_6]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_6"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_6 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_6]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_7"]
                [#assign AD_TYPE_MANUFACTURER_DATA_7 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_7]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_7"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_7 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_7]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_8"]
                [#assign AD_TYPE_MANUFACTURER_DATA_8 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_8]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_8"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_8 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_8]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_9"]
                [#assign AD_TYPE_MANUFACTURER_DATA_9 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_9]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_9"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_9 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_9]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_10"]
                [#assign AD_TYPE_MANUFACTURER_DATA_10 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_10]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_10"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_10 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_10]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_11"]
                [#assign AD_TYPE_MANUFACTURER_DATA_11 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_11]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_11"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_11 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_11]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_12"]
                [#assign AD_TYPE_MANUFACTURER_DATA_12 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_12]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_12"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_12 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_12]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_13"]
                [#assign AD_TYPE_MANUFACTURER_DATA_13 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_13]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_13"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_13 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_13]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_14"]
                [#assign AD_TYPE_MANUFACTURER_DATA_14 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_14]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_14"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_14 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_14]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_15"]
                [#assign AD_TYPE_MANUFACTURER_DATA_15 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_15]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_15"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_15 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_15]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_16"]
                [#assign AD_TYPE_MANUFACTURER_DATA_16 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_16]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_16"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_16 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_16]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_17"]
                [#assign AD_TYPE_MANUFACTURER_DATA_17 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_17]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_17"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_17 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_17]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_18"]
                [#assign AD_TYPE_MANUFACTURER_DATA_18 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_18]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_18"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_18 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_18]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_19"]
                [#assign AD_TYPE_MANUFACTURER_DATA_19 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_19]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_19"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_19 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_19]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_20"]
                [#assign AD_TYPE_MANUFACTURER_DATA_20 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_20]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_20"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_20 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_20]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_21"]
                [#assign AD_TYPE_MANUFACTURER_DATA_21 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_21]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_21"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_21 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_21]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_22"]
                [#assign AD_TYPE_MANUFACTURER_DATA_22 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_22]]
            [/#if]
            [#if definition.name == "AD_TYPE_MANUFACTURER_DATA_COMMENT_22"]
                [#assign AD_TYPE_MANUFACTURER_DATA_COMMENT_22 = definition.value]
                [#assign AD_TYPE_MANUFACTURER_DATA_TABLE = AD_TYPE_MANUFACTURER_DATA_TABLE + [AD_TYPE_MANUFACTURER_DATA_COMMENT_22]]
            [/#if]
            [#if definition.name == "CFG_STATIC_RANDOM_ADDRESS"]
                [#assign CFG_STATIC_RANDOM_ADDRESS = definition.value]
            [/#if]
            [#if definition.name == "CFG_RNG"]
                [#assign CFG_RNG = definition.value]
            [/#if]
            [#if (definition.name == "CFG_IDENTITY_ADDRESS")]
                [#assign CFG_IDENTITY_ADDRESS = definition.value]
            [/#if]
            [#if (definition.name == "CFG_PRIVACY")]
                [#assign CFG_PRIVACY = definition.value]
            [/#if]
        [/#list]
	[/#if]
[/#list]
[#if CFG_PRIVACY == "PRIVACY_DISABLED"]
  [#assign BLE_ADDR_TYPE = CFG_IDENTITY_ADDRESS]
[/#if]

/* Includes ------------------------------------------------------------------*/
#include "main.h"

#include "app_common.h"

#include "dbg_trace.h"
#include "ble.h"
#include "tl.h"
#include "app_ble.h"

[#if  (FREERTOS_STATUS = 0)]
#include "stm32_seq.h"
[#else]
#include "cmsis_os.h"
[/#if]
#include "shci.h"
#include "stm32_lpm.h"
#include "otp.h"

[#if  (BT_SIG_BEACON != "0")]
#include "eddystone_beacon.h"
#include "eddystone_uid_service.h"
#include "eddystone_url_service.h"
#include "eddystone_tlm_service.h"
#include "ibeacon_service.h"
#include "ibeacon.h"
[/#if]
[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1)]
#include "bls_app.h"
[/#if]
[#if  (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)]
#include "hts_app.h"
[/#if]
[#if  (BT_SIG_HEART_RATE_SENSOR = 1)]
#include "hrs_app.h"
[/#if]
[#if  (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1) || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1)]
#include "dis_app.h"
[/#if]
[#if  (CUSTOM_P2P_SERVER = 1)]
#include "p2p_server_app.h"
[/#if]
[#if  (CUSTOM_TEMPLATE = 1)]
#include "custom_app.h"
[/#if]

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/

[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
/**
 * security parameters structure
 */ 
typedef struct _tSecurityParams
{
  /**
   * IO capability of the device
   */
  uint8_t ioCapability;

  /**
   * Authentication requirement of the device
   * Man In the Middle protection required?
   */
  uint8_t mitm_mode;

  /**
   * bonding mode of the device
   */
  uint8_t bonding_mode;

  /**
   * this variable indicates whether to use a fixed pin
   * during the pairing process or a passkey has to be
   * requested to the application during the pairing process
   * 0 implies use fixed pin and 1 implies request for passkey
   */
  uint8_t Use_Fixed_Pin; 

  /**
   * minimum encryption key size requirement
   */
  uint8_t encryptionKeySizeMin;

  /**
   * maximum encryption key size requirement
   */
  uint8_t encryptionKeySizeMax;

  /**
   * fixed pin to be used in the pairing process if
   * Use_Fixed_Pin is set to 1
   */
  uint32_t Fixed_Pin;

  /**
   * this flag indicates whether the host has to initiate
   * the security, wait for pairing or does not have any security
   * requirements.
   * 0x00 : no security required
   * 0x01 : host should initiate security by sending the slave security
   *        request command
   * 0x02 : host need not send the clave security request but it
   * has to wait for paiirng to complete before doing any other
   * processing
   */
  uint8_t initiateSecurity;
  /* USER CODE BEGIN tSecurityParams*/

  /* USER CODE END tSecurityParams */
}tSecurityParams;

/**
 * global context
 * contains the variables common to all 
 * services
 */ 
typedef struct _tBLEProfileGlobalContext
{
  /**
   * security requirements of the host
   */ 
  tSecurityParams bleSecurityParam;

  /**
   * gap service handle
   */
  uint16_t gapServiceHandle;

  /**
   * device name characteristic handle
   */ 
  uint16_t devNameCharHandle;

  /**
   * appearance characteristic handle
   */ 
  uint16_t appearanceCharHandle;

  /**
   * connection handle of the current active connection
   * When not in connection, the handle is set to 0xFFFF
   */ 
  uint16_t connectionHandle;

  /**
   * length of the UUID list to be used while advertising
   */ 
  uint8_t advtServUUIDlen;

  /**
   * the UUID list to be used while advertising
   */ 
  uint8_t advtServUUID[100];
  /* USER CODE BEGIN BleGlobalContext_t*/

  /* USER CODE END BleGlobalContext_t */
}BleGlobalContext_t;

typedef struct
{
  BleGlobalContext_t BleApplicationContext_legacy;
  APP_BLE_ConnStatus_t Device_Connection_Status;
[#if (BT_SIG_BEACON != "0") || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1)|| (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)|| (BT_SIG_HEART_RATE_SENSOR = 1)|| (CUSTOM_OTA = 1)|| (CUSTOM_P2P_SERVER = 1)]

  /**
   * ID of the Advertising Timeout
   */
  uint8_t Advertising_mgr_timer_Id;
[/#if]
[#if  (CUSTOM_P2P_SERVER = 1)]

  uint8_t SwitchOffGPIO_timer_Id;
[/#if]
  /* USER CODE BEGIN PTD_1*/

  /* USER CODE END PTD_1 */
}BleApplicationContext_t;
[/#if]

/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private defines -----------------------------------------------------------*/
[#if (CUSTOM_TEMPLATE = 0)]
#define APPBLE_GAP_DEVICE_NAME_LENGTH 7
[/#if]
[#if  (BT_SIG_BEACON != "0")]
  /**
  * Boot Mode:    1 (OTA)
  * Sector Index: 6
  * Nb Sectors  : 1
  */
#define BOOT_MODE_AND_SECTOR                                            0x010601
#define APP_SECTORS                                                            7
#define DATA_SECTOR                                                            6
[/#if]
[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
      || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
#define FAST_ADV_TIMEOUT               (30*1000*1000/CFG_TS_TICK_VAL) /**< 30s */
#define INITIAL_ADV_TIMEOUT            (60*1000*1000/CFG_TS_TICK_VAL) /**< 60s */
[/#if]

#define BD_ADDR_SIZE_LOCAL    6

/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
PLACE_IN_SECTION("MB_MEM1") ALIGN(4) static TL_CmdPacket_t BleCmdBuffer;

[#if ((CFG_IDENTITY_ADDRESS = "GAP_PUBLIC_ADDR") && ((BT_SIG_BEACON != "0") || (BT_SIG_HEART_RATE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)))]
static const uint8_t a_MBdAddr[BD_ADDR_SIZE_LOCAL] =
{
  (uint8_t)((CFG_ADV_BD_ADDRESS & 0x0000000000FF)),
  (uint8_t)((CFG_ADV_BD_ADDRESS & 0x00000000FF00) >> 8),
  (uint8_t)((CFG_ADV_BD_ADDRESS & 0x000000FF0000) >> 16),
  (uint8_t)((CFG_ADV_BD_ADDRESS & 0x0000FF000000) >> 24),
  (uint8_t)((CFG_ADV_BD_ADDRESS & 0x00FF00000000) >> 32),
  (uint8_t)((CFG_ADV_BD_ADDRESS & 0xFF0000000000) >> 40)
};

static uint8_t a_BdAddrUdn[BD_ADDR_SIZE_LOCAL];
[/#if]

/**
 *   Identity root key used to derive LTK and CSRK 
 */
static const uint8_t a_BLE_CfgIrValue[16] = CFG_BLE_IRK;

/**
 * Encryption root key used to derive LTK and CSRK
 */
static const uint8_t a_BLE_CfgErValue[16] = CFG_BLE_ERK;

[#if  (BT_SIG_BEACON != "0")]
static uint8_t sector_type;
[/#if]
[#if  (BT_SIG_BEACON != "0") || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
/**
 * These are the two tags used to manage a power failure during OTA
 * The MagicKeywordAdress shall be mapped @0x140 from start of the binary image
 * The MagicKeywordvalue is checked in the ble_ota application
 */
PLACE_IN_SECTION("TAG_OTA_END") const uint32_t MagicKeywordValue = 0x94448A29 ;
PLACE_IN_SECTION("TAG_OTA_START") const uint32_t MagicKeywordAddress = (uint32_t)&MagicKeywordValue;

[/#if]
[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
static BleApplicationContext_t BleApplicationContext;
[/#if]
[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1)]
static uint16_t AdvIntervalMin, AdvIntervalMax;
[/#if]

[#if (CUSTOM_TEMPLATE = 1)]
Custom_App_ConnHandle_Not_evt_t HandleNotification;
[#else]
[#if  (CUSTOM_P2P_SERVER = 1)]
P2PS_APP_ConnHandle_Not_evt_t HandleNotification;
[/#if]
[/#if]
[#if  (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]

#if (L2CAP_REQUEST_NEW_CONN_PARAM != 0)
#define SIZE_TAB_CONN_INT            2
float a_ConnInterval[SIZE_TAB_CONN_INT] = {50, 1000}; /* ms */
uint8_t index_con_int, mutex; 
#endif /* L2CAP_REQUEST_NEW_CONN_PARAM != 0 */
[/#if]

[#if  (CUSTOM_TEMPLATE = 1)]
/**
 * Advertising Data
 */
uint8_t a_AdvData[${AD_DATA_LENGTH}] =
{
[#if  (INCLUDE_AD_TYPE_TX_POWER_LEVEL = "1")]
  ${AD_TYPE_TX_POWER_LEVEL_LENGTH}, AD_TYPE_TX_POWER_LEVEL, ${AD_TYPE_TX_POWER_LEVEL_DBM}, /* Transmission Power */
[/#if]
[#if  (INCLUDE_AD_TYPE_COMPLETE_LOCAL_NAME = "1")]
  ${AD_TYPE_COMPLETE_LOCAL_NAME_LENGTH}, AD_TYPE_COMPLETE_LOCAL_NAME, [#rt]
    [#list AD_TYPE_COMPLETE_LOCAL_NAME?split("(?!^)", "r") as char][#t]
        [#lt]'${char}', [#rt]
    [/#list][#lt] /* Complete name */
[/#if]
[#if  (INCLUDE_AD_TYPE_SHORTENED_LOCAL_NAME  = "1")]
  ${AD_TYPE_SHORTENED_LOCAL_NAME_LENGTH}, AD_TYPE_SHORTENED_LOCAL_NAME , [#rt]
    [#list AD_TYPE_SHORTENED_LOCAL_NAME ?split("(?!^)", "r") as char][#t]
        [#lt]'${char}', [#rt]
    [/#list][#lt] /* Shortened name */
[/#if]
[#if  (INCLUDE_AD_TYPE_APPEARANCE = "1")]
  ${AD_TYPE_APPEARANCE_LENGTH}, AD_TYPE_APPEARANCE, ${AD_TYPE_APPEARANCE},
[/#if]
[#if  (INCLUDE_AD_TYPE_ADVERTISING_INTERVAL = "1")]
  ${AD_TYPE_ADVERTISING_INTERVAL_LENGTH}, AD_TYPE_ADVERTISING_INTERVAL, [#assign res = CFG_FAST_CONN_ADV_INTERVAL_MAX_HEXA?matches("(.){2}")] ${res[0]}${res[1]}, ${res[0]}${res[2]} /* ${AD_TYPE_ADVERTISING_INTERVAL_VALUE} ms */,
[/#if]
[#if  (INCLUDE_AD_TYPE_LE_ROLE = "1")]
  ${AD_TYPE_LE_ROLE_LENGTH}, AD_TYPE_LE_ROLE, ${AD_TYPE_LE_ROLE},
[/#if]
[#if  (INCLUDE_AD_TYPE_16_BIT_SERV_UUID_CMPLT_LIST = "1")]
  ${AD_TYPE_16_BIT_SERV_UUID_CMPLT_LIST_LENGTH}, AD_TYPE_16_BIT_SERV_UUID_CMPLT_LIST, [#rt]
[#assign size = AD_SERVICE_CLASS_UUID_NBR?number-1]
[#list 0..size as i]
[#assign j = size-i]
0x${AD_SERVICE_CLASS_UUID_TABLE[j]?replace(", ",", 0x")?replace("[","")?replace("]","")}, [#rt]
[/#list]

[/#if]
[#if  (INCLUDE_AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST = "1")]
  ${AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST_LENGTH}, AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST, 0x${AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST_INV?replace(", ",", 0x")?replace("[","")?replace("]","")},
[/#if]
[#if  (INCLUDE_AD_TYPE_SLAVE_CONN_INTERVAL = "1")]
[#if  (AD_TYPE_SLAVE_CONN_INTERVAL_MIN_MAX = "1")]
  ${AD_TYPE_SLAVE_CONN_INTERVAL_LENGTH}, AD_TYPE_SLAVE_CONN_INTERVAL, ${AD_TYPE_SLAVE_CONN_INTERVAL_MIN_HEXA} /* ${AD_TYPE_SLAVE_CONN_INTERVAL_MIN} ms */, ${AD_TYPE_SLAVE_CONN_INTERVAL_MAX_HEXA} /* ${AD_TYPE_SLAVE_CONN_INTERVAL_MAX} ms*/,
[#else]
  ${AD_TYPE_SLAVE_CONN_INTERVAL_LENGTH}, AD_TYPE_SLAVE_CONN_INTERVAL, 0xFFFF,0xFFFF,
[/#if]
[/#if]
[#if  (INCLUDE_AD_TYPE_URI = "1")]
  ${AD_TYPE_URI_LENGTH}, AD_TYPE_URI, 0x${AD_TYPE_URI_CODE_POINT?replace(",",", 0x")}, '/', '/', [#rt]
    [#list AD_TYPE_URI_DATA?split("(?!^)", "r") as char][#t]
        [#lt]'${char}', [#rt]
    [/#list][#lt]

[/#if]
[#if  (INCLUDE_AD_TYPE_MANUFACTURER_SPECIFIC_DATA = "1")]
  ${AD_TYPE_MANUFACTURER_SPECIFIC_DATA_LENGTH}, AD_TYPE_MANUFACTURER_SPECIFIC_DATA, 0x${AD_TYPE_MANUFACTURER_SPECIFIC_DATA_COMPANY_IDENTIFIER?replace(",",", 0x")}, [#rt]
[#assign size = (AD_TYPE_MANUFACTURER_DATA_NBR?number-1)]
[#list 0..size as i]
0x${AD_TYPE_MANUFACTURER_DATA_TABLE[2*i]?replace(" ",", 0x")} /* ${AD_TYPE_MANUFACTURER_DATA_TABLE[2*i+1]} */, [#rt]
[/#list]
[/#if]

};
[/#if]
[#if  (CUSTOM_P2P_SERVER = 1)]
/**
 * Advertising Data
 */
#if (P2P_SERVER1 != 0)
static const char a_LocalName[] = {AD_TYPE_COMPLETE_LOCAL_NAME[#if P2P_SERVER_NUMBER = "P2P_SERVER1"] ${LOCAL_NAME_FORMATTED}[#else], 'P', '2', 'P', 'S', 'R', 'V', '1'[/#if]};
uint8_t a_ManufData[14] = {sizeof(a_ManufData)-1,
                           AD_TYPE_MANUFACTURER_SPECIFIC_DATA,
                           0x01,                               /*SKD version */
                           CFG_DEV_ID_P2P_SERVER1,             /* STM32WB - P2P Server 1*/
                           0x00,                               /* GROUP A Feature */ 
                           0x00,                               /* GROUP A Feature */
                           0x00,                               /* GROUP B Feature */
                           0x00,                               /* GROUP B Feature */
                           0x00,                               /* BLE MAC start -MSB */
                           0x00,
                           0x00,
                           0x00,
                           0x00,
                           0x00,                               /* BLE MAC stop */
                          };
#endif /* P2P_SERVER1 != 0 */
/**
 * Advertising Data
 */
#if (P2P_SERVER2 != 0)
static const char a_LocalName[] = {AD_TYPE_COMPLETE_LOCAL_NAME[#if P2P_SERVER_NUMBER = "P2P_SERVER2"] ${LOCAL_NAME_FORMATTED}[#else], 'P', '2', 'P', 'S', 'R', 'V', '2'[/#if]};
uint8_t a_ManufData[14] = {sizeof(a_ManufData)-1,
                           AD_TYPE_MANUFACTURER_SPECIFIC_DATA,
                           0x01,                               /*SKD version */
                           CFG_DEV_ID_P2P_SERVER2,             /* STM32WB - P2P Server 2*/
                           0x00,                               /* GROUP A Feature */ 
                           0x00,                               /* GROUP A Feature */
                           0x00,                               /* GROUP B Feature */
                           0x00,                               /* GROUP B Feature */
                           0x00,                               /* BLE MAC start -MSB */
                           0x00,
                           0x00,
                           0x00,
                           0x00,
                           0x00,                               /* BLE MAC stop */
                          };

#endif /* P2P_SERVER2 != 0 */

#if (P2P_SERVER3 != 0)
static const char a_LocalName[] = {AD_TYPE_COMPLETE_LOCAL_NAME[#if P2P_SERVER_NUMBER = "P2P_SERVER3"] ${LOCAL_NAME_FORMATTED}[#else], 'P', '2', 'P', 'S', 'R', 'V', '3'[/#if]};
uint8_t a_ManufData[14] = {sizeof(a_ManufData)-1,
                           AD_TYPE_MANUFACTURER_SPECIFIC_DATA,
                           0x01,                               /*SKD version */
                           CFG_DEV_ID_P2P_SERVER3,             /* STM32WB - P2P Server 3*/
                           0x00,                               /* GROUP A Feature */ 
                           0x00,                               /* GROUP A Feature */
                           0x00,                               /* GROUP B Feature */
                           0x00,                               /* GROUP B Feature */
                           0x00,                               /* BLE MAC start -MSB */
                           0x00,
                           0x00,
                           0x00,
                           0x00,
                           0x00,                               /* BLE MAC stop */
                          };
#endif /* P2P_SERVER3 != 0 */

#if (P2P_SERVER4 != 0)
static const char a_LocalName[] = {AD_TYPE_COMPLETE_LOCAL_NAME[#if P2P_SERVER_NUMBER = "P2P_SERVER4"] ${LOCAL_NAME_FORMATTED}[#else], 'P', '2', 'P', 'S', 'R', 'V', '4'[/#if]};
uint8_t a_ManufData[14] = {sizeof(a_ManufData)-1,
                           AD_TYPE_MANUFACTURER_SPECIFIC_DATA,
                           0x01,                               /*SKD version */
                           CFG_DEV_ID_P2P_SERVER4,             /* STM32WB - P2P Server 4*/
                           0x00,                               /* GROUP A Feature */ 
                           0x00,                               /* GROUP A Feature */
                           0x00,                               /* GROUP B Feature */
                           0x00,                               /* GROUP B Feature */
                           0x00,                               /* BLE MAC start -MSB */
                           0x00,
                           0x00,
                           0x00,
                           0x00,
                           0x00,                               /* BLE MAC stop */
                          };
#endif /* P2P_SERVER4 != 0 */

#if (P2P_SERVER5 != 0)
static const char a_LocalName[] = {AD_TYPE_COMPLETE_LOCAL_NAME[#if P2P_SERVER_NUMBER = "P2P_SERVER5"] ${LOCAL_NAME_FORMATTED}[#else], 'P', '2', 'P', 'S', 'R', 'V', '5'[/#if]};
uint8_t a_ManufData[14] = {sizeof(a_ManufData)-1,
                           AD_TYPE_MANUFACTURER_SPECIFIC_DATA,
                           0x01,                               /*SKD version */
                           CFG_DEV_ID_P2P_SERVER5,             /* STM32WB - P2P Server 5*/
                           0x00,                               /* GROUP A Feature */ 
                           0x00,                               /* GROUP A Feature */
                           0x00,                               /* GROUP B Feature */
                           0x00,                               /* GROUP B Feature */
                           0x00,                               /* BLE MAC start -MSB */
                           0x00,
                           0x00,
                           0x00,
                           0x00,
                           0x00,                               /* BLE MAC stop */
                          };
#endif /* P2P_SERVER5 != 0 */

#if (P2P_SERVER6 != 0)
static const char a_LocalName[] = {AD_TYPE_COMPLETE_LOCAL_NAME[#if P2P_SERVER_NUMBER = "P2P_SERVER6"] ${LOCAL_NAME_FORMATTED}[#else], 'P', '2', 'P', 'S', 'R', 'V', '6'[/#if]};
uint8_t a_ManufData[14] = {sizeof(a_ManufData)-1,
                           AD_TYPE_MANUFACTURER_SPECIFIC_DATA,
                           0x01,                               /*SKD version */
                           CFG_DEV_ID_P2P_SERVER6,             /* STM32WB - P2P Server 6*/
                           0x00,                               /* GROUP A Feature */ 
                           0x00,                               /* GROUP A Feature */
                           0x00,                               /* GROUP B Feature */
                           0x00,                               /* GROUP B Feature */
                           0x00,                               /* BLE MAC start -MSB */
                           0x00,
                           0x00,
                           0x00,
                           0x00,
                           0x00,                               /* BLE MAC stop */
                          };
#endif /* P2P_SERVER6 != 0 */
[#else]
[#if (BT_SIG_HEART_RATE_SENSOR = 1) || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)]
static const char a_LocalName[] = {AD_TYPE_COMPLETE_LOCAL_NAME ${LOCAL_NAME_FORMATTED}};
uint8_t a_ManufData[14] = {sizeof(a_ManufData)-1,
                           AD_TYPE_MANUFACTURER_SPECIFIC_DATA,
                           0x01 /*SKD version */,
                           0x00 /* Generic*/,
                           0x00 /* GROUP A Feature  */,
                           0x00 /* GROUP A Feature */,
                           0x00 /* GROUP B Feature */,
                           0x00 /* GROUP B Feature */,
                           0x00, /* BLE MAC start -MSB */
                           0x00,
                           0x00,
                           0x00,
                           0x00,
                           0x00, /* BLE MAC stop */
                          };
[/#if]
[/#if]

/* USER CODE BEGIN PV */

/* USER CODE END PV */

[#if  (FREERTOS_STATUS = 1)]
/* Global variables ----------------------------------------------------------*/
osMutexId_t MtxHciId;
osSemaphoreId_t SemHciId;
osThreadId_t AdvUpdateProcessId;
osThreadId_t HciUserEvtProcessId;

const osThreadAttr_t AdvUpdateProcess_attr = {
    .name = CFG_ADV_UPDATE_PROCESS_NAME,
    .attr_bits = CFG_ADV_UPDATE_PROCESS_ATTR_BITS,
    .cb_mem = CFG_ADV_UPDATE_PROCESS_CB_MEM,
    .cb_size = CFG_ADV_UPDATE_PROCESS_CB_SIZE,
    .stack_mem = CFG_ADV_UPDATE_PROCESS_STACK_MEM,
    .priority = CFG_ADV_UPDATE_PROCESS_PRIORITY,
    .stack_size = CFG_ADV_UPDATE_PROCESS_STACK_SIZE
};

const osThreadAttr_t HciUserEvtProcess_attr = {
    .name = CFG_HCI_USER_EVT_PROCESS_NAME,
    .attr_bits = CFG_HCI_USER_EVT_PROCESS_ATTR_BITS,
    .cb_mem = CFG_HCI_USER_EVT_PROCESS_CB_MEM,
    .cb_size = CFG_HCI_USER_EVT_PROCESS_CB_SIZE,
    .stack_mem = CFG_HCI_USER_EVT_PROCESS_STACK_MEM,
    .priority = CFG_HCI_USER_EVT_PROCESS_PRIORITY,
    .stack_size = CFG_HCI_USER_EVT_PROCESS_STACK_SIZE
};

[/#if]
/* Private function prototypes -----------------------------------------------*/
[#if  (FREERTOS_STATUS = 1)]
static void HciUserEvtProcess(void *argument);
[/#if]
static void BLE_UserEvtRx(void *p_Payload);
static void BLE_StatusNot(HCI_TL_CmdStatus_t Status);
static void Ble_Tl_Init(void);
static void Ble_Hci_Gap_Gatt_Init(void);
[#if ((CFG_IDENTITY_ADDRESS = "GAP_PUBLIC_ADDR") && ((BT_SIG_BEACON != "0") || (BT_SIG_HEART_RATE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)))]
static const uint8_t* BleGetBdAddress(void);
[/#if]
[#if  (BT_SIG_BEACON != "0")]
static void Beacon_Update(void);
[/#if]
[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
static void Adv_Request(APP_BLE_ConnStatus_t NewStatus);
[/#if]
[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1)]
static void Add_Advertisment_Service_UUID(uint16_t servUUID);
static void Adv_Mgr(void);
[#if  (FREERTOS_STATUS = 1)]
static void AdvUpdateProcess(void *argument);
[/#if]
static void Adv_Update(void);
[/#if]
[#if  (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
static void Adv_Cancel(void);
[#if  (CUSTOM_P2P_SERVER = 1)]
static void Adv_Cancel_Req(void);
static void Switch_OFF_GPIO(void);
[/#if]
#if (L2CAP_REQUEST_NEW_CONN_PARAM != 0)
static void BLE_SVC_L2CAP_Conn_Update(uint16_t ConnectionHandle);
static void Connection_Interval_Update_Req(void);
#endif /* L2CAP_REQUEST_NEW_CONN_PARAM != 0 */
[/#if]

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* External variables --------------------------------------------------------*/
[#if  ((CFG_STATIC_RANDOM_ADDRESS == "0") && (CFG_RNG == "1") && ((BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)))]
extern RNG_HandleTypeDef hrng;
[/#if]

/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Functions Definition ------------------------------------------------------*/
void APP_BLE_Init(void)
{
  SHCI_CmdStatus_t status;
[#if  (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
#if (RADIO_ACTIVITY_EVENT != 0)
  tBleStatus ret = BLE_STATUS_INVALID_PARAMS;
#endif /* RADIO_ACTIVITY_EVENT != 0 */
[/#if]
  /* USER CODE BEGIN APP_BLE_Init_1 */

  /* USER CODE END APP_BLE_Init_1 */
  SHCI_C2_Ble_Init_Cmd_Packet_t ble_init_cmd_packet =
  {
    {{0,0,0}},                          /**< Header unused */
    {0,                                 /** pBleBufferAddress not used */
     0,                                 /** BleBufferSize not used */
     CFG_BLE_NUM_GATT_ATTRIBUTES,
     CFG_BLE_NUM_GATT_SERVICES,
     CFG_BLE_ATT_VALUE_ARRAY_SIZE,
     CFG_BLE_NUM_LINK,
     CFG_BLE_DATA_LENGTH_EXTENSION,
     CFG_BLE_PREPARE_WRITE_LIST_SIZE,
     CFG_BLE_MBLOCK_COUNT,
     CFG_BLE_MAX_ATT_MTU,
     CFG_BLE_SLAVE_SCA,
     CFG_BLE_MASTER_SCA,
     CFG_BLE_LS_SOURCE,
     CFG_BLE_MAX_CONN_EVENT_LENGTH,
     CFG_BLE_HSE_STARTUP_TIME,
     CFG_BLE_VITERBI_MODE,
     CFG_BLE_OPTIONS,
     0,
     CFG_BLE_MAX_COC_INITIATOR_NBR,
     CFG_BLE_MIN_TX_POWER,
     CFG_BLE_MAX_TX_POWER,
     CFG_BLE_RX_MODEL_CONFIG,
     CFG_BLE_MAX_ADV_SET_NBR, 
     CFG_BLE_MAX_ADV_DATA_LEN,
     CFG_BLE_TX_PATH_COMPENS,
     CFG_BLE_RX_PATH_COMPENS,
     CFG_BLE_CORE_VERSION
    }
  };

  /**
   * Initialize Ble Transport Layer
   */
  Ble_Tl_Init();

[#if DIE == "DIE494"]
#if (CFG_LPM_STANDBY_SUPPORTED == 0)
  UTIL_LPM_SetOffMode(1U << CFG_LPM_APP_BLE, UTIL_LPM_DISABLE);
#endif /* CFG_LPM_STANDBY_SUPPORTED == 0 */
[#else]
  /**
   * Do not allow standby in the application
   */
  UTIL_LPM_SetOffMode(1 << CFG_LPM_APP_BLE, UTIL_LPM_DISABLE);
[/#if]

  /**
   * Register the hci transport layer to handle BLE User Asynchronous Events
   */
[#if  (FREERTOS_STATUS = 0)]
  UTIL_SEQ_RegTask(1<<CFG_TASK_HCI_ASYNCH_EVT_ID, UTIL_SEQ_RFU, hci_user_evt_proc);
[#else]
  HciUserEvtProcessId = osThreadNew(HciUserEvtProcess, NULL, &HciUserEvtProcess_attr);
[/#if]

  /**
   * Starts the BLE Stack on CPU2
   */
  status = SHCI_C2_BLE_Init(&ble_init_cmd_packet);
  if (status != SHCI_Success)
  {
    APP_DBG_MSG("  Fail   : SHCI_C2_BLE_Init command, result: 0x%02x\n\r", status);
    /* if you are here, maybe CPU2 doesn't contain STM32WB_Copro_Wireless_Binaries, see Release_Notes.html */
    Error_Handler();
  }
  else
  {
    APP_DBG_MSG("  Success: SHCI_C2_BLE_Init command\n\r");
  }

  /**
   * Initialization of HCI & GATT & GAP layer
   */
  Ble_Hci_Gap_Gatt_Init();

  /**
   * Initialization of the BLE Services
   */
  SVCCTL_Init();

[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
  /**
   * Initialization of the BLE App Context
   */
  BleApplicationContext.Device_Connection_Status = APP_BLE_IDLE;
  BleApplicationContext.BleApplicationContext_legacy.connectionHandle = 0xFFFF;
  
[/#if]
  /**
   * From here, all initialization are BLE application specific
   */
[#if  (BT_SIG_BEACON != "0")]
  UTIL_SEQ_RegTask(1<<CFG_TASK_BEACON_UPDATE_REQ_ID, UTIL_SEQ_RFU, Beacon_Update);
[/#if]
[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1)]
[#if  (FREERTOS_STATUS = 0)]
  UTIL_SEQ_RegTask(1<<CFG_TASK_ADV_UPDATE_ID, UTIL_SEQ_RFU, Adv_Update);
[#else]
  AdvUpdateProcessId = osThreadNew(AdvUpdateProcess, NULL, &AdvUpdateProcess_attr);
[/#if]
[/#if]
[#if  (CUSTOM_P2P_SERVER = 1)]
  UTIL_SEQ_RegTask(1<<CFG_TASK_ADV_CANCEL_ID, UTIL_SEQ_RFU, Adv_Cancel);
#if (L2CAP_REQUEST_NEW_CONN_PARAM != 0)
  UTIL_SEQ_RegTask(1<<CFG_TASK_CONN_UPDATE_REG_ID, UTIL_SEQ_RFU, Connection_Interval_Update_Req);
#endif /* L2CAP_REQUEST_NEW_CONN_PARAM != 0 */
[/#if]

[#if  (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1)]
  /**
   * Initialization of ADV - Ad Manufacturer Element - Support OTA Bit Mask
   */
#if (BLE_CFG_OTA_REBOOT_CHAR != 0)
  a_ManufData[sizeof(a_ManufData)-8] = CFG_FEATURE_OTA_REBOOT;
#endif /* BLE_CFG_OTA_REBOOT_CHAR != 0 */

[/#if]
[#if  (CUSTOM_P2P_SERVER = 1)]
#if (RADIO_ACTIVITY_EVENT != 0)  
  ret = aci_hal_set_radio_activity_mask(0x0006);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_hal_set_radio_activity_mask command, result: 0x%x \n\r", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_hal_set_radio_activity_mask command\n\r");
  }
#endif /* RADIO_ACTIVITY_EVENT != 0 */
  
#if (L2CAP_REQUEST_NEW_CONN_PARAM != 0)
  index_con_int = 0; 
  mutex = 1; 
#endif /* L2CAP_REQUEST_NEW_CONN_PARAM != 0 */

[/#if]
[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1)]
  /**
   * Initialize Blood Pressure Service
   */
  BLSAPP_Init();

[/#if]
[#if  (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1) || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1)]
  /**
   * Initialize DIS Application
   */
  DISAPP_Init();

[/#if]
[#if  (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)]
  /**
   * Initialize HTS Application
   */
  HTSAPP_Init();

[/#if]
[#if  (BT_SIG_HEART_RATE_SENSOR = 1)]
  /**
   * Initialize HRS Application
   */
  HRSAPP_Init();

[/#if]
[#if  (CUSTOM_P2P_SERVER = 1)]
  /**
   * Initialize P2P Server Application
   */
  P2PS_APP_Init();

[/#if]
[#if  (CUSTOM_TEMPLATE = 1)]
  UTIL_SEQ_RegTask(1<<CFG_TASK_ADV_CANCEL_ID, UTIL_SEQ_RFU, Adv_Cancel);

  /* USER CODE BEGIN APP_BLE_Init_4 */

  /* USER CODE END APP_BLE_Init_4 */

  /**
   * Initialization of ADV - Ad Manufacturer Element - Support OTA Bit Mask
   */
#if (RADIO_ACTIVITY_EVENT != 0)
  ret = aci_hal_set_radio_activity_mask(0x0006);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_hal_set_radio_activity_mask command, result: 0x%x \n\r", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_hal_set_radio_activity_mask command\n\r");
  }
#endif /* RADIO_ACTIVITY_EVENT != 0 */
  
#if (L2CAP_REQUEST_NEW_CONN_PARAM != 0)
  index_con_int = 0; 
  mutex = 1; 
#endif /* L2CAP_REQUEST_NEW_CONN_PARAM != 0 */

  /**
   * Initialize Custom Template Application
   */
  Custom_APP_Init();

[/#if]
  /* USER CODE BEGIN APP_BLE_Init_3 */

  /* USER CODE END APP_BLE_Init_3 */

[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1)]
  /**
   * Create timer to handle the connection state machine
   */
  HW_TS_Create(CFG_TIM_PROC_ID_ISR, &(BleApplicationContext.Advertising_mgr_timer_Id), hw_ts_SingleShot, Adv_Mgr);

[/#if]
[#if  (CUSTOM_P2P_SERVER = 1)]
  /**
   * Create timer to handle the Advertising Stop
   */
  HW_TS_Create(CFG_TIM_PROC_ID_ISR, &(BleApplicationContext.Advertising_mgr_timer_Id), hw_ts_SingleShot, Adv_Cancel_Req);
  /**
   * Create timer to handle the Led Switch OFF
   */
  HW_TS_Create(CFG_TIM_PROC_ID_ISR, &(BleApplicationContext.SwitchOffGPIO_timer_Id), hw_ts_SingleShot, Switch_OFF_GPIO);

[/#if]
  /**
   * Make device discoverable
   */
[#if  (BT_SIG_BEACON != "0")]
  if (CFG_BEACON_TYPE & CFG_EDDYSTONE_UID_BEACON_TYPE)
  {
    APP_DBG_MSG("Eddystone UID beacon advertise\n\r");
    EddystoneUID_Process();
  }
  else if (CFG_BEACON_TYPE & CFG_EDDYSTONE_URL_BEACON_TYPE)
  {
    APP_DBG_MSG("Eddystone URL beacon advertise\n\r");
    EddystoneURL_Process();
  }
  else if (CFG_BEACON_TYPE & CFG_EDDYSTONE_TLM_BEACON_TYPE)
  {
    APP_DBG_MSG("Eddystone TLM beacon advertise\n\r");
    EddystoneTLM_Process();
  }
  else if (CFG_BEACON_TYPE & CFG_IBEACON)
  {
    APP_DBG_MSG("Ibeacon advertise\n\r");
    IBeacon_Process();
  }
[/#if]   
[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1)]
  BleApplicationContext.BleApplicationContext_legacy.advtServUUID[0] = AD_TYPE_16_BIT_SERV_UUID;
  BleApplicationContext.BleApplicationContext_legacy.advtServUUIDlen = 1;
[/#if]
[#if  (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
  BleApplicationContext.BleApplicationContext_legacy.advtServUUID[0] = NULL;
  BleApplicationContext.BleApplicationContext_legacy.advtServUUIDlen = 0;

[/#if]
[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1)]
  Add_Advertisment_Service_UUID(BLOOD_PRESSURE_SERVICE_UUID);
  
[/#if]
[#if  (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)]
  Add_Advertisment_Service_UUID(HEALTH_THERMOMETER_SERVICE_UUID);
  
[/#if]
[#if  (BT_SIG_HEART_RATE_SENSOR = 1)]
  Add_Advertisment_Service_UUID(HEART_RATE_SERVICE_UUID);
  
[/#if]
[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)] 
[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1)]
  /* Initialize intervals for reconnexion without intervals update */
  AdvIntervalMin = CFG_FAST_CONN_ADV_INTERVAL_MIN;
  AdvIntervalMax = CFG_FAST_CONN_ADV_INTERVAL_MAX;

[/#if]
[#if (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1)] 
  /**
   * Start to Advertise to be connected by Collector
   */
[/#if]
[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1)] 
  /**
   * Start to Advertise to be connected by a Client
   */
[/#if]
[#if  (CUSTOM_P2P_SERVER = 1)] 
  /**
   * Start to Advertise to be connected by P2P Client
   */
[/#if]
[#if  (CUSTOM_TEMPLATE = 1)] 
  /**
   * Start to Advertise to be connected by a Client
   */
[/#if]
  Adv_Request(APP_BLE_FAST_ADV);

[/#if]
  /* USER CODE BEGIN APP_BLE_Init_2 */

  /* USER CODE END APP_BLE_Init_2 */

  return;
}


SVCCTL_UserEvtFlowStatus_t SVCCTL_App_Notification(void *p_Pckt)
{
  hci_event_pckt    *p_event_pckt;
  evt_le_meta_event *p_meta_evt;
  evt_blecore_aci   *p_blecore_evt;
[#if  (BT_SIG_BEACON = "0") && ((BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) ||(CUSTOM_P2P_SERVER = 1))]
  uint8_t           Tx_phy, Rx_phy;
[/#if]
[#if  (BT_SIG_BEACON = "0") && ((BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1))]
  tBleStatus        ret = BLE_STATUS_INVALID_PARAMS;
[/#if]
[#if  (BT_SIG_BEACON = "0") && ((BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1))]
[#if CFG_PRIVACY =="PRIVACY_DISABLED"]
  hci_le_connection_complete_event_rp0        *p_connection_complete_event;
[#else]
  hci_le_enhanced_connection_complete_event_rp0 *p_enhanced_connection_complete_event;
[/#if]
[/#if]
[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) ||(CUSTOM_P2P_SERVER = 1) ||(CUSTOM_TEMPLATE = 1)] 
  hci_disconnection_complete_event_rp0        *p_disconnection_complete_event;
[/#if]
[#if  (BT_SIG_BEACON = "0") && ((BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) ||(CUSTOM_P2P_SERVER = 1))]
  hci_le_phy_update_complete_event_rp0        *p_evt_le_phy_update_complete; 
[/#if]
[#if  (BT_SIG_BEACON = "0") && ((BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1))]
#if (CFG_DEBUG_APP_TRACE != 0)
  hci_le_connection_update_complete_event_rp0 *p_connection_update_complete_event;
#endif /* CFG_DEBUG_APP_TRACE != 0 */
[/#if]

[#if (CUSTOM_TEMPLATE = 1)]

  /* PAIRING */
[#--  aci_gap_numeric_comparison_value_event_rp0 *evt_numeric_value;--]
  aci_gap_pairing_complete_event_rp0          *p_pairing_complete;
[#--  uint32_t numeric_value;--]
  /* PAIRING */
[/#if]

  /* USER CODE BEGIN SVCCTL_App_Notification */

  /* USER CODE END SVCCTL_App_Notification */

  p_event_pckt = (hci_event_pckt*) ((hci_uart_pckt *) p_Pckt)->data;

  switch (p_event_pckt->evt)
  {
    case HCI_DISCONNECTION_COMPLETE_EVT_CODE:
[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) ||(CUSTOM_P2P_SERVER = 1) ||(CUSTOM_TEMPLATE = 1)] 
    {
      p_disconnection_complete_event = (hci_disconnection_complete_event_rp0 *) p_event_pckt->data;

      if (p_disconnection_complete_event->Connection_Handle == BleApplicationContext.BleApplicationContext_legacy.connectionHandle)
      {
        BleApplicationContext.BleApplicationContext_legacy.connectionHandle = 0;
        BleApplicationContext.Device_Connection_Status = APP_BLE_IDLE;
        APP_DBG_MSG(">>== HCI_DISCONNECTION_COMPLETE_EVT_CODE\n");
        APP_DBG_MSG("     - Connection Handle:   0x%x\n     - Reason:    0x%x\n\r", 
                    p_disconnection_complete_event->Connection_Handle,
                    p_disconnection_complete_event->Reason);

        /* USER CODE BEGIN EVT_DISCONN_COMPLETE_2 */

        /* USER CODE END EVT_DISCONN_COMPLETE_2 */
      }

      /* USER CODE BEGIN EVT_DISCONN_COMPLETE_1 */

      /* USER CODE END EVT_DISCONN_COMPLETE_1 */

      /* restart advertising */
      Adv_Request(APP_BLE_FAST_ADV);

[#if (CUSTOM_TEMPLATE = 1)]
      /**
       * SPECIFIC to Custom Template APP
       */
      HandleNotification.Custom_Evt_Opcode = CUSTOM_DISCON_HANDLE_EVT;
      HandleNotification.ConnectionHandle = BleApplicationContext.BleApplicationContext_legacy.connectionHandle;
      Custom_APP_Notification(&HandleNotification);
[#else]
[#if  (CUSTOM_P2P_SERVER = 1)]
      /**
       * SPECIFIC to P2P Server APP
       */
      HandleNotification.P2P_Evt_Opcode = PEER_DISCON_HANDLE_EVT;
      HandleNotification.ConnectionHandle = BleApplicationContext.BleApplicationContext_legacy.connectionHandle;
      P2PS_APP_Notification(&HandleNotification);
[/#if]
[/#if]
[/#if]
      /* USER CODE BEGIN EVT_DISCONN_COMPLETE */

      /* USER CODE END EVT_DISCONN_COMPLETE */
      break; /* HCI_DISCONNECTION_COMPLETE_EVT_CODE */
[#if  (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) ||(CUSTOM_P2P_SERVER = 1) ||(CUSTOM_TEMPLATE = 1)] 
    }
[/#if]

    case HCI_LE_META_EVT_CODE:
[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1) ||(CUSTOM_P2P_SERVER = 1) ||(CUSTOM_TEMPLATE = 1)]
    {
[/#if]
      p_meta_evt = (evt_le_meta_event*) p_event_pckt->data;
      /* USER CODE BEGIN EVT_LE_META_EVENT */

      /* USER CODE END EVT_LE_META_EVENT */
      switch (p_meta_evt->subevent)
      {
[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1) ||(CUSTOM_P2P_SERVER = 1) ||(CUSTOM_TEMPLATE = 1)]
        case HCI_LE_CONNECTION_UPDATE_COMPLETE_SUBEVT_CODE:
#if (CFG_DEBUG_APP_TRACE != 0)
          p_connection_update_complete_event = (hci_le_connection_update_complete_event_rp0 *) p_meta_evt->data;
          APP_DBG_MSG(">>== HCI_LE_CONNECTION_UPDATE_COMPLETE_SUBEVT_CODE\n");
          APP_DBG_MSG("     - Connection Interval:   %.2f ms\n     - Connection latency:    %d\n     - Supervision Timeout: %d ms\n\r",
                       p_connection_update_complete_event->Conn_Interval*1.25,
                       p_connection_update_complete_event->Conn_Latency,
                       p_connection_update_complete_event->Supervision_Timeout*10);
#endif /* CFG_DEBUG_APP_TRACE != 0 */

          /* USER CODE BEGIN EVT_LE_CONN_UPDATE_COMPLETE */

          /* USER CODE END EVT_LE_CONN_UPDATE_COMPLETE */
          break;

[/#if]
[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1) ||(CUSTOM_P2P_SERVER = 1)]
        case HCI_LE_PHY_UPDATE_COMPLETE_SUBEVT_CODE:
          p_evt_le_phy_update_complete = (hci_le_phy_update_complete_event_rp0*)p_meta_evt->data;
          APP_DBG_MSG("==>> HCI_LE_PHY_UPDATE_COMPLETE_SUBEVT_CODE - ");
          if (p_evt_le_phy_update_complete->Status == 0)
          {
            APP_DBG_MSG("status ok \n");
          }
          else
          {
            APP_DBG_MSG("status nok \n");
          }

          ret = hci_le_read_phy(BleApplicationContext.BleApplicationContext_legacy.connectionHandle, &Tx_phy, &Rx_phy);
          if (ret != BLE_STATUS_SUCCESS)
          {
            APP_DBG_MSG("==>> hci_le_read_phy : fail\n\r");
          }
          else
          {
            APP_DBG_MSG("==>> hci_le_read_phy - Success \n");

            if ((Tx_phy == TX_2M) && (Rx_phy == RX_2M))
            {
              APP_DBG_MSG("==>> PHY Param  TX= %d, RX= %d \n\r", Tx_phy, Rx_phy);
            }
            else
            {
              APP_DBG_MSG("==>> PHY Param  TX= %d, RX= %d \n\r", Tx_phy, Rx_phy);
            }
          }
          /* USER CODE BEGIN EVT_LE_PHY_UPDATE_COMPLETE */

          /* USER CODE END EVT_LE_PHY_UPDATE_COMPLETE */
          break;

[/#if]
[#if CFG_PRIVACY =="PRIVACY_DISABLED"]
        case HCI_LE_CONNECTION_COMPLETE_SUBEVT_CODE:
[#else]
        case HCI_LE_ENHANCED_CONNECTION_COMPLETE_SUBEVT_CODE:
[/#if]
[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) ||(CUSTOM_P2P_SERVER = 1) ||(CUSTOM_TEMPLATE = 1)]
        {
[#if CFG_PRIVACY =="PRIVACY_DISABLED"]
          p_connection_complete_event = (hci_le_connection_complete_event_rp0 *) p_meta_evt->data;
[#else]
          p_enhanced_connection_complete_event = (hci_le_enhanced_connection_complete_event_rp0 *) p_meta_evt->data;
[/#if]
          /**
           * The connection is done, there is no need anymore to schedule the LP ADV
           */

[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1) ||(CUSTOM_P2P_SERVER = 1)]
          HW_TS_Stop(BleApplicationContext.Advertising_mgr_timer_Id);
[/#if]

[#if CFG_PRIVACY =="PRIVACY_DISABLED"]
          APP_DBG_MSG(">>== HCI_LE_CONNECTION_COMPLETE_SUBEVT_CODE - Connection handle: 0x%x\n", p_connection_complete_event->Connection_Handle);
          APP_DBG_MSG("     - Connection established with Central: @:%02x:%02x:%02x:%02x:%02x:%02x\n",
                      p_connection_complete_event->Peer_Address[5],
                      p_connection_complete_event->Peer_Address[4],
                      p_connection_complete_event->Peer_Address[3],
                      p_connection_complete_event->Peer_Address[2],
                      p_connection_complete_event->Peer_Address[1],
                      p_connection_complete_event->Peer_Address[0]);
          APP_DBG_MSG("     - Connection Interval:   %.2f ms\n     - Connection latency:    %d\n     - Supervision Timeout: %d ms\n\r",
                      p_connection_complete_event->Conn_Interval*1.25,
                      p_connection_complete_event->Conn_Latency,
                      p_connection_complete_event->Supervision_Timeout*10
                     );
[#else]
          APP_DBG_MSG(">>== HCI_LE_ENHANCED_CONNECTION_COMPLETE_SUBEVT_CODE - Connection handle: 0x%x\n", p_enhanced_connection_complete_event->Connection_Handle);
          APP_DBG_MSG("     - Connection established with Central: @:%02x:%02x:%02x:%02x:%02x:%02x\n",
                      p_enhanced_connection_complete_event->Peer_Address[5],
                      p_enhanced_connection_complete_event->Peer_Address[4],
                      p_enhanced_connection_complete_event->Peer_Address[3],
                      p_enhanced_connection_complete_event->Peer_Address[2],
                      p_enhanced_connection_complete_event->Peer_Address[1],
                      p_enhanced_connection_complete_event->Peer_Address[0]);
          APP_DBG_MSG("     - Connection Interval:   %.2f ms\n     - Connection latency:    %d\n     - Supervision Timeout: %d ms\n\r",
                      p_enhanced_connection_complete_event->Conn_Interval*1.25,
                      p_enhanced_connection_complete_event->Conn_Latency,
                      p_enhanced_connection_complete_event->Supervision_Timeout*10
                     );
[/#if]

          if (BleApplicationContext.Device_Connection_Status == APP_BLE_LP_CONNECTING)
          {
            /* Connection as client */
            BleApplicationContext.Device_Connection_Status = APP_BLE_CONNECTED_CLIENT;
          }
          else
          {
            /* Connection as server */
            BleApplicationContext.Device_Connection_Status = APP_BLE_CONNECTED_SERVER;
          }
[#if CFG_PRIVACY =="PRIVACY_DISABLED"]
          BleApplicationContext.BleApplicationContext_legacy.connectionHandle = p_connection_complete_event->Connection_Handle;
[#else]
          BleApplicationContext.BleApplicationContext_legacy.connectionHandle = p_enhanced_connection_complete_event->Connection_Handle;
[/#if]
[#if  (CUSTOM_TEMPLATE = 1)]
          /**
           * SPECIFIC to Custom Template APP
           */
          HandleNotification.Custom_Evt_Opcode = CUSTOM_CONN_HANDLE_EVT;
          HandleNotification.ConnectionHandle = BleApplicationContext.BleApplicationContext_legacy.connectionHandle;
          Custom_APP_Notification(&HandleNotification);
[#else]
[#if  (CUSTOM_P2P_SERVER = 1)] 
          /**
           * SPECIFIC to P2P Server APP
           */
          HandleNotification.P2P_Evt_Opcode = PEER_CONN_HANDLE_EVT;
          HandleNotification.ConnectionHandle = BleApplicationContext.BleApplicationContext_legacy.connectionHandle;
          P2PS_APP_Notification(&HandleNotification);
[/#if]
[/#if]
[#if CFG_PRIVACY =="PRIVACY_DISABLED"]
          /* USER CODE BEGIN HCI_EVT_LE_CONN_COMPLETE */

          /* USER CODE END HCI_EVT_LE_CONN_COMPLETE */
          break; /* HCI_LE_CONNECTION_COMPLETE_SUBEVT_CODE */
[#else]
          /* USER CODE BEGIN HCI_LE_ENHANCED_CONNECTION_COMPLETE_SUBEVT_CODE */

          /* USER CODE END HCI_LE_ENHANCED_CONNECTION_COMPLETE_SUBEVT_CODE */
          break; /* HCI_LE_ENHANCED_CONNECTION_COMPLETE_SUBEVT_CODE */
[/#if]
        }
[#else]
          /* USER CODE BEGIN SUBEVENT_DEFAULT */

          /* USER CODE END SUBEVENT_DEFAULT */
          break;

[/#if]
        
        default:
          /* USER CODE BEGIN SUBEVENT_DEFAULT */

          /* USER CODE END SUBEVENT_DEFAULT */
          break;
      }
	  
      /* USER CODE BEGIN META_EVT */

      /* USER CODE END META_EVT */
      break; /* HCI_LE_META_EVT_CODE */
[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
    }
[/#if]

    case HCI_VENDOR_SPECIFIC_DEBUG_EVT_CODE:
      p_blecore_evt = (evt_blecore_aci*) p_event_pckt->data;
      /* USER CODE BEGIN EVT_VENDOR */

      /* USER CODE END EVT_VENDOR */
      switch (p_blecore_evt->ecode)
      {
        /* USER CODE BEGIN ecode */

        /* USER CODE END ecode */
	  
[#if (CUSTOM_P2P_SERVER = 1)]
        /**
         * SPECIFIC to P2P Server APP
         */
[/#if]
[#if (CUSTOM_TEMPLATE = 1)]
        /**
         * SPECIFIC to Custom Template APP
         */
[/#if]
[#if (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
        case ACI_L2CAP_CONNECTION_UPDATE_RESP_VSEVT_CODE:
#if (L2CAP_REQUEST_NEW_CONN_PARAM != 0)
          mutex = 1;
#endif /* L2CAP_REQUEST_NEW_CONN_PARAM != 0 */
          /* USER CODE BEGIN EVT_BLUE_L2CAP_CONNECTION_UPDATE_RESP */

          /* USER CODE END EVT_BLUE_L2CAP_CONNECTION_UPDATE_RESP */
          break;

[/#if]
        case ACI_GAP_PROC_COMPLETE_VSEVT_CODE:
[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
          APP_DBG_MSG(">>== ACI_GAP_PROC_COMPLETE_VSEVT_CODE \r");
[/#if]
          /* USER CODE BEGIN EVT_BLUE_GAP_PROCEDURE_COMPLETE */

          /* USER CODE END EVT_BLUE_GAP_PROCEDURE_COMPLETE */
          break; /* ACI_GAP_PROC_COMPLETE_VSEVT_CODE */

[#if (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
#if (RADIO_ACTIVITY_EVENT != 0)
        case ACI_HAL_END_OF_RADIO_ACTIVITY_VSEVT_CODE:
          /* USER CODE BEGIN RADIO_ACTIVITY_EVENT*/

          /* USER CODE END RADIO_ACTIVITY_EVENT*/
          break; /* ACI_HAL_END_OF_RADIO_ACTIVITY_VSEVT_CODE */
#endif /* RADIO_ACTIVITY_EVENT != 0 */

[/#if]
[#if (CUSTOM_TEMPLATE = 1)]
        /* PAIRING */
        case (ACI_GAP_KEYPRESS_NOTIFICATION_VSEVT_CODE):
          APP_DBG_MSG(">>== ACI_GAP_KEYPRESS_NOTIFICATION_VSEVT_CODE\n");
          /* USER CODE BEGIN ACI_GAP_KEYPRESS_NOTIFICATION_VSEVT_CODE*/

          /* USER CODE END ACI_GAP_KEYPRESS_NOTIFICATION_VSEVT_CODE*/
          break;
          
        case ACI_GAP_PASS_KEY_REQ_VSEVT_CODE:
          APP_DBG_MSG(">>== ACI_GAP_PASS_KEY_REQ_VSEVT_CODE \n");
		  
          ret = aci_gap_pass_key_resp(BleApplicationContext.BleApplicationContext_legacy.connectionHandle, CFG_FIXED_PIN);
          if (ret != BLE_STATUS_SUCCESS)
          {
            APP_DBG_MSG("==>> aci_gap_pass_key_resp : Fail, reason: 0x%x\n", ret);
          } 
          else 
          {
            APP_DBG_MSG("==>> aci_gap_pass_key_resp : Success \n");
          }
          /* USER CODE BEGIN ACI_GAP_PASS_KEY_REQ_VSEVT_CODE*/

          /* USER CODE END ACI_GAP_PASS_KEY_REQ_VSEVT_CODE*/
          break;
        
        case ACI_GAP_NUMERIC_COMPARISON_VALUE_VSEVT_CODE:
          APP_DBG_MSG(">>== ACI_GAP_NUMERIC_COMPARISON_VALUE_VSEVT_CODE\n");
          APP_DBG_MSG("     - numeric_value = %ld\n",
                      ((aci_gap_numeric_comparison_value_event_rp0 *)(p_blecore_evt->data))->Numeric_Value);
          APP_DBG_MSG("     - Hex_value = %lx\n",
                      ((aci_gap_numeric_comparison_value_event_rp0 *)(p_blecore_evt->data))->Numeric_Value);
          ret = aci_gap_numeric_comparison_value_confirm_yesno(BleApplicationContext.BleApplicationContext_legacy.connectionHandle, YES);
          if (ret != BLE_STATUS_SUCCESS)
          {
            APP_DBG_MSG("==>> aci_gap_numeric_comparison_value_confirm_yesno-->YES : Fail, reason: 0x%x\n", ret);
          } 
          else 
          {
            APP_DBG_MSG("==>> aci_gap_numeric_comparison_value_confirm_yesno-->YES : Success \n");
          }
          /* USER CODE BEGIN ACI_GAP_NUMERIC_COMPARISON_VALUE_VSEVT_CODE*/

          /* USER CODE END ACI_GAP_NUMERIC_COMPARISON_VALUE_VSEVT_CODE*/
          break;
        
        case ACI_GAP_PAIRING_COMPLETE_VSEVT_CODE:
          p_pairing_complete = (aci_gap_pairing_complete_event_rp0*)p_blecore_evt->data;

          APP_DBG_MSG(">>== ACI_GAP_PAIRING_COMPLETE_VSEVT_CODE\n");
          if (p_pairing_complete->Status != 0)
          {
            APP_DBG_MSG("     - Pairing KO \n     - Status: 0x%x\n     - Reason: 0x%x\n", p_pairing_complete->Status, p_pairing_complete->Reason);
          }
          else
          {
            APP_DBG_MSG("     - Pairing Success\n");
          }
          APP_DBG_MSG("\n");

          /* USER CODE BEGIN ACI_GAP_PAIRING_COMPLETE_VSEVT_CODE*/

          /* USER CODE END ACI_GAP_PAIRING_COMPLETE_VSEVT_CODE*/
          break;
        /* PAIRING */
[/#if]

        /* USER CODE BEGIN BLUE_EVT */

        /* USER CODE END BLUE_EVT */
      }
      break; /* HCI_VENDOR_SPECIFIC_DEBUG_EVT_CODE */

      /* USER CODE BEGIN EVENT_PCKT */

      /* USER CODE END EVENT_PCKT */

    default:
      /* USER CODE BEGIN ECODE_DEFAULT*/

      /* USER CODE END ECODE_DEFAULT*/
      break;
  }

  return (SVCCTL_UserEvtFlowEnable);
}

[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
APP_BLE_ConnStatus_t APP_BLE_Get_Server_Connection_Status(void)
{
  return BleApplicationContext.Device_Connection_Status;
}
[/#if]

/* USER CODE BEGIN FD*/

/* USER CODE END FD*/

/*************************************************************
 *
 * LOCAL FUNCTIONS
 *
 *************************************************************/
static void Ble_Tl_Init(void)
{
  HCI_TL_HciInitConf_t Hci_Tl_Init_Conf;

[#if (FREERTOS_STATUS = 1)]
  MtxHciId = osMutexNew(NULL);
  SemHciId = osSemaphoreNew(1, 0, NULL); /*< Create the semaphore and make it busy at initialization */

[/#if]
  Hci_Tl_Init_Conf.p_cmdbuffer = (uint8_t*)&BleCmdBuffer;
  Hci_Tl_Init_Conf.StatusNotCallBack = BLE_StatusNot;
  hci_init(BLE_UserEvtRx, (void*) &Hci_Tl_Init_Conf);

  return;
}

static void Ble_Hci_Gap_Gatt_Init(void)
{
  uint8_t role;
  uint16_t gap_service_handle, gap_dev_name_char_handle, gap_appearance_char_handle;
[#if ((CFG_IDENTITY_ADDRESS = "GAP_PUBLIC_ADDR") && ((BT_SIG_BEACON != "0") || (BT_SIG_HEART_RATE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)))]
  const uint8_t *p_bd_addr;
[/#if]
[#if ((CFG_IDENTITY_ADDRESS = "GAP_STATIC_RANDOM_ADDR") && ((BT_SIG_HEART_RATE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)))]
  uint32_t a_srd_bd_addr[2] = {0,0};
[/#if]
  uint16_t a_appearance[1] = {BLE_CFG_GAP_APPEARANCE}; 
  tBleStatus ret = BLE_STATUS_INVALID_PARAMS;
  /* USER CODE BEGIN Ble_Hci_Gap_Gatt_Init*/

  /* USER CODE END Ble_Hci_Gap_Gatt_Init*/

  APP_DBG_MSG("==>> Start Ble_Hci_Gap_Gatt_Init function\n");

  /**
   * Initialize HCI layer
   */
  /*HCI Reset to synchronise BLE Stack*/
  ret = hci_reset();
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : hci_reset command, result: 0x%x \n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: hci_reset command\n");
  }

[#if ((CFG_IDENTITY_ADDRESS = "GAP_PUBLIC_ADDR") && ((BT_SIG_BEACON != "0") || (BT_SIG_HEART_RATE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)))]
  /**
   * Write the BD Address
   */
  p_bd_addr = BleGetBdAddress();
  ret = aci_hal_write_config_data(CONFIG_DATA_PUBADDR_OFFSET, CONFIG_DATA_PUBADDR_LEN, (uint8_t*) p_bd_addr);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_hal_write_config_data command - CONFIG_DATA_PUBADDR_OFFSET, result: 0x%x \n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_hal_write_config_data command - CONFIG_DATA_PUBADDR_OFFSET\n");
    APP_DBG_MSG("  Public Bluetooth Address: %02x:%02x:%02x:%02x:%02x:%02x\n",p_bd_addr[5],p_bd_addr[4],p_bd_addr[3],p_bd_addr[2],p_bd_addr[1],p_bd_addr[0]);
  }
[/#if]

[#if (BT_SIG_HEART_RATE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
[#if (BT_SIG_HEART_RATE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1)]
[#if (CFG_IDENTITY_ADDRESS == "GAP_PUBLIC_ADDR") && (BLE_ADDR_TYPE == "GAP_RESOLVABLE_PRIVATE_ADDR")]
[#else]
#if (CFG_BLE_ADDRESS_TYPE == PUBLIC_ADDR)
  /* BLE MAC in ADV Packet */
  a_ManufData[ sizeof(a_ManufData)-6] = p_bd_addr[5];
  a_ManufData[ sizeof(a_ManufData)-5] = p_bd_addr[4];
  a_ManufData[ sizeof(a_ManufData)-4] = p_bd_addr[3];
  a_ManufData[ sizeof(a_ManufData)-3] = p_bd_addr[2];
  a_ManufData[ sizeof(a_ManufData)-2] = p_bd_addr[1];
  a_ManufData[ sizeof(a_ManufData)-1] = p_bd_addr[0];
#endif /* CFG_BLE_ADDRESS_TYPE == PUBLIC_ADDR */
[/#if]
[/#if]

[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
  /**
   * Static random Address
   * The two upper bits shall be set to 1
   * The lowest 32bits is read from the UDN to differentiate between devices
   * The RNG may be used to provide a random number on each power on
   */
[#if (CFG_IDENTITY_ADDRESS == "GAP_PUBLIC_ADDR") && (BLE_ADDR_TYPE == "GAP_RESOLVABLE_PRIVATE_ADDR")]
[#else]
#if (CFG_IDENTITY_ADDRESS == GAP_STATIC_RANDOM_ADDR)
#if defined(CFG_STATIC_RANDOM_ADDRESS)
  a_srd_bd_addr[0] = CFG_STATIC_RANDOM_ADDRESS & 0xFFFFFFFF;
  a_srd_bd_addr[1] = (uint32_t)((uint64_t)CFG_STATIC_RANDOM_ADDRESS >> 32);
  a_srd_bd_addr[1] |= 0xC000; /* The two upper bits shall be set to 1 */
#else
  /* Get RNG semaphore */
  while(LL_HSEM_1StepLock(HSEM, CFG_HW_RNG_SEMID));

  /* Enable RNG */
  __HAL_RNG_ENABLE(&hrng);

[#if DIE == "DIE495"]
  /* Enable HSI48 oscillator */
  LL_RCC_HSI48_Enable();
  /* Wait until HSI48 is ready */
  while(! LL_RCC_HSI48_IsReady());
[/#if]

  if (HAL_RNG_GenerateRandomNumber(&hrng, &a_srd_bd_addr[1]) != HAL_OK)
  {
    /* Random number generation error */
    Error_Handler();
  }
  if (HAL_RNG_GenerateRandomNumber(&hrng, &a_srd_bd_addr[0]) != HAL_OK)
  {
    /* Random number generation error */
    Error_Handler();
  }
  a_srd_bd_addr[1] |= 0xC000; /* The two upper bits shall be set to 1 */

[#if DIE == "DIE495"]
  /* Disable HSI48 oscillator */
  LL_RCC_HSI48_Disable();
[/#if]

  /* Disable RNG */
  __HAL_RNG_DISABLE(&hrng);
  
  /* Release RNG semaphore */
  LL_HSEM_ReleaseLock(HSEM, CFG_HW_RNG_SEMID, 0);
#endif /* CFG_STATIC_RANDOM_ADDRESS */
#endif

[#if (BT_SIG_HEART_RATE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
[#if CFG_IDENTITY_ADDRESS =="GAP_STATIC_RANDOM_ADDR"]
#if (CFG_BLE_ADDRESS_TYPE == GAP_STATIC_RANDOM_ADDR)
[#else]
#if (CFG_BLE_ADDRESS_TYPE != PUBLIC_ADDR)
[/#if]
[#if (BT_SIG_HEART_RATE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1)]
  /* BLE MAC in ADV Packet */
  a_ManufData[ sizeof(a_ManufData)-6] = a_srd_bd_addr[1] >> 8 ;
  a_ManufData[ sizeof(a_ManufData)-5] = a_srd_bd_addr[1];
  a_ManufData[ sizeof(a_ManufData)-4] = a_srd_bd_addr[0] >> 24;
  a_ManufData[ sizeof(a_ManufData)-3] = a_srd_bd_addr[0] >> 16;
  a_ManufData[ sizeof(a_ManufData)-2] = a_srd_bd_addr[0] >> 8;
  a_ManufData[ sizeof(a_ManufData)-1] = a_srd_bd_addr[0];
[/#if]
[#if CFG_IDENTITY_ADDRESS =="GAP_STATIC_RANDOM_ADDR"]
#endif

#if (CFG_BLE_ADDRESS_TYPE != PUBLIC_ADDR)
[#else]

[/#if]
  ret = aci_hal_write_config_data(CONFIG_DATA_RANDOM_ADDRESS_OFFSET, CONFIG_DATA_RANDOM_ADDRESS_LEN, (uint8_t*)a_srd_bd_addr);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_hal_write_config_data command - CONFIG_DATA_RANDOM_ADDRESS_OFFSET, result: 0x%x \n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_hal_write_config_data command - CONFIG_DATA_RANDOM_ADDRESS_OFFSET\n");
    APP_DBG_MSG("  Random Bluetooth Address: %02x:%02x:%02x:%02x:%02x:%02x\n", (uint8_t)(a_srd_bd_addr[1] >> 8),
                                                                               (uint8_t)(a_srd_bd_addr[1]),
                                                                               (uint8_t)(a_srd_bd_addr[0] >> 24),
                                                                               (uint8_t)(a_srd_bd_addr[0] >> 16),
                                                                               (uint8_t)(a_srd_bd_addr[0] >> 8),
                                                                               (uint8_t)(a_srd_bd_addr[0]));
  }
#endif /* CFG_BLE_ADDRESS_TYPE != PUBLIC_ADDR */
[/#if]
[/#if]
[/#if]

[/#if]
  /**
   * Write Identity root key used to derive LTK and CSRK 
   */
  ret = aci_hal_write_config_data(CONFIG_DATA_IR_OFFSET, CONFIG_DATA_IR_LEN, (uint8_t*)a_BLE_CfgIrValue);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_hal_write_config_data command - CONFIG_DATA_IR_OFFSET, result: 0x%x \n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_hal_write_config_data command - CONFIG_DATA_IR_OFFSET\n");
  }
    
  /**
   * Write Encryption root key used to derive LTK and CSRK
   */
  ret = aci_hal_write_config_data(CONFIG_DATA_ER_OFFSET, CONFIG_DATA_ER_LEN, (uint8_t*)a_BLE_CfgErValue);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_hal_write_config_data command - CONFIG_DATA_ER_OFFSET, result: 0x%x \n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_hal_write_config_data command - CONFIG_DATA_ER_OFFSET\n");
  }

  /**
   * Set TX Power.
   */
  ret = aci_hal_set_tx_power_level(1, CFG_TX_POWER);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_hal_set_tx_power_level command, result: 0x%x \n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_hal_set_tx_power_level command\n");
  }

  /**
   * Initialize GATT interface
   */
  ret = aci_gatt_init();
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_gatt_init command, result: 0x%x \n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_gatt_init command\n");
  }

  /**
   * Initialize GAP interface
   */
  role = 0;

#if (BLE_CFG_PERIPHERAL == 1)
  role |= GAP_PERIPHERAL_ROLE;
#endif /* BLE_CFG_PERIPHERAL == 1 */

#if (BLE_CFG_CENTRAL == 1)
  role |= GAP_CENTRAL_ROLE;
#endif /* BLE_CFG_CENTRAL == 1 */

/* USER CODE BEGIN Role_Mngt*/

/* USER CODE END Role_Mngt */

  if (role > 0)
  {
[#if (CUSTOM_TEMPLATE = 1)]
    const char *name = CFG_GAP_DEVICE_NAME;
[#else]
    const char *name = "${LOCAL_NAME}";
[/#if]
    ret = aci_gap_init(role,
[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
                       CFG_PRIVACY,
[#else]
                       0,
[/#if]
[#if (CUSTOM_TEMPLATE = 1)]
                       CFG_GAP_DEVICE_NAME_LENGTH,
[#else]
                       APPBLE_GAP_DEVICE_NAME_LENGTH,
[/#if]
                       &gap_service_handle,
                       &gap_dev_name_char_handle,
                       &gap_appearance_char_handle);

    if (ret != BLE_STATUS_SUCCESS)
    {
      APP_DBG_MSG("  Fail   : aci_gap_init command, result: 0x%x \n", ret);
    }
    else
    {
      APP_DBG_MSG("  Success: aci_gap_init command\n");
    }

    ret = aci_gatt_update_char_value(gap_service_handle, gap_dev_name_char_handle, 0, strlen(name), (uint8_t *) name);
    if (ret != BLE_STATUS_SUCCESS)
    {
      BLE_DBG_SVCCTL_MSG("  Fail   : aci_gatt_update_char_value - Device Name\n");
    }
    else
    {
      BLE_DBG_SVCCTL_MSG("  Success: aci_gatt_update_char_value - Device Name\n");
    }
  }

  ret = aci_gatt_update_char_value(gap_service_handle,
                                   gap_appearance_char_handle,
                                   0,
                                   2,
                                   (uint8_t *)&a_appearance);
  if (ret != BLE_STATUS_SUCCESS)
  {
    BLE_DBG_SVCCTL_MSG("  Fail   : aci_gatt_update_char_value - Appearance\n");
  }
  else
  {
    BLE_DBG_SVCCTL_MSG("  Success: aci_gatt_update_char_value - Appearance\n");
  }

[#if (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
  /**
   * Initialize Default PHY
   */
  ret = hci_le_set_default_phy(ALL_PHYS_PREFERENCE,TX_2M_PREFERRED,RX_2M_PREFERRED); 
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : hci_le_set_default_phy command, result: 0x%x \n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: hci_le_set_default_phy command\n");
  }

[/#if]
[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
  /**
   * Initialize IO capability
   */
  BleApplicationContext.BleApplicationContext_legacy.bleSecurityParam.ioCapability = CFG_IO_CAPABILITY;
  ret = aci_gap_set_io_capability(BleApplicationContext.BleApplicationContext_legacy.bleSecurityParam.ioCapability);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_gap_set_io_capability command, result: 0x%x \n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_gap_set_io_capability command\n");
  }

  /**
   * Initialize authentication
   */
  BleApplicationContext.BleApplicationContext_legacy.bleSecurityParam.mitm_mode = CFG_MITM_PROTECTION;
  BleApplicationContext.BleApplicationContext_legacy.bleSecurityParam.encryptionKeySizeMin = CFG_ENCRYPTION_KEY_SIZE_MIN;
  BleApplicationContext.BleApplicationContext_legacy.bleSecurityParam.encryptionKeySizeMax = CFG_ENCRYPTION_KEY_SIZE_MAX;
  BleApplicationContext.BleApplicationContext_legacy.bleSecurityParam.Use_Fixed_Pin = CFG_USED_FIXED_PIN;
  BleApplicationContext.BleApplicationContext_legacy.bleSecurityParam.Fixed_Pin = CFG_FIXED_PIN;
  BleApplicationContext.BleApplicationContext_legacy.bleSecurityParam.bonding_mode = CFG_BONDING_MODE;
  /* USER CODE BEGIN Ble_Hci_Gap_Gatt_Init_1*/

  /* USER CODE END Ble_Hci_Gap_Gatt_Init_1*/

  ret = aci_gap_set_authentication_requirement(BleApplicationContext.BleApplicationContext_legacy.bleSecurityParam.bonding_mode,
                                               BleApplicationContext.BleApplicationContext_legacy.bleSecurityParam.mitm_mode,
                                               CFG_SC_SUPPORT,
                                               CFG_KEYPRESS_NOTIFICATION_SUPPORT,
                                               BleApplicationContext.BleApplicationContext_legacy.bleSecurityParam.encryptionKeySizeMin,
                                               BleApplicationContext.BleApplicationContext_legacy.bleSecurityParam.encryptionKeySizeMax,
                                               BleApplicationContext.BleApplicationContext_legacy.bleSecurityParam.Use_Fixed_Pin,
                                               BleApplicationContext.BleApplicationContext_legacy.bleSecurityParam.Fixed_Pin,
                                               CFG_IDENTITY_ADDRESS);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_gap_set_authentication_requirement command, result: 0x%x \n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_gap_set_authentication_requirement command\n");
  }

  /**
   * Initialize whitelist
   */
  if (BleApplicationContext.BleApplicationContext_legacy.bleSecurityParam.bonding_mode)
  {
    ret = aci_gap_configure_whitelist();
    if (ret != BLE_STATUS_SUCCESS)
    {
      APP_DBG_MSG("  Fail   : aci_gap_configure_whitelist command, result: 0x%x \n", ret);
    }
    else
    {
      APP_DBG_MSG("  Success: aci_gap_configure_whitelist command\n");
    }
  }
  APP_DBG_MSG("==>> End Ble_Hci_Gap_Gatt_Init function\n\r");
[/#if]
}
[#if (BT_SIG_BEACON != "0")]
static void Beacon_Update(void)
{
  FLASH_EraseInitTypeDef erase;
  uint32_t pageError = 0;

  if (sector_type != 0)
  {
    erase.TypeErase = FLASH_TYPEERASE_PAGES;
    erase.Page      = sector_type;
    if (sector_type == APP_SECTORS)
    {
      erase.NbPages = 2;  /* 2 sectors for beacon application */
    }
    else
    {
      erase.NbPages = 1; /* 1 sector for beacon user data */
    }
    
    HAL_FLASH_Unlock();
    __HAL_FLASH_CLEAR_FLAG(FLASH_FLAG_EOP | FLASH_FLAG_WRPERR | FLASH_FLAG_OPTVERR);
    
    HAL_FLASHEx_Erase(&erase, &pageError);
    
    HAL_FLASH_Lock();
  }
  
  *(uint32_t*) SRAM1_BASE = BOOT_MODE_AND_SECTOR; 
  /**
   * Boot Mode:    1 (OTA)
   * Sector Index: 6
   * Nb Sectors  : 1
   */
  NVIC_SystemReset();
}
[/#if]

[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) ||(CUSTOM_P2P_SERVER = 1) ||(CUSTOM_TEMPLATE = 1)]
static void Adv_Request(APP_BLE_ConnStatus_t NewStatus)
{
  tBleStatus ret = BLE_STATUS_INVALID_PARAMS;
[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) ||(CUSTOM_P2P_SERVER = 1)]
  uint16_t Min_Inter, Max_Inter;

  if (NewStatus == APP_BLE_FAST_ADV)
  {
    Min_Inter = AdvIntervalMin;
    Max_Inter = AdvIntervalMax;
  }
  else
  {
    Min_Inter = CFG_LP_CONN_ADV_INTERVAL_MIN;
    Max_Inter = CFG_LP_CONN_ADV_INTERVAL_MAX;
  }

  /**
   * Stop the timer, it will be restarted for a new shot
   * It does not hurt if the timer was not running
   */
  HW_TS_Stop(BleApplicationContext.Advertising_mgr_timer_Id);
[/#if]

[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) ||(CUSTOM_P2P_SERVER = 1)]

  if ((NewStatus == APP_BLE_LP_ADV)
      && ((BleApplicationContext.Device_Connection_Status == APP_BLE_FAST_ADV)
          || (BleApplicationContext.Device_Connection_Status == APP_BLE_LP_ADV)))
  {
    /* Connection in ADVERTISE mode have to stop the current advertising */
    ret = aci_gap_set_non_discoverable();
    if (ret != BLE_STATUS_SUCCESS)
    {
      APP_DBG_MSG("==>> aci_gap_set_non_discoverable - Stop Advertising Failed , result: %d \n", ret);
    }
    else
    {
      APP_DBG_MSG("==>> aci_gap_set_non_discoverable - Successfully Stopped Advertising \n");
    }
  }

[/#if]
  BleApplicationContext.Device_Connection_Status = NewStatus;
  /* Start Fast or Low Power Advertising */
[#if (CUSTOM_TEMPLATE = 1)]
  ret = aci_gap_set_discoverable(ADV_TYPE,
                                 CFG_FAST_CONN_ADV_INTERVAL_MIN,
                                 CFG_FAST_CONN_ADV_INTERVAL_MAX,
                                 CFG_BLE_ADDRESS_TYPE,
                                 ADV_FILTER,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("==>> aci_gap_set_discoverable - fail, result: 0x%x \n", ret);
  }
  else
  {
    APP_DBG_MSG("==>> aci_gap_set_discoverable - Success\n");
  }

[#else]
  ret = aci_gap_set_discoverable(ADV_IND,
                                 Min_Inter,
                                 Max_Inter,
                                 CFG_BLE_ADDRESS_TYPE,
                                 NO_WHITE_LIST_USE, /* use white list */
                                 sizeof(a_LocalName),
                                 (uint8_t*) &a_LocalName,
                                 BleApplicationContext.BleApplicationContext_legacy.advtServUUIDlen,
                                 BleApplicationContext.BleApplicationContext_legacy.advtServUUID,
                                 0,
                                 0);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("==>> aci_gap_set_discoverable - fail, result: 0x%x \n", ret);
  }
  else
  {
    APP_DBG_MSG("==>> aci_gap_set_discoverable - Success\n");
  }

[/#if]
[#if (CUSTOM_TEMPLATE = 1)]
  /* Update Advertising data */
  ret = aci_gap_update_adv_data(sizeof(a_AdvData), (uint8_t*) a_AdvData);
[#else]
[#if (BT_SIG_HEART_RATE_SENSOR = 1) || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1)]
  /* Update Advertising data */
  ret = aci_gap_update_adv_data(sizeof(a_ManufData), (uint8_t*) a_ManufData);
[/#if]
[/#if]
  if (ret != BLE_STATUS_SUCCESS)
  {
[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) ||(CUSTOM_P2P_SERVER = 1)]
    if (NewStatus == APP_BLE_FAST_ADV)
    {
[/#if]
      APP_DBG_MSG("==>> Start Fast Advertising Failed , result: %d \n\r", ret);
[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) ||(CUSTOM_P2P_SERVER = 1)]
    }
    else
    {
      APP_DBG_MSG("==>> Start Low Power Advertising Failed , result: %d \n\r", ret);
    }
[/#if]
  }
  else
  {
[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) ||(CUSTOM_P2P_SERVER = 1)]
    if (NewStatus == APP_BLE_FAST_ADV)
    {
[/#if]
      APP_DBG_MSG("==>> Success: Start Fast Advertising \n\r");
[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)
 || (BT_SIG_HEART_RATE_SENSOR = 1) ||(CUSTOM_P2P_SERVER = 1)]
      /* Start Timer to STOP ADV - TIMEOUT - and next Restart Low Power Advertising */
      HW_TS_Start(BleApplicationContext.Advertising_mgr_timer_Id, INITIAL_ADV_TIMEOUT);
    }
    else
    {
      APP_DBG_MSG("==>> Success: Start Low Power Advertising \n\r");
    }
[/#if]
  }

  return;
}
[/#if]


[#if ((CFG_IDENTITY_ADDRESS = "GAP_PUBLIC_ADDR") && ((BT_SIG_BEACON != "0") || (BT_SIG_HEART_RATE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)))]
const uint8_t* BleGetBdAddress(void)
{
  uint8_t *p_otp_addr;
  const uint8_t *p_bd_addr;
  uint32_t udn;
  uint32_t company_id;
  uint32_t device_id;

  udn = LL_FLASH_GetUDN();

  if (udn != 0xFFFFFFFF)
  {
    company_id = LL_FLASH_GetSTCompanyID();
    device_id = LL_FLASH_GetDeviceID();

    /**
     * Public Address with the ST company ID
     * bit[47:24] : 24bits (OUI) equal to the company ID
     * bit[23:16] : Device ID.
     * bit[15:0] : The last 16bits from the UDN
     * Note: In order to use the Public Address in a final product, a dedicated
     * 24bits company ID (OUI) shall be bought.
     */
    a_BdAddrUdn[0] = (uint8_t)(udn & 0x000000FF);
    a_BdAddrUdn[1] = (uint8_t)((udn & 0x0000FF00) >> 8);
    a_BdAddrUdn[2] = (uint8_t)device_id;
    a_BdAddrUdn[3] = (uint8_t)(company_id & 0x000000FF);
    a_BdAddrUdn[4] = (uint8_t)((company_id & 0x0000FF00) >> 8);
    a_BdAddrUdn[5] = (uint8_t)((company_id & 0x00FF0000) >> 16);

    p_bd_addr = (const uint8_t *)a_BdAddrUdn;
  }
  else
  {
    p_otp_addr = OTP_Read(0);
    if (p_otp_addr)
    {
      p_bd_addr = ((OTP_ID0_t*)p_otp_addr)->bd_address;
    }
    else
    {
      p_bd_addr = a_MBdAddr;
    }
  }

  return p_bd_addr;
}
[/#if]

/* USER CODE BEGIN FD_LOCAL_FUNCTION */

/* USER CODE END FD_LOCAL_FUNCTION */

[#if (BT_SIG_BLOOD_PRESSURE_SENSOR = 1) || (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1) || (BT_SIG_HEART_RATE_SENSOR = 1)]

/*************************************************************
 *
 *SPECIFIC FUNCTIONS
 *
 *************************************************************/
static void Add_Advertisment_Service_UUID(uint16_t servUUID)
{
  BleApplicationContext.BleApplicationContext_legacy.advtServUUID[BleApplicationContext.BleApplicationContext_legacy.advtServUUIDlen] =
      (uint8_t) (servUUID & 0xFF);
  BleApplicationContext.BleApplicationContext_legacy.advtServUUIDlen++;
  BleApplicationContext.BleApplicationContext_legacy.advtServUUID[BleApplicationContext.BleApplicationContext_legacy.advtServUUIDlen] =
      (uint8_t) (servUUID >> 8) & 0xFF;
  BleApplicationContext.BleApplicationContext_legacy.advtServUUIDlen++;

  return;
}

static void Adv_Mgr(void)
{
  /**
   * The code shall be executed in the background as an aci command may be sent
   * The background is the only place where the application can make sure a new aci command
   * is not sent if there is a pending one
   */
[#if (FREERTOS_STATUS = 1)]
  osThreadFlagsSet(AdvUpdateProcessId, 1);
[#else]
  UTIL_SEQ_SetTask(1 << CFG_TASK_ADV_UPDATE_ID, CFG_SCH_PRIO_0);
[/#if]

  return;
}

[#if (FREERTOS_STATUS = 1)]
static void AdvUpdateProcess(void *argument)
{
  UNUSED(argument);

  for(;;)
  {
    osThreadFlagsWait(1, osFlagsWaitAny, osWaitForever);
    Adv_Update();
  }
}

[/#if]
static void Adv_Update(void)
{
  Adv_Request(APP_BLE_LP_ADV);

  return;
}
[#if (FREERTOS_STATUS = 1)]

static void HciUserEvtProcess(void *argument)
{
  UNUSED(argument);

  for(;;)
  {
    osThreadFlagsWait(1, osFlagsWaitAny, osWaitForever);
    hci_user_evt_proc();
  }
}
[/#if]
[/#if]
[#if (CUSTOM_P2P_SERVER = 1) && (CUSTOM_TEMPLATE = 0)]
/*************************************************************
 *
 * SPECIFIC FUNCTIONS FOR P2P SERVER
 *
 *************************************************************/
[/#if]
[#if (CUSTOM_P2P_SERVER = 0) && (CUSTOM_TEMPLATE = 1)]
/*************************************************************
 *
 * SPECIFIC FUNCTIONS FOR CUSTOM
 *
 *************************************************************/
[/#if]
[#if (CUSTOM_P2P_SERVER = 1) && (CUSTOM_TEMPLATE = 1)]
/*************************************************************
 *
 * SPECIFIC FUNCTIONS FOR CUSTOM & P2P SERVER
 *
 *************************************************************/
[/#if]
[#if (CUSTOM_P2P_SERVER = 1) || (CUSTOM_TEMPLATE = 1)]
static void Adv_Cancel(void)
{
  /* USER CODE BEGIN Adv_Cancel_1 */

  /* USER CODE END Adv_Cancel_1 */

  if (BleApplicationContext.Device_Connection_Status != APP_BLE_CONNECTED_SERVER)
  {
    tBleStatus ret = BLE_STATUS_INVALID_PARAMS;

    ret = aci_gap_set_non_discoverable();

    BleApplicationContext.Device_Connection_Status = APP_BLE_IDLE;
    if (ret != BLE_STATUS_SUCCESS)
    {
      APP_DBG_MSG("** STOP ADVERTISING **  Failed \r\n\r");
    }
    else
    {
      APP_DBG_MSG("  \r\n\r");
      APP_DBG_MSG("** STOP ADVERTISING **  \r\n\r");
    }
  }

  /* USER CODE BEGIN Adv_Cancel_2 */

  /* USER CODE END Adv_Cancel_2 */

  return;
}

[#if (BT_SIG_BEACON != "0") || (BT_SIG_BLOOD_PRESSURE_SENSOR = 1)|| (BT_SIG_HEALTH_THERMOMETER_SENSOR = 1)|| (BT_SIG_HEART_RATE_SENSOR = 1)|| (CUSTOM_OTA = 1)|| (CUSTOM_P2P_SERVER = 1)]
static void Adv_Cancel_Req(void)
{
  /* USER CODE BEGIN Adv_Cancel_Req_1 */

  /* USER CODE END Adv_Cancel_Req_1 */

  UTIL_SEQ_SetTask(1 << CFG_TASK_ADV_CANCEL_ID, CFG_SCH_PRIO_0);

  /* USER CODE BEGIN Adv_Cancel_Req_2 */

  /* USER CODE END Adv_Cancel_Req_2 */

  return;
}

static void Switch_OFF_GPIO()
{
  /* USER CODE BEGIN Switch_OFF_GPIO */

  /* USER CODE END Switch_OFF_GPIO */
}
[/#if]

#if (L2CAP_REQUEST_NEW_CONN_PARAM != 0)  
void BLE_SVC_L2CAP_Conn_Update(uint16_t ConnectionHandle)
{
  /* USER CODE BEGIN BLE_SVC_L2CAP_Conn_Update_1 */

  /* USER CODE END BLE_SVC_L2CAP_Conn_Update_1 */

  if (mutex == 1)
  { 
    mutex = 0;
    index_con_int = (index_con_int + 1)%SIZE_TAB_CONN_INT;
    uint16_t interval_min = CONN_P(a_ConnInterval[index_con_int]);
    uint16_t interval_max = CONN_P(a_ConnInterval[index_con_int]);
    uint16_t slave_latency = L2CAP_SLAVE_LATENCY;
    uint16_t timeout_multiplier = L2CAP_TIMEOUT_MULTIPLIER;
    tBleStatus ret;

    ret = aci_l2cap_connection_parameter_update_req(BleApplicationContext.BleApplicationContext_legacy.connectionHandle,
                                                    interval_min, interval_max,
                                                    slave_latency, timeout_multiplier);
    if (ret != BLE_STATUS_SUCCESS)
    {
      APP_DBG_MSG("BLE_SVC_L2CAP_Conn_Update(), Failed \r\n\r");
    }
    else
    {
      APP_DBG_MSG("BLE_SVC_L2CAP_Conn_Update(), Successfully \r\n\r");
    }
  }

  /* USER CODE BEGIN BLE_SVC_L2CAP_Conn_Update_2 */

  /* USER CODE END BLE_SVC_L2CAP_Conn_Update_2 */

  return;
}
#endif /* L2CAP_REQUEST_NEW_CONN_PARAM != 0 */

#if (L2CAP_REQUEST_NEW_CONN_PARAM != 0)
static void Connection_Interval_Update_Req(void)
{
  if (BleApplicationContext.Device_Connection_Status != APP_BLE_FAST_ADV && BleApplicationContext.Device_Connection_Status != APP_BLE_IDLE)
  {
    BLE_SVC_L2CAP_Conn_Update(BleApplicationContext.BleApplicationContext_legacy.connectionHandle);
  }

  return;
}
#endif /* L2CAP_REQUEST_NEW_CONN_PARAM != 0 */
[/#if]

/* USER CODE BEGIN FD_SPECIFIC_FUNCTIONS */

/* USER CODE END FD_SPECIFIC_FUNCTIONS */
/*************************************************************
 *
 * WRAP FUNCTIONS
 *
 *************************************************************/
void hci_notify_asynch_evt(void* p_Data)
{
[#if (FREERTOS_STATUS = 0)]
  UTIL_SEQ_SetTask(1 << CFG_TASK_HCI_ASYNCH_EVT_ID, CFG_SCH_PRIO_0);
[#else]
  UNUSED(p_Data);
  osThreadFlagsSet(HciUserEvtProcessId, 1);
[/#if]

  return;
}

void hci_cmd_resp_release(uint32_t Flag)
{
[#if (FREERTOS_STATUS = 0)]
  UTIL_SEQ_SetEvt(1 << CFG_IDLEEVT_HCI_CMD_EVT_RSP_ID);
[#else]
  UNUSED(Flag);
  osSemaphoreRelease(SemHciId);
[/#if]

  return;
}

void hci_cmd_resp_wait(uint32_t Timeout)
{
[#if (FREERTOS_STATUS = 0)]
  UTIL_SEQ_WaitEvt(1 << CFG_IDLEEVT_HCI_CMD_EVT_RSP_ID);
[#else]
  UNUSED(Timeout);
  osSemaphoreAcquire(SemHciId, osWaitForever);
[/#if]

  return;
}

static void BLE_UserEvtRx(void *p_Payload)
{
  SVCCTL_UserEvtFlowStatus_t svctl_return_status;
  tHCI_UserEvtRxParam *p_param;

  p_param = (tHCI_UserEvtRxParam *)p_Payload; 

  svctl_return_status = SVCCTL_UserEvtRx((void *)&(p_param->pckt->evtserial));
  if (svctl_return_status != SVCCTL_UserEvtFlowDisable)
  {
    p_param->status = HCI_TL_UserEventFlow_Enable;
  }
  else
  {
    p_param->status = HCI_TL_UserEventFlow_Disable;
  }

  return;
}

static void BLE_StatusNot(HCI_TL_CmdStatus_t Status)
{
[#if (FREERTOS_STATUS = 0)]
  uint32_t task_id_list;
[/#if]
  switch (Status)
  {
    case HCI_TL_CmdBusy:
[#if (FREERTOS_STATUS = 0)]
      /**
       * All tasks that may send an aci/hci commands shall be listed here
       * This is to prevent a new command is sent while one is already pending
       */
      task_id_list = (1 << CFG_LAST_TASK_ID_WITH_HCICMD) - 1;
      UTIL_SEQ_PauseTask(task_id_list);
      [#else]
      osMutexAcquire(MtxHciId, osWaitForever);
[/#if]
      /* USER CODE BEGIN HCI_TL_CmdBusy */

      /* USER CODE END HCI_TL_CmdBusy */
      break;

    case HCI_TL_CmdAvailable:
[#if (FREERTOS_STATUS = 0)]
      /**
       * All tasks that may send an aci/hci commands shall be listed here
       * This is to prevent a new command is sent while one is already pending
       */
      task_id_list = (1 << CFG_LAST_TASK_ID_WITH_HCICMD) - 1;
      UTIL_SEQ_ResumeTask(task_id_list);
[#else]
      osMutexRelease(MtxHciId);
[/#if]
      /* USER CODE BEGIN HCI_TL_CmdAvailable */

      /* USER CODE END HCI_TL_CmdAvailable */
      break;

    default:
      /* USER CODE BEGIN Status */

      /* USER CODE END Status */
      break;
  }

  return;
}

void SVCCTL_ResumeUserEventFlow(void)
{
  hci_resume_flow();

  return;
}


/* USER CODE BEGIN FD_WRAP_FUNCTIONS */

/* USER CODE END FD_WRAP_FUNCTIONS */