[#ftl]

[#-- Clock binding :
-w U-Boot, TF-A, Linux, OP-TEE FWs support
-w no U-Boot-SPL support
--]

[#list configs as dt]
[#assign data = dt]
[#assign peripheralParams =dt.peripheralParams]
[#assign peripheralRCCParams =dt.peripheralRCCParams]
[#assign RCCClockSourceParam =dt.RCCClockSourceParam]
[#t]
[#t]
[#-- Fixed Clocks (clocks node)--]
[#assign  TAB = dts_get_tabs(1)]
[#assign  TABN = TAB.TABN]
#n
[#t]
[#list peripheralParams.get("RCC").entrySet() as paramEntry]
    [#if paramEntry.key == "LSE_STATUS"][#assign lse_status="${paramEntry.value}"][/#if]
    [#if paramEntry.key == "HSE_STATUS"][#assign hse_status="${paramEntry.value}"][/#if]
    [#if paramEntry.key == "I2S_CLK_STATUS"][#assign i2s_clk_status="${paramEntry.value}"][/#if]
[/#list]
[#list RCCClockSourceParam.get("Source").entrySet() as paramEntry]
[#t]
        [#if paramEntry.key == "clk_lse" || paramEntry.key == "clk_hse" || paramEntry.key == "clk_i2sin" || paramEntry.key == "clk_hsi" || paramEntry.key == "clk_msi" || paramEntry.key == "clk_lsi"]
            [#lt]&${paramEntry.key} {
                [#if paramEntry.key == "clk_lse"]
				[#if lse_status=="enabled"]
                    [#lt]${TABN}clock-frequency = <${paramEntry.value}>;
                    [#list peripheralRCCParams.get("CLKClockSourceLSE").entrySet() as paramEntryLSE]
                        [#if paramEntryLSE.key == "LSE_VALUE_Drive"]
                            [#lt]${TABN}st,drive = < ${paramEntryLSE.value} >;
                        [/#if]
                    [/#list]
				[#else]
					[#lt]${TABN}status = "${lse_status}";
				[/#if]
                [/#if]
				[#if paramEntry.key == "clk_hse"]
				[#if hse_status=="enabled"]
					[#lt]${TABN}clock-frequency = <${paramEntry.value}>;
					[#list peripheralRCCParams.get("CLKClockSourceHSE").entrySet() as paramEntryHSE]
                [/#list]
				[#else]
					[#lt]${TABN}status = "${hse_status}";
				[/#if]
				[/#if]
				[#if paramEntry.key == "clk_hsi"]
					[#lt]${TABN}clock-frequency = <${paramEntry.value}>;
				[/#if]
				[#if paramEntry.key == "clk_msi"]
					[#lt]${TABN}clock-frequency = <${paramEntry.value}>;
				[/#if]
				[#if paramEntry.key == "clk_lsi"]
					[#lt]${TABN}clock-frequency = <${paramEntry.value}>;
				[/#if]
				[#if paramEntry.key == "clk_i2sin"]
				[#if i2s_clk_status=="enabled"]
					[#lt]${TABN}clock-frequency = <${paramEntry.value}>;
				[#else]
					[#lt]${TABN}status = "${i2s_clk_status}";
				[/#if]
				[/#if]
#n
${TABN}/* USER CODE BEGIN ${paramEntry.key} */
${TABN}/* USER CODE END ${paramEntry.key} */
        [#lt]};
[/#if]   
[/#list]
#n
[/#list]
