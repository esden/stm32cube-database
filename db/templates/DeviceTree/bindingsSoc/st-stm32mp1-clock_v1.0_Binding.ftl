[#ftl]

[#-- Clock binding : 
	*w U-Boot, TF-A, Linux FWs support
	*w U-Boot-SPL support
--]

[#list configs as dt]
[#assign data = dt]
[#assign peripheralParams =dt.peripheralParams]
[#assign peripheralRCCParams =dt.peripheralRCCParams]
[#assign RCCClockSourceParam =dt.RCCClockSourceParam]
[#t]
[#t]
[#-- Fixed Clocks (clocks node)--]
[#if srvcmx_isTargetedFw_inDTS("LINUX")]
[#assign  TAB = dts_get_tabs(1)]
[#else]
[#assign  TAB = dts_get_tabs(1)]
[/#if]
[#assign  TABN = TAB.TABN]
[#assign  TABP = TAB.TABP]
[#if srvcmx_isTargetedFw_inDTS("LINUX")]
[#assign  TAB = dts_get_tabs(3)]
[#else]
[#assign  TAB = dts_get_tabs(3)]
[/#if]
[#assign  TABN1 = TAB.TABN]
${TABN}clocks {
${TABP}/* USER CODE BEGIN clocks */
${TABP}/* USER CODE END clocks */
#n
[#t]
[#if !srvcmx_isTargetedFw_inDTS("TF-A") && !srvcmx_isTargetedFw_inDTS("OP-TEE")]
#ifndef CONFIG_TFABOOT
[/#if]
		[#list RCCClockSourceParam.get("Source").entrySet() as paramEntry]
[#t]
[#if srvcmx_isTargetedFw_inDTS("LINUX") || srvcmx_isTargetedFw_inDTS("U-BOOT")]
			[#lt]${TABP}${paramEntry.key} {
[#if srvcmx_isTargetedFw_inDTS("LINUX")]
				[#--lt--][#--${TABN1}#clock-cells = <0>;--]
				[#--lt--][#--${TABN1}compatible = "fixed-clock";--]
				[#lt]${TABN1}clock-frequency = <${paramEntry.value}>;
[/#if]
							[#if paramEntry.key == "clk_lse: clk-lse"]
								 [#list peripheralRCCParams.get("CLKClockSourceLSE").entrySet() as paramEntryLSE]
									[#if srvcmx_isTargetedFw_inDTS("U-BOOT")][#--FW contextualization--]
										[#if paramEntryLSE.key == "LSE_VALUE_Drive"]
																			[#lt]${TABN1}st,drive = < ${paramEntryLSE.value} >;
																		[/#if]
																		[#if paramEntryLSE.key == "LSE_VALUE_OSC"]
																			[#lt]${TABN1}${paramEntryLSE.value};
																		[/#if]
                                                                                                                                                [#if paramEntryLSE.key == "LSE_STATUS"]
																			[#lt]${TABN1}status = "${paramEntryLSE.value}";
																		[/#if]
										[#else]
																		[#if paramEntryLSE.key != "LSE_VALUE_Drive" && paramEntryLSE.key != "LSE_VALUE_OSC" && paramEntryLSE.key != "LSE_STATUS"]
																			[#lt]${TABN1}${paramEntryLSE.value};
																		[/#if]
										[/#if]
								[/#list]
							[/#if]
							[#if paramEntry.key == "clk_hse: clk-hse"]
								 [#list peripheralRCCParams.get("CLKClockSourceHSE").entrySet() as paramEntryHSE]
																	[#if srvcmx_isTargetedFw_inDTS("U-BOOT")]
                                                                                                                                                        [#if paramEntryHSE.key == "HSE_STATUS"]
                                                                                                                                                            [#lt]${TABN1}status = "${paramEntryHSE.value}";
                                                                                                                                                        [#else]
                                                                                                                                                            [#lt]${TABN1}${paramEntryHSE.value};
                                                                                                                                                        [/#if]
																	[#else]
																		[#if paramEntryHSE.key != "HSE_VALUE_OSC" && paramEntryHSE.key != "HSE_STATUS"]
																			[#lt]${TABN1}${paramEntryHSE.value};
																		[/#if]
																	[/#if]
								[/#list]
							[/#if]
[#if paramEntry.key == "clk_lsi: clk-lsi"]
    [#list peripheralParams.get("RCC").entrySet() as paramEntry]
        [#if srvcmx_isTargetedFw_inDTS("U-BOOT")]
            [#if paramEntry.key == "LSIState" && paramEntry.value == "RCC_LSI_OFF"]
                [#lt]${TABN1}status = "disabled";
            [/#if]
        [/#if]
    [/#list]
[/#if]
[#if paramEntry.key == "clk_hsi: clk-hsi"]
    [#list peripheralParams.get("RCC").entrySet() as paramEntry]
        [#if srvcmx_isTargetedFw_inDTS("U-BOOT")]
            [#if paramEntry.key == "HSIState" && paramEntry.value == "RCC_HSI_OFF"]
                [#lt]${TABN1}status = "disabled";
            [/#if]
        [/#if]
    [/#list]
[/#if]
[#if paramEntry.key == "clk_csi: clk-csi"]
    [#list peripheralParams.get("RCC").entrySet() as paramEntry]
        [#if srvcmx_isTargetedFw_inDTS("U-BOOT")]
            [#if paramEntry.key == "CSIState" && paramEntry.value == "RCC_CSI_OFF"]
                [#lt]${TABN1}status = "disabled";
            [/#if]
        [/#if]
    [/#list]
[/#if]
[#if srvcmx_isTargetedFw_inDTS("U-BOOT")]
	[#assign  nodeLabel = paramEntry.key?split(":")[0]]
#n
${TABN1}/* USER CODE BEGIN ${nodeLabel} */
${TABN1}/* USER CODE END ${nodeLabel} */
[/#if]
			[#lt]${TABP}};
[#else]
[#if srvcmx_isTargetedFw_inDTS("TF-A") || srvcmx_isTargetedFw_inDTS("OP-TEE")]
	[#if paramEntry.key == "clk_lse: clk-lse"]
#n
		[#lt]${TABP}${paramEntry.key} {
						[#list peripheralRCCParams.get("CLKClockSourceLSE").entrySet() as paramEntryLSE]
								[#if paramEntryLSE.key == "LSE_VALUE_Drive"]
									[#lt]${TABN1}st,drive = < ${paramEntryLSE.value} >;
								[/#if]
								[#if paramEntryLSE.key == "LSE_VALUE_OSC"]
									[#lt]${TABN1}${paramEntryLSE.value};
								[/#if]
						[/#list]
#n
						[#assign  nodeLabel = paramEntry.key?split(":")[0]]
${TABN1}/* USER CODE BEGIN ${nodeLabel} */
${TABN1}/* USER CODE END ${nodeLabel} */
			[#lt]${TABP}};
	[/#if]
	[#if paramEntry.key == "clk_hse: clk-hse"]
#n
	[#lt]${TABP}${paramEntry.key} {
						[#list peripheralRCCParams.get("CLKClockSourceHSE").entrySet() as paramEntryHSE]
								[#if paramEntryHSE.key == "HSE_VALUE_OSC"]
									[#lt]${TABN1}${paramEntryHSE.value};
								[/#if]
						[/#list]
#n
						[#assign  nodeLabel = paramEntry.key?split(":")[0]]
${TABN1}/* USER CODE BEGIN ${nodeLabel} */
${TABN1}/* USER CODE END ${nodeLabel} */
			[#lt]${TABP}};
	[/#if]
[/#if]
[/#if]
		[/#list]
[#if !srvcmx_isTargetedFw_inDTS("TF-A") && !srvcmx_isTargetedFw_inDTS("OP-TEE")]
#endif	/*CONFIG_TFABOOT*/
[/#if]
${TABN}};
#n
[/#list]
