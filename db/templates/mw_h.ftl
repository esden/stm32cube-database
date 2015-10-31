[#ftl]
/**
  ******************************************************************************
  * File Name          : ${name}.h
  * Date               : ${date}
  * Description        : This file provides code for the configuration
  *                      of the ${name} instances.
  ******************************************************************************
  *
  * COPYRIGHT ${year} STMicroelectronics
  *
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
  ******************************************************************************
  */#n
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${name?lower_case}_H
#define __${name?lower_case}_H
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

[#list ipvar.instances.entrySet() as entry]
        [#if halModeList?contains(entry.value)]
        [#else]
            [#assign halModeList = halModeList + " " +entry.value]
        [/#if]
[/#list]

[#list IP.configModelList as instanceData]
        [#assign instName = instanceData.instanceName]
        [#assign instMode= instanceData.halMode]
		[#assign ipName = instanceData.ipName]
/* ${ipName} init function */	
[#--[#if instMode!=instName]void ${instMode}_${instName}_Init(void);[#else]void MX_${instName}_Init(void);[/#if]--]
void MX_${ipName}_Init(void);
[/#list]
[#list halModeList?split(" ") as mode]
[#if mode !=""]
void HAL_${mode}_BspInit(${mode}_HandleTypeDef* h${mode?lower_case});
void HAL_${mode}_BspDeInit(${mode}_HandleTypeDef* h${mode?lower_case});
[/#if]
[/#list]

[/#list]

[#--void ${ipName}_Init(void);--]

#ifdef __cplusplus
}
#endif
#endif /*__${name?lower_case}_H */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
