[#ftl]

[#---------------------------]
[#-- DTS OP-TEE generation --]
[#---------------------------]
[@gen_optee /]
[#--------------------------]
[#macro gen_optee]
[#local module = "gen_optee"]
// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
/*
 * Copyright (C) ${year}, STMicroelectronics - All Rights Reserved
 * Author: STM32CubeMX code generation for STMicroelectronics.
 */

/* For more information on Device Tree configuration, please refer to
 * https://wiki.st.com/stm32mpu/wiki/Category:Device_tree_configuration
 */

/dts-v1/;
#include <dt-bindings/pinctrl/stm32-pinfunc.h>
[#if (mx_socDtRPN == "stm32mp15")]
#include <dt-bindings/clock/stm32mp1-clksrc.h>
[#else]
#include <dt-bindings/clock/${mx_socDtRPN}-clksrc.h>
[/#if]
[#if srvcmx_isDeviceEnabled("etzpc") && srvcmx_getMatchingBindedHwName_inDTS("etzpc")?has_content]
#include <dt-bindings/soc/${mx_socDtRPN}-etzpc.h>
[/#if]

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
	[#if mx_isCustomBoard]
	compatible = "st,${mx_socRPN}-${mx_projectName}-mx", "st,${mx_socFtRPN}";
	 [#else]
	compatible = "st,${mx_socRPN}-${mx_projectName}-mx", "st,${mx_boardName_lowercase}", "st,${mx_socFtRPN}";
	[/#if]
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

	[#--other root subnodes--]
	[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsByPath(mxDtDM.dts_bindedElmtsList, "/") pDtLevel=1 pOrdering=true/]	[#--get only "root" level elmts--]

}; /*root*/


[#--pinctrl--]
/*Warning: the configuration of the secured GPIOs should be added in (addons) User Section*/[#t]
[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsMatchingBindedHwName(mxDtDM.dts_bindedElmtsList, "pinctrl") pDtLevel=0 pOrdering=true/]


[#--dts level elmts--]
[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getDeviceElmtsByPath(mxDtDM.dts_bindedElmtsList, "") pDtLevel=0 pOrdering=true/][#--get only "dts" level elmts--]


/* USER CODE BEGIN addons */
/* USER CODE END addons */

[/#macro]
