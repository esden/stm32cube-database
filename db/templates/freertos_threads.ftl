[#ftl]

[#assign nbThreads = 0]
[#assign defaultTaskFunction = "defaultName"]
[#assign inMain = 0]

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
          [#assign index = index + 1]
        [/#list]
        [#assign nbThreads = nbThreads + 1]
        [#if nbThreads == 1]
          [#assign defaultTaskFunction = threadFunction]
        [/#if]
      [/#if]
	[/#list]
  [/#if]
[/#list]
[#assign mw = "empty"]
#n#n/* ${defaultTaskFunction} function */
void ${defaultTaskFunction}(void const * argument)
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
#t#tosDelay(1);
#t}
[#if inMain == 1]
#t/* USER CODE END 5 */ 
[#else]
#t/* USER CODE END ${defaultTaskFunction} */
[/#if]
}
#n
