#include "app_sys.h"
#include "app_conf.h"
#include "timer_if.h"
#include "stm32_lpm.h"
#include "stm32_seq.h"
#include "ll_intf.h"
#include "ll_sys.h"

extern uint8_t is_Radio_DeepSleep;

#if (CFG_LPM_STDBY_SUPPORTED == 1)
static UTIL_TIMER_Object_t  sys_standby_tmr_id = {0};
static void start_sys_timer(const uint32_t next_wkup_time_us);
static void ExitStandby_clbk(void *arg);
#endif

void APP_SYS_LPM_Init(void)
{  
#if (CFG_LPM_STDBY_SUPPORTED == 1)
  UTIL_TIMER_Status_t util_tmr_status = UTIL_TIMER_UNKNOWN_ERROR;
  
  /* Timer to exit from standby (based on RTC) */
  util_tmr_status = UTIL_TIMER_Create(&sys_standby_tmr_id,
                                      0, //Defined later
                                      UTIL_TIMER_ONESHOT,
                                      &ExitStandby_clbk,
                                      NULL
                                      );
  assert_param(util_tmr_status == UTIL_TIMER_OK);
#endif  
}

#if (CFG_LPM_STDBY_SUPPORTED == 1)
/**
  * @brief  Checks next system wakeup, if far enough in the future,
  *         start a timer, and enter in standby mode.
  * @param  next_wkup_time_us:
  * @retval None
  */
static void start_sys_timer(const uint32_t next_wkup_time_us)
{
  UTIL_TIMER_Status_t util_tmr_status;

  if (next_wkup_time_us > SYSTEM_IDLE_THRESHOLD_US)
  {
    UTIL_TIMER_Stop(&sys_standby_tmr_id);
    util_tmr_status = UTIL_TIMER_SetPeriod(&sys_standby_tmr_id,
                                           (uint32_t)(next_wkup_time_us / 1000) );
    (void)util_tmr_status;

    util_tmr_status = UTIL_TIMER_Start(&sys_standby_tmr_id);
    (void)util_tmr_status;

    UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_ENABLE);

    /* Clear Status Flag */
    LL_PWR_ClearFlag_SB();
    LL_RCC_ClearResetFlags();
  }
  else
  {
    UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);
  }
}

static void ExitStandby_clbk(void *arg)
{
  /* User code here */
}
#endif

void APP_SYS_LPM_EnterLowPowerMode(void)
{
  ble_stat_t cmd_status = GENERAL_FAILURE;
  uint32_t radio_remaining_time = 0;

  if (is_Radio_DeepSleep == 0U) //TODO Call HAL_PWREx_GetRADIOOperatingMode instead?
  {
    /* Enable radio to retrieve next radio activity */
    ll_sys_radio_hclk_ctrl_req(LL_SYS_RADIO_HCLK_PREIDLE, LL_SYS_RADIO_HCLK_ON);

    cmd_status = ll_intf_le_get_remaining_time_for_next_event(&radio_remaining_time);
    assert_param(cmd_status == SUCCESS);

    if (radio_remaining_time > RADIO_IDLE_THRESHOLD_US)
    {
      /* No event in a "near" futur */
      ll_sys_dp_slp_enter(radio_remaining_time - RADIO_IDLE_THRESHOLD_US);
    }
    ll_sys_radio_hclk_ctrl_req(LL_SYS_RADIO_HCLK_PREIDLE, LL_SYS_RADIO_HCLK_OFF);

#if (CFG_LPM_STDBY_SUPPORTED == 1)    
    if (is_Radio_DeepSleep == 0U)
    {
      UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);
      return;
    }
    else
    {
      if (radio_remaining_time > SYSTEM_IDLE_THRESHOLD_US)
        start_sys_timer(radio_remaining_time - 10);
      else
        UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);
    }
  }
  else
  {
    /* Next wakeup source: only radio activity here */
    ll_sys_radio_hclk_ctrl_req(LL_SYS_RADIO_HCLK_PREIDLE, LL_SYS_RADIO_HCLK_ON);
    cmd_status = ll_intf_le_get_remaining_time_for_next_event(&radio_remaining_time);
    assert_param(cmd_status == SUCCESS);
    
    ll_sys_radio_hclk_ctrl_req(LL_SYS_RADIO_HCLK_PREIDLE, LL_SYS_RADIO_HCLK_OFF);
 
    start_sys_timer(radio_remaining_time);
#endif    
  }
}