[#ftl]
// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
/*
 * Copyright (C) ${year}, STMicroelectronics - All Rights Reserved
 * Author: STM32CubeMX code generation for STMicroelectronics.
 */

/* For more information on Device Tree configuration, please refer to
 * https://wiki.st.com/stm32mpu/wiki/Category:Device_tree_configuration
 */
[#------------------------------]
[#-- DTS FW config generation --]
[#------------------------------]
[@gen_fwconfig /]
[#------------------------------]
[#macro gen_fwconfig]
[#local module = "gen_fwconfig"]
[#local Tabulation=dts_get_tabs(1)]
[#local TABnode = Tabulation.TABN]
[#local TABprop = Tabulation.TABP]
 [#if mx_socDtRPN?starts_with("stm32mp2") ]
	[#if mx_socPtCPN?has_content]
#include "${mx_socPtCPN?substring(0,9)}-fw-config.dtsi"
	[#else]
	[@mlog  logMod=module logType="ERR" logMsg="unknown SOC pinCtrl package dtsi" varsMap={} /]
/*#include "???-pinctrl.dtsi"*/
	[/#if]
[/#if]

[#local MCIDsGrpofTHREE = 3]
[#local UiRegionID_Index = 1]
[#local UiRegionName_Index = 2]
[#local UiStartAddress_Index = 3]
[#local UiRegionSize_Index = 4]
[#local UiMasterCIDs_Index = 5]
[#local UiSecure_Index = 6]
[#local UiEncrypt_Index = 7]
[#local cpt=0]
		[#-- Risaf Column values--]
		[#local RegionNameList = []]
		[#local RegionIDList = []]
		[#local StartAddressList = []]
		[#local RegionSizeList = []]
		[#local MasterCIDsList = []]
		[#local MasterCIDRList = []]
		[#local MasterCIDWList  = []]
		[#local MasterCIDPList  = []]
		[#local SecureList = []]
		[#local EncryptList = []]
		[#compress]
		[#list mx_RIF_Params.entrySet() as RIF_Params]
			[#if (RIF_Params.key)?? && RIF_Params.key == "risaf4"]
				[#local BKPSRAMTable = RIF_Params.value]
				[#list BKPSRAMTable.entrySet() as RISAFTable_params]
					[#if (RISAFTable_params.key == "7" || RISAFTable_params.key == "8" )]
						[#local RegionID= RISAFTable_params.value[UiRegionID_Index]]
						[#local RegionIDMap= srvc_str_toMap(RegionID)]

						[#local RegionName= RISAFTable_params.value[UiRegionName_Index]]
						[#local RegionNameMap= srvc_str_toMap(RegionName)]

						[#local StartAddress= RISAFTable_params.value[UiStartAddress_Index]]
						[#local StartAddressMap= srvc_str_toMap(StartAddress)]

						[#local RegionSize= RISAFTable_params.value[UiRegionSize_Index]]
						[#local RegionSizeMap= srvc_str_toMap(RegionSize)]

						[#local MasterCIDs=RISAFTable_params.value[UiMasterCIDs_Index]]
						[#local MasterCIDsMap= srvc_str_toMap(MasterCIDs)]

						[#local Secure= RISAFTable_params.value[UiSecure_Index]]
						[#local SecureMap= srvc_str_toMap(Secure)]

						[#local Encrypt= RISAFTable_params.value[UiEncrypt_Index]]
						[#local EncryptMap= srvc_str_toMap(Encrypt)]

						[#list RegionIDMap?keys as RegionIDKey]
							[#if (RISAFTable_params.value[UiRegionName_Index])?matches("^\\{.+=.+\\}$")][#-- to discard empty region names --]
								[#local RegionIDList = RegionIDList + [RegionIDMap[RegionIDKey]]]
							[/#if]
						[/#list]

						[#list RegionNameMap?keys as RegionNameKey]
							[#if RegionNameMap[RegionNameKey]!="" ]
								[#local RegionNameList=RegionNameList+[RegionNameMap[RegionNameKey]]]
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

						[#-- Master CIDs parsing parameters and formatting section BEGIN --]
						[#list MasterCIDsMap?keys as MasterCIDsKey]
							[#local MasterCIDsList_formatted=[]]
							[#if (RISAFTable_params.value[UiRegionName_Index])?matches("^\\{.+=.+\\}$")][#-- to discard empty region names --]
								[#local MasterCIDsList = MasterCIDsMap[MasterCIDsKey]]
							[/#if]
						[/#list]

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
					[/#if]
			[/#list]
			[/#if]
		[/#list]
	[/#compress]
/ {
${TABnode}st-mem-firewall {
[#list RegionNameList as RegionNameElmt]
${TABprop}${RegionNameElmt?replace("-","_")?lower_case}: ${RegionNameElmt?lower_case}@${StartAddressList[RegionNameElmt?index]?keep_after("0x")} {
${TABprop}${TABnode}reg = <0x0 ${StartAddressList[RegionNameElmt?index]} 0x0 ${RegionSizeList[RegionNameElmt?index]}>;
${TABprop}${TABnode}st,protreg = <RISAFPROT(RISAF_REG_ID(${RegionIDList[RegionNameElmt?index]}), ${((MasterCIDRList[RegionNameElmt?index]?length)>0)?then(MasterCIDRList[RegionNameElmt?index],"0")}, ${((MasterCIDWList[RegionNameElmt?index]?length)>0)?then(MasterCIDWList[RegionNameElmt?index],"0")}, ${((MasterCIDPList[RegionNameElmt?index]?length)>0)?then(MasterCIDPList[RegionNameElmt?index],"0")}, ${SecureList[RegionNameElmt?index]}, ${EncryptList[RegionNameElmt?index]}, RIF_BREN_EN)>;
${TABprop}};
[/#list]
${TABnode}};
${TABnode}/* USER CODE BEGIN root */
${TABnode}/* USER CODE END root */
};

[/#macro]