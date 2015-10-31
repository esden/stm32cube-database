[#ftl]

[#list IPdatas as IP]
[#-- Global variables --]
[#if IP.variables??]
  [#list IP.variables as variable]
${variable.value} ${variable.name};
  [/#list]
[/#if]
[#-- Global variables --]#n
[/#list]
