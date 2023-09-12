[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    partition_[#if McuName?starts_with("STM32U585")]stm32u585xx.h[/#if][#if McuName?starts_with("STM32U575")]stm32u575xx.h[/#if][#if McuName?starts_with("STM32U595")]stm32u595xx.h[/#if][#if McuName?starts_with("STM32U5A5")]stm32u5a5xx.h[/#if][#if McuName?starts_with("STM32U5A9")]stm32u5a9xx.h[/#if][#if McuName?starts_with("STM32U599")]stm32u599xx.h[/#if]
  * @author  MCD Application Team
  * @brief   CMSIS [#if McuName?starts_with("STM32U585")]STM32U585xx[/#if][#if McuName?starts_with("STM32U575")]STM32U575xx[/#if][#if McuName?starts_with("STM32U595")]STM32U595xx[/#if][#if McuName?starts_with("STM32U5A5")]STM32U5A5xx[/#if][#if McuName?starts_with("STM32U5A9")]STM32U5A9xx[/#if][#if McuName?starts_with("STM32U599")]STM32U599xx[/#if] Device Initial Setup for Secure / Non-Secure Zones
  *          for ARMCM33 based on CMSIS CORE partition_ARMCM33.h Template.
  *
  *          This file contains:
  *           - Initialize Security Attribution Unit (SAU) CTRL register
  *           - Setup behavior of Sleep and Exception Handling
  *           - Setup behavior of Floating Point Unit
  *           - Setup Interrupt Target
  *
  ******************************************************************************/
/*
  * Copyright (c) 2009-2016 ARM Limited. All rights reserved.
  * Portions Copyright (c) 2021 STMicroelectronics, all rights reserved
  *
  * SPDX-License-Identifier: Apache-2.0
 
  *
 * Licensed under the Apache License, Version 2.0 (the License); you may
 * not use this file except in compliance with the License.
 * You may obtain a copy of the License at
  *
 * http://www.apache.org/licenses/LICENSE-2.0
   *


 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an AS IS BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/* USER CODE END Header */

[#assign enabledIT = ""]
[#if nvic??]
[#list nvic as vector]
[#assign enabledIT = enabledIT + " - " +  vector.name]
[/#list]
[/#if]
[#if McuName?starts_with("STM32U585")]
#ifndef PARTITION_STM32U585XX_H
#define PARTITION_STM32U585XX_H
[/#if]
[#if McuName?starts_with("STM32U575")]
#ifndef PARTITION_STM32U575XX_H
#define PARTITION_STM32U575XX_H
[/#if]
[#if McuName?starts_with("STM32U595")]
#ifndef PARTITION_STM32U595XX_H
#define PARTITION_STM32U595XX_H
[/#if]
[#if McuName?starts_with("STM32U5A5")]
#ifndef PARTITION_STM32U5A5XX_H
#define PARTITION_STM32U5A5XX_H
[/#if]
[#if McuName?starts_with("STM32U5A9")]
#ifndef PARTITION_STM32U5A9XX_H
#define PARTITION_STM32U5A9XX_H
[/#if]
[#if McuName?starts_with("STM32U599")]
#ifndef PARTITION_STM32U599XX_H
#define PARTITION_STM32U599XX_H
[/#if]
[#assign nonSecureIT0 = "100, 100"/]
[#assign nonSecureIT1 = "100, 100"/]
[#assign nonSecureIT2 = "100, 100"/]
[#assign nonSecureIT3 = "100, 100"/]
/*
//-------- <<< Use Configuration Wizard in Context Menu >>> -----------------
*/
/* USER CODE BEGIN 0 */
/*
// <e>Initialize Security Attribution Unit (SAU) CTRL register
*/
#define SAU_INIT_CTRL          1

/*
//   <q> Enable SAU
//   <i> Value for SAU->CTRL register bit ENABLE
*/
#define SAU_INIT_CTRL_ENABLE   0

/*
//   <o> When SAU is disabled
//     <0=> All Memory is Secure
//     <1=> All Memory is Non-Secure
//   <i> Value for SAU->CTRL register bit ALLNS
//   <i> When all Memory is Non-Secure (ALLNS is 1), IDAU can override memory map configuration.
*/
#define SAU_INIT_CTRL_ALLNS   1

/*
// </e>
*/

/*
// <h>Initialize Security Attribution Unit (SAU) Address Regions
// <i>SAU configuration specifies regions to be one of:
// <i> - Secure and Non-Secure Callable
// <i> - Non-Secure
// <i>Note: All memory regions not configured by SAU are Secure
*/
#define SAU_REGIONS_MAX   8                 /* Max. number of SAU regions */

/*
//   <e>Initialize SAU Region 0
//   <i> Setup SAU Region 0 memory attributes
*/
#define SAU_INIT_REGION0    0

[#if McuName?starts_with("STM32U585")]
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/

#define SAU_INIT_START0     0x0C0FE000      /* start address of SAU region 0 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END0       0x0C0FFFFF      /* end address of SAU region 0 */
[/#if]

[#if McuName?starts_with("STM32U575")]
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/

#define SAU_INIT_START0     0x0C0FE000      /* start address of SAU region 0 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END0       0x0C0FFFFF      /* end address of SAU region 0 */
[/#if]

[#if McuName?starts_with("STM32U5A5")]
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START0     0x0C1FE000      /* start address of SAU region 0 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END0       0x0C1FFFFF      /* end address of SAU region 0 */
[/#if]

[#if McuName?starts_with("STM32U5A9")]
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START0     0x0C1FE000      /* start address of SAU region 0 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END0       0x0C1FFFFF      /* end address of SAU region 0 */
[/#if]

[#if McuName?starts_with("STM32U595")]
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START0     0x0C1FE000      /* start address of SAU region 0 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END0       0x0C1FFFFF      /* end address of SAU region 0 */
[/#if]

[#if McuName?starts_with("STM32U599")]
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START0     0x0C1FE000      /* start address of SAU region 0 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END0       0x0C1FFFFF      /* end address of SAU region 0 */
[/#if]

/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC0       1
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 1
//   <i> Setup SAU Region 1 memory attributes
*/
#define SAU_INIT_REGION1    0

[#if McuName?starts_with("STM32U585")]
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START1     0x08100000      /* start address of SAU region 1 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END1       0x081FFFFF      /* end address of SAU region 1 */
[/#if]

[#if McuName?starts_with("STM32U575")]
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START1     0x08100000      /* start address of SAU region 1 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END1       0x081FFFFF      /* end address of SAU region 1 */
[/#if]

[#if McuName?starts_with("STM32U5A5")]
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START1     0x08200000      /* start address of SAU region 1 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END1       0x083FFFFF      /* end address of SAU region 1 */
[/#if]

[#if McuName?starts_with("STM32U5A9")]
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START1     0x08200000      /* start address of SAU region 1 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END1       0x083FFFFF      /* end address of SAU region 1 */
[/#if]

[#if McuName?starts_with("STM32U595")]
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START1     0x08200000      /* start address of SAU region 1 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END1       0x083FFFFF      /* end address of SAU region 1 */
[/#if]

[#if McuName?starts_with("STM32U599")]
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START1     0x08200000      /* start address of SAU region 1 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END1       0x083FFFFF      /* end address of SAU region 1 */
[/#if]

/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC1       0
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 2
//   <i> Setup SAU Region 2 memory attributes
*/
#define SAU_INIT_REGION2    0

[#if McuName?starts_with("STM32U585")]
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START2     0x20040000      /* start address of SAU region 2 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END2       0x200BFFFF      /* end address of SAU region 2 */
[/#if]

[#if McuName?starts_with("STM32U575")]
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START2     0x20040000      /* start address of SAU region 2 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END2       0x200BFFFF      /* end address of SAU region 2 */
[/#if]

[#if McuName?starts_with("STM32U5A5")]
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START2     0x200D0000      /* start address of SAU region 2 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END2       0x2026FFFF      /* end address of SAU region 2 */
[/#if]

[#if McuName?starts_with("STM32U5A9")]
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START2     0x200D0000      /* start address of SAU region 2 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END2       0x2026FFFF      /* end address of SAU region 2 */
[/#if]

[#if McuName?starts_with("STM32U595")]
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START2     0x200D0000      /* start address of SAU region 2 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END2       0x2026FFFF      /* end address of SAU region 2 */
[/#if]

[#if McuName?starts_with("STM32U599")]
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START2     0x200D0000      /* start address of SAU region 2 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END2       0x2026FFFF      /* end address of SAU region 2 */
[/#if]

/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC2       0
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 3
//   <i> Setup SAU Region 3 memory attributes
*/
#define SAU_INIT_REGION3    0

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START3     0x40000000      /* start address of SAU region 3 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END3       0x4FFFFFFF      /* end address of SAU region 3 */

/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC3       0
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 4
//   <i> Setup SAU Region 4 memory attributes
*/
#define SAU_INIT_REGION4    0

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START4     0x60000000      /* start address of SAU region 4 */

[#if McuName?starts_with("STM32U585")]
/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END4       0x9FFFFFFF      /* end address of SAU region 4 */
[/#if]

[#if McuName?starts_with("STM32U575")]
/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END4       0x9FFFFFFF      /* end address of SAU region 4 */
[/#if]

[#if McuName?starts_with("STM32U5A5")]
/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END4       0xAFFFFFFF      /* end address of SAU region 4 */
[/#if]

[#if McuName?starts_with("STM32U5A9")]
/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END4       0xAFFFFFFF      /* end address of SAU region 4 */
[/#if]

[#if McuName?starts_with("STM32U595")]
/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END4       0xAFFFFFFF      /* end address of SAU region 4 */
[/#if]

[#if McuName?starts_with("STM32U599")]
/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END4       0xAFFFFFFF      /* end address of SAU region 4 */
[/#if]

/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC4       0
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 5
//   <i> Setup SAU Region 5 memory attributes
*/
#define SAU_INIT_REGION5    0

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START5     0x0BF90000      /* start address of SAU region 5 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END5       0x0BFA8FFF      /* end address of SAU region 5 */

/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC5       0
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 6
//   <i> Setup SAU Region 6 memory attributes
*/
#define SAU_INIT_REGION6    0

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START6     0x00000000      /* start address of SAU region 6 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END6       0x00000000      /* end address of SAU region 6 */

/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC6       0
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 7
//   <i> Setup SAU Region 7 memory attributes
*/
#define SAU_INIT_REGION7    0

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START7     0x00000000      /* start address of SAU region 7 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END7       0x00000000      /* end address of SAU region 7 */

/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC7       0
/*
//   </e>
*/

/*
// </h>
*/

/*
// <e>Setup behaviour of Sleep and Exception Handling
*/
#define SCB_CSR_AIRCR_INIT  0

/*
//   <o> Deep Sleep can be enabled by
//     <0=>Secure and Non-Secure state
//     <1=>Secure state only
//   <i> Value for SCB->CSR register bit DEEPSLEEPS
*/
#define SCB_CSR_DEEPSLEEPS_VAL  0

/*
//   <o>System reset request accessible from
//     <0=> Secure and Non-Secure state
//     <1=> Secure state only
//   <i> Value for SCB->AIRCR register bit SYSRESETREQS
*/
#define SCB_AIRCR_SYSRESETREQS_VAL    0
/* USER CODE END 0 */
/*
//   <o>Priority of Non-Secure exceptions is
//     <0=> Not altered
//     <1=> Lowered to 0x04-0x07
//   <i> Value for SCB->AIRCR register bit PRIS
*/
#define SCB_AIRCR_PRIS_VAL      [#if AIRCR_PRIS??]${AIRCR_PRIS}[#else]0[/#if]

/*
//   <o>BusFault, HardFault, and NMI target
//     <0=> Secure state
//     <1=> Non-Secure state
//   <i> Value for SCB->AIRCR register bit BFHFNMINS
*/
#define SCB_AIRCR_BFHFNMINS_VAL    [#if AIRCR_BFHFNMINS??]${AIRCR_BFHFNMINS}[#else]0[/#if]

/*
// </e>
*/
/* USER CODE BEGIN 1 */
/*
// <e>Setup behaviour of Floating Point Unit
*/
#define TZ_FPU_NS_USAGE 1

/*
// <o>Floating Point Unit usage
//     <0=> Secure state only
//     <3=> Secure and Non-Secure state
//   <i> Value for SCB->NSACR register bits CP10, CP11
*/
#define SCB_NSACR_CP10_11_VAL       3

/*
// <o>Treat floating-point registers as Secure
//     <0=> Disabled
//     <1=> Enabled
//   <i> Value for FPU->FPCCR register bit TS
*/
#define FPU_FPCCR_TS_VAL            0

/*
// <o>Clear on return (CLRONRET) accessibility
//     <0=> Secure and Non-Secure state
//     <1=> Secure state only
//   <i> Value for FPU->FPCCR register bit CLRONRETS
*/
#define FPU_FPCCR_CLRONRETS_VAL     0

/*
// <o>Clear floating-point caller saved registers on exception return
//     <0=> Disabled
//     <1=> Enabled
//   <i> Value for FPU->FPCCR register bit CLRONRET
*/
#define FPU_FPCCR_CLRONRET_VAL      1

/*
// </e>
*/
/* USER CODE END 1 */
/*
// <h>Setup Interrupt Target
*/

/*
//   <e>Initialize ITNS 0 (Interrupts 0..31)
*/
#define NVIC_INIT_ITNS0    1
/*
// Interrupts 0..31
//   <o.0>  WWDG_IRQn             [#if enabledIT?contains("WWDG_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"0"/][#else]<0=> Secure state[/#if]
//   <o.1>  PVD_AVD_IRQn          [#if enabledIT?contains("PVD_AVD_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"1"/][#else]<0=> Secure state[/#if]
//   <o.2>  RTC_IRQn              [#if enabledIT?contains("RTC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"2"/][#else]<0=> Secure state[/#if]
//   <o.3>  RTC_S_IRQn            [#if enabledIT?contains("RTC_S_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"3"/][#else]<0=> Secure state[/#if]
//   <o.4>  TAMP_IRQn             [#if enabledIT?contains("TAMP_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"4"/][#else]<0=> Secure state[/#if]
//   <o.5>  RAMCFG_IRQn           [#if enabledIT?contains("RAMCFG_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"5"/][#else]<0=> Secure state[/#if]
//   <o.6>  FLASH_IRQn            [#if enabledIT?contains("FLASH_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"6"/][#else]<0=> Secure state[/#if]
//   <o.7>  FLASH_S_IRQn          [#if enabledIT?contains("FLASH_S_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"7"/][#else]<0=> Secure state[/#if]
//   <o.8>  GTZC_IRQn             [#if enabledIT?contains("GTZC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"8"/][#else]<0=> Secure state[/#if]
//   <o.9>  RCC_IRQn              [#if enabledIT?contains("RCC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"9"/][#else]<0=> Secure state[/#if]
//   <o.10> RCC_S_IRQn            [#if enabledIT?contains("RCC_S_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"10"/][#else]<0=> Secure state[/#if]
//   <o.11> EXTI0_IRQn            [#if enabledIT?contains("EXTI0_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"11"/][#else]<0=> Secure state[/#if]
//   <o.12> EXTI1_IRQn            [#if enabledIT?contains("EXTI1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"12"/][#else]<0=> Secure state[/#if]
//   <o.13> EXTI2_IRQn            [#if enabledIT?contains("EXTI2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"13"/][#else]<0=> Secure state[/#if]
//   <o.14> EXTI3_IRQn            [#if enabledIT?contains("EXTI3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"14"/][#else]<0=> Secure state[/#if]
//   <o.15> EXTI4_IRQn            [#if enabledIT?contains("EXTI4_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"15"/][#else]<0=> Secure state[/#if]
//   <o.16> EXTI5_IRQn            [#if enabledIT?contains("EXTI5_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"16"/][#else]<0=> Secure state[/#if]
//   <o.17> EXTI6_IRQn            [#if enabledIT?contains("EXTI6_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"17"/][#else]<0=> Secure state[/#if]
//   <o.18> EXTI7_IRQn            [#if enabledIT?contains("EXTI7_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"18"/][#else]<0=> Secure state[/#if]
//   <o.19> EXTI8_IRQn            [#if enabledIT?contains("EXTI8_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"19"/][#else]<0=> Secure state[/#if]
//   <o.20> EXTI9_IRQn            [#if enabledIT?contains("EXTI9_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"20"/][#else]<0=> Secure state[/#if]
//   <o.21> EXTI10_IRQn           [#if enabledIT?contains("EXTI10_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"21"/][#else]<0=> Secure state[/#if]
//   <o.22> EXTI11_IRQn           [#if enabledIT?contains("EXTI11_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"22"/][#else]<0=> Secure state[/#if]
//   <o.23> EXTI12_IRQn           [#if enabledIT?contains("EXTI12_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"23"/][#else]<0=> Secure state[/#if]
//   <o.24> EXTI13_IRQn           [#if enabledIT?contains("EXTI13_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"24"/][#else]<0=> Secure state[/#if]
//   <o.25> EXTI14_IRQn           [#if enabledIT?contains("EXTI14_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"25"/][#else]<0=> Secure state[/#if]
//   <o.26> EXTI15_IRQn           [#if enabledIT?contains("EXTI15_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"26"/][#else]<0=> Secure state[/#if]
//   <o.27> IWDG_IRQn             [#if enabledIT?contains("IWDG_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"27"/][#else]<0=> Secure state[/#if]
//   <o.28> SAES_IRQn             [#if enabledIT?contains("SAES_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"28"/][#else]<0=> Secure state[/#if]
//   <o.29> GPDMA1_Channel0_IRQn  [#if enabledIT?contains("GPDMA1_Channel0_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"29"/][#else]<0=> Secure state[/#if]
//   <o.30> GPDMA1_Channel1_IRQn  [#if enabledIT?contains("GPDMA1_Channel1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"30"/][#else]<0=> Secure state[/#if]
//   <o.31> GPDMA1_Channel2_IRQn  [#if enabledIT?contains("GPDMA1_Channel2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"31"/][#else]<0=> Secure state[/#if]
*/
[#assign decVal = 0/]
[#if nonSecureIT0??]
[#assign ll0 = nonSecureIT0?split(", ")/]
[#list ll0 as it]
[#assign index = Integer.parseInt(it)/]
[#if index!=100]
[#assign decVal = decVal +  Math.pow(2, index)]
[/#if]
[/#list]
[/#if]
[#assign res = String.format("0x%08X" , Integer.valueOf(decVal)) /]
#define NVIC_INIT_ITNS0_VAL      ${res}
/*
//   </e>
*/

/*
//   <e>Initialize ITNS 1 (Interrupts 32..63)
*/
#define NVIC_INIT_ITNS1    1

/*
// Interrupts 32..63
//   <o.0>  GPDMA1_Channel3_IRQn  [#if enabledIT?contains("GPDMA1_Channel3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"0"/][#else]<0=> Secure state[/#if]
//   <o.1>  GPDMA1_Channel4_IRQn  [#if enabledIT?contains("GPDMA1_Channel4_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"1"/][#else]<0=> Secure state[/#if]
//   <o.2>  GPDMA1_Channel5_IRQn  [#if enabledIT?contains("GPDMA1_Channel5_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"2"/][#else]<0=> Secure state[/#if]
//   <o.3>  GPDMA1_Channel6_IRQn  [#if enabledIT?contains("GPDMA1_Channel6_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"3"/][#else]<0=> Secure state[/#if]
//   <o.4>  GPDMA1_Channel7_IRQn  [#if enabledIT?contains("GPDMA1_Channel7_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"4"/][#else]<0=> Secure state[/#if]
//   <o.5>  ADC1_IRQn             [#if enabledIT?contains("ADC1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"5"/][#else]<0=> Secure state[/#if]
//   <o.6>  DAC1_IRQn             [#if enabledIT?contains("DAC1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"6"/][#else]<0=> Secure state[/#if]
//   <o.7>  FDCAN1_IT0_IRQn       [#if enabledIT?contains("FDCAN1_IT0_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"7"/][#else]<0=> Secure state[/#if]
//   <o.8>  FDCAN1_IT1_IRQn       [#if enabledIT?contains("FDCAN1_IT1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"8"/][#else]<0=> Secure state[/#if]
//   <o.9>  TIM1_BRK_IRQn         [#if enabledIT?contains("TIM1_BRK_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"9"/][#else]<0=> Secure state[/#if]
//   <o.10> TIM1_UP_IRQn          [#if enabledIT?contains("TIM1_UP_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"10"/][#else]<0=> Secure state[/#if]
//   <o.11> TIM1_TRG_COM_IRQn     [#if enabledIT?contains("TIM1_TRG_COM_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"11"/][#else]<0=> Secure state[/#if]
//   <o.12> TIM1_CC_IRQn          [#if enabledIT?contains("TIM1_CC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"12"/][#else]<0=> Secure state[/#if]
//   <o.13> TIM2_IRQn             [#if enabledIT?contains("TIM2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"13"/][#else]<0=> Secure state[/#if]
//   <o.14> TIM3_IRQn             [#if enabledIT?contains("TIM3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"14"/][#else]<0=> Secure state[/#if]
//   <o.15> TIM4_IRQn             [#if enabledIT?contains("TIM4_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"15"/][#else]<0=> Secure state[/#if]
//   <o.16> TIM5_IRQn             [#if enabledIT?contains("TIM5_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"16"/][#else]<0=> Secure state[/#if]
//   <o.17> TIM6_IRQn             [#if enabledIT?contains("TIM6_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"17"/][#else]<0=> Secure state[/#if]
//   <o.18> TIM7_IRQn             [#if enabledIT?contains("TIM7_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"18"/][#else]<0=> Secure state[/#if]
//   <o.19> TIM8_BRK_IRQn         [#if enabledIT?contains("TIM8_BRK_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"19"/][#else]<0=> Secure state[/#if]
//   <o.20> TIM8_UP_IRQn          [#if enabledIT?contains("TIM8_UP_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"20"/][#else]<0=> Secure state[/#if]
//   <o.21> TIM8_TRG_COM_IRQn     [#if enabledIT?contains("TIM8_TRG_COM_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"21"/][#else]<0=> Secure state[/#if]
//   <o.22> TIM8_CC_IRQn          [#if enabledIT?contains("TIM8_CC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"22"/][#else]<0=> Secure state[/#if]
//   <o.23> I2C1_EV_IRQn          [#if enabledIT?contains("I2C1_EV_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"23"/][#else]<0=> Secure state[/#if]
//   <o.24> I2C1_ER_IRQn          [#if enabledIT?contains("I2C1_ER_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"24"/][#else]<0=> Secure state[/#if]
//   <o.25> I2C2_EV_IRQn          [#if enabledIT?contains("I2C2_EV_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"25"/][#else]<0=> Secure state[/#if]
//   <o.26> I2C2_ER_IRQn          [#if enabledIT?contains("I2C2_ER_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"26"/][#else]<0=> Secure state[/#if]
//   <o.27> SPI1_IRQn             [#if enabledIT?contains("SPI1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"27"/][#else]<0=> Secure state[/#if]
//   <o.28> SPI2_IRQn             [#if enabledIT?contains("SPI2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"28"/][#else]<0=> Secure state[/#if]
//   <o.29> USART1_IRQn           [#if enabledIT?contains("USART1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"29"/][#else]<0=> Secure state[/#if]
//   <o.30> USART2_IRQn           [#if enabledIT?contains("USART2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"30"/][#else]<0=> Secure state[/#if]
//   <o.31> USART3_IRQn           [#if enabledIT?contains("USART3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"31"/][#else]<0=> Secure state[/#if]
*/


[#assign decVal1 = 0/]
[#if nonSecureIT1??]
[#assign lll1 = nonSecureIT1?split(", ")/]
[#list lll1 as it1]
[#assign index1 = Integer.parseInt(it1)/]
[#if index1!=100]
[#assign decVal1 = decVal1 +  Math.pow(2, index1)]
[/#if]
[/#list]
[/#if]

[#assign res1 = String.format("0x%08X" , Integer.valueOf(decVal1)) /]
#define NVIC_INIT_ITNS1_VAL      ${res1}

/*
//   </e>
*/

/*
//   <e>Initialize ITNS 2 (Interrupts 64..95)
*/
#define NVIC_INIT_ITNS2    1

/*
// Interrupts 64..95
//   <o.0>  UART4_IRQn            [#if enabledIT?contains("UART4_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"0"/][#else]<0=> Secure state[/#if]
//   <o.1>  UART5_IRQn            [#if enabledIT?contains("UART5_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"1"/][#else]<0=> Secure state[/#if]
//   <o.2>  LPUART1_IRQn          [#if enabledIT?contains("LPUART1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"2"/][#else]<0=> Secure state[/#if]
//   <o.3>  LPTIM1_IRQn           [#if enabledIT?contains("LPTIM1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"3"/][#else]<0=> Secure state[/#if]
//   <o.4>  LPTIM2_IRQn           [#if enabledIT?contains("LPTIM2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"4"/][#else]<0=> Secure state[/#if]
//   <o.5>  TIM15_IRQn            [#if enabledIT?contains("TIM15_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"5"/][#else]<0=> Secure state[/#if]
//   <o.6>  TIM16_IRQn            [#if enabledIT?contains("TIM16_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"6"/][#else]<0=> Secure state[/#if]
//   <o.7>  TIM17_IRQn            [#if enabledIT?contains("TIM17_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"7"/][#else]<0=> Secure state[/#if]
//   <o.8>  COMP_IRQn             [#if enabledIT?contains("COMP_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"8"/][#else]<0=> Secure state[/#if]
[#if McuName?starts_with("STM32U585")]
//   <o.9>  OTG_FS_IRQn           [#if enabledIT?contains("OTG_FS_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"9"/][#else]<0=> Secure state[/#if]
[/#if]
[#if McuName?starts_with("STM32U575")]
//   <o.9>  OTG_FS_IRQn           [#if enabledIT?contains("OTG_FS_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"9"/][#else]<0=> Secure state[/#if]
[/#if]
[#if McuName?starts_with("STM32U5A5")]
//   <o.9>  OTG_HS_IRQn           [#if enabledIT?contains("OTG_HS_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"9"/][#else]<0=> Secure state[/#if]
[/#if]
[#if McuName?starts_with("STM32U5A9")]
//   <o.9>  OTG_HS_IRQn           [#if enabledIT?contains("OTG_HS_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"9"/][#else]<0=> Secure state[/#if]
[/#if]
[#if McuName?starts_with("STM32U595")]
//   <o.9>  OTG_HS_IRQn           [#if enabledIT?contains("OTG_HS_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"9"/][#else]<0=> Secure state[/#if]
[/#if]
[#if McuName?starts_with("STM32U599")]
//   <o.9>  OTG_HS_IRQn           [#if enabledIT?contains("OTG_HS_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"9"/][#else]<0=> Secure state[/#if]
[/#if]
//   <o.10> CRS_IRQn              [#if enabledIT?contains("CRS_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"10"/][#else]<0=> Secure state[/#if]
//   <o.11> FMC_IRQn              [#if enabledIT?contains("FMC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"11"/][#else]<0=> Secure state[/#if]
//   <o.12> OCTOSPI1_IRQn         [#if enabledIT?contains("OCTOSPI1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"12"/][#else]<0=> Secure state[/#if]
//   <o.13> PWR_S3WU_IRQn         [#if enabledIT?contains("PWR_S3WU_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"13"/][#else]<0=> Secure state[/#if]

//   <o.14> SDMMC1_IRQn           [#if enabledIT?contains("SDMMC1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"14"/][#else]<0=> Secure state[/#if]
//   <o.15> SDMMC2_IRQn           [#if enabledIT?contains("SDMMC2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"15"/][#else]<0=> Secure state[/#if]

//   <o.16> GPDMA1_Channel8_IRQn  [#if enabledIT?contains("GPDMA1_Channel8_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"16"/][#else]<0=> Secure state[/#if]
//   <o.17> GPDMA1_Channel9_IRQn  [#if enabledIT?contains("GPDMA1_Channel9_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"17"/][#else]<0=> Secure state[/#if]
//   <o.18> GPDMA1_Channel10_IRQn [#if enabledIT?contains("GPDMA1_Channel10_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"18"/][#else]<0=> Secure state[/#if]
//   <o.19> GPDMA1_Channel11_IRQn [#if enabledIT?contains("GPDMA1_Channel11_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"19"/][#else]<0=> Secure state[/#if]
//   <o.20> GPDMA1_Channel12_IRQn [#if enabledIT?contains("GPDMA1_Channel12_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"20"/][#else]<0=> Secure state[/#if]
//   <o.21> GPDMA1_Channel13_IRQn [#if enabledIT?contains("GPDMA1_Channel13_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"21"/][#else]<0=> Secure state[/#if]
//   <o.22> GPDMA1_Channel14_IRQn [#if enabledIT?contains("GPDMA1_Channel14_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"22"/][#else]<0=> Secure state[/#if]
//   <o.23> GPDMA1_Channel15_IRQn [#if enabledIT?contains("GPDMA1_Channel15_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"23"/][#else]<0=> Secure state[/#if]
//   <o.24> I2C3_EV_IRQn          [#if enabledIT?contains("I2C3_EV_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"24"/][#else]<0=> Secure state[/#if]
//   <o.25> I2C3_ER_IRQn          [#if enabledIT?contains("I2C3_ER_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"25"/][#else]<0=> Secure state[/#if]
//   <o.26> SAI1_IRQn             [#if enabledIT?contains("SAI1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"26"/][#else]<0=> Secure state[/#if]
//   <o.27> SAI2_IRQn             [#if enabledIT?contains("SAI2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"27"/][#else]<0=> Secure state[/#if]
//   <o.28> TSC_IRQn              [#if enabledIT?contains("TSC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"28"/][#else]<0=> Secure state[/#if]
//   <o.29> AES_IRQn              [#if enabledIT?contains("AES_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"29"/][#else]<0=> Secure state[/#if]

//   <o.30> RNG_IRQn              [#if enabledIT?contains("RNG_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"30"/][#else]<0=> Secure state[/#if]
//   <o.31> FPU_IRQn              [#if enabledIT?contains("FPU_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"31"/][#else]<0=> Secure state[/#if]
*/

[#assign decVal2 = 0/]
[#if nonSecureIT2??]
[#assign lll2 = nonSecureIT2?split(", ")/]
[#list lll2 as it2]
[#assign index2 = Integer.parseInt(it2)/]
[#if index2!=100]
[#assign decVal2 = decVal2 +  Math.pow(2, index2)]
[/#if]
[/#list]
[/#if]

[#assign res2 = String.format("0x%08X" , Integer.valueOf(decVal2)) /]
#define NVIC_INIT_ITNS2_VAL      ${res2}


/*
//   </e>
*/

/*
[#if McuName?starts_with("STM32U585")]
//   <e>Initialize ITNS 3 (Interrupts 96..108)
[/#if]
[#if McuName?starts_with("STM32U575")]
//   <e>Initialize ITNS 3 (Interrupts 96..108)
[/#if]
[#if McuName?starts_with("STM32U5A5")]
//   <e>Initialize ITNS 3 (Interrupts 96..127)
[/#if]
[#if McuName?starts_with("STM32U5A9")]
//   <e>Initialize ITNS 3 (Interrupts 96..127)
[/#if]
[#if McuName?starts_with("STM32U595")]
//   <e>Initialize ITNS 3 (Interrupts 96..127)
[/#if]
[#if McuName?starts_with("STM32U599")]
//   <e>Initialize ITNS 3 (Interrupts 96..127)
[/#if]

*/
#define NVIC_INIT_ITNS3    1

/*
[#if McuName?starts_with("STM32U575")]// Interrupts 96..125[/#if][#if McuName?starts_with("STM32U585")]// Interrupts 96..125[/#if]
[#if McuName?starts_with("STM32U5A5")]// Interrupts 96..127[/#if][#if McuName?starts_with("STM32U5A9")]// Interrupts 96..127[/#if][#if McuName?starts_with("STM32U595")]// Interrupts 96..127[/#if][#if McuName?starts_with("STM32U599")]// Interrupts 96..127[/#if]
//   <o.0>  HASH_IRQn             [#if enabledIT?contains("HASH_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"0"/][#else]<0=> Secure state[/#if]
//   <o.1>  PKA_IRQn              [#if enabledIT?contains("PKA_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"1"/][#else]<0=> Secure state[/#if]
//   <o.2>  LPTIM3_IRQn           [#if enabledIT?contains("LPTIM3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"2"/][#else]<0=> Secure state[/#if]
//   <o.3>  SPI3_IRQn             [#if enabledIT?contains("SPI3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"3"/][#else]<0=> Secure state[/#if]
//   <o.4>  I2C4_ER_IRQn          [#if enabledIT?contains("I2C4_ER_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"4"/][#else]<0=> Secure state[/#if]
//   <o.5>  I2C4_EV_IRQn          [#if enabledIT?contains("I2C4_EV_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"5"/][#else]<0=> Secure state[/#if]
//   <o.6>  MDF1_FLT0_IRQn        [#if enabledIT?contains("MDF1_FLT0_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"6"/][#else]<0=> Secure state[/#if]
//   <o.7>  MDF1_FLT1_IRQn        [#if enabledIT?contains("MDF1_FLT1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"7"/][#else]<0=> Secure state[/#if]
//   <o.8>  MDF1_FLT2_IRQn        [#if enabledIT?contains("MDF1_FLT2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"8"/][#else]<0=> Secure state[/#if]
//   <o.9>  MDF1_FLT3_IRQn        [#if enabledIT?contains("MDF1_FLT3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"9"/][#else]<0=> Secure state[/#if]
//   <o.10> UCPD1_IRQn            [#if enabledIT?contains("UCPD1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"10"/][#else]<0=> Secure state[/#if]
//   <o.11> ICACHE_IRQn           [#if enabledIT?contains("ICACHE_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"11"/][#else]<0=> Secure state[/#if]
//   <o.12> OTFDEC1_IRQn          [#if enabledIT?contains("OTFDEC1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"12"/][#else]<0=> Secure state[/#if]
//   <o.13> OTFDEC2_IRQn          [#if enabledIT?contains("OTFDEC2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"13"/][#else]<0=> Secure state[/#if]
//   <o.14> LPTIM4_IRQn           [#if enabledIT?contains("LPTIM4_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"14"/][#else]<0=> Secure state[/#if]
//   <o.15> DCACHE1_IRQn          [#if enabledIT?contains("DCACHE1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"15"/][#else]<0=> Secure state[/#if]
//   <o.16> ADF1_IRQn             [#if enabledIT?contains("ADF1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"16"/][#else]<0=> Secure state[/#if]
//   <o.17> ADC4_IRQn             [#if enabledIT?contains("ADC4_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"17"/][#else]<0=> Secure state[/#if]
//   <o.18> LPDMA1_Channel0_IRQn  [#if enabledIT?contains("LPDMA1_Channel0_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"18"/][#else]<0=> Secure state[/#if]
//   <o.19> LPDMA1_Channel1_IRQn  [#if enabledIT?contains("LPDMA1_Channel1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"19"/][#else]<0=> Secure state[/#if]
//   <o.20> LPDMA1_Channel2_IRQn  [#if enabledIT?contains("LPDMA1_Channel2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"20"/][#else]<0=> Secure state[/#if]
//   <o.21> LPDMA1_Channel3_IRQn  [#if enabledIT?contains("LPDMA1_Channel3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"21"/][#else]<0=> Secure state[/#if]
//   <o.22> DMA2D_IRQn            [#if enabledIT?contains("DMA2D_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"22"/][#else]<0=> Secure state[/#if]
//   <o.23> DCMI_PSSI_IRQn        [#if enabledIT?contains("DCMI_PSSI_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"23"/][#else]<0=> Secure state[/#if]
//   <o.24> OCTOSPI2_IRQn         [#if enabledIT?contains("OCTOSPI2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"24"/][#else]<0=> Secure state[/#if]
//   <o.25> MDF1_FLT4_IRQn        [#if enabledIT?contains("MDF1_FLT4_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"25"/][#else]<0=> Secure state[/#if]
//   <o.26> MDF1_FLT5_IRQn        [#if enabledIT?contains("MDF1_FLT5_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"26"/][#else]<0=> Secure state[/#if]
//   <o.27> CORDIC_IRQn           [#if enabledIT?contains("CORDIC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"27"/][#else]<0=> Secure state[/#if]
//   <o.28> FMAC_IRQn             [#if enabledIT?contains("FMAC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"28"/][#else]<0=> Secure state[/#if]
[#if McuName?starts_with("STM32U5A5")]
//   <o.30> USART6_IRQn           [#if enabledIT?contains("USART6_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"30"/][#else]<0=> Secure state[/#if]
//   <o.31> I2C5_ER_IRQn          [#if enabledIT?contains("I2C5_ER_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"31"/][#else]<0=> Secure state[/#if]
[/#if]
[#if McuName?starts_with("STM32U5A9")]
//   <o.30> USART6_IRQn           [#if enabledIT?contains("USART6_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"30"/][#else]<0=> Secure state[/#if]
//   <o.31> I2C5_ER_IRQn          [#if enabledIT?contains("I2C5_ER_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"31"/][#else]<0=> Secure state[/#if]
[/#if]
[#if McuName?starts_with("STM32U595")]
//   <o.30> USART6_IRQn           [#if enabledIT?contains("USART6_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"30"/][#else]<0=> Secure state[/#if]
//   <o.31> I2C5_ER_IRQn          [#if enabledIT?contains("I2C5_ER_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"31"/][#else]<0=> Secure state[/#if]
[/#if]
[#if McuName?starts_with("STM32U599")]
//   <o.30> USART6_IRQn           [#if enabledIT?contains("USART6_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"30"/][#else]<0=> Secure state[/#if]
//   <o.31> I2C5_ER_IRQn          [#if enabledIT?contains("I2C5_ER_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"31"/][#else]<0=> Secure state[/#if]
[/#if]

*/

[#assign decVal3 = 0/]
[#if nonSecureIT3??]
[#assign lll3 = nonSecureIT3?split(", ")/]
[#list lll3 as it3]
[#assign index3 = Integer.parseInt(it3)/]
[#if index3!=100]
[#assign decVal3 = decVal3 +  Math.pow(2, index3)]
[/#if]
[/#list]
[/#if]

[#assign res3 = String.format("0x%08X" , Math.round(decVal3)) /]
#define NVIC_INIT_ITNS3_VAL      ${res3}

[#if McuName?starts_with("STM32U5A5")]
/*
//   </e>
*/

/*
//   <e>Initialize ITNS 4 (Interrupts 109..138)
*/
#define NVIC_INIT_ITNS4    1

/*
// Interrupts 96..138
//   <o.0>  I2C5_EV_IRQn          <0=> Secure state <1=> Non-Secure state
//   <o.1>  I2C6_ER_IRQn          <0=> Secure state <1=> Non-Secure state
//   <o.2>  I2C6_EV_IRQn          <0=> Secure state <1=> Non-Secure state
//   <o.3>  HSPI1_IRQn            <0=> Secure state <1=> Non-Secure state
*/
#define NVIC_INIT_ITNS4_VAL      0x00000000
[/#if]

[#if McuName?starts_with("STM32U5A9")]
/*
//   </e>
*/

/*
//   <e>Initialize ITNS 4 (Interrupts 109..138)
*/
#define NVIC_INIT_ITNS4    1

/*
// Interrupts 96..138
//   <o.0>  I2C5_EV_IRQn          <0=> Secure state <1=> Non-Secure state
//   <o.1>  I2C6_ER_IRQn          <0=> Secure state <1=> Non-Secure state
//   <o.2>  I2C6_EV_IRQn          <0=> Secure state <1=> Non-Secure state
//   <o.3>  HSPI1_IRQn            <0=> Secure state <1=> Non-Secure state
//   <o.4>  GPU2D_IRQn            <0=> Secure state <1=> Non-Secure state
//   <o.5>  GPU2D_ER_IRQn         <0=> Secure state <1=> Non-Secure state
//   <o.6>  GFXMMU_IRQn           <0=> Secure state <1=> Non-Secure state
//   <o.7>  LTDC_IRQn             <0=> Secure state <1=> Non-Secure state
//   <o.8>  LTDC_ER_IRQn          <0=> Secure state <1=> Non-Secure state
//   <o.9>  DSI_IRQn              <0=> Secure state <1=> Non-Secure state
//   <o.10> DCACHE2_IRQn          <0=> Secure state <1=> Non-Secure state
*/
#define NVIC_INIT_ITNS4_VAL      0x00000000
[/#if]

[#if McuName?starts_with("STM32U595")]
/*
//   </e>
*/

/*
//   <e>Initialize ITNS 4 (Interrupts 109..138)
*/
#define NVIC_INIT_ITNS4    1

/*
// Interrupts 96..138
//   <o.0>  I2C5_EV_IRQn          <0=> Secure state <1=> Non-Secure state
//   <o.1>  I2C6_ER_IRQn          <0=> Secure state <1=> Non-Secure state
//   <o.2>  I2C6_EV_IRQn          <0=> Secure state <1=> Non-Secure state
//   <o.3>  HSPI1_IRQn            <0=> Secure state <1=> Non-Secure state
//   <o.4>  GPU2D_IRQn            <0=> Secure state <1=> Non-Secure state
//   <o.5>  GPU2D_ER_IRQn         <0=> Secure state <1=> Non-Secure state
//   <o.6>  GFXMMU_IRQn           <0=> Secure state <1=> Non-Secure state
//   <o.7>  LTDC_IRQn             <0=> Secure state <1=> Non-Secure state
//   <o.8>  LTDC_ER_IRQn          <0=> Secure state <1=> Non-Secure state
//   <o.9>  DSI_IRQn              <0=> Secure state <1=> Non-Secure state
//   <o.10> DCACHE2_IRQn          <0=> Secure state <1=> Non-Secure state
*/
#define NVIC_INIT_ITNS4_VAL      0x00000000
[/#if]

[#if McuName?starts_with("STM32U599")]
/*
//   </e>
*/

/*
//   <e>Initialize ITNS 4 (Interrupts 109..138)
*/
#define NVIC_INIT_ITNS4    1

/*
// Interrupts 96..138
//   <o.0>  I2C5_EV_IRQn          <0=> Secure state <1=> Non-Secure state
//   <o.1>  I2C6_ER_IRQn          <0=> Secure state <1=> Non-Secure state
//   <o.2>  I2C6_EV_IRQn          <0=> Secure state <1=> Non-Secure state
//   <o.3>  HSPI1_IRQn            <0=> Secure state <1=> Non-Secure state
//   <o.4>  GPU2D_IRQn            <0=> Secure state <1=> Non-Secure state
//   <o.5>  GPU2D_ER_IRQn         <0=> Secure state <1=> Non-Secure state
//   <o.6>  GFXMMU_IRQn           <0=> Secure state <1=> Non-Secure state
//   <o.7>  LTDC_IRQn             <0=> Secure state <1=> Non-Secure state
//   <o.8>  LTDC_ER_IRQn          <0=> Secure state <1=> Non-Secure state
//   <o.9>  DSI_IRQn              <0=> Secure state <1=> Non-Secure state
//   <o.10> DCACHE2_IRQn          <0=> Secure state <1=> Non-Secure state
*/
#define NVIC_INIT_ITNS4_VAL      0x00000000
[/#if]

/*
//   </e>
*/

/*
// </h>
*/

/* USER CODE BEGIN 2 */

/*
    max 8 SAU regions.
    SAU regions are defined in partition.h
 */

#define SAU_INIT_REGION(n) \
    SAU->RNR  =  (n                                     & SAU_RNR_REGION_Msk); \
    SAU->RBAR =  (SAU_INIT_START##n                     & SAU_RBAR_BADDR_Msk); \
    SAU->RLAR =  (SAU_INIT_END##n                       & SAU_RLAR_LADDR_Msk) | \
                ((SAU_INIT_NSC##n << SAU_RLAR_NSC_Pos)  & SAU_RLAR_NSC_Msk)   | 1U

/**
  \brief   Setup a SAU Region
  \details Writes the region information contained in SAU_Region to the
           registers SAU_RNR, SAU_RBAR, and SAU_RLAR
 */
__STATIC_INLINE void TZ_SAU_Setup (void)
{

#if defined (__SAUREGION_PRESENT) && (__SAUREGION_PRESENT == 1U)

  #if defined (SAU_INIT_REGION0) && (SAU_INIT_REGION0 == 1U)
    SAU_INIT_REGION(0);
  #endif

  #if defined (SAU_INIT_REGION1) && (SAU_INIT_REGION1 == 1U)
    SAU_INIT_REGION(1);
  #endif

  #if defined (SAU_INIT_REGION2) && (SAU_INIT_REGION2 == 1U)
    SAU_INIT_REGION(2);
  #endif

  #if defined (SAU_INIT_REGION3) && (SAU_INIT_REGION3 == 1U)
    SAU_INIT_REGION(3);
  #endif

  #if defined (SAU_INIT_REGION4) && (SAU_INIT_REGION4 == 1U)
    SAU_INIT_REGION(4);
  #endif

  #if defined (SAU_INIT_REGION5) && (SAU_INIT_REGION5 == 1U)
    SAU_INIT_REGION(5);
  #endif

  #if defined (SAU_INIT_REGION6) && (SAU_INIT_REGION6 == 1U)
    SAU_INIT_REGION(6);
  #endif

  #if defined (SAU_INIT_REGION7) && (SAU_INIT_REGION7 == 1U)
    SAU_INIT_REGION(7);
  #endif

  /* repeat this for all possible SAU regions */

#endif /* defined (__SAUREGION_PRESENT) && (__SAUREGION_PRESENT == 1U) */


  #if defined (SAU_INIT_CTRL) && (SAU_INIT_CTRL == 1U)
    SAU->CTRL = ((SAU_INIT_CTRL_ENABLE << SAU_CTRL_ENABLE_Pos) & SAU_CTRL_ENABLE_Msk) |
                ((SAU_INIT_CTRL_ALLNS  << SAU_CTRL_ALLNS_Pos)  & SAU_CTRL_ALLNS_Msk)   ;
  #endif

  #if defined (SCB_CSR_AIRCR_INIT) && (SCB_CSR_AIRCR_INIT == 1U)
    SCB->SCR   = (SCB->SCR   & ~(SCB_SCR_SLEEPDEEPS_Msk    )) |
                   ((SCB_CSR_DEEPSLEEPS_VAL     << SCB_SCR_SLEEPDEEPS_Pos)     & SCB_SCR_SLEEPDEEPS_Msk);

    SCB->AIRCR = (SCB->AIRCR & ~(SCB_AIRCR_VECTKEY_Msk   | SCB_AIRCR_SYSRESETREQS_Msk |
                                 SCB_AIRCR_BFHFNMINS_Msk | SCB_AIRCR_PRIS_Msk)        )                     |
                   ((0x05FAU                    << SCB_AIRCR_VECTKEY_Pos)      & SCB_AIRCR_VECTKEY_Msk)      |
                   ((SCB_AIRCR_SYSRESETREQS_VAL << SCB_AIRCR_SYSRESETREQS_Pos) & SCB_AIRCR_SYSRESETREQS_Msk) |
                   ((SCB_AIRCR_PRIS_VAL         << SCB_AIRCR_PRIS_Pos)         & SCB_AIRCR_PRIS_Msk)         |
                   ((SCB_AIRCR_BFHFNMINS_VAL    << SCB_AIRCR_BFHFNMINS_Pos)    & SCB_AIRCR_BFHFNMINS_Msk);
  #endif /* defined (SCB_CSR_AIRCR_INIT) && (SCB_CSR_AIRCR_INIT == 1U) */

  #if defined (__FPU_USED) && (__FPU_USED == 1U) && \
      defined (TZ_FPU_NS_USAGE) && (TZ_FPU_NS_USAGE == 1U)

    SCB->NSACR = (SCB->NSACR & ~(SCB_NSACR_CP10_Msk | SCB_NSACR_CP11_Msk)) |
                   ((SCB_NSACR_CP10_11_VAL << SCB_NSACR_CP10_Pos) & (SCB_NSACR_CP10_Msk | SCB_NSACR_CP11_Msk));

    FPU->FPCCR = (FPU->FPCCR & ~(FPU_FPCCR_TS_Msk | FPU_FPCCR_CLRONRETS_Msk | FPU_FPCCR_CLRONRET_Msk)) |
                   ((FPU_FPCCR_TS_VAL        << FPU_FPCCR_TS_Pos       ) & FPU_FPCCR_TS_Msk       ) |
                   ((FPU_FPCCR_CLRONRETS_VAL << FPU_FPCCR_CLRONRETS_Pos) & FPU_FPCCR_CLRONRETS_Msk) |
                   ((FPU_FPCCR_CLRONRET_VAL  << FPU_FPCCR_CLRONRET_Pos ) & FPU_FPCCR_CLRONRET_Msk );
  #endif

  #if defined (NVIC_INIT_ITNS0) && (NVIC_INIT_ITNS0 == 1U)
    NVIC->ITNS[0] = NVIC_INIT_ITNS0_VAL;
  #endif

  #if defined (NVIC_INIT_ITNS1) && (NVIC_INIT_ITNS1 == 1U)
    NVIC->ITNS[1] = NVIC_INIT_ITNS1_VAL;
  #endif

  #if defined (NVIC_INIT_ITNS2) && (NVIC_INIT_ITNS2 == 1U)
    NVIC->ITNS[2] = NVIC_INIT_ITNS2_VAL;
  #endif

  #if defined (NVIC_INIT_ITNS3) && (NVIC_INIT_ITNS3 == 1U)
    NVIC->ITNS[3] = NVIC_INIT_ITNS3_VAL;
  #endif

[#if McuName?starts_with("STM32U5A5")]
  #if defined (NVIC_INIT_ITNS4) && (NVIC_INIT_ITNS4 == 1U)
    NVIC->ITNS[4] = NVIC_INIT_ITNS4_VAL;
  #endif
[/#if]

[#if McuName?starts_with("STM32U5A9")]
  #if defined (NVIC_INIT_ITNS4) && (NVIC_INIT_ITNS4 == 1U)
    NVIC->ITNS[4] = NVIC_INIT_ITNS4_VAL;
  #endif
[/#if]

[#if McuName?starts_with("STM32U595")]
  #if defined (NVIC_INIT_ITNS4) && (NVIC_INIT_ITNS4 == 1U)
    NVIC->ITNS[4] = NVIC_INIT_ITNS4_VAL;
  #endif
[/#if]

[#if McuName?starts_with("STM32U599")]
  #if defined (NVIC_INIT_ITNS4) && (NVIC_INIT_ITNS4 == 1U)
    NVIC->ITNS[4] = NVIC_INIT_ITNS4_VAL;
  #endif
[/#if]

}
/* USER CODE END 2 */
[#if McuName?starts_with("STM32U585")]
#endif  /* PARTITION_STM32U585XX_H */
[/#if]

[#if McuName?starts_with("STM32U575")]
#endif  /* PARTITION_STM32U575XX_H */
[/#if]

[#if McuName?starts_with("STM32U5A5")]
#endif  /* PARTITION_STM32U5A5XX_H */
[/#if]

[#if McuName?starts_with("STM32U5A9")]
#endif  /* PARTITION_STM32U5A9XX_H */
[/#if]

[#if McuName?starts_with("STM32U595")]
#endif  /* PARTITION_STM32U595XX_H */
[/#if]

[#if McuName?starts_with("STM32U599")]
#endif  /* PARTITION_STM32U599XX_H */
[/#if]


