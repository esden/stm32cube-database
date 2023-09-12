[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ll_sys_sequencer_if.c
  * @author  MCD Application Team
  * @brief   Source file for initiating the system sequencer
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include "app_conf.h"
#include "ll_intf.h"
#include "ll_sys.h"
#include "stm32_seq.h"
#include "app_ble.h"

/**
  * @brief  Link Layer background process initialization
  * @param  None
  * @retval None
  */
void ll_sys_bg_process_init(void)
{
  /* Register tasks */
  UTIL_SEQ_RegTask( 1U << CFG_TASK_LINK_LAYER, UTIL_SEQ_RFU, ll_sys_bg_process);
}

/**
  * @brief  Link Layer background process next iteration scheduling
  * @param  None
  * @retval None
  */
void ll_sys_schedule_bg_process(void)
{
  UTIL_SEQ_SetTask(1U << CFG_TASK_LINK_LAYER, CFG_SCH_PRIO_0);
}

void ll_sys_config_ctx_params(void)
{
  ll_intf_config_ll_ctx_params(USE_RADIO_LOW_ISR,NEXT_EVENT_SCHEDULING_FROM_ISR);
}

void HostStack_Process(void)
{
  BleStackCB_Process();
}