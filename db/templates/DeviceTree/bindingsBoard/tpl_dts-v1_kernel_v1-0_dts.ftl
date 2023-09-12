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

/* For more information on Device Tree configuration, please refer to
 * https://wiki.st.com/stm32mpu/wiki/Category:Device_tree_configuration
 */

/dts-v1/;
#include <dt-bindings/pinctrl/stm32-pinfunc.h>

[#if mx_socFtRPN?has_content]
#include "${mx_socFtRPN}.dtsi"
[#else]
	[@mlog  logMod=module logType="ERR" logMsg="unknown SOC dtsi" varsMap={} /]
/*#include "???.dtsi"*/
[/#if]
[#if mx_socRPN?has_content]
#include "${mx_socRPN?substring(0,9) + "x" + mx_socRPN?substring(10)}.dtsi"
[#else]
	[@mlog  logMod=module logType="ERR" logMsg="unknown SOC package dtsi" varsMap={} /]
/*#include "???.dtsi"*/
[/#if]
[#if (mx_socDtRPN == "stm32mp15")]
	[#if mx_socPtCPN?has_content]
#include "${mx_socPtCPN?substring(0,9) + "xx" + mx_socPtCPN?substring(11)}-pinctrl.dtsi"
	[#else]
		[@mlog  logMod=module logType="ERR" logMsg="unknown SOC pinCtrl package dtsi" varsMap={} /]
/*#include "???-pinctrl.dtsi"*/
	[/#if]
[/#if]
[#local coproDeviceName = srvcmx_getMatchingBindedHwName_inDTS(".+_copro")]
[#if coproDeviceName?has_content][#--at least 1 IP should be assigned--]
	[#local coproName = coproDeviceName?replace("_copro", "")]
#include "${mx_socDtRPN}-${coproName}-srm.dtsi"
[/#if]

/* USER CODE BEGIN includes */
/* USER CODE END includes */


/ {
	[#if mx_boardName_uppercase?has_content]
		[#local manifestVersion = srvcmx_getManifestVersion()]
		[#if manifestVersion?has_content]
	model = "STMicroelectronics ${mx_boardName_uppercase} STM32CubeMX board - ${manifestVersion}";
		[#else]
	model = "STMicroelectronics ${mx_boardName_uppercase} STM32CubeMX board";
		[/#if]
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
	[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsMatchingBindedHwName(mxDtDM.dts_bindedElmtsList, "clocks") pDtLevel=1 pOrdering=true/]


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
