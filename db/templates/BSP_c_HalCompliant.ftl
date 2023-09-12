[#ftl]

[#assign coreDir=""]

[#assign coreDir=sourceDir]
[#if cpucore!="" && (contextFolder=="" || contextFolder=="/")]
[#assign contextFolder = cpucore?replace("ARM_CORTEX_","C")+"/"]
[/#if]

[#compress]
[#list datas as data]
    [#if data.ipName=="gpio"]

[#if RESMGR_UTILITY??]
    [@common.optinclude name=contextFolder+mxTmpFolder+"/resmgrutility_"+data.ipName+".tmp"/][#-- ADD RESMGR_UTILITY Code--]
[/#if]

        [#assign v = ""]
[#if data.ipName=="gpio"][#-- Actually we don't need to generate code for gpio modes not associated to any peripheral --]
        [#list data.variables as variable]				
            [#if v?contains(variable.name)]
            [#-- no matches--]
            [#else]
#t${variable.value} ${variable.name} = {0};
        	[#assign v = v + " "+ variable.name/]	
            [/#if]	
        [/#list]
[/#if]
[#if isHalSupported=="true"]
    [#if clock?size >0 ]#n#t/* GPIO Ports Clock Enable */[/#if]
        [#list clock as clockMacro]
            [#if clockMacro!=""] 
                [#if clockMacro?contains("(")]
                    #t${clockMacro};
                [#else]
                    #t${clockMacro}();
                [/#if]
            [/#if]
        [/#list] 
    [/#if]

[#else] [#-- peripheral gpio init function --]
#n
        [#assign v = ""]
        [#list data.variables as variable] [#-- variables declaration --]
            [#if v?contains(variable.name)]
            [#-- no matches--]
            [#else]
#t${variable.value} ${variable.name} = {0};
                [#assign v = v + " "+ variable.name/]	
            [/#if]	
        [/#list]
[/#if]

[#if data.methods??] [#-- if the pin configuration contains a list of LibMethods--]
[#if data.ipName=="gpio"][#-- Actually we don't need to generate code for gpio modes not associated to any peripheral --]

	[#list data.methods as method][#assign args = ""]	
		[#if method.status=="OK"]	
                [#-- --]                
                [#if method.name == "HAL_GPIO_Init"]
                    [#assign pin = ""]
                    [#assign port = ""]
                    [#list method.arguments as fargument]
                    [#if fargument.name =="GPIOx"]							
                       [#assign port = port + " " + fargument.value]
                        [#assign i =port?length-1]
                        [#assign j =port?length]
                       [#assign port = "P"+port?substring(i,j)]
                    [/#if]
                    [#if fargument.genericType == "struct"]											
                        [#list fargument.argument as argument]	
                            [#if argument.name =="Pin"]							
                                [#assign pin = pin + " " + argument.value]
                            [/#if]                            
                        [/#list]
                    [/#if]
                    [/#list]
                    [#compress]
  [#--comment of GPIO configuration--]  #n#t/*Configure GPIO [#if pin?split("|")?size>1]pins[#else]pin[/#if] : [#list pin?split("|") as x][#if x?contains("GPIO_PIN")][#assign i =x?split("_")] [#assign j =i?last]${port}${j}[#else]${x} [/#if] [/#list] */[/#compress]
                [#else]
                [#if method.comment??]#n#t/*[#compress]${method.comment} */[/#compress][/#if]			
                [/#if]    

                [#-- --]
		[#if method.arguments??]
                    [#list method.arguments as fargument][#compress]
                    [#if fargument.addressOf] [#assign adr = "&"][#else ][#assign adr = ""][/#if][/#compress]
                    [#if fargument.genericType == "struct"][#assign arg = "" + adr + fargument.name]											
                        [#list fargument.argument as argument]	
                            [#if argument.mandatory]
                                [#if argument.value??]
                                [#if argument.status=="OK"]#t${fargument.name}.${argument.name} = ${argument.value};[/#if]
                                [#else]
                                [#if argument.status=="KO"]#t//${fargument.name}.${argument.name} = ;[/#if]
                                [/#if]
                            [/#if]
                        [/#list]
                    [#else]
                        [#assign arg = "" + adr + fargument.value]
                    [/#if]
                    [#if args == ""][#assign args = args + arg ][#else][#assign args = args + ', ' + arg][/#if]
                    [/#list]
#t${method.name}(${args});

		[#else]
                    #t${method.name}();
                [/#if]			
		[/#if]
		[#if method.status=="KO"]
		#n #t//!!! ${method.name} is commented because some parameters are missing
			[#if method.arguments??]			
				[#list method.arguments as fargument]
					[#if fargument.addressOf] [#assign adr = "&"][#else ] [#assign adr = ""][/#if]
					[#if fargument.genericType == "struct"][#assign arg = "" + adr + fargument.name]
                                            [#list fargument.argument as argument]	
                                                [#if argument.mandatory]	
                                                    [#if argument.value??]
                                                       #t//${fargument.name}.${argument.name} = ${argument.value};
                                                    [#else]
                                                        [#if argument.status!="WARNING"]#t//${fargument.name}.${argument.name} = ;[/#if]
                                                    [/#if]                                                   
                                                [/#if]
                                            [/#list]
                                        [#else]
                                            [#assign arg = "" + adr + fargument.value]
                                        [/#if]
					[#if args == ""][#assign args = args + arg ]
					[#else][#assign args = args + ', ' + arg]
                                        [/#if]
                                [/#list]
                                #t//${method.name}(${args});
                        [#else]
                                #t${method.name}();
                        [/#if]

                [/#if]

        [/#list]

[#if InitNvic??&&InitNvic?size>0]
[#compress]
[#assign irqNum = 0]
[#list InitNvic as initVector]
        [#if initVector.codeInMspInit]
                [#assign irqNum = irqNum+1]
                [#if irqNum==1]#n#t/* EXTI interrupt init*/[/#if]
[#if usedDriver == "HAL"]
                #tHAL_NVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority}, ${initVector.subPriority});
                #tHAL_NVIC_EnableIRQ(${initVector.vector});#n
[#else]
    [#if NVICPriorityGroup??]
                #tNVIC_SetPriority(${initVector.vector}, NVIC_EncodePriority(NVIC_GetPriorityGrouping(),${initVector.preemptionPriority}, ${initVector.subPriority}));
    [#else]
                #tNVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority});
    [/#if]
                #tNVIC_EnableIRQ(${initVector.vector});
[/#if]
        [/#if]
[/#list]
[/#compress]
[/#if]
#n
[/#if]


#n

[/#if] [#-- else there is no LibMethod to call--]

[/#list]
[#if IoList??]
    [#list IoList as io]
[@common.optinclude name=contextFolder+mxTmpFolder+"/"+io?lower_case+".tmp"/][#--include io configuration --]
#n
    [/#list]
[/#if]
[/#compress]