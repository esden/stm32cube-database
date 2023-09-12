[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : mdma.c
  * Description        : This file provides code for the configuration
  *                      of all the requested global MDMA transfers.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign debugmdma = false]
[#assign ipName = "MDMA"]
[#if dmas?size > 0]
  [#list dmas as dma]
    [#assign ipName = dma]
  [/#list]
[/#if]

[#assign contextFolder=""]
[#if cpucore!=""]
[#assign contextFolder = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")+"/"]
[/#if]

/* Includes ------------------------------------------------------------------*/
#include "${ipName?lower_case}.h"

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/*----------------------------------------------------------------------------*/
/* Configure MDMA                                                              */
/*----------------------------------------------------------------------------*/

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
[#if variables?? && variables?size > 0]
  [#list variables as variable]
${variable.value} ${variable.name};
  [/#list]
[/#if]

[#assign LL_Driver = false]
[#if driver??]
  [#list driver as driverType]
    [#if driverType=="LL"]
      [#assign LL_Driver = true]
    [/#if]
  [/#list]
[/#if]

[#function list_element string_list number]
  [#assign counter = 0]
  [#list string_list?split(" ") as string_element]
    [#assign counter = counter + 1]
    [#if counter == number]
      [#return string_element]
    [/#if]
  [/#list]
  [#return ""]
[/#function]

[#function list_contains string_list element]
  [#list string_list?split(" ") as string_element]
    [#if string_element == element]
      [#return true]
    [/#if]
  [/#list]
  [#return false]
[/#function]

[#function is_global_variable element]
  [#list variables as variable]
    [#if variable.name == element]
      [#return true]
    [/#if]
  [/#list]
  [#return false]
[/#function]

/** 
  * Enable MDMA controller clock
[#if datas?size > 0]
  * Configure MDMA for global transfers
[/#if]
[#if variables?? && variables?size > 0]
  [#list variables as variable]
  *   ${variable.name}
  [/#list]
[/#if]
  */
void MX_${ipName}_Init(void) 
{

[#if RESMGR_UTILITY??]
    [@common.optinclude name=contextFolder+mxTmpFolder+"/resmgrutility_"+ipName+".tmp"/][#-- ADD RESMGR_UTILITY Code--]
[/#if]

[#if LL_Driver]
  /* Init with LL driver */
[/#if]
[#if isHalSupported=="true"]
  [#if clocks?size > 0]
  /* MDMA controller clock enable */
  [/#if]
  [#list clocks as clockMacro]
    [#if clockMacro?contains("(")]
  ${clockMacro};
    [#else]
  ${clockMacro}();
    [/#if]
  [/#list]
[/#if]
[#assign global_variables = ""]
[#list datas as configModel]
  [#list configModel.methods as method]
    [#list method.arguments as func_argument]
      [#if func_argument.genericType == "struct" && func_argument.context == "global"]
        [#if global_variables == ""]
          [#assign global_variables = func_argument.name]
        [#else]
          [#if !list_contains(global_variables, func_argument.name)]
            [#assign global_variables = global_variables + " " + func_argument.name]
          [/#if]
        [/#if]
      [/#if]
    [/#list]
  [/#list]
[/#list]
[#if debugmdma]
global_variables=${global_variables}
[/#if]
[#assign local_variables = ""]
  /* Local variables */
[#list datas as configModel]
  [#list configModel.methods as method]
    [#list method.arguments as func_argument]
      [#if func_argument.genericType == "struct" && func_argument.context != "global"]
        [#if local_variables == ""]
          [#assign local_variables = func_argument.name]
  ${func_argument.typeName} ${func_argument.name};
        [#else]
          [#if !list_contains(local_variables, func_argument.name) && !list_contains(global_variables, func_argument.name)]
            [#assign local_variables = local_variables + " " + func_argument.name]
  ${func_argument.typeName} ${func_argument.name};
          [/#if]
        [/#if]
      [/#if]
    [/#list]
  [/#list]
[/#list]
[#if debugmdma]
local_variables=${local_variables}
[/#if]
[#assign struct_variables = ""]
[#assign main_request = ""]
[#assign channel_name = ""]
[#list datas as configModel][#--go through all MDMA requests--]
  [#if channel_name != configModel.instanceName]
    [#assign channel_name = configModel.instanceName]
    [#assign struct_variables = ""]
    [#assign main_request = ""]

  /* Configure MDMA channel ${channel_name} */
  [/#if]
  [#assign instanceSuffix = "_" + configModel.dmaRequestName?lower_case]
[#if debugmdma]
dmaRequestName=${configModel.dmaRequestName?lower_case}
[/#if]
  [#if configModel.methods??][#-- if the MDMA configuration contains a list of LibMethods--]
    [#if LL_Driver]
  #n
    /* Configure MDMA request ${configModel.dmaRequestName} */
    [/#if]
    [#--[#assign struct_variables = ""]--]
    [#list configModel.methods as method]
      [#assign method_commented = false]
      [#assign start_commenting = false]
      [#assign args = ""]
      [#if method.name == "HAL_MDMA_Init"]
        [#assign request = ""]
        [#assign stream = ""]
        [#list method.arguments as func_argument]
          [#if func_argument.genericType == "struct"]
            [#assign request = func_argument.name]
            [#list func_argument.argument as argument]
              [#if argument.name == "Instance"]
                [#assign stream = argument.value]
              [/#if]
            [/#list]
          [/#if]
          [#assign request = request + instanceSuffix]
          [#assign main_request = request]
        [/#list]
      [/#if]
      [#-- It is the second and last argument of CreateNode for which code must be generated to set its structure fields --]
      [#if method.name == "HAL_MDMA_LinkedList_CreateNode"]
        [#assign request = ""]
        [#list method.arguments as func_argument]
          [#if func_argument.genericType == "struct"]
            [#assign request = func_argument.name]
          [/#if]
        [/#list]
        [#assign method_commented = true]
      [/#if]
      [#if method.name == "HAL_MDMA_LinkedList_AddNode"]
        [#assign request = main_request]
      [/#if]
      [#if method.status=="OK"][#-- all parameters have a value  --]
        [#if method.name == "HAL_MDMA_Init"]
  /* Configure MDMA request ${request} on ${stream} */
        [#else]
          [#if method.comment??]
  /* ${method.comment} */
          [/#if]
        [/#if]
        [#if method.arguments??]
          [#list method.arguments as func_argument]
            [#if func_argument.addressOf]
              [#assign addr = "&"]
            [#else]
              [#assign addr = ""]
            [/#if]
            [#assign already_found = false]
            [#if func_argument.genericType == "struct"]
              [#assign added = false]
              [#if struct_variables == ""]
                [#assign struct_variables = func_argument.name + ":" + request]
                [#assign added = true]
              [#else]
                [#assign already_found = list_contains(struct_variables, func_argument.name + ":" + request)]
                [#if !already_found]
                  [#assign struct_variables = struct_variables + " " + func_argument.name + ":" + request]
                  [#assign added = true]
                [/#if]
              [/#if]
              [#if debugmdma]
struct_variables add ${func_argument.name} ? [#if added]yes[#else]no[/#if]
func_argument.name=${func_argument.name}
                [#if func_argument.value??]
func_argument.value=${func_argument.value}
                [/#if]
request=${request}
struct_variables=${struct_variables}
              [/#if]
              [#assign arg = "" + addr + request]
              [#if !already_found || !is_global_variable(request)]
                [#list func_argument.argument as argument1]
                  [#if argument1.genericType != "struct"]
                    [#if argument1.mandatory && argument1.value??]
  ${request}.${argument1.name} = ${argument1.value};
                    [/#if]
                  [#else]
                    [#list argument1.argument as argument2]
                      [#if argument2.mandatory && argument2.value??]
  ${request}.${argument1.name}.${argument2.name} = ${argument2.value};
                      [/#if]
                    [/#list]
                  [/#if]
                [/#list]
              [/#if]
            [#else]
              [#assign arg = "" + addr + func_argument.value]
            [/#if][#-- if func_argument.genericType == "struct"--]
            [#if args == ""]
              [#assign args = arg]
            [#else]
              [#assign args = args + ', ' + arg]
            [/#if]
          [/#list][#-- list method.arguments as func_argument--]
          [#if method.returnHAL=="false"]
  ${method.name}(${args});
          [#else]
  if (${method.name}(${args}) != HAL_OK)
  {
    Error_Handler();
  }
            [#if method_commented]
  /* USER CODE BEGIN ${configModel.dmaRequestName?lower_case} */

  /* USER CODE END ${configModel.dmaRequestName?lower_case} */
            [/#if]

          [/#if]
        [#else][#-- no arguments--]
          [#if method.returnHAL=="false"]
  ${method.name}();

          [#else]
  if (${method.name}() != HAL_OK)
  {
    Error_Handler();
  }

          [/#if]
        [/#if][#--if method.arguments??--]
      [/#if][#--if method.status=="OK"--]
  	  [#if method.status=="KO"]
  //!!! ${method.name} is commented because some parameters are missing
        [#if method.arguments??]			
          [#list method.arguments as func_argument]
            [#if func_argument.addressOf]
              [#assign addr = "&"]
            [#else]
              [#assign addr = ""]
            [/#if]
            [#if func_argument.genericType == "struct"]
              [#assign arg = "" + addr + request]
              [#list func_argument.argument as argument1]
                [#if argument1.genericType != "struct"]
                  [#if argument1.mandatory && argument1.value??]
  //${request}.${argument1.name} = ${argument1.value};
                  [/#if]
                [#else]
                  [#list argument1.argument as argument2]
                    [#if argument2.mandatory && argument2.value??]
  //${request}.${argument1.name}.${argument2.name} = ${argument2.value};
                    [/#if]
                  [/#list]
                [/#if]
              [/#list]
            [#else]
              [#assign arg = "" + addr + func_argument.value]
            [/#if][#-- if func_argument.genericType == "struct"--]
            [#if args == ""]
              [#assign args = args + arg ]
            [#else]
              [#assign args = args + ', ' + arg]
            [/#if]
          [/#list]
  //${method.name}(${args});
        [#else]
  //${method.name}();
        [/#if][#--if method.arguments??--]
      [/#if][#--if method.status=="KO"--]
    [/#list][#--list configModel.methods as method--]
  [/#if][#--if configModel.methods??--]
[/#list][#--list datas as configModel--]
[#compress]
[#-- MDMA interrupts --]
[#if InitNvic??]
    [#assign codeInMspInit = false]
    [#list InitNvic as initVector]
      [#if initVector.codeInMspInit]
       [#assign codeInMspInit = true]
       [#break]
      [/#if]
    [/#list]
    [#if codeInMspInit]
     #n#t/* MDMA interrupt initialization */
     [#list InitNvic as initVector]
        [#if initVector.codeInMspInit]
          #t/* ${initVector.vector} interrupt configuration */
          [#if initVector.usedDriver == "LL"]
            [#if !NVICPriorityGroup??]
          #tNVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority});
            [#else]
          #tNVIC_SetPriority(${initVector.vector}, NVIC_EncodePriority(NVIC_GetPriorityGrouping(),${initVector.preemptionPriority}, ${initVector.subPriority}));
            [/#if]
          #tNVIC_EnableIRQ(${initVector.vector});
          [#else]
          #tHAL_NVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority}, ${initVector.subPriority});
          #tHAL_NVIC_EnableIRQ(${initVector.vector});
          [/#if]
        [/#if]
     [/#list]
    [/#if]
[/#if]
#n
[/#compress]
}
/* USER CODE BEGIN 2 */

/* USER CODE END 2 */

/**
  * @}
  */

/**
  * @}
  */

