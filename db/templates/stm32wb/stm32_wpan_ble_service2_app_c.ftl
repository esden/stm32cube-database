[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name?remove_beginning("App/%")?replace("%_app.c", "_app.c")}
  * @author  MCD Application Team
  * @brief   ${name?remove_beginning("App/%")?replace("%_app.c", "_app")} application definition.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign SvcNbr = 2]
[#assign SERVICE_NUMBER_OF_CHARACTERISTICS = 0]
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
[#assign SERVICE_SHORT_NAME_LowerCase = myHash["SERVICE"+SvcNbr+"_SHORT_NAME"]?lower_case]
[#assign SvcNbr = myHash["SERVICE"+SvcNbr]]

[#--
Key & Value:
[#list myHash?keys as key]
Key: ${key}; Value: ${myHash[key]}
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
[#assign item_PROP_START = item]
[#-- assign item_PROP_NONE = item][#assign item = item + 1--]
[#assign item_PROP_BROADCAST = item][#assign item = item + 1]
[#assign item_PROP_READ = item][#assign item = item + 1]
[#assign item_PROP_WRITE_WITHOUT_RESP = item][#assign item = item + 1]
[#assign item_PROP_WRITE = item][#assign item = item + 1]
[#assign item_PROP_NOTIFY = item][#assign item = item + 1]
[#assign item_PROP_INDICATE = item][#-- assign item++]
[#assign item_PROP_SIGNED_WRITE = item][#assign item++]
[# assign item_PROP_EXT = item --]
[#assign item_PROP_END = item]

[#assign SERVICES_CHARS_PROP = {} /]
[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as i]
  [#assign SERVICES_CHARS_PROP = SERVICES_CHARS_PROP + {i?string: [myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_BROADCAST"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_READ"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_WRITE_WITHOUT_RESP"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_WRITE"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_NOTIFY"],myHash["SERVICE"+SvcNbr+"_CHAR"+i+"_PROP_INDICATE"]]}/]
[/#list]

[#assign SERVICES_CHARS_SUFFIX = ["", "_READ_EVT", "_WRITE_NO_RESP_EVT", "_WRITE_EVT", "_NOTIFY_ENABLED_EVT", "_INDICATE_ENABLED_EVT"]]

[#macro customServChar characteristic]
    ${SERVICE_SHORT_NAME_UpperCase}_${SERVICES_CHARS_NAMES[characteristic?string][item_SHORT_NAME]?upper_case}[#t]
[/#macro]

[#macro capitalizeServChar characteristic]
    ${SERVICES_CHARS_NAMES[characteristic?string][item_SHORT_NAME]?capitalize}[#t]
[/#macro]

[#macro caseEventCode characteristic suffix]
    case [@customServChar characteristic/]${suffix}:
      /* USER CODE BEGIN Service${SvcNbr}Char${characteristic}${suffix} */

      /* USER CODE END Service${SvcNbr}Char${characteristic}${suffix} */
      break;

[/#macro]

[#macro customEventCode item characteristic]
    [#if SERVICES_CHARS_SUFFIX[item] != ""]
        [#assign suffix = SERVICES_CHARS_SUFFIX[item]]
  [@caseEventCode characteristic suffix/]
        [#if SERVICES_CHARS_SUFFIX[item]?contains("ENABLED")]
            [#assign suffix=SERVICES_CHARS_SUFFIX[item]?replace("ENABLED","DISABLED")]
  [@caseEventCode characteristic suffix/]
        [/#if]
    [/#if]
[/#macro]

[#macro capitalizeWords words]
    [#list words as word]
        ${word?capitalize}[#t]
    [/#list]
[/#macro]

[#--
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
${definition.name}: "${definition.value}"
        [/#list]
    [/#if]
[/#list]
--]

/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "app_common.h"
#include "app_ble.h"
#include "dbg_trace.h"
#include "ble.h"
[#if SERVICE_SHORT_NAME != ""]
#include "${SERVICE_SHORT_NAME_LowerCase}_app.h"
#include "${SERVICE_SHORT_NAME_LowerCase}.h"
[/#if]
#include "stm32_seq.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
typedef enum
{
[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
    [#if SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY]?? &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY] != ""]
  [@capitalizeServChar characteristic/]_NOTIFICATION_OFF,
  [@capitalizeServChar characteristic/]_NOTIFICATION_ON,
    [/#if]
    [#if SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE]?? &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE] != ""]
  [@capitalizeServChar characteristic/]_INDICATION_OFF,
  [@capitalizeServChar characteristic/]_INDICATION_ON,
    [/#if]
[/#list]
  /* USER CODE BEGIN Service${SvcNbr}_APP_SendInformation_t */

  /* USER CODE END Service${SvcNbr}_APP_SendInformation_t */
  ${SERVICE_SHORT_NAME_UpperCase}_APP_SENDINFORMATION_LAST
} ${SERVICE_SHORT_NAME_UpperCase}_APP_SendInformation_t;

typedef struct
{
[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
    [#if SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY]?? &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY] != ""]
  ${SERVICE_SHORT_NAME_UpperCase}_APP_SendInformation_t     [@capitalizeServChar characteristic/]_Notification_Status;
    [/#if]
    [#if SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE]?? &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE] != ""]
  ${SERVICE_SHORT_NAME_UpperCase}_APP_SendInformation_t     [@capitalizeServChar characteristic/]_Indication_Status;
    [/#if]
[/#list]
  /* USER CODE BEGIN Service${SvcNbr}_APP_Context_t */

  /* USER CODE END Service${SvcNbr}_APP_Context_t */
  uint16_t              ConnectionHandle;
} ${SERVICE_SHORT_NAME_UpperCase}_APP_Context_t;

/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private macros ------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/**
 * START of Section BLE_APP_CONTEXT
 */

PLACE_IN_SECTION("BLE_APP_CONTEXT") static ${SERVICE_SHORT_NAME_UpperCase}_APP_Context_t ${SERVICE_SHORT_NAME_UpperCase}_APP_Context;

/**
 * END of Section BLE_APP_CONTEXT
 */

uint8_t a_${SERVICE_SHORT_NAME_UpperCase}_UpdateCharData[247];

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
    [#if SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY]?? &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY] != ""]
static void ${SERVICE_SHORT_NAME_UpperCase}_[@capitalizeServChar characteristic/]_SendNotification(void);
    [/#if]
    [#if SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE]?? &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE] != ""]
static void ${SERVICE_SHORT_NAME_UpperCase}_[@capitalizeServChar characteristic/]_SendIndication(void);
    [/#if]
[/#list]

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Functions Definition ------------------------------------------------------*/
void ${SERVICE_SHORT_NAME_UpperCase}_Notification(${SERVICE_SHORT_NAME_UpperCase}_NotificationEvt_t *p_Notification)
{
  /* USER CODE BEGIN Service${SvcNbr}_Notification_1 */

  /* USER CODE END Service${SvcNbr}_Notification_1 */
  switch(p_Notification->EvtOpcode)
  {
    /* USER CODE BEGIN Service${SvcNbr}_Notification_Service${SvcNbr}_EvtOpcode */

    /* USER CODE END Service${SvcNbr}_Notification_Service${SvcNbr}_EvtOpcode */

    [#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
        [#list item_PROP_START..item_PROP_END as item]
            [#if SERVICES_CHARS_PROP[characteristic?string][item]?? &&
                    SERVICES_CHARS_PROP[characteristic?string][item] != ""]
                [@customEventCode item characteristic /]
            [/#if]
        [/#list]
    [/#list]

    default:
      /* USER CODE BEGIN Service${SvcNbr}_Notification_default */

      /* USER CODE END Service${SvcNbr}_Notification_default */
      break;
  }
  /* USER CODE BEGIN Service${SvcNbr}_Notification_2 */

  /* USER CODE END Service${SvcNbr}_Notification_2 */
  return;
}

void ${SERVICE_SHORT_NAME_UpperCase}_APP_EvtRx(${SERVICE_SHORT_NAME_UpperCase}_APP_ConnHandleNotEvt_t *p_Notification)
{
  /* USER CODE BEGIN Service${SvcNbr}_APP_EvtRx_1 */

  /* USER CODE END Service${SvcNbr}_APP_EvtRx_1 */

  switch(p_Notification->EvtOpcode)
  {
    /* USER CODE BEGIN Service${SvcNbr}_APP_EvtRx_Service${SvcNbr}_EvtOpcode */

    /* USER CODE END Service${SvcNbr}_Notification_Service${SvcNbr}_EvtOpcode */
    case ${SERVICE_SHORT_NAME_UpperCase}_CONN_HANDLE_EVT :
      /* USER CODE BEGIN Service${SvcNbr}_APP_CONN_HANDLE_EVT */
              
      /* USER CODE END Service${SvcNbr}_APP_CONN_HANDLE_EVT */
      break;

    case ${SERVICE_SHORT_NAME_UpperCase}_DISCON_HANDLE_EVT :
      /* USER CODE BEGIN Service${SvcNbr}_APP_DISCON_HANDLE_EVT */
          
      /* USER CODE END Service${SvcNbr}_APP_DISCON_HANDLE_EVT */
      break;
    
    default:
      /* USER CODE BEGIN Service${SvcNbr}_APP_EvtRx_default */

      /* USER CODE END Service${SvcNbr}_APP_EvtRx_default */
      break;
  }

  /* USER CODE BEGIN Service${SvcNbr}_APP_EvtRx_2 */

  /* USER CODE END Service${SvcNbr}_APP_EvtRx_2 */

  return;
}

void ${SERVICE_SHORT_NAME_UpperCase}_APP_Init(void)
{
  ${SERVICE_SHORT_NAME_UpperCase}_Init();
  
[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
    [#if SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY]?? &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY] != ""]
  ${SERVICE_SHORT_NAME_UpperCase}_[@capitalizeServChar characteristic/]_SendNotification();
    [/#if]
    [#if SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE]?? &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE] != ""]
  ${SERVICE_SHORT_NAME_UpperCase}_[@capitalizeServChar characteristic/]_SendIndication();
    [/#if]
[/#list]

  /* USER CODE BEGIN Service${SvcNbr}_APP_Init */

  /* USER CODE END Service${SvcNbr}_APP_Init */
  return;
}

/* USER CODE BEGIN FD */

/* USER CODE END FD */

/*************************************************************
 *
 * LOCAL FUNCTIONS
 *
 *************************************************************/
[#list 1..SERVICE_NUMBER_OF_CHARACTERISTICS?number as characteristic]
    [#if SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY]?? &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_NOTIFY] != ""]
void ${SERVICE_SHORT_NAME_UpperCase}_[@capitalizeServChar characteristic/]_SendNotification(void) /* Property Notification */
{ 
  ${SERVICE_SHORT_NAME_UpperCase}_APP_SendInformation_t notification_on_off = [@capitalizeServChar characteristic/]_NOTIFICATION_OFF;

  /* USER CODE BEGIN Service${SvcNbr}Char${characteristic}_NS_1*/
#warning user should update data to be notified and notification condition 

  /* USER CODE END Service${SvcNbr}Char${characteristic}_NS_1*/

  if (notification_on_off != [@capitalizeServChar characteristic/]_NOTIFICATION_OFF)
  {
    ${SERVICE_SHORT_NAME_UpperCase}_UpdateValue([@customServChar characteristic/], (uint8_t *)a_${SERVICE_SHORT_NAME_UpperCase}_UpdateCharData);
  }
  
  /* USER CODE BEGIN Service${SvcNbr}Char${characteristic}_NS_Last*/

  /* USER CODE END Service${SvcNbr}Char${characteristic}_NS_Last*/

  return;
}

    [/#if]
    [#if SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE]?? &&
        SERVICES_CHARS_PROP[characteristic?string][item_PROP_INDICATE] != ""]
void ${SERVICE_SHORT_NAME_UpperCase}_[@capitalizeServChar characteristic/]_SendIndication(void) /* Property Indication */
{ 
  ${SERVICE_SHORT_NAME_UpperCase}_APP_SendInformation_t indication_on_off = [@capitalizeServChar characteristic/]_INDICATION_OFF;

  /* USER CODE BEGIN Service${SvcNbr}Char${characteristic}_IS_1*/
#warning user should update data to be indicated and indication condition 

  /* USER CODE END Service${SvcNbr}Char${characteristic}_IS_1*/

  if (indication_on_off != [@capitalizeServChar characteristic/]_INDICATION_OFF)
  {
    ${SERVICE_SHORT_NAME_UpperCase}_UpdateValue([@customServChar characteristic/], (uint8_t *)a_${SERVICE_SHORT_NAME_UpperCase}_UpdateCharData);
  }
  
  /* USER CODE BEGIN Service${SvcNbr}Char${characteristic}_IS_Last*/

  /* USER CODE END Service${SvcNbr}Char${characteristic}_IS_Last*/

  return;
}

    [/#if]
[/#list]

/* USER CODE BEGIN FD_LOCAL_FUNCTIONS*/

/* USER CODE END FD_LOCAL_FUNCTIONS*/
