[#ftl]

[#---------------------------]
[#-- DTS U-BOOT generation --]
[#---------------------------]
[@gen_uboot /]
[#--------------------------]
[#macro gen_uboot]
[#local module = "gen_uboot"]
/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause*/
/*
 * Copyright (C) ${year}, STMicroelectronics - All Rights Reserved
 * Author: STM32CubeMX code generation for STMicroelectronics.
 */

#include <dt-bindings/clock/stm32mp1-clksrc.h>
[#if mx_ddrConfigs["general"]?? && mx_ddrConfigs["general"]["isConfigured"]?? && mx_ddrConfigs["general"]["isConfigured"]=="true" ]
	[#if mxDtDM.dts_ddrConfigFileName??]
#include "${mxDtDM.dts_ddrConfigFileName}"
	[#else]
		[@mlog  logMod=module logType="WARN" logMsg="DDR not configured: unknown DDR config include" varsMap={} /]
/*#include "???"*/
	[/#if]
[/#if]

[#if mx_socFtRPNSuperset?has_content && mxDtDM.dts_fileNameSuffix?has_content]
#include "${mx_socFtRPNSuperset}${mxDtDM.dts_fileNameSuffix}.dtsi"
[#else]
	[@mlog  logMod=module logType="ERR" logMsg="unknown 'U-BOOT' dtsi" varsMap={} /]
/*#include "???.dtsi"*/
[/#if]
[#if mx_ddrConfigs["general"]?? && mx_ddrConfigs["general"]["isConfigured"]?? && mx_ddrConfigs["general"]["isConfigured"]=="true" ]
	[#if mx_socDtRPN?has_content]
#include "${mx_socDtRPN}-ddr.dtsi"
	[#else]
	[@mlog  logMod=module logType="ERR" logMsg="unknown DDR dtsi" varsMap={} /]
/*#include "???-ddr.dtsi"*/
	[/#if]
[#else]
	[@mlog  logMod=module logType="WARN" logMsg="DDR not configured: unknown DDR dtsi" varsMap={} /]
/*#include "???-ddr.dtsi"*/
[/#if]

/* USER CODE BEGIN includes */
/* USER CODE END includes */


/ {

	/* USER CODE BEGIN root */
	/* USER CODE END root */

	[#--clock Tree--]
	[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsMatchingBindedHwName(mxDtDM.dts_bindedElmtsList, "clocks") pDtLevel=0 pOrdering=true/]

}; /*root*/


[#--pinctrl--]
[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsMatchingBindedHwName(mxDtDM.dts_bindedElmtsList, "pinctrl") pDtLevel=0 pOrdering=true/]


[#--RCC node--]
[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsMatchingBindedHwName(mxDtDM.dts_bindedElmtsList, "rcc_cfg") pDtLevel=0 pOrdering=true/]

[#--dts level elmts--]
[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getDeviceElmtsByPath(mxDtDM.dts_bindedElmtsList, "") pDtLevel=0 pOrdering=true/][#--get only "dts" level elmts--]


/* USER CODE BEGIN addons */
/* USER CODE END addons */

[/#macro]