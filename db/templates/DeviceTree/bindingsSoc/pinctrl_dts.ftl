[#ftl]

[#compress]
[#list configs as dt]
[#assign data = dt]
[#assign dtPinCtrlDataModelNoZ = dt.dtPinCtrlDataModelNoZ]
[#assign dtPinCtrlDataModelZ = dt.dtPinCtrlDataModelZ]

[#assign ipInstanceListNoZ = dt.ipInstanceListNoZ]
[#assign ipInstanceListZ = dt.ipInstanceListZ]

[#assign pinCtrlBankZ = dt.pinCtrlBankZ]

[#assign ipPinCtrlNodesNoZ = dt.ipPinCtrlNodesNoZ]
[#assign ipPinCtrlNodesZ = dt.ipPinCtrlNodesZ]

[#assign wakeupIps = dt.wakeupIps]

[#assign GPIOMode = { "GPIO_MODE_AF_OD": "drive-open-drain", "GPIO_MODE_AF_PP": "drive-push-pull" }]
[#assign GPIOPuPd = { "GPIO_NOPULL": "bias-disable", "GPIO_PULLUP": "bias-pull-up", "GPIO_PULLDOWN": "bias-pull-down" }]
[#assign GPIOSpeed = { "GPIO_SPEED_FREQ_LOW": "slew-rate = <0>", "GPIO_SPEED_FREQ_MEDIUM": "slew-rate = <1>", "GPIO_SPEED_FREQ_HIGH": "slew-rate = <2>", "GPIO_SPEED_FREQ_VERY_HIGH": "slew-rate = <3>" }]

[#assign T1 = "#t#t"] [#-- 1 Tab = 2 spaces --]
[#assign T2 = "#t#t#t#t"] [#-- 2 Tab = 4 spaces --]
[#assign T3 = "#t#t#t#t#t#t"] [#-- 3 Tab = 6 spaces --]
[#assign T4 = "#t#t#t#t#t#t#t#t"] [#-- 4 Tab = 8 spaces --]
[#assign T5 = "#t#t#t#t#t#t#t#t#t#t"] [#-- 5 Tab = 10 spaces --]

[#--build nodes list to generate based on dtIODevicesList IPs list--]
[#assign nodesToGenerate = []]
[#assign akNode = false]
[#assign zNode = false]
[#list srvcmx_getListOfDevicesWithPinCtrl_inDTS() as ip]
    [#assign ipUpper = ip?upper_case ]
    [#if ipPinCtrlNodesNoZ.containsKey(ipUpper)]
        [#assign nodesToGenerate = nodesToGenerate + ipPinCtrlNodesNoZ.get(ipUpper) ]
        [#assign akNode = true]
    [/#if]
    [#if ipPinCtrlNodesZ.containsKey(ipUpper) && pinCtrlBankZ]
        [#assign nodesToGenerate = nodesToGenerate + ipPinCtrlNodesZ.get(ipUpper) ]
        [#assign zNode = true]
    [/#if]
[/#list]

[#if srvcmx_isTargetedFw_inDTS("LINUX")] [#--FW contextualization--]
    [#assign kernelDt = true ]
[#else]
    [#assign kernelDt = false ]
[/#if]

[#if srvcmx_isTargetedFw_inDTS("U-BOOT")] [#--FW contextualization--]
    [#assign uBootDt = true ]
[#else]
    [#assign uBootDt = false ]
[/#if]

[#if uBootDt]
	&gpioa {
		${T1}compatible = "st,stm32-gpio";
		${T1}u-boot,dm-pre-reloc;
	};
	&gpiob {
		${T1}compatible = "st,stm32-gpio";
		${T1}u-boot,dm-pre-reloc;
	};
	&gpioc {
		${T1}compatible = "st,stm32-gpio";
		${T1}u-boot,dm-pre-reloc;
	};
	&gpiod {
		${T1}compatible = "st,stm32-gpio";
		${T1}u-boot,dm-pre-reloc;
	};
	&gpioe {
		${T1}compatible = "st,stm32-gpio";
		${T1}u-boot,dm-pre-reloc;
	};
	&gpiof {
		${T1}compatible = "st,stm32-gpio";
		${T1}u-boot,dm-pre-reloc;
	};
	&gpiog {
		${T1}compatible = "st,stm32-gpio";
		${T1}u-boot,dm-pre-reloc;
	};
	&gpioh {
		${T1}compatible = "st,stm32-gpio";
		${T1}u-boot,dm-pre-reloc;
	};
	&gpioi {
		${T1}compatible = "st,stm32-gpio";
		${T1}u-boot,dm-pre-reloc;
	};
	&gpioj {
		${T1}compatible = "st,stm32-gpio";
		${T1}u-boot,dm-pre-reloc;
	};
	&gpiok {
		${T1}compatible = "st,stm32-gpio";
		${T1}u-boot,dm-pre-reloc;
	};
[#elseif akNode] [#--to not generate empty nodes for atf DT & not pinCtrl for uBoot DT--]
    &pinctrl {
    [#if kernelDt] [#--no 'u-boot,dm-pre-reloc' tags for atf DT--]
        ${T1}u-boot,dm-pre-reloc;
    [/#if]
    [@pinctrlPrint dtPinCtrlDataModel=dtPinCtrlDataModelNoZ ipInstanceList=ipInstanceListNoZ bankZ=false sleep=false/]
    [#if kernelDt]
        [@pinctrlPrint dtPinCtrlDataModel=dtPinCtrlDataModelNoZ ipInstanceList=ipInstanceListNoZ bankZ=false sleep=true/]
    [/#if]
    }; 
[/#if]

[#if pinCtrlBankZ]
    [#if uBootDt]
        &gpioz {
            ${T1}compatible = "st,stm32-gpio";
            ${T1}u-boot,dm-pre-reloc;
        };
    [#elseif zNode && !uBootDt] [#--to not generate empty nodes for atf DT & not pinCtrl for uBoot DT--]
        &pinctrl_z {
        [#if kernelDt]
            ${T1}u-boot,dm-pre-reloc;
        [/#if]
        [@pinctrlPrint dtPinCtrlDataModel=dtPinCtrlDataModelZ ipInstanceList=ipInstanceListZ bankZ=true sleep=false/]
        [#if kernelDt]
            [@pinctrlPrint dtPinCtrlDataModel=dtPinCtrlDataModelZ ipInstanceList=ipInstanceListZ bankZ=true sleep=true/]
        [/#if]
        }; 
    [/#if]
[/#if]

[/#list]
[/#compress]



[#function noContainsStr strlist str]
    [#list strlist as elem]
        [#if str = elem]
            [#return false]
        [/#if]
    [/#list]
    [#return true]
[/#function]



[#-- macro pinctrlPrint --]
[#macro pinctrlPrint dtPinCtrlDataModel ipInstanceList bankZ sleep]
        [#-- For each used ip, list all configuration data --]

    [#list ipInstanceList as ip]
        [#assign ipLower = ip?lower_case ]
        [#assign wakeupIP = false ]
     
        [#if srvcmx_getBootloadersEnabledDevicesList()?seq_contains(ipLower) && kernelDt]
            [#assign ipBootTag = true ]
        [#else]
            [#assign ipBootTag = false ]
        [/#if]
        [#if sleep]
            [#list wakeupIps as wakeupIp]
                [#if ipLower?matches(wakeupIp)]
                    [#assign wakeupIP = true ]
                    [#break]
                [/#if]
            [/#list]
        [/#if]

        [#if ((dtPinCtrlDataModel.get(ip).entrySet()?size>0) && nodesToGenerate?seq_contains(ip))] [#--only some IPs are listed because some does not have a Map structure so no {key, value}--]
            [#if bankZ]
				[#if sleep]
					${T1}${ipLower}_sleep_pins_z_mx: ${ipLower}_sleep_mx-0 {  [#--CMX generates only 1 config--]
				[#else]
					${T1}${ipLower}_pins_z_mx: ${ipLower}_mx-0 {  [#--CMX generates only 1 config--]
				[/#if]
            [#else]
				[#if sleep]
					${T1}${ipLower}_sleep_pins_mx: ${ipLower}_sleep_mx-0 {  [#--CMX generates only 1 config--]
				[#else]
					${T1}${ipLower}_pins_mx: ${ipLower}_mx-0 {  [#--CMX generates only 1 config--]
				[/#if]
            [/#if]
            [#if ipBootTag]
                ${T2}u-boot,dm-pre-reloc;
            [/#if]

                [#assign gpioParam = {}]
                
                [#-- ############################## DataModel Processing ############################## --]
                [#-- # for each signal, the gpio config is encoded in gpioConfig in order to gather   # --]
                [#-- # pinmux with same gpio config for printing                                      # --]
                [#list dtPinCtrlDataModel.get(ip).entrySet() as gpioparamEntry]  [#--For all signals of the IP--]
                    [#assign gpioConfig = ""]

                    [#-- Retrieve key pin & pin mux config--]
                    [#assign dtKey = gpioparamEntry.key] [#-- ex: <STM32_PINMUX('A',6,ANALOG)>&/* ADC1_IN3 */ --]

                    [#if !sleep || wakeupIP]
                        [#-- Save gpio configuration >> concatenated in gpioConfig --]

                        [#--biasprop--]
                        [#if gpioparamEntry.value.containsKey("GPIO_PuPd")] 
                            [#list GPIOPuPd?keys as key]
                                [#if key == gpioparamEntry.value.get("GPIO_PuPd")]
                                    [#if gpioConfig == ""]
                                        [#assign gpioConfig = GPIOPuPd[key]]
                                    [#else]
                                        [#assign gpioConfig = gpioConfig+"&"+GPIOPuPd[key]]
                                    [/#if]
                                    [#break]
                                [/#if]
                            [/#list]
                        [/#if]

                        [#--biasprop--]
                        [#if gpioparamEntry.value.containsKey("GPIO_PuPdOD")]
                            [#list GPIOPuPd?keys as key]
                                [#if key == gpioparamEntry.value.get("GPIO_PuPdOD")]
                                    [#if gpioConfig == ""]
                                        [#assign gpioConfig = GPIOPuPd[key]]
                                    [#else]
                                        [#assign gpioConfig = gpioConfig+"&"+GPIOPuPd[key]]
                                    [/#if]
                                    [#break]
                                [/#if]
                            [/#list]
                        [/#if]

                        [#--biasprop--]
                        [#if gpioparamEntry.value.containsKey("GPIO_Pu")]
                            [#list GPIOPuPd?keys as key]
                                [#if key == gpioparamEntry.value.get("GPIO_Pu")]
                                    [#if gpioConfig == ""]
                                        [#assign gpioConfig = GPIOPuPd[key]]
                                    [#else]
                                        [#assign gpioConfig = gpioConfig+"&"+GPIOPuPd[key]]
                                    [/#if]
                                    [#break]
                                [/#if]
                            [/#list]
                        [/#if]

                        [#--driverprop--]
                        [#list gpioparamEntry.value?keys as key1]
                            [#if key1?starts_with("GPIO_Mode")]
                                [#list GPIOMode?keys as key2]
                                    [#if key2 == gpioparamEntry.value.get(key1)]
                                        [#if gpioConfig == ""]
                                            [#assign gpioConfig = GPIOMode[key2]]
                                        [#else]
                                            [#assign gpioConfig = gpioConfig+"&"+GPIOMode[key2]]
                                        [/#if]
                                        [#break]
                                    [/#if]
                                [/#list]
                                [#break]
                            [/#if]
                        [/#list]

                        [#--slew-rateprop--]
                        [#list gpioparamEntry.value?keys as key1]
                            [#if key1?starts_with("GPIO_Speed")]
                                [#list GPIOSpeed?keys as key2]
                                    [#if key2 == gpioparamEntry.value.get(key1)]
                                        [#if gpioConfig == ""]
                                            [#assign gpioConfig = GPIOSpeed[key2]]
                                        [#else]
                                            [#assign gpioConfig = gpioConfig+"&"+GPIOSpeed[key2]]
                                        [/#if]
                                        [#break]
                                    [/#if]
                                [/#list]
                                [#break]
                            [/#if]
                        [/#list]
                    [/#if] [#-- !sleep || wakeupIP --]

                    [#assign gpioParam = gpioParam+{dtKey:gpioConfig}] [#--gpioParam will contain the list of all "pinmux:gpioConfig" of the ip ex: <STM32_PINMUX('A',6,ANALOG)>:[gpioConfig]--]
                [/#list]

                [#-- check and save if pinmuxs with different config or no (multiConfig flag) --]
                [#assign firstLoop = true]
                [#assign multiConfig = false]
                [#assign monoConfig = ""]
                [#list gpioParam?values as config]
                    [#if firstLoop]
                        [#assign monoConfig = config]
                        [#assign firstLoop = false]
                    [#elseif monoConfig != config]
                        [#assign multiConfig = true]
                        [#break]
                    [/#if]
                 [/#list]

                [#-- ################################ pinCtrl Printing ############################# --]
                [#-- # pinmux are printed gathering the same gpio config                           # --]
                [#if multiConfig] [#-- if pinmuxs with different gpio configs --]
                    [#assign index = 1]
                    [#assign signalDone = []]
                    [#list gpioParam?keys as pinMux] [#--for all pinMux (ex: <STM32_PINMUX('A',6,ANALOG)>)--]
                            [#if noContainsStr(signalDone, pinMux)] [#--signalDone records pinMux already traited for the ip--]
                                [#assign config = gpioParam[pinMux]]
                                
                                [#assign signalsSameConfig = []]
                                [#assign signalsSameConfigSortedTemp = []]
                                [#assign signalsSameConfigSorted = []]
                                [#assign ls1 = []]
                                [#assign ls2 = []]

                                ${T2}pins${index} {
                                    [#if ipBootTag]
                                        ${T3}u-boot,dm-pre-reloc;
                                    [/#if]
                                    [#-- ########### find pinMuxs with same config ########## --]
                                    [#assign index = index+1]
                                    
                                    [#assign signalDone = signalDone + [pinMux]]
                                    [#assign signalsSameConfig = signalsSameConfig + [pinMux]]


                                    
                                    [#list gpioParam?keys as pinMux2] [#-- find pinMuxs with same config --]
                                        [#if noContainsStr(signalDone, pinMux2) && (gpioParam[pinMux2] == config)]
                                            [#assign signalDone = signalDone + [pinMux2]] [#-- save pinMux already traited --]
                                            [#assign signalsSameConfig = signalsSameConfig + [pinMux2]] [#-- save pinMux with same config --]
                                        [/#if]
                                    [/#list]

                                    [#-- ########### print pinMux with same config (saved in signalsSameConfig) ########### --]
                                    [#assign savedPinMux = ""]
									[#assign savedEntry = ""]

                                    [#--sort pinMuxs for printing (port letter + number)--]
                                    [#list signalsSameConfig as entry]
										[#if sleep && !wakeupIP]
											[#assign savedEntry = entry?split(",")[0]+","+entry?split(",")[1]+", ANALOG)>&"+entry?split("&")[1]]
										[#else]
											[#assign savedEntry = entry]
										[/#if]
                                        [#assign ls1 = ls1 + [{"port":entry?split(",")[0], "nb":entry?split(",")[1]?trim?number, "pinMux":savedEntry}]]
                                    [/#list]
                                    [#list ls1?sort_by(["nb"]) as entry]
                                        [#assign ls2 = ls2 + [entry]]
                                    [/#list]
                                    [#list ls2?sort_by(["port"]) as entry]
                                        [#assign signalsSameConfigSortedTemp = signalsSameConfigSortedTemp + [entry.pinMux]]
                                    [/#list]
                                    [#list signalsSameConfigSortedTemp as entry] [#--remove duplicates--]
										[#if entry?split("/")[0] != savedPinMux?split("/")[0]]
											[#assign signalsSameConfigSorted = signalsSameConfigSorted + [entry]]
                                        [/#if]
                                        [#assign savedPinMux = entry]
                                    [/#list]


									
                                    [#-- print pinMux with same config --]
                                    [#assign sizeSame = signalsSameConfigSorted?size]
                                    [#list signalsSameConfigSorted as pinMux]
                                        [#if signalsSameConfigSorted?seq_index_of(pinMux) == 0]
                                            [#if sizeSame == 1]
                                                ${T3}pinmux = ${pinMux?split("&")[0]}; ${pinMux?split("&")[1]}
                                            [#else]
                                                ${T3}pinmux = ${pinMux?split("&")[0]}, ${pinMux?split("&")[1]}
                                            [/#if]
                                        [#else]
                                            [#if signalsSameConfigSorted?seq_index_of(pinMux) == (sizeSame-1)]
                                                ${T5} ${pinMux?split("&")[0]}; ${pinMux?split("&")[1]}
                                            [#else]
                                                ${T5} ${pinMux?split("&")[0]}, ${pinMux?split("&")[1]}
                                            [/#if]
                                        [/#if]
                                    [/#list]
                                    
                                    [#--gpios configuration--]
                                    [#if config != ""]
                                        [#list config?split("&") as conf]
                                            ${T3}${conf};
                                        [/#list]
                                    [/#if]
                                ${T2}};
                            [/#if]
                    [/#list]
                [#else] [#-- if all IP pinmuxs with same gpio config --]

                    [#assign signals = []]
                    [#assign signalsSortedTemp = []]
                    [#assign signalsSorted = []]
                    [#assign ls1 = []]
                    [#assign ls2 = []]

                    [#list gpioParam?keys as pinMux] [#--for all pinMux (ex: <STM32_PINMUX('A',6,ANALOG)>)--]
                        [#assign signals = signals + [pinMux]]
                    [/#list]

                    [#-- ########### print pinMuxs ########### --]
					[#assign savedPinMux = ""]
					[#assign savedEntry = ""]

                    [#--sort pinMuxs for printing (port letter + number)--]
                    [#list signals as entry]
						[#if sleep && !wakeupIP]
							[#assign savedEntry = entry?split(",")[0]+","+entry?split(",")[1]+", ANALOG)>&"+entry?split("&")[1]]
						[#else]
							[#assign savedEntry = entry]
						[/#if]
                        [#assign ls1 = ls1 + [{"port":entry?split(",")[0], "nb":entry?split(",")[1]?trim?number, "pinMux":savedEntry}]]
                    [/#list]
                    [#list ls1?sort_by(["nb"]) as entry]
                        [#assign ls2 = ls2 + [entry]]
                    [/#list]
                    [#list ls2?sort_by(["port"]) as entry]
                        [#assign signalsSortedTemp = signalsSortedTemp + [entry.pinMux]]
                    [/#list]
					[#list signalsSortedTemp as entry] [#--remove duplicates--]
						[#if entry?split("/")[0] != savedPinMux?split("/")[0]]
							[#assign signalsSorted = signalsSorted + [entry]]
						[/#if]
						[#assign savedPinMux = entry]
					[/#list]

                    [#-- print pinMux --]
                    [#assign size = signalsSorted?size]
                    ${T2}pins {
                        [#if ipBootTag]
                            ${T3}u-boot,dm-pre-reloc;
                        [/#if]
                        [#list signalsSorted as pinMux]
                            [#if signalsSorted?seq_index_of(pinMux) == 0]
                                [#if size == 1]
                                    ${T3}pinmux = ${pinMux?split("&")[0]}; ${pinMux?split("&")[1]}
                                [#else]
                                    ${T3}pinmux = ${pinMux?split("&")[0]}, ${pinMux?split("&")[1]}
                                [/#if]
                            [#else]
                                [#if signalsSorted?seq_index_of(pinMux) == (size-1)]
                                    ${T5} ${pinMux?split("&")[0]}; ${pinMux?split("&")[1]}
                                [#else]
                                    ${T5} ${pinMux?split("&")[0]}, ${pinMux?split("&")[1]}
                                [/#if]
                            [/#if]
                        [/#list]
                    
                        [#--gpios configuration--]
                        [#if monoConfig != ""]
                            [#list monoConfig?split("&") as conf]
                                ${T3}${conf};
                            [/#list]
                        [/#if]
                    ${T2}};
                [/#if] [#-- multiConfig --]
            ${T1}};
        [/#if] [#--  --]
    [/#list] [#-- eof list usedIPs --]
[/#macro]
[#-- End macro pinctrlPrint --]
