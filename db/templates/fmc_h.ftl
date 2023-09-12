[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : ${name}.h
  * Description        : This file provides code for the configuration
  *                      of the ${name} peripheral.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${name?upper_case}_H
#define __${name?upper_case}_H
#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if includes??]
#include "main.h"

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
#n
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */
#n
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
[#compress]
#n/* USER CODE BEGIN Prototypes */
#n     
/* USER CODE END Prototypes */
#n
[/#compress]

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
