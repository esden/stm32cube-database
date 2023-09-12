[#ftl]

[#--ETZPC binding--]
[#--/////////////--]

[#--Identifiers list of peripherals under ETZPC control.
ETZPC peripheral Ids definitions are part of ETZPC binding, this is why they
are defined in this file.
	*key = MX device name (regexp) - only one regexp group possible corresponding to device index
	*value = ETZPC Peripheral Ids - if empty value, keep MX device name

NB: if the device name does not match, the device is skipped from ETZPC list. The default HW reset
value will be applied.
--]
[#assign etzpc_map_periphIds={
	 "adc":""
	,"crc2":""
	,"cryp(.+)":""
	,"dac1":"DAC"
	,"dcmi":""
	,"ddr":"DDRCTRL" [#--special case--]
	,"dfsdm":"DFSDM"
	,"dma(\\w)":""
	,"dmamux1":"DMAMUX"
	,"eth1":"ETH"
	,"fdcan1":"TT_FDCAN" [#--only fdcan1 is managed--]
	,"hdmi_cec":"CEC"
	,"fmc":""
	,"hash(.+)":""
	,"i2c(.+)":""
	,"i2s(.+)":"SPI$1"
	,"iwdg1":""
	,"lptim(.+)":""
	,"mdios":""
	,"quadspi":"QSPI"
	,"rng(.+)":""
	,"sai(.+)":""
	,"sdmmc3":""
	,"spdifrx":""
	,"spi(.+)":""
	,"tim(.+)":""
	,"uart(.+)":""
	,"usart(.+)":""
	,"usb_otg_hs":"OTG"
	,"vrefbuf":""
	,"wwdg1":""
}]


[#macro bind_etzpc	pElmt pDtLevel]
[#compress]
[#local TABres = dts_get_tabs(pDtLevel)]
[#local TABnode = TABres.TABN]
[#local TABprop = TABres.TABP]

	[#local runtimeContextNamesList = srvcmx_getRuntimeCtxtNamesList()]
	[#local periphIdsMap = {}]

	[#list runtimeContextNamesList as runtimeContextName]
		[#local isCtxtSecure = srvcmx_isContextSecure(runtimeContextName)]
		[#local ctxtCoreName = srvcmx_getContextCoreName(runtimeContextName)]

		[#local deviceNamesList = srvcmx_getRuntimeCtxtEnableIPDeviceNamesList(runtimeContextName)]
		[#list deviceNamesList as deviceName]

			[#local res = srvc_map_getValueIfMatchWithStatus(etzpc_map_periphIds, deviceName)]
			[#if res.errors?has_content]
/*ERR : bind_etzpc() returns errors. The DTS may be incomplete. Reason:
${res.errors} - deviceName=${deviceName}*/
			[/#if]

			[#if res.isMatching]
				[#if res.res?has_content]
					[#local newPeriphId = res.res?upper_case]
				[#else]
					[#local newPeriphId = deviceName?upper_case]
				[/#if]
				[#local newPeriphIdsList = [newPeriphId]]

				[#--Special configurations => a device can lead to several IDs--]
				[#if (deviceName=="quadspi")]
					[#local newPeriphIdsList = newPeriphIdsList + ["DLYBQ"]]
				[#elseif (deviceName=="sdmmc3")]
					[#local newPeriphIdsList = newPeriphIdsList + ["DLYBSD3"]]
				[#elseif (deviceName=="ddr")]
					[#local newPeriphIdsList = newPeriphIdsList + ["DDRPHYC"]]
				[/#if]

				[#local deviceRtCtxtNber = srvcmx_getDeviceRtCtxtNber(deviceName)]
				[#if (deviceRtCtxtNber==1)]
					[#if isCtxtSecure]
						[#if deviceName!="tim15"][#--HW restriction (Wildcat specific): TIM15 cannot be declared Secured--]
							[#local periphIdsMap = srvc_map_putElmtsList(periphIdsMap, "Secured", newPeriphIdsList)]
						[/#if]
					[#else]
						[#if (ctxtCoreName?contains("Cortex-M"))][#--All Cortex-M cores are isolated--]
							[#local periphIdsMap = srvc_map_putElmtsList(periphIdsMap, "Mcu Isolation", newPeriphIdsList)]
						[#else]
							[#local periphIdsMap = srvc_map_putElmtsList(periphIdsMap, "Non Secured", newPeriphIdsList)]
						[/#if]
					[/#if]
				[#elseif (deviceRtCtxtNber>1)]
					[#if deviceName!="ddr"]
						[#--multi-assignments => DECPROT_NS_RW--]
						[#local periphIdsList = srvc_map_getValue(periphIdsMap, "Non Secured")]
						[#if !periphIdsList?? || !periphIdsList?seq_contains(newPeriphId)]
							[#local periphIdsMap = srvc_map_putElmtsList(periphIdsMap, "Non Secured", newPeriphIdsList)]
						[/#if]
					[#elseif isCtxtSecure]
						[#--Specific DDR: multi-assigned but declared as Secured (NS_R S_W) only--]
						[#local periphIdsMap = srvc_map_putElmtsList(periphIdsMap, "NS_R S_W", newPeriphIdsList)]
					[/#if]
				[#else]
/*ERR : bind_etzpc() returns errors. The DTS may be incomplete. Reason:
device has no context*/
				[/#if]
			[#--else: no match, skip peripheral--]
			[/#if]
		[/#list]

		[#--Specific Secured--]
		[#if isCtxtSecure]
			[#local periphIdsMap = srvc_map_putElmtsList(periphIdsMap, "Secured", ["STGENC"])]
		[/#if]
	[/#list]


[/#compress]
${TABnode}st,decprot = <
	[#if periphIdsMap?has_content]
		[#local securityAreasList = periphIdsMap?keys]
		[#list securityAreasList as securityArea]
${TABnode}/*"${securityArea}" peripherals*/
			[#local periphIdsList = srvc_map_getValue(periphIdsMap, securityArea)]
			[#list periphIdsList as periphId]
[#t]
				[#if (periphId=="DDRCTRL" || periphId=="DDRPHYC")]
					[#local lockingStatus = "DECPROT_LOCK"]
				[#else]
					[#local lockingStatus = "DECPROT_UNLOCK"]
				[/#if]
[#t]
				[#if securityArea=="Secured"]
${TABnode}DECPROT(${mx_family?upper_case}_ETZPC_${periphId}_ID, DECPROT_S_RW, ${lockingStatus})
				[#elseif securityArea=="NS_R S_W"]
${TABnode}DECPROT(${mx_family?upper_case}_ETZPC_${periphId}_ID, DECPROT_NS_R_S_W, ${lockingStatus})
				[#elseif securityArea=="Mcu Isolation"]
${TABnode}DECPROT(${mx_family?upper_case}_ETZPC_${periphId}_ID, DECPROT_MCU_ISOLATION, ${lockingStatus})
				[#else]
${TABnode}DECPROT(${mx_family?upper_case}_ETZPC_${periphId}_ID, DECPROT_NS_RW, ${lockingStatus})
				[/#if]
			[/#list]
		[/#list]
#n
${TABnode}/*Restriction: following IDs are not managed  - please to use User-Section if needed:
${TABnode}	${mx_family?upper_case}_ETZPC_SRAMx_ID, ${mx_family?upper_case}_ETZPC_RETRAM_ID, ${mx_family?upper_case}_ETZPC_BKPSRAM_ID*/
#n
${TABnode}/* USER CODE BEGIN etzpc_decprot */
${TABnode}	/*STM32CubeMX generates a basic and standard configuration for ETZPC.
${TABnode}	Additional device configurations can be added here if needed.
${TABnode}	"etzpc" node could be also overloaded in "addons" User-Section.*/
${TABnode}/* USER CODE END etzpc_decprot */
[#t]
	[#else]
${TABprop}/*No peripheral found*/
	[/#if]
${TABnode}>;
#n
[/#macro]
