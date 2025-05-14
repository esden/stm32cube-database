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
[#if BUTTON == "1"]
        #t#t/* -- Sample board code for User push-button in interrupt mode ---- */
        #t#tif (BspButtonState == BUTTON_PRESSED)
        #t#t{
        #t#t#t/* Update button state */
        #t#t#tBspButtonState = BUTTON_RELEASED;
        [@toggle_Leds/]
        #t#t#t/* ..... Perform your action ..... */
        #t#t}
    [#elseif BUTTON == "2"]
        #t#t/* -- Sample board code for User push-button without interrupt mode ---- */
        #t#tif (BSP_PB_GetState(BUTTON_USER) == BUTTON_PRESSED)
        #t#t{
        [@toggle_Leds/]
        #t#t#t/* ..... Perform your action ..... */
        #t#t}
    [/#if]
[/#compress]
[/#if]

[#macro toggle_Leds]
  [#if (LED1??&& LED1=="true") || (LED2??&& LED2=="true") || (LED3??&& LED3=="true") || (LED4??&& LED4=="true") ]
  #t#t#t/* -- Sample board code to toggle led ---- */
  
  [#if  LED2?? && LED2 == "true"]
      #t#t#tBSP_LED_Toggle(LED_GREEN);
     [/#if]
  
  
  #n
  [/#if]
[/#macro]
