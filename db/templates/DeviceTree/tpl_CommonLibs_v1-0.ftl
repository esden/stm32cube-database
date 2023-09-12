[#ftl]

[#----------------------------------------------------]
[#--Common services

Global variables Api:
    -cfg_traceEnable: enable the trace feature when true
--]
[#----------------------------------------------------]


[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- Basic srvc (Java data models).
	 Some FTL built-in do not operate on Java data models.--]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#-- return the keys list from a Java map
(?keys operates only on FTL map.--]
[#function srvc_javaMap_getKeysList  map]

	[#local keysList = []]
	[#list map.entrySet() as entry]
		[#local keysList = keysList + [entry.key]]
	[/#list]

[#return keysList!]
[/#function]


[#-- return a value from a Java "entrySet.keyIn"--]
[#function srvc_javaEntrySet_getValue  entrySet keyIn]

	[#list entrySet as entry]
		[#if entry.key==keyIn]
			[#return entry.value]
		[/#if]
	[/#list]

	[#return null!]
[/#function]



[#--------------------------------------------------------------------------------------------------------------------------------]				
[#-- Basic srvc (FTL data models)
	 NB: this functions should not be used on java DM (else undefined behavior) --]
[#--------------------------------------------------------------------------------------------------------------------------------]				

[#function srvc_convertNberDecToHexaString	pDecNber]
	[#local module = "srvc_convertNberDecToHexa"]
	[#local traces =  ftrace("", "module="+module+"\n") ]
	[#local errors = ""]

	[#local res = FTLUtilDecNberToHexaString(pDecNber)!]

	[#if !res?? || !res?has_content]
		[#local errors = "conversion failed"]
	[/#if]

[#return {"errors":errors!, "res":res!, "traces":traces!} ]
[/#function]


[#-- Return true if the key is found in the map.
--]
[#function srvc_map_isContainsKey  map keyIn]

	[#local keys = map?keys]
	[#if keys?seq_contains(keyIn)]
		[#return true]
	[#else]
		[#return false]
	[/#if]
[/#function]


[#-- Return value from map if key found.
The exact value of "keyIn" is searched.
Return empty value if key not found.--]
[#function srvc_map_getValue  map keyIn]

	[#local keys = map?keys]
	[#if keys?seq_contains(keyIn)]
		[#return map[keyIn]]
	[#else]
		[#return map[keyIn]!]
	[/#if]
[/#function]


[#--Return value from map if key match.
"keyIn" is compared to a "regexp".
Exact matching is expected: no subStr extraction (?size==1).
One possible regexp group extraction: the 1st group is returned. Nothing if no group.
Other groups are ignored.
Return empty value if no match.--]
[#function srvc_map_getValueIfMatchWithStatus  map keyIn]
	[#local module = "srvc_map_getValueIfMatchWithStatus"]
	[#local traces =  ftrace("", "module="+module+"\n") ]
	[#local errors = ""]

	[#local value = ""]
	[#local isMatching = false]
	[#list map?keys as key]
		[#local matchres = keyIn?matches(key)]
		[#if matchres]
			[#local value = map[key]]
			[#if !value?has_content]
				[#local isMatching = true]
				[#local res = map[keyIn]!]
			[#else]
				[#if matchres?size==1]
					[#local isMatching = true]
					[#if key?contains("(")]
						[#local group1 = matchres[0]?groups[1]]
					[/#if]
					[#local res = value]
				[#else]
					[#local errors = "malformed regexp"]
				[/#if]

				[#break]
			[/#if]
		[/#if]
	[/#list]

[#return {"errors":errors!, "isMatching":isMatching, "res":res!, "group1":group1!, "traces":traces!} ]
[/#function]


[#-- return matching status and value from map if key found--]
[#function srvc_map_getValueWithStatus  map keyIn]

	[#local keys = map?keys]
	[#if keys?seq_contains(keyIn)]
		[#return {"keyFound":true, "value":map[keyIn]}]
	[#else]
		[#return {"keyFound":false, "value":map[keyIn]!}]
	[/#if]
[/#function]


[#--copie an elmtsListIn into an existing map.
The elmtsListIn is inserted at key position in the map.
No check of compatibility between elmtsListIn and map: the map
is supposed to contain elmts of list type--]
[#function srvc_map_putElmtsList  map key elmtsListIn]

	[#local newElmtsList = srvc_map_getValue(map, key)]

	[#list elmtsListIn as elmt]
		[#local newElmtsList = newElmtsList + [elmt]]
	[/#list]

	[#local map = map + {key:newElmtsList}]

[#return map!]
[/#function]


[#--search the provided elmt in the entry map with values composed as list of elmts--]
[#function srvc_map_isElmtInValuesAsList  mapIn elmtIn]

	[#local isElmtFound = false]
	[#list mapIn?values as valuesList]
		[#if valuesList?seq_contains(elmtIn)]
			[#local isElmtFound = true]
			[#break]
		[/#if]
	[/#list]

[#return isElmtFound]
[/#function]


[#--Search in a strings list an element starting the provided string.
	Return the 1st found element from the list. Empty if nothing match.--]
[#function srvc_list_getStringElmtStartingTheString  pStringsListIn pStringIn]

	[#list pStringsListIn as elmt]
		[#if pStringIn?starts_with(elmt)]
			[#return elmt]
			[#break]
		[/#if]
	[/#list]
[#return ""]
[/#function]


[#-- replace anywhere in a strings list the origin str by the destination str--]
[#function srvc_list_replaceString  strInList oriStr destStr]
	[#local module = "srvc_list_replaceString"]
	[#local traces =  ftrace("", "module="+module+"\n") ]
	[#local errors = ""]

	[#local strOutList = []]
	[#list strInList  as strIn]
		[#if strIn?contains(oriStr)]
			[#if destStr?has_content]
				[#local strOutList = strOutList + [strIn?replace(oriStr, destStr)] ]
			[#else]
				[#local errors = "empty destStr - strInList= " + strInList! + " - oriStr= " + oriStr!]
				[#break]
			[/#if]
		[#else]
			[#local strOutList = strOutList + [strIn] ]
		[/#if]
	[/#list]

[#return {"errors":errors!, "res":strOutList!, "traces":traces!} ]
[/#function]


[#--------------------------------------------------------------------------------------------------------------------------------]
[#-- Debug srvc --]
[#--------------------------------------------------------------------------------------------------------------------------------]

[#-- log from function --]
[#function flog   logErr logMod logType logMsg varsMap]

	[#local outmsg = logErr + "/* !!! log "]

	[#if logType?has_content]
		[#if logType=="ERR"]
			[#local logType = "Internal error"]
		[#elseif logType=="WARN"]
			[#local logType = "Warning"]
		[#else]
			[#local logType = "Unknown error"]
		[/#if]

		[#local outmsg = outmsg + ": " + logType + " "]
	[#else]
		[#--local outmsg = outmsg + ": noLogType "--]
	[/#if]

	[#if logMod?has_content]
		[#local outmsg = outmsg + "- " + logMod + " "]
	[#else]
		[#--local outmsg = outmsg + "- noLogMod "--]
	[/#if]

	[#if logMsg?has_content]
		[#local outmsg = outmsg + "- " + logMsg + " "]
	[#else]
		[#--local outmsg = outmsg + "- noLogMsg "--]
	[/#if]

	[#if varsMap?has_content]
		[#local outmsg = outmsg + "- vars "]

		[#local keys = varsMap?keys]
		[#list keys as key]
			[#local outmsg = outmsg + ": " + key + "="]

			[#if varsMap[key]?has_content]
				[#local outmsg = outmsg + varsMap[key] + " "]
			[#else]
				[#local outmsg = outmsg + "?"]
			[/#if]
		[/#list]
	[/#if]

	[#local outmsg = outmsg + " !!! */"]

	[#return outmsg ]
[/#function]


[#-- log from macro --]
[#macro mlog   logMod logType logMsg  varsMap]
${flog("", "", logType, logMsg, varsMap)}
[/#macro]


[#-- trace from function --]
[#function ftrace  traces message]
	[#if cfg_traceEnable?? && cfg_traceEnable]
		[#return traces + message]
	[/#if]
[#return traces]
[/#function]


[#-- trace from macro --]
[#macro mtrace  traces]
	[#if cfg_traceEnable?? && cfg_traceEnable]
#n
/*Trace>>>
  ---
${traces}
<<<Trace*/
#n
	[/#if]
[/#macro]
