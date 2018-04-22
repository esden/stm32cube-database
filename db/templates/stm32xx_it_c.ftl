[#ftl]
/**
  ******************************************************************************
  * @file    ${FamilyName?lower_case}xx_it.c
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
[#if isHalSupported?? && isHALUsed??]
#include "${FamilyName?lower_case}xx_hal.h"
[/#if]
#include "${FamilyName?lower_case}xx.h"
#include "${FamilyName?lower_case}xx_it.h"
[#if FREERTOS??] [#-- If FreeRtos is used --]
#include "cmsis_os.h"
[/#if]

[#assign noUsbWakeUpInterruptHalHandler = missingUsbWakeUpInterruptHalHandler()]
[#if noUsbWakeUpInterruptHalHandler]
  [#assign requireSystemClockConfig = false]
  [#list nvic as vector]
    [#assign requireSystemClockConfig = usbWakeUpVector(vector.name)]
    [#if requireSystemClockConfig]
      [#break]
    [/#if]
  [/#list]
  [#if requireSystemClockConfig]
#n
/* External functions --------------------------------------------------------*/
void SystemClock_Config(void);
  [/#if]
[/#if]
[/#compress]

[#assign CortexName = "Cortex"]
[#if FamilyName=="STM32F7"]
  [#assign CortexName = "Cortex-M7"]
[#elseif FamilyName=="STM32F4" || FamilyName=="STM32F3" || FamilyName=="STM32L4"]
  [#assign CortexName = "Cortex-M4"]
[#elseif FamilyName=="STM32F1" || FamilyName=="STM32F2" || FamilyName=="STM32L1"]
  [#assign CortexName = "Cortex-M3"]
[#elseif FamilyName=="STM32F0"]
  [#assign CortexName = "Cortex-M0"]
[#elseif FamilyName=="STM32L0"]
  [#assign CortexName = "Cortex-M0+"]
[/#if]

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

[#compress]
/* External variables --------------------------------------------------------*/
[#assign handleList = ""]
[#list handlers as handler]
  [#list handler.entrySet() as entry]
    [#list entry.value as ipHandler]
        [#if ipHandler.useNvic && !(handleList?contains("(" + ipHandler.handler + ")")) && ipHandler.handlerType!="DFSDM_Channel_HandleTypeDef"]
extern ${ipHandler.handlerType} ${ipHandler.handler};
        [/#if]
        [#assign handleList = handleList + "(" + ipHandler.handler + ")"]
    [/#list]
  [/#list]
[/#list]
#n
[#-- If Time Base Source is different to Systick--]
[#if timeBaseSource?? && timeBaseSource!="SysTick"]
extern ${timeBaseHandlerType} ${timeBaseHandler};
#n
[/#if]
[#if USE_Embedded_Wizard_STACK??]
extern void GRAPHICS_IncTick(void);
#n
[/#if]
[#if !FREERTOS?? && (USE_STemWin_STACK??||USE_Touch_GFX_STACK??)]
extern void GRAPHICS_IncTick(void);
#n
[/#if]
[/#compress]
/******************************************************************************/
/*            ${CortexName} Processor Interruption and Exception Handlers         */ 
/******************************************************************************/

[#compress]
[#list nvic as vector]
[#if vector.systemHandler && vector.irqHandlerGenerated]
/**
  * @brief  This function handles ${vector.comment}.  
  */
void ${vector.irqHandler}(void)
{
#t/* USER CODE BEGIN ${vector.name} 0 */

#n#t/* USER CODE END ${vector.name} 0 */
[#if vector.halHandler != "NONE"]
      #t${vector.halHandler}
[/#if]
#t/* USER CODE BEGIN ${vector.name} 1 */

#n#t/* USER CODE END ${vector.name} 1 */
}#n
[/#if]
[/#list]
[/#compress]

[#macro usbWakeupClearFlagMacro vectorName]
  [#if FamilyName=="STM32F1"]
    [#if vectorName=="OTG_FS_WKUP_IRQn"]
      __HAL_USB_OTG_FS_WAKEUP_EXTI_CLEAR_FLAG();
    [#elseif vectorName=="USBWakeUp_IRQn"]
      __HAL_USB_WAKEUP_EXTI_CLEAR_FLAG();
    [/#if]
  [/#if]
  [#if FamilyName=="STM32F2" || FamilyName=="STM32F4"]
    [#if vectorName=="OTG_FS_WKUP_IRQn"]
      __HAL_USB_OTG_FS_WAKEUP_EXTI_CLEAR_FLAG();
    [#elseif vectorName=="OTG_HS_WKUP_IRQn"]
      __HAL_USB_OTG_HS_WAKEUP_EXTI_CLEAR_FLAG();
    [/#if]
  [/#if]
  [#if FamilyName=="STM32F3"]
    [#if vectorName=="USBWakeUp_IRQn" || vectorName=="USBWakeUp_RMP_IRQn"]
      __HAL_USB_WAKEUP_EXTI_CLEAR_FLAG();
    [/#if]
  [/#if]
  [#if FamilyName=="STM32L1"]
    [#if vectorName=="USB_FS_WKUP_IRQn"]
      __HAL_USB_WAKEUP_EXTI_CLEAR_FLAG();
    [/#if]
  [/#if]
[/#macro]

[#function usbWakeUpVector(vectorName)]
  [#if (vectorName?contains("USB") || vectorName?contains("OTG_FS") || vectorName?contains("OTG_HS")) && (vectorName?contains("WKUP") || vectorName?contains("WakeUp"))]
    [#return true]
  [#else]
    [#return false]
  [/#if]
[/#function]

[#function missingUsbWakeUpInterruptHalHandler()]
  [#switch (FamilyName)]
    [#case "STM32F1"]
    [#case "STM32F2"]
    [#case "STM32F3"]
    [#case "STM32F4"]
    [#case "STM32F7"]
    [#case "STM32L1"]
      [#return true]
  [/#switch]
  [#return false]
[/#function]

/******************************************************************************/
/* ${FamilyName}xx Peripheral Interrupt Handlers                                    */
/* Add here the Interrupt Handlers for the used peripherals.                  */
/* For the available peripheral interrupt handler names,                      */
/* please refer to the startup file (startup_${FamilyName?lower_case}xx.s).                    */
/******************************************************************************/

[#compress]

[#list nvic as vector]

[#if !vector.systemHandler && vector.irqHandlerGenerated]
/**
  * @brief  This function handles ${vector.comment}.  
  */
void ${vector.irqHandler}(void)
{
#t/* USER CODE BEGIN ${vector.name} 0 */

#n#t/* USER CODE END ${vector.name} 0 */

[#if vector.halHandler == "NONE"]
[#elseif vector.ipName=="" || vector.irregular=="true"]
  #t${vector.halHandler}
[#elseif vector.name=="FMC_IRQn" || vector.name=="FSMC_IRQn" || vector.name=="HASH_RNG_IRQn" || vector.name=="TIM6_DAC_IRQn"]
  #t${vector.halHandler}
[#elseif vector.ipHandle != "" && vector.halUsed]
  #t${vector.halHandler}(&${vector.ipHandle});
[#elseif vector.halUsed]
  #t${vector.halHandler}();
[/#if]

#t/* USER CODE BEGIN ${vector.name} 1 */

#n#t/* USER CODE END ${vector.name} 1 */
}#n
[/#if]
[/#list]
[/#compress]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
