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
      [#if definition.name=="LCD_TC_ON"]
      [#assign LCD_TC_ON = definition.value]
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

  [#if LED1?? && LED1 == "true"]
  /* -- Sample board code to switch on leds ---- */
  BSP_LED_On(LED_GREEN);
  [/#if]
  [#if LED2?? && LED2 == "true"]
  BSP_LED_On(LED_ORANGE);
  [/#if]
  [#if LED3?? && LED3 == "true"]
  BSP_LED_On(LED_RED);
  [/#if]
  [#if LED3?? && LED3 == "true"]
  BSP_LED_On(LED_BLUE);
  [/#if]

  [#if LCD_TC_ON == "true"]
  /* Demo code for LCD utilities functions */
  UTIL_LCD_SetFuncDriver(&LCD_Driver);
  UTIL_LCD_SetFont(&Font16);
  UTIL_LCD_Clear(UTIL_LCD_COLOR_ST_BLUE_DARK);
  UTIL_LCD_SetBackColor(UTIL_LCD_COLOR_ST_BLUE_DARK);
  UTIL_LCD_SetTextColor(UTIL_LCD_COLOR_WHITE);
  UTIL_LCD_DisplayStringAt(0, 25, (uint8_t *)"Welcome to", CENTER_MODE);
  UTIL_LCD_DisplayStringAt(0, 50, (uint8_t *)"STM32 world !", CENTER_MODE);
  [/#if]

  /* USER CODE END BSP */
[/#if]
