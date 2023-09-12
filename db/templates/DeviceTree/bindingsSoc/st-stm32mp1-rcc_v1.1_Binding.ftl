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
[#if srvcmx_isTargetedFw_inDTS("OP-TEE")][#--FW contextualization--]
	[#lt]${T1}clocks = [#if hse_status=="enabled"]<&clk_hse>, [/#if]<&clk_hsi>, [#if lse_status=="enabled"]<&clk_lse>, [/#if]<&clk_lsi>, <&clk_csi>[#if i2s_clk_status=="enabled"], <&clk_i2sin>[/#if]; 
	[#lt]${T1}clock-names = [#if hse_status=="enabled"]"clk-hse", [/#if]"clk-hsi", [#if lse_status=="enabled"]"clk-lse", [/#if]"clk-lsi", "clk-csi"[#if i2s_clk_status=="enabled"], "clk-i2sin"[/#if];
[/#if]

	/* USER CODE BEGIN rcc */
	/* USER CODE END rcc */

	[#lt]${T1}st,clksrc = <
[#t]
[#if srvcmx_isTargetedFw_inDTS("TF-A")]
		[#list peripheralRCCParams.get("CLKSystemSource").entrySet() as paramEntry]
			[#lt]${T2}${paramEntry.value}
		[/#list]
[/#if]
[#if srvcmx_isTargetedFw_inDTS("OP-TEE")]
        [#list peripheralRCCParams.get("CLKSystemSourceOP").entrySet() as paramEntry]
			[#lt]${T2}${paramEntry.value}
		[/#list]
[/#if]
[#t]
	[#lt]${T1}>;
[#t]
	[#lt]${T1}st,clkdiv = <
[#t]
        [#list peripheralRCCParams.get("CLKDivider").entrySet() as paramEntry]
			[#lt]${T2}${paramEntry.value}
		[/#list]
[#if srvcmx_isTargetedFw_inDTS("OP-TEE")]
		[#list peripheralRCCParams.get("CLKDividerOP").entrySet() as paramEntry]
			[#lt]${T2}${paramEntry.value}
		[/#list]
[/#if]
[#t]
	[#lt]${T1}>;
[#t]
[#t]
	[#-- Nb pll available --]
	[#assign nbPLL=0]
	[#list peripheralParams.get("RCC").entrySet() as paramEntry]
		[#if paramEntry.key?matches("DIVN[1-9]")][#assign nbPLL=nbPLL+1][/#if]
                [#if paramEntry.key == "MPUCLKFreq_VALUE"][#assign MPUCLKFreq_VALUE="${paramEntry.value}"][/#if]
                [#if paramEntry.key == "AXICLKFreq_VALUE"][#assign AXICLKFreq_VALUE="${paramEntry.value}"][/#if]
                [#if paramEntry.key == "MLAHBCLKFreq_VALUE"][#assign MLAHBCLKFreq_VALUE="${paramEntry.value}"][/#if]
	[/#list]
	[#-- pll nodes creation if PLL --]
	[#if nbPLL > 0]
[#-- pll_vco nodes --]
[#lt]${T1}st,pll_vco {
		[#list 1..nbPLL as PLLnb]
			[#-- pll parameters saving --]
			[#assign PLLFRAC="0"]
			[#assign PLLMODPER="0"]
			[#assign PLLINCSTEP="0"]
			[#assign PLLSSCGMODE="0"]
			[#assign VCOM="0"]
			[#assign PLLSource="0"]
			[#list peripheralParams.get("RCC").entrySet() as paramEntry]
				[#if paramEntry.key == "PLL${PLLnb}UsedTFA"][#assign PLLUsedTFA=paramEntry.value?number][/#if]
				[#if paramEntry.key == "PLL${PLLnb}UsedA7"][#assign PLLUsedA7=paramEntry.value?number][/#if]
				[#if paramEntry.key == "DIVN${PLLnb}"][#assign DIVN=paramEntry.value?number -1][/#if]
				[#if paramEntry.key == "DIVM${PLLnb}"][#assign DIVM=paramEntry.value?number -1][/#if]
                [#if paramEntry.key == "PLL${PLLnb}FRACV"][#assign PLLFRAC="${paramEntry.value}"][/#if]
				[#if paramEntry.key == "VCO${PLLnb}M"][#assign VCOM="${paramEntry.value?number}"][/#if]
				[#if paramEntry.key == "PLL${PLLnb}MODPER"][#assign PLLMODPER="${paramEntry.value}"][/#if]
				[#if paramEntry.key == "PLL${PLLnb}INCSTEP"][#assign PLLINCSTEP="${paramEntry.value}"][/#if]
				[#if paramEntry.key == "PLL${PLLnb}SSCGMODEDT"][#assign PLLSSCGMODE="${paramEntry.value}"][/#if]
				[#if paramEntry.key == "PLL${PLLnb}MODE"][#assign PLLMODE="${paramEntry.value}"][/#if]
				[#if paramEntry.key == "PLL${PLLnb}CSG"][#assign PLLCSG="${paramEntry.value}"][/#if]
			[/#list]
                        [#list peripheralRCCParams.get("CLKDTPLLSource").entrySet() as paramEntry]
				[#if paramEntry.key == "PLL${PLLnb}SourceARG"][#assign PLLSource="${paramEntry.value}"][/#if]
			[/#list]
						[#if ((PLLUsedTFA! = 1) && srvcmx_isTargetedFw_inDTS("TF-A")) || ((PLLUsedA7! = 1) && srvcmx_isTargetedFw_inDTS("OP-TEE"))]
			[#lt]${T2}pll${PLLnb}_vco_${VCOM}Mhz: pll${PLLnb}-vco-${VCOM}Mhz {
				[#lt]${T3}src = < ${PLLSource} >;
				[#lt]${T3}divmn = < ${DIVM} ${DIVN} >;
								[#if PLLMODE == "RCC_PLL_FRACTIONAL"]
[#if PLLFRAC?starts_with("0x")]
									[#lt]${T3}frac = < ${PLLFRAC} >;
[#else]
[#assign fractional = String.format("0x%x" , Integer.valueOf(PLLFRAC))]
									[#lt]${T3}frac = < ${fractional} >;
[/#if]
								[/#if]
				[#if PLLCSG == "true"]
									[#lt]${T3}csg = < ${PLLMODPER} ${PLLINCSTEP} ${PLLSSCGMODE} >;
								[/#if]
[#if srvcmx_isTargetedFw_inDTS("U-BOOT") && !srvcmx_isDbFeatureEnabled("noUBootSplSupport")][#--FW contextualization--]
				[#lt]${T3}u-boot,dm-pre-reloc;
[/#if]
			[#lt]${T2}};
						[/#if]
		[/#list]

			[#lt]${T2}/* USER CODE BEGIN rcc_st-pll_vco */
			[#lt]${T2}/* USER CODE END rcc_st-pll_vco */
	[#lt]${T1}};
	[/#if]

[#-- pll nodes --]
[#t]
	[#-- pll nodes creation if PLL --]
	[#if nbPLL > 0]
		[#list 1..nbPLL as PLLnb]
			[#-- pll parameters saving --]
			[#assign VCOM="0"]
[#t]
			[#list peripheralParams.get("RCC").entrySet() as paramEntry]
				[#if paramEntry.key == "PLL${PLLnb}UsedTFA"][#assign PLLUsedTFA=paramEntry.value?number][/#if]
                [#if paramEntry.key == "PLL${PLLnb}UsedA7"][#assign PLLUsedA7=paramEntry.value?number][/#if]
				[#if paramEntry.key == "DIVP${PLLnb}"][#assign DIVP=paramEntry.value?number -1][/#if]
				[#if paramEntry.key == "DIVQ${PLLnb}"][#assign DIVQ=paramEntry.value?number -1][/#if]
				[#if paramEntry.key == "DIVR${PLLnb}"][#assign DIVR=paramEntry.value?number -1][/#if]
				[#if paramEntry.key == "VCO${PLLnb}M"][#assign VCOM="${paramEntry.value?number}"][/#if]
			[/#list]

						[#if ((PLLUsedTFA! = 1) && srvcmx_isTargetedFw_inDTS("TF-A")) || ((PLLUsedA7! = 1) && srvcmx_isTargetedFw_inDTS("OP-TEE"))]
			[#lt]${T1}pll${PLLnb}:st,pll@${PLLnb?number -1} {
				[#lt]${T2}compatible = "st,stm32mp1-pll";
				[#lt]${T2}reg = <${PLLnb?number -1}>;

                                [#lt]${T2}st,pll = < &pll${PLLnb}_cfg1 >;

                                [#lt]${T2}pll${PLLnb}_cfg1: pll${PLLnb}_cfg1 {
				[#lt]${T3}st,pll_vco = < &pll${PLLnb}_vco_${VCOM}Mhz >;
				[#lt]${T3}st,pll_div_pqr = < ${DIVP} ${DIVQ} ${DIVR} >;
				[#lt]${T2}};
			[#lt]${T2}/* USER CODE BEGIN pll${PLLnb} */
			[#lt]${T2}/* USER CODE END pll${PLLnb} */
[#lt]${T1}};                                    [/#if]
		[/#list]
	[/#if]

[#-- st,clk_opp node creation --]
[#if srvcmx_isTargetedFw_inDTS("OP-TEE")]
[#list peripheralRCCParams.get("CLKSystemSource").entrySet() as paramEntry]
    [#if paramEntry.key == "MPUCLKSource"][#assign MPUCLKSource=paramEntry.value][/#if]
    [#if paramEntry.key == "AXICLKSource"][#assign AXICLKSource=paramEntry.value][/#if]
    [#if paramEntry.key == "MLAHBCLKSource"][#assign MLAHBCLKSource=paramEntry.value][/#if]
[/#list]


[#list peripheralRCCParams.get("CLKDivider").entrySet() as paramEntry]
    [#if paramEntry.key == "AXI"][#assign AXIDiv=paramEntry.value][/#if]
    [#if paramEntry.key == "MLHB"][#assign MLAHBDiv=paramEntry.value][/#if]
[/#list]
[#lt]${T1}st,clk_opp {
[#lt]${T2}/* CK_MPU clock config for MP13 */
[#lt]${T2}st,ck_mpu {

[#lt]${T3}cfg_1 {
[#lt]${T4}hz = < ${MPUCLKFreq_VALUE} >;
[#lt]${T4}st,clksrc = < ${MPUCLKSource} >;
[#if MPUCLKSource?starts_with("CLK_MPU_PLL1")]
[#lt]${T4}st,pll = < &pll1_cfg1 >;
[/#if]
[#lt]${T3}};
[#lt]${T3}/* USER CODE BEGIN rcc_st-ck_mpu */
[#lt]${T3}/* USER CODE END rcc_st-ck_mpu */
[#lt]${T2}};

[#lt]${T2}/* CK_AXI clock config for MP13 */
[#lt]${T2}st,ck_axi {

[#lt]${T3}cfg_1 {
[#lt]${T4}hz = < ${AXICLKFreq_VALUE} >;
[#lt]${T4}st,clksrc = < ${AXICLKSource} >;
[#lt]${T4}st,clkdiv = < ${AXIDiv} >;
[#if AXICLKSource == "CLK_AXI_PLL2P"]
[#lt]${T4}st,pll = < &pll2_cfg1 >;
[/#if]
[#lt]${T3}};
[#lt]${T3}/* USER CODE BEGIN rcc_st-ck_axi */
[#lt]${T3}/* USER CODE END rcc_st-ck_axi */
[#lt]${T2}};

[#lt]${T2}/* CK_MLAHBS clock config for MP13 */
[#lt]${T2}st,ck_mlahbs {

[#lt]${T3}cfg_1 {
[#lt]${T4}hz = < ${MLAHBCLKFreq_VALUE} >;
[#lt]${T4}st,clksrc = < ${MLAHBCLKSource} >;
[#lt]${T4}st,clkdiv = < ${MLAHBDiv} >;
[#if MLAHBCLKSource?starts_with("CLK_MLAHBS_PLL3")]
[#lt]${T4}st,pll = < &pll3_cfg1 >;
[/#if]
[#lt]${T3}};

[#lt]${T3}/* USER CODE BEGIN rcc_st-ck_mlahbs */
[#lt]${T3}/* USER CODE END rcc_st-ck_mlahbs */
[#lt]${T2}};
[#lt]${T1}};
[/#if]
[/#list]
