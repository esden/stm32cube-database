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
[#compress]
	[#if (LED1??&& LED1=="true") || (LED2??&& LED2=="true") || (LED3??&& LED3=="true") || (LED4??&& LED4=="true") ]
		#t/* Initialize leds */
        [#if  LED1?? && LED1 == "true"]
			#tBSP_LED_Init(LED_BLUE);
		[/#if]
		 [#if  LED2?? && LED2 == "true"]
			#tBSP_LED_Init(LED_GREEN);
		[/#if]
		[#if  LED3?? && LED3 == "true"]
			#tBSP_LED_Init(LED_RED);
		[/#if]
		
	[/#if] 
#n
[#if (BUTTON?? && BUTTON == "1") || (BUTTON2?? && BUTTON2 == "1") || (BUTTON3?? && BUTTON3 == "1") || (BUTTON4?? && BUTTON4 == "1")][#--GPIO--]
    #t/* Initialize USER push-button, will be used to trigger an interrupt each time it's pressed.*/
  [#if BUTTON == "1"][#--EXTI--]
    #tBSP_PB_Init(B1, BUTTON_MODE_EXTI);
  [/#if]
  [#if BUTTON2 == "1"][#--EXTI--]
    #tBSP_PB_Init(B2, BUTTON_MODE_EXTI);
  [/#if]
  [#if BUTTON3 == "1"][#--EXTI--]
    #tBSP_PB_Init(B3, BUTTON_MODE_EXTI);
  [/#if]
#n
[/#if]

[#if (BUTTON?? && BUTTON == "2") || (BUTTON2?? && BUTTON2 == "2") || (BUTTON3?? && BUTTON3 == "2") || (BUTTON4?? && BUTTON4 == "2")][#--GPIO--]
    #t/* Initialize User push-button without interrupt mode. */
  [#if BUTTON == "2"]
    #tBSP_PB_Init(B1, BUTTON_MODE_GPIO);
  [/#if]
  [#if BUTTON2 == "2"]
    #tBSP_PB_Init(B2, BUTTON_MODE_GPIO);
  [/#if]
  [#if BUTTON3 == "2"]
    #tBSP_PB_Init(B3, BUTTON_MODE_GPIO);
  [/#if]
#n
[/#if]
[/#compress]
#n
[#if VCP == "true"]
  /* Initialize COM1 port (115200, 8 bits (7-bit data + 1 stop bit), no parity */
  BspCOMInit.BaudRate   = 115200;
  BspCOMInit.WordLength = COM_WORDLENGTH_8B;
  BspCOMInit.StopBits   = COM_STOPBITS_1;
  BspCOMInit.Parity     = COM_PARITY_NONE;
  BspCOMInit.HwFlowCtl  = COM_HWCONTROL_NONE;
  if (BSP_COM_Init(COM1, &BspCOMInit) != BSP_ERROR_NONE)
  {
    Error_Handler();
  }
[/#if]
