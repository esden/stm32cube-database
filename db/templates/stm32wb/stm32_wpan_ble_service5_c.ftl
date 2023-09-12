[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name?remove_beginning("App/%")?remove_ending("%.c")}.c
  * @author  MCD Application Team
  * @brief   ${name?remove_beginning("App/%")?remove_ending("%.c")} definition.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign SvcNbr = 5]
[#assign SERVICE_NUMBER_OF_CHARACTERISTICS = 0]
[#assign SERVICE_SHORT_NAME = ""]
[#assign SERVICE_SHORT_NAME_UpperCase = ""]
[#assign SERVICE_CHAR_PROP_NONE = ""]
[#assign SERVICE_CHAR_ATTR_PERMISSION_NONE = ""]
[#assign SERVICE_CHAR_GATT_DONT_NOTIFY_EVENTS = ""]

[#assign myHash = {}]

[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#assign myHash = {definition.name:definition.value} + myHash]
        [/#list]
    [/#if]
[/#list]
[#assign SERVICE_NUMBER_OF_CHARACTERISTICS = myHash["SERVICE"+SvcNbr+"_NUMBER_OF_CHARACTERISTICS"]]
[#assign SERVICE_SHORT_NAME = myHash["SERVICE"+SvcNbr+"_SHORT_NAME"]]
[#assign SERVICE_SHORT_NAME_UpperCase = myHash["SERVICE"+SvcNbr+"_SHORT_NAME"]?upper_case]
[#assign SERVICE_CHAR_PROP_NONE = myHash["SERVICE_CHAR_PROP_NONE"]]
[#assign SERVICE_CHAR_ATTR_PERMISSION_NONE = myHash["SERVICE_CHAR_ATTR_PERMISSION_NONE"]]
[#assign SERVICE_CHAR_GATT_DONT_NOTIFY_EVENTS = myHash["SERVICE_CHAR_GATT_DONT_NOTIFY_EVENTS"]]
[#assign SvcNbr = myHash["SERVICE"+SvcNbr]]

[#--
Key & Value:
[#list myHash?keys as key]
Key: ${key}; Value: "${myHash[key]}"
[/#list]
--]

[#assign item = 0]
[#assign item_NAME_START = item]
[#assign item_LONG_NAME = item][#assign item = item + 1]
[#assign item_SHORT_NAME = item]
[#assign item_NAME_END = item]

[#assign SERVICES_CHARS_NAMES = {} /]
[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as i]
  [#assign SERVICES_CHARS_NAMES = SERVICES_CHARS_NAMES + {i?string: [myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_LONG_NAME"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_SHORT_NAME"]]}/]
[/#list]

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
[#assign SERVICES_CHARS_ENC_KEY_SIZE = {} /]

[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as i]
  [#assign SERVICES_CHARS_INFO = SERVICES_CHARS_INFO + {i?string: [myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_UUID_TYPE"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_UUID"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_UUID_128_INPUT_TYPE"]]}/]
  [#assign SERVICES_CHARS_VALUE_OFFSET = SERVICES_CHARS_VALUE_OFFSET + {i?string: myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_VALUE_OFFSET"]}/]
  [#assign SERVICES_CHARS_VALUE_LENGTH = SERVICES_CHARS_VALUE_LENGTH + {i?string: myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_VALUE_LENGTH"]}/]
  [#assign SERVICES_CHARS_LENGTH_CHARACTERISTIC = SERVICES_CHARS_LENGTH_CHARACTERISTIC + {i?string: myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_LENGTH_CHARACTERISTIC"]}/]
  [#assign SERVICES_CHARS_ENC_KEY_SIZE = SERVICES_CHARS_ENC_KEY_SIZE + {i?string: myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_ENC_KEY_SIZE"]}/]
[/#list]

[#assign item = 0]
[#assign item_PROP_START = item]
[#assign item_PROP_BROADCAST = item][#assign item = item + 1]
[#assign item_PROP_READ = item][#assign item = item + 1]
[#assign item_PROP_WRITE_WITHOUT_RESP = item][#assign item = item + 1]
[#assign item_PROP_WRITE = item][#assign item = item + 1]
[#assign item_PROP_NOTIFY = item][#assign item = item + 1]
[#assign item_PROP_INDICATE = item]
[#assign item_PROP_END = item]

[#assign SERVICES_CHARS_PROP = {} /]
[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as i]
  [#assign SERVICES_CHARS_PROP = SERVICES_CHARS_PROP + {i?string: [myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_BROADCAST"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_READ"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_WRITE_WITHOUT_RESP"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_WRITE"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_NOTIFY"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_INDICATE"]]}/]
[/#list]

[#--
SERVICE_NUMBER_OF_CHARACTERISTICS: ${SERVICE_NUMBER_OF_CHARACTERISTICS}
[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as i]
  Characteristic ${i}:
  [#list item_PROP_START..5 as j]
    Property ${j}:
    ${SERVICES_CHARS_PROP[i?string][j]}
  [/#list]
[/#list]
--]

[#assign item = 0]
[#assign item_ATTR_PERM_START = item]
[#-- assign item_ATTR_PERM_NONE = item][#assign item = item + 1--]
[#assign item_ATTR_PERM_AUTHEN_READ = item][#assign item = item + 1]
[#assign item_ATTR_PERM_AUTHOR_READ = item][#assign item = item + 1]
[#assign item_ATTR_PERM_ENCRY_READ = item][#assign item = item + 1]
[#assign item_ATTR_PERM_AUTHEN_WRITE = item][#assign item = item + 1]
[#assign item_ATTR_PERM_AUTHOR_WRITE = item][#assign item = item + 1]
[#assign item_ATTR_PERM_ENCRY_WRITE = item]
[#assign item_ATTR_PERM_END = item]

[#assign SERVICES_CHARS_ATTR_PERM = {} /]
[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as i]
  [#assign SERVICES_CHARS_ATTR_PERM = SERVICES_CHARS_ATTR_PERM + {i?string: [myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_ATTR_PERMISSION_AUTHEN_READ"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_ATTR_PERMISSION_AUTHOR_READ"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_ATTR_PERMISSION_ENCRY_READ"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_ATTR_PERMISSION_AUTHEN_WRITE"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_ATTR_PERMISSION_AUTHOR_WRITE"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_ATTR_PERMISSION_ENCRY_WRITE"]]}/]
[/#list]

[#assign item = 0]
[#assign item_GATT_NOTIFY_START = item]
[#-- assign item_GATT_DONT_NOTIFY = item][#assign item = item + 1--]
[#assign item_GATT_NOTIFY_ATTR_WRITE = item][#assign item = item + 1]
[#assign item_GATT_NOTIFY_WRITE_REQ_AND_WAIT_FOR_APPL_RESP = item][#assign item = item + 1]
[#assign item_GATT_NOTIFY_READ_REQ_AND_WAIT_FOR_APPL_RESP = item][#assign item = item + 1]
[#assign item_GATT_NOTIFY_END = item]

[#assign SERVICES_CHARS_GATT_NOTIFY = {} /]
[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as i]
  [#assign SERVICES_CHARS_GATT_NOTIFY = SERVICES_CHARS_GATT_NOTIFY + {i?string: [myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_GATT_NOTIFY_ATTRIBUTE_WRITE"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_GATT_NOTIFY_WRITE_REQ_AND_WAIT_FOR_APPL_RESP"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_GATT_NOTIFY_READ_REQ_AND_WAIT_FOR_APPL_RESP"]]}/]
[/#list]

[#assign IS_ATTRIBUTE = 0]
[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
    [#if (((SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_WITHOUT_RESP]??  &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_WITHOUT_RESP] != "") ||
        (SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE]??  &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE] != "")) &&
        SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_ATTR_WRITE]??  &&
        SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_ATTR_WRITE] != " ")
        ||
        ((SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY]??  &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY] != "") ||
        (SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE]??  &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE] != ""))]
[#assign IS_ATTRIBUTE = 1]
    [/#if]
[/#list]

[#assign IS_WRITE = 0]
[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
    [#if (((SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_WITHOUT_RESP]??  &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_WITHOUT_RESP] != "") ||
        (SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE]??  &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE] != "")) &&
        SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_WRITE_REQ_AND_WAIT_FOR_APPL_RESP]??  &&
        SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_WRITE_REQ_AND_WAIT_FOR_APPL_RESP] != " ")]
[#assign IS_WRITE = 1]
    [/#if]
[/#list]

[#assign IS_READ = 0]
[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
    [#if (SERVICES_CHARS_PROP[characteristic?string][item_PROP_READ]??  &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_READ] != "" &&
        SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_READ_REQ_AND_WAIT_FOR_APPL_RESP]??  &&
        SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_READ_REQ_AND_WAIT_FOR_APPL_RESP] != " ")]
[#assign IS_READ = 1]
    [/#if]
[/#list]

[#macro characteristicShortName characteristic]
    ${SERVICES_CHARS_NAMES[characteristic?string][item_SHORT_NAME]?upper_case}[#t]
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
    COPY_${SERVICES_CHARS_NAMES[characteristic?string][item_SHORT_NAME]?upper_case}[#t]
[/#macro]

[#macro customServChar characteristic]
    ${SERVICE_SHORT_NAME_UpperCase}_${SERVICES_CHARS_NAMES[characteristic?string][item_SHORT_NAME]?upper_case}[#t]
[/#macro]

/* Includes ------------------------------------------------------------------*/
#include "common_blesvc.h"
[#if SERVICE_SHORT_NAME != ""]
#include "${SERVICE_SHORT_NAME?lower_case}.h"
[/#if]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
typedef struct{
  uint16_t  ${SERVICE_SHORT_NAME?capitalize}SvcHdle;                  /**< ${SERVICE_SHORT_NAME?capitalize} Service Handle */
[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
  uint16_t  [@characteristicShortNameCapitalized characteristic/]CharHdle;                  /**< [@characteristicShortName characteristic/] Characteristic Handle */
[/#list]
}${SERVICE_SHORT_NAME_UpperCase}_Context_t;

/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private defines -----------------------------------------------------------*/
#define UUID_128_SUPPORTED  1

#if (UUID_128_SUPPORTED == 1)
#define BM_UUID_LENGTH  UUID_TYPE_128
#else
#define BM_UUID_LENGTH  UUID_TYPE_16
#endif

#define BM_REQ_CHAR_SIZE    (3)

/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* External variables -----------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private macros ------------------------------------------------------------*/
#define CHARACTERISTIC_DESCRIPTOR_ATTRIBUTE_OFFSET         2
#define CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET              1
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
static const uint8_t Size[@characteristicShortNameCapitalized characteristic/] = ${SERVICES_CHARS_VALUE_LENGTH[characteristic?string]};
[/#list]

/**
 * START of Section BLE_DRIVER_CONTEXT
 */
PLACE_IN_SECTION("BLE_DRIVER_CONTEXT") static ${SERVICE_SHORT_NAME_UpperCase}_Context_t ${SERVICE_SHORT_NAME_UpperCase}_Context;

/**
 * END of Section BLE_DRIVER_CONTEXT
 */

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
static SVCCTL_EvtAckStatus_t ${SERVICE_SHORT_NAME_UpperCase}_EventHandler(void *p_pckt);

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Functions Definition ------------------------------------------------------*/
/* USER CODE BEGIN PFD */

/* USER CODE END PFD */

/* Private functions ----------------------------------------------------------*/

#define COPY_UUID_128(uuid_struct, uuid_15, uuid_14, uuid_13, uuid_12, uuid_11, uuid_10, uuid_9, uuid_8, uuid_7, uuid_6, uuid_5, uuid_4, uuid_3, uuid_2, uuid_1, uuid_0) \
do {\
    uuid_struct[0] = uuid_0; uuid_struct[1] = uuid_1; uuid_struct[2] = uuid_2; uuid_struct[3] = uuid_3; \
    uuid_struct[4] = uuid_4; uuid_struct[5] = uuid_5; uuid_struct[6] = uuid_6; uuid_struct[7] = uuid_7; \
    uuid_struct[8] = uuid_8; uuid_struct[9] = uuid_9; uuid_struct[10] = uuid_10; uuid_struct[11] = uuid_11; \
    uuid_struct[12] = uuid_12; uuid_struct[13] = uuid_13; uuid_struct[14] = uuid_14; uuid_struct[15] = uuid_15; \
}while(0)

/* Hardware Characteristics Service */
/*
 The following 128bits UUIDs have been generated from the random UUID
 generator:
 D973F2E0-B19E-11E2-9E96-0800200C9A66: Service 128bits UUID
 D973F2E1-B19E-11E2-9E96-0800200C9A66: Characteristic_1 128bits UUID
 D973F2E2-B19E-11E2-9E96-0800200C9A66: Characteristic_2 128bits UUID
 */
        [#if myHash["SERVICE"+SvcNbr+"_UUID_TYPE"] == "0x02"]
            [#if myHash["SERVICE"+SvcNbr+"_UUID_128_INPUT_TYPE"] == "0"]
#define COPY_${SERVICE_SHORT_NAME_UpperCase}_UUID(uuid_struct)       COPY_UUID_128(uuid_struct,0x00,0x00,0x${myHash["SERVICE"+SvcNbr+"_UUID"]?lower_case?replace(" ",",0x")},0xcc,0x7a,0x48,0x2a,0x98,0x4a,0x7f,0x2e,0xd5,0xb3,0xe5,0x8f)
            [#else]
#define COPY_${SERVICE_SHORT_NAME_UpperCase}_UUID(uuid_struct)       COPY_UUID_128(uuid_struct,0x${myHash["SERVICE"+SvcNbr+"_UUID"]?lower_case?replace(" ",",0x")})
            [/#if]
        [/#if]
        [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
            [#if SERVICES_CHARS_INFO[characteristic?string][item_UUID_TYPE] == "0x02"]
                [#if SERVICES_CHARS_INFO[characteristic?string][item_UUID_128_INPUT_TYPE] == "0"]
#define [@copyServChar characteristic/]_UUID(uuid_struct)       COPY_UUID_128(uuid_struct,0x00,0x00,0x${SERVICES_CHARS_INFO[characteristic?string][item_UUID]?lower_case?replace(" ",",0x")},0x8e,0x22,0x45,0x41,0x9d,0x4c,0x21,0xed,0xae,0x82,0xed,0x19)
                [#else]
#define [@copyServChar characteristic/]_UUID(uuid_struct)       COPY_UUID_128(uuid_struct,0x${SERVICES_CHARS_INFO[characteristic?string][item_UUID]?lower_case?replace(" ",",0x")})
                [/#if]
            [/#if]
        [/#list]

/* USER CODE BEGIN PF */

/* USER CODE END PF */

/**
 * @brief  Event handler
 * @param  p_Event: Address of the buffer holding the p_Event
 * @retval Ack: Return whether the p_Event has been managed or not
 */
static SVCCTL_EvtAckStatus_t ${SERVICE_SHORT_NAME_UpperCase}_EventHandler(void *p_Event)
{
  SVCCTL_EvtAckStatus_t return_value;
  hci_event_pckt *p_event_pckt;
  evt_blecore_aci *p_blecore_evt;
[#if IS_ATTRIBUTE =1]
  aci_gatt_attribute_modified_event_rp0 *p_attribute_modified;
[/#if]
[#if IS_WRITE =1]
  aci_gatt_write_permit_req_event_rp0   *p_write_perm_req;
[/#if]
[#if IS_READ =1]
  aci_gatt_read_permit_req_event_rp0    *p_read_req;
[/#if]
[#if IS_ATTRIBUTE =1]
  ${SERVICE_SHORT_NAME_UpperCase}_NotificationEvt_t                 notification;
[/#if]
  /* USER CODE BEGIN Service${SvcNbr}_EventHandler_1 */

  /* USER CODE END Service${SvcNbr}_EventHandler_1 */

  return_value = SVCCTL_EvtNotAck;
  p_event_pckt = (hci_event_pckt *)(((hci_uart_pckt*)p_Event)->data);

  switch(p_event_pckt->evt)
  {
    case HCI_VENDOR_SPECIFIC_DEBUG_EVT_CODE:
      p_blecore_evt = (evt_blecore_aci*)p_event_pckt->data;
      switch(p_blecore_evt->ecode)
      {
        case ACI_GATT_ATTRIBUTE_MODIFIED_VSEVT_CODE:
          /* USER CODE BEGIN EVT_BLUE_GATT_ATTRIBUTE_MODIFIED_BEGIN */

          /* USER CODE END EVT_BLUE_GATT_ATTRIBUTE_MODIFIED_BEGIN */
[#if IS_ATTRIBUTE =1]
          p_attribute_modified = (aci_gatt_attribute_modified_event_rp0*)p_blecore_evt->data;
[/#if]
[#assign INDEX = 0]
        [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
            [#if (SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY]??  &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY] != "") &&
                (SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE]?? &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE] != "")]
              [#if INDEX = 0]
          if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_DESCRIPTOR_ATTRIBUTE_OFFSET))
                [#assign INDEX = INDEX + 1]
              [#else]
          else if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_DESCRIPTOR_ATTRIBUTE_OFFSET))              
              [/#if]
          {
            return_value = SVCCTL_EvtAckFlowEnable;
            /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string} */

            /* USER CODE END Service${SvcNbr}_Char_${characteristic?string} */

            switch(p_attribute_modified->Attr_Data[0])
            {
              /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_attribute_modified  */

              /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_attribute_modified  */

              /* Disabled Notification and Indication management */
              case (!(COMSVC_Notification) | !(COMSVC_Indication)):
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
              case COMSVC_Notification:
                /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Notification_BEGIN */

                /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Notification_BEGIN */
                notification.EvtOpcode = ${SERVICE_SHORT_NAME_UpperCase}_[@characteristicShortName characteristic/]_NOTIFY_ENABLED_EVT;
                ${SERVICE_SHORT_NAME_UpperCase}_Notification(&notification);
                /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Notification_END */

                /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_COMSVC_Notification_END */
                break;

              /* Enabled Indication management */
              case COMSVC_Indication:
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
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY] != "") &&
                (SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE]?? &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE] == "")]
              [#if INDEX = 0]
          if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_DESCRIPTOR_ATTRIBUTE_OFFSET))
                [#assign INDEX = INDEX + 1]
              [#else]
          else if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_DESCRIPTOR_ATTRIBUTE_OFFSET))              
              [/#if]
          {
            return_value = SVCCTL_EvtAckFlowEnable;
            /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string} */

            /* USER CODE END Service${SvcNbr}_Char_${characteristic?string} */
            switch(p_attribute_modified->Attr_Data[0])
            {
              /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_attribute_modified */

              /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_attribute_modified */

              /* Disabled Notification management */
              case (!(COMSVC_Notification)):
                /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_Disabled_BEGIN */

                /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_Disabled_BEGIN */
                notification.EvtOpcode = ${SERVICE_SHORT_NAME_UpperCase}_[@characteristicShortName characteristic/]_NOTIFY_DISABLED_EVT;
                ${SERVICE_SHORT_NAME_UpperCase}_Notification(&notification);
                /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_Disabled_END */

                /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_Disabled_END */
                break;

              /* Enabled Notification management */
              case COMSVC_Notification:
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
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY] == "") &&
                (SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE]?? &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE] != "")]
              [#if INDEX = 0]
          if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_DESCRIPTOR_ATTRIBUTE_OFFSET))
                [#assign INDEX = INDEX + 1]
              [#else]
          else if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_DESCRIPTOR_ATTRIBUTE_OFFSET))
              [/#if]
          {
            return_value = SVCCTL_EvtAckFlowEnable;
            /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string} */

            /* USER CODE END Service${SvcNbr}_Char_${characteristic?string} */

            switch(p_attribute_modified->Attr_Data[0])
            {
              /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_attribute_modified */

              /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_attribute_modified */

              /* Disabled Indication management */
              case (!(COMSVC_Indication)):
                /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_Disabled_BEGIN */

                /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_Disabled_BEGIN */
                notification.EvtOpcode = ${SERVICE_SHORT_NAME_UpperCase}_[@characteristicShortName characteristic/]_INDICATE_DISABLED_EVT;
                ${SERVICE_SHORT_NAME_UpperCase}_Notification(&notification);
                /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_Disabled_END */

                /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_Disabled_END */
                break;

              /* Enabled Indication management */
              case COMSVC_Indication:
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
        [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
            [#if (((SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_WITHOUT_RESP]??  &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_WITHOUT_RESP] != "") ||
                (SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE]??  &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE] != "")) &&
                SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_ATTR_WRITE]??  &&
                SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_ATTR_WRITE] != " ")]
              [#if INDEX = 0]
          if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET))
                [#assign INDEX = INDEX + 1]
              [#else]
          else if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET))              
              [/#if]
          {
            return_value = SVCCTL_EvtAckFlowEnable;
            /* USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_ACI_GATT_ATTRIBUTE_MODIFIED_VSEVT_CODE */

            /* USER CODE END Service${SvcNbr}_Char_${characteristic?string}_ACI_GATT_ATTRIBUTE_MODIFIED_VSEVT_CODE */
            [#if (SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_WITHOUT_RESP]??  &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_WITHOUT_RESP] != "")]
            notification.EvtOpcode = ${SERVICE_SHORT_NAME_UpperCase}_[@characteristicShortName characteristic/]_WRITE_NO_RESP_EVT;
            [#else]
            notification.EvtOpcode = ${SERVICE_SHORT_NAME_UpperCase}_[@characteristicShortName characteristic/]_WRITE_EVT;
            [/#if]
            ${SERVICE_SHORT_NAME_UpperCase}_Notification(&notification);
          } /* if(p_attribute_modified->Attr_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET))*/
            [/#if]
        [/#list]

          /* USER CODE BEGIN EVT_BLUE_GATT_ATTRIBUTE_MODIFIED_END */

          /* USER CODE END EVT_BLUE_GATT_ATTRIBUTE_MODIFIED_END */
          break;

        case ACI_GATT_READ_PERMIT_REQ_VSEVT_CODE :
          /* USER CODE BEGIN EVT_BLUE_GATT_READ_PERMIT_REQ_BEGIN */

          /* USER CODE END EVT_BLUE_GATT_READ_PERMIT_REQ_BEGIN */
[#if IS_READ =1]
          p_read_req = (aci_gatt_read_permit_req_event_rp0*)p_blecore_evt->data;
[/#if]
[#assign INDEX = 0]
        [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
            [#if (SERVICES_CHARS_PROP[characteristic?string][item_PROP_READ]??  &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_READ] != "" &&
                SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_READ_REQ_AND_WAIT_FOR_APPL_RESP]??  &&
                SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_READ_REQ_AND_WAIT_FOR_APPL_RESP] != " ")]
              [#if INDEX = 0]
          if(p_read_req->Attribute_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET))
                [#assign INDEX = INDEX + 1]
              [#else]
          else if(p_read_req->Attribute_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET))
              [/#if]
          {
            return_value = SVCCTL_EvtAckFlowEnable;
            /*USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_ACI_GATT_READ_PERMIT_REQ_VSEVT_CODE_1 */

            /*USER CODE END Service${SvcNbr}_Char_${characteristic?string}_ACI_GATT_READ_PERMIT_REQ_VSEVT_CODE_1*/

            /*USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_ACI_GATT_READ_PERMIT_REQ_VSEVT_CODE_2 */
#warning user shall call aci_gatt_allow_read() function if allowed
            /*USER CODE END Service${SvcNbr}_Char_${characteristic?string}_ACI_GATT_READ_PERMIT_REQ_VSEVT_CODE_2*/
          } /* if(p_read_req->Attribute_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET))*/
            [/#if]
        [/#list]
		
          /* USER CODE BEGIN EVT_BLUE_GATT_READ_PERMIT_REQ_END */

          /* USER CODE END EVT_BLUE_GATT_READ_PERMIT_REQ_END */
          break;

        case ACI_GATT_WRITE_PERMIT_REQ_VSEVT_CODE:
          /* USER CODE BEGIN EVT_BLUE_GATT_WRITE_PERMIT_REQ_BEGIN */

          /* USER CODE END EVT_BLUE_GATT_WRITE_PERMIT_REQ_BEGIN */
[#if IS_WRITE =1]
          p_write_perm_req = (aci_gatt_write_permit_req_event_rp0*)p_blecore_evt->data;
[/#if]
[#assign INDEX = 0]
        [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
            [#if (((SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_WITHOUT_RESP]??  &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE_WITHOUT_RESP] != "") ||
                (SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE]??  &&
                SERVICES_CHARS_PROP[characteristic?string][item_PROP_WRITE] != "")) &&
                SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_WRITE_REQ_AND_WAIT_FOR_APPL_RESP]??  &&
                SERVICES_CHARS_GATT_NOTIFY[characteristic?string][item_GATT_NOTIFY_WRITE_REQ_AND_WAIT_FOR_APPL_RESP] != " ")]
              [#if INDEX = 0]
          if(p_write_perm_req->Attribute_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET))
                [#assign INDEX = INDEX + 1]
              [#else]
          else if(p_write_perm_req->Attribute_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET))
              [/#if]
          {
            return_value = SVCCTL_EvtAckFlowEnable;
            /*USER CODE BEGIN Service${SvcNbr}_Char_${characteristic?string}_ACI_GATT_WRITE_PERMIT_REQ_VSEVT_CODE */
#warning user shall call aci_gatt_write_resp() function if allowed
            /*USER CODE END Service${SvcNbr}_Char_${characteristic?string}_ACI_GATT_WRITE_PERMIT_REQ_VSEVT_CODE*/
          } /*if(p_write_perm_req->Attribute_Handle == (${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle + CHARACTERISTIC_VALUE_ATTRIBUTE_OFFSET))*/

            [/#if]
        [/#list]

          /* USER CODE BEGIN EVT_BLUE_GATT_WRITE_PERMIT_REQ_END */

          /* USER CODE END EVT_BLUE_GATT_WRITE_PERMIT_REQ_END */
          break;
        /* USER CODE BEGIN BLECORE_EVT */

        /* USER CODE END BLECORE_EVT */
        default:
          /* USER CODE BEGIN EVT_DEFAULT */

          /* USER CODE END EVT_DEFAULT */
          break;
      }
      /* USER CODE BEGIN EVT_VENDOR*/

      /* USER CODE END EVT_VENDOR*/
      break; /* HCI_VENDOR_SPECIFIC_DEBUG_EVT_CODE */

      /* USER CODE BEGIN EVENT_PCKT_CASES*/

      /* USER CODE END EVENT_PCKT_CASES*/

    default:
      /* USER CODE BEGIN EVENT_PCKT*/

      /* USER CODE END EVENT_PCKT*/
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
  Char_UUID_t  uuid;
  tBleStatus ret = BLE_STATUS_INVALID_PARAMS;
  /* USER CODE BEGIN SVCCTL_InitService${SvcNbr}Svc_1 */

  /* USER CODE END SVCCTL_InitService${SvcNbr}Svc_1 */

  /**
   *  Register the event handler to the BLE controller
   */
  SVCCTL_RegisterSvcHandler(${SERVICE_SHORT_NAME_UpperCase}_EventHandler);

[#assign UUID_TYPE = "UUID_TYPE_128"]

  /**
   * ${SERVICE_SHORT_NAME}
   *
   * Max_Attribute_Records = 1 + 2*${SERVICE_NUMBER_OF_CHARACTERISTICS?number} + 1*no_of_char_with_notify_or_indicate_property + 1*no_of_char_with_broadcast_property
   * service_max_attribute_record = 1 for ${SERVICE_SHORT_NAME} +
      [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
   *                                2 for [@characteristicShortName characteristic/] +
      [/#list]
      [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
          [#if (SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY]??  &&
              SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY] != "") ||
              (SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE]?? &&
              SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE] != "")]
   *                                1 for [@characteristicShortName characteristic/] configuration descriptor +
          [/#if]
      [/#list]
      [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
          [#if (SERVICES_CHARS_PROP[characteristic?string][item_PROP_BROADCAST]??  &&
              SERVICES_CHARS_PROP[characteristic?string][item_PROP_BROADCAST] != "")]
   *                                1 for [@characteristicShortName characteristic/] broadcast property +
          [/#if]
      [/#list]
   *                              = ${myHash["SERVICE"+SvcNbr+"_MAX_ATTRIBUTES_RECORDS"]}
   */
      [#if myHash["SERVICE"+SvcNbr+"_UUID_TYPE"] == "0x01"]
          [#assign UUID_TYPE = "UUID_TYPE_16"]
  uuid.Char_UUID_16 = 0x${myHash["SERVICE"+SvcNbr+"_UUID"]?lower_case?replace(" ","")};
      [/#if]
      [#if myHash["SERVICE"+SvcNbr+"_UUID_TYPE"] == "0x02"]
          [#assign UUID_TYPE = "UUID_TYPE_128"]
  COPY_${SERVICE_SHORT_NAME_UpperCase}_UUID(uuid.Char_UUID_128);
      [/#if]
  ret = aci_gatt_add_service(${UUID_TYPE},
                             (Service_UUID_t *) &uuid,
                             ${myHash["SERVICE"+SvcNbr+"_TYPE"]},
                             ${myHash["SERVICE"+SvcNbr+"_MAX_ATTRIBUTES_RECORDS"]},
                             &(${SERVICE_SHORT_NAME_UpperCase}_Context.${SERVICE_SHORT_NAME?capitalize}SvcHdle));
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_gatt_add_service command: ${SERVICE_SHORT_NAME}, error code: 0x%x \n\r", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_gatt_add_service command: ${SERVICE_SHORT_NAME} \n\r");
  }

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
  /**
   * [@characteristicShortName characteristic/]
   */
          [#if SERVICES_CHARS_INFO[characteristic?string][item_UUID_TYPE] == "0x01"]
              [#assign UUID_TYPE = "UUID_TYPE_16"]
  uuid.Char_UUID_16 = ${SERVICES_CHARS_INFO[characteristic?string][item_UUID]?lower_case?replace(" ","")};
          [/#if]
          [#if SERVICES_CHARS_INFO[characteristic?string][item_UUID_TYPE] == "0x02"]
              [#assign UUID_TYPE = "UUID_TYPE_128"]
  [@copyServChar characteristic/]_UUID(uuid.Char_UUID_128);
          [/#if]
  ret = aci_gatt_add_char(${SERVICE_SHORT_NAME_UpperCase}_Context.${SERVICE_SHORT_NAME?capitalize}SvcHdle,
                          ${UUID_TYPE},
                          (Char_UUID_t *) &uuid,
                          Size[@characteristicShortNameCapitalized characteristic/],
                          ${prop_list},
                          ${attr_perm_list},
                          ${gatt_notify_list},
                          ${SERVICES_CHARS_ENC_KEY_SIZE[characteristic?string]},
                          ${SERVICES_CHARS_LENGTH_CHARACTERISTIC[characteristic?string]},
                          &(${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle));
  if (ret != BLE_STATUS_SUCCESS)
  {
    APP_DBG_MSG("  Fail   : aci_gatt_add_char command   : [@characteristicShortName characteristic/], error code: 0x%x \n\r", ret);
  }
  else
  {
    APP_DBG_MSG("  Success: aci_gatt_add_char command   : [@characteristicShortName characteristic/] \n\r");
  }

      [/#list]

  /* USER CODE BEGIN SVCCTL_InitService${SvcNbr}Svc_2 */

  /* USER CODE END SVCCTL_InitService${SvcNbr}Svc_2 */

  return;
}

/**
 * @brief  Characteristic update
 * @param  CharOpcode: Characteristic identifier
 * @param  Service_Instance: Instance of the service to which the characteristic belongs
 *
 */
tBleStatus ${SERVICE_SHORT_NAME_UpperCase}_UpdateValue(${SERVICE_SHORT_NAME_UpperCase}_CharOpcode_t CharOpcode, uint8_t *p_Payload)
{
  tBleStatus ret = BLE_STATUS_INVALID_PARAMS;
  /* USER CODE BEGIN Service${SvcNbr}_App_Update_Char_1 */

  /* USER CODE END Service${SvcNbr}_App_Update_Char_1 */

  switch(CharOpcode)
  {
        [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
    case [@customServChar characteristic/]:
      ret = aci_gatt_update_char_value(${SERVICE_SHORT_NAME_UpperCase}_Context.${SERVICE_SHORT_NAME?capitalize}SvcHdle,
                                       ${SERVICE_SHORT_NAME_UpperCase}_Context.[@characteristicShortNameCapitalized characteristic/]CharHdle,
                                       ${SERVICES_CHARS_VALUE_OFFSET[characteristic?string]}, /* charValOffset */
                                       Size[@characteristicShortNameCapitalized characteristic/], /* charValueLen */
                                       (uint8_t *)p_Payload);
      if (ret != BLE_STATUS_SUCCESS)
      {
        APP_DBG_MSG("  Fail   : aci_gatt_update_char_value [@characteristicShortName characteristic/] command, error code: 0x%x \n\r", ret);
      }
      else
      {
        APP_DBG_MSG("  Success: aci_gatt_update_char_value [@characteristicShortName characteristic/] command\n\r");
      }
      /* USER CODE BEGIN Service${SvcNbr}_Char_Value_${characteristic?string}*/

      /* USER CODE END Service${SvcNbr}_Char_Value_${characteristic?string}*/
      break;

        [/#list]

    default:
      break;
  }

  /* USER CODE BEGIN Service${SvcNbr}_App_Update_Char_2 */

  /* USER CODE END Service${SvcNbr}_App_Update_Char_2 */

  return ret;
}
