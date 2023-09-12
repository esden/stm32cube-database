[#ftl]

[#list configs as dt]
[#assign data = dt]
[#assign peripheralParams =dt.peripheralParams]
[#assign peripheralRCCParams =dt.peripheralRCCParams]
[#assign RCCClockSourceParam =dt.RCCClockSourceParam]
[#compress]



[#-- Fixed Clocks (clocks node)--]
[#if srvcmx_isTargetedFw_inDTS("LINUX")]
[#assign  TAB = dts_get_tabs(1)]
[#else]
[#assign  TAB = dts_get_tabs(0)]
[/#if]
[#assign  TABN = TAB.TABN]
[#assign  TABP = TAB.TABP]
[#if srvcmx_isTargetedFw_inDTS("LINUX")]
[#assign  TAB = dts_get_tabs(3)]
[#else]
[#assign  TAB = dts_get_tabs(2)]
[/#if]
[#assign  TABN1 = TAB.TABN]
${TABN}clocks {
${TABP}/* USER CODE BEGIN clocks */
${TABP}/* USER CODE END clocks */
#n
        [#list RCCClockSourceParam.get("Source").entrySet() as paramEntry]
[#if srvcmx_isTargetedFw_inDTS("LINUX") || srvcmx_isTargetedFw_inDTS("U-BOOT")]
            [#lt]${TABP}${paramEntry.key} {
[#if srvcmx_isTargetedFw_inDTS("LINUX")]
				[#--lt--][#--${TABN1}#clock-cells = <0>;--]
				[#--lt--][#--${TABN1}compatible = "fixed-clock";--]
				[#lt]${TABN1}clock-frequency = <${paramEntry.value}>;
[#else]
${TABN1}/* USER CODE BEGIN clocks */
${TABN1}/* USER CODE END clocks */
[/#if]
							[#if paramEntry.key == "clk_lse: clk-lse"]
								 [#list peripheralRCCParams.get("CLKClockSourceLSE").entrySet() as paramEntryLSE]
								     [#if srvcmx_isTargetedFw_inDTS("U-BOOT")] [#--FW contextualization--]
								         [#if paramEntryLSE.key == "LSE_VALUE_Drive"]
                                                                            [#lt]${TABN1}st,drive=<${paramEntryLSE.value}>;
                                                                         [/#if]
                                                                        [#if paramEntryLSE.key == "LSE_VALUE_OSC"]
                                                                            [#lt]${TABN1}${paramEntryLSE.value};
                                                                        [/#if]
							             [#else]
                                                                        [#if paramEntryLSE.key != "LSE_VALUE_Drive" && paramEntryLSE.key != "LSE_VALUE_OSC"]
                                                                            [#lt]${TABN1}${paramEntryLSE.value};
                                                                       [/#if]
                                                                     [/#if]
								[/#list]
							[/#if]
							[#if paramEntry.key == "clk_hse: clk-hse"]
								 [#list peripheralRCCParams.get("CLKClockSourceHSE").entrySet() as paramEntryHSE]
                                                                    [#if srvcmx_isTargetedFw_inDTS("U-BOOT")]
                                                                            [#lt]${TABN1}${paramEntryHSE.value};
                                                                    [#else]
                                                                        [#if paramEntryHSE.key != "HSE_VALUE_OSC"]
                                                                            [#lt]${TABN1}${paramEntryHSE.value};
                                                                        [/#if]
                                                                    [/#if]
								[/#list]
							[/#if]
[#if srvcmx_isTargetedFw_inDTS("U-BOOT")] [#--FW contextualization--]
				[#lt]${TABN1}u-boot,dm-pre-reloc;
[/#if]
			[#lt]${TABP}};
[#else]
[#if srvcmx_isTargetedFw_inDTS("TF-A")]
    [#if paramEntry.key == "clk_lse: clk-lse"]
            [#lt]${TABP}${paramEntry.key} {
${TABN1}/* USER CODE BEGIN clocks */
${TABN1}/* USER CODE END clocks */
                        [#list peripheralRCCParams.get("CLKClockSourceLSE").entrySet() as paramEntryLSE]
                                [#if paramEntryLSE.key == "LSE_VALUE_Drive"]
                                    [#lt]${TABN1}st,drive=<${paramEntryLSE.value}>;
                                [/#if]
                                [#if paramEntryLSE.key == "LSE_VALUE_OSC"]
                                    [#lt]${TABN1}${paramEntryLSE.value};
                                [/#if]
                        [/#list]
			[#lt]${TABP}};
    [/#if]
    [#if paramEntry.key == "clk_hse: clk-hse"]
            [#lt]${TABP}${paramEntry.key} {
${TABN1}/* USER CODE BEGIN clocks */
${TABN1}/* USER CODE END clocks */
                        [#list peripheralRCCParams.get("CLKClockSourceHSE").entrySet() as paramEntryHSE]
                                [#if paramEntryHSE.key == "HSE_VALUE_OSC"]
                                    [#lt]${TABN1}${paramEntryHSE.value};
                                [/#if]
                        [/#list]
			[#lt]${TABP}};
    [/#if]
[/#if]
[/#if]
        [/#list]
${TABN}};
#n
[/#compress]
[/#list]
