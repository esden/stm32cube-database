[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : app_${name?lower_case}.h
  * Description        : This file provides code for the configuration
  *                      of the ${name?lower_case} instances.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __app_${name?lower_case}_H
#define __app_${name?lower_case}_H
#ifdef __cplusplus
 extern "C" {
#endif

[#-- 'UserCode sections' are indexed dynamically --]
[#assign userCodeIdx = 0]

/* Includes ------------------------------------------------------------------*/
[#if THREADX??]
#include <stdint.h>
#include "tx_api.h"
[/#if]
[#if includes??]
[#list includes as include]
[#if include != ""]
#include "${include}"
[/#if]
[/#list]
[/#if]

/* USER CODE BEGIN ${userCodeIdx} */
/* USER CODE END ${userCodeIdx} */
[#assign userCodeIdx = userCodeIdx+1]

/* Global variables ---------------------------------------------------------*/
[#list IPdatas as IP]
[#assign ipvar = IP]
[#-- Global variables --]
[#if IP.variables??]
	[#list IP.variables as variable]
extern ${variable.value} ${variable.name};
	[/#list]
[/#if]

/* USER CODE BEGIN ${userCodeIdx} */
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
/* ${ipName}${instName} init function */
[#if !THREADX??][#-- If AzRtos is not used --]
void MX_${ipName}${instName}_Init(void);
[#else]
uint32_t MX_${ipName}${instName}_Init(void *memory_ptr);
[/#if]
[/#list]
[#list halModeList?split(" ") as mode]
[#if mode !=""]
void HAL_${mode}_BspInit(${mode}_HandleTypeDef* h${mode?lower_case});
void HAL_${mode}_BspDeInit(${mode}_HandleTypeDef* h${mode?lower_case});
[/#if]
[/#list]

[/#list]

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

/**
  * @}
  */
