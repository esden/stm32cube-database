[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    partition_[#if McuName?starts_with("STM32N647")]stm32n647xx.h[/#if][#if McuName?starts_with("STM32N657")]stm32n657xx.h[/#if]
  * @author  MCD Application Team
  * @brief   CMSIS [#if McuName?starts_with("STM32N647")]STM32N647xx[/#if][#if McuName?starts_with("STM32N657")]STM32N657xx[/#if] Device Initial Setup for Secure / Non-Secure Zones
  *          for ARMCM55 based on CMSIS CORE V5.3.1 partition_ARMCM33.h Template.
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
* Portions Copyright (c) 2023 STMicroelectronics, all rights reserved
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

[#assign familyName = McuName?substring(0,9)]
#ifndef PARTITION_${familyName}XX_H
#define PARTITION_${familyName}XX_H
[#assign nonSecureIT0 = "100, 100"/]
[#assign nonSecureIT1 = "100, 100"/]
[#assign nonSecureIT2 = "100, 100"/]
[#assign nonSecureIT3 = "100, 100"/]
[#assign nonSecureIT4 = "100, 100"/]
[#assign nonSecureIT5 = "100, 100"/]
[#assign nonSecureIT6 = "100, 100"/]
[#if SAU??]
[@common.optinclude name=contextFolder+mxTmpFolder+"/sau_partition.tmp"/][#-- ADD SAU init Code--]
[#else]/*
//-------- <<< Use Configuration Wizard in Context Menu >>> -----------------
*/
/*
// <e>Initialize Security Attribution Unit (SAU) CTRL register
*/
#define SAU_INIT_CTRL          0

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
#define SAU_INIT_CTRL_ALLNS  0

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

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START0     0x00000000      /* start address of SAU region 0 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END0       0x00000000      /* end address of SAU region 0 */

/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC0       0
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 1
//   <i> Setup SAU Region 1 memory attributes
*/
#define SAU_INIT_REGION1    0

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START1       0x00000000      /* start address of SAU region 1 */
/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END1       0x00000000      /* end address of SAU region 1 */
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

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START2     0x00000000      /* start address of SAU region 2 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END2       0x00000000      /* end address of SAU region 2 */

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
#define SAU_INIT_START3     0x00000000      /* start address of SAU region 3 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END3       0x00000000      /* end address of SAU region 3 */

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
#define SAU_INIT_START4     0x00000000      /* start address of SAU region 4 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END4       0x00000000      /* end address of SAU region 4 */

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
#define SAU_INIT_START5     0x00000000      /* start address of SAU region 5 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END5       0x00000000      /* end address of SAU region 5 */

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
[/#if]
/* USER CODE BEGIN 0 */
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
#define SCB_AIRCR_SYSRESETREQS_VAL  0
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
#define SCB_AIRCR_BFHFNMINS_VAL [#if AIRCR_BFHFNMINS??]${AIRCR_BFHFNMINS}[#else]0[/#if]

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
//   <o.0>  PVD_PVM_IRQn        [#if enabledIT?contains("PVD_PVM_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"0"/][#else]<0=> Secure state[/#if]
//   <o.1> Reserved             [#if enabledIT?contains("Reserved")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"1"/][#else]<0=> Secure state[/#if]
//   <o.2>  DTS_IRQn            [#if enabledIT?contains("DTS_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"2"/][#else]<0=> Secure state[/#if]
//   <o.3>  RCC_IRQn            [#if enabledIT?contains("RCC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"3"/][#else]<0=> Secure state[/#if]
//   <o.4>  LOCKUP_IRQn         [#if enabledIT?contains("LOCKUP_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"4"/][#else]<0=> Secure state[/#if]
//   <o.5>  CACHE_ECC_IRQn      [#if enabledIT?contains("CACHE_ECC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"5"/][#else]<0=> Secure state[/#if]
//   <o.6>  TCM_ECC_IRQn        [#if enabledIT?contains("TCM_ECC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"6"/][#else]<0=> Secure state[/#if]
//   <o.7>  BKP_ECC_IRQn        [#if enabledIT?contains("BKP_ECC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"7"/][#else]<0=> Secure state[/#if]
//   <o.8>  FPU_IRQn            [#if enabledIT?contains("FPU_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"8"/][#else]<0=> Secure state[/#if]
//   <o.9>  Reserved            [#if enabledIT?contains("Reserved")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"9"/][#else]<0=> Secure state[/#if]
//   <o.10> RTC_S_IRQn          [#if enabledIT?contains("RTC_S_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"10"/][#else]<0=> Secure state[/#if]
//   <o.11> TAMP_IRQn           [#if enabledIT?contains("TAMP_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"11"/][#else]<0=> Secure state[/#if]
//   <o.12> RIFSC_TAMPER_IRQn   [#if enabledIT?contains("RIFSC_TAMPER_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"12"/][#else]<0=> Secure state[/#if]
//   <o.13> IAC_IRQn            [#if enabledIT?contains("IAC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"13"/][#else]<0=> Secure state[/#if]
//   <o.14> RCC_S_IRQn          [#if enabledIT?contains("RCC_S_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"14"/][#else]<0=> Secure state[/#if]
//   <o.15> Reserved            [#if enabledIT?contains("Reserved")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"15"/][#else]<0=> Secure state[/#if]
//   <o.16> RTC_IRQn            [#if enabledIT?contains("RTC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"16"/][#else]<0=> Secure state[/#if]
//   <o.17> Reserved            [#if enabledIT?contains("Reserved")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"17"/][#else]<0=> Secure state[/#if]
//   <o.18> IWDG_IRQn           [#if enabledIT?contains("IWDG_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"18"/][#else]<0=> Secure state[/#if]
//   <o.19> WWDG_IRQn           [#if enabledIT?contains("WWDG_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"19"/][#else]<0=> Secure state[/#if]
//   <o.20> EXTI0_IRQn          [#if enabledIT?contains("EXTI0_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"20"/][#else]<0=> Secure state[/#if]
//   <o.21> EXTI1_IRQn          [#if enabledIT?contains("EXTI1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"21"/][#else]<0=> Secure state[/#if]
//   <o.22> EXTI2_IRQn          [#if enabledIT?contains("EXTI2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"22"/][#else]<0=> Secure state[/#if]
//   <o.23> EXTI3_IRQn          [#if enabledIT?contains("EXTI3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"23"/][#else]<0=> Secure state[/#if]
//   <o.24> EXTI4_IRQn          [#if enabledIT?contains("EXTI4_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"24"/][#else]<0=> Secure state[/#if]
//   <o.25> EXTI5_IRQn          [#if enabledIT?contains("EXTI5_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"25"/][#else]<0=> Secure state[/#if]
//   <o.26> EXTI6_IRQn          [#if enabledIT?contains("EXTI6_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"26"/][#else]<0=> Secure state[/#if]
//   <o.27> EXTI7_IRQn          [#if enabledIT?contains("EXTI7_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"27"/][#else]<0=> Secure state[/#if]
//   <o.28> EXTI8_IRQn          [#if enabledIT?contains("EXTI8_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"28"/][#else]<0=> Secure state[/#if]
//   <o.29> EXTI9_IRQn          [#if enabledIT?contains("EXTI9_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"29"/][#else]<0=> Secure state[/#if]
//   <o.30> EXTI10_IRQn         [#if enabledIT?contains("EXTI10_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"30"/][#else]<0=> Secure state[/#if]
//   <o.31> EXTI11_IRQn         [#if enabledIT?contains("EXTI11_IRQn")]<1=> Non-Secure state[#assign nonSecureIT0 = nonSecureIT0+", "+"31"/][#else]<0=> Secure state[/#if]
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
/ Interrupts 32..63
//   <o.0>  EXTI12_IRQn       [#if enabledIT?contains("EXTI12_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"0"/][#else]<0=> Secure state[/#if]
//   <o.1>  EXTI13_IRQn       [#if enabledIT?contains("EXTI13_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"1"/][#else]<0=> Secure state[/#if]
//   <o.2>  EXTI14_IRQn       [#if enabledIT?contains("EXTI14_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"2"/][#else]<0=> Secure state[/#if]
//   <o.3>  EXTI15_IRQn       [#if enabledIT?contains("EXTI15_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"3"/][#else]<0=> Secure state[/#if]
[#if McuName?starts_with("STM32N657")]
//   <o.4>  SAES_IRQn          [#if enabledIT?contains("SAES_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"4"/][#else]<0=> Secure state[/#if]
//   <o.5>  CRYP_IRQn   	      [#if enabledIT?contains("CRYP_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"5"/][#else]<0=> Secure state[/#if]
[#else]
//   <o.4>  Reserved          [#if enabledIT?contains("Reserved")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"4"/][#else]<0=> Secure state[/#if]
//   <o.5>  Reserved   	      [#if enabledIT?contains("Reserved")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"5"/][#else]<0=> Secure state[/#if]
[/#if]
//   <o.6>  PKA_IRQn          [#if enabledIT?contains("PKA_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"6"/][#else]<0=> Secure state[/#if]
//   <o.7>  HASH_IRQn         [#if enabledIT?contains("HASH_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"7"/][#else]<0=> Secure state[/#if]
//   <o.8>  RNG_IRQn          [#if enabledIT?contains("RNG_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"8"/][#else]<0=> Secure state[/#if]
//   <o.9>  Reserved          [#if enabledIT?contains("Reserved")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"9"/][#else]<0=> Secure state[/#if]
[#if McuName?starts_with("STM32N657")]
//   <o.10> MCE1_IRQn          [#if enabledIT?contains("MCE1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"10"/][#else]<0=> Secure state[/#if]
//   <o.11> MCE2_IRQn          [#if enabledIT?contains("MCE2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"11"/][#else]<0=> Secure state[/#if]
//   <o.12> MCE3_IRQn          [#if enabledIT?contains("MCE3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"12"/][#else]<0=> Secure state[/#if]
//   <o.13> MCE4_IRQn          [#if enabledIT?contains("MCE4_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"13"/][#else]<0=> Secure state[/#if]
[#else]
//   <o.10> Reserved          [#if enabledIT?contains("Reserved")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"10"/][#else]<0=> Secure state[/#if]
//   <o.11> Reserved          [#if enabledIT?contains("Reserved")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"11"/][#else]<0=> Secure state[/#if]
//   <o.12> Reserved          [#if enabledIT?contains("Reserved")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"12"/][#else]<0=> Secure state[/#if]
//   <o.13> Reserved          [#if enabledIT?contains("Reserved")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"13"/][#else]<0=> Secure state[/#if]
[/#if]
//   <o.14> ADC1_2_IRQn       [#if enabledIT?contains("ADC1_2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"14"/][#else]<0=> Secure state[/#if]
//   <o.15> CSI_IRQn          [#if enabledIT?contains("CSI_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"15"/][#else]<0=> Secure state[/#if]
//   <o.16> DCMIPP_IRQn       [#if enabledIT?contains("DCMIPP_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"16"/][#else]<0=> Secure state[/#if]
//   <o.17> Reserved          [#if enabledIT?contains("Reserved")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"17"/][#else]<0=> Secure state[/#if]
//   <o.18> Reserved          [#if enabledIT?contains("Reserved")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"18"/][#else]<0=> Secure state[/#if]
//   <o.19> Reserved          [#if enabledIT?contains("Reserved")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"19"/][#else]<0=> Secure state[/#if]
//   <o.20> PAHB_ERR_IRQn     [#if enabledIT?contains("PAHB_ERR_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"20"/][#else]<0=> Secure state[/#if]
//   <o.21> NPU0_IRQn         [#if enabledIT?contains("NPU0_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"21"/][#else]<0=> Secure state[/#if]
//   <o.22> NPU1_IRQn         [#if enabledIT?contains("NPU1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"22"/][#else]<0=> Secure state[/#if]
//   <o.23> NPU2_IRQn         [#if enabledIT?contains("NPU2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"23"/][#else]<0=> Secure state[/#if]
//   <o.24> NPU3_IRQn         [#if enabledIT?contains("NPU3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"24"/][#else]<0=> Secure state[/#if]
//   <o.25> CACHEAXI_IRQn     [#if enabledIT?contains("CACHEAXI_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"25"/][#else]<0=> Secure state[/#if]
//   <o.26> LTDC_LO_IRQn      [#if enabledIT?contains("LTDC_LO_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"26"/][#else]<0=> Secure state[/#if]
//   <o.27> LTDC_LO_ERR_IRQn  [#if enabledIT?contains("LTDC_LO_ERR_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"27"/][#else]<0=> Secure state[/#if]
//   <o.28> DMA2D_IRQn        [#if enabledIT?contains("DMA2D_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"28"/][#else]<0=> Secure state[/#if]
//   <o.29> JPEG_IRQn         [#if enabledIT?contains("JPEG_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"29"/][#else]<0=> Secure state[/#if]
//   <o.30> VENC_IRQn         [#if enabledIT?contains("VENC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"30"/][#else]<0=> Secure state[/#if]
//   <o.31> GFXMMU_IRQn       [#if enabledIT?contains("GFXMMU_IRQn")]<1=> Non-Secure state[#assign nonSecureIT1 = nonSecureIT1+", "+"31"/][#else]<0=> Secure state[/#if]
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
//   <o.0>  GFXTIM_IRQn               [#if enabledIT?contains("GFXTIM_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"0"/][#else]<0=> Secure state[/#if]
//   <o.1>  GPU2D_IRQn                [#if enabledIT?contains("GPU2D_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"1"/][#else]<0=> Secure state[/#if]
//   <o.2>  GPU2D_ER_IRQn             [#if enabledIT?contains("GPU2D_ER_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"2"/][#else]<0=> Secure state[/#if]
//   <o.3>  ICACHE_IRQn               [#if enabledIT?contains("ICACHE_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"3"/][#else]<0=> Secure state[/#if]
//   <o.4>  HPDMA1_Channel0_IRQn      [#if enabledIT?contains("HPDMA1_Channel0_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"4"/][#else]<0=> Secure state[/#if]
//   <o.5>  HPDMA1_Channel1_IRQn      [#if enabledIT?contains("HPDMA1_Channel1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"5"/][#else]<0=> Secure state[/#if]
//   <o.6>  HPDMA1_Channel2_IRQn      [#if enabledIT?contains("HPDMA1_Channel2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"6"/][#else]<0=> Secure state[/#if]
//   <o.7>  HPDMA1_Channel3_IRQn      [#if enabledIT?contains("HPDMA1_Channel3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"7"/][#else]<0=> Secure state[/#if]
//   <o.8>  HPDMA1_Channel4_IRQn      [#if enabledIT?contains("HPDMA1_Channel4_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"8"/][#else]<0=> Secure state[/#if]
//   <o.9>  HPDMA1_Channel5_IRQn      [#if enabledIT?contains("HPDMA1_Channel5_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"9"/][#else]<0=> Secure state[/#if]
//   <o.10> HPDMA1_Channel6_IRQn      [#if enabledIT?contains("HPDMA1_Channel6_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"10"/][#else]<0=> Secure state[/#if]
//   <o.11> HPDMA1_Channel7_IRQn      [#if enabledIT?contains("HPDMA1_Channel7_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"11"/][#else]<0=> Secure state[/#if]
//   <o.12> HPDMA1_Channel8_IRQn      [#if enabledIT?contains("HPDMA1_Channel8_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"12"/][#else]<0=> Secure state[/#if]
//   <o.13> HPDMA1_Channel9_IRQn      [#if enabledIT?contains("HPDMA1_Channel9_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"13"/][#else]<0=> Secure state[/#if]
//   <o.14> HPDMA1_Channel10_IRQn     [#if enabledIT?contains("HPDMA1_Channel10_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"14"/][#else]<0=> Secure state[/#if]
//   <o.15> HPDMA1_Channel11_IRQn     [#if enabledIT?contains("HPDMA1_Channel11_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"15"/][#else]<0=> Secure state[/#if]
//   <o.16> HPDMA1_Channel12_IRQn     [#if enabledIT?contains("HPDMA1_Channel12_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"16"/][#else]<0=> Secure state[/#if]
//   <o.17> HPDMA1_Channel13_IRQn     [#if enabledIT?contains("HPDMA1_Channel13_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"17"/][#else]<0=> Secure state[/#if]
//   <o.18> HPDMA1_Channel14_IRQn     [#if enabledIT?contains("HPDMA1_Channel14_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"18"/][#else]<0=> Secure state[/#if]
//   <o.19> HPDMA1_Channel15_IRQn     [#if enabledIT?contains("HPDMA1_Channel15_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"19"/][#else]<0=> Secure state[/#if]
//   <o.20> GPDMA1_Channel0_IRQn      [#if enabledIT?contains("GPDMA1_Channel0_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"20"/][#else]<0=> Secure state[/#if]
//   <o.21> GPDMA1_Channel1_IRQn      [#if enabledIT?contains("GPDMA1_Channel1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"21"/][#else]<0=> Secure state[/#if]
//   <o.22> GPDMA1_Channel2_IRQn      [#if enabledIT?contains("GPDMA1_Channel2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"22"/][#else]<0=> Secure state[/#if]
//   <o.23> GPDMA1_Channel3_IRQn      [#if enabledIT?contains("GPDMA1_Channel3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"23"/][#else]<0=> Secure state[/#if]
//   <o.24> GPDMA1_Channel4_IRQn      [#if enabledIT?contains("GPDMA1_Channel4_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"24"/][#else]<0=> Secure state[/#if]
//   <o.25> GPDMA1_Channel5_IRQn      [#if enabledIT?contains("GPDMA1_Channel5_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"25"/][#else]<0=> Secure state[/#if]
//   <o.26> GPDMA1_Channel6_IRQn      [#if enabledIT?contains("GPDMA1_Channel6_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"26"/][#else]<0=> Secure state[/#if]
//   <o.27> GPDMA1_Channel7_IRQn      [#if enabledIT?contains("GPDMA1_Channel7_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"27"/][#else]<0=> Secure state[/#if]
//   <o.28> GPDMA1_Channel8_IRQn      [#if enabledIT?contains("GPDMA1_Channel8_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"28"/][#else]<0=> Secure state[/#if]
//   <o.29> GPDMA1_Channel9_IRQn      [#if enabledIT?contains("GPDMA1_Channel9_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"29"/][#else]<0=> Secure state[/#if]
//   <o.30> GPDMA1_Channel10_IRQn     [#if enabledIT?contains("GPDMA1_Channel10_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"30"/][#else]<0=> Secure state[/#if]
//   <o.31> GPDMA1_Channel11_IRQn     [#if enabledIT?contains("GPDMA1_Channel11_IRQn")]<1=> Non-Secure state[#assign nonSecureIT2 = nonSecureIT2+", "+"31"/][#else]<0=> Secure state[/#if]
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
//   <e>Initialize ITNS 3 (Interrupts 96..127)
*/
#define NVIC_INIT_ITNS3    1
/*
// Interrupts 96..127
//   <o.0>  GPDMA1_Channel12_IRQn   [#if enabledIT?contains("GPDMA1_Channel12_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"0"/][#else]<0=> Secure state[/#if]
//   <o.1>  GPDMA1_Channel13_IRQn   [#if enabledIT?contains("GPDMA1_Channel13_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"1"/][#else]<0=> Secure state[/#if]
//   <o.2>  GPDMA1_Channel14_IRQn   [#if enabledIT?contains("GPDMA1_Channel14_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"2"/][#else]<0=> Secure state[/#if]
//   <o.3>  GPDMA1_Channel15_IRQn   [#if enabledIT?contains("GPDMA1_Channel15_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"3"/][#else]<0=> Secure state[/#if]
//   <o.4>  I2C1_EV_IRQn            [#if enabledIT?contains("I2C1_EV_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"4"/][#else]<0=> Secure state[/#if]
//   <o.5>  I2C1_ER_IRQn            [#if enabledIT?contains("I2C1_ER_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"5"/][#else]<0=> Secure state[/#if]
//   <o.6>  I2C2_EV_IRQn            [#if enabledIT?contains("I2C2_EV_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"6"/][#else]<0=> Secure state[/#if]
//   <o.7>  I2C2_ER_IRQn            [#if enabledIT?contains("I2C2_ER_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"7"/][#else]<0=> Secure state[/#if]
//   <o.8>  I2C3_EV_IRQn            [#if enabledIT?contains("I2C3_EV_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"8"/][#else]<0=> Secure state[/#if]
//   <o.9>  I2C3_ER_IRQn            [#if enabledIT?contains("I2C3_ER_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"9"/][#else]<0=> Secure state[/#if]
//   <o.10> I2C4_EV_IRQn            [#if enabledIT?contains("I2C4_EV_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"10"/][#else]<0=> Secure state[/#if]
//   <o.11> I2C4_ER_IRQn            [#if enabledIT?contains("I2C4_ER_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"11"/][#else]<0=> Secure state[/#if]
//   <o.12> I3C1_EV_IRQn            [#if enabledIT?contains("I3C1_EV_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"12"/][#else]<0=> Secure state[/#if]
//   <o.13> I3C1_ER_IRQn            [#if enabledIT?contains("I3C1_ER_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"13"/][#else]<0=> Secure state[/#if]
//   <o.14> I3C2_EV_IRQn            [#if enabledIT?contains("I3C2_EV_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"14"/][#else]<0=> Secure state[/#if]
//   <o.15> I3C2_ER_IRQn            [#if enabledIT?contains("I3C2_ER_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"15"/][#else]<0=> Secure state[/#if]
//   <o.16> TIM1_BRK_IRQn           [#if enabledIT?contains("TIM1_BRK_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"16"/][#else]<0=> Secure state[/#if]
//   <o.17> TIM1_UP_IRQn            [#if enabledIT?contains("TIM1_UP_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"17"/][#else]<0=> Secure state[/#if]
//   <o.18> TIM1_TRG_COM_IRQn       [#if enabledIT?contains("TIM1_TRG_COM_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"18"/][#else]<0=> Secure state[/#if]
//   <o.19> TIM1_CC_IRQn            [#if enabledIT?contains("TIM1_CC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"19"/][#else]<0=> Secure state[/#if]
//   <o.20> TIM2_IRQn               [#if enabledIT?contains("TIM2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"20"/][#else]<0=> Secure state[/#if]
//   <o.21> TIM3_IRQn               [#if enabledIT?contains("TIM3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"21"/][#else]<0=> Secure state[/#if]
//   <o.22> TIM4_IRQn               [#if enabledIT?contains("TIM4_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"22"/][#else]<0=> Secure state[/#if]
//   <o.23> TIM5_IRQn               [#if enabledIT?contains("TIM5_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"23"/][#else]<0=> Secure state[/#if]
//   <o.24> TIM6_IRQn               [#if enabledIT?contains("TIM6_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"24"/][#else]<0=> Secure state[/#if]
//   <o.25> TIM7_IRQn               [#if enabledIT?contains("TIM7_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"25"/][#else]<0=> Secure state[/#if]
//   <o.26> TIM8_BRK_IRQn           [#if enabledIT?contains("TIM8_BRK_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"26"/][#else]<0=> Secure state[/#if]
//   <o.27> TIM8_UP_IRQn            [#if enabledIT?contains("TIM8_UP_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"27"/][#else]<0=> Secure state[/#if]
//   <o.28> TIM8_TRG_COM_IRQn       [#if enabledIT?contains("TIM8_TRG_COM_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"28"/][#else]<0=> Secure state[/#if]
//   <o.29> TIM8_CC_IRQn            [#if enabledIT?contains("TIM8_CC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"29"/][#else]<0=> Secure state[/#if]
//   <o.30> TIM9_IRQn               [#if enabledIT?contains("TIM9_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"30"/][#else]<0=> Secure state[/#if]
//   <o.31> TIM10_IRQn              [#if enabledIT?contains("TIM10_IRQn")]<1=> Non-Secure state[#assign nonSecureIT3 = nonSecureIT3+", "+"31"/][#else]<0=> Secure state[/#if]
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

[#assign res3 = String.format("0x%08X" , Integer.valueOf(decVal3)) /]
#define NVIC_INIT_ITNS3_VAL      ${res3}


/*
//   </e>
*/

/*
//   <e>Initialize ITNS 4 (Interrupts 128..159)
*/
#define NVIC_INIT_ITNS4    1
/*
// Interrupts 128..159
//   <o.0>  TIM11_IRQn        [#if enabledIT?contains("TIM11_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"0"/][#else]<0=> Secure state[/#if]
//   <o.1>  TIM12_IRQn        [#if enabledIT?contains("TIM12_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"1"/][#else]<0=> Secure state[/#if]
//   <o.2>  TIM13_IRQn        [#if enabledIT?contains("TIM13_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"2"/][#else]<0=> Secure state[/#if]
//   <o.3>  TIM14_IRQn        [#if enabledIT?contains("TIM14_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"3"/][#else]<0=> Secure state[/#if]
//   <o.4>  TIM15_IRQn        [#if enabledIT?contains("TIM15_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"4"/][#else]<0=> Secure state[/#if]
//   <o.5>  TIM16_IRQn        [#if enabledIT?contains("TIM16_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"5"/][#else]<0=> Secure state[/#if]
//   <o.6>  TIM17_IRQn        [#if enabledIT?contains("TIM17_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"6"/][#else]<0=> Secure state[/#if]
//   <o.7>  TIM18_IRQn        [#if enabledIT?contains("TIM18_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"7"/][#else]<0=> Secure state[/#if]
//   <o.8>  LPTIM1_IRQn       [#if enabledIT?contains("LPTIM1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"8"/][#else]<0=> Secure state[/#if]
//   <o.9>  LPTIM2_IRQn       [#if enabledIT?contains("LPTIM2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"9"/][#else]<0=> Secure state[/#if]
//   <o.10> LPTIM3_IRQn       [#if enabledIT?contains("LPTIM3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"10"/][#else]<0=> Secure state[/#if]
//   <o.11> LPTIM4_IRQn       [#if enabledIT?contains("LPTIM4_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"11"/][#else]<0=> Secure state[/#if]
//   <o.12> LPTIM5_IRQn       [#if enabledIT?contains("LPTIM5_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"12"/][#else]<0=> Secure state[/#if]
//   <o.13> ADF1_FLT0_IRQn    [#if enabledIT?contains("ADF1_FLT0_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"13"/][#else]<0=> Secure state[/#if]
//   <o.14> MDF1_FLT0_IRQn    [#if enabledIT?contains("MDF1_FLT0_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"14"/][#else]<0=> Secure state[/#if]
//   <o.15> MDF1_FLT1_IRQn    [#if enabledIT?contains("MDF1_FLT1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"15"/][#else]<0=> Secure state[/#if]
//   <o.16> MDF1_FLT2_IRQn    [#if enabledIT?contains("MDF1_FLT2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"16"/][#else]<0=> Secure state[/#if]
//   <o.17> MDF1_FLT3_IRQn    [#if enabledIT?contains("MDF1_FLT3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"17"/][#else]<0=> Secure state[/#if]
//   <o.18> MDF1_FLT4_IRQn    [#if enabledIT?contains("MDF1_FLT4_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"18"/][#else]<0=> Secure state[/#if]
//   <o.19> MDF1_FLT5_IRQn    [#if enabledIT?contains("MDF1_FLT5_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"19"/][#else]<0=> Secure state[/#if]
//   <o.20> SAI1_A_IRQn       [#if enabledIT?contains("SAI1_A_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"20"/][#else]<0=> Secure state[/#if]
//   <o.21> SAI1_B_IRQn       [#if enabledIT?contains("SAI1_B_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"21"/][#else]<0=> Secure state[/#if]
//   <o.22> SAI2_A_IRQn       [#if enabledIT?contains("SAI2_A_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"22"/][#else]<0=> Secure state[/#if]
//   <o.23> SAI2_B_IRQn       [#if enabledIT?contains("SAI2_B_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"23"/][#else]<0=> Secure state[/#if]
//   <o.24> SPDIFRX1_IRQn     [#if enabledIT?contains("SPDIFRX1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"24"/][#else]<0=> Secure state[/#if]
//   <o.25> SPI1_IRQn         [#if enabledIT?contains("SPI1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"25"/][#else]<0=> Secure state[/#if]
//   <o.26> SPI2_IRQn         [#if enabledIT?contains("SPI2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"26"/][#else]<0=> Secure state[/#if]
//   <o.27> SPI3_IRQn         [#if enabledIT?contains("SPI3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"27"/][#else]<0=> Secure state[/#if]
//   <o.28> SPI4_IRQn         [#if enabledIT?contains("SPI4_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"28"/][#else]<0=> Secure state[/#if]
//   <o.29> SPI5_IRQn         [#if enabledIT?contains("SPI5_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"29"/][#else]<0=> Secure state[/#if]
//   <o.30> SPI6_IRQn         [#if enabledIT?contains("SPI6_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"30"/][#else]<0=> Secure state[/#if]
//   <o.31> USART1_IRQn       [#if enabledIT?contains("USART1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT4 = nonSecureIT4+", "+"31"/][#else]<0=> Secure state[/#if]
*/

[#assign decVal4 = 0/]
[#if nonSecureIT4??]
[#assign lll4 = nonSecureIT4?split(", ")/]
[#list lll4 as it4]
[#assign index4 = Integer.parseInt(it4)/]
[#if index4!=100]
[#assign decVal4 = decVal4 +  Math.pow(2, index4)]
[/#if]
[/#list]
[/#if]

[#assign res4 = String.format("0x%08X" , Integer.valueOf(decVal4)) /]
#define NVIC_INIT_ITNS4_VAL      ${res4}


/*
//   </e>
*/

/*
//   <e>Initialize ITNS 5 (Interrupts 160..191)
*/
#define NVIC_INIT_ITNS5    1
/*
// Interrupts 160..191
//   <o.0>  USART2_IRQn         [#if enabledIT?contains("USART2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"0"/][#else]<0=> Secure state[/#if]
//   <o.1>  USART3_IRQn         [#if enabledIT?contains("USART3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"1"/][#else]<0=> Secure state[/#if]
//   <o.2>  UART4_IRQn          [#if enabledIT?contains("UART4_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"2"/][#else]<0=> Secure state[/#if]
//   <o.3>  UART5_IRQn          [#if enabledIT?contains("UART5_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"3"/][#else]<0=> Secure state[/#if]
//   <o.4>  USART6_IRQn         [#if enabledIT?contains("USART6_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"4"/][#else]<0=> Secure state[/#if]
//   <o.5>  UART7_IRQn          [#if enabledIT?contains("UART7_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"5"/][#else]<0=> Secure state[/#if]
//   <o.6>  UART8_IRQn          [#if enabledIT?contains("UART8_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"6"/][#else]<0=> Secure state[/#if]
//   <o.7>  UART9_IRQn          [#if enabledIT?contains("UART9_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"7"/][#else]<0=> Secure state[/#if]
//   <o.8>  USART10_IRQn        [#if enabledIT?contains("USART10_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"8"/][#else]<0=> Secure state[/#if]
//   <o.9>  LPUART1_IRQn        [#if enabledIT?contains("LPUART1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"9"/][#else]<0=> Secure state[/#if]
//   <o.10> XSPI1_IRQn          [#if enabledIT?contains("XSPI1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"10"/][#else]<0=> Secure state[/#if]
//   <o.11> XSPI2_IRQn          [#if enabledIT?contains("XSPI2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"11"/][#else]<0=> Secure state[/#if]
//   <o.12> XSPI3_IRQn          [#if enabledIT?contains("XSPI3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"12"/][#else]<0=> Secure state[/#if]
//   <o.13> FMC_IRQn            [#if enabledIT?contains("FMC_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"13"/][#else]<0=> Secure state[/#if]
//   <o.14> SDMMC1_IRQn         [#if enabledIT?contains("SDMMC1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"14"/][#else]<0=> Secure state[/#if]
//   <o.15> SDMMC2_IRQn         [#if enabledIT?contains("SDMMC2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"15"/][#else]<0=> Secure state[/#if]
//   <o.16> UCPD1_IRQn          [#if enabledIT?contains("UCPD1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"16"/][#else]<0=> Secure state[/#if]
//   <o.17> USB1_OTG_HS_IRQn    [#if enabledIT?contains("USB1_OTG_HS_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"17"/][#else]<0=> Secure state[/#if]
//   <o.18> USB2_OTG_HS_IRQn    [#if enabledIT?contains("USB2_OTG_HS_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"18"/][#else]<0=> Secure state[/#if]
//   <o.19> ETH1_IRQn           [#if enabledIT?contains("ETH1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"19"/][#else]<0=> Secure state[/#if]
//   <o.20> FDCAN1_IT0_IRQn     [#if enabledIT?contains("FDCAN1_IT0_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"20"/][#else]<0=> Secure state[/#if]
//   <o.21> FDCAN1_IT1_IRQn     [#if enabledIT?contains("FDCAN1_IT1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"21"/][#else]<0=> Secure state[/#if]
//   <o.22> FDCAN2_IT0_IRQn     [#if enabledIT?contains("FDCAN2_IT0_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"22"/][#else]<0=> Secure state[/#if]
//   <o.23> FDCAN2_IT1_IRQn     [#if enabledIT?contains("FDCAN2_IT1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"23"/][#else]<0=> Secure state[/#if]
//   <o.24> FDCAN3_IT0_IRQn     [#if enabledIT?contains("FDCAN3_IT0_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"24"/][#else]<0=> Secure state[/#if]
//   <o.25> FDCAN3_IT1_IRQn     [#if enabledIT?contains("FDCAN3_IT1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"25"/][#else]<0=> Secure state[/#if]
//   <o.26> FDCAN_CU_IRQn       [#if enabledIT?contains("FDCAN_CU_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"26"/][#else]<0=> Secure state[/#if]
//   <o.27> MDIOS_IRQn          [#if enabledIT?contains("MDIOS_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"27"/][#else]<0=> Secure state[/#if]
//   <o.28> DCMI_PSSI_IRQn      [#if enabledIT?contains("DCMI_PSSI_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"28"/][#else]<0=> Secure state[/#if]
//   <o.29> WAKEUP_PIN_IRQn     [#if enabledIT?contains("WAKEUP_PIN_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"29"/][#else]<0=> Secure state[/#if]
//   <o.30> CTI_INT0_IRQn       [#if enabledIT?contains("CTI_INT0_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"30"/][#else]<0=> Secure state[/#if]
//   <o.31> CTI_INT1_IRQn       [#if enabledIT?contains("CTI_INT1_IRQn")]<1=> Non-Secure state[#assign nonSecureIT5 = nonSecureIT5+", "+"31"/][#else]<0=> Secure state[/#if]
*/

[#assign decVal5 = 0/]
[#if nonSecureIT5??]
[#assign lll5 = nonSecureIT5?split(", ")/]
[#list lll5 as it5]
[#assign index5 = Integer.parseInt(it5)/]
[#if index5!=100]
[#assign decVal5 = decVal5 +  Math.pow(2, index5)]
[/#if]
[/#list]
[/#if]

[#assign res5 = String.format("0x%08X" , Integer.valueOf(decVal5)) /]
#define NVIC_INIT_ITNS5_VAL      ${res5}


/*
//   </e>
*/

/*
//   <e>Initialize ITNS 6 (Interrupts 192..223)
*/
#define NVIC_INIT_ITNS6    1
/*
// Interrupts 192..223
//   <o.0>  USART2_IRQn         [#if enabledIT?contains("USART2_IRQn")]<1=> Non-Secure state[#assign nonSecureIT6 = nonSecureIT6+", "+"0"/][#else]<0=> Secure state[/#if]
//   <o.1>  USART3_IRQn         [#if enabledIT?contains("USART3_IRQn")]<1=> Non-Secure state[#assign nonSecureIT6 = nonSecureIT6+", "+"1"/][#else]<0=> Secure state[/#if]
//   <o.2>  UART4_IRQn          [#if enabledIT?contains("UART4_IRQn")]<1=> Non-Secure state[#assign nonSecureIT6 = nonSecureIT6+", "+"2"/][#else]<0=> Secure state[/#if]

[#assign decVal6 = 0/]
[#if nonSecureIT6??]
[#assign lll6 = nonSecureIT6?split(", ")/]
[#list lll6 as it6]
[#assign index6 = Integer.parseInt(it6)/]
[#if index6!=100]
[#assign decVal6 = decVal6 +  Math.pow(2, index6)]
[/#if]
[/#list]
[/#if]
*/
[#assign res6 = String.format("0x%08X" , Integer.valueOf(decVal6)) /]
#define NVIC_INIT_ITNS6_VAL      ${res6}

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

  #if defined (NVIC_INIT_ITNS4) && (NVIC_INIT_ITNS4 == 1U)
    NVIC->ITNS[4] = NVIC_INIT_ITNS4_VAL;
  #endif

  #if defined (NVIC_INIT_ITNS5) && (NVIC_INIT_ITNS5 == 1U)
    NVIC->ITNS[5] = NVIC_INIT_ITNS5_VAL;
  #endif

  #if defined (NVIC_INIT_ITNS6) && (NVIC_INIT_ITNS6 == 1U)
    NVIC->ITNS[6] = NVIC_INIT_ITNS6_VAL;
  #endif

}
/* USER CODE END 2 */
[#if McuName?starts_with("STM32N64")]
#endif  /* PARTITION_STM32N647XX_H */
[#else]
#endif  /* PARTITION_STM32N657XX_H */
[/#if]
