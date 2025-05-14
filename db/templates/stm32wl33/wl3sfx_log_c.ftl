[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_log.c
  * @author  GPM WBL Application Team
  * @brief   Optional logging of internal debug messages of the Sigfox STM32WL3 support library.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stdarg.h>
#include <stdio.h>

#include "wl3sfx_log.h"

#ifdef WL3SFX_LOG_ENABLE

void _log_severity(WL3SFX_Severity sev)
{
  if (sev == WL3SFX_SEV_TRACE) {
    printf("\033[0;32m");
  } else if (sev == WL3SFX_SEV_INFO) {
    printf("\033[0;37m");
  } else if (sev == WL3SFX_SEV_WARN) {
    printf("\033[0;33m");
  } else if (sev == WL3SFX_SEV_ERROR) {
    printf("\033[0;31m");
  }
  printf("[wl3sfx]\033[0m");
}

void wl3sfx_log_func(WL3SFX_Severity sev, const char* fname, const char* fmt, ...)
{
  _log_severity(sev);
  printf("[%s] ", fname);

  va_list args;
  va_start(args, fmt);
  vprintf(fmt, args);
  va_end(args);

  printf("\r\n");
}

void wl3sfx_log_bytearray_func(WL3SFX_Severity sev, const char* fname, const char* msg, const unsigned char* array, unsigned int size)
{
  _log_severity(sev);
  printf("[%s] %s", fname, msg);

  for (unsigned int i = 0; i < size; ++i)
    printf("%02x", array[i]);
  printf("\r\n");
}

#endif