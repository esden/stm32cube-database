[#ftl]

[#--Common services--]

[#--------------------------------------------------------------------------------------------------------------------------------]				
[#-- Basic srvc --]
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


[#function srvc_map_getKeysList  map]

	[#local keysList = []]
	[#list map.entrySet() as entry]
		[#local keysList = keysList + [entry.key]]
	[/#list]

[#return keysList]
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
One possible group replacement: "$1" replacement is performed when matching.
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
						[#local res = value?replace("$1", matchres[0]?groups[1])]
					[#else]
						[#local res = value]
					[/#if]
				[#else]
					[#local errors = "malformed regexp"]
				[/#if]

				[#break]
			[/#if]
		[/#if]
	[/#list]

[#return {"errors":errors!, "isMatching":isMatching, "res":res!, "traces":traces!} ]
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
	[#if cfg_traceEnable]
		[#return traces + message]
	[/#if]
[#return traces]
[/#function]


[#-- trace from macro --]
[#macro mtrace  traces]
	[#if cfg_traceEnable]
#n
/*Trace>>>
  ---
${traces}
<<<Trace*/
#n
	[/#if]
[/#macro]
