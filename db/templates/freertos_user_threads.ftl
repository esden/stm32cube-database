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
          [#if index == 3]
            [#assign threadFunction = i]
          [/#if]
          [#assign index = index + 1]
        [/#list]
        [#assign nbThreads = nbThreads + 1]
        [#if nbThreads == 1]
        [#else]
        /* ${threadFunction} function */
        void ${threadFunction}(void const * argument) 
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
          [#assign index = index + 1]
        [/#list]
        [#assign nbCallbacks = nbCallbacks + 1]
        [#if generateCallback == "1"]
        /* ${timerCallback} function */
        void ${timerCallback}(void const * argument) 
        {
        #t/* USER CODE BEGIN ${timerCallback} */
        #t        
        #t/* USER CODE END ${timerCallback} */
        }
        #n
        [/#if]
      [/#if]   
      
	[/#list]
	
  [/#if]
[/#list]
[/#compress]
