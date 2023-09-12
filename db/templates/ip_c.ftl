[#ftl]
/**
  ******************************************************************************
  * File Name          : ${name}.c
  * Description        : This file provides code for the configuration
  *                      of the ${name} instances.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

[#function list_contains string_list element]
  [#list string_list?split(" ") as string_element]
    [#if string_element == element]
      [#return true]
    [/#if]
  [/#list]
  [#return false]
[/#function]
[#list IPdatas as IP]  
[#assign ipvar = IP]
/* Includes ------------------------------------------------------------------*/
#include "${name?lower_case}.h"

[#assign useGpio = false]
[#assign useBdma = false]
[#assign useDma = false]
[#assign useMdma = false]
[#assign useNvic = false]

[#-- Tracker 276386 -- GetHandle Start --]
[#compress]
[#assign handlerList = ""]
[#if handlers??]
  [#list handlers as handler]
    [#list handler.entrySet() as entry]
      [#list entry.value as ipHandler]
        [#if !(handlerList?contains("("+ipHandler.handler+")"))]
[#--static ${ipHandler.handlerType} ${ipHandler.handler}; --]
        [/#if]
[#assign handlerList = handlerList + " "+ "("+ipHandler.handler+")"]
    [/#list]
  [/#list]
[/#list]
[/#if]
[#-- Tracker 276386 -- GetHandle End --]
#n
[#assign handlerList = ""]

[/#compress]

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
        [#list instanceData.initServices.dma as configModel]
          [#if configModel.ipName?starts_with("BDMA")]
            [#assign useBdma = true]
          [/#if]
          [#if configModel.ipName=="DMA"]
            [#assign useDma = true]
          [/#if]
          [#if configModel.ipName == "MDMA"]
            [#assign useMdma = true]
          [/#if]
        [/#list]
    [/#if]
    [#if instanceData.initServices.nvic??]
        [#assign useNvic = true]
    [/#if]
  [/#if]
[/#list]


[#-- End Define includes --]
[#-- Tracker 276386 -- GetHandle Start --]
#n
[#if IP.variables??]
[#list IP.variables as variable]
[#-- static ${variable.value} ${variable.name}; --]
[/#list]
[/#if]
[#if GFXMMUisUsed?? && name=="GFXMMU"]
[@common.optincludeFile path="Inc" name="gfxmmu_lut.h"/]
[/#if]
[#-- WorkAround for Ticket 30863 --]
[#if name=="ETH" && H7_ETH_NoLWIP??]
#if defined ( __ICCARM__ ) /*!< IAR Compiler */

#pragma location=[#if RxDescAddress??]${RxDescAddress}[#else]0x30040000[/#if]
ETH_DMADescTypeDef  DMARxDscrTab[ETH_RX_DESC_CNT]; /* Ethernet Rx DMA Descriptors */
#pragma location=[#if TxDescAddress??]${TxDescAddress}[#else]0x30040060[/#if]
ETH_DMADescTypeDef  DMATxDscrTab[ETH_TX_DESC_CNT]; /* Ethernet Tx DMA Descriptors */
#pragma location=[#if RxBuffAddress??]${RxBuffAddress}[#else]0x30040200[/#if]
uint8_t Rx_Buff[ETH_RX_DESC_CNT][ETH_MAX_PACKET_SIZE]; /* Ethernet Receive Buffers */

#elif defined ( __CC_ARM )  /* MDK ARM Compiler */

__attribute__((at([#if RxDescAddress??]${RxDescAddress}[#else]0x30040000[/#if]))) ETH_DMADescTypeDef  DMARxDscrTab[ETH_RX_DESC_CNT]; /* Ethernet Rx DMA Descriptors */
__attribute__((at([#if TxDescAddress??]${TxDescAddress}[#else]0x30040060[/#if]))) ETH_DMADescTypeDef  DMATxDscrTab[ETH_TX_DESC_CNT]; /* Ethernet Tx DMA Descriptors */
__attribute__((at([#if RxBuffAddress??]${RxBuffAddress}[#else]0x30040200[/#if]))) uint8_t Rx_Buff[ETH_RX_DESC_CNT][ETH_MAX_PACKET_SIZE]; /* Ethernet Receive Buffer */

#elif defined ( __GNUC__ ) /* GNU Compiler */ 

ETH_DMADescTypeDef DMARxDscrTab[ETH_RX_DESC_CNT] __attribute__((section(".RxDecripSection"))); /* Ethernet Rx DMA Descriptors */
ETH_DMADescTypeDef DMATxDscrTab[ETH_TX_DESC_CNT] __attribute__((section(".TxDecripSection")));   /* Ethernet Tx DMA Descriptors */
uint8_t Rx_Buff[ETH_RX_DESC_CNT][ETH_MAX_PACKET_SIZE] __attribute__((section(".RxArraySection"))); /* Ethernet Receive Buffers */

#endif

ETH_TxPacketConfig TxConfig; 
[/#if]
[#-- End workaround for Ticket 30863 --]
[#-- Tracker 276386 -- GetHandle End --]
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

[#-- Function getDmaType --]
[#-- BDMA dmaType is DMA --]
[#function getDmaType(dmaconfig)]
  [#assign dmaType = "DMA"]
  [#if dmaconfig.ipName=="MDMA"]
    [#assign dmaType = "MDMA"]
  [/#if]
  [#return dmaType]
[/#function]
[#-- End Function getDmaType --]

[#-- Function getDmaHandlePrefix --]
[#-- BDMA dmaHandlePrefix is hdma --]
[#function getDmaHandlePrefix(dmaconfig)]
  [#assign dmaHandlePrefix = "hdma"]
  [#if dmaconfig.ipName=="MDMA"]
    [#assign dmaHandlePrefix = "hmdma"]
  [/#if]
  [#return dmaHandlePrefix]
[/#function]
[#-- End Function getDmaHandlePrefix --]

[#-- Function getDmaServiceType --]
[#function getDmaServiceType(dmaservice)]
    [#list dmaservice as dmaconfig]
        [#return getDmaType(dmaconfig)]
    [/#list]
[/#function]
[#-- End Function getDmaServiceType --]
[#function getLocalVariableCLK configModel1]
[#if configModel1.methods??] 
    [#assign methodList1 = configModel1.methods]
[#else]
    [#assign methodList1 = configModel1.libMethod]
[/#if]
[#assign clkVariables = ""]
    [#list methodList1 as method][#-- list methodList1 --]
        [#list method.arguments as argument][#-- list method.arguments --]
            [#if argument.genericType == "struct"]
                [#if argument.context??]
                    [#if argument.context!="global"&&argument.status!="WARNING"&&argument.status!="NULL"] [#-- if !global --]
                        [#if clkVariables==""]
                            [#assign clkVariables = argument.typeName + " "+ argument.name]
                        [#else]
                            [#assign clkVariables = clkVariables+"/"+ argument.typeName + " "+ argument.name]
                        [/#if]
                    [/#if]
                [/#if]
            [/#if]
        [/#list][#-- list method.arguments --]
    [/#list][#-- list methodList1 --]
[#return clkVariables]
[/#function]
[#-- Function getLocalVariableCLK of a config End--]
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

[#--------------DMA DFSDM--]
[#-- macro generate service code for MspInit/MspDeInit Start--]
[#macro generateServiceCodeDFSDM ipName serviceType modeName instHandler tabN]
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
        [#if entry.key=="dma"  && modeName?contains("DFSDM_Filter")]
        [#assign dmaExist = true]
        [/#if]
        [#if entry.key=="nvic" && initService.nvic?size!=0 && (modeName?contains("DFSDM_Filter")||!modeName?contains("DFSDM"))]
        [#assign nvicExist = true]
        [/#if]
        [#if entry.key=="gpio"]
        [#assign gpioExist = true]
        [/#if]            
    [/#list]
    [/#if]    
   
      
    [#if serviceType=="Init"] 
        [#if dmaExist]
        #t[@generateConfigCode ipName=ipName type=serviceType serviceName="dma" instHandler=instHandler tabN=tabN/]
        [/#if] 
    [#else] [#-- if Deinit DMA --]
    [#assign service = getInitServiceMode(ipName)] 
        [#if dmaExist]
            [#assign dmaservice =service.dma]
            [#if dmaservice??]#n#t#t/* ${ipName} ${getDmaServiceType(dmaservice)} DeInit */
               [#-- list dmaservice as dmaconfig (Not necessary for DFSDM: applicable for all handler)--]
                    [#assign dmaconfig = dmaservice[0]]
                   [#if dmaconfig.dmaRequestName==""]
                        [#assign dmaCurrentRequest = dmaconfig.instanceName?lower_case]
                   [#else]
                        [#assign dmaCurrentRequest = dmaconfig.dmaRequestName?lower_case]
                   [/#if]
                   [#assign prefixList = dmaCurrentRequest?split("_")] 
            [#assign ind=""]
[#if dmaCurrentRequest?contains("dfsdm")]
    [#assign ind=dmaconfig.dmaRequestName?substring(dmaconfig.dmaRequestName?length-1)]
[#-- #tif(${instHandler}->Instance == ${ipName}_Filter${ind}){ --]
[/#if]
                   [#list prefixList as p][#assign prefix= p][/#list]
                        [#assign ipdmahandler1 = "hdma" + prefix]
                        [#-- [#if getDmaHandler(ipName)!=""][#assign ipdmahandler = getDmaHandler(ipName)][#else][#assign ipdmahandler = ipdmahandler1][/#if]--]
                        [#if dmaconfig.dmaHandel??][#assign ipdmahandler = dmaconfig.dmaHandel][#else][#assign ipdmahandler = ipdmahandler1][/#if]                     
                            [#list dmaconfig.dmaHandel as dmaH]
                                #t#tHAL_${getDmaType(dmaconfig)}_DeInit(${instHandler}->${dmaH});
                            [/#list]
[#if dmaCurrentRequest?contains("dfsdm")]
[#-- #t} --]
#n
[/#if]                        
                    [#-- /#list (Not necessary for DFSDM: applicable for all handler) --] [#-- list dmaService as dmaconfig --]
             [/#if]    
        [/#if]
    [/#if]   
[/#macro]

[#-- End macro add service code --]
[#--------------DMA DFSDM --]
[#-- macro generateConfigModelCode --]

[#macro generateConfigModelCode configModel inst nTab index mode]
[#if configModel.clockEnableMacro?? && mode=="Init"] [#-- Enable Port clock --]
    [#list configModel.clockEnableMacro as clkmacroList]	
            [#if nTab==2]#t#t[#else]#t[/#if]${clkmacroList}[#if !clkmacroList?contains("(")]()[/#if];
    [/#list]
[/#if]
[#if configModel.methods??] [#-- if the pin configuration contains a list of LibMethods--]
    [#assign methodList = configModel.methods]
[#else] [#assign methodList = configModel.libMethod]

[/#if]
[#assign writeConfigComments=false]
[#list methodList as method]
    [#if method.status=="OK"][#assign writeConfigComments=true][/#if]
[/#list]
[#if writeConfigComments]
[#if configModel.comments??] #t#t/**${configModel.comments?replace("#t","#t#t")} #n#t#t*/[/#if]
[/#if]
	[#list methodList as method][#assign args = ""]	      
		[#if method.status=="OK"]
             	[#if method.arguments??]
                    [#list method.arguments as fargument][#compress]
                    [#if fargument.addressOf] [#assign adr = "&"][#else ][#assign adr = ""][/#if][/#compress] 
                    [#if fargument.genericType == "struct"]
                        [#if fargument.context??]
                            [#if fargument.context=="global"]
                                [#if configModel.ipName=="DMA" || configModel.ipName?starts_with("BDMA") || configModel.ipName=="MDMA"]
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
                        [#if ((!method.name?contains("Init")&&fargument.context=="global")||fargument.optional=="output")]
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
                                            [/#if]
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
                                                #t${argument2.name}[${i}] =0x${val};
                                            [/#if]
                                            [#assign i = i+1]
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
                                            #t${argument3.name}[${i}] = ${val};
                                            [#assign i = i+1]
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
                    [#--[#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});#n--]
                            [#if method.returnHAL=="false"]
                                [#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});
                            [#else]
                                [#-- [#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});#n --]
                                [#if nTab==2]#t#t[#else]#t[/#if]if (${method.name}(${args}) != [#if method.returnHAL == "true"]HAL_OK[#else]${method.returnHAL}[/#if])
                                [#if nTab==2]#t#t[#else]#t[/#if]{
                                [#if nTab==2]#t#t[#else]#t[/#if]#tError_Handler();
                                [#if nTab==2]#t#t[#else]#t[/#if]}
                            [/#if]#n                                    
		[#else]
                    [#--[#if nTab==2]#t#t[#else]#t[/#if]${method.name}();#n--]
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
					[#if fargument.genericType == "struct"][#assign arg = "" + adr + fargument.name]
                                        [#if fargument.context??]                   
                                            [#if fargument.context=="global"]
                                                [#if configModel.ipName=="DMA" || configModel.ipName?starts_with("BDMA") || configModel.ipName=="MDMA"]
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
[#macro generateConfigCode ipName type serviceName instHandler tabN ]
[#if type=="Init"]
 [#assign service = getInitServiceMode(ipName)]
[#else]
 [#assign service = getDeInitServiceMode(ipName)]
[/#if]
[#if serviceName=="gpio"]
    [#if service.gpio??][#assign gpioService = service.gpio][#else][#assign gpioService = ""][/#if]
[/#if]
[#if serviceName=="gpioOut"]
    [#if service.gpioOut??][#assign gpioOutService = service.gpioOut][#else][#assign gpioOutService = "empty"][/#if]
[#else]
[#assign gpioOutService = "empty"]
[/#if]
[#if serviceName=="dma" && service.dma??]
[#assign dmaService = service.dma]
[#if type=="Init"]
#n#t#t/* ${ipName} ${getDmaServiceType(dmaService)} Init */
[/#if]
[/#if]
   
[#if serviceName=="gpio"]
 [#assign instanceIndex =""]
    [@generateConfigModelCode configModel=gpioService inst=ipName nTab=tabN index="" mode=type/]
[/#if]
[#if serviceName=="gpioOut"]
 [#assign instanceIndex =""]
[#if gpioOutService!="empty"]
    [@generateConfigModelCode configModel=gpioOutService inst=ipName nTab=tabN index="" mode=type/]
[/#if]
[/#if]
[#if serviceName=="dma" && dmaService??]
 [#assign instanceIndex =""]
    [#list dmaService as dmaconfig] 
[#if dmaconfig.dmaRequestName=""]
            [#assign dmaCurrentRequest = dmaconfig.instanceName?lower_case]
        [#else]
            [#assign dmaCurrentRequest = dmaconfig.dmaRequestName?lower_case]
        [/#if]
#t#t/* ${dmaCurrentRequest?upper_case} Init */
[#--workAround DFSDM--]
 [#assign ind="" ]
[#if dmaCurrentRequest?contains("dfsdm")]
    [#assign reqName  = dmaconfig.dmaRequestName?replace("_ON_BDMA1","")]
    [#assign ind=reqName?substring(reqName?length-1)]
#tif(${instHandler}->Instance == ${ipName}_Filter${ind}){
[/#if]
     [@generateConfigModelCode configModel=dmaconfig inst=ipName  nTab=tabN index="" mode=type/]
        [#assign prefixList = dmaCurrentRequest?split("_")]
        [#list prefixList as p][#assign prefix= p][/#list]
        
            [#-- #t__HAL_LINKDMA(${instHandler},[#if dmaconfig.dmaHandel??]${dmaconfig.dmaHandel}[#else]hdma${prefix}[/#if],${getDmaHandlePrefix(dmaconfig)}_${dmaconfig.instanceName?lower_case});#n --]
            [#if dmaconfig.dmaHandel?size > 1] [#-- if more than one dma handler--]
                [#assign channel="channel"]
                [#if (FamilyName=="STM32F2" || FamilyName=="STM32F4" || FamilyName=="STM32F7")]
                  [#assign channel="stream"]
                [/#if]
                #t#t/* Several peripheral DMA handle pointers point to the same DMA handle.
                #t#t   Be aware that there is only one ${channel} to perform all the requested DMAs. */
                [#assign one_sdio_request=false]
                [#if (FamilyName=="STM32F1" || FamilyName=="STM32F2" || FamilyName=="STM32F4") && dmaconfig.dmaRequestName=="SDIO"]
                  [#assign one_sdio_request=true]
                [/#if]
                [#if FamilyName=="STM32L1" && dmaconfig.dmaRequestName=="SD_MMC"]
                  [#assign one_sdio_request=true]
                [/#if]
                [#if (FamilyName=="STM32F7" || FamilyName=="STM32L4") && dmaconfig.dmaRequestName=="SDMMC1"]
                  [#assign one_sdio_request=true]
                [/#if]
                [#if one_sdio_request]
                #t#t/* Be sure to change transfer direction before calling
                #t#t   HAL_SD_ReadBlocks_DMA or HAL_SD_WriteBlocks_DMA. */
                [/#if]
            [/#if]   [#-- if more than one dma handler--]  
            [#list dmaconfig.dmaHandel as dmaH]
                [#if dmaconfig.dmaRequestName==""] [#-- if dma request name different from instanceName: case of I2S1 for example --]
                    #t#t__HAL_LINKDMA(${instHandler},${dmaH},${getDmaHandlePrefix(dmaconfig)}_${dmaconfig.instanceName?lower_case});
                [#else]
        [#--workAround DFSDM--]
            [#assign ind=""]
            [#if dmaconfig.dmaRequestName?contains("DFSDM")]
                [#assign ind=dmaconfig.dmaRequestName?replace("DFSDM","")]
            [/#if]
                    #t#t__HAL_LINKDMA(${instHandler},${dmaH},${getDmaHandlePrefix(dmaconfig)}_${dmaconfig.dmaRequestName?lower_case});
                [/#if]
            [/#list]
            [#-- #t#t__HAL_LINKDMA(${instHandler},[#if dmaconfig.dmaHandel??]${dmaconfig.dmaHandel}[#else]hdma${prefix}[/#if],${getDmaHandlePrefix(dmaconfig)}_${dmaconfig.instanceName?lower_case});#n --]
[#if dmaCurrentRequest?contains("dfsdm")]
    #t}
[/#if]
#n
    [/#list] [#-- list dmaService as dmaconfig --]
#n
[/#if]

[/#macro]
[#-- End macro generateConfigCode --]

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

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
            [#if entry.key=="dma" && !modeName?contains("DFSDM")]
            [#assign dmaExist = true]
            [/#if]
            [#if entry.key=="nvic" && initService.nvic?size!=0 && !modeName?contains("DFSDM_Filter")]
            [#assign nvicExist = true]
            [/#if]
            [#if entry.key=="gpio"]
            [#assign gpioExist = true]
            [/#if]            
        [/#list]
        [/#if]    
[#assign usedDriverFlag = ""]
[#list ipvar.configModelList as instanceData]
    [#if instanceData.usedDriver?? && instanceData.usedDriver == "LL"]
        [#assign usedDriverFlag = usedDriverFlag+" LL"]    
    [#else]
        [#assign usedDriverFlag = usedDriverFlag+" HAL"]     
    [/#if]
    
[/#list]
    [#if serviceType=="Init"] 
        [#if !ipName?contains("I2C")&& !ipName?contains("USB")] [#-- if not I2C --]
            [#if initService.clock??]
                [#if initService.clock!="none"]
                    [#if FamilyName=="STM32F1" && ipName=="RTC"]
                        [#if usedDriverFlag?? && !usedDriverFlag?contains("LL")]
                        #t#tHAL_PWR_EnableBkUpAccess();
                        #t#t/* Enable BKP CLK enable for backup registers */
                        #t#t__HAL_RCC_BKP_CLK_ENABLE();    
                        [#else]
                        #t#tLL_PWR_EnableBkUpAccess();
                        #t#t/* Enable BKP CLK enable for backup registers */
                        #t#tLL_APB1_GRP1_EnableClock(LL_APB1_GRP1_PERIPH_BKP);
                        [/#if]
                    [/#if]
                        #t#t/* ${ipName} clock enable */
                    [#list initService.clock?split(';') as clock]    
                        [#if ipvar.clkCommonResource.entrySet()?contains(clock?trim)]#t#t${clock?trim?replace("__","")?replace("_ENABLE","")}_ENABLED++;
                            #t#tif(${clock?trim?replace("__","")?replace("_ENABLE","")}_ENABLED==1){          
                            #t#t#t${clock?trim}();
                            [#if ipvar.clkCommonResource.entrySet()?contains(clock?trim)]#t#t}[/#if]  
                        [#else]
                           #t#t${clock?trim}();
                        [/#if]
                    [/#list]
                [/#if]
            [#else]
                #t#t/* ${ipName} clock enable */
                #t#t__HAL_RCC_${ipName}_CLK_ENABLE(); 
            [/#if]
        [/#if] [#-- if not I2C --]
    [#else]  [#-- serviceType = deInit --]     
        [#if initService.clock??]
            [#if initService.clock!="none"]
               #t#t/* Peripheral clock disable */
               [#list initService.clock?split(';') as clock]     
                    [#if ipvar.clkCommonResource.entrySet()?contains(clock?trim)]
                        [#if (ipvar.usedDriver == "HAL")]
                            #t#t${clock?trim?replace("__","")?replace("_ENABLE","")}_ENABLED--;
                            #t#tif(${clock?trim?replace("__","")?replace("_ENABLE","")}_ENABLED==0){                                    
                  #t#t#t${clock?replace("ENABLE","DISABLE")?trim}(); 
                            [#if (ipvar.usedDriver == "HAL") && ipvar.clkCommonResource.entrySet()?contains(clock?trim)]#t#t}[/#if]          
                            [#else]
                             #t#t/* Be sure that all peripheral instances that share the same clock need to be disabled */
                             #t#t/**#t${clock?trim?replace("__","")?replace("_ENABLE","")}_ENABLED--;
                             #t#t*#tif(${clock?trim?replace("__","")?replace("_ENABLE","")}_ENABLED==0){                                    
                             #t#t*#t#t${clock?replace("ENABLE","DISABLE")?trim}(); 
                             #t#t**/
                        [/#if]
                    [#else]
    #t#t${clock?replace("ENABLE","DISABLE")?trim}();
                    [/#if]
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
        [#if FamilyName=="STM32MP1"]
            [#-- if defined (CONFIG_MASTER_MODE) --]
        [/#if]
        #t[@generateConfigCode ipName=ipName type=serviceType serviceName="gpio" instHandler=instHandler tabN=tabN/]
[#if FamilyName=="STM32MP1"]
       [#-- #endif --]
    [/#if]
    [/#if]
[#-- if I2C clk_enable should be after GPIO Init Begin --]
    [#if serviceType=="Init" && (ipName?contains("I2C")||ipName?contains("USB"))] 
           [#if initService.clock??]
            [#if initService.clock!="none"]
               #t#t/* ${ipName} clock enable */
                [#list initService.clock?split(';') as clock]
                    [#if ipvar.clkCommonResource.entrySet()?contains(clock?trim)]#t#t${clock?trim?replace("__","")?replace("_ENABLE","")}_ENABLED++;
                    #t#tif(${clock?trim?replace("__","")?replace("_ENABLE","")}_ENABLED==1){          
                        #t#t#t${clock?trim}();
                    [#if ipvar.clkCommonResource.entrySet()?contains(clock?trim)]#t#t}[/#if]  
                    [#else]
                        #t#t${clock?trim}();
                    [/#if]        
                [/#list]
            [/#if]
            [#else]
                 #t#t/* ${ipName} clock enable */
                 #t#t__HAL_RCC_${ipName}_CLK_ENABLE(); 
           [/#if]
[/#if]
[#-- if I2C clk_enable should be after GPIO Init End --]    
[#if serviceType=="Init"] 
    [#if dmaExist]
#t[@generateConfigCode ipName=ipName type=serviceType serviceName="dma" instHandler=instHandler tabN=tabN/]
    [/#if]
[#-- bug 322189 Init--]
[#if ipName?contains("OTG_FS")&&FamilyName=="STM32L4"]
#n#t#t/* Enable VDDUSB */
  #t#tif(__HAL_RCC_PWR_IS_CLK_DISABLED())
  #t#t{
    #t#t#t__HAL_RCC_PWR_CLK_ENABLE();
    
    #t#t#tHAL_PWREx_EnableVddUSB();
    
    #t#t#t__HAL_RCC_PWR_CLK_DISABLE();
  #t#t}
  #t#telse
  #t#t{
    #t#t#tHAL_PWREx_EnableVddUSB();
  #t#t}
[/#if]
[#-- bug 322189 Init End--]
    [#if nvicExist]
        [#if initService??&&initService.nvic??&&initService.nvic?size>0]
          [#assign codeInMspInit = false]
          [#list initService.nvic as initVector]
            [#if initVector.codeInMspInit]
              [#assign codeInMspInit = true]
              [#break]
            [/#if]
          [/#list]
        [/#if]
        [#if initService.nvic??&&initService.nvic?size>0]
           [#if codeInMspInit || ipName?contains("USB")]
           [#-- Always generate comment for USB: it is not worth the trouble to compute when it is really needed --]
             #n#t#t/* ${ipName} interrupt Init */
           [/#if]
           [#if ipName?contains("USB")]
                [#-- WorkAround for USB low power and remap macro--]
                [#if USB_interruptRemapMacro??]
                  #t#t${USB_interruptRemapMacro};
                [/#if]
                [#list initService.nvic as initVector]
                  [#if !initVector.vector?contains("WKUP") && !initVector.vector?contains("WakeUp") && initVector.codeInMspInit]
                    #t#tHAL_NVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority}, ${initVector.subPriority});
                    #t#tHAL_NVIC_EnableIRQ(${initVector.vector});
                  [/#if]
                [/#list]
                [#assign lowPower = "no"]
                [#list initService.nvic as initVector]
                   [#if (instHandler=="pcdHandle") && (initVector.vector?contains("WKUP") || initVector.vector?contains("WakeUp") || (((initVector.vector == "USB_IRQn")||(initVector.vector == "OTG_FS_IRQn")||(initVector.vector == "USB_LP_IRQn")) && USB_INTERRUPT_WAKEUP??))]
                      [#assign lowPower = "yes"]
                   [/#if]
                [/#list]
                [#if lowPower == "yes"]
                  [#assign codeInMspInit = false]
                  [#assign wakeupVector = false]
                  [#list initService.nvic as initVector]
                      [#if initVector.vector?contains("WKUP") || initVector.vector?contains("WakeUp")]
                          [#assign wakeupVector = true]
                          [#if initVector.codeInMspInit]
                            [#assign codeInMspInit = true]
                            [#break]
                          [/#if]
                      [/#if]
                  [/#list]
                  [#-- Even if init code is in MX_NVIC_Init, if there is no specific USB wake-up interrupt, some code needs to be generated here --]
                  [#if codeInMspInit || !wakeupVector]
                    #t#tif(pcdHandle->Init.low_power_enable == 1)
                    #t#t{
                    [@common.generateUsbWakeUpInterrupt ipName=ipName tabN=3/]
                    [#list initService.nvic as initVector]
                       [#if initVector.vector?contains("WKUP") || initVector.vector?contains("WakeUp")]
                           #t#t#tHAL_NVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority}, ${initVector.subPriority});
                           #t#t#tHAL_NVIC_EnableIRQ(${initVector.vector});
                       [/#if]
                    [/#list]
                    #t#t}
                  [/#if]
                [/#if]
           [#else]
              [#list initService.nvic as initVector]
                [#if initVector.codeInMspInit]
                  #t#tHAL_NVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority}, ${initVector.subPriority});
                  #t#tHAL_NVIC_EnableIRQ(${initVector.vector});
                [/#if]
              [/#list]
           [/#if]
        [/#if]
    [/#if]
    [#else] [#-- else serviceType = DeInit --]
 [#assign service = getInitServiceMode(ipName)]
[#-- bug 322189 DeInit--]
[#if ipName?contains("OTG_FS")&&FamilyName=="STM32L4"]
#n#t#t/* Disable VDDUSB */
  #t#tif(__HAL_RCC_PWR_IS_CLK_DISABLED())
  #t#t{
    #t#t#t__HAL_RCC_PWR_CLK_ENABLE();
    
    #t#t#tHAL_PWREx_DisableVddUSB();
    
    #t#t#t__HAL_RCC_PWR_CLK_DISABLE();
  #t#t}
  #t#telse
  #t#t{
    #t#t#tHAL_PWREx_DisableVddUSB();
  #t#t}
[/#if]
[#-- bug 322189 DeInit End--]
    [#if dmaExist]
 [#assign dmaservice =service.dma]
 [#if dmaservice??]#n#t#t/* ${ipName} ${getDmaServiceType(dmaservice)} DeInit */
    [#list dmaservice as dmaconfig]
        [#assign dmaCurrentRequest = dmaconfig.instanceName?lower_case]
        [#assign prefixList = dmaCurrentRequest?split("_")]
        [#list prefixList as p][#assign prefix= p][/#list]
[#assign ind=""]
            [#--workAround DFSDM--]
            [#if dmaconfig.dmaRequestName?contains("DFSDM")]
                [#assign ind=dmaconfig.dmaRequestName?replace("DFSDM","")]
            [/#if]
        [#assign ipdmahandler1 = "hdma" + prefix]
         [#-- [#if getDmaHandler(ipName)!=""][#assign ipdmahandler = getDmaHandler(ipName)][#else][#assign ipdmahandler = ipdmahandler1][/#if]--]
           [#if dmaconfig.dmaHandel??][#assign ipdmahandler = dmaconfig.dmaHandel][#else][#assign ipdmahandler = ipdmahandler1][/#if]
                [#list dmaconfig.dmaHandel as dmaH]
                                #t#tHAL_${getDmaType(dmaconfig)}_DeInit(${instHandler}->${dmaH});
                            [/#list]
    [/#list] [#-- list dmaService as dmaconfig --]
[/#if]    
    [/#if] [#-- if DMA exist --]
[#-- DeInit NVIC if DeInit --]
    [#if service??&&service.nvic??&&nvicExist&&service.nvic?size>0]#n#t#t/* ${ipName} interrupt Deinit */[#--#n#t#tHAL_NVIC_DisableIRQ([#if service.nvic.vector??]${service.nvic.vector}[/#if]);--]
[#list service.nvic as initVector]                
               [#if initVector.shared=="false"]             
                #t#tHAL_NVIC_DisableIRQ(${initVector.vector});
                [#else]
#t/* USER CODE BEGIN ${ipName}:${initVector.vector} disable */
#t#t/**
#t#t* Uncomment the line below to disable the "${initVector.vector}" interrupt 
#t#t*        Be aware, disabling shared interrupt may affect other IPs
#t#t*/
#t#t/* HAL_NVIC_DisableIRQ(${initVector.vector}); */
#t/* USER CODE END ${ipName}:${initVector.vector} disable */
#n

                [/#if]
            [/#list]
    [/#if]

    [/#if]
[/#macro]
[#-- End macro add service code --]

[#assign initServicesList = {"test0":"test1"}]
[#-- Section1: Create the void mx_<IpInstance>_<HalMode>_init() function for each ip instance --]
[#compress]
[#-- Global variables --]
[#if IP.variables??]
[#list IP.variables as variable]
[#-- Tracker 276386 -- GetHandle Start --]
[#--${variable.value}* MX_${variable.name?substring(1)?upper_case}_GetHandle(void) {--]
[#--#treturn &${variable.name};--]
[#--}--]
[#-- Tracker 276386 -- GetHandle End --]
${variable.value} ${variable.name};
[/#list]
[#-- Add global dma Handler --]
[#list IP.configModelList as instanceData]
    [#if instanceData.dmaHandel??]
        [#list instanceData.dmaHandel as dHandle]
            ${dHandle};
        [/#list]
    [/#if]
[/#list]
[/#if]
[#-- CEC array --]
[@common.generateCecRxBuffer configModelList=IP.configModelList methodName="HAL_CEC_Init" argumentName="RxBuffer" bufferType="uint8_t" bufferSize="16"/]
[#-- Global variables --]#n
[#list IP.configModelList as instanceData]
[#if instanceData.isMWUsed=="false" && instanceData.isBusDriverUSed=="false"]
     [#assign instName = instanceData.instanceName]
        [#assign halMode= instanceData.halMode]
        /* ${instName} init function */
        [#if halMode!=instanceData.realIpName&&!instanceData.ipName?contains("TIM")&&!instanceData.ipName?contains("CEC")]#nvoid MX_${instName}_${halMode}_Init(void)[#else]void MX_${instName}_Init(void)[/#if]
{
        [#-- assign ipInstanceIndex = instName?replace(name,"")--]
        [#assign args = ""]
        [#assign listOfLocalVariables =""]
        [#assign resultList =""] 	
[@common.getLocalVariableList instanceData=instanceData/]      
#n      

[#if RESMGR_UTILITY??]
    [@common.optinclude name="Src/resmgrutility_"+instName+".tmp"/][#-- ADD RESMGR_UTILITY Code--]
[/#if]

[#-- if used Driver is LL --]
[#if instanceData.usedDriver?? && instanceData.usedDriver!="HAL"][#--Check if LL driver is used. instanceData:ConfigModel --]
    [#-- varaible declaration --]
    [#assign v = ""]
    [#if instanceData.initServices?? && instanceData.initServices.gpio?? ]
        [#assign service=instanceData.initServices.gpio]
           [#list service.variables as variable] [#-- variables declaration --]
               [#if v?contains(variable.name)]
               [#-- no matches--]
               [#else]
   #t${variable.value} ${variable.name} = {0};
                   [#assign v = v + " "+ variable.name/]	
               [/#if]	
           [/#list]  
    [/#if]

[#assign listOfLocalVariables =""]
    [#assign resultList =""]
[#if instanceData.initServices??]
    [#if instanceData.initServices.pclockConfig??]
        [#assign   pclockConfig=instanceData.initServices.pclockConfig] [#--list0--]
        [#list pclockConfig.configs as config] [#--list1--]
            [@common.getLocalVariable configModel1=config listOfLocalVariables=listOfLocalVariables resultList=resultList/]
            [#assign listOfLocalVariables =resultList]
        [/#list]
    [/#if]
[/#if]
#n
[#assign clockInst=""]

[#if instanceData.initServices??]
    [#if instanceData.initServices.pclockConfig??]
[#if FamilyName=="STM32MP1"]
#tif(IS_ENGINEERING_BOOT_MODE())
#t{
[#assign nTab=2]
[#else]
[#assign nTab=1]
[/#if]
[#assign   pclockConfig=instanceData.initServices.pclockConfig] [#--list0--]
[@common.generateConfigModelListCode configModel=pclockConfig inst=""  nTab=nTab index=""/]#n
[#if FamilyName=="STM32MP1"]
#t}
[/#if]
#n
    [/#if]
[/#if]

    [#-- if used with LL and MspPost init is required using gpioOut service --]
    [#if instanceData.initServices?? && instanceData.initServices.gpioOut?? ]
           [#assign service=instanceData.initServices.gpioOut]
           [#list service.variables as variable] [#-- variables declaration --]
               [#if v?contains(variable.name)]
               [#-- no matches--]
               [#else]
   #t${variable.value} ${variable.name} = {0};
                   [#assign v = v + " "+ variable.name/]	
               [/#if]	
           [/#list]  
    [/#if]
    [#-- Generate service code --]
    [@common.generateServiceCode ipName=instName serviceType="Init" modeName="mode" instHandler=instName tabN=1 IPData=instanceData/] 
[/#if]
        [#--list instanceData.configs as config--]
            [#if instanceData.instIndex??][@common.generateConfigModelListCode configModel=instanceData inst=instName  nTab=1 index=instanceData.instIndex/][#else][@common.generateConfigModelListCode configModel=instanceData inst=instName  nTab=1 index=""/][/#if]
        [#--/#list--]
[#-- MspPostInit callBack if needed for output gpio config --]
[#if instanceData.initServices??]
    [#if instanceData.initServices.gpioOut??]
        [#if instanceData.usedDriver?? && instanceData.usedDriver=="HAL"]
            [#assign ipName = instanceData.ipName]
            [#list instanceData.initCallBackInitMethodList as initCallBack]
                [#if initCallBack?contains("PostInit")]
                #t${initCallBack}([#if ipName?contains("TIM")&&!(ipName?contains("HRTIM")||ipName?contains("LPTIM"))]&htim[#else]&h${instanceData.realIpName?lower_case}[/#if]${instanceData.instIndex});
                [/#if]
            [/#list]
        [#else][#-- Else if LL is used gpio code should be generated --]
            [@generateConfigCode ipName=instName type="Init" serviceName="gpioOut" instHandler="Tim"?lower_case+"Handle" tabN=1/]  
        [/#if]
    [/#if]
[/#if]
[#-- MspPostInit End --]
#n}
  [/#if]
[/#list]

[/#compress]
[#-- Section1: END --]

[#if (name.contains("USB_OTG_"))&&(mspForSingleUSB=="true")||(!name.contains("USB_OTG_"))]
#n
[#if ipvar.usedDriver?contains("HAL") &&  ipvar.clkCommonResource??]
    [#list ipvar.clkCommonResource.entrySet() as entry]
static uint32_t ${entry.value}=0;
    [/#list]
[/#if]
[#-- Section2: Msp Init --]
[#if ipvar.initCallBacks??]
[#compress]
[#assign DFSDM_var = "false"]
[#list ipvar.initCallBacks.entrySet() as entry]#n
[#assign instanceList = entry.value]
[#assign mode=entry.key?replace("_MspInit","")?replace("MspInit","")?replace("_BspInit","")?replace("HAL_","")]

[#assign ipHandler = "h" + mode?lower_case]

[#if  mode?contains("DFSDM") && DFSDM_var == "false"]
[#assign n = 1]
    [#list instanceList as dfsdmInst]
        static uint32_t DFSDM${dfsdmInst?replace("DFSDM","")}_Init = 0;
        [#assign n = n + 1]
    [/#list]
[#assign DFSDM_var = "true"]
[/#if]
[#-- #nvoid HAL_${mode}_MspInit(${mode}_HandleTypeDef* h${mode?lower_case}){--] 
[#if name !="TIM"]
#nvoid ${entry.key}(${mode}_HandleTypeDef* ${mode?lower_case}Handle)
{#n
[#else]
#nvoid ${entry.key}(${name}_HandleTypeDef* ${mode?lower_case}Handle)
{
#n
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
[#-- #tstatic ${fargument.typeName} ${fargument.name}_${dmaRequest.instanceName?lower_case}; Should be global--]
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
#t${variable.value} ${variable.name} = {0};
                [#assign v = v + " "+ variable.name/]	
            [/#if]	
        [/#list]  
[/#if]
[/#list]
[#-- add local variables for HAL_DMAEx_ConfigMuxSync --]
[#if entry.key != "HAL_DFSDM_ChannelMspInit"]
  [#assign local_dma_variables = ""]
  [#list words as inst] [#-- loop on ip instance data --]
    [#assign services = getInitServiceMode(inst)]
    [#if services.dma??]
      [#assign dmaService = services.dma]
      [#list dmaService as dmaconfig]
        [#list dmaconfig.methods as method]
          [#list method.arguments as func_argument]
            [#if func_argument.genericType == "struct" && func_argument.context != "global"]
              [#if !list_contains(local_dma_variables, func_argument.name)]
                [#assign local_dma_variables = local_dma_variables + " " + func_argument.name]
#t${func_argument.typeName} ${func_argument.name}= {0};
              [/#if]
            [/#if]
          [/#list]
        [/#list]
      [/#list]
    [/#if]
  [/#list]
[/#if]
[#-- --]
[#if mspIsEmpty=="no"]
[#if IP.ipName==ipvar.ipName]

    [#assign listOfLocalVariables = ""]
    [#assign  resultList  = ""]
    [#list IP.configModelList as instanceData]
[#assign  halMode  = getHalMode(IP.ipName)]
        [#if instanceData.initServices??  && halMode==instanceData.halMode]
            [#if instanceData.initServices.pclockConfig??]

                [#list instanceData.initServices.pclockConfig.configs as config] [#--list1--]
                    [#assign listOfLocalVariables = getLocalVariableCLK(config)]
[#if listOfLocalVariables !="" ]
                    [#if resultList == ""]
                        [#list  listOfLocalVariables?split("/") as variable]
                            #t${variable} = {0};                            
                            [#if resultList == ""]
                                [#assign resultList = variable]
                            [#else]
                                [#assign resultList = resultList + ":"+ variable]
                            [/#if]
                        [/#list]
                    [#else]
                        [#list  listOfLocalVariables?split("/") as variable]                
                            [#assign  dup  = ""]
                            [#list  resultList?split(":") as v]
                                [#if v == variable]
                                    [#assign  dup  = "yes"]
                                [/#if]
                            [/#list]
                            [#if dup != "yes"]
                                #t${variable} = {0};
                                [#assign resultList = resultList + ":"+ variable]
                            [/#if]
                        [/#list]
                    [/#if]
[/#if]
                [/#list]
            [/#if]
        [/#if]
    [/#list]

[/#if]
    [#if  words[0]?contains("DFSDM")]
        [#assign word0 = words[0]]  
        [#if DIE == "DIE451" || DIE == "DIE449" || DIE == "DIE441" || DIE == "DIE450" || DIE == "DIE483" || DIE == "DIE500" || DIE == "DIE472" || FamilyName == "STM32L4"]
            #tif(${words[0]}_Init == 0)             
        [#else]
            #tif([#if word0.contains("DFSDM1")&& mode=="DFSDM_Channel"](IS_DFSDM1_CHANNEL_INSTANCE(${mode?lower_case}Handle->Instance))&&[/#if][#if word0.contains("DFSDM2")&& mode=="DFSDM_Channel"]!(IS_DFSDM1_CHANNEL_INSTANCE(${mode?lower_case}Handle->Instance))&&[/#if][#if word0.contains("DFSDM1")&& mode=="DFSDM_Filter"](IS_DFSDM1_FILTER_INSTANCE(${mode?lower_case}Handle->Instance))&&[/#if][#if word0.contains("DFSDM2")&& mode=="DFSDM_Filter"]!(IS_DFSDM1_FILTER_INSTANCE(${mode?lower_case}Handle->Instance))&&[/#if](${words[0]}_Init == 0)) 
        [/#if]
        #t{
   [#else]
        [#if ipvar.instanceNbre > 1] [#-- IF number of IP instances greater than 0--]
        #tif(${mode?lower_case}Handle->Instance==${words[0]?replace("I2S","SPI")})
        #t{
    [/#if]
    [/#if]

[#if words?size > 1] [#-- Check if there is more than one ip instance--]        
#t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspInit 0 */

#n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspInit 0 */

[#list IP.configModelList as instanceData]
[#if instanceData.initServices??]
    [#if instanceData.initServices.pclockConfig??]
[#assign   pclockConfig=instanceData.initServices.pclockConfig] [#--list0--]
[#if pclockConfig.ipName?replace("HDMI_CEC","CEC")==words[0]]
[#if FamilyName=="STM32MP1"]
#tif(IS_ENGINEERING_BOOT_MODE())
#t{
[/#if]
[@common.generateConfigModelListCode configModel=pclockConfig inst=words[0]  nTab=2 index=""/]#n
[#if FamilyName=="STM32MP1"]
#t}
[/#if]
[/#if]
#n
    [/#if]
[/#if]
[/#list]

    [@generateServiceCode ipName=words[0] serviceType="Init" modeName=mode instHandler=mode?lower_case+"Handle" tabN=2/] 
    [#if words[0]?contains("DFSDM")]
    [@generateServiceCodeDFSDM ipName=words[0] serviceType="DeInit" modeName=mode instHandler=mode?lower_case+"Handle" tabN=2/]
    [/#if]
#t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspInit 1 */

#n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspInit 1 */
[#if  words[0]?contains("DFSDM")]
#t${words[0]}_Init++;
[/#if]
#t} 

    [#assign i = 0]
    [#list words as inst]
    [#if i>0] 
    [#if  words[i]?contains("DFSDM")]
[#assign word0 = words[i]]  
        [#if DIE == "DIE451" || DIE == "DIE449" || DIE == "DIE441" || DIE == "DIE450" || DIE == "DIE483" || DIE == "DIE500" || DIE == "DIE472" || FamilyName == "STM32L4"]
            #tif(${words[0]}_Init == 0)             
        [#else]
            #telse if([#if word0.contains("DFSDM1")&& mode=="DFSDM_Channel"](IS_DFSDM1_CHANNEL_INSTANCE(${mode?lower_case}Handle->Instance))&&[/#if][#if word0.contains("DFSDM2")&& mode=="DFSDM_Channel"]!(IS_DFSDM1_CHANNEL_INSTANCE(${mode?lower_case}Handle->Instance))&&[/#if][#if word0.contains("DFSDM1")&& mode=="DFSDM_Filter"](IS_DFSDM1_FILTER_INSTANCE(${mode?lower_case}Handle->Instance))&&[/#if][#if word0.contains("DFSDM2")&& mode=="DFSDM_Filter"]!(IS_DFSDM1_FILTER_INSTANCE(${mode?lower_case}Handle->Instance))&&[/#if](${words[i]}_Init == 0))
        [/#if]
    [#else]
        #telse if(${mode?lower_case}Handle->Instance==${words[i]?replace("I2S","SPI")}) [#-- if I2S instance should be SPI--]
    [/#if]
    #t{
#t/* USER CODE BEGIN ${words[i]?replace("I2S","SPI")}_MspInit 0 */

#n#t/* USER CODE END ${words[i]?replace("I2S","SPI")}_MspInit 0 */

[#list IP.configModelList as instanceData]
[#if instanceData.initServices??]
    [#if instanceData.initServices.pclockConfig??]
[#assign   pclockConfig=instanceData.initServices.pclockConfig] [#--list0--]
[#if pclockConfig.ipName?replace("HDMI_CEC","CEC")==words[i]]
[#if FamilyName=="STM32MP1"]
#tif(IS_ENGINEERING_BOOT_MODE())
#t{
[/#if]
[@common.generateConfigModelListCode configModel=pclockConfig inst=words[i]  nTab=2 index=""/]#n
[#if FamilyName=="STM32MP1"]
#t}
[/#if]
[/#if]
#n
    [/#if]
[/#if]
[/#list]

        [@generateServiceCode ipName=words[i] serviceType="Init" modeName=mode instHandler=mode?lower_case+"Handle" tabN=2/] 
#t/* USER CODE BEGIN ${words[i]?replace("I2S","SPI")}_MspInit 1 */

#n#t/* USER CODE END ${words[i]?replace("I2S","SPI")}_MspInit 1 */
[#if  words[i]?contains("DFSDM")]
#t${words[i]}_Init++;
[/#if]
    #t}
        [/#if]
        [#assign i = i + 1]
    [/#list]
[#else]
    [#if words[0]??]
#t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspInit 0 */

#n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspInit 0 */

[#list IP.configModelList as instanceData]
[#if instanceData.initServices??]
    [#if instanceData.initServices.pclockConfig??]
[#assign   pclockConfig=instanceData.initServices.pclockConfig] [#--list0--]
[#if pclockConfig.ipName?replace("HDMI_CEC","CEC")==words[0]]
[#if FamilyName=="STM32MP1"]
#tif(IS_ENGINEERING_BOOT_MODE())
#t{
[/#if]
[@common.generateConfigModelListCode configModel=pclockConfig inst=words[0]  nTab=2 index=""/]#n
[#if FamilyName=="STM32MP1"]
#t}
[/#if]
[/#if]
#n
    [/#if]
[/#if]
[/#list]

    [@generateServiceCode ipName=words[0] serviceType="Init" modeName=mode instHandler=mode?lower_case+"Handle" tabN=2/] 
#t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspInit 1 */

#n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspInit 1 */
[#if  words[0]?contains("DFSDM")]
#t${words[0]}_Init++;
[/#if]
    [/#if]
[#if ipvar.instanceNbre > 1 || words[0]?contains("DFSDM")] [#-- IF number of IP instances greater than 0--]
#t}
[/#if]
[/#if]
[/#if] [#-- inist not empty --]
[#list words as inst] [#-- DMA code for DFSDM --]
[#if  inst.contains("DFSDM")]
[@generateServiceCodeDFSDM ipName=inst serviceType="Init" modeName=mode instHandler=mode?lower_case+"Handle" tabN=2/]
[/#if]
[/#list]
}
[#--break--] [#-- use the first msp--]
[/#list]
[/#compress]
[/#if]
[#-- Section2:End --]
[#-- Section2-1: MspPost Init --]
[#if ipvar.initCallBacks??]
[#compress]
[#assign DFSDM_var = "false"]
[#assign instanceList = ipvar.instListForHALPostInit]

[#--assign mode=entry.key?replace("_MspInit","")?replace("MspInit","")?replace("_BspInit","")?replace("HAL_","")--]
[#assign mode=ipvar.ipName]
[#assign usedDriverFlag = ""]
[#list ipvar.configModelList as instanceData]
    [#if instanceData.usedDriver?? && instanceData.usedDriver == "LL"]
        [#assign usedDriverFlag = usedDriverFlag+" LL"]    
    [#else]
        [#assign usedDriverFlag = usedDriverFlag+" HAL"]     
    [/#if]
    
[/#list]
       
[#assign ipHandler = "h" + mode?lower_case]
[#--Check if the Msp init will be empty start--] 
    [#assign mspIsEmpty1="yes"] 
    [#list instanceList as inst]
     [#if getInitServiceMode(inst)??]
        [#assign services = getInitServiceMode(inst)]
        [#if services?? && (services!="") && (services.gpioOut??)&& usedDriverFlag?contains("HAL")]
            [#assign mspIsEmpty1="no"] 
            [#break]
        [/#if]
     [/#if]
    [/#list]
[#-- Check if the Msp init will be empty end -- ]
[#if  mode?contains("DFSDM") && DFSDM_var == "false"]
uint32_t DFSDM1_Init = 0;
[#assign DFSDM_var = "true"]
[/#if]

[#-- #nvoid HAL_${mode}_MspInit(${mode}_HandleTypeDef* h${mode?lower_case}){--] 
[#if (mspIsEmpty1=="no")&&(mode!="TIM")]
    #n#nvoid HAL_${mode}_MspPostInit(${mode}_HandleTypeDef* ${mode?lower_case}Handle)
    {
    #n
[#else]
    [#if (mspIsEmpty1=="no")]
        #nvoid HAL_${mode}_MspPostInit(TIM_HandleTypeDef* ${mode?lower_case}Handle)
        {
        #n
    [/#if]
[/#if]

[#assign words = instanceList]
[#assign wordsForPostInit = "["]
[#if (mspIsEmpty1=="no")]
    [#-- declare Variable GPIO_InitTypeDef once --]
           [#assign v = ""]
    [#assign mspExist="false"]
    [#list words as inst] [#-- loop on ip instances datas --] 
        [#assign services = getInitServiceMode(inst)]
        [#if services?? && services!="" && services.gpioOut??][#assign service=services.gpioOut]
               [#list service.variables as variable] [#-- variables declaration --]
                   [#if v?contains(variable.name)]
                   [#-- no matches--]
                   [#else]
       #t${variable.value} ${variable.name} = {0};
                       [#assign v = v + " "+ variable.name/]	
                   [/#if]	
               [/#list]  
       [/#if]
    [/#list]
[/#if]
[#-- --]
[#if mspIsEmpty1=="no"]
[#if  words[0]?contains("DFSDM")]
[#assign word0 = words[0]]  
    [#if DIE == "DIE451" || DIE == "DIE449" || DIE == "DIE441" || DIE == "DIE450" || DIE == "DIE483" || DIE == "DIE500" || DIE == "DIE472" || FamilyName == "STM32L4"]
        #tif(${words[0]}_Init == 0)             
    [#else]
        #tif([#if word0.contains("DFSDM1")&& mode=="DFSDM_Channel"](IS_DFSDM1_CHANNEL_INSTANCE(${mode?lower_case}Handle->Instance))&&[/#if][#if word0.contains("DFSDM2")&& mode=="DFSDM_Channel"]!(IS_DFSDM1_CHANNEL_INSTANCE(${mode?lower_case}Handle->Instance))&&[/#if][#if word0.contains("DFSDM1")&& mode=="DFSDM_Filter"](IS_DFSDM1_FILTER_INSTANCE(${mode?lower_case}Handle->Instance))&&[/#if][#if word0.contains("DFSDM2")&& mode=="DFSDM_Filter"]!(IS_DFSDM1_FILTER_INSTANCE(${mode?lower_case}Handle->Instance))&&[/#if](${words[0]}_Init == 0))
    [/#if]
        #t{
[#else]
    [#if ipvar.instanceNbre >  1 ] [#-- IF number of IP instances greater than 0--]
 #tif(${mode?lower_case}Handle->Instance==${words[0]?replace("I2S","SPI")})
        #t{
    [/#if]
[/#if]

[#if words?size > 1] [#-- Check if there is more than one ip instance--]    
#t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspPostInit 0 */

#n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspPostInit 0 */    
        [@generateConfigCode ipName=words[0] type="Init" serviceName="gpioOut" instHandler=mode?lower_case+"Handle" tabN=2/]  
#t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspPostInit 1 */

#n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspPostInit 1 */   
    #t} 
    [#assign i = 0]
    [#list words as inst]
    [#if i>0]    
    #telse if(${mode?lower_case}Handle->Instance==${words[i]?replace("I2S","SPI")})
    #t{
#t/* USER CODE BEGIN ${words[i]?replace("I2S","SPI")}_MspPostInit 0 */

#n#t/* USER CODE END ${words[i]?replace("I2S","SPI")}_MspPostInit 0 */
       #t[@generateConfigCode ipName=words[i] type="Init" serviceName="gpioOut" instHandler=mode?lower_case+"Handle" tabN=2/] 
#t/* USER CODE BEGIN ${words[i]?replace("I2S","SPI")}_MspPostInit 1 */

#n#t/* USER CODE END ${words[i]?replace("I2S","SPI")}_MspPostInit 1 */    
#t}
        [/#if]
        [#assign i = i + 1]
    [/#list]
[#else]
    [#if words[0]??]
    #t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspPostInit 0 */

    #n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspPostInit 0 */
    #t[@generateConfigCode ipName=words[0] type="Init" serviceName="gpioOut" instHandler=mode?lower_case+"Handle" tabN=2/]

    #t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspPostInit 1 */

    #n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspPostInit 1 */
    [/#if]
    [#if ipvar.instanceNbre >  1 || words[0]?contains("DFSDM")] [#-- IF number of IP instances greater than 0--]    
        #t}
    [/#if]
[/#if]

#n}#n
[/#if] [#-- mspIsEmpty1=="no" --]
[#--break--] [#-- use the first msp--]

[/#compress]
[/#if]
[#-- Section2-1:End --]
[#-- --]

[#if ipvar.deInitCallBacks??]
[#compress]
[#list ipvar.deInitCallBacks.entrySet() as entry]#n
[#assign instanceList = entry.value]
[#assign mode=entry.key?replace("_MspDeInit","")?replace("MspDeInit","")?replace("_BspDeInit","")?replace("HAL_","")]
[#assign ipHandler = "h" + mode?lower_case]
[#if name !="TIM"]
#nvoid ${entry.key}(${mode}_HandleTypeDef* ${mode?lower_case}Handle)
{#n
[#else]
#nvoid ${entry.key}(${name}_HandleTypeDef* ${mode?lower_case}Handle)
{#n
[/#if]
#n
[#if mspIsEmpty=="no"]
[#assign words = instanceList]
[#if words[0]?contains("DFSDM")]
[#assign word0 = words[0]] 
    [#if DIE == "DIE451" || DIE == "DIE449" || DIE == "DIE441" || DIE == "DIE450" || DIE == "DIE483" || DIE == "DIE500" || DIE == "DIE472" || FamilyName == "STM32L4"]
        #t${words[0]}_Init-- ;
        #tif(${words[0]}_Init == 0)           
    [#else]
        #tif([#if word0.contains("DFSDM1")&& mode=="DFSDM_Channel"](IS_DFSDM1_CHANNEL_INSTANCE(${mode?lower_case}Handle->Instance))[/#if][#if word0.contains("DFSDM2")&& mode=="DFSDM_Channel"]!(IS_DFSDM1_CHANNEL_INSTANCE(${mode?lower_case}Handle->Instance))[/#if][#if word0.contains("DFSDM1")&& mode=="DFSDM_Filter"](IS_DFSDM1_FILTER_INSTANCE(${mode?lower_case}Handle->Instance))[/#if][#if word0.contains("DFSDM2")&& mode=="DFSDM_Filter"]!(IS_DFSDM1_FILTER_INSTANCE(${mode?lower_case}Handle->Instance))[/#if])
        #t{    
        #t#t${words[0]}_Init-- ;
        #t#tif((${words[0]}_Init == 0))
    [/#if]
    [#if DIE == "DIE451" || DIE == "DIE449" || DIE == "DIE441" || DIE == "DIE450" || DIE == "DIE500" || FamilyName == "STM32L4"]
    [#else]
        
    [/#if]
    #t#t{
[#else]
        [#if ipvar.instanceNbre >  1 ] [#-- IF number of IP instances greater than 0--]
            #tif(${mode?lower_case}Handle->Instance==${words[0]?replace("I2S","SPI")})
            #t{
        [/#if]
[/#if]

[#if words?size > 1] [#-- Check if there is more than one ip instance--]
 [#assign deInitService = getDeInitServiceMode(words[0])]    
#t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspDeInit 0 */

#n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspDeInit 0 */
[@generateServiceCode ipName=words[0] serviceType="DeInit" modeName=mode instHandler=mode?lower_case+"Handle" tabN=2/]
#t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspDeInit 1 */

#n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspDeInit 1 */
[#if words[0]?contains("DFSDM") &&(DIE != "DIE451" && DIE != "DIE449" && DIE != "DIE441" && DIE != "DIE450" && DIE != "DIE483" && DIE != "DIE500" && DIE != "DIE472" && FamilyName != "STM32L4" )]
#t#t}
[/#if]
#t}
  [#assign i = 0]
    [#list words as inst]
        [#if i>0]
[#if words[i]?contains("DFSDM")]
[#assign word0 = words[i]]  
    [#if DIE == "DIE451" || DIE == "DIE449" || DIE == "DIE441" || DIE == "DIE450" || DIE == "DIE483" || DIE == "DIE500" || DIE == "DIE472" || FamilyName == "STM32L4"]        
    [#else]        
        #telse if([#if word0.contains("DFSDM1")&& mode=="DFSDM_Channel"](IS_DFSDM1_CHANNEL_INSTANCE(${mode?lower_case}Handle->Instance))[/#if][#if word0.contains("DFSDM2")&& mode=="DFSDM_Channel"]!(IS_DFSDM1_CHANNEL_INSTANCE(${mode?lower_case}Handle->Instance))[/#if][#if word0.contains("DFSDM1")&& mode=="DFSDM_Filter"](IS_DFSDM1_FILTER_INSTANCE(${mode?lower_case}Handle->Instance))[/#if][#if word0.contains("DFSDM2")&& mode=="DFSDM_Filter"]!(IS_DFSDM1_FILTER_INSTANCE(${mode?lower_case}Handle->Instance))[/#if])
        #t{
    [/#if] 
#t#t${words[i]}_Init-- ;
#t#tif((${words[i]}_Init == 0))
[#else]
#telse if(${mode?lower_case}Handle->Instance==${words[i]?replace("I2S","SPI")})
[/#if]
[#if words[i]?contains("DFSDM")]
#t#t{
[#else]
#t{
[/#if]
#t/* USER CODE BEGIN ${words[i]?replace("I2S","SPI")}_MspDeInit 0 */

#n#t/* USER CODE END ${words[i]?replace("I2S","SPI")}_MspDeInit 0 */    
[@generateServiceCode ipName=words[i] serviceType="DeInit" modeName=mode instHandler=mode?lower_case+"Handle" tabN=2/] 
[#if words[i]?contains("DFSDM")]
[@generateServiceCodeDFSDM ipName=words[i] serviceType="DeInit" modeName=mode instHandler=mode?lower_case+"Handle" tabN=2/]
[/#if]
#t/* USER CODE BEGIN ${words[i]?replace("I2S","SPI")}_MspDeInit 1 */

#n#t/* USER CODE END ${words[i]?replace("I2S","SPI")}_MspDeInit 1 */
[#if words[i]?contains("DFSDM") &&(DIE != "DIE451" && DIE != "DIE449" && DIE != "DIE441" && DIE != "DIE450" && DIE != "DIE483" && DIE != "DIE500" && DIE != "DIE472" && FamilyName != "STM32L4" )]
#t#t}
[/#if]
#t}
        [/#if]
        [#assign i = i + 1]
    [/#list]
[#else]
    [#-- only one ip instance ${instanceList}--]
[#if words[0]??]
#t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspDeInit 0 */

#n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspDeInit 0 */
[@generateServiceCode ipName=words[0] serviceType="DeInit" modeName=mode instHandler=mode?lower_case+"Handle" tabN=2/] 

[#if words[0]?contains("DFSDM")]
[@generateServiceCodeDFSDM ipName=words[0] serviceType="DeInit" modeName=mode instHandler=mode?lower_case+"Handle" tabN=2/]
[/#if]
[#if ipvar.instanceNbre >  1 || words[0]?contains("DFSDM")] [#-- IF number of IP instances greater than 0--]
[#--t}--]
[/#if]
#t/* USER CODE BEGIN ${words[0]?replace("I2S","SPI")}_MspDeInit 1 */

#n#t/* USER CODE END ${words[0]?replace("I2S","SPI")}_MspDeInit 1 */
[#if words[0]?contains("DFSDM")&&(DIE != "DIE451" && DIE != "DIE449" && DIE != "DIE441" && DIE != "DIE450" && DIE != "DIE483" && DIE != "DIE500" && DIE != "DIE472" && FamilyName!="STM32L4")]
#t#t}
[/#if]
[/#if]
[#if ipvar.instanceNbre >  1 || words[0]?contains("DFSDM")] [#-- IF number of IP instances greater than 0--]
#t}
[/#if]
[/#if]
[/#if]
}
[#--break--] [#-- use the first msp--]
[/#list][#--list ipvar.deInitCallBacks.entrySet() as entry--]
[/#compress]
[/#if][#--if ipvar.deInitCallBacks??--]

[#-- Section3: End --]
[/#if] [#-- (name.contains("USB_OTG_")&&(mspForSingleUSB=="true")--]

[/#list]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
