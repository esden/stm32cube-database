[#ftl]
[#macro bind_RESMEM	pElmt pDtLevel]
[#local Tabulation=dts_get_tabs(pDtLevel)]
[#local TABnode = Tabulation.TABN]
[#local TABprop = Tabulation.TABP]
[#--	RISAB BEGIN --]
[#local Name = 2]
[#local StartAdress = 6]
[#local RegionSize = 7]
[#local RisabValues =[]]
[#list mx_RIF_Params?keys?sort as RIF_Params]
	[#if (RIF_Params?starts_with("Risab"))]
	[#local RisabValues += [RIF_Params]]
	[/#if]
[/#list]
#n
${TABnode}#address-cells = <2>;
${TABnode}#size-cells = <2>;
${TABnode}ranges;
[#list RisabValues as RisabElmt]
	[#compress]
		[#-- Risab Column values--]
		[#local NameList = []]
		[#local RegionSizeList = []]
		[#local StartAddressList = []]
		[#local RegionNameList = []]
		[#list mx_RIF_Params.entrySet() as RIF_Params]
			[#if (RIF_Params.key)?? && RIF_Params.key == RisabElmt]
			[#local value = RIF_Params.value]
				[#list value.entrySet() as risabTable_params]
					[#--uncomment for debugging:    ${risabTable_params}--]
					[#-- Converting Risab params Strings to Map Section BEGIN--]

					[#local RegionName= risabTable_params.value[Name]]
					[#local RegionNameMap= srvc_str_toMap(RegionName)]

					[#local RegionStartAddress= risabTable_params.value[StartAdress]]
					[#local StartAddressMap= srvc_str_toMap(RegionStartAddress)]

					[#local RegSize= risabTable_params.value[RegionSize]]
					[#local RegionSizeMap= srvc_str_toMap(RegSize)]

					[#list RegionNameMap?keys as RegionNameKey]
						[#if RegionNameMap[RegionNameKey]!=""]
							[#local RegionNameList=RegionNameList+[RegionNameMap[RegionNameKey]]]
						[/#if]
					[/#list]

					[#list StartAddressMap?keys as StartAddressKey]
						[#if (risabTable_params.value[Name])?matches("^\\{.+=.+\\}$")][#-- to discard empty region names --]
							[#local StartAddressList=StartAddressList+[StartAddressMap[StartAddressKey]]]
						[/#if]
					[/#list]

					[#list RegionSizeMap?keys as RegionSizeKey]
						[#if (risabTable_params.value[Name])?matches("^\\{.+=.+\\}$")][#-- to discard empty region names --]
							[#local RegionSizeList=RegionSizeList+[RegionSizeMap[RegionSizeKey]]]
						[/#if]
					[/#list]

				[/#list]
			[/#if]
		[/#list]
	[/#compress]
[#list RegionNameList as RegionNameElmt]
#n
[#if (RegionSizeList[RegionNameElmt?index]!="0x0") && RegionNameElmt?trim!=""]
${TABnode}${RegionNameElmt?replace("-","_")?lower_case}: ${RegionNameElmt?replace("_","-")?lower_case}@${StartAddressList[RegionNameElmt?index]?substring(2)} {
${TABprop}reg = <0x0 ${StartAddressList[RegionNameElmt?index]} 0x0 ${RegionSizeList[RegionNameElmt?index]}>;
${TABprop}no-map;
#n
${TABprop}/* USER CODE BEGIN ${RegionNameElmt?replace("-","_")?lower_case} */
${TABprop}/* USER CODE END ${RegionNameElmt?replace("-","_")?lower_case} */
${TABnode}};
[/#if]
[/#list]
[/#list]
[#--	RISAB END --]
[#local MCIDsGrpofTHREE = 3]
[#local UiRegionID_Index = 1]
[#local UiRegionName_Index = 2]
[#local UiStartAddress_Index = 3]
[#local UiRegionSize_Index = 4]
[#local UiMasterCIDs_Index = 5]
[#local UiSecure_Index = 6]
[#local UiEncrypt_Index = 7]
[#local RisafList = ["risaf1","risaf2","risaf4","risaf5"]][#--these must be the same keys in MCUDataModel --]
[#list RisafList as RisafElmt]
[#--	- Common section  with st-stm32-rmem_v1.0_Binding.ftl BEGIN
        - If any update in this section, st-stm32-rmem_v1.0_Binding.ftl must be updated also   --]
	[#compress]
		[#-- Risaf Column values--]
		[#local RegionNameList = []]
		[#local StartAddressList = []]
		[#local RegionSizeList = []]
		[#local RegionIDList = []]
		[#local SecureList = []]
		[#local EncryptList = []]
		[#local MasterCIDsList = []]
		[#local MasterCIDRList = []]
		[#local MasterCIDWList  = []]
		[#local MasterCIDPList  = []]
		[#local MemoryRegion = ""]
		[#list mx_RIF_Params.entrySet() as RIF_Params]
			[#if (RIF_Params.key)?? && RIF_Params.key == RisafElmt]
				[#local BKPSRAMTable = RIF_Params.value]
				[#list BKPSRAMTable.entrySet() as RISAFTable_params]
					[#--uncomment for debugging:    ${RISAFTable_params}--]
					[#-- Converting Risaf params Strings to Map Section BEGIN--]
					[#local RegionName= RISAFTable_params.value[UiRegionName_Index]]
					[#local RegionNameMap= srvc_str_toMap(RegionName)]

					[#local RegionID= RISAFTable_params.value[UiRegionID_Index]]
					[#local RegionIDMap= srvc_str_toMap(RegionID)]

					[#local MasterCIDs=RISAFTable_params.value[UiMasterCIDs_Index]]
					[#local MasterCIDsMap= srvc_str_toMap(MasterCIDs)]

					[#local Secure= RISAFTable_params.value[UiSecure_Index]]
					[#local SecureMap= srvc_str_toMap(Secure)]

					[#local Secure= RISAFTable_params.value[UiSecure_Index]]
					[#local SecureMap= srvc_str_toMap(Secure)]

					[#local Encrypt= RISAFTable_params.value[UiEncrypt_Index]]
					[#local EncryptMap= srvc_str_toMap(Encrypt)]

					[#local StartAddress= RISAFTable_params.value[UiStartAddress_Index]]
					[#local StartAddressMap= srvc_str_toMap(StartAddress)]

					[#local RegionSize= RISAFTable_params.value[UiRegionSize_Index]]
					[#local RegionSizeMap= srvc_str_toMap(RegionSize)]
					[#-- Converting Risaf params Strings to Map Section END--]

					[#list RegionNameMap?keys as RegionNameKey]
						[#if RegionNameMap[RegionNameKey]!=""]
							[#local RegionNameList=RegionNameList+[RegionNameMap[RegionNameKey]]]
							[#local MemoryRegion = MemoryRegion + "<&"+RegionNameMap[RegionNameKey]?replace("-","_")?lower_case+">, " ]
						[/#if]
					[/#list]

					[#list StartAddressMap?keys as StartAddressKey]
						[#if (RISAFTable_params.value[UiRegionName_Index])?matches("^\\{.+=.+\\}$")][#-- to discard empty region names --]
							[#local StartAddressList=StartAddressList+[StartAddressMap[StartAddressKey]]]
						[/#if]
					[/#list]

					[#list RegionSizeMap?keys as RegionSizeKey]
						[#if (RISAFTable_params.value[UiRegionName_Index])?matches("^\\{.+=.+\\}$")][#-- to discard empty region names --]
							[#local RegionSizeList=RegionSizeList+[RegionSizeMap[RegionSizeKey]]]
						[/#if]
					[/#list]

					[#list RegionIDMap?keys as RegionIDKey]
						[#if (RISAFTable_params.value[UiRegionName_Index])?matches("^\\{.+=.+\\}$")][#-- to discard empty region names --]
							[#local RegionIDList = RegionIDList + [RegionIDMap[RegionIDKey]]]
						[/#if]
					[/#list]

					[#-- Master CIDs parsing parameters and formatting section BEGIN --]
					[#list MasterCIDsMap?keys as MasterCIDsKey]
						[#local MasterCIDsList_formatted=[]]
						[#if (RISAFTable_params.value[UiRegionName_Index])?matches("^\\{.+=.+\\}$")][#-- to discard empty region names --]
							[#local MasterCIDsList = MasterCIDsMap[MasterCIDsKey]]
						[/#if]
					[/#list]
					[#local counter=0]
					[#local MasterCIDIndex=0]
					[#local MasterCIRP=[]]
					[#local MasterCIDR=""]
					[#local MasterCIDW=""]
					[#local MasterCIDP=""]
					[#list MasterCIDsList?keep_before("]")?keep_after("[")?word_list as MCIDValue]
							[#if (counter%MCIDsGrpofTHREE)==0 && (RISAFTable_params.value[UiRegionName_Index])?matches("^\\{.+=.+\\}$")]
									[#local MasterCIDR=MasterCIDR + ((MCIDValue?replace(",",""))=="true")?then("RIF_CID"+ MasterCIDIndex+"_BF|","")]
							[/#if]
							[#if ((counter+2)%MCIDsGrpofTHREE)==0 && (RISAFTable_params.value[UiRegionName_Index])?matches("^\\{.+=.+\\}$")]
									[#local MasterCIDW = MasterCIDW + ((MCIDValue?replace(",",""))=="true")?then("RIF_CID" + MasterCIDIndex + "_BF|" , "")]
							[/#if]
							[#if ((counter+1)%MCIDsGrpofTHREE)==0 && (RISAFTable_params.value[UiRegionName_Index])?matches("^\\{.+=.+\\}$")]
									[#local MasterCIDP = MasterCIDP + ((MCIDValue?replace(",",""))=="true")?then("RIF_CID" + MasterCIDIndex + "_BF|" ,"")]
									[#local MasterCIDIndex = MasterCIDIndex+1] [#-- Master CIDW shared with next list --]
							[/#if]
							[#local counter=counter+1]
					[/#list]
					[#local MasterCIDRList = MasterCIDRList+ [MasterCIDR?keep_before_last("|")]]
					[#local MasterCIDWList = MasterCIDWList+ [MasterCIDW?keep_before_last("|")]]
					[#local MasterCIDPList = MasterCIDPList+ [MasterCIDP?keep_before_last("|")]]
					[#-- Master CIDs parsing parameters and formatting section END --]

					[#list SecureMap?keys as SecureKey]
						[#if (RISAFTable_params.value[UiRegionName_Index])?matches("^\\{.+=.+\\}$")][#-- to discard empty region names --]
							[#local SecureList = SecureList + [((SecureMap[SecureKey])=="true")?then("RIF_SEC","RIF_NSEC")]][#-- to Format --]
						[/#if]
					[/#list]

					[#list EncryptMap?keys as EncryptKey]
						[#if (RISAFTable_params.value[UiRegionName_Index])?matches("^\\{.+=.+\\}$")][#-- to discard empty region names --]
							[#local EncryptList = EncryptList + [((EncryptMap[EncryptKey])=="true")?then("RIF_ENC_EN","RIF_ENC_DIS")]][#-- to Format --]
						[/#if]
					[/#list]

				[/#list]
			[/#if]
		[/#list]
	[/#compress]
[#--	common section with st-stm32-rmem_v1.0_Binding.ftl END     --]
[#list RegionNameList as RegionNameElmt]
#n
[#local startAddress64bit=(StartAddressList[RegionNameElmt?index]?keep_after_last("0x")?length<=8)?then("0x0 "+StartAddressList[RegionNameElmt?index], "0x"+((StartAddressList[RegionNameElmt?index]?keep_after_last("0x"))?left_pad(16,"0"))?substring(0,8)+ " 0x"+((StartAddressList[RegionNameElmt?index]?keep_after_last("0x"))?left_pad(16,"0"))?substring(8))]
[#local regionSize64bit=(RegionSizeList[RegionNameElmt?index]?keep_after_last("0x")?length<=8)?then("0x0 "+RegionSizeList[RegionNameElmt?index], "0x"+((RegionSizeList[RegionNameElmt?index]?keep_after_last("0x"))?left_pad(16,"0"))?substring(0,8)+ " 0x"+((RegionSizeList[RegionNameElmt?index]?keep_after_last("0x"))?left_pad(16,"0"))?substring(8))]
[#if (RegionSizeList[RegionNameElmt?index]!="0x0") && RegionNameElmt?trim!=""]
${TABnode}${(RegionNameElmt?contains("ipc-shmem") && srvcmx_isTargetedFw_inDTS("LINUX"))?then(RegionNameElmt?replace("-","_")?lower_case+"_1",RegionNameElmt?replace("-","_")?lower_case)}: ${(RegionNameElmt?contains("ipc-shmem") && srvcmx_isTargetedFw_inDTS("LINUX"))?then(RegionNameElmt?lower_case+"-1",RegionNameElmt?replace("_","-")?lower_case)}@${StartAddressList[RegionNameElmt?index]?substring(2)} {
${TABprop}reg = <${startAddress64bit} ${regionSize64bit}>;
${TABprop}no-map;
#n
${TABprop}/* USER CODE BEGIN ${RegionNameElmt?replace("-","_")?lower_case} */
${TABprop}/* USER CODE END ${RegionNameElmt?replace("-","_")?lower_case} */
${TABnode}};
[/#if]
[/#list]
[/#list]
[/#macro]

