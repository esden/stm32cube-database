[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_log.h
  * @author  GPM WBL Application Team
  * @brief   Optional logging of internal debug messages of the Sigfox STM32WL3 support library.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#ifndef _WL3SFX_LOG
#define _WL3SFX_LOG

/**
 * @addtogroup WL3SFX
 * @{
 * @addtogroup WL3SFX_LOG Debug Logging Utilities
 * @brief Helpers for generating useful, colored debug output via printf
 * @{
 */

typedef enum { WL3SFX_SEV_TRACE = 0, WL3SFX_SEV_INFO, WL3SFX_SEV_WARN, WL3SFX_SEV_ERROR } WL3SFX_Severity;

#ifdef WL3SFX_LOG_ENABLE
void _log_severity(WL3SFX_Severity sev);
void wl3sfx_log_func(WL3SFX_Severity sev, const char* fname, const char* fmt, ...);
void wl3sfx_log_bytearray_func(WL3SFX_Severity sev, const char* fname, const char* msg, const unsigned char* array, unsigned int size);

#define wl3sfx_log(sev, fmt, ...) wl3sfx_log_func(sev, __func__, fmt, ##__VA_ARGS__)
#define wl3sfx_log_bytearray(sev, msg, array, size) wl3sfx_log_bytearray_func(sev, __func__, msg, array, size)
#else
#define wl3sfx_log(...)
#define wl3sfx_log_bytearray(...)
#endif

/** @}@} */

#endif