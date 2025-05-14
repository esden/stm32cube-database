[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_ble.c
  * @author  MCD Application Team
  * @brief   BLE Application
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign PG_FILL_UCS = "False"]
[#assign PG_SKIP_LIST = "False"]
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

[#--

   This hash handles the Platform Settings BSP

--]
[#assign nbInstance = 0]
[#assign BSP_myHash = {}]
[#if BspIpDatas??]
[#list BspIpDatas as BSP_Data]
    [#if BSP_Data.variables??]
        [#list BSP_Data.variables as variables]
      [#assign BSP_myHash = {variables.name + nbInstance:variables.value} + BSP_myHash]
            [#if variables.name?contains("BoardName")]
        [#assign nbInstance=nbInstance+1]
            [/#if]
        [/#list]
    [/#if]
[/#list]
[/#if]
[#--
Key & Value:
[#list BSP_myHash?keys as key]
Key: ${key}; Value: ${BSP_myHash[key]}
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
#include "main.h"
#include "app_common.h"
#include "log_module.h"
#include "ble.h"
#include "app_ble.h"
#include "host_stack_if.h"
#include "ll_sys_if.h"
#include "stm32_rtos.h"
#include "otp.h"
#include "stm32_timer.h"
#include "stm_list.h"
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
#include "advanced_memory_manager.h"
[/#if]
#include "blestack.h"
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
#include "nvm.h"
#include "simple_nvm_arbiter.h"
[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
#include "lhci.h"
[/#if]
[#if  (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
  [#if myHash["NUMBER_OF_SERVICES"] != "0"]
    [#list 1..myHash["NUMBER_OF_SERVICES"]?number as service]
#include "${SERVICES_NAMES[service?string][item_SHORT_NAME]?lower_case}.h"
#include "${SERVICES_NAMES[service?string][item_SHORT_NAME]?lower_case}_app.h"
    [/#list]
  [/#if]
  [#if (PG_SKIP_LIST == "True") && (myHash["NUMBER_OF_SERVICES"] == "2")]
#include "${SERVICES_NAMES[service2?string][item_SHORT_NAME]?lower_case}.h"
#include "${SERVICES_NAMES[service2?string][item_SHORT_NAME]?lower_case}_app.h"
  [/#if]
[/#if]
[#if  (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
#include "gatt_client_app.h"
[/#if]
/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
[#if PG_FILL_UCS == "True"]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
#include "stm32_lpm.h"
[/#if]
[#if (RF_APPLICATION == "BEACON")]
#include "eddystone_beacon.h"
#include "eddystone_uid_service.h"
#include "eddystone_url_service.h"
#include "eddystone_tlm_service.h"
#include "ibeacon_service.h"
#include "ibeacon.h"
[/#if]
[/#if]

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */
[#if PG_FILL_UCS == "True"]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
typedef enum
{
  LOW_POWER_MODE_DISABLE,
  LOW_POWER_MODE_ENABLE,
}LowPowerModeStatus_t;
[/#if]
[/#if]

/* USER CODE END PTD */

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
/* Maximum size of data buffer (Rx or Tx) */
#define HCI_DATA_MAX_SIZE         313
#define NUM_OF_TX_SYNCHRO          2
#define NUM_OF_TX_ASYNCHRO        50
#define NUM_OF_RX_BUFFER          12
#define NUM_OF_TX_BUFFER           (NUM_OF_TX_ASYNCHRO + NUM_OF_TX_SYNCHRO)    

typedef struct
{
  tListNode                 node;  /* Actual node in the list */
  uint8_t buf[HCI_DATA_MAX_SIZE];  /* Memory buffer */
} UART_node;

/* Global variables structure */
typedef struct
{
  volatile uint8_t uart_tx_on;
  uint8_t  rx_state;
  uint8_t  rxReceivedState;
  UART_node buff_node[NUM_OF_RX_BUFFER+NUM_OF_TX_BUFFER];
} HciTransport_var_t;

extern RNG_HandleTypeDef hrng;

[/#if]
[#if ((myHash["BLE_MODE_HOST_SKELETON"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL"] == "Enabled"))]
/* Security parameters structure */
typedef struct
{
  /* IO capability of the device */
  uint8_t ioCapability;

  /**
   * Authentication requirement of the device
   * Man In the Middle protection required?
   */
  uint8_t mitm_mode;

  /* Bonding mode of the device */
  uint8_t bonding_mode;

  /**
   * this variable indicates whether to use a fixed pin
   * during the pairing process or a passkey has to be
   * requested to the application during the pairing process
   * 0 implies use fixed pin and 1 implies request for passkey
   */
  uint8_t Use_Fixed_Pin;

  /* Minimum encryption key size requirement */
  uint8_t encryptionKeySizeMin;

  /* Maximum encryption key size requirement */
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
  /* USER CODE BEGIN tSecurityParams */

  /* USER CODE END tSecurityParams */
}SecurityParams_t;

/* Global context contains all BLE common variables. */
typedef struct
{
  /* Security requirements of the host */
  SecurityParams_t bleSecurityParam;

[#if (myHash["BLE_MODE_HOST_SKELETON"] != "Enabled")]
  /* GAP service handle */
  uint16_t gapServiceHandle;

  /* Device name characteristic handle */
  uint16_t devNameCharHandle;

  /* Appearance characteristic handle */
  uint16_t appearanceCharHandle;

  /**
   * connection handle of the current active connection
   * When not in connection, the handle is set to 0xFFFF
   */
  uint16_t connectionHandle;

[/#if]
  /* USER CODE BEGIN BleGlobalContext_t */

  /* USER CODE END BleGlobalContext_t */
}BleGlobalContext_t;

typedef struct
{
  BleGlobalContext_t BleApplicationContext_legacy;
[#if (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
  APP_BLE_ConnStatus_t Device_Connection_Status;
[/#if]
  /* USER CODE BEGIN PTD_1 */

  /* USER CODE END PTD_1 */
}BleApplicationContext_t;
[/#if]

/* Private defines -----------------------------------------------------------*/
/* GATT buffer size (in bytes)*/
#define BLE_GATT_BUF_SIZE \
          BLE_TOTAL_BUFFER_SIZE_GATT(CFG_BLE_NUM_GATT_ATTRIBUTES, \
                                     CFG_BLE_NUM_GATT_SERVICES, \
                                     CFG_BLE_ATT_VALUE_ARRAY_SIZE)

#define MBLOCK_COUNT              (BLE_MBLOCKS_CALC(PREP_WRITE_LIST_SIZE, \
                                                    CFG_BLE_ATT_MTU_MAX, \
                                                    CFG_BLE_NUM_LINK) \
                                   + CFG_BLE_MBLOCK_COUNT_MARGIN)

#define BLE_DYN_ALLOC_SIZE \
        (BLE_TOTAL_BUFFER_SIZE(CFG_BLE_NUM_LINK, MBLOCK_COUNT))

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
/* Definitions for "uart_rx_state" */
#define HCI_RX_STATE_WAIT_TYPE    0
#define HCI_RX_STATE_WAIT_HEADER  1
#define HCI_RX_STATE_WAIT_PAYLOAD 2

/* Definition for "hci_event_type" */
#define HCI_EVENT_SYNCHRO         0
#define HCI_EVENT_ASYNCHRO        1      

[/#if]
/* USER CODE BEGIN PD */
[#if PG_FILL_UCS == "True"]
[#if ((RF_APPLICATION == "HEARTRATE")||(RF_APPLICATION == "P2PSERVER"))]
#define ADV_TIMEOUT_MS                 (60 * 1000)
[/#if]
[#if (RF_APPLICATION == "P2PSERVER")]
#define LED_ON_TIMEOUT_MS              (5)

[/#if]
[/#if]

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled")]
static tListNode BleAsynchEventQueue;
[/#if]

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled")]
static uint8_t a_BdAddr[BD_ADDR_SIZE];
[#if (myHash["BLE_OPTIONS_ENHANCED_ATT"] == "BLE_OPTIONS_ENHANCED_ATT")]
#define GATT_EAB_PREFIX                         0xEAU
[/#if]
/* Identity root key used to derive IRK and DHK(Legacy) */
static uint8_t a_BLE_CfgIrValue[16];

/* Encryption root key used to derive LTK(Legacy) and CSRK */
static uint8_t a_BLE_CfgErValue[16];
[/#if]
[#if (((myHash["BLE_MODE_HOST_SKELETON"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")) && (myHash["BLE_OPTIONS_LL_ONLY"] != "BLE_OPTIONS_LL_ONLY"))]
static BleApplicationContext_t bleAppContext;
[/#if]
[#if ((myHash["BLE_OPTIONS_ENHANCED_ATT"] == "BLE_OPTIONS_ENHANCED_ATT") && (myHash["BLE_MODE_PERIPHERAL"] == "Enabled"))]
BleCoCEATTContext_t BleCoCEATTContext;
[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
[#if myHash["NUMBER_OF_SERVICES"] != "0"]
  [#list 1..myHash["NUMBER_OF_SERVICES"]?number as service]
${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_APP_ConnHandleNotEvt_t ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification;
  [/#list]
[/#if]
[#if (PG_SKIP_LIST == "True") && (myHash["NUMBER_OF_SERVICES"] == "2")]
${SERVICES_NAMES[service2?string][item_SHORT_NAME]?upper_case}_APP_ConnHandleNotEvt_t ${SERVICES_NAMES[service2?string][item_SHORT_NAME]?upper_case}HandleNotification;
[/#if]
[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
GATT_CLIENT_APP_ConnHandle_Notif_evt_t clientHandleNotification;
[/#if]

[#if ((myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled") && (myHash["BLE_OPTIONS_LL_ONLY"] != "BLE_OPTIONS_LL_ONLY"))]
[#if PG_SKIP_LIST == "False"]
static char a_GapDeviceName[] = { [#rt] [#list "${CFG_GAP_DEVICE_NAME}"?split("(?!^)", "r") as char][#t][#lt]'${char}'<#sep>, [#rt]
    [/#list][#lt] }; /* Gap Device Name */
[#else]
static char a_GapDeviceName[] = {  ${CFG_GAP_DEVICE_NAME} }; /* Gap Device Name */
[/#if]
[/#if]

[#if  (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
/* Advertising Data */
uint8_t a_AdvData[${myHash["AD_DATA_LENGTH"]}] =
{
[#if  (myHash["INCLUDE_AD_TYPE_TX_POWER_LEVEL"] == "1")]
  ${myHash["AD_TYPE_TX_POWER_LEVEL_LENGTH"]}, AD_TYPE_TX_POWER_LEVEL, ${myHash["AD_TYPE_TX_POWER_LEVEL_DBM"]}, /* Transmission Power */
[/#if]
[#if  (myHash["INCLUDE_AD_TYPE_COMPLETE_LOCAL_NAME"] == "1")]
[#if PG_SKIP_LIST == "False"]
  ${myHash["AD_TYPE_COMPLETE_LOCAL_NAME_LENGTH"]}, AD_TYPE_COMPLETE_LOCAL_NAME, [#rt]
    [#list myHash["AD_TYPE_COMPLETE_LOCAL_NAME"]?split("(?!^)", "r") as char][#t]
        [#lt]'${char}', [#rt]
    [/#list][#lt] /* Complete name */
[#else]
  ${myHash["AD_TYPE_COMPLETE_LOCAL_NAME_LENGTH"]}, AD_TYPE_COMPLETE_LOCAL_NAME, ${myHash["AD_TYPE_COMPLETE_LOCAL_NAME"]?split("(?!^)", "r")}  /* Complete name */
[/#if]
[/#if]
[#if  (myHash["INCLUDE_AD_TYPE_SHORTENED_LOCAL_NAME"]  == "1")]
[#if PG_SKIP_LIST == "False"]
  ${myHash["AD_TYPE_SHORTENED_LOCAL_NAME_LENGTH"]}, AD_TYPE_SHORTENED_LOCAL_NAME , [#rt]
    [#list myHash["AD_TYPE_SHORTENED_LOCAL_NAME"]?split("(?!^)", "r") as char][#t]
        [#lt]'${char}', [#rt]
    [/#list][#lt] /* Shortened name */
[#else]
  ${myHash["AD_TYPE_SHORTENED_LOCAL_NAME_LENGTH"]}, AD_TYPE_SHORTENED_LOCAL_NAME, ${myHash["AD_TYPE_SHORTENED_LOCAL_NAME"]?split("(?!^)", "r")}   /* Shortened name */
[/#if]
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
[#if PG_SKIP_LIST == "False"]
  ${myHash["AD_TYPE_16_BIT_SERV_UUID_CMPLT_LIST_LENGTH"]}, AD_TYPE_16_BIT_SERV_UUID_CMPLT_LIST, [#rt]
[#assign size = myHash["AD_SERVICE_CLASS_UUID_NBR"]?number-1]
[#list 0..size as i]
[#assign j = size-i]
0x${AD_SERVICE_CLASS_UUID_TABLE[j]?replace(", ",", 0x")?replace("[","")?replace("]","")}, [#rt]
[/#list]

[#else]
  ${myHash["AD_TYPE_16_BIT_SERV_UUID_CMPLT_LIST_LENGTH"]}, AD_TYPE_16_BIT_SERV_UUID_CMPLT_LIST, 0x${AD_SERVICE_CLASS_UUID_TABLE[j]?replace(", ",", 0x")?replace("[","")?replace("]","")}
[/#if]
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
[#if PG_SKIP_LIST == "False"]
  ${myHash["AD_TYPE_URI_LENGTH"]}, AD_TYPE_URI, 0x${myHash["AD_TYPE_URI_CODE_POINT"]?replace(",",", 0x")}, '/', '/', [#rt]
    [#list myHash["AD_TYPE_URI_DATA"]?split("(?!^)", "r") as char][#t]
        [#lt]'${char}', [#rt]
    [/#list][#lt]

[#else]
  ${myHash["AD_TYPE_URI_LENGTH"]}, AD_TYPE_URI, 0x${myHash["AD_TYPE_URI_CODE_POINT"]?replace(",",", 0x")}, '/', '/', myHash["AD_TYPE_URI_DATA"]?split("(?!^)", "r")
[/#if]
[/#if]
[#if  (myHash["INCLUDE_AD_TYPE_MANUFACTURER_SPECIFIC_DATA"] == "1")]
[#if PG_SKIP_LIST == "False"]
  ${myHash["AD_TYPE_MANUFACTURER_SPECIFIC_DATA_LENGTH"]}, AD_TYPE_MANUFACTURER_SPECIFIC_DATA, 0x${myHash["AD_TYPE_MANUFACTURER_SPECIFIC_DATA_COMPANY_IDENTIFIER"]?replace(",",", 0x")}, [#rt]
[#assign size = (myHash["AD_TYPE_MANUFACTURER_DATA_NBR"]?number-1)]
[#list 0..size as i]
0x${AD_TYPE_MANUFACTURER_DATA_TABLE[2*i]?replace(" ",", 0x")} /* ${AD_TYPE_MANUFACTURER_DATA_TABLE[2*i+1]} */, [#rt]
[/#list]

[#else]
  ${myHash["AD_TYPE_MANUFACTURER_SPECIFIC_DATA_LENGTH"]}, AD_TYPE_MANUFACTURER_SPECIFIC_DATA, 0x${myHash["AD_TYPE_MANUFACTURER_SPECIFIC_DATA_COMPANY_IDENTIFIER"]?replace(",",", 0x")},
[/#if]
[/#if]
};
[/#if]
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
uint64_t buffer_nvm[CFG_BLEPLAT_NVM_MAX_SIZE] = {0};

[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled") && (myHash["CFG_MM_TYPE"]?number == 2)]
static AMM_VirtualMemoryCallbackFunction_t APP_BLE_ResumeFlowProcessCb;

[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
tListNode UART_RX_Pool;
tListNode UART_RX_List;
tListNode UART_TX_Pool;
tListNode UART_TX_List;

UART_node *ongoing_TX_node;
HciTransport_var_t HCI_var;

static uint8_t *readBusBuffer;
static uint8_t *writeBusBuffer;

[/#if]
/* Host stack init variables */
static uint32_t buffer[DIVC(BLE_DYN_ALLOC_SIZE, 4)];
static uint32_t gatt_buffer[DIVC(BLE_GATT_BUF_SIZE, 4)];
static BleStack_init_t pInitParams;

[#if myHash["FREERTOS_STATUS"]?number == 1 ]
static osThreadId_t     BleHostTaskHandle;

const osThreadAttr_t BleHostTask_attributes = {
  .name         = "BLE Host Task",
  .priority     = TASK_PRIO_BLE_HOST,
  .stack_size   = TASK_STACK_SIZE_BLE_HOST,
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM
};

osThreadId_t            HciAsyncEvtTaskHandle;
osSemaphoreId_t         HciAsyncEvtSemaphore;

const osThreadAttr_t HciAsyncEvtTask_attributes = {
  .name         = "HCI async Event Task",
  .priority     = TASK_PRIO_HCI_ASYNC_EVENT,
  .stack_size   = TASK_STACK_SIZE_HCI_ASYNC_EVENT,
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM
};

const osSemaphoreAttr_t HciAsyncEvtSemaphore_attributes = {
  .name         = "HCI async Event Semaphore",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE
};

[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
static TX_THREAD        BleHostTaskHandle;

static TX_THREAD        HciAsyncEvtTaskHandle;
static TX_SEMAPHORE     HciAsyncEvtSemaphore;

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
static TX_THREAD        TxToHostTaskHandle;
static TX_SEMAPHORE     TxToHostSemaphore;

[/#if]
[/#if]

/* USER CODE BEGIN PV */
[#if PG_FILL_UCS == "True"]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
static LowPowerModeStatus_t LowPowerModeStatus;
[/#if]
[/#if]

/* USER CODE END PV */

/* Global variables ----------------------------------------------------------*/
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
osSemaphoreId_t       BleHostSemaphore;
osSemaphoreId_t       GapProcCompleteSemaphore;

const osSemaphoreAttr_t BleHostSemaphore_attributes = {
  .name         = "BLE Host Semaphore",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE
};

const osSemaphoreAttr_t GapProcCompleteSemaphore_attributes = {
  .name         = "GAP procedure complete Semaphore",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE
};

[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
TX_SEMAPHORE          BleHostSemaphore;
TX_SEMAPHORE          GapProcCompleteSemaphore;

[/#if]

[#if ((myHash["BLE_OPTIONS_ENHANCED_ATT"] == "BLE_OPTIONS_ENHANCED_ATT") && (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
BleCoC_EATTContext_t BleCoC_EATTContextCentral;
COC_EATT_APP_ConnHandle_Not_evt_t HandleNotification;

[/#if]
/* USER CODE BEGIN GV */

/* USER CODE END GV */

/* Private function prototypes -----------------------------------------------*/
static void BleStack_Process_BG(void);
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled")]
static void Ble_UserEvtRx(void);
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
static void BLE_ResumeFlowProcessCallback(void);
[/#if]
[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled")]
static void Ble_Hci_Gap_Gatt_Init(void);
[#if (myHash["CFG_BD_ADDRESS_DEVICE"] == "GAP_PUBLIC_ADDR")]
static const uint8_t* BleGenerateBdAddress(void);
[/#if]
static const uint8_t* BleGenerateIRValue(void);
static const uint8_t* BleGenerateERValue(void);
[#if (((myHash["BLE_MODE_PERIPHERAL"] == "Enabled")  && (myHash["NUMBER_OF_SERVICES"] != "0"))||(myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
static void gap_cmd_resp_wait(void);
static void gap_cmd_resp_release(void);
[/#if]
[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
static void TM_Init(void);
static void TM_SysLocalCmd(uint8_t *data);
static void TM_TxToHost(void);
static void TM_EventNotify(void);
static void TM_UART_TxComplete(uint8_t *buffer);
static void TM_UART_RxComplete(uint8_t *buffer);

static void BLEUART_Write(UART_HandleTypeDef *huart, uint8_t *buffer, uint16_t size);
static void BLEUART_Read(UART_HandleTypeDef *huart, uint8_t *buffer, uint16_t size);

static int HCI_UartSend(uint8_t *data, uint8_t hci_event_type);
static uint16_t HCI_GetDataToSend(uint8_t **dataToSend);
static uint8_t* HCI_GetFreeTxBuffer(uint8_t hci_event_type);
static uint8_t* HCI_GetDataReceived(void);
static uint8_t* HCI_GetFreeRxBuffer(void);
[/#if]
[#if ((myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled") && (myHash["USE_SNVMA_NVM"]?number != 0) )]
static void BLE_NvmCallback (SNVMA_Callback_Status_t);
[/#if]
static uint8_t HOST_BLE_Init(void);
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
static void BLE_HOST_Task_Entry(void* argument);
static void HciAsyncEvt_Task_Entry(void* argument);
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
static void BLE_HOST_Task_Entry(ULONG lArgument);
static void HciAsyncEvt_Task_Entry(ULONG lArgument);
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
static void TM_TxToHost_Entry(ULONG lArgument);
[/#if]
[/#if]
/* USER CODE BEGIN PFP */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "HEARTRATE")]
void fill_advData(uint8_t *p_adv_data, uint8_t tab_size, const uint8_t*p_bd_addr);
[/#if]
[#if (RF_APPLICATION == "P2PSERVER")]
static void Adv_Cancel_Req(void *arg);
static void Adv_Cancel(void);
static void Switch_OFF_GPIO(void *arg);
static void fill_advData(uint8_t *p_adv_data, uint8_t tab_size, const uint8_t*p_bd_addr);
[/#if]
[/#if]
[#if PG_FILL_UCS == "True"]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
static void TM_SetLowPowerMode( void );
[/#if]
[/#if]

/* USER CODE END PFP */

/* External variables --------------------------------------------------------*/
[#if BspIpDatas??]
[#list 0..(nbInstance-1) as i]
[#if BSP_myHash["bspName"+i] == "Serial Link for CubeMonitor RF"]
extern UART_HandleTypeDef h${BSP_myHash["IpInstance"+i]?lower_case?replace("s","")};
[/#if]
[/#list]
[/#if]

/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Functions Definition ------------------------------------------------------*/
void APP_BLE_Init(void)
{
  /* USER CODE BEGIN APP_BLE_Init_1 */

  /* USER CODE END APP_BLE_Init_1 */

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled") ]
  LST_init_head(&BleAsynchEventQueue);
[/#if]

[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  /* Register BLE Host tasks */
[#if myHash["BLE_MODE_SKELETON"] != "Enabled" ]
  UTIL_SEQ_RegTask(1U << CFG_TASK_BLE_HOST, UTIL_SEQ_RFU, BleStack_Process_BG);
[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled") ]
  UTIL_SEQ_RegTask(1U << CFG_TASK_HCI_ASYNCH_EVT_ID, UTIL_SEQ_RFU, Ble_UserEvtRx);
[/#if]
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  /* Create BLE Host FreeRTOS objects */

  BleHostTaskHandle = osThreadNew(BLE_HOST_Task_Entry, NULL, &BleHostTask_attributes);

  BleHostSemaphore = osSemaphoreNew(1U, 0U, &BleHostSemaphore_attributes);

  if((BleHostTaskHandle == NULL) || (BleHostSemaphore == NULL) )
  {
    LOG_ERROR_APP( "BLE Host FreeRTOS objects creation FAILED");
    Error_Handler();
  }

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled") ]
  HciAsyncEvtTaskHandle = osThreadNew(HciAsyncEvt_Task_Entry, NULL, &HciAsyncEvtTask_attributes);

  HciAsyncEvtSemaphore = osSemaphoreNew(1U, 0U, &HciAsyncEvtSemaphore_attributes);

  if((HciAsyncEvtTaskHandle == NULL) || (HciAsyncEvtSemaphore == NULL) )
  {
    LOG_ERROR_APP( "HCI Async Event FreeRTOS objects creation FAILED");
    Error_Handler();
  }
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  UINT TXstatus;
  CHAR *pStack;
  
  /* Create BLE Host ThreadX objects */
  
  TXstatus = tx_byte_allocate(pBytePool, (void **)&pStack, TASK_STACK_SIZE_BLE_HOST, TX_NO_WAIT);

  if( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create(&BleHostTaskHandle, "BLE Host Task", BLE_HOST_Task_Entry, 0,
                                 pStack, TASK_STACK_SIZE_BLE_HOST,
                                 TASK_PRIO_BLE_HOST, TASK_PREEMP_BLE_HOST,
                                 TX_NO_TIME_SLICE, TX_AUTO_START);
                                 
    TXstatus |= tx_semaphore_create(&BleHostSemaphore, "BLE Host Semaphore", 0);
  }

  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "BLE Host ThreadX objects creation FAILED, status: %d", TXstatus);
    Error_Handler();
  }

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled") ]
  TXstatus = tx_byte_allocate(pBytePool, (void **)&pStack, TASK_STACK_SIZE_HCI_ASYNC_EVENT, TX_NO_WAIT);

  if( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create(&HciAsyncEvtTaskHandle, "HCI Async Event Task", HciAsyncEvt_Task_Entry, 0,
                                 pStack, TASK_STACK_SIZE_HCI_ASYNC_EVENT,
                                 TASK_PRIO_HCI_ASYNC_EVENT, TASK_PREEMP_HCI_ASYNC_EVENT,
                                 TX_NO_TIME_SLICE, TX_AUTO_START);
                                 
    TXstatus |= tx_semaphore_create(&HciAsyncEvtSemaphore, "HCI Async Event Semaphore", 0);
  }

  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "HCI Async Event ThreadX objects creation FAILED, status: %d", TXstatus);
    Error_Handler();
  }
[/#if]

  TXstatus = tx_semaphore_create(&GapProcCompleteSemaphore, "GAP Procedure Completed Semaphore", 0);
  
  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "GAP Procedure Completed ThreadX objects creation FAILED, status: %d", TXstatus);
    Error_Handler();
  }

[/#if]

[#if (myHash["USE_SNVMA_NVM"]?number != 0)]

  /* NVM emulation in RAM initialization */
  NVM_Init(buffer_nvm, 0, CFG_BLEPLAT_NVM_MAX_SIZE);

  /* First register the APP BLE buffer */
  SNVMA_Register (APP_BLE_NvmBuffer,
                  (uint32_t *)buffer_nvm,
                  (CFG_BLEPLAT_NVM_MAX_SIZE * 2));

  /* Realize a restore */
  SNVMA_Restore (APP_BLE_NvmBuffer);
[/#if]
  /* USER CODE BEGIN APP_BLE_Init_Buffers */

  /* USER CODE END APP_BLE_Init_Buffers */
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]

  /* Check consistency */
  if (NVM_Get (NVM_FIRST, 0xFF, 0, 0, 0) != NVM_EOF)
  {
    NVM_Discard (NVM_ALL);
  }
[/#if]

  /* Initialize the BLE Host */
  if (HOST_BLE_Init() == 0u)
  {
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled")]
    /* Initialization of HCI & GATT & GAP layer */
    Ble_Hci_Gap_Gatt_Init();

[#if myHash["FREERTOS_STATUS"]?number == 1 ]
    GapProcCompleteSemaphore = osSemaphoreNew(1U, 0U, &GapProcCompleteSemaphore_attributes);
    if (GapProcCompleteSemaphore == NULL)
    {
      Error_Handler();
    }

[/#if]
[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled")]
    /* Initialization of the BLE Services */
    SVCCTL_Init();

[/#if]
[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") && (myHash["NUMBER_OF_SERVICES"] != "0"))]
    /* Initialization of the BLE App Context */
    bleAppContext.Device_Connection_Status = APP_BLE_IDLE;
    bleAppContext.BleApplicationContext_legacy.connectionHandle = 0xFFFF;

    /* From here, all initialization are BLE application specific */

    /* USER CODE BEGIN APP_BLE_Init_4 */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PSERVER")]
    UTIL_SEQ_RegTask(1U << CFG_TASK_ADV_CANCEL_ID, UTIL_SEQ_RFU, Adv_Cancel);

    /* Create timer to handle the Advertising Stop */
    UTIL_TIMER_Create(&(bleAppContext.Advertising_mgr_timer_Id),
                      0,
                      UTIL_TIMER_ONESHOT,
                      &Adv_Cancel_Req,
                      NULL);
    /* Create timer to handle the Led Switch OFF */
    UTIL_TIMER_Create(&(bleAppContext.SwitchOffGPIO_timer_Id),
                      0,
                      UTIL_TIMER_ONESHOT,
                      &Switch_OFF_GPIO,
                      NULL);

[/#if]
[/#if]

    /* USER CODE END APP_BLE_Init_4 */

    /* Initialize Services and Characteristics. */
[#if myHash["NUMBER_OF_SERVICES"] != "0"]
    LOG_INFO_APP("\n");
    LOG_INFO_APP("Services and Characteristics creation\n");
    [#list 1..myHash["NUMBER_OF_SERVICES"]?number as service]
    ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_APP_Init();
    [/#list]
   [#if (PG_SKIP_LIST == "True") && (myHash["NUMBER_OF_SERVICES"] == "2")]
    ${SERVICES_NAMES[service2?string][item_SHORT_NAME]?upper_case}_APP_Init();
   [/#if]
    LOG_INFO_APP("End of Services and Characteristics creation\n");
    LOG_INFO_APP("\n");
[/#if]

    /* USER CODE BEGIN APP_BLE_Init_3 */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "HEARTRATE")||(RF_APPLICATION == "P2PSERVER")||(RF_APPLICATION == "HEALTH_THERMOMETER")]
    /* Start to Advertise to accept a connection */
    APP_BLE_Procedure_Gap_Peripheral(PROC_GAP_PERIPH_ADVERTISE_START_FAST);

    /* Start a timer to stop advertising after a while */
    UTIL_TIMER_StartWithPeriod(&bleAppContext.Advertising_mgr_timer_Id, ADV_TIMEOUT_MS);

[/#if]
[/#if]

    /* USER CODE END APP_BLE_Init_3 */

[/#if]

[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
    /**
     * Initialize GATT Client Application
     */
    GATT_CLIENT_APP_Init();
[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
    /* Initialize Transparent Mode Application */
    TM_Init();
[/#if]
  }
  /* USER CODE BEGIN APP_BLE_Init_2 */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "BEACON")]
  /**
   * Make device discoverable
   */
  if (CFG_BEACON_TYPE & CFG_EDDYSTONE_UID_BEACON_TYPE)
  {
    LOG_INFO_APP("Eddystone UID beacon advertise\n");
    EddystoneUID_Process();
  }
  else if (CFG_BEACON_TYPE & CFG_EDDYSTONE_URL_BEACON_TYPE)
  {
    LOG_INFO_APP("Eddystone URL beacon advertise\n");
    EddystoneURL_Process();
  }
  else if (CFG_BEACON_TYPE & CFG_EDDYSTONE_TLM_BEACON_TYPE)
  {
    LOG_INFO_APP("Eddystone TLM beacon advertise\n");
    EddystoneTLM_Process();
  }
  else if (CFG_BEACON_TYPE & CFG_IBEACON)
  {
    LOG_INFO_APP("Ibeacon advertise\n");
    IBeacon_Process();
  }
[/#if]
[/#if]

  /* USER CODE END APP_BLE_Init_2 */

  return;
}

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled")]
SVCCTL_UserEvtFlowStatus_t SVCCTL_App_Notification(void *p_Pckt)
{
  tBleStatus ret = BLE_STATUS_ERROR;
  hci_event_pckt    *p_event_pckt;
  evt_le_meta_event *p_meta_evt;
  evt_blecore_aci   *p_blecore_evt;
  [#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
  int8_t rssi;
  [/#if]

  p_event_pckt = (hci_event_pckt*) ((hci_uart_pckt *) p_Pckt)->data;
  UNUSED(ret);
  /* USER CODE BEGIN SVCCTL_App_Notification */

  /* USER CODE END SVCCTL_App_Notification */

  switch (p_event_pckt->evt)
  {
    case HCI_DISCONNECTION_COMPLETE_EVT_CODE:
    {
      hci_disconnection_complete_event_rp0 *p_disconnection_complete_event;
      p_disconnection_complete_event = (hci_disconnection_complete_event_rp0 *) p_event_pckt->data;
[#if (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
      if (p_disconnection_complete_event->Connection_Handle == bleAppContext.BleApplicationContext_legacy.connectionHandle)
      {
        bleAppContext.BleApplicationContext_legacy.connectionHandle = 0;
        bleAppContext.Device_Connection_Status = APP_BLE_IDLE;
        LOG_INFO_APP(">>== HCI_DISCONNECTION_COMPLETE_EVT_CODE\n");
        LOG_INFO_APP("     - Connection Handle:   0x%04X\n     - Reason:    0x%02X\n",
                    p_disconnection_complete_event->Connection_Handle,
                    p_disconnection_complete_event->Reason);

        /* USER CODE BEGIN EVT_DISCONN_COMPLETE_2 */

        /* USER CODE END EVT_DISCONN_COMPLETE_2 */
      }
[#else]
      UNUSED(p_disconnection_complete_event);
[/#if]
[#if (((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") && (myHash["NUMBER_OF_SERVICES"] != "0")) || (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
      gap_cmd_resp_release();
[/#if]

      /* USER CODE BEGIN EVT_DISCONN_COMPLETE_1 */

      /* USER CODE END EVT_DISCONN_COMPLETE_1 */
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
[#if myHash["NUMBER_OF_SERVICES"] != "0"]
  [#list 1..myHash["NUMBER_OF_SERVICES"]?number as service]
      ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification.EvtOpcode = ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_DISCON_HANDLE_EVT;
  [/#list]
  [#if (PG_SKIP_LIST == "True") && (myHash["NUMBER_OF_SERVICES"] == "2")]
      ${SERVICES_NAMES[service2?string][item_SHORT_NAME]?upper_case}HandleNotification.EvtOpcode = ${SERVICES_NAMES[service2?string][item_SHORT_NAME]?upper_case}_DISCON_HANDLE_EVT;
  [/#if]
[/#if]
[#if myHash["NUMBER_OF_SERVICES"] != "0"]
  [#list 1..myHash["NUMBER_OF_SERVICES"]?number as service]
      ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification.ConnectionHandle = p_disconnection_complete_event->Connection_Handle;
  [/#list]
  [#if (PG_SKIP_LIST == "True") && (myHash["NUMBER_OF_SERVICES"] == "2")]
      ${SERVICES_NAMES[service2?string][item_SHORT_NAME]?upper_case}HandleNotification.ConnectionHandle = p_disconnection_complete_event->Connection_Handle;
  [/#if]
[/#if]
[#if myHash["NUMBER_OF_SERVICES"] != "0"]
  [#list 1..myHash["NUMBER_OF_SERVICES"]?number as service]
      ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_APP_EvtRx(&${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification);
  [/#list]
  [#if (PG_SKIP_LIST == "True") && (myHash["NUMBER_OF_SERVICES"] == "2")]
      ${SERVICES_NAMES[service2?string][item_SHORT_NAME]?upper_case}_APP_EvtRx(&${SERVICES_NAMES[service2?string][item_SHORT_NAME]?upper_case}HandleNotification);
  [/#if]
[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
     clientHandleNotification.P2P_Evt_Opcode = P2PSC_DISCON_HANDLE_EVT;
     clientHhandleNotification.ConnectionHandle = p_disconnection_complete_event->Connection_Handle;
     P2PC_APP_Notification(&clientHhandleNotification);
[/#if]
      /* USER CODE BEGIN EVT_DISCONN_COMPLETE */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PSERVER")]
      APP_BLE_Procedure_Gap_Peripheral(PROC_GAP_PERIPH_ADVERTISE_START_FAST);
      UTIL_TIMER_StartWithPeriod(&bleAppContext.Advertising_mgr_timer_Id, ADV_TIMEOUT_MS);
[/#if]
[/#if]

      /* USER CODE END EVT_DISCONN_COMPLETE */
[/#if]
      break; /* HCI_DISCONNECTION_COMPLETE_EVT_CODE */
    }
    case HCI_HARDWARE_ERROR_EVT_CODE:
    {
       hci_hardware_error_event_rp0 *p_hardware_error_event;

       p_hardware_error_event = (hci_hardware_error_event_rp0 *)p_event_pckt->data;
       UNUSED(p_hardware_error_event);
       APP_DBG_MSG(">>== HCI_HARDWARE_ERROR_EVT_CODE\n");
       APP_DBG_MSG("Hardware Code = 0x%02X\n",p_hardware_error_event->Hardware_Code);
       /* USER CODE BEGIN HCI_EVT_LE_HARDWARE_ERROR */
 
       /* USER CODE END HCI_EVT_LE_HARDWARE_ERROR */
       break; /* HCI_HARDWARE_ERROR_EVT_CODE */
    }
    case HCI_LE_META_EVT_CODE:
    {
      p_meta_evt = (evt_le_meta_event*) p_event_pckt->data;
      /* USER CODE BEGIN EVT_LE_META_EVENT */

      /* USER CODE END EVT_LE_META_EVENT */
      switch (p_meta_evt->subevent)
      {
        case HCI_LE_CONNECTION_UPDATE_COMPLETE_SUBEVT_CODE:
        {
[#if ((myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled") ||(myHash["BLE_MODE_PERIPHERAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
          uint32_t conn_interval_us = 0;
[/#if]
          hci_le_connection_update_complete_event_rp0 *p_conn_update_complete;
          p_conn_update_complete = (hci_le_connection_update_complete_event_rp0 *) p_meta_evt->data;
[#if (myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
          conn_interval_us = p_conn_update_complete->Conn_Interval * 1250;
          LOG_INFO_APP(">>== HCI_LE_CONNECTION_UPDATE_COMPLETE_SUBEVT_CODE\n");
          LOG_INFO_APP("     - Connection Interval:   %d.%02d ms\n     - Connection latency:    %d\n     - Supervision Timeout:   %d ms\n",
                       conn_interval_us / 1000,
                       (conn_interval_us%1000) / 10,
                       p_conn_update_complete->Conn_Latency,
                       p_conn_update_complete->Supervision_Timeout*10);
          UNUSED(conn_interval_us);
[/#if]
          UNUSED(p_conn_update_complete);

          /* USER CODE BEGIN EVT_LE_CONN_UPDATE_COMPLETE */

          /* USER CODE END EVT_LE_CONN_UPDATE_COMPLETE */
          break;
        }
        case HCI_LE_PHY_UPDATE_COMPLETE_SUBEVT_CODE:
        {
          hci_le_phy_update_complete_event_rp0 *p_le_phy_update_complete;
          p_le_phy_update_complete = (hci_le_phy_update_complete_event_rp0*)p_meta_evt->data;
          UNUSED(p_le_phy_update_complete);

[#if (((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") && (myHash["NUMBER_OF_SERVICES"] != "0")) || (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
          gap_cmd_resp_release();
[/#if]

          /* USER CODE BEGIN EVT_LE_PHY_UPDATE_COMPLETE */

          /* USER CODE END EVT_LE_PHY_UPDATE_COMPLETE */
          break;
        }
        case HCI_LE_ENHANCED_CONNECTION_COMPLETE_SUBEVT_CODE:
        {
[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
          uint32_t conn_interval_us = 0;
[/#if]
          hci_le_enhanced_connection_complete_event_rp0 *p_enhanced_conn_complete;
          p_enhanced_conn_complete = (hci_le_enhanced_connection_complete_event_rp0 *) p_meta_evt->data;
[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
          conn_interval_us = p_enhanced_conn_complete->Conn_Interval * 1250;
          LOG_INFO_APP(">>== HCI_LE_ENHANCED_CONNECTION_COMPLETE_SUBEVT_CODE - Connection handle: 0x%04X\n", p_enhanced_conn_complete->Connection_Handle);
          LOG_INFO_APP("     - Connection established with @:%02x:%02x:%02x:%02x:%02x:%02x\n",
                      p_enhanced_conn_complete->Peer_Address[5],
                      p_enhanced_conn_complete->Peer_Address[4],
                      p_enhanced_conn_complete->Peer_Address[3],
                      p_enhanced_conn_complete->Peer_Address[2],
                      p_enhanced_conn_complete->Peer_Address[1],
                      p_enhanced_conn_complete->Peer_Address[0]);
          LOG_INFO_APP("     - Connection Interval:   %d.%02d ms\n     - Connection latency:    %d\n     - Supervision Timeout:   %d ms\n",
                      conn_interval_us / 1000,
                      (conn_interval_us%1000) / 10,
                      p_enhanced_conn_complete->Conn_Latency,
                      p_enhanced_conn_complete->Supervision_Timeout * 10
                     );
          UNUSED(conn_interval_us);

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
          bleAppContext.BleApplicationContext_legacy.connectionHandle = p_enhanced_conn_complete->Connection_Handle;

[#if myHash["NUMBER_OF_SERVICES"] != "0"]
  [#list 1..myHash["NUMBER_OF_SERVICES"]?number as service]
          ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification.EvtOpcode = ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_CONN_HANDLE_EVT;
  [/#list]
  [#if (PG_SKIP_LIST == "True") && (myHash["NUMBER_OF_SERVICES"] == "2")]
          ${SERVICES_NAMES[service2?string][item_SHORT_NAME]?upper_case}HandleNotification.EvtOpcode = ${SERVICES_NAMES[service2?string][item_SHORT_NAME]?upper_case}_CONN_HANDLE_EVT;
  [/#if]
[/#if]
[#if myHash["NUMBER_OF_SERVICES"] != "0"]
  [#list 1..myHash["NUMBER_OF_SERVICES"]?number as service]
          ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification.ConnectionHandle = p_enhanced_conn_complete->Connection_Handle;
  [/#list]
  [#if (PG_SKIP_LIST == "True") && (myHash["NUMBER_OF_SERVICES"] == "2")]
          ${SERVICES_NAMES[service2?string][item_SHORT_NAME]?upper_case}HandleNotification.ConnectionHandle = p_enhanced_conn_complete->Connection_Handle;
  [/#if]
[/#if]
[#if myHash["NUMBER_OF_SERVICES"] != "0"]
  [#list 1..myHash["NUMBER_OF_SERVICES"]?number as service]
          ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_APP_EvtRx(&${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification);
  [/#list]
  [#if (PG_SKIP_LIST == "True") && (myHash["NUMBER_OF_SERVICES"] == "2")]
          ${SERVICES_NAMES[service2?string][item_SHORT_NAME]?upper_case}_APP_EvtRx(&${SERVICES_NAMES[service2?string][item_SHORT_NAME]?upper_case}HandleNotification);
  [/#if]
[/#if]
[#else]
          UNUSED(p_enhanced_conn_complete);
[/#if]
          /* USER CODE BEGIN HCI_EVT_LE_ENHANCED_CONN_COMPLETE */

          /* USER CODE END HCI_EVT_LE_ENHANCED_CONN_COMPLETE */
          break; /* HCI_LE_ENHANCED_CONNECTION_COMPLETE_SUBEVT_CODE */
        }
        case HCI_LE_CONNECTION_COMPLETE_SUBEVT_CODE:
        {
[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
          uint32_t conn_interval_us = 0;
[/#if]
          hci_le_connection_complete_event_rp0 *p_conn_complete;
          p_conn_complete = (hci_le_connection_complete_event_rp0 *) p_meta_evt->data;
[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") || (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
          conn_interval_us = p_conn_complete->Conn_Interval * 1250;
          LOG_INFO_APP(">>== HCI_LE_CONNECTION_COMPLETE_SUBEVT_CODE - Connection handle: 0x%04X\n", p_conn_complete->Connection_Handle);
          LOG_INFO_APP("     - Connection established with @:%02x:%02x:%02x:%02x:%02x:%02x\n",
                      p_conn_complete->Peer_Address[5],
                      p_conn_complete->Peer_Address[4],
                      p_conn_complete->Peer_Address[3],
                      p_conn_complete->Peer_Address[2],
                      p_conn_complete->Peer_Address[1],
                      p_conn_complete->Peer_Address[0]);
          LOG_INFO_APP("     - Connection Interval:   %d.%02d ms\n     - Connection latency:    %d\n     - Supervision Timeout:   %d ms\n",
                      conn_interval_us / 1000,
                      (conn_interval_us%1000) / 10,
                      p_conn_complete->Conn_Latency,
                      p_conn_complete->Supervision_Timeout * 10
                     );
          UNUSED(conn_interval_us);

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
          bleAppContext.BleApplicationContext_legacy.connectionHandle = p_conn_complete->Connection_Handle;

[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
          GATT_CLIENT_APP_Set_Conn_Handle(0, p_conn_complete->Connection_Handle);
[/#if]

[#if myHash["NUMBER_OF_SERVICES"] != "0"]
  [#list 1..myHash["NUMBER_OF_SERVICES"]?number as service]
          ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification.EvtOpcode = ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_CONN_HANDLE_EVT;
  [/#list]
  [#if (PG_SKIP_LIST == "True") && (myHash["NUMBER_OF_SERVICES"] == "2")]
          ${SERVICES_NAMES[service2?string][item_SHORT_NAME]?upper_case}HandleNotification.EvtOpcode = ${SERVICES_NAMES[service2?string][item_SHORT_NAME]?upper_case}_CONN_HANDLE_EVT;
  [/#if]
[/#if]
[#if myHash["NUMBER_OF_SERVICES"] != "0"]
  [#list 1..myHash["NUMBER_OF_SERVICES"]?number as service]
          ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification.ConnectionHandle = p_conn_complete->Connection_Handle;
  [/#list]
  [#if (PG_SKIP_LIST == "True") && (myHash["NUMBER_OF_SERVICES"] == "2")]
          ${SERVICES_NAMES[service2?string][item_SHORT_NAME]?upper_case}HandleNotification.ConnectionHandle = p_conn_complete->Connection_Handle;
  [/#if]
[/#if]
[#if myHash["NUMBER_OF_SERVICES"] != "0"]
  [#list 1..myHash["NUMBER_OF_SERVICES"]?number as service]
          ${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}_APP_EvtRx(&${SERVICES_NAMES[service?string][item_SHORT_NAME]?upper_case}HandleNotification);
  [/#list]
  [#if (PG_SKIP_LIST == "True") && (myHash["NUMBER_OF_SERVICES"] == "2")]
          ${SERVICES_NAMES[service2?string][item_SHORT_NAME]?upper_case}_APP_EvtRx(&${SERVICES_NAMES[service2?string][item_SHORT_NAME]?upper_case}HandleNotification);
  [/#if]
[/#if]
[#else]
          UNUSED(p_conn_complete);
[/#if]
          /* USER CODE BEGIN HCI_EVT_LE_CONN_COMPLETE */

          /* USER CODE END HCI_EVT_LE_CONN_COMPLETE */
          break; /* HCI_LE_CONNECTION_COMPLETE_SUBEVT_CODE */
        }
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
        case HCI_LE_ADVERTISING_REPORT_SUBEVT_CODE:
        {
          hci_le_advertising_report_event_rp0 *p_adv_report;
          p_adv_report = (hci_le_advertising_report_event_rp0 *) p_meta_evt->data;
          UNUSED(p_adv_report);

          rssi = HCI_LE_ADVERTISING_REPORT_RSSI(p_meta_evt->data);
          UNUSED(rssi);

          /* USER CODE BEGIN HCI_EVT_LE_ADVERTISING_REPORT */

          /* USER CODE END HCI_EVT_LE_ADVERTISING_REPORT */
          break; /* HCI_LE_ADVERTISING_REPORT_SUBEVT_CODE */
        }
[/#if]
[#if  (myHash["BLE_STACK_TYPE"] == "BLE_STACK_TYPE_FULL") && (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
        case HCI_LE_EXTENDED_ADVERTISING_REPORT_SUBEVT_CODE:
        {
          hci_le_extended_advertising_report_event_rp0 *p_ext_adv_report;
          p_ext_adv_report = (hci_le_extended_advertising_report_event_rp0 *) p_meta_evt->data;
          UNUSED(p_ext_adv_report);
          /* USER CODE BEGIN HCI_LE_EXTENDED_ADVERTISING_REPORT_SUBEVT_CODE */

          /* USER CODE END HCI_LE_EXTENDED_ADVERTISING_REPORT_SUBEVT_CODE */
          break; /* HCI_LE_EXTENDED_ADVERTISING_REPORT_SUBEVT_CODE */
        }
[/#if]
        /* USER CODE BEGIN SUBEVENT */

        /* USER CODE END SUBEVENT */
        default:
        {
          /* USER CODE BEGIN SUBEVENT_DEFAULT */

          /* USER CODE END SUBEVENT_DEFAULT */
          break;
        }
      }

      /* USER CODE BEGIN META_EVT */

      /* USER CODE END META_EVT */
    }
    break; /* HCI_LE_META_EVT_CODE */

    case HCI_VENDOR_SPECIFIC_DEBUG_EVT_CODE:
    {
      p_blecore_evt = (evt_blecore_aci*) p_event_pckt->data;
      /* USER CODE BEGIN EVT_VENDOR */

      /* USER CODE END EVT_VENDOR */
      switch (p_blecore_evt->ecode)
      {
        /* USER CODE BEGIN ECODE */

        /* USER CODE END ECODE */
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
        case ACI_L2CAP_CONNECTION_UPDATE_RESP_VSEVT_CODE:
        {
          aci_l2cap_connection_update_resp_event_rp0 *p_l2cap_conn_update_resp;
          p_l2cap_conn_update_resp = (aci_l2cap_connection_update_resp_event_rp0 *) p_blecore_evt->data;
          UNUSED(p_l2cap_conn_update_resp);
          /* USER CODE BEGIN EVT_L2CAP_CONNECTION_UPDATE_RESP */

          /* USER CODE END EVT_L2CAP_CONNECTION_UPDATE_RESP */
          break;
        }
[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
        case ACI_L2CAP_CONNECTION_UPDATE_REQ_VSEVT_CODE:
        {
          aci_l2cap_connection_update_req_event_rp0 *p_l2cap_conn_update_req;
          uint8_t req_resp = 0x01;
          p_l2cap_conn_update_req = (aci_l2cap_connection_update_req_event_rp0 *) p_blecore_evt->data;
          UNUSED(p_l2cap_conn_update_req);

          /* USER CODE BEGIN EVT_L2CAP_CONNECTION_UPDATE_REQ */

          /* USER CODE END EVT_L2CAP_CONNECTION_UPDATE_REQ */

          ret = aci_l2cap_connection_parameter_update_resp(p_l2cap_conn_update_req->Connection_Handle,
                                                           p_l2cap_conn_update_req->Interval_Min,
                                                           p_l2cap_conn_update_req->Interval_Max,
                                                           p_l2cap_conn_update_req->Latency,
                                                           p_l2cap_conn_update_req->Timeout_Multiplier,
                                                           CONN_CE_LENGTH_MS(10),
                                                           CONN_CE_LENGTH_MS(10),
                                                           p_l2cap_conn_update_req->Identifier,
                                                           req_resp);
          if(ret != BLE_STATUS_SUCCESS)
          {
            LOG_INFO_APP("  Fail   : aci_l2cap_connection_parameter_update_resp command\n");
          }
          else
          {
            LOG_INFO_APP("  Success: aci_l2cap_connection_parameter_update_resp command\n");
          }

          break;
        }
[/#if]
        case ACI_GAP_PROC_COMPLETE_VSEVT_CODE:
        {
          aci_gap_proc_complete_event_rp0 *p_gap_proc_complete;
          p_gap_proc_complete = (aci_gap_proc_complete_event_rp0*) p_blecore_evt->data;
          UNUSED(p_gap_proc_complete);

          LOG_INFO_APP(">>== ACI_GAP_PROC_COMPLETE_VSEVT_CODE\n");
          /* USER CODE BEGIN EVT_GAP_PROCEDURE_COMPLETE */

          /* USER CODE END EVT_GAP_PROCEDURE_COMPLETE */
          break; /* ACI_GAP_PROC_COMPLETE_VSEVT_CODE */
        }
        case ACI_HAL_END_OF_RADIO_ACTIVITY_VSEVT_CODE:
        {
          /* USER CODE BEGIN RADIO_ACTIVITY_EVENT */

          /* USER CODE END RADIO_ACTIVITY_EVENT */
          break; /* ACI_HAL_END_OF_RADIO_ACTIVITY_VSEVT_CODE */
        }
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
        case ACI_GAP_KEYPRESS_NOTIFICATION_VSEVT_CODE:
        {
          LOG_INFO_APP(">>== ACI_GAP_KEYPRESS_NOTIFICATION_VSEVT_CODE\n");
          /* USER CODE BEGIN ACI_GAP_KEYPRESS_NOTIFICATION_VSEVT_CODE */

          /* USER CODE END ACI_GAP_KEYPRESS_NOTIFICATION_VSEVT_CODE */
          break;
        }
[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
        case ACI_GAP_PASS_KEY_REQ_VSEVT_CODE:
        {
          uint32_t pin;
          LOG_INFO_APP(">>== ACI_GAP_PASS_KEY_REQ_VSEVT_CODE\n");

          pin = CFG_FIXED_PIN;
          /* USER CODE BEGIN ACI_GAP_PASS_KEY_REQ_VSEVT_CODE_0 */

          /* USER CODE END ACI_GAP_PASS_KEY_REQ_VSEVT_CODE_0 */
          
          ret = aci_gap_pass_key_resp(bleAppContext.BleApplicationContext_legacy.connectionHandle, pin);
          if (ret != BLE_STATUS_SUCCESS)
          {
            LOG_INFO_APP("==>> aci_gap_pass_key_resp : Fail, reason: 0x%02X\n", ret);
          }
          else
          {
            LOG_INFO_APP("==>> aci_gap_pass_key_resp : Success\n");
          }
          /* USER CODE BEGIN ACI_GAP_PASS_KEY_REQ_VSEVT_CODE */

          /* USER CODE END ACI_GAP_PASS_KEY_REQ_VSEVT_CODE */
          break;
        }
[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
        case ACI_GAP_NUMERIC_COMPARISON_VALUE_VSEVT_CODE:
        {
          uint8_t confirm_value;
          LOG_INFO_APP(">>== ACI_GAP_NUMERIC_COMPARISON_VALUE_VSEVT_CODE\n");
          LOG_INFO_APP("     - numeric_value = %ld\n",
                      ((aci_gap_numeric_comparison_value_event_rp0 *)(p_blecore_evt->data))->Numeric_Value);
          LOG_INFO_APP("     - Hex_value = %lx\n",
                      ((aci_gap_numeric_comparison_value_event_rp0 *)(p_blecore_evt->data))->Numeric_Value);

          /* Set confirm value to 1(YES) */
          confirm_value = 1;
          /* USER CODE BEGIN ACI_GAP_NUMERIC_COMPARISON_VALUE_VSEVT_CODE_0 */

          /* USER CODE END ACI_GAP_NUMERIC_COMPARISON_VALUE_VSEVT_CODE_0 */

          ret = aci_gap_numeric_comparison_value_confirm_yesno(bleAppContext.BleApplicationContext_legacy.connectionHandle, confirm_value);
          if (ret != BLE_STATUS_SUCCESS)
          {
            LOG_INFO_APP("==>> aci_gap_numeric_comparison_value_confirm_yesno : Fail, reason: 0x%02X\n", ret);
          }
          else
          {
            LOG_INFO_APP("==>> aci_gap_numeric_comparison_value_confirm_yesno : Success\n");
          }
          /* USER CODE BEGIN ACI_GAP_NUMERIC_COMPARISON_VALUE_VSEVT_CODE */

          /* USER CODE END ACI_GAP_NUMERIC_COMPARISON_VALUE_VSEVT_CODE */
          break;
        }
[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
        case ACI_GAP_PAIRING_COMPLETE_VSEVT_CODE:
        {
          LOG_INFO_APP(">>== ACI_GAP_PAIRING_COMPLETE_VSEVT_CODE\n");
          aci_gap_pairing_complete_event_rp0 *p_pairing_complete;
          p_pairing_complete = (aci_gap_pairing_complete_event_rp0*)p_blecore_evt->data;

          if (p_pairing_complete->Status != 0)
          {
            LOG_INFO_APP("     - Pairing KO\n     - Status: 0x%02X\n     - Reason: 0x%02X\n",
                         p_pairing_complete->Status, p_pairing_complete->Reason);
          }
          else
          {
            LOG_INFO_APP("     - Pairing Success\n");
          }
          LOG_INFO_APP("\n");

          /* USER CODE BEGIN ACI_GAP_PAIRING_COMPLETE_VSEVT_CODE */

          /* USER CODE END ACI_GAP_PAIRING_COMPLETE_VSEVT_CODE */
          break;
        }
[/#if]
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
        case ACI_GAP_BOND_LOST_VSEVT_CODE:
        {
          LOG_INFO_APP(">>== ACI_GAP_BOND_LOST_EVENT\n");
          ret = aci_gap_allow_rebond(bleAppContext.BleApplicationContext_legacy.connectionHandle);
          if (ret != BLE_STATUS_SUCCESS)
          {
            LOG_INFO_APP("==>> aci_gap_allow_rebond : Fail, reason: 0x%02X\n", ret);
          }
          else
          {
            LOG_INFO_APP("==>> aci_gap_allow_rebond : Success\n");
          }
          /* USER CODE BEGIN ACI_GAP_BOND_LOST_VSEVT_CODE */

          /* USER CODE END ACI_GAP_BOND_LOST_VSEVT_CODE */
          break;
        }
[/#if]
[#if ((myHash["BLE_OPTIONS_ENHANCED_ATT"] == "BLE_OPTIONS_ENHANCED_ATT") && (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
        case (ACI_L2CAP_COC_CONNECT_CONFIRM_VSEVT_CODE):
        {
          aci_l2cap_coc_connect_confirm_event_rp0 *coc_connect_confirm_event;
          coc_connect_confirm_event = (aci_l2cap_coc_connect_confirm_event_rp0*)p_blecore_evt->data;

          /* USER CODE BEGIN ACI_L2CAP_COC_CONNECT_CONFIRM_VSEVT_CODE_1 */

          /* USER CODE END ACI_L2CAP_COC_CONNECT_CONFIRM_VSEVT_CODE_1 */

          APP_DBG_MSG(">>== ACI_L2CAP_COC_CONNECT_CONFIRM_VSEVT_CODE\n");
          BleCoC_EATTContextCentral.Conn_Handle = coc_connect_confirm_event->Connection_Handle;
          BleCoC_EATTContextCentral.Max_Transmission_Unit = coc_connect_confirm_event->MTU;
          BleCoC_EATTContextCentral.Max_Payload_Size = coc_connect_confirm_event->MPS;
          BleCoC_EATTContextCentral.Initial_Credits = coc_connect_confirm_event->Initial_Credits;
          BleCoC_EATTContextCentral.Channel_Number = coc_connect_confirm_event->Channel_Number;
          BleCoC_EATTContextCentral.Channel_Index_List = coc_connect_confirm_event->Channel_Index_List[(BleCoC_EATTContextCentral.Channel_Number)-1];
          
          /* USER CODE BEGIN ACI_L2CAP_COC_CONNECT_CONFIRM_VSEVT_CODE_2 */

          /* USER CODE END ACI_L2CAP_COC_CONNECT_CONFIRM_VSEVT_CODE_2 */

          APP_DBG_MSG("==>> Connection Oriented Channel established\n");
          /* Discover services */
          UTIL_SEQ_SetTask(1U << CFG_TASK_DISCOVER_SERVICES_ID, CFG_SEQ_PRIO_0);
          break;
        }
[/#if]
[#if ((myHash["BLE_OPTIONS_ENHANCED_ATT"] == "BLE_OPTIONS_ENHANCED_ATT") && (myHash["BLE_MODE_PERIPHERAL"] == "Enabled"))]
        case ACI_L2CAP_COC_CONNECT_VSEVT_CODE:
        {
          aci_l2cap_coc_connect_event_rp0 *coc_connect_complete;
          coc_connect_complete = (aci_l2cap_coc_connect_event_rp0*)p_blecore_evt->data;

          uint16_t Result = 0x0000;
          uint8_t Channel_Number;
          uint8_t Channel_Index_List;

          LOG_INFO_APP(">>== ACI_L2CAP_COC_CONNECT_VSEVT_CODE\n");

          /* USER CODE BEGIN ACI_L2CAP_COC_CONNECT_VSEVT_CODE_1 */

          /* USER CODE END ACI_L2CAP_COC_CONNECT_VSEVT_CODE_1 */

          BleCoCEATTContext.Conn_Handle = coc_connect_complete->Connection_Handle;
          BleCoCEATTContext.Max_Transmission_Unit = coc_connect_complete->MTU;
          BleCoCEATTContext.Max_Payload_Size = CFG_BLE_COC_MPS_MAX;
          BleCoCEATTContext.Initial_Credits = coc_connect_complete->Initial_Credits;
          BleCoCEATTContext.Channel_Number = coc_connect_complete->Channel_Number;
          BleCoCEATTContext.SPSM = coc_connect_complete->SPSM;            

          /* USER CODE BEGIN ACI_L2CAP_COC_CONNECT_VSEVT_CODE_2 */

          /* USER CODE END ACI_L2CAP_COC_CONNECT_VSEVT_CODE_2 */

          ret = aci_l2cap_coc_connect_confirm(BleCoCEATTContext.Conn_Handle, 
                                              BleCoCEATTContext.Max_Transmission_Unit, 
                                              BleCoCEATTContext.Max_Payload_Size, 
                                              BleCoCEATTContext.Initial_Credits, 
                                              Result,
                                              &Channel_Number, 
                                              &Channel_Index_List); 
          if (ret != BLE_STATUS_SUCCESS)
          {
            LOG_INFO_APP("==>> aci_l2cap_coc_connect_confirm : Fail, reason: 0x%02X\n", ret);
          }
          else
          {
            LOG_INFO_APP("==>> aci_l2cap_coc_connect_confirm : Success\n");
          }

          BleCoCEATTContext.Channel_Number = Channel_Number;
          BleCoCEATTContext.Channel_Index_List = Channel_Index_List;
          bleAppContext.PeriphChannelIndex = BleCoCEATTContext.Channel_Index_List;

          /* USER CODE BEGIN ACI_L2CAP_COC_CONNECT_VSEVT_CODE_3 */

          /* USER CODE END ACI_L2CAP_COC_CONNECT_VSEVT_CODE_3 */
          break;
        }
        case (ACI_L2CAP_COC_DISCONNECT_VSEVT_CODE):
        {   
          APP_DBG_MSG(">>== ACI_L2CAP_COC_DISCONNECT_VSEVT_CODE\n"); 
          /* USER CODE BEGIN ACI_L2CAP_COC_DISCONNECT_VSEVT_CODE */

          /* USER CODE END ACI_L2CAP_COC_DISCONNECT_VSEVT_CODE */

          
          break;
        }
        case (ACI_GATT_EATT_BEARER_VSEVT_CODE):
        {
          aci_gatt_eatt_bearer_event_rp0 *eatt_bearer_event;
          uint8_t bearer_table_index;

          eatt_bearer_event = (aci_gatt_eatt_bearer_event_rp0*)p_blecore_evt->data;
          APP_DBG_MSG(">>== ACI_GATT_EATT_BEARER_VSEVT_CODE\n");
          APP_DBG_MSG(">>== Channel_Index = %d\n",eatt_bearer_event->Channel_Index );

          /* USER CODE BEGIN ACI_GATT_EATT_BEARER_VSEVT_CODE */

          /* USER CODE END ACI_GATT_EATT_BEARER_VSEVT_CODE */

          bearer_table_index = eatt_bearer_event->Channel_Index - 0x20;
          BleCoCEATTContext.EATT_Bearer_connHdl[bearer_table_index] = (GATT_EAB_PREFIX << 8) | eatt_bearer_event->Channel_Index;
          
          break;
        }

[/#if]
        case ACI_HAL_FW_ERROR_VSEVT_CODE:
        {
          aci_hal_fw_error_event_rp0 *p_fw_error_event;

          p_fw_error_event = (aci_hal_fw_error_event_rp0 *)p_blecore_evt->data;
          UNUSED(p_fw_error_event);
          APP_DBG_MSG(">>== ACI_HAL_FW_ERROR_VSEVT_CODE\n");
          APP_DBG_MSG("FW Error Type = 0x%02X\n", p_fw_error_event->FW_Error_Type);
          /* USER CODE BEGIN ACI_HAL_FW_ERROR_VSEVT_CODE */
    
          /* USER CODE END ACI_HAL_FW_ERROR_VSEVT_CODE */
          break;        
        }
        /* USER CODE BEGIN ECODE_1 */

        /* USER CODE END ECODE_1 */
        default:
        {
          /* USER CODE BEGIN ECODE_DEFAULT */

          /* USER CODE END ECODE_DEFAULT */
          break;
        }
      }
      /* USER CODE BEGIN EVT_VENDOR_1 */

      /* USER CODE END EVT_VENDOR_1 */
    }
    break; /* HCI_VENDOR_SPECIFIC_DEBUG_EVT_CODE */
    /* USER CODE BEGIN EVENT_PCKT */

    /* USER CODE END EVENT_PCKT */
    default:
    {
      /* USER CODE BEGIN EVENT_PCKT_DEFAULT */

      /* USER CODE END EVENT_PCKT_DEFAULT */
      break;
    }
  }
  /* USER CODE BEGIN SVCCTL_App_Notification_1 */

  /* USER CODE END SVCCTL_App_Notification_1 */

  return (SVCCTL_UserEvtFlowEnable);
}
[/#if]

[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
APP_BLE_ConnStatus_t APP_BLE_Get_Server_Connection_Status(void)
{
  return bleAppContext.Device_Connection_Status;
}
[/#if]

[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
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

[#if (((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") && (myHash["NUMBER_OF_SERVICES"] != "0")) || (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
void APP_BLE_Procedure_Gap_General(ProcGapGeneralId_t ProcGapGeneralId)
{
  tBleStatus status;
 
  /* USER CODE BEGIN Procedure_Gap_General_1 */

  /* USER CODE END Procedure_Gap_General_1 */

  switch(ProcGapGeneralId)
  {
    case PROC_GAP_GEN_PHY_TOGGLE:
    {
      uint8_t phy_tx = 0U, phy_rx = 0U;

      status = hci_le_read_phy(bleAppContext.BleApplicationContext_legacy.connectionHandle, &phy_tx, &phy_rx);

      if (status != BLE_STATUS_SUCCESS)
      {
        LOG_INFO_APP("hci_le_read_phy failure: reason=0x%02X\n",status);
      }
      else
      {
        LOG_INFO_APP("==>> hci_le_read_phy - Success\n");
        LOG_INFO_APP("==>> PHY Param  TX= %d, RX= %d\n", phy_tx, phy_rx);
        if ((phy_tx == HCI_TX_PHY_LE_2M) && (phy_rx == HCI_RX_PHY_LE_2M))
        {
          LOG_INFO_APP("==>> hci_le_set_phy PHY Param  TX= %d, RX= %d - ", HCI_TX_PHY_LE_1M, HCI_RX_PHY_LE_1M);
          status = hci_le_set_phy(bleAppContext.BleApplicationContext_legacy.connectionHandle, 0, HCI_TX_PHYS_LE_1M_PREF, HCI_RX_PHYS_LE_1M_PREF, 0);
          if (status != BLE_STATUS_SUCCESS)
          {
            LOG_INFO_APP("Fail\n");
          }
          else
          {
            LOG_INFO_APP("Success\n");
            gap_cmd_resp_wait();/* waiting for HCI_LE_PHY_UPDATE_COMPLETE_SUBEVT_CODE */
          }
        }
        else
        {
          LOG_INFO_APP("==>> hci_le_set_phy PHY Param  TX= %d, RX= %d - ", HCI_TX_PHYS_LE_2M_PREF, HCI_RX_PHYS_LE_2M_PREF);
          status = hci_le_set_phy(bleAppContext.BleApplicationContext_legacy.connectionHandle, 0, HCI_TX_PHYS_LE_2M_PREF, HCI_RX_PHYS_LE_2M_PREF, 0);
          if (status != BLE_STATUS_SUCCESS)
          {
            LOG_INFO_APP("Fail\n");
          }
          else
          {
            LOG_INFO_APP("Success\n");
            gap_cmd_resp_wait();/* waiting for HCI_LE_PHY_UPDATE_COMPLETE_SUBEVT_CODE */
          }
        }
      }
      break;
    }/* PROC_GAP_GEN_PHY_TOGGLE */
    case PROC_GAP_GEN_CONN_TERMINATE:
    {
      status = aci_gap_terminate(bleAppContext.BleApplicationContext_legacy.connectionHandle, HCI_REMOTE_USER_TERMINATED_CONNECTION_ERR_CODE);
      if (status != BLE_STATUS_SUCCESS)
      {
         LOG_INFO_APP("aci_gap_terminate failure: reason=0x%02X\n", status);
      }
      else
      {
        LOG_INFO_APP("==>> aci_gap_terminate : Success\n");
      }
      gap_cmd_resp_wait();/* waiting for HCI_DISCONNECTION_COMPLETE_EVT_CODE */
      break;
    }/* PROC_GAP_GEN_CONN_TERMINATE */
    case PROC_GATT_EXCHANGE_CONFIG:
    {
      status = aci_gatt_exchange_config(bleAppContext.BleApplicationContext_legacy.connectionHandle);
      if (status != BLE_STATUS_SUCCESS)
      {
        LOG_INFO_APP("aci_gatt_exchange_config failure: reason=0x%02X\n", status);
      }
      else
      {
        LOG_INFO_APP("==>> aci_gatt_exchange_config : Success\n");
      }
      break;
    }
    /* USER CODE BEGIN GAP_GENERAL */

    /* USER CODE END GAP_GENERAL */
    default:
      break;
  }
  
  /* USER CODE BEGIN Procedure_Gap_General_2 */

  /* USER CODE END Procedure_Gap_General_2 */
  return;
}
[/#if]

[#if ((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") && (myHash["NUMBER_OF_SERVICES"] != "0"))]
void APP_BLE_Procedure_Gap_Peripheral(ProcGapPeripheralId_t ProcGapPeripheralId)
{
  tBleStatus status;
  uint32_t paramA = 0U;
  uint32_t paramB = 0U;
  uint32_t paramC = 0U;
  uint32_t paramD = 0U;
  
  /* USER CODE BEGIN Procedure_Gap_Peripheral_1 */

  /* USER CODE END Procedure_Gap_Peripheral_1 */

  /* First set parameters before calling ACI APIs, only if needed */
  switch(ProcGapPeripheralId)
  {
    case PROC_GAP_PERIPH_ADVERTISE_START_FAST:
    {
      paramA = ADV_INTERVAL_MIN;
      paramB = ADV_INTERVAL_MAX;
      paramC = APP_BLE_ADV_FAST;
      paramD = ADV_IND;

      break;
    }
    case PROC_GAP_PERIPH_ADVERTISE_NON_CONN_START_FAST:
    {
      paramA = ADV_INTERVAL_MIN;
      paramB = ADV_INTERVAL_MAX;
      paramC = APP_BLE_ADV_NON_CONN_FAST;
      paramD = ADV_NONCONN_IND;

      break;
    }
    case PROC_GAP_PERIPH_ADVERTISE_START_LP:
    {
      paramA = ADV_LP_INTERVAL_MIN;
      paramB = ADV_LP_INTERVAL_MAX;
      paramC = APP_BLE_ADV_LP;
      paramD = ADV_IND;

      break;
    }
    case PROC_GAP_PERIPH_ADVERTISE_NON_CONN_START_LP:
    {
      paramA = ADV_LP_INTERVAL_MIN;
      paramB = ADV_LP_INTERVAL_MAX;
      paramC = APP_BLE_ADV_NON_CONN_LP;
      paramD = ADV_NONCONN_IND;

      break;
    }
    case PROC_GAP_PERIPH_ADVERTISE_STOP:
    {
      paramC = APP_BLE_IDLE;

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
    /* USER CODE BEGIN PARAM_UPDATE_1 */

    /* USER CODE END PARAM_UPDATE_1 */
    default:
      break;
  }

  /* USER CODE BEGIN Procedure_Gap_Peripheral_2 */

  /* USER CODE END Procedure_Gap_Peripheral_2 */

  /* Call ACI APIs */
  switch(ProcGapPeripheralId)
  {
    case PROC_GAP_PERIPH_ADVERTISE_START_FAST:
    case PROC_GAP_PERIPH_ADVERTISE_START_LP:
    case PROC_GAP_PERIPH_ADVERTISE_NON_CONN_START_FAST:
    case PROC_GAP_PERIPH_ADVERTISE_NON_CONN_START_LP:
    {
      /* Start Advertising */
      status = aci_gap_set_discoverable(paramD,
                                        paramA,
                                        paramB,
                                        CFG_BD_ADDRESS_TYPE,
                                        ADV_FILTER,
                                        0, 0, 0, 0, 0, 0);
      if (status != BLE_STATUS_SUCCESS)
      {
        LOG_INFO_APP("==>> aci_gap_set_discoverable - fail, result: 0x%02X\n", status);
      }
      else
      {
        bleAppContext.Device_Connection_Status = (APP_BLE_ConnStatus_t)paramC;
        LOG_INFO_APP("==>> aci_gap_set_discoverable - Success\n");
      }

      status = aci_gap_delete_ad_type(AD_TYPE_TX_POWER_LEVEL);
      if (status != BLE_STATUS_SUCCESS)
      {
        LOG_INFO_APP("==>> delete tx power level - fail, result: 0x%02X\n", status);
      }

      /* Update Advertising data */
      uint8_t *adv_data_p;
      uint8_t adv_data_len;      
      
      adv_data_p = &a_AdvData[0];
      adv_data_len = sizeof(a_AdvData);
      /* USER CODE BEGIN ADV_DATA_UPDATE_1 */

      /* USER CODE END ADV_DATA_UPDATE_1 */
      status = aci_gap_update_adv_data(adv_data_len, adv_data_p);
      if (status != BLE_STATUS_SUCCESS)
      {
        LOG_INFO_APP("==>> Start Advertising Failed, result: 0x%02X\n", status);
      }
      else
      {
        LOG_INFO_APP("==>> Success: Start Advertising\n");
      }
      break;
    }
    case PROC_GAP_PERIPH_ADVERTISE_STOP:
    {
      status = aci_gap_set_non_discoverable();
      if (status != BLE_STATUS_SUCCESS)
      {
        LOG_INFO_APP("aci_gap_set_non_discoverable - fail, result: 0x%02X\n",status);
      }
      else
      {
        bleAppContext.Device_Connection_Status = (APP_BLE_ConnStatus_t)paramC;
        LOG_INFO_APP("==>> aci_gap_set_non_discoverable - Success\n");
      }
      break;
    }/* PROC_GAP_PERIPH_ADVERTISE_STOP */
    case PROC_GAP_PERIPH_ADVERTISE_DATA_UPDATE:
    {
      uint8_t *adv_data_p;
      uint8_t adv_data_len;      
      
      adv_data_p = &a_AdvData[0];
      adv_data_len = sizeof(a_AdvData);
      /* USER CODE BEGIN ADV_DATA_UPDATE_2 */

      /* USER CODE END ADV_DATA_UPDATE_2 */
      status = aci_gap_update_adv_data(adv_data_len, adv_data_p);
      if (status != BLE_STATUS_SUCCESS)
      {
        LOG_INFO_APP("aci_gap_update_adv_data - fail, result: 0x%02X\n",status);
      }
      else
      {
        LOG_INFO_APP("==>> aci_gap_update_adv_data - Success\n");
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
        LOG_INFO_APP("aci_l2cap_connection_parameter_update_req - fail, result: 0x%02X\n",status);
      }
      else
      {
        LOG_INFO_APP("==>> aci_l2cap_connection_parameter_update_req - Success\n");
      }

      break;
    }/* PROC_GAP_PERIPH_CONN_PARAM_UPDATE */
    /* USER CODE BEGIN ACI_CALL */

    /* USER CODE END ACI_CALL */
    default:
      break;
  }
  
  /* USER CODE BEGIN Procedure_Gap_Peripheral_3 */

  /* USER CODE END Procedure_Gap_Peripheral_3 */
  return;
}
[/#if]

[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
void APP_BLE_Procedure_Gap_Central(ProcGapCentralId_t ProcGapCentralId)
{
  tBleStatus status;
  uint32_t paramA, paramB, paramC, paramD;

  UNUSED(paramA);
  UNUSED(paramB);
  UNUSED(paramC);
  UNUSED(paramD);
  
  /* USER CODE BEGIN Procedure_Gap_Central_1 */

  /* USER CODE END Procedure_Gap_Central_1 */

  /* First set parameters before calling ACI APIs, only if needed */
  switch(ProcGapCentralId)
  {
    case PROC_GAP_CENTRAL_SCAN_START:
    {
      paramA = SCAN_INT_MS(500);
      paramB = SCAN_WIN_MS(500);
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
    /* USER CODE BEGIN PARAM_UPDATE */

    /* USER CODE END PARAM_UPDATE */
    default:
      break;
  }
  
  /* USER CODE BEGIN Procedure_Gap_Central_2 */

  /* USER CODE END Procedure_Gap_Central_2 */

  /* Call ACI APIs */
  switch(ProcGapCentralId)
  {
    case PROC_GAP_CENTRAL_SCAN_START:
    {
      status = aci_gap_start_general_discovery_proc(paramA, paramB, CFG_BD_ADDRESS_TYPE, 0);

      if (status != BLE_STATUS_SUCCESS)
      {
        LOG_INFO_APP("aci_gap_start_general_discovery_proc - fail, result: 0x%02X\n", status);
      }
      else
      {
        bleAppContext.Device_Connection_Status = (APP_BLE_ConnStatus_t)paramC;
        LOG_INFO_APP("==>> aci_gap_start_general_discovery_proc - Success\n");
      }

      break;
    }/* PROC_GAP_CENTRAL_SCAN_START */
    case PROC_GAP_CENTRAL_SCAN_TERMINATE:
    {
      status = aci_gap_terminate_gap_proc(GAP_GENERAL_DISCOVERY_PROC);
      if (status != BLE_STATUS_SUCCESS)
      {
        LOG_INFO_APP("aci_gap_terminate_gap_proc - fail, result: 0x%02X\n",status);
      }
      else
      {
        bleAppContext.Device_Connection_Status = (APP_BLE_ConnStatus_t)paramC;
        LOG_INFO_APP("==>> aci_gap_terminate_gap_proc - Success\n");
      }
      break;
    }/* PROC_GAP_CENTRAL_SCAN_TERMINATE */
    /* USER CODE BEGIN ACI_CALL */

    /* USER CODE END ACI_CALL */
    default:
      break;
  }

  /* USER CODE BEGIN Procedure_Gap_Central_3 */

  /* USER CODE END Procedure_Gap_Central_3 */

  return;
}
[/#if]

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled")]
const uint8_t* BleGetBdAddress(void)
{
  const uint8_t *p_bd_addr;
  
  p_bd_addr = (const uint8_t *)a_BdAddr;

  return p_bd_addr;
}
[/#if]

/* USER CODE BEGIN FD */

/* USER CODE END FD */

/*************************************************************
 *
 * LOCAL FUNCTIONS
 *
 *************************************************************/
static uint8_t HOST_BLE_Init(void)
{
  tBleStatus return_status;

  pInitParams.numAttrRecord           = CFG_BLE_NUM_GATT_ATTRIBUTES;
  pInitParams.numAttrServ             = CFG_BLE_NUM_GATT_SERVICES;
  pInitParams.attrValueArrSize        = CFG_BLE_ATT_VALUE_ARRAY_SIZE;
  pInitParams.prWriteListSize         = CFG_BLE_ATTR_PREPARE_WRITE_VALUE_SIZE;
  pInitParams.attMtu                  = CFG_BLE_ATT_MTU_MAX;
  pInitParams.max_coc_nbr             = CFG_BLE_COC_NBR_MAX;
  pInitParams.max_coc_mps             = CFG_BLE_COC_MPS_MAX;
  pInitParams.max_coc_initiator_nbr   = CFG_BLE_COC_INITIATOR_NBR_MAX;
  pInitParams.numOfLinks              = CFG_BLE_NUM_LINK;
  pInitParams.mblockCount             = CFG_BLE_MBLOCK_COUNT;
  pInitParams.bleStartRamAddress      = (uint8_t*)buffer;
  pInitParams.total_buffer_size       = BLE_DYN_ALLOC_SIZE;
  pInitParams.bleStartRamAddress_GATT = (uint8_t*)gatt_buffer;
  pInitParams.total_buffer_size_GATT  = BLE_GATT_BUF_SIZE;
  pInitParams.options                 = CFG_BLE_OPTIONS;
  pInitParams.debug                   = 0U;
/* USER CODE BEGIN HOST_BLE_Init_Params */

/* USER CODE END HOST_BLE_Init_Params */
  return_status = BleStack_Init(&pInitParams);
/* USER CODE BEGIN HOST_BLE_Init */

/* USER CODE END HOST_BLE_Init */
  return ((uint8_t)return_status);
}

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
static void TM_Init(void)
{
[#if myHash["THREADX_STATUS"]?number == 1]
  CHAR * pStack;
[/#if]
  /* UART init. */
  HCI_var.uart_tx_on = 0;
  HCI_var.rx_state = HCI_RX_STATE_WAIT_TYPE;
  HCI_var.rxReceivedState = 0;

  LST_init_head(&UART_RX_Pool);
  LST_init_head(&UART_RX_List);
  LST_init_head(&UART_TX_Pool);
  LST_init_head(&UART_TX_List);

  for (uint8_t rx_index = 0; rx_index < NUM_OF_RX_BUFFER; rx_index++)
  {
    LST_insert_tail(&UART_RX_Pool, (tListNode *)(&(HCI_var.buff_node[rx_index])));
  }

  for (uint8_t tx_index = 0; tx_index < NUM_OF_TX_BUFFER; tx_index++)
  {
    LST_insert_tail(&UART_TX_Pool, (tListNode *)(&(HCI_var.buff_node[NUM_OF_RX_BUFFER + tx_index])));
  }

[#if BspIpDatas??]
[#list 0..(nbInstance-1) as i]
[#if BSP_myHash["bspName"+i] == "Serial Link for CubeMonitor RF"]
  BLEUART_Read(&h${BSP_myHash["IpInstance"+i]?lower_case?replace("s","")}, HCI_GetFreeRxBuffer(), 1 /*IDENTIFIER_OFFSET*/);
[/#if]
[/#list]
[/#if]

/* USER CODE BEGIN TM_Init */
[#if PG_FILL_UCS == "True"]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
  UTIL_LPM_SetOffMode(1 << CFG_LPM_APP_BLE, UTIL_LPM_DISABLE);
  UTIL_LPM_SetStopMode(1<<CFG_LPM_APP_BLE, UTIL_LPM_DISABLE);
  LowPowerModeStatus = LOW_POWER_MODE_DISABLE;
[/#if]
[/#if]
/* USER CODE END TM_Init */

  os_enable_isr();
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_RegTask(1U << CFG_TASK_TX_TO_HOST_ID, UTIL_SEQ_RFU, TM_TxToHost);
  UTIL_SEQ_RegTask(1U << CFG_TASK_NOTIFY_EVENT_ID, UTIL_SEQ_RFU, TM_EventNotify);
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
  UINT TXstatus;
  CHAR *pStack;
  
  /* Create TX to Host ThreadX objects */
  
  TXstatus = tx_byte_allocate(pBytePool, (void **)&pStack, TASK_STACK_SIZE_TX_TO_HOST, TX_NO_WAIT);

  if( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create(&TxToHostTaskHandle, "TX to Host Task", TX_TO_HOST_Task_Entry, 0,
                                 pStack, TASK_STACK_SIZE_TX_TO_HOST,
                                 TASK_PRIO_TX_TO_HOST, TASK_PREEMP_TX_TO_HOST,
                                 TX_NO_TIME_SLICE, TX_AUTO_START);
                                 
    TXstatus |= tx_semaphore_create(&TxToHostSemaphore, "TX to Host Semaphore", 0);
  }

  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "TX to Host ThreadX objects creation FAILED, status: %d", TXstatus);
    Error_Handler();
  }
[/#if]

}

static void TM_SysLocalCmd (uint8_t *data)
{
  uint16_t lcmd_opcode =(uint16_t)(data[1] | (data[2]<<8));

  switch(lcmd_opcode)
  {
    case LHCI_OPCODE_C1_WRITE_REG:
      LHCI_C1_Write_Register((BleCmdSerial_t*)data);
      break;

    case LHCI_OPCODE_C1_READ_REG:
      LHCI_C1_Read_Register((BleCmdSerial_t*)data);
      break;

    case LHCI_OPCODE_C1_DEVICE_INF:
      LHCI_C1_Read_Device_Information((BleCmdSerial_t*)data);
      break;

    case LHCI_OPCODE_C1_RF_CONTROL_ANTENNA_SWITCH:
      LHCI_C1_RF_CONTROL_AntennaSwitch((BleCmdSerial_t*)data);
      break;

    default:
      ((TL_CcEvt_t*)(((BleEvtSerial_t*)data)->evt.payload))->cmdcode = lcmd_opcode;
      ((TL_CcEvt_t*)(((BleEvtSerial_t*)data)->evt.payload))->payload[0] = 0x01;
      ((TL_CcEvt_t*)(((BleEvtSerial_t*)data)->evt.payload))->numcmd = 1;
      ((BleEvtSerial_t*)data)->type = TL_LOCRSP_PKT_TYPE;
      ((BleEvtSerial_t*)data)->evt.evtcode = HCI_COMMAND_COMPLETE_EVT_CODE;
      ((BleEvtSerial_t*)data)->evt.plen = TL_EVT_CS_PAYLOAD_SIZE;

      break;
  }

  return;
}

static void TM_TxToHost(void)
{
  if ( HCI_var.rxReceivedState != 0 )
  {
    uint8_t *pData = 0;
    uint8_t packet_type;
    tBleStatus status = BLE_STATUS_SUCCESS;

    pData = HCI_GetDataReceived();

    if ( pData != NULL )
    {
      packet_type = *pData;

      if( packet_type == TL_LOCCMD_PKT_TYPE )
      {
        TM_SysLocalCmd(pData);
      }

      BleStack_Request(pData);
      BleStackCB_Process();

      if(( packet_type == 0x01 ) || ( packet_type == TL_LOCCMD_PKT_TYPE ) || ( packet_type == TL_LOCRSP_PKT_TYPE ))
      {
        status = HCI_UartSend(pData, HCI_EVENT_SYNCHRO);
      }

      if( status != BLE_STATUS_SUCCESS )
      {
        /* No more TX buffer available - Synchro event not sent */
        assert_param(0);
      }
    }
  }

  if( HCI_var.uart_tx_on == 1 )
  {
    uint8_t *pData = 0;
    uint16_t size;

    HCI_var.uart_tx_on |= 2;
    size = HCI_GetDataToSend(&pData);

    if( pData != 0 )
    {
      os_disable_isr();
[#if BspIpDatas??]
[#list 0..(nbInstance-1) as i]
[#if BSP_myHash["bspName"+i] == "Serial Link for CubeMonitor RF"]
      BLEUART_Write(&h${BSP_myHash["IpInstance"+i]?lower_case?replace("s","")}, pData, size);
[/#if]
[/#list]
[/#if]
      os_enable_isr();
    }
    else
    {}
  }
  else
  {}
}

static void TM_EventNotify(void)
{
  change_state_options_t event_options;

  /* Notify LL that Host is ready */
  event_options.combined_value = 0x0F;
  ll_intf_chng_evnt_hndlr_state(event_options);
}

static void TM_UART_TxComplete(uint8_t *buffer)
{
  memset(ongoing_TX_node->buf, 0, HCI_DATA_MAX_SIZE);
  LST_insert_tail(&UART_TX_Pool,(tListNode*) ongoing_TX_node);

  if ( LST_get_size(&UART_TX_List) == 0)
  {
    HCI_var.uart_tx_on = 0; /* No more data to send */
  }
  else
  {
    HCI_var.uart_tx_on = 1; /* More data to send */
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
    UTIL_SEQ_SetTask(1U << CFG_TASK_TX_TO_HOST_ID,CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
    tx_semaphore_put(&TX_TO_HOST_Thread_Sem);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
//TODO
[/#if]
  }
}

static void TM_UART_RxComplete( uint8_t *buffer )
{
  UART_node *pNode = ((UART_node*)(UART_RX_List.prev));
  uint8_t *data = pNode->buf;
  uint16_t size_to_receive = 1, header_size, payload_size;

  switch ( HCI_var.rx_state )
  {
  case HCI_RX_STATE_WAIT_TYPE:
    {
      if ( data[0] == HCI_ACLDATA_PKT_TYPE )
      {
        HCI_var.rx_state = HCI_RX_STATE_WAIT_HEADER;
        data += 1;
        size_to_receive = HCI_ACLDATA_HDR_SIZE - 1;
      }
      else if ( (data[0] == HCI_COMMAND_PKT_TYPE) ||
                (data[0] == 0x20) )
      {
        HCI_var.rx_state = HCI_RX_STATE_WAIT_HEADER;
        data += 1;
        size_to_receive = HCI_COMMAND_HDR_SIZE - 1;
      }
      else if (data[0] == HCI_ISODATA_PKT_TYPE)
      {
        HCI_var.rx_state = HCI_RX_STATE_WAIT_HEADER;
        data += 1;
        size_to_receive = HCI_ISODATA_HDR_SIZE - 1;
      }
      else
      {
        /* Received unknown packet type: silently ignore */
      }
      break;
    }

  case HCI_RX_STATE_WAIT_HEADER:
    {
      header_size = ((data[0] == HCI_ACLDATA_PKT_TYPE) ?
                     HCI_ACLDATA_HDR_SIZE : HCI_COMMAND_HDR_SIZE);
      payload_size = data[3];
      if (data[0] == HCI_ISODATA_PKT_TYPE)
      {
        header_size = HCI_ISODATA_HDR_SIZE;
        payload_size = data[3] | ((data[4] &0x3F) << 8);
      }

      if ( payload_size > 0 )
      {
        HCI_var.rx_state = HCI_RX_STATE_WAIT_PAYLOAD;
        data += header_size;
        size_to_receive = payload_size;
        break;
      }
      /* else continue with next case */
    }

  default:
  case HCI_RX_STATE_WAIT_PAYLOAD:
    {
      HCI_var.rxReceivedState += 1;
      HCI_var.rx_state = HCI_RX_STATE_WAIT_TYPE;
      data = HCI_GetFreeRxBuffer();
    }
  }

  os_disable_isr();
[#if BspIpDatas??]
[#list 0..(nbInstance-1) as i]
[#if BSP_myHash["bspName"+i] == "Serial Link for CubeMonitor RF"]
  BLEUART_Read(&h${BSP_myHash["IpInstance"+i]?lower_case?replace("s","")}, data, size_to_receive );
[/#if]
[/#list]
[/#if]
  os_enable_isr();

[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_TX_TO_HOST_ID,CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_put(&TX_TO_HOST_Thread_Sem);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
//TODO
[/#if]
}

static void BLEUART_Write(UART_HandleTypeDef *huart, uint8_t *buffer, uint16_t size)
{
  writeBusBuffer = buffer;
  HAL_UART_Transmit_DMA(huart, buffer, size);
}

static void BLEUART_Read(UART_HandleTypeDef *huart, uint8_t *buffer, uint16_t size)
{
  HAL_StatusTypeDef uart_status;
  readBusBuffer = buffer;

  uart_status = HAL_UART_Receive_DMA(huart, buffer, size);
  if ( uart_status != HAL_OK )
  {
    /* No more RX buffer available - UART blocked in idle mode */
    assert_param(0);
  }
}

static int HCI_UartSend(uint8_t *data, uint8_t hci_event_type)
{
  uint16_t size;
  uint8_t *pData = HCI_GetFreeTxBuffer(hci_event_type);

  if ( pData == 0 )
  {
    /* No more TX buffer available */
    return BLE_STATUS_FAILED;
  }

  HCI_var.uart_tx_on |= 1;

  if (data[0] == HCI_ACLDATA_PKT_TYPE)
  {
    size = HCI_ACLDATA_HDR_SIZE + data[3];
  }
  else if (data[0] == HCI_ISODATA_PKT_TYPE)
  {
    size = HCI_ISODATA_HDR_SIZE + (data[3] | ((data[4] &0x3F) << 8) );
  }
  else if (data[0] == TL_LOCRSP_PKT_TYPE)
  {
    size = HCI_EVENT_HDR_SIZE + data[2];
  }
  else
  {
    size = HCI_EVENT_HDR_SIZE + data[2];
  }

  if( size > 255 )
  {
    memcpy( pData, data, 254);
    memcpy( pData + 254, data + 254, size - 254);
  }
  else
  {
    memcpy( pData, data, size);
  }

  return BLE_STATUS_SUCCESS;
}

static uint16_t HCI_GetDataToSend(uint8_t **dataToSend)
{
  uint16_t size;
  UART_node *pNode = NULL;

  if (LST_get_size(&UART_TX_List) != 0)
  {
    LST_remove_head(&UART_TX_List,(tListNode**) &pNode);

    if ( pNode->buf[0] == HCI_ACLDATA_PKT_TYPE )
    {
      size = HCI_ACLDATA_HDR_SIZE + pNode->buf[3];
    }
    else if( pNode->buf[0] == HCI_ISODATA_PKT_TYPE)
    {
      size = HCI_ISODATA_HDR_SIZE +
        (pNode->buf[3] | ((pNode->buf[4] &0x3F) << 8));
    }
    else
    {
      size = HCI_EVENT_HDR_SIZE + pNode->buf[2];
    }

    *dataToSend = &pNode->buf[0];

    ongoing_TX_node = pNode;
  }
  else
  {
    size = 0;
  }
  return size;
}

static uint8_t* HCI_GetFreeTxBuffer(uint8_t hci_event_type)
{
  UART_node *pNode = NULL;
  uint8_t size = LST_get_size(&UART_TX_Pool);
  
  if (((hci_event_type == HCI_EVENT_ASYNCHRO) && (size > NUM_OF_TX_SYNCHRO))
      || ((hci_event_type == HCI_EVENT_SYNCHRO) && (size > 0)))
  {
    LST_remove_head(&UART_TX_Pool,(tListNode**) &pNode);
    
    if (pNode != NULL)
    {
      LST_insert_tail(&UART_TX_List, (tListNode *)pNode);
      return pNode->buf;
    }
    else
    {
      return NULL;
    }
  }
  else
  {
    return NULL;
  }
}

static uint8_t* HCI_GetFreeRxBuffer(void)
{
  UART_node *pNode = NULL;

  if (LST_get_size(&UART_RX_Pool) != 0)
  {
    LST_remove_head(&UART_RX_Pool,(tListNode**) &pNode);
    memset( pNode->buf, 0, HCI_DATA_MAX_SIZE );
    LST_insert_tail(&UART_RX_List, (tListNode *)pNode);

    return pNode->buf;
  }
  else
  {
    return NULL;
  }
}

static uint8_t* HCI_GetDataReceived(void)
{
  UART_node *pNode = NULL;
  HCI_var.rxReceivedState -= 1;

  if (LST_get_size(&UART_RX_List) != 0)
  {
    LST_remove_head(&UART_RX_List,(tListNode**) &pNode);
    LST_insert_tail(&UART_RX_Pool, (tListNode *)pNode);
    return pNode->buf;
  }
  else
  {
    return NULL;
  }
}

[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled")]

static void Ble_Hci_Gap_Gatt_Init(void)
{
[#if (myHash["BLE_OPTIONS_LL_ONLY"] != "BLE_OPTIONS_LL_ONLY")]
  uint8_t role;
  uint16_t gap_service_handle = 0U, gap_dev_name_char_handle = 0U, gap_appearance_char_handle = 0U;
[/#if]
[#if (myHash["CFG_BD_ADDRESS_DEVICE"] == "GAP_PUBLIC_ADDR")]
  const uint8_t *p_bd_addr;
[/#if]
[#if (myHash["CFG_BD_ADDRESS_DEVICE"] == "GAP_STATIC_RANDOM_ADDR") ]
  uint32_t p_bd_addr[2];
[/#if]
[#if (myHash["CFG_STATIC_RANDOM_ADDRESS"] == "2")]
uint32_t a_BdAddrUdn[6]   = {0,0};
[/#if]
[#if (myHash["BLE_OPTIONS_LL_ONLY"] != "BLE_OPTIONS_LL_ONLY")]
  uint16_t a_appearance[1] = {CFG_GAP_APPEARANCE};
[/#if]
  const uint8_t *p_ir_value;
  const uint8_t *p_er_value;
  tBleStatus ret;

  /* USER CODE BEGIN Ble_Hci_Gap_Gatt_Init */

  /* USER CODE END Ble_Hci_Gap_Gatt_Init */

  LOG_INFO_APP("==>> Start Ble_Hci_Gap_Gatt_Init function\n");

[#if (myHash["CFG_BD_ADDRESS_DEVICE"] ==  "GAP_PUBLIC_ADDR")]
  /* Write the BD Address */
  p_bd_addr = BleGenerateBdAddress();

  /* USER CODE BEGIN BD_Address_Mngt */

  /* USER CODE END BD_Address_Mngt */

  ret = aci_hal_write_config_data(CONFIG_DATA_PUBADDR_OFFSET,
                                  CONFIG_DATA_PUBADDR_LEN,
                                  (uint8_t*) p_bd_addr);
  if (ret != BLE_STATUS_SUCCESS)
  {
    LOG_INFO_APP("  Fail   : aci_hal_write_config_data command - CONFIG_DATA_PUBADDR_OFFSET, result: 0x%02X\n", ret);
  }
  else
  {
    LOG_INFO_APP("  Success: aci_hal_write_config_data command - CONFIG_DATA_PUBADDR_OFFSET\n");
    LOG_INFO_APP("  Public Bluetooth Address: %02x:%02x:%02x:%02x:%02x:%02x\n",p_bd_addr[5],p_bd_addr[4],p_bd_addr[3],p_bd_addr[2],p_bd_addr[1],p_bd_addr[0]);
  }
[/#if]

[#if (myHash["CFG_BD_ADDRESS_DEVICE"] ==  "GAP_STATIC_RANDOM_ADDR")]
  /**
   * Static random Address
   * The two upper bits shall be set to 1
   * The lowest 32bits is read from the UDN to differentiate between devices
   * The RNG may be used to provide a random number on each power on
   */
[#if (myHash["CFG_STATIC_RANDOM_ADDRESS"] == "1")]
  p_bd_addr[0] = CFG_STATIC_RANDOM_ADDRESS & 0xFFFFFFFF;
  p_bd_addr[1] = (uint32_t)((uint64_t)CFG_STATIC_RANDOM_ADDRESS >> 32);
  p_bd_addr[1] |= 0xC000; /* The two upper bits shall be set to 1 */
[/#if]
[#if (myHash["CFG_STATIC_RANDOM_ADDRESS"] == "2")]
  uint32_t company_id;
  uint32_t device_id;
  a_BdAddrUdn[0] = (uint8_t)LL_FLASH_GetUDN();

  company_id = LL_FLASH_GetSTCompanyID();
  device_id = LL_FLASH_GetDeviceID();
  a_BdAddrUdn[1] = (uint8_t)((CFG_STATIC_UNIQUE_RANDOM_ADDR_LSB & 0x0000FF00) >> 8);
  a_BdAddrUdn[2] = (uint8_t)device_id;
  a_BdAddrUdn[3] = (uint8_t)(company_id & 0x000000FF);

  p_bd_addr [0] = (a_BdAddrUdn[3] << 24 | a_BdAddrUdn[2] << 16 | a_BdAddrUdn[1] << 8 | a_BdAddrUdn[0]);

  a_BdAddrUdn[4] = (uint8_t)((company_id & 0x0000FF00) >> 8);
  a_BdAddrUdn[5] = (uint8_t)((company_id & 0x00FF0000) >> 16);
  p_bd_addr [1] = (a_BdAddrUdn[5] << 8) | (a_BdAddrUdn[4]);
  p_bd_addr [1] |= 0xC000; /* The two upper bits shall be set to 1 */
[/#if] 
[#if (myHash["CFG_STATIC_RANDOM_ADDRESS"] == "0")]
  /* Random address generation */
  HW_RNG_Get(1, &p_bd_addr[1]);
  HW_RNG_Get(1, &p_bd_addr[0]);
  p_bd_addr[1] |= 0xC000; /* The two upper bits shall be set to 1 */
[/#if]
[/#if]

[#if (myHash["CFG_BD_ADDRESS_DEVICE"] ==  "GAP_STATIC_RANDOM_ADDR")]
  ret = aci_hal_write_config_data(CONFIG_DATA_RANDOM_ADDRESS_OFFSET, CONFIG_DATA_RANDOM_ADDRESS_LEN, (uint8_t*)p_bd_addr);
  if (ret != BLE_STATUS_SUCCESS)
  {
    LOG_INFO_APP("  Fail   : aci_hal_write_config_data command - CONFIG_DATA_RANDOM_ADDRESS_OFFSET, result: 0x%02X\n", ret);
  }
  else
  {
    LOG_INFO_APP("  Success: aci_hal_write_config_data command - CONFIG_DATA_RANDOM_ADDRESS_OFFSET\n");
    LOG_INFO_APP("  Random Bluetooth Address: %02x:%02x:%02x:%02x:%02x:%02x\n", (uint8_t)(p_bd_addr[1] >> 8),
                                                                               (uint8_t)(p_bd_addr[1]),
                                                                               (uint8_t)(p_bd_addr[0] >> 24),
                                                                               (uint8_t)(p_bd_addr[0] >> 16),
                                                                               (uint8_t)(p_bd_addr[0] >> 8),
                                                                               (uint8_t)(p_bd_addr[0]));
     memcpy(&a_BdAddr[0], (uint8_t*)p_bd_addr, 6);
  }
[/#if]


  /* Generate Identity root key Value */
  p_ir_value = BleGenerateIRValue();
  
  /* Write Identity root key used to derive IRK and DHK(Legacy) */
  ret = aci_hal_write_config_data(CONFIG_DATA_IR_OFFSET, CONFIG_DATA_IR_LEN, p_ir_value);
  if (ret != BLE_STATUS_SUCCESS)
  {
    LOG_INFO_APP("  Fail   : aci_hal_write_config_data command - CONFIG_DATA_IR_OFFSET, result: 0x%02X\n", ret);
  }
  else
  {
    LOG_INFO_APP("  Success: aci_hal_write_config_data command - CONFIG_DATA_IR_OFFSET\n");
  }

  /* Generate Encryption root key Value */
  p_er_value = BleGenerateERValue();
  
  /* Write Encryption root key used to derive LTK and CSRK */
  ret = aci_hal_write_config_data(CONFIG_DATA_ER_OFFSET, CONFIG_DATA_ER_LEN, p_er_value);
  if (ret != BLE_STATUS_SUCCESS)
  {
    LOG_INFO_APP("  Fail   : aci_hal_write_config_data command - CONFIG_DATA_ER_OFFSET, result: 0x%02X\n", ret);
  }
  else
  {
    LOG_INFO_APP("  Success: aci_hal_write_config_data command - CONFIG_DATA_ER_OFFSET\n");
  }

  /* Set Transmission RF Power. */
  ret = aci_hal_set_tx_power_level(1, CFG_TX_POWER);
  if (ret != BLE_STATUS_SUCCESS)
  {
    LOG_INFO_APP("  Fail   : aci_hal_set_tx_power_level command, result: 0x%02X\n", ret);
  }
  else
  {
    LOG_INFO_APP("  Success: aci_hal_set_tx_power_level command\n");
  }

[#if (myHash["BLE_OPTIONS_LL_ONLY"] != "BLE_OPTIONS_LL_ONLY")]
  /* Initialize GATT interface */
  ret = aci_gatt_init();
  if (ret != BLE_STATUS_SUCCESS)
  {
    LOG_INFO_APP("  Fail   : aci_gatt_init command, result: 0x%02X\n", ret);
  }
  else
  {
    LOG_INFO_APP("  Success: aci_gatt_init command\n");
  }

  /* Initialize GAP interface */
  role = 0U;
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")]
  role |= GAP_PERIPHERAL_ROLE;
[/#if]
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled")]
  role |= GAP_CENTRAL_ROLE;
[/#if]

  /* USER CODE BEGIN Role_Mngt */

  /* USER CODE END Role_Mngt */

  if (role > 0)
  {
    ret = aci_gap_init(role,
                       CFG_PRIVACY,
                       sizeof(a_GapDeviceName),
                       &gap_service_handle,
                       &gap_dev_name_char_handle,
                       &gap_appearance_char_handle);

    if (ret != BLE_STATUS_SUCCESS)
    {
      LOG_INFO_APP("  Fail   : aci_gap_init command, result: 0x%02X\n", ret);
    }
    else
    {
      LOG_INFO_APP("  Success: aci_gap_init command\n");
    }


    ret = aci_gatt_update_char_value(gap_service_handle,
                                     gap_dev_name_char_handle,
                                     0,
                                     sizeof(a_GapDeviceName),
                                     (uint8_t *) a_GapDeviceName);
    if (ret != BLE_STATUS_SUCCESS)
    {
      LOG_INFO_APP("  Fail   : aci_gatt_update_char_value - Device Name, result: 0x%02X\n", ret);
    }
    else
    {
      LOG_INFO_APP("  Success: aci_gatt_update_char_value - Device Name\n");
    }

    ret = aci_gatt_update_char_value(gap_service_handle,
                                     gap_appearance_char_handle,
                                     0,
                                     sizeof(a_appearance),
                                     (uint8_t *)&a_appearance);
    if (ret != BLE_STATUS_SUCCESS)
    {
      LOG_INFO_APP("  Fail   : aci_gatt_update_char_value - Appearance, result: 0x%02X\n", ret);
    }
    else
    {
      LOG_INFO_APP("  Success: aci_gatt_update_char_value - Appearance\n");
    }
  }
  else
  {
    LOG_ERROR_APP("GAP role cannot be null\n");
  }
[/#if]

  /* Initialize Default PHY */
  ret = hci_le_set_default_phy(CFG_PHY_PREF, CFG_PHY_PREF_TX, CFG_PHY_PREF_RX);
  if (ret != BLE_STATUS_SUCCESS)
  {
    LOG_INFO_APP("  Fail   : hci_le_set_default_phy command, result: 0x%02X\n", ret);
  }
  else
  {
    LOG_INFO_APP("  Success: hci_le_set_default_phy command\n");
  }

[#if ((myHash["BLE_MODE_SKELETON"] != "Enabled")  && (myHash["BLE_OPTIONS_LL_ONLY"] != "BLE_OPTIONS_LL_ONLY"))]
  /* Initialize IO capability */
  bleAppContext.BleApplicationContext_legacy.bleSecurityParam.ioCapability = CFG_IO_CAPABILITY;
  ret = aci_gap_set_io_capability(bleAppContext.BleApplicationContext_legacy.bleSecurityParam.ioCapability);
  if (ret != BLE_STATUS_SUCCESS)
  {
    LOG_INFO_APP("  Fail   : aci_gap_set_io_capability command, result: 0x%02X\n", ret);
  }
  else
  {
    LOG_INFO_APP("  Success: aci_gap_set_io_capability command\n");
  }

  /* Initialize authentication */
  bleAppContext.BleApplicationContext_legacy.bleSecurityParam.mitm_mode             = CFG_MITM_PROTECTION;
  bleAppContext.BleApplicationContext_legacy.bleSecurityParam.encryptionKeySizeMin  = CFG_ENCRYPTION_KEY_SIZE_MIN;
  bleAppContext.BleApplicationContext_legacy.bleSecurityParam.encryptionKeySizeMax  = CFG_ENCRYPTION_KEY_SIZE_MAX;
  bleAppContext.BleApplicationContext_legacy.bleSecurityParam.Use_Fixed_Pin         = CFG_USED_FIXED_PIN;
  bleAppContext.BleApplicationContext_legacy.bleSecurityParam.Fixed_Pin             = CFG_FIXED_PIN;
  bleAppContext.BleApplicationContext_legacy.bleSecurityParam.bonding_mode          = CFG_BONDING_MODE;
  /* USER CODE BEGIN Ble_Hci_Gap_Gatt_Init_1 */

  /* USER CODE END Ble_Hci_Gap_Gatt_Init_1 */

  ret = aci_gap_set_authentication_requirement(bleAppContext.BleApplicationContext_legacy.bleSecurityParam.bonding_mode,
                                               bleAppContext.BleApplicationContext_legacy.bleSecurityParam.mitm_mode,
                                               CFG_SC_SUPPORT,
                                               CFG_KEYPRESS_NOTIFICATION_SUPPORT,
                                               bleAppContext.BleApplicationContext_legacy.bleSecurityParam.encryptionKeySizeMin,
                                               bleAppContext.BleApplicationContext_legacy.bleSecurityParam.encryptionKeySizeMax,
                                               bleAppContext.BleApplicationContext_legacy.bleSecurityParam.Use_Fixed_Pin,
                                               bleAppContext.BleApplicationContext_legacy.bleSecurityParam.Fixed_Pin,
                                               CFG_BD_ADDRESS_DEVICE);
  if (ret != BLE_STATUS_SUCCESS)
  {
    LOG_INFO_APP("  Fail   : aci_gap_set_authentication_requirement command, result: 0x%02X\n", ret);
  }
  else
  {
    LOG_INFO_APP("  Success: aci_gap_set_authentication_requirement command\n");
  }

  /* Initialize whitelist */
  if (bleAppContext.BleApplicationContext_legacy.bleSecurityParam.bonding_mode)
  {
    ret = aci_gap_configure_whitelist();
    if (ret != BLE_STATUS_SUCCESS)
    {
      LOG_INFO_APP("  Fail   : aci_gap_configure_whitelist command, result: 0x%02X\n", ret);
    }
    else
    {
      LOG_INFO_APP("  Success: aci_gap_configure_whitelist command\n");
    }
  }

  /* USER CODE BEGIN Ble_Hci_Gap_Gatt_Init_2 */

  /* USER CODE END Ble_Hci_Gap_Gatt_Init_2 */
  
[/#if]
  LOG_INFO_APP("==>> End Ble_Hci_Gap_Gatt_Init function\n");

  return;
}

static void Ble_UserEvtRx( void)
{
  SVCCTL_UserEvtFlowStatus_t svctl_return_status;
  BleEvtPacket_t *phcievt = NULL;

  LST_remove_head ( &BleAsynchEventQueue, (tListNode **)&phcievt );

  svctl_return_status = SVCCTL_UserEvtRx((void *)&(phcievt->evtserial));

  if (svctl_return_status != SVCCTL_UserEvtFlowDisable)
  {
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
    AMM_Free((uint32_t *)phcievt);
[#else]
    free(phcievt);
[/#if]
  }
  else
  {
    LST_insert_head ( &BleAsynchEventQueue, (tListNode *)phcievt );
  }

  if ((LST_is_empty(&BleAsynchEventQueue) == FALSE) && (svctl_return_status != SVCCTL_UserEvtFlowDisable) )
  {
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
    UTIL_SEQ_SetTask(1U << CFG_TASK_HCI_ASYNCH_EVT_ID, CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
    tx_semaphore_put(&HciAsyncEvtSemaphore);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
    osSemaphoreRelease(HciAsyncEvtSemaphore);
[/#if]
  }

  /* Trigger BLE Host stack to process */
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_BLE_HOST, CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_put(&BleHostSemaphore);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
  osSemaphoreRelease(BleHostSemaphore);
[/#if]

}

[#if (myHash["CFG_BD_ADDRESS_DEVICE"] == "GAP_PUBLIC_ADDR")]
static const uint8_t* BleGenerateBdAddress(void)
{
  OTP_Data_s *p_otp_addr = NULL;
  const uint8_t *p_bd_addr;
  uint32_t udn;
  uint32_t company_id;
  uint32_t device_id;
  uint8_t a_BdAddrDefault[BD_ADDR_SIZE] ={0x65, 0x43, 0x21, 0x1E, 0x08, 0x00};
  uint8_t a_BDAddrNull[BD_ADDR_SIZE];
  memset(&a_BDAddrNull[0], 0x00, sizeof(a_BDAddrNull));

  a_BdAddr[0] = (uint8_t)(CFG_BD_ADDRESS & 0x0000000000FF);
  a_BdAddr[1] = (uint8_t)((CFG_BD_ADDRESS & 0x00000000FF00) >> 8);
  a_BdAddr[2] = (uint8_t)((CFG_BD_ADDRESS & 0x000000FF0000) >> 16);
  a_BdAddr[3] = (uint8_t)((CFG_BD_ADDRESS & 0x0000FF000000) >> 24);
  a_BdAddr[4] = (uint8_t)((CFG_BD_ADDRESS & 0x00FF00000000) >> 32);
  a_BdAddr[5] = (uint8_t)((CFG_BD_ADDRESS & 0xFF0000000000) >> 40);

  if(memcmp(&a_BdAddr[0], &a_BDAddrNull[0], BD_ADDR_SIZE) != 0)
  {
    p_bd_addr = (const uint8_t *)a_BdAddr;
  }
  else
  {
    udn = LL_FLASH_GetUDN();

    /* USER CODE BEGIN BleGenerateBdAddress */

    /* USER CODE END BleGenerateBdAddress */

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
      a_BdAddr[0] = (uint8_t)(udn & 0x000000FF);
      a_BdAddr[1] = (uint8_t)((udn & 0x0000FF00) >> 8);
      a_BdAddr[2] = (uint8_t)device_id;
      a_BdAddr[3] = (uint8_t)(company_id & 0x000000FF);
      a_BdAddr[4] = (uint8_t)((company_id & 0x0000FF00) >> 8);
      a_BdAddr[5] = (uint8_t)((company_id & 0x00FF0000) >> 16);
      p_bd_addr = (const uint8_t *)a_BdAddr;
    }
    else
    {
      if (OTP_Read(0, &p_otp_addr) == HAL_OK)
      {
        a_BdAddr[0] = p_otp_addr->bd_address[0];
        a_BdAddr[1] = p_otp_addr->bd_address[1];
        a_BdAddr[2] = p_otp_addr->bd_address[2];
        a_BdAddr[3] = p_otp_addr->bd_address[3];
        a_BdAddr[4] = p_otp_addr->bd_address[4];
        a_BdAddr[5] = p_otp_addr->bd_address[5];
        p_bd_addr = (const uint8_t *)a_BdAddr;
      }
      else
      {
        memcpy(&a_BdAddr[0], a_BdAddrDefault,BD_ADDR_SIZE);
        p_bd_addr = (const uint8_t *)a_BdAddr;
      }
    }
  }

  return p_bd_addr;
}
[/#if]

static const uint8_t* BleGenerateIRValue(void)
{
  uint32_t uid_word0;
  uint32_t uid_word1;
  const uint8_t *p_ir_value;
  uint8_t a_BLE_CfgIrValueNull[16];
  uint8_t a_cfg_ir_value[16] = CFG_BLE_IR;
  uint8_t a_BLE_CfgIrValueDefault[16] =
  {
    0x12, 0x34, 0x56, 0x78, 0x9A, 0xBC, 0xDE, 0xF0, 0x12, 0x34, 0x56, 0x78, 0x9A, 0xBC, 0xDE, 0xF0
  };

  /* USER CODE BEGIN BleGenerateIRValue_1 */

  /* USER CODE END BleGenerateIRValue_1 */

  memset(&a_BLE_CfgIrValueNull[0], 0x00, sizeof(a_BLE_CfgIrValueNull));

  memcpy(&a_BLE_CfgIrValue[0], a_cfg_ir_value,16);

  if(memcmp(&a_BLE_CfgIrValue[0], &a_BLE_CfgIrValueNull[0], 16) != 0)
  {
    p_ir_value = (const uint8_t *)a_BLE_CfgIrValue;
  }
  else
  {
    uid_word0 = LL_GetUID_Word0();
    uid_word1 = LL_GetUID_Word1();
    /* USER CODE BEGIN BleGenerateIRValue_2 */

    /* USER CODE END BleGenerateIRValue_2 */

    if ((uid_word0 != 0xFFFFFFFF) && (uid_word1 != 0xFFFFFFFF))
    {

    /**
     * Identity root key is built from bits of the UDN.
     */
      a_BLE_CfgIrValue[0] = a_BLE_CfgIrValue[8] = (uint8_t)(uid_word0 & 0x000000FF);
      a_BLE_CfgIrValue[1] = a_BLE_CfgIrValue[9] = (uint8_t)((uid_word0 & 0x0000FF00) >> 8);
      a_BLE_CfgIrValue[2] = a_BLE_CfgIrValue[10] = (uint8_t)((uid_word0 & 0x00FF0000) >> 16);
      a_BLE_CfgIrValue[3] = a_BLE_CfgIrValue[11] = (uint8_t)((uid_word0 & 0xFF000000) >> 24);
      a_BLE_CfgIrValue[4] = a_BLE_CfgIrValue[12] = (uint8_t)(uid_word1 & 0x000000FF);
      a_BLE_CfgIrValue[5] = a_BLE_CfgIrValue[13] = (uint8_t)((uid_word1 & 0x0000FF00) >> 8);
      a_BLE_CfgIrValue[6] = a_BLE_CfgIrValue[14] = (uint8_t)((uid_word1 & 0x00FF0000) >> 16);
      a_BLE_CfgIrValue[7] = a_BLE_CfgIrValue[15] = (uint8_t)((uid_word1 & 0xFF000000) >> 24);
      p_ir_value = (const uint8_t *)a_BLE_CfgIrValue;
    }
    else
    {
      memcpy(&a_BLE_CfgIrValue[0], a_BLE_CfgIrValueDefault,16);
      p_ir_value = (const uint8_t *)a_BLE_CfgIrValue;
    }
  }

  /* USER CODE BEGIN BleGenerateIRValue_3 */

  /* USER CODE END BleGenerateIRValue_3 */
  return p_ir_value;
}

static const uint8_t* BleGenerateERValue(void)
{
  const uint8_t *p_er_value;
  uint32_t uid_word1;
  uint32_t uid_word2;
  uint8_t a_BLE_CfgErValueNull[16];
  uint8_t a_cfg_er_value[16] = CFG_BLE_ER;
  uint8_t a_BLE_CfgErValueDefault[16] =
  {
    0xFE, 0xDC, 0xBA, 0x09, 0x87, 0x65, 0x43, 0x21, 0xFE, 0xDC, 0xBA, 0x09, 0x87, 0x65, 0x43, 0x21
  };

  /* USER CODE BEGIN BleGenerateERValue_1 */

  /* USER CODE END BleGenerateERValue_1 */

  memset(&a_BLE_CfgErValueNull[0], 0x00, sizeof(a_BLE_CfgErValueNull));

  memcpy(&a_BLE_CfgErValue[0], a_cfg_er_value,16);

  if(memcmp(&a_BLE_CfgErValue[0], &a_BLE_CfgErValueNull[0], 16) != 0)
  {
    p_er_value = (const uint8_t *)a_BLE_CfgErValue;
  }
  else
  {
    uid_word1 = LL_GetUID_Word1();
    uid_word2 = LL_GetUID_Word2();

    /* USER CODE BEGIN BleGenerateERValue_2 */

    /* USER CODE END BleGenerateERValue_2 */

   if ((uid_word1 != 0xFFFFFFFF) && (uid_word2 != 0xFFFFFFFF))
    {

    /**
     * Encryption root key is built from bits of the UDN.
     */
      a_BLE_CfgErValue[0] = a_BLE_CfgErValue[8] = (uint8_t)(uid_word2 & 0x000000FF);
      a_BLE_CfgErValue[1] = a_BLE_CfgErValue[9] = (uint8_t)((uid_word2 & 0x0000FF00) >> 8);
      a_BLE_CfgErValue[2] = a_BLE_CfgErValue[10] = (uint8_t)((uid_word2 & 0x00FF0000) >> 16);
      a_BLE_CfgErValue[3] = a_BLE_CfgErValue[11] = (uint8_t)((uid_word2 & 0xFF000000) >> 24);
      a_BLE_CfgErValue[4] = a_BLE_CfgErValue[12] = (uint8_t)~(uid_word1 & 0x000000FF);
      a_BLE_CfgErValue[5] = a_BLE_CfgErValue[13] = (uint8_t)~((uid_word1 & 0x0000FF00) >> 8);
      a_BLE_CfgErValue[6] = a_BLE_CfgErValue[14] = (uint8_t)~((uid_word1 & 0x00FF0000) >> 16);
      a_BLE_CfgErValue[7] = a_BLE_CfgErValue[15] = (uint8_t)~((uid_word1 & 0xFF000000) >> 24);
      p_er_value = (const uint8_t *)a_BLE_CfgErValue;
    }
    else
    {
      memcpy(&a_BLE_CfgErValue[0], a_BLE_CfgErValueDefault,16);
      p_er_value = (const uint8_t *)a_BLE_CfgErValue;
    }
  }

  /* USER CODE BEGIN BleGenerateERValue_3 */

  /* USER CODE END BleGenerateERValue_3 */
  return p_er_value;
}

[/#if]


static void BleStack_Process_BG(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  if (BleStack_Process( ) == 0x0)
  {
    BleStackCB_Process( );
  }
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  uint8_t running = 0x0;

  tx_mutex_get(&LinkLayerMutex, TX_WAIT_FOREVER);
  running = BleStack_Process( );
  tx_mutex_put(&LinkLayerMutex);
  if (running == 0x0)
  {
    BleStackCB_Process( );
  }
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
  uint8_t running = 0x0;

  osMutexAcquire(LinkLayerMutex, osWaitForever);
  running = BleStack_Process( );
  osMutexRelease(LinkLayerMutex);
  if (running == 0x0)
  {
    BleStackCB_Process( );
  }
[/#if]
}

[#if (((myHash["BLE_MODE_PERIPHERAL"] == "Enabled") && (myHash["NUMBER_OF_SERVICES"] != "0")) || (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
static void gap_cmd_resp_release(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetEvt(1U << CFG_IDLEEVT_PROC_GAP_COMPLETE);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_put(&GapProcCompleteSemaphore);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
  osSemaphoreRelease(GapProcCompleteSemaphore);
[/#if]
  return;
}

static void gap_cmd_resp_wait(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_WaitEvt(1U << CFG_IDLEEVT_PROC_GAP_COMPLETE);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
  tx_semaphore_get(&GapProcCompleteSemaphore, TX_WAIT_FOREVER);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
  osSemaphoreAcquire(GapProcCompleteSemaphore, osWaitForever);
[/#if]
  return;
}

[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled") && (myHash["CFG_MM_TYPE"]?number == 2)]
/**
  * @brief  Notify the LL to resume the flow process
  * @param  None
  * @retval None
  */
static void BLE_ResumeFlowProcessCallback(void)
{
  /* Receive any events from the LL. */
  change_state_options_t notify_options;

  notify_options.combined_value = 0x0F;

  ll_intf_chng_evnt_hndlr_state( notify_options );
}

[/#if]
[#if ((myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled") && (myHash["USE_SNVMA_NVM"]?number != 0) )]
static void BLE_NvmCallback (SNVMA_Callback_Status_t CbkStatus)
{
  if (CbkStatus != SNVMA_OPERATION_COMPLETE)
  {
    /* Retry the write operation */
    SNVMA_Write (APP_BLE_NvmBuffer,
                 BLE_NvmCallback);
  }
}

[/#if]
[#if ((myHash["BLE_OPTIONS_ENHANCED_ATT"] == "BLE_OPTIONS_ENHANCED_ATT") && (myHash["BLE_MODE_CENTRAL"] == "Enabled"))]
void COC_EATT_CENTRAL_APP_Notification(COC_EATT_APP_ConnHandle_Not_evt_t *pNotification)
{
  tBleStatus        ret = BLE_STATUS_INVALID_PARAMS;

  switch(pNotification->CoC_EATT_Evt_Opcode)
  {    
  case BLE_CONN_HANDLE_EVT :    
    BleCoC_EATTContextCentral.Conn_Handle = pNotification->ConnectionHandle;
    BleCoC_EATTContextCentral.connectionstatus = APP_BLE_CONNECTED_CLIENT;
    
    break;
  
  case BLE_CONN_UPDATE_EVT:
    
  case BLE_PAIRING_COMPLETE_EVT:
    
    BleCoC_EATTContextCentral.SPSM = 0x0027;
    BleCoC_EATTContextCentral.Max_Transmission_Unit = DATA_NOTIFICATION_MAX_PACKET_SIZE; //0x0023;
    BleCoC_EATTContextCentral.Max_Payload_Size = CFG_BLE_COC_MPS_MAX;
    BleCoC_EATTContextCentral.Initial_Credits = 0x0003;
    BleCoC_EATTContextCentral.Channel_Number = 0x02;
     
    /* USER CODE BEGIN BLE_PAIRING_COMPLETE_EVT_1 */

    /* USER CODE END BLE_PAIRING_COMPLETE_EVT_1 */

    LOG_INFO_APP("==>> Start Connection Oriented Channel\n");
    ret = aci_l2cap_coc_connect(BleCoC_EATTContextCentral.Conn_Handle, 
                                  BleCoC_EATTContextCentral.SPSM, 
                                  BleCoC_EATTContextCentral.Max_Transmission_Unit, 
                                  BleCoC_EATTContextCentral.Max_Payload_Size, 
                                  BleCoC_EATTContextCentral.Initial_Credits, 
                                  BleCoC_EATTContextCentral.Channel_Number);
    if (ret != BLE_STATUS_SUCCESS)
    {
      LOG_INFO_APP("  Fail   : aci_l2cap_coc_connect command, result: 0x%02X\n", ret);
    }
    else
    {
      LOG_INFO_APP("  Success: aci_l2cap_coc_connect command\n");
    }
    /* USER CODE BEGIN BLE_PAIRING_COMPLETE_EVT_2 */

    /* USER CODE END BLE_PAIRING_COMPLETE_EVT_2 */
    break;

    case BLE_DISCON_HANDLE_EVT :
      {
        BleCoC_EATTContextCentral.connectionstatus = APP_BLE_IDLE;
        BSP_LED_Off(LED_BLUE); 
      }
      break;

    default:
      break;
  }
  return;
}

[/#if]
/* USER CODE BEGIN FD_LOCAL_FUNCTION */
[#if PG_FILL_UCS == "True"]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
static void TM_SetLowPowerMode(void)
{
  if(LowPowerModeStatus == LOW_POWER_MODE_DISABLE)
  {
    BSP_LED_Off(LED_GREEN);
    LowPowerModeStatus = LOW_POWER_MODE_ENABLE;
    UTIL_LPM_SetStopMode(1<<CFG_LPM_APP_BLE, UTIL_LPM_ENABLE);
  }
  else
  {
    BSP_LED_On(LED_GREEN);
    LowPowerModeStatus = LOW_POWER_MODE_DISABLE;
    UTIL_LPM_SetStopMode(1<<CFG_LPM_APP_BLE, UTIL_LPM_DISABLE);
  }
  return;
}
[/#if]
[/#if]

/* USER CODE END FD_LOCAL_FUNCTION */

/*************************************************************
 *
 * WRAP FUNCTIONS
 *
 *************************************************************/

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart)
{
  UNUSED(huart);
  TM_UART_RxComplete(readBusBuffer);
}

void HAL_UART_TxCpltCallback(UART_HandleTypeDef *huart)
{
  TM_UART_TxComplete(writeBusBuffer);
}
[/#if]

tBleStatus BLECB_Indication( const uint8_t* data,
                          uint16_t length,
                          const uint8_t* ext_data,
                          uint16_t ext_length )
{
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled")]
  uint8_t status = BLE_STATUS_FAILED;
  BleEvtPacket_t *phcievt = NULL;
  uint16_t total_length = (length+ext_length);

  UNUSED(ext_data);

  if (data[0] == HCI_EVENT_PKT_TYPE)
  {
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
    APP_BLE_ResumeFlowProcessCb.Callback = BLE_ResumeFlowProcessCallback;
    if (AMM_Alloc (CFG_AMM_VIRTUAL_APP_BLE,
                   DIVC((sizeof(BleEvtPacketHeader_t) + total_length), sizeof (uint32_t)),
                   (uint32_t **)&phcievt,
                   &APP_BLE_ResumeFlowProcessCb) != AMM_ERROR_OK)
[#else]
    phcievt = (BleEvtPacket_t *)malloc(sizeof(BleEvtPacketHeader_t) + total_length);
    if(phcievt == NULL)
[/#if]
    {
      LOG_INFO_APP("Alloc failed\n");
      status = BLE_STATUS_FAILED;
    }
    else if (phcievt != (BleEvtPacket_t *)0 )
    {
      phcievt->evtserial.type = HCI_EVENT_PKT_TYPE;
      phcievt->evtserial.evt.evtcode = data[1];
      phcievt->evtserial.evt.plen  = data[2];
      MEMCPY( (void*)&phcievt->evtserial.evt.payload, &data[3], data[2]);
      LST_insert_tail(&BleAsynchEventQueue, (tListNode *)phcievt);
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
      UTIL_SEQ_SetTask(1U << CFG_TASK_HCI_ASYNCH_EVT_ID, CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
      tx_semaphore_put(&HciAsyncEvtSemaphore);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
      osSemaphoreRelease(HciAsyncEvtSemaphore);
[/#if]
      status = BLE_STATUS_SUCCESS;
    }
  }
  else if (data[0] == HCI_ACLDATA_PKT_TYPE)
  {
    status = BLE_STATUS_SUCCESS;
  }
[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
  uint8_t status;
  uint8_t bufferHci[HCI_DATA_MAX_SIZE];

  MEMCPY( &bufferHci[0], data, length);

  if ( ext_length > 255 )
  {
    MEMCPY( &bufferHci[length], ext_data, 254);
    MEMCPY( &bufferHci[length + 254], ext_data + 254, ext_length - 254 );
  }
  else
  {
    MEMCPY( &bufferHci[length], ext_data, ext_length );
  }

  if (bufferHci[1] == 0xFF) /* ACI events */
  {
    status = HCI_UartSend(&bufferHci[0], HCI_EVENT_SYNCHRO);
  }
  else 
  {
    status = HCI_UartSend(&bufferHci[0], HCI_EVENT_ASYNCHRO);
  }

  if(status == BLE_STATUS_SUCCESS)
  {
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
    UTIL_SEQ_SetTask(1U << CFG_TASK_TX_TO_HOST_ID,CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
    tx_semaphore_put(&TX_TO_HOST_Thread_Sem);
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
[/#if]
  }
  else
  {
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
    UTIL_SEQ_SetTask(1U << CFG_TASK_NOTIFY_EVENT_ID, CFG_SEQ_PRIO_0);
[/#if]
  }
[/#if]
  return status;
}
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
void TM_TxToHost_Entry(ULONG lArgument)
{
  UNUSED(lArgument);

  while(1)
  {
    tx_semaphore_get(&TX_TO_HOST_Thread_Sem, TX_WAIT_FOREVER);
    TM_TxToHost();
  }
}
[#else]
static void BLE_HOST_Task_Entry(ULONG lArgument)
{
  UNUSED(lArgument);

  while(1)
  {
    tx_semaphore_get(&BleHostSemaphore, TX_WAIT_FOREVER);
    BleStack_Process_BG();
    tx_thread_relinquish();
  }
}

static void HciAsyncEvt_Task_Entry(ULONG lArgument)
{
  UNUSED(lArgument);

  while(1)
  {
    tx_semaphore_get(&HciAsyncEvtSemaphore, TX_WAIT_FOREVER);

    Ble_UserEvtRx();

    tx_thread_relinquish();
  }
}
[/#if]
[/#if]

[#if myHash["FREERTOS_STATUS"]?number == 1 ]
static void BLE_HOST_Task_Entry(void* argument)
{
  UNUSED(argument);

  while(1)
  {
    osSemaphoreAcquire(BleHostSemaphore, osWaitForever);
    BleStack_Process_BG();
    osThreadYield();
  }
}

static void HciAsyncEvt_Task_Entry(void* argument)
{
  UNUSED(argument);

  while(1)
  {
    osSemaphoreAcquire(HciAsyncEvtSemaphore, osWaitForever);

    Ble_UserEvtRx();

    osThreadYield();
  }
}
[/#if]

[#if ((myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled") && (myHash["USE_SNVMA_NVM"]?number != 0) )]
void NVMCB_Store( const uint32_t* ptr, uint32_t size )
{
  UNUSED(ptr);
  UNUSED(size);

  /* Call SNVMA for storing - Without callback */
  SNVMA_Write (APP_BLE_NvmBuffer,
               BLE_NvmCallback);
}

[/#if]
/* USER CODE BEGIN FD_WRAP_FUNCTIONS */
[#if PG_FILL_UCS == "True"]
[#if (RF_APPLICATION == "P2PROUTER")]
#if (CFG_BUTTON_SUPPORTED == 1)
void APPE_Button1Action(void)
{
  BSP_LED_On(LED_BLUE);
  APP_BLE_Procedure_Gap_Central(PROC_GAP_CENTRAL_SCAN_START);
  return;
}
#endif
[/#if]
[/#if]

/* USER CODE END FD_WRAP_FUNCTIONS */
