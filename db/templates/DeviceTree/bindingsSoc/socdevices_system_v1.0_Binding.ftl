[#ftl]

[#-----------------------------------------------------------]
[#-- FTL System bindings for SOC devices system properties --]
[#-----------------------------------------------------------]


[#--Bind system properties for SOC Device nodes--]
[#function Bind_socNodeSystemProperties	 pNodeElmt]
	[#local module = "Bind_socNodeSystemProperties"]
	[#local traces =  ftrace("", "module="+module+"\n") ]
	[#local errors = ""]

	[#if pNodeElmt?has_content]
		[#local resElmtsList = []]

		[#--If bootable device, add "pre-reloc" property in all device nodes hierarchy--]
		[#if !srvcmx_isDbFeatureEnabled("noUBootSplSupport")]
			[#if ((srvcmx_isElmtTargetsFw(pNodeElmt, "LINUX") || srvcmx_isElmtTargetsFw(pNodeElmt, "U-BOOT")) && srvcmx_isBindedDeviceBootable(pNodeElmt))] [#--Contextualize--]
				[#local resElmtsList = resElmtsList + [DTBindedDtsElmtDM_new_Property_noValue("u-boot,dm-pre-reloc")] ]
			[/#if]
		[/#if]
	[#else]
		[#local errors = "empty pNodeElmt"]
	[/#if]

	[#--Bind INT--]

	[#--Bind DMAs--]

	[#--Bind clock--]

	[#return {"errors":errors!, "resElmtsList":resElmtsList!, "traces":traces!} ]
[/#function]
