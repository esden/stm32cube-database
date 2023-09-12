[#ftl]
/* USER CODE BEGIN Header */
/*
 * FreeRTOS Kernel V10.3.1
 * Portion Copyright (C) 2017 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
 * Portion Copyright (C) 2019 StMicroelectronics, Inc.  All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * http://www.FreeRTOS.org
 * http://aws.amazon.com/freertos
 *
 * 1 tab == 4 spaces!
 */
/* USER CODE END Header */

#ifndef FREERTOS_CONFIG_H
#define FREERTOS_CONFIG_H

[#assign familyName=FamilyName?lower_case]
[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]
[#assign instName = SWIP.ipName]
[#assign fileName = SWIP.fileName]
[#assign version = SWIP.version]
[#assign valueMemoryAllocation = "0"]

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
[#-- Since FreeRTOS v9.0 --]
[#assign MEMORY_ALLOCATION = "0"]
[#assign configUSE_DAEMON_TASK_STARTUP_HOOK = "0"]
[#assign INCLUDE_vTaskPrioritySet = "0"]        [#-- In v9.0, has a default value, 0 (in FreeRTOS.h) --]
[#assign INCLUDE_uxTaskPriorityGet = "0"]       [#-- In v9.0, has a default value, 0 (in FreeRTOS.h) --]
[#assign INCLUDE_vTaskDelete = "0"]             [#-- In v9.0, has a default value, 0 (in FreeRTOS.h) --]
[#assign INCLUDE_vTaskSuspend = "0"]            [#-- In v9.0, has a default value, 0 (in FreeRTOS.h) --]
[#assign INCLUDE_vTaskDelayUntil = "0"]         [#-- In v9.0, has a default value, 0 (in FreeRTOS.h) --]
[#assign INCLUDE_vTaskDelay = "0"]              [#-- In v9.0, has a default value, 0 (in FreeRTOS.h) --]
[#assign xTaskAbortDelay = "0"]                 [#-- NEW In v9.0, has a default value, 0 (in FreeRTOS.h) --]
[#assign xTaskGetHandle = "0"]                  [#-- NEW In v9.0, has a default value, 0 (in FreeRTOS.h) --]
[#-- Since FreeRTOS v10.0 --] 
[#assign configRECORD_STACK_HIGH_ADDRESS = "0"]
[#-- For BLE --] 
[#assign configOVERRIDE_DEFAULT_TICK_CONFIGURATION = "0"]
[#-- For 10.2.1 --]
[#assign configENABLE_TRUSTZONE = "0"]
[#assign configRUN_FREERTOS_SECURE_ONLY = "0"]
[#assign configMINIMAL_SECURE_STACK_SIZE = "0"]
[#assign configENABLE_MPU = "0"]
[#assign configENABLE_FPU = "0"]
[#assign configUSE_POSIX_ERRNO = "0"]                 [#-- NEW In 10.2.1, has a default value, 0 (in FreeRTOS.h) --]
[#assign INCLUDE_uxTaskGetStackHighWaterMark2 = "0"]  [#-- NEW In 10.2.1, has a default value, 0 (in FreeRTOS.h) --]

[#-- For NEWLIB --]
[#assign configUSE_NEWLIB_REENTRANT = "0"]

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
      [#-- New ones from freertos 9.0.0 --]
      [#if definition.name=="MEMORY_ALLOCATION"]
          [#assign valueMemoryAllocation = definition.value]
      [/#if]
      [#if definition.name=="configUSE_DAEMON_TASK_STARTUP_HOOK"]
          [#assign configUSE_DAEMON_TASK_STARTUP_HOOK = definition.value]
      [/#if]
      [#if definition.name=="INCLUDE_xTaskAbortDelay"]
          [#assign xTaskAbortDelay = definition.value]
      [/#if]
      [#if definition.name=="INCLUDE_xTaskGetHandle"]
          [#assign xTaskGetHandle = definition.value]
      [/#if]
      [#-- New ones from freertos 10.0.0 --]
      [#if definition.name=="configRECORD_STACK_HIGH_ADDRESS"]
          [#assign configRECORD_STACK_HIGH_ADDRESS = definition.value]
      [/#if]
      [#-- New ones for BLE --]
      [#if definition.name=="configOVERRIDE_DEFAULT_TICK_CONFIGURATION"]
          [#assign configOVERRIDE_DEFAULT_TICK_CONFIGURATION = definition.value]
      [/#if]
      [#-- New ones for 10.2.1 --]
      [#if definition.name=="configENABLE_TRUSTZONE"]
          [#assign configENABLE_TRUSTZONE = definition.value]
      [/#if]
      [#if definition.name=="configRUN_FREERTOS_SECURE_ONLY"]
          [#assign configRUN_FREERTOS_SECURE_ONLY = definition.value]
      [/#if]
      [#if definition.name=="configMINIMAL_SECURE_STACK_SIZE"]
          [#assign configMINIMAL_SECURE_STACK_SIZE = definition.value]
      [/#if]
      [#if definition.name=="configENABLE_MPU"]
          [#assign configENABLE_MPU = definition.value]
      [/#if]
      [#if definition.name=="configENABLE_FPU"]
          [#assign configENABLE_FPU = definition.value]
      [/#if]
      [#if definition.name=="configUSE_POSIX_ERRNO"]
          [#assign configUSE_POSIX_ERRNO = definition.value]
      [/#if]
      [#if definition.name=="INCLUDE_uxTaskGetStackHighWaterMark2"]
          [#assign INCLUDE_uxTaskGetStackHighWaterMark2 = definition.value]
      [/#if]            
      [#-- NEWLIB --]
      [#if definition.name=="configUSE_NEWLIB_REENTRANT"]
          [#assign configUSE_NEWLIB_REENTRANT = definition.value]
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
 * These parameters and more are described within the 'configuration' section of the
 * FreeRTOS API documentation available on the FreeRTOS.org web site.
 *
 * See http://www.freertos.org/a00110.html
 *----------------------------------------------------------*/

/* USER CODE BEGIN Includes */
/* Section where include file can be added */
/* USER CODE END Includes */

[#compress]
[#assign prototypeNeeded = "false"]
[#if timeBaseSource?? && timeBaseSource=="SysTick"]
   [#assign prototypeNeeded = "true"]
[/#if]
[#if timeBaseSource_M4?? && timeBaseSource_M4=="SysTick"]
   [#assign prototypeNeeded = "true"]
[/#if]
[#if timeBaseSource_M7?? && timeBaseSource_M7=="SysTick"]
   [#assign prototypeNeeded = "true"]
[/#if]
/* Ensure definitions are only used by the compiler, and not by the assembler. */
#if defined(__ICCARM__) || defined(__CC_ARM) || defined(__GNUC__)
#t#include <stdint.h>
[#-- BZ 74309 --]
#textern uint32_t ${valueCpuClock};
[#-- BZ 74309 --]
[#if prototypeNeeded == "true"] [#-- generated when timebase=systick --]
#tvoid xPortSysTickHandler(void);
[/#if]
[#if configGENERATE_RUN_TIME_STATS=="1"]
/* USER CODE BEGIN 0 */
#textern void configureTimerForRunTimeStats(void);
#textern unsigned long getRunTimeCounterValue(void);
/* USER CODE END 0 */
[/#if]
#endif
[/#compress]

[#-- Added for 10.2.1 support --]
[#if (familyName=="stm32l5") ]
/*-------------------- STM32L5 specific defines -------------------*/
#define configENABLE_TRUSTZONE                   ${configENABLE_TRUSTZONE}
#define configRUN_FREERTOS_SECURE_ONLY           ${configRUN_FREERTOS_SECURE_ONLY}
[/#if]
#define configENABLE_FPU                         ${configENABLE_FPU}
#define configENABLE_MPU                         ${configENABLE_MPU}

#define configUSE_PREEMPTION                     ${valueUsePreemption}
[#if valueMemoryAllocation == "0"]
#define configSUPPORT_STATIC_ALLOCATION          0
#define configSUPPORT_DYNAMIC_ALLOCATION         1
[/#if]
[#if valueMemoryAllocation == "1"]
#define configSUPPORT_STATIC_ALLOCATION          1
#define configSUPPORT_DYNAMIC_ALLOCATION         0
[/#if]
[#if valueMemoryAllocation == "2"]
#define configSUPPORT_STATIC_ALLOCATION          1
#define configSUPPORT_DYNAMIC_ALLOCATION         1
[/#if]
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
[#if (familyName=="stm32l5") ]
[#if configMINIMAL_SECURE_STACK_SIZE != "0"]
#define configMINIMAL_SECURE_STACK_SIZE          ((uint16_t)${configMINIMAL_SECURE_STACK_SIZE})
[/#if]
[/#if]
[#if valueMemoryAllocation != "1"]
#define configTOTAL_HEAP_SIZE                    ((size_t)${valueTotalHeapSize})
[/#if]
#define configMAX_TASK_NAME_LEN                  ( ${valueMaxTaskNameLen} )
[#if configGENERATE_RUN_TIME_STATS=="1"]
#define configGENERATE_RUN_TIME_STATS            1
[/#if]
[#if configUSE_TRACE_FACILITY=="1"]
#define configUSE_TRACE_FACILITY                 1
[/#if]
[#if configUSE_STATS_FORMATTING_FUNCTIONS != "0"]
#define configUSE_STATS_FORMATTING_FUNCTIONS     ${configUSE_STATS_FORMATTING_FUNCTIONS}
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
[#if configUSE_DAEMON_TASK_STARTUP_HOOK=="1"]
#define configUSE_DAEMON_TASK_STARTUP_HOOK       1
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
#define configUSE_PORT_OPTIMISED_TASK_SELECTION  ${configUSE_PORT_OPTIMISED_TASK_SELECTION}
[#if configUSE_TICKLESS_IDLE=="1"]
#define configUSE_TICKLESS_IDLE                  1
[/#if]
[#if configUSE_TICKLESS_IDLE=="2"]
#define configUSE_TICKLESS_IDLE                  2
[/#if]
[#if configUSE_TASK_NOTIFICATIONS=="0"]
#define configUSE_TASK_NOTIFICATIONS             0
[/#if]
[#if configRECORD_STACK_HIGH_ADDRESS=="1"]
#define configRECORD_STACK_HIGH_ADDRESS          1
[/#if]
[#if configOVERRIDE_DEFAULT_TICK_CONFIGURATION=="1"]
#define configOVERRIDE_DEFAULT_TICK_CONFIGURATION          1
[/#if]
[#-- for 10.2.1 support --]
[#if configUSE_POSIX_ERRNO=="1"]
#define configUSE_POSIX_ERRNO                    1
[/#if]
/* USER CODE BEGIN MESSAGE_BUFFER_LENGTH_TYPE */
/* Defaults to size_t for backward compatibility, but can be changed
   if lengths will always be less than the number of bytes in a size_t. */
#define configMESSAGE_BUFFER_LENGTH_TYPE         size_t
/* USER CODE END MESSAGE_BUFFER_LENGTH_TYPE */
[#-- for 10.2.1 support --]

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

[#if configUSE_NEWLIB_REENTRANT=="1"]
/* The following flag must be enabled only when using newlib */
#define configUSE_NEWLIB_REENTRANT          1
[/#if]

/* Set the following definitions to 1 to include the API function, or zero
to exclude the API function. */
#define INCLUDE_vTaskPrioritySet             ${valueTaskPrioritySet}
#define INCLUDE_uxTaskPriorityGet            ${valueTaskPriorityGet}
#define INCLUDE_vTaskDelete                  ${valueTaskDelete}
#define INCLUDE_vTaskCleanUpResources        ${valueTaskCleanUpResources}
#define INCLUDE_vTaskSuspend                 ${valueTaskSuspend}
#define INCLUDE_vTaskDelayUntil              ${valueTaskDelayUntil}
#define INCLUDE_vTaskDelay                   ${valueTaskDelay}
#define INCLUDE_xTaskGetSchedulerState       ${valueGetSchedulerState}
[#if xTaskResumeFromISR=="0"]
#define INCLUDE_xTaskResumeFromISR           0
[/#if]
[#if xEventGroupSetBitFromISR=="1"]
#define INCLUDE_xEventGroupSetBitFromISR     1
[/#if]
[#if xTimerPendFunctionCall=="1"]
#define INCLUDE_xTimerPendFunctionCall       1
[/#if]
[#if xQueueGetMutexHolder=="1"]
#define INCLUDE_xQueueGetMutexHolder         1
[/#if]
[#if xSemaphoreGetMutexHolder=="1"]
#define INCLUDE_xSemaphoreGetMutexHolder     1
[/#if]
[#if pcTaskGetTaskName=="1"]
#define INCLUDE_pcTaskGetTaskName            1
[/#if]
[#if uxTaskGetStackHighWaterMark=="1"]
#define INCLUDE_uxTaskGetStackHighWaterMark  1
[/#if]
[#if INCLUDE_uxTaskGetStackHighWaterMark2=="1"][#-- Added for 10.2.1 --]
#define INCLUDE_uxTaskGetStackHighWaterMark2 1
[/#if]
[#if xTaskGetCurrentTaskHandle=="1"]
#define INCLUDE_xTaskGetCurrentTaskHandle    1
[/#if]
[#if eTaskGetState=="1"]
#define INCLUDE_eTaskGetState                1
[/#if]
[#if xTaskAbortDelay=="1"]
#define INCLUDE_xTaskAbortDelay              1
[/#if]
[#if xTaskGetHandle=="1"]
#define INCLUDE_xTaskGetHandle               1
[/#if]

[#if (familyName=="stm32g0") || (familyName=="stm32f0") || (familyName=="stm32l0")]  [#-- BZ 47214 --]
[#else]
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
[/#if]

/* Normal assert() semantics without relying on the provision of an assert.h
header file. */
/* USER CODE BEGIN 1 */
#define configASSERT( x ) ${valueAssert}
/* USER CODE END 1 */

[#if (familyName=="stm32l5") ]
[#-- Removed for CM33 (L5 specs) --]
[#else]
/* Definitions that map the FreeRTOS port interrupt handlers to their CMSIS
standard names. */
#define vPortSVCHandler    SVC_Handler
#define xPortPendSVHandler PendSV_Handler

/* IMPORTANT: This define is commented when used with STM32Cube firmware, when the timebase source is SysTick,
              to prevent overwriting SysTick_Handler defined within STM32Cube HAL */
[#-- for dual core, need to check the right timebase (for others, keep previous check --]
[#if (familyName=="stm32h7")] 
 [#assign timeBaseTreated = "0"]
 [#if cpucore!="" && cpucore?replace("ARM_CORTEX_","")=="M4"]
  [#if timeBaseSource_M4?? && timeBaseSource_M4!="SysTick"]
#define xPortSysTickHandler SysTick_Handler
  [#else]
/* #define xPortSysTickHandler SysTick_Handler */
  [/#if]
  [#assign timeBaseTreated = "1"]
 [/#if]
 [#if cpucore!="" &&cpucore?replace("ARM_CORTEX_","")=="M7"]
  [#if timeBaseSource_M7?? && timeBaseSource_M7!="SysTick"]
#define xPortSysTickHandler SysTick_Handler
  [#else]
/* #define xPortSysTickHandler SysTick_Handler */
  [/#if]
  [#assign timeBaseTreated = "1"]
 [/#if]
 [#if timeBaseTreated = "0"] [#-- not yet treated (on h7 single-core mcus) --]
  [#if timeBaseSource?? && timeBaseSource!="SysTick"]
#define xPortSysTickHandler SysTick_Handler
  [#else]
/* #define xPortSysTickHandler SysTick_Handler */
  [/#if]
 [/#if]
[#else] [#-- not a h7 (test for mcu with no context: to be checkedand confirmed on L5!) --]
 [#if timeBaseSource?? && timeBaseSource!="SysTick"]
#define xPortSysTickHandler SysTick_Handler
 [#else]
/* #define xPortSysTickHandler SysTick_Handler */
 [/#if]
[/#if]

[/#if]

[#if USE_Touch_GFX_STACK??]
/* To measure mcu load by measure time used in the dummy idle task */
#define traceTASK_SWITCHED_OUT() xTaskCallApplicationTaskHook( pxCurrentTCB, (void*)1 )
#define traceTASK_SWITCHED_IN() xTaskCallApplicationTaskHook( pxCurrentTCB, (void*)0 )
[/#if]

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
void PreSleepProcessing(uint32_t ulExpectedIdleTime);
void PostSleepProcessing(uint32_t ulExpectedIdleTime);
#endif /* defined(__ICCARM__) || defined(__CC_ARM) || defined(__GNUC__) */

/* The configPRE_SLEEP_PROCESSING() and configPOST_SLEEP_PROCESSING() macros
allow the application writer to add additional code before and after the MCU is
placed into the low power state respectively. */
#if configUSE_TICKLESS_IDLE == 1 
#define configPRE_SLEEP_PROCESSING(__x__)                           \
                                       do {                         \
                                         __x__ = 0;                 \
                                         PreSleepProcessing(__x__); \
                                      }while(0)
#define configPOST_SLEEP_PROCESSING                       PostSleepProcessing
#endif /* configUSE_TICKLESS_IDLE == 1 */
[/#if]

#endif /* FREERTOS_CONFIG_H */
