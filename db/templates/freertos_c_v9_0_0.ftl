[#ftl]
/**
  ******************************************************************************
  * File Name          : freertos.c
  * Description        : Code for freertos applications
  ******************************************************************************
[@common.optinclude name=sourceDir+"Src/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

[#compress]
[#assign inMain = 0]
[#assign useNewHandle = 0]
[#assign useTimers = 0]

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
    [#if SWIP.defines??]     
	  [#list SWIP.defines as definition]
	    [#if definition.name=="configENABLE_BACKWARD_COMPATIBILITY"]
	      [#if definition.value=="0"]
	        [#assign useNewHandle = 1]
          [/#if]   
	    [/#if]
	    [#if definition.name=="configUSE_TIMERS"]
	      [#if definition.value=="1"]
	        [#assign useTimers = 1]
          [/#if]    
	    [/#if]   
	  [/#list]
    [/#if]
[/#list]

/* Includes ------------------------------------------------------------------*/
#include "FreeRTOS.h"
#include "task.h"
[/#compress]

[#if inMain == 0]
[@common.optinclude name=sourceDir+"Src/rtos_inc.tmp"/][#--include freertos includes --]
[/#if]

/* USER CODE BEGIN Includes */     

/* USER CODE END Includes */

[#compress]
/* Variables -----------------------------------------------------------------*/
[#if inMain == 0]
[@common.optinclude name=sourceDir+"Src/rtos_vars.tmp"/]
[/#if]
#n/* USER CODE BEGIN Variables */
#n
#n/* USER CODE END Variables */
#n     
/* Function prototypes -------------------------------------------------------*/
[#if inMain == 0]
[@common.optinclude name=sourceDir+"Src/rtos_pfp.tmp"/]
#n
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
extern void MX_${mw}_Init(void);
	  [/#if]
    [/#list]
  [/#if]
 [/#list]
void MX_FREERTOS_Init(void);  /* (MISRA C 2004 rule 8.1) */
[/#if]


#n
#n/* USER CODE BEGIN FunctionPrototypes */
#n   
#n/* USER CODE END FunctionPrototypes */

[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]     
	  [#list SWIP.defines as definition]
	  	[#if definition.name=="configUSE_TICKLESS_IDLE"]
	      [#if definition.value=="1"]
#n/* Pre/Post sleep processing prototypes */
void PreSleepProcessing(uint32_t *ulExpectedIdleTime);
void PostSleepProcessing(uint32_t *ulExpectedIdleTime);
          [/#if]
        [/#if] 
	  	[#if definition.name=="MEMORY_ALLOCATION"]
	      [#if definition.value!="0"]
#n/* GetIdleTaskMemory prototype (linked to static allocation support) */
void vApplicationGetIdleTaskMemory( StaticTask_t **ppxIdleTaskTCBBuffer, StackType_t **ppxIdleTaskStackBuffer, uint32_t *pulIdleTaskStackSize );
            [#if useTimers==1]
#n/* GetTimerTaskMemory prototype (linked to static allocation support) */
void vApplicationGetTimerTaskMemory( StaticTask_t **ppxTimerTaskTCBBuffer, StackType_t **ppxTimerTaskStackBuffer, uint32_t *pulTimerTaskStackSize );            
            [/#if]
          [/#if]
        [/#if]	                          
     [/#list]
 [/#if]
[/#list]	

#n/* Hook prototypes */
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
     [#list SWIP.defines as definition]
        [#if definition.name=="configGENERATE_RUN_TIME_STATS"]
          [#if definition.value=="1"]
void configureTimerForRunTimeStats(void);
unsigned long getRunTimeCounterValue(void);          
          [/#if]
        [/#if]
        [#if definition.name=="configUSE_IDLE_HOOK"]
          [#if definition.value=="1"]
void vApplicationIdleHook(void);       
          [/#if]
        [/#if]
        [#if definition.name=="configUSE_TICK_HOOK"]
          [#if definition.value=="1"]
void vApplicationTickHook(void);       
          [/#if]
        [/#if]   
        [#if definition.name=="configUSE_DAEMON_TASK_STARTUP_HOOK"]
          [#if definition.value=="1"]
void vApplicationDaemonTaskStartupHook(void);       
          [/#if]    
        [/#if]     
        [#if definition.name=="configCHECK_FOR_STACK_OVERFLOW"]
          [#if definition.value !="0"]
            [#if useNewHandle==0]
void vApplicationStackOverflowHook(xTaskHandle xTask, signed char *pcTaskName);  
            [#else]
void vApplicationStackOverflowHook(TaskHandle_t xTask, signed char *pcTaskName); 
            [/#if]     
          [/#if]
        [/#if]
        [#if definition.name=="configUSE_MALLOC_FAILED_HOOK"]
          [#if definition.value=="1"]
void vApplicationMallocFailedHook(void);       
          [/#if]
        [/#if]             
     [/#list]
 [/#if]
[/#list]

[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]     
	  [#list SWIP.defines as definition]	
	    [#if definition.name=="configGENERATE_RUN_TIME_STATS"]
	      [#if definition.value=="1"]
#n
/* USER CODE BEGIN 1 */
/* Functions needed when configGENERATE_RUN_TIME_STATS is on */
__weak void configureTimerForRunTimeStats(void) 
{
#n    
}

#n__weak unsigned long getRunTimeCounterValue(void) 
{
    return 0;
}  
/* USER CODE END 1 */
	      [/#if]
	    [/#if]
		    
		[#if definition.name=="configUSE_IDLE_HOOK"]
	      [#if definition.value=="1"]
#n
/* USER CODE BEGIN 2 */
__weak void vApplicationIdleHook( void ) 
{
#t    /* vApplicationIdleHook() will only be called if configUSE_IDLE_HOOK is set
#t    to 1 in FreeRTOSConfig.h.  It will be called on each iteration of the idle
#t    task.  It is essential that code added to this hook function never attempts
#t    to block in any way (for example, call xQueueReceive() with a block time
#t    specified, or call vTaskDelay()).  If the application makes use of the
#t    vTaskDelete() API function (as this demo application does) then it is also
#t    important that vApplicationIdleHook() is permitted to return to its calling
#t    function, because it is the responsibility of the idle task to clean up
#t    memory allocated by the kernel to any task that has since been deleted. */
}
/* USER CODE END 2 */  
	      [/#if]
	    [/#if]  

	    [#if definition.name=="configUSE_TICK_HOOK"]
	      [#if definition.value=="1"]
#n/* USER CODE BEGIN 3 */
__weak void vApplicationTickHook( void ) 
{
#t    /* This function will be called by each tick interrupt if
#t    configUSE_TICK_HOOK is set to 1 in FreeRTOSConfig.h.  User code can be
#t    added here, but the tick hook is called from an interrupt context, so
#t    code must not attempt to block, and only the interrupt safe FreeRTOS API
#t    functions can be used (those that end in FromISR()). */ 
}
 /* USER CODE END 3 */ 	      
	      [/#if]
	    [/#if]
	        
	    [#if definition.name=="configCHECK_FOR_STACK_OVERFLOW"]
	      [#if definition.value !="0"]
#n/* USER CODE BEGIN 4 */
[#if useNewHandle==0]
__weak void vApplicationStackOverflowHook(xTaskHandle xTask, signed char *pcTaskName)
[#else]
__weak void vApplicationStackOverflowHook(TaskHandle_t xTask, signed char *pcTaskName)
[/#if]
{
#t    /* Run time stack overflow checking is performed if
#t    configCHECK_FOR_STACK_OVERFLOW is defined to 1 or 2. This hook function is
#t    called if a stack overflow is detected. */ 
}
 /* USER CODE END 4 */ 
	      [/#if]
	    [/#if]
	    
	    [#if definition.name=="configUSE_MALLOC_FAILED_HOOK"]
	      [#if definition.value=="1"]
#n/* USER CODE BEGIN 5 */
__weak void vApplicationMallocFailedHook(void) 
{
#t    /* vApplicationMallocFailedHook() will only be called if
#t    configUSE_MALLOC_FAILED_HOOK is set to 1 in FreeRTOSConfig.h.  It is a hook
#t    function that will get called if a call to pvPortMalloc() fails.
#t    pvPortMalloc() is called internally by the kernel whenever a task, queue,
#t    timer or semaphore is created.  It is also called by various parts of the
#t    demo application.  If heap_1.c or heap_2.c are used, then the size of the
#t    heap available to pvPortMalloc() is defined by configTOTAL_HEAP_SIZE in
#t    FreeRTOSConfig.h, and the xPortGetFreeHeapSize() API function can be used
#t    to query the size of free heap space that remains (although it does not
#t    provide information on how the remaining heap might be fragmented). */
}
/* USER CODE END 5 */
	      [/#if]
	    [/#if]
	    
	    [#if definition.name=="configUSE_DAEMON_TASK_STARTUP_HOOK"]
	      [#if definition.value=="1"]
#n/* USER CODE BEGIN DAEMON_TASK_STARTUP_HOOK */
void vApplicationDaemonTaskStartupHook(void) 
{
}
/* USER CODE END DAEMON_TASK_STARTUP_HOOK */	    
	      [/#if]
	    [/#if]
	    
	  [/#list]
	 [/#if]
[/#list]
[/#compress]

[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]     
	  [#list SWIP.defines as definition]
	  	[#if definition.name=="configUSE_TICKLESS_IDLE"]
	      [#if definition.value=="1"]
#n
/* USER CODE BEGIN PREPOSTSLEEP */
__weak void PreSleepProcessing(uint32_t *ulExpectedIdleTime)
{
/* place for user code */ 
}

__weak void PostSleepProcessing(uint32_t *ulExpectedIdleTime)
{
/* place for user code */
}
/* USER CODE END PREPOSTSLEEP */
#n
          [/#if]
        [/#if]
	  	[#if definition.name=="MEMORY_ALLOCATION"]
	      [#if definition.value!="0"]
#n
/* USER CODE BEGIN GET_IDLE_TASK_MEMORY */
static StaticTask_t xIdleTaskTCBBuffer;
static StackType_t xIdleStack[configMINIMAL_STACK_SIZE];
  
void vApplicationGetIdleTaskMemory( StaticTask_t **ppxIdleTaskTCBBuffer, StackType_t **ppxIdleTaskStackBuffer, uint32_t *pulIdleTaskStackSize )
{
  *ppxIdleTaskTCBBuffer = &xIdleTaskTCBBuffer;
  *ppxIdleTaskStackBuffer = &xIdleStack[0];
  *pulIdleTaskStackSize = configMINIMAL_STACK_SIZE;
  /* place for user code */
}                   
/* USER CODE END GET_IDLE_TASK_MEMORY */
#n
            [#if useTimers==1]
#n
/* USER CODE BEGIN GET_TIMER_TASK_MEMORY */
static StaticTask_t xTimerTaskTCBBuffer;
static StackType_t xTimerStack[configTIMER_TASK_STACK_DEPTH];
  
void vApplicationGetTimerTaskMemory( StaticTask_t **ppxTimerTaskTCBBuffer, StackType_t **ppxTimerTaskStackBuffer, uint32_t *pulTimerTaskStackSize )  
{
  *ppxTimerTaskTCBBuffer = &xTimerTaskTCBBuffer;
  *ppxTimerTaskStackBuffer = &xTimerStack[0];
  *pulTimerTaskStackSize = configTIMER_TASK_STACK_DEPTH;
  /* place for user code */
}                   
/* USER CODE END GET_TIMER_TASK_MEMORY */
#n
            [/#if]
          [/#if]
        [/#if]                  
     [/#list]
 [/#if]
[/#list]	

[#if inMain == 0]
#n
/* Init FreeRTOS */

void MX_FREERTOS_Init(void) {
#t/* USER CODE BEGIN Init */
#t     
#t/* USER CODE END Init */
[@common.optinclude name=sourceDir+"Src/rtos_HalInit.tmp"/]
}
[@common.optinclude name=sourceDir+"Src/rtos_threads.tmp"/]
[@common.optinclude name=sourceDir+"Src/rtos_user_threads.tmp"/] 
[/#if]  

/* USER CODE BEGIN Application */
     
/* USER CODE END Application */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
