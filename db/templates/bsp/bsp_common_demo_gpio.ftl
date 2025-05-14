[#ftl]
[#assign pinsPA =""]
[#assign pinsPB =""]
[#assign pinsPC =""]
[#assign pinsPD =""]
[#assign pinsPE =""]
[#assign pinsPF =""]

[#compress]
[#if clock?? && clock?size > 0]
    #n#t/* GPIO Ports Clock Enable Needed For BSP */
    [#list clock as bspClock]
        #t${bspClock}();
    [/#list]
[/#if]

[#if  bspPins?? && bspPins?size >0]
    #n#t/*IO attributes management functions needed for BSP*/
    [#list bspPins as bspPin]
        [#assign port = bspPin.name?substring(1,2)]
        [#assign pinNumber = bspPin.name?substring(2)]

        [#--used in case when the pin name is specified like PB4 (NJTRST) --]
        [#if pinNumber?split(" ")?size >1]
            [#list pinNumber?split(" ") as pin]
                [#assign pinNumber = pin]
                [#break]
            [/#list]
        [/#if]
        [#-- end  --]

        [#switch  port]
            [#case "A"]
                [#assign pinsPA = pinsPA+"GPIO_PIN_"+pinNumber+"|"]
                [#break]
            [#case "B"]
                [#assign pinsPB = pinsPB+"GPIO_PIN_"+pinNumber+"|"]
                [#break]
            [#case "C"]
                [#assign pinsPC = pinsPC+"GPIO_PIN_"+pinNumber+"|"]
                [#break]
            [#case "D"]
                [#assign pinsPD = pinsPD+"GPIO_PIN_"+pinNumber+"|"]
                [#break]
            [#case "E"]
                [#assign pinsPE = pinsPE+"GPIO_PIN_"+pinNumber+"|"]
                [#break]
            [#case "F"]
                [#assign pinsPF = pinsPF+"GPIO_PIN_"+pinNumber+"|"]
                [#break]
            [#default]
                #tHAL_GPIO_ConfigPinAttributes(GPIO${port}, GPIO_PIN_${pinNumber}, GPIO_PIN_NSEC);
        [/#switch]
    [/#list]

    [#if pinsPA!?length gt 1]
        #tHAL_GPIO_ConfigPinAttributes(GPIOA, ${pinsPA?substring(0,pinsPA?length - 1)}, GPIO_PIN_NSEC);
    [/#if]
    [#if pinsPB!?length gt 1]
        #tHAL_GPIO_ConfigPinAttributes(GPIOB, ${pinsPB?substring(0,pinsPB?length - 1)}, GPIO_PIN_NSEC);
    [/#if]
    [#if pinsPC!?length gt 1]
        #tHAL_GPIO_ConfigPinAttributes(GPIOC, ${pinsPC?substring(0,pinsPC?length - 1)}, GPIO_PIN_NSEC);
    [/#if]
    [#if pinsPD!?length gt 1]
        #tHAL_GPIO_ConfigPinAttributes(GPIOD, ${pinsPD?substring(0,pinsPD?length - 1)}, GPIO_PIN_NSEC);
    [/#if]
    [#if pinsPE!?length gt 1]
        #tHAL_GPIO_ConfigPinAttributes(GPIOE, ${pinsPE?substring(0,pinsPE?length - 1)}, GPIO_PIN_NSEC);
    [/#if]
    [#if pinsPF!?length gt 1]
        #tHAL_GPIO_ConfigPinAttributes(GPIOF, ${pinsPF?substring(0,pinsPF?length - 1)}, GPIO_PIN_NSEC);
    [/#if]
#n
[/#if]

[/#compress]
