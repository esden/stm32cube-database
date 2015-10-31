[#ftl]

[#compress]
[#list datas as data]
    [#if data.ipName=="gpio"]
[#if data.comments??]
#n/** ${data.comments}
*/
[/#if]
void MX_GPIO_Init(void) 
{
#n
        [#assign v = ""]
        [#list data.variables as variable]				
            [#if v?contains(variable.name)]
            [#-- no matches--]
            [#else]
#t${variable.value} ${variable.name};
        	[#assign v = v + " "+ variable.name/]	
            [/#if]	
        [/#list]
[#if isHalSupported=="true"]
    [#if clock?size >0 ]#n#t/* GPIO Ports Clock Enable */[/#if]
            [#list clock as clockMacro]
    [#if clockMacro!=""] #t${clockMacro}(); [/#if]
            [/#list] 
    [/#if]

[#else] [#-- peripheral gpio init function --]
[#if data.comments??]
#n/** ${data.comments}
*/
[/#if]
void MX_${data.ipName}_GPIO_Init(void) 
{
#n
        [#assign v = ""]
        [#list data.variables as variable] [#-- variables declaration --]
            [#if v?contains(variable.name)]
            [#-- no matches--]
            [#else]
#t${variable.value} ${variable.name};
                [#assign v = v + " "+ variable.name/]	
            [/#if]	
        [/#list]
    [/#if]


[#if data.methods??] [#-- if the pin configuration contains a list of LibMethods--]
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
                    #n#t/*Configure GPIO [#if pin?split("|")?size>1]pins[#else]pin[/#if] : [#list pin?split("|") as x][#assign i =x?split("_")] [#assign j =i?last]${port}${j} [/#list] */[/#compress]
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

[#if InitNvic??&&InitNvic?size>0][#compress]
#n#t/* EXTI interrupt init*/
[#list InitNvic as initVector]
                #tHAL_NVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority}, ${initVector.subPriority});
                #tHAL_NVIC_EnableIRQ(${initVector.vector});#n
            [/#list]
[/#compress]
[/#if]
#n
}

#n
[/#if] [#-- else there is no LibMethod to call--]


[/#list]

[/#compress]