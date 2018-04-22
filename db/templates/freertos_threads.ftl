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
void ${defaultTaskFunction}(void const * argument)
[#else]
__weak void ${defaultTaskFunction}(void const * argument)
[/#if]
{
[#-- Start Detection of middlewares used --]
[#assign USE_LWIP = false]
[#assign USE_MBEDTLS = false] 
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
        [#if mw == "MBEDTLS"]
          [#assign USE_MBEDTLS = true]
        [/#if]
	  [/#if]
    [/#list]
  [/#if]
[/#list]
[#-- End of middlewares used detection --]

[#assign USE_GRAPHICS = false] 
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
            [#if mw!="GRAPHICS"]
              [#if !((mw == "LWIP") && (USE_MBEDTLS == true))]
                [#if (mw == "MBEDTLS")]
#t/* Up to user define the empty MX_MBEDTLS_Init() function located in mbedtls.c file */
                [#else]
#t/* init code for ${mw?replace("MX_","")?replace("_Init","")} */
                [/#if]
#tMX_${mw}_Init();#n
              [#else]
#t/* MX_LWIP_Init() is generated within mbedtls_net_init() function in net_cockets.c file */
#t/* Up to user to call mbedtls_net_init() function in MBEDTLS initialization step */#n
              [/#if]
            [#else]
[#assign USE_GRAPHICS = true] 
            [/#if]
            
	  [/#if]
    [/#list]
  [/#if]
[/#list]

[#if USE_GRAPHICS] 
/* Graphic application */  
  GRAPHICS_MainTask();
[/#if]
#n
[#list SWIPdatas as SWIP]
  [#if SWIP.variables??]
	[#list SWIP.variables as variable]
	  [#if variable.name=="ThirdPartyInUse"]
	  [#assign s = variable.valueList]
	  [#assign index = 0] 
        [#list s as i] 
          [#if index == 0]
            [#assign mw = i]
          [/#if]
          [#assign index = index + 1]
        [/#list]
#t/* init code for ${mw?replace("TP_","")?replace("_Init","")} */
#tTP_${mw}_Init();#n
	  [/#if]
    [/#list]
  [/#if]
[/#list]
[#if inMain == 1]
#t/* USER CODE BEGIN 5 */
[#else]
 [#if defaultTaskFunction == "Application"]
#t/* USER CODE BEGIN DEFAULT_TASK_FUNCTION */  [#-- There is already a User section named "Application" in freertos.c --]
 [#else]
#t/* USER CODE BEGIN ${defaultTaskFunction} */
 [/#if]
[/#if]
#t/* Infinite loop */
#tfor(;;)
#t{
#t#tosDelay(1);
#t}
[#if inMain == 1]
#t/* USER CODE END 5 */ 
[#else]
 [#if defaultTaskFunction == "Application"]
#t/* USER CODE END DEFAULT_TASK_FUNCTION */  [#-- There is already a User section named "Application" in freertos.c --]
 [#else]
#t/* USER CODE END ${defaultTaskFunction} */
 [/#if]
[/#if]
}
#n
