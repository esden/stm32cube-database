[#ftl]

[#---------------------------------------------------------]
[#-- FTL System bindings for SOC devices status property --]
[#---------------------------------------------------------]

[#--Bind status properties for Device nodes:
"status" property management only--]
[#function Bind_nodeStatusProperties	 pNodeElmt]
	[#local module = "Bind_socNodeStatusProperties"]
	[#local traces =  ftrace("", "module="+module+"\n") ]
	[#local errors = ""]

	[#if pNodeElmt?has_content]
		[#--Generate status only if elmt configures a complete device (i.e. not a device section)--]
		[#if srvcmx_isBindedHwADevice(pNodeElmt)]
			[#local resElmtsList = []]
			[#if srvcmx_isDeviceAssignedToTargetedCtxt(pNodeElmt)]
				[#local resElmtsList = resElmtsList + [DTBindedDtsElmtDM_new_Property_singleValueAndItem("status", "string", "", "okay")] ]
			[#else]
				[#local resElmtsList = resElmtsList + [DTBindedDtsElmtDM_new_Property_singleValueAndItem("status", "string", "", "disabled")] ]
			[/#if]
		[/#if]
	[#else]
		[#local errors = "empty pNodeElmt"]
	[/#if]

	[#return {"errors":errors!, "resElmtsList":resElmtsList!, "traces":traces!} ]
[/#function]
