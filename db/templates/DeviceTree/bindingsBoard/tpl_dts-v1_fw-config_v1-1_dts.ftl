[#ftl]

[#------------------------------]
[#-- DTS FW config generation --]
[#------------------------------]
[@gen_fwconfig /]
[#------------------------------]
[#macro gen_fwconfig]
[#local module = "gen_fwconfig"]
/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
/*
 * Copyright (C) STMicroelectronics ${year} - All Rights Reserved
 * Author: STM32CubeMX code generation for STMicroelectronics.
 */

/* For more information on Device Tree configuration, please refer to
 * https://wiki.st.com/stm32mpu/wiki/Category:Device_tree_configuration
 */

[#if mx_ddrConfigs["general"]?? && mx_ddrConfigs["general"]["isConfigured"]?? && mx_ddrConfigs["general"]["isConfigured"]=="true" ]
	[#if mx_socDtRPN?has_content && mx_ddrConfigs["general"]?? && mx_ddrConfigs["general"]["ddrDecSize"]??]

		[#local ddrProfiles_map={
			 "0x8000000":"128MB"
			,"0x10000000":"256MB"
			,"0x20000000":"512MB"
			,"0x40000000":"1GB"
		}]

		[#local ddrHexSizeStr = mx_ddrConfigs["general"]["ddrSize"] ]
		[#local ddrProfile = srvc_map_getValue(ddrProfiles_map, ddrHexSizeStr)]

		[#if ddrProfile?has_content]
#define DDR_SIZE	${ddrHexSizeStr} /* ${ddrProfile} */
#include "${mx_socDtRPN}-fw-config.dtsi"
			[#if srvcmx_isDeviceEnabled("mce")]
#include "${mx_socDtRPN}-fw-config-mem-encrypt.dtsi"
			[/#if]
		[#else]
[@mlog  logMod=module logType="ERR" logMsg="Unknown DDR profile: FW config not generated" varsMap={} /]
		[/#if]
	[#else]
[@mlog  logMod=module logType="ERR" logMsg="FW config not generated" varsMap={} /]
/*#include "???-fw-config.dts"*/
	[/#if]
[#else]
	[@mlog  logMod=module logType="WARN" logMsg="DDR not configured: FW config not generated" varsMap={} /]
/*#include "???-fw-config.dts"*/
[/#if]
[/#macro]