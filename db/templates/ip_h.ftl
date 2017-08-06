[#ftl]
/**
  ******************************************************************************
  * File Name          : ${name}.h
  * Description        : This file provides code for the configuration
  *                      of the ${name} instances.
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
#n
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */
#n
[#list IPdatas as IP]  
[#assign ipvar = IP]
[#-- Global variables --]
[#if IP.variables??]
[#list IP.variables as variable]
[#-- Tracker 276386 -- GetHandle Start --]
[#--${variable.value}* MX_${variable.name?replace("h","")?upper_case}_GetHandle(void);--]
[#-- Tracker 276386 -- GetHandle End --]
extern ${variable.value} ${variable.name};
[/#list]
[/#if]
[#-- Global variables --]

#n
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */
#n
extern void Error_Handler(void);
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
        [#assign halMode= instanceData.halMode]
[#if halMode!=instanceData.realIpName&&!instanceData.ipName?contains("TIM")&&!instanceData.ipName?contains("CEC")]void MX_${instName}_${halMode}_Init(void);[#else]void MX_${instName}_Init(void);[/#if]
[/#list]
[#list halModeList?split(" ") as mode]
[/#list]
[/#list]
[#-- PostInit declaration --]
[#assign postinitList = ""]
[#list IPdatas as IP]  
[#list IP.configModelList as instanceData]
[#if instanceData.initServices??]
    [#if instanceData.initServices.gpioOut??]
        [#list instanceData.initCallBackInitMethodList as initCallBack]
            [#if initCallBack?contains("PostInit")]
            [#assign halMode = instanceData.halMode]
                [#assign ipName = instanceData.ipName]
                [#assign ipInstance = instanceData.instanceName]
                [#if halMode!=ipName&&!ipName?contains("TIM")&&!ipName?contains("CEC")]
                    [#if !postinitList?contains(initCallBack)]
                    #nvoid ${initCallBack}(${instanceData.halMode}_HandleTypeDef *h${instanceData.halMode?lower_case});
                    [#assign postinitList = postinitList+" "+initCallBack]
                    [/#if]
                [#else]
                    [#if !postinitList?contains(initCallBack)]
                    #nvoid ${initCallBack}([#if ipName?contains("TIM")&&!(ipName?contains("HRTIM")||ipName?contains("LPTIM"))]TIM_HandleTypeDef *htim[#else]${ipName}_HandleTypeDef *h${ipName?lower_case}[/#if]);
                    [#assign postinitList = postinitList+" "+initCallBack]
                     [/#if]
                [/#if]
                [#break] [#-- take only the first PostInit : case of timer--]
            [/#if]
        [/#list]
    [/#if]
[/#if]
[/#list]

[/#list]
[#-- PostInit declaration : End --]
[#compress]
#n/* USER CODE BEGIN Prototypes */
#n     
/* USER CODE END Prototypes */
#n
[/#compress]
#ifdef __cplusplus
}
#endif
#endif /*__ ${name?lower_case}_H */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/