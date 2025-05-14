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
    * @brief  BSP Push Button callback
    * @param  Button Specifies the pressed button
    * @retval None
    */
  void BSP_PB_Callback(Button_TypeDef Button)
  {
  #tswitch(Button)
      #t{
			[#if (BUTTON?? && BUTTON == "1")]
                	#t#tcase BUTTON_SW1:
                		#t#t#t/* Change the period to 100 ms */
                		#t#t#tdelay = 100;
                		#t#t#tbreak;
                [/#if]
			[#if (BUTTON2?? && BUTTON2 == "1")]
                	#t#tcase BUTTON_SW2:
                		#t#t#t/* Change the period to 500 ms */
                		#t#t#tdelay = 500;
                		#t#t#tbreak;
                 [/#if]
			[#if (BUTTON3?? && BUTTON3 == "1")]
                	#t#tcase BUTTON_SW3:
                		#t#t#t/* Change the period to 1000 ms */
                		#t#t#tdelay = 1000;
                		#t#t#tbreak;
                [/#if]
				#t#tdefault:
                	#t#t#tbreak;
        #t}

	}
  [/#if]
[/#compress]
[/#if]
