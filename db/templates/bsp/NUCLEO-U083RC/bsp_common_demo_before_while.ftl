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

[#if Bsp_Common_DEMO?? && Bsp_Common_DEMO == "true"]
  /* USER CODE BEGIN BSP */
  
  [#if VCP == "true"]
  /* -- Sample board code to send message over COM1 port ---- */
  printf("Welcome to STM32 world !\n\r");
  [/#if]

  [#if LED4?? && LED4 == "true"]
  /* -- Sample board code to switch on leds ---- */
  BSP_LED_On(LED_GREEN);
  [/#if]
  
  /* USER CODE END BSP */
  
[/#if]