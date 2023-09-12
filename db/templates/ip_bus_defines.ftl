[#ftl]
[#assign coreDir=""]

[#assign coreDir=sourceDir]
[#if cpucore!="" && (contextFolder=="" || contextFolder=="/")]
[#assign contextFolder = cpucore?replace("ARM_CORTEX_","C")+"/"]
[/#if]

[#if BUS_DEFINES??][#-- BUS driver defines declaration --]
[#if BUS_DEFINES.get(0)??]
[#assign defines = BUS_DEFINES.get(0)]
[#list defines.entrySet() as define]
#define ${define.key} ${define.value}
[/#list]
[/#if]
[/#if]

[#if IoList??]
    [#list IoList as io]
[@common.optinclude name=contextFolder+mxTmpFolder+"/"+io?lower_case+"_define.tmp"/][#--include io configuration --]
#n
    [/#list]
[/#if]