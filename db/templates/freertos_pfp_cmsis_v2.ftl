[#ftl]
[#compress]
[#assign nbThreads = 0]
[#assign generateFunction = "1"]
[#assign option = "Default"]
[#-- SWIPdatas is a list of SWIPconfigModel --]  
[#list SWIPdatas as SWIP]
  [#if SWIP.variables??]
    [#list SWIP.variables as variable]
    [#-- Look for threads --]  
      [#if variable.name == "Threads"]
        [#assign s = variable.valueList]
        [#assign index = 0]
        [#list s as i]
          [#if index == 3]
            [#assign threadFunction = i]
          [/#if]
          [#if index == 4]
            [#assign generateFunction = i]
          [/#if]
          [#if index == 5]
            [#assign option = i]
          [/#if]
          [#assign index = index + 1]
        [/#list]
        [#if generateFunction == "1"]
         [#if option == "As external"]
         extern void ${threadFunction}(void *argument);  // for v2
         [#else]
         void ${threadFunction}(void *argument);  // for v2
         [/#if]
        [/#if]
      [/#if]
      [#-- Look for timers --]  
      [#if variable.name == "Timers"]
        [#assign s = variable.valueList]
        [#assign index = 0]
        [#list s as i]
          [#if index == 1]
            [#assign timerCallback = i]
          [/#if]
          [#if index == 3]
            [#assign generateCallback = i]
          [/#if]
          [#if index == 4]
            [#assign option = i]
          [/#if]
          [#assign index = index + 1]
        [/#list]
        [#if generateCallback == "1"]
         [#if option == "As external"]
         extern void ${timerCallback}(void *argument);  // for v2
         [#else]
         void ${timerCallback}(void *argument);  // for v2
         [/#if]
        [/#if]
      [/#if]
    [/#list]   [#-- end loop on SWIP.variables --]  
  [/#if]
[/#list]
[/#compress]
#n