[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_sys.c
  * @author  MCD Application Team
  * @brief   Application system for STM32WPAN Middleware.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign myHash = {}]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
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

#include "app_sys.h"
#include "app_conf.h"
#include "timer_if.h"
#include "stm32_lpm.h"
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
#include "stm32_seq.h"
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
#include "app_threadx.h"
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
#include "cmsis_os.h"
[/#if]
#include "ll_intf.h"
#include "ll_sys.h"

void APP_SYS_BLE_EnterDeepSleep(void)
{
  ble_stat_t cmd_status = GENERAL_FAILURE;
  uint32_t radio_remaining_time = 0;

  if (ll_sys_dp_slp_get_state() == LL_SYS_DP_SLP_DISABLED)
  {
    /* Enable radio to retrieve next radio activity */

    /* Getting next radio event time if any */
    cmd_status = ll_intf_le_get_remaining_time_for_next_event(&radio_remaining_time);
    UNUSED(cmd_status);
    assert_param(cmd_status == SUCCESS);

    if (radio_remaining_time == LL_DP_SLP_NO_WAKEUP)
    {
      /* No next radio event scheduled */
      (void)ll_sys_dp_slp_enter(LL_DP_SLP_NO_WAKEUP);
    }
    else if (radio_remaining_time > RADIO_DEEPSLEEP_WAKEUP_TIME_US)
    {
      /* No event in a "near" futur */
      (void)ll_sys_dp_slp_enter(radio_remaining_time - RADIO_DEEPSLEEP_WAKEUP_TIME_US);
    }
  }
}
