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
	,"dfsdm":"DFSDM"
	[#--,"dmax":""--]
	,"eth1":"ETH"
	,"fdcan1":"TT_FDCAN" [#--only fdcan1 is managed--]
	,"hdmi_cec":"CEC"
	,"fmc":""
	,"hash(.+)":""
	,"i2c(.+)":""
	,"i2s(.+)":"spi$1"
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


[#macro bind_etzpc	pDtLevel]
[#compress]
[#local TABres = dts_get_tabs(pDtLevel)]
[#local TABetzpc = TABres.TABN]

	[#local showDecprot = false]
	[#if !showDecprot]
		[#local showDecprot = true]
${TABetzpc}st,decprot = <
	[/#if]

	[#local runtimeContextNamesList = srvcmx_getRuntimeCtxtNamesList()]
	[#local isPeriphFound = false]
	[#list runtimeContextNamesList as runtimeContextName]
		[#local isCtxtSecure = srvcmx_isContextSecure(runtimeContextName)]
		[#local ctxtCoreName = srvcmx_getContextCoreName(runtimeContextName)]

		[#--Get IP devices--]
		[#local deviceNamesList = srvcmx_getRuntimeCtxtEnableIPDeviceNamesList(runtimeContextName)]

		[#local isPeriphFoundInCtxt = false]
		[#list deviceNamesList as deviceName]
			[#local res = srvc_map_getValueIfMatchWithStatus(etzpc_map_periphIds, deviceName)]
			[#if res.errors?has_content]
/*ERR : bind_etzpc() returns errors. The DTS may be incomplete. Reason:
${res.errors} - deviceName=${deviceName}*/
			[/#if]

			[#if res.isMatching]
				[#local isPeriphFound = true]

				[#if res.res?has_content]
					[#local periphIdsList = [res.res?upper_case]]
				[#else]
					[#local periphIdsList = [deviceName?upper_case]]
				[/#if]

				[#--keep in case of--]
				[#if !showDecprot]
					[#local showDecprot = true]
${TABetzpc}st,decprot = <
				[/#if]

				[#if !isPeriphFoundInCtxt]
					[#local isPeriphFoundInCtxt = true]
${TABetzpc}/*"${srvcmx_getContextLongName(runtimeContextName)}" context*/
				[/#if]

				[#list periphIdsList as periphId]
					[#if isCtxtSecure && !srvcmx_isEnabledDeviceNonSecure(deviceName)][#--if NS => shared => DECPROT_NS_RW--]
						[#if !(deviceName=="tim15")][#--HW restriction (Wildcat specific): TIM15 cannot be declared secured--]
${TABetzpc}DECPROT(${mx_family?upper_case}_ETZPC_${periphId}_ID, DECPROT_S_RW, DECPROT_UNLOCK)
						[/#if]
					[#elseif !isCtxtSecure][#--if NS only: DECPROT can not be duplicated--]
						[#if (ctxtCoreName?contains("Cortex-M"))][#--All Cortex-M cores are isolated--]
${TABetzpc}DECPROT(${mx_family?upper_case}_ETZPC_${periphId}_ID, DECPROT_MCU_ISOLATION, DECPROT_UNLOCK)
						[#else]
${TABetzpc}DECPROT(${mx_family?upper_case}_ETZPC_${periphId}_ID, DECPROT_NS_RW, DECPROT_UNLOCK)
						[/#if]
					[/#if]
				[/#list]

				[#--warn message--]
				[#if (deviceName=="quadspi")]
${TABetzpc}/*Restriction: STM32MP1_ETZPC_DLYBQ_ID is not managed - please to use User-Section if needed*/
				[/#if]
				[#if (deviceName=="sdmmc3")]
${TABetzpc}/*Restriction: STM32MP1_ETZPC_DLYBSD3_ID is not managed - please to use User-Section if needed*/
				[/#if]

			[#--else: no match, skip peripheral--]
			[/#if]
		[/#list]
	[/#list]

	[#if !isPeriphFound]
#n
${TABetzpc}/*No peripherals found*/#n
	[/#if]
#n
${TABetzpc}/*Restriction: following IDs are not managed  - please to use User-Section if needed:
${TABetzpc}	STM32MP1_ETZPC_DMA1_ID, STM32MP1_ETZPC_DMA2_ID, STM32MP1_ETZPC_DMAMUX_ID,
${TABetzpc}	STM32MP1_ETZPC_SRAMx_ID, STM32MP1_ETZPC_RETRAM_ID, STM32MP1_ETZPC_BKPSRAM_ID*/
#n
${TABetzpc}/* USER CODE BEGIN etzpc_decprot */
${TABetzpc}	/*STM32CubeMX generates a basic and standard configuration for ETZPC.
${TABetzpc}	Additional device configurations can be added here if needed.
${TABetzpc}	"etzpc" node could be also overloaded in "addons" User-Section.*/
${TABetzpc}/* USER CODE END etzpc_decprot */

	[#if showDecprot]
${TABetzpc}>;#n
	[#else]
#n
	[/#if]

[/#compress]
[/#macro]
