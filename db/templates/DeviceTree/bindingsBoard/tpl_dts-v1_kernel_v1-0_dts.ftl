[#ftl]

[#---------------------------]
[#-- DTS kernel generation --]
[#---------------------------]
[@gen_kernel /]
[#--------------------------]
[#macro gen_kernel]
[#local module = "gen_kernel"]
/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
/*
 * Copyright (C) STMicroelectronics ${year} - All Rights Reserved
 * Author: STM32CubeMX code generation for STMicroelectronics.
 */

/dts-v1/;
[#if mx_socRPNSuperset?has_content]
#include "${mx_socRPNSuperset}.dtsi"
[#else]
	[@mlog  logMod=module logType="ERR" logMsg="unknown SOC dtsi" varsMap={} /]
/*#include "???.dtsi"*/
[/#if]
[#local coproDeviceName = srvcmx_getMatchingBindedHwName_inDTS(".+_copro")]
[#if coproDeviceName?has_content][#--at least 1 IP should be assigned--]
	[#local coproName = coproDeviceName?replace("_copro", "")]
#include "${mx_socRPNSuperset}-${coproName}-srm.dtsi"
[/#if]
[#if mx_socRPNSuperset?has_content]
#include "${mx_socRPNSuperset}${mx_socPackageType}-pinctrl.dtsi"
[#else]
	[@mlog  logMod=module logType="ERR" logMsg="unknown SOC pinCtrl dtsi" varsMap={} /]
/*#include "???-pinctrl.dtsi"*/
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

	[#--memory mapping--]
	[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsMatchingBindedHwName(mxDtDM.dts_bindedElmtsList, "memories") pDtLevel=0 pOrdering=true/]
	[@bind_memories pDtLevel=1 /]


	/* USER CODE BEGIN root */
	/* USER CODE END root */

	[#--clock Tree--]
	[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsMatchingBindedHwName(mxDtDM.dts_bindedElmtsList, "clocks") pDtLevel=0 pOrdering=true/]


	[#--Bind other root subelmts--]
	[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsByPath(mxDtDM.dts_bindedElmtsList, "/") pDtLevel=1 pOrdering=true/] [#--get only "root" level elmts--]

}; /*root*/



[#--pinctrl--]
[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsMatchingBindedHwName(mxDtDM.dts_bindedElmtsList, "pinctrl") pDtLevel=0 pOrdering=true/]


[#--dts level elmts--]
[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getDeviceElmtsByPath(mxDtDM.dts_bindedElmtsList, "") pDtLevel=0 pOrdering=true/][#--get only "dts" level elmts--]


/* USER CODE BEGIN addons */
/* USER CODE END addons */

[/#macro]
