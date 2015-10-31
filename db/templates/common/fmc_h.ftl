[#ftl]
/**
  ******************************************************************************
  * File Name          : ${name}.h
  * Description        : This file provides code for the configuration
  *                      of the ${name} peripheral.
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
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${name?upper_case}_H
#define __${name?upper_case}_H
#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if includes??]
[#list includes as include]
#include "${include}"
[/#list]
[/#if]

[#list IPdatas as IP]  
[#assign ipvar = IP]
[#-- Global variables --]
[#if IP.variables??]
[#list IP.variables as variable]
extern ${variable.value} ${variable.name};
[/#list]
[/#if]
[#-- Global variables --]

[#-- extract hal mode list used by all instances of the ip --]
[#assign halModeList= ""]
[#if ipvar.ipName=="FMC"||ipvar.ipName=="FSMC"]
  [#if ipvar.variables??]
    [#list ipvar.variables as variable]
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

[#list IP.configModelList as instanceData]
  [#assign instName = instanceData.instanceName]
  [#assign instMode= instanceData.halMode]
  [#if ipvar.ipName=="FMC"||ipvar.ipName=="FSMC"]
void MX_${instName}_Init(void);
  [#else]
    [#if instMode!=name]void MX_${instName}_${instMode}_Init(void)[#else]void MX_${instName}_Init(void)[/#if];
  [/#if]
[/#list]
[#list halModeList?split(" ") as mode]
[#if mode !=""]
void HAL_${mode}_MspInit(${mode}_HandleTypeDef* h${mode?lower_case});
void HAL_${mode}_MspDeInit(${mode}_HandleTypeDef* h${mode?lower_case});
[/#if]
[/#list]
[/#list]

#ifdef __cplusplus
}
#endif
#endif /*__${name?upper_case}_H */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
