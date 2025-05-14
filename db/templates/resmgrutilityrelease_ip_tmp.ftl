[#ftl]
[#-- ----------------------------------------------------------------- --]

[#macro generateResMgrCode(RESMGR_ID, valueResMgrRequest )]
    #n
    #tif (ResMgr_Release(RESMGR_RESOURCE_RIFSC,RESMGR_RIFSC_${valueResMgrRequest}_ID) != RESMGR_STATUS_ACCESS_OK)
    #t{

    #t#tError_Handler();

    #t}
[/#macro]

[#-- ----------------------------------------------------------------- --]
[#compress]
[#assign valueCore = ""]
[#assign valueList = RESMGR_REQUEST.split(" ")]
[#assign resMgrRequest = valueList[0]]

[#if resMgrRequest?? && resMgrRequest!=""]
[#if resMgrRequest?contains("ADC1")] [#assign resMgrRequest= "ADC12"][#else] [#assign resMgrRequest=resMgrRequest] [/#if]
    [@generateResMgrCode RESMGR_ID="RESMGR_RESOURCE_RIFSC" valueResMgrRequest=resMgrRequest/]
[/#if]

[#list IPdatas as IP]
    [#list IP.configModelList as configModel]
        [#list configModel.refConfigFiles as refConfigFile]
            [#if refConfigFile.fileName == "resmgrutilityrelease_" + resMgrRequest + ".tmp"]
                [#assign valueCore = ""]
                [#assign resMgr_Request = ""]
                [#assign resMgr_Id = ""]

                [#list refConfigFile.arguments as argument]
                    [#if argument.name?? && (argument.name?contains("RESMGR_REQUEST_") || argument.name?contains("RESMGR_RESOURCE_REQUEST_")) && argument.value?? && argument.value!=""]
                        [#assign valueList = argument.value.split(" ")]
                        [#if valueList?size == 2]
                            [#assign valueCore = valueList[1]]
                            [#assign resMgr_Request = valueList[0]]
                        [#else]
                            [#assign resMgr_Request = argument.value]
                        [/#if]
                    [/#if]
                [/#list]

            [/#if]
        [/#list]
    [/#list]
[/#list]
[/#compress]
