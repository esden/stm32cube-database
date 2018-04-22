[#ftl]
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
        [#if FMCUsedWithMW == "true"]
            [#if hsram1??]
SRAM_HandleTypeDef hsram1;
            [/#if]
            [#if hsram2??]
SRAM_HandleTypeDef hsram2;
            [/#if]
            [#if hsram3??]
SRAM_HandleTypeDef hsram3;
            [/#if]
            [#if hsram4??]
SDRAM_HandleTypeDef hsram4;
            [/#if]
            [#if hsdram1??]
SDRAM_HandleTypeDef hsdram1;
            [/#if]
            [#if hsdram2??]
SDRAM_HandleTypeDef hsdram2;
            [/#if]
        [/#if]
    [/#if]
[/#list]
