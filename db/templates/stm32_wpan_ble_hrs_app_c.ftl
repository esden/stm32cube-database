[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : ${name}
  * Description        : Heart Rate Service Application
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
#include "hrs_app.h"
[#if FREERTOS_STATUS = 0]
#include "stm32_seq.h"
[#else]
#include "cmsis_os.h"
[/#if]

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
typedef struct
{
  HRS_BodySensorLocation_t BodySensorLocationChar;
  HRS_MeasVal_t MeasurementvalueChar;
  uint8_t ResetEnergyExpended;
  uint8_t TimerMeasurement_Id;

} HRSAPP_Context_t;
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private defines ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macros ------------------------------------------------------------*/
#define HRSAPP_MEASUREMENT_INTERVAL   (1000000/CFG_TS_TICK_VAL)  /**< 1s */
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/**
 * START of Section BLE_APP_CONTEXT
 */

PLACE_IN_SECTION("BLE_APP_CONTEXT") static HRSAPP_Context_t HRSAPP_Context;

/**
 * END of Section BLE_APP_CONTEXT
 */
 [#if FREERTOS_STATUS = 1]
osThreadId_t HrsProcessId;

const osThreadAttr_t HrsProcess_attr = {
    .name = CFG_HRS_PROCESS_NAME,
    .attr_bits = CFG_HRS_PROCESS_ATTR_BITS,
    .cb_mem = CFG_HRS_PROCESS_CB_MEM,
    .cb_size = CFG_HRS_PROCESS_CB_SIZE,
    .stack_mem = CFG_HRS_PROCESS_STACK_MEM,
    .priority = CFG_HRS_PROCESS_PRIORITY,
    .stack_size = CFG_HRS_PROCESS_STACk_SIZE
};
[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private functions prototypes-----------------------------------------------*/
static void HrMeas( void );
[#if FREERTOS_STATUS = 1]
static void HrsProcess(void *argument);
[/#if]
static void HRSAPP_Measurement(void);
static uint32_t HRSAPP_Read_RTC_SSR_SS ( void );
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Functions Definition ------------------------------------------------------*/
void HRS_Notification(HRS_App_Notification_evt_t *pNotification)
{
/* USER CODE BEGIN HRS_Notification_1 */

/* USER CODE END HRS_Notification_1 */
  switch(pNotification->HRS_Evt_Opcode)
  {
/* USER CODE BEGIN HRS_Notification_HRS_Evt_Opcode */

/* USER CODE END HRS_Notification_HRS_Evt_Opcode */
#if (BLE_CFG_HRS_ENERGY_EXPENDED_INFO_FLAG != 0)
    case HRS_RESET_ENERGY_EXPENDED_EVT:
/* USER CODE BEGIN HRS_RESET_ENERGY_EXPENDED_EVT */

/* USER CODE END HRS_RESET_ENERGY_EXPENDED_EVT */
      break;
#endif
      
    case HRS_NOTIFICATION_ENABLED:
/* USER CODE BEGIN HRS_NOTIFICATION_ENABLED */

/* USER CODE END HRS_NOTIFICATION_ENABLED */
      break;

    case HRS_NOTIFICATION_DISABLED:
/* USER CODE BEGIN HRS_NOTIFICATION_DISABLED */

/* USER CODE END HRS_NOTIFICATION_DISABLED */
      break;
      
#if (BLE_CFG_OTA_REBOOT_CHAR != 0)
    case HRS_STM_BOOT_REQUEST_EVT:
/* USER CODE BEGIN HRS_STM_BOOT_REQUEST_EVT */

/* USER CODE END HRS_STM_BOOT_REQUEST_EVT */
      break;
#endif
      
   default:
/* USER CODE BEGIN HRS_Notification_Default */

/* USER CODE END HRS_Notification_Default */
      break;
  }
/* USER CODE BEGIN HRS_Notification_2 */

/* USER CODE END HRS_Notification_2 */
  return;
}

void HRSAPP_Init(void)
{
[#if FREERTOS_STATUS = 1]
  HrsProcessId = osThreadNew(HrsProcess, NULL, &HrsProcess_attr);
[#else]
  UTIL_SEQ_RegTask( 1<< CFG_TASK_MEAS_REQ_ID, UTIL_SEQ_RFU, HRSAPP_Measurement );
[/#if]
/* USER CODE BEGIN HRSAPP_Init */

/* USER CODE END HRSAPP_Init */
  return;
}

[#if FREERTOS_STATUS = 1]
static void HrsProcess(void *argument)
{
  UNUSED(argument);

  for(;;)
  {
    osThreadFlagsWait( 1, osFlagsWaitAny, osWaitForever);
    HRSAPP_Measurement( );
  }
}
[/#if]
static void HRSAPP_Measurement(void)
{
/* USER CODE BEGIN HRSAPP_Measurement */

/* USER CODE END HRSAPP_Measurement */
  return;
}

static void HrMeas( void )
{
  /**
   * The code shall be executed in the background as aci command may be sent
   * The background is the only place where the application can make sure a new aci command
   * is not sent if there is a pending one
   */
[#if FREERTOS_STATUS = 1]
  osThreadFlagsSet( HrsProcessId, 1 );
  
[#else]
  UTIL_SEQ_SetTask( 1<<CFG_TASK_MEAS_REQ_ID, CFG_SCH_PRIO_0);
[/#if]
/* USER CODE BEGIN HrMeas */

/* USER CODE END HrMeas */

  return;
}

static uint32_t HRSAPP_Read_RTC_SSR_SS ( void )
{
  return ((uint32_t)(READ_BIT(RTC->SSR, RTC_SSR_SS)));
}

/* USER CODE BEGIN FD */

/* USER CODE END FD */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/