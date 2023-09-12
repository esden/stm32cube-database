[#ftl]

[#--STM32-RPROC binding--]
[#--///////////////////--]

[#--FIX: remove links w M4--]
[#macro bind_stm32_rproc	pDtLevel]
[#compress]
[#local TABres = dts_get_tabs(pDtLevel)]
[#local TABnode = TABres.TABN]

[#local TABres = dts_get_tabs(pDtLevel+1)]
[#local TABsubnode = TABres.TABN]
[#local TABsubprop = TABres.TABP]

${TABnode}&m4_rproc{

	[#if srvcmx_isDeviceEnabled("openamp")]
${TABsubnode}/*Restriction: "memory-region" property is not managed - please to use User-Section if needed*/
	[/#if]
	
	[#if srvcmx_isDeviceEnabled("ipcc")]
${TABsubnode}mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
${TABsubnode}mbox-names = "vq0", "vq1", "shutdown";
	[/#if]

${TABsubnode}recovery;
${TABsubnode}status = "okay";
#n
${TABsubnode}/* USER CODE BEGIN m4_rproc */
${TABsubnode}/* USER CODE END m4_rproc */

	[#--binding for "Documentation/bindings/remoteproc/rproc-srm.txt"--]
	[#if srvcmx_getRuntimeCtxtBindedEnableIPDeviceNber("CortexM4")>0][#--"m4_rproc" exist but not of SOC type--]
#n
${TABsubnode}m4_system_resources{
${TABsubprop}status = "okay";
#n
${TABsubprop}/* USER CODE BEGIN m4_system_resources */
${TABsubprop}/* USER CODE END m4_system_resources */
${TABsubnode}};
	[/#if]
${TABnode}};

[/#compress]
[/#macro]
