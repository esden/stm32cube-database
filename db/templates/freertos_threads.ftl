[#ftl]
#n#nstatic void StartThread(void const * argument)
{
[#list middlewareVoids as mw]
[#if mw == "FATFS"]
[@common.optinclude name="Src/fatfs_HalInit.tmp"/]        
[#else]
[#if mw != "FREERTOS"] [#-- if mw != from FREERTOS --]
#t/* init code for ${mw?replace("MX_","")?replace("_Init","")} */
#tMX_${mw}_Init();#n
[/#if]
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