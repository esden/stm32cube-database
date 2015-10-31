[#ftl]
/**
 ******************************************************************************
  * File Name          : ${name}.c
  * Description        : This file provides code for the configuration
  *                      of the ${name} instances.
  ******************************************************************************
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */
/* Includes ------------------------------------------------------------------*/
#include "${name}.h"

[#-- IPdatas is a list of IPconfigModel --]  
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
#include "gpio.h"
[/#if]
[#if useDma]
#include "DMA.h"
[/#if]
[#-- End Define includes --]

[#-- macro getLocalVariable of a config Start--]
[#macro getLocalVariable configModel1 listOfLocalVariables resultList]
    [#if configModel1.methods??] 
        [#assign methodList1 = configModel1.methods]		
    [#else] 
		[#assign methodList1 = configModel1.libMethod]
    [/#if]
    [#list methodList1 as method][#-- list methodList1 --]	
		[#if method.callBackMethod=="false"]
			[#list method.arguments as argument][#-- list method.arguments --]		
				[#if (argument.genericType == "struct")][#-- if struct --]		
					[#if argument.context??][#-- if argument.context?? --]
						[#if argument.context!="global"] [#-- if global --]					
							[#assign varName= " "+argument.name]  					               
							[#assign ll= listOfLocalVariables?split(" ")]
							[#assign exist=false]					
							[#list ll as var  ]													
								[#if var==argument.name]												
									[#assign exist=true]
								[/#if]
							[/#list]
							[#if !exist]  [#-- if exist --] 					
							#t${argument.typeName} ${argument.name};
								[#assign resultList = listOfLocalVariables + " "+ argument.name]
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
			
			
				[#if argument.genericType == "simple"]	
					[#compress]
					[#if argument.addressOf] 
						[#assign adr = "&"]
					[#else ]
						[#assign adr = ""]
					[/#if]
					[/#compress]
					[#if argument.context??]
						[#if argument.context!="global"] 				
							[#assign varName= " "+argument.name]  					               
							[#if (argument.init=="false")]
								#t${argument.typeName} ${argument.name};
							[#else]
								#t${argument.typeName} ${argument.name} = ${adr}${argument.value};
							[/#if]
						[/#if]
					[/#if]
				[/#if]
				
						
			[/#list][#-- list method.arguments --]
		[/#if]	
    [/#list][#-- list methodList1 --]
[/#macro]
[#-- macro getLocalVariable of a config End--]
 
[#-- macro generateConfigModelCode --]
[#macro generateConfigModelCode configModel inst nTab]
[#if configModel.comments??] #t/**${configModel.comments} #n#t*/[/#if]
[#if configModel.methods??] [#-- if the pin configuration contains a list of LibMethods--]
    [#assign methodList = configModel.methods]
[#else] 
	[#assign methodList = configModel.libMethod]
[/#if]	
[#local myInst=inst]

	[#list methodList as method]
		[#assign args = ""]	
		[#if method.callBackMethod=="false"]			
		[#if method.status=="OK"]		
            [#if method.arguments??]
                [#list method.arguments as fargument]
				[#if fargument.returnValue=="false"]								
					[#assign return = ""]
					[#compress]
					[#if fargument.addressOf] 
						[#assign adr = "&"]
					[#else ]
						[#assign adr = ""]
					[/#if]
					[/#compress]
					[#if fargument.genericType == "Array"]
						[#assign valList = fargument.value?split(fargument.arraySeparator)]     
                        [#assign i = 0]                                  
						[#list valList as val] 
							#t${fargument.name}[${i}] = ${val};
							[#assign i = i+1]
						[/#list]
                    [#assign argValue="&"+fargument.name]
					[/#if]
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
							[#assign arg = "" + adr + fargument.name + instanceIndex]
						[#else]
							[#assign arg = "" + adr + fargument.name]							
						[/#if]
						[#-- [#assign arg = "" + adr + fargument.name] --]
						[#--if (!method.name?contains("Init")&&fargument.context=="global")--]
						[#if (fargument.init=="false")] [#-- MZA add the field init for Argument object, if init is false the intialization of this argument is not done --]				
							[#-- do Nothing --]
						[#else]
							[#list fargument.argument as argument]									
								[#compress]
									[#if argument.addressOf] 
										[#assign AdrMza = ""]
									[#else]
										[#assign AdrMza = ""]
									[/#if]
								[/#compress]								
								[#if argument.genericType != "struct"]	
									[#if argument.mandatory]								
										[#if instanceIndex??&&fargument.context=="global"]
											[#assign argValue=argument.value?replace("$Index",instanceIndex)]
										[#else]
											[#assign argValue=argument.value]
										[/#if]
										[#if argument.genericType=="Array"][#-- if genericType=Array --]
											[#assign valList = argument1.value?split(argument1.arraySeparator)]     
											[#assign i = 0]                                  
											[#list valList as val] 
												#t${argument1.name}[${i}] = ${val};
												[#assign i = i+1]
											[/#list]
										[/#if] [#-- if genericType=Array --]
										[#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${argValue};
										[#else]	
											[#if argument.genericType=="fpointer"] 											
												[#local Function = inst + "_" + argument.name]
                                                                                                [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${AdrMza}${Function};
											[#else]
                                                                                            [#if argument.value??]
												[#local Function = argument.value]
												[#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${AdrMza}${Function};
                                                                                            [/#if]
											[/#if]									
										[#--[#if argument.name=="Instance"]--]
											[#-- [#if nTab==2]#t#t[#else]#t[/#if][#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${AdrMza}${Function};--]
										[#--[/#if]--]
									[/#if]                                
								[#else]
								[#list argument.argument as argument1]  								
									[#if argument1.mandatory]
										[#if instanceIndex??&&fargument.context=="global"][#assign argValue=argument1.value?replace("$Index",instanceIndex)][#else][#assign argValue=argument1.value][/#if]
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
								[/#list]
								[/#if]
							[/#list][#-- list  fargument.argument as argument--]
						[/#if]	
					[#elseif fargument.genericType == "simple"] [#-- MZA if argument is simple we pass the name of the argument and not the value --]
						[#if fargument.context=="global"]
							[#assign arg = "" + adr + fargument.name + myInst]
						[#else]
							[#assign arg = "" + adr + fargument.name]
						[/#if]	
					[#else][#-- if struct --]
						[#assign arg = "" + adr + fargument.value]
					[/#if]
					[#if args == ""]
						[#assign args = args + arg ]
					[#else]
						[#assign args = args + ', ' + arg]
					[/#if]
				[#else] [#-- here we have an Argument as Return Value --]					
					[#if fargument.context=="global"] [#assign return = fargument.name + myInst + " = "]
					[#else] [#assign return = fargument.name + " = "]
					[/#if]
				[/#if]
				
                [/#list]
				[#if nTab==2]#t#t[#else]#t[/#if]${return}${method.name}(${args});#n
				[#else]
                    [#if nTab==2]#t#t[#else]#t[/#if]${return}${method.name}();
				[/#if]			
		[/#if]
		[#if method.status=="KO"]
		#n [#if nTab==2]#t#t[#else]#t[/#if]//!!! ${method.name} is commented because some parameters are missing
		[#if method.arguments??]			[#-- here we comment all variables intialization --]
				[#list method.arguments as fargument]
					[#if fargument.addressOf] 
						[#assign adr = "&"]
					[#else ] 
						[#assign adr = ""]
					[/#if]
					[#if fargument.genericType == "struct"]
						[#assign arg = "" + adr + fargument.name]
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
									[#if argument.mandatory]
										[#if instanceIndex??&&fargument.context=="global"][#assign argValue=argument.value?replace("$Index",instanceIndex)][#else][#assign argValue=argument.value][/#if]
									[#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${argValue};
                                 [#else]
                                    [#if argument.name=="Instance"]
                                        [#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name} = ${inst};
                                    [/#if]                                
                                [/#if]
								[#else]
								[#list argument.argument as argument1]
									[#if argument1.mandatory]
										[#if instanceIndex??&&fargument.context=="global"][#assign argValue=argument1.value?replace("$Index",instanceIndex)][#else][#assign argValue=argument1.value][/#if]
										[#if nTab==2]#t#t[#else]#t[/#if]//[#if instanceIndex??&&fargument.context=="global"]${fargument.name}${instanceIndex}[#else]${fargument.name}[/#if].${argument.name}.${argument1.name} = ${argValue};
									[/#if]
								[/#list]
								[/#if]
                        [/#list]
					[/#if]
                    [#else]
                        [#assign arg = "" + adr + fargument.value]
                    [/#if]
					[#if args == "" && arg.returnValue!="true"]
						[#assign args = args + arg ]
					[#else]
						[#assign args = args + ', ' + arg]
                    [/#if]
                [/#list]
				[#if nTab==2]#t#t[#else]#t[/#if]//${method.name}(${args});
            [#else]
            [#if nTab==2]#t#t[#else]#t[/#if]${method.name}()#n;
			[/#if]
        [/#if]
[/#if]		
    [/#list]

[#assign instanceIndex = ""]
[#-- else there is no LibMethod to call--]
[/#macro]
[#-- End macro generateConfigModelCode --]
 
[#compress]
[#-- Section1: Create CallBack function for each middle ware instance --]
[#-- This section can be moded into mw_h.ftl --]
[#list IP.configModelList as instanceData]
	[#assign instName = instanceData.instanceName]   
	[#list instanceData.configs as config]	
		[#list config.libMethod as libMethod]			
			[#if libMethod.callBackMethod??]
				[#if libMethod.callBackMethod=="true"]
					[#if libMethod.arguments??]
						[#assign argumentList= ""]
						[#list libMethod.arguments as argument]
							[#if argument_has_next]
								[#assign argumentList = argumentList + " " + argument.typeName + ","]
							[#else]
								[#assign argumentList = argumentList + " " + argument.typeName]
							[/#if]
						[/#list]
						extern DSTATUS ${instName}_${libMethod.name}(${argumentList});
					[#else]
						extern DSTATUS ${instName}_${libMethod.name}(void);
					[/#if]	
				[/#if]	
			[/#if]
		[/#list]
	[/#list]
[/#list]#n

[#-- Section2: Create global Variables for each middle ware instance --] 
[#-- Global variables --]
[#if IP.variables??]
	[#list IP.variables as variable]
	[#if variable.generiqueType=="Array"] 	
		${variable.value} ${variable.name}[${variable.arraySize}];
	[#else]
		${variable.value} ${variable.name};
	[/#if]
	[/#list]
[/#if]
[#-- Global variables --]#n

[#-- Section3: Create the void <IpInstance>_init() function for each middle ware instance --] 

[#list IP.configModelList as instanceData]
   [#assign instName = instanceData.instanceName]   
   [#assign halMode= instanceData.halMode]
   [#assign ipName = instanceData.ipName]
        /* ${instName} init function */				
        [#--[#if halMode!=instName]void ${halMode}_${instName}_Init(void)[#else]void MX_${instName}_Init(void)[/#if] --]
void MX_${ipName}${instName}_Init(void)
{
	[#-- MZA je dois remplir la liste des configs, pour l'instant j'utilise la liste des methods --]
	[#-- assign ipInstanceIndex = instName?replace(name,"")--]
	[#assign args = ""]
	[#assign listOfLocalVariables =""]
	[#assign resultList =""]
	[#list instanceData.configs as config]	
		[@getLocalVariable configModel1=config listOfLocalVariables=listOfLocalVariables resultList=resultList/]
		[#assign listOfLocalVariables =resultList]
	[/#list]
	
	[#list instanceData.configs as config]
        [@generateConfigModelCode configModel=config inst=instName  nTab=1/]
    [/#list]
#n}
[/#list]
[/#compress]
[/#list]
/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
