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
[#if Bsp_Common_DEMO?? && Bsp_Common_DEMO == "true"]
[#compress]
[#if (BUTTON?? && BUTTON == "1") || (BUTTON2?? && BUTTON2 == "1") || (BUTTON3?? && BUTTON3 == "1") || (BUTTON4?? && BUTTON4 == "1")][#--EXTI--]
  /**
  #t* @brief EXTI line detection callback.
  #t* @param GPIO_Pin: Specifies the pins connected EXTI line
  #t* @retval None
  #t*/
  void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
  {
    #tswitch(GPIO_Pin)
    #t{
    [#if (BUTTON?? && BUTTON == "1")]
      #t#tcase BUTTON_SW1_PIN:
          #t#t#t/* Change the period from 500ms to 250ms or 250ms to 500ms */
          #t#t#tdelay = (delay == 250) ? 500 : 250;
          #t#t#tbreak;
    #t}
    [/#if]
  }
  [/#if]
[/#compress]
[/#if]
