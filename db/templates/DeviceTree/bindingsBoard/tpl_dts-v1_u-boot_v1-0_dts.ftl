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

/* For more information on Device Tree configuration, please refer to
 * https://wiki.st.com/stm32mpu/wiki/Category:Device_tree_configuration
 */

[#if !srvcmx_isDbFeatureEnabled("noUBootSplSupport")]
#include <dt-bindings/clock/stm32mp1-clksrc.h>
	[#if mx_ddrConfigs["general"]?? && mx_ddrConfigs["general"]["isConfigured"]?? && mx_ddrConfigs["general"]["isConfigured"]=="true" ]
		[#if mxDtDM.dts_ddrConfigFileName??]
#include "${mxDtDM.dts_ddrConfigFileName}"
		[#else]
		[@mlog  logMod=module logType="WARN" logMsg="DDR not configured: unknown DDR config include" varsMap={} /]
/*#include "???"*/
		[/#if]
	[/#if]
[/#if]

[#if mx_socDtRPN?has_content && mxDtDM.dts_fileNameSuffix?has_content]
#include "${mx_socDtRPN}${mxDtDM.dts_fileNameSuffix}.dtsi"
[#else]
	[@mlog  logMod=module logType="ERR" logMsg="unknown 'U-BOOT' dtsi" varsMap={} /]
/*#include "???.dtsi"*/
[/#if]
[#if !srvcmx_isDbFeatureEnabled("noUBootSplSupport")]
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
[/#if]

/* USER CODE BEGIN includes */
/* USER CODE END includes */


/ {

	/* USER CODE BEGIN root */
	/* USER CODE END root */

	[#--clock Tree--]
	[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsMatchingBindedHwName(mxDtDM.dts_bindedElmtsList, "clocks") pDtLevel=1 pOrdering=true/]

}; /*root*/


[#--pinctrl--]
[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsMatchingBindedHwName(mxDtDM.dts_bindedElmtsList, "pinctrl") pDtLevel=0 pOrdering=true/]

[#if !srvcmx_isDbFeatureEnabled("noUBootSplSupport")][#--noUBootSplSupport--]
[#--basic boot devices--]
[#local basicBootDevicesList = ["rcc", "i2c4", "quadspi", "sdmmc1", "sdmmc2", "sai2", "sai4"]]

#ifndef CONFIG_TFABOOT

[#list basicBootDevicesList as deviceName]
[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsMatchingBindedHwName(mxDtDM.dts_bindedElmtsList, deviceName) pDtLevel=0 pOrdering=true/]
[/#list]

#endif	/*CONFIG_TFABOOT*/

[#--dts level elmts--]
[#local basicBootDevicesList = basicBootDevicesList + ["rcc"]]
[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getDeviceElmtsByPathExcludingSome(mxDtDM.dts_bindedElmtsList, "", basicBootDevicesList) pDtLevel=0 pOrdering=true/][#--get only "dts" level elmts--]

[#else][#--noUBootSplSupport--]

[#--dts level elmts--]
[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getDeviceElmtsByPath(mxDtDM.dts_bindedElmtsList, "") pDtLevel=0 pOrdering=true/][#--get only "dts" level elmts--]

[/#if][#--noUBootSplSupport--]


/* USER CODE BEGIN addons */
/* USER CODE END addons */

[/#macro]