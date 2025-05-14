[#ftl]
/* USER CODE BEGIN Header */
/**
  ***************************************************************************************
  * @file    ${name}
  * @author  MCD Application Team
  * @brief   Low layer function to enter/exit low power modes (stop, sleep).
  ***************************************************************************************
  [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign WB_LINE = Line]
[#assign DIE = DIE]

/* Includes ------------------------------------------------------------------*/
#include "stm32_lpm_if.h"
#include "stm32_lpm.h"
#include "app_conf.h"
[#if DIE == "DIE494"]
#include "main.h"
#include "standby.h"
[/#if]
/* USER CODE BEGIN include */

/* USER CODE END include */

/* Exported variables --------------------------------------------------------*/
const struct UTIL_LPM_Driver_s UTIL_PowerDriver =
{
  PWR_EnterSleepMode,
  PWR_ExitSleepMode,

  PWR_EnterStopMode,
  PWR_ExitStopMode,

  PWR_EnterOffMode,
  PWR_ExitOffMode,
};
[#if DIE == "DIE494"]

extern RTC_HandleTypeDef hrtc;

void CPUcontextSave(void); /* this function is implemented in startup assembly file */
void SystemClock_Config(void);
void PeriphCommonClock_Config(void);
[/#if]

/* Private function prototypes -----------------------------------------------*/
static void Switch_On_HSI(void);
static void EnterLowPower(void);
static void ExitLowPower(void);
[#if DIE == "DIE494"]
#if (CFG_LPM_STANDBY_SUPPORTED != 0)
static void ExitLowPower_standby(void);
#endif
[/#if]
/* USER CODE BEGIN Private_Function_Prototypes */

/* USER CODE END Private_Function_Prototypes */
/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN Private_Typedef */

/* USER CODE END Private_Typedef */
/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN Private_Define */

/* USER CODE END Private_Define */
/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN Private_Macro */

/* USER CODE END Private_Macro */
/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN Private_Variables */

/* USER CODE END Private_Variables */

/* Functions Definition ------------------------------------------------------*/
/**
  * @brief Enters Low Power Off Mode
  * @param none
  * @retval none
  */
void PWR_EnterOffMode(void)
{
/* USER CODE BEGIN PWR_EnterOffMode_1 */

/* USER CODE END PWR_EnterOffMode_1 */
  /**
   * The systick should be disabled for the same reason than when the device enters stop mode because
   * at this time, the device may enter either OffMode or StopMode.
   */
  HAL_SuspendTick();
[#if DIE == "DIE494"]
  __HAL_RCC_CLEAR_RESET_FLAGS();
[/#if]

  EnterLowPower();

  /************************************************************************************
   * ENTER OFF MODE
   ***********************************************************************************/
  /*
   * There is no risk to clear all the WUF here because in the current implementation, this API is called
   * in critical section. If an interrupt occurs while in that critical section before that point,
   * the flag is set and will be cleared here but the system will not enter Off Mode
   * because an interrupt is pending in the NVIC. The ISR will be executed when moving out
   * of this critical section
   */
  LL_PWR_ClearFlag_WU();

  LL_PWR_SetPowerMode(LL_PWR_MODE_STANDBY);

  LL_LPM_EnableDeepSleep(); /**< Set SLEEPDEEP bit of Cortex System Control Register */

  /**
   * This option is used to ensure that store operations are completed
   */
#if defined (__CC_ARM) || defined (__ARMCC_VERSION)
  __force_stores();
#endif

[#if DIE == "DIE494"]
#if (CFG_LPM_STANDBY_SUPPORTED != 0)
  LL_EXTI_EnableRisingTrig_32_63(LL_EXTI_LINE_40);
  LL_EXTI_EnableEvent_32_63(LL_EXTI_LINE_40);

  STBY_AppHwSave();
  STBY_SysHwSave();

  CPUcontextSave();/* this function will call WFI instruction */
#endif
[#else]
  __WFI();
[/#if]

/* USER CODE BEGIN PWR_EnterOffMode_2 */

/* USER CODE END PWR_EnterOffMode_2 */
  return;
}

/**
  * @brief Exits Low Power Off Mode
  * @param none
  * @retval none
  */
void PWR_ExitOffMode(void)
{
/* USER CODE BEGIN PWR_ExitOffMode_1 */

/* USER CODE END PWR_ExitOffMode_1 */
[#if DIE == "DIE494"]
#if (CFG_LPM_STANDBY_SUPPORTED != 0)
  if(STBY_BootStatus != 0)
  {
    STBY_SysHwRestore();
    ExitLowPower_standby();
    STBY_AppHwRestore();
  }
  else
  {
    ExitLowPower();
  }
#endif
[#else]
  HAL_ResumeTick();
[/#if]
/* USER CODE BEGIN PWR_ExitOffMode_2 */

/* USER CODE END PWR_ExitOffMode_2 */
  return;
}

/**
  * @brief Enters Low Power Stop Mode
  * @note ARM exists the function when waking up
  * @param none
  * @retval none
  */
void PWR_EnterStopMode(void)
{
/* USER CODE BEGIN PWR_EnterStopMode_1 */

/* USER CODE END PWR_EnterStopMode_1 */
  /**
   * When HAL_DBGMCU_EnableDBGStopMode() is called to keep the debugger active in Stop Mode,
   * the systick shall be disabled otherwise the cpu may crash when moving out from stop mode
   *
   * When in production, the HAL_DBGMCU_EnableDBGStopMode() is not called so that the device can reach best power consumption
   * However, the systick should be disabled anyway to avoid the case when it is about to expire at the same time the device enters
   * stop mode (this will abort the Stop Mode entry).
   */
  HAL_SuspendTick();

  /**
   * This function is called from CRITICAL SECTION
   */
  EnterLowPower();

  /************************************************************************************
   * ENTER STOP MODE
   ***********************************************************************************/
[#if DIE == "DIE494"]
  LL_PWR_SetPowerMode(LL_PWR_MODE_STOP1);
[#else]
  LL_PWR_SetPowerMode(LL_PWR_MODE_STOP2);
[/#if]

  LL_LPM_EnableDeepSleep(); /**< Set SLEEPDEEP bit of Cortex System Control Register */

  /**
   * This option is used to ensure that store operations are completed
   */
#if defined (__CC_ARM) || defined (__ARMCC_VERSION)
  __force_stores();
#endif

  __WFI();

/* USER CODE BEGIN PWR_EnterStopMode_2 */

/* USER CODE END PWR_EnterStopMode_2 */
  return;
}

/**
  * @brief Exits Low Power Stop Mode
  * @note Enable the pll at 32MHz
  * @param none
  * @retval none
  */
void PWR_ExitStopMode(void)
{
/* USER CODE BEGIN PWR_ExitStopMode_1 */

/* USER CODE END PWR_ExitStopMode_1 */
  /**
   * This function is called from CRITICAL SECTION
   */
  ExitLowPower();

  HAL_ResumeTick();
/* USER CODE BEGIN PWR_ExitStopMode_2 */

/* USER CODE END PWR_ExitStopMode_2 */
  return;
}

/**
  * @brief Enters Low Power Sleep Mode
  * @note ARM exits the function when waking up
  * @param none
  * @retval none
  */
void PWR_EnterSleepMode(void)
{
/* USER CODE BEGIN PWR_EnterSleepMode_1 */

/* USER CODE END PWR_EnterSleepMode_1 */

  HAL_SuspendTick();

  /************************************************************************************
   * ENTER SLEEP MODE
   ***********************************************************************************/
  LL_LPM_EnableSleep(); /**< Clear SLEEPDEEP bit of Cortex System Control Register */

  /**
   * This option is used to ensure that store operations are completed
   */
#if defined (__CC_ARM) || defined (__ARMCC_VERSION)
  __force_stores();
#endif

  __WFI();
/* USER CODE BEGIN PWR_EnterSleepMode_2 */

/* USER CODE END PWR_EnterSleepMode_2 */
  return;
}

/**
  * @brief Exits Low Power Sleep Mode
  * @note ARM exits the function when waking up
  * @param none
  * @retval none
  */
void PWR_ExitSleepMode(void)
{
/* USER CODE BEGIN PWR_ExitSleepMode_1 */

/* USER CODE END PWR_ExitSleepMode_1 */
  HAL_ResumeTick();
/* USER CODE BEGIN PWR_ExitSleepMode_2 */

/* USER CODE END PWR_ExitSleepMode_2 */
  return;
}

[#if DIE == "DIE494"]
/**
* @brief Weak CPUcontextSave function definition to implement in startup file.
* @param none
* @retval none
*/
__WEAK void CPUcontextSave(void)
{
#if (CFG_LPM_STANDBY_SUPPORTED != 0)
  /*
   * If you are here, you have to update your startup_stm32wb15xx_cm4.s file to
   * implement CPUcontextSave function like done in latest STM32CubeWB package
   * into STM32WB15 BLE applications.
   */
  Error_Handler();
#endif

  return;
}
[/#if]

/*************************************************************
 *
 * LOCAL FUNCTIONS
 *
 *************************************************************/
/**
  * @brief Setup the system to enter either stop or off mode
  * @param none
  * @retval none
  */
static void EnterLowPower(void)
{
  /**
   * This function is called from CRITICAL SECTION
   */

  while(LL_HSEM_1StepLock(HSEM, CFG_HW_RCC_SEMID));

  if (! LL_HSEM_1StepLock(HSEM, CFG_HW_ENTRY_STOP_MODE_SEMID))
  {
    if(LL_PWR_IsActiveFlag_C2DS() || LL_PWR_IsActiveFlag_C2SB())
    {
      /* Release ENTRY_STOP_MODE semaphore */
      LL_HSEM_ReleaseLock(HSEM, CFG_HW_ENTRY_STOP_MODE_SEMID, 0);

      Switch_On_HSI();
      __HAL_FLASH_SET_LATENCY(FLASH_LATENCY_0);
    }
  }
  else
  {
    Switch_On_HSI();
    __HAL_FLASH_SET_LATENCY(FLASH_LATENCY_0);
  }

  /* Release RCC semaphore */
  LL_HSEM_ReleaseLock(HSEM, CFG_HW_RCC_SEMID, 0);

  return;
}

/**
  * @brief Restore the system to exit stop mode
  * @param none
  * @retval none
  */
static void ExitLowPower(void)
{
  /* Release ENTRY_STOP_MODE semaphore */
  LL_HSEM_ReleaseLock(HSEM, CFG_HW_ENTRY_STOP_MODE_SEMID, 0);

  while(LL_HSEM_1StepLock(HSEM, CFG_HW_RCC_SEMID));

  if(LL_RCC_GetSysClkSource() == LL_RCC_SYS_CLKSOURCE_STATUS_HSI)
  {
/* Restore the clock configuration of the application in this user section */ 
/* USER CODE BEGIN ExitLowPower_1 */

/* USER CODE END ExitLowPower_1 */
  }
  else
  {
/* If the application is not running on HSE restore the clock configuration in this user section */
/* USER CODE BEGIN ExitLowPower_2 */

/* USER CODE END ExitLowPower_2 */
  }
[#if DIE == "DIE494"]
#if (CFG_LPM_STANDBY_SUPPORTED != 0)

  __HAL_PWR_CLEAR_FLAG(PWR_FLAG_SB);
#endif
[/#if]
  
  /* Release RCC semaphore */
  LL_HSEM_ReleaseLock(HSEM, CFG_HW_RCC_SEMID, 0);

  return;
}

[#if DIE == "DIE494"]
#if (CFG_LPM_STANDBY_SUPPORTED != 0)
/**
  * @brief Restore the system to exit standby mode
  * @param none
  * @retval none
  */
static void ExitLowPower_standby(void)
{
/* Release ENTRY_STOP_MODE semaphore */
  LL_HSEM_ReleaseLock(HSEM, CFG_HW_ENTRY_STOP_MODE_SEMID, 0);
  
  while(LL_HSEM_1StepLock(HSEM, CFG_HW_RCC_SEMID));
/* USER CODE BEGIN ExitLowPower_standby */

/* USER CODE END ExitLowPower_standby */
  __HAL_PWR_CLEAR_FLAG(PWR_FLAG_SB);

  /* Release RCC semaphore */
  LL_HSEM_ReleaseLock(HSEM, CFG_HW_RCC_SEMID, 0);

  return;
}
#endif
[/#if]

/**
  * @brief Switch the system clock on HSI
  * @param none
  * @retval none
  */
static void Switch_On_HSI(void)
{
  LL_RCC_HSI_Enable();
  while(!LL_RCC_HSI_IsReady());
  LL_RCC_SetSysClkSource(LL_RCC_SYS_CLKSOURCE_HSI);
[#if (WB_LINE != "STM32WBx0 Value Line")]
  LL_RCC_SetSMPSClockSource(LL_RCC_SMPS_CLKSOURCE_HSI);
[/#if]
  while (LL_RCC_GetSysClkSource() != LL_RCC_SYS_CLKSOURCE_STATUS_HSI);
  return;
}

/* USER CODE BEGIN Private_Functions */

/* USER CODE END Private_Functions */

