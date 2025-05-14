[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_debug_signal_def.h
  * @author  MCD Application Team
  * @brief   Real Time Debug module application signal definition
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* This header is part of the RTDebug module mechanisim.
 * In this file, application global debug signals can be 
 * define by the user without modyfing files in the module core.
 *
 * There is no need to add this header file as include file 
 * in the application files. This is handled by the module itself.
 */

#if (USE_RT_DEBUG_APP_APPE_INIT == 1)
  RT_DEBUG_APP_APPE_INIT,
#endif /* USE_RT_DEBUG_APP_APPE_INIT */
