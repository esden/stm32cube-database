[#ftl]
[#assign contextFolder=""]
[#if cpucore!=""]    
[#assign contextFolder = cpucore?replace("ARM_CORTEX_","C")+"/"]
[/#if]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${FamilyName?lower_case}xx_it.c
  * @brief   Interrupt Service Routines.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
#n
[#compress]
/* Includes ------------------------------------------------------------------*/
#include "${main_h}"
#include "${FamilyName?lower_case}xx_it.h"
[#if FREERTOS?? && (Secure == "false" || Secure == "-1")] [#-- If FreeRtos is used --]
[#-- [@common.optinclude name=contextFolder+mxTmpFolder+"/rtos_inc.tmp"/] --] [#--include freertos includes --]
[#-- cf BZ 64089 --]
#include "FreeRTOS.h"
#include "task.h"
[/#if]
[#if TOUCHSENSING??] [#-- If TouchSensing is used --]
#include "tsl_time.h"
[/#if]
/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */
[#assign noUsbWakeUpInterruptHalHandler = missingUsbWakeUpInterruptHalHandler()]
[#if noUsbWakeUpInterruptHalHandler]
  [#assign requireSystemClockConfig = false]
  [#list nvic as vector] [#-- nvic is a list of NvicVector, given by the code generator --]
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
[#if FamilyName=="STM32F7"]  [#-- FamilyName is in reality series name --]
  [#assign CortexName = "Cortex-M7"]
[#elseif FamilyName=="STM32F4" || FamilyName=="STM32F3" || FamilyName=="STM32L4" || FamilyName=="STM32G4" ||  FamilyName=="STM32MP1" ]
  [#assign CortexName = "Cortex-M4"]
[#elseif FamilyName=="STM32F1" || FamilyName=="STM32F2" || FamilyName=="STM32L1"]
  [#assign CortexName = "Cortex-M3"]
[#elseif FamilyName=="STM32F0"]
  [#assign CortexName = "Cortex-M0"]
[#elseif FamilyName=="STM32L0" ||  FamilyName=="STM32G0" ]
  [#assign CortexName = "Cortex-M0+"]
[/#if]

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN TD */

/* USER CODE END TD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */
 
/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */


/* External variables --------------------------------------------------------*/
[#compress]
[#assign handleList = ""]
[#list handlers as handler] [#-- handlers is a list of ipHandlers (hashmap)  --] 
  [#list handler.entrySet() as entry]  [#-- handler is a set of handles --]
    [#list entry.value as ipHandler]  [#-- entry.value is a list of IpHandler --] 
        [#if ipHandler.useNvic && ipHandler.declareExtenalVariable && !(handleList?contains("(" + ipHandler.handler + ")")) && ipHandler.handlerType!="DFSDM_Channel_HandleTypeDef"]
[#if !context?? || (context?? && context==ipHandler.contextName)]
extern ${ipHandler.handlerType} ${ipHandler.handler};
[#assign handleList = handleList + "(" + ipHandler.handler + ")"]
[/#if]
        [/#if]
        
    [/#list]
  [/#list]
[/#list]
[#list services as service]
  [#if service.bspExtihandles??]
    [#list service.bspExtihandles as ipHandle]
extern ${ipHandle.type} ${ipHandle.name};
    [/#list]
  [/#if]
[/#list]
[#-- If Time Base Source is different to Systick--]
[#if cpucore!="" && cpucore?replace("ARM_CORTEX_","")=="M4"]
    [#if  timeBaseSource_M4??]
        [#assign timeBaseSource = timeBaseSource_M4]
        [#assign timeBaseHandlerType = timeBaseHandlerType_M4]
        [#assign timeBaseHandler = timeBaseHandler_M4]
    [/#if]
[/#if]
[#if cpucore!="" &&cpucore?replace("ARM_CORTEX_","")=="M7"]
    [#if  timeBaseSource_M7??]
        [#assign timeBaseSource = timeBaseSource_M7]
        [#assign timeBaseHandlerType = timeBaseHandlerType_M7]
        [#assign timeBaseHandler = timeBaseHandler_M7]
    [/#if]
[/#if]
[#if timeBaseSource?? && timeBaseSource!="SysTick" && timeBaseSource!="None"]
extern ${timeBaseHandlerType} ${timeBaseHandler};
#n
[/#if]


[/#compress]

/* USER CODE BEGIN EV */

/* USER CODE END EV */

/******************************************************************************/
/*           ${CortexName} Processor Interruption and Exception Handlers          */ 
/******************************************************************************/
[#compress]
[#list nvic as vector]
[#if vector.systemHandler && vector.irqHandlerGenerated]
/**
#t* @brief  This function handles ${vector.comment}.   
#t*/
void ${vector.irqHandler}(void)
{
#t/* USER CODE BEGIN ${vector.name} 0 */

#n#t/* USER CODE END ${vector.name} 0 */
[#if vector.halHandler != "NONE" && vector.halHandlerNeeded || vector.operation == "W1"] [#-- "&& timeBaseSource!="None"" is handled in NvicVector.java --]
      #t${vector.halHandler}
[/#if]
[#--[#if vector.name != "HardFault_IRQn"]--]
[#--[#if vector.name != "MemoryManagement_IRQn"]--]
[#--[#if vector.name != "BusFault_IRQn"]--]
[#--[#if vector.name != "UsageFault_IRQn"] --]
[#if vector.operation != "W1"]
#t/* USER CODE BEGIN ${vector.name} 1 */

#n#t/* USER CODE END ${vector.name} 1 */
[#--[/#if]--]
[#--[/#if]--]
[#--[/#if]--]
[/#if]
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

[#if vector?? && !vector.systemHandler && vector.irqHandlerGenerated]
/**
#t* @brief  This function handles ${vector.comment}.  
#t*/
void ${vector.irqHandler}(void)
{
#t/* USER CODE BEGIN ${vector.name} 0 */

#n#t/* USER CODE END ${vector.name} 0 */

[#if vector.halHandler?? && (vector.halHandler == "NONE" || !vector.halHandlerNeeded)]
[#elseif vector.ipName=="" || vector.irregular=="true"]
  #t${vector.halHandler}
[#elseif vector.name=="FMC_IRQn" || vector.name=="FSMC_IRQn" || vector.name=="HASH_RNG_IRQn" || vector.name=="TIM6_DAC_IRQn"]
  #t${vector.halHandler}
[#elseif vector.ipHandle != "" && vector.halUsed]
  #t${vector.halHandler}[#if timeBaseSource==vector.ipName && FamilyName=="STM32MP1"][#else](&${vector.ipHandle});[/#if]
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
