[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
 * File Name          : ${name}
 * Description        : P2P Server Application
 ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign FREERTOS_STATUS = 0]
[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
            [#if (definition.name == "FREERTOS_STATUS") && (definition.value == "1")]
                [#assign FREERTOS_STATUS = 1]
            [/#if]

        [/#list]
	[/#if]
[/#list]
/* Includes ------------------------------------------------------------------*/
#include "app_common.h"
#include "dbg_trace.h"
#include "ble.h"
#include "template_server_app.h"
[#if  (FREERTOS_STATUS = 0)]
#include "stm32_seq.h"
[#else]
#include "cmsis_os.h"
[/#if]
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
typedef struct
{
  uint8_t  NotificationStatus;
  uint16_t Parameter;
} TEMPLATE_Server_App_Context_t;

/* USER CODE BEGIN TypeDef */

/* USER CODE END TypeDef */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN Defines */

/* USER CODE END Defines */

/* Private macros ------------------------------------------------------------*/
/* USER CODE BEGIN Macros */

/* USER CODE END Macros */

/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN PrivateVariables */

/* USER CODE END PrivateVariables */

/**
 * START of Section BLE_APP_CONTEXT
 */
PLACE_IN_SECTION("BLE_APP_CONTEXT") static TEMPLATE_Server_App_Context_t TEMPLATE_Server_App_Context;

/**
 * END of Section BLE_APP_CONTEXT
 */
/* Global variables ----------------------------------------------------------*/
/* USER CODE BEGIN GlobalVariables */

/* USER CODE END GlobalVariables */

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN FunctionPrototypes */

/* USER CODE END FunctionPrototypes */

/* Functions Definition ------------------------------------------------------*/
/* USER CODE BEGIN FunctionDefinition */

/* USER CODE END FunctionDefinition */

/* Private functions ---------------------------------------------------------*/
static void TEMPLATE_APP_context_Init(void);
static void TEMPLATE_Send_Notification_Task(void);
/* USER CODE BEGIN PrivateFunctions */

/* USER CODE END PrivateFunctions */

/* Public functions ----------------------------------------------------------*/
void TEMPLATE_STM_App_Notification(TEMPLATE_STM_App_Notification_evt_t *pNotification)
{
  switch(pNotification->Template_Evt_Opcode)
  {
    case TEMPLATE_STM_NOTIFY_ENABLED_EVT:
      TEMPLATE_Server_App_Context.NotificationStatus = 1;
#if(CFG_DEBUG_APP_TRACE != 0)
      APP_DBG_MSG("-- TEMPLATE APPLICATION SERVER : NOTIFICATION ENABLED\n");
      APP_DBG_MSG(" \n\r");
#endif
      break; /* TEMPLATE_STM_NOTIFY_ENABLED_EVT */

    case TEMPLATE_STM_NOTIFY_DISABLED_EVT:
      TEMPLATE_Server_App_Context.NotificationStatus = 0;
#if(CFG_DEBUG_APP_TRACE != 0)
      APP_DBG_MSG("-- TEMPLATE APPLICATION SERVER : NOTIFICATION DISABLED\n");
      APP_DBG_MSG(" \n\r");
#endif
      break; /* TEMPLATE_STM_NOTIFY_DISABLED_EVT */
      
    case TEMPLATE_STM_WRITE_EVT:
#if(CFG_DEBUG_APP_TRACE != 0)
      APP_DBG_MSG("-- TEMPLATE APPLICATION SERVER : WRITE EVENT RECEIVED\n");
      APP_DBG_MSG("-- TEMPLATE APPLICATION SERVER : 0x%x\n",pNotification->DataTransfered.pPayload[0]);
      APP_DBG_MSG(" \n\r");
#endif
      if(pNotification->DataTransfered.pPayload[0] == 0x00)
      {
#if(CFG_DEBUG_APP_TRACE != 0)
      APP_DBG_MSG("-- TEMPLATE APPLICATION SERVER : START TASK 2 \n");
#endif
      }
      break; /* TEMPLATE_STM_WRITE_EVT */

#if(BLE_CFG_OTA_REBOOT_CHAR != 0)       
    case TEMPLATE_STM_BOOT_REQUEST_EVT:
#if(CFG_DEBUG_APP_TRACE != 0)
    APP_DBG_MSG("-- TEMPLATE APPLICATION SERVER : BOOT REQUESTED\n");
    APP_DBG_MSG(" \n\r");
#endif

      *(uint32_t*)SRAM1_BASE = *(uint32_t*)pNotification->DataTransfered.pPayload;
      NVIC_SystemReset();

      break; /* TEMPLATE_STM_BOOT_REQUEST_EVT */
#endif
      
    default:
      break; /* DEFAULT */
  }

  return;
}

void TEMPLATE_APP_Init(void)
{
  /**
   * Initialize Template application context
   */
  TEMPLATE_Server_App_Context.NotificationStatus=0;
  TEMPLATE_APP_context_Init();
  return;
}

/*************************************************************
 *
 * LOCAL FUNCTIONS
 *
 *************************************************************/
static void TEMPLATE_APP_context_Init(void)
{
  TEMPLATE_Server_App_Context.Parameter = 0;
}

static void TEMPLATE_Send_Notification_Task(void)
{
  uint16_t value;

  value = TEMPLATE_Server_App_Context.Parameter;

  if(TEMPLATE_Server_App_Context.NotificationStatus)
  {
#if(CFG_DEBUG_APP_TRACE != 0)
    APP_DBG_MSG("-- TEMPLATE APPLICATION SERVER : NOTIFY CLIENT WITH NEW PARAMETER VALUE \n ");
    APP_DBG_MSG(" \n\r");
#endif
    TEMPLATE_STM_App_Update_Char(0x0000,(uint8_t *)&value);
  }
  else
  {
#if(CFG_DEBUG_APP_TRACE != 0)
    APP_DBG_MSG("-- TEMPLATE APPLICATION SERVER : CAN'T INFORM CLIENT - NOTIFICATION DISABLED\n ");
#endif
  }

  return;
}

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
