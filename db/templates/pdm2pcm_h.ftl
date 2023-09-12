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
 #include "main.h"
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
            #n/* ${ipName}${instName} init function */
            void MX_${ipName}${instName}_Init(void);
            #n/* USER CODE BEGIN ${userCodeIdx} */
            #n/* ${ipName}${instName} process function */
            uint8_t MX_${ipName}${instName}_Process(uint16_t *PDMBuf, uint16_t *PCMBuf);
            #n/* USER CODE END ${userCodeIdx} */
            [#assign userCodeIdx = userCodeIdx+1]
        [/#list]

        [#list halModeList?split(" ") as mode]
            [#if mode !=""]
                void HAL_${mode}_BspInit(${mode}_HandleTypeDef* h${mode?lower_case});
                void HAL_${mode}_BspDeInit(${mode}_HandleTypeDef* h${mode?lower_case});
            [/#if]
        [/#list]

    [/#list]
[/#compress]

[#--void ${ipName}${instName}_Init(void);--]

/* USER CODE BEGIN ${userCodeIdx} */
/* USER CODE END ${userCodeIdx} */
[#assign userCodeIdx = userCodeIdx+1]

#ifdef __cplusplus
}
#endif
#endif /*__${name?lower_case}_H */

/**
  * @}
  */
