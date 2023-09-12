[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name?lower_case}.h
  * @brief   This file contains all the function prototypes for
  *          the ${name?lower_case}.c file
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${name}_H__
#define __${name}_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#compress]
#include "main.h"

[#if H7_ETH_NoLWIP?? && !HALCompliant??]
#include "string.h"
[/#if]

[#if RESMGR_UTILITY??]
#include "res_mgr_conf.h"
#include "res_mgr.h"
[/#if]
[/#compress]

#n
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */
#n

[#list IPdatas as IP]
[#assign var1= ""]  
[#assign ipvar = IP]
[#-- Global variables --]
[#if IP.variables??]
[#list IP.variables as variable]
[#-- Tracker 276386 -- GetHandle Start --]
[#--${variable.value}* MX_${variable.name?replace("h","")?upper_case}_GetHandle(void);--]
[#-- Tracker 276386 -- GetHandle End --]

[#if !variable.value?contains("static const") && !variable.value?contains("uint")]
extern ${variable.value} ${variable.name};
[#assign var1= var1+" " + variable.name]
[/#if]

[/#list]
[/#if]
[#list IP.configModelList as instanceData]
        [#assign instName = instanceData.instanceName]
        [#assign halMode= instanceData.halMode]
[#if instanceData.ipName?contains("TAMP") && !(instanceData.usedDriver == "LL")&& !var1?contains("hrtc")]
extern RTC_HandleTypeDef hrtc;
[/#if]
[/#list]

[#-- Global variables --]

#n
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */
#n

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
[@common.getMspPostInit/]
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

#endif /* __${name}_H__ */

