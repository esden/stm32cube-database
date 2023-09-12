[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
  * File Name          : ${name}
  * Description        : OTA Service Application.
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
#include "ble.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
typedef enum
{
  Wireless_Fw,
  Fw_App,
} OTAS_APP_FileType_t;

typedef struct
{
  uint32_t base_address;
  uint64_t write_value;
  uint8_t  write_value_index;
  uint8_t  file_type;
} OTAS_APP_Context_t;

/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private macros -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
OTAS_APP_Context_t OTAS_APP_Context;
/* USER CODE BEGIN PV */

/* USER CODE END PV */

[#if  (FREERTOS_STATUS = 1)]
/* Global variables ----------------------------------------------------------*/
extern osThreadId RF_ThreadId;
[/#if]

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Public functions ----------------------------------------------------------*/
void OTAS_STM_Notification( OTA_STM_Notification_t *p_notification )
{
  uint32_t count;
  uint32_t size_left;
  OTAS_STM_Indication_Msg_t msg_conf;

  switch(p_notification->ChardId)
  {
    case OTAS_STM_BASE_ADDR_ID:
    {
      switch( ((OTA_STM_Base_Addr_Event_Format_t*)(p_notification->pPayload))->Command )
      {
        case OTAS_STM_STOP_ALL_UPLOAD:
          break;

        case OTAS_STM_WIRELESS_FW_UPLOAD:
          OTAS_APP_Context.file_type = Wireless_Fw;
          OTAS_APP_Context.base_address = FLASH_BASE;
          memcpy( (uint8_t*)&OTAS_APP_Context.base_address, ((OTA_STM_Base_Addr_Event_Format_t*)(p_notification->pPayload))->Base_Addr, p_notification->ValueLength -1 );
          OTAS_APP_Context.write_value_index = 0;
          break;

        case OTAS_STM_APPLICATION_UPLOAD:
          OTAS_APP_Context.file_type = Fw_App;
          OTAS_APP_Context.base_address = FLASH_BASE;
          memcpy( (uint8_t*)&OTAS_APP_Context.base_address, ((OTA_STM_Base_Addr_Event_Format_t*)(p_notification->pPayload))->Base_Addr, p_notification->ValueLength -1 );
          OTAS_APP_Context.write_value_index = 0;
          break;

        case OTAS_STM_UPLOAD_FINISHED:
          msg_conf = OTAS_STM_REBOOT_CONFIRMED;
          (void) OTAS_STM_UpdateChar(OTAS_STM_CONF_ID, (uint8_t*)&msg_conf);
          break;

        case OTAS_STM_CANCEL_UPLOAD:
          break;

        default:
          break;
      }
    }
    break;

    case OTAS_STM_RAW_DATA_ID:
      count = 0;
      size_left = p_notification->ValueLength;

      while( LL_HSEM_1StepLock( HSEM, CFG_HW_FLASH_SEMID ) );
      HAL_FLASH_Unlock();
      while( size_left >= (8 - OTAS_APP_Context.write_value_index) )
      {
        memcpy( (uint8_t*)&OTAS_APP_Context.write_value + OTAS_APP_Context.write_value_index,
                ((OTA_STM_Raw_Data_Event_Format_t*)(p_notification->pPayload))->Raw_Data + count,
                8 - OTAS_APP_Context.write_value_index );
        while(LL_FLASH_IsActiveFlag_OperationSuspended());
        HAL_FLASH_Program( FLASH_TYPEPROGRAM_DOUBLEWORD,
                           OTAS_APP_Context.base_address,
                           OTAS_APP_Context.write_value);
        if(*(uint64_t*)(OTAS_APP_Context.base_address)==OTAS_APP_Context.write_value)
        {
          OTAS_APP_Context.base_address += 8;
          size_left -= (8 - OTAS_APP_Context.write_value_index);
          count += (8 - OTAS_APP_Context.write_value_index);
          OTAS_APP_Context.write_value_index = 0;
        }
      }
      HAL_FLASH_Lock();
      LL_HSEM_ReleaseLock( HSEM, CFG_HW_FLASH_SEMID, 0 );

      if(size_left != 0)
      {
        memcpy( (uint8_t*)&OTAS_APP_Context.write_value + OTAS_APP_Context.write_value_index,
                ((OTA_STM_Raw_Data_Event_Format_t*)(p_notification->pPayload))->Raw_Data + count,
                size_left );
        OTAS_APP_Context.write_value_index += size_left;
      }
      break;

    case OTAS_STM_CONF_EVENT_ID:
    {
      if(OTAS_APP_Context.write_value_index != 0)
      {
        while( LL_HSEM_1StepLock( HSEM, CFG_HW_FLASH_SEMID ) );
        HAL_FLASH_Unlock();
        while(*(uint64_t*)(OTAS_APP_Context.base_address) != OTAS_APP_Context.write_value)
        {
          while(LL_FLASH_IsActiveFlag_OperationSuspended());
          HAL_FLASH_Program( FLASH_TYPEPROGRAM_DOUBLEWORD,
                             OTAS_APP_Context.base_address,
                             OTAS_APP_Context.write_value);
        }
        HAL_FLASH_Lock();
        LL_HSEM_ReleaseLock( HSEM, CFG_HW_FLASH_SEMID, 0 );
      }

      switch(OTAS_APP_Context.file_type)
      {
        case Fw_App:
          *(uint32_t*)SRAM1_BASE = 0x00;
          NVIC_SystemReset();
          break;

          /**
           * TODO
           * Not supported to prevent user error
           */
        case Wireless_Fw:
          break;

        default:
          break;
      }


    }
    break;

    default:
      break;
  }

  return;
}
/* USER CODE BEGIN PF */

/* USER CODE END PF */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/