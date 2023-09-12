[#ftl]

[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name?? && definition.name?contains("RESMGR_REQUEST_") && definition.value??]
                [#assign valueResMgrRequest = definition.value.split(" ")[0]]
            [/#if]
        [/#list]
    [/#if]
    [#if valueResMgrRequest?? && valueResMgrRequest!=""]
                #tif (ResMgr_Request(RESMGR_ID_${valueResMgrRequest}, RESMGR_FLAGS_ACCESS_NORMAL | \
                #t#t#t#t#t#t#t#t#t                          RESMGR_FLAGS_CPU_SLAVE , 0, NULL) != RESMGR_OK)
                #t{
                #t#t/* USER CODE BEGIN RESMGR_UTILITY_${valueResMgrRequest} */
                #t#tError_Handler();
                #t#t/* USER CODE END RESMGR_UTILITY_${valueResMgrRequest} */
                #t}
    [/#if]
[/#list]