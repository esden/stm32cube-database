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

[#if useDma]
[#-- include "DMA.h"--]
[/#if]
[#-- End Define includes --]

[#-- Function getInitServiceMode --]
[#function getInitServiceMode(ipname1)]
    [#-- assign initServicesList = {"test0":"test1"}--]
    [#assign initServicesList = ""]
    [#list ipvar.configModelList as instanceData]
        [#if instanceData.halInstanceName==ipname1]
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
        [#if instanceData.halInstanceName==ipname2]
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
        [#list method.arguments as argument][#-- list method.arguments --]
            [#if argument.genericType == "struct"][#-- if struct --]
                [#if argument.context??][#-- if argument.context?? --]
                    [#if argument.context!="global"&&argument.status!="WARNING"&&argument.status!="NULL"] [#-- if !global --]
                    [#assign varName= " "+argument.name]                    
                    [#assign ll= myListOfLocalVariables?split(" ")]
                    [#assign exist=false]
                    [#list ll as var  ]
                        [#if var==argument.name]
                            [#assign exist=true]
                        [/#if]
                    [/#list]
                    [#if !exist]  [#-- if exist --]                  
                    #t${argument.typeName} ${argument.name};                        
                      [#assign myListOfLocalVariables = myListOfLocalVariables + " "+ argument.name]
                      [#assign resultList = myListOfLocalVariables]
                    [/#if][#-- if exist --]
                    [/#if][#-- if global --]
                [#else][#-- if context?? --]
                #t${argument.typeName} ${argument.name};
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
[#if configModel.comments??] [#if nTab==3 ]#t[/#if]#t#t/**${configModel.comments?replace("#t","#t#t")} #n#t#t*/[/#if]
[/#if]
	[#list methodList as method][#assign args = ""]	      
		[#if method.status=="OK"]
             	[#if method.arguments??]
                    [#list method.arguments as fargument][#compress]
                    [#if fargument.addressOf] [#assign adr = "&"][#else ][#assign adr = ""][/#if][/#compress] 
                    [#if fargument.genericType == "struct"]
                        [#if fargument.context??]
                            [#if fargument.context=="global"]
                                [#if configModel.ipName=="DMA"]
                                    [#if configModel.dmaRequestName==""] [#-- if dma request name different from instanceName: case of I2S1 for example --]
                                        [#assign instanceIndex = "_"+ configModel.instanceName?lower_case]
                                    [#else]
                                        [#assign instanceIndex = "_"+ configModel.dmaRequestName?lower_case]
                                    [/#if]
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
                                            #t${argument1.name}[${i}] = ${val};
                                            [#assign i = i+1]
                                        [/#list]
                                        [#assign argValue="&"+argument1.name]
                                    [/#if] [#-- if genericType=Array --]
                                    [#if argument.value!="" && argument.value!="N/A"]
                                    [#if nTab==3 ]#t[/#if][#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${argValue};
                                    [#else]
                                    [#if nTab==3 ]#t[/#if][#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = [#if argument.value!="N/A"]${argValue}[/#if];
                                    [/#if]                                                                     
                                    [/#if]
                                    [#else] [#-- else argument.mandatory--]
                                      [#if fargument.name!="GPIO_InitStruct" && fargument.name!="GPIO_Init"]
                                            [#if argument.name=="Instance"][#-- if argument=Instance--]
                                              [#-- calculate the value of Instance argument if contains $Index --]
                                                [#if  (argument.value??) && (argument.value?contains("$Index"))]
                                                    [#assign instanceValue=argument.value?replace("$Index",index)]
                                                [#if nTab==3 ]#t[/#if][#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${instanceValue};
                                                [#else]
                                                   [#if nTab==3 ]#t[/#if][#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = [#if argument.value??]${argument.value};[#else]${inst}[/#if]
                                                [/#if]
                                          [#else]
                                              [#if argument.status=="KO"]
                                                   [#if nTab==3 ]#t[/#if][#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]//${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${argument.value};                                        
                                              [/#if]
                                              [#if argument.value??]
                                                   [#if nTab==3 ]#t[/#if][#if argument.value!="N/A"][#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${argument.value};  [/#if]
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
                                            #t${argument2.name}[${i}] = ${val};
                                            [#assign i = i+1]
                                        [/#list]
                                        [#assign argValue="&"+argument2.name+"[0]"]
                                    [/#if] [#-- if genericType=Array --]
                                    [#if nTab==3 ]#t[/#if][#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name} = ${argValue};                                    
                                    [/#if]
                               [#else] [#-- !argument.mandatory --]
                                    [#if argument2.status=="KO"]
                                        [#if nTab==3 ]#t[/#if][#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]//${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name} = ${argValue};
                                    [/#if]
                                    [#if argument2.status=="OK"]
                                    [#if nTab==3 ]#t[/#if][#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name} = ${argValue};
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
                                            #t${argument3.name}[${i}] = ${val};
                                            [#assign i = i+1]
                                        [/#list]
                                        [#assign argValue="&"+argument3.name+"[0]"]
                                    [/#if] [#-- if genericType=Array --]
                                    [#if nTab==3 ]#t[/#if][#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name}.${argument3.name} = ${argValue};                                    
                                    [/#if]
                               [#else] [#-- !argument.mandatory --]
                                    [#if argument3.status=="KO"]
                                        [#if nTab==3 ]#t[/#if][#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]//${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name}.${argument3.name} = ${argValue};
                                    [/#if]
                                    [#if argument3.status=="OK"]
                                    [#if nTab==3 ]#t[/#if][#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name}.${argument3.name} = ${argValue};
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
                        [#if fargument.status=="OK" && fargument.value??]
                            [#assign argIndex = inst?replace(name,"")]  
                                            [#if argIndex??]
                                                [#assign argValue=fargument.value?replace("$Index",argIndex)]
                                                [#assign arg = "" + adr + argValue]
                                            [#else]
                                                [#assign arg = "" + adr + fargument.value]                                                
                                            [/#if]
                        [/#if]
                    [/#if]
                    [#if args == "" && arg!=""][#assign args = args + arg ][#else][#if arg!=""][#assign args = args + ', ' + arg][/#if][/#if]
                    [/#list]
                    [#if nTab==3 ]#t[/#if][#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});#n
		[#else]
                    [#if nTab==3 ]#t[/#if][#if nTab==2]#t#t[#else]#t[/#if]${method.name}();#n
                [/#if]			
		[/#if]
		[#if method.status=="KO"]
		#n [#if nTab==2]#t#t[#else]#t[/#if]//!!! ${method.name} is commented because some parameters are missing
			[#if method.arguments??]			
				[#list method.arguments as fargument]
					[#if fargument.addressOf] [#assign adr = "&"][#else ] [#assign adr = ""][/#if]
					[#if fargument.genericType == "struct"][#assign arg = "" + adr + fargument.name]
                                        [#if fargument.context??]                   
                                            [#if fargument.context=="global"]
                                                [#if configModel.ipName=="DMA"]
                                                [#if configModel.dmaRequestName==""] [#-- if dma request name different from instanceName: case of I2S1 for example --]
                                                       [#assign instanceIndex = "_"+ configModel.instanceName?lower_case]
                                                [#else]
                                                       [#assign instanceIndex = "_"+ configModel.dmaRequestName?lower_case]
                                                 [/#if]
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
                               [#if nTab==2]#t#t[#else]#t[/#if]${method.name}()#n;
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
                [#if dmaconfig.dmaRequestName==""] [#-- if dma request name different from instanceName: case of I2S1 for example --]
#t__HAL_LINKDMA(${instHandler},[#if dmaconfig.dmaHandel??]${dmaconfig.dmaHandel}[#else]hdma${prefix}[/#if],hdma_${dmaconfig.instanceName?lower_case});#n
                [#else]
#t__HAL_LINKDMA(${instHandler},[#if dmaconfig.dmaHandel??]${dmaconfig.dmaHandel}[#else]hdma${prefix}[/#if],hdma_${dmaconfig.dmaRequestName?lower_case});#n
                [/#if]        

#n
    [/#list] [#-- list dmaService as dmaconfig --]
#n
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
                 #t#t__${ipName}_CLK_ENABLE(); 
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
                 #t#t/* Peripheral clock disable */
                 #t#t__${ipName}_CLK_DISABLE();  
         [/#if]
    [/#if]
    [#if gpioExist]
[#if ipName=="USB" && USB_INTERRUPT_WAKEUP?? ][#assign tabN=tabN+1][/#if]

#t[@generateConfigCode ipName=ipName type=serviceType serviceName="gpio" instHandler=instHandler tabN=tabN/]
[/#if]
    [#if serviceType=="Init"] 
    [#if dmaExist]#n#t#t/* Peripheral DMA init*/

#t[@generateConfigCode ipName=ipName type=serviceType serviceName="dma" instHandler=instHandler tabN=tabN/]

    [/#if]
    [#if nvicExist]
        [#if initService.nvic??&&initService.nvic?size>0]
 [#-- WorkAround for USB low power--]
           [#if ipName?contains("USB")]
                [#-- WorkAround for USB low power and remap macro--]
                [#if USB_interruptRemapMacro??]
                  #t#t${USB_interruptRemapMacro};
                [/#if]
                [#list initService.nvic as initVector]
                  [#if !initVector.vector?contains("WKUP") && !initVector.vector?contains("WakeUp")]
                    #t#tHAL_NVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority}, ${initVector.subPriority});
                    #t#tHAL_NVIC_EnableIRQ(${initVector.vector});
                  [/#if]
                [/#list]
                [#assign lowPower = "no"]
                [#list initService.nvic as initVector]
                   [#if initVector.vector?contains("WKUP") || initVector.vector?contains("WakeUp") || (initVector.vector == "USB_IRQn" && USB_INTERRUPT_WAKEUP??)]
                      [#assign lowPower = "yes"]
                   [/#if]
                [/#list]
                [#if lowPower == "yes"]
                    #t#tif(hpcd->Init.low_power_enable == 1)
                    #t#t{
                    #t#t#t/* Enable EXTI Line 18 for USB wakeup */
                    [#if FamilyName=="STM32L1"][#-- FamilyName=="STM32F3"|| to be added on V4.5 --]
                      #t#t#t__HAL_USB_EXTI_CLEAR_FLAG();
                      #t#t#t__HAL_USB_EXTI_SET_RISING_EDGE_TRIGGER();
                    [/#if]
                    [#if FamilyName=="STM32F2"||FamilyName=="STM32F4"]
                        [#if ipName?contains("_FS")]
                            #t#t#t__HAL_USB_FS_EXTI_CLEAR_FLAG();
                            #t#t#t__HAL_USB_FS_EXTI_SET_RISING_EGDE_TRIGGER();
                        [/#if]
                        [#if ipName?contains("_HS")]
                            #t#t#t__HAL_USB_HS_EXTI_CLEAR_FLAG();
                            #t#t#t__HAL_USB_HS_EXTI_SET_RISING_EGDE_TRIGGER();
                        [/#if]
                      
                    [/#if]
                    [#if ipName?contains("_HS")]
                        #t#t#t__HAL_USB_HS_EXTI_ENABLE_IT();
                    
                    [#elseif ipName?contains("_FS")]
                        #t#t#t__HAL_USB_FS_EXTI_ENABLE_IT();
                    [#else]
                        #t#t#t__HAL_USB_EXTI_ENABLE_IT();
                    [/#if]
                    [#list initService.nvic as initVector]
                       [#if initVector.vector?contains("WKUP") || initVector.vector?contains("WakeUp")]
                           #t#t#tHAL_NVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority}, ${initVector.subPriority});
                           #t#t#tHAL_NVIC_EnableIRQ(${initVector.vector});
                       [/#if]
                    [/#list]
                    #t#t}
                [/#if]
            [#else]
              [#list initService.nvic as initVector]            
                  #t#tHAL_NVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority}, ${initVector.subPriority});
                  #t#tHAL_NVIC_EnableIRQ(${initVector.vector});
              [/#list]
            [/#if]
        [/#if]
    [/#if]
    [#else] [#-- else serviceType = DeInit --]
[#assign service = getInitServiceMode(ipName)]
    [#if dmaExist]#n#t#t/* Peripheral DMA DeInit*/     
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
    [#if nvicExist&&service??&&service.nvic?size>0]#n#t#t/* Peripheral interrupt Deinit*/[#--#n#t#tHAL_NVIC_DisableIRQ([#if service.nvic.vector??]${service.nvic.vector}[/#if]);--]
[#list service.nvic as initVector]                
                #t#tHAL_NVIC_DisableIRQ(${initVector.vector});
            [/#list]
    [/#if]

    [/#if]
[/#macro]
[#-- End macro add service code --]


[#assign initServicesList = {"test0":"test1"}]

[#-- Section2: Msp Init --]
[#if ipvar.initCallBacks??]
[#compress]
[#list ipvar.initCallBacks.entrySet() as entry] 
[#assign instanceList = entry.value] 
[#if (instanceList?size==1 && (name==instanceList.get(0)||name=="USB")) || instanceList?size>1]
[#assign mode=entry.key?replace("_MspInit","")?replace("_BspInit","")?replace("HAL_","")]

[#assign ipHandler = "h" + mode?lower_case]


[#-- #nvoid HAL_${mode}_MspInit(${mode}_HandleTypeDef* h${mode?lower_case}){--] 
[#if name !="TIM"]
#nvoid ${entry.key}(${mode}_HandleTypeDef* h${mode?lower_case})
{
[#else]
#nvoid ${entry.key}(${name}_HandleTypeDef* h${mode?lower_case})
{
[/#if]
[#--Check if the Msp init will be empty start--] 
    [#assign mspIsEmpty="yes"] 
    [#list instanceList as inst]
     [#if getInitServiceMode(inst)??]
        [#assign services = getInitServiceMode(inst)]
        [#if (services.gpio??)||!services.clock??||(services.clock??&&services.clock!="none")||(services.nvic??&&services.nvic?size>0)||(services.dma??)]
            [#assign mspIsEmpty="no"] 
            [#break]
        [/#if]
     [/#if]
    [/#list]
[#-- Check if the Msp init will be empty end -- ]
[#-- Search for static variables Start--]
[#list instanceList as inst]

     [#assign services = getInitServiceMode(inst)]
[#if services.dma??]
     [#assign dmaService=services.dma]   
    [#if dmaService?? && dmaService?size!=0]
    [#list dmaService as dmaRequest]
        [#list dmaRequest.methods as method]	
		[#if method.status=="OK" && method.arguments??]
                    [#list method.arguments as fargument]
                        [#if fargument.genericType == "struct" && fargument.context??]
                            [#if fargument.context=="global"]

#tstatic ${fargument.typeName} ${fargument.name}_${dmaRequest.instanceName?lower_case};
                            [/#if]
                        [/#if]
                    [/#list]
                [/#if]
         [/#list]

     [/#list] [#-- list dmaService as dmaRequest --]
     [/#if]   [#-- if dmaService?? && dmaService.size!=0 --]
[/#if]
[/#list]

[#assign words = instanceList]
[#-- declare Variable GPIO_InitTypeDef once --]
       [#assign v = ""]
[#list words as inst] [#-- loop on ip instances datas --] 
 [#assign services = getInitServiceMode(inst)]
 [#if services.gpio??][#assign service=services.gpio]
        [#list service.variables as variable] [#-- variables declaration --]
            [#if v?contains(variable.name)]
            [#-- no matches--]
            [#else]
#t${variable.value} ${variable.name};
                [#assign v = v + " "+ variable.name/]	
            [/#if]	
        [/#list]  
[/#if]
[/#list]
[#-- --]
[#if mspIsEmpty=="no"]
 #tif(h${mode?lower_case}->Instance==${words[0]?replace("I2S","SPI")})
#t{
[#if words?size > 1] [#-- Check if there is more than one ip instance--]        
#t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspInit 0 */

#n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspInit 0 */
        [@generateServiceCode ipName=words[0] serviceType="Init" modeName=mode instHandler=ipHandler tabN=2/] 
#t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspInit 1 */

#n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspInit 1 */
    #t} 
    [#assign i = 0]
    [#list words as inst]
    [#if i>0]    
    #telse if(h${mode?lower_case}->Instance==${words[i]?replace("I2S","SPI")}) [#-- if I2S instance should be SPI--]
    #t{
#t/* USER CODE BEGIN ${words[i]?replace("I2S","SPI")}_MspInit 0 */

#n#t/* USER CODE END ${words[i]?replace("I2S","SPI")}_MspInit 0 */
        [@generateServiceCode ipName=words[i] serviceType="Init" modeName=mode instHandler=ipHandler tabN=2/] 
#t/* USER CODE BEGIN ${words[i]?replace("I2S","SPI")}_MspInit 1 */

#n#t/* USER CODE END ${words[i]?replace("I2S","SPI")}_MspInit 1 */
    #t}
        [/#if]
        [#assign i = i + 1]
    [/#list]
[#else]
    [#if words[0]??]
#t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspInit 0 */

#n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspInit 0 */
    [@generateServiceCode ipName=words[0] serviceType="Init" modeName=mode instHandler=ipHandler tabN=2/] 
#t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspInit 1 */

#n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspInit 1 */
    [/#if]
#t}
[/#if] [#-- msp not empty--]
[/#if]
}
[#--break--] [#-- use the first msp--]
[/#if]
[/#list]
[/#compress]
[/#if]
[#-- Section2:End --]


[#if ipvar.deInitCallBacks??]
[#compress]
[#list ipvar.deInitCallBacks.entrySet() as entry]
[#assign instanceList = entry.value]
[#if (instanceList?size==1 && (name==instanceList.get(0)||name=="USB"))  || instanceList?size>1]
[#assign mode=entry.key?replace("_MspDeInit","")?replace("_BspDeInit","")?replace("HAL_","")]
[#assign ipHandler = "h" + mode?lower_case]
[#if name !="TIM"]
#nvoid ${entry.key}(${mode}_HandleTypeDef* h${mode?lower_case})
{
[#else]
#nvoid ${entry.key}(${name}_HandleTypeDef* h${mode?lower_case})
{
[/#if]
[#-- Search for static variables Start--]

[#-- Search for static variables End--]
[#assign words = instanceList]
[#if mspIsEmpty=="no"]
#tif(h${mode?lower_case}->Instance==${words[0]?replace("I2S","SPI")})
#t{
[#if words?size > 1] [#-- Check if there is more than one ip instance--]
 [#assign deInitService = getDeInitServiceMode(words[0])]    
#t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspDeInit 0 */

#n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspDeInit 0 */
[@generateServiceCode ipName=words[0] serviceType="DeInit" modeName=mode instHandler=ipHandler tabN=2/]
#t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspDeInit 1 */

#n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspDeInit 1 */
#t}
  [#assign i = 0]
    [#list words as inst]
        [#if i>0]
#telse if(h${mode?lower_case}->Instance==${words[i]?replace("I2S","SPI")})
#t{
#t/* USER CODE BEGIN ${words[i]?replace("I2S","SPI")}_MspDeInit 0 */

#n#t/* USER CODE END ${words[i]?replace("I2S","SPI")}_MspDeInit 0 */    
[@generateServiceCode ipName=words[i] serviceType="DeInit" modeName=mode instHandler=ipHandler tabN=2/] 
#t/* USER CODE BEGIN ${words[i]?replace("I2S","SPI")}_MspDeInit 1 */

#n#t/* USER CODE END ${words[i]?replace("I2S","SPI")}_MspDeInit 1 */
#t}
        [/#if]
        [#assign i = i + 1]
    [/#list]
[#else]
    [#-- only one ip instance ${instanceList}--]
[#if words[0]??]
#t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspDeInit 0 */

#n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspDeInit 0 */
[@generateServiceCode ipName=words[0] serviceType="DeInit" modeName=mode instHandler=ipHandler tabN=2/] 
#t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspDeInit 1 */

#n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspDeInit 1 */
[/#if]
#t}
[/#if]
[/#if] [#-- msp not empty --]
}
[/#if]
[#--break--] [#-- use the first msp--]
[/#list][#--list ipvar.deInitCallBacks.entrySet() as entry--]
[/#compress]
[/#if][#--if ipvar.deInitCallBacks??--]

[#-- Section3: End --]

[/#list]