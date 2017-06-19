[#ftl]
/**
  ******************************************************************************
  * @file           : ${name}
  * @version        : ${version}
[#--  * @packageVersion : ${fwVersion} --]
  * @brief          : Header for usb_device file.
  ******************************************************************************
[@common.optinclude name="Src/license.tmp"/][#--include License text --]
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

/* USB_Device init function */	
[#--[#if instMode!=instName]void ${instMode}_${instName}_Init(void);[#else]void MX_${instName}_Init(void);[/#if]--]
void MX_USB_DEVICE_Init(void);

[/#list]


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
