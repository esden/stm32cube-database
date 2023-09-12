[#ftl]

[#-------------------------------------------------]
[#-- FTL System bindings for SOC devices pinctrl --]
[#-------------------------------------------------]


[#--Bind pinCtrl for SOC Device nodes.
The algorithm can operate only if "extraNode2" feature is supported in this DB version.
Extra nodes config name format is defined in "pinoutsynthesis.xml".

The pinctrl configurations are ordered (default, extra) - re-ordering is not needed.
Pinctrl nodes maybe in random order (NoZ, Z, NoZ, ...).
--]
[#function Bind_pinCtrl	pPinctrlConfigsList pFwName]
	[#local module = "Bind_pinCtrl"]
	[#local traces =  ftrace("", "module="+module+"\n") ]
	[#local errors = ""]

	[#local bindedElmtsList = [] ]

	[#--The test is done here to allow other DTS sections generation even in case of error--]
	[#if !srvcmx_isDbFeatureEnabled("extraNode2")]
		[#local errors = "DB error: extranode2 feature is OFF"]
		[#return {"errors":errors!, "bindedElmtsList":bindedElmtsList!, "traces":traces!} ]
	[/#if]

	[#--filter nodes per FW--]
	[#if (pFwName=="TF-A")||(pFwName=="SP_MIN")||(pFwName=="OP-TEE")][#--Contextualize--]
		[#--generate only the "default" config--]
		[#local pinCtrlConfigNodesList = [] ]
		[#list pPinctrlConfigsList as pinctrlConfig]
			[#if (pinctrlConfig.pinctrlElmtType=="DEFAULT")]
				[#local pinCtrlConfigNodesList = pinCtrlConfigNodesList + pinctrlConfig.pinCtrlConfigNodesList ]
			[/#if]
		[/#list]

		[#local pinctrlConfigsList = [DTInfoElmtDM_new("DEFAULT", "default", pinCtrlConfigNodesList)] ][#--use default as config name--]
	[#elseif (pFwName=="CUBE")][#--Contextualize--]
		[#--generate only the "copro" config--]
		[#local pinCtrlConfigNodesList = [] ]
		[#list pPinctrlConfigsList as pinctrlConfig]
			[#if (pinctrlConfig.pinctrlElmtType=="EXTRA") && (pinctrlConfig.pinCtrlConfigName=="copro")]
				[#local pinCtrlConfigNodesList = pinCtrlConfigNodesList + pinctrlConfig.pinCtrlConfigNodesList ]
			[/#if]
		[/#list]

		[#local pinctrlConfigsList = [DTInfoElmtDM_new("DEFAULT", "default", pinCtrlConfigNodesList)] ][#--use default as config name--]
	[#else][#--LINUX, U-BOOT--]
		[#--generate all configs excepted "copro" config--]
		[#local filteredPinCtrlConfigList = [] ]
		[#list pPinctrlConfigsList as pinctrlConfig]
			[#if !((pinctrlConfig.pinctrlElmtType=="EXTRA") && (pinctrlConfig.pinCtrlConfigName=="copro"))]
				[#local filteredPinCtrlConfigList = filteredPinCtrlConfigList + [pinctrlConfig] ]
			[/#if]
		[/#list]

		[#local pinctrlConfigsList = filteredPinCtrlConfigList ][#--keep original config name--]
	[/#if]


	[#if pinctrlConfigsList?has_content]
		[#local copro_suffix = ""]
		[#if (pFwName=="CUBE")][#--Contextualize--]
			[#local copro_suffix = ""][#--also no suffix--]
		[/#if]

		[#local idx = 0]
		[#local configNamePropValueItemsList = [] ]
		[#local configsPropertiesList = [] ]
		[#list pinctrlConfigsList as pinctrlConfig]

			[#--extract config name--]
			[#local configName = "" ]
			[#if (pinctrlConfig.pinctrlElmtType=="DEFAULT")]
				[#--check ordering: 1st should be default--]
				[#if idx!=0]
					[#local errors = errors + " - wrong default node pinctrl ordering"]
					[#--continue--]
				[/#if]

				[#local configName = "default" ]
			[#elseif (pinctrlConfig.pinctrlElmtType=="EXTRA")]
				[#--check ordering: 1st should be default--]
				[#if idx==0]
					[#local errors = errors + " - wrong extra node pinctrl ordering"]
					[#--continue--]
				[/#if]

				[#if pinctrlConfig.pinCtrlConfigName?? && pinctrlConfig.pinCtrlConfigName?has_content]
					[#local configName = pinctrlConfig.pinCtrlConfigName]
				[#else]
					[#local errors = errors + " - missing pinctrl config name"]
					[#--continue--]
				[/#if]
			[#else]
				[#local errors = errors + " - unknown pinctrl config type:" + pinctrlConfig.pinctrlElmtType]
			[/#if]

			[#--compose pinctrl properties--]
			[#if configName?has_content]
				[#--compose config name property--]
				[#local configNamePropValueItemsList = configNamePropValueItemsList + [DTBindedDtsElmtDM_new_PropertyValueItem("string", [DTBindedDtsElmtDM_new_PropertyArrayItem("", copro_suffix+configName)])] ]

				[#--compose config property--]
				[#local nodeNamesPropValueItemsList = [] ]
				[#list pinctrlConfig.pinCtrlConfigNodesList as pinctrlNodeConfig]

					[#--Extract pinctrl nodes for this config--]
					[#list pinctrlNodeConfig.pinCtrlConfigNodesList as pinctrlNode]

						[#local nodeNamesArrayItemsList = [] ]
						[#local isSeveralBankTypes = false][#--for optimization--]
						[#local pinCtrlNodesList = pinctrlNodeConfig.pinCtrlConfigNodesList ]
						[#list pinCtrlNodesList as nodeInfo]
							[#if (nodeInfo.bankName=="OTHER")]
								[#--replace delimiter if existing--]
								[#local pinCtrlNodeName = nodeInfo.pinCtrlNodeName?replace("/copro", "")]
								[#local pinCtrlNodeName = pinCtrlNodeName?replace("/", "_")]
								[#local nodeNamesArrayItemsList = nodeNamesArrayItemsList + [DTBindedDtsElmtDM_new_PropertyArrayItem("phandle", pinCtrlNodeName+"_pins_mx")] ]
							[#else]
								[#local isSeveralBankTypes = true]
							[/#if]
						[/#list]

						[#--x2 to respect ordering--]
						[#if isSeveralBankTypes]
							[#list pinCtrlNodesList as nodeInfo]
								[#if (nodeInfo.bankName=="Z")]
									[#--replace delimiter if existing--]
									[#local pinCtrlNodeName = nodeInfo.pinCtrlNodeName?replace("/copro", "")]
									[#local pinCtrlNodeName = pinCtrlNodeName?replace("/", "_")]
									[#local nodeNamesArrayItemsList = nodeNamesArrayItemsList + [DTBindedDtsElmtDM_new_PropertyArrayItem("phandle", pinCtrlNodeName+"_pins_z_mx")] ]
								[/#if]
							[/#list]
						[/#if]
					[/#list]

					[#local nodeNamesPropValueItemsList = nodeNamesPropValueItemsList + [DTBindedDtsElmtDM_new_PropertyValueItem("integer", nodeNamesArrayItemsList)] ]
				[/#list]

				[#local configsPropertiesList = configsPropertiesList + [DTBindedDtsElmtDM_new_Property("pinctrl-"+idx?string.number, nodeNamesPropValueItemsList)] ]

				[#--id++ only if composition done--]
				[#local idx = idx+1]
			[/#if]
		[/#list]

		[#--respecting ordering--]
		[#local bindedElmtsList = [DTBindedDtsElmtDM_new_Property("pinctrl-names", configNamePropValueItemsList)] + configsPropertiesList]
	[#else]
		[#local errors = errors + " - empty pinctrlConfigsList"]
	[/#if]

	[#return {"errors":errors!, "bindedElmtsList":bindedElmtsList!, "traces":traces!} ]
[/#function]
