[#ftl]
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]

  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
   [#if name == "TX_TIMER_TICKS_PER_SECOND"]
      [#assign TX_TIMER_TICKS_PER_SECOND_value = value]
    [/#if]
   [#if name == "AZRTOS_APP_MEM_ALLOCATION_METHOD"]
      [#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_value = value]
    [/#if]
		[#if name == "CORTEX_CLOCK_SELECTION"]
      [#assign CORTEX_CLOCK_SELECTION_value = value]
    [/#if]
		[#if name == "CORTEX_CLOCK_FREQ"]
      [#assign CORTEX_CLOCK_FREQ_value = value?number?replace(",", "")]
    [/#if]

  [/#list]

[/#if]
[/#list]
[/#compress]

[#if FamilyName != "STM32MP13"]
// by default AzureRTOS is configured to use static byte pool for
// allocation, in case dynamic allocation is to be used, uncomment
// the define below and update the linker files to define the following symbols
// EWARM toolchain:
//       place in RAM_region    { last section FREE_MEM};
// MDK-ARM toolchain;
//       either define the RW_IRAM1 region in the ".sct" file or modify this file by referring to the correct memory region.
//         LDR r1, =|Image$$RW_IRAM1$$ZI$$Limit|
// STM32CubeIDE toolchain:
//       ._threadx_heap :
//       {
//        . = ALIGN(8);
//        __RAM_segment_used_end__ = .;
//        . = . + 64K;
//        . = ALIGN(8);
//       } >RAM_D1 AT> RAM_D1
//  The simplest way to provide memory for ThreadX is to define a new section, see ._threadx_heap above.
//  In the example above the ThreadX heap size is set to 64KBytes.
//  The ._threadx_heap must be located between the .bss and the ._user_heap_stack sections in the linker script.
//  Caution: Make sure that ThreadX does not need more than the provided heap memory (64KBytes in this example).
//  Read more in STM32CubeIDE User Guide, chapter: "Linker script".

[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_value == "1"]
//#define USE_DYNAMIC_MEMORY_ALLOCATION
[#else]
#define USE_DYNAMIC_MEMORY_ALLOCATION
[/#if]

#if defined (__clang__)
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
/**   Initialize                                                          */
/**                                                                       */
/**************************************************************************/
/**************************************************************************/

[#if FamilyName == "STM32WBA"]
SYSTEM_CLOCK      =   ${CORTEX_CLOCK_FREQ_value}
[#else]
SYSTEM_CLOCK      =   ${HCLKFreq_Value}
[/#if]
SYSTICK_CYCLES    =   ((SYSTEM_CLOCK / ${TX_TIMER_TICKS_PER_SECOND_value}) -1)

/**************************************************************************/
/*                                                                        */
/*  FUNCTION                                               RELEASE        */
/*                                                                        */
/*    _tx_initialize_low_level                          Cortex-M33/AC6    */
/*                                                           6.1          */
/*  AUTHOR                                                                */
/*                                                                        */
/*    Scott Larson, Microsoft Corporation                                 */
/*                                                                        */
/*  DESCRIPTION                                                           */
/*                                                                        */
/*    This function is responsible for any low-level processor            */
/*    initialization, including setting up interrupt vectors, setting     */
/*    up a periodic timer interrupt source, saving the system stack       */
/*    pointer for use in ISR processing later, and finding the first      */
/*    available RAM memory address for tx_application_define.             */
/*                                                                        */
/*  INPUT                                                                 */
/*                                                                        */
/*    None                                                                */
/*                                                                        */
/*  OUTPUT                                                                */
/*                                                                        */
/*    None                                                                */
/*                                                                        */
/*  CALLS                                                                 */
/*                                                                        */
/*    None                                                                */
/*                                                                        */
/*  CALLED BY                                                             */
/*                                                                        */
/*    _tx_initialize_kernel_enter           ThreadX entry function        */
/*                                                                        */
/*  RELEASE HISTORY                                                       */
/*                                                                        */
/*    DATE              NAME                      DESCRIPTION             */
/*                                                                        */
/*  09-30-2020      Scott Larson            Initial Version 6.1           */
/*                                                                        */
/**************************************************************************/
// VOID   _tx_initialize_low_level(VOID)
// {
    .section .text
    .balign 4
    .syntax unified
    .eabi_attribute Tag_ABI_align_preserved, 1
    .global  _tx_initialize_low_level
    .thumb_func
.type _tx_initialize_low_level, function
_tx_initialize_low_level:

    /* Disable interrupts during ThreadX initialization.  */
    CPSID   i

    /* Set base of available memory to end of non-initialised RAM area.  */
#ifdef USE_DYNAMIC_MEMORY_ALLOCATION
    LDR     r0, =_tx_initialize_unused_memory       // Build address of unused memory pointer
    LDR     r1, =Image$$RW_IRAM1$$ZI$$Limit         // Build first free address
    ADD     r1, r1, #4                              //
    STR     r1, [r0]                                // Setup first unused memory pointer
#endif

    /* Setup Vector Table Offset Register.  */
    MOV     r0, #0xE000E000                         // Build address of NVIC registers
    LDR     r1, =__Vectors                          // Pickup address of vector table
    STR     r1, [r0, #0xD08]                        // Set vector table address

    /* Enable the cycle count register.  */
    LDR     r0, =0xE0001000                         // Build address of DWT register
    LDR     r1, [r0]                                // Pickup the current value
    ORR     r1, r1, #1                              // Set the CYCCNTENA bit
    STR     r1, [r0]                                // Enable the cycle count register

    /* Set system stack pointer from vector value.  */
    LDR     r0, =_tx_thread_system_stack_ptr        // Build address of system stack pointer
    LDR     r1, =__Vectors                          // Pickup address of vector table
    LDR     r1, [r1]                                // Pickup reset stack pointer
    STR     r1, [r0]                                // Save system stack pointer

    /* Configure SysTick.  */
    MOV     r0, #0xE000E000                         // Build address of NVIC registers
    LDR     r1, =SYSTICK_CYCLES
    STR     r1, [r0, #0x14]                         // Setup SysTick Reload Value
[#if FamilyName == "STM32WBA"]
    MOV     r1, #0x3                                // Build SysTick Control Enable Value
[#else]
    MOV     r1, #0x7                                // Build SysTick Control Enable Value
[/#if]
    STR     r1, [r0, #0x10]                         // Setup SysTick Control

    /* Configure handler priorities.  */
    LDR     r1, =0x00000000                         // Rsrv, UsgF, BusF, MemM
    STR     r1, [r0, #0xD18]                        // Setup System Handlers 4-7 Priority Registers

    LDR     r1, =0xFF000000                         // SVCl, Rsrv, Rsrv, Rsrv
    STR     r1, [r0, #0xD1C]                        // Setup System Handlers 8-11 Priority Registers
                                                    // Note: SVC must be lowest priority, which is 0xFF

    LDR     r1, =0x40FF0000                         // SysT, PnSV, Rsrv, DbgM
    STR     r1, [r0, #0xD20]                        // Setup System Handlers 12-15 Priority Registers
                                                    // Note: PnSV must be lowest priority, which is 0xFF

    /* Return to caller.  */
    BX      lr
// }


/* Define shells for each of the unused vectors.  */
    .section .text
    .balign 4
    .syntax unified
    .eabi_attribute Tag_ABI_align_preserved, 1
    .global  __tx_BadHandler
    .thumb_func
.type __tx_BadHandler, function
__tx_BadHandler:
    B       __tx_BadHandler


    .section .text
    .balign 4
    .syntax unified
    .eabi_attribute Tag_ABI_align_preserved, 1
    .global  __tx_IntHandler
    .thumb_func
.type __tx_IntHandler, function
__tx_IntHandler:
// VOID InterruptHandler (VOID)
// {
    PUSH    {r0,lr}     // Save LR (and dummy r0 to maintain stack alignment)
#if (defined(TX_ENABLE_EXECUTION_CHANGE_NOTIFY) || defined(TX_EXECUTION_PROFILE_ENABLE))
    BL      _tx_execution_isr_enter             // Call the ISR enter function
#endif
    /* Do interrupt handler work here */
    /* .... */
#if (defined(TX_ENABLE_EXECUTION_CHANGE_NOTIFY) || defined(TX_EXECUTION_PROFILE_ENABLE))
    BL      _tx_execution_isr_exit              // Call the ISR exit function
#endif
    POP     {r0,lr}
    BX      LR
// }


    .section .text
    .balign 4
    .syntax unified
    .eabi_attribute Tag_ABI_align_preserved, 1
    .global  SysTick_Handler
    .thumb_func
.type SysTick_Handler, function
SysTick_Handler:
// VOID TimerInterruptHandler (VOID)
// {
    PUSH    {r0,lr}     // Save LR (and dummy r0 to maintain stack alignment)
#if (defined(TX_ENABLE_EXECUTION_CHANGE_NOTIFY) || defined(TX_EXECUTION_PROFILE_ENABLE))
    BL      _tx_execution_isr_enter             // Call the ISR enter function
#endif
    BL      _tx_timer_interrupt
#if (defined(TX_ENABLE_EXECUTION_CHANGE_NOTIFY) || defined(TX_EXECUTION_PROFILE_ENABLE))
    BL      _tx_execution_isr_exit              // Call the ISR exit function
#endif
    POP     {r0,lr}
    BX      LR
// }


    .section .text
    .balign 4
    .syntax unified
    .eabi_attribute Tag_ABI_align_preserved, 1
    .global  __tx_NMIHandler
    .thumb_func
.type __tx_NMIHandler, function
__tx_NMIHandler:
    B       __tx_NMIHandler


    .section .text
    .balign 4
    .syntax unified
    .eabi_attribute Tag_ABI_align_preserved, 1
    .global  __tx_DBGHandler
    .thumb_func
.type __tx_DBGHandler, function
__tx_DBGHandler:
    B       __tx_DBGHandler

    .end
#endif

#if defined(__IAR_SYSTEMS_ASM__)
;/**************************************************************************/
;/*                                                                        */
;/*       Copyright (c) Microsoft Corporation. All rights reserved.        */
;/*                                                                        */
;/*       This software is licensed under the Microsoft Software License   */
;/*       Terms for Microsoft Azure RTOS. Full text of the license can be  */
;/*       found in the LICENSE file at https://aka.ms/AzureRTOS_EULA       */
;/*       and in the root directory of this software.                      */
;/*                                                                        */
;/**************************************************************************/
;
;
;/**************************************************************************/
;/**************************************************************************/
;/**                                                                       */
;/** ThreadX Component                                                     */
;/**                                                                       */
;/**   Initialize                                                          */
;/**                                                                       */
;/**************************************************************************/
;/**************************************************************************/
;
;
    EXTERN  _tx_thread_system_stack_ptr
    EXTERN  _tx_initialize_unused_memory
    EXTERN  _tx_timer_interrupt
    EXTERN  _tx_execution_isr_enter
    EXTERN  _tx_execution_isr_exit
    EXTERN  __vector_table
;
;
[#if FamilyName == "STM32WBA"]
SYSTEM_CLOCK      EQU   ${CORTEX_CLOCK_FREQ_value}
[#else]
SYSTEM_CLOCK      EQU   ${HCLKFreq_Value}
[/#if]
SYSTICK_CYCLES    EQU   ((SYSTEM_CLOCK / ${TX_TIMER_TICKS_PER_SECOND_value}) -1)
;
;

#ifdef USE_DYNAMIC_MEMORY_ALLOCATION
    RSEG    FREE_MEM:DATA
    PUBLIC  __tx_free_memory_start
__tx_free_memory_start
    DS32    4
#endif
;
;
    SECTION `.text`:CODE:NOROOT(2)
    THUMB

;/**************************************************************************/
;/*                                                                        */
;/*  FUNCTION                                               RELEASE        */
;/*                                                                        */
;/*    _tx_initialize_low_level                          Cortex-M33/IAR    */
;/*                                                           6.1          */
;/*  AUTHOR                                                                */
;/*                                                                        */
;/*    Scott Larson, Microsoft Corporation                                 */
;/*                                                                        */
;/*  DESCRIPTION                                                           */
;/*                                                                        */
;/*    This function is responsible for any low-level processor            */
;/*    initialization, including setting up interrupt vectors, setting     */
;/*    up a periodic timer interrupt source, saving the system stack       */
;/*    pointer for use in ISR processing later, and finding the first      */
;/*    available RAM memory address for tx_application_define.             */
;/*                                                                        */
;/*  INPUT                                                                 */
;/*                                                                        */
;/*    None                                                                */
;/*                                                                        */
;/*  OUTPUT                                                                */
;/*                                                                        */
;/*    None                                                                */
;/*                                                                        */
;/*  CALLS                                                                 */
;/*                                                                        */
;/*    None                                                                */
;/*                                                                        */
;/*  CALLED BY                                                             */
;/*                                                                        */
;/*    _tx_initialize_kernel_enter           ThreadX entry function        */
;/*                                                                        */
;/*  RELEASE HISTORY                                                       */
;/*                                                                        */
;/*    DATE              NAME                      DESCRIPTION             */
;/*                                                                        */
;/*  09-30-2020      Scott Larson            Initial Version 6.1           */
;/*                                                                        */
;/**************************************************************************/
;VOID   _tx_initialize_low_level(VOID)
;{
    PUBLIC  _tx_initialize_low_level
_tx_initialize_low_level:
;
;    /* Disable interrupts during ThreadX initialization.  */
;
    CPSID   i
;
;    /* Set base of available memory to end of non-initialised RAM area.  */
;
#ifdef USE_DYNAMIC_MEMORY_ALLOCATION
    LDR     r0, =_tx_initialize_unused_memory       ; Build address of unused memory pointer
    LDR     r1, =__tx_free_memory_start             ; Build first free address
    STR     r1, [r0]                                ; Setup first unused memory pointer
#endif
;
;    /* Setup Vector Table Offset Register.  */
;
    MOV     r0, #0xE000E000                         ; Build address of NVIC registers
    LDR     r1, =__vector_table                     ; Pickup address of vector table
    STR     r1, [r0, #0xD08]                        ; Set vector table address
;
;    /* Enable the cycle count register.  */
;
;    LDR     r0, =0xE0001000                         ; Build address of DWT register
;    LDR     r1, [r0]                                ; Pickup the current value
;    ORR     r1, r1, #1                              ; Set the CYCCNTENA bit
;    STR     r1, [r0]                                ; Enable the cycle count register
;
;    /* Set system stack pointer from vector value.  */
;
    LDR     r0, =_tx_thread_system_stack_ptr        ; Build address of system stack pointer
    LDR     r1, =__vector_table                     ; Pickup address of vector table
    LDR     r1, [r1]                                ; Pickup reset stack pointer
    STR     r1, [r0]                                ; Save system stack pointer
;
;    /* Configure SysTick.  */
;
    MOV     r0, #0xE000E000                         ; Build address of NVIC registers
    LDR     r1, =SYSTICK_CYCLES
    STR     r1, [r0, #0x14]                         ; Setup SysTick Reload Value
[#if FamilyName == "STM32WBA"]
    MOV     r1, #0x3                                ; Build SysTick Control Enable Value
[#else]
    MOV     r1, #0x7                                ; Build SysTick Control Enable Value
[/#if]
    STR     r1, [r0, #0x10]                         ; Setup SysTick Control
;
;    /* Configure handler priorities.  */
;
    LDR     r1, =0x00000000                         ; Rsrv, UsgF, BusF, MemM
    STR     r1, [r0, #0xD18]                        ; Setup System Handlers 4-7 Priority Registers

    LDR     r1, =0xFF000000                         ; SVCl, Rsrv, Rsrv, Rsrv
    STR     r1, [r0, #0xD1C]                        ; Setup System Handlers 8-11 Priority Registers
                                                    ; Note: SVC must be lowest priority, which is 0xFF

    LDR     r1, =0x40FF0000                         ; SysT, PnSV, Rsrv, DbgM
    STR     r1, [r0, #0xD20]                        ; Setup System Handlers 12-15 Priority Registers
                                                    ; Note: PnSV must be lowest priority, which is 0xFF
;
;    /* Return to caller.  */
;
    BX      lr
;}
;
;
;/* Define shells for each of the unused vectors.  */
;
    PUBLIC  __tx_BadHandler
__tx_BadHandler:
    B       __tx_BadHandler


    PUBLIC  __tx_IntHandler
__tx_IntHandler:
// VOID InterruptHandler (VOID)
// {
    PUSH    {r0,lr}     // Save LR (and dummy r0 to maintain stack alignment)
#if (defined(TX_ENABLE_EXECUTION_CHANGE_NOTIFY) || defined(TX_EXECUTION_PROFILE_ENABLE))
    BL      _tx_execution_isr_enter             // Call the ISR enter function
#endif
    /* Do interrupt handler work here */
    /* .... */
#if (defined(TX_ENABLE_EXECUTION_CHANGE_NOTIFY) || defined(TX_EXECUTION_PROFILE_ENABLE))
    BL      _tx_execution_isr_exit              // Call the ISR exit function
#endif
    POP     {r0,lr}
    BX      lr
// }


    PUBLIC  __tx_SysTickHandler
    PUBLIC SysTick_Handler
SysTick_Handler:
__tx_SysTickHandler:
// VOID TimerInterruptHandler (VOID)
// {
    PUSH    {r0,lr}     // Save LR (and dummy r0 to maintain stack alignment)
#if (defined(TX_ENABLE_EXECUTION_CHANGE_NOTIFY) || defined(TX_EXECUTION_PROFILE_ENABLE))
    BL      _tx_execution_isr_enter             // Call the ISR enter function
#endif
    BL      _tx_timer_interrupt
#if (defined(TX_ENABLE_EXECUTION_CHANGE_NOTIFY) || defined(TX_EXECUTION_PROFILE_ENABLE))
    BL      _tx_execution_isr_exit              // Call the ISR exit function
#endif
    POP     {r0,lr}
    BX      lr
// }

    PUBLIC  __tx_NMIHandler
__tx_NMIHandler:
    B       __tx_NMIHandler


    PUBLIC  __tx_DBGHandler
__tx_DBGHandler:
    B       __tx_DBGHandler

    END
#endif

#if (defined(__GNUC__) && !defined(__clang__))
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
/**   Initialize                                                          */
/**                                                                       */
/**************************************************************************/
/**************************************************************************/

[#if FamilyName == "STM32WBA"]
SYSTEM_CLOCK      =   ${CORTEX_CLOCK_FREQ_value}
[#else]
SYSTEM_CLOCK      =   ${HCLKFreq_Value}
[/#if]
SYSTICK_CYCLES    =   ((SYSTEM_CLOCK / ${TX_TIMER_TICKS_PER_SECOND_value}) -1)

/**************************************************************************/
/*                                                                        */
/*  FUNCTION                                               RELEASE        */
/*                                                                        */
/*    _tx_initialize_low_level                          Cortex-M33/GNU    */
/*                                                           6.1          */
/*  AUTHOR                                                                */
/*                                                                        */
/*    Scott Larson, Microsoft Corporation                                 */
/*                                                                        */
/*  DESCRIPTION                                                           */
/*                                                                        */
/*    This function is responsible for any low-level processor            */
/*    initialization, including setting up interrupt vectors, setting     */
/*    up a periodic timer interrupt source, saving the system stack       */
/*    pointer for use in ISR processing later, and finding the first      */
/*    available RAM memory address for tx_application_define.             */
/*                                                                        */
/*  INPUT                                                                 */
/*                                                                        */
/*    None                                                                */
/*                                                                        */
/*  OUTPUT                                                                */
/*                                                                        */
/*    None                                                                */
/*                                                                        */
/*  CALLS                                                                 */
/*                                                                        */
/*    None                                                                */
/*                                                                        */
/*  CALLED BY                                                             */
/*                                                                        */
/*    _tx_initialize_kernel_enter           ThreadX entry function        */
/*                                                                        */
/*  RELEASE HISTORY                                                       */
/*                                                                        */
/*    DATE              NAME                      DESCRIPTION             */
/*                                                                        */
/*  09-30-2020      Scott Larson            Initial Version 6.1           */
/*                                                                        */
/**************************************************************************/
// VOID   _tx_initialize_low_level(VOID)
// {
    .section .text
    .balign 4
    .syntax unified
    .eabi_attribute Tag_ABI_align_preserved, 1
    .global  _tx_initialize_low_level
    .thumb_func
.type _tx_initialize_low_level, function
_tx_initialize_low_level:

    /* Disable interrupts during ThreadX initialization.  */
    CPSID   i

    /* Set base of available memory to end of non-initialised RAM area.  */
#ifdef USE_DYNAMIC_MEMORY_ALLOCATION
    LDR     r0, =_tx_initialize_unused_memory       // Build address of unused memory pointer
    LDR     r1, =__RAM_segment_used_end__           // Build first free address
    ADD     r1, r1, #4                              //
    STR     r1, [r0]                                // Setup first unused memory pointer
#endif
    /* Setup Vector Table Offset Register.  */
    MOV     r0, #0xE000E000                         // Build address of NVIC registers
    LDR     r1, =g_pfnVectors                       // Pickup address of vector table
    STR     r1, [r0, #0xD08]                        // Set vector table address

    /* Enable the cycle count register.  */
    LDR     r0, =0xE0001000                         // Build address of DWT register
    LDR     r1, [r0]                                // Pickup the current value
    ORR     r1, r1, #1                              // Set the CYCCNTENA bit
    STR     r1, [r0]                                // Enable the cycle count register

    /* Set system stack pointer from vector value.  */
    LDR     r0, =_tx_thread_system_stack_ptr        // Build address of system stack pointer
    LDR     r1, =g_pfnVectors                       // Pickup address of vector table
    LDR     r1, [r1]                                // Pickup reset stack pointer
    STR     r1, [r0]                                // Save system stack pointer

    /* Configure SysTick.  */
    MOV     r0, #0xE000E000                         // Build address of NVIC registers
    LDR     r1, =SYSTICK_CYCLES
    STR     r1, [r0, #0x14]                         // Setup SysTick Reload Value
[#if FamilyName == "STM32WBA"]
    MOV     r1, #0x3                                // Build SysTick Control Enable Value
[#else]
    MOV     r1, #0x7                                // Build SysTick Control Enable Value
[/#if]
    STR     r1, [r0, #0x10]                         // Setup SysTick Control

    /* Configure handler priorities.  */
    LDR     r1, =0x00000000                         // Rsrv, UsgF, BusF, MemM
    STR     r1, [r0, #0xD18]                        // Setup System Handlers 4-7 Priority Registers

    LDR     r1, =0xFF000000                         // SVCl, Rsrv, Rsrv, Rsrv
    STR     r1, [r0, #0xD1C]                        // Setup System Handlers 8-11 Priority Registers
                                                    // Note: SVC must be lowest priority, which is 0xFF

    LDR     r1, =0x40FF0000                         // SysT, PnSV, Rsrv, DbgM
    STR     r1, [r0, #0xD20]                        // Setup System Handlers 12-15 Priority Registers
                                                    // Note: PnSV must be lowest priority, which is 0xFF

    /* Return to caller.  */
    BX      lr
// }


/* Define shells for each of the unused vectors.  */
    .section .text
    .balign 4
    .syntax unified
    .eabi_attribute Tag_ABI_align_preserved, 1
    .global  __tx_BadHandler
    .thumb_func
.type __tx_BadHandler, function
__tx_BadHandler:
    B       __tx_BadHandler


    .section .text
    .balign 4
    .syntax unified
    .eabi_attribute Tag_ABI_align_preserved, 1
    .global  __tx_IntHandler
    .thumb_func
.type __tx_IntHandler, function
__tx_IntHandler:
// VOID InterruptHandler (VOID)
// {
    PUSH    {r0,lr}     // Save LR (and dummy r0 to maintain stack alignment)
#if (defined(TX_ENABLE_EXECUTION_CHANGE_NOTIFY) || defined(TX_EXECUTION_PROFILE_ENABLE))
    BL      _tx_execution_isr_enter             // Call the ISR enter function
#endif
    /* Do interrupt handler work here */
    /* .... */
#if (defined(TX_ENABLE_EXECUTION_CHANGE_NOTIFY) || defined(TX_EXECUTION_PROFILE_ENABLE))
    BL      _tx_execution_isr_exit              // Call the ISR exit function
#endif
    POP     {r0,lr}
    BX      lr
// }



    .section .text
    .balign 4
    .syntax unified
    .eabi_attribute Tag_ABI_align_preserved, 1
    .global  SysTick_Handler
    .thumb_func
.type SysTick_Handler, function
SysTick_Handler:
// VOID TimerInterruptHandler (VOID)
// {
    PUSH    {r0,lr}     // Save LR (and dummy r0 to maintain stack alignment)
#if (defined(TX_ENABLE_EXECUTION_CHANGE_NOTIFY) || defined(TX_EXECUTION_PROFILE_ENABLE))
    BL      _tx_execution_isr_enter             // Call the ISR enter function
#endif
    BL      _tx_timer_interrupt
#if (defined(TX_ENABLE_EXECUTION_CHANGE_NOTIFY) || defined(TX_EXECUTION_PROFILE_ENABLE))
    BL      _tx_execution_isr_exit              // Call the ISR exit function
#endif
    POP     {r0,lr}
    BX      lr
// }

    .section .text
    .balign 4
    .syntax unified
    .eabi_attribute Tag_ABI_align_preserved, 1
    .global  __tx_NMIHandler
    .thumb_func
.type __tx_NMIHandler, function
__tx_NMIHandler:
    B       __tx_NMIHandler


    .section .text
    .balign 4
    .syntax unified
    .eabi_attribute Tag_ABI_align_preserved, 1
    .global  __tx_DBGHandler
    .thumb_func
.type __tx_DBGHandler, function
__tx_DBGHandler:
    B       __tx_DBGHandler

    .end

#endif
[#else]
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
/**   Initialize                                                          */
/**                                                                       */
/**************************************************************************/
/**************************************************************************/

    .syntax unified
#if defined(ARM_MODE)
    .arm
#else
    .thumb
#endif

  FIQ_MODE        =       0x11                    // Disable IRQ/FIQ FIQ mode
  IRQ_MODE        =       0x12                    // Disable IRQ/FIQ IRQ mode
  SVC_MODE        =       0x13                    // Disable IRQ/FIQ SVC mode
  MON_MODE        =       0x16                    // Disable IRQ/FIQ MON mode
  ABT_MODE        =       0x17                    // Disable IRQ/FIQ ABT mode
  HYP_MODE        =       0x1A                    // Disable IRQ/FIQ HYP mode
  UND_MODE        =       0x1B                    // Disable IRQ/FIQ UND mode
  SYS_MODE        =       0x1F                    // Disable IRQ/FIQ SYS mode

  .global     _tx_thread_system_stack_ptr
  .global     _tx_initialize_unused_memory
  .global     _tx_thread_context_save
  .global     _tx_thread_context_restore
  .global     _stack_bottom
  .global     _end

/**************************************************************************/
/*                                                                        */
/*  FUNCTION                                               RELEASE        */
/*                                                                        */
/*    _tx_initialize_low_level                             ARMv7-A        */
/*                                                           6.1.11       */
/*  AUTHOR                                                                */
/*                                                                        */
/*    William E. Lamie, Microsoft Corporation                             */
/*                                                                        */
/*  DESCRIPTION                                                           */
/*                                                                        */
/*    This function is responsible for any low-level processor            */
/*    initialization, including setting up interrupt vectors, setting     */
/*    up a periodic timer interrupt source, saving the system stack       */
/*    pointer for use in ISR processing later, and finding the first      */
/*    available RAM memory address for tx_application_define.             */
/*                                                                        */
/*  INPUT                                                                 */
/*                                                                        */
/*    None                                                                */
/*                                                                        */
/*  OUTPUT                                                                */
/*                                                                        */
/*    None                                                                */
/*                                                                        */
/*  CALLS                                                                 */
/*                                                                        */
/*    None                                                                */
/*                                                                        */
/*  CALLED BY                                                             */
/*                                                                        */
/*    _tx_initialize_kernel_enter           ThreadX entry function        */
/*                                                                        */
/*  RELEASE HISTORY                                                       */
/*                                                                        */
/*    DATE              NAME                      DESCRIPTION             */
/*                                                                        */
/*  09-30-2020     William E. Lamie         Initial Version 6.1           */
/*  04-25-2022     Zhen Kong                Updated comments,             */
/*                                            resulting in version 6.1.11 */
/*                                                                        */
/**************************************************************************/
  .text
  .align 2

#if !defined(ARM_MODE)
  .thumb_func
#endif
  .global _tx_initialize_low_level
  .type   _tx_initialize_low_level,function
_tx_initialize_low_level:

  /* We must be in SYS mode at this point! */

#ifdef TX_ENABLE_FIQ_SUPPORT
  CPSID   if                                  // Disable IRQ and FIQ
#else
  CPSID   i                                   // Disable IRQ
#endif

  /* Save sp and lr to use them in SVC mode */
  MOV     r0, sp
  MOV     r1, lr

#if 1
  /* Optional clearing of registers for easier debugging */
  MOV     r3, #0

  CPS     #IRQ_MODE                           // Enter IRQ mode
  MOV     lr, r3                              // Clear LR for easier debugging
  MSR     SPSR_cxsf, r3                       // Clear SPSR for easier debugging

  CPS     #FIQ_MODE                           // Enter FIQ mode
  MOV     r8, r3                              // Clear R8 for easier debugging
  MOV     r9, r3                              // Clear R9 for easier debugging
  MOV     r10, r3                             // Clear R10 for easier debugging
  MOV     r11, r3                             // Clear R11 for easier debugging
  MOV     r12, r3                             // Clear R12 for easier debugging
  MOV     lr, r3                              // Clear LR for easier debugging
  MSR     SPSR_cxsf, r3                       // Clear SPSR for easier debugging

  CPS     #MON_MODE                           // Enter MON mode
  MOV     lr, r3                              // Clear LR for easier debugging
  MSR     SPSR_cxsf, r3                       // Clear SPSR for easier debugging

  CPS     #ABT_MODE                           // Enter ABT mode
  MOV     lr, r3                              // Clear LR for easier debugging
  MSR     SPSR_cxsf, r3                       // Clear SPSR for easier debugging

  CPS     #UND_MODE                           // Enter UND mode
  MOV     lr, r3                              // Clear LR for easier debugging
  MSR     SPSR_cxsf, r3                       // Clear SPSR for easier debugging
#endif

  CPS     #SVC_MODE                           // Enter SVC mode

  /* Use sp and lr from SYS mode in SVC mode */
  MOV     sp, r0
  MOV     lr, r1

  LDR     r1, =_stack_bottom                  // Get pointer to stack area
  LDR     r2, =_tx_thread_system_stack_ptr    // Pickup stack pointer
  STR     r1, [r2]                            // Save the system stack

  LDR     r1, =_end                           // Get end of non-initialized RAM area
  LDR     r2, =_tx_initialize_unused_memory   // Pickup unused memory ptr address
  ADD     r1, r1, #8                          // Increment to next free word
  STR     r1, [r2]                            // Save first free memory address

  MOV     pc, lr                              // Return to caller

/**************************************************************************/
/* Undefined exception */
/**************************************************************************/
#if !defined(ARM_MODE)
  .thumb_func
#endif
    .global __tx_undefined
__tx_undefined:
  BKPT    0x0000
__tx_undefined_loop:
  B       __tx_undefined_loop

/**************************************************************************/
/* Reserved exception */
/**************************************************************************/
#if !defined(ARM_MODE)
  .thumb_func
#endif
    .global __tx_reserved_handler
__tx_reserved_handler:
  BKPT    0x0000
__tx_reserved_handler_loop:
  B       __tx_reserved_handler_loop

/**************************************************************************/
/* IRQ exception */
/**************************************************************************/
#if !defined(ARM_MODE)
  .thumb_func
#endif
  .global __tx_irq_handler
  .global __tx_irq_processing_return
__tx_irq_handler:

  /* Jump to context save to save system context.  */
  B       _tx_thread_context_save
__tx_irq_processing_return:
  /* At this point execution is still in the IRQ mode.  The CPSR, point of
     interrupt, and all C scratch registers are available for use.  In
     addition, IRQ interrupts may be re-enabled - with certain restrictions -
     if nested IRQ interrupts are desired.  Interrupts may be re-enabled over
     small code sequences where lr is saved before enabling interrupts and
     restored after interrupts are again disabled. */

  /* Interrupt nesting is allowed after calling _tx_thread_irq_nesting_start
     from IRQ mode with interrupts disabled.  This routine switches to the
     system mode and returns with IRQ interrupts enabled.

     NOTE:  It is very important to ensure all IRQ interrupts are cleared
     prior to enabling nested IRQ interrupts. */
#ifdef TX_ENABLE_IRQ_NESTING
  BL      _tx_thread_irq_nesting_start
#endif


  /*
   * Handle all IRQ and in paticular the one used for Threadx tick:
   * SecurePhysicalTimer_IRQHandler which calls _tx_timer_interrupt function
   */
  BL     IRQ_Handler

  /* If interrupt nesting was started earlier, the end of interrupt nesting
     service must be called before returning to _tx_thread_context_restore.
     This routine returns in processing in IRQ mode with interrupts disabled.  */
#ifdef TX_ENABLE_IRQ_NESTING
  BL      _tx_thread_irq_nesting_end
#endif

  /* Jump to context restore to restore system context.  */
  B       _tx_thread_context_restore

/**************************************************************************/
/* FIQ exception */
/**************************************************************************/
#ifdef TX_ENABLE_FIQ_SUPPORT
#if !defined(ARM_MODE)
  .thumb_func
#endif
  .global  __tx_fiq_handler
  .global  __tx_fiq_processing_return
__tx_fiq_handler:

  /* Jump to fiq context save to save system context.  */
  B       _tx_thread_fiq_context_save
__tx_fiq_processing_return:

  /* At this point execution is still in the FIQ mode.  The CPSR, point of
     interrupt, and all C scratch registers are available for use.  */

  /* Interrupt nesting is allowed after calling _tx_thread_fiq_nesting_start
     from FIQ mode with interrupts disabled.  This routine switches to the
     system mode and returns with FIQ interrupts enabled.

     NOTE:  It is very important to ensure all FIQ interrupts are cleared
     prior to enabling nested FIQ interrupts.  */
#ifdef TX_ENABLE_FIQ_NESTING
  BL      _tx_thread_fiq_nesting_start
#endif

  /* Application FIQ handlers can be called here!  */

  /* If interrupt nesting was started earlier, the end of interrupt nesting
     service must be called before returning to _tx_thread_fiq_context_restore.  */
#ifdef TX_ENABLE_FIQ_NESTING
    BL      _tx_thread_fiq_nesting_end
#endif

  /* Jump to fiq context restore to restore system context.  */
  B       _tx_thread_fiq_context_restore


#else

#if !defined(ARM_MODE)
  .thumb_func
#endif
    .global  __tx_fiq_handler
__tx_fiq_handler:
  BKPT    0x0000
__tx_fiq_handler_loop:
  B       __tx_fiq_handler_loop

#endif

/**************************************************************************/
/* Prefetch exception */
/**************************************************************************/
#if !defined(ARM_MODE)
  .thumb_func
#endif
  .global  __tx_prefetch_handler
__tx_prefetch_handler:
  BKPT    0x0000
__tx_prefetch_handler_loop:
  B       __tx_prefetch_handler_loop

/**************************************************************************/
/* Abort exception */
/**************************************************************************/
#if !defined(ARM_MODE)
  .thumb_func
#endif
  .global  __tx_abort_handler
__tx_abort_handler:
  BKPT    0x0000
__tx_abort_handler_loop:
  B       __tx_abort_handler_loop

/**************************************************************************/
/* Build options and version */
/**************************************************************************/
    /* Reference build options and version ID to ensure they come in.  */

BUILD_OPTIONS:
    .word  _tx_build_options                    // Reference to bring in
VERSION_ID:
    .word  _tx_version_id                       // Reference to bring in

[/#if]