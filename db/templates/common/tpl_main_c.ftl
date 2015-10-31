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
[/#list]
[#-- /#if --]
[/#compress]
#n
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */
#n
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
    [@common.optinclude name="Src/mx_FMC_GV.tmp"/]
    [#--ADD FMC Code End--]
    [#-- Add FSMC Code Begin--]
    [@common.optinclude name="Src/mx_FSMC_GV.tmp"/]
    [#--ADD FSMC Code End--] 
    [#-- RTOS variables --]
    [#-- ADD RTOS Code Begin--]
    [@common.optinclude name="Src/rtos_vars.tmp"/]   
    [#-- ADD RTOS Code End--]
    [/#compress]
[/#if][#-- if HALCompliant End --] 

    [#-- Global variables --]
[#-- If HAL compliant generate Global variable : Peripherals handler -End --]
#n#n
/* USER CODE BEGIN PV */

/* USER CODE END PV */
#n
[#compress]
[#if clockConfig??]
/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void); [#-- remove static --]
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
  [#if !void?contains("FREERTOS")&&!void?contains("FATFS")&& !void?contains("LWIP")&& !void?contains("USB_DEVICE")&& !void?contains("USB_HOST")&& !void?contains("CORTEX")]
  static void ${""?right_pad(2)}${void}(void);
  [/#if]
 [/#list]
 [@common.optinclude name="Src/rtos_pfp.tmp"/]
[/#if]
[/#compress]
[#if USB_HOST?? && !FREERTOS??]
#nvoid MX_USB_HOST_Process(void);
[/#if]
#n
/* USER CODE BEGIN PFP */

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
[#if !void?contains("FREERTOS")&&!void?contains("CORTEX")]
#t${void}();
[/#if]
[/#list]
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
[/#list][/#if]}[/#if]
#n

[/#compress]

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
        [#if halMode!=ipName&&!ipName?contains("TIM")&&!ipName?contains("CEC")]void MX_${instName}_${halMode}_Init(void)[#else]void MX_${instName}_Init(void)[/#if]
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
#n}#n
[/#if]
[/#list]
[/#compress]
[/#list][/#if]
[/#list]
[@common.optinclude name="Src/dma.tmp"/][#-- ADD DMA Code--]
[@common.optinclude name="Src/mx_FMC_HC.tmp"/][#-- FMC Init --]
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

[#compress] 
#n
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