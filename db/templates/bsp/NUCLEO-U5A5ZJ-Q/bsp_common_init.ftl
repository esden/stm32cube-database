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
#t/* Initialize leds */
[#if (LED1?? && LED1 == "true")]
  #tBSP_LED_Init(LED_GREEN);
[/#if]

[#if LED2?? && LED2 == "true"]
  #tBSP_LED_Init(LED_RED);
[/#if]

[#if LED3?? && LED3 == "true"]
  #tBSP_LED_Init(LED_BLUE);
[/#if]

[/#compress]
#n
[#if BUTTON == "1"][#--EXTI--]
  /* Initialize USER push-button, will be used to trigger an interrupt each time it's pressed.*/
  BSP_PB_Init(BUTTON_USER, BUTTON_MODE_EXTI);
[#elseif BUTTON == "2"]
  /* Initialize User push-button without interrupt mode. */
  BSP_PB_Init(BUTTON_USER, BUTTON_MODE_GPIO);
[/#if]

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