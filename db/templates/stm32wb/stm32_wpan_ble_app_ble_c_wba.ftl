[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_ble.c
  * @author  MCD Application Team
  * @brief   BLE Application
  *****************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign CUSTOM_P2P_CLIENT = 0]
[#assign CUSTOM_P2P_ROUTER = 0]
[#assign CUSTOM_TEMPLATE = 0]
[#assign FREERTOS_STATUS = 0]
[#assign LOCAL_NAME = "STM32WBA"]
[#assign ADV_TYPE = ""]
[#assign CFG_BLE_ADDRESS_TYPE = ""]
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
[#assign NUMBER_OF_SERVICES = "0"]
[#assign SERVICE1_SHORT_NAME = ""]
[#assign SERVICE2_SHORT_NAME = ""]
[#assign SERVICE3_SHORT_NAME = ""]
[#assign SERVICE4_SHORT_NAME = ""]
[#assign SERVICE5_SHORT_NAME = ""]
[#assign SERVICE6_SHORT_NAME = ""]
[#assign SERVICE7_SHORT_NAME = ""]
[#assign SERVICE8_SHORT_NAME = ""]
[#assign SERVICE9_SHORT_NAME = ""]
[#assign SERVICE10_SHORT_NAME = ""]
[#assign SERVICE1_LONG_NAME = ""]
[#assign SERVICE2_LONG_NAME = ""]
[#assign SERVICE3_LONG_NAME = ""]
[#assign SERVICE4_LONG_NAME = ""]
[#assign SERVICE5_LONG_NAME = ""]
[#assign SERVICE6_LONG_NAME = ""]
[#assign SERVICE7_LONG_NAME = ""]
[#assign SERVICE8_LONG_NAME = ""]
[#assign SERVICE9_LONG_NAME = ""]
[#assign SERVICE10_LONG_NAME = ""]

[#assign myHash = {}]

[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
      [#if (definition.name == "CUSTOM_P2P_CLIENT") && (definition.value == "Enabled")]
          [#assign CUSTOM_P2P_CLIENT = 1]
      [/#if]
      [#if (definition.name == "CUSTOM_P2P_ROUTER") && (definition.value =="Enabled")]
          [#assign CUSTOM_P2P_ROUTER = 1]
      [/#if]
      [#if (definition.name == "CUSTOM_TEMPLATE") && (definition.value == "Enabled")]
          [#assign CUSTOM_TEMPLATE = 1]
      [/#if]
      [#if (definition.name == "FREERTOS_STATUS") && (definition.value == "1")]
          [#assign FREERTOS_STATUS = 1]
      [/#if]
      [#if definition.name == "LOCAL_NAME"]
          [#assign LOCAL_NAME = definition.value]
      [/#if]
      [#if definition.name == "ADV_TYPE"]
          [#assign ADV_TYPE = definition.value]
      [/#if]
      [#if definition.name == "CFG_BLE_ADDRESS_TYPE"]
          [#assign CFG_BLE_ADDRESS_TYPE = definition.value]
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
      [#if definition.name == "NUMBER_OF_SERVICES"]
          [#assign NUMBER_OF_SERVICES = definition.value]
      [/#if]
      [#if definition.name == "SERVICE1_SHORT_NAME"]
          [#assign SERVICE1_SHORT_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE2_SHORT_NAME"]
          [#assign SERVICE2_SHORT_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE3_SHORT_NAME"]
          [#assign SERVICE3_SHORT_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE4_SHORT_NAME"]
          [#assign SERVICE4_SHORT_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE5_SHORT_NAME"]
          [#assign SERVICE5_SHORT_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE6_SHORT_NAME"]
          [#assign SERVICE6_SHORT_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE7_SHORT_NAME"]
          [#assign SERVICE7_SHORT_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE8_SHORT_NAME"]
          [#assign SERVICE8_SHORT_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE9_SHORT_NAME"]
          [#assign SERVICE9_SHORT_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE10_SHORT_NAME"]
          [#assign SERVICE10_SHORT_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE1_LONG_NAME"]
          [#assign SERVICE1_LONG_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE2_LONG_NAME"]
          [#assign SERVICE2_LONG_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE3_LONG_NAME"]
          [#assign SERVICE3_LONG_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE4_LONG_NAME"]
          [#assign SERVICE4_LONG_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE5_LONG_NAME"]
          [#assign SERVICE5_LONG_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE6_LONG_NAME"]
          [#assign SERVICE6_LONG_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE7_LONG_NAME"]
          [#assign SERVICE7_LONG_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE8_LONG_NAME"]
          [#assign SERVICE8_LONG_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE9_LONG_NAME"]
          [#assign SERVICE9_LONG_NAME = definition.value]
      [/#if]
      [#if definition.name == "SERVICE10_LONG_NAME"]
          [#assign SERVICE10_LONG_NAME = definition.value]
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
[#if NUMBER_OF_SERVICES != "0"]
  [#assign item = 0]
  [#assign item_NAME_START = item]
  [#assign item_LONG_NAME = item][#assign item = item + 1]
  [#assign item_SHORT_NAME = item]
  [#assign item_NAME_END = item]

  [#assign SERVICES_NAMES = {} /]
  [#list 1..NUMBER_OF_SERVICES?number as i]
    [#assign SERVICES_NAMES = SERVICES_NAMES + {i?string: [myHash["SERVICE"+i+"_LONG_NAME"],myHash["SERVICE"+i+"_SHORT_NAME"]]}/]
  [/#list]

  [#--
  [#list 1..NUMBER_OF_SERVICES?number as i]
    [#list item_NAME_START..item_NAME_END as j]
    ${SERVICES_NAMES[i?string][j]}
    [/#list]
  [/#list]
  --]

  [#macro serviceShortName service]
      ${SERVICES_NAMES[service?string][item_SHORT_NAME]}[#t]
  [/#macro]
  [#macro capitalizeWords words]
      [#list words as word]
          ${word?capitalize}[#t]
      [/#list]
  [/#macro]

  [#macro serviceShortNameCapitalized service]
      [@capitalizeWords SERVICES_NAMES[service?string][item_SHORT_NAME]?matches(r"[a-zA-Z]+\d*[^a-zA-Z]*")/]
  [/#macro]
[/#if]
/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "app_common.h"
#include "ble.h"
#include "app_ble.h"

[#if  (FREERTOS_STATUS = 0)]
#include "stm32_seq.h"
[#else]
#include "cmsis_os.h"
[/#if]

#include "otp.h"
#include "stm32_timer.h"
#include "stm_list.h"
#include "host_ble.h"
#include "stm32_mm.h"
#include "nvm.h"
#include "ble_mm_if.h"
#include "blestack.h"
[#if  (CUSTOM_TEMPLATE = 1)]
  [#if NUMBER_OF_SERVICES != "0"]
    [#list 1..NUMBER_OF_SERVICES?number as service]
#include "${SERVICES_NAMES[service?string][item_SHORT_NAME]?lower_case}.h"
#include "${SERVICES_NAMES[service?string][item_SHORT_NAME]?lower_case}_app.h"
    [/#list]
  [/#if]
[/#if]

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/

[#if (CUSTOM_TEMPLATE = 1)]
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
  /* USER CODE BEGIN BleGlobalContext_t*/

  /* USER CODE END BleGlobalContext_t */
}BleGlobalContext_t;

typedef struct
{
  BleGlobalContext_t BleApplicationContext_legacy;
  APP_BLE_ConnStatus_t Device_Connection_Status;
  /* USER CODE BEGIN PTD_1*/

  /* USER CODE END PTD_1 */
}BleApplicationContext_t;
[/#if]
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private defines -----------------------------------------------------------*/
[#if (CUSTOM_TEMPLATE = 0)]
#define APPBLE_GAP_DEVICE_NAME_LENGTH   7
[/#if]
#define BD_ADDR_SIZE_LOCAL              6

/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
static tListNode BleAsynchEventQueue;
[#if ((CFG_BLE_ADDRESS_TYPE = "GAP_RANDOM_ADDR") && (CUSTOM_TEMPLATE = 1))]
extern RNG_HandleTypeDef hrng;
[/#if]
[#if ((CFG_BLE_ADDRESS_TYPE = "GAP_PUBLIC_ADDR") && (CUSTOM_TEMPLATE = 1))]
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
static BleApplicationContext_t BleApplicationContext;

[#if (CUSTOM_TEMPLATE = 1)]
[#if NUMBER_OF_SERVICES != "0"]
  [#list 1..NUMBER_OF_SERVICES?number as service]
${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_APP_ConnHandleNotEvt_t ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification;
  [/#list]
[/#if]
[#else]
[/#if]

[#if  (CUSTOM_TEMPLATE = 1)]
static const char a_GapDeviceName[] = { [#rt] [#list "${CFG_GAP_DEVICE_NAME}" ?split("(?!^)", "r") as char][#t][#lt]'${char}'<#sep>, [#rt]
    [/#list][#lt] }; /* Gap Device Name */

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

uint64_t buffer_nvm[CFG_BLEPLAT_NVM_MAX_SIZE];

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
static void BleStack_Process_BG(void);
static void Ble_UserEvtRx(void);
static void Ble_Hci_Gap_Gatt_Init(void);
[#if ((CFG_BLE_ADDRESS_TYPE = "GAP_PUBLIC_ADDR") && (CUSTOM_TEMPLATE = 1))]
static const uint8_t* BleGetBdAddress(void);
[/#if]
[#if (CUSTOM_TEMPLATE = 1)]
static void Adv_Request(APP_BLE_ConnStatus_t NewStatus);
static void Adv_Cancel(void);
[/#if]

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* External variables --------------------------------------------------------*/
[#if  ((CFG_STATIC_RANDOM_ADDRESS == "0") && (CFG_RNG == "1") && (CUSTOM_TEMPLATE = 1))]
extern RNG_HandleTypeDef hrng;
[/#if]

/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Functions Definition ------------------------------------------------------*/
void APP_BLE_Init(void)
{
  /* USER CODE BEGIN APP_BLE_Init_1 */

  /* USER CODE END APP_BLE_Init_1 */

  LST_init_head(&BleAsynchEventQueue);

  UTIL_SEQ_RegTask(1U << CFG_TASK_BLE_HOST, UTIL_SEQ_RFU, BleStack_Process_BG);
  UTIL_SEQ_RegTask(1U << CFG_TASK_HCI_ASYNCH_EVT_ID, UTIL_SEQ_RFU, Ble_UserEvtRx);

  /* NVM emulation in RAM initialization */
  NVM_Init(buffer_nvm, 0, CFG_BLEPLAT_NVM_MAX_SIZE);

  /* Initialize the BLE Host */
  if(HOST_BLE_Init() == 0u){
  

  /**
   * Initialization of HCI & GATT & GAP layer
   */
  Ble_Hci_Gap_Gatt_Init();

  /**
   * Initialization of the BLE Services
   */
  SVCCTL_Init();

[#if (CUSTOM_TEMPLATE = 1)]
  /**
   * Initialization of the BLE App Context
   */
  BleApplicationContext.Device_Connection_Status = APP_BLE_IDLE;
  BleApplicationContext.BleApplicationContext_legacy.connectionHandle = 0xFFFF;

  /**
   * From here, all initialization are BLE application specific
   */
  UTIL_SEQ_RegTask(1<<CFG_TASK_ADV_CANCEL_ID, UTIL_SEQ_RFU, Adv_Cancel);

  /* USER CODE BEGIN APP_BLE_Init_4 */

  /* USER CODE END APP_BLE_Init_4 */

  /**
   * Initialize Services and Characteristics.
   */
[#if NUMBER_OF_SERVICES != "0"]
  APP_DBG_MSG("\n\r");
  APP_DBG_MSG("Services and Characteristics creation\n\r");
  [#list 1..NUMBER_OF_SERVICES?number as service]
  ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_APP_Init();
  [/#list]
  APP_DBG_MSG("End of Services and Characteristics creation\n\r");
  APP_DBG_MSG("\n\r");
[/#if]

  /* USER CODE BEGIN APP_BLE_Init_3 */

  /* USER CODE END APP_BLE_Init_3 */

  /**
   * Start to Advertise to be connected by a Client
   */
  Adv_Request(APP_BLE_FAST_ADV);
  }
  /* USER CODE BEGIN APP_BLE_Init_2 */

  /* USER CODE END APP_BLE_Init_2 */

  return;
}


SVCCTL_UserEvtFlowStatus_t SVCCTL_App_Notification(void *p_Pckt)
{
  hci_event_pckt    *p_event_pckt;
  evt_le_meta_event *p_meta_evt;
  evt_blecore_aci   *p_blecore_evt;
  tBleStatus        ret = BLE_STATUS_INVALID_PARAMS;
  hci_le_enhanced_connection_complete_event_rp0 *p_enhanced_connection_complete_event;
  hci_disconnection_complete_event_rp0          *p_disconnection_complete_event;
  hci_le_connection_update_complete_event_rp0   *p_connection_update_complete_event;

  p_event_pckt = (hci_event_pckt*) ((hci_uart_pckt *) p_Pckt)->data;

  /* USER CODE BEGIN SVCCTL_App_Notification */

  /* USER CODE END SVCCTL_App_Notification */

  switch (p_event_pckt->evt)
  {
    case HCI_DISCONNECTION_COMPLETE_EVT_CODE:
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

      /**
       * SPECIFIC to Custom Template APP
       */
[#if NUMBER_OF_SERVICES != "0"]
  [#list 1..NUMBER_OF_SERVICES?number as service]
      ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification.EvtOpcode = ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_DISCON_HANDLE_EVT;
  [/#list]
[/#if]
[#if NUMBER_OF_SERVICES != "0"]
  [#list 1..NUMBER_OF_SERVICES?number as service]
      ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification.ConnectionHandle = BleApplicationContext.BleApplicationContext_legacy.connectionHandle;
  [/#list]
[/#if]
[#if NUMBER_OF_SERVICES != "0"]
  [#list 1..NUMBER_OF_SERVICES?number as service]
      ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_APP_EvtRx(&${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification);
  [/#list]
[/#if]
      /* USER CODE BEGIN EVT_DISCONN_COMPLETE */

      /* USER CODE END EVT_DISCONN_COMPLETE */
      break; /* HCI_DISCONNECTION_COMPLETE_EVT_CODE */
    }

    case HCI_LE_META_EVT_CODE:
    {
      p_meta_evt = (evt_le_meta_event*) p_event_pckt->data;
      /* USER CODE BEGIN EVT_LE_META_EVENT */

      /* USER CODE END EVT_LE_META_EVENT */
      switch (p_meta_evt->subevent)
      {
        case HCI_LE_CONNECTION_UPDATE_COMPLETE_SUBEVT_CODE:
          p_connection_update_complete_event = (hci_le_connection_update_complete_event_rp0 *) p_meta_evt->data;
          APP_DBG_MSG(">>== HCI_LE_CONNECTION_UPDATE_COMPLETE_SUBEVT_CODE\n");
          APP_DBG_MSG("     - Connection Interval:   %.2f ms\n     - Connection latency:    %d\n     - Supervision Timeout: %d ms\n\r",
                       p_connection_update_complete_event->Conn_Interval*1.25,
                       p_connection_update_complete_event->Conn_Latency,
                       p_connection_update_complete_event->Supervision_Timeout*10);

          /* USER CODE BEGIN EVT_LE_CONN_UPDATE_COMPLETE */

          /* USER CODE END EVT_LE_CONN_UPDATE_COMPLETE */
          break;

        case HCI_LE_ENHANCED_CONNECTION_COMPLETE_SUBEVT_CODE:
        {
          p_enhanced_connection_complete_event = (hci_le_enhanced_connection_complete_event_rp0 *) p_meta_evt->data;

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
          BleApplicationContext.BleApplicationContext_legacy.connectionHandle = p_enhanced_connection_complete_event->Connection_Handle;
          /**
           * SPECIFIC to Custom Template APP
           */
[#if NUMBER_OF_SERVICES != "0"]
  [#list 1..NUMBER_OF_SERVICES?number as service]
          ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification.EvtOpcode = ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_CONN_HANDLE_EVT;
  [/#list]
[/#if]
[#if NUMBER_OF_SERVICES != "0"]
  [#list 1..NUMBER_OF_SERVICES?number as service]
          ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification.ConnectionHandle = BleApplicationContext.BleApplicationContext_legacy.connectionHandle;
  [/#list]
[/#if]
[#if NUMBER_OF_SERVICES != "0"]
  [#list 1..NUMBER_OF_SERVICES?number as service]
          ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_APP_EvtRx(&${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification);
  [/#list]
[/#if]

          /* USER CODE BEGIN HCI_EVT_LE_ENHANCED_CONN_COMPLETE */

          /* USER CODE END HCI_EVT_LE_ENHANCED_CONN_COMPLETE */
          break; /* HCI_LE_ENHANCED_CONNECTION_COMPLETE_SUBEVT_CODE */
        }

        
        default:
          /* USER CODE BEGIN SUBEVENT_DEFAULT */

          /* USER CODE END SUBEVENT_DEFAULT */
          break;
      }
      
      /* USER CODE BEGIN META_EVT */

      /* USER CODE END META_EVT */
    }
      break; /* HCI_LE_META_EVT_CODE */

    case HCI_VENDOR_SPECIFIC_DEBUG_EVT_CODE:
      p_blecore_evt = (evt_blecore_aci*) p_event_pckt->data;
      /* USER CODE BEGIN EVT_VENDOR */

      /* USER CODE END EVT_VENDOR */
      switch (p_blecore_evt->ecode)
      {
        aci_gap_pairing_complete_event_rp0 *p_pairing_complete;
        /* USER CODE BEGIN ecode */

        /* USER CODE END ecode */

        case ACI_L2CAP_CONNECTION_UPDATE_RESP_VSEVT_CODE:

          /* USER CODE BEGIN EVT_BLUE_L2CAP_CONNECTION_UPDATE_RESP */

          /* USER CODE END EVT_BLUE_L2CAP_CONNECTION_UPDATE_RESP */
          break;


        case ACI_GAP_PROC_COMPLETE_VSEVT_CODE:
          APP_DBG_MSG(">>== ACI_GAP_PROC_COMPLETE_VSEVT_CODE \r");
          /* USER CODE BEGIN EVT_BLUE_GAP_PROCEDURE_COMPLETE */

          /* USER CODE END EVT_BLUE_GAP_PROCEDURE_COMPLETE */
          break; /* ACI_GAP_PROC_COMPLETE_VSEVT_CODE */

        case ACI_HAL_END_OF_RADIO_ACTIVITY_VSEVT_CODE:
          /* USER CODE BEGIN RADIO_ACTIVITY_EVENT*/

          /* USER CODE END RADIO_ACTIVITY_EVENT*/
          break; /* ACI_HAL_END_OF_RADIO_ACTIVITY_VSEVT_CODE */

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

APP_BLE_ConnStatus_t APP_BLE_Get_Server_Connection_Status(void)
{
  return BleApplicationContext.Device_Connection_Status;
}
[/#if]


void BleStackCB_Process(void)
{  
  UTIL_SEQ_SetTask( 1U << CFG_TASK_BLE_HOST, CFG_SCH_PRIO_0);
}

/* USER CODE BEGIN FD*/

/* USER CODE END FD*/

/*************************************************************
 *
 * LOCAL FUNCTIONS
 *
 *************************************************************/
static void Ble_Hci_Gap_Gatt_Init(void)
{
  uint8_t role;
  uint16_t gap_service_handle, gap_dev_name_char_handle, gap_appearance_char_handle;
[#if ((CFG_BLE_ADDRESS_TYPE = "GAP_PUBLIC_ADDR") && (CUSTOM_TEMPLATE = 1))]
  const uint8_t *p_bd_addr;
[/#if]

[#if ((CFG_BLE_ADDRESS_TYPE = "GAP_RANDOM_ADDR") && (CUSTOM_TEMPLATE = 1))]
#if (CFG_BLE_ADDRESS_TYPE != GAP_PUBLIC_ADDR)
  uint32_t a_srd_bd_addr[2];
#endif
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
[#if ((CFG_BLE_ADDRESS_TYPE = "GAP_PUBLIC_ADDR") && (CUSTOM_TEMPLATE = 1))]
  /**
   * Write the BD Address
   */
  p_bd_addr = BleGetBdAddress();
  ret = aci_hal_write_config_data(CONFIG_DATA_PUBADDR_OFFSET,
                                  CONFIG_DATA_PUBADDR_LEN,
                                  (uint8_t*) p_bd_addr);
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

[#if ((CFG_BLE_ADDRESS_TYPE = "GAP_RANDOM_ADDR") && (CUSTOM_TEMPLATE = 1))]
  /**
   * Static random Address
   * The two upper bits shall be set to 1
   * The lowest 32bits is read from the UDN to differentiate between devices
   * The RNG may be used to provide a random number on each power on
   */
#if defined(CFG_STATIC_RANDOM_ADDRESS)
  a_srd_bd_addr[0] = CFG_STATIC_RANDOM_ADDRESS & 0xFFFFFFFF;
  a_srd_bd_addr[1] = (uint32_t)((uint64_t)CFG_STATIC_RANDOM_ADDRESS >> 32);
  a_srd_bd_addr[1] |= 0xC000; /* The two upper bits shall be set to 1 */
#elif (CFG_BLE_ADDRESS_TYPE == GAP_STATIC_RANDOM_ADDR)

  /* Enable RNG */
  __HAL_RNG_ENABLE(&hrng);

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

  /* Disable RNG */
  __HAL_RNG_DISABLE(&hrng);

#endif /* CFG_STATIC_RANDOM_ADDRESS */
[/#if]

[#if (CUSTOM_TEMPLATE = 1)]
#if (CFG_BLE_ADDRESS_TYPE != GAP_PUBLIC_ADDR)

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
#endif /* CFG_BLE_ADDRESS_TYPE != GAP_PUBLIC_ADDR */

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
    ret = aci_gap_init(role,
[#if (CUSTOM_TEMPLATE = 1)]
#if ((CFG_BLE_ADDRESS_TYPE == GAP_RESOLVABLE_PRIVATE_ADDR) || (CFG_BLE_ADDRESS_TYPE == GAP_NON_RESOLVABLE_PRIVATE_ADDR))
                       2,
#else
                       0,
#endif /* (CFG_BLE_ADDRESS_TYPE == GAP_RESOLVABLE_PRIVATE_ADDR) || (CFG_BLE_ADDRESS_TYPE == GAP_NON_RESOLVABLE_PRIVATE_ADDR) */
[#else]
                       0,
[/#if]
[#if (CUSTOM_TEMPLATE = 1)]
                       sizeof(a_GapDeviceName),
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

    ret = aci_gatt_update_char_value(gap_service_handle, gap_dev_name_char_handle, 0, strlen(a_GapDeviceName), (uint8_t *) a_GapDeviceName);
    if (ret != BLE_STATUS_SUCCESS)
    {
      APP_DBG_MSG("  Fail   : aci_gatt_update_char_value - Device Name\n");
    }
    else
    {
      APP_DBG_MSG("  Success: aci_gatt_update_char_value - Device Name\n");
    }
  }

  ret = aci_gatt_update_char_value(gap_service_handle,
                                   gap_appearance_char_handle,
                                   0,
                                   2,
                                   (uint8_t *)&a_appearance);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_gatt_update_char_value - Appearance\n");
  }
  else
  {
    APP_DBG_MSG("  Success: aci_gatt_update_char_value - Appearance\n");
  }

[#if (CUSTOM_TEMPLATE = 1)]
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
                                               CFG_BLE_ADDRESS_TYPE);
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
}

static void Ble_UserEvtRx( void)
{
  SVCCTL_UserEvtFlowStatus_t svctl_return_status;
  BleEvtPacket_t *phcievt;

  LST_remove_head ( &BleAsynchEventQueue, (tListNode **)&phcievt );

  svctl_return_status = SVCCTL_UserEvtRx((void *)&(phcievt->evtserial));

  if (svctl_return_status != SVCCTL_UserEvtFlowDisable)
  {
    UTIL_MM_ReleaseBuffer(phcievt);
  }
  else
  {
    LST_insert_head ( &BleAsynchEventQueue, (tListNode *)phcievt );
  }

  if((LST_is_empty(&BleAsynchEventQueue) == FALSE) && (svctl_return_status != SVCCTL_UserEvtFlowDisable) )
  {
    UTIL_SEQ_SetTask(1 << CFG_TASK_HCI_ASYNCH_EVT_ID, CFG_SCH_PRIO_0);
  }
}

static void Adv_Request(APP_BLE_ConnStatus_t NewStatus)
{
  tBleStatus ret = BLE_STATUS_INVALID_PARAMS;
  BleApplicationContext.Device_Connection_Status = NewStatus;
  /* Start Fast or Low Power Advertising */
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

  ret = aci_gap_delete_ad_type(AD_TYPE_TX_POWER_LEVEL);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("==>> delete tx power level - fail\n");
  }

  /* Update Advertising data */
  ret = aci_gap_update_adv_data(sizeof(a_AdvData), (uint8_t*) a_AdvData);
  if (ret != BLE_STATUS_SUCCESS)
  {
      APP_DBG_MSG("==>> Start Fast Advertising Failed , result: %d \n\r", ret);
  }
  else
  {
      APP_DBG_MSG("==>> Success: Start Fast Advertising \n\r");
  }

  return;
}
[/#if]


[#if ((CFG_BLE_ADDRESS_TYPE = "GAP_PUBLIC_ADDR") && (CUSTOM_TEMPLATE = 1))]
const uint8_t* BleGetBdAddress(void)
{
  OTP_Data_s *p_otp_addr = NULL;
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
    OTP_Read(0, &p_otp_addr);
    if (p_otp_addr)
    {
      p_bd_addr = (uint8_t*)(p_otp_addr->bd_address);
    }
    else
    {
      p_bd_addr = a_MBdAddr;
    }
  }

  return p_bd_addr;
}
[/#if]

static void BleStack_Process_BG(void)
{
  if(BleStack_Process( ) == 0x0)
  {
    BleStackCB_Process( );
  }
}

/* USER CODE BEGIN FD_LOCAL_FUNCTION */

/* USER CODE END FD_LOCAL_FUNCTION */

[#if (CUSTOM_TEMPLATE = 1)]
/*************************************************************
 *
 * SPECIFIC FUNCTIONS
 *
 *************************************************************/
[/#if]
[#if (CUSTOM_TEMPLATE = 1)]
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

uint8_t BLECB_Indication( const uint8_t* data,
                          uint16_t length,
                          const uint8_t* ext_data,
                          uint16_t ext_length )
{
  BleEvtPacket_t *phcievt;
  uint16_t total_length = (length+ext_length);

  APP_DBG_MSG("==>> BLECB_Indication\n");
  if (data[0] == HCI_EVENT_PKT_TYPE)
  {
    phcievt = (BleEvtPacket_t *)UTIL_MM_GetBuffer(sizeof(BleEvtPacketHeader_t) + total_length);

    if(phcievt != (BleEvtPacket_t *)0 )
    {
      APP_DBG_MSG("==>> BLECB_Indication: phcievt\n");
      phcievt->evtserial.type = HCI_EVENT_PKT_TYPE;
      phcievt->evtserial.evt.evtcode = data[1];
      phcievt->evtserial.evt.plen  = data[2];
      memcpy( (void*)&phcievt->evtserial.evt.payload, &data[3], data[2]);
      LST_insert_tail(&BleAsynchEventQueue, (tListNode *)phcievt);
      APP_DBG_MSG("\r Set CFG_TASK_HCI_ASYNCH_EVT_ID \n");
      UTIL_SEQ_SetTask(1 << CFG_TASK_HCI_ASYNCH_EVT_ID, CFG_SCH_PRIO_0);
    }
    else
    {
      APP_DBG_MSG("\r Memory pool Empty\n");
    }
  }
  else if(data[0] == HCI_ACLDATA_PKT_TYPE)
  {
  }
  return 0u;
}

/* USER CODE BEGIN FD_WRAP_FUNCTIONS */

/* USER CODE END FD_WRAP_FUNCTIONS */