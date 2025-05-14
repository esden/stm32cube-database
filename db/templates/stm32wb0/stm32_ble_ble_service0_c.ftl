[#ftl]
[#assign SvcNbr = "0"]
[#assign myHash = {}]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if SvcNbr == "0"]
                [#assign SvcNbr = definition.name?remove_beginning("SERVICE")]
            [/#if]
            [#assign myHash = {definition.name:definition.value} + myHash]
        [/#list]
    [/#if]
[/#list]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${myHash["SERVICE"+SvcNbr+"_SHORT_NAME"]}.c
  * @author  MCD Application Team
  * @brief   ${myHash["SERVICE"+SvcNbr+"_SHORT_NAME"]} definition.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign SERVICE_SHORT_NAME = ""]
[#assign SERVICE_LONG_NAME = ""]
[#assign SERVICE_UUID_TYPE = ""]
[#assign SERVICE_SHORT_NAME_UpperCase = ""]
[#assign SERVICE_CHAR_PROP_NONE = ""]
[#assign SERVICE_CHAR_ATTR_PERMISSION_NONE = ""]
[#assign SERVICE_CHAR_GATT_DONT_NOTIFY_EVENTS = ""]
[#assign SERVICE_UUID_TYPE = myHash["SERVICE"+SvcNbr+"_UUID_TYPE"]]
[#assign SERVICE_NUMBER_OF_CHARACTERISTICS = myHash["SERVICE"+SvcNbr+"_NUMBER_OF_CHARACTERISTICS"]]
[#assign SERVICE_SHORT_NAME = myHash["SERVICE"+SvcNbr+"_SHORT_NAME"]]
[#assign SERVICE_LONG_NAME = myHash["SERVICE"+SvcNbr+"_LONG_NAME"]]
[#assign SERVICE_SHORT_NAME_UpperCase = myHash["SERVICE"+SvcNbr+"_SHORT_NAME"]?upper_case]
[#assign SERVICE_LONG_NAME_UpperCase = myHash["SERVICE"+SvcNbr+"_LONG_NAME"]?upper_case]
[#assign SERVICE_CHAR_PROP_NONE = myHash["SERVICE_CHAR_PROP_NONE"]]
[#assign SERVICE_CHAR_ATTR_PERMISSION_NONE = myHash["SERVICE_CHAR_ATTR_PERMISSION_NONE"]]
[#assign SERVICE_CHAR_GATT_DONT_NOTIFY_EVENTS = myHash["SERVICE_CHAR_GATT_DONT_NOTIFY_EVENTS"]]
[#assign item = 0]
[#assign item_NAME_START = item]
[#assign item_SHORT_NAME = item][#assign item = item + 1]
[#assign item_NAME_END = item]

[#assign SERVICES_CHARS_NAMES = {} /]
[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
  [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as i]
    [#--  ${i} --]
    [#assign SERVICES_CHARS_NAMES = SERVICES_CHARS_NAMES + {i?string: [myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_SHORT_NAME"]]}/]
  [/#list]
[/#if]
[#assign SERVICES_CHARS_LONG_NAMES = {} /]
[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
  [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as i]
    [#--  ${i} --]
    [#assign SERVICES_CHARS_LONG_NAMES = SERVICES_CHARS_LONG_NAMES + {i?string: [myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_LONG_NAME"]]}/]
  [/#list]
[/#if]

[#assign item = 0]
[#assign item_UUID_TYPE = item][#assign item = item + 1]
[#assign item_UUID = item][#assign item = item + 1]
[#assign item_UUID_128_INPUT_TYPE = item][#assign item = item + 1]
[#assign item_TYPE = item][#assign item = item + 1]
[#assign item_MAX_ATTRIBUTES_RECORDS = item]

[#assign SERVICES_CHARS_INFO = {} /]
[#assign SERVICES_CHARS_VALUE_OFFSET = {} /]
[#assign SERVICES_CHARS_VALUE_LENGTH = {} /]
[#assign SERVICES_CHARS_LENGTH_CHARACTERISTIC = {} /]
[#assign SERVICES_CHARS_ENCRY_KEY_SIZE = {} /]

[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
  [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as i]
    [#assign SERVICES_CHARS_INFO = SERVICES_CHARS_INFO + {i?string: [myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_UUID_TYPE"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_UUID"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_UUID_128_INPUT_TYPE"]]}/]
    [#assign SERVICES_CHARS_VALUE_OFFSET = SERVICES_CHARS_VALUE_OFFSET + {i?string: myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_VALUE_OFFSET"]}/]
    [#assign SERVICES_CHARS_VALUE_LENGTH = SERVICES_CHARS_VALUE_LENGTH + {i?string: myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_VALUE_LENGTH"]}/]
    [#assign SERVICES_CHARS_LENGTH_CHARACTERISTIC = SERVICES_CHARS_LENGTH_CHARACTERISTIC + {i?string: myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_LENGTH_CHARACTERISTIC"]}/]
    [#assign SERVICES_CHARS_ENCRY_KEY_SIZE = SERVICES_CHARS_ENCRY_KEY_SIZE + {i?string: myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_ENCRY_KEY_SIZE"]}/]
  [/#list]
[/#if]

[#assign item = 0]
[#assign item_PROP_START = item]
[#assign item_PROP_BROADCAST = item][#assign item = item + 1]
[#assign item_PROP_READ = item][#assign item = item + 1]
[#assign item_PROP_WRITE_NO_RESP = item][#assign item = item + 1]
[#assign item_PROP_WRITE = item][#assign item = item + 1]
[#assign item_PROP_NOTIFY = item][#assign item = item + 1]
[#assign item_PROP_INDICATE = item]
[#assign item_PROP_END = item]

[#assign SERVICES_CHARS_PROP = {} /]
[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
  [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as i]
    [#assign SERVICES_CHARS_PROP = SERVICES_CHARS_PROP + {i?string: [myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_BROADCAST"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_READ"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_WRITE_NO_RESP"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_WRITE"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_NOTIFY"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_INDICATE"]]}/]
  [/#list]
[/#if]

[#assign item = 0]
[#assign item_ATTR_PERM_START = item]
[#-- assign item_ATTR_PERM_NONE = item][#assign item = item + 1--]
[#assign item_ATTR_PERM_AUTHEN_READ = item][#assign item = item + 1]
[#--[#assign item_ATTR_PERM_AUTHOR_READ = item][#assign item = item + 1]1--]
[#assign item_ATTR_PERM_ENCRY_READ = item][#assign item = item + 1]
[#assign item_ATTR_PERM_AUTHEN_WRITE = item][#assign item = item + 1]
[#--[#assign item_ATTR_PERM_AUTHOR_WRITE = item][#assign item = item + 1]1--]
[#assign item_ATTR_PERM_ENCRY_WRITE = item]
[#assign item_ATTR_PERM_END = item]

[#assign SERVICES_CHARS_ATTR_PERM = {} /]
[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
  [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as i]
    [#assign SERVICES_CHARS_ATTR_PERM = SERVICES_CHARS_ATTR_PERM + {i?string: [myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_ATTR_PERMISSION_AUTHEN_READ"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_ATTR_PERMISSION_ENCRY_READ"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_ATTR_PERMISSION_AUTHEN_WRITE"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_ATTR_PERMISSION_ENCRY_WRITE"]]}/]
[#--    [#assign SERVICES_CHARS_ATTR_PERM = SERVICES_CHARS_ATTR_PERM + {i?string: [myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_ATTR_PERMISSION_AUTHEN_READ"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_ATTR_PERMISSION_AUTHOR_READ"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_ATTR_PERMISSION_ENCRY_READ"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_ATTR_PERMISSION_AUTHEN_WRITE"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_ATTR_PERMISSION_AUTHOR_WRITE"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_ATTR_PERMISSION_ENCRY_WRITE"]]}/]1--]
  [/#list]
[/#if]

[#assign item = 0]
[#assign item_GATT_NOTIFY_START = item]
[#-- assign item_GATT_DONT_NOTIFY = item][#assign item = item + 1--]
[#assign item_GATT_NOTIFY_ATTR_WRITE = item][#assign item = item + 1]
[#assign item_GATT_NOTIFY_WRITE_REQ_AND_WAIT_FOR_APPL_RESP = item][#assign item = item + 1]
[#assign item_GATT_NOTIFY_READ_REQ_AND_WAIT_FOR_APPL_RESP = item][#assign item = item + 1]
[#assign item_GATT_NOTIFY_NOTIFICATION_COMPLETION = item][#assign item = item + 1]
[#assign item_GATT_NOTIFY_END = item]

[#assign SERVICES_CHARS_GATT_NOTIFY = {} /]
[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
  [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as i]
    [#assign SERVICES_CHARS_GATT_NOTIFY = SERVICES_CHARS_GATT_NOTIFY + {i?string: [myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_GATT_NOTIFY_ATTRIBUTE_WRITE"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_GATT_NOTIFY_WRITE_REQ_AND_WAIT_FOR_APPL_RESP"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_GATT_NOTIFY_READ_REQ_AND_WAIT_FOR_APPL_RESP"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_GATT_NOTIFY_NOTIFICATION_COMPLETION"]]}/]
  [/#list]
[/#if]

[#assign item = 0]
[#assign item_CHAR_PROP_NOTIFY_INDICATE_START = item]
[#-- assign item_GATT_DONT_NOTIFY = item][#assign item = item + 1--]
[#assign item_CHAR_PROP_NOTIFY = item][#assign item = item + 1]
[#assign item_CHAR_PROP_INDICATE = item][#assign item = item + 1]
[#assign item_CHAR_PROP_NOTIFY_INDICATE_END = item]

[#assign SERVICES_CHARS_PROP_NOTIFY_INDICATE = {} /]
[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
  [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as i]
    [#assign SERVICES_CHARS_PROP_NOTIFY_INDICATE = SERVICES_CHARS_PROP_NOTIFY_INDICATE + {i?string: [myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_NOTIFY"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_INDICATE"]]}/]
  [/#list]
[/#if]

[#assign IS_ATTRIBUTE = 0]
[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
  [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
    [#if (((SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_NO_RESP]??  &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_NO_RESP] != " ") ||
        (SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE]??  &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE] != " ")) &&
        SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_ATTR_WRITE]??  &&
        SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_ATTR_WRITE] != " ")
        ||
        ((SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY]??  &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY] != " ") ||
        (SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE]??  &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE] != " "))]
[#assign IS_ATTRIBUTE = 1]
    [/#if]
  [/#list]
[/#if]

[#assign IS_WRITE = 0]
[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
  [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
    [#if (((SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_NO_RESP]??  &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_NO_RESP] != " ") ||
        (SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE]??  &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE] != " ")) &&
        SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_WRITE_REQ_AND_WAIT_FOR_APPL_RESP]??  &&
        SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_WRITE_REQ_AND_WAIT_FOR_APPL_RESP] != " ")]
[#assign IS_WRITE = 1]
    [/#if]
  [/#list]
[/#if]

[#assign IS_READ = 0]
[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
  [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
    [#if (SERVICES_CHARS_PROP[characteristic?string][item_PROP_READ]??  &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_READ] != " " &&
        SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_READ_REQ_AND_WAIT_FOR_APPL_RESP]??  &&
        SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_READ_REQ_AND_WAIT_FOR_APPL_RESP] != " ")]
[#assign IS_READ = 1]
    [/#if]
  [/#list]
[/#if]

[#macro characteristicShortName characteristic]
    ${SERVICES_CHARS_NAMES[characteristic?string][item_SHORT_NAME]?upper_case}[#t]
[/#macro]

[#macro characteristicShortNameLow characteristic]
    ${SERVICES_CHARS_NAMES[characteristic?string][item_SHORT_NAME]?lower_case}[#t]
[/#macro]

[#macro characteristicLongName characteristic]
    ${SERVICES_CHARS_LONG_NAMES[characteristic?string][item_SHORT_NAME]?upper_case}[#t]
[/#macro]

[#macro characteristicLongNameLow characteristic]
    ${SERVICES_CHARS_LONG_NAMES[characteristic?string][item_SHORT_NAME]?lower_case}[#t]
[/#macro]

[#macro capitalizeWords words]
    [#list words as word]
        ${word?capitalize}[#t]
    [/#list]
[/#macro]

[#macro characteristicShortNameCapitalized characteristic]
    [@capitalizeWords SERVICES_CHARS_NAMES[characteristic?string][item_SHORT_NAME]?matches(r"[a-zA-Z]+\d*[^a-zA-Z]*")/]
[/#macro]

[#macro copyServChar characteristic]
    ${SERVICES_CHARS_NAMES[characteristic?string][item_SHORT_NAME]?upper_case}[#t]
[/#macro]

[#macro customServChar characteristic]
    ${SERVICE_SHORT_NAME_UpperCase}_${SERVICES_CHARS_NAMES[characteristic?string][item_SHORT_NAME]?upper_case}[#t]
[/#macro]
/* Includes ------------------------------------------------------------------*/
[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled")]
#include <app_common.h>
[#else]
#include "app_common.h"
[/#if]
#include "ble.h"
[#if SERVICE_SHORT_NAME != ""]
#include "${SERVICE_SHORT_NAME?lower_case}.h"
#include "${SERVICE_SHORT_NAME?lower_case}_app.h"
[/#if]
#include "ble_evt.h"
    
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/

/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

typedef struct{
  uint16_t  ${SERVICE_SHORT_NAME?capitalize}SvcHdle;				/**< ${SERVICE_SHORT_NAME?capitalize} Service Handle */
[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
  uint16_t  [@characteristicShortNameCapitalized characteristic/]CharHdle;			/**< [@characteristicShortName characteristic/] Characteristic Handle */
[/#list]
/* USER CODE BEGIN Context */
  /* Place holder for Characteristic Descriptors Handle*/

/* USER CODE END Context */
[/#if]
}${SERVICE_SHORT_NAME_UpperCase}_Context_t;

/* Private defines -----------------------------------------------------------*/

/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* External variables --------------------------------------------------------*/

/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private macros ------------------------------------------------------------*/
#define CHARACTERISTIC_DESCRIPTOR_ATTRIBUTE_OFFSET        2
#define CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET             1
[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
  [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
#define [@characteristicShortName characteristic/]_SIZE        ${SERVICES_CHARS_VALUE_LENGTH[characteristic?string]}	/* ${SERVICES_CHARS_LONG_NAMES[characteristic?string][item_SHORT_NAME]?replace("_"," ")} Characteristic size */
  [/#list]
[/#if]
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

static ${SERVICE_SHORT_NAME_UpperCase}_Context_t ${SERVICE_SHORT_NAME_UpperCase}_Context;

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Functions Definition ------------------------------------------------------*/
/* USER CODE BEGIN PFD */

/* USER CODE END PFD */

/* Private functions ----------------------------------------------------------*/

/*
 * UUIDs for ${SERVICE_LONG_NAME?replace("_"," ")} service
 */
[#if myHash["SERVICE"+SvcNbr+"_UUID_TYPE"] == "0x02"]
    [#if myHash["SERVICE"+SvcNbr+"_UUID_128_INPUT_TYPE"] == "1"]
#define ${SERVICE_SHORT_NAME_UpperCase}_UUID			0x${myHash["SERVICE"+SvcNbr+"_UUID"]?lower_case?replace(" ",",0x")}
    [#else]
#define ${SERVICE_SHORT_NAME_UpperCase}_UUID			(0x${myHash["SERVICE"+SvcNbr+"_UUID"]?lower_case?replace(" ","")})
   [/#if]
[/#if]
[#if myHash["SERVICE"+SvcNbr+"_UUID_TYPE"] == "0x01"]
    [#if myHash["SERVICE"+SvcNbr+"_UUID_ALLOCATION_TYPE"] == "SIG"]
#define ${SERVICE_LONG_NAME_UpperCase}_UUID			(0x${myHash["SERVICE"+SvcNbr+"_UUID"]?replace(" ","")})
    [#else]
#define ${SERVICE_SHORT_NAME_UpperCase}_UUID			(0x${myHash["SERVICE"+SvcNbr+"_UUID"]?lower_case?replace(" ","")})
     [/#if]
[/#if]
[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
	[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
		[#if myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_UUID_TYPE"] == "0x02"]
			[#if myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_UUID_128_INPUT_TYPE"] == "0"]
#define [@characteristicShortName characteristic/]_UUID			0x${myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_UUID"]?lower_case?replace(" ",",0x")},0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
			[#else]
#define [@characteristicShortName characteristic/]_UUID			0x${myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_UUID"]?lower_case?replace(" ",",0x")}
			[/#if]
		[/#if]
		[#if myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_UUID_TYPE"] == "0x01"]
			[#if myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_UUID_ALLOCATION_TYPE"] == "SIG"]
#define [@characteristicLongName characteristic/]_UUID			(${myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_UUID"]})
			[#else]
#define [@characteristicShortName characteristic/]_UUID			(0x${myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_UUID"]?lower_case?replace(" ","")})
			[/#if]
		[/#if]
		[#assign char_prop_list = ""]
		[#list item_CHAR_PROP_NOTIFY_INDICATE_START..item_CHAR_PROP_NOTIFY_INDICATE_END as item]
			[#if SERVICES_CHARS_PROP_NOTIFY_INDICATE[characteristic?string][item]??]
				[#if SERVICES_CHARS_PROP_NOTIFY_INDICATE[characteristic?string][item] != " " && char_prop_list != ""]
					[#assign char_prop_list = char_prop_list + " | "]
				[/#if]
				[#if SERVICES_CHARS_PROP_NOTIFY_INDICATE[characteristic?string][item] != " "]
					[#assign char_prop_list = char_prop_list + SERVICES_CHARS_PROP_NOTIFY_INDICATE[characteristic?string][item]]
				[/#if]
			[/#if]
		[/#list]
	[/#list]
[/#if]

[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
    [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
        [#if (myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_PROP_NOTIFY"] == "BLE_GATT_SRV_CHAR_PROP_NOTIFY") || (myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_PROP_INDICATE"] == "BLE_GATT_SRV_CHAR_PROP_INDICATE") ]
BLE_GATT_SRV_CCCD_DECLARE([@characteristicShortNameLow characteristic/], CFG_BLE_NUM_RADIO_TASKS, BLE_GATT_SRV_CCCD_PERM_DEFAULT,
                          BLE_GATT_SRV_OP_MODIFIED_EVT_ENABLE_FLAG);
        [/#if]
    [/#list]
[/#if]

[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
[#if myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_CHARACTERISTIC_TYPE"] == "Buffered"]

uint8_t [@characteristicShortNameLow characteristic/]_val_buffer[[@characteristicShortName characteristic/]_SIZE];

static ble_gatt_val_buffer_def_t [@characteristicShortNameLow characteristic/]_val_buffer_def = {
  .op_flags = BLE_GATT_SRV_OP_MODIFIED_EVT_ENABLE_FLAG[#if myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_LENGTH_CHARACTERISTIC"] == "CHAR_VALUE_LEN_VARIABLE"] | BLE_GATT_SRV_OP_VALUE_VAR_LENGTH_FLAG[/#if],
  .val_len = [@characteristicShortName characteristic/]_SIZE,
  .buffer_len = sizeof([@characteristicShortNameLow characteristic/]_val_buffer),
  .buffer_p = [@characteristicShortNameLow characteristic/]_val_buffer
};
[/#if]
[/#list]
[/#if]

/* ${SERVICE_LONG_NAME?replace("_"," ")} service[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"][#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic][#if myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_PROP_WRITE_NO_RESP"] =="BLE_GATT_SRV_CHAR_PROP_WRITE_NO_RESP"] [@characteristicShortName characteristic/] (write without response),[/#if][#if myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_PROP_NOTIFY"] =="BLE_GATT_SRV_CHAR_PROP_NOTIFY"] [@characteristicShortName characteristic/] (notification)[/#if][/#list][/#if] characteristics definition */
static const ble_gatt_chr_def_t ${SERVICE_SHORT_NAME?lower_case}_chars[] = {
	[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
      [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
          [#-- prop_list definition --]
          [#assign prop_list = ""]
          [#list item_PROP_START..item_PROP_END as item]
              [#if SERVICES_CHARS_PROP[characteristic?string][item]??]
                  [#if SERVICES_CHARS_PROP[characteristic?string][item] != " "]
                      [#if prop_list != ""]
                          [#assign prop_list = prop_list + " | " + SERVICES_CHARS_PROP[characteristic?string][item]]
                      [/#if]
                      [#if prop_list == ""]
                        [#assign prop_list = prop_list + SERVICES_CHARS_PROP[characteristic?string][item]]
                      [/#if]
                  [/#if]
              [/#if]
          [/#list]
          [#if prop_list == ""]
              [#assign prop_list = myHash["SERVICE_CHAR_PROP_NONE"]]
          [/#if]
		   [#-- attr_perm_list definition --]
          [#assign attr_perm_list = ""]
          [#list item_ATTR_PERM_START..item_ATTR_PERM_END as item]
              [#if SERVICES_CHARS_ATTR_PERM[characteristic?string][item]??]
                  [#if SERVICES_CHARS_ATTR_PERM[characteristic?string][item] != " " && attr_perm_list != ""]
                      [#assign attr_perm_list = attr_perm_list + " | "]
                  [/#if]
                  [#if SERVICES_CHARS_ATTR_PERM[characteristic?string][item] != " "]
                      [#assign attr_perm_list = attr_perm_list + SERVICES_CHARS_ATTR_PERM[characteristic?string][item]]
                  [/#if]
              [/#if]
          [/#list]
          [#if attr_perm_list == ""]
              [#assign attr_perm_list = myHash["SERVICE_CHAR_ATTR_PERMISSION_NONE"]]
          [/#if]
		  [#-- gatt_notify_list definition --]
          [#assign gatt_notify_list = ""]
          [#list item_GATT_NOTIFY_START..item_GATT_NOTIFY_END as item]
              [#if SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item]??]
                  [#if SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item] != " " && gatt_notify_list != ""]
                      [#assign gatt_notify_list = gatt_notify_list + " | "]
                  [/#if]
                  [#if SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item] != " "]
                      [#assign gatt_notify_list = gatt_notify_list + SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item]]
                  [/#if]
              [/#if]
          [/#list]
          [#if gatt_notify_list == ""]
              [#assign gatt_notify_list = myHash["SERVICE_CHAR_GATT_DONT_NOTIFY_EVENTS"]]
          [/#if]
		  [#if SERVICES_CHARS_INFO[characteristic?string][item_UUID_TYPE] == "0x01"]
              [#assign UUID_TYPE = "BLE_UUID_INIT_16"]
          [/#if]
          [#if SERVICES_CHARS_INFO[characteristic?string][item_UUID_TYPE] == "0x02"]
              [#assign UUID_TYPE = "BLE_UUID_INIT_128"]
          [/#if]
	{
        .properties = ${prop_list},
        .permissions = ${attr_perm_list},
        .min_key_size = ${SERVICES_CHARS_ENCRY_KEY_SIZE[characteristic?string]},
		[#if myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_UUID_TYPE"] == "0x01"]
		     [#if myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_UUID_ALLOCATION_TYPE"] == "SIG"]
        .uuid = ${UUID_TYPE}([@characteristicLongName characteristic/]_UUID),
		     [#else]
        .uuid = ${UUID_TYPE}([@characteristicShortName characteristic/]_UUID),
		     [/#if]
        [/#if]
		[#if myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_UUID_TYPE"] == "0x02"]
        .uuid = ${UUID_TYPE}([@characteristicShortName characteristic/]_UUID),
		[/#if]
	        [#if ((myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_PROP_NOTIFY"] == "BLE_GATT_SRV_CHAR_PROP_NOTIFY") && (myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_PROP_INDICATE"] != "BLE_GATT_SRV_CHAR_PROP_INDICATE")) || ((myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_PROP_NOTIFY"] != "BLE_GATT_SRV_CHAR_PROP_NOTIFY") && (myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_PROP_INDICATE"] == "BLE_GATT_SRV_CHAR_PROP_INDICATE"))]
        .descrs = {
            .descrs_p = &BLE_GATT_SRV_CCCD_DEF_NAME([@characteristicShortNameLow characteristic/]),
            .descr_count = 1U,
        },
           [/#if]
		[#if myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_CHARACTERISTIC_TYPE"] == "Buffered"]
        .val_buffer_p = &[@characteristicShortNameLow characteristic/]_val_buffer_def
		[/#if]
    },
	[/#list]
    [/#if]
};

/* ${SERVICE_LONG_NAME?replace("_"," ")} service definition */
static const ble_gatt_srv_def_t ${SERVICE_SHORT_NAME?lower_case}_service = {
	[#if SERVICE_UUID_TYPE == "0x01"]
       [#assign UUID_TYPE = "BLE_UUID_INIT_16"]
    [/#if]
    [#if SERVICE_UUID_TYPE == "0x02"]
       [#assign UUID_TYPE = "BLE_UUID_INIT_128"]
    [/#if]
   .type = BLE_GATT_SRV_PRIMARY_SRV_TYPE,
[#if myHash["SERVICE"+SvcNbr+"_UUID_TYPE"] == "0x01"]
    [#if myHash["SERVICE"+SvcNbr+"_UUID_ALLOCATION_TYPE"] == "SIG"]
   .uuid = ${UUID_TYPE}(${SERVICE_LONG_NAME_UpperCase}_UUID),
    [#else]
   .uuid = ${UUID_TYPE}(${SERVICE_SHORT_NAME_UpperCase}_UUID),
    [/#if]
[/#if]
[#if myHash["SERVICE"+SvcNbr+"_UUID_TYPE"] == "0x02"]
   .uuid = ${UUID_TYPE}(${SERVICE_SHORT_NAME_UpperCase}_UUID),
[/#if]
   .chrs = {
       .chrs_p = (ble_gatt_chr_def_t *)${SERVICE_SHORT_NAME?lower_case}_chars,
       .chr_count = ${SERVICE_NUMBER_OF_CHARACTERISTICS}U,
   },
};

/* USER CODE BEGIN PF */

/* USER CODE END PF */

/**
 * @brief  Event handler
 * @param  p_Event: Address of the buffer holding the p_Event
 * @retval Ack: Return whether the p_Event has been managed or not
 */
static BLEEVT_EvtAckStatus_t ${SERVICE_SHORT_NAME_UpperCase}_EventHandler(aci_blecore_event *p_evt)
{
  BLEEVT_EvtAckStatus_t return_value = BLEEVT_NoAck;
[#if IS_ATTRIBUTE =1]
  aci_gatt_srv_attribute_modified_event_rp0 *p_attribute_modified;
[/#if]
[#if IS_WRITE =1]
  aci_gatt_srv_write_event_rp0   *p_write;
[/#if]
[#if IS_READ =1]
  aci_gatt_srv_read_event_rp0    *p_read;
[/#if]
[#if IS_ATTRIBUTE =1]
  ${SERVICE_SHORT_NAME_UpperCase}_NotificationEvt_t notification;
[/#if]
  /* USER CODE BEGIN Service${SvcNbr}_EventHandler_1 */

  /* USER CODE END Service${SvcNbr}_EventHandler_1 */

  switch(p_evt->ecode)
  {
    case ACI_GATT_SRV_ATTRIBUTE_MODIFIED_VSEVT_CODE:
    {
      /* USER CODE BEGIN EVT_BLUE_GATT_ATTRIBUTE_MODIFIED_BEGIN */

      /* USER CODE END EVT_BLUE_GATT_ATTRIBUTE_MODIFIED_BEGIN */
[#if IS_ATTRIBUTE =1]
      p_attribute_modified = (aci_gatt_srv_attribute_modified_event_rp0*)p_evt->data;
      notification.ConnectionHandle         = p_attribute_modified->Connection_Handle;
      notification.AttributeHandle          = p_attribute_modified->Attr_Handle;
      notification.DataTransfered.Length    = p_attribute_modified->Attr_Data_Length;
      notification.DataTransfered.p_Payload = p_attribute_modified->Attr_Data;
[/#if]
[#assign INDEX = 0]
    [#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
        [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
            [#if (SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY]??  &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY] != " ") &&
                (SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE]?? &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE] != " ")]
              [#if INDEX = 0]
      if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_DESCRIPTOR_ATTRIBUTE_OFFSET))
					[#assign INDEX = INDEX + 1]
			  [#else]
      else if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_DESCRIPTOR_ATTRIBUTE_OFFSET))
		      [/#if]
      {
        return_value = BLEEVT_Ack;
	    /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string} */

        /* USER CODE END Service${SvcNbr}_Char_${characteristic?string} */

        switch(p_attribute_modified->Attr_Data[0])
		{
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_attribute_modified  */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_attribute_modified  */

          /* Disabled Notification and Indication management */
        case (!(BLE_GATT_SRV_CCCD_NOTIFICATION) | !(BLE_GATT_SRV_CCCD_INDICATION)):
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_Disabled_BEGIN  */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_Disabled_BEGIN  */
          notification.EvtOpcode = ${SERVICE_SHORT_NAME_UpperCase}_[@characteristicShortName characteristic/]_NOTIFY_DISABLED_EVT;
          ${SERVICE_SHORT_NAME_UpperCase}_Notification(&notification);
          notification.EvtOpcode = ${SERVICE_SHORT_NAME_UpperCase}_[@characteristicShortName characteristic/]_INDICATE_DISABLED_EVT;
          ${SERVICE_SHORT_NAME_UpperCase}_Notification(&notification);
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_Disabled_END */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_Disabled_END */
          break;

          /* Enabled Notification management */
        case BLE_GATT_SRV_CCCD_NOTIFICATION:
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Notification_BEGIN */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Notification_BEGIN */
          notification.EvtOpcode = ${SERVICE_SHORT_NAME_UpperCase}_[@characteristicShortName characteristic/]_NOTIFY_ENABLED_EVT;
          ${SERVICE_SHORT_NAME_UpperCase}_Notification(&notification);
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Notification_END */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Notification_END */
          break;

          /* Enabled Indication management */
        case BLE_GATT_SRV_CCCD_INDICATION:
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Indication_BEGIN */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Indication_BEGIN */
          notification.EvtOpcode = ${SERVICE_SHORT_NAME_UpperCase}_[@characteristicShortName characteristic/]_INDICATE_ENABLED_EVT;
          ${SERVICE_SHORT_NAME_UpperCase}_Notification(&notification);
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Indication_END */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Indication_END */
          break;

          default:
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_default */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_default */
          break;
        }
      }  /* if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_DESCRIPTOR_ATTRIBUTE_OFFSET))*/

            [/#if]
            [#if (SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY]??  &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY] != " ") &&
                (SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE]?? &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE] == " ")]
              [#if INDEX = 0]
      if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_DESCRIPTOR_ATTRIBUTE_OFFSET))
                [#assign INDEX = INDEX + 1]
              [#else]
      else if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_DESCRIPTOR_ATTRIBUTE_OFFSET))
              [/#if]
      {
        return_value = BLEEVT_Ack;
        /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string} */

        /* USER CODE END Service${SvcNbr}_Char_${characteristic?string} */
        switch(p_attribute_modified->Attr_Data[0])
		{
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_attribute_modified */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_attribute_modified */

          /* Disabled Notification management */
        case (!BLE_GATT_SRV_CCCD_NOTIFICATION):
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_Disabled_BEGIN */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_Disabled_BEGIN */
          notification.EvtOpcode = ${SERVICE_SHORT_NAME_UpperCase}_[@characteristicShortName characteristic/]_NOTIFY_DISABLED_EVT;
          ${SERVICE_SHORT_NAME_UpperCase}_Notification(&notification);
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_Disabled_END */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_Disabled_END */
          break;

          /* Enabled Notification management */
        case BLE_GATT_SRV_CCCD_NOTIFICATION:
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Notification_BEGIN */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Notification_BEGIN */
          notification.EvtOpcode = ${SERVICE_SHORT_NAME_UpperCase}_[@characteristicShortName characteristic/]_NOTIFY_ENABLED_EVT;
          ${SERVICE_SHORT_NAME_UpperCase}_Notification(&notification);
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Notification_END */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Notification_END */
          break;

        default:
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_default */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_default */
          break;
        }
      }  /* if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_DESCRIPTOR_ATTRIBUTE_OFFSET))*/

            [/#if]
            [#if (SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY]??  &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY] == " ") &&
                (SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE]?? &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE] != " ")]
              [#if INDEX = 0]
      if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_DESCRIPTOR_ATTRIBUTE_OFFSET))
                [#assign INDEX = INDEX + 1]
              [#else]
      else if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_DESCRIPTOR_ATTRIBUTE_OFFSET))
              [/#if]
      {
        return_value = BLEEVT_Ack;
        /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string} */

        /* USER CODE END Service${SvcNbr}_Char_${characteristic?string} */

        switch(p_attribute_modified->Attr_Data[0])
		{
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_attribute_modified */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_attribute_modified */

          /* Disabled Indication management */
        case (!BLE_GATT_SRV_CCCD_INDICATION):
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_Disabled_BEGIN */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_Disabled_BEGIN */
          notification.EvtOpcode = ${SERVICE_SHORT_NAME_UpperCase}_[@characteristicShortName characteristic/]_INDICATE_DISABLED_EVT;
          ${SERVICE_SHORT_NAME_UpperCase}_Notification(&notification);
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_Disabled_END */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_Disabled_END */
          break;

          /* Enabled Indication management */
        case BLE_GATT_SRV_CCCD_INDICATION:
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Indication_BEGIN */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Indication_BEGIN */
          notification.EvtOpcode = ${SERVICE_SHORT_NAME_UpperCase}_[@characteristicShortName characteristic/]_INDICATE_ENABLED_EVT;
          ${SERVICE_SHORT_NAME_UpperCase}_Notification(&notification);
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Indication_END */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Indication_END */
          break;

          default:
          /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_default */

          /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_default */
          break;
        }
      }  /* if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortName characteristic/]Hdle + CHARACTERISTIC_DESCRIPTOR_ATTRIBUTE_OFFSET))*/

            [/#if]
        [/#list]
    [/#if]
    [#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
        [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
            [#if (((SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_NO_RESP]??  &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_NO_RESP] != " ") ||
                (SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE]??  &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE] != " ")) &&
                SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_ATTR_WRITE]??  &&
                SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_ATTR_WRITE] != " ")]
              [#if INDEX = 0]
      if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET))
                [#assign INDEX = INDEX + 1]
              [#else]
      else if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET))
              [/#if]
      {
        return_value = BLEEVT_Ack;

            [#if (SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_NO_RESP]??  &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_NO_RESP] != " ")]
        notification.EvtOpcode = ${SERVICE_SHORT_NAME_UpperCase}_[@characteristicShortName characteristic/]_WRITE_NO_RESP_EVT;
            [#else]
        notification.EvtOpcode = ${SERVICE_SHORT_NAME_UpperCase}_[@characteristicShortName characteristic/]_WRITE_EVT;
            [/#if]
        /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_ACI_GATT_ATTRIBUTE_MODIFIED_VSEVT_CODE */

        /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_ACI_GATT_ATTRIBUTE_MODIFIED_VSEVT_CODE */
        ${SERVICE_SHORT_NAME_UpperCase}_Notification(&notification);
      } /* if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET))*/
            [/#if]
        [/#list]
    [/#if]

      /* USER CODE BEGIN EVT_BLUE_GATT_ATTRIBUTE_MODIFIED_END */

      /* USER CODE END EVT_BLUE_GATT_ATTRIBUTE_MODIFIED_END */
      break;/* ACI_GATT_SRV_ATTRIBUTE_MODIFIED_VSEVT_CODE */
    }
    case ACI_GATT_SRV_READ_VSEVT_CODE :
    {
      /* USER CODE BEGIN EVT_BLUE_GATT_SRV_READ_BEGIN */

      /* USER CODE END EVT_BLUE_GATT_SRV_READ_BEGIN */
  [#if IS_READ =1]
      p_read = (aci_gatt_srv_read_event_rp0*)p_evt->data;
  [/#if]
  [#assign INDEX = 0]
  [#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
    [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
        [#if (SERVICES_CHARS_PROP[characteristic?string][item_PROP_READ]??  &&
            SERVICES_CHARS_PROP[characteristic?string][item_PROP_READ] != " " &&
            SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_READ_REQ_AND_WAIT_FOR_APPL_RESP]??  &&
            SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_READ_REQ_AND_WAIT_FOR_APPL_RESP] != " ")]
          [#if INDEX = 0]
	  if(p_read->Attribute_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET))
				[#assign INDEX = INDEX + 1]
			  [#else]
	  else if(p_read->Attribute_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET))
			  [/#if]
	  {
		return_value = BLEEVT_Ack;
		/*USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_ACI_GATT_SRV_READ_VSEVT_CODE_1 */
#warning user shall call aci_gatt_srv_read_resp() function if allowed
		/*USER CODE END Service${SvcNbr}_Char_${characteristic?string}_ACI_GATT_SRV_READ_VSEVT_CODE_1 */

		/*USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_ACI_GATT_SRV_READ_VSEVT_CODE_2 */

		  /*USER CODE END Service${SvcNbr}_Char_${characteristic?string}_ACI_GATT_SRV_READ_VSEVT_CODE_2 */
	  } /* if(p_read->Attribute_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET))*/
        [/#if]
    [/#list]
  [/#if]

      /* USER CODE BEGIN EVT_BLUE_GATT_SRV_READ_END */

      /* USER CODE END EVT_EVT_BLUE_GATT_SRV_READ_END */
      break;/* ACI_GATT_SRV_READ_VSEVT_CODE */
    }
    case ACI_GATT_SRV_WRITE_VSEVT_CODE:
    {
      /* USER CODE BEGIN EVT_BLUE_SRV_GATT_BEGIN */

      /* USER CODE END EVT_BLUE_SRV_GATT_BEGIN */
[#if IS_WRITE =1]
      p_write = (aci_gatt_srv_write_event_rp0*)p_evt->data;
[/#if]
[#assign INDEX = 0]
    [#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
        [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
            [#if (((SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_NO_RESP]??  &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_NO_RESP] != " ") ||
                (SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE]??  &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE] != " ")) &&
                SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_WRITE_REQ_AND_WAIT_FOR_APPL_RESP]??  &&
                SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_WRITE_REQ_AND_WAIT_FOR_APPL_RESP] != " ")]
              [#if INDEX = 0]
      if(p_write->Attribute_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET))
                [#assign INDEX = INDEX + 1]
              [#else]
      else if(p_write->Attribute_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET))
              [/#if]
      {
        return_value = BLEEVT_Ack;
        /*USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_ACI_GATT_SRV_WRITE_VSEVT_CODE */
#warning user shall call aci_gatt_srv_write_resp() function if allowed
        /*USER CODE END Service${SvcNbr}_Char_${characteristic?string}_ACI_GATT_SRV_WRITE_VSEVT_CODE*/
      } /*if(p_write->Attribute_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET))*/

            [/#if]
        [/#list]
    [/#if]

      /* USER CODE BEGIN EVT_BLUE_GATT_SRV_WRITE_END */

      /* USER CODE END EVT_BLUE_GATT_SRV_WRITE_END */
      break;/* ACI_GATT_SRV_WRITE_VSEVT_CODE */
    }
    case ACI_GATT_TX_POOL_AVAILABLE_VSEVT_CODE:
    {
      aci_gatt_tx_pool_available_event_rp0 *p_tx_pool_available_event;
      p_tx_pool_available_event = (aci_gatt_tx_pool_available_event_rp0 *) p_evt->data;
      UNUSED(p_tx_pool_available_event);

      /* USER CODE BEGIN ACI_GATT_TX_POOL_AVAILABLE_VSEVT_CODE */

      /* USER CODE END ACI_GATT_TX_POOL_AVAILABLE_VSEVT_CODE */
      break;/* ACI_GATT_TX_POOL_AVAILABLE_VSEVT_CODE*/
    }
    case ACI_ATT_EXCHANGE_MTU_RESP_VSEVT_CODE:
    {
      aci_att_exchange_mtu_resp_event_rp0 *p_exchange_mtu;
      p_exchange_mtu = (aci_att_exchange_mtu_resp_event_rp0 *)  p_evt->data;
      UNUSED(p_exchange_mtu);

      /* USER CODE BEGIN ACI_ATT_EXCHANGE_MTU_RESP_VSEVT_CODE */

      /* USER CODE END ACI_ATT_EXCHANGE_MTU_RESP_VSEVT_CODE */
      break;/* ACI_ATT_EXCHANGE_MTU_RESP_VSEVT_CODE */
    }
    /* USER CODE BEGIN BLECORE_EVT */

    /* USER CODE END BLECORE_EVT */
  default:
    /* USER CODE BEGIN EVT_DEFAULT */

    /* USER CODE END EVT_DEFAULT */
    break;
  }

  /* USER CODE BEGIN Service${SvcNbr}_EventHandler_2 */

  /* USER CODE END Service${SvcNbr}_EventHandler_2 */

  return(return_value);
}/* end ${SERVICE_SHORT_NAME_UpperCase}_EventHandler */

/* Public functions ----------------------------------------------------------*/

/**
 * @brief  Service initialization
 * @param  None
 * @retval None
 */
void ${SERVICE_SHORT_NAME_UpperCase}_Init(void)
{
  tBleStatus ret = BLE_STATUS_INVALID_PARAMS;
  UNUSED(${SERVICE_SHORT_NAME_UpperCase}_Context);

  /* USER CODE BEGIN InitService${SvcNbr}Svc_1 */

  /* USER CODE END InitService${SvcNbr}Svc_1 */

  /**
   *  Register the event handler to the BLE controller
   */
  BLEEVT_RegisterGattEvtHandler(${SERVICE_SHORT_NAME_UpperCase}_EventHandler);

  ret = aci_gatt_srv_add_service((ble_gatt_srv_def_t *)&${SERVICE_SHORT_NAME?lower_case}_service);

  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_gatt_srv_add_service command: ${SERVICE_SHORT_NAME}, error code: 0x%x \n", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_gatt_srv_add_service command: ${SERVICE_SHORT_NAME} \n");
  }
  [#assign Nbr = 0]

  ${SERVICE_SHORT_NAME_UpperCase}_Context.${SERVICE_SHORT_NAME?capitalize}SvcHdle = aci_gatt_srv_get_service_handle((ble_gatt_srv_def_t *) &${SERVICE_SHORT_NAME?lower_case}_service);
  [#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
   [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
  ${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle = aci_gatt_srv_get_char_decl_handle((ble_gatt_chr_def_t *)&${SERVICE_SHORT_NAME?lower_case}_chars[${Nbr}]);
        [#assign Nbr = Nbr + 1]
    [/#list]
  [/#if]

  /* USER CODE BEGIN InitService1Svc_2 */

  /* USER CODE END InitService1Svc_2 */

  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail registering ${SERVICE_SHORT_NAME} handlers\n");
  }

  return;
}

/**
 * @brief  Characteristic update
 * @param  CharOpcode: Characteristic identifier
 * @param  pData: pointer to the new data to be written in the characteristic
 *
 */
tBleStatus ${SERVICE_SHORT_NAME_UpperCase}_UpdateValue(${SERVICE_SHORT_NAME_UpperCase}_CharOpcode_t CharOpcode, ${SERVICE_SHORT_NAME_UpperCase}_Data_t *pData)
{
  tBleStatus ret = BLE_STATUS_SUCCESS;

  /* USER CODE BEGIN Service${SvcNbr}_App_Update_Char_1 */

  /* USER CODE END Service${SvcNbr}_App_Update_Char_1 */

  switch(CharOpcode)
  {
      [#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
        [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
		  [#if SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY]?? &&
           SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY] == " "]
    case [@customServChar characteristic/]:
			[#if (myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_CHARACTERISTIC_TYPE"] == "Buffered")]
      memcpy([@characteristicShortNameLow characteristic/]_val_buffer, pData->p_Payload, MIN(pData->Length, sizeof([@characteristicShortNameLow characteristic/]_val_buffer)));      
			[/#if]
      /* USER CODE BEGIN Service${SvcNbr}_Char_Value_${characteristic?string}*/

      /* USER CODE END Service${SvcNbr}_Char_Value_${characteristic?string}*/
      break;

        [/#if]
        [/#list]
		[/#if]

    default:
      break;
  }

  /* USER CODE BEGIN Service${SvcNbr}_App_Update_Char_2 */

  /* USER CODE END Service${SvcNbr}_App_Update_Char_2 */

  return ret;
}

/**
 * @brief  Characteristic notification
 * @param  CharOpcode: Characteristic identifier
 * @param  pData: pointer to the data to be notified to the client
 * @param  ConnectionHandle: connection handle identifying the client to be notified.
 *
 */
tBleStatus ${SERVICE_SHORT_NAME_UpperCase}_NotifyValue(${SERVICE_SHORT_NAME_UpperCase}_CharOpcode_t CharOpcode, ${SERVICE_SHORT_NAME_UpperCase}_Data_t *pData, uint16_t ConnectionHandle)
{
  tBleStatus ret = BLE_STATUS_INVALID_PARAMS;
  /* USER CODE BEGIN Service${SvcNbr}_App_Notify_Char_1 */

  /* USER CODE END Service${SvcNbr}_App_Notify_Char_1 */

  switch(CharOpcode)
  {
    [#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
        [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
			[#if SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY]?? && SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY] != " "]
    case [@customServChar characteristic/]:
				[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled") && (myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_CHARACTERISTIC_TYPE"] == "Buffered")]
      memcpy([@characteristicShortNameLow characteristic/]_val_buffer, pData->p_Payload, MIN(pData->Length, sizeof([@characteristicShortNameLow characteristic/]_val_buffer)));      
				[/#if]
      ret = aci_gatt_srv_notify(ConnectionHandle,
                                BLE_GATT_UNENHANCED_ATT_L2CAP_CID,
                                ${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + 1,
                                GATT_NOTIFICATION,
                                pData->Length, /* charValueLen */
                                (uint8_t *)pData->p_Payload);
      if (ret != BLE_STATUS_SUCCESS)
      {
        APP_DBG_MSG("  Fail   : aci_gatt_srv_notify [@characteristicShortName characteristic/] command, error code: 0x%2X\n", ret);
      }
      else
      {
        APP_DBG_MSG("  Success: aci_gatt_srv_notify [@characteristicShortName characteristic/] command\n");
      }
      /* USER CODE BEGIN Service${SvcNbr}_Char_Value_${characteristic?string}*/

      /* USER CODE END Service${SvcNbr}_Char_Value_${characteristic?string}*/
      break;
	  
			[/#if]
			[#if SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY]?? && SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE] != " "]
    case [@customServChar characteristic/]:
				[#if (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")&&(myHash["BLE_MODE_PERIPHERAL_CENTRAL"] == "Disabled") && (myHash["SERVICE"+SvcNbr+"_CHAR"+characteristic+"_CHARACTERISTIC_TYPE"] == "Buffered")]
      memcpy([@characteristicShortNameLow characteristic/]_val_buffer, pData->p_Payload, MIN(pData->Length, sizeof([@characteristicShortNameLow characteristic/]_val_buffer)));      
				[/#if]
      ret = aci_gatt_srv_notify(ConnectionHandle,
                                BLE_GATT_UNENHANCED_ATT_L2CAP_CID,
                                ${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + 1,
                                GATT_INDICATION,
                                pData->Length, /* charValueLen */
                                (uint8_t *)pData->p_Payload);
      if (ret != BLE_STATUS_SUCCESS)
      {
        APP_DBG_MSG("  Fail   : aci_gatt_srv_notify [@characteristicShortName characteristic/] command, error code: 0x%2X\n", ret);
      }
      else
      {
        APP_DBG_MSG("  Success: aci_gatt_srv_notify [@characteristicShortName characteristic/] command\n");
      }
      /* USER CODE BEGIN Service${SvcNbr}_Char_Value_${characteristic?string}*/

      /* USER CODE END Service${SvcNbr}_Char_Value_${characteristic?string}*/
      break;
	  
			[/#if]

		[/#list]
    [/#if]

    default:
      break;
  }

  /* USER CODE BEGIN Service${SvcNbr}_App_Notify_Char_2 */

  /* USER CODE END Service${SvcNbr}_App_Notify_Char_2 */

  return ret;
}
