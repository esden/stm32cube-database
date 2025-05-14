[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_ble.c
  * @author  GPM WBL Application Team
  * @brief   BLE Application
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign myHash = {}]
[#assign CFG_GAP_DEVICE_NAME = ""]
[#assign AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST_INV = ""]
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

[#list SWIPdatas as SWIP]
  [#if SWIP.defines??]
    [#list SWIP.defines as definition]
      [#if definition.name == "CFG_GAP_DEVICE_NAME"]
        [#assign CFG_GAP_DEVICE_NAME = definition.value]
      [/#if]
      [#if ("${definition.value}"=="valueNotSetted")]
              [#assign myHash = {definition.name:0} + myHash]
      [#else]
              [#assign myHash = {definition.name:definition.value} + myHash]
      [/#if]
      [#if definition.name == "AD_SERVICE_CLASS_UUID_1_INV"]
          [#assign AD_SERVICE_CLASS_UUID_1_INV = definition.value]
          [#if AD_SERVICE_CLASS_UUID_1_INV == "00 00"]
          [#assign AD_SERVICE_CLASS_UUID_1_INV = "[00, 00]"]
          [/#if]
          [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_1_INV]]
      [/#if]
      [#if definition.name == "AD_SERVICE_CLASS_UUID_2_INV"]
          [#assign AD_SERVICE_CLASS_UUID_2_INV = definition.value]
          [#if AD_SERVICE_CLASS_UUID_2_INV == "00 00"]
          [#assign AD_SERVICE_CLASS_UUID_2_INV = "[00, 00]"]
          [/#if]
          [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_2_INV]]
      [/#if]
      [#if definition.name == "AD_SERVICE_CLASS_UUID_3_INV"]
          [#assign AD_SERVICE_CLASS_UUID_3_INV = definition.value]
          [#if AD_SERVICE_CLASS_UUID_3_INV == "00 00"]
          [#assign AD_SERVICE_CLASS_UUID_3_INV = "[00, 00]"]
          [/#if]
          [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_3_INV]]
      [/#if]
      [#if definition.name == "AD_SERVICE_CLASS_UUID_4_INV"]
          [#assign AD_SERVICE_CLASS_UUID_4_INV = definition.value]
          [#if AD_SERVICE_CLASS_UUID_4_INV == "00 00"]
          [#assign AD_SERVICE_CLASS_UUID_4_INV = "[00, 00]"]
          [/#if]
          [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_4_INV]]
      [/#if]
      [#if definition.name == "AD_SERVICE_CLASS_UUID_5_INV"]
          [#assign AD_SERVICE_CLASS_UUID_5_INV = definition.value]
          [#if AD_SERVICE_CLASS_UUID_5_INV == "00 00"]
          [#assign AD_SERVICE_CLASS_UUID_5_INV = "[00, 00]"]
          [/#if]
          [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_5_INV]]
      [/#if]
      [#if definition.name == "AD_SERVICE_CLASS_UUID_6_INV"]
          [#assign AD_SERVICE_CLASS_UUID_6_INV = definition.value]
          [#if AD_SERVICE_CLASS_UUID_6_INV == "00 00"]
          [#assign AD_SERVICE_CLASS_UUID_6_INV = "[00, 00]"]
          [/#if]
          [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_6_INV]]
      [/#if]
      [#if definition.name == "AD_SERVICE_CLASS_UUID_7_INV"]
          [#assign AD_SERVICE_CLASS_UUID_7_INV = definition.value]
          [#if AD_SERVICE_CLASS_UUID_7_INV == "00 00"]
          [#assign AD_SERVICE_CLASS_UUID_7_INV = "[00, 00]"]
          [/#if]
          [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_7_INV]]
      [/#if]
      [#if definition.name == "AD_SERVICE_CLASS_UUID_8_INV"]
          [#assign AD_SERVICE_CLASS_UUID_8_INV = definition.value]
          [#if AD_SERVICE_CLASS_UUID_8_INV == "00 00"]
          [#assign AD_SERVICE_CLASS_UUID_8_INV = "[00, 00]"]
          [/#if]
          [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_8_INV]]
      [/#if]
      [#if definition.name == "AD_SERVICE_CLASS_UUID_9_INV"]
          [#assign AD_SERVICE_CLASS_UUID_9_INV = definition.value]
          [#if AD_SERVICE_CLASS_UUID_9_INV == "00 00"]
          [#assign AD_SERVICE_CLASS_UUID_9_INV = "[00, 00]"]
          [/#if]
          [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_9_INV]]
      [/#if]
      [#if definition.name == "AD_SERVICE_CLASS_UUID_10_INV"]
          [#assign AD_SERVICE_CLASS_UUID_10_INV = definition.value]
          [#if AD_SERVICE_CLASS_UUID_10_INV == "00 00"]
          [#assign AD_SERVICE_CLASS_UUID_10_INV = "[00, 00]"]
          [/#if]
          [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_10_INV]]
      [/#if]
      [#if definition.name == "AD_SERVICE_CLASS_UUID_11_INV"]
          [#assign AD_SERVICE_CLASS_UUID_11_INV = definition.value]
          [#if AD_SERVICE_CLASS_UUID_11_INV == "00 00"]
          [#assign AD_SERVICE_CLASS_UUID_11_INV = "[00, 00]"]
          [/#if]
          [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_11_INV]]
      [/#if]
      [#if definition.name == "AD_SERVICE_CLASS_UUID_12_INV"]
          [#assign AD_SERVICE_CLASS_UUID_12_INV = definition.value]
          [#if AD_SERVICE_CLASS_UUID_12_INV == "00 00"]
          [#assign AD_SERVICE_CLASS_UUID_12_INV = "[00, 00]"]
          [/#if]
          [#assign AD_SERVICE_CLASS_UUID_TABLE = AD_SERVICE_CLASS_UUID_TABLE + [AD_SERVICE_CLASS_UUID_12_INV]]
      [/#if]
      [#if definition.name == "AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST_INV"]
          [#assign AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST_INV = definition.value]
          [#if AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST_INV == "00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00"]
          [#assign AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST_INV = "[00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00]"]
          [/#if]
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

[#if myHash["NUMBER_OF_SERVICES"] != "0"]
  [#assign item = 0]
  [#assign item_NAME_START = item]
  [#assign item_LONG_NAME = item][#assign item = item + 1]
  [#assign item_SHORT_NAME = item]
  [#assign item_NAME_END = item]

  [#assign SERVICES_NAMES = {} /]
  [#list 1..myHash["NUMBER_OF_SERVICES"]?number as i]
    [#assign SERVICES_NAMES = SERVICES_NAMES + {i?string: [myHash["SERVICE"+i+"_LONG_NAME"],myHash["SERVICE"+i+"_SHORT_NAME"]]}/]
  [/#list]

  [#--
  [#list 1..myHash["NUMBER_OF_SERVICES"]?number as i]
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
#include <stdio.h>
#include <string.h>
#include "main.h"
#include "stm32wb0x.h"
#include "ble.h"
[#if  ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_BROADCASTER"] == "Enabled"))]
#include "gatt_profile.h"
[/#if]
#include "gap_profile.h"
#include "app_ble.h"
#include "stm32wb0x_hal_radio_timer.h"
#include "bleplat.h"
#include "nvm_db.h"
#include "blenvm.h"
#include "pka_manager.h"
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
#include "stm32_seq.h"
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

[/#if]
[#if  (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
#include "transport_layer.h"
#include "miscutil.h"
#include "aci_l2cap_nwk.h"
#include "aci_gatt_nwk.h"
#include "dm_alloc.h"
#include "aci_adv_nwk.h"
#include "dtm_burst.h"
[/#if]
[#if  (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
  [#if myHash["NUMBER_OF_SERVICES"] != "0"]
    [#list 1..myHash["NUMBER_OF_SERVICES"]?number as service]
#include "${SERVICES_NAMES[service?string][item_SHORT_NAME]?lower_case}.h"
#include "${SERVICES_NAMES[service?string][item_SHORT_NAME]?lower_case}_app.h"
    [/#list]
  [/#if]
[/#if]
[#if  (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
#include "gatt_client_app.h"
[/#if]
[#if  (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
/* Add aci_blue_initialized_event() prototype */
void aci_blue_initialized_event(uint8_t Reason_Code);

/* Add aci_blue_crash_info_event() prototype */
void aci_blue_crash_info_event(uint8_t Crash_Type,
                               uint32_t SP,
                               uint32_t R0,
                               uint32_t R1,
                               uint32_t R2,
                               uint32_t R3,
                               uint32_t R12,
                               uint32_t LR,
                               uint32_t PC,
                               uint32_t xPSR,
                               uint8_t Debug_Data_Length,
                               uint8_t Debug_Data[]);

uint16_t num_packets = 0;
[/#if]
/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */
[#if  ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]

/**
 * Security parameters structure
 */
typedef struct
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
   * minimum encryption key size requirement
   */
  uint8_t encryptionKeySizeMin;

  /**
   * maximum encryption key size requirement
   */
  uint8_t encryptionKeySizeMax;

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
}SecurityParams_t;

/**
 * Global context contains all BLE common variables.
 */
typedef struct
{
  /**
   * security requirements of the host
   */
  SecurityParams_t bleSecurityParam;

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
/* Private define ------------------------------------------------------------*/
[#if  (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
#define RESET_REASON_WDG        ((uint8_t)0x05)
#define RESET_REASON_LOCKUP     ((uint8_t)0x06)
#define RESET_REASON_POR_BOR    ((uint8_t)0x07)
#define RESET_REASON_CRASH      ((uint8_t)0x08)
[/#if]
/* USER CODE BEGIN PD */

/* USER CODE END PD */
/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */
/* Private variables ---------------------------------------------------------*/

NO_INIT(uint32_t dyn_alloc_a[BLE_DYN_ALLOC_SIZE>>2]);

[#if  (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
NO_INIT(uint32_t aci_gatt_adv_nwk_buffer[CFG_BLE_GATT_ADV_NWK_BUFFER_SIZE>>2]);

[/#if]
[#if  ((myHash["BLE_MODE_CENTRAL"] == "Enabled")|| (myHash["BLE_MODE_PERIPHERAL"] == "Enabled"))]
static BleApplicationContext_t bleAppContext;

[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]

  [#if myHash["NUMBER_OF_SERVICES"] != "0"]
    [#list 1..myHash["NUMBER_OF_SERVICES"]?number as service]
${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_APP_ConnHandleNotEvt_t ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification;

	[/#list]
  [/#if]
[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
GATT_CLIENT_APP_ConnHandle_Notif_evt_t clientHandleNotification;

[/#if]
[#if  (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled") && (myHash["BLE_MODE_BROADCASTER"] != "Enabled")]
static const char a_GapDeviceName[] = { [#rt] [#list "${CFG_GAP_DEVICE_NAME}"?split("(?!^)", "r") as char][#t][#lt]'${char}'<#sep>, [#rt]
    [/#list][#lt] }; /* Gap Device Name */

[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
/**
 * Advertising Data
 */
uint8_t a_AdvData[] =
{
  2, AD_TYPE_FLAGS, FLAG_BIT_LE_GENERAL_DISCOVERABLE_MODE|FLAG_BIT_BR_EDR_NOT_SUPPORTED,
[#if  (myHash["INCLUDE_AD_TYPE_TX_POWER_LEVEL"] == "1")]
  ${myHash["AD_TYPE_TX_POWER_LEVEL_LENGTH"]}, AD_TYPE_TX_POWER_LEVEL, ${myHash["AD_TYPE_TX_POWER_LEVEL_DBM"]}, /* Transmission Power */
[/#if]
[#if  (myHash["INCLUDE_AD_TYPE_COMPLETE_LOCAL_NAME"] == "1")]
  ${myHash["AD_TYPE_COMPLETE_LOCAL_NAME_LENGTH"]}, AD_TYPE_COMPLETE_LOCAL_NAME, [#rt]
    [#list myHash["AD_TYPE_COMPLETE_LOCAL_NAME"]?split("(?!^)", "r") as char][#t]
        [#lt]'${char}', [#rt]
    [/#list][#lt] /* Complete name */
[/#if]
[#if  (myHash["INCLUDE_AD_TYPE_SHORTENED_LOCAL_NAME"]  == "1")]
  ${myHash["AD_TYPE_SHORTENED_LOCAL_NAME_LENGTH"]}, AD_TYPE_SHORTENED_LOCAL_NAME , [#rt]
    [#list myHash["AD_TYPE_SHORTENED_LOCAL_NAME"]?split("(?!^)", "r") as char][#t]
        [#lt]'${char}', [#rt]
    [/#list][#lt] /* Shortened name */
[/#if]
[#if  (myHash["INCLUDE_AD_TYPE_APPEARANCE"] == "1")]
  ${myHash["AD_TYPE_APPEARANCE_LENGTH"]}, AD_TYPE_APPEARANCE, ${myHash["AD_TYPE_APPEARANCE"]},
[/#if]
[#if  (myHash["INCLUDE_AD_TYPE_ADVERTISING_INTERVAL"] == "1")]
  ${myHash["AD_TYPE_ADVERTISING_INTERVAL_LENGTH"]}, AD_TYPE_ADVERTISING_INTERVAL, [#assign res = myHash["ADV_INTERVAL_MAX_HEXA"]?matches("(.){2}")] ${res[0]}${res[1]}, ${res[0]}${res[2]} /* ${myHash["AD_TYPE_ADVERTISING_INTERVAL_VALUE"]} ms */,
[/#if]
[#if  (myHash["INCLUDE_AD_TYPE_LE_ROLE"] == "1")]
  ${myHash["AD_TYPE_LE_ROLE_LENGTH"]}, AD_TYPE_LE_ROLE, ${myHash["AD_TYPE_LE_ROLE"]},
[/#if]
[#if  (myHash["INCLUDE_AD_TYPE_16_BIT_SERV_UUID_CMPLT_LIST"] == "1")]
  ${myHash["AD_TYPE_16_BIT_SERV_UUID_CMPLT_LIST_LENGTH"]}, AD_TYPE_16_BIT_SERV_UUID_CMPLT_LIST, [#rt]
[#assign size = myHash["AD_SERVICE_CLASS_UUID_NBR"]?number-1]
[#list 0..size as i]
[#assign j = size-i]
0x${AD_SERVICE_CLASS_UUID_TABLE[j]?replace(", ",", 0x")?replace("[","")?replace("]","")}, [#rt]
[/#list]

[/#if]
[#if  (myHash["INCLUDE_AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST"] == "1")]
  ${myHash["AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST_LENGTH"]}, AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST, 0x${AD_TYPE_128_BIT_SERV_UUID_CMPLT_LIST_INV?replace(", ",", 0x")?replace("[","")?replace("]","")},
[/#if]
[#if  (myHash["INCLUDE_AD_TYPE_SLAVE_CONN_INTERVAL"] == "1")]
[#if  (myHash["AD_TYPE_SLAVE_CONN_INTERVAL_MIN_MAX"] == "1")]
  ${myHash["AD_TYPE_SLAVE_CONN_INTERVAL_LENGTH"]}, AD_TYPE_SLAVE_CONN_INTERVAL, ${myHash["AD_TYPE_SLAVE_CONN_INTERVAL_MIN_HEXA"]} /* ${myHash["AD_TYPE_SLAVE_CONN_INTERVAL_MIN"]} ms */, ${myHash["AD_TYPE_SLAVE_CONN_INTERVAL_MAX_HEXA"]} /* ${myHash["AD_TYPE_SLAVE_CONN_INTERVAL_MAX"]} ms*/,
[#else]
  ${myHash["AD_TYPE_SLAVE_CONN_INTERVAL_LENGTH"]}, AD_TYPE_SLAVE_CONN_INTERVAL, 0xFFFF,0xFFFF,
[/#if]
[/#if]
[#if  (myHash["INCLUDE_AD_TYPE_URI"] == "1")]
  ${myHash["AD_TYPE_URI_LENGTH"]}, AD_TYPE_URI, 0x${myHash["AD_TYPE_URI_CODE_POINT"]?replace(",",", 0x")}, '/', '/', [#rt]
    [#list myHash["AD_TYPE_URI_DATA"]?split("(?!^)", "r") as char][#t]
        [#lt]'${char}', [#rt]
    [/#list][#lt]

[/#if]
[#if  (myHash["INCLUDE_AD_TYPE_MANUFACTURER_SPECIFIC_DATA"] == "1")]
  ${myHash["AD_TYPE_MANUFACTURER_SPECIFIC_DATA_LENGTH"]}, AD_TYPE_MANUFACTURER_SPECIFIC_DATA, 0x${myHash["AD_TYPE_MANUFACTURER_SPECIFIC_DATA_COMPANY_IDENTIFIER"]?replace(",",", 0x")}, [#rt]
[#assign size = (myHash["AD_TYPE_MANUFACTURER_DATA_NBR"]?number-1)]
[#list 0..size as i]
0x${AD_TYPE_MANUFACTURER_DATA_TABLE[2*i]?replace(" ",", 0x")} /* ${AD_TYPE_MANUFACTURER_DATA_TABLE[2*i+1]} */, [#rt]
[/#list]

[/#if]
};

[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

[#if  (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
/* Global variables ----------------------------------------------------------*/

/* USER CODE BEGIN GV */

/* USER CODE END GV */
[/#if]

/* Private function prototypes -----------------------------------------------*/
[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") && (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled"))]
static void connection_complete_event(uint8_t Status,
                                      uint16_t Connection_Handle,
                                      uint8_t Peer_Address_Type,
                                      uint8_t Peer_Address[6],
                                      uint16_t Connection_Interval,
                                      uint16_t Peripheral_Latency,
                                      uint16_t Supervision_Timeout);
static void gap_cmd_resp_wait(void);
static void gap_cmd_resp_release(void);

[/#if]
[#if  (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
static void connection_complete_event(uint8_t Status,
                                      uint16_t Connection_Handle,
                                      uint8_t Role,
                                      uint8_t Peer_Address_Type,
                                      uint8_t Peer_Address[6],
                                      uint16_t Connection_Interval,
                                      uint16_t Peripheral_Latency,
                                      uint16_t Supervision_Timeout);
static void gap_cmd_resp_wait(void);
static void gap_cmd_resp_release(void);

[/#if]
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* External variables --------------------------------------------------------*/

/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private functions ---------------------------------------------------------*/

/* USER CODE BEGIN PF */

/* USER CODE END PF */

/* Functions Definition ------------------------------------------------------*/
void ModulesInit(void)
{
  BLENVM_Init();  
  if (PKAMGR_Init() == PKAMGR_ERROR)
  {
    Error_Handler();
  }
}

void BLE_Init(void)
{
[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled")||(myHash["BLE_MODE_CENTRAL"] == "Enabled")||(myHash["BLE_MODE_BROADCASTER"] == "Enabled"))]
  uint8_t role;
  uint8_t privacy_type = 0;
[/#if]
  tBleStatus ret;
[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled")|| (myHash["BLE_MODE_CENTRAL"] == "Enabled")||(myHash["BLE_MODE_BROADCASTER"] == "Enabled"))]
  uint16_t gatt_service_changed_handle;
[/#if]
[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled")|| (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
  uint16_t gap_dev_name_char_handle;
  uint16_t gap_appearance_char_handle;
  uint16_t gap_periph_pref_conn_param_char_handle;
[/#if]
[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled")|| (myHash["BLE_MODE_CENTRAL"] == "Enabled")||(myHash["BLE_MODE_BROADCASTER"] == "Enabled"))]
  uint8_t bd_address[6] = {0};
  uint8_t bd_address_len= 6;
[/#if]
[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled")|| (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
  uint16_t appearance = CFG_GAP_APPEARANCE;
[/#if]
  
  BLE_STACK_InitTypeDef BLE_STACK_InitParams = {
    .BLEStartRamAddress = (uint8_t*)dyn_alloc_a,
    .TotalBufferSize = BLE_DYN_ALLOC_SIZE,
    .NumAttrRecords = CFG_BLE_NUM_GATT_ATTRIBUTES,
    .MaxNumOfClientProcs = CFG_BLE_NUM_OF_CONCURRENT_GATT_CLIENT_PROC,
    .NumOfRadioTasks = CFG_BLE_NUM_RADIO_TASKS,
    .NumOfEATTChannels = CFG_BLE_NUM_EATT_CHANNELS,
    .NumBlockCount = CFG_BLE_MBLOCKS_COUNT,
    .ATT_MTU = CFG_BLE_ATT_MTU_MAX,
    .MaxConnEventLength = CFG_BLE_CONN_EVENT_LENGTH_MAX,
    .SleepClockAccuracy = CFG_BLE_SLEEP_CLOCK_ACCURACY,
    .NumOfAdvDataSet = CFG_BLE_NUM_ADV_SETS,
    .NumOfSubeventsPAwR = CFG_BLE_NUM_PAWR_SUBEVENTS,
    .MaxPAwRSubeventDataCount = CFG_BLE_PAWR_SUBEVENT_DATA_COUNT_MAX,
    .NumOfAuxScanSlots = CFG_BLE_NUM_AUX_SCAN_SLOTS,
    .FilterAcceptListSizeLog2 = CFG_BLE_FILTER_ACCEPT_LIST_SIZE_LOG2,
    .L2CAP_MPS = CFG_BLE_COC_MPS_MAX,
    .L2CAP_NumChannels = CFG_BLE_COC_NBR_MAX,
    .NumOfSyncSlots = CFG_BLE_NUM_SYNC_SLOTS,
    .CTE_MaxNumAntennaIDs = CFG_BLE_NUM_CTE_ANTENNA_IDS_MAX,
    .CTE_MaxNumIQSamples = CFG_BLE_NUM_CTE_IQ_SAMPLES_MAX,
    .NumOfSyncBIG = CFG_BLE_NUM_SYNC_BIG_MAX,
    .NumOfBrcBIG = CFG_BLE_NUM_BRC_BIG_MAX,
    .NumOfSyncBIS = CFG_BLE_NUM_SYNC_BIS_MAX,
    .NumOfBrcBIS = CFG_BLE_NUM_BRC_BIS_MAX,
    .NumOfCIG = CFG_BLE_NUM_CIG_MAX,
    .NumOfCIS = CFG_BLE_NUM_CIS_MAX,
    .isr0_fifo_size = CFG_BLE_ISR0_FIFO_SIZE,
    .isr1_fifo_size = CFG_BLE_ISR1_FIFO_SIZE, 
    .user_fifo_size = CFG_BLE_USER_FIFO_SIZE   
  };
  
  /* Bluetooth LE stack init */
  ret = BLE_STACK_Init(&BLE_STACK_InitParams);
  if (ret != BLE_STATUS_SUCCESS) {
[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled")|| (myHash["BLE_MODE_CENTRAL"] == "Enabled")|| (myHash["BLE_MODE_BROADCASTER"] == "Enabled"))]
    APP_DBG_MSG("Error in BLE_STACK_Init() 0x%02x\r\n", ret);
[/#if]
    Error_Handler();
  }
[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled")|| (myHash["BLE_MODE_BROADCASTER"] == "Enabled"))]

#if (CFG_BD_ADDRESS_TYPE == HCI_ADDR_PUBLIC)

  bd_address[0] = (uint8_t)((CFG_PUBLIC_BD_ADDRESS & 0x0000000000FF));
  bd_address[1] = (uint8_t)((CFG_PUBLIC_BD_ADDRESS & 0x00000000FF00) >> 8);
  bd_address[2] = (uint8_t)((CFG_PUBLIC_BD_ADDRESS & 0x000000FF0000) >> 16);
  bd_address[3] = (uint8_t)((CFG_PUBLIC_BD_ADDRESS & 0x0000FF000000) >> 24);
  bd_address[4] = (uint8_t)((CFG_PUBLIC_BD_ADDRESS & 0x00FF00000000) >> 32);
  bd_address[5] = (uint8_t)((CFG_PUBLIC_BD_ADDRESS & 0xFF0000000000) >> 40);
  (void)bd_address_len;

  ret = aci_hal_write_config_data(CONFIG_DATA_PUBADDR_OFFSET, CONFIG_DATA_PUBADDR_LEN, bd_address);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_hal_write_config_data command - CONFIG_DATA_PUBADDR_OFFSET, result: 0x%02X\n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_hal_write_config_data command - CONFIG_DATA_PUBADDR_OFFSET\n");
  }
#endif

  /**
   * Set TX Power.
   */
  ret = aci_hal_set_tx_power_level(0, CFG_TX_POWER);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_hal_set_tx_power_level command, result: 0x%02X\n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_hal_set_tx_power_level command\n");
  }

  /**
   * Initialize GATT interface
   */
  ret = aci_gatt_srv_profile_init(GATT_INIT_SERVICE_CHANGED_BIT, &gatt_service_changed_handle);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_gatt_srv_profile_init command, result: 0x%02X\n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_gatt_srv_profile_init command\n");
  }

  /**
   * Initialize GAP interface
   */
  role = 0U;
[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") && (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled") || (myHash["BLE_MODE_BROADCASTER"] == "Enabled"))]
  role |= GAP_PERIPHERAL_ROLE;

[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
  role |= GAP_CENTRAL_ROLE;
[/#if]
#if CFG_BLE_PRIVACY_ENABLED
  privacy_type = 0x02;
#endif

/* USER CODE BEGIN Role_Mngt*/

/* USER CODE END Role_Mngt */

  ret = aci_gap_init(privacy_type, CFG_BD_ADDRESS_TYPE);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_gap_init command, result: 0x%02X\n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_gap_init command\n");
  }

[#if (myHash["BLE_MODE_BROADCASTER"] != "Enabled")]
  ret = aci_gap_profile_init(role, privacy_type,
                             &gap_dev_name_char_handle,
                             &gap_appearance_char_handle,
                             &gap_periph_pref_conn_param_char_handle);
[/#if]

#if (CFG_BD_ADDRESS_TYPE == HCI_ADDR_STATIC_RANDOM_ADDR)
  ret = aci_hal_read_config_data(CONFIG_DATA_STORED_STATIC_RANDOM_ADDRESS,
                                 &bd_address_len, bd_address);
  APP_DBG_MSG("  Static Random Bluetooth Address: %02x:%02x:%02x:%02x:%02x:%02x\n",bd_address[5],bd_address[4],bd_address[3],bd_address[2],bd_address[1],bd_address[0]);
#elif (CFG_BD_ADDRESS_TYPE == HCI_ADDR_PUBLIC)
  APP_DBG_MSG("  Public Bluetooth Address: %02x:%02x:%02x:%02x:%02x:%02x\n",bd_address[5],bd_address[4],bd_address[3],bd_address[2],bd_address[1],bd_address[0]);
#else
#error "Invalid CFG_BD_ADDRESS_TYPE"
#endif

[#if (myHash["BLE_MODE_BROADCASTER"] == "Enabled")]
  APP_DBG_MSG("BLE stack initialized\r\n");
[/#if]
[#if (myHash["BLE_MODE_BROADCASTER"] != "Enabled")]
  ret = Gap_profile_set_dev_name(0, sizeof(a_GapDeviceName), (uint8_t*)a_GapDeviceName);

  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : Gap_profile_set_dev_name - Device Name, result: 0x%02X\n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: Gap_profile_set_dev_name - Device Name\n");
  }

  ret = Gap_profile_set_appearance(0, sizeof(appearance), (uint8_t*)&appearance);
  
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : Gap_profile_set_appearance - Appearance, result: 0x%02X\n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: Gap_profile_set_appearance - Appearance\n");
  }

[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]

#if CFG_BLE_CONTROLLER_2M_CODED_PHY_ENABLED
[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
  /* Initialize Default PHY */
  ret = hci_le_set_default_phy(0x00, HCI_TX_PHYS_LE_2M_PREF, HCI_RX_PHYS_LE_2M_PREF);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : hci_le_set_default_phy command, result: 0x%02X\n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: hci_le_set_default_phy command\n");
  }

[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
#endif
[/#if]
[/#if]
[#if (myHash["BLE_MODE_BROADCASTER"] != "Enabled")]
  /**
   * Initialize IO capability
   */
  bleAppContext.BleApplicationContext_legacy.bleSecurityParam.ioCapability = CFG_IO_CAPABILITY;
  ret = aci_gap_set_io_capability(bleAppContext.BleApplicationContext_legacy.bleSecurityParam.ioCapability);
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_gap_set_io_capability command, result: 0x%02X\n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_gap_set_io_capability command\n");
  }

  /**
   * Initialize authentication
   */
  bleAppContext.BleApplicationContext_legacy.bleSecurityParam.mitm_mode             = CFG_MITM_PROTECTION;
  bleAppContext.BleApplicationContext_legacy.bleSecurityParam.encryptionKeySizeMin  = CFG_ENCRYPTION_KEY_SIZE_MIN;
  bleAppContext.BleApplicationContext_legacy.bleSecurityParam.encryptionKeySizeMax  = CFG_ENCRYPTION_KEY_SIZE_MAX;
  bleAppContext.BleApplicationContext_legacy.bleSecurityParam.bonding_mode          = CFG_BONDING_MODE;
  /* USER CODE BEGIN Ble_Hci_Gap_Gatt_Init_1*/

  /* USER CODE END Ble_Hci_Gap_Gatt_Init_1*/

  ret = aci_gap_set_security_requirements(bleAppContext.BleApplicationContext_legacy.bleSecurityParam.bonding_mode,
                                               bleAppContext.BleApplicationContext_legacy.bleSecurityParam.mitm_mode,
                                               CFG_SC_SUPPORT,
                                               CFG_KEYPRESS_NOTIFICATION_SUPPORT,
                                               bleAppContext.BleApplicationContext_legacy.bleSecurityParam.encryptionKeySizeMin,
                                               bleAppContext.BleApplicationContext_legacy.bleSecurityParam.encryptionKeySizeMax,
                                               GAP_PAIRING_RESP_NONE);

  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_gap_set_security_requirements command, result: 0x%02X\n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_gap_set_security_requirements command\n");
  }

  /**
   * Initialize Filter Accept List
   */
  if (bleAppContext.BleApplicationContext_legacy.bleSecurityParam.bonding_mode)
  {
    ret = aci_gap_configure_filter_accept_and_resolving_list(0x01);
    if (ret != BLE_STATUS_SUCCESS)
    {
      APP_DBG_MSG("  Fail   : aci_gap_configure_filter_accept_and_resolving_list command, result: 0x%02X\n", ret);
    }
    else
    {
      APP_DBG_MSG("  Success: aci_gap_configure_filter_accept_and_resolving_list command\n");
    }
  }

  APP_DBG_MSG("==>> End BLE_Init function\n");
  
[/#if]
[/#if]
}

void BLEStack_Process_Schedule(void)
{
  /* Keep BLE Stack Process priority low, since there are limited cases
     where stack wants to be rescheduled for busy waiting.  */
  UTIL_SEQ_SetTask( 1U << CFG_TASK_BLE_STACK, CFG_SEQ_PRIO_1);
}

static void BLEStack_Process(void)
{
  APP_DEBUG_SIGNAL_SET(APP_STACK_PROCESS);
  BLE_STACK_Tick();
  
  if(BLE_STACK_SleepCheck() == 0)
  {
    BLEStack_Process_Schedule();
  }
  APP_DEBUG_SIGNAL_RESET(APP_STACK_PROCESS);
}

void VTimer_Process(void)
{
  HAL_RADIO_TIMER_Tick();
}

void VTimer_Process_Schedule(void)
{
  UTIL_SEQ_SetTask( 1U << CFG_TASK_VTIMER, CFG_SEQ_PRIO_0);
}

void NVM_Process(void)
{
  NVMDB_Tick();
}

void NVM_Process_Schedule(void)
{
  UTIL_SEQ_SetTask( 1U << CFG_TASK_NVM, CFG_SEQ_PRIO_1);
}

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
void TM_Process_Schedule(void)
{
  UTIL_SEQ_SetTask( 1U << CFG_TASK_TM, CFG_SEQ_PRIO_1);
}

void TM_Process(void)
{
  transport_layer_tick();
}

void BURST_Process_Schedule(void)
{
  UTIL_SEQ_SetTask( 1U << CFG_TASK_BURST, CFG_SEQ_PRIO_1);
}

void BURST_Process(void)
{
  BURST_Tick();
}
[/#if]

/* Function called from PKA_IRQHandler() context. */
void PKAMGR_IRQCallback(void)
{
  BLEStack_Process_Schedule();
}

/* Function called from RADIO_TIMER_TXRX_WKUP_IRQHandler() context. */
void HAL_RADIO_TIMER_TxRxWakeUpCallback(void)
{
  VTimer_Process_Schedule();  
  BLEStack_Process_Schedule();
}

/* Function called from RADIO_TIMER_CPU_WKUP_IRQHandler() context. */
void HAL_RADIO_TIMER_CpuWakeUpCallback(void)
{
  VTimer_Process_Schedule();  
  BLEStack_Process_Schedule();
}

/* Function called from RADIO_TXRX_IRQHandler() context. */
void HAL_RADIO_TxRxCallback(uint32_t flags)
{
  BLE_STACK_RadioHandler(flags);
  
  BLEStack_Process_Schedule();
  VTimer_Process_Schedule();
  NVM_Process_Schedule();  
}

/* Functions Definition ------------------------------------------------------*/
void APP_BLE_Init(void)
{
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
  crash_info_t crash_info;
[/#if]
  /* USER CODE BEGIN APP_BLE_Init_1 */

  /* USER CODE END APP_BLE_Init_1 */

  UTIL_SEQ_RegTask(1U << CFG_TASK_BLE_STACK, UTIL_SEQ_RFU, BLEStack_Process);
  UTIL_SEQ_RegTask(1U << CFG_TASK_VTIMER, UTIL_SEQ_RFU, VTimer_Process);
  UTIL_SEQ_RegTask(1U << CFG_TASK_NVM, UTIL_SEQ_RFU, NVM_Process);
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
  UTIL_SEQ_RegTask(1U << CFG_TASK_TM, UTIL_SEQ_RFU, TM_Process);
  UTIL_SEQ_RegTask(1U << CFG_TASK_BURST, UTIL_SEQ_RFU, BURST_Process);
[/#if]

  ModulesInit();
  
  /* Initialization of HCI & GATT & GAP layer */
  BLE_Init();
  
  /* Need to call stack process at least once. */
  BLEStack_Process_Schedule();
[#if (myHash["BLE_MODE_BROADCASTER"] == "Enabled")]

/* USER CODE BEGIN APP_BLE_Init_2 */

/* USER CODE END APP_BLE_Init_2 */
  return;
}

void BLEEVT_App_Notification(const hci_pckt *hci_pckt)
{
  
}

/* Event used to notify the Host that a hardware failure has occurred in the Controller. 
   See ble_events.h. */
void hci_hardware_error_event(uint8_t Hardware_Code)
{
  if (Hardware_Code <= 0x03)
  {
    NVIC_SystemReset();
  }
}
[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]

  /**
  * Initialization of the BLE App Context
  */
  bleAppContext.Device_Connection_Status = APP_BLE_IDLE;
  bleAppContext.BleApplicationContext_legacy.connectionHandle = 0xFFFF;

  /* From here, all initialization are BLE application specific */

  /* USER CODE BEGIN APP_BLE_Init_4 */

  /* USER CODE END APP_BLE_Init_4 */

  /**
  * Initialize Services and Characteristics.
  */
[#if myHash["NUMBER_OF_SERVICES"] != "0"]
  APP_DBG_MSG("\n");
  APP_DBG_MSG("Services and Characteristics creation\n");
  [#list 1..myHash["NUMBER_OF_SERVICES"]?number as service]
  ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_APP_Init();
  [/#list]
  APP_DBG_MSG("End of Services and Characteristics creation\n");
  APP_DBG_MSG("\n");
[/#if]

  /* USER CODE BEGIN APP_BLE_Init_3 */

  /* USER CODE END APP_BLE_Init_3 */
[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled")]

  /**
  * Initialize GATT Client Application
  */
  GATT_CLIENT_APP_Init();

[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled") ||(myHash["BLE_MODE_CENTRAL"] == "Enabled")]

  /* USER CODE BEGIN APP_BLE_Init_2 */

  /* USER CODE END APP_BLE_Init_2 */

  return;
}

void BLEEVT_App_Notification(const hci_pckt *hci_pckt)
{
  tBleStatus ret = BLE_STATUS_ERROR;
  hci_event_pckt    *p_event_pckt;
  hci_le_meta_event *p_meta_evt;
  void *event_data;

  UNUSED(ret);
  /* USER CODE BEGIN SVCCTL_App_Notification */

  /* USER CODE END SVCCTL_App_Notification */
  
  if(hci_pckt->type != HCI_EVENT_PKT_TYPE && hci_pckt->type != HCI_EVENT_EXT_PKT_TYPE)
  {
    /* Not an event */
    return;
  }

  p_event_pckt = (hci_event_pckt*)hci_pckt->data;

  if(hci_pckt->type == HCI_EVENT_PKT_TYPE){
    event_data = p_event_pckt->data;
  }
  else { /* hci_pckt->type == HCI_EVENT_EXT_PKT_TYPE */
    hci_event_ext_pckt *p_event_pckt = (hci_event_ext_pckt*)hci_pckt->data;
    event_data = p_event_pckt->data;
  }

  switch (p_event_pckt->evt) /* evt field is at same offset in hci_event_pckt and hci_event_ext_pckt */
  {
  case HCI_DISCONNECTION_COMPLETE_EVT_CODE:
    {
      hci_disconnection_complete_event_rp0 *p_disconnection_complete_event;
      p_disconnection_complete_event = (hci_disconnection_complete_event_rp0 *) p_event_pckt->data;

        /* USER CODE BEGIN EVT_DISCONN_COMPLETE_3 */

        /* USER CODE END EVT_DISCONN_COMPLETE_3 */

      if (p_disconnection_complete_event->Connection_Handle == bleAppContext.BleApplicationContext_legacy.connectionHandle)
      {
        bleAppContext.BleApplicationContext_legacy.connectionHandle = 0xFFFF;
        bleAppContext.Device_Connection_Status = APP_BLE_IDLE;
        APP_DBG_MSG(">>== HCI_DISCONNECTION_COMPLETE_EVT_CODE\n");
        APP_DBG_MSG("     - Connection Handle:   0x%02X\n     - Reason:    0x%02X\n",
                    p_disconnection_complete_event->Connection_Handle,
                    p_disconnection_complete_event->Reason);

        /* USER CODE BEGIN EVT_DISCONN_COMPLETE_2 */

        /* USER CODE END EVT_DISCONN_COMPLETE_2 */
      }

      gap_cmd_resp_release();

      /* USER CODE BEGIN EVT_DISCONN_COMPLETE_1 */

      /* USER CODE END EVT_DISCONN_COMPLETE_1 */
[#if myHash["NUMBER_OF_SERVICES"] != "0"]
  [#list 1..myHash["NUMBER_OF_SERVICES"]?number as service]
      ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification.EvtOpcode = ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_DISCON_HANDLE_EVT;
      ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification.ConnectionHandle = p_disconnection_complete_event->Connection_Handle;
      ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_APP_EvtRx(&${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification);
  [/#list]
[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
      /* USER CODE BEGIN EVT_DISCONN_COMPLETE */

      /* USER CODE END EVT_DISCONN_COMPLETE */
[/#if]
    }
    break;

  case HCI_LE_META_EVT_CODE:
    {
      p_meta_evt = (hci_le_meta_event*) p_event_pckt->data;
      /* USER CODE BEGIN EVT_LE_META_EVENT */

      /* USER CODE END EVT_LE_META_EVENT */
      switch (p_meta_evt->subevent)
      {
      case HCI_LE_CONNECTION_UPDATE_COMPLETE_SUBEVT_CODE:
        {
          hci_le_connection_update_complete_event_rp0 *p_conn_update_complete;
          p_conn_update_complete = (hci_le_connection_update_complete_event_rp0 *) p_meta_evt->data;
          APP_DBG_MSG(">>== HCI_LE_CONNECTION_UPDATE_COMPLETE_SUBEVT_CODE\n");
          APP_DBG_MSG("     - Connection Interval:   %d.%02d ms\n     - Connection latency:    %d\n     - Supervision Timeout:   %d ms\n",
                      INT(p_conn_update_complete->Connection_Interval*1.25),
                      FRACTIONAL_2DIGITS(p_conn_update_complete->Connection_Interval*1.25),
                      p_conn_update_complete->Peripheral_Latency,
                      p_conn_update_complete->Supervision_Timeout*10);
          UNUSED(p_conn_update_complete);
          /* USER CODE BEGIN EVT_LE_CONN_UPDATE_COMPLETE */

          /* USER CODE END EVT_LE_CONN_UPDATE_COMPLETE */
        }
        break;
      case HCI_LE_PHY_UPDATE_COMPLETE_SUBEVT_CODE:
        {
          hci_le_phy_update_complete_event_rp0 *p_le_phy_update_complete;
          p_le_phy_update_complete = (hci_le_phy_update_complete_event_rp0*)p_meta_evt->data;
          UNUSED(p_le_phy_update_complete);

          gap_cmd_resp_release();

          /* USER CODE BEGIN EVT_LE_PHY_UPDATE_COMPLETE */

          /* USER CODE END EVT_LE_PHY_UPDATE_COMPLETE */
        }
        break;
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
      case HCI_LE_ENHANCED_CONNECTION_COMPLETE_SUBEVT_CODE:
        {
          hci_le_enhanced_connection_complete_event_rp0 *p_enhanced_conn_complete;
          p_enhanced_conn_complete = (hci_le_enhanced_connection_complete_event_rp0 *) p_meta_evt->data;

          connection_complete_event(p_enhanced_conn_complete->Status,
                                    p_enhanced_conn_complete->Connection_Handle,
                                    p_enhanced_conn_complete->Peer_Address_Type,
                                    p_enhanced_conn_complete->Peer_Address,
                                    p_enhanced_conn_complete->Connection_Interval,
                                    p_enhanced_conn_complete->Peripheral_Latency,
                                    p_enhanced_conn_complete->Supervision_Timeout);
        }
        break;
      case HCI_LE_CONNECTION_COMPLETE_SUBEVT_CODE:
        {
          hci_le_connection_complete_event_rp0 *p_conn_complete;
          p_conn_complete = (hci_le_connection_complete_event_rp0 *) p_meta_evt->data;

          connection_complete_event(p_conn_complete->Status,
                                    p_conn_complete->Connection_Handle,
                                    p_conn_complete->Peer_Address_Type,
                                    p_conn_complete->Peer_Address,
                                    p_conn_complete->Connection_Interval,
                                    p_conn_complete->Peripheral_Latency,
                                    p_conn_complete->Supervision_Timeout);
        }
        break;
[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
      case HCI_LE_ENHANCED_CONNECTION_COMPLETE_SUBEVT_CODE:
        {
          hci_le_enhanced_connection_complete_event_rp0 *p_enhanced_conn_complete;
          p_enhanced_conn_complete = (hci_le_enhanced_connection_complete_event_rp0 *) p_meta_evt->data;

          connection_complete_event(p_enhanced_conn_complete->Status,
                                    p_enhanced_conn_complete->Connection_Handle,
									p_enhanced_conn_complete->Role,
                                    p_enhanced_conn_complete->Peer_Address_Type,
                                    p_enhanced_conn_complete->Peer_Address,
                                    p_enhanced_conn_complete->Connection_Interval,
                                    p_enhanced_conn_complete->Peripheral_Latency,
                                    p_enhanced_conn_complete->Supervision_Timeout);
        }
        break;
      case HCI_LE_CONNECTION_COMPLETE_SUBEVT_CODE:
        {
          hci_le_connection_complete_event_rp0 *p_conn_complete;
          p_conn_complete = (hci_le_connection_complete_event_rp0 *) p_meta_evt->data;

          connection_complete_event(p_conn_complete->Status,
                                    p_conn_complete->Connection_Handle,
									p_conn_complete->Role,
                                    p_conn_complete->Peer_Address_Type,
                                    p_conn_complete->Peer_Address,
                                    p_conn_complete->Connection_Interval,
                                    p_conn_complete->Peripheral_Latency,
                                    p_conn_complete->Supervision_Timeout);
        }
        break;
      case HCI_LE_ADVERTISING_REPORT_SUBEVT_CODE:
        {
          hci_le_advertising_report_event_rp0 *p_adv_report;
          p_adv_report = (hci_le_advertising_report_event_rp0 *) p_meta_evt->data;
          /* USER CODE BEGIN EVT_LE_ADVERTISING_REPORT */

          /* USER CODE END EVT_LE_ADVERTISING_REPORT */
	  UNUSED(p_adv_report);

        }
        break;
      case HCI_LE_EXTENDED_ADVERTISING_REPORT_SUBEVT_CODE:
        {
          hci_le_extended_advertising_report_event_rp0 *p_ext_adv_report;
          p_ext_adv_report = (hci_le_extended_advertising_report_event_rp0 *) p_meta_evt->data;
          /* USER CODE BEGIN EVT_LE_EXT_ADVERTISING_REPORT */

          /* USER CODE END EVT_LE_EXT_ADVERTISING_REPORT */
          UNUSED(p_ext_adv_report);

        }
        break;
[/#if]
      /* USER CODE BEGIN EVT_LE_META_EVENT_1 */

      /* USER CODE END EVT_LE_META_EVENT_1 */

      default:
        /* USER CODE BEGIN SUBEVENT_DEFAULT */

        /* USER CODE END SUBEVENT_DEFAULT */
        break;
      }
    } /* HCI_LE_META_EVT_CODE */
    break;

  case HCI_VENDOR_EVT_CODE:
    {
      aci_blecore_event *p_blecore_evt = (aci_blecore_event*) event_data;
      /* USER CODE BEGIN EVT_VENDOR */

      /* USER CODE END EVT_VENDOR */
      switch (p_blecore_evt->ecode)
      {
        /* USER CODE BEGIN ecode */

        /* USER CODE END ecode */
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
      case ACI_L2CAP_CONNECTION_UPDATE_RESP_VSEVT_CODE:
        {
          aci_l2cap_connection_update_resp_event_rp0 *p_l2cap_conn_update_resp;
          p_l2cap_conn_update_resp = (aci_l2cap_connection_update_resp_event_rp0 *) p_blecore_evt->data;
          UNUSED(p_l2cap_conn_update_resp);
[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
      case ACI_L2CAP_CONNECTION_UPDATE_REQ_VSEVT_CODE:
        {
          aci_l2cap_connection_update_req_event_rp0 *p_l2cap_conn_update_req;
          p_l2cap_conn_update_req = (aci_l2cap_connection_update_req_event_rp0 *) p_blecore_evt->data;
          tBleStatus ret; 
          uint8_t req_resp = 0x01;

          /* USER CODE BEGIN EVT_L2CAP_CONNECTION_UPDATE_REQ */

          /* USER CODE END EVT_L2CAP_CONNECTION_UPDATE_REQ */

          ret = aci_l2cap_connection_parameter_update_resp(p_l2cap_conn_update_req->Connection_Handle,
                                                           p_l2cap_conn_update_req->Connection_Interval_Min,
                                                           p_l2cap_conn_update_req->Connection_Interval_Max,
                                                           p_l2cap_conn_update_req->Max_Latency,
                                                           p_l2cap_conn_update_req->Timeout_Multiplier,
                                                           CONN_CE_LENGTH_MS(10),
                                                           CONN_CE_LENGTH_MS(10),
                                                           p_l2cap_conn_update_req->Identifier,
                                                           req_resp);
          if(ret != BLE_STATUS_SUCCESS)
          {
            APP_DBG_MSG("  Fail   : aci_l2cap_connection_parameter_update_resp command\n");
          }
          else
          {
            APP_DBG_MSG("  Success: aci_l2cap_connection_parameter_update_resp command\n");
          }

[/#if]
          /* USER CODE BEGIN EVT_L2CAP_CONNECTION_UPDATE_RESP */

          /* USER CODE END EVT_L2CAP_CONNECTION_UPDATE_RESP */
        }
        break;
      case ACI_GAP_PROC_COMPLETE_VSEVT_CODE:
        {
          APP_DBG_MSG(">>== ACI_GAP_PROC_COMPLETE_VSEVT_CODE\n");
          aci_gap_proc_complete_event_rp0 *p_gap_proc_complete;
          p_gap_proc_complete = (aci_gap_proc_complete_event_rp0*) p_blecore_evt->data;
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
          UNUSED(p_gap_proc_complete);
[/#if]

          /* USER CODE BEGIN EVT_GAP_PROCEDURE_COMPLETE */

          /* USER CODE END EVT_GAP_PROCEDURE_COMPLETE */
        }
        break;
      case ACI_HAL_END_OF_RADIO_ACTIVITY_VSEVT_CODE:
        /* USER CODE BEGIN RADIO_ACTIVITY_EVENT*/

        /* USER CODE END RADIO_ACTIVITY_EVENT*/
        break;
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled")]
      case ACI_GAP_KEYPRESS_NOTIFICATION_VSEVT_CODE:
        {
          APP_DBG_MSG(">>== ACI_GAP_KEYPRESS_NOTIFICATION_VSEVT_CODE\n");
          /* USER CODE BEGIN ACI_GAP_KEYPRESS_NOTIFICATION_VSEVT_CODE*/

          /* USER CODE END ACI_GAP_KEYPRESS_NOTIFICATION_VSEVT_CODE*/
        }
        break;
      case ACI_GAP_PASSKEY_REQ_VSEVT_CODE:
        {
          APP_DBG_MSG(">>== ACI_GAP_PASSKEY_REQ_VSEVT_CODE\n");

          ret = aci_gap_passkey_resp(bleAppContext.BleApplicationContext_legacy.connectionHandle, CFG_FIXED_PIN);
          if (ret != BLE_STATUS_SUCCESS)
          {
            APP_DBG_MSG("==>> aci_gap_passkey_resp : Fail, reason: 0x%02X\n", ret);
          }
          else
          {
            APP_DBG_MSG("==>> aci_gap_passkey_resp : Success\n");
          }
          /* USER CODE BEGIN ACI_GAP_PASSKEY_REQ_VSEVT_CODE*/

          /* USER CODE END ACI_GAP_PASSKEY_REQ_VSEVT_CODE*/
        }
        break;
[#if (myHash["CFG_BLE_SECURE_CONNECTIONS_ENABLED"] == "1")]
      case ACI_GAP_NUMERIC_COMPARISON_VALUE_VSEVT_CODE:
        {
          uint8_t confirm_value;
          APP_DBG_MSG(">>== ACI_GAP_NUMERIC_COMPARISON_VALUE_VSEVT_CODE\n");
          APP_DBG_MSG("     - numeric_value = %d\n",
                      ((aci_gap_numeric_comparison_value_event_rp0 *)(p_blecore_evt->data))->Numeric_Value);
          APP_DBG_MSG("     - Hex_value = %x\n",
                      ((aci_gap_numeric_comparison_value_event_rp0 *)(p_blecore_evt->data))->Numeric_Value);

          /* Set confirm value to 1(YES) */
          confirm_value = 1;
          /* USER CODE BEGIN ACI_GAP_NUMERIC_COMPARISON_VALUE_VSEVT_CODE_0*/

          /* USER CODE END ACI_GAP_NUMERIC_COMPARISON_VALUE_VSEVT_CODE_0*/

          ret = aci_gap_numeric_comparison_value_confirm_yesno(bleAppContext.BleApplicationContext_legacy.connectionHandle, confirm_value);
          if (ret != BLE_STATUS_SUCCESS)
          {
            APP_DBG_MSG("==>> aci_gap_numeric_comparison_value_confirm_yesno : Fail, reason: 0x%02X\n", ret);
          }
          else
          {
            APP_DBG_MSG("==>> aci_gap_numeric_comparison_value_confirm_yesno : Success\n");
          }
          /* USER CODE BEGIN ACI_GAP_NUMERIC_COMPARISON_VALUE_VSEVT_CODE*/

          /* USER CODE END ACI_GAP_NUMERIC_COMPARISON_VALUE_VSEVT_CODE*/
        }
        break;
[/#if]
      case ACI_GAP_PAIRING_COMPLETE_VSEVT_CODE:
        {
          APP_DBG_MSG(">>== ACI_GAP_PAIRING_COMPLETE_VSEVT_CODE\n");
          aci_gap_pairing_complete_event_rp0 *p_pairing_complete;
          p_pairing_complete = (aci_gap_pairing_complete_event_rp0*)p_blecore_evt->data;

          if (p_pairing_complete->Status != 0)
          {
            APP_DBG_MSG("     - Pairing KO\n     - Status: 0x%02X\n     - Reason: 0x%02X\n",
                        p_pairing_complete->Status, p_pairing_complete->Reason);
          }
          else
          {
            APP_DBG_MSG("     - Pairing Success\n");
          }
          APP_DBG_MSG("\n");

          /* USER CODE BEGIN ACI_GAP_PAIRING_COMPLETE_VSEVT_CODE*/

          /* USER CODE END ACI_GAP_PAIRING_COMPLETE_VSEVT_CODE*/
        }
        break;
[/#if]
        /* USER CODE BEGIN EVT_VENDOR_1 */

        /* USER CODE END EVT_VENDOR_1 */
      default:
        /* USER CODE BEGIN EVT_VENDOR_DEFAULT */

        /* USER CODE END EVT_VENDOR_DEFAULT */
        break;
      }
    } /* HCI_VENDOR_EVT_CODE */
    break;

  case HCI_HARDWARE_ERROR_EVT_CODE:
    {
      hci_hardware_error_event_rp0 *p_hci_hardware_error_event;
      p_hci_hardware_error_event = (hci_hardware_error_event_rp0*)p_event_pckt->data;

      if (p_hci_hardware_error_event->Hardware_Code <= 0x03)
      {
        NVIC_SystemReset();
      }
    }
    break;

    /* USER CODE BEGIN EVENT_PCKT */

    /* USER CODE END EVENT_PCKT */

  default:
    /* USER CODE BEGIN ECODE_DEFAULT*/

    /* USER CODE END ECODE_DEFAULT*/
    break;
  }
}
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]

static void connection_complete_event(uint8_t Status,
                                      uint16_t Connection_Handle,
                                      uint8_t Peer_Address_Type,
                                      uint8_t Peer_Address[6],
                                      uint16_t Connection_Interval,
                                      uint16_t Peripheral_Latency,
                                      uint16_t Supervision_Timeout)
{
[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]

static void connection_complete_event(uint8_t Status,
                                      uint16_t Connection_Handle,
                                      uint8_t Role,
                                      uint8_t Peer_Address_Type,
                                      uint8_t Peer_Address[6],
                                      uint16_t Conn_Interval,
                                      uint16_t Peripheral_Latency,
                                      uint16_t Supervision_Timeout)
{
[/#if]
  /* USER CODE BEGIN HCI_EVT_LE_CONN_COMPLETE_1 */

  /* USER CODE END HCI_EVT_LE_CONN_COMPLETE_1 */
  APP_DBG_MSG(">>== hci_le_connection_complete_event - Connection handle: 0x%04X\n", Connection_Handle);
  APP_DBG_MSG("     - Connection established with @:%02x:%02x:%02x:%02x:%02x:%02x\n",
              Peer_Address[5],
              Peer_Address[4],
              Peer_Address[3],
              Peer_Address[2],
              Peer_Address[1],
              Peer_Address[0]);
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
   APP_DBG_MSG("     - Connection Interval:   %d.%02d ms\n     - Connection latency:    %d\n     - Supervision Timeout: %d ms\n",
               INT(Conn_Interval*1.25),
               FRACTIONAL_2DIGITS(Conn_Interval*1.25),
               Peripheral_Latency,
               Supervision_Timeout * 10
                 );

[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]  
   if (bleAppContext.Device_Connection_Status == APP_BLE_LP_CONNECTING)
   {
     /* Connection as client */
     bleAppContext.Device_Connection_Status = APP_BLE_CONNECTED_CLIENT;
   }
   else
   {
     /* Connection as server */
     bleAppContext.Device_Connection_Status = APP_BLE_CONNECTED_SERVER;
   }
   bleAppContext.BleApplicationContext_legacy.connectionHandle = Connection_Handle;
   
   GATT_CLIENT_APP_Set_Conn_Handle(0, Connection_Handle);
   
   /* USER CODE BEGIN HCI_EVT_LE_CONN_COMPLETE */

   /* USER CODE END HCI_EVT_LE_CONN_COMPLETE */

}/* end hci_le_connection_complete_event() */

/* USER CODE BEGIN EVT_VENDOR_2 */

/* USER CODE END EVT_VENDOR_2 */

[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
APP_BLE_ConnStatus_t APP_BLE_Get_Client_Connection_Status(uint16_t Connection_Handle)
{
  APP_BLE_ConnStatus_t conn_status;

  if (bleAppContext.BleApplicationContext_legacy.connectionHandle == Connection_Handle)
  {
    conn_status = bleAppContext.Device_Connection_Status;
  }
  else
  {
    conn_status = APP_BLE_IDLE;
  }

  return conn_status;
}
[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
  APP_DBG_MSG("     - Connection Interval:   %d.%02d ms\n     - Connection latency:    %d\n     - Supervision Timeout: %d ms\n",
              INT(Connection_Interval*1.25),
              FRACTIONAL_2DIGITS(Connection_Interval*1.25),
              Peripheral_Latency,
              Supervision_Timeout * 10
              );

  if (bleAppContext.Device_Connection_Status == APP_BLE_LP_CONNECTING)
  {
    /* Connection as client */
    bleAppContext.Device_Connection_Status = APP_BLE_CONNECTED_CLIENT;
  }
  else
  {
    /* Connection as server */
    bleAppContext.Device_Connection_Status = APP_BLE_CONNECTED_SERVER;
  }
  bleAppContext.BleApplicationContext_legacy.connectionHandle = Connection_Handle;

[#if myHash["NUMBER_OF_SERVICES"] != "0"]
  [#list 1..myHash["NUMBER_OF_SERVICES"]?number as service]
  ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification.EvtOpcode = ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_CONN_HANDLE_EVT;
  ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification.ConnectionHandle = Connection_Handle;
  ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_APP_EvtRx(&${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification);
  [/#list]
[/#if]
[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled")]
  if (bleAppContext.Device_Connection_Status == APP_BLE_LP_CONNECTING)
  {
   /* Connection as client */
   bleAppContext.Device_Connection_Status = APP_BLE_CONNECTED_CLIENT;
  }
  else
  {
   /* Connection as server */
   bleAppContext.Device_Connection_Status = APP_BLE_CONNECTED_SERVER;
  }
  bleAppContext.BleApplicationContext_legacy.connectionHandle = Connection_Handle;
[#if myHash["NUMBER_OF_SERVICES"] != "0"]
  [#list 1..myHash["NUMBER_OF_SERVICES"]?number as service]
  if (Role == HCI_ROLE_PERIPHERAL)
  {
    ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification.EvtOpcode = ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_PERIPH_CONN_HANDLE_EVT;
  }
  else
  {
    ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification.EvtOpcode = ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_CENTR_CONN_HANDLE_EVT;
  }
  
  ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification.ConnectionHandle = Connection_Handle;
  ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_APP_EvtRx(&${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification);
  [/#list]
[/#if]
[/#if]

[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
  /* USER CODE BEGIN HCI_EVT_LE_CONN_COMPLETE */

  /* USER CODE END HCI_EVT_LE_CONN_COMPLETE */
}/* end hci_le_connection_complete_event() */


/* USER CODE BEGIN EVT_VENDOR_3 */

/* USER CODE END EVT_VENDOR_3 */

APP_BLE_ConnStatus_t APP_BLE_Get_Server_Connection_Status(void)
{
  return bleAppContext.Device_Connection_Status;
}
[/#if]
[/#if]

[#if (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled")]
APP_BLE_ConnStatus_t APP_BLE_Get_Client_Connection_Status(uint16_t Connection_Handle)
{
  APP_BLE_ConnStatus_t conn_status;

  if (bleAppContext.BleApplicationContext_legacy.connectionHandle == Connection_Handle)
  {
    conn_status = bleAppContext.Device_Connection_Status;
  }
  else
  {
    conn_status = APP_BLE_IDLE;
  }

  return conn_status;
}

[/#if]
[#if  (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled") && (myHash["BLE_MODE_BROADCASTER"] != "Enabled")]
void APP_BLE_Procedure_Gap_General(ProcGapGeneralId_t ProcGapGeneralId)
{
  tBleStatus status;

  switch(ProcGapGeneralId)
  {
#if (CFG_BLE_CONTROLLER_2M_CODED_PHY_ENABLED == 1)
    case PROC_GAP_GEN_PHY_TOGGLE:
    {
      uint8_t phy_tx, phy_rx;

      status = hci_le_read_phy(bleAppContext.BleApplicationContext_legacy.connectionHandle, &phy_tx, &phy_rx);
      if (status != BLE_STATUS_SUCCESS)
      {
        APP_DBG_MSG("hci_le_read_phy failure: reason=0x%02X\n",status);
      }
      else
      {
        APP_DBG_MSG("==>> hci_le_read_phy - Success\n");
        APP_DBG_MSG("==>> PHY Param  TX= %d, RX= %d\n", phy_tx, phy_rx);
        if ((phy_tx == HCI_TX_PHY_LE_2M) && (phy_rx == HCI_RX_PHY_LE_2M))
        {
          APP_DBG_MSG("==>> hci_le_set_phy PHY Param  TX= %d, RX= %d - ", HCI_TX_PHY_LE_1M, HCI_RX_PHY_LE_1M);
          status = hci_le_set_phy(bleAppContext.BleApplicationContext_legacy.connectionHandle, 0, HCI_TX_PHYS_LE_1M_PREF, HCI_RX_PHYS_LE_1M_PREF, 0);
          if (status != BLE_STATUS_SUCCESS)
          {
            APP_DBG_MSG("Fail\n");
          }
          else
          {
            APP_DBG_MSG("Success\n");
            gap_cmd_resp_wait();/* waiting for HCI_LE_PHY_UPDATE_COMPLETE_SUBEVT_CODE */
          }
        }
        else
        {
          APP_DBG_MSG("==>> hci_le_set_phy PHY Param  TX= %d, RX= %d - ", HCI_TX_PHYS_LE_2M_PREF, HCI_RX_PHYS_LE_2M_PREF);
          status = hci_le_set_phy(bleAppContext.BleApplicationContext_legacy.connectionHandle, 0, HCI_TX_PHYS_LE_2M_PREF, HCI_RX_PHYS_LE_2M_PREF, 0);
          if (status != BLE_STATUS_SUCCESS)
          {
            APP_DBG_MSG("Fail\n");
          }
          else
          {
            APP_DBG_MSG("Success\n");
            gap_cmd_resp_wait();/* waiting for HCI_LE_PHY_UPDATE_COMPLETE_SUBEVT_CODE */
          }
        }
      }
      break;
    }/* PROC_GAP_GEN_PHY_TOGGLE */
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
#endif /* (CFG_BLE_CONTROLLER_2M_CODED_PHY_ENABLED == 1) */
[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
#endif
[/#if]
    case PROC_GAP_GEN_CONN_TERMINATE:
    {
      status = aci_gap_terminate(bleAppContext.BleApplicationContext_legacy.connectionHandle, BLE_ERROR_TERMINATED_REMOTE_USER);
      if (status != BLE_STATUS_SUCCESS)
      {
         APP_DBG_MSG("aci_gap_terminate failure: reason=0x%02X\n", status);
      }
      else
      {
        APP_DBG_MSG("==>> aci_gap_terminate : Success\n");
        gap_cmd_resp_wait();/* waiting for HCI_DISCONNECTION_COMPLETE_EVT_CODE */
      }
      break;
    }/* PROC_GAP_GEN_CONN_TERMINATE */
    case PROC_GATT_EXCHANGE_CONFIG:
    {
      status =aci_gatt_clt_exchange_config(bleAppContext.BleApplicationContext_legacy.connectionHandle);
      if (status != BLE_STATUS_SUCCESS)
      {
        APP_DBG_MSG("aci_gatt_clt_exchange_config failure: reason=0x%02X\n", status);
      }
      else
      {
        APP_DBG_MSG("==>> aci_gatt_clt_exchange_config : Success\n");
      }
      break;
    }
    /* USER CODE BEGIN GAP_GENERAL */

    /* USER CODE END GAP_GENERAL */
    default:
      break;
  }
  return;
}

[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
void APP_BLE_Procedure_Gap_Peripheral(ProcGapPeripheralId_t ProcGapPeripheralId)
{
  tBleStatus status;
  uint32_t paramA = ADV_INTERVAL_MIN;
  uint32_t paramB = ADV_INTERVAL_MAX;
  uint32_t paramC, paramD;

  /* First set parameters before calling ACI APIs, only if needed */
  switch(ProcGapPeripheralId)
  {
    case PROC_GAP_PERIPH_ADVERTISE_START_FAST:
    {
      paramA = ADV_INTERVAL_MIN;
      paramB = ADV_INTERVAL_MAX;
      paramC = APP_BLE_ADV_FAST;

      /* USER CODE BEGIN PROC_GAP_PERIPH_ADVERTISE_START_FAST */

      /* USER CODE END PROC_GAP_PERIPH_ADVERTISE_START_FAST */
      break;
    }/* PROC_GAP_PERIPH_ADVERTISE_START_FAST */
    case PROC_GAP_PERIPH_ADVERTISE_START_LP:
    {
      paramA = ADV_LP_INTERVAL_MIN;
      paramB = ADV_LP_INTERVAL_MAX;
      paramC = APP_BLE_ADV_LP;

      /* USER CODE BEGIN PROC_GAP_PERIPH_ADVERTISE_START_LP */

      /* USER CODE END PROC_GAP_PERIPH_ADVERTISE_START_LP */
      break;
    }/* PROC_GAP_PERIPH_ADVERTISE_START_LP */
    case PROC_GAP_PERIPH_ADVERTISE_STOP:
    {
      paramC = APP_BLE_IDLE;

      /* USER CODE BEGIN PROC_GAP_PERIPH_ADVERTISE_STOP */

      /* USER CODE END PROC_GAP_PERIPH_ADVERTISE_STOP */
      break;
    }/* PROC_GAP_PERIPH_ADVERTISE_STOP */
    case PROC_GAP_PERIPH_CONN_PARAM_UPDATE:
    {
      paramA = CONN_INT_MS(1000);
      paramB = CONN_INT_MS(1000);
      paramC = 0x0000;
      paramD = 0x01F4;

      /* USER CODE BEGIN CONN_PARAM_UPDATE */

      /* USER CODE END CONN_PARAM_UPDATE */
      break;
    }/* PROC_GAP_PERIPH_CONN_PARAM_UPDATE */
    case PROC_GAP_PERIPH_CONN_TERMINATE:
    {
      status = aci_gap_terminate(bleAppContext.BleApplicationContext_legacy.connectionHandle, 0x13);
      if (status != BLE_STATUS_SUCCESS)
      {
         APP_DBG_MSG("aci_gap_terminate failure: reason=0x%02X\n", status);
      }
      else
      {
        APP_DBG_MSG("==>> aci_gap_terminate : Success\n");
        gap_cmd_resp_wait();/* waiting for HCI_DISCONNECTION_COMPLETE_EVT_CODE */
      }
      break;
    }
    /* PROC_GAP_PERIPH_CONN_TERMINATE */
    default:
      break;
  }
[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
void APP_BLE_Procedure_Gap_Central(ProcGapCentralId_t ProcGapCentralId)
{
  tBleStatus status;
  uint32_t paramA, paramB, paramC, paramD;

  UNUSED(paramA);
  UNUSED(paramB);
  UNUSED(paramC);
  UNUSED(paramD);

  /* First set parameters before calling ACI APIs, only if needed */
  switch(ProcGapCentralId)
  {
    case PROC_GAP_CENTRAL_SCAN_START:
    {
      paramA = SCAN_INT_MS(${myHash["CFG_SCAN_INT_MS"]});
      paramB = SCAN_WIN_MS(${myHash["CFG_SCAN_WIN_MS"]});
      paramC = APP_BLE_SCANNING;

      /* USER CODE BEGIN PROC_GAP_CENTRAL_SCAN_START */

      /* USER CODE END PROC_GAP_CENTRAL_SCAN_START */
      break;
    }/* PROC_GAP_CENTRAL_SCAN_START */
    case PROC_GAP_CENTRAL_SCAN_TERMINATE:
    {
      paramA = 1;
      paramB = 1;
      paramC = APP_BLE_IDLE;

      /* USER CODE BEGIN PROC_GAP_CENTRAL_SCAN_TERMINATE */

      /* USER CODE END PROC_GAP_CENTRAL_SCAN_TERMINATE */
      break;
    }/* PROC_GAP_CENTRAL_SCAN_TERMINATE */
    default:
      break;
  }
[/#if]

  /* Call ACI APIs */
[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
  switch(ProcGapPeripheralId)
  {
    case PROC_GAP_PERIPH_ADVERTISE_START_FAST:
    case PROC_GAP_PERIPH_ADVERTISE_START_LP:
    {

      /* USER CODE BEGIN PROC_GAP_PERIPHERAL_ID */

      /* USER CODE END PROC_GAP_PERIPHERAL_ID */

      Advertising_Set_Parameters_t Advertising_Set_Parameters = {0};

      /* Start Fast or Low Power Advertising */

      /* Set advertising configuration for legacy advertising */
      status = aci_gap_set_advertising_configuration(0,
                                                     GAP_MODE_GENERAL_DISCOVERABLE,
                                                     ADV_TYPE,
                                                     paramA,
                                                     paramB,
                                                     HCI_ADV_CH_ALL,
                                                     0,
                                                     NULL, /* No peer address */
                                                     HCI_ADV_FILTER_NONE,
                                                     0, /* 0 dBm */
                                                     HCI_PHY_LE_1M, /* Primary advertising PHY */
                                                     0, /* 0 skips */
                                                     HCI_PHY_LE_1M, /* Secondary advertising PHY. Not used with legacy advertising. */
                                                     0, /* SID */
                                                     0 /* No scan request notifications */);
      if (status != BLE_STATUS_SUCCESS)
      {
        APP_DBG_MSG("==>> aci_gap_set_advertising_configuration - fail, result: 0x%02X\n", status);
      }
      else
      {
        bleAppContext.Device_Connection_Status = (APP_BLE_ConnStatus_t)paramC;
        APP_DBG_MSG("==>> Success: aci_gap_set_advertising_configuration\n");
      }

      status = aci_gap_set_advertising_data(0, ADV_COMPLETE_DATA, sizeof(a_AdvData), (uint8_t*) a_AdvData);
      if (status != BLE_STATUS_SUCCESS)
      {
        APP_DBG_MSG("==>> aci_gap_set_advertising_data Failed, result: 0x%02X\n", status);
      }
      else
      {
        APP_DBG_MSG("==>> Success: aci_gap_set_advertising_data\n");
      }

      /* Enable advertising */
      status = aci_gap_set_advertising_enable(ENABLE, 1, &Advertising_Set_Parameters);
      if (status != BLE_STATUS_SUCCESS)
      {
        APP_DBG_MSG("==>> aci_gap_set_advertising_enable Failed, result: 0x%02X\n", status);
      }
      else
      {
        APP_DBG_MSG("==>> Success: aci_gap_set_advertising_enable\n");
      }
      break;
    }
    case PROC_GAP_PERIPH_ADVERTISE_STOP:
    {
      status = aci_gap_set_advertising_enable(DISABLE, 0, NULL);
      if (status != BLE_STATUS_SUCCESS)
      {
        bleAppContext.Device_Connection_Status = (APP_BLE_ConnStatus_t)paramC;
        APP_DBG_MSG("Disable advertising - fail, result: 0x%02X\n",status);
      }
      else
      {
        APP_DBG_MSG("==>> Disable advertising - Success\n");
      }
      break;
    }/* PROC_GAP_PERIPH_ADVERTISE_STOP */
    case PROC_GAP_PERIPH_ADVERTISE_DATA_UPDATE:
    {
      Advertising_Set_Parameters_t Advertising_Set_Parameters = {0};

      /* Disable advertising */ //TBR??? Do we need to disable advertising, set advertising data and then enable advertising?
      status = aci_gap_set_advertising_enable(DISABLE, 0, NULL);
      if (status != BLE_STATUS_SUCCESS)
      {
        bleAppContext.Device_Connection_Status = (APP_BLE_ConnStatus_t)paramC;
        APP_DBG_MSG("Disable advertising - fail, result: 0x%02X\n",status);
      }
      else
      {
        APP_DBG_MSG("==>> Disable advertising - Success\n");
      }
      /* Set advertising data */
      status = aci_gap_set_advertising_data(0, ADV_COMPLETE_DATA, sizeof(a_AdvData), (uint8_t*) a_AdvData);
      if (status != BLE_STATUS_SUCCESS)
      {
        APP_DBG_MSG("==>> aci_gap_set_advertising_data Failed, result: 0x%02X\n", status);
      }
      else
      {
        APP_DBG_MSG("==>> Success: aci_gap_set_advertising_data\n");
      }
      /* Enable advertising */
      status = aci_gap_set_advertising_enable(ENABLE, 1, &Advertising_Set_Parameters);
      if (status != BLE_STATUS_SUCCESS)
      {
        APP_DBG_MSG("==>> aci_gap_set_advertising_enable Failed, result: 0x%02X\n", status);
      }
      else
      {
        APP_DBG_MSG("==>> Success: aci_gap_set_advertising_enable\n");
      }
      break;
    }/* PROC_GAP_PERIPH_ADVERTISE_DATA_UPDATE */
    case PROC_GAP_PERIPH_CONN_PARAM_UPDATE:
    {
       status = aci_l2cap_connection_parameter_update_req(
                                                       bleAppContext.BleApplicationContext_legacy.connectionHandle,
                                                       paramA,
                                                       paramB,
                                                       paramC,
                                                       paramD);
      if (status != BLE_STATUS_SUCCESS)
      {
        APP_DBG_MSG("aci_l2cap_connection_parameter_update_req - fail, result: 0x%02X\n",status);
      }
      else
      {
        APP_DBG_MSG("==>> aci_l2cap_connection_parameter_update_req - Success\n");
      }

      break;
    }/* PROC_GAP_PERIPH_CONN_PARAM_UPDATE */

    case PROC_GAP_PERIPH_SET_BROADCAST_MODE:
    {

      break;
    }/* PROC_GAP_PERIPH_SET_BROADCAST_MODE */
    default:
      break;
  }
  return;
}
[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled")]

void APP_BLE_Procedure_Gap_Central(ProcGapCentralId_t ProcGapCentralId)
{
  tBleStatus status;
  uint32_t paramA, paramB, paramC, paramD;

  UNUSED(paramA);
  UNUSED(paramB);
  UNUSED(paramC);
  UNUSED(paramD);

  /* First set parameters before calling ACI APIs, only if needed */
  switch(ProcGapCentralId)
  {
    case PROC_GAP_CENTRAL_SCAN_START:
    {
      paramA = SCAN_INT_MS(${myHash["CFG_SCAN_INT_MS"]});
      paramB = SCAN_WIN_MS(${myHash["CFG_SCAN_WIN_MS"]});
      paramC = APP_BLE_SCANNING;

      break;
    }/* PROC_GAP_CENTRAL_SCAN_START */
    case PROC_GAP_CENTRAL_SCAN_TERMINATE:
    {
      paramA = 1;
      paramB = 1;
      paramC = APP_BLE_IDLE;

      break;
    }/* PROC_GAP_CENTRAL_SCAN_TERMINATE */
    default:
      break;
  }

  /* Call ACI APIs */
[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
  switch(ProcGapCentralId)
  {
    case PROC_GAP_CENTRAL_SCAN_START:
    {
      status = aci_gap_set_scan_configuration(DUPLICATE_FILTER_ENABLED, 0x00, LE_1M_PHY_BIT, HCI_SCAN_TYPE_ACTIVE, paramA, paramB);
      if (status != BLE_STATUS_SUCCESS)
      {
        APP_DBG_MSG("aci_gap_set_scan_configuration - fail, result: 0x%02X\n", status);
      }
      else
      {
        APP_DBG_MSG("==>> aci_gap_set_scan_configuration - Success\n");
      }
      
      status = aci_gap_start_procedure (GAP_GENERAL_DISCOVERY_PROC,LE_1M_PHY_BIT,0,0);
      if (status != BLE_STATUS_SUCCESS)
      {
        APP_DBG_MSG("aci_gap_start_procedure - fail, result: 0x%02X\n", status);
      }
      else
      {
        bleAppContext.Device_Connection_Status = (APP_BLE_ConnStatus_t)paramC;
        APP_DBG_MSG("==>> aci_gap_start_procedure - Success\n");
      }  
      break;
    }/* PROC_GAP_CENTRAL_SCAN_START */
    case PROC_GAP_CENTRAL_SCAN_TERMINATE:
    {
      status = aci_gap_terminate_proc(GAP_GENERAL_DISCOVERY_PROC);
      if (status != BLE_STATUS_SUCCESS)
      {
        APP_DBG_MSG("aci_gap_terminate_gap_proc - fail, result: 0x%02X\n",status);
      }
      else
      {
        bleAppContext.Device_Connection_Status = (APP_BLE_ConnStatus_t)paramC;
        APP_DBG_MSG("==>> aci_gap_terminate_gap_proc - Success\n");
      }
      break;
    }/* PROC_GAP_CENTRAL_SCAN_TERMINATE */

    default:
      break;
  }
  return;
}
[/#if]
[#if  (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
    /* Used by aci_gatt_nwk and adv_buff_alloc libraries.  */
  dm_init(CFG_BLE_GATT_ADV_NWK_BUFFER_SIZE, aci_gatt_adv_nwk_buffer);

  aci_adv_nwk_init();

#if (BLESTACK_CONTROLLER_ONLY == 0)  
  ACI_gatt_nwk_init(CFG_BLE_ATT_QUEUED_WRITE_SIZE);
#endif

  transport_layer_init();

  /* Get crash info */
  GetCrashInfo(&crash_info); 

  if(RAM_VR.Reserved[0] == 0x01){
    // Send a command complete event for HCI_Reset
    uint8_t buffer_out[] = {0x04,0x0E,0x04,0x01,0x03,0x0C,0x00};
    RAM_VR.Reserved[0] = 0x00;
    send_event(buffer_out,7,-1);
  }

#if (BLESTACK_CONTROLLER_ONLY == 0)

  uint8_t reset_reason = 0x01;

  /* EVT_BLUE_INITIALIZED */  
  /* Check the reset reason */
  if(RAM_VR.ResetReason & RCC_CSR_WDGRSTF){
    reset_reason = RESET_REASON_WDG;
  }
  else if(RAM_VR.ResetReason & RCC_CSR_LOCKUPRSTF) {
    reset_reason = RESET_REASON_LOCKUP;
  }
  else if(RAM_VR.ResetReason & RCC_CSR_PORRSTF) {
    reset_reason = RESET_REASON_POR_BOR;
  }

  if((crash_info.signature&0xFFFF0000) == CRASH_SIGNATURE_BASE) {  
    reset_reason = RESET_REASON_CRASH;
  }

  aci_blue_initialized_event(reset_reason);

#endif

  if((crash_info.signature&0xFFFF0000) == CRASH_SIGNATURE_BASE) { 
    aci_blue_crash_info_event(crash_info.signature&0xFF,
                              crash_info.SP,
                              crash_info.R0,
                              crash_info.R1,
                              crash_info.R2,
                              crash_info.R3,
                              crash_info.R12,
                              crash_info.LR,
                              crash_info.PC,
                              crash_info.xPSR,
                              0,
                              NULL);
  }
  
  /* USER CODE BEGIN APP_BLE_Init_2 */

  /* USER CODE END APP_BLE_Init_2 */

  return;
}

/* Implementation of event hooks. */

int aci_l2cap_cos_disconnection_complete_event_preprocess(uint16_t Connection_Handle,
                                                      uint16_t CID)
{
  ACI_gatt_nwk_disconnection(Connection_Handle, CID);

  return 0;  
}

int aci_gatt_srv_attribute_modified_event_preprocess(uint16_t Connection_Handle,
                                                     uint16_t CID,
                                                     uint16_t Attr_Handle,
                                                     uint16_t Attr_Data_Length,
                                                     uint8_t Attr_Data[])
{
  return BURST_WriteReceived(Connection_Handle, Attr_Handle, Attr_Data_Length, Attr_Data);
}

int aci_gatt_clt_notification_event_preprocess(uint16_t Connection_Handle,
                                               uint16_t CID,
                                               uint16_t Attribute_Handle,
                                               uint16_t Attribute_Value_Length,
                                               uint8_t Attribute_Value[])
{
  return BURST_NotificationReceived(Connection_Handle, Attribute_Handle, Attribute_Value_Length, Attribute_Value);
}

int aci_gatt_tx_pool_available_event_preprocess(uint16_t Connection_Handle,
                                                uint16_t Available_Buffers)
{
  if(BURST_BufferAvailableNotify())
  {
    /* BURST is currently enabled. */
    BURST_Process_Schedule();

    return 1;
  }
  
  return 0;
}

void BURST_StartCallback(void)
{
  BURST_Process_Schedule();
}

void TL_ProcessReqCallback(void)
{
  TM_Process_Schedule();
}

void TL_ResetReqCallback(void)
{
  RAM_VR.Reserved[0] = 0x01; // Remember to send a command complete after reset is completed.
  NVIC_SystemReset();
}
[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]

/* USER CODE BEGIN FD*/

/* USER CODE END FD*/
[/#if]

[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
static void gap_cmd_resp_release(void)
{
  UTIL_SEQ_SetEvt(1 << CFG_IDLEEVT_PROC_GAP_COMPLETE);
  return;
}

static void gap_cmd_resp_wait(void)
{
  UTIL_SEQ_WaitEvt(1 << CFG_IDLEEVT_PROC_GAP_COMPLETE);
  return;
}

/* USER CODE BEGIN FD_LOCAL_FUNCTION */

/* USER CODE END FD_LOCAL_FUNCTION */

/* USER CODE BEGIN FD_WRAP_FUNCTIONS */

/* USER CODE END FD_WRAP_FUNCTIONS */

[/#if]
/** \endcond
 */
