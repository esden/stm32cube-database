[#ftl]
[#list configs as dt]
[#assign data = dt]
[#assign peripheralParams =dt.peripheralParams]
[#assign peripheralRCCParams =dt.peripheralRCCParams]
[#assign RCCClockSourceParam =dt.RCCClockSourceParam]
[#t]
[#assign T1 = "\t"] [#-- 1 Tab --]
[#assign T2 = "\t\t"] [#-- 2 Tab --]
[#assign T3 = "\t\t\t"] [#-- 3 Tab --]
[#assign T4 = "\t\t\t\t"] [#-- 4 Tab --]
[#assign T5 = "\t\t\t\t\t"] [#-- 5 Tab --]
[#t]
[#t]
[#-- Clock Tree configuration (rcc node)--]
[#list peripheralParams.get("RCC").entrySet() as paramEntry]
    [#if paramEntry.key == "LSE_STATUS"][#assign lse_status="${paramEntry.value}"][/#if]
    [#if paramEntry.key == "HSE_STATUS"][#assign hse_status="${paramEntry.value}"][/#if]
    [#if paramEntry.key == "I2S_CLK_STATUS"][#assign i2s_clk_status="${paramEntry.value}"][/#if]
[/#list]

[#assign clocks=""]
[#assign clocksNames=""]
[#if hse_status=="enabled"][#assign clocks +="<&clk_hse>, "] [/#if][#assign clocks +="<&clk_hsi>, "][#assign clocks +="<&clk_msi>, "][#if lse_status=="enabled"][#assign clocks +="<&clk_lse>, "][/#if][#assign clocks +="<&clk_lsi>, "][#if i2s_clk_status=="enabled"][#assign clocks +="<&clk_i2sin>, "][/#if]
[#if hse_status=="enabled"][#assign clocksNames+="\"clk-hse\", "][/#if][#assign clocksNames+="\"clk-hsi\", "][#assign clocksNames+="\"clk-msi\", "][#if lse_status=="enabled"][#assign clocksNames+="\"clk-lse\", "][/#if][#assign clocksNames+="\"clk-lsi\", "][#if i2s_clk_status=="enabled"][#assign clocksNames+="\"clk-i2sin\", "][/#if]
[#if !srvcmx_isTargetedFw_inDTS("TF-M")]
[#lt]${T1}clocks = ${clocks?keep_before_last(",")};
[#lt]${T1}clock-names = ${clocksNames?keep_before_last(",")};

	[#lt]${T1}st,flexgen = <
[#t]
[#-- Nb flexgen available --]
[#assign flexgenNb=0]
	[#list peripheralParams.get("RCC").entrySet() as paramEntry]
		[#if paramEntry.key?matches("XBAR.*CLKSource")][#assign flexgenNb=flexgenNb+1][/#if]
	[/#list]
[#-- flexgen node --]

[#t]
	[#-- flexgen node creation --]
	[#if flexgenNb > 0]
		[#list 1..flexgenNb as FlexgenNb]
			[#list peripheralParams.get("RCC").entrySet() as paramEntry]
				[#if paramEntry.key == "XBAR${FlexgenNb-1}CLKSource"][#assign XBARCLKSource="${paramEntry.value}"][/#if]
				[#if paramEntry.key == "XBAR${FlexgenNb-1}Prediv"][#assign XBARPrediv=paramEntry.value?number][/#if]
				[#if paramEntry.key == "XBAR${FlexgenNb-1}Findiv"][#assign XBARFindiv=paramEntry.value?number][/#if]
			[/#list]
		[#if srvcmx_isTargetedFw_inDTS("TF-A")]
			[#list peripheralRCCParams.get("CLKFLEXGEN").entrySet() as paramEntry]
				[#if paramEntry.key == "XBAR${FlexgenNb-1}CLKSourceARG"][#assign XBARCLKSourceARG="${paramEntry.value}"]
					[#if XBARCLKSourceARG??]
						[#lt]${T2}FLEXGEN_CFG(${FlexgenNb-1}, ${XBARCLKSourceARG}, ${XBARPrediv-1}, ${XBARFindiv-1})
					[/#if]
				[/#if]
			[/#list]
		[/#if]
		[#if srvcmx_isTargetedFw_inDTS("OP-TEE")]
			[#list peripheralRCCParams.get("CLKFLEXGENOP").entrySet() as paramEntry]
				[#if paramEntry.key == "XBAR${FlexgenNb-1}CLKSourceARGA7"][#assign XBARCLKSourceARGA7="${paramEntry.value}"]
					[#if XBARCLKSourceARGA7??]
						[#lt]${T2}FLEXGEN_CFG(${FlexgenNb-1}, ${XBARCLKSourceARGA7}, ${XBARPrediv-1}, ${XBARFindiv-1})
					[/#if]
				[/#if]
			[/#list]
		[/#if]
		[/#list]
	[/#if]
[#t]
	[#lt]${T1}>;

[#t]
	[#lt]${T1}st,busclk = <
[#t]
        [#list peripheralRCCParams.get("ICNDivider").entrySet() as paramEntry]
			[#lt]${T2}${paramEntry.value}
		[/#list]
[#t]
	[#lt]${T1}>;

[#t]
	[#lt]${T1}st,kerclk = <
[#t]
[#-- kerclk node --]
[#t]
[#if srvcmx_isTargetedFw_inDTS("TF-A")]
	[#list peripheralRCCParams.get("CLKSystemSource").entrySet() as paramEntry]
		[#lt]${T2}MUX_CFG(${paramEntry.value})
	[/#list]
[/#if]
[#if srvcmx_isTargetedFw_inDTS("OP-TEE")]
	[#list peripheralRCCParams.get("CLKSystemSourceOP").entrySet() as paramEntry]
		[#lt]${T2}MUX_CFG(${paramEntry.value})
	[/#list]
[/#if]

	[#list peripheralRCCParams.get("CLKDivider").entrySet() as paramEntry]
		[#lt]${T2}${paramEntry.value}
	[/#list]

	[#list peripheralRCCParams.get("CLKSystemSourceMCO").entrySet() as paramEntry]
		[#lt]${T2}MCO_CFG(${paramEntry.value})
	[/#list]
[#t]
[#t]
	[#lt]${T1}>;
[/#if]
[#-- Nb pll available --]
[#assign nbPLL=0]
	[#list peripheralParams.get("RCC").entrySet() as paramEntry]
		[#if paramEntry.key?matches("FREFDIV[1-9]")][#assign nbPLL=nbPLL+1][/#if]
	[/#list]

[#-- pll nodes --]
[#t]

[#-- pll nodes creation if PLL --]
[#if nbPLL > 0]
[#list 1..nbPLL as PLLnb]

[#-- pll parameters saving --]
[#assign FREFDIV="0"]
[#assign FBDIV="0"]
[#assign POSTDIV1="0"]
[#assign POSTDIV2="0"]
[#assign PLLFRAC="0"]
[#assign FOUTPOSTDIV="0"]
[#assign PLLSource="0"]
[#t]
	[#list peripheralParams.get("RCC").entrySet() as paramEntry]
		[#if paramEntry.key == "PLL${PLLnb}UsedTFA"][#assign PLLUsedTFA=paramEntry.value?number][/#if]
		[#if paramEntry.key == "PLL${PLLnb}UsedA7"][#assign PLLUsedA7=paramEntry.value?number][/#if]
		[#if paramEntry.key == "PLL${PLLnb}MODE"][#assign PLLMODE="${paramEntry.value}"][/#if]
        [#if paramEntry.key == "FREFDIV${PLLnb}"][#assign FREFDIV=paramEntry.value?number][/#if]
		[#if paramEntry.key == "FBDIV${PLLnb}"][#assign FBDIV=paramEntry.value?number][/#if]
		[#if paramEntry.key == "POSTDIV1_${PLLnb}"][#assign POSTDIV1=paramEntry.value?number][/#if]
		[#if paramEntry.key == "POSTDIV2_${PLLnb}"][#assign POSTDIV2=paramEntry.value?number][/#if]
		[#if paramEntry.key == "PLL${PLLnb}FRACV"][#assign PLLFRAC="${paramEntry.value}"][/#if]
		[#if paramEntry.key == "FOUTPOSTDIV${PLLnb}"][#assign FOUTPOSTDIV="${paramEntry.value}"][/#if]
	[/#list]
    [#list peripheralRCCParams.get("CLKDTPLLSource").entrySet() as paramEntry]
		[#if paramEntry.key == "PLL${PLLnb}SourceARG"][#assign PLLSource=paramEntry.value][/#if]
	[/#list]
    [#if ((PLLUsedTFA! = 1) && srvcmx_isTargetedFw_inDTS("TF-A")) || ((PLLUsedA7! = 1) && (srvcmx_isTargetedFw_inDTS("OP-TEE") || srvcmx_isTargetedFw_inDTS("TF-M")))]
		[#lt]${T1}pll${PLLnb}:st,pll-${PLLnb?number} {
			[#lt]${T2}st,pll = < &pll${PLLnb}_cfg_${FOUTPOSTDIV}Mhz >;

			[#lt]${T2}pll${PLLnb}_cfg_${FOUTPOSTDIV}Mhz: pll${PLLnb}-cfg-${FOUTPOSTDIV}Mhz{
				[#lt]${T3}cfg = <${FBDIV} ${FREFDIV} ${POSTDIV1} ${POSTDIV2}>;
				[#lt]${T3}src = <MUX_CFG(${PLLSource})>;
				[#if PLLMODE == "RCC_PLL_FRACTIONAL"]
					[#if PLLFRAC?starts_with("0x")]
						[#lt]${T3}frac = < ${PLLFRAC} >;
					[#else]
						[#assign fractional = String.format("0x%x" , Integer.valueOf(PLLFRAC))]
						[#lt]${T3}frac = < ${fractional} >;
					[/#if]
				[/#if]
			[#lt]${T2}};
			[#lt]${T2}/* USER CODE BEGIN pll${PLLnb} */
			[#lt]${T2}/* USER CODE END pll${PLLnb} */
        [#lt]${T1}};
	[/#if]
[/#list]
[/#if]
[/#list]

