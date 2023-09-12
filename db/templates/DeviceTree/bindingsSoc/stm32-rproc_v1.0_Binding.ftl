[#ftl]

[#--STM32-RPROC binding--]
[#--///////////////////--]

[#--FIX: remove links w M4--]
[#macro bind_stm32_rproc	pElmt pDtLevel]
[#compress]
[#local TABres = dts_get_tabs(pDtLevel)]
[#local TABnode = TABres.TABN]
[#local TABres = dts_get_tabs(pDtLevel+1)]
[#local TABsubnode = TABres.TABN]
[#local TABsubprop = TABres.TABP]

[/#compress]
${TABnode}&m4_rproc{
[#t]
	[#if srvcmx_isDeviceEnabled("ipcc")]
${TABsubnode}/*Restriction: "memory-region" property is not managed - please to use User-Section if needed*/
	[/#if]
[#t]
	[#if srvcmx_isDeviceEnabled("ipcc")]
${TABsubnode}mboxes = [#t]
		[#if srvcmx_isDeviceEnabled("openamp")]
<&ipcc 0>, <&ipcc 1>, [#t]
		[/#if]
<&ipcc 2>;
${TABsubnode}mbox-names = [#t]
		[#if srvcmx_isDeviceEnabled("openamp")]
"vq0", "vq1", [#t]
		[/#if]
"shutdown";
	[/#if]
[#t]
${TABsubnode}status = "okay";
#n
${TABsubnode}/* USER CODE BEGIN m4_rproc */
${TABsubnode}/* USER CODE END m4_rproc */
[#t]
	[#--binding for "Documentation/bindings/remoteproc/rproc-srm.txt"--]
	[#if srvcmx_getRuntimeCtxtBindedEnableIPDeviceNber("CortexM4")>0][#--this service can be called as at this stage CortexM4 has been binded--]
#n
${TABsubnode}m4_system_resources{
${TABsubprop}status = "okay";
#n
${TABsubprop}/* USER CODE BEGIN m4_system_resources */
${TABsubprop}/* USER CODE END m4_system_resources */
${TABsubnode}};
	[/#if]
${TABnode}};
[/#macro]
