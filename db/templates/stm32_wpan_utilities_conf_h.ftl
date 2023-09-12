[#ftl]
/**
 ******************************************************************************
  * File Name          : ${name}
  * Description        : Utilities configuration file for BLE 
  *                      middleWare.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
[#assign THREAD = 0]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if (definition.name == "THREAD") && (definition.value == "Enabled")]
                [#assign THREAD = 1]
            [/#if]
        [/#list]
    [/#if]
[/#list]


/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef UTILITIES_CONF_H
#define UTILITIES_CONF_H

#include "app_conf.h"
[#if THREAD = 1 ]
#include "app_thread.h"
[/#if]

/******************************************************************************
 * OTP manager
 ******************************************************************************/
#define CFG_OTP_BASE_ADDRESS    OTP_AREA_BASE

#define CFG_OTP_END_ADRESS      OTP_AREA_END_ADDR


/******************************************************************************
 * Scheduler
 ******************************************************************************/

#define SCH_CONF_TASK_NBR    CFG_TASK_NBR

#define SCH_CONF_PRIO_NBR    CFG_PRIO_NBR

/******************************************************************************
 * Debug Trace
 ******************************************************************************/
/**
 * When DBG_TRACE_FULL is set to 1, the trace are output with the API name, the file name and the line number
 * When DBG_TRACE_LIGTH is set to 1, only the debug message is output
 *
 * When both are set to 0, no trace are output
 * When both are set to 1,  DBG_TRACE_FULL is selected
 */
#define DBG_TRACE_LIGTH     1
#define DBG_TRACE_FULL      0

#if (( CFG_DEBUG_TRACE != 0 ) && ( DBG_TRACE_LIGTH == 0 ) && (DBG_TRACE_FULL == 0))
#undef DBG_TRACE_FULL
#undef DBG_TRACE_LIGTH
#define DBG_TRACE_FULL      0
#define DBG_TRACE_LIGTH     1
#endif

#if ( CFG_DEBUG_TRACE == 0 )
#undef DBG_TRACE_FULL
#undef DBG_TRACE_LIGTH
#define DBG_TRACE_FULL      0
#define DBG_TRACE_LIGTH     0
#endif

/**
 * When not set, the traces is looping on sending the trace over UART
 */
#define DBG_TRACE_USE_CIRCULAR_QUEUE 1

/**
 * max buffer Size to queue data traces and max data trace allowed.
 * Only Used if DBG_TRACE_USE_CIRCULAR_QUEUE is defined
 */
#define DBG_TRACE_MSG_QUEUE_SIZE 4096
#define MAX_DBG_TRACE_MSG_SIZE 1024

#endif /*UTILITIES_CONF_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
