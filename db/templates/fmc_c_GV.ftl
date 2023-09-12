[#ftl]
[#assign FMCUsedWithMW = "false"] 
[#list IPdatas as IP]
[#-- Global variables --]
    [#if IP.variables??]
        [#list IP.variables as variable]
            ${variable.value} ${variable.name};
        [/#list] 
    [#-- Global variables --]#n      
      
        [#list IP.configModelList as instanceData]
            [#assign FMCUsedWithMW = "false"] 
            [#if instanceData.isMWUsed=="true"]  
                [#assign FMCUsedWithMW = "true"] 
            [/#if]
        [/#list]
        [#-- add  SRAM handler id used with MW --]
                [/#if]

[/#list]
[#if FMCUsedWithMW == "true"]
    [#if IPhandlers??]
        [#list IPhandlers as handler]
${handler.getHandlerType()} ${handler.getHandler()};
        [/#list]
    [/#if]
[/#if]