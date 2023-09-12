[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : ${name?lower_case}.h
  * Description        : This file provides code for the configuration
  *                      of the ${name?lower_case} instances.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#-- 'UserCode sections' are indexed dynamically --]
[#assign userCodeIdx = 0]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${name?lower_case}_H
#define __${name?lower_case}_H
#ifdef __cplusplus
  extern "C" {
#endif

[#compress]
    /* Includes ------------------------------------------------------------------*/
    [#if includes??]
        [#list includes as include]
            #include "${include}"
        [/#list]
    [/#if]

    #n/* USER CODE BEGIN ${userCodeIdx} */
    /* USER CODE END ${userCodeIdx} */
    [#assign userCodeIdx = userCodeIdx+1]

    #n/* Global variables ---------------------------------------------------------*/
    [#list IPdatas as IP]
        [#assign ipvar = IP]
        [#-- Global variables --]
        [#if IP.variables??]
            [#list IP.variables as variable]
                extern ${variable.value} ${variable.name};
            [/#list]
        [/#if]

        #n/* USER CODE BEGIN ${userCodeIdx} */
        /* USER CODE END ${userCodeIdx} */
        [#assign userCodeIdx = userCodeIdx+1]

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
            #n/* ${ipName} init function */
            void MX_${ipName}_Init(void);
        [/#list]

    [/#list]
[/#compress]

[#--void ${ipName}${instName}_Init(void);--]

/* USER CODE BEGIN ${userCodeIdx} */
/* USER CODE END ${userCodeIdx} */
[#assign userCodeIdx = userCodeIdx+1]

[#if FamilyName=="STM32H7"]
#n/* Resource Manager send message function */
void MX_${ipName}_SendMsg(uint32_t id, uint32_t msg);

#n/* Resource Manager callback function */
void MX_${ipName}_Callback(uint32_t id, uint32_t msg);
[/#if]

#ifdef __cplusplus
}
#endif
#endif /*__${name?lower_case}_H */

/**
  * @}
  */

