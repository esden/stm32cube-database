[#ftl]
/**
  ******************************************************************************
  * File Name          : main.c
  * Description        : Main program body
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
[#assign usb_device = false]
/* Includes ------------------------------------------------------------------*/
[#if isHalSupported??]
#include "${FamilyName?lower_case}xx_hal.h"
[/#if]
[@common.optinclude name="Src/rtos_inc.tmp"/][#--include freertos includes --]
[#-- if !HALCompliant??--][#-- if HALCompliant Begin --]
[#list ips as ip]
[#if !ip?contains("FREERTOS") && !ip?contains("NVIC")&& !ip?contains("CORTEX")]
#include "${ip?lower_case}.h"
[/#if]
[#if ip?contains("USB_DEVICE")]
[#assign usb_device = true]
[/#if]
[/#list]
[#-- /#if --]
[/#compress]
#n
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */
#n
[#if usb_device]
  [#if vectors??]
    [#assign wakeupInterrupt = false]
    [#list vectors as vector]
      [#if (vector.vector?contains("OTG_FS") || vector.vector?contains("OTG_HS") || vector.vector?contains("USB")) && (vector.vector?contains("WKUP") || vector.vector?contains("WakeUp"))]
        [#if !wakeupInterrupt]
/* External variables --------------------------------------------------------*/
        [/#if]
        [#assign wakeupInterrupt = true]
        [#assign handleName = getHandleName(vector.vector)]
extern PCD_HandleTypeDef ${handleName};
      [/#if]
    [/#list]
    [#if wakeupInterrupt]
#n
    [/#if]
  [/#if]
[/#if]
/* Private variables ---------------------------------------------------------*/
[#-- If HAL compliant generate Global variable : Peripherals handler -Begin --]
[#if HALCompliant??][#-- if HALCompliant Begin --]
[#compress]
    [#list Peripherals as Peripheral]
        [#if Peripheral??]                
            [#list Peripheral as periph]
                [#-- Global variables --]
                [#if periph.variables??]
                    [#list periph.variables as variable]
${variable.value} ${variable.name};
                    [/#list]
                [/#if][#--if periph.variables??--]
                [#-- Add global dma Handler --]
                [#list periph.configModelList as instanceData]
                    [#if instanceData.dmaHandel??]
                        [#list instanceData.dmaHandel as dHandle]
${dHandle};
                        [/#list]
                    [/#if]
                [/#list]                
            [/#list]#n
        [/#if][#--if Peripheral??--]
    [/#list]
[/#compress]
    [#compress]
    [#-- DMA global variables --]
    [#-- ADD DMA Code Begin--]
    [@common.optinclude name="Src/DMA_GV.tmp"/]
    [#-- ADD DMA Code End--]
    [#-- FMCGlobal variables --]
    [#-- Add FMC Code Begin--]
    [@common.optinclude name="Src/mx_fmc_GV.tmp"/]
    [#--ADD FMC Code End--]
    [#-- Add FSMC Code Begin--]
    [@common.optinclude name="Src/mx_fsmc_GV.tmp"/]
    [#--ADD FSMC Code End--] 
    [#-- RTOS variables --]
    [#-- ADD RTOS Code Begin--]
    [@common.optinclude name="Src/rtos_vars.tmp"/]   
    [#-- ADD RTOS Code End--]
    [/#compress]
[/#if][#-- if HALCompliant End --] 
[#if HALCompliant??]
  [#-- CEC array --]
  [#compress]
  [#list Peripherals as Peripheral]
    [#if Peripheral??]
      [#list Peripheral as IP]
[@common.generateCecRxBuffer configModelList=IP.configModelList methodName="HAL_CEC_Init" argumentName="RxBuffer" bufferType="uint8_t" bufferSize="16"/]
      [/#list]
    [/#if]
  [/#list]
  [/#compress]
[/#if]
    [#-- Global variables --]
[#-- If HAL compliant generate Global variable : Peripherals handler -End --]
#n#n

/* USER CODE BEGIN PV */
/* Private variables ---------------------------------------------------------*/

/* USER CODE END PV */
#n
[#compress]
[#if clockConfig??]
/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void); [#-- remove static --]
void Error_Handler(void);
[/#if]
[#if mpuControl??] [#-- if MPU config is enabled --]
static void MPU_Config(void); 
[/#if]    

[#-- modif for freeRtos 21 Augst 2014 --]
[#if FREERTOS??]
 [#if !HALCompliant??]           [#-- modif for freeRtos 24th Nov. 2014 --]
 void MX_FREERTOS_Init(void); 
 [/#if]
[/#if]
[#if HALCompliant??] 
 [#list voids as void]
  [#if !void.functionName?contains("FREERTOS")&&!void.functionName?contains("FATFS")&& !void.functionName?contains("LWIP")&& !void.functionName?contains("USB_DEVICE")&& !void.functionName?contains("USB_HOST")&& !void.functionName?contains("CORTEX")] 
[#if !void.isNotGenerated]
static void ${""?right_pad(2)}${void.functionName}(void);
  [/#if]
  [/#if]
 [/#list]
 [@common.optinclude name="Src/rtos_pfp.tmp"/]
[/#if]
[#if vectors??]
static void MX_NVIC_Init(void);
[/#if]
[/#compress]
[#if USB_HOST?? && !FREERTOS??]
#nvoid MX_USB_HOST_Process(void);
[/#if]
[#-- PostInit declaration --]
[#if Peripherals??]
[#assign postinitList = ""]
[#list Peripherals as Peripheral]
[#if Peripheral??]
[#list Peripheral as IP]
[#list IP.configModelList as instanceData]
[#if instanceData.initServices??]
    [#if instanceData.initServices.gpioOut??] 
        [#list instanceData.initCallBackInitMethodList as initCallBack]
            [#if initCallBack?contains("PostInit")]
                [#assign halMode = instanceData.halMode]
                [#assign ipName = instanceData.ipName]
                [#assign ipInstance = instanceData.instanceName]
                [#if halMode!=ipName&&!ipName?contains("TIM")&&!ipName?contains("CEC")]
[#if !postinitList?contains(initCallBack)]
                    #nvoid ${initCallBack}(${instanceData.halMode}_HandleTypeDef *h${instanceData.halMode?lower_case});
                     [#assign postinitList = postinitList+" "+initCallBack]
[/#if]
                [#else]
[#if !postinitList?contains(initCallBack)]
                    #nvoid ${initCallBack}([#if ipName?contains("TIM")&&!(ipName?contains("HRTIM")||ipName?contains("LPTIM"))]TIM_HandleTypeDef *htim[#else]${ipName}_HandleTypeDef *h${ipName?lower_case}[/#if]);
        [#assign postinitList = postinitList+" "+initCallBack]
[/#if]
                [/#if]
                [#break] [#-- take only the first PostInit : case of timer--]
            [/#if]

        [/#list]
    [/#if]
[/#if]

[/#list]
[/#list]
[/#if]
[/#list]
[/#if]

[#-- PostInit declaration : End --]
#n
/* USER CODE BEGIN PFP */
/* Private function prototypes -----------------------------------------------*/

/* USER CODE END PFP */
#n
#n
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */
#n
int main(void)
{
#n
#t/* USER CODE BEGIN 1 */

#t/* USER CODE END 1 */
#n
[#compress]
[#if mpuControl??] [#-- if MPU config is enabled --]
#t/* MPU Configuration----------------------------------------------------------*/
    #tMPU_Config();
[/#if]
[#if ICache??] [#-- if CPU ICache is enabled --]
#n#t/* Enable I-Cache-------------------------------------------------------------*/
    #tSCB_EnableICache();
[/#if]
[#if DCache??] [#-- if CPU DCache config is enabled --]
#n#t/* Enable D-Cache-------------------------------------------------------------*/
    #tSCB_EnableDCache();
[/#if]
#n
#t/* MCU Configuration----------------------------------------------------------*/
[#if clockConfig??]
#n#t/* Reset of all peripherals, Initializes the Flash interface and the Systick. */
#tHAL_Init();
#n#t/* Configure the system clock */
#tSystemClock_Config();
[/#if]
#n#t/* Initialize all configured peripherals */
[#list voids as void]
[#if !void.functionName?contains("FREERTOS")&&!void.functionName?contains("CORTEX")]
[#if !void.isNotGenerated]
[#if (FREERTOS?? && void.ipType=="peripheral") || !FREERTOS??]
#t${void.functionName}();
[/#if]
[/#if]
[/#if]
[/#list]
[#if vectors??]
#n
#t/* Initialize interrupts */
#tMX_NVIC_Init();
[/#if]
[/#compress]
#n
#t/* USER CODE BEGIN 2 */

#t/* USER CODE END 2 */
#n
[#if FREERTOS??] [#-- If FreeRtos is used --]
  [#if HALCompliant??]
  [@common.optinclude name="Src/rtos_HalInit.tmp"/] [#-- include generated tmp file22 Augst 2014 --]
  [#else]
  /* Call init function for freertos objects (in freertos.c) */
  MX_FREERTOS_Init();
  [/#if]

  [@common.optinclude name="Src/rtos_start.tmp"/] [#-- include generated tmp file 13 Nov 2014 --] 
  /* We should never get here as control is now taken by the scheduler */
[/#if]

[#-- if !FREERTOS?? --] 
#n

#t/* Infinite loop */
#t/* USER CODE BEGIN WHILE */
#twhile (1)
#t{
#t/* USER CODE END WHILE */
[#if USB_HOST?? && !FREERTOS??]
#t#tMX_USB_HOST_Process();
[/#if]
#n
#t/* USER CODE BEGIN 3 */

#t}
#t/* USER CODE END 3 */

#n
[#-- if --]


}
[#compress]
[#if clockConfig??]
#n/** System Clock Configuration
 */
void SystemClock_Config(void)
{
#n
[#compress]
[#assign listOfLocalVariables =""]
        [#assign resultList =""]
    [#list clockConfig as configModel] [#--list0--]
        [#list configModel.configs as config] [#--list1--]
           [#compress] [@common.getLocalVariable configModel1=config listOfLocalVariables=listOfLocalVariables resultList=resultList/][/#compress]
            [#assign listOfLocalVariables =resultList]
        [/#list]
    [/#list]
[/#compress]#n
[#assign clockInst=""]
[#assign nTab=1]
[#if clockConfig??] 
[#list clockConfig as configModel] [#--list0--]
    [#--list configModel.configs as config--] [#--list1--]
   [#compress] [@common.generateConfigModelCode configModel=configModel inst=clockInst  nTab=1 index=""/][/#compress]#n
    [#--/#list--]
[/#list][/#if]
[#-- configure systick interrupts  --]
[#if systemVectors??]
[#list systemVectors as initVector] 
[#if initVector.vector=="SysTick_IRQn" && initVector.codeInMspInit]
#t/* ${initVector.vector} interrupt configuration */
#tHAL_NVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority}, ${initVector.subPriority});
[#if initVector.systemHandler=="false"]
  #tHAL_NVIC_EnableIRQ(${initVector.vector});#n
[/#if]
[/#if]
[/#list]
[/#if]
}[/#if]
#n

[/#compress]

[#compress]
[#if vectors??]
#n/** NVIC Configuration
 */
static void MX_NVIC_Init(void)
{
[#list vectors as vector]
  #t/* ${vector.vector} interrupt configuration */
  [#if (vector.vector?contains("OTG_FS") || vector.vector?contains("OTG_HS") || vector.vector?contains("USB")) && (vector.vector?contains("WKUP") || vector.vector?contains("WakeUp"))]
    [#assign handleName = getHandleName(vector.vector)]
    [#assign ipName = getIpName(vector.vector)]
    #tif (${handleName}.Init.low_power_enable == 1)
    #t{
    [@common.generateUsbWakeUpInterrupt ipName=ipName tabN=2/]
    #t#tHAL_NVIC_SetPriority(${vector.vector}, ${vector.preemptionPriority}, ${vector.subPriority});
    #t#tHAL_NVIC_EnableIRQ(${vector.vector});
    #t}
  [#else]
    #tHAL_NVIC_SetPriority(${vector.vector}, ${vector.preemptionPriority}, ${vector.subPriority});
    [#if vector.systemHandler=="false"]
      #tHAL_NVIC_EnableIRQ(${vector.vector});
    [/#if]
  [/#if]
[/#list]
}
#n
[/#if]
[/#compress]

[#function getIpName(vectorName)]
    [#if vectorName?starts_with("OTG_FS")]
        [#return "USB_OTG_FS"]
    [#elseif vectorName?starts_with("OTG_HS")]
        [#return "USB_OTG_HS"]
    [#elseif vectorName?starts_with("USB")]
        [#return "USB"]
    [/#if]
    [#return ""]
[/#function]

[#function getHandleName(vectorName)]
    [#if vectorName?starts_with("OTG_FS")]
        [#return "hpcd_USB_OTG_FS"]
    [#elseif vectorName?starts_with("OTG_HS")]
        [#return "hpcd_USB_OTG_HS"]
    [#elseif vectorName?starts_with("USB")]
        [#return "hpcd_USB_FS"]
    [/#if]
    [#return ""]
[/#function]

[#if HALCompliant??][#-- if HALCompliant Begin --]
#n[#list Peripherals as Peripheral][#if Peripheral??]
[#list Peripheral as IP]
[#-- Section1: Create the void mx_<IpInstance>_<HalMode>_init() function for each ip instance --]
[#compress]
[#list IP.configModelList as instanceData]
[#assign ipName = instanceData.ipName]
[#if instanceData.isMWUsed=="false" && !ipName?contains("CORTEX") ]
     [#assign instName = instanceData.instanceName]

        [#assign halMode= instanceData.halMode]
        /* ${instName} init function */
        [#if halMode!=ipName&&!ipName?contains("TIM")&&!ipName?contains("CEC")]static void MX_${instName}_${halMode}_Init(void)[#else]static void MX_${instName}_Init(void)[/#if]
{
#n
        [#-- assign ipInstanceIndex = instName?replace(name,"")--]
        [#assign args = ""]
        [#assign listOfLocalVariables =""]
        [#assign resultList =""]
 	[#--list instanceData.configs as config--]
            [@common.getLocalVariableList instanceData=instanceData/]            
        [#--/#list--]#n
        [#--list instanceData.configs as config--]
            [#if instanceData.instIndex??][@common.generateConfigModelListCode configModel=instanceData inst=instName  nTab=1 index=instanceData.instIndex/][#else][@common.generateConfigModelListCode configModel=instanceData inst=instName  nTab=1 index=""/][/#if]
        [#--/#list--]
[#if instanceData.initServices??]
    [#if instanceData.initServices.gpioOut??]
        [#list instanceData.initCallBackInitMethodList as initCallBack]
            [#if initCallBack?contains("PostInit")]
                [#if  halMode!=ipName&&!ipName?contains("TIM")&&!ipName?contains("CEC")]
                #t${initCallBack}(&h${instanceData.halMode?lower_case}${instanceData.instIndex});
                [#else]
                #t${initCallBack}([#if ipName?contains("TIM")&&!(ipName?contains("HRTIM")||ipName?contains("LPTIM"))]&htim[#else]&h${instanceData.realIpName?lower_case}[/#if]${instanceData.instIndex});
                [/#if]
            [/#if]
        [/#list]
    [/#if]
[/#if]

#n}#n
[/#if]
[/#list]
[/#compress]
[/#list][/#if]
[/#list]
[@common.optinclude name="Src/dma.tmp"/][#-- ADD DMA Code--]
[@common.optinclude name="Src/mx_fmc_HC.tmp"/][#-- FMC Init --]
[@common.optinclude name="Src/gpio.tmp"/][#-- ADD GPIO Code--]
[/#if] [#-- if HALCompliant End --]
#n
[#-- FSMC Init --]
[@common.optinclude name="Src/mx_FSMC_HC.tmp"/]
#n
/* USER CODE BEGIN 4 */

/* USER CODE END 4 */
#n

[#if HALCompliant??] [#-- If FreeRtos is used --]
[@common.optinclude name="Src/rtos_threads.tmp"/]
[@common.optinclude name="Src/rtos_user_threads.tmp"/] 
[/#if] [#-- If FreeRtos is used --]

[#if mpuControl??] [#-- if MPU config is enabled --]
/* MPU Configuration */
[@common.optinclude name="Src/cortex.tmp"/]
[/#if]
[#-- For Tim timebase --]
[#if timeBaseSource?? && timeBaseSource.contains("TIM")]
/**
  * @brief  Period elapsed callback in non blocking mode
  * @note   This function is called  when ${timeBaseSource} interrupt took place, inside
  * HAL_TIM_IRQHandler(). It makes a direct call to HAL_IncTick() to increment
  * a global variable "uwTick" used as application time base.
  * @param  htim : TIM handle
  * @retval None
  */
void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim)
{
/* USER CODE BEGIN Callback 0 */

/* USER CODE END Callback 0 */
  if (htim->Instance == ${timeBaseSource}) {
    HAL_IncTick();
  }
/* USER CODE BEGIN Callback 1 */

/* USER CODE END Callback 1 */
}
[/#if]
#n
/**
  * @brief  This function is executed in case of error occurrence.
  * @param  None
  * @retval None
  */
void Error_Handler(void)
{
#t/* USER CODE BEGIN Error_Handler */
#t/* User can add his own implementation to report the HAL error return state */
#twhile(1) 
#t{
#t}
#t/* USER CODE END Error_Handler */ 
}
#n
[#compress] 
#ifdef  USE_FULL_ASSERT
#n
/**
#t  * @brief  Reports the name of the source file and the source line number
#t  *         where the assert_param error has occurred.
#t  * @param  file: pointer to the source file name
#t  * @param  line: assert_param error line source number
#t  * @retval None
#t  */
void assert_failed(uint8_t* file, uint32_t line)
{ 
#t/* USER CODE BEGIN 6 */
#t/* User can add his own implementation to report the file name and line number,
#t#tex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
#t/* USER CODE END 6 */
#n
}
#n
#endif
[/#compress]
#n
/**
#t* @}
#t*/ 
#n
/**
#t* @}
*/ 
#n
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/