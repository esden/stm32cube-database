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
  [#if BUTTON == "1"][#--EXTI--]
/**
  * @brief  BSP Push Button callback
  * @param  Button Specifies the pressed button
  * @retval None
  */
void BSP_PB_Callback(Button_TypeDef Button)
{
  if (Button == BUTTON_USER)
  {
    BspButtonState = BUTTON_PRESSED;
  }
}
  [/#if]

[#if (LCD_TC_ON?? && LCD_TC_ON == "true")]
/**
  * @brief  BSP TS Callback.
  * @param  Instance TS Instance.
  * @retval None.
  */
void BSP_TS_Callback(uint32_t Instance)
{
  BSP_TS_GetState(0, &TS_State);
  if(TS_State.TouchDetected == 1)
  {
    TouchPressed = 1;
  }
}
[/#if]
[/#if]