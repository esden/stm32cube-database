[#ftl]

[#-- ----------------------------------------------------------------- --]

[#function getResmgr_Flags_Cpu(valueCore)]
    [#assign valueResMgrCpu = ""]
    [#if FamilyName=="STM32MP1"]
        [#-- RESMGR_FLAGS_CPU2, CortexM4 for STM32MP1 - second API version --]
        [#assign valueResMgrCpu = "RESMGR_FLAGS_CPU2"]
    [#elseif FamilyName=="STM32H7"]
        [#-- RESMGR_FLAGS_CPU1, CortexM7 for STM32H7 - second API version --]
        [#-- RESMGR_FLAGS_CPU2, CortexM4 for STM32H7 - second API version --]
        [#if valueCore?contains("CortexM7")]
            [#assign valueResMgrCpu = "RESMGR_FLAGS_CPU1"]
        [#elseif valueCore?contains("CortexM4")]
            [#assign valueResMgrCpu = "RESMGR_FLAGS_CPU2"]
        [/#if]
    [/#if]
   [#return valueResMgrCpu]
[/#function]

[#-- ----------------------------------------------------------------- --]

[#macro generateResMgrCode(RESMGR_ID, valueResMgrRequest, valueResMgrCpu)]
    #tif (ResMgr_Request(RESMGR_ID_${RESMGR_ID}, RESMGR_FLAGS_ACCESS_NORMAL | \
    #t#t#t#t#t#t#t#t#t${valueResMgrCpu} , 0, NULL) != RESMGR_OK)
    #t{
    #t#t/* USER CODE BEGIN RESMGR_UTILITY_${valueResMgrRequest} */
    #t#tError_Handler();
    #t#t/* USER CODE END RESMGR_UTILITY_${valueResMgrRequest} */
    #t}
[/#macro]

[#-- ----------------------------------------------------------------- --]
[#compress]
[#assign valueCore = ""]
[#assign valueList = RESMGR_REQUEST.split(" ")]
[#if valueList?size == 2]
    [#assign valueCore = valueList[1]]
[/#if]
[#assign resMgrRequest = valueList[0]]
[#assign resMgrCpu = getResmgr_Flags_Cpu(valueCore)]

[#if resMgrRequest?? && resMgrRequest!="" && RESMGR_ID?? && RESMGR_ID!=""]
    [@generateResMgrCode RESMGR_ID=RESMGR_ID valueResMgrRequest=resMgrRequest valueResMgrCpu=resMgrCpu/]
[/#if]

[#list IPdatas as IP]
    [#list IP.configModelList as configModel]
        [#list configModel.refConfigFiles as refConfigFile]
            [#if refConfigFile.fileName == "resmgrutility_" + resMgrRequest + ".tmp"]
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
                        [#assign resMgrCpu = getResmgr_Flags_Cpu(valueCore)]

                        [#if resMgr_Request?? && resMgr_Request!=""]
                            [@generateResMgrCode RESMGR_ID=resMgr_Request valueResMgrRequest=resMgr_Request valueResMgrCpu=resMgrCpu/]
                        [/#if]
                    [/#if]
                [/#list]

            [/#if]
        [/#list]
    [/#list]
[/#list]
[/#compress]
