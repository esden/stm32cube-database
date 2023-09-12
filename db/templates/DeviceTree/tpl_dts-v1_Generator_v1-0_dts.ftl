[#ftl]
[#compress]

[#assign dtsGeneratorModule = "tpl_dts-v1_Generator_vx-x_dts.ftl"]

[#----------------------------------------------------]
[#-- DTS FTL binder and printer (specific "dts-v1") --]
[#-- All the DTS structuring should be defined in FTL
	 as it cannot be changed between 2 versions		--]
[#----------------------------------------------------]

[#--FTL root path--]
[#assign mx_dtLibsPath = "DeviceTree" + mx_osPathDelimiter]

[#--Load services libs --]
[#assign cfg_traceEnable = false] [#-- false: disable tracing for memory&performance gain --]
[#include mx_dtLibsPath + "tpl_CommonLibs_v1-0.ftl"]

[#include mx_dtLibsPath + "tpl_MxLibs_v1-0.ftl"]

[#--Load SOC system bindings--]
[#--FIX: load from DTConfigs.xml--]
[#include mx_dtLibsPath + mx_dtBindingsSocPath +  "system-soc_and_common_v1.0_Bindings.ftl"]


[#--Check DTGen config--]
[#assign global_allowBinding = true]
[#if !mxDtDM.dts_fwsList?has_content]
	[@mlog  logMod=dtsGeneratorModule logType="ERR" logMsg="wrong DTGen configuration: no FW specified" varsMap={} /]
	[#assign global_allowBinding = false]
[/#if]
[#if !mxDtDM.dts_name?has_content || !mxDtDM.dts_template?has_content]
	[@mlog  logMod=dtsGeneratorModule logType="ERR" logMsg="wrong DTGen configuration" varsMap={"mxDtDM.dts_name":mxDtDM.dts_name!,"mxDtDM.dts_template":mxDtDM.dts_template!} /]
	[#assign global_allowBinding = false]
[/#if]


[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- DTS binding and printing service --]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#--Bind some Dts elements then print elements.
pParentElmt and each element from pElmtsList are viewed as of DTBindedDtsElmtDM type.
Before printing, are positionned elements respecting ordering.--]
[#macro DTBindedDtsElmtDMsList_print pParentElmt  pElmtsList pDtLevel pOrdering]
[#compress]
	[#local module = "DTBindedDtsElmtDMsList_print"]

	[#--FIX: optimize when pElmtsList is empty--]

		[#if pParentElmt?? && pParentElmt?has_content]
			[#--mandatory attributes--]
			[#if pParentElmt.typeName?? && pParentElmt.typeName?has_content]
				[#local typeName = pParentElmt.typeName]
				[#local areUserSectionsAllowed = pParentElmt.areUserSectionsAllowed]
			[#else]
				[@mlog  logMod=module logType="ERR" logMsg="Undefined typeName (pParentElmt)" varsMap={} /]
				[#local typeName = ""]
			[/#if]
			[#--optional attributes--]
		[#else]
			[#local typeName = ""]
		[/#if]

		[#--elmts extraction for re-ordering--]
		[#local NodeElmtsList = []]
		[#local pinCtrlElmtsList = []]
		[#local otherElmtsList = []]
		[#local notOrderedElmtsList = []]
		[#list pElmtsList as elmt]
			[#--FIX: if no parent and no overloading => node location error--]
			[#if elmt.typeName?? && elmt.typeName?has_content]
				[#if (elmt.typeName=="Node")]
					[#--mandatory checks--]
					[#local isElmtValid = true]
					[#if !elmt.bindedHwName?? || !elmt.bindedHwName?has_content]
						[@mlog  logMod=module logType="ERR" logMsg="Undefined bindedHwName" varsMap={"elmt.typeName":elmt.typeName!} /]
						[#local isElmtValid = false]
					[/#if]

					[#if !elmt.fwName?? || !elmt.fwName?has_content]
						[@mlog  logMod=module logType="ERR" logMsg="Undefined fwName" varsMap={"bindedHwName":elmt.bindedHwName!} /]
						[#local isElmtValid = false]
					[/#if]

					[#if isElmtValid]
						[#local NodeElmtsList = NodeElmtsList + [elmt]]
						[#local notOrderedElmtsList = notOrderedElmtsList + [elmt]]
					[/#if]
				[#elseif (elmt.typeName=="PinCtrl")]
					[#local pinCtrlElmtsList = pinCtrlElmtsList + [elmt]]
				[#else]
					[#local otherElmtsList = otherElmtsList + [elmt]]
					[#local notOrderedElmtsList = notOrderedElmtsList + [elmt]]
				[/#if]
			[#else]
				[@mlog  logMod=module logType="ERR" logMsg="Undefined typeName (elmt)" varsMap={"elmt.typeName":elmt.typeName!} /]
				[#local typeName = ""]
			[/#if]
		[/#list]

		[#--bind pinCtrl--]
		[#local pinCtrlBindedElmtsList = [] ]
		[#if pinCtrlElmtsList?has_content && srvcmx_isPinCtrlToGenerate_inElmt(pParentElmt)]
				[#--mandatory attributes--]
				[#if pParentElmt.fwName?? && pParentElmt.fwName?has_content]
					[#local fwName = pParentElmt.fwName]
				[#else]
					[@mlog  logMod=module logType="ERR" logMsg="PinCtrl elmts - undefined fwName" varsMap={"pParentElmt.fwName":pParentElmt.fwName!} /]
					[#local fwName = ""]
				[/#if]
				[#--optional attributes--]

				[#local pinCtrlBindedElmtsListRes = Bind_pinCtrl(pinCtrlElmtsList, fwName) ]
				[#local pinCtrlBindedElmtsList = pinCtrlBindedElmtsListRes.bindedElmtsList ]
			[#if pinCtrlBindedElmtsListRes.errors?has_content]
/*ERR : Bind_pinCtrl() returns errors. The DTS may be incomplete. Reason:
#t	${pinCtrlBindedElmtsListRes.errors}*/#n
				[@mtrace  traces=pinCtrlBindedElmtsListRes.traces /]
			[/#if]
		[/#if]

		[#--bind Node common elmts--]
		[#local systemPropertiesElmtsList = []]
		[#local statusPropertiesElmtsList = []]
		[#local usersectionElmtsList = []]
		[#if typeName=="Node"]

			[#--Properties--]
			[#--FIX: if device DMType=IP => mandatory--]
			[#local systemPropertiesElmtsListRes = Bind_socNodeSystemProperties(pParentElmt)]
			[#local systemPropertiesElmtsList = systemPropertiesElmtsListRes.resElmtsList]
			[#if systemPropertiesElmtsListRes.errors?has_content]
/*ERR : DTBinding_bindBody() returns errors. The DTS may be incomplete. Reason:
#t	${systemPropertiesElmtsListRes.errors}*/#n
				[@mtrace traces=systemPropertiesElmtsListRes.traces /]
			[/#if]

			[#--Add status as being the last property.
			Having no status is possible (cf HW sub-part)--]
			[#if srvcmx_isStatusToGenerate_inElmt(pParentElmt)]
				[#local statusPropertiesElmtsListRes = Bind_nodeStatusProperties(pParentElmt)]
				[#local statusPropertiesElmtsList = statusPropertiesElmtsListRes.resElmtsList]
			[/#if]

			[#--Add UserSection--]
			[#if areUserSectionsAllowed]
				[#local usersectionElmtsList = usersectionElmtsList + [DTBindedDtsElmtDM_new_UserSection_FromParent(pParentElmt)] ]
			[/#if]
		[/#if]


		[#--Apply re-ordering rules--]
		[#if pOrdering]
			[#-- systProp - pinCtrl - other elmts - Nodes (nodes in alphabetic order) --]
			[#--FIX: would be better to sort by localNodeId (after wrapping)--]
			[#local outElmtsList = systemPropertiesElmtsList + pinCtrlBindedElmtsList + otherElmtsList + statusPropertiesElmtsList + usersectionElmtsList + NodeElmtsList?sort_by("name")]
		[#else]
			[#-- keep ordering excepted pinCtrl --]
			[#local outElmtsList = systemPropertiesElmtsList + pinCtrlBindedElmtsList + statusPropertiesElmtsList + usersectionElmtsList + notOrderedElmtsList]
		[/#if]

		[#--Print elmts--]
[/#compress]
		[@DTDtsElmtDMsList_print pElmtsList=outElmtsList pElmtClassPrintLevel="DTBindedDtsElmtDM" pDtLevel=pDtLevel pConfigsList=[]/]
[/#macro]


[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- DTS print --]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#--Load dts-v1 printer service --]
[#assign global_includeFtlPath = mx_dtBindingsSocPath] [#--path for included ftl--]
[#include mx_dtLibsPath + "tpl_dts-v1_Printer_v1-0_dts.ftl"]


[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- Board DTS generation --]
[#--------------------------------------------------------------------------------------------------------------------------------]
[/#compress]
[#if global_allowBinding]
	[#if mxDtDM.dts_template?? && mxDtDM.dts_template?has_content]
		[#include mx_dtLibsPath + mx_dtBindingsBoardPath + mxDtDM.dts_template]
	[#else]
		[@mlog  logMod="DTSGen" logType="ERR" logMsg="unknown template" varsMap={"mxDtDM.dts_template":mxDtDM.dts_template!} /]
	[/#if]
[/#if]
