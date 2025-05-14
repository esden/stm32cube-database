[#ftl]
// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
/*
 * Copyright (C) ${year}, STMicroelectronics - All Rights Reserved
 * Author: STM32CubeMX code generation for STMicroelectronics.
 */

/* For more information on Device Tree configuration, please refer to
 * https://wiki.st.com/stm32mpu/wiki/Category:Device_tree_configuration
 */
[#---------------------------]
[#-- DTS TF-M generation --]
[#---------------------------]
[@gen_tfm /]
[#--------------------------]
[#macro gen_tfm]
[#local module = "gen_optee"]
/dts-v1/;
[#if mx_socPtCPN?starts_with("stm32mp23")]
#include "dt-bindings/clock/stm32mp25-clksrc.h"
#include "dt-bindings/reset/stm32mp25-resets.h"
#include <dt-bindings/pinctrl/stm32-pinfunc.h>
[#else]
#include "dt-bindings/clock/${mx_socDtRPN}-clksrc.h"
#include "dt-bindings/reset/${mx_socDtRPN}-resets.h"
#include <dt-bindings/pinctrl/stm32-pinfunc.h>
[/#if]
[#if mx_socFtRPN?has_content]
#include "${mx_socFtRPN}.dtsi"
[#else]
/*#include "???.dtsi"*/
[/#if]
[#if mx_socDtRPN?starts_with("stm32mp2") ]
	[#if mx_socPtCPN?has_content]
#include "${mx_socRPN}-${mx_projectName}-mx-rcc.dtsi"
#include "${mx_socRPN}-${mx_projectName}-mx-resmem.dtsi"
	[#else]
	[@mlog  logMod=module logType="ERR" logMsg="unknown SOC pinCtrl package dtsi" varsMap={} /]
/*#include "???-pinctrl.dtsi"*/
	[/#if]
[/#if]
[#if (mx_socDtRPN?starts_with("stm32mp2"))]
	[#if mx_socPtCPN?has_content]
		[#if mx_socPtCPN?starts_with("stm32mp23")]
#include "${"stm32mp25" + "xx" + mx_socPtCPN?substring(11)}-pinctrl.dtsi"
		[#else]
#include "${mx_socPtCPN?substring(0,9) + "xx" + mx_socPtCPN?substring(11)}-pinctrl.dtsi"
		[/#if]
	[#else]
		[@mlog  logMod=module logType="ERR" logMsg="unknown SOC pinCtrl package dtsi" varsMap={} /]
/*#include "???-pinctrl.dtsi"*/
	[/#if]
[/#if]

/* USER CODE BEGIN includes */
/* USER CODE END includes */

/ {
	[#if mx_boardName_uppercase?has_content]
		[#assign manifestVersion = srvcmx_getManifestVersion()]
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

}; /*root*/
[#--pinctrl--]
[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsMatchingBindedHwName(mxDtDM.dts_bindedElmtsList, "pinctrl") pDtLevel=0 pOrdering=true/]

[#if srvcmx_getFamilyName()?? && srvcmx_getFamilyName()=="stm32mp2"]
	[#assign excludedDevicesList = ["rifsc","risax"]]
	[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getDeviceElmtsByPathExcludingSome(mxDtDM.dts_bindedElmtsList, "", excludedDevicesList) pDtLevel=0 pOrdering=true/][#--get only "dts" level elmts--]
[#else]
	[#--dts level elmts--]
	[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getDeviceElmtsByPath(mxDtDM.dts_bindedElmtsList, "") pDtLevel=0 pOrdering=true/][#--get only "dts" level elmts--]
[/#if]

/* USER CODE BEGIN addons */
/* USER CODE END addons */

[/#macro]
