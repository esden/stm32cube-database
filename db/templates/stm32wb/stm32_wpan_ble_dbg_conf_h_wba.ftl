[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    dbg_conf.h
  * @author  MCD Application Team
  * @brief   Debug configuration file for BLE Middleware.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef BLE_DBG_CONF_H
#define BLE_DBG_CONF_H

/**
 * Enable or Disable traces from BLE
 */

[#list SWIPdatas as SWIP]
	[#if SWIP.defines??]
		[#list SWIP.defines as definition]
			[#if definition.name="BLE_DBG_APP_EN"]
				[#lt]#define ${definition.name}             ${definition.value}
			[/#if]
		[/#list]
	[/#if]
[/#list]

/**
 * Macro definition
 */
#if (BLE_DBG_APP_EN != 0)
#define BLE_DBG_APP_MSG             PRINT_MESG_DBG
#else
#define BLE_DBG_APP_MSG             PRINT_NO_MESG
#endif

#endif /*BLE_DBG_CONF_H */
