[#ftl]
/**
 ******************************************************************************
  * File Name          : ${name}
  * Description        : Hardware Low Power Mode source file for BLE 
  *                      middleWare.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "app_common.h"
#include "hw_conf.h"

/* Private const -----------------------------------------------------------*/
const uint32_t HW_LPM_STOP_MODE[3] = {LL_PWR_MODE_STOP0, LL_PWR_MODE_STOP1, LL_PWR_MODE_STOP2};
const uint32_t HW_LPM_OFF_MODE[2] = {LL_PWR_MODE_STANDBY, LL_PWR_MODE_SHUTDOWN};

void HW_LPM_SleepMode(void)
{
  LL_LPM_EnableSleep(); /**< Clear SLEEPDEEP bit of Cortex System Control Register */

  /**
   * This option is used to ensure that store operations are completed
   */
#if defined ( __CC_ARM)
  __force_stores();
#endif

  __WFI();

  return;
}

void HW_LPM_StopMode(HW_LPM_StopModeConf_t configuration)
{
  LL_PWR_SetPowerMode(HW_LPM_STOP_MODE[configuration]);

  LL_LPM_EnableDeepSleep(); /**< Set SLEEPDEEP bit of Cortex System Control Register */

  /**
   * This option is used to ensure that store operations are completed
   */
#if defined ( __CC_ARM)
  __force_stores();
#endif

  __WFI();

  return;
}

void HW_LPM_OffMode(HW_LPM_OffModeConf_t configuration)
{
    /*
     * There is no risk to clear all the WUF here because in the current implementation, this API is called
     * in critical section. If an interrupt occurs while in that critical section before that point,
     * the flag is set and will be cleared here but the system will not enter Off Mode
     * because an interrupt is pending in the NVIC. The ISR will be executed when moving out
     * of this critical section
     */
    LL_PWR_ClearFlag_WU();

    LL_PWR_SetPowerMode(HW_LPM_OFF_MODE[configuration]);

    LL_LPM_EnableDeepSleep(); /**< Set SLEEPDEEP bit of Cortex System Control Register */

    /**
     * This option is used to ensure that store operations are completed
     */
#if defined ( __CC_ARM)
    __force_stores();
#endif

    __WFI();

  return;
}

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
