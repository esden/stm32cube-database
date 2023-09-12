[#ftl]
[#function getQueueInfo(queueName,keyName)]
    [#if Inputs??]
        [#list Inputs as inData]
            [#list inData.entrySet() as entry]
                [#if entry.key==keyName]
                    [#assign val = entry.value]
                    [#if  val[queueName]??]
                        [#return val[queueName]]
                    [/#if]
                [/#if]
            [/#list]
        [/#list]
        [#return ""]
    [/#if]   
    [#return ""]
[/#function]
/* USER CODE BEGIN Header */
/**
  **********************************************************************************************************************
  * @file   lpbam_${LPBAM_NAME?replace(" ","_")?lower_case}_${ScenarioName?lower_case}_build.c
  * @author MCD Application Team
  * @brief  Provides LPBAM ${LPBAM_NAME} application ${ScenarioName} scenario build services
  **********************************************************************************************************************
  * @attention
  *
  * Copyright (c) ${year} STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  **********************************************************************************************************************
  */
/* USER CODE END Header */
/* Includes ----------------------------------------------------------------------------------------------------------*/
#include "lpbam_${LPBAM_NAME?replace(" ","_")?lower_case}.h"
[#if Queues??]
#n
/* Private variables -------------------------------------------------------------------------------------------------*/
/* LPBAM variables declaration */
    [#list Queues as QName]       
        [#assign Descriptors = getQueueInfo(QName, "FunctionDescriptors")]
        [#if Descriptors?? && Descriptors?is_enumerable] 
            [#list Descriptors as descr]
                [#if descr!=""]
static ${descr};
                [/#if]
            [/#list]
        [#else]
            [#if Descriptors?? && Descriptors!=""]
static ${Descriptors};
            [/#if]
        [/#if]
    [/#list]
#n
/* Exported variables ------------------------------------------------------------------------------------------------*/
/* LPBAM queues declaration */
[#list Queues as QName]
    [#assign Descriptors = getQueueInfo(QName, "FunctionDescriptors")]
    [#assign CoupledQueueName = getQueueInfo(QName, "CoupledQueueInfoMap")]
    [#if Descriptors?? && Descriptors!=""][#--if queue is empty --]
DMA_QListTypeDef ${QName?replace(" ","_")}_Q;
    [/#if]
    [#--[#if CoupledQueueName??]--]
        [#--[#list CoupledQueueName as CQueue]--]
[#--DMA_QListTypeDef ${CQueue}_Q;--]
    [#--    [/#list]--]
    [#--[/#if] --]
[/#list]
[/#if]
#n
/* External variables ------------------------------------------------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */
#n
/* Private function prototypes ---------------------------------------------------------------------------------------*/
[#if Queues??]
[#list Queues as QName]
    [#assign Descriptors = getQueueInfo(QName, "FunctionDescriptors")]
    [#if Descriptors?? && Descriptors!="" && (!QName?starts_with("Coupled_"))][#--if queue is empty --]
static void MX_${QName?replace(" ","_")}_Q_Build(void);
    [/#if]
[/#list]
[/#if]
#n
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */
[#if Queues??]
#n
/* Exported functions ------------------------------------------------------------------------------------------------*/
[#compress]
/**
#t* @brief  ${LPBAM_NAME} application ${ScenarioName} scenario build
#t* @param  None
#t* @retval None
#t*/
void MX_${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Build(void)
{
#t/* USER CODE BEGIN ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Build 0 */
#n#t/* USER CODE END ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Build 0 */
#n
[#list Queues as QName]
[#assign Descriptors = getQueueInfo(QName, "FunctionDescriptors")]
[#if Descriptors?? && Descriptors!="" && (!QName?starts_with("Coupled_"))] [#--if queue is empty --]
#t/* LPBAM build ${QName} queue */
#tMX_${QName?replace(" ","_")}_Q_Build();
[/#if]
[/#list]
#n
#t/* USER CODE BEGIN ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Build 1 */
#n#t/* USER CODE END ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Build 1 */
}
[/#compress]
[/#if]
[#if Queues??]
#n
#n
/* Private functions -------------------------------------------------------------------------------------------------*/
[#list Queues as QName]
[#assign Descriptors = getQueueInfo(QName, "FunctionDescriptors")]
[#assign CoupledQueueNameTest = getQueueInfo(QName, "CoupledQueueInfoMap")]
[#if (Descriptors?? && Descriptors!="") && (!QName?starts_with("Coupled_"))] [#--if queue is empty --]
/**
  * @brief  ${LPBAM_NAME} application ${ScenarioName} scenario ${QName} queue build
  * @param  None
  * @retval None
  */
static void MX_${QName?replace(" ","_")}_Q_Build(void)
{
#t/* LPBAM build variable */
[#-- LOCAL VARIABLES --]
[#compress]
[#assign PeriphConfigModels = getQueueInfo(QName, "IPConfigModel")]
[#if PeriphConfigModels??]
[#assign myListOfLocalVariables =""]
    [#list PeriphConfigModels as IP]
        [#list IP.configModelList as instanceData]
               [#assign args = ""]
                [#assign listOfLocalVariables =""]
                [#assign resultList =""]
        [@getLocalVariableList instanceData=instanceData/]
        [/#list]
    [/#list]
[/#if]
[#-- Function indx config --]
[#assign I2CTransferUsed = getQueueInfo(QName, "I2CTransferUsed")]
[#if I2CTransferUsed?? && I2CTransferUsed == "true"]
[#-- I2C special variables --]
#tuint32_t data_size = 0;
#tuint32_t transfer_idx = 0;
#n
[#else]
#n
[/#if]
[#if PeriphConfigModels??]
[#assign listofDeclaration = ""]
    [#list PeriphConfigModels as IP] 
[#if IP.comments??]
#t/**
#t#t* ${IP.comments} 
#t#t*/
[/#if]
        [#list IP.configModelList as instanceData]
                [#assign args = ""]
                [#assign listOfLocalVariables =""]
                [#assign resultList =""]
[#assign instName = instanceData.instanceName]
        [#if instanceData.instIndex??][@generateConfigModelListCode configModel=instanceData inst=instName  nTab=1 index=instanceData.instIndex/][#else][@generateConfigModelListCode configModel=instanceData inst=instName  nTab=1 index=""/][/#if]
        [/#list]
#n
    [/#list]
[/#if]
[/#compress]
[#assign circularM = getQueueInfo(QName, "circularModes")]

[#assign circularNodeD = getQueueInfo(QName, "circularNodeDescriptor")]
[#assign CoupledCircularNodeD = getQueueInfo("Coupled_"+QName, "circularNodeDescriptor")]
[#if circularM == "true" && circularNodeD!=""]
    [#assign circularData = getQueueInfo(QName, "circularNodeInfo")]
    [#assign circularNode = "CircularNode"]
    [#if circularData?? && circularData!=""]
        [#assign circularNode = circularData[circularNode]]
    [/#if]
    [#assign CoupledCircularData = getQueueInfo("Coupled_"+QName, "circularNodeInfo")]
    [#assign CoupledcircularNode = "CircularNode"]
    [#if circularData?? && CoupledCircularData?? && CoupledCircularData!="" && CoupledCircularData[CoupledcircularNode]??]
        [#assign CoupledCircularNode = CoupledCircularData[CoupledcircularNode]]
    [/#if]
    [#compress]  
#n#t/**
#t#t* Set circular mode
#t#t*/
    #tif (ADV_LPBAM_Q_SetCircularMode(&${circularNodeD}, ${circularNode}, &${QName?replace(" ","_")}_Q) != LPBAM_OK)
    #t{
    #t#tError_Handler();
    #t}
[#if circularData?? && CoupledCircularData?? && CoupledCircularData!="" && CoupledCircularData[CoupledcircularNode]??]
#n#t/**
#t#t* Set circular mode
#t#t*/
    #tif (ADV_LPBAM_Q_SetCircularMode(&${CoupledCircularNodeD}, ${CoupledCircularNode}, &Coupled_${QName?replace(" ","_")}_Q) != LPBAM_OK)
    #t{
    #t#tError_Handler();
    #t}
[/#if]
    [/#compress]
[/#if]
#n}
[/#if]
[/#list]
[/#if]
#n
/* USER CODE BEGIN ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Build */

/* USER CODE END ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Build */
[#-- macro getLocalVariableList of a config Start--]
[#macro getLocalVariableList instanceData]
[#--assign myListOfLocalVariables =""--]
[#list instanceData.configs as configModel1]
    [#if configModel1.methods??] 
        [#assign methodList1 = configModel1.methods]
    [#else] [#assign methodList1 = configModel1.libMethod]
    [/#if]
    [#list methodList1 as method][#-- list methodList1 --][#if method.arguments?? && method.status!="WARNING"]
        [#list method.arguments as argument][#-- list method.arguments --]
            [#if argument.genericType == "struct" && argument.typeName != "DONTCARE"][#-- if struct --]
                [#assign ll= myListOfLocalVariables?split(" ")]
                [#assign exist=false]
                [#list ll as var  ]
                    [#if argument.name?? && var==argument.name]
                        [#assign exist=true]
                    [/#if]
                [/#list]
                [#if argument.context?? && argument.typeName != "DONTCARE"][#-- if argument.context?? --]
                    [#if argument.name?? && argument.context!="global"&&argument.status!="WARNING"&&argument.status!="NULL"] [#-- if !global --]
                    [#assign varName= " "+argument.name]  
                    [#if !myListOfLocalVariables?contains(argument.name) && !argument.typeName?ends_with("Desc_t") && !argument.name?ends_with("Desc") && !argument.typeName?ends_with("DMA_QListTypeDef")]  [#-- if exist --]                  
                    #t${argument.typeName} ${argument.name} = {0};
                      [#assign myListOfLocalVariables = myListOfLocalVariables + " "+ argument.name]
                      [#assign resultList = myListOfLocalVariables]
                    [/#if][#-- if exist --]
                    [/#if][#-- if global --]
                [#else][#-- if context?? --]
                    [#if !exist && argument.typeName != "DONTCARE"]  [#-- if exist --]                  
                    #t${argument.typeName} ${argument.name} = {0};
                      [#assign myListOfLocalVariables = myListOfLocalVariables + " "+ argument.name]
                      [#assign resultList = myListOfLocalVariables]
                    [/#if][#-- if exist --]
                [/#if][#-- if argument.context?? --]
[#if configModel1.ipName!="ETH"]
            [#-- Array type --]
            [#list argument.argument as subArg] [#-- list subArg --]
                [#if subArg.genericType=="Array" && subArg.context!="globalConst" && sunArg.context!="globalInit"] [#-- if genericType == "Array" --] 
                    ${subArg.typeName} ${subArg.name}[${subArg.arraySize}] ; 
                [/#if] [#-- if genericType == "Array" --]
                [#if subArg.genericType =="struct"]
                    [#-- array inside struct is not considered as an array but as values
                    [#list subArg.argument as subArg1] [#-- list subArg1 -]
                        [#if subArg1.genericType=="Array" && subArg1.context!="globalConst" && subArg.context!="globalInit"] [#-- if genericType == "Array" -]
                            [#if subArg1.value?? && subArg1.value!="__NULL"]
                                #t ${subArg1.typeName} ${subArg1.name}[${subArg1.arraySize}] ; 
                            [/#if]
                        [/#if] [#-- if genericType == "Array" -]
                    [/#list]
                    --]
                [/#if]
            [/#list] [#-- list subArg --]
[/#if]
                [#if configModel1.ipName=="ETH"]
                    [#-- Array type --]
                     [#list argument.argument as subArg] [#-- list subArg --]
                         [#if subArg.genericType=="Array"] [#-- if genericType == "Array" --]
                             ${subArg.typeName} ${subArg.name}[${subArg.arraySize}] ; 
                         [/#if] [#-- if genericType == "Array" --]
                         [#if subArg.genericType =="struct"]
                             [#list subArg.argument as subArg1] [#-- list subArg1 --]
                                 [#if subArg1.genericType=="Array"] [#-- if genericType == "Array" --]
                                    #t static ${subArg1.typeName} ${subArg1.name}[${subArg1.arraySize}]; 
                                 [/#if] [#-- if genericType == "Array" --]
                             [/#list]
                         [/#if]
                     [/#list] [#-- list subArg --]
		[/#if]
           [#else][#-- if non struct --]
                [#if argument.genericType=="Array"] [#-- if genericType == "Array" --]
                    #t${argument.typeName} ${argument.name}[${argument.arraySize}] ; 
                [#else]
                        [#if argument.context?? || argument.typeName != "DONTCARE"][#-- if argument.context?? --]
                        [#else][#-- if context?? --]
                        #t${argument.typeName} ${argument.name} = {0}; 
                        [/#if]
                [/#if][#-- if genericType == "Array" --]
            [/#if][#-- if struct --]
        [/#list][#-- list method.arguments --]
        [/#if]
    [/#list][#-- list methodList1 --]
[/#list]
[/#macro]
[#-- macro getLocalVariableList of a config End--]
[#macro generateConfigModelListCode configModel inst nTab index]
[#--assign listofDeclaration = ""--]
[#compress]
[#assign listofCalledMethod = ""]
[#list configModel.configs as config]
[#assign bz36245=false]
[#if config.methods??] [#-- if the pin configuration contains a list of LibMethods--]
    [#assign methodList = config.methods]
[#else] [#assign methodList = config.libMethod]
[/#if]
[#assign writeConfigComments=false]
[#list methodList as method]
    [#if method.status=="OK"][#assign writeConfigComments=true][/#if]
[/#list]
[#if writeConfigComments]
[#if config.ipName?contains("CORTEX")]
[#if config.comments?? && config.comments!=""]#n#t/*#n #t* ${config.comments}#n#t */[/#if]
[#else]
[#if config.comments?? && config.comments!=""]#n#t/*#n #t* ${config.comments?replace("#t","#t")}#n#t */[/#if]
[/#if]
[/#if]
    [#list methodList as method][#assign args = ""]
            [#if method.hardCode??][#-- Hard code --]
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
[#if fargument.refMethod??][#-- CallLibMethod for Argument value --]
    [#assign argumentValue=""]
    [@callLibMethod CLmethod=fargument.refMethod configModelRef=configModel instRef=inst nTabRef=nTab indexRef=index argumentValue=argumentValue/]
    [#assign arg = argumentValue]
    [#if args == "" && arg!=""][#assign args = args + arg ][#else][#if arg!=""][#assign args = args + ', ' + arg][/#if][/#if]
[/#if] [#-- end if fargument.refMethod??--][#-- New --]
                    [#if fargument.addressOf] [#assign adr = "&"][#else ][#assign adr = ""][/#if]
                    [#if fargument.cast??] [#assign adr = fargument.cast + adr][/#if][/#compress]
                    [#if fargument.genericType == "struct" && fargument.argumentReference == "RefParameter"]
                        [#if fargument.optional == "output"]
                                [#assign arg = "" + adr + fargument.name]
                                [#if fargument.cast??][#assign arg = fargument.cast + arg][/#if]
                        [/#if]
                        [#if fargument.context?? && fargument.optional!="output"]
                            [#if fargument.context=="global"]
                                [#if config.ipName=="DMA" || config.ipName=="BDMA"]
                                    [#assign instanceIndex = "_"+ config.dmaRequestName?lower_case]
                                [#else]
                                    [#if config.ipName?starts_with("GPDMA") || config.ipName?starts_with("LPDMA")]
                                        [#assign instanceIndex = ""]
                                   [#else]
                                        [#-- [#assign instanceIndex = instRef?replace(name,"")]--]
                                        [#if index??][#assign instanceIndex = index][#else][#if name??][#assign instanceIndex = inst?replace(name,"")][/#if][/#if]
                                                     [#if configModel.ipName=="DFSDM" || configModel.ipName=="MDF" || configModel.ipName=="ADF"]
                                                         [#assign instanceIndex = ""]
                                                     [/#if]
                                        [/#if]
                                    [/#if]
                            [/#if]
                        [/#if]
                        [#if instanceIndex??&&fargument.context=="global" && fargument.optional!="output"][#if fargument.status!="NULL"][#assign arg = "" + adr + fargument.name + instanceIndex][#else][#assign arg = "NULL"][/#if][#else][#if  fargument.status!="NULL"][#assign arg = "" + adr + fargument.name][#else][#assign arg = "NULL"][/#if][/#if]
                        [#-- [#assign arg = "" + adr + fargument.name] --]
                        [#if ((!method.name?contains("Init")&&fargument.context=="global")||(fargument.optional=="output"))]
                        [#-- MDF : if ((!(fargument.context=="global"))||(fargument.optional=="output"))--]
                        [#else]
                            [#assign index1 =1] [#-- index of argument struct level1 --]
                        [#list fargument.argument as argument]
                            [#if argument.genericType != "struct"]
                                [#if argument.mandatory && !argument.refMethod??] 
                                [#if argument.value?? && argument.value!="__NULL"]
                                    [#if instanceIndex??&&fargument.context=="global" && fargument.optional!="output"]
                                        [#assign argValue=argument.value?replace("$Index",instanceIndex)]
                                    [#else]
                                        [#assign argValue=argument.value]
                                    [/#if][#-- if global --]
                                    [#-- Bz40086 - Begin tweak of the value in case of ADC --]
[#if ((config.name == "ADC_RegularChannelConfig" && (FamilyName!="STM32G0" || FamilyName!="STM32WL") ) || config.name == "ADC_InjectedChannelConfig" ||  ((FamilyName=="STM32G0" || FamilyName=="STM32WL" || FamilyName=="STM32U5") && config.name == "ADC_RegularChannelRankConfig")) && (FamilyName!="STM32F0" && FamilyName!="STM32L0" && FamilyName!="STM32F2" && FamilyName!="STM32F4")]                                        [#list argument?keys as k]
                                            [#if k == "name" && !(argument.value)?starts_with("ADC")]
                                                [#if argument[k] == "Rank"]                                                 
                                                    [#assign argValue="ADC_REGULAR_RANK_"+argument.value]
                                                [#elseif argument[k] == "InjectedRank"]
                                                    [#assign argValue="ADC_INJECTED_RANK_"+argument.value]
                                                [/#if]
                                            [/#if]
                                        [/#list]
                                    [/#if]                                   
                                    [#-- Bz40086 End tweak of the value in case of ADC --]
                                    [#if argument.genericType=="Array" && argument.context!="globalConst" && argument.context!="globalInit"][#-- if genericType=Array --]
                                    [#assign valList = argument.value?split(argument.arraySeparator)]     
                                            [#assign i = 0]                                  
                                        [#list valList as val]
                                            [#if argument.base == "10"]
                                                #t${argument.name}[${i}] = ${val};
                                            [#else]
                                                #t${argument.name}[${i}] = 0x${val};
                                            [/#if]
                                            [#assign i = i+1]
                                        [/#list]
                                        [#assign argValue="&"+argument.name]                                    
                                    [/#if] [#-- if genericType=Array --]
                                    [#if argument.genericType=="Array" && (argument.context=="globalConst" || argument.context=="globalInit")][#-- if genericType=Array and gloabl--]                                        
                                        [#assign argValue="("+argument.typeName +" *)"+argument.name]
                                    [/#if]
                                    [#if argument.value!="" && argument.value!="N/A"]
                                    [#if instanceIndex??&&fargument.context=="global" && fargument.optional!="output"][#assign varName=fargument.name +"." +instanceIndex][#else][#assign varName=fargument.name][/#if]
                                        [#assign indicator = varName+"."+argument.name+" = "+argValue+" "]
                                        [#assign indicatorName = varName+"."+argument.name]
                                        [#if !listofDeclaration?contains(indicator)][#-- if not repeted --]
                                            [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global" && fargument.optional!="output"][#assign varName=fargument.name +"." +instanceIndex]${fargument.name}${instanceIndex}[#else][#assign varName=fargument.name]${fargument.name}[/#if].${argument.name} = ${argValue};
                                            [#assign listofDeclaration = listofDeclaration?replace(indicatorName+" =","")]
                                            [#assign listofDeclaration = listofDeclaration +", "+ varName+"."+argument.name+" = "+argValue+" "]                                                                                 
                                        [/#if]
                                    [#else]
                                    [#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global" && fargument.optional!="output"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = [#if argument.value!="N/A"]${argValue}[/#if];
                                    [/#if]                                                                     
                                    [/#if]
                                    [#else] [#-- else argument.mandatory--]
                                      [#if fargument.name!="GPIO_InitStruct" && fargument.name!="GPIO_Init"]
                                            [#if argument.name=="Instance"][#-- if argument=Instance--]
                                              [#-- calculate the value of Instance argument if contains $Index --]
                                                [#if  (argument.value??&& argument.value!="__NULL") && (argument.value?contains("$Index"))]
                                                    [#assign instanceValue=argument.value?replace("$Index",index)]
[#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"][#assign varName=fargument.name +instanceIndex][#else][#assign varName=fargument.name][/#if]
                                                    [#assign indicator = varName+"."+argument.name+" = "+instanceValue+" "]
                                                    [#if !listofDeclaration?contains(indicator)]    [#-- if not repeted --]
                                                    [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${instanceValue};
                                                            [#assign listofDeclaration = listofDeclaration +", "+ indicator]
                                                    
                                                    [/#if]
                                                [#else]
[#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"][#assign varName=fargument.name+instanceIndex][#else][#assign varName=fargument.name][/#if] [#if argument.value?? && argument.value!="__NULL"][#assign argv =argument.value][#else][#assign argv=inst][/#if]
                                                   [#assign indicator = varName+"."+argument.name+" = "+argv+" "]
                                                   [#if !listofDeclaration?contains(indicator)] [#-- if not repeted --]
                                                    [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = [#if argument.value?? && argument.value!="__NULL"]${argument.value};[#else]${inst};[/#if]
                                                            [#assign listofDeclaration = listofDeclaration +", "+ indicator]
                                                            [#if index1 == fargument.argument?size]
                                                                #n
                                                            [/#if]
                                                            [#if configModel.ipName=="RTC" && config.name=="RTC_Init_Only"]
                                                                [#list configModel.configs as bz36245config]
                                                                    [#if bz36245config.name=="RTC_Init"]
                                                                        [#assign bz36245=true]
                                                                    [/#if]
                                                                [/#list]
                                                            [/#if]
                                                            [#if bz36245]                                                              
                                                            [/#if]
                                                   [/#if]
                                                [/#if]
                                          [#else]
                                              [#if argument.status=="KO"]
                                                   [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"]//${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${argument.value};                                        
                                              [/#if]
                                              [#if argument.value?? && argument.value!="__NULL"]

[#if argument.refMethod??] [#-- CallLibMethod for Argument value --]
    [#assign argumentValue=""]
    [@callLibMethod CLmethod=argument.refMethod configModelRef=configModel instRef=inst nTabRef=nTab indexRef=index argumentValue=argumentValue/]
    [#assign argTmp = argumentValue]
[/#if] [#-- end if fargument.refMethod??--] [#-- New --]
                [#if argument.value!="N/A"]
                                                        [#if argument.refMethod??][#assign argValue=argumentValue][#else][#assign argValue=argument.value][/#if]
                                                        [#if instanceIndex??&&fargument.context=="global"][#assign varName=fargument.name+instanceIndex][#else][#assign varName=fargument.name][/#if]
                                                        [#assign indicator = varName+"."+argument.name+" = "+argValue+" "]
                                                        [#assign indicatorName = varName+"."+argument.name]
                                                        [#if !listofDeclaration?contains(indicator)][#-- if not repeted --] 
                                                            [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"][#assign varName=fargument.name +"." +instanceIndex]${fargument.name}${instanceIndex}[#else][#assign varName=fargument.name]${fargument.name}[/#if].${argument.name} = ${argValue};
                                                            [#assign listofDeclaration = listofDeclaration?replace(indicatorName+" =","")]
                                                            [#assign listofDeclaration = listofDeclaration +", "+ varName+"."+argument.name+" = "+argValue+" "]                                                                                 
                                                        [/#if]
                                                    [/#if]
                                              [/#if]                                    
                                          [/#if][#-- if argument=Instance--]                                
                                      [/#if]    
                                [/#if][#-- if argument.mandatory--]     
                            [#else]
                            [#assign index2=0]
[#list argument.argument as argument2]
			[#if argument2.genericType!="struct"]
[#if config.ipName=="ETH"]
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
[/#if]
                                [/#if][#-- if argument.mandatory --]
[#if config.ipName!="ETH"]
                                [#if argument2.value?? && argument2.value!="__NULL"][#assign argValue=argument2.value][#else] [#assign argValue=""][/#if]
                                [#if argument2.mandatory]
                                    [#if argument2.value?? && argument2.value!="__NULL"]
                                    [#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"][#assign argValue=argument2.value?replace("$Index",instanceIndex)][#else][#assign argValue=argument2.value][/#if]
                                    [#if argument2.genericType=="Array" && argument2.context!="globalConst" && argument2.context!="globalInit"][#-- if genericType=Array --]
                                        [#if argument2.arraySeparator?? && argument2.arraySeparator!=""]
                                        [#assign valList = argument2.value?split(argument2.arraySeparator)]     
                                        [#else]
                                            [#assign valList = argument2.value?split(":")]
                                        [/#if]
                                            [#assign i = 0]
                                            [#assign argValue="&"+argument2.name+"[0]"]
                                            [#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"][#assign varName=fargument.name +instanceIndex][#else][#assign varName=fargument.name][/#if]
                                        [#list valList as val]
                                            [#if nTab==2]#t#t[#else]#t[/#if][#t]
                                            [#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"][#t]
                                                ${fargument.name}${instanceIndex}[#t]
                                            [#else]
                                                ${fargument.name}[#t]
                                            [/#if]
                                            .${argument.name}.${argument2.name}[${i}] =[#t]
                                            [#if argument2.base == "10"]
                                                #t${val};
                                            [#else]
                                                #t0x${val};
                                            [/#if]
                                          [#assign i = i+1]
                                        [/#list]
                                            [#if index2 == argument.argument?size]
                                                 [#-- add space line at the end of argument setting --]
                                            [/#if]
                                    [#else] [#-- if genericType=Array --]
                                    [#-- if argument is a global array --]
                                    [#if argument2.genericType=="Array" && (argument2.context=="globalConst" || argument2.context=="globalInit")][#-- if genericType=Array and gloabl--]                                        
                                        [#assign argValue="("+argument2.typeName +" *)"+argument2.variableName]
                                    [/#if]                                         
                                    [#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"][#assign varName=fargument.name +instanceIndex][#else][#assign varName=fargument.name][/#if]
                                                    [#assign indicatorName = varName+"."+argument.name+"."+argument2.name]
                                                    [#assign indicator = varName+"."+argument.name+"."+argument2.name+" = "+argValue+" "]
                                                    [#if !listofDeclaration?contains(indicator)]  [#-- if not repeted --]
                                                        [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name} = ${argValue};                                    

                                                        [#if index2 == argument.argument?size]
                                                            #n [#-- add space line at the end of argument setting --] 
                                                        [/#if]
                                                            [#assign listofDeclaration = listofDeclaration?replace(indicatorName+" =","")]
                                                            [#assign listofDeclaration = listofDeclaration +", "+ indicator]
                                                    [/#if]
                                        [/#if]
                                    [/#if]
                               [#else] [#-- !argument.mandatory --]
                                    [#if argument2.status=="WARNING"]
                                        [#if argument2.name=="ShieldIOs"]
                                            [#assign argValue ="0"]
                                            [#assign indicatorName = varName+"."+argument.name+"."+argument2.name]
                                            [#assign indicator = varName+"."+argument.name+"."+argument2.name+" = "+argValue+" "]
                                            [#if !listofDeclaration?contains(indicator)]  [#-- if not repeted --]
                                                [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name} = ${argValue};                                    
                                               [#if index2 == argument.argument?size]
                                                        #n [#-- add space line at the end of argument setting --]
                                                [/#if]
                                            [/#if]
                                        [/#if]
                                    [/#if]
                                    [#if argument2.status=="KO"]
                                        [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"]//${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name} = ${argValue};
                                    [/#if]
                                    [#if argument2.status=="OK"]
[#if instanceIndex??&&fargument.context=="global"][#assign varName=fargument.name +instanceIndex][#else][#assign varName=fargument.name][/#if]
                                         [#assign indicatorName = varName+"."+argument.name+"."+argument2.name]
                                         [#assign indicator = varName+"."+argument.name+"."+argument2.name+" = "+argValue+" "]
                                         [#if !listofDeclaration?contains(indicator)]  [#-- if not repeted --]   
                                            [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name} = ${argValue};
                                            [#assign listofDeclaration = listofDeclaration?replace(indicatorName+" =","")]
                                            [#assign listofDeclaration = listofDeclaration +", "+ indicator]                                            
                                         [/#if]
                                    [/#if]

[/#if]
                                [/#if][#-- if argument.mandatory --]
[#else]
[#list argument2.argument as argument3]
    [#if argument3.genericType!="struct"]
        [#if argument3.value?? && argument3.value!="__NULL"][#assign argValue=argument3.value][#else] [#assign argValue=""][/#if]
                                [#if argument3.mandatory]
                                    [#if argument3.value?? && argument3.value!="__NULL"]
                                    [#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"][#assign argValue=argument3.value?replace("$Index",instanceIndex)][#else][#assign argValue=argument3.value][/#if]
                                    [#if argument3.genericType=="Array" && argument3.context!="globalConst" && argument3.context!="globalInit"][#-- if genericType=Array --] 
                                        [#if argument3.arraySeparator?? && argument3.arraySeparator!=""]
                                            [#assign valList = argument3.value?split(argument3.arraySeparator)]     
                                        [#else]
                                            [#assign valList = argument3.value?split(":")]
                                        [/#if]
                                            [#assign i = 0]                                  
                                        [#list valList as val] 
                                            [#if argument3.base == "10"]
                                                #t${argument3.name}[${i}] = ${val};
                                            [#else]
                                                #t${argument3.name}[${i}] = 0x${val};
                                            [/#if]
                                            [#assign i = i+1]
                                        [/#list]
                                        [#assign argValue="&"+argument3.name+"[0]"]
                                    [/#if] [#-- if genericType=Array --]
                                     [#-- if argument is a global array --]
                                    [#if argument3.genericType=="Array" && (argument3.context=="globalConst"||argument3.context=="globalInit")][#-- if genericType=Array and gloabl--]                                        
                                        [#assign argValue="("+argument3.typeName +" *)"+argument3.name]
                                    [/#if]
[#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"][#assign varName=fargument.name +instanceIndex][#else][#assign varName=fargument.name][/#if]
                                         [#assign indicatorName = varName+"."+argument.name+"."+argument2.name+"."+argument3.name]
                                         [#assign indicator = varName+"."+argument.name+"."+argument2.name+"."+argument3.name+" = "+argValue+ " "]
                                         [#if !listofDeclaration?contains(indicator)]  [#-- if not repeted --]                                      
                                            [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name}.${argument3.name} = ${argValue};                                    
                                            [#assign listofDeclaration = listofDeclaration?replace(indicatorName+" =","")]
                                            [#assign listofDeclaration = listofDeclaration +", "+ indicator]
                                         [/#if]                                       [/#if]
                               [#else] [#-- !argument.mandatory --]
                                    [#if argument3.status=="KO"]
[#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"][#assign varName=fargument.name +instanceIndex][#else][#assign varName=fargument.name][/#if]
                                         [#assign indicatorName = varName+"."+argument.name+"."+argument2.name+"."+argument3.name]
                                         [#assign indicator = varName+"."+argument.name+"."+argument2.name+"."+argument3.name+" = "+argValue+" "] 
                                         [#if !listofDeclaration?contains(indicator)]  [#-- if not repeted --]  
                                            [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name}.${argument3.name} = ${argValue};
                                            [#assign listofDeclaration = listofDeclaration?replace(indicatorName+" =","")]
                                            [#assign listofDeclaration = listofDeclaration +", "+ indicator]
                                         [/#if]
                                    [/#if]
                                    [#if argument3.status=="OK"]
[#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"][#assign varName=fargument.name +instanceIndex][#else][#assign varName=fargument.name][/#if]
                                         [#assign indicatorName = varName+"."+argument.name+"."+argument2.name+"."+argument3.name]
                                         [#assign indicator = varName+"."+argument.name+"."+argument2.name+"."+argument3.name+" = "+argValue+" "] 
                                         [#if !listofDeclaration?contains(indicator)]  [#-- if not repeted --]  
                                            [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name}.${argument3.name} = ${argValue};
                                            [#assign listofDeclaration = listofDeclaration?replace(indicatorName+" =","")]
                                            [#assign listofDeclaration = listofDeclaration +", "+ indicator]
                                        [/#if]
                                    [/#if]
                                [/#if][#-- if argument.mandatory --]
    [#else]
		[#list argument3.argument as argument4]
			[#if argument4.genericType!="struct"]
				[#if argument4.value?? && argument4.value!="__NULL"][#assign argValue=argument4.value][#else] [#assign argValue=""][/#if]
				[#if argument4.value?? && argument4.value!="__NULL"]
					[#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"][#assign varName=fargument.name +instanceIndex][#else][#assign varName=fargument.name][/#if]
                    [#assign indicatorName = varName+"."+argument.name+"."+argument2.name+"."+argument3.name+"."+argument4.name]
                    [#assign indicator = varName+"."+argument.name+"."+argument2.name+"."+argument3.name+"."+argument4.name+" = "+argValue+" "] 
                    [#if !listofDeclaration?contains(indicator)]  [#-- if not repeted --]  
                        [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name}.${argument3.name}.${argument4.name} = ${argValue};                                    
                        [#assign listofDeclaration = listofDeclaration?replace(indicatorName+" =","")]
                        [#assign listofDeclaration = listofDeclaration +", "+ indicator]
                    [/#if]
				[/#if]
			[#else]
				[#list argument4.argument as argument5]
					[#if argument5.genericType!="struct"]
						[#if argument5.value?? && argument5.value!="__NULL"][#assign argValue=argument5.value][#else] [#assign argValue=""][/#if]
						[#if argument5.value?? && argument5.value!="__NULL"]
                            [#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"][#assign varName=fargument.name +instanceIndex][#else][#assign varName=fargument.name][/#if]
                            [#assign indicatorName = varName+"."+argument.name+"."+argument2.name+"."+argument3.name+"."+argument4.name+"."+argument5.name]
                            [#assign indicator = varName+"."+argument.name+"."+argument2.name+"."+argument3.name+"."+argument4.name+"."+argument5.name+" = "+argValue+" "] 
                            [#if !listofDeclaration?contains(indicator)]  [#-- if not repeted --]  
                                [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument2.name}.${argument3.name}.${argument4.name}.${argument5.name} = ${argValue};                                    
                                [#assign listofDeclaration = listofDeclaration?replace(indicatorName+" =","")]
                                [#assign listofDeclaration = listofDeclaration +", "+ indicator]
                            [/#if]
						[/#if]
					[/#if]
				[/#list]
			[/#if]
		 [/#list]
    [/#if]                                
[/#list]
[/#if]
[#assign index2=index2 + 1]
                            [/#list]
                            [/#if]
[#assign index1 =index1 + 1]
                        [/#list][#-- list  fargument.argument as argument--]
                        [/#if]
                    [#else][#-- if fargument a simple type struct --]
                        [#if fargument.genericType=="Array"][#-- if genericType=Array --]
                            [#if fargument.context!="globalConst" && fargument.context!="globalInit"]
                                [#assign valList = fargument.value?split(fargument.arraySeparator)]
                                [#assign i = 0]
                                [#list valList as val]
                                    [#if fargument.base == "10"]
                                        #t${fargument.name}[${i}] = ${val};
                                    [#else]
                                        #t${fargument.name}[${i}] = 0x${val};
                                    [/#if]
                                    [#assign i = i+1]
                                [/#list]
                            [/#if]
                            [#if fargument.status!="NULL"]
                                [#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"]
                                    [#assign arg = "" + adr + fargument.name + instanceIndex]
                                [#else]
                                    [#assign arg = "" + adr + fargument.name]
                                [/#if]
                            [#else]
                                [#assign arg = "NULL"]
                            [/#if]
                        [#else] [#-- if genericType=Array --]
                    [#assign arg = ""]
                        [#if fargument.status=="OK" && fargument.value?? && fargument.value!="__NULL" && fargument.argumentReference == "RefParameter"]
                            [#if name??][#assign argIndex = inst?replace(name,"")]  [/#if]
                                            [#if argIndex??] 
                                                [#assign argValue=fargument.value?replace("$Index",argIndex)]
                                                [#if fargument.returnValue!="true"]
                                                    [#assign arg = "" + adr + argValue]
                                                [/#if]
                                            [#else]
                                                [#if fargument.returnValue!="true"]
                                                    [#assign arg = "" + adr + fargument.value]                                                
                                                [/#if]
                                            [/#if]    
                        [#else] 
                            [#if fargument.status=="NULL"][#assign arg = "" + adr + "NULL"] [/#if]      
                    [/#if]
                        [/#if] [#-- if genericType=Array --]
                    [/#if] [#-- end if fargument is struct --]
                    [#if args == "" && arg!=""][#assign args = args + arg ][#else][#if arg!=""][#assign args = args + ', ' + arg][/#if][/#if]
                    [/#list]
                    [#assign retval=""]
            [#list method.arguments as argument]
            [#if argument.returnValue=="true"]
                [#assign retval=argument.name]
            [/#if]
            [/#list]
[#if !(method.callMethod) || (S_FATFS_SDIO?? && (inst=="SDIO" || inst?starts_with("SDMMC")) && !(method.name=="HAL_RCCEx_PeriphCLKConfig"))] [#-- if HAL_SD_Init  and SDIO is used with FATFS--]
[#else]		    
                [#if inst?contains("ETH")]
                    #n
                    #t/* USER CODE BEGIN MACADDRESS */
                    #t#t
                    #t/* USER CODE END MACADDRESS */
                    #n
                [/#if]
[#--[#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});#n--]
        [#if method.returnHAL=="false"]
            [#-- Check if Method is already called (listofCalledMethod)--]
            [#assign methodName = method.name + "("+args+")"]
            [#if !listofCalledMethod?contains(methodName)]
                [#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});
                [#if method.optimizale??&&method.optimizale==true]
                [#assign listofCalledMethod = listofCalledMethod + ", "+ methodName]
                [/#if]
            [#if bz36245]
             }
               [/#if]
            [/#if]
        [#else]
            [#-- [#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});#n --]
            [#-- Check if Method is already called (listofCalledMethod)--]
            [#assign methodName = method.name + "("+args+")"] 
            [#if !listofCalledMethod?contains(methodName) && method.optimizale??]
                [#-- specific case for I2C setData fucntion --]
                [#if method.name?contains("ADV_LPBAM_I2C") &&(method.name?contains("_SetDataQ") || method.name?contains("_SetFullQ"))]
                   [#assign Sarg = args?split(',')]
                       [#if Sarg??]
                        [#assign sizeArg= Sarg[2]?replace(" &","")]
                       [#else]
                        [#assign sizeArg= "pRxData_I2C"]
                       [/#if]           
                    #t/* Set transfer parameters */
                    #tdata_size = ${sizeArg}.Size;
                    #ttransfer_idx = 0;
                    #n
                    #t/* Repeat inserting I2C master Tx data queue until completing all data */
                    #twhile (data_size != 0U)
                    #t{
                    #t#tif (${method.name}(${args}) != LPBAM_OK)                
                    #t#t{
                    #t#t#tError_Handler();                    
                    #t#t}
                    #n       
                    #t#ttransfer_idx++;
                    #n
                    #t#tif (data_size > LPBAM_I2C_MAX_DATA_SIZE)
                    #t#t{
                      #t#t#tdata_size -= LPBAM_I2C_MAX_DATA_SIZE;
                    #t#t}
                    #t#telse
                    #t#t{
                      #t#t#tdata_size = 0U;
                    #t#t}
                    #t}
                [#else]
                    [#if nTab==2]#t#t[#else]#t[/#if]if (${method.name}(${args}) != [#if method.returnHAL == "true"]LPBAM_OK[#else]${method.returnHAL}[/#if])                
                    [#if nTab==2]#t#t[#else]#t[/#if]{
                    [#if nTab==2]#t#t[#else]#t[/#if]#tError_Handler();                    
                    [#if nTab==2]#t#t[#else]#t[/#if]}
                [/#if]
                [#if method.optimizale??&&method.optimizale==true]
                [#assign listofCalledMethod = listofCalledMethod + ", "+ methodName]
                [/#if]
            [/#if]
        [/#if]
[/#if]                   
            [#else]
                    [#if !(method.callMethod) || (S_FATFS_SDIO?? && (inst=="SDIO" || inst?starts_with("SDMMC")))] [#-- if HAL_SD_Init  and SDIO is used with FATFS--][#else]
                        [#--[#if nTab==2]#t#t[#else]#t[/#if]${method.name}();#n--]
                        [#if method.returnHAL=="false"]
            [#if nTab==2]#t#t[#else]#t[/#if]${method.name}();
                        [#else]
                            [#-- [#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});#n --]
                            [#if nTab==2]#t#t[#else]#t[/#if]if (${method.name}() != [#if method.returnHAL == "true"]LPBAM_OK[#else]${method.returnHAL}[/#if])
                            [#if nTab==2]#t#t[#else]#t[/#if]{
                            [#if nTab==2]#t#t[#else]#t[/#if]#tError_Handler();
                            [#if nTab==2]#t#t[#else]#t[/#if]}
                        [/#if]                 
                    [/#if]
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
                                                [#if config.ipName=="DMA" || config.ipName=="BDMA" || config.ipName=="BDMA1"]
                                                [#assign instanceIndex = "_"+ config.dmaRequestName?lower_case]
                                                [#else]
                                               [#if name??] [#assign instanceIndex = inst?replace(name,"")][/#if]
                                                [#if configModel.ipName=="DFSDM" || configModel.ipName=="MDF" || configModel.ipName=="ADF"]
                                                    [#assign instanceIndex = ""]
                                                [/#if]                
                                                [/#if]
                                            [/#if]
                                        [/#if]              
                        [#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"][#assign arg = "" + adr + fargument.name + instanceIndex][#else][#assign arg = "" + adr + fargument.name][/#if]
                        [#if (!method.name?contains("Init")&&fargument.context=="global")]
        [#-- MDF  --]
                        [#else]
                        [#list fargument.argument as argument]	
                                [#if argument.genericType != "struct"]
                                [#if argument.mandatory && argument.value?? && argument.value!="__NULL"]
                                    [#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"][#assign argValue=argument.value?replace("$Index",instanceIndex)][#else][#assign argValue=argument.value][/#if]
                                    [#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${argValue};
                                 [#else]
                                    [#if argument.name=="Instance"]
                                        [#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${inst};
                                    [/#if]                                
                                [/#if]
                            [#else]
                            [#list argument.argument as argument1]
                                [#if argument1.mandatory && argument1.value?? && argument1.value!="__NULL"]
                                    [#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"][#assign argValue=argument1.value?replace("$Index",instanceIndex)][#else][#assign argValue=argument1.value][/#if]
                                [#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global"&& fargument.optional!="output"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument1.name} = ${argValue};
                                [/#if]
                            [/#list]
                            [/#if]
                            [/#list]
[/#if]
                                        [#else] [#-- if argument != struct --]
 [#if name??][#assign argIndex = inst?replace(name,"")]  
                                            [#assign argIndex = inst?replace(name,"")] 
[/#if]
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
                            [#if method.returnHAL=="false"]
                            [#if nTab==2]#t#t[#else]#t[/#if]${method.name}();
                            [#else]
                                [#-- [#if nTab==2]#t#t[#else]#t[/#if]${method.name}(${args});#n --]
                                [#if nTab==2]#t#t[#else]#t[/#if]if (${method.name}() != [#if method.returnHAL == "true"]LPBAM_OK[#else]${method.returnHAL}[/#if])
                                [#if nTab==2]#t#t[#else]#t[/#if]{
                                [#if nTab==2]#t#t[#else]#t[/#if]#tError_Handler();
                                [#if nTab==2]#t#t[#else]#t[/#if]}
                            [/#if]
                               [#--[#if nTab==2]#t#t[#else]#t[/#if]${method.name}();--]
                        [/#if]
                [/#if]
        [/#list]
[#-- assign instanceIndex = "" --]
 [#-- else there is no LibMethod to call--]
[#if bz36245]                                                           
    #n
    #t/* USER CODE BEGIN Check_RTC_BKUP */
    #t#t
    #t/* USER CODE END Check_RTC_BKUP */
    #n
[/#if]
[/#list]
[/#compress]
[/#macro]
[#-- End macro generateConfigModelListCode --]
