[#ftl]

[#--ETZPC binding: generic binding--]
[#--/////////////--]


[#--update the security areas map w the new periph ids list taking into acount the device controls--]
[#function bind_etzpc_updateSecurityAreasMap    periphIdsMap newPeriphIdsList targetedSecurityAreaName deviceSecurityAreasControlsList]
	[#local module = "bind_etzpc_updateSecurityAreasMap"]
	[#local traces =  ftrace("", "module="+module+"\n") ]
	[#local errors = ""]

	[#if !deviceSecurityAreasControlsList?seq_contains("!" + targetedSecurityAreaName)]
		[#local securityAreaName = targetedSecurityAreaName]
		[#list deviceSecurityAreasControlsList as controlledAreaName]
			[#if !controlledAreaName?contains("!")]
				[#local securityAreaName = controlledAreaName]
				[#break]
			[/#if]
		[/#list]

		[#local periphIdsMap = srvc_map_putElmtsList(periphIdsMap, securityAreaName, newPeriphIdsList)]
	[/#if]

[#return {"errors":errors!, "periphIdsMap":periphIdsMap, "traces":traces!} ]
[/#function]

[#macro bind_etzpc_genericBinding	pElmt pDtLevel]
[#compress]
[#local TABres = dts_get_tabs(pDtLevel)]
[#local TABnode = TABres.TABN]
[#local TABprop = TABres.TABP]

	[#local runtimeContextNamesList = srvcmx_getRuntimeCtxtNamesList()]
	[#local periphIdsMap = {}]

	[#list runtimeContextNamesList as runtimeContextName]
		[#local isCtxtSecure = srvcmx_isContextSecure(runtimeContextName)]
		[#local ctxtCoreName = srvcmx_getContextCoreName(runtimeContextName)]

		[#local deviceNamesList = srvcmx_getRuntimeCtxtEnableIPDeviceNamesList(runtimeContextName)]
		[#list deviceNamesList as deviceName]

			[#local res = srvc_map_getValueIfMatchWithStatus(etzpc_map_periphIds, deviceName)]
			[#if res.errors?has_content]
/*ERR : bind_etzpc() returns errors. The configuration may be incorrect. Reason:
${res.errors} - deviceName=${deviceName}*/
			[/#if]

			[#if res.isMatching]

				[#if res.res[0]?has_content]
					[#local newPeriphIdsList = []]
					[#local newPeriphIdsListRes = srvc_list_replaceString(res.res[0], "$1", res.group1)]
					[#if !newPeriphIdsListRes.errors?has_content]
						[#local newPeriphIdsList = newPeriphIdsListRes.res]
					[#else]
/*ERR : bind_etzpc() returns errors. The configuration may be incorrect. Reason:
${res.errors} - deviceName=${deviceName}*/
					[/#if]
				[#else]
					[#local newPeriphIdsList = [deviceName?upper_case]]
				[/#if]

				[#if newPeriphIdsList?has_content]

					[#local deviceSecurityAreasControlsList = res.res[1]!]

					[#local deviceRtCtxtNber = srvcmx_getDeviceRtCtxtNber(deviceName)]
					[#if (deviceRtCtxtNber==1)]
						[#if isCtxtSecure]
							[#local periphIdsMap = bind_etzpc_updateSecurityAreasMap(periphIdsMap, newPeriphIdsList, "Secured", deviceSecurityAreasControlsList).periphIdsMap]
						[#else]
							[#if (ctxtCoreName?contains("Cortex-M"))][#--All Cortex-M cores are isolated--]
								[#local periphIdsMap = bind_etzpc_updateSecurityAreasMap(periphIdsMap, newPeriphIdsList, "Mcu Isolation", deviceSecurityAreasControlsList).periphIdsMap]
							[#else]
								[#local periphIdsMap = bind_etzpc_updateSecurityAreasMap(periphIdsMap, newPeriphIdsList, "Non Secured", deviceSecurityAreasControlsList).periphIdsMap]
							[/#if]
						[/#if]
					[#elseif (deviceRtCtxtNber>1)]
						[#--multi-assignments--]
						[#if (ctxtCoreName?contains("Cortex-M"))]
/*ERR : bind_etzpc() returns errors. The configuration may be incorrect. Reason:
wrong device assignment (shared Cortex-M) - deviceName=${deviceName}*/
						[#elseif isCtxtSecure]
							[#--multi RT ctxts assignments & Secured => "Secured" & only one time--]
							[#if !srvc_map_isElmtInValuesAsList(periphIdsMap, newPeriphIdsList[0])][#--1st Id is enough--]
								[#local periphIdsMap = bind_etzpc_updateSecurityAreasMap(periphIdsMap, newPeriphIdsList, "Secured", deviceSecurityAreasControlsList).periphIdsMap]
							[/#if]
						[/#if]
					[#else]
	/*ERR : bind_etzpc() returns errors. The configuration may be incomplete. Reason:
	device has no context*/
					[/#if]
				[#--else: error, skip peripheral--]
				[/#if]
			[#--else: no match, skip peripheral--]
			[/#if]
		[/#list]

		[#--Specific Secured--]
		[#if isCtxtSecure]
			[#local periphIdsMap = srvc_map_putElmtsList(periphIdsMap, "Secured", ["STGENC"])]
		[/#if]
	[/#list]


[/#compress]
${TABnode}st,decprot = <
	[#if periphIdsMap?has_content]
		[#local securityAreasList = periphIdsMap?keys]
		[#list securityAreasList as securityArea]
${TABnode}/*"${securityArea}" peripherals*/
			[#local periphIdsList = srvc_map_getValue(periphIdsMap, securityArea)]
			[#list periphIdsList as periphId]
[#t]
				[#if periphId?starts_with("DDR")][#--Specific DDR--]
					[#local lockingStatus = "DECPROT_LOCK"]
				[#else]
					[#local lockingStatus = "DECPROT_UNLOCK"]
				[/#if]
[#t]
				[#if securityArea=="Secured"]
${TABnode}DECPROT(${mx_family?upper_case}_ETZPC_${periphId}_ID, DECPROT_S_RW, ${lockingStatus})
				[#elseif securityArea=="NS_R S_W"]
${TABnode}DECPROT(${mx_family?upper_case}_ETZPC_${periphId}_ID, DECPROT_NS_R_S_W, ${lockingStatus})
				[#elseif securityArea=="Mcu Isolation"]
${TABnode}DECPROT(${mx_family?upper_case}_ETZPC_${periphId}_ID, DECPROT_MCU_ISOLATION, ${lockingStatus})
				[#else]
${TABnode}DECPROT(${mx_family?upper_case}_ETZPC_${periphId}_ID, DECPROT_NS_RW, ${lockingStatus})
				[/#if]
			[/#list]
		[/#list]
#n
${TABnode}/*Restriction: following IDs are not managed  - please to use User-Section if needed:
	${TABnode}[#rt]
		[#list etzpc_list_notManagedPeriphIds as notManagedPeriphIds][#t]
  [#rt]${mx_family?upper_case}_ETZPC_${notManagedPeriphIds}_ID
		[/#list][#t]
*/
#n
${TABnode}/* USER CODE BEGIN etzpc_decprot */
${TABnode}	/*STM32CubeMX generates a basic and standard configuration for ETZPC.
${TABnode}	Additional device configurations can be added here if needed.
${TABnode}	"etzpc" node could be also overloaded in "addons" User-Section.*/
${TABnode}/* USER CODE END etzpc_decprot */
[#t]
	[#else]
${TABprop}/*No peripheral found*/
	[/#if]
${TABnode}>;
#n
[/#macro]
