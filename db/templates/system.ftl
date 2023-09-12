[#ftl]
[#compress]
[#if systemConfig??]
[#list systemConfig as config]
 [#assign listOfLocalVariables =""]
        [#assign resultList =""] 	
[@common.getLocalVariableList instanceData=config/] 
[/#list]
[/#if]
[#if clock??]
    [#list clock as clk]
        [#if clk!=""]
#t${clk}[#if !clk?contains('(')]()[/#if];
        [/#if]
    [/#list]
[/#if]
#n
 [#if NVICPriorityGroup??]
    [#if isHALUsed??]
    #t/* System interrupt init*/
    #t HAL_NVIC_SetPriorityGrouping(${NVICPriorityGroup});#n
    [#else]
    #t/* System interrupt init*/
    #tNVIC_SetPriorityGrouping(${NVICPriorityGroup});#n
    [/#if]
  [/#if]
[#-- configure system interrupts (RCC, systick, ...) --]
[#if systemVectors??]
[#assign systemHandlers = false]
[#assign firstSystemInterrupt = true]
[#assign firstPeripheralInterrupt = true]
[#list systemVectors as initVector] 
    [#if initVector.systemHandler=="true"]
    [#assign systemHandlers = true]
    [#if firstSystemInterrupt]
    [#assign firstSystemInterrupt = false]
    
    [/#if]
    [#elseif firstPeripheralInterrupt]
    [#assign firstPeripheralInterrupt = false]
    [#if systemHandlers]
    #n
    [/#if]
    #n#t/* Peripheral interrupt init*/
    [/#if]
    [#if initVector.codeInMspInit]
        [#if initVector.systemHandler=="false" || initVector.preemptionPriority!="0" || initVector.subPriority!="0"]
    #t/* ${initVector.vector} interrupt configuration */
        [#if NVICPriorityGroup??]
    #tNVIC_SetPriority(${initVector.vector}, NVIC_EncodePriority(NVIC_GetPriorityGrouping(),${initVector.preemptionPriority}, ${initVector.subPriority}));
        [#else]
    #tNVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority});
        [/#if]
        [/#if]
        [#if initVector.systemHandler=="false"]
    #tNVIC_EnableIRQ(${initVector.vector});
        [/#if]
    [/#if]
[/#list]
[/#if]
#n
[#-- Sys configuration --]
[#if systemConfig??]
[#list systemConfig as config]
[@common.generateConfigModelListCode configModel=config inst="SYS"  nTab=1 index=""/]
[/#list]
[/#if]
#n



[/#compress]

