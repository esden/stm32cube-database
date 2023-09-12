[#ftl]

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
[#--extern ${variable.value} ${variable.name}; --]
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
/* ${instName} part */	
extern uint8_t ${instName}_DriverNum;
extern FATFS ${instName}_FatFs;
extern Diskio_drvTypeDef ${instName}_Driver;
[/#list]
[/#list]
