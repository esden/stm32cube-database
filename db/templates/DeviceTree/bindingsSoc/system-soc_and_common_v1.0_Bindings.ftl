[#ftl]

[#--------------------------------------------------]
[#--FTL System bindings for:
		*SOC devices
		*Common to all elmts
--]
[#--------------------------------------------------]


[#--Bind pinCtrl for Device nodes.
The algorithm can operate only if "extraNode" feature is supported in this DB version.
Extra nodes config name should be formed in "pinoutsynthesis.xml" of "xxx_configname".

The pinctrl configurations arrive in order (default, extra) - re-ordering is not needed.
pinctrl nodes maybe in random order (NoZ, Z, NoZ).
--]
[#function Bind_pinCtrl	pPinctrlConfigsList pFwName]
	[#local module = "Bind_pinCtrl"]
	[#local traces =  ftrace("", "module="+module+"\n") ]
	[#local errors = ""]

	[#local bindedElmtsList = [] ]

	[#--The test is done here to allow other DTS sections generation even in case of error--]
	[#if !srvcmx_isDbFeatureEnabled("extraNode")]
		[#local errors = "DB error: extra nodes feature is OFF"]
		[#return {"errors":errors!, "bindedElmtsList":bindedElmtsList!, "traces":traces!} ]
	[/#if]


	[#--FW contextualization of binding--]
	[#if (pFwName=="CUBE")||(pFwName=="TF-A")][#--Contextualize--]
		[#--generate only the "default" config - no extra node--]
		[#local pinCtrlConfigNodesList = [] ]
		[#list pPinctrlConfigsList as pinctrlConfig]
			[#--remove extraNode configs and merge all default configs--]
			[#if (pinctrlConfig.pinctrlElmtType=="DEFAULT")]
				[#local pinCtrlConfigNodesList = pinCtrlConfigNodesList + pinctrlConfig.pinCtrlConfigNodesList ]
			[/#if]
		[/#list]

		[#local pinctrlConfigsList = [DTInfoElmtDM_new("DEFAULT", "default", pinCtrlConfigNodesList)] ]
	[#else]
		[#local pinctrlConfigsList = pPinctrlConfigsList ]
	[/#if]


	[#if pinctrlConfigsList?has_content]
		[#local copro_suffix = ""]
		[#if (pFwName=="CUBE")][#--Contextualize--]
			[#local copro_suffix = "rproc_"]
		[/#if]

		[#local idx = 0]
		[#local configNameArrayItemsList = [] ]
		[#local configsPropertiesList = [] ]
		[#list pinctrlConfigsList as pinctrlConfig]

			[#--extract config name--]
			[#local configName = "" ]
			[#if (pinctrlConfig.pinctrlElmtType=="DEFAULT")]
				[#--ordering: 1st should be default--]
				[#if idx!=0]
					[#local errors = errors + " - wrong default node pinctrl ordering"]
					[#--continue--]
				[/#if]

				[#local configName = "default" ]
			[#elseif (pinctrlConfig.pinctrlElmtType=="EXTRA")]
				[#if idx==0]
					[#local errors = errors + " - wrong extra node pinctrl ordering"]
					[#--continue--]
				[/#if]

				[#local configNameSplitsList = pinctrlConfig.pinCtrlConfigName?split("_")]
				[#if configNameSplitsList?has_content]
					[#local configName = configNameSplitsList?last][#--this rule should be respected in "pinoutsynthesis.xml" !--]
					[#if ((configName=="sleep")&&(pFwName!="LINUX"))][#--Contextualize--]
						[#local configName = ""][#--forbid "sleep" config - ex.: TF-A, SP-MIN--]
					[/#if]
				[#else]
					[#local errors = errors + " - malformed extra nodes config name - name=" + pinctrlConfig.pinCtrlConfigName]
					[#--continue--]
				[/#if]
			[#else]
				[#local errors = errors + " - unknown pinctrl config type:" + pinctrlConfig.pinctrlElmtType]
			[/#if]


			[#if configName?has_content]
				[#--compose config name--]
				[#local configNameArrayItemsList = configNameArrayItemsList + [DTBindedDtsElmtDM_new_PropertyValueItem("string", [DTBindedDtsElmtDM_new_PropertyArrayItem("", copro_suffix+configName)])] ]

				[#--Extract pinctrl nodes for this config--]
				[#list pinctrlConfig.pinCtrlConfigNodesList as pinctrlNode]

					[#local nodeNamesArrayItemsList = [] ]
					[#local isSeveralBankTypes = false][#--for optimization--]
					[#local pinCtrlConfigNodesList = pinctrlConfig.pinCtrlConfigNodesList ]
					[#list pinCtrlConfigNodesList as nodeInfo]
						[#if (nodeInfo.bankName=="OTHER")]
							[#local nodeNamesArrayItemsList = nodeNamesArrayItemsList + [DTBindedDtsElmtDM_new_PropertyArrayItem("phandle", nodeInfo.pinCtrlNodeName+"_pins_mx")] ]
						[#else]
							[#local isSeveralBankTypes = true]
						[/#if]
					[/#list]

					[#--x2 to respect ordering--]
					[#if isSeveralBankTypes]
						[#list pinCtrlConfigNodesList as nodeInfo]
							[#if (nodeInfo.bankName=="Z")]
								[#local nodeNamesArrayItemsList = nodeNamesArrayItemsList + [DTBindedDtsElmtDM_new_PropertyArrayItem("phandle", nodeInfo.pinCtrlNodeName+"_pins_z_mx")] ]
							[/#if]
						[/#list]
					[/#if]

				[/#list]

				[#--compose config property--]
				[#local configsPropertiesList = configsPropertiesList + [DTBindedDtsElmtDM_new_Property("pinctrl-"+idx?string.number, [DTBindedDtsElmtDM_new_PropertyValueItem("integer", nodeNamesArrayItemsList)])] ]

				[#--id++ only if composition done--]
				[#local idx = idx+1]
			[/#if]

		[/#list]

		[#--respecting ordering--]
		[#local bindedElmtsList = [DTBindedDtsElmtDM_new_Property("pinctrl-names", configNameArrayItemsList)] + configsPropertiesList]

	[#else]
		[#local errors = errors + " - empty pinctrlConfigsList"]
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

