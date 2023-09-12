[#ftl]

[#list IPdatas as IP]
[#assign ipvar = IP]
[#assign useGpio = false]
[#assign useDma = false]
[#assign useNvic = false]


[#-- extract hal mode list used by all instances of the ip --]
[#assign halModeList= ""]
[#if ipvar.ipName=="FMC"||ipvar.ipName=="FSMC"]
  [#if ipvar.variables??]
    
    [#list ipvar.variables as variable] [#--if FMC not used with Mw --]
      [#if !halModeList?contains(variable.value?replace("_HandleTypeDef",""))]
        [#assign halModeList = halModeList + " " + variable.value?replace("_HandleTypeDef","")]
      [/#if]
    [/#list]
    [#list ipvar.variablesForMw as variable]  [#--if FMC used with Mw --]
      [#if !halModeList?contains(variable.value?replace("_HandleTypeDef",""))]
        [#assign halModeList = halModeList + " " + variable.value?replace("_HandleTypeDef","")]
      [/#if]
    [/#list]
  [/#if]
[#else]
  [#list ipvar.instances.entrySet() as entry]
    [#if halModeList?contains(entry.value)]
    [#else]
      [#assign halModeList = halModeList + " " +entry.value]
    [/#if]
  [/#list]
[/#if]
[#-- End extract hal mode list used by all instances of the ip --]


[#-- Function getInitServiceMode --]
[#function getInitServiceMode(ipname1)]
  [#assign initServicesList = ""]
  [#list ipvar.configModelList as instanceData]
    [#if instanceData.instanceName==ipname1]
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
  [#assign deInitServicesList = ""]
  [#list ipvar.configModelList as instanceData]
    [#if instanceData.instanceName==ipname2]
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
[#--/* getLocalVariable ${configModel1.name} "${listOfLocalVariables}" "${resultList}" */--]
  [#if configModel1.methods??] 
    [#assign methodList1 = configModel1.methods]
  [#else]
    [#assign methodList1 = configModel1.libMethod]
  [/#if]
  [#assign myListOfLocalVariables = listOfLocalVariables]
  [#list methodList1 as method][#-- list methodList1 --]
    [#list method.arguments as argument][#-- list method.arguments --]
      [#if argument.genericType == "struct"][#-- if struct --]
        [#if argument.context??][#-- if argument.context?? --]
          [#if argument.context!="global"&&argument.status!="WARNING"] [#-- if !global --]
            [#assign ll= myListOfLocalVariables?split(" ")]
            [#assign exist=false]
            [#list ll as var]
              [#if var==argument.name]
                [#assign exist=true]
              [/#if]
            [/#list]
            [#if !exist]  [#-- if exist --]
              [#if argument.status!="NULL"]
                    #t${argument.typeName} ${argument.name};
                [#if myListOfLocalVariables != ""]
                  [#assign myListOfLocalVariables = myListOfLocalVariables + " " + argument.name]
                [#else]
                  [#assign myListOfLocalVariables = argument.name]
                [/#if]
                [#assign resultList = myListOfLocalVariables]
                [#--/* myListOfLocalVariables="${myListOfLocalVariables}" */--]
              [/#if]
            [/#if][#-- if exist --]
          [/#if][#-- if global --]
        [#else][#-- if context?? --]
          [#if argument.status!="NULL"]
                #t${argument.typeName} ${argument.name};
          [/#if]
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
[#macro generateConfigModelCode configModel inst nTab]
  [#if configModel.methods??][#-- if the pin configuration contains a list of LibMethods--]
    [#assign methodList = configModel.methods]
  [#else]
    [#assign methodList = configModel.libMethod]
  [/#if]
  [#assign writeConfigComments=false]
  [#list methodList as method]
    [#if method.status=="OK"]
      [#assign writeConfigComments=true]
    [/#if]
  [/#list]
  [#if writeConfigComments]
    [#if configModel.comments??]#t/** ${configModel.comments}#n#t*/[/#if]
  [/#if]
  [#list methodList as method]
    [#assign args = ""]
    [#if method.status=="OK"]
      [#if method.arguments??]
        [#list method.arguments as fargument]
          [#compress]
          [#if fargument.addressOf]
            [#assign adr = "&"]
          [#else]
            [#assign adr = ""]
          [/#if]
          [/#compress]
          [#if fargument.genericType == "struct"]
            [#if fargument.context??]
              [#if fargument.context=="global"]
                [#if configModel.ipName=="DMA"]
                  [#assign instanceIndex = "_"+ configModel.instanceName?lower_case]
                [#else]
                  [#assign instanceIndex = inst?replace(name,"")]
                [/#if]
              [/#if]
            [/#if]          
            [#if instanceIndex??&&fargument.context=="global"]
              [#if fargument.status!="WARNING"]
                [#assign arg = "" + adr + fargument.name + instanceIndex]
              [#else]
                [#assign arg = "NULL"]
              [/#if]
            [#elseif fargument.status=="NULL"]
              [#assign arg = "NULL"]
            [#else]
              [#assign arg = "" + adr + fargument.name]
            [/#if]
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
                        [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${argValue};
                      [#else]
                        [#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = [#if argument.value!="N/A"]${argValue}[/#if];
                      [/#if]                                                                   
                    [/#if]
                  [#else] [#-- else argument.mandatory--]
                    [#if fargument.name!="GPIO_InitStruct"]
                      [#if argument.name=="Instance"][#-- if argument=Instance--]
                        [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${inst};
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
                                
                [#else][#--if argument.genericType != "struct"--]
                  [#list argument.argument as argument1]
                    [#if argument1.value??]
                      [#assign argValue=argument1.value]
                    [#else]
                      [#assign argValue=""]
                    [/#if]
                    [#if argument1.mandatory]
                      [#if argument1.value??]
                        [#if instanceIndex??&&fargument.context=="global"]
                          [#assign argValue=argument1.value?replace("$Index",instanceIndex)]
                        [#else]
                          [#assign argValue=argument1.value]
                        [/#if]
                        [#if argument1.genericType=="Array"][#-- if genericType=Array --] 
                          [#assign valList = argument1.value?split(":")]     
                          [#assign i = 0]                                  
                          [#list valList as val] 
                                            #t${argument1.name}[${i}] = ${val};
                            [#assign i = i+1]
                          [/#list]
                          [#assign argValue="&"+argument1.name+"[0]"]
                        [/#if] [#-- if genericType=Array --]
                        [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument1.name} = ${argValue};
                      [/#if]
                    [#else] [#-- !argument.mandatory --]
                      [#if argument1.status=="KO"]
                        [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]//${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument1.name} = ${argValue};
                      [/#if]
                      [#if argument1.status=="OK"]
                        [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument1.name} = ${argValue};
                      [/#if]
                    [/#if][#-- if argument.mandatory --]
                                
                  [/#list]
                [/#if][#--if argument.genericType != "struct"--]
              [/#list][#-- list  fargument.argument as argument--]
            [/#if][#-- if (!method.name?contains("Init")&&fargument.context=="global")--]

          [#else][#--if fargument.genericType == "struct"--]
            [#assign arg = ""]
            [#if fargument.status=="OK" && fargument.value??]
              [#assign arg = "" + adr + fargument.value]
            [/#if]
          [/#if][#--if fargument.genericType == "struct"--]
          [#if args == "" && arg!=""]
            [#assign args = args + arg]
          [#else]
            [#if arg!=""]
              [#assign args = args + ', ' + arg]
            [/#if]
          [/#if]
        [/#list][#--list method.arguments as fargument--]
        [#--[#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});#n--]
                    [#if method.returnHAL=="false"]
                        [#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});
                    [#else]
                        [#-- [#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});#n --]
                        [#if nTab==2]#t#t[#else]#t[/#if]if (${method.name}(${args}) != HAL_OK)
                        [#if nTab==2]#t#t[#else]#t[/#if]{
                        [#if nTab==2]#t#t[#else]#t[/#if]#tError_Handler();
                        [#if nTab==2]#t#t[#else]#t[/#if]}
                    [/#if]#n                        
		  [#else][#--if method.arguments??--]
        [#--[#if nTab==2]#t#t[#else]#t[/#if]${method.name}();--]
                    [#if method.returnHAL=="false"]
                        [#if nTab==2]#t#t[#else]#t[/#if]${method.name}();
                    [#else]
                        [#-- [#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});#n --]
                        [#if nTab==2]#t#t[#else]#t[/#if]if (${method.name}() != HAL_OK)
                        [#if nTab==2]#t#t[#else]#t[/#if]{
                        [#if nTab==2]#t#t[#else]#t[/#if]#tError_Handler( );
                        [#if nTab==2]#t#t[#else]#t[/#if]}
                    [/#if]#n
      [/#if][#--if method.arguments??--]
    [/#if][#--if method.status=="OK"--]
    [#if method.status=="KO"]
		#n [#if nTab==2]#t#t[#else]#t[/#if]//!!! ${method.name} is commented because some parameters are missing
      [#if method.arguments??]			
        [#list method.arguments as fargument]
          [#if fargument.addressOf]
            [#assign adr = "&"][#else ]
            [#assign adr = ""]
          [/#if]
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
            [#if instanceIndex??&&fargument.context=="global"]
              [#assign arg = "" + adr + fargument.name + instanceIndex]
            [#else]
              [#assign arg = "" + adr + fargument.name]
            [/#if]
            [#if (!method.name?contains("Init")&&fargument.context=="global")]
            [#else]
              [#list fargument.argument as argument]	
                [#if argument.genericType != "struct"]
                  [#if argument.mandatory && argument.value??]
                    [#if instanceIndex??&&fargument.context=="global"]
                      [#assign argValue=argument.value?replace("$Index",instanceIndex)]
                    [#else]
                      [#assign argValue=argument.value]
                    [/#if]
                    [#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${argValue};
                  [#else]
                    [#if argument.name=="Instance"]
                      [#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${inst};
                    [/#if]                                
                  [/#if]
                [#else]
                  [#list argument.argument as argument1]
                    [#if argument1.mandatory]
                      [#if instanceIndex??&&fargument.context=="global"]
                        [#assign argValue=argument1.value?replace("$Index",instanceIndex)]
                      [#else][#assign argValue=argument1.value]
                      [/#if]
                      [#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument1.name} = ${argValue};
                    [/#if]
                  [/#list]
                [/#if]
              [/#list]
            [/#if]
          [#else]
            [#assign arg = "" + adr + fargument.value]
          [/#if]
          [#if args == ""]
            [#assign args = args + arg ]
          [#else]
            [#assign args = args + ', ' + arg]
          [/#if]
        [/#list]
                                [#if nTab==2]#t#t[#else]#t[/#if]#t//${method.name}(${args});
      [#else]
                              [#-- [#if nTab==2]#t#t[#else]#t[/#if]${method.name}()#n;--]
                [#if method.returnHAL=="false"]
                    [#if nTab==2]#t#t[#else]#t[/#if]${method.name}();
                [#else]
                    [#-- [#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});#n --]
                    [#if nTab==2]#t#t[#else]#t[/#if]if (${method.name}() != HAL_OK)
                    [#if nTab==2]#t#t[#else]#t[/#if]{
                    [#if nTab==2]#t#t[#else]#t[/#if]#tError_Handler( );
                    [#if nTab==2]#t#t[#else]#t[/#if]}
                [/#if]#n
      [/#if]
    [/#if][#--if method.status=="KO"--]
  [/#list][#--list methodList as method--]

  [#assign instanceIndex = ""]
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
    [#if service.gpio??]
      [#assign gpioService = service.gpio]
    [#else]
      [#assign gpioService = ""]
    [/#if]
  [/#if]
  [#if serviceName=="dma" && service.dma??]
    [#assign dmaService = service.dma]
  [/#if]
   
  [#if serviceName=="gpio"]
    [#assign instanceIndex =""]
    [@generateConfigModelCode configModel=gpioService inst=ipName nTab=tabN/]
  [/#if]
  [#if serviceName=="dma" && dmaService??]
    [#assign instanceIndex =""]
    [#list dmaService as dmaconfig] 
      [@generateConfigModelCode configModel=dmaconfig inst=ipName  nTab=tabN/]
      [#assign dmaCurrentRequest = dmaconfig.instanceName?lower_case]
      [#assign prefixList = dmaCurrentRequest?split("_")]
      [#list prefixList as p]
        [#assign prefix= p]
      [/#list]
        
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
      [#if instanceData.dmaHandel??]
        [#assign result=instanceData.dmaHandel]
      [/#if]
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
    #t/* Peripheral clock enable */
  [#if serviceType=="Init"] 
    [#if initService.clock??]
      [#list initService.clock?split(';') as clock]
        #t${clock}(); 
      [/#list]
    [#else]
         #t__HAL_RCC_${ipName}_CLK_ENABLE();
    [/#if]
  [#else]           
         #t__HAL_RCC_${ipName}_CLK_DISABLE();   
  [/#if]
  [#if gpioExist]
#t[@generateConfigCode ipName=ipName type=serviceType serviceName="gpio" instHandler=instHandler tabN=tabN/]
  [/#if]
  [#if serviceType=="Init"]
    [#if dmaExist]#n#t#t/* Peripheral DMA init*/
#t[@generateConfigCode ipName=ipName type=serviceType serviceName="dma" instHandler=instHandler tabN=tabN/]
    [/#if]
    [#if nvicExist]
        [#if initService.nvic??]
            [#assign irqNum = 0]
            [#list initService.nvic as initVector]
              [#if initVector.codeInMspInit]
                [#assign irqNum = irqNum+1]
                [#if irqNum==1]#t/* Peripheral interrupt init */[/#if]
                #tHAL_NVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority}, ${initVector.subPriority});
                #tHAL_NVIC_EnableIRQ(${initVector.vector});
              [/#if]
            [/#list]
        [/#if]
    [/#if]
  [#else] [#-- else serviceType = DeInit --]
    [#if dmaExist]#n#t#t/* Peripheral DMA DeInit */
    
      [#assign service = getInitServiceMode(ipName)]
      [#assign dmaservice =service.dma]
      [#if dmaservice??]
        [#list dmaservice as dmaconfig]
          [#assign dmaCurrentRequest = dmaconfig.instanceName?lower_case]
          [#assign prefixList = dmaCurrentRequest?split("_")]
          [#list prefixList as p][#assign prefix= p][/#list]
          [#assign ipdmahandler1 = "hdma" + prefix]
          [#-- [#if getDmaHandler(ipName)!=""][#assign ipdmahandler = getDmaHandler(ipName)][#else][#assign ipdmahandler = ipdmahandler1][/#if]--]
          [#if dmaconfig.dmaHandel??]
            [#assign ipdmahandler = dmaconfig.dmaHandel]
          [#else]
            [#assign ipdmahandler = ipdmahandler1]
          [/#if]
        #t   #tHAL_DMA_DeInit(${instHandler}->${ipdmahandler});
        [/#list] [#-- list dmaService as dmaconfig --]
      [/#if]

    [/#if] [#-- if DMA exist --]
    [#-- DeInit NVIC if DeInit --]
    [#if nvicExist]
          [#if initService.nvic??]
              [#assign irqNum = 0]
              [#list initService.nvic as initVector]
                  [#assign irqNum = irqNum+1]
                  [#if irqNum==1]#t/* Peripheral interrupt DeInit */[/#if]
                  #tHAL_NVIC_DisableIRQ(${initVector.vector});
              [/#list]
          [/#if]
    [/#if]
  [/#if]
[/#macro]
[#-- End macro add service code --]

[#compress]

[#-- Section2: Msp Init --]
[#assign mspinitvar = ipvar.ipName + "_Initialized"]
#nstatic uint32_t ${mspinitvar} = 0;

#nstatic void HAL_${ipvar.ipName}_MspInit(void){
#t/* USER CODE BEGIN ${ipvar.ipName}_MspInit 0 */

#n#t/* USER CODE END ${ipvar.ipName}_MspInit 0 */
[#assign services = getInitServiceMode(ipvar.ipName)]
[#if services.gpio??]
  [#assign service=services.gpio]
  [#assign v = ""]
  [#list service.variables as variable] [#-- variables declaration --]
    [#if v?contains(variable.name)]
    [#else]
#t${variable.value} ${variable.name} ={0};
      [#assign v = v + " " + variable.name]
    [/#if]
  [/#list]
[/#if]
#tif (${mspinitvar}) {
#t#treturn;
#t}
#t${mspinitvar} = 1;


[#assign listOfLocalVariables =""]
    [#assign resultList =""]
[#list ipvar.configModelList as instanceData]
[#if instanceData.initServices??]
    [#if instanceData.initServices.pclockConfig??]
        [#assign   pclockConfig=instanceData.initServices.pclockConfig] [#--list0--]
        [#list pclockConfig.configs as config] [#--list1--]
            [@common.getLocalVariable configModel1=config listOfLocalVariables=listOfLocalVariables resultList=resultList/]
            [#assign listOfLocalVariables =resultList]
        [/#list]
    [/#if]
[/#if]
[/#list]
#n
[#assign clockInst=""]

[#list ipvar.configModelList as instanceData]
[#if instanceData.initServices??]
    [#if instanceData.initServices.pclockConfig??]
[#if FamilyName=="STM32MP1"]
#tif(IS_ENGINEERING_BOOT_MODE())
#t{
[/#if]
[#assign   pclockConfig=instanceData.initServices.pclockConfig] [#--list0--]
[@common.generateConfigModelListCode configModel=pclockConfig inst=""  nTab=2 index=""/]#n
[#if FamilyName=="STM32MP1"]
#t}
[/#if]
#n
    [/#if]
[/#if]

[/#list]
[#assign ipHandler = "h" + ipvar.ipName?lower_case]

[@generateServiceCode ipName=ipvar.ipName serviceType="Init" modeName=ipvar.ipName instHandler=ipHandler tabN=1/]
#t/* USER CODE BEGIN ${ipvar.ipName}_MspInit 1 */

#n#t/* USER CODE END ${ipvar.ipName}_MspInit 1 */
}

[#list halModeList?split(" ") as mode]
  [#if mode!=""]
    [#assign instanceList = ""]

    [#if ipvar.ipName!="FMC"&&ipvar.ipName!="FSMC"]
      [#list ipvar.instances.entrySet() as entry]
        [#if entry.value == mode]
          [#assign instanceList = instanceList + " "+ entry.key]
        [/#if]
      [/#list]
    [/#if]
    [#assign ipHandler = "h" + mode?lower_case]
#nvoid HAL_${mode}_MspInit(${mode}_HandleTypeDef* h${mode?lower_case}){

    [#-- Search for static variables Start--]
    [#list instanceList?word_list as inst]

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

          [/#list]  [#-- list dmaService as dmaRequest --]
        [/#if]  [#-- if dmaService?? && dmaService.size!=0 --]
      [/#if]  [#-- if services.dma?? --]
    [/#list]

    [#assign words = instanceList?word_list]
    [#-- declare Variable GPIO_InitTypeDef once --]
    [#assign v = ""]
    [#list words as inst] [#-- loop on ip instances data --] 
      [#assign services = getInitServiceMode(inst)]
      [#if services.gpio??]
        [#assign service=services.gpio]
        [#list service.variables as variable] [#-- variables declaration --]
          [#if v?contains(variable.name)]
            [#-- no matches--]
          [#else]
#t${variable.value} ${variable.name};
            [#assign v = v + " "+ variable.name]
          [/#if]
        [/#list]  
      [/#if]
    [/#list]
    [#-- --]
    [#if words[0]??]
      [@generateServiceCode ipName=words[0] serviceType="Init" modeName=mode instHandler=ipHandler tabN=1/] 
    [/#if]
#t/* USER CODE BEGIN ${mode}_MspInit 0 */

#n#t/* USER CODE END ${mode}_MspInit 0 */
#tHAL_${ipvar.ipName}_MspInit();
#t/* USER CODE BEGIN ${mode}_MspInit 1 */

#n#t/* USER CODE END ${mode}_MspInit 1 */
}
  [/#if]
[/#list][#-- list halModeList?split(" ") as mode --]
[#-- Section2:End --]

[#-- Section3: Msp DeInit --]
[#assign mspdeinitvar = ipvar.ipName + "_DeInitialized"]
#nstatic uint32_t ${mspdeinitvar} = 0;

#nstatic void HAL_${ipvar.ipName}_MspDeInit(void){
#t/* USER CODE BEGIN ${ipvar.ipName}_MspDeInit 0 */

#n#t/* USER CODE END ${ipvar.ipName}_MspDeInit 0 */
#tif (${mspdeinitvar}) {
#t#treturn;
#t}
#t${mspdeinitvar} = 1;
[#assign ipHandler = "h" + ipvar.ipName?lower_case]

[@generateServiceCode ipName=ipvar.ipName serviceType="DeInit" modeName=ipvar.ipName instHandler=ipHandler tabN=1/]
#t/* USER CODE BEGIN ${ipvar.ipName}_MspDeInit 1 */

#n#t/* USER CODE END ${ipvar.ipName}_MspDeInit 1 */
}

[#list halModeList?split(" ") as mode]
  [#if mode!=""]
    [#assign instanceList = ""]

    [#if ipvar.ipName!="FMC"&&ipvar.ipName!="FSMC"]
      [#list ipvar.instances.entrySet() as entry]
        [#if entry.value == mode]
          [#assign instanceList = instanceList + " "+ entry.key]
        [/#if]
      [/#list]
    [/#if]
    [#assign ipHandler = "h" + mode?lower_case]

#nvoid HAL_${mode}_MspDeInit(${mode}_HandleTypeDef* h${mode?lower_case}){
    [#-- Search for static variables Start--]

    [#-- Search for static variables End--]
    [#assign words = instanceList?word_list]
    [#-- only one ip instance ${instanceList}--]
    [#if words[0]??]
      [@generateServiceCode ipName=words[0] serviceType="DeInit" modeName=mode instHandler=ipHandler tabN=1/] 
    [/#if]
#t/* USER CODE BEGIN ${mode}_MspDeInit 0 */

#n#t/* USER CODE END ${mode}_MspDeInit 0 */
#tHAL_${ipvar.ipName}_MspDeInit();
#t/* USER CODE BEGIN ${mode}_MspDeInit 1 */

#n#t/* USER CODE END ${mode}_MspDeInit 1 */
}
  [/#if]
[/#list]
[#-- Section3: End --]
[/#compress]
[/#list]