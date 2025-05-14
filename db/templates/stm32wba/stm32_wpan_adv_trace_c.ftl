[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : adv_trace.c
  * Description        : trace for application that can displayed with color.
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
#include "stdarg.h"
#include "stdio.h"

#include "app_conf.h"

/* Private defines -----------------------------------------------------------*/
#define ENDOFLINE_SIZE          0x01u
#define ENDOFLINE_CHAR          '\n'

#define RTT_COLOR_CODE_DEFAULT  37    // Blanck
#define RTT_COLOR_CODE_RED      91
#define RTT_COLOR_CODE_GREEN    92
#define RTT_COLOR_CODE_YELLOW   93
#define RTT_COLOR_CODE_CYAN     96

/* Private macros ------------------------------------------------------------*/

/* Private typedef -----------------------------------------------------------*/

/* Private variables ---------------------------------------------------------*/
static uint8_t sztmp[UTIL_ADV_TRACE_TMP_BUF_SIZE];

/* Private function prototypes -----------------------------------------------*/

/* Functions Definition ------------------------------------------------------*/

/**
 *
 */
static uint16_t RegionToColor( char * szBuffer, uint32_t lRegion )
{
  uint8_t   cColor;
  
  switch  ( lRegion )
  {
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled")]
    case LOG_REGION_ZIGBEE:
        cColor = RTT_COLOR_CODE_GREEN;
        break;

    case LOG_REGION_MAC:
        cColor = RTT_COLOR_CODE_YELLOW;
        break;

[/#if]
    case LOG_REGION_LL:
        cColor = RTT_COLOR_CODE_RED;
        break;
        
    case LOG_REGION_APP:
    default:
        cColor = RTT_COLOR_CODE_DEFAULT;
        break;
  }
  
  if ( cColor == RTT_COLOR_CODE_DEFAULT )
    { sprintf( szBuffer, "\x1b[0m" ); }
  else
    { sprintf( szBuffer, "\x1b[0;%02dm", cColor ); }
  
  return( strlen( szBuffer ) );
}

/**
 *
 */
UTIL_ADV_TRACE_Status_t ADV_TRACE_COND_FSend_WithArgList(uint32_t VerboseLevel, uint32_t Region, uint32_t TimeStampState, const char *strFormat, va_list vaArgs )
{
  uint16_t  iBuffSize = 0u, iTempSize;
  UTIL_ADV_TRACE_Status_t eReturn = UTIL_ADV_TRACE_OK;
  
  /* Check verbose level */
  if ( VerboseLevel > APP_TRACE_LEVEL )
  {
    return UTIL_ADV_TRACE_GIVEUP;
  }

  /* Check Region */
  if ( ( Region & APP_TRACE_REGION ) != Region )
  {
    return UTIL_ADV_TRACE_REGIONMASKED;
  }
  
#if (CFG_DEBUGGER_SUPPORTED != 1)
  /* Add Colours */
  iBuffSize = RegionToColor( (char *)sztmp, Region );
#endif /* (CFG_DEBUGGER_SUPPORTED != 1) */
  
//  /* Add TimeStamp */
//  if( ( ADV_TRACE_Ctx.timestamp_func != NULL) && (TimeStampState != 0u ) )
//  {
//    ADV_TRACE_Ctx.timestamp_func( &sztmp[iBuffSize], &iTempSize );
//    iBuffSize += iTempSize;
//  }
  
  /* Copy the data */
  iTempSize = (uint16_t)UTIL_ADV_TRACE_VSNPRINTF( (char *)&sztmp[iBuffSize], UTIL_ADV_TRACE_TMP_BUF_SIZE, strFormat, vaArgs );
  iBuffSize += iTempSize;
  
  /* Add End Of Line if needed */
  if ( ( sztmp[iBuffSize - 1] != ENDOFLINE_CHAR ) && ( sztmp[iBuffSize - 2] != ENDOFLINE_CHAR ) )
  { 
    sztmp[iBuffSize++] = ENDOFLINE_CHAR;
    sztmp[iBuffSize] = 0;
  }
   
#if ( CFG_DEBUGGER_SUPPORTED == 1 )
  printf( (const char *)sztmp );
#else /* ( CFG_DEBUGGER_SUPPORTED == 1 ) */
  eReturn = UTIL_ADV_TRACE_COND_FSend( VerboseLevel, Region, TimeStampState, (const char *)sztmp );
#endif /* ( CFG_DEBUGGER_SUPPORTED == 1 ) */
  
  return(eReturn);
}

/**
 *
 */
UTIL_ADV_TRACE_Status_t ADV_TRACE_COND_FSend( uint32_t VerboseLevel, uint32_t Region, uint32_t TimeStampState, const char * strFormat, ... )
{
  va_list   vaArgs;
  UTIL_ADV_TRACE_Status_t eReturn;

  va_start(vaArgs, strFormat);
  eReturn = ADV_TRACE_COND_FSend_WithArgList( VerboseLevel, Region, TimeStampState, strFormat, vaArgs );
  va_end(vaArgs);
  
  return(eReturn);
}

/**
 *
 */
UTIL_ADV_TRACE_Status_t ADV_TRACE_COND_NoSend( const char * strFormat, ... )
{
  return(UTIL_ADV_TRACE_OK);
}
