[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name?remove_beginning("App/%")?replace("%.h", ".h")}
  * @author  MCD Application Team
  * @brief   Header for ${name?remove_beginning("App/%")?replace("%.h", ".c")}
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

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
[#--
Key & Value:
[#list myHash?keys as key]
Key: ${key}; Value: ${myHash[key]}
[/#list]
--]

[#assign SERVICE_SHORT_NAME_UpperCase = myHash["SERVICE"+SvcNbr+"_SHORT_NAME"]?upper_case]
[#assign SERVICE_NUMBER_OF_CHARACTERISTICS = myHash["SERVICE"+SvcNbr+"_NUMBER_OF_CHARACTERISTICS"]]
[#assign item = 0]
[#assign item_NAME_START = item]
[#assign item_LONG_NAME = item][#assign item = item + 1]
[#assign item_SHORT_NAME = item]
[#assign item_NAME_END = item]
[#assign SERVICES_CHARS_NAMES = {} /]
[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
  [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as i]
    [#assign SERVICES_CHARS_NAMES = SERVICES_CHARS_NAMES + {i?string: [myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_LONG_NAME"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_SHORT_NAME"]]}/]
  [/#list]
[/#if]
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
[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
  [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as i]
    [#assign SERVICES_CHARS_PROP = SERVICES_CHARS_PROP + {i?string: [myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_BROADCAST"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_READ"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_WRITE_WITHOUT_RESP"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_WRITE"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_NOTIFY"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_INDICATE"]]}/]
  [/#list]
[/#if]

[#assign SERVICES_CHARS_SUFFIX = ["", "_READ_EVT", "_WRITE_NO_RESP_EVT", "_WRITE_EVT", "_NOTIFY_ENABLED_EVT", "_INDICATE_ENABLED_EVT"]]

[#macro customServChar  characteristic]
    ${SERVICE_SHORT_NAME_UpperCase}_${SERVICES_CHARS_NAMES[characteristic?string][item_SHORT_NAME]?upper_case}[#t]
[/#macro]

[#macro customEventCode item  characteristic]
    [#if SERVICES_CHARS_SUFFIX[item] != ""]
  [@customServChar  characteristic/]${SERVICES_CHARS_SUFFIX[item]},
        [#if SERVICES_CHARS_SUFFIX[item]?contains("ENABLED")]
  [@customServChar  characteristic/]${SERVICES_CHARS_SUFFIX[item]?replace("ENABLED","DISABLED")},
        [/#if]
    [/#if]
[/#macro]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef ${SERVICE_SHORT_NAME_UpperCase}_H
#define ${SERVICE_SHORT_NAME_UpperCase}_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported defines ----------------------------------------------------------*/
/* USER CODE BEGIN ED */

/* USER CODE END ED */

/* Exported types ------------------------------------------------------------*/
typedef enum
{
[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
  [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
  [@customServChar characteristic/],
  [/#list]
[/#if]
  /* USER CODE BEGIN Service${SvcNbr}_CharOpcode_t */

  /* USER CODE END Service${SvcNbr}_CharOpcode_t */
  ${SERVICE_SHORT_NAME_UpperCase}_CHAROPCODE_LAST
} ${SERVICE_SHORT_NAME_UpperCase}_CharOpcode_t;

typedef enum
{
[#if SERVICE_NUMBER_OF_CHARACTERISTICS != "0"]
  [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
      [#list item_PROP_START..item_PROP_END as item]
          [#if SERVICES_CHARS_PROP[characteristic?string][item]?? &&
                  SERVICES_CHARS_PROP[characteristic?string][item] != " "]
              [@customEventCode item characteristic /]
          [/#if]
      [/#list]
  [/#list]
[/#if]
  /* USER CODE BEGIN Service${SvcNbr}_OpcodeEvt_t */

  /* USER CODE END Service${SvcNbr}_OpcodeEvt_t */
  ${SERVICE_SHORT_NAME_UpperCase}_BOOT_REQUEST_EVT
} ${SERVICE_SHORT_NAME_UpperCase}_OpcodeEvt_t;

typedef struct
{
  uint8_t *p_Payload;
  uint8_t Length;

  /* USER CODE BEGIN Service${SvcNbr}_Data_t */

  /* USER CODE END Service${SvcNbr}_Data_t */
} ${SERVICE_SHORT_NAME_UpperCase}_Data_t;

typedef struct
{
  ${SERVICE_SHORT_NAME_UpperCase}_OpcodeEvt_t       EvtOpcode;
  ${SERVICE_SHORT_NAME_UpperCase}_Data_t             DataTransfered;
  uint16_t                ConnectionHandle;
  uint16_t                AttributeHandle;
  uint8_t                 ServiceInstance;
  /* USER CODE BEGIN Service${SvcNbr}_NotificationEvt_t */

  /* USER CODE END Service${SvcNbr}_NotificationEvt_t */
} ${SERVICE_SHORT_NAME_UpperCase}_NotificationEvt_t;

/* USER CODE BEGIN ET */

/* USER CODE END ET */


/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macros -----------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions ------------------------------------------------------- */
void ${SERVICE_SHORT_NAME_UpperCase}_Init(void);
void ${SERVICE_SHORT_NAME_UpperCase}_Notification(${SERVICE_SHORT_NAME_UpperCase}_NotificationEvt_t *p_Notification);
tBleStatus ${SERVICE_SHORT_NAME_UpperCase}_UpdateValue(${SERVICE_SHORT_NAME_UpperCase}_CharOpcode_t CharOpcode, ${SERVICE_SHORT_NAME_UpperCase}_Data_t *pData);
/* USER CODE BEGIN EF */

/* USER CODE END EF */


#ifdef __cplusplus
}
#endif

#endif /*${SERVICE_SHORT_NAME_UpperCase}_H */