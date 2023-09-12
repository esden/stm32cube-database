[#ftl]
[#assign valueResMgrRequest = ""]
[#assign requestId = ""]

[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name?? && definition.name?starts_with("RESMGR_REQUEST_") && definition.value??]
                [#assign valueResMgrRequest = definition.value.split(" ")[0]]
            [/#if]
            [#if definition.name?? && definition.name?starts_with("RESMGR_ID_")]
                [#assign requestId = definition.name.split("RESMGR_ID_")[1]]
            [/#if]
        [/#list]
    [/#if]
    [#if valueResMgrRequest?? && valueResMgrRequest!=""]
                #tif (ResMgr_Request(RESMGR_ID_${requestId}, RESMGR_FLAGS_ACCESS_NORMAL | \
                #t#t#t#t#t#t#t#t#t                          RESMGR_FLAGS_CPU_SLAVE , 0, NULL) != RESMGR_OK)
                #t{
                #t#t/* USER CODE BEGIN RESMGR_UTILITY_${valueResMgrRequest} */
                #t#tError_Handler();
                #t#t/* USER CODE END RESMGR_UTILITY_${valueResMgrRequest} */
                #t}
    [/#if]
[/#list]