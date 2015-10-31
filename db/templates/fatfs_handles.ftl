[#ftl]
/**
  ******************************************************************************
  * File Name          : ${name}
  * Date               : ${date}
  * Description        : This file provides code for the IP handles used by FATFS
  * Version			   : ${version}
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
  *
  ******************************************************************************
  */
[#assign s = name]
[#assign temp = s?replace(".","__")]
[#assign inclusion_protection = temp?upper_case]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${inclusion_protection}__
#define __${inclusion_protection}__

#ifdef __cplusplus
 extern "C" {
#endif

[#-- SWIPdatas is a list of SWIPconfigModel --]  
[#list SWIPdatas as SWIP]  

[#-- Global variables --]
[#assign instName = SWIP.ipName]   
[#assign fileName = SWIP.fileName]   
[#assign version = SWIP.version]   

[#if SWIP.defines??]
	[#list SWIP.defines as definition]	
/*---------- [#if definition.comments??]${definition.comments} [/#if] -----------*/
#define ${definition.name} #t#t ${definition.value} 
[#if definition.description??]${definition.description} [/#if]
	[/#list]
[/#if]

[/#list]

#ifdef __cplusplus
}
#endif
#endif /*__ ${inclusion_protection}__ */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
