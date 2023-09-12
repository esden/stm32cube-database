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

	/* USER CODE BEGIN rcc */
	/* USER CODE END rcc */

	[#lt]${T1}st,clksrc = <
[#t]
		[#list peripheralRCCParams.get("CLKSystemSource").entrySet() as paramEntry]
			[#lt]${T2}${paramEntry.value}
		[/#list]
[#t]
	[#lt]${T1}>;
[#t]
	[#lt]${T1}st,clkdiv = <
[#t]
		[#list peripheralRCCParams.get("CLKDivider").entrySet() as paramEntry]
			[#lt]${T2}${paramEntry.value} ${T2}/*${paramEntry.key}*/
		[/#list]
[#t]
	[#lt]${T1}>;
[#t]
[#t]
[#if peripheralRCCParams.get("CLKIPClockSelection")??]
	[#lt]${T1}st,pkcs = <
[#t]
		[#list peripheralRCCParams.get("CLKIPClockSelection").entrySet() as paramEntry]
			[#lt]${T2}${paramEntry.value}
		[/#list]
[#t]
	[#lt]${T1}>;
[#t]
[/#if]
	[#-- pll nodes --]
	[#-- Nb pll available --]
	[#assign nbPLL=0]
	[#assign temporarely_remove_csg_parameter = false] [#-- if 'false' : csg = < 0 1 SSCG_MODE_DOWN_SPREAD>; not print in LSE, temporarily setting --]
[#t]
	[#list peripheralParams.get("RCC").entrySet() as paramEntry]
		[#if paramEntry.key?matches("DIVN[1-9]")][#assign nbPLL=nbPLL+1][/#if]
	[/#list]
	[#-- pll nodes creation if PLL --]
	[#if nbPLL > 0]
		[#list 1..nbPLL as PLLnb]
			[#-- pll parameters saving --]
			[#assign PLLFRAC="0"]
			[#assign PLLMODPER="0"]
			[#assign PLLINCSTEP="0"]
			[#assign PLLSSCGMODE="0"]
[#t]
			[#list peripheralParams.get("RCC").entrySet() as paramEntry]
								[#if paramEntry.key == "PLL${PLLnb}Used"][#assign PLLUsed=paramEntry.value?number][/#if]
				[#if paramEntry.key == "DIVN${PLLnb}"][#assign DIVN=paramEntry.value?number -1][/#if]
				[#if paramEntry.key == "DIVM${PLLnb}"][#assign DIVM=paramEntry.value?number -1][/#if]
				[#if paramEntry.key == "DIVP${PLLnb}"][#assign DIVP=paramEntry.value?number -1][/#if]
				[#if paramEntry.key == "DIVQ${PLLnb}"][#assign DIVQ=paramEntry.value?number -1][/#if]
				[#if paramEntry.key == "DIVR${PLLnb}"][#assign DIVR=paramEntry.value?number -1][/#if]
								[#if paramEntry.key == "PLL${PLLnb}PQR"][#assign PQR="${paramEntry.value}"][/#if]
				[#if paramEntry.key == "PLL${PLLnb}FRACV"][#assign PLLFRAC="${paramEntry.value}"][/#if]
								[#if paramEntry.key == "PLL${PLLnb}MODPER"][#assign PLLMODPER="${paramEntry.value}"][/#if]
								[#if paramEntry.key == "PLL${PLLnb}INCSTEP"][#assign PLLINCSTEP="${paramEntry.value}"][/#if]
								[#if paramEntry.key == "PLL${PLLnb}SSCGMODEDT"][#assign PLLSSCGMODE="${paramEntry.value}"][/#if]
								[#if paramEntry.key == "PLL${PLLnb}MODE"][#assign PLLMODE="${paramEntry.value}"][/#if]
								[#if paramEntry.key == "PLL${PLLnb}CSG"][#assign PLLCSG="${paramEntry.value}"][/#if]
			[/#list]
						[#if (PLLUsed! = 1) ]
			[#lt]${T1}pll${PLLnb}:st,pll@${PLLnb?number -1} {
				[#lt]${T2}compatible = "st,stm32mp1-pll";
				[#lt]${T2}reg = <${PLLnb?number -1}>;
				[#lt]${T2}cfg = < ${DIVM} ${DIVN} ${DIVP} ${DIVQ} ${DIVR} ${PQR} >;
								[#if PLLMODE == "RCC_PLL_FRACTIONAL"]
[#if PLLFRAC?starts_with("0x")]
									[#lt]${T2}frac = < ${PLLFRAC} >;
[#else]
[#assign fractional = String.format("0x%x" , Integer.valueOf(PLLFRAC))]
									[#lt]${T2}frac = < ${fractional} >;
[/#if]
								[/#if]
				[#if PLLCSG == "true"]
									[#lt]${T2}csg = < ${PLLMODPER} ${PLLINCSTEP} ${PLLSSCGMODE} >;
								[/#if]
[#if srvcmx_isTargetedFw_inDTS("U-BOOT") && !srvcmx_isDbFeatureEnabled("noUBootSplSupport")][#--FW contextualization--]
				[#lt]${T2}u-boot,dm-pre-reloc;
[/#if]
			[#lt]${T1}};
						[/#if]
		[/#list]
	[/#if]
[/#list]
