[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : adv_trace.h
  * Description        : header for trace for application that can displayed with color.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef ADV_TRACE_H
#define ADV_TRACE_H


/* Includes ------------------------------------------------------------------*/
#include "stdint.h"
#include "utilities_conf.h"

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported macros -----------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */

/**
 * @brief conditional FSend decode the strFormat & vaArgs and post it to the circular queue for printing
 * @param VerboseLevel verbose level of the trace
 * @param Region region of the trace
 * @param TimeStampState 0 no time stamp insertion, 1 time stamp inserted inside the trace data
 * @param strFormat formatted string
 * @param vaArgs list of arguments
 * @retval Status based on @ref UTIL_ADV_TRACE_Status_t
 */
UTIL_ADV_TRACE_Status_t ADV_TRACE_COND_FSend_WithArgList( uint32_t VerboseLevel, uint32_t Region, uint32_t TimeStampState, const char *strFormat, va_list vaArgs );

/**
 * @brief conditional FSend decode the strFormat and post it to the circular queue for printing
 * @param VerboseLevel verbose level of the trace
 * @param Region region of the trace
 * @param TimeStampState 0 no time stamp insertion, 1 time stamp inserted inside the trace data
 * @param strFormat formatted string
 * @retval Status based on @ref UTIL_ADV_TRACE_Status_t
 */
UTIL_ADV_TRACE_Status_t ADV_TRACE_COND_FSend( uint32_t VerboseLevel, uint32_t Region,uint32_t TimeStampState, const char *strFormat, ... );

/**
 *  @brief  Function Trace used when debug is not possible (LowPower). 
 *          That permits to do not have the warning 'variable "xx" was set but never used'
 *
 * @param strFormat formatted string
 * @retval Always UTIL_ADV_TRACE_OK
 */
UTIL_ADV_TRACE_Status_t ADV_TRACE_COND_NoSend( const char * strFormat, ... );

#endif /*ADV_TRACE_H */
