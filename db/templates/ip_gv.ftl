[#ftl]
[#list IPdatas as IP]  
[#-- Global variables --]
[#if IP.variablesForMw??]
[#list IP.variablesForMw as variable]
[#assign ipname= IP.ipName]
[#if variable.name?contains(ipname)]
${variable.value} ${variable.name};
[/#if]
[/#list]
[/#if]
[#-- Global variables --]
[/#list]
void _Error_Handler(char * file, int line);