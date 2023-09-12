[#ftl]
[#compress]
[#assign nbThreads = 0]
[#assign nbCallbacks = 0]

[#list SWIPdatas as SWIP]
  [#if SWIP.variables??]
  
    [#list SWIP.variables as variable]
    
      [#if variable.name=="Threads"]
        [#assign s = variable.valueList]
        [#assign index = 0]
        [#list s as i]
          [#if index == 0]
            [#assign threadName = i]
          [/#if]        
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
        [#assign nbThreads = nbThreads + 1]
        [#if nbThreads == 1]
        [#else]
         [#if generateFunction == "1"]
          [#if option == "As external"]
          [#else]
           [#-- /* ${threadFunction} function */ --]
           /* USER CODE BEGIN Header_${threadFunction} */
           /**
             * @brief  Function implementing the ${threadName} thread.
             * @param  argument: Not used 
             * @retval None
             */ 
           /* USER CODE END Header_${threadFunction} */
           [#if option == "As weak"]
           __weak void ${threadFunction}(void const * argument) 
           [#else]
           void ${threadFunction}(void const * argument) 
           [/#if]
           {
           #t/* USER CODE BEGIN ${threadFunction} */
           #t/* Infinite loop */
           #tfor(;;)
           #t{
           #t#tosDelay(1);
           #t}        
           #t/* USER CODE END ${threadFunction} */
           }
           #n
          [/#if]
         [/#if]
        [/#if]
      [/#if]
      
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
        [#assign nbCallbacks = nbCallbacks + 1]
        [#if generateCallback == "1"]
         [#if option == "As external"]
         [#else]
         /* ${timerCallback} function */
         [#if option == "As weak"]
         __weak void ${timerCallback}(void const * argument) 
         [#else]
         void ${timerCallback}(void const * argument) 
         [/#if]
         {
         #t/* USER CODE BEGIN ${timerCallback} */
         #t        
         #t/* USER CODE END ${timerCallback} */
         }
         #n
         [/#if]
        [/#if]
      [/#if]   
    [/#list]
  [/#if]
[/#list]
[/#compress]
