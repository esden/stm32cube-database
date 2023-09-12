[#ftl]

[#assign valueList = RESMGR_REQUEST.split(" ")]
[#assign valueResMgrRequest = RESMGR_REQUEST.split(" ")[0]]
[#assign valueResMgrCpu = ""]

[#if FamilyName=="STM32MP1"]
    [#-- RESMGR_FLAGS_CPU_SLAVE, CortexM4 for STM32MP1 - first API version --]
    [#assign valueResMgrCpu = "RESMGR_FLAGS_CPU_SLAVE"]
[#elseif FamilyName=="STM32H7"]
    [#assign valueCore = ""]
    [#if valueList?size == 2]
        [#assign valueCore = RESMGR_REQUEST.split(" ")[1]]
    [/#if]
    [#-- RESMGR_FLAGS_CPU1, CortexM7 for STM32H7 - second API version --]
    [#-- RESMGR_FLAGS_CPU2, CortexM4 for STM32H7 - second API version --]
    [#if valueCore?contains("CortexM7")]
        [#assign valueResMgrCpu = "RESMGR_FLAGS_CPU1"]
    [#elseif valueCore?contains("CortexM4")]
        [#assign valueResMgrCpu = "RESMGR_FLAGS_CPU2"]
    [/#if]
[/#if]

[#if valueResMgrRequest?? && valueResMgrRequest!=""]
            #tif (ResMgr_Request(RESMGR_ID_${RESMGR_ID}, RESMGR_FLAGS_ACCESS_NORMAL | \
            #t#t#t#t#t#t#t#t#t                          ${valueResMgrCpu} , 0, NULL) != RESMGR_OK)
            #t{
            #t#t/* USER CODE BEGIN RESMGR_UTILITY_${valueResMgrRequest} */
            #t#tError_Handler();
            #t#t/* USER CODE END RESMGR_UTILITY_${valueResMgrRequest} */
            #t}
[/#if]
