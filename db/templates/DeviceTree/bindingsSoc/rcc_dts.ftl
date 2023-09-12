[#ftl]

[#list configs as dt]
[#assign data = dt]
[#assign peripheralParams =dt.peripheralParams]
[#assign peripheralRCCParams =dt.peripheralRCCParams]
[#assign RCCClockSourceParam =dt.RCCClockSourceParam]

[#assign T1 = "#t#t"] [#-- 1 Tab = 2 spaces --]
[#assign T2 = "#t#t#t#t"] [#-- 2 Tab = 4 spaces --]
[#assign T3 = "#t#t#t#t#t#t"] [#-- 3 Tab = 6 spaces --]
[#assign T4 = "#t#t#t#t#t#t#t#t"] [#-- 4 Tab = 8 spaces --]
[#assign T5 = "#t#t#t#t#t#t#t#t#t#t"] [#-- 4 Tab = 8 spaces --]
[#compress]

[#-- Clock Tree configuration (rcc node)--]
&rcc {
[#if srvcmx_isTargetedFw_inDTS("U-BOOT")] [#--FW contextualization--]
	[#lt]${T1}u-boot,dm-pre-reloc;
[/#if]
[#if srvcmx_isTargetedFw_inDTS("TF-A")] [#--FW contextualization--]
[#assign HSICalibration="Disable"]
[#assign CSICalibration="Disable"]
[#assign PeriodicCalibrationValue=0]
[#list peripheralParams.get("RCC").entrySet() as paramEntry]
[#if paramEntry.key == "HSICalibration"][#assign HSICalibration=paramEntry.value]
[#if (HSICalibration = "Enable") ]
[#lt]${T1}st,hsi-cal;
[/#if]
[/#if]
[#if paramEntry.key == "CSICalibration"][#assign CSICalibration=paramEntry.value]
[#if (CSICalibration = "Enable") ]
[#lt]${T1}st,csi-cal;
[/#if]
[/#if]
[#if paramEntry.key == "PeriodicCalibrationValue"][#assign PeriodicCalibrationValue=paramEntry.value?number][/#if]
[/#list]

[#if (HSICalibration = "Enable") | (CSICalibration = "Enable") ]
[#lt]${T1}st,cal-sec = <${PeriodicCalibrationValue}>;
[/#if]
[/#if]
	[#lt]${T1}st,clksrc = <

            [#list peripheralRCCParams.get("CLKSystemSource").entrySet() as paramEntry]
            [#lt]${T2}${paramEntry.value} 
            [/#list]
	
	[#lt]${T1}>;

	[#lt]${T1}st,clkdiv = <

            [#list peripheralRCCParams.get("CLKDivider").entrySet() as paramEntry]
            [#lt]${T2}${paramEntry.value} ${T2}/*${paramEntry.key}*/
            [/#list]

	[#lt]${T1}>;


	[#lt]${T1}st,pkcs = <

            [#list peripheralRCCParams.get("CLKIPClockSelection").entrySet() as paramEntry]
            [#lt]${T2}${paramEntry.value} 
            [/#list]

	[#lt]${T1}>;

	[#-- pll nodes --]
	[#-- Nb pll available --]
	[#assign nbPLL=0]
	[#assign temporarely_remove_csg_parameter = false] [#-- if 'false' : csg = < 0 1 SSCG_MODE_DOWN_SPREAD>; not print in LSE, temporarely setting --]

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
				[#lt]${T2}cfg = < ${DIVM} ${DIVN} ${DIVP} ${DIVQ} ${DIVR} ${PQR}>;
                                [#if PLLMODE == "RCC_PLL_FRACTIONAL"]
                                    [#lt]${T2}frac = < ${PLLFRAC} >;
                                [/#if]
				[#if PLLCSG == "true"]
                                    [#lt]${T2}csg = < ${PLLMODPER} ${PLLINCSTEP} ${PLLSSCGMODE}>; [#-- optionnal --]
                                [/#if]
[#if srvcmx_isTargetedFw_inDTS("U-BOOT")] [#--FW contextualization--]
				[#lt]${T2}u-boot,dm-pre-reloc;
[/#if]
			[#lt]${T1}};
                        [/#if]
		[/#list]
	[/#if]
};
[/#compress]
[/#list]
