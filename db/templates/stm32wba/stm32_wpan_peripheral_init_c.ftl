[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    peripheral_init.c
  * @author  MCD Application Team
  * @brief   tbd module
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include "peripheral_init.h"

/**
  * @brief  Configure the SoC peripherals at Standby mode exit.
  * @param  None
  * @retval None
  */
void MX_StandbyExit_PeripharalInit(void)
{
  /* USER CODE BEGIN MX_STANDBY_EXIT_PERIPHERAL_INIT_1 */

  /* USER CODE END MX_STANDBY_EXIT_PERIPHERAL_INIT_1 */

[#assign PreviousIpHandler = ""]
[#if handlersList??]
  [#list handlersList as handler]
    [#list handler.entrySet() as entry]
      [#list entry.value as ipHandler]
		[#if ipHandler.handler != "hrtc"]
			[#if ipHandler.handler != PreviousIpHandler]
${""?right_pad(2)}memset(&${ipHandler.handler}, 0, sizeof(${ipHandler.handler}));
				[#assign PreviousIpHandler = ipHandler.handler]
			[/#if]
		[/#if]
    [/#list]
  [/#list]
[/#list]
[/#if]

[#if voidsList??]
  [#list voidsList as void]
	[#if void.functionName??]
		[#if (void.functionName != "SystemClock_Config") 
		  && (void.functionName != "SystemPower_Config")
		  && (void.functionName != "MX_RTC_Init")
		  && (void.functionName != "APPE_Init")
		  && (void.functionName != "MX_RF_Init")
		  && (void.functionName != "MX_CORTEX_M33_NS_Init")
		]
${""?right_pad(2)}${void.functionName}();
		[/#if]
	[/#if]
  [/#list]
[/#if]

  /* USER CODE BEGIN MX_STANDBY_EXIT_PERIPHERAL_INIT_2 */

  /* USER CODE END MX_STANDBY_EXIT_PERIPHERAL_INIT_2 */
}
