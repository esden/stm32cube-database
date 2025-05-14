[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_debug.h
  * @author  GPM WBL Application Team
  * @brief   Real Time Debug module application APIs and signal table
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#ifndef APP_DEBUG_H
#define APP_DEBUG_H

#include "RTDebug.h"

/***************************************************/
/** Specific application debug signals definition **/
/***************************************************/
typedef enum {
  APP_APPE_INIT,
  APP_STACK_PROCESS,
  APP_BLE_NOTIF,
  APP_BLE_NO_RESOURCES,
} app_debug_signal_t;

#if(RT_DEBUG_GPIO_MODULE == 1)

/************************************/
/** Application local signal table **/
/************************************/
static const rt_debug_signal_t app_debug_table[] = {
#if (USE_RT_DEBUG_APP_APPE_INIT == 1)
  [APP_APPE_INIT] = RT_DEBUG_APP_APPE_INIT,
#else
  [APP_APPE_INIT] = RT_DEBUG_SIGNAL_UNUSED,
#endif /* USE_RT_DEBUG_APP_APPE_INIT */
  
#if (USE_RT_DEBUG_APP_STACK_PROCESS == 1)
  [APP_STACK_PROCESS] = RT_DEBUG_APP_STACK_PROCESS,
#else
  [APP_STACK_PROCESS] = RT_DEBUG_SIGNAL_UNUSED,
#endif /* USE_RT_DEBUG_APP_STACK_PROCESS */
  
#if (USE_RT_DEBUG_APP_BLE_NOTIF == 1)
  [APP_BLE_NOTIF] = RT_DEBUG_APP_BLE_NOTIF,
#else
  [APP_BLE_NOTIF] = RT_DEBUG_SIGNAL_UNUSED,
#endif /* USE_RT_DEBUG_APP_BLE_NOTIF */
  
#if (USE_RT_DEBUG_APP_BLE_NO_RESOURCES == 1)
  [APP_BLE_NO_RESOURCES] = RT_DEBUG_APP_BLE_NO_RESOURCES,
#else
  [APP_BLE_NO_RESOURCES] = RT_DEBUG_SIGNAL_UNUSED,
#endif /* USE_RT_DEBUG_APP_BLE_NO_RESOURCES */
  
};

#endif /* RT_DEBUG_GPIO_MODULE */

/**************************************/
/** Application debug API definition **/
/**************************************/
void APP_DEBUG_SIGNAL_SET(app_debug_signal_t signal);
void APP_DEBUG_SIGNAL_RESET(app_debug_signal_t signal);
void APP_DEBUG_SIGNAL_TOGGLE(app_debug_signal_t signal);

/*******************************/
/** Debug GPIO Initialization **/
/*******************************/
void RT_DEBUG_GPIO_Init(void);

#endif /* APP_DEBUG_H */
