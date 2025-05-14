[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_entry.c
  * @author  GPM WBL Application Team
  * @brief   Entry point of the application
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign myHash = {}]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if ("${definition.value}"=="valueNotSetted")]
              [#assign myHash = {definition.name:0} + myHash]
            [#else]
              [#assign myHash = {definition.name:definition.value} + myHash]
            [/#if]
        [/#list]
    [/#if]
[/#list]
[#--
Key & Value:
[#list myHash?keys as key]
Key: ${key}; Value: ${myHash[key]}
[/#list]
--]

/* Includes ------------------------------------------------------------------*/
#include "app_common.h"
#include "main.h"
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
#include "stm32_seq.h"
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]

[/#if]
[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] != "Enabled")]
#include "app_ble.h"
[/#if]
#include "hw_rng.h"
#include "hw_aes.h"
#include "hw_pka.h"
#include "stm32wb0x.h"
[#if (myHash["BLE_MODE_CENTRAL"] == "Enabled") || (myHash["BLE_MODE_PERIPHERAL"] == "Enabled")  || (myHash["BLE_MODE_BROADCASTER"] == "Enabled")|| (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
#include "stm32wb0x_ll_usart.h"
[/#if]
#include "ble_stack.h"
#if (CFG_LPM_SUPPORTED == 1)
#include "stm32_lpm.h"
#endif /* CFG_LPM_SUPPORTED */
#include "app_debug.h"

/* Private includes -----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/

/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private defines -----------------------------------------------------------*/

/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macros ------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Global variables ----------------------------------------------------------*/

/* USER CODE BEGIN GV */

/* USER CODE END GV */

/* Private functions prototypes-----------------------------------------------*/

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* External variables --------------------------------------------------------*/

/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Functions Definition ------------------------------------------------------*/

uint32_t MX_APPE_Init(void *p_param)
{

  UNUSED(p_param);
  
  APP_DEBUG_SIGNAL_SET(APP_APPE_INIT);
  
#if (CFG_DEBUG_APP_ADV_TRACE != 0)
  UTIL_ADV_TRACE_Init();
  UTIL_ADV_TRACE_SetVerboseLevel(VLEVEL_L); /* functional traces*/
  UTIL_ADV_TRACE_SetRegion(~0x0);
#endif
  
  /* USER CODE BEGIN APPE_Init_1 */
  
  /* USER CODE END APPE_Init_1 */
  
  if (HW_RNG_Init() != HW_RNG_SUCCESS)
  {
    Error_Handler();
  }
  
  /* Init the AES block */
  HW_AES_Init();
  HW_PKA_Init();
[#if myHash["BLE_MODE_SKELETON"] == "Disabled"]
  APP_BLE_Init();
[/#if]

#if (CFG_LPM_SUPPORTED == 1)
  /* Low Power Manager Init */
  UTIL_LPM_Init();
#endif /* CFG_LPM_SUPPORTED */
/* USER CODE BEGIN APPE_Init_2 */
  
/* USER CODE END APPE_Init_2 */
  APP_DEBUG_SIGNAL_RESET(APP_APPE_INIT);
  return BLE_STATUS_SUCCESS;
}

/* USER CODE BEGIN FD */

/* USER CODE END FD */

/*************************************************************
 *
 * LOCAL FUNCTIONS
 *
 *************************************************************/
#if (CFG_LPM_SUPPORTED == 1)
static PowerSaveLevels App_PowerSaveLevel_Check(void)
{
  PowerSaveLevels output_level = POWER_SAVE_LEVEL_STOP;
  /* USER CODE BEGIN App_PowerSaveLevel_Check_1 */
  
  /* USER CODE END App_PowerSaveLevel_Check_1 */
  
  return output_level;
}
#endif

/* USER CODE BEGIN FD_LOCAL_FUNCTIONS */

/* USER CODE END FD_LOCAL_FUNCTIONS */

/*************************************************************
 *
 * WRAP FUNCTIONS
 *
 *************************************************************/
void MX_APPE_Process(void)
{
  /* USER CODE BEGIN MX_APPE_Process_1 */

  /* USER CODE END MX_APPE_Process_1 */
  UTIL_SEQ_Run(UTIL_SEQ_DEFAULT);
  /* USER CODE BEGIN MX_APPE_Process_2 */

  /* USER CODE END MX_APPE_Process_2 */
}

void UTIL_SEQ_PreIdle( void )
{
#if (CFG_LPM_SUPPORTED == 1)
  /* USER CODE BEGIN UTIL_SEQ_PREIDLE */

  /* USER CODE END UTIL_SEQ_PREIDLE */
#endif /* CFG_LPM_SUPPORTED */
  return;
}

void UTIL_SEQ_Idle( void )
{
#if (CFG_LPM_SUPPORTED == 1)
  
  /* Need to consume some CSTACK on WB05, due to bootloader CSTACK usage. */
  volatile uint32_t dummy[15];
  uint8_t i;
  for (i=0; i<10; i++)
  {
    dummy[i] = 0;
    __NOP();
  }
  
  PowerSaveLevels app_powerSave_level, vtimer_powerSave_level, final_level, pka_level;
  
  if ((BLE_STACK_SleepCheck() != POWER_SAVE_LEVEL_RUNNING) &&
      ((app_powerSave_level = App_PowerSaveLevel_Check()) != POWER_SAVE_LEVEL_RUNNING)) 
  {  
    vtimer_powerSave_level = HAL_RADIO_TIMER_PowerSaveLevelCheck();
    pka_level = (PowerSaveLevels) HW_PKA_PowerSaveLevelCheck();
    final_level = (PowerSaveLevels)MIN(vtimer_powerSave_level, app_powerSave_level);
    final_level = (PowerSaveLevels)MIN(pka_level, final_level);
     
    switch(final_level)
    {
    case POWER_SAVE_LEVEL_RUNNING:
      /* Not Power Save device is busy */
      return;
      break;
    case POWER_SAVE_LEVEL_CPU_HALT:
      UTIL_LPM_SetStopMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);
      UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);
      break;
    case POWER_SAVE_LEVEL_STOP_LS_CLOCK_ON:
      UTIL_LPM_SetStopMode(1 << CFG_LPM_APP, UTIL_LPM_ENABLE);
      UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);
      break;
    case POWER_SAVE_LEVEL_STOP:
      UTIL_LPM_SetStopMode(1 << CFG_LPM_APP, UTIL_LPM_ENABLE);
      UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_ENABLE);
      break;
    }

  /* USER CODE BEGIN UTIL_SEQ_IDLE_BEGIN */

  /* USER CODE END UTIL_SEQ_IDLE_BEGIN */    

    UTIL_LPM_EnterLowPower();

  /* USER CODE BEGIN UTIL_SEQ_IDLE_END */

  /* USER CODE END UTIL_SEQ_IDLE_END */
  }
#endif /* CFG_LPM_SUPPORTED */
}

/* USER CODE BEGIN FD_WRAP_FUNCTIONS */

/* USER CODE END FD_WRAP_FUNCTIONS */
