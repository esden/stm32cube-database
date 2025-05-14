[#ftl]
[#compress]




[#assign RIMU_IP_RENAME="GPU:GPU2D,LTDC_L1:LTDC1,LTDC_L2:LTDC2"]
[#assign RISUP_IP_RENAME="CRYP1:CRYP,GPU:GPU2D,LTDC_L1:LTDCL1,LTDC_L2:LTDCL2,LTDC_CMN:LTDC,OTG1_HS:OTG1HS,OTG2_HS:OTG2HS,CSI2HOST:CSI,SPI1/I2S1:SPI1,SPI2/I2S2:SPI2,SPI3/I2S3:SPI3,SPI6/I2S6:SPI6"]
[#assign RISAF_TABLE_RENAME="TCM:RISAF1,CPUAXI_RAM0:RISAF2,CPUAXI_RAM1:RISAF3,NPU_master0:RISAF4,NPU_master1:RISAF5,CPU_master:RISAF6,FLEXRAM:RISAF7,CACHEAXI_RAM:RISAF8,VENCRAM:RISAF9,XSPI1:RISAF11,XSPI2:RISAF12,XSPI3:RISAF13,FMC:RISAF14,CACHEAXI_configuration_port:RISAF15,AHB_RAM1:RISAF21,AHB_RAM2:RISAF22,Backup_RAM:RISAF23"]
[#assign RIFAWARE_PWR_FEATURE="System supply:PWR_ITEM_0,Programmable:PWR_ITEM_1,VDDCORE:PWR_ITEM_2,I-TCM:PWR_ITEM_3,Voltage scaling:PWR_ITEM_4,Backup:PWR_ITEM_5,CPU:PWR_ITEM_6,Peripheral:PWR_ITEM_7,WKUP1:PWR_ITEM_WKUP1,WKUP2:PWR_ITEM_WKUP2,WKUP3:PWR_ITEM_WKUP3,WKUP4:PWR_ITEM_WKUP4"]
[#assign RIFAWARE_RCC_FEATURE="PLL1:RCC_ITEM_PLL1,PLL2:RCC_ITEM_PLL2,PLL3:RCC_ITEM_PLL3,PLL4:RCC_ITEM_PLL4,IC1:RCC_ITEM_IC1,IC2:RCC_ITEM_IC2,IC3:RCC_ITEM_IC3,IC4:RCC_ITEM_IC4,IC5:RCC_ITEM_IC5,IC6:RCC_ITEM_IC6,IC7:RCC_ITEM_IC7,IC8:RCC_ITEM_IC8,IC9:RCC_ITEM_IC9,IC10:RCC_ITEM_IC10,IC11:RCC_ITEM_IC11,IC12:RCC_ITEM_IC12"]
[#assign RIFAWARE_RCC_FEATURE+=",IC13:RCC_ITEM_IC13,IC14:RCC_ITEM_IC14,IC15:RCC_ITEM_IC15,IC16:RCC_ITEM_IC16,IC17:RCC_ITEM_IC17,IC18:RCC_ITEM_IC18,IC19:RCC_ITEM_IC19,IC20:RCC_ITEM_IC20,DFT:RCC_ITEM_DFT,RST:RCC_ITEM_RST,INT:RCC_ITEM_INT,PER:RCC_ITEM_PER,BUS:RCC_ITEM_BUS,SYS:RCC_ITEM_SYS,MOD:RCC_ITEM_MOD,ACLKN:RCC_ITEM_ACLKN,ACLKNC:RCC_ITEM_ACLKNC"]
[#assign RIFAWARE_RCC_FEATURE+=",AHBM:RCC_ITEM_AHBM,AHB1:RCC_ITEM_AHB1,AHB2:RCC_ITEM_AHB2,AHB3:RCC_ITEM_AHB3,AHB4:RCC_ITEM_AHB4,AHB5:RCC_ITEM_AHB5,APB1:RCC_ITEM_APB1,APB2:RCC_ITEM_APB2,APB3:RCC_ITEM_APB3,APB4:RCC_ITEM_APB4,APB5:RCC_ITEM_APB5,NOC:RCC_ITEM_NOC"]
[#assign RIFAWARE_RTC_FEATURE="Alarm A:ALRA,Alarm B:ALRB,Wake-up:WUT,Timestamp:TS,calibration:CAL,Initialization:INIT"]

#t/* set all required IPs as secure privileged */
#t__HAL_RCC_RIFSC_CLK_ENABLE();

[#-----------------------------RIMU part  ------------------------------]
[#assign lock = "false"]
[#if RIMU??]
    [#list RIMU as rimu ]


            [#if rimu.secure == "true" || rimu.privilege == "true"]

                [#if lock == "false"]
                    #tRIMC_MasterConfig_t RIMC_master = {0};
                    #tRIMC_master.MasterCID = RIF_CID_1;
                    #tRIMC_master.SecPriv = RIF_ATTRIBUTE_SEC | RIF_ATTRIBUTE_PRIV;
                    #n#t/*RIMC configuration*/
                    [#assign lock = "true"]
                [/#if]
                [#assign ipName=Rename(RIMU_IP_RENAME,rimu.ipName)]
                #tHAL_RIF_RIMC_ConfigMasterAttributes(RIF_MASTER_INDEX_${ipName}, &RIMC_master);
            [/#if]
    [/#list]
[/#if ]

[#-----------------------------RISUP part  ------------------------------]
[#assign lock = "false"]
[#if RISUP??]
    [#list RISUP as risup ]
            [#if (risup.secure?? && risup.secure == "true") || risup.privilege == "true"]
                [#if lock == "false"]
                    #n#t/*RISUP configuration*/
                    [#assign lock = "true"]
                [/#if]
                [#if (!risup.secure??|| risup.secure == "true") ]
                    [#assign secure_attrebut = "RIF_ATTRIBUTE_SEC"]
                [#else]
                    [#assign secure_attrebut = "RIF_ATTRIBUTE_NSEC"]
                [/#if]

                [#if risup.privilege == "true"]
                    [#assign privilege_attrebut = "RIF_ATTRIBUTE_PRIV"]
                [#else]
                    [#assign privilege_attrebut = "RIF_ATTRIBUTE_NPRIV"]
                [/#if]
                [#assign ipName=Rename(RISUP_IP_RENAME,risup.ipName)]
                #tHAL_RIF_RISC_SetSlaveSecureAttributes(RIF_RISC_PERIPH_INDEX_${ipName} , ${secure_attrebut} | ${privilege_attrebut});
            [/#if]
    [/#list]
[/#if ]

[#-----------------------------IAC part  ------------------------------]
    [#assign lock = "false"]
[#if IAC??]

    [#list IAC as iac ]
        [#if iac.active == "true"]
            [#if lock == "false"]
                #n#t/*IAC configuration*/
                [#assign lock = "true"]
            [/#if]
            #tHAL_RIF_IAC_EnableIT(${iac.id});
        [/#if]
    [/#list]

    [#if lock == "true"]
        #n#t/* IAC interrupt Init */
        #tHAL_NVIC_SetPriority(IAC_IRQn, 0x0, 0x0);
        #tHAL_NVIC_EnableIRQ(IAC_IRQn);#n
    [/#if]
[/#if ]

[#-----------------------------RISAF base region part  ------------------------------]
[#assign lock = "false"]
[#if RISAF_BASE_REGEION??]
    [#assign structRef=""]
    [#list RISAF_BASE_REGEION as baseRegion ]
        [#list baseRegion.entrySet() as entry]
            [#if lock == "false"]
                #n#n#t/* RISAF Config */
                #tRISAF_BaseRegionConfig_t risaf_base_config;
                #t__HAL_RCC_RISAF_CLK_ENABLE();
                [#assign lock = "true"]
            [/#if]
            [#assign risafName=entry.key]
            [#assign regions=entry.value]
            [#assign RISAF_NAME=Rename(RISAF_TABLE_RENAME,risafName)]

            [#if lock == "true"]
            #n#t/* set up base region configuration for ${risafName}*/
            [/#if]

            [#list regions  as region]
                    #t/* ${region.Region} is [#if region.Secure == "true"]secure [#else]non-secure [/#if] */
                    [@generateCode region structRef "risaf_base_config"/]
                    #tHAL_RIF_RISAF_ConfigBaseRegion(${RISAF_NAME}, RISAF_REGION_${region.id}, &risaf_base_config);#n
            [/#list]
        [/#list]
    [/#list]
#n
[/#if ]

[#-----------------------------RISAF sub region part  ------------------------------]
[#if RISAF_SUB_REGEION??]
    [#assign structRef=""]
    [#assign lock = "false"]

    [#list RISAF_SUB_REGEION as subRegion ]
        [#list subRegion.entrySet() as entry]
            [#if lock == "false"]
                #tRISAF_SubRegionConfig_t risaf_sub_config;
                [#assign lock = "true"]
            [/#if]
            [#assign risafName=entry.key]
            [#assign subRegions=entry.value]
            [#assign RISAF_NAME=Rename(RISAF_TABLE_RENAME,risafName)]

            [#if lock == "true"]
            #n#t/* set up Sub region configuration for ${risafName}*/
            [/#if]

            [#list subRegions  as subRegion]
                [@generateCode subRegion structRef "risaf_sub_config"/]
                #tHAL_RIF_RISAF_ConfigSubRegion(${RISAF_NAME}, RISAF_REGION_${subRegion.id}, RISAF_SUBREGION_${subRegion.name}, &risaf_sub_config);#n
            [/#list]
        [/#list]
    [/#list]
#n
[/#if ]

[#-----------------------------RIF-AWARE part ------------------------------]
[#if RIF_AWARE?? ]
    [#assign lock = "false"]
    [#assign RTC_Flag = true]
    [#assign rtcPrivilegeFeatures=""]
    [#assign rtcPrivilegeFeaturesCount=1]
    [#assign backupRegisterPrivZone=""]
    [#assign rtcPrivilegeFull=""]

    [#list RIF_AWARE as ip ]
        [#list ip.entrySet() as entry]
            [#if lock == "false" ]
                #n#n#t/* RIF-Aware IPs Config */
                [#assign lock = "true"]
            [/#if]
            [#assign ipName=entry.key]
            [#assign ipData=entry.value]

            [#if ipName=="PWR"]
                #n#t/* set up PWR configuration */
                [#list ipData  as value]
                    #tHAL_PWR_ConfigAttributes(${Rename(RIFAWARE_PWR_FEATURE,value.Feature)},${getRefernce("PWR_SecPriv",value.Secure+","+value.Privilege,"")});
                [/#list]
                #n
            [/#if]

            [#if ipName=="GPIO"]
                #n#t/* set up GPIO configuration */
                [#list ipData  as value]
                    #tHAL_GPIO_ConfigPinAttributes(GPIO${value.Feature?substring(1,2)},GPIO_PIN_${value.Feature?substring(2)},${getRefernce("GPIO_SecPriv",value.Secure+","+value.Privilege,"")});
                [/#list]
                #n
            [/#if]

            [#if ipName=="RCC"]
                #n#t/* set up RCC configuration */
                [#list ipData  as value]
                    #tHAL_RCC_ConfigAttributes(${Rename(RIFAWARE_RCC_FEATURE,value.Feature)},${getRefernce("RCC_SecPrivLock",value.Secure+","+value.Privilege,value.Lock)});
                [/#list]
                #n
            [/#if]

            [#if ipName=="EXTI"]
                #n#t/* set up EXTI configuration */
                [#list ipData  as value]
                    #t/* ${value.Feature} line  */
                    #tHAL_EXTI_ConfigLineAttributes(${value.Id},${getRefernce("EXTI_SecPriv",value.Secure+","+value.Privilege,"")});
                [/#list]
                #n
            [/#if]

            [#if ipName?matches("HPDMA|GPDMA")]
                #n#t/* set up ${ipName} configuration */
                [#list ipData  as value]
                    #t/* set ${value.Feature} */
                    [#assign Channel =value.Feature?split(" ")]
                     #tif (HAL_DMA_ConfigChannelAttributes(&handle_${Channel[0]}_Channel${Channel[2]},${getRefernce("DMA_SecPriv",value.Secure+","+value.Privilege,"")})!= HAL_OK )
                    #t{
                    #t#tError_Handler();
                    #t}
                [/#list]
                #n
            [/#if]

            [#if ipName?matches("RTC|TAMP") && RTC_Flag]
                [#assign isGlobalP=false]
                [#assign isGlobalS=false]
                [#if ip.get("RTC")?? ]
                    [#list ip.get("RTC")  as value]
                        [#if value.Feature?contains("global") ]
                            [#if  value.Privilege=="true"]
                                [#assign isGlobalP=true]
                            [/#if]
                            [#if  value.Secure=="true"]
                                [#assign isGlobalS=true]
                            [/#if]
                        [/#if]
                    [/#list]
                [/#if]

                [#assign structP="Instance:privilegeState,rtcPrivilegeFull:"+getRTC_Value(ip,isGlobalP,"privilege_Full")+",rtcPrivilegeFeatures:"+getRTC_Value(ip,isGlobalP,"privilege_Features")+",tampPrivilegeFull:"+getRTC_Value(ip,isGlobalP,"privilege_tamper")+",MonotonicCounterPrivilege:"+getRTC_Value(ip,isGlobalP,"privilege_Monotonic")]
                [#assign structP+=",backupRegisterPrivZone:"+getRTC_Value(ip,isGlobalP,"BKUP_PZone")+",backupRegisterStartZone2:"+getRTC_Value(ip,isGlobalP,"BKUP_R2")+",backupRegisterStartZone3:"+getRTC_Value(ip,isGlobalP,"BKUP_R3")]

                [#assign structS="Instance:secureState,rtcSecureFull:"+getRTC_Value(ip,isGlobalS,"secure_Full")+",rtcNonSecureFeatures:"+getRTC_Value(ip,isGlobalS,"secure_Features")+",MonotonicCounterSecure:"+getRTC_Value(ip,isGlobalS,"secure_Monotonic")+",tampSecureFull:"+getRTC_Value(ip,isGlobalS,"secure_tamper") ]
                [#assign structS+=",backupRegisterStartZone2:"+getRTC_Value(ip,isGlobalS,"BKUP_R2")+",backupRegisterStartZone3:"+getRTC_Value(ip,isGlobalS,"BKUP_R3")]

                #tRTC_PrivilegeStateTypeDef ${getInstance( structP )} = {0};
                #tRTC_SecureStateTypeDef ${getInstance( structS )} = {0};#n

                [@printS structP/]
                #tif (HAL_RTCEx_PrivilegeModeSet(&hrtc, &${instance}) != HAL_OK)
                #t{
                    #t#tError_Handler();
                #t}#n

                [@printS structS/]
                #tif (HAL_RTCEx_SecureModeSet(&hrtc, &${instance}) != HAL_OK)
                #t{
                    #t#tError_Handler();
                #t}

                 [#assign RTC_Flag = false]
            [/#if]

        [/#list]
    [/#list]
    #n
[/#if ]

[/#compress]

[#-------------------------------- Macros & Functions Part  ----------------------------------------]

[#--This function takes an old name as argument and searches for it in a list.--]
[#--If it is found, it is then replaced by the new name.  --]

[#function Rename list oldName]
    [#assign mappings=list?split(",") ]
    [#list mappings as mapping]
        [#assign pair=mapping?split(":")]
        [#if oldName?contains(pair[0])]
            [#return pair[1] ]
        [/#if]
    [/#list]
    [#return oldName]
[/#function]

[#-- The purpose of this macro is to fill a structure --]
[#-- and ensure that the instruction is not repeated twice. --]

[#macro generateCode struct structRef instanceName]
    [#list struct.entrySet() as key_S]
        [#local key=key_S.key]
        [#local value=key_S.value]
        [#if structRef == "" || (value != structRef.get(key))]
            [#if key?matches("id|Region|name|CID|DelegatedCID|Delegation")]
                [#-- No think to do --]
            [#elseif key?matches("EndAddress")]
                [#--struct.get("StartAddress") waiting to fix startAdress --]
                #t${instanceName}.${key} = ${getEndAddress("0x00",value)};
            [#else]
                #t${instanceName}.${key} = ${getRefernce(key,value,"")};
            [/#if]
        [/#if]
    [/#list]
    [#assign structRef=struct ]
[/#macro]

[#--  --]
[#function getRefernce key value value2]
    [#if key == "Filtering"]
        [#return "RISAF_FILTER_"+(value=="true")?then("ENABLE", "DISABLE")]
    [#elseif key == "Secure"]
        [#return "RIF_ATTRIBUTE_"+(value=="true")?then("SEC", "NSEC")]
    [#elseif key == "WriteWhitelist"]
        [#return (value=="0")?then("RIF_CID_NONE", value)]
    [#elseif key == "ReadWhitelist"]
        [#return (value=="0")?then("RIF_CID_NONE", value)]
    [#elseif key == "PrivWhitelist"]
        [#return (value=="0")?then("RIF_CID_NONE", value)]
    [#elseif key == "ReadWrite"]
        [#assign ret=value?split(",")]
        [#return (ret[0]=="true")?then("RISAF_READ_ENABLE", "RISAF_READ_DISABLE")+"|"+(ret[1]=="true")?then("RISAF_WRITE_ENABLE", "RISAF_WRITE_DISABLE")]
    [#elseif key == "SecPriv"]
        [#assign ret=value?split(",")]
        [#return (ret[0]=="true")?then("RIF_ATTRIBUTE_SEC", "RIF_ATTRIBUTE_NSEC")+"|"+(ret[1]=="true")?then("RIF_ATTRIBUTE_PRIV", "RIF_ATTRIBUTE_NPRIV")]
    [#elseif key == "Lock"]
        [#return "RIF_LOCK_"+(value=="true")?then("ENABLE", "DISABLE")]
    [#elseif key == "PWR_SecPriv"]
        [#assign ret=value?split(",")]
        [#return "PWR_"+(ret[0]=="true")?then("", "N")+"SEC_"+(ret[1]=="true")?then("", "N")+"PRIV"]
    [#elseif key == "GPIO_SecPriv"]
        [#assign ret=value?split(",")]
        [#return (ret[0]=="true")?then("GPIO_PIN_SEC", "GPIO_PIN_NSEC")+"|"+(ret[1]=="true")?then("GPIO_PIN_PRIV", "GPIO_PIN_NPRIV")]
    [#elseif key == "RCC_SecPrivLock"]
        [#assign ret=value?split(",")]
        [#return (ret[0]=="true")?then("RCC_ATTR_SEC", "RCC_ATTR_NSEC")+"|"+(ret[1]=="true")?then("RCC_ATTR_PRIV", "RCC_ATTR_NPRIV")+"|"+(value2=="true")?then("RCC_ATTR_LOCK", "RCC_ATTR_NLOCK")]
    [#elseif key == "EXTI_SecPriv"]
        [#assign ret=value?split(",")]
        [#return (ret[0]=="true")?then("EXTI_LINE_SEC", "EXTI_LINE_NSEC")+"|"+(ret[1]=="true")?then("EXTI_LINE_PRIV", "EXTI_LINE_NPRIV")]
    [#elseif key == "DMA_SecPriv"]
        [#assign ret=value?split(",")]
        [#return (ret[0]=="true")?then("DMA_CHANNEL_SEC", "DMA_CHANNEL_NSEC")+"|"+(ret[1]=="true")?then("DMA_CHANNEL_PRIV", "DMA_CHANNEL_NPRIV")]
    [#else]
        [#return value]
    [/#if]
[/#function]

[#--The purpose of this macro is to calculate the sum--]
[#--of the starting address and the region size.--]

[#function getEndAddress startAddress ReginSize]
        [#assign  intStartAddress =Integer.parseInt( startAddress?substring(2), 16)]
        [#assign  intReginSize =Integer.parseInt(ReginSize?substring(2), 16)]
        [#assign resultValue = intStartAddress + intReginSize]
        [#return "0x"+Integer.toHexString(resultValue)]
[/#function]

[#function getInstance struct]
    [#local mappings=struct?split(",") ]
    [#list mappings as mapping]
        [#local pair=mapping?split(":")]
        [#if pair[0] == "Instance"]
            [#return pair[1]]
        [/#if]
    [/#list]
[/#function]

[#macro printS struct]
    [#assign instance=""]
    [#local mappings=struct?split(",") ]
    [#list mappings as mapping]
        [#local pair=mapping?split(":")]
        [#if pair[0] == "Instance"]
            [#assign instance=pair[1]]
        [#elseif pair[1] != ""]
            #t${instance}.${pair[0]}= ${pair[1]};
        [/#if]
    [/#list]
[/#macro]


[#--    ************** --]
[#function getRTC_Value Ip global key]
    [#local various=(key?contains("privilege"))?then("Privilege","Secure")]
    [#local various2=(key?contains("privilege"))?then("Privilege","NonSecure")]

                            [#------------- RTC Struct ------------]
    [#if key?contains("Full")]
        [#return "RTC_"+various?upper_case+"_FULL_"+global?then("YES", "NO")]

    [#elseif key?contains("Features") && Ip.get("RTC")??]

        [#if global ]
            [#return "RTC_"+various2?upper_case+"_FEATURE_NONE"]
        [#else]
            [#local checkedCounter=0]
            [#local Features=""]
            [#list Ip.get("RTC")  as value]
                [#if value.get(various) == "true"]
                    [#if Features == ""]
                        [#local Features="RTC_"+various2?upper_case+"_FEATURE_"+Rename(RIFAWARE_RTC_FEATURE,value.Feature)]
                    [#else]
                        [#local Features+="|"+"RTC_"+various2?upper_case+"_FEATURE_"+Rename(RIFAWARE_RTC_FEATURE,value.Feature)]
                    [/#if]
                    [#local checkedCounter++]
                [/#if]
            [/#list]
            [#if checkedCounter == 6 ]
                [#return "RTC_"+various2?upper_case+"_FEATURE_ALL"]
            [#elseif checkedCounter == 0 ]
                [#return "RTC_"+various2?upper_case+"_FEATURE_NONE"]
            [#else]
                [#return Features]
            [/#if]
        [/#if]
    [/#if]
                            [#------------- TAMP Struct ------------]
    [#if Ip.get("TAMP")??]
        [#list Ip.get("TAMP") as value]
            [#if value.Feature?contains("read/write")]
                [#local registreRW=value]
            [#elseif value.Feature?contains("write")]
                [#local registreW=value]
            [#elseif value.Feature?contains("Tamper")]
                [#local tamp=value]
            [#elseif value.Feature?contains("Monotonic")]
                [#local monotonic=value]
            [/#if]
        [/#list]
        [#if key?contains("tamper") && tamp??]
            [#return "TAMP_"+various?upper_case+"_FULL_"+(tamp.get(various?capitalize) == "true")?then("YES", "NO")]
        [#elseif key?contains("Monotonic") && monotonic??]
            [#return "TAMP_MONOTONIC_CNT_"+various?upper_case+"_"+(monotonic.get(various?capitalize) == "true")?then("YES", "NO")]
        [#elseif key?contains("BKUP_R2") && registreW??]
            [#return "RTC_BKP_DR"+registreW.Secure]
        [#elseif key?contains("BKUP_R3") && registreRW??]
            [#return "RTC_BKP_DR"+registreRW.Secure]
        [#elseif key?contains("BKUP_PZone")  ]
            [#local Ret=""]
            [#local BKUP="RW:"+(registreRW??)?then(registreRW.Privilege,"false")+"_W:"+(registreW??)?then(registreW.Privilege,"false")]

            [#if BKUP?contains("RW:true_W:true")]
                [#return "RTC_PRIVILEGE_BKUP_ZONE_ALL"]
            [#elseif BKUP?contains("RW:true")]
                [#return "RTC_PRIVILEGE_BKUP_ZONE_1"]
            [#elseif BKUP?contains("W:true")]
                [#return "RTC_PRIVILEGE_BKUP_ZONE_2"]
            [#else]
                [#return "RTC_PRIVILEGE_BKUP_ZONE_NONE"]
            [/#if]

        [/#if]
    [/#if]

    [#if key?contains("BKUP_R2")]
        [#return "RTC_BKP_DR0"]
    [#elseif key?contains("BKUP_R3")]
        [#return "RTC_BKP_DR0"]
    [/#if]

    [#return ""]
[/#function]


