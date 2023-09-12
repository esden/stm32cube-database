[#ftl]

[#--MX Data models access services--]

[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- Extract DT info --]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#--pre-process MX DM to extract info--]
[@srvcmx_init /]

[#macro srvcmx_init]

	[#--Get info from MX McuDataModels.
		*MCU & DTS data arrive in native MX format => should be changed into lower-case when needed
		*ip & device names arrive in lower-case format
	 --]
	[#list configs as mxMcuDataModel]
		[#--MCU system info --]
		[#assign mx_projectName = mxMcuDataModel.projectName?lower_case]
		[#assign mx_boardName_uppercase = mxMcuDataModel.boardName]

		[#--MCU info --]
		[#assign mx_family = mxMcuDataModel.family?lower_case]
		[#assign mx_socRPN = mxMcuDataModel.mcuParams.socRPN?lower_case]
		[#assign mx_socDtRPN = mxMcuDataModel.mcuParams.socDtRPN?lower_case]
		[#assign mx_socFtRPN = mxMcuDataModel.mcuParams.socFtRPN?lower_case]
		[#assign mx_socPtCPN = mxMcuDataModel.mcuParams.socPtCPN?lower_case]
		[#assign mx_socPackageType = mxMcuDataModel.mcuParams.socPackageType?lower_case]
		[#assign mx_socRPNSuperset = mxMcuDataModel.mcuParams.socRPNSuperset?lower_case]
		[#assign mx_socFtRPNSuperset = mxMcuDataModel.mcuParams.socFtRPNSuperset?lower_case]

		[#--MCU Contexts info --]
		[#assign mx_contextInfoPerIp = mxMcuDataModel.contextInfoPerIp!]
		[#assign mx_ipsInfoPerContext = mxMcuDataModel.ipsInfoPerContext!]
		[#assign mx_contextsInfo = mxMcuDataModel.contextsInfo!]

		[#--DDR info --]
		[#assign mx_ddrConfigs = mxMcuDataModel.ddrConfigs]

		[#--soc pinCtrl DM --]
		[#assign mx_ipInstanceListNoZ = mxMcuDataModel.ipInstanceListNoZ]
		[#assign mx_ipInstanceListZ = mxMcuDataModel.ipInstanceListZ]
		[#assign mx_ipPinCtrlNodesNoZ = mxMcuDataModel.ipPinCtrlNodesNoZ]
		[#assign mx_ipPinCtrlNodesZ = mxMcuDataModel.ipPinCtrlNodesZ]
	[/#list]

	[#--Respect ordering below
	 ------------------------]
	[#--Specify templates path --]
	[#assign mx_dtBindingsBoardPath = "bindingsBoard" + mx_osPathDelimiter] [#--used from included ftl--]
	[#assign mx_dtBindingsSocPath = "bindingsSoc" + mx_osPathDelimiter] [#--used from included ftl--]


	[#--get runtime context names list--]
	[#assign mx_runtimeContextNamesList = []]
	[#local contextNamesList = srvc_map_getKeysList(mx_contextsInfo)]
	[#list contextNamesList as contextName]
		[#--FIX: dirty - use ContextKeyEnum--]
		[#if !contextName?starts_with("Boot")]
			[#assign mx_runtimeContextNamesList = mx_runtimeContextNamesList + [contextName]]
		[/#if]
	[/#list]

	[#--FIX: could use "mxDtDM.dt_enabledDevicesMap"--]
	[#assign mx_dt_enabledDevicesNamesList = []]
	[#list mxDtDM.dt_enabledDevicesList as device]
		[#assign mx_dt_enabledDevicesNamesList = mx_dt_enabledDevicesNamesList + [device.name]]
	[/#list]

[/#macro]


[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- Contexts & Runtime contexts info --]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#-- return the names list of all available runtimeContexts
     empty list if no context --]
[#function srvcmx_getRuntimeCtxtNamesList]
	[#return mx_runtimeContextNamesList]
[/#function]


[#-- return the "LongName" as String for a given context
     empty String is not found --]
[#function srvcmx_getContextLongName	pContextName]
	[#local contextInfo = srvc_map_getValue(mx_contextsInfo, pContextName) ]
	[#return contextInfo["longName"]]
[/#function]

[#-- returns true if the context is secured--]
[#function srvcmx_isContextSecure	pContextName]
	[#local contextInfo = srvc_map_getValue(mx_contextsInfo, pContextName) ]

	[#if contextInfo["isSecure"]=="true"]
		[#return true]
	[#else]
		[#return false]
	[/#if]
[/#function]

[#-- return the "CoreName" for a given context--]
[#function srvcmx_getContextCoreName	pContextName]
	[#local contextInfo = srvc_map_getValue(mx_contextsInfo, pContextName) ]
	[#return contextInfo["coreName"]]
[/#function]


[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- Extracting info from DT --]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#--returns the list of devices assigned to "BootLoader" context and enabled--]
[#function srvcmx_getBootloadersEnabledDevicesList]

[#return mxDtDM.dt_bootloadersEnabledDevicesNamesList]
[/#function]


[#--return list of IP devices name.
	Empty list if no device.--]
[#function srvcmx_getIPDeviceNamesList	 pDevicesList]
	
	[#local devicesNamesList = []]
	[#list pDevicesList as device]
		[#if device.typeName=="IP"]
			[#local devicesNamesList = devicesNamesList + [device.name] ]
		[/#if]
	[/#list]
	
[#return devicesNamesList]	
[/#function]


[#--return list of existing and enabled IP devices name for a given RUNTIME context in the system.
	 Empty list if no device--]
[#function srvcmx_getRuntimeCtxtEnableIPDeviceNamesList	pRuntimeContextName]

	[#local devicesList = srvc_map_getValue(mxDtDM.dt_enabledDevicesPerRuntimeCtxtMap, pRuntimeContextName) ]
	[#local devicesNamesList = srvcmx_getIPDeviceNamesList(devicesList) ]

[#return devicesNamesList]
[/#function]


[#--return list of binded IP devices name for a given RUNTIME context in the system.
	 empty list if no device--]
[#function srvcmx_getRuntimeCtxtBindedEnableIPDeviceNamesList	pRuntimeContextName]

	[#local devicesList = srvc_map_getValue(mxDtDM.dt_bindedEnabledDevicesPerRuntimeCtxtMap, pRuntimeContextName) ]
	[#local devicesNamesList = srvcmx_getIPDeviceNamesList(devicesList) ]

[#return devicesNamesList]
[/#function]


[#--returns nber of devices in the given context for the whole system.--]
[#function srvcmx_getRuntimeCtxtBindedEnableIPDeviceNber		pRuntimeContextName]

	[#local devicesNamesList = srvcmx_getRuntimeCtxtBindedEnableIPDeviceNamesList(pRuntimeContextName)]
[#return devicesNamesList?size]
[/#function]


[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- Extracting info from Device --]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#--true if device exist and is enabled--]
[#function srvcmx_isDeviceEnabled		pDeviceName]

	[#if mx_dt_enabledDevicesNamesList?seq_contains(pDeviceName)]
		[#return true]
	[/#if]
[#return false]
[/#function]

[#--true if device is enabled and "non secured".
else false.
NB: it is supposed that device checked is enabled as "dt_enabledDevicesMap" is used.
--]
[#function srvcmx_isEnabledDeviceNonSecure		pDeviceName]

	[#local device = srvc_map_getValue(mxDtDM.dt_enabledDevicesMap, pDeviceName)]
	[#if  device?? && device.isNonSecure]
		[#return true]
	[/#if]

[#return false]
[/#function]


[#--return the nber of runtime ctxts the device is assigned to.
NB: independently to its state--]
[#function srvcmx_getDeviceRtCtxtNber		pDeviceName]

	[#local device = srvc_map_getValue(mxDtDM.dt_enabledDevicesMap, pDeviceName)]
	[#if  device??]
		[#return device.rtCtxtAssignmentNber]
	[/#if]

[#return 0]
[/#function]


[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- Extracting info from current printed DTS --]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#--returns true if the DTS configures the proposed FW--]
[#function srvcmx_isTargetedFw_inDTS	pFwName]

	[#if mxDtDM.dts_fwsList?seq_contains(pFwName)]
		[#return true]
	[/#if]

[#return false]
[/#function]

[#--returns the list of devices w IO for this DTS--]
[#function srvcmx_getListOfDevicesWithPinCtrl_inDTS]

[#return mxDtDM.dts_devicesWithPinCtrlList]
[/#function]


[#--get the list of elmts with "Path" matching the absolute path "pPath"--]
[#function srvcmx_getElmtsByPath  pElmtsList pPath]
	[#local elmtsList = []]
	[#list pElmtsList as elmt]
		[#--mandatory attributes--]
		[#--optional attributes--]
		[#local path = elmt.path!]

		[#if path==pPath]
			[#local elmtsList = elmtsList + [elmt]]
		[/#if]
	[/#list]

	[#return elmtsList]
[/#function]


[#--get the list of elmts "issued from a Device" with "Path" matching the absolute path "pPath"--]
[#function srvcmx_getDeviceElmtsByPath  pElmtsList pPath]
	[#local elmtsList = []]
	[#list pElmtsList as elmt]
		[#--mandatory attributes--]
		[#--optional attributes--]
		[#local path = elmt.path!]

		[#if (path==pPath)&&(srvcmx_isBindedHwADevice(elmt))]
			[#local elmtsList = elmtsList + [elmt]]
		[/#if]
	[/#list]

	[#return elmtsList]
[/#function]


[#--The bindedHwName is provided as a "regexp".
The bindedHw is considered as "existing" on the 1st match.
Returns the 1st found "bindedHwName" as a "String".
--]
[#function srvcmx_getMatchingBindedHwName_inDTS		pBindedHwNameRegexp]

	[#--we list binded elmts to found the parent dtsElmt--]
	[#list mxDtDM.dts_bindedElmtsList as elmt]
		[#if elmt.bindedHwName?matches(pBindedHwNameRegexp)]
			[#return elmt.bindedHwName]
		[/#if]
	[/#list]
[#return ""]
[/#function]


[#--get the list of elmts issued from "bindedHwName"--]
[#function srvcmx_getElmtsMatchingBindedHwName  pElmtsList pBindedHwNameRegexp]
	[#local elmtsList = []]
	[#list pElmtsList as elmt]
		[#--mandatory attributes--]
		[#--optional attributes--]
		[#local bindedHwName = elmt.bindedHwName!]

		[#if bindedHwName?matches(pBindedHwNameRegexp)]
			[#local elmtsList = elmtsList + [elmt]]
		[/#if]
	[/#list]

	[#return elmtsList]
[/#function]

[#--get the list of elmts NOT issued from "bindedHwName"--]
[#function srvcmx_getElmtsNotMatchingBindedHwName  pElmtsList pBindedHwNameRegexp]
	[#local elmtsList = []]
	[#list pElmtsList as elmt]
		[#--mandatory attributes--]
		[#--optional attributes--]
		[#local bindedHwName = elmt.bindedHwName!]

		[#if !bindedHwName?matches(pBindedHwNameRegexp)]
			[#local elmtsList = elmtsList + [elmt]]
		[/#if]
	[/#list]

	[#return elmtsList]
[/#function]


[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- Extracting info from a DTBindedDtsElmtDM elmts --]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#--Check if the elmt configures a device or a device sub-part--]
[#function srvcmx_isBindedHwADevice	pElmt]
	[#if (pElmt.isBindedHwADevice)]
		[#return true] [#--complete device--]
	[#else]
		[#return false] [#--device sub-part--]
	[/#if]
[/#function]


[#--Check if the device configured by the elmt is Bootable--]
[#function srvcmx_isBindedDeviceBootable	pElmt]
[#return pElmt.isBootableDevice]
[/#function]

[#--Check if the device configured by the elmt is non-secured--]
[#function srvcmx_isBindedDeviceNonSecure	pElmt]
[#return pElmt.isNonSecureDevice]
[/#function]

[#--Check if the device configured by the elmt is secure--]
[#function srvcmx_isBindedDeviceSecure	pElmt]
[#return pElmt.isSecureDevice]
[/#function]

[#--Check if the elmt targets the provided FW--]
[#function srvcmx_isElmtTargetsFw	pElmt pFwName]
	[#if (pElmt.fwName==pFwName)]
		[#return true]
	[#else]
		[#return false]
	[/#if]
[/#function]

[#--returns true if the pinCtrl generation is allowed for the given FW--]
[#function srvcmx_isPinCtrlToGenerate_inElmt	pElmt]

	[#if pElmt.bindControlsList?? && pElmt.bindControlsList?seq_contains("noPinctrlInElmt")]
		[#return false]
	[/#if]

[#return true]
[/#function]

[#--returns true if the status generation is allowed for the given FW--]
[#function srvcmx_isStatusToGenerate_inElmt		pElmt]

	[#if pElmt.bindControlsList?? && pElmt.bindControlsList?seq_contains("noStatusInElmt")]
		[#return false]
	[/#if]

[#return true]
[/#function]



[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- DTS elmt creation services --]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#--FIX: secure Api by improving i/f checking--]
[#--DTBindedDtsElmtDM class mirroring
		=>to modify whenever "DTBindedDtsElmtDM" java class changes
		-today only the mandatory and minimum set of attributes are implemented
--]
[#function DTBindedDtsElmtDM_new  pTypeName pDeviceName pFwName pElmtsList]
	[#return {"typeName":pTypeName, "deviceName":pDeviceName, "fwName":pFwName, "areUserSectionsAllowed":true, "elmtsList":pElmtsList}]
	[#return elmt]
[/#function]


[#--Create UserSection elmt--]
[#function DTBindedDtsElmtDM_new_UserSection_FromParent  pParentElmt]
	[#return DTBindedDtsElmtDM_new("UserSection", "", "", []) + {"parent":pParentElmt}]
[/#function]


[#--Create PROPERTY: full Api--]
[#function DTBindedDtsElmtDM_new_PropertyArrayItem  pValueType pValue]
	[#return DTBindedDtsElmtDM_new("ArrayItem", "", "", []) + {"valueType":pValueType, "value":pValue}]
[/#function]

[#function DTBindedDtsElmtDM_new_PropertyValueItem  pFormat pArrayItemsList]
	[#return  DTBindedDtsElmtDM_new("ValueItem", "", "", pArrayItemsList) + {"valueFormat":pFormat}]
[/#function]

[#function DTBindedDtsElmtDM_new_Property  pName pValueItemsList]
	[#return DTBindedDtsElmtDM_new("Property", "", "", pValueItemsList) + {"name":pName}]
[/#function]


[#--Create PROPERTY Api: single ValueItem and single ArrayItem:
	ex.: prop = <x>;
	ex.: prop = "x";
	--]
[#function DTBindedDtsElmtDM_new_Property_singleValueAndItem  pName pFormat pType pArrayItemValue]
	[#return DTBindedDtsElmtDM_new_Property(pName, [DTBindedDtsElmtDM_new_PropertyValueItem(pFormat, [DTBindedDtsElmtDM_new_PropertyArrayItem(pType, pArrayItemValue)])])]
[/#function]

[#--Create PROPERTY w no value:
	ex.: prop;
	--]
[#function DTBindedDtsElmtDM_new_Property_noValue  pName]
	[#return DTBindedDtsElmtDM_new_Property(pName, [])]
[/#function]


[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- Misc DTS services --]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#--UserSection name generation: DO NOT CHANGE !!!--]

[#--Generate a US name: "pParentElmt" is the elmt (typically a Node) where the US stands--]
[#function srvcmx_generate_UserSectionName  pParentElmt pLevel]
[#local module = "srvcmx_generate_UserSectionName"]
[#local traces =  ftrace("", "module="+module+"\n") ]
[#local errors = ""]

	[#if pLevel < 20]
		[#if pParentElmt?has_content]
			[#--Mandatory attributes--]
			[#local isNodeOverloading = pParentElmt.isNodeOverloading]
			[#local name = pParentElmt.name]
			[#--Optional attributes--]
			[#local label = pParentElmt.nodeLabel!]
			[#local unitAddress = pParentElmt.nodeUnitAddress!]

			[#if label?has_content]
				[#--use label (preferred)--]
				[#local usName = label]
			[#elseif isNodeOverloading]
				[#--if no label, use parent elmt ref if it is an overload--]
				[#local usName = name]
			[#else]
				[#--name = parentUSName_name-unitAddress--]
				[#local usName = name]
				[#if unitAddress?has_content]
					[#local usName = usName + "-" + unitAddress]
				[/#if]

				[#if pParentElmt.parent??]
					[#local usNameRes = srvcmx_generate_UserSectionName(pParentElmt.parent, (pLevel+1))]
					[#local errors = usNameRes.errors]
					[#if !usNameRes.errors?has_content]
						[#local usName = usNameRes.name + "_" + usName]
					[/#if]
				[#else]
					[#local errors = "no parent"]
				[/#if]
			[/#if]
		[#else]
			[#local errors = "empty parent"]
		[/#if]
	[#else]
		[#--control recursivity--]
		[#local errors = "too high level"]
	[/#if]

	[#return {"errors":errors!, "name":usName!, "traces":traces!} ]
[/#function]

[#--UserSection name generation--]
