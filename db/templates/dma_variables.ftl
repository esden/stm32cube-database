[#ftl]
[#if variables??]
[#list variables as variable]
${variable.value} ${variable.name};
[/#list]
[/#if]