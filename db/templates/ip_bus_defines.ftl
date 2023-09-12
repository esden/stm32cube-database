[#ftl]
[#if BUS_DEFINES??][#-- BUS driver defines declaration --]
[#assign defines = BUS_DEFINES.get(0)]
[#list defines.entrySet() as define]
#define ${define.key} ${define.value}
[/#list]
[/#if]