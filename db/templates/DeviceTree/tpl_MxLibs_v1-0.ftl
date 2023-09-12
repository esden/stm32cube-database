[#ftl]

[#--------------------------------------------------------------------]
[#--MX Device Tree Generator Data models access services

NB: all the string lists should be re-ordered to insure DTS ordering.
--]
[#--------------------------------------------------------------------]

[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- Extract DT DM info --]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#--pre-process MX DM to extract info--]
[@srvcmx_init /]

[#macro srvcmx_init]
	[#local module = "srvcmx_init"]

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
	[#assign mx_dtBindingsSocPath = "bindingsSoc" + mx_osPathDelimiter] [#--soc ftl--]


	[#--get runtime context names list--]
	[#assign mx_runtimeContextNamesList = []]
	[#local contextNamesList = srvc_javaMap_getKeysList(mx_contextsInfo)]
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

	[#--get a Map of the FW associated to the binding devices "for this dts".
		key= deviceName value= fwName
		NB: several elmts can reference the same device but a device is binded one time per FW in a dts => map can be used
		NB: a device reference only one FW per dts--]
	[#assign mx_dts_fwNamesAssociatedToBindedDevicesMap = {}]
	[#list mxDtDM.dts_bindedElmtsList as elmt]
		[#if srvcmx_isBindedHwADevice(elmt)]
			[#assign mx_dts_fwNamesAssociatedToBindedDevicesMap = mx_dts_fwNamesAssociatedToBindedDevicesMap + {elmt.deviceName:elmt.fwName}]
		[/#if]
	[/#list]

[/#macro]


[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- Contexts & Runtime contexts info: cover all the DT (not specific to a DTS) --]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#-- return the names list of all available runtimeContexts
     empty list if no context --]
[#function srvcmx_getRuntimeCtxtNamesList]
	[#return mx_runtimeContextNamesList?sort]
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
[#-- Extracting misc info covering all the DT (not specific to a DTS) --]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#--returns true if the DbFeature is enabled--]
[#function srvcmx_isDbFeatureEnabled	pFeatureName]

	[#if mxDtDM.dt_featuresList?seq_contains(pFeatureName)]
		[#return true]
	[/#if]

[#return false]
[/#function]


[#--get manifest version.
	Empty string if no version.--]
[#function srvcmx_getManifestVersion]

	[#if !mxDtDM.dt_ManifestVersion??]
		[#return ""]
	[/#if]

[#return mxDtDM.dt_ManifestVersion]
[/#function]


[#--returns the list of devices assigned to "BootLoader" context and enabled--]
[#function srvcmx_getBootloadersEnabledDevicesList]

[#return mxDtDM.dt_bootloadersEnabledDevicesNamesList?sort]
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
	
[#return devicesNamesList?sort]
[/#function]


[#--return list of existing and enabled IP devices name for a given RUNTIME context in the system.
	 Empty list if no device--]
[#function srvcmx_getRuntimeCtxtEnableIPDeviceNamesList	pRuntimeContextName]

	[#local devicesList = srvc_map_getValue(mxDtDM.dt_enabledDevicesPerRuntimeCtxtMap, pRuntimeContextName) ]
	[#local devicesNamesList = srvcmx_getIPDeviceNamesList(devicesList) ]

[#return devicesNamesList?sort]
[/#function]


[#--return list of binded IP devices name for a given RUNTIME context in the system.
	 Empty list if no device.
	 NB: the pRuntimeContextName should have been binded before to call this service.--]
[#function srvcmx_getRuntimeCtxtBindedEnableIPDeviceNamesList	pRuntimeContextName]

	[#local devicesList = srvc_map_getValue(mxDtDM.dt_bindedEnabledDevicesPerRuntimeCtxtMap, pRuntimeContextName) ]
	[#local devicesNamesList = srvcmx_getIPDeviceNamesList(devicesList) ]

[#return devicesNamesList?sort]
[/#function]


[#--returns nber of devices in the given context for the whole system.--]
[#function srvcmx_getRuntimeCtxtBindedEnableIPDeviceNber		pRuntimeContextName]

	[#local devicesNamesList = srvcmx_getRuntimeCtxtBindedEnableIPDeviceNamesList(pRuntimeContextName)]
[#return devicesNamesList?size]
[/#function]


[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- Extracting info from Device.
	Device can be shared: this info are global, covering all the DT (not specific to a DTS)  --]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#--true if device exists and is enabled--]
[#function srvcmx_isDeviceEnabled		pDeviceName]

	[#if mx_dt_enabledDevicesNamesList?seq_contains(pDeviceName)]
		[#return true]
	[/#if]
[#return false]
[/#function]

[#--return the nber of runtime ctxts the device is assigned to, covering all the DT.
NB: independently to its state--]
[#function srvcmx_getDeviceRtCtxtNber		pDeviceName]

	[#local device = srvc_map_getValue(mxDtDM.dt_enabledDevicesMap, pDeviceName)]
	[#if  device??]
		[#return device.rtCtxtAssignmentNber]
	[/#if]

[#return 0]
[/#function]

[#--return the configuration value of a device with a status.
The value to search is identified by its path in (string) nodes list format.--]
[#function srvcmx_getDeviceConfigValueWithStatus	pDeviceName pConfigNodesList]
	[#local module = "srvcmx_getDeviceConfigValue"]
	[#local traces =  ftrace("", "module="+module+"\n") ]
	[#local errors = ""]

	[#local mapRes = srvc_map_getValueWithStatus(mxDtDM.dt_enabledDevicesMap, pDeviceName)]
	[#local nodesNber = 0]
	[#if mapRes.keyFound && mapRes.value?has_content]
		[#list pConfigNodesList as node]

			[#local mapRes = srvc_map_getValueWithStatus(mapRes.value, node)]
			[#if mapRes.keyFound && (mapRes.value?has_content || (nodesNber >= (pConfigNodesList?size - 1)))]
				[#local nodesNber = nodesNber + 1]
			[#else]
				[#local errors = "value not found - device= " + device.name + - "searching failed on node= " + node]
				[#return {"errors":errors!, "value":mapRes.value!, "traces":traces!} ]
			[/#if]
		[/#list]

		[#return {"errors":errors!, "value":mapRes.value!, "traces":traces!} ]
	[#else]
		[#local errors = "unknown device or no config found - device= " + pDeviceName]
		[#return {"errors":errors!, "value":mapRes.value!, "traces":traces!} ]
	[/#if]

[#return {"errors":errors!, "value":mapRes.value!, "traces":traces!} ]
[/#function]

[#--return the configuration value of a device with no status (empty value returned if value not found).
The value to search is identified by its path in (string) nodes list format.--]
[#function srvcmx_getDeviceConfigValue	pDeviceName pConfigNodesList]

	[#return srvcmx_getDeviceConfigValueWithStatus(pDeviceName, pConfigNodesList).value!]
[/#function]


[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- Extracting info from Device.
	Device can be shared: this info are specific to the current DTS  --]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#--return the FW name to which the binded device is assigned to for the current DTS.
	return empty string if error.
NB: only the binded devices are scanned - a device is binded only one time per dts => only one FW name can be returned--]
[#function srvcmx_getFwNameOfBindedDevice_inDTS		pDeviceName]

	[#return srvc_map_getValue(mx_dts_fwNamesAssociatedToBindedDevicesMap, pDeviceName)!"" ]
[/#function]


[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- Extracting info from current DTS --]
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

[#return mxDtDM.dts_devicesWithPinCtrlList?sort]
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

[#--get the list of elmts "issued from a Device" with "Path" matching the absolute path "pPath"
but excluding the elmts that configure the provided devices--]
[#function srvcmx_getDeviceElmtsByPathExcludingSome  pElmtsList pPath pExcludedDeviceNamesList]
	[#local elmtsList = []]
	[#list pElmtsList as elmt]
		[#--mandatory attributes--]
		[#--optional attributes--]
		[#local path = elmt.path!]

		[#if (path==pPath)&&srvcmx_isBindedHwADevice(elmt)&&!pExcludedDeviceNamesList?seq_contains(srvcmx_getBindedHwName(elmt))]
			[#local elmtsList = elmtsList + [elmt]]
		[/#if]
	[/#list]

	[#return elmtsList]
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

[#--Check if the device configured by the elmt is assigned to the targeted ctxt--]
[#function srvcmx_isDeviceAssignedToTargetedCtxt	pElmt]
[#return pElmt.isDeviceAssignedToTargetedCtxt]
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

[#--return the binded HW name associated to the pElmt--]
[#function srvcmx_getBindedHwName	pElmt]
[#return pElmt.bindedHwName]
[/#function]


[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- DTBindedDtsElmtDM object creation services --]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#--FIX: secure Api by improving i/f checking--]
[#--DTBindedDtsElmtDM class mirroring
		=>to modify whenever "DTBindedDtsElmtDM" java class changes
		-today only the mandatory and minimum set of attributes are implemented
--]

[#function DTBindedDtsElmtDM_new  pTypeName pDeviceName pFwName pElmtsList]
	[#return {"typeName":pTypeName, "deviceName":pDeviceName, "fwName":pFwName, "areUserSectionsAllowed":true, "elmtsList":pElmtsList}]
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
[#-- DTInfoElmtDM object creation services --]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#--FIX: secure Api by improving i/f checking--]
[#--DTInfoElmtDM class mirroring
		=>to modify whenever "DTInfoElmtDM" java class changes
		-today only the mandatory and minimum set of attributes are implemented
--]

[#function DTInfoElmtDM_new  pPinctrlElmtType pPinCtrlConfigName pPinCtrlConfigNodesList]
	[#return {"pinctrlElmtType":pPinctrlElmtType, "pinCtrlConfigName":pPinCtrlConfigName, "pinCtrlConfigNodesList":pPinCtrlConfigNodesList}]
[/#function]

