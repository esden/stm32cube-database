[#ftl]
[#list IPdatas as IP]  
[#assign ipvar = IP]
[#assign useGpio = false]
[#assign useDma = false]
[#assign useNvic = false]
[#-- extract hal mode list used by all instances of the ip --]
[#assign halModeList= ""]
[#list ipvar.instances.entrySet() as entry]
        [#if halModeList?contains(entry.value)]
        [#else]
            [#assign halModeList = halModeList + " " +entry.value]
        [/#if]
[/#list]
[#-- End extract hal mode list used by all instances of the ip --]

[#-- Define includes --]
[#list IP.configModelList as instanceData]
[#if instanceData.initServices??]
    [#if instanceData.initServices.gpio??]
        [#assign useGpio = true]
    [/#if]
    [#if instanceData.initServices.dma??]
        [#assign useDma = true]
    [/#if]
    [#if instanceData.initServices.nvic??]
        [#assign useNvic = true]
    [/#if]
  [/#if]
[/#list]

[#if useGpio]
[/#if]
[#if useDma]
[#-- include "dma.h" --]
[/#if]
[#-- End Define includes --]

[#-- Function getInitServiceMode --]
[#function getInitServiceMode(ipname1)]
    [#-- assign initServicesList = {"test0":"test1"}--]
    [#assign initServicesList = ""]
    [#list ipvar.configModelList as instanceData]
        [#if instanceData.instanceName==ipname1]
            [#assign initServicesList = {"test0":"test1"}]
            [#if instanceData.initServices??]
                [#return instanceData.initServices]
            [/#if]
        [/#if]
    [/#list]
   [#return initServicesList]
[/#function]
[#-- End Function getInitServiceMode --]

[#-- Function getDeInitServiceMode --]
[#function getDeInitServiceMode(ipname2)]
    [#-- assign initServicesList = {"test0":"test1"}--]
    [#assign deInitServicesList = ""]
    [#list ipvar.configModelList as instanceData]
        [#if instanceData.instanceName==ipname2]
            [#assign deInitServicesList = {"test0":"test1"}]
            [#if instanceData.deInitServices??]
                [#return instanceData.deInitServices]
            [/#if]
        [/#if]
    [/#list]
   [#return deInitServicesList]
[/#function]
[#-- End Function getDeInitServiceMode --]

[#-- macro getLocalVariable of a config Start--]
[#macro getLocalVariable configModel1 listOfLocalVariables resultList]
    [#if configModel1.methods??] 
        [#assign methodList1 = configModel1.methods]
    [#else] [#assign methodList1 = configModel1.libMethod]
    [/#if]
 [#assign myListOfLocalVariables = listOfLocalVariables]
    [#list methodList1 as method][#-- list methodList1 --]
[#if method.arguments??]
        [#list method.arguments as argument][#-- list method.arguments --]
            [#if argument.genericType == "struct"][#-- if struct --]
                [#if argument.context??][#-- if argument.context?? --]
                    [#if argument.context!="global"&&argument.status!="WARNING"&&argument.status!="NULL"&&argument.returnValue=="true"] [#-- if !global --]
                    [#assign varName= " "+argument.name]                    
                    [#assign ll= myListOfLocalVariables?split(" ")]
                    [#assign exist=false]
                    [#list ll as var  ]
                        [#if var==argument.name]
                            [#assign exist=true]
                        [/#if]
                    [/#list]
                    [#if !exist]  [#-- if exist --]                  
                    #t${argument.typeName} ${argument.name} = {0};                        
                      [#assign myListOfLocalVariables = myListOfLocalVariables + " "+ argument.name]
                      [#assign resultList = myListOfLocalVariables]
                    [/#if][#-- if exist --]
                    [/#if][#-- if global --]
                [#else][#-- if context?? --]
                #t${argument.typeName} ${argument.name} = {0};
            [/#if][#-- if argument.context?? --]

            [#-- Array type --]
            [#list argument.argument as subArg] [#-- list subArg --]
                [#if subArg.genericType=="Array"] [#-- if genericType == "Array" --]
                    ${subArg.typeName} ${subArg.name}[${subArg.arraySize}] ; 
                [/#if] [#-- if genericType == "Array" --]
                [#if subArg.genericType =="struct"]
                    [#list subArg.argument as subArg1] [#-- list subArg1 --]
                        [#if subArg1.genericType=="Array"] [#-- if genericType == "Array" --]
                           #t ${subArg1.typeName} ${subArg1.name}[${subArg1.arraySize}] ; 
                        [/#if] [#-- if genericType == "Array" --]
                    [/#list]
                [/#if]
            [/#list] [#-- list subArg --]
            [/#if][#-- if struct --]
        [/#list][#-- list method.arguments --]
[/#if]
    [/#list][#-- list methodList1 --]
[/#macro]
[#-- macro getLocalVariable of a config End--]


[#-- macro generateConfigModelCode --]

[#macro generateConfigModelCode configModel inst nTab index]
[#if configModel.methods??] [#-- if the pin configuration contains a list of LibMethods--]
    [#assign methodList = configModel.methods]
[#else] [#assign methodList = configModel.libMethod]
[/#if]
[#assign writeConfigComments=false]
[#list methodList as method]
    [#if method.status=="OK"][#assign writeConfigComments=true][/#if]
[/#list]
[#if writeConfigComments]
[#-- [#if configModel.comments??] #t/**${configModel.comments} #n#t*/[/#if] --]
[/#if]
	[#list methodList as method][#assign args = ""]	  
[#assign handler = ""]
            [#if method.hardCode??] [#-- Hard code --]              
                ${method.hardCode.text?replace("$IpInstance",inst)} 
            [#else]
                [#if method.type == "Template"] [#-- Template code --]  
                    [#list method.name?split("/") as n]
                        [#assign tplName = n]
                    [/#list]
                    [@optinclude name=mxTmpFolder+"/${tplName?replace('ftl','tmp')}" /] 
                [/#if]
            [/#if]
            [#if method.status=="OK" && method.type != "Template" && method.type != "HardCode"]                           		
             	[#if method.arguments??]
                    [#list method.arguments as fargument][#compress]
[#if inst=="USB"]
[#assign handler = fargument.name]
[/#if]
                    [#if fargument.addressOf] [#assign adr = "&"][#else ][#assign adr = ""][/#if]
                    [#if fargument.cast??] [#assign adr = fargument.cast + adr][/#if][/#compress] 
                    [#if fargument.genericType == "struct"]
                        [#if fargument.context??]
                            [#if fargument.context=="global"]
                                [#if configModel.ipName=="DMA"]
                                    [#assign instanceIndex = "_"+ configModel.instanceName?lower_case]
                                [#else]
                                   [#-- [#assign instanceIndex = inst?replace(name,"")]--]
                                   [#if index??][#assign instanceIndex = index][#else][#assign instanceIndex = inst?replace(name,"")][/#if]
                                [/#if]
                            [/#if]
                        [/#if]                     
                        [#if instanceIndex??&&fargument.context=="global"][#if fargument.status!="NULL"][#assign arg = "" + adr + fargument.name + instanceIndex][#else][#assign arg = "NULL"][/#if][#else][#if  fargument.status!="NULL"][#assign arg = "" + adr + fargument.name][#else][#assign arg = "NULL"][/#if][/#if]
                        [#-- [#assign arg = "" + adr + fargument.name] --]
                        [#if (!method.name?contains("Init")&&fargument.context=="global")]
                        [#else]
                        [#list fargument.argument as argument]	
                            [#if argument.genericType != "struct"]
                                [#if argument.mandatory]
                                [#if argument.value??]
                                    [#if instanceIndex??&&fargument.context=="global"]
                                        [#assign argValue=argument.value?replace("$Index",instanceIndex)]
                                    [#else]
                                        [#assign argValue=argument.value]
                                    [/#if][#-- if global --]
                                    [#if argument.genericType=="Array"][#-- if genericType=Array --]
                                    [#assign valList = argument1.value?split(argument1.arraySeparator)]     
                                            [#assign i = 0]                                  
                                        [#list valList as val] 
                                            [#if argument1.typeName == "10"]
                                                #t${argument1.name}[${i}] = ${val};
                                            [#else]
                                                #t${argument1.name}[${i}] = 0x${val};
                                            [/#if]                                            [#assign i = i+1]
                                        [/#list]
                                        [#assign argValue="&"+argument1.name]
                                    [/#if] [#-- if genericType=Array --]
                                    [#if argument.value!="" && argument.value!="N/A"]
                                    [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${argValue};
                                    [#else]
                                    [#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = [#if argument.value!="N/A"]${argValue}[/#if];
                                    [/#if]                                                                     
                                    [/#if]
                                    [#else] [#-- else argument.mandatory--]
                                      [#if fargument.name!="GPIO_InitStruct" && fargument.name!="GPIO_Init"]
                                            [#if argument.name=="Instance"][#-- if argument=Instance--]
                                              [#-- calculate the value of Instance argument if contains $Index --]
                                                [#if  (argument.value??) && (argument.value?contains("$Index"))]
                                                    [#assign instanceValue=argument.value?replace("$Index",index)]
                                                [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${instanceValue};
                                                [#else]
                                                   [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = [#if argument.value??]${argument.value};[#else]${inst}[/#if]
                                                [/#if]
                                          [#else]
                                              [#if argument.status=="KO"]
                                                   [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]//${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${argument.value};                                        
                                              [/#if]
                                              [#if argument.value??]
                                                   [#if argument.value!="N/A"][#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${argument.value};  [/#if]
                                              [/#if]                                    
                                          [/#if][#-- if argument=Instance--]                                
                                      [/#if]    
                                [/#if][#-- if argument.mandatory--]
                                
                            [#else]
                            [#list argument.argument as argument2]
[#if argument2.genericType!="struct"]
                                [#if argument2.value??][#assign argValue=argument2.value][#else] [#assign argValue=""][/#if]
                                [#if argument2.mandatory]
                                    [#if argument2.value??]
                                    [#if instanceIndex??&&fargument.context=="global"][#assign argValue=argument2.value?replace("$Index",instanceIndex)][#else][#assign argValue=argument2.value][/#if]
                                    [#if argument2.genericType=="Array"][#-- if genericType=Array --] 
                                        [#assign valList = argument2.value?split(":")]     
                                            [#assign i = 0]                                  
                                        [#list valList as val] 
                                            [#if argument2.typeName == "10"]
                                                #t${argument2.name}[${i}] = ${val};
                                            [#else]
                                                #t${argument2.name}[${i}] = 0x${val};
                                            [/#if]                                            [#assign i = i+1]
                                        [/#list]
                                        [#assign argValue="&"+argument2.name+"[0]"]
                                    [/#if] [#-- if genericType=Array --]
                                    [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name} = ${argValue};                                    
                                    [/#if]
                               [#else] [#-- !argument.mandatory --]
                                    [#if argument2.status=="KO"]
                                        [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]//${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name} = ${argValue};
                                    [/#if]
                                    [#if argument2.status=="OK"]
                                    [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name} = ${argValue};
                                    [/#if]
                                [/#if][#-- if argument.mandatory --]
[#else]
[#list argument2.argument as argument3]
 [#if argument3.value??][#assign argValue=argument3.value][#else] [#assign argValue=""][/#if]
                                [#if argument3.mandatory]
                                    [#if argument3.value??]
                                    [#if instanceIndex??&&fargument.context=="global"][#assign argValue=argument3.value?replace("$Index",instanceIndex)][#else][#assign argValue=argument3.value][/#if]
                                    [#if argument3.genericType=="Array"][#-- if genericType=Array --] 
                                        [#assign valList = argument3.value?split(":")]     
                                            [#assign i = 0]                                  
                                        [#list valList as val] 
                                            [#if argument3.typeName == "10"]
                                                #t${argument3.name}[${i}] = ${val};
                                            [#else]
                                                #t${argument3.name}[${i}] = 0x${val};
                                            [/#if]                                            [#assign i = i+1]
                                        [/#list]
                                        [#assign argValue="&"+argument3.name+"[0]"]
                                    [/#if] [#-- if genericType=Array --]
                                    [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name}.${argument3.name} = ${argValue};                                    
                                    [/#if]
                               [#else] [#-- !argument.mandatory --]
                                    [#if argument3.status=="KO"]
                                        [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]//${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name}.${argument3.name} = ${argValue};
                                    [/#if]
                                    [#if argument3.status=="OK"]
                                    [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name}.${argument3.name} = ${argValue};
                                    [/#if]
                                [/#if][#-- if argument.mandatory --]
[/#list]
[/#if]
                            [/#list]
                            [/#if]
                        [/#list][#-- list  fargument.argument as argument--]
                        [/#if]
                    [#else][#-- if struct --]
                        [#assign arg = ""]
                        [#if inst?contains("ETH")]
                            #n
                            #t/* USER CODE BEGIN MACADDRESS */
                            #t#t
                            #t/* USER CODE END MACADDRESS */
                            #n
                        [/#if]
                        [#if fargument.status=="OK" && fargument.value??]
                            [#assign argIndex = inst?replace(name,"")]  
                                            [#if argIndex??]
                                                [#assign argValue=fargument.value?replace("$Index",argIndex)]
                                                [#if fargument.returnValue!="true"]
                                                	[#assign arg = "" + adr + argValue]
                                                [/#if]
                                            [#else]
                                                [#assign arg = "" + adr + fargument.value]                                                
                                            [/#if]
                        [/#if]
                    [/#if]
                    [#if args == "" && arg!=""][#assign args = args + arg ][#else][#if arg!=""][#assign args = args + ', ' + arg][/#if][/#if]
                    [/#list]
                    [#assign retval=""]
		    [#list method.arguments as argument]
			[#if argument.returnValue=="true"]
				[#assign retval=argument.name]
			[/#if]
		    [/#list]
                    [#-- add Register Callbacks for USB STM32WB Start --]
                    [#if (FamilyName=="STM32WB" | FamilyName=="STM32G4" ) && inst == "USB" && handler!=""]                    
                    [#if handler?contains("pcd")]
                    [#assign USBmodule = "PCD"]
                    [#else]
                    [#assign USBmodule = "HCD"]
                    [/#if]
                        #n#t#if (USE_HAL_${USBmodule}_REGISTER_CALLBACKS == 1U)
                        #t/* register Msp Callbacks (before the Init) */
                        #tHAL_${USBmodule}_RegisterCallback(&${handler}, HAL_${USBmodule}_MSPINIT_CB_ID, ${USBmodule}_MspInit);
                        #tHAL_${USBmodule}_RegisterCallback(&${handler}, HAL_${USBmodule}_MSPDEINIT_CB_ID, ${USBmodule}_MspDeInit);
                        #t#endif /* USE_HAL_${USBmodule}_REGISTER_CALLBACKS */#n
                    
                    [#-- add Register Callbacks for USB STM32WB End --]
                    [/#if]
		    [#if retval??&& retval!=""]
			[#if nTab==2]#t#t[#else]#t[/#if]${retval} = ${method.name}(${args});
		    [#else]
			[#--[#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});#n--]
                            [#if method.returnHAL=="false"]
                                [#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});
                            [#else]
                                [#-- [#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});#n --]
                                [#if nTab==2]#t#t[#else]#t[/#if]if (${method.name}(${args}) != [#if method.returnHAL == "true"]HAL_OK[#else]${method.returnHAL}[/#if])
                                [#if nTab==2]#t#t[#else]#t[/#if]{
                                [#if nTab==2]#t#t[#else]#t[/#if]#tError_Handler( );
                                [#if nTab==2]#t#t[#else]#t[/#if]}
                            [/#if]#n
		    [/#if]
		[#else]
                    [#--[#if nTab==2]#t#t[#else]#t[/#if]${method.name}();#n""--]
                            [#if method.returnHAL=="false"]
                                [#if nTab==2]#t#t[#else]#t[/#if]${method.name}();
                            [#else]
                                [#-- [#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});#n --]
                                [#if nTab==2]#t#t[#else]#t[/#if]if (${method.name}() != [#if method.returnHAL == "true"]HAL_OK[#else]${method.returnHAL}[/#if])
                                [#if nTab==2]#t#t[#else]#t[/#if]{
                                [#if nTab==2]#t#t[#else]#t[/#if]#tError_Handler( );
                                [#if nTab==2]#t#t[#else]#t[/#if]}
                            [/#if]#n
                [/#if]			
		[/#if]
		[#if method.status=="KO"]
		#n [#if nTab==2]#t#t[#else]#t[/#if]//!!! ${method.name} is commented because some parameters are missing
			[#if method.arguments??]			
				[#list method.arguments as fargument]
					[#if fargument.addressOf] [#assign adr = "&"][#else ] [#assign adr = ""][/#if]
                                        [#if fargument.cast??] [#assign adr = fargument.cast + adr][/#if]
					[#if fargument.genericType == "struct"][#assign arg = "" + adr + fargument.name]
                                        [#if fargument.context??]                   
                                            [#if fargument.context=="global"]
                                                [#if configModel.ipName=="DMA"]
                                                [#assign instanceIndex = "_"+ configModel.instanceName?lower_case]
                                                [#else]
                                                [#assign instanceIndex = inst?replace(name,"")]
                                                [/#if]
                                            [/#if]
                                        [/#if]              
                        [#if instanceIndex??&&fargument.context=="global"][#assign arg = "" + adr + fargument.name + instanceIndex][#else][#assign arg = "" + adr + fargument.name][/#if]
                        [#if (!method.name?contains("Init")&&fargument.context=="global")]
                        [#else]
                        [#list fargument.argument as argument]	
                                [#if argument.genericType != "struct"]
                                [#if argument.mandatory && argument.value??]
                                    [#if instanceIndex??&&fargument.context=="global"][#assign argValue=argument.value?replace("$Index",instanceIndex)][#else][#assign argValue=argument.value][/#if]
                                    [#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${argValue};
                                 [#else]
                                    [#if argument.name=="Instance"]
                                        [#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${inst};
                                    [/#if]                                
                                [/#if]
                            [#else]
                            [#list argument.argument as argument1]
                                [#if argument1.mandatory && argument1.value??]
                                    [#if instanceIndex??&&fargument.context=="global"][#assign argValue=argument1.value?replace("$Index",instanceIndex)][#else][#assign argValue=argument1.value][/#if]
                                [#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument1.name} = ${argValue};
                                [/#if]
                            [/#list]
                            [/#if]
                            [/#list]
[/#if]
                                        [#else] [#-- if argument != struct --]
                                            [#assign argIndex = inst?replace(name,"")] 
                                            [#if argIndex??]
                                                [#assign argValue=fargument.value?replace("$Index",argIndex)]
                                                [#assign arg = "" + adr + argValue]
                                            [#else]
                                                [#assign arg = "" + adr + fargument.value]                                                
                                            [/#if]
                                        [/#if]
					[#if args == ""][#assign args = args + arg ]
					[#else][#assign args = args + ', ' + arg]
                                        [/#if]
                                [/#list]
                                [#if nTab==2]#t#t[#else]#t[/#if]#t//${method.name}(${args});
                        [#else] [#-- if method without argument --]
                               [#--[#if nTab==2]#t#t[#else]#t[/#if]${method.name}()#n;--]
                            [#if method.returnHAL=="false"]
                                [#if nTab==2]#t#t[#else]#t[/#if]${method.name}();
                            [#else]
                                [#-- [#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});#n --]
                                [#if nTab==2]#t#t[#else]#t[/#if]if (${method.name}() != [#if method.returnHAL == "true"]HAL_OK[#else]${method.returnHAL}[/#if])
                                [#if nTab==2]#t#t[#else]#t[/#if]{
                                [#if nTab==2]#t#t[#else]#t[/#if]#tError_Handler( );
                                [#if nTab==2]#t#t[#else]#t[/#if]}
                            [/#if]#n                                
                        [/#if]
                [/#if]
        [/#list]

[#-- assign instanceIndex = "" --]
 [#-- else there is no LibMethod to call--]
[/#macro]
[#-- End macro generateConfigModelCode --]

[#-- macro generateConfigCode --]
[#macro generateConfigCode ipName type serviceName instHandler tabN]
[#if type=="Init"]
 [#assign service = getInitServiceMode(ipName)]
[#else]
 [#assign service = getDeInitServiceMode(ipName)]
[/#if]
[#if serviceName=="gpio"]
    [#if service.gpio??][#assign gpioService = service.gpio][#else][#assign gpioService = ""][/#if]
[/#if]
[#if serviceName=="dma" && service.dma??]
[#assign dmaService = service.dma]
[/#if]
   
[#if serviceName=="gpio"]
 [#assign instanceIndex =""]
    [@generateConfigModelCode configModel=gpioService inst=ipName nTab=tabN index=""/]
[/#if]
[#if serviceName=="dma" && dmaService??]
 [#assign instanceIndex =""]
    [#list dmaService as dmaconfig] 
     [@generateConfigModelCode configModel=dmaconfig inst=ipName  nTab=tabN index=""/]
        [#assign dmaCurrentRequest = dmaconfig.instanceName?lower_case]
        [#assign prefixList = dmaCurrentRequest?split("_")]
        [#list prefixList as p][#assign prefix= p][/#list]
        
#t__HAL_LINKDMA(${instHandler},[#if dmaconfig.dmaHandel??]${dmaconfig.dmaHandel}[#else]hdma${prefix}[/#if],hdma_${dmaconfig.instanceName?lower_case});#n
    [/#list] [#-- list dmaService as dmaconfig --]
[/#if]

[/#macro]
[#-- End macro generateConfigCode --]

[#-- function: getHalMode(ipInstanceName) --]
[#function getHalMode ipname]
    [#list ipvar.instances.entrySet() as entry]
        [#if entry.key==ipname]
            ${entry.value}
        [/#if]
    [#return entry.value]
    [/#list]
[/#function]
[#-- End function: getHalMode(ipInstanceName) --]

[#-- function: getDmaHandler(currentipname) --]
[#function getDmaHandler currentipname]
    [#assign result=""]
    [#list ipvar.configModelList as instanceData]
        [#if instanceData.instanceName==currentipname]
            [#if instanceData.dmaHandel??] [#assign result=instanceData.dmaHandel][/#if]
        [/#if]
    [/#list] 
    [#return result]   
[/#function]
[#-- End function: getDmaHandler(currentipname) --]

[#-- macro generate service code for MspInit/MspDeInit Start--]
[#macro generateServiceCode ipName serviceType modeName instHandler tabN]
    [#if serviceType=="Init"]
        [#assign initService = getInitServiceMode(ipName)]
    [#else]
        [#assign initService = getDeInitServiceMode(ipName)]
    [/#if]
        [#assign gpioExist = false]
        [#assign dmaExist = false]
        [#assign nvicExist = false]
        [#if initService?? && initService.entrySet??]
        [#list initService.entrySet() as entry]
            [#if entry.key=="dma"]
            [#assign dmaExist = true]
            [/#if]
            [#if entry.key=="nvic"]
            [#assign nvicExist = true]
            [/#if]
            [#if entry.key=="gpio"]
            [#assign gpioExist = true]
            [/#if]            
        [/#list]
        [/#if]    
    #t#t/* Peripheral clock enable */
    [#if serviceType=="Init"] 
           [#if initService.clock??]
            [#if initService.clock!="none"]
                #t#t/* Enable Peripheral clock */
            [#list initService.clock?split(';') as clock]            
               #t#t${clock?trim}();
            [/#list]
            [/#if]
            [#else]
                 #t#t/* Peripheral clock enable */
                 #t#t__HAL_RCC_${ipName}_CLK_ENABLE(); 
           [/#if]
    [#else]           
         [#if initService.clock??]
            [#if initService.clock!="none"]
               #t#t/* Disable Peripheral clock */
               [#list initService.clock?split(';') as clock]            
                  #t#t${clock?replace("ENABLE","DISABLE")?trim}(); 
               [/#list]
            [/#if]
         [#else]
            [#if ipName?contains("WWDG") && (DIE=="DIE415" || DIE=="DIE435")]
            [#-- Orca and LittleOrca window watchdog clock disable don't work --]
            [#else]
                 #t#t/* Peripheral clock disable */
                 #t#t__HAL_RCC_${ipName}_CLK_DISABLE();  
            [/#if]
         [/#if]   
    [/#if]
    [#if gpioExist]
#t[@generateConfigCode ipName=ipName type=serviceType serviceName="gpio" instHandler=instHandler tabN=tabN/]
[/#if]
    [#if serviceType=="Init"] 
    [#if dmaExist]#n#t#t/* Peripheral DMA init*/
#t[@generateConfigCode ipName=ipName type=serviceType serviceName="dma" instHandler=instHandler tabN=tabN/]

    [/#if]
    [#if nvicExist]
        [#if initService.nvic??&&initService.nvic?size>0]
            [#assign irqNum = 0]
            [#list initService.nvic as initVector]
                [#if initVector.codeInMspInit]
                  [#assign irqNum = irqNum+1]
                  [#if irqNum==1]#n#t#t/* Peripheral interrupt init*/[/#if]
                  #t#tHAL_NVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority}, ${initVector.subPriority});
                  #t#tHAL_NVIC_EnableIRQ(${initVector.vector});
                [/#if]
            [/#list]
        [/#if]
    [/#if]
    [#else] [#-- else serviceType = DeInit --]
    [#if dmaExist]#n#t#t/* Peripheral DMA DeInit*/    
 [#assign service = getInitServiceMode(ipName)]
 [#assign dmaservice =service.dma]
 [#if dmaservice??]
    [#list dmaservice as dmaconfig]
        [#assign dmaCurrentRequest = dmaconfig.instanceName?lower_case]
        [#assign prefixList = dmaCurrentRequest?split("_")]
        [#list prefixList as p][#assign prefix= p][/#list]
        [#assign ipdmahandler1 = "hdma" + prefix]
         [#-- [#if getDmaHandler(ipName)!=""][#assign ipdmahandler = getDmaHandler(ipName)][#else][#assign ipdmahandler = ipdmahandler1][/#if]--]
           [#if dmaconfig.dmaHandel??][#assign ipdmahandler = dmaconfig.dmaHandel][#else][#assign ipdmahandler = ipdmahandler1][/#if]
        #t#tHAL_DMA_DeInit(${instHandler}->${ipdmahandler});
    [/#list] [#-- list dmaService as dmaconfig --]
[/#if]    
    [/#if] [#-- if DMA exist --]
[#-- DeInit NVIC if DeInit --]
    [#if nvicExist&&service.nvic?size>0]#n#t#t/* Peripheral interrupt Deinit*/[#--#n#t#tHAL_NVIC_DisableIRQ([#if service.nvic.vector??]${service.nvic.vector}[/#if]);--]
            [#list service.nvic as initVector]
                #t#tHAL_NVIC_DisableIRQ(${initVector.vector});
            [/#list]
    [/#if]

    [/#if]
[/#macro]
[#-- End macro add service code --]


[#assign initServicesList = {"test0":"test1"}]
[#-- Section1: Create the void mx_<IpInstance>_<HalMode>_init() function for each ip instance --]
[#compress]
[#list IP.configModelList as instanceData]
[#if (instanceData.isMWUsed=="true" ||instanceData.isBSPUsed=="true" )&& instanceData.instanceName==name]
     [#assign instName = instanceData.instanceName] 
        [#assign halMode= instanceData.halMode]
[#if instanceData.isBSPUsed=="true" ][#-- added for periph used by BSP --]
[#-- added for periph used by BSP --]
/* ${instName} init function */ [#-- added for periph used by BSP --]
        [#if halMode!=instanceData.realIpName&&!instanceData.ipName?contains("TIM")&&!instanceData.ipName?contains("CEC")]#HAL_StatusTypeDef MX_${instName}_${halMode}_Init(${instanceData.instancehandler})[#else]HAL_StatusTypeDef MX_${instName}_Init(${instanceData.instancehandler})[/#if][#-- added for periph used by BSP --]
{[#-- added for periph used by BSP --]
#tHAL_StatusTypeDef ret = HAL_OK;
[/#if]
        [#assign args = ""]
        [#assign listOfLocalVariables =""]
        [#assign resultList =""]
[#if instName?contains("TIM")]
[@common.getLocalVariableList instanceData=instanceData/]
[#else]
 	[#list instanceData.configs as config]
            [@getLocalVariable configModel1=config listOfLocalVariables=listOfLocalVariables resultList=resultList/]
            [#assign listOfLocalVariables =resultList]

        [/#list]
[/#if]
[#if instName!="DSIHOST"]
        [#list instanceData.configs as config]
                
            [#if instanceData.instIndex??][@generateConfigModelCode configModel=config inst=instName  nTab=1 index=instanceData.instIndex/][#else][@generateConfigModelCode configModel=config inst=instName  nTab=1 index=""/][/#if]
        [/#list]

                [#else]
            [#if instanceData.instIndex??][@common.generateConfigModelListCode configModel=instanceData inst=instName  nTab=1 index=instanceData.instIndex/][#else][@common.generateConfigModelListCode configModel=instanceData inst=instName  nTab=1 index=""/][/#if]
                [/#if]

#n
[#if instanceData.isBSPUsed=="true" ][#-- added for periph used by BSP --]
#treturn ret;
} [#-- added for periph used by BSP --]
[/#if]
[/#if]
  
[/#list]
[/#compress]
[/#list]