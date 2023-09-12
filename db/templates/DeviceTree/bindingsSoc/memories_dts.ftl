[#ftl]

[#--memories nodes binding--]
[#--/////////////--]

[#macro bind_memories	pDtLevel]
[#compress]
[#local module = bind_memories]
[#local TABres = dts_get_tabs(pDtLevel)]
[#local TABnode = TABres.TABN]
[#local TABprop = TABres.TABP]

[/#compress]
	[#--Std memory--]
	[#if mx_ddrConfigs["general"]?? && mx_ddrConfigs["general"]["ddrBaseAddress"]?? && mx_ddrConfigs["general"]["ddrSize"]??]
${TABnode}memory@${mx_ddrConfigs["general"]["ddrBaseAddress"]?replace("0x", "")} {
${TABprop}device_type = "memory";
${TABprop}reg = <${mx_ddrConfigs["general"]["ddrBaseAddress"]} ${mx_ddrConfigs["general"]["ddrSize"]}>;
#n
${TABprop}/* USER CODE BEGIN memory */
${TABprop}/* USER CODE END memory */
${TABnode}};
	[#else]
${TABnode}[@mlog  logMod=module logType="WARN" logMsg="no DDR config found: 'memory' node not generated" varsMap={} /]
${TABnode}/*
${TABnode}memory@??? {
${TABprop}reg = < ??? >;
${TABnode}};
${TABnode}*/
	[/#if]
#n	

[#if !srvcmx_isTargetedFw_inDTS("TF-A")]
	[#--reserved memory--]
${TABnode}reserved-memory {
${TABprop}#address-cells = <1>;
${TABprop}#size-cells = <1>;
${TABprop}ranges;
#n
${TABprop}/* USER CODE BEGIN reserved-memory */
${TABprop}/* USER CODE END reserved-memory */
${TABnode}};
[/#if]

[/#macro]
