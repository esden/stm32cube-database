[#ftl]

[#--------------------------------------------------]
[#--FTL System bindings for:
		*SOC devices
		*Common to all elmts
--]
[#--------------------------------------------------]


[#--Bind pinCtrl for Device nodes--]
[#function Bind_pinCtrl	pDTInfoElmtsList pFwName]
	[#local module = "Bind_pinCtrl"]
	[#local traces =  ftrace("", "module="+module+"\n") ]
	[#local errors = ""]

	[#if pDTInfoElmtsList?has_content]

		[#local propArrayItemsList = [] ]
		[#local sleepPropArrayItemsList = [] ]
		[#--2x to respect ordering--]
		[#list pDTInfoElmtsList as dTInfoElmt]
			[#if dTInfoElmt.bankName=="OTHER"]
				[#local propArrayItemsList = propArrayItemsList + [DTBindedDtsElmtDM_new_PropertyArrayItem("phandle", dTInfoElmt.pinCtrlNodeName+"_pins_mx")] ]
				[#local sleepPropArrayItemsList = sleepPropArrayItemsList + [DTBindedDtsElmtDM_new_PropertyArrayItem("phandle", dTInfoElmt.pinCtrlNodeName+"_sleep_pins_mx")] ]
			[/#if]
		[/#list]
		[#list pDTInfoElmtsList as dTInfoElmt]
			[#if dTInfoElmt.bankName=="Z"]
				[#local propArrayItemsList = propArrayItemsList + [DTBindedDtsElmtDM_new_PropertyArrayItem("phandle", dTInfoElmt.pinCtrlNodeName+"_pins_z_mx")] ]
				[#local sleepPropArrayItemsList = sleepPropArrayItemsList + [DTBindedDtsElmtDM_new_PropertyArrayItem("phandle", dTInfoElmt.pinCtrlNodeName+"_sleep_pins_z_mx")] ]
			[/#if]
		[/#list]

		[#local copro_suffix = ""]
		[#if (pFwName=="CUBE")] [#--Contextualize--]
			[#local copro_suffix = "rproc_"]
		[/#if]

		[#local propValueItemsList = [DTBindedDtsElmtDM_new_PropertyValueItem("string", [DTBindedDtsElmtDM_new_PropertyArrayItem("", copro_suffix+"default")])] ]
		[#if (pFwName=="LINUX")||(pFwName=="CUBE")] [#--Contextualize--]
			[#local propValueItemsList = propValueItemsList + [DTBindedDtsElmtDM_new_PropertyValueItem("string", [DTBindedDtsElmtDM_new_PropertyArrayItem("", copro_suffix+"sleep")])] ]
		[/#if]
		[#local bindedElmtsList = [DTBindedDtsElmtDM_new_Property("pinctrl-names", propValueItemsList)]]

		[#local bindedElmtsList = bindedElmtsList + [DTBindedDtsElmtDM_new_Property("pinctrl-0", [DTBindedDtsElmtDM_new_PropertyValueItem("integer", propArrayItemsList)])] ]
		[#if (pFwName=="LINUX")||(pFwName=="CUBE")] [#--Contextualize--]
			[#local bindedElmtsList = bindedElmtsList + [DTBindedDtsElmtDM_new_Property("pinctrl-1", [DTBindedDtsElmtDM_new_PropertyValueItem("integer", sleepPropArrayItemsList)])] ]
		[/#if]

	[#else]
		[#local errors = "empty pDTInfoElmtsList"]
	[/#if]

	[#return {"errors":errors!, "bindedElmtsList":bindedElmtsList!, "traces":traces!} ]
[/#function]


[#--Bind system properties for Device nodes--]
[#function Bind_socNodeSystemProperties	 pNodeElmt]
	[#local module = "Bind_socNodeSystemProperties"]
	[#local traces =  ftrace("", "module="+module+"\n") ]
	[#local errors = ""]

	[#if pNodeElmt?has_content]
		[#--If bootable device, add "pre-reloc" property in all device nodes hierarchy--]
		[#local resElmtsList = []]
		[#--FIX: LINUX and U-BOOT should be Java enum--]
		[#if ((srvcmx_isElmtTargetsFw(pNodeElmt, "LINUX") || srvcmx_isElmtTargetsFw(pNodeElmt, "U-BOOT")) && srvcmx_isBindedDeviceBootable(pNodeElmt))] [#--Contextualize--]
			[#local resElmtsList = resElmtsList + [DTBindedDtsElmtDM_new_Property_noValue("u-boot,dm-pre-reloc")] ]
		[/#if]
	[#else]
		[#local errors = "empty pNodeElmt"]
	[/#if]

	[#--Bind INT--]

	[#--Bind DMAs--]

	[#--Bind clock--]

	[#return {"errors":errors!, "resElmtsList":resElmtsList!, "traces":traces!} ]
[/#function]


[#--Bind status properties for Device nodes--]
[#function Bind_nodeStatusProperties	 pNodeElmt]
	[#local module = "Bind_socNodeStatusProperties"]
	[#local traces =  ftrace("", "module="+module+"\n") ]
	[#local errors = ""]

	[#if pNodeElmt?has_content]
		[#--Generate status only if elmt configures a complete device--]
		[#if srvcmx_isBindedHwADevice(pNodeElmt)]
			[#--Ordering: "status" 1st then "secure-status"--]
			[#local resElmtsList = []]
			[#if srvcmx_isBindedDeviceNonSecure(pNodeElmt)]
				[#local resElmtsList = resElmtsList + [DTBindedDtsElmtDM_new_Property_singleValueAndItem("status", "string", "", "okay")] ]
			[/#if]

			[#if ((srvcmx_isElmtTargetsFw(pNodeElmt, "TF-A")||srvcmx_isElmtTargetsFw(pNodeElmt, "SP_MIN")) && srvcmx_isBindedDeviceSecure(pNodeElmt))]
				[#local resElmtsList = resElmtsList + [DTBindedDtsElmtDM_new_Property_singleValueAndItem("secure-status", "string", "", "okay")] ]
			[/#if]
		[/#if]
	[#else]
		[#local errors = "empty pNodeElmt"]
	[/#if]

	[#return {"errors":errors!, "resElmtsList":resElmtsList!, "traces":traces!} ]
[/#function]

