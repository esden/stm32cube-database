[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : ${name}.h
  * Description        : This file provides code for the configuration
  *                      of the ${name}.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  *************************************************************************  

  */
/* USER CODE END Header */ 
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __mx_${name?lower_case}_H
#define __mx_${name?lower_case}_H
#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if includes??]
[#list includes as include]
#include "${include}"
[/#list]
[/#if]

/* Includes for RTOS ---------------------------------------------------------*/
#if WITH_RTOS
#include "lwip/tcpip.h"
#endif /* WITH_RTOS */

[#list IPdatas as IP]  
[#assign ipvar = IP]
[#-- Global variables --]

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/* Global Variables ----------------------------------------------------------*/
[#if IP.variables??]
	[#list IP.variables as variable]
		[#if variable.name == "heth"]
extern ${variable.value} ${variable.name};
		[/#if]
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

#if !WITH_RTOS
/* USER CODE BEGIN 1 */
/* Function defined in lwip.c to:
 *   - Read a received packet from the Ethernet buffers 
 *   - Send it to the lwIP stack for handling
 *   - Handle timeouts if NO_SYS_NO_TIMERS not set
 */ 
void MX_LWIP_Process(void);

/* USER CODE END 1 */
#endif /* WITH_RTOS */

#ifdef __cplusplus
}
#endif
#endif /*__ mx_${name?lower_case}_H */

/**
  * @}
  */

/**
  * @}
  */
