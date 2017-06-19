[#ftl]
[#compress]
[#assign CMSIS_version = "1.00"]

[#list SWIPdatas as SWIP]
  [#if SWIP.variables??]
	[#list SWIP.variables as variable]
	  [#if variable.name=="CMSIS_version"]
        [#assign CMSIS_version = variable.value]
	  [/#if]
    [/#list]
  [/#if]
[/#list]

/* Start scheduler */
#tvTaskStartScheduler();

[/#compress]
