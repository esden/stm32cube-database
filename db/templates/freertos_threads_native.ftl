[#ftl]
[#assign nbThreads = 0]
[#assign defaultTaskFunction = "defaultName"]
[#assign inMain = 0]
[#assign defaultTaskOption = "Default"]

[#list SWIPdatas as SWIP]
    [#if SWIP.variables??]
    	[#list SWIP.variables as variable]	
	      [#if variable.name=="HALCompliant"]
	         [#assign inMain = 1]
	      [/#if]   
	    [/#list]
    [/#if]
[/#list]
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
          [#if index == 5] 
            [#assign option = i] 
          [/#if]
          [#assign index = index + 1]
        [/#list]
        [#assign nbThreads = nbThreads + 1]
        [#if nbThreads == 1]
          [#assign defaultTaskFunction = threadFunction]
          [#assign defaultTaskOption = option]
        [/#if]
      [/#if]
	[/#list]
  [/#if]
[/#list]
[#assign mw = "empty"]
#n#n/* ${defaultTaskFunction} function */
[#if defaultTaskOption == "Default"]
void ${defaultTaskFunction}(void * argument)
[#else]
__weak void ${defaultTaskFunction}(void * argument)
[/#if]
{
[#list SWIPdatas as SWIP]
  [#if SWIP.variables??]
	[#list SWIP.variables as variable]
	  [#if variable.name=="MiddlewareInUse"]
	  [#assign s = variable.valueList]
	  [#assign index = 0] 
        [#list s as i] 
          [#if index == 0]
            [#assign mw = i]
          [/#if]
          [#assign index = index + 1]
        [/#list]
#t/* init code for ${mw?replace("MX_","")?replace("_Init","")} */
#tMX_${mw}_Init();#n
	  [/#if]
    [/#list]
  [/#if]
[/#list]
#n
[#if inMain == 1]
#t/* USER CODE BEGIN 5 */
[#else]
#t/* USER CODE BEGIN ${defaultTaskFunction} */
[/#if]
#t/* Infinite loop */
#tfor(;;)
#t{
#t#tvTaskDelay(1);    /* 1 ms (with default settings) */
#t}
[#if inMain == 1]
#t/* USER CODE END 5 */ 
[#else]
#t/* USER CODE END ${defaultTaskFunction} */
[/#if]
}
#n
