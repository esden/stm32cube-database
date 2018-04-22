[#ftl]
/*
    FreeRTOS V8.2.3 - Copyright (C) 2015 Real Time Engineers Ltd.
    All rights reserved

    VISIT http://www.FreeRTOS.org TO ENSURE YOU ARE USING THE LATEST VERSION.

    This file is part of the FreeRTOS distribution.

    FreeRTOS is free software; you can redistribute it and/or modify it under
    the terms of the GNU General Public License (version 2) as published by the
    Free Software Foundation >>!AND MODIFIED BY!<< the FreeRTOS exception.

	***************************************************************************
    >>!   NOTE: The modification to the GPL is included to allow you to     !<<
    >>!   distribute a combined work that includes FreeRTOS without being   !<<
    >>!   obliged to provide the source code for proprietary components     !<<
    >>!   outside of the FreeRTOS kernel.                                   !<<
	***************************************************************************

    FreeRTOS is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    FOR A PARTICULAR PURPOSE.  Full license text is available on the following
    link: http://www.freertos.org/a00114.html

    ***************************************************************************
     *                                                                       *
     *    FreeRTOS provides completely free yet professionally developed,    *
     *    robust, strictly quality controlled, supported, and cross          *
     *    platform software that is more than just the market leader, it     *
     *    is the industry's de facto standard.                               *
     *                                                                       *
     *    Help yourself get started quickly while simultaneously helping     *
     *    to support the FreeRTOS project by purchasing a FreeRTOS           *
     *    tutorial book, reference manual, or both:                          *
     *    http://www.FreeRTOS.org/Documentation                              *
     *                                                                       *
    ***************************************************************************

    http://www.FreeRTOS.org/FAQHelp.html - Having a problem?  Start by reading
	the FAQ page "My application does not run, what could be wrong?".  Have you
	defined configASSERT()?

	http://www.FreeRTOS.org/support - In return for receiving this top quality
	embedded software for free we request you assist our global community by
	participating in the support forum.

	http://www.FreeRTOS.org/training - Investing in training allows your team to
	be as productive as possible as early as possible.  Now you can receive
	FreeRTOS training directly from Richard Barry, CEO of Real Time Engineers
	Ltd, and the world's leading authority on the world's leading RTOS.

    http://www.FreeRTOS.org/plus - A selection of FreeRTOS ecosystem products,
    including FreeRTOS+Trace - an indispensable productivity tool, a DOS
    compatible FAT file system, and our tiny thread aware UDP/IP stack.

    http://www.FreeRTOS.org/labs - Where new FreeRTOS products go to incubate.
    Come and try FreeRTOS+TCP, our new open source TCP/IP stack for FreeRTOS.

    http://www.OpenRTOS.com - Real Time Engineers ltd. license FreeRTOS to High
    Integrity Systems ltd. to sell under the OpenRTOS brand.  Low cost OpenRTOS
    licenses offer ticketed support, indemnification and commercial middleware.

    http://www.SafeRTOS.com - High Integrity Systems also provide a safety
    engineered and independently SIL3 certified version for use in safety and
    mission critical applications that require provable dependability.

    1 tab == 4 spaces!
*/#n

#ifndef FREERTOS_CONFIG_H
#define FREERTOS_CONFIG_H

[#-- SWIPdatas is a list of SWIPconfigModel --]  
[#list SWIPdatas as SWIP]  
[#assign instName = SWIP.ipName]   
[#assign fileName = SWIP.fileName]   
[#assign version = SWIP.version]   

[#assign CMSIS_version = "1.00"]

[#assign configUSE_TIMERS = "0"]
[#assign configCHECK_FOR_STACK_OVERFLOW = "0"]
[#assign configUSE_APPLICATION_TASK_TAG = "0"]
[#assign configUSE_MALLOC_FAILED_HOOK = "0"]
[#assign configUSE_MUTEXES = "0"]
[#assign configUSE_RECURSIVE_MUTEXES = "0"]
[#assign configUSE_COUNTING_SEMAPHORES = "0"]
[#assign configGENERATE_RUN_TIME_STATS = "0"]
[#assign configUSE_TRACE_FACILITY = "0"]
[#assign configUSE_STATS_FORMATTING_FUNCTIONS = "0"]
[#assign configIDLE_SHOULD_YIELD = "1"]

[#assign xTaskResumeFromISR = "1"]
[#assign xQueueGetMutexHolder = "0"]
[#assign xSemaphoreGetMutexHolder = "0"]
[#assign pcTaskGetTaskName = "0"]
[#assign uxTaskGetStackHighWaterMark = "0"]
[#assign xTaskGetCurrentTaskHandle = "0"]
[#assign eTaskGetState = "0"]
[#assign configUSE_ALTERNATIVE_API = "0"]

[#-- Since FreeRTOS v8 --] 
[#assign xEventGroupSetBitFromISR = "0"]
[#assign xTimerPendFunctionCall = "0"]
[#assign configENABLE_BACKWARD_COMPATIBILITY = "1"]
[#assign configUSE_PORT_OPTIMISED_TASK_SELECTION = "0"]
[#-- Since FreeRTOS v8.2 --] 
[#assign configUSE_TASK_NOTIFICATIONS = "1"]


[#if SWIP.defines??]
	[#list SWIP.defines as definition]
      [#if definition.name=="CMSIS_version"]
	      [#assign CMSIS_version = definition.value]
	  [/#if]
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
	  [#if definition.name=="configUSE_16_BIT_TICKS"]
	      [#assign valueUse16BitTicks = definition.value]
	  [/#if]	
	  [#if definition.name=="configIDLE_SHOULD_YIELD"]
	      [#assign configIDLE_SHOULD_YIELD = definition.value]
	  [/#if]
	  [#if definition.name=="configUSE_MUTEXES"]
	      [#assign configUSE_MUTEXES = definition.value]
	  [/#if]	
	  [#if definition.name=="configQUEUE_REGISTRY_SIZE"]
	      [#assign valueQueueRegistrySize = definition.value]
	  [/#if]	
	  [#if definition.name=="configCHECK_FOR_STACK_OVERFLOW"]
	      [#assign configCHECK_FOR_STACK_OVERFLOW = definition.value]
	  [/#if]
	  [#if definition.name=="configUSE_RECURSIVE_MUTEXES"]
	      [#assign configUSE_RECURSIVE_MUTEXES = definition.value]
	  [/#if]	
	  [#if definition.name=="configUSE_MALLOC_FAILED_HOOK"]
	      [#assign configUSE_MALLOC_FAILED_HOOK = definition.value]
	  [/#if]
	  [#if definition.name=="configUSE_APPLICATION_TASK_TAG"]
	      [#assign configUSE_APPLICATION_TASK_TAG = definition.value]
	  [/#if]	
	  [#if definition.name=="configUSE_COUNTING_SEMAPHORES"]
	      [#assign configUSE_COUNTING_SEMAPHORES = definition.value]
	  [/#if]
	  [#if definition.name=="configGENERATE_RUN_TIME_STATS"]
	      [#assign configGENERATE_RUN_TIME_STATS = definition.value]
	  [/#if]
	  [#if definition.name=="configUSE_TRACE_FACILITY"]
	      [#assign configUSE_TRACE_FACILITY = definition.value]
	  [/#if]
	  [#if definition.name=="configUSE_STATS_FORMATTING_FUNCTIONS"]
	      [#assign configUSE_STATS_FORMATTING_FUNCTIONS = definition.value]
	  [/#if]
	  [#if definition.name=="configUSE_CO_ROUTINES"]
	      [#assign valueUseCoRoutines = definition.value]
	  [/#if]
	  [#if definition.name=="configMAX_CO_ROUTINE_PRIORITIES"]
	      [#assign valueMaxCoRoutinePriorities = definition.value]
	  [/#if]
	  [#if definition.name=="configUSE_TIMERS"]
	      [#assign configUSE_TIMERS = definition.value]
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
	  [#-- New ones for all families --]  
	  [#if definition.name=="INCLUDE_xTaskResumeFromISR"]
	      [#assign xTaskResumeFromISR = definition.value]
	  [/#if]
	  [#if definition.name=="INCLUDE_xQueueGetMutexHolder"]
	      [#assign xQueueGetMutexHolder = definition.value]
	  [/#if]
	  [#if definition.name=="INCLUDE_xSemaphoreGetMutexHolder"]
	      [#assign xSemaphoreGetMutexHolder = definition.value]
	  [/#if]
	  [#if definition.name=="INCLUDE_pcTaskGetTaskName"]
	      [#assign pcTaskGetTaskName = definition.value]
	  [/#if]	  
	  [#if definition.name=="INCLUDE_uxTaskGetStackHighWaterMark"]
	      [#assign uxTaskGetStackHighWaterMark = definition.value]
	  [/#if]	  
	  [#if definition.name=="INCLUDE_xTaskGetCurrentTaskHandle"]
	      [#assign xTaskGetCurrentTaskHandle = definition.value]
	  [/#if]
	  [#if definition.name=="INCLUDE_eTaskGetState"]
	      [#assign eTaskGetState = definition.value]
	  [/#if]
	  [#if definition.name=="configUSE_ALTERNATIVE_API"]
	      [#assign configUSE_ALTERNATIVE_API = definition.value]
	  [/#if]
	  [#-- New ones from freertos 8.1.2 --]  
	  [#if definition.name=="INCLUDE_xEventGroupSetBitFromISR"]
	      [#assign xEventGroupSetBitFromISR = definition.value] 
	  [/#if]
	  [#if definition.name=="INCLUDE_xTimerPendFunctionCall"]
	      [#assign xTimerPendFunctionCall = definition.value]
	  [/#if]
	  [#if definition.name=="configENABLE_BACKWARD_COMPATIBILITY"]
	      [#assign configENABLE_BACKWARD_COMPATIBILITY = definition.value] 
	  [/#if]
	  [#if definition.name=="configUSE_PORT_OPTIMISED_TASK_SELECTION"]
	      [#assign configUSE_PORT_OPTIMISED_TASK_SELECTION = definition.value]
	  [/#if]
	  [#-- New ones from freertos 8.2.1 --]  
	  [#if definition.name=="configUSE_TICKLESS_IDLE"]
	      [#assign configUSE_TICKLESS_IDLE = definition.value]
	  [/#if]
	  [#if definition.name=="configUSE_TASK_NOTIFICATIONS"]
	      [#assign configUSE_TASK_NOTIFICATIONS = definition.value]
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

/* USER CODE BEGIN Includes */   	      
/* Section where include file can be added */
/* USER CODE END Includes */ 

/* Ensure stdint is only used by the compiler, and not the assembler. */
#if defined(__ICCARM__) || defined(__CC_ARM) || defined(__GNUC__)
    #include <stdint.h>
    #include "${main_h}" [#-- for user defines --]
    extern uint32_t SystemCoreClock;
[#if configGENERATE_RUN_TIME_STATS=="1"]
/* USER CODE BEGIN 0 */   	      
    extern void configureTimerForRunTimeStats(void);
    extern unsigned long getRunTimeCounterValue(void);  
/* USER CODE END 0 */       
[/#if]
#endif

#define configUSE_PREEMPTION                     ${valueUsePreemption}
#define configUSE_IDLE_HOOK                      ${valueUseIdleHook}
#define configUSE_TICK_HOOK                      ${valueUseTickHook}
#define configCPU_CLOCK_HZ                       ( ${valueCpuClock} )
[#if CMSIS_version=="1.00"]
#define configTICK_RATE_HZ                       ((portTickType)${valueTickRate})
[#else]
#define configTICK_RATE_HZ                       ((TickType_t)${valueTickRate})
[/#if]
#define configMAX_PRIORITIES                     ( ${valueMaxPriorities} )
#define configMINIMAL_STACK_SIZE                 ((uint16_t)${valueMinimalStackSize})
#define configTOTAL_HEAP_SIZE                    ((size_t)${valueTotalHeapSize})
#define configMAX_TASK_NAME_LEN                  ( ${valueMaxTaskNameLen} )
[#if configGENERATE_RUN_TIME_STATS=="1"]
#define configGENERATE_RUN_TIME_STATS            1
[/#if]
[#if configUSE_TRACE_FACILITY=="1"]
#define configUSE_TRACE_FACILITY                 1
[/#if]
[#if configUSE_STATS_FORMATTING_FUNCTIONS=="1"]
#define configUSE_STATS_FORMATTING_FUNCTIONS     1
[/#if]
#define configUSE_16_BIT_TICKS                   ${valueUse16BitTicks}
[#if configIDLE_SHOULD_YIELD=="0"]
#define configIDLE_SHOULD_YIELD                  0
[/#if]
[#if configUSE_MUTEXES=="1"]
#define configUSE_MUTEXES                        1
[/#if]
#define configQUEUE_REGISTRY_SIZE                ${valueQueueRegistrySize}
[#if configCHECK_FOR_STACK_OVERFLOW !="0"]
#define configCHECK_FOR_STACK_OVERFLOW           ${configCHECK_FOR_STACK_OVERFLOW}
[/#if]
[#if configUSE_RECURSIVE_MUTEXES=="1"]
#define configUSE_RECURSIVE_MUTEXES              1
[/#if]
[#if configUSE_MALLOC_FAILED_HOOK=="1"]
#define configUSE_MALLOC_FAILED_HOOK             1
[/#if]
[#if configUSE_APPLICATION_TASK_TAG=="1"]
#define configUSE_APPLICATION_TASK_TAG           1
[/#if]
[#if configUSE_COUNTING_SEMAPHORES=="1"]
#define configUSE_COUNTING_SEMAPHORES            1
[/#if]
[#if configUSE_ALTERNATIVE_API=="1"]
#define configUSE_ALTERNATIVE_API                1   /* Deprecated! */
[/#if]
[#if configENABLE_BACKWARD_COMPATIBILITY=="0"]
#define configENABLE_BACKWARD_COMPATIBILITY      0
[/#if]
[#if configUSE_PORT_OPTIMISED_TASK_SELECTION=="1"]
#define configUSE_PORT_OPTIMISED_TASK_SELECTION  1
[/#if]
[#if configUSE_TICKLESS_IDLE=="1"]
#define configUSE_TICKLESS_IDLE                  1
[/#if]
[#if configUSE_TASK_NOTIFICATIONS=="0"]
#define configUSE_TASK_NOTIFICATIONS             0
[/#if]

/* Co-routine definitions. */
#define configUSE_CO_ROUTINES                    ${valueUseCoRoutines}
#define configMAX_CO_ROUTINE_PRIORITIES          ( ${valueMaxCoRoutinePriorities} )

[#if configUSE_TIMERS=="1"]
/* Software timer definitions. */
#define configUSE_TIMERS                         1
#define configTIMER_TASK_PRIORITY                ( ${valueTimerTaskPriority} )
#define configTIMER_QUEUE_LENGTH                 ${valueTimerQueueLength}
#define configTIMER_TASK_STACK_DEPTH             ${valueTimerTaskStackDepth}
[/#if]

/* Set the following definitions to 1 to include the API function, or zero
to exclude the API function. */
#define INCLUDE_vTaskPrioritySet            ${valueTaskPrioritySet}
#define INCLUDE_uxTaskPriorityGet           ${valueTaskPriorityGet}
#define INCLUDE_vTaskDelete                 ${valueTaskDelete}
#define INCLUDE_vTaskCleanUpResources       ${valueTaskCleanUpResources}
#define INCLUDE_vTaskSuspend                ${valueTaskSuspend}
#define INCLUDE_vTaskDelayUntil             ${valueTaskDelayUntil}
#define INCLUDE_vTaskDelay                  ${valueTaskDelay}
#define INCLUDE_xTaskGetSchedulerState      ${valueGetSchedulerState}

[#if xTaskResumeFromISR=="0"]
#define INCLUDE_xTaskResumeFromISR          0
[/#if]
[#if xEventGroupSetBitFromISR=="1"]
#define INCLUDE_xEventGroupSetBitFromISR    1
[/#if]
[#if xTimerPendFunctionCall=="1"]
#define INCLUDE_xTimerPendFunctionCall      1
[/#if]
[#if xQueueGetMutexHolder=="1"]
#define INCLUDE_xQueueGetMutexHolder        1
[/#if]
[#if xSemaphoreGetMutexHolder=="1"]
#define INCLUDE_xSemaphoreGetMutexHolder    1
[/#if]
[#if pcTaskGetTaskName=="1"]
#define INCLUDE_pcTaskGetTaskName           1
[/#if]
[#if uxTaskGetStackHighWaterMark=="1"]
#define INCLUDE_uxTaskGetStackHighWaterMark 1
[/#if]
[#if xTaskGetCurrentTaskHandle=="1"]
#define INCLUDE_xTaskGetCurrentTaskHandle   1
[/#if]
[#if eTaskGetState=="1"]
#define INCLUDE_eTaskGetState               1
[/#if]

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

[#if configGENERATE_RUN_TIME_STATS=="1"]
/* USER CODE BEGIN 2 */    
/* Definitions needed when configGENERATE_RUN_TIME_STATS is on */
#define portCONFIGURE_TIMER_FOR_RUN_TIME_STATS configureTimerForRunTimeStats
#define portGET_RUN_TIME_COUNTER_VALUE getRunTimeCounterValue    
/* USER CODE END 2 */
[/#if]

/* USER CODE BEGIN Defines */   	      
/* Section where parameter definitions can be added (for instance, to override default ones in FreeRTOS.h) */
/* USER CODE END Defines */ 

[#if configUSE_TICKLESS_IDLE=="1"]
#if defined(__ICCARM__) || defined(__CC_ARM) || defined(__GNUC__)
void PreSleepProcessing(uint32_t *ulExpectedIdleTime);
void PostSleepProcessing(uint32_t *ulExpectedIdleTime);
#endif /* defined(__ICCARM__) || defined(__CC_ARM) || defined(__GNUC__) */

/* The configPRE_SLEEP_PROCESSING() and configPOST_SLEEP_PROCESSING() macros
allow the application writer to add additional code before and after the MCU is
placed into the low power state respectively. */
#if configUSE_TICKLESS_IDLE == 1 
#define configPRE_SLEEP_PROCESSING                        PreSleepProcessing
#define configPOST_SLEEP_PROCESSING                       PostSleepProcessing
#endif /* configUSE_TICKLESS_IDLE == 1 */
[/#if]

#endif /* FREERTOS_CONFIG_H */
