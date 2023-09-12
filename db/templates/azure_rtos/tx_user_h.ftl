[#ftl]
/**************************************************************************/
/*                                                                        */
/*       Copyright (c) Microsoft Corporation. All rights reserved.        */
/*                                                                        */
/*       This software is licensed under the Microsoft Software License   */
/*       Terms for Microsoft Azure RTOS. Full text of the license can be  */
/*       found in the LICENSE file at https://aka.ms/AzureRTOS_EULA       */
/*       and in the root directory of this software.                      */
/*                                                                        */
/**************************************************************************/


/**************************************************************************/
/**************************************************************************/
/**                                                                       */
/** ThreadX Component                                                     */
/**                                                                       */
/**   User Specific                                                       */
/**                                                                       */
/**************************************************************************/
/**************************************************************************/


/**************************************************************************/
/*                                                                        */
/*  PORT SPECIFIC C INFORMATION                            RELEASE        */
/*                                                                        */
/*    tx_user.h                                           PORTABLE C      */
/*                                                           6.0          */
/*                                                                        */
/*  AUTHOR                                                                */
/*                                                                        */
/*    William E. Lamie, Microsoft Corporation                             */
/*                                                                        */
/*  DESCRIPTION                                                           */
/*                                                                        */
/*    This file contains user defines for configuring ThreadX in specific */
/*    ways. This file will have an effect only if the application and     */
/*    ThreadX library are built with TX_INCLUDE_USER_DEFINE_FILE defined. */
/*    Note that all the defines in this file may also be made on the      */
/*    command line when building ThreadX library and application objects. */
/*                                                                        */
/*  RELEASE HISTORY                                                       */
/*                                                                        */
/*    DATE              NAME                      DESCRIPTION             */
/*                                                                        */
/*  05-19-2020     William E. Lamie         Initial Version 6.0           */
/*                                                                        */
/**************************************************************************/

#ifndef TX_USER_H
#define TX_USER_H

[#compress]

[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]

	[#if name == "TX_MINIMUM_STACK"]
      [#assign TX_MINIMUM_STACK_value = value]
    [/#if]
	
	[#if name == "TX_MAX_PRIORITIES"]
      [#assign TX_MAX_PRIORITIES_value = value]
    [/#if]
	
	[#if name == "TX_THREAD_USER_EXTENSION"]
      [#assign TX_THREAD_USER_EXTENSION_value = value]
    [/#if]
	
	[#if name == "TX_TIMER_THREAD_STACK_SIZE"]
      [#assign TX_TIMER_THREAD_STACK_SIZE_value = value]
    [/#if]
	
	[#if name == "TX_TIMER_THREAD_PRIORITY"]
      [#assign TX_TIMER_THREAD_PRIORITY_value = value]
    [/#if]
	
    [#if name == "TX_TIMER_PROCESS_IN_ISR"]
      [#assign TX_TIMER_PROCESS_IN_ISR_value = value]
    [/#if]
	
	[#if name == "TX_REACTIVATE_INLINE"]
      [#assign TX_REACTIVATE_INLINE_value = value]
    [/#if]
	
	[#if name == "TX_DISABLE_STACK_FILLING"]
      [#assign TX_DISABLE_STACK_FILLING_value = value]
    [/#if]
	
	[#if name == "TX_DISABLE_PREEMPTION_THRESHOLD"]
      [#assign TX_DISABLE_PREEMPTION_THRESHOLD_value = value]
    [/#if]
	
	[#if name == "TX_DISABLE_REDUNDANT_CLEARING"]
      [#assign TX_DISABLE_REDUNDANT_CLEARING_value = value]
    [/#if]
	
	[#if name == "TX_DISABLE_NOTIFY_CALLBACKS"]
      [#assign TX_DISABLE_NOTIFY_CALLBACKS_value = value]
    [/#if]
	
	[#if name == "TX_INLINE_THREAD_RESUME_SUSPEND"]
      [#assign TX_INLINE_THREAD_RESUME_SUSPEND_value = value]
    [/#if]
	
	[#if name == "TX_NOT_INTERRUPTABLE"]
      [#assign TX_NOT_INTERRUPTABLE_value = value]
    [/#if]
	
	[#if name == "TX_ENABLE_EVENT_TRACE"]
      [#assign TX_ENABLE_EVENT_TRACE_value = value]
    [/#if]
	
	[#if name == "TX_BLOCK_POOL_ENABLE_PERFORMANCE_INFO"]
      [#assign TX_BLOCK_POOL_ENABLE_PERFORMANCE_INFO_value = value]
    [/#if]
	
	[#if name == "TX_BYTE_POOL_ENABLE_PERFORMANCE_INFO"]
      [#assign TX_BYTE_POOL_ENABLE_PERFORMANCE_INFO_value = value]
    [/#if]
	
	[#if name == "TX_EVENT_FLAGS_ENABLE_PERFORMANCE_INFO"]
      [#assign TX_EVENT_FLAGS_ENABLE_PERFORMANCE_INFO_value = value]
    [/#if]
	
	[#if name == "TX_MUTEX_ENABLE_PERFORMANCE_INFO"]
      [#assign TX_MUTEX_ENABLE_PERFORMANCE_INFO_value = value]
    [/#if]
	
	[#if name == "TX_QUEUE_ENABLE_PERFORMANCE_INFO"]
      [#assign TX_QUEUE_ENABLE_PERFORMANCE_INFO_value = value]
    [/#if]
	
	[#if name == "TX_SEMAPHORE_ENABLE_PERFORMANCE_INFO"]
      [#assign TX_SEMAPHORE_ENABLE_PERFORMANCE_INFO_value = value]
    [/#if]
	
	[#if name == "TX_THREAD_ENABLE_PERFORMANCE_INFO"]
      [#assign TX_THREAD_ENABLE_PERFORMANCE_INFO_value = value]
    [/#if]
	
	[#if name == "TX_TIMER_ENABLE_PERFORMANCE_INFO"]
      [#assign TX_TIMER_ENABLE_PERFORMANCE_INFO_value = value]
    [/#if]
	

	[#if name == "TX_TRACE_TIME_SOURCE"]
      [#assign TX_TRACE_TIME_SOURCE_value = value]
    [/#if]
	
	[#if name == "TX_TRACE_TIME_MASK"]
      [#assign TX_TRACE_TIME_MASK_value = value]
    [/#if]
	
	[#if name == "TX_ENABLE_EXECUTION_CHANGE_NOTIFY"]
      [#assign TX_ENABLE_EXECUTION_CHANGE_NOTIFY_value = value]
    [/#if]
	
	[#if name == "TX_THREAD_GET_SYSTEM_STATE"]
      [#assign TX_THREAD_GET_SYSTEM_STATE_value = value]
    [/#if]
	
	[#if name == "TX_THREAD_SYSTEM_RETURN_CHECK"]
      [#assign TX_THREAD_SYSTEM_RETURN_CHECK_value = value]
    [/#if]
	
	[#if name == "TX_TIMER_TICKS_PER_SECOND"]
      [#assign TX_TIMER_TICKS_PER_SECOND_value = value]
    [/#if]
	
	[#if name == "ALIGN_TYPE_DEFINED"]
      [#assign ALIGN_TYPE_DEFINED_value = value]
    [/#if]
	
	[#if name == "ALIGN_TYPE_VAL"]
      [#assign ALIGN_TYPE_VAL_value = value]
    [/#if]
	
	[#if name == "TX_MEMSET"]
      [#assign TX_MEMSET_value = value]
    [/#if]
	
	[#if name == "TX_SAFETY_CRITICAL"]
      [#assign TX_SAFETY_CRITICAL_value = value]
    [/#if]

	[#if name == "TX_LOW_POWER"]
      [#assign TX_LOW_POWER_value = value]
    [/#if]
	
	[#if name == "TX_LOW_POWER_TIMER_SETUP"]
      [#assign TX_LOW_POWER_TIMER_SETUP_value = value]
    [/#if]
	
	[#if name == "TX_LOW_POWER_TICKLESS"]
      [#assign TX_LOW_POWER_TICKLESS_value = value]
    [/#if]
	
	[#if name == "TX_LOW_POWER_USER_ENTER"]
      [#assign TX_LOW_POWER_USER_ENTER_value = value]
    [/#if]
	
	[#if name == "TX_LOW_POWER_USER_EXIT"]
      [#assign TX_LOW_POWER_USER_EXIT_value = value]
    [/#if]
	
	[#if name == "TX_LOW_POWER_USER_TIMER_ADJUST"]
      [#assign TX_LOW_POWER_USER_TIMER_ADJUST_value = value]
    [/#if]
  [/#list]
[/#if]
[/#list]
[/#compress]

/* Define various build options for the ThreadX port.  The application should either make changes
   here by commenting or un-commenting the conditional compilation defined OR supply the defines
   though the compiler's equivalent of the -D option.

   For maximum speed, the following should be defined:

        TX_MAX_PRIORITIES                       32
        TX_DISABLE_PREEMPTION_THRESHOLD
        TX_DISABLE_REDUNDANT_CLEARING
        TX_DISABLE_NOTIFY_CALLBACKS
        TX_NOT_INTERRUPTABLE
        TX_TIMER_PROCESS_IN_ISR
        TX_REACTIVATE_INLINE
        TX_DISABLE_STACK_FILLING
        TX_INLINE_THREAD_RESUME_SUSPEND

   For minimum size, the following should be defined:

        TX_MAX_PRIORITIES                       32
        TX_DISABLE_PREEMPTION_THRESHOLD
        TX_DISABLE_REDUNDANT_CLEARING
        TX_DISABLE_NOTIFY_CALLBACKS
        TX_NOT_INTERRUPTABLE
        TX_TIMER_PROCESS_IN_ISR

   Of course, many of these defines reduce functionality and/or change the behavior of the
   system in ways that may not be worth the trade-off. For example, the TX_TIMER_PROCESS_IN_ISR
   results in faster and smaller code, however, it increases the amount of processing in the ISR.
   In addition, some services that are available in timers are not available from ISRs and will
   therefore return an error if this option is used. This may or may not be desirable for a
   given application.  */


/* Override various options with default values already assigned in tx_port.h. Please also refer
   to tx_port.h for descriptions on each of these options.  */

[#if TX_MAX_PRIORITIES_value == "32"]
/*#define TX_MAX_PRIORITIES                32*/
[#else]
#define TX_MAX_PRIORITIES                ${TX_MAX_PRIORITIES_value}
[/#if]
[#if TX_THREAD_USER_EXTENSION_value == " " || TX_THREAD_USER_EXTENSION_value == ""]
/*#define TX_THREAD_USER_EXTENSION                ????*/
[#else]
#define TX_THREAD_USER_EXTENSION                ${TX_THREAD_USER_EXTENSION_value}
[/#if]
[#if TX_TIMER_THREAD_STACK_SIZE_value == "1024"]
/*#define TX_TIMER_THREAD_STACK_SIZE                1024*/
[#else]
#define TX_TIMER_THREAD_STACK_SIZE                ${TX_TIMER_THREAD_STACK_SIZE_value}
[/#if]
[#if TX_TIMER_THREAD_PRIORITY_value == "0"]
/*#define TX_TIMER_THREAD_PRIORITY                0*/
[#else]
#define TX_TIMER_THREAD_PRIORITY                ${TX_TIMER_THREAD_PRIORITY_value}
[/#if]

[#if TX_MINIMUM_STACK_value == "200"]
/*#define TX_MINIMUM_STACK                200*/
[#else]
#define TX_MINIMUM_STACK                ${TX_MINIMUM_STACK_value}
[/#if]

/* Determine if timer expirations (application timers, timeouts, and tx_thread_sleep calls
   should be processed within the a system timer thread or directly in the timer ISR.
   By default, the timer thread is used. When the following is defined, the timer expiration
   processing is done directly from the timer ISR, thereby eliminating the timer thread control
   block, stack, and context switching to activate it.  */

[#if TX_TIMER_PROCESS_IN_ISR_value == "1"]
#define TX_TIMER_PROCESS_IN_ISR
[#else]
/*#define TX_TIMER_PROCESS_IN_ISR*/
[/#if]

/* Determine if in-line timer reactivation should be used within the timer expiration processing.
   By default, this is disabled and a function call is used. When the following is defined,
   reactivating is performed in-line resulting in faster timer processing but slightly larger
   code size.  */

[#if TX_REACTIVATE_INLINE_value == "1"]
#define TX_REACTIVATE_INLINE
[#else]
/*#define TX_REACTIVATE_INLINE*/
[/#if]

/* Determine is stack filling is enabled. By default, ThreadX stack filling is enabled,
   which places an 0xEF pattern in each byte of each thread's stack.  This is used by
   debuggers with ThreadX-awareness and by the ThreadX run-time stack checking feature.  */

[#if TX_DISABLE_STACK_FILLING_value == "1"]
#define TX_DISABLE_STACK_FILLING
[#else]
/*#define TX_DISABLE_STACK_FILLING*/
[/#if]

/* Determine if preemption-threshold should be disabled. By default, preemption-threshold is
   enabled. If the application does not use preemption-threshold, it may be disabled to reduce
   code size and improve performance.  */

[#if TX_DISABLE_PREEMPTION_THRESHOLD_value == "1"]
#define TX_DISABLE_PREEMPTION_THRESHOLD
[#else]
/*#define TX_DISABLE_PREEMPTION_THRESHOLD*/
[/#if]

/* Determine if global ThreadX variables should be cleared. If the compiler startup code clears
   the .bss section prior to ThreadX running, the define can be used to eliminate unnecessary
   clearing of ThreadX global variables.  */

[#if TX_DISABLE_REDUNDANT_CLEARING_value == "1"]
#define TX_DISABLE_REDUNDANT_CLEARING
[#else]
/*#define TX_DISABLE_REDUNDANT_CLEARING*/
[/#if]

/* Determine if the notify callback option should be disabled. By default, notify callbacks are
   enabled. If the application does not use notify callbacks, they may be disabled to reduce
   code size and improve performance.  */

[#if TX_DISABLE_NOTIFY_CALLBACKS_value == "1"]
#define TX_DISABLE_NOTIFY_CALLBACKS
[#else]
/*#define TX_DISABLE_NOTIFY_CALLBACKS*/
[/#if]

/* Determine if the tx_thread_resume and tx_thread_suspend services should have their internal
   code in-line. This results in a larger image, but improves the performance of the thread
   resume and suspend services.  */

[#if TX_INLINE_THREAD_RESUME_SUSPEND_value == "1"]
#define TX_INLINE_THREAD_RESUME_SUSPEND
[#else]
/*#define TX_INLINE_THREAD_RESUME_SUSPEND*/
[/#if]

/* Determine if the internal ThreadX code is non-interruptable. This results in smaller code
   size and less processing overhead, but increases the interrupt lockout time.  */

[#if TX_NOT_INTERRUPTABLE_value == "1"]
#define TX_NOT_INTERRUPTABLE
[#else]
/*#define TX_NOT_INTERRUPTABLE*/
[/#if]

/* Determine if the trace event logging code should be enabled. This causes slight increases in
   code size and overhead, but provides the ability to generate system trace information which
   is available for viewing in TraceX.  */

[#if TX_ENABLE_EVENT_TRACE_value == "1"]
#define TX_ENABLE_EVENT_TRACE
[#else]
/*#define TX_ENABLE_EVENT_TRACE*/
[/#if]

/* Determine if block pool performance gathering is required by the application. When the following is
   defined, ThreadX gathers various block pool performance information. */

[#if TX_BLOCK_POOL_ENABLE_PERFORMANCE_INFO_value == "1"]
#define TX_BLOCK_POOL_ENABLE_PERFORMANCE_INFO
[#else]
/*#define TX_BLOCK_POOL_ENABLE_PERFORMANCE_INFO*/
[/#if]

/* Determine if byte pool performance gathering is required by the application. When the following is
   defined, ThreadX gathers various byte pool performance information. */

[#if TX_BYTE_POOL_ENABLE_PERFORMANCE_INFO_value == "1"]
#define TX_BYTE_POOL_ENABLE_PERFORMANCE_INFO
[#else]
/*#define TX_BYTE_POOL_ENABLE_PERFORMANCE_INFO*/
[/#if]

/* Determine if event flags performance gathering is required by the application. When the following is
   defined, ThreadX gathers various event flags performance information. */

[#if TX_EVENT_FLAGS_ENABLE_PERFORMANCE_INFO_value == "1"]
#define TX_EVENT_FLAGS_ENABLE_PERFORMANCE_INFO
[#else]
/*#define TX_EVENT_FLAGS_ENABLE_PERFORMANCE_INFO*/
[/#if]

/* Determine if mutex performance gathering is required by the application. When the following is
   defined, ThreadX gathers various mutex performance information. */

[#if TX_MUTEX_ENABLE_PERFORMANCE_INFO_value == "1"]
#define TX_MUTEX_ENABLE_PERFORMANCE_INFO
[#else]
/*#define TX_MUTEX_ENABLE_PERFORMANCE_INFO*/
[/#if]

/* Determine if queue performance gathering is required by the application. When the following is
   defined, ThreadX gathers various queue performance information. */

[#if TX_QUEUE_ENABLE_PERFORMANCE_INFO_value == "1"]
#define TX_QUEUE_ENABLE_PERFORMANCE_INFO
[#else]
/*#define TX_QUEUE_ENABLE_PERFORMANCE_INFO*/
[/#if]

/* Determine if semaphore performance gathering is required by the application. When the following is
   defined, ThreadX gathers various semaphore performance information. */

[#if TX_SEMAPHORE_ENABLE_PERFORMANCE_INFO_value == "1"]
#define TX_SEMAPHORE_ENABLE_PERFORMANCE_INFO
[#else]
/*#define TX_SEMAPHORE_ENABLE_PERFORMANCE_INFO*/
[/#if]

/* Determine if thread performance gathering is required by the application. When the following is
   defined, ThreadX gathers various thread performance information. */

[#if TX_THREAD_ENABLE_PERFORMANCE_INFO_value == "1"]
#define TX_THREAD_ENABLE_PERFORMANCE_INFO
[#else]
/*#define TX_THREAD_ENABLE_PERFORMANCE_INFO*/
[/#if]

/* Determine if timer performance gathering is required by the application. When the following is
   defined, ThreadX gathers various timer performance information. */

[#if TX_TIMER_ENABLE_PERFORMANCE_INFO_value == "1"]
#define TX_TIMER_ENABLE_PERFORMANCE_INFO
[#else]
/*#define TX_TIMER_ENABLE_PERFORMANCE_INFO*/
[/#if]

[#if TX_ENABLE_EVENT_TRACE_value == "1"]
/* Define the clock source for trace event entry time stamp. */

[#if TX_TRACE_TIME_SOURCE_value != "0xE0001004"]
#define TX_TRACE_TIME_SOURCE  *((ULONG *) ${TX_TRACE_TIME_SOURCE_value})
[#else]
/*#define TX_TRACE_TIME_SOURCE  *((ULONG *) 0xE0001004)*/
[/#if]

/* Define the clock source for trace mask. */

[#if TX_TRACE_TIME_MASK_value != "0xFFFFFFFF"]
#define TX_TRACE_TIME_MASK  ${TX_TRACE_TIME_MASK_value}UL
[#else]
/*#define TX_TRACE_TIME_MASK  0xFFFFFFFFUL*/
[/#if]
[/#if]

/* Define if the execution change notify is enabled. */

[#if TX_ENABLE_EXECUTION_CHANGE_NOTIFY_value == "1"]
#define TX_ENABLE_EXECUTION_CHANGE_NOTIFY
[#else]
/*#define TX_ENABLE_EXECUTION_CHANGE_NOTIFY*/
[/#if]

/* Define the get system state macro. */

[#if TX_THREAD_GET_SYSTEM_STATE_value == "_tx_thread_system_state"]
/*#define TX_THREAD_GET_SYSTEM_STATE() _tx_thread_system_state */
[#else]
#define TX_THREAD_GET_SYSTEM_STATE()  ${TX_THREAD_GET_SYSTEM_STATE_value}
[/#if]

/* Define the check for whether or not to call the
    _tx_thread_system_return function (TX_THREAD_SYSTEM_RETURN_CHECK(c)). */

[#if TX_THREAD_SYSTEM_RETURN_CHECK_value != "_tx_thread_preempt_disable"]
#define TX_THREAD_SYSTEM_RETURN_CHECK (c)  ((ULONG) ${TX_THREAD_SYSTEM_RETURN_CHECK_value})
[#else]
/*#define TX_THREAD_SYSTEM_RETURN_CHECK (c)  ((ULONG) _tx_thread_preempt_disable)*/
[/#if]

/* Define the common timer tick reference for use by other middleware components. */

[#if TX_TIMER_TICKS_PER_SECOND_value == "100"]
/*#define TX_TIMER_TICKS_PER_SECOND                100*/
[#else]
#define TX_TIMER_TICKS_PER_SECOND                ${TX_TIMER_TICKS_PER_SECOND_value}
[/#if]

/* Determinate if the basic alignment type is defined. */

[#if ALIGN_TYPE_DEFINED_value == "1"]
#define ALIGN_TYPE_DEFINED
[#else]
/*#define ALIGN_TYPE_DEFINED*/
[/#if]

/* Define basic alignment type used in block and byte pool operations. */

[#if ALIGN_TYPE_DEFINED_value == "1"]
#define ALIGN_TYPE  ${ALIGN_TYPE_VAL_value}
[#else]
/*#define ALIGN_TYPE  ULONG*/
[/#if]

/* Define the TX_MEMSET macro to the standard library function. */

[#if TX_MEMSET_value != "memset"]
#define TX_MEMSET  ${TX_MEMSET_value}((a),(b),(c))
[#else]
/*#define TX_MEMSET  memset((a),(b),(c))*/
[/#if]

/* Define if the safety critical configuration is enabled. */

[#if TX_SAFETY_CRITICAL_value == "1"]
#define TX_SAFETY_CRITICAL
[#else]
/*#define TX_SAFETY_CRITICAL*/
[/#if]

[#if TX_LOW_POWER_value == "1"]
/* Define the LowPower macros and flags */

/* Define a macro that sets up a low power clock and keep track of time */
[#if TX_LOW_POWER_TIMER_SETUP_value == " " || TX_LOW_POWER_TIMER_SETUP_value == ""]
/*#define TX_LOW_POWER_TIMER_SETUP */
[#else]
void ${TX_LOW_POWER_TIMER_SETUP_value}(unsigned long count);
#define TX_LOW_POWER_TIMER_SETUP(_count) ${TX_LOW_POWER_TIMER_SETUP_value}(_count)
[/#if]

/* Define the TX_LOW_POWER_TICKLESS to disable the internal ticks */
[#if TX_LOW_POWER_TICKLESS_value == "1"]
#define TX_LOW_POWER_TICKLESS 
[#else]
/* #define TX_LOW_POWER_TICKLESS */
[/#if]

/* A user defined macro to make the system enter low power mode */
[#if TX_LOW_POWER_USER_ENTER_value == " " || TX_LOW_POWER_USER_ENTER_value == ""]
/*#define TX_LOW_POWER_USER_ENTER */
[#else]
void ${TX_LOW_POWER_USER_ENTER_value}();
#define TX_LOW_POWER_USER_ENTER ${TX_LOW_POWER_USER_ENTER_value}()
[/#if]


/* A user defined macro to make the system exit low power mode */
[#if TX_LOW_POWER_USER_EXIT_value == " " || TX_LOW_POWER_USER_EXIT_value == ""]
/*#define TX_LOW_POWER_USER_EXIT */
[#else]
void ${TX_LOW_POWER_USER_EXIT_value}();
#define TX_LOW_POWER_USER_EXIT ${TX_LOW_POWER_USER_EXIT_value}()
[/#if]

/* User's low-power macro to obtain the amount of time (in ticks) the system has been in low power mode */
[#if TX_LOW_POWER_USER_TIMER_ADJUST_value == " " || TX_LOW_POWER_USER_TIMER_ADJUST_value == ""]
/*#define TX_LOW_POWER_USER_TIMER_ADJUST */
[#else]
unsigned long ${TX_LOW_POWER_USER_TIMER_ADJUST_value}();
#define TX_LOW_POWER_USER_TIMER_ADJUST ${TX_LOW_POWER_USER_TIMER_ADJUST_value}()
[/#if]

[/#if]
#endif
