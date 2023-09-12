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
[#assign  TABP = TAB.TABP]
[#assign  TAB = dts_get_tabs(3)]
[#assign  TABN1 = TAB.TABN]
${TABN}clocks {
${TABP}/* USER CODE BEGIN clocks */
${TABP}/* USER CODE END clocks */
#n
[#t]
[#list peripheralParams.get("RCC").entrySet() as paramEntry]
    [#if paramEntry.key == "LSE_STATUS"][#assign lse_status="${paramEntry.value}"][/#if]
    [#if paramEntry.key == "HSE_STATUS"][#assign hse_status="${paramEntry.value}"][/#if]
    [#if paramEntry.key == "I2S_CLK_STATUS"][#assign i2s_clk_status="${paramEntry.value}"][/#if]
[/#list]
[#list RCCClockSourceParam.get("Source").entrySet() as paramEntry]
[#t]
        [#if paramEntry.key == "clk_lse: clk-lse" || paramEntry.key == "clk_hse: clk-hse" || paramEntry.key == "clk_i2sin: clk-i2sin" || paramEntry.key == "clk_hsi: clk-hsi"]
            [#lt]${TABP}${paramEntry.key} {
                [#if paramEntry.key == "clk_lse: clk-lse"]
[#if lse_status=="enabled"]
                    [#lt]${TABN1}clock-frequency = <${paramEntry.value}>;
                    [#list peripheralRCCParams.get("CLKClockSourceLSE").entrySet() as paramEntryLSE]
                        [#if paramEntryLSE.key == "LSE_VALUE_Drive"]
                            [#lt]${TABN1}st,drive = < ${paramEntryLSE.value} >;
                        [#else]
                            [#lt]${TABN1}${paramEntryLSE.value};
                        [/#if]
                    [/#list]
[#else]
                [#lt]${TABN1}status = "${lse_status}";
[/#if]
                [/#if]
            [#if paramEntry.key == "clk_hse: clk-hse"]
[#if hse_status=="enabled"]
                [#lt]${TABN1}clock-frequency = <${paramEntry.value}>;
                [#list peripheralRCCParams.get("CLKClockSourceHSE").entrySet() as paramEntryHSE]
                    [#lt]${TABN1}${paramEntryHSE.value};
                [/#list]
[#else]
                [#lt]${TABN1}status = "${hse_status}";
[/#if]
            [/#if]
            [#if paramEntry.key == "clk_hsi: clk-hsi"]
                [#lt]${TABN1}clock-frequency = <${paramEntry.value}>;
            [/#if]
            [#if paramEntry.key == "clk_i2sin: clk-i2sin"]
[#if i2s_clk_status=="enabled"]
                [#lt]${TABN1}clock-frequency = <${paramEntry.value}>;
[#else]
                [#lt]${TABN1}status = "${i2s_clk_status}";
[/#if]
            [/#if]
	[#assign  nodeLabel = paramEntry.key?split(":")[0]]
#n
${TABN1}/* USER CODE BEGIN ${nodeLabel} */
${TABN1}/* USER CODE END ${nodeLabel} */
        [#lt]${TABP}};
[/#if]   
[/#list]
${TABN}};
#n
[/#list]
