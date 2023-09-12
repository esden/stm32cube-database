[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    dbg_if.c
  * @author  MCD Application Team
  * @brief   routines for debug logging service needed by the BLE Host Stack
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include "stdio.h"
#include "ble_dbg_if.h"
#include "stm32_adv_trace.h"
#include "app_conf.h"

/* Private typedef -----------------------------------------------------------*/
/* Private defines -----------------------------------------------------------*/
/* Private macros ------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private functions prototypes-----------------------------------------------*/
/* Functions Definition ------------------------------------------------------*/
/**
 * @brief ble_dbg_log
 * This function is used by the ble host to print some Debug Traces
 * 
 * @param format: a list of printable arguments
 *
 */
void ble_dbg_log(char *format,...){
  
    char msg[SYS_MAX_MSG];
    
    va_list args;

    va_start(args, format );
    vsnprintf(msg, SYS_MAX_MSG-1, format, args);
    va_end(args);

   UTIL_ADV_TRACE_COND_FSend(VLEVEL_L, ~0x0, 0,msg);
  /* printf("%s",msg); */
  /* UNUSED_PARAMETER(format); */
}
