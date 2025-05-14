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
      [#if definition.name=="AUDIO_IN"]
          [#assign AUDIO_IN = definition.value]
      [/#if]
      [#if definition.name=="AUDIO_OUT"]
          [#assign AUDIO_OUT = definition.value]
      [/#if]
      [#if definition.name=="OCTOSPI_DEMO"]
          [#assign OCTOSPI_DEMO = definition.value]
      [/#if]
      [#if definition.name=="SD_CARD_DEMO"]
          [#assign SD_CARD_DEMO = definition.value]
      [/#if]
    [/#list]
  [/#if]
[/#list]
[#compress]
[#if (LED1?? && LED1 == "true")||(LED2?? && LED2 == "true") || (LED3?? && LED3 == "true")||(LED4?? && LED4 == "true")]
#t/* Initialize leds */
[/#if]
[#if (LED1?? && LED1 == "true")]
  #tBSP_LED_Init(LED_GREEN);
[/#if]

[#if LED2?? && LED2 == "true"]
  #tBSP_LED_Init(LED_ORANGE);
[/#if]

[#if LED3?? && LED3 == "true"]
  #tBSP_LED_Init(LED_RED);
[/#if]

[#if LED4?? && LED4 == "true"]
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

[#if (LCD_TC_ON?? && LCD_TC_ON == "true")]
  /* Initialize LCD to black */
  if (BSP_LCD_Init(0, LCD_ORIENTATION_LANDSCAPE) != BSP_ERROR_NONE)
  {
    Error_Handler();
  }

  /* Initialize Touch screen with interrupts */
  BspTSInit.Orientation = TS_ORIENTATION_LANDSCAPE;
  BspTSInit.Accuracy = 5;
  BspTSInit.Width = FT6X06_MAX_X_LENGTH;
  BspTSInit.Height = FT6X06_MAX_Y_LENGTH;
  if (BSP_TS_Init(0, &BspTSInit) != BSP_ERROR_NONE)
  {
    Error_Handler();
  }
  BSP_TS_EnableIT(0);
[/#if]

[#if AUDIO_IN == "true"]
  /* Initialize AUDIO IN (Analog) */
  BspAudioInInit.Device = AUDIO_IN_DEVICE_DIGITAL_MIC;
  BspAudioInInit.ChannelsNbr = 2;
  BspAudioInInit.SampleRate = AUDIO_FREQUENCY_16K;
  BspAudioInInit.BitsPerSample = AUDIO_RESOLUTION_16B;
  BspAudioInInit.Volume = 80;
  if (BSP_AUDIO_IN_Init(AUDIO_IN_DEVICE_DIGITAL_MIC, &BspAudioInInit) != BSP_ERROR_NONE)
  {
    Error_Handler();
  }
[/#if]

[#if AUDIO_OUT == "true"]
  /* Initialize AUDIO OUT (Headset) */
  BspAudioOutInit.Device = AUDIO_OUT_DEVICE_HEADPHONE;
  BspAudioOutInit.ChannelsNbr = 2;
  BspAudioOutInit.SampleRate = 16000;
  BspAudioOutInit.BitsPerSample = AUDIO_RESOLUTION_16B;
  BspAudioOutInit.Volume = 60;
  if(BSP_AUDIO_OUT_Init(0, &BspAudioOutInit) != BSP_ERROR_NONE)
  {
    Error_Handler();
  }
[/#if]

[#if OCTOSPI_DEMO == "true"]
  /* Initialize OCTAL NOR memory */
  BspOSPINORInit.InterfaceMode = BSP_OSPI_NOR_OPI_MODE;
  BspOSPINORInit.TransferRate = BSP_OSPI_NOR_DTR_TRANSFER;
  if (BSP_OSPI_NOR_Init(0, &BspOSPINORInit) != BSP_ERROR_NONE)
  {
    Error_Handler();
  }
[/#if]

[#if SD_CARD_DEMO == "true"]
  /* Initialize SD with detection under interrupt */
  BSP_SD_Init(0);
  BSP_SD_DetectITConfig(0);
[/#if]