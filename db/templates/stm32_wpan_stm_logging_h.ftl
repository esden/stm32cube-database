[#ftl]
/**
 ******************************************************************************
  * File Name          : ${name}
  * Description        : Application header file for logging
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

#ifndef STM_LOGGING_H_
#define STM_LOGGING_H_

#define LOG_LEVEL_NONE  0  /* None     */
#define LOG_LEVEL_CRIT  1U  /* Critical */
#define LOG_LEVEL_WARN  2U  /* Warning  */
#define LOG_LEVEL_INFO  3U  /* Info     */
#define LOG_LEVEL_DEBG  4U  /* Debug    */

#define APP_DBG_FULL(level, region, ...)                                                    \
  {                                                                                         \
    if (APPLI_PRINT_FILE_FUNC_LINE == 1U)                                                   \
    {                                                                                       \
        printf("\r\n[%s][%s][%d] ", DbgTraceGetFileName(__FILE__),__FUNCTION__,__LINE__);   \
    }                                                                                       \
    logApplication(level, region, __VA_ARGS__);                                             \
  }
#define APP_DBG(...)                                                                        \
  {                                                                                         \
    if (APPLI_PRINT_FILE_FUNC_LINE == 1U)                                                   \
    {                                                                                       \
        printf("\r\n[%s][%s][%d] ", DbgTraceGetFileName(__FILE__),__FUNCTION__,__LINE__);   \
    }                                                                                       \
    logApplication(LOG_LEVEL_NONE, APPLI_LOG_REGION_GENERAL, __VA_ARGS__);                  \
  }
/**
 * This enumeration represents log regions.
 *
 */
typedef enum 
{
  APPLI_LOG_REGION_GENERAL                    = 1U,  /* General                 */
  APPLI_LOG_REGION_OPENTHREAD_API             = 2U,  /* OpenThread API          */
  APPLI_LOG_REGION_OT_API_LINK                = 3U,  /* OpenThread Link API     */
  APPLI_LOG_REGION_OT_API_INSTANCE            = 4U,  /* OpenThread Instance API */
  APPLI_LOG_REGION_OT_API_MESSAGE             = 5U   /* OpenThread Message API  */
} appliLogRegion_t;

typedef uint8_t appliLogLevel_t;

void logApplication(appliLogLevel_t aLogLevel, appliLogRegion_t aLogRegion, const char *aFormat, ...);

#endif  /* STM_LOGGING_H_ */