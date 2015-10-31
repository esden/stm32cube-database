[#ftl]
/*
    VISIT http://www.FreeRTOS.org TO ENSURE YOU ARE USING THE LATEST VERSION.

    ***************************************************************************
     *                                                                       *
     *    FreeRTOS provides completely free yet professionally developed,    *
     *    robust, strictly quality controlled, supported, and cross          *
     *    platform software that has become a de facto standard.             *
     *                                                                       *
     *    Help yourself get started quickly and support the FreeRTOS         *
     *    project by purchasing a FreeRTOS tutorial book, reference          *
     *    manual, or both from: http://www.FreeRTOS.org/Documentation        *
     *                                                                       *
     *    Thank you!                                                         *
     *                                                                       *
    ***************************************************************************

    This file is part of the FreeRTOS distribution.

    FreeRTOS is free software; you can redistribute it and/or modify it under
    the terms of the GNU General Public License (version 2) as published by the
    Free Software Foundation >>!AND MODIFIED BY!<< the FreeRTOS exception.

    >>! NOTE: The modification to the GPL is included to allow you to distribute
    >>! a combined work that includes FreeRTOS without being obliged to provide
    >>! the source code for proprietary components outside of the FreeRTOS
    >>! kernel.

    FreeRTOS is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    FOR A PARTICULAR PURPOSE.  Full license text is available from the following
    link: http://www.freertos.org/a00114.html

    1 tab == 4 spaces!

    ***************************************************************************
     *                                                                       *
     *    Having a problem?  Start by reading the FAQ "My application does   *
     *    not run, what could be wrong?"                                     *
     *                                                                       *
     *    http://www.FreeRTOS.org/FAQHelp.html                               *
     *                                                                       *
    ***************************************************************************

    http://www.FreeRTOS.org - Documentation, books, training, latest versions,
    license and Real Time Engineers Ltd. contact details.

    http://www.FreeRTOS.org/plus - A selection of FreeRTOS ecosystem products,
    including FreeRTOS+Trace - an indispensable productivity tool, a DOS
    compatible FAT file system, and our tiny thread aware UDP/IP stack.

    http://www.OpenRTOS.com - Real Time Engineers ltd license FreeRTOS to High
    Integrity Systems to sell under the OpenRTOS brand.  Low cost OpenRTOS
    licenses offer ticketed support, indemnification and middleware.

    http://www.SafeRTOS.com - High Integrity Systems also provide a safety
    engineered and independently SIL3 certified version for use in safety and
    mission critical applications that require provable dependability.

    1 tab == 4 spaces!
*/
/**
  ******************************************************************************
  * File Name          : ${name}
  * Date               : ${date}
  ******************************************************************************
  */#n

#ifndef FREERTOS_CONFIG_H
#define FREERTOS_CONFIG_H

[#-- SWIPdatas is a list of SWIPconfigModel --]  
[#list SWIPdatas as SWIP]  
[#assign instName = SWIP.ipName]   
[#assign fileName = SWIP.fileName]   
[#assign version = SWIP.version]   

[#if SWIP.defines??]
	[#list SWIP.defines as definition]	
	  [#if definition.name=="configUSE_PREEMPTION"]
	      [#assign valueUsePreemption = definition.value]
	  [/#if]
	  [#if definition.name=="configUSE_IDLE_HOOK"]
	      [#assign valueUseIdleHook = definition.value]
	  [/#if]	
	  [#if definition.name=="configUSE_TICK_HOOK"]
	      [#assign valueUseTickHook = definition.value]
	  [/#if]  
	  [#if definition.name=="configCPU_CLOCK_HZ"]
	      [#assign valueCpuClock = definition.value]
	  [/#if]
	  [#if definition.name=="configTICK_RATE_HZ"]
	      [#assign valueTickRate = definition.value]
	  [/#if]	 
	  [#if definition.name=="configMAX_PRIORITIES"]
	      [#assign valueMaxPriorities = definition.value]
	  [/#if]	
	  [#if definition.name=="configMINIMAL_STACK_SIZE"]
	      [#assign valueMinimalStackSize = definition.value]
	  [/#if]	  
	  [#if definition.name=="configTOTAL_HEAP_SIZE"]
	      [#assign valueTotalHeapSize = definition.value]
	  [/#if]
	  [#if definition.name=="configMAX_TASK_NAME_LEN"]
	      [#assign valueMaxTaskNameLen = definition.value]
	  [/#if]
	  [#if definition.name=="configUSE_TRACE_FACILITY"]
	      [#assign valueUseTraceFacility = definition.value]
	  [/#if]	
	  [#if definition.name=="configUSE_16_BIT_TICKS"]
	      [#assign valueUse16BitTicks = definition.value]
	  [/#if]	
	  [#if definition.name=="configIDLE_SHOULD_YIELD"]
	      [#assign valueIdleShouldYield = definition.value]
	  [/#if]
	  [#if definition.name=="configUSE_MUTEXES"]
	      [#assign valueUseMutexes = definition.value]
	  [/#if]	
	  [#if definition.name=="configQUEUE_REGISTRY_SIZE"]
	      [#assign valueQueueRegistrySize = definition.value]
	  [/#if]	
	  [#if definition.name=="configCHECK_FOR_STACK_OVERFLOW"]
	      [#assign valueCheckForStackOverflow = definition.value]
	  [/#if]
	  [#if definition.name=="configUSE_RECURSIVE_MUTEXES"]
	      [#assign valueUseRecursiveMutexes = definition.value]
	  [/#if]	
	  [#if definition.name=="configUSE_MALLOC_FAILED_HOOK"]
	      [#assign valueUseMalocFailedHook = definition.value]
	  [/#if]
	  [#if definition.name=="configUSE_APPLICATION_TASK_TAG"]
	      [#assign valueUseApplicationTaskTag = definition.value]
	  [/#if]	
	  [#if definition.name=="configUSE_COUNTING_SEMAPHORES"]
	      [#assign valueUseCountingSemaphores = definition.value]
	  [/#if]
	  [#if definition.name=="configGENERATE_RUN_TIME_STATS"]
	      [#assign valueGenerateRunTimeStats = definition.value]
	  [/#if]
	  [#if definition.name=="configUSE_CO_ROUTINES"]
	      [#assign valueUseCoRoutines = definition.value]
	  [/#if]
	  [#if definition.name=="configMAX_CO_ROUTINE_PRIORITIES"]
	      [#assign valueMaxCoRoutinePriorities = definition.value]
	  [/#if]
	  [#if definition.name=="configUSE_TIMERS"]
	      [#assign valueUseTimers = definition.value]
	  [/#if]	  
	  [#if definition.name=="configTIMER_TASK_PRIORITY"]
	      [#assign valueTimerTaskPriority = definition.value]
	  [/#if]
	  [#if definition.name=="configTIMER_QUEUE_LENGTH"]
	      [#assign valueTimerQueueLength = definition.value]
	  [/#if]
	  [#if definition.name=="configTIMER_TASK_STACK_DEPTH"]
	      [#assign valueTimerTaskStackDepth = definition.value]
	  [/#if]   
	  [#if definition.name=="INCLUDE_vTaskPrioritySet"]
	      [#assign valueTaskPrioritySet = definition.value]
	  [/#if] 	  
	  [#if definition.name=="INCLUDE_uxTaskPriorityGet"]
	      [#assign valueTaskPriorityGet = definition.value]
	  [/#if] 	
	  [#if definition.name=="INCLUDE_vTaskDelete"]
	      [#assign valueTaskDelete = definition.value]
	  [/#if] 		    
	  [#if definition.name=="INCLUDE_vTaskCleanUpResources"]
	      [#assign valueTaskCleanUpResources = definition.value]
	  [/#if] 
	  [#if definition.name=="INCLUDE_vTaskSuspend"]
	      [#assign valueTaskSuspend = definition.value]
	  [/#if] 
	  [#if definition.name=="INCLUDE_vTaskDelayUntil"]
	      [#assign valueTaskDelayUntil = definition.value]
	  [/#if] 
	  [#if definition.name=="INCLUDE_vTaskDelay"]
	      [#assign valueTaskDelay = definition.value]
	  [/#if]
	  [#if definition.name=="INCLUDE_xTaskGetSchedulerState"]
	      [#assign valueGetSchedulerState = definition.value]
	  [/#if] 
	  [#if definition.name=="configPRIO_BITS"]
	      [#assign valuePrioBits = definition.value]
	  [/#if] 	  
	  [#if definition.name=="configLIBRARY_LOWEST_INTERRUPT_PRIORITY"]
	      [#assign valueLibraryLowestInterruptPriority = definition.value]
	  [/#if] 	  
	  [#if definition.name=="configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY"]
	      [#assign valueLibraryMaxSyscallInterruptPriority = definition.value]
	  [/#if] 	
	  [#if definition.name=="configASSERT( x )"]
	      [#assign valueAssert = definition.value]
	  [/#if] 	  
	[/#list]
[/#if]
[/#list]
/*-----------------------------------------------------------
 * Application specific definitions.
 *
 * These definitions should be adjusted for your particular hardware and
 * application requirements.
 *
 * THESE PARAMETERS ARE DESCRIBED WITHIN THE 'CONFIGURATION' SECTION OF THE
 * FreeRTOS API DOCUMENTATION AVAILABLE ON THE FreeRTOS.org WEB SITE.
 *
 * See http://www.freertos.org/a00110.html.
 *----------------------------------------------------------*/
 
/* Ensure stdint is only used by the compiler, and not the assembler. */
#if defined(__ICCARM__) || defined(__CC_ARM) || defined(__GNUC__)
    #include <stdint.h>
    extern uint32_t SystemCoreClock;
	[#list SWIPdatas as SWIP]  
     [#if SWIP.defines??]
	  [#list SWIP.defines as definition]	
	    [#if definition.name=="configGENERATE_RUN_TIME_STATS"]
	      [#if definition.value=="1"]
/* USER CODE BEGIN 0 */   	      
    extern void configureTimerForRunTimeStats(void);
    extern unsigned long getRunTimeCounterValue(void);  
/* USER CODE END 0 */       
	      [/#if]
	    [/#if]
	  [/#list]
	 [/#if]
	[/#list]
#endif

#define configUSE_PREEMPTION              ${valueUsePreemption}
#define configUSE_IDLE_HOOK               ${valueUseIdleHook}
#define configUSE_TICK_HOOK               ${valueUseTickHook}
#define configCPU_CLOCK_HZ                (${valueCpuClock})
#define configTICK_RATE_HZ                ((portTickType)${valueTickRate})
#define configMAX_PRIORITIES              ((unsigned portBASE_TYPE)${valueMaxPriorities})
#define configMINIMAL_STACK_SIZE          ((unsigned short)${valueMinimalStackSize})
#define configTOTAL_HEAP_SIZE             ((size_t)${valueTotalHeapSize})
#define configMAX_TASK_NAME_LEN           (${valueMaxTaskNameLen})
#define configUSE_TRACE_FACILITY          ${valueUseTraceFacility}
#define configUSE_16_BIT_TICKS            ${valueUse16BitTicks}
#define configIDLE_SHOULD_YIELD           ${valueIdleShouldYield}
#define configUSE_MUTEXES                 ${valueUseMutexes}
#define configQUEUE_REGISTRY_SIZE         ${valueQueueRegistrySize}
#define configCHECK_FOR_STACK_OVERFLOW    ${valueCheckForStackOverflow}
#define configUSE_RECURSIVE_MUTEXES       ${valueUseRecursiveMutexes}
#define configUSE_MALLOC_FAILED_HOOK      ${valueUseMalocFailedHook}
#define configUSE_APPLICATION_TASK_TAG    ${valueUseApplicationTaskTag}
#define configUSE_COUNTING_SEMAPHORES     ${valueUseCountingSemaphores}
#define configGENERATE_RUN_TIME_STATS     ${valueGenerateRunTimeStats}

/* Co-routine definitions. */
#define configUSE_CO_ROUTINES           ${valueUseCoRoutines}
#define configMAX_CO_ROUTINE_PRIORITIES (${valueMaxCoRoutinePriorities})

/* Software timer definitions. */
#define configUSE_TIMERS             ${valueUseTimers}
#define configTIMER_TASK_PRIORITY    (${valueTimerTaskPriority})
#define configTIMER_QUEUE_LENGTH     ${valueTimerQueueLength}
#define configTIMER_TASK_STACK_DEPTH ${valueTimerTaskStackDepth}

/* Set the following definitions to 1 to include the API function, or zero
to exclude the API function. */
#define INCLUDE_vTaskPrioritySet       ${valueTaskPrioritySet}
#define INCLUDE_uxTaskPriorityGet      ${valueTaskPriorityGet}
#define INCLUDE_vTaskDelete            ${valueTaskDelete}
#define INCLUDE_vTaskCleanUpResources  ${valueTaskCleanUpResources}
#define INCLUDE_vTaskSuspend           ${valueTaskSuspend}
#define INCLUDE_vTaskDelayUntil        ${valueTaskDelayUntil}
#define INCLUDE_vTaskDelay             ${valueTaskDelay}
#define INCLUDE_xTaskGetSchedulerState ${valueGetSchedulerState}

/* Cortex-M specific definitions. */
#ifdef __NVIC_PRIO_BITS
 /* __BVIC_PRIO_BITS will be specified when CMSIS is being used. */
 #define configPRIO_BITS         __NVIC_PRIO_BITS
#else
 #define configPRIO_BITS         ${valuePrioBits}
#endif

/* The lowest interrupt priority that can be used in a call to a "set priority"
function. */
#define configLIBRARY_LOWEST_INTERRUPT_PRIORITY   ${valueLibraryLowestInterruptPriority}

/* The highest interrupt priority that can be used by any interrupt service
routine that makes calls to interrupt safe FreeRTOS API functions.  DO NOT CALL
INTERRUPT SAFE FREERTOS API FUNCTIONS FROM ANY INTERRUPT THAT HAS A HIGHER
PRIORITY THAN THIS! (higher priorities are lower numeric values. */
#define configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY ${valueLibraryMaxSyscallInterruptPriority}

/* Interrupt priorities used by the kernel port layer itself.  These are generic
to all Cortex-M ports, and do not rely on any particular library functions. */
#define configKERNEL_INTERRUPT_PRIORITY 		( configLIBRARY_LOWEST_INTERRUPT_PRIORITY << (8 - configPRIO_BITS) )
/* !!!! configMAX_SYSCALL_INTERRUPT_PRIORITY must not be set to zero !!!!
See http://www.FreeRTOS.org/RTOS-Cortex-M3-M4.html. */
#define configMAX_SYSCALL_INTERRUPT_PRIORITY 	( configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY << (8 - configPRIO_BITS) )

/* Normal assert() semantics without relying on the provision of an assert.h
header file. */
/* USER CODE BEGIN 1 */   
#define configASSERT( x ) ${valueAssert}
/* USER CODE END 1 */

/* Definitions that map the FreeRTOS port interrupt handlers to their CMSIS
standard names. */
#define vPortSVCHandler    SVC_Handler
#define xPortPendSVHandler PendSV_Handler

/* IMPORTANT: This define MUST be commented when used with STM32Cube firmware, 
              to prevent overwriting SysTick_Handler defined within STM32Cube HAL */
/* #define xPortSysTickHandler SysTick_Handler */

[#list SWIPdatas as SWIP]  
 [#if SWIP.defines??]
  [#list SWIP.defines as definition]	
   [#if definition.name=="configGENERATE_RUN_TIME_STATS"]
    [#if definition.value=="1"]
/* USER CODE BEGIN 2 */    
/* Definitions needed when configGENERATE_RUN_TIME_STATS is on */
#define portCONFIGURE_TIMER_FOR_RUN_TIME_STATS configureTimerForRunTimeStats
#define portGET_RUN_TIME_COUNTER_VALUE getRunTimeCounterValue    
/* USER CODE END 2 */
    [/#if]
   [/#if]
  [/#list]
 [/#if]
[/#list]

#endif /* FREERTOS_CONFIG_H */
