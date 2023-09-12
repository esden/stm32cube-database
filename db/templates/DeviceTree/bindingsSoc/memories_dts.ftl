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

	[#--reserved memory--]
${TABnode}reserved-memory {
${TABprop}#address-cells = <1>;
${TABprop}#size-cells = <1>;
${TABprop}ranges;
#n
${TABprop}/* USER CODE BEGIN reserved-memory */
${TABprop}/* USER CODE END reserved-memory */
#n
[#compress]

	[#--GPU memory binding--]
	[#local errorLog = ""]
	[#if mx_ddrConfigs["general"]?? && mx_ddrConfigs["general"]["ddrDecBaseAddress"]?? && mx_ddrConfigs["general"]["ddrDecSize"]??]
		[#local ddrDecBaseAddress = mx_ddrConfigs["general"]["ddrDecBaseAddress"]?number]
		[#local ddrDecSize = mx_ddrConfigs["general"]["ddrDecSize"]?number]

		[#local gpuDecSize = ddrDecSize / 8]

		[#local baseDecAdd = ddrDecBaseAddress + ddrDecSize - gpuDecSize]
		[#local baseHexAddRes = srvc_convertNberDecToHexaString(baseDecAdd)]
		[#local errorLog = baseHexAddRes.errors]

		[#local gpuHexSize = srvc_convertNberDecToHexaString(gpuDecSize)]
		[#local errorLog = baseHexAddRes.errors]
	[#else]
		[#local errorLog = "no DDR config found"]
	[/#if]

[/#compress]
[#local TABres = dts_get_tabs(pDtLevel+1)]
[#local TABsubnode = TABres.TABN]
[#local TABsubprop = TABres.TABP]
	[#if !errorLog?has_content]
${TABsubnode}gpu_reserved: gpu@${baseHexAddRes.res} {
${TABsubprop}reg = <0x${baseHexAddRes.res} 0x${gpuHexSize.res}>;
${TABsubprop}no-map;
${TABsubnode}};
	[#else]
${TABsubnode}[@mlog  logMod=module logType="WARN" logMsg=errorLog + ": 'gpu_reserved' node not generated"  varsMap={} /]
${TABsubnode}/*
${TABsubnode}gpu_reserved: gpu@??? {
${TABsubprop}reg = <??? ???}>;
${TABsubprop}no-map;
${TABsubnode}};
${TABsubnode}*/
	[/#if]
${TABnode}};

[/#macro]
