[#ftl]
[#assign nbThreads = 0]
[#assign defaultTaskFunction = "toto"]
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
#n#nvoid ${defaultTaskFunction}(void const * argument)
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
        [#if mw == "FATFS"]
[@common.optinclude name="Src/fatfs_HalInit.tmp"/] 
        [#else]
#t/* init code for ${mw?replace("MX_","")?replace("_Init","")} */
#tMX_${mw}_Init();#n
        [/#if]
	  [/#if]
    [/#list]
  [/#if]
[/#list]
#n
#t/* USER CODE BEGIN 5 */
 
#t/* Infinite loop */
#tfor(;;)
#t{
#t#tosDelay(1);
#t}

#t/* USER CODE END 5 */ 
#n
}
