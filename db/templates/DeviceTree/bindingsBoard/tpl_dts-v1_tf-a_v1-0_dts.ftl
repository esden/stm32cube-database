[#ftl]

[#---------------------------]
[#-- DTS TF-A generation --]
[#---------------------------]
[@gen_tfa /]
[#--------------------------]
[#macro gen_tfa]
[#local module = "gen_tfa"]
/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
/*
 * Copyright (C) STMicroelectronics ${year} - All Rights Reserved
 * Author: STM32CubeMX code generation for STMicroelectronics.
 */

/dts-v1/;
#include <dt-bindings/clock/stm32mp1-clksrc.h>
[#if mx_ddrConfigs["general"]?? && mx_ddrConfigs["general"]["isConfigured"]?? && mx_ddrConfigs["general"]["isConfigured"]=="true" ]
	[#if mxDtDM.dts_ddrConfigFileName??]
#include "${mxDtDM.dts_ddrConfigFileName}"
	[#else]
		[@mlog  logMod=module logType="ERR" logMsg="unknown DDR config include" varsMap={} /]
/*#include "???"*/
	[/#if]
[/#if]

[#if mx_socRPNSuperset?has_content]
#include "${mx_socRPNSuperset}.dtsi"
[#else]
	[@mlog  logMod=module logType="ERR" logMsg="unknown SOC dtsi" varsMap={} /]
/*#include "???.dtsi"*/
[/#if]
[#if mx_socRPNSuperset?has_content]
#include "${mx_socRPNSuperset}${mx_socPackageType}-pinctrl.dtsi"
[#else]
	[@mlog  logMod=module logType="ERR" logMsg="unknown SOC pinCtrl dtsi" varsMap={} /]
/*#include "???-pinctrl.dtsi"*/
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
[#if mx_socRPNSuperset?has_content]
#include "${mx_socRPNSuperset}-security.dtsi"
[#else]
	[@mlog  logMod=module logType="ERR" logMsg="unknown SOC security dtsi" varsMap={} /]
/*#include "???-security.dtsi"*/
[/#if]

/* USER CODE BEGIN includes */
/* USER CODE END includes */


/ {
	[#if mx_boardName_uppercase?has_content]
	model = "STMicroelectronics ${mx_boardName_uppercase} STM32CubeMX board";
	[#else]
		[@mlog  logMod=module logType="ERR" logMsg="unknown board type: 'model' not generated" varsMap={} /]
	/*model = "STMicroelectronics unknown STM32CubeMX board";*/
	[/#if]
	[#if mx_socRPN?has_content && mx_socFtRPN?has_content && mx_projectName?has_content]
	compatible = "st,${mx_socRPN}-${mx_projectName}-mx", "st,${mx_socFtRPN}";
	[#else]
		[@mlog  logMod=module logType="ERR" logMsg="compatible' not generated" varsMap={} /]
	/*compatible = "st,???-mx", "st,???";*/
	[/#if]

	/* USER CODE BEGIN root */
	/* USER CODE END root */

	[#--clock Tree--]
	[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsMatchingBindedHwName(mxDtDM.dts_bindedElmtsList, "clocks") pDtLevel=0 pOrdering=true/]

	[#--other root subnodes--]
	[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsByPath(mxDtDM.dts_bindedElmtsList, "/") pDtLevel=1 pOrdering=true/]	[#--get only "root" level elmts--]

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
