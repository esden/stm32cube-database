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
    [/#list]
  [/#if]
[/#list]


[#if BUTTON == "1"]
/* BEGIN_MX_CODEGEN  BUTTON_MODE_EXTI code */
/**
  * @brief  This function handles external line 13 interrupt request.
  * @retval None
  */
void EXTI13_IRQHandler(void)
{
#tBSP_PB_IRQHandler(BUTTON_USER);
}
/* END_MX_CODEGEN  BUTTON_MODE_EXTI code */
[/#if]