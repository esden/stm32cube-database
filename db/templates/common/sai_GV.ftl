[#ftl]
[#-- Global variables --]
[#list IPdatas as IP]  
[#if IP.variables??]
[#list IP.variables as variable]
${variable.value} ${variable.name};
[/#list]
[/#if]
[/#list]