[#ftl]
[#list SWIPdatas as SWIP]
    [#assign instName = SWIP.ipName]
    [#assign fileName = SWIP.fileName]
    [#assign version = SWIP.version]

    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name=="LD1"]
                [#assign LED1 = definition.value]
            [/#if]
            [#if definition.name=="LD2"]
                [#assign LED2 = definition.value]
            [/#if]
            [#if definition.name=="LD3"]
                [#assign LED3 = definition.value]
            [/#if]
            [#if definition.name=="LD4"]
                [#assign LED4 = definition.value]
            [/#if]
            [#if definition.name=="BUTTON"]
                [#assign BUTTON = definition.value]
            [/#if]
			[#if definition.name=="BUTTON2"]
                [#assign BUTTON2 = definition.value]
            [/#if]
			[#if definition.name=="BUTTON3"]
                [#assign BUTTON3 = definition.value]
            [/#if]
			[#if definition.name=="BUTTON4"]
                [#assign BUTTON4 = definition.value]
            [/#if]
            [#if definition.name=="VCP"]
                [#assign VCP = definition.value]
            [/#if]
            [#if definition.name=="Bsp_Common_DEMO"]
                [#assign Bsp_Common_DEMO = definition.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]

[#if Bsp_Common_DEMO?? && Bsp_Common_DEMO == "true"  ]
[#compress]
[#if (BUTTON?? && BUTTON == "1") || (BUTTON2?? && BUTTON2 == "1") || (BUTTON3?? && BUTTON3 == "1") || (BUTTON4?? && BUTTON4 == "1")][#--GPIO--]
    #t#t/* -- Sample board code for User push-button in interrupt mode ---- */
  [/#if]
[#if BUTTON == "1"]
    #t#tBSP_LED_Toggle(LED_BLUE);
    #t#tHAL_Delay(delay);
    #n
[/#if]
[#if BUTTON2 == "1"]
    #t#tBSP_LED_Toggle(LED_GREEN);
    #t#tHAL_Delay(delay);
    #n
[/#if]
[#if BUTTON3 == "1"]
    #t#tBSP_LED_Toggle(LED_RED);
    #t#tHAL_Delay(delay);
    #n
[/#if]

[#if (BUTTON?? && BUTTON == "2") || (BUTTON2?? && BUTTON2 == "2") || (BUTTON3?? && BUTTON3 == "2") || (BUTTON4?? && BUTTON4 == "2")][#--GPIO--]
#t#t/* -- Sample board code for User push-button without interrupt mode ---- */
[/#if]
[#if BUTTON == "2"]
    #t#tBSP_LED_Toggle(LED_BLUE);
    #t#tHAL_Delay(delay);
    #t#tif (BSP_PB_GetState(B1) == 1)
    #t#t{
    [#if  LED1?? && LED1 == "true"]
              #t#t#tdelay = 100;
    [/#if]
    #t#t#t/* ..... Perform your action ..... */
    #t#t}
    #n
[/#if]
[#if BUTTON2 == "2"]
    #t#tBSP_LED_Toggle(LED_GREEN);
    #t#tHAL_Delay(delay);
    #t#tif (BSP_PB_GetState(B2) == 1)
    #t#t{
    [#if  LED2?? && LED2 == "true"]
              #t#t#tdelay = 500;
    [/#if]
    #t#t#t/* ..... Perform your action ..... */
    #t#t}
    #n
[/#if]
[#if BUTTON3 == "2"]
    #t#tBSP_LED_Toggle(LED_RED);
    #t#tHAL_Delay(delay);
    #t#tif (BSP_PB_GetState(B3) == 1)
    #t#t{
    [#if  LED3?? && LED3 == "true"]
              #t#t#tdelay = 1000;
    [/#if]
    #t#t#t/* ..... Perform your action ..... */
    #t#t}
    #n
[/#if]
[/#compress]
[/#if]
