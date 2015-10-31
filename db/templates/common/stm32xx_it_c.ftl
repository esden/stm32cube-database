[#ftl]
/**
  ******************************************************************************
  * @file    ${FamilyName?lower_case}xx_it.c
  * @date    ${date}
  * @brief   Interrupt Service Routines.
  ******************************************************************************
  *
  * COPYRIGHT(c) ${year} STMicroelectronics
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  *   1. Redistributions of source code must retain the above copyright notice,
  *      this list of conditions and the following disclaimer.
  *   2. Redistributions in binary form must reproduce the above copyright notice,
  *      this list of conditions and the following disclaimer in the documentation
  *      and/or other materials provided with the distribution.
  *   3. Neither the name of STMicroelectronics nor the names of its contributors
  *      may be used to endorse or promote products derived from this software
  *      without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
  * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
  * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */
[#compress]
/* Includes ------------------------------------------------------------------*/
[#--#include "stm32f4xx_it.h"   --]
#include "${FamilyName?lower_case}xx_hal.h"
#include "${FamilyName?lower_case}xx.h"
#include "${FamilyName?lower_case}xx_it.h"
[#if FREERTOS??] [#-- If FreeRtos is used --]
#include "cmsis_os.h"
[/#if]
[/#compress]
[#assign CortexName = "Cortex"]
[#if FamilyName=="STM32F4" || FamilyName=="STM32F3"]
  [#assign CortexName = "Cortex-M4"]
[#elseif FamilyName=="STM32F2" || FamilyName=="STM32L1"]
  [#assign CortexName = "Cortex-M3"]
[#elseif FamilyName=="STM32F0"]
  [#assign CortexName = "Cortex-M0"]
[#elseif FamilyName=="STM32L0"]
  [#assign CortexName = "Cortex-M0+"]
[/#if]

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */
/* External variables --------------------------------------------------------*/
[#if FREERTOS??] [#-- If FreeRtos is used --]
extern void xPortSysTickHandler(void);
[/#if]


[#compress]
[#assign handlerList = ""]
[#list handlers as handler]
  [#list handler.entrySet() as entry]
    [#list entry.value as ipHandler]
        [#if ipHandler.useNvic && !(handlerList?contains("("+ipHandler.handler+")"))]
extern ${ipHandler.handlerType} ${ipHandler.handler};
        [/#if]
[#assign handlerList = handlerList + " "+ "("+ipHandler.handler+")"]
    [/#list]
[/#list]
[/#list]
#n
[#assign handlerList = ""]
[/#compress]
/******************************************************************************/
/*            ${CortexName} Processor Interruption and Exception Handlers         */ 
/******************************************************************************/

[#compress]

[#list nvic as vector]
/**
  * @brief  This function handles ${vector.comment}.  
  */
void ${vector.irqHandler}(void)
{
#t/* USER CODE BEGIN ${vector.name} 0 */

#n#t/* USER CODE END ${vector.name} 0 */
[#if vector.name=="RCC_IRQn" || vector.name=="RCC_CRS_IRQn"]
  #tHAL_NVIC_ClearPendingIRQ(${vector.name});
  [#-- #t/* USER CODE BEGIN 0 */#n --]
  [#-- #t/* USER CODE END 0 */ --]
[#elseif vector.ipName!="" && vector.name!="ADC_IRQn" && vector.name!="SAI1_IRQn" && vector.name!="DMA1_Stream0_IRQn" && vector.name!="DMA1_Stream1_IRQn" && vector.name!="DMA1_Stream2_IRQn" && vector.name!="DMA1_Stream3_IRQn" && vector.name!="DMA1_Stream4_IRQn" && vector.name!="DMA1_Stream5_IRQn" && vector.name!="DMA1_Stream6_IRQn" && vector.name!="DMA1_Stream7_IRQn" && vector.name!="DMA2_Stream0_IRQn" && vector.name!="DMA2_Stream1_IRQn" && vector.name!="DMA2_Stream2_IRQn" && vector.name!="DMA2_Stream3_IRQn" && vector.name!="DMA2_Stream4_IRQn" && vector.name!="DMA2_Stream5_IRQn" && vector.name!="DMA2_Stream6_IRQn" && vector.name!="DMA2_Stream7_IRQn" && vector.name!="FSMC_IRQn" && vector.name!="FMC_IRQn" && vector.name!="HASH_RNG_IRQn" && vector.name!="NonMaskableInt_IRQn" && vector.name!="EXTI0_IRQn" && vector.name!="EXTI1_IRQn" && vector.name!="EXTI2_IRQn" && vector.name!="EXTI3_IRQn" && vector.name!="EXTI4_IRQn" && vector.name!="EXTI9_5_IRQn" && vector.name!="EXTI15_10_IRQn" && vector.name!="SDIO_IRQn" && vector.name!="FLASH_IRQn" && vector.name!="TIM6_DAC_IRQn" && vector.name!= "TIM1_UP_TIM10_IRQn" && vector.name!= "TIM1_BRK_TIM9_IRQn" && vector.name!= "TIM1_TRG_COM_TIM11_IRQn" && vector.name!= "TIM8_UP_TIM13_IRQn" && vector.name!= "TIM8_BRK_TIM12_IRQn" && vector.name!= "TIM8_TRG_COM_TIM14_IRQn" && vector.name!= "I2C1_IRQn" && vector.name!= "I2C2_IRQn" && vector.name!= "ADC1_COMP_IRQn" && vector.name!="EXTI4_15_IRQn" && vector.name!="EXTI0_1_IRQn" && vector.name!="EXTI2_3_IRQn"  && vector.name!="AES_RNG_LPUART1_IRQn" && vector.name!= "DMA1_Channel2_3_IRQn" && vector.name!= "DMA1_Channel1_IRQn" && vector.name!= "DMA1_Channel4_5_IRQn" && vector.name!= "DMA1_Channel4_5_6_7_IRQn" && vector.name!="RTC_IRQn" && vector.name!="TIM18_DAC2_IRQn" && vector.name!="TIM6_DAC1_IRQn" && vector.name!="EXTI2_TSC_IRQn" && vector.name!="ADC1_2_IRQn" && vector.name!="TIM1_BRK_TIM15_IRQn" && vector.name!="TIM1_UP_TIM16_IRQn" && vector.name!="TIM1_TRG_COM_TIM17_IRQn" && vector.name!="COMP4_6_IRQn" && vector.name!="COMP1_2_3_IRQn" && vector.name!="COMP4_5_6_IRQn" && vector.name!="DMA2_Channel1_IRQn" && vector.name!="DMA2_Channel2_IRQn" && vector.name!="DMA2_Channel3_IRQn" && vector.name!="DMA2_Channel4_IRQn" && vector.name!="DMA2_Channel5_IRQn" && vector.name!="DMA1_Channel1_IRQn" && vector.name!="DMA1_Channel2_IRQn" && vector.name!="DMA1_Channel3_IRQn" && vector.name!="DMA1_Channel4_IRQn" && vector.name!="DMA1_Channel5_IRQn" && vector.name!="DMA1_Channel6_IRQn" && vector.name!="DMA1_Channel7_IRQn" && vector.name!="TIM7_DAC2_IRQn" && vector.name!="I2C1_EV_IRQn" && vector.name!="I2C1_ER_IRQn" && vector.name!="I2C2_EV_IRQn" && vector.name!="I2C2_ER_IRQn" && vector.name!="I2C3_EV_IRQn" && vector.name!="I2C3_ER_IRQn" && vector.name!="USB_HP_CAN_TX_IRQn" && vector.name!="USB_LP_CAN_RX0_IRQn" && vector.name!="DMA_CH1_IRQn" && vector.name!="DMA_CH2_3_IRQn" && vector.name!="DMA_CH4_5_6_7_IRQn" && vector.name!="CEC_CAN_IRQn" && vector.name!="ADC_COMP_IRQn" && vector.name!="USART3_4_IRQn" && vector.name!="HRTIM1_Master_IRQn" && vector.name!="HRTIM1_TIMA_IRQn" && vector.name!="HRTIM1_TIMB_IRQn" && vector.name!="HRTIM1_TIMC_IRQn" && vector.name!="HRTIM1_TIMD_IRQn" && vector.name!="HRTIM1_TIME_IRQn" && vector.name!="HRTIM1_FLT_IRQn" && vector.name!="DMA1_Ch1_IRQn" && vector.name!="DMA1_Ch2_3_DMA2_Ch1_2_IRQn" && vector.name!="DMA1_Ch4_7_DMA2_Ch3_5_IRQn" && vector.name!="USART3_8_IRQn" && vector.name!="COMP_IRQn" && vector.name!="COMP_ACQ_IRQn"]
  #tHAL_NVIC_ClearPendingIRQ(${vector.name});
  [#if vector.halHandler != "" && vector.halHandler != "NONE"]
    [#if vector.ipHandler != ""]
      #t${vector.halHandler}(&${vector.ipHandler});
    [#else]
      #t${vector.halHandler}();
    [/#if]
  [/#if]
[#else]
      #t${vector.halHandler}
[/#if]
#t/* USER CODE BEGIN ${vector.name} 1 */

#n#t/* USER CODE END ${vector.name} 1 */
}#n
[/#list]
[/#compress]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/