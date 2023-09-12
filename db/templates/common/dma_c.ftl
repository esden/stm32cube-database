[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : dma.c
  * Description        : This file provides code for the configuration
  *                      of all the requested memory to memory DMA transfers.
  ******************************************************************************
  *
  * COPYRIGHT(c) ${year} STMicroelectronics
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  *   1. Redistributions of source code must retain the above copyright notice,
  *      this list of conditions and the following disclaimer.
  *   2. Redistributions in binary form must reproduce the above copyright notice,
  *      this list of conditions and the following disclaimer in the documentation
  *      and/or other materials provided with the distribution.
  *   3. Neither the name of STMicroelectronics nor the names of its contributors
  *      may be used to endorse or promote products derived from this software
  *      without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
  * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
  * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "dma.h"

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/*----------------------------------------------------------------------------*/
/* Configure DMA                                                              */
/*----------------------------------------------------------------------------*/

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

[#list variables as variable]
${variable.value} ${variable.name};
[/#list]
[#if variables?size > 0]

[/#if]
/** 
  * Enable DMA controller clock
[#if variables?size > 0]
  * Configure DMA for memory to memory transfers
[#list variables as variable]
  *   ${variable.name}
[/#list]
[/#if]
  */
void MX_DMA_Init(void) 
{
[#if isHalSupported=="true"]
  [#if clocks?size > 0]
  /* DMA controller clock enable */
  [/#if]
  [#list clocks as clockMacro]
  ${clockMacro}();
  [/#list]
[/#if]
[#list datas as configModel][#--go through all DMA requests--]
  [#assign instanceSuffix = "_" + configModel.instanceName?lower_case]
  [#if configModel.methods??][#-- if the DMA configuration contains a list of LibMethods--]
    [#list configModel.methods as method]
      [#assign args = ""]
      [#if method.name == "HAL_DMA_Init"]
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
        [/#list]
      [/#if]

      [#if method.status=="OK"][#-- all parameters have a value --]
        [#if method.name == "HAL_DMA_Init"]
  /* Configure DMA request ${request} on ${stream} */
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
            [#if func_argument.genericType == "struct"]
              [#assign arg = "" + addr + request]
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
            [#else]
              [#assign arg = "" + addr + func_argument.value]
            [/#if][#-- if func_argument.genericType == "struct"--]
            [#if args == ""]
              [#assign args = arg]
            [#else]
              [#assign args = args + ', ' + arg]
            [/#if]
          [/#list]
  ${method.name}(${args});
        [#else]
  ${method.name}();
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
[#-- DMA interrupts --]
[#if InitNvic??]#n#t/* DMA interrupt init */
            [#list InitNvic as initVector]                                
                #tHAL_NVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority}, ${initVector.subPriority});
                #tHAL_NVIC_EnableIRQ(${initVector.vector});
            [/#list]
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

