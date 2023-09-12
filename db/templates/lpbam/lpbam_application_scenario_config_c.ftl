[#ftl]
[#assign coreDir=""]

[#assign coreDir=sourceDir]
[#if cpucore!="" && (contextFolder=="" || contextFolder=="/")]
    [#assign contextFolder = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")+"/"]
[/#if]
/* USER CODE BEGIN Header */
/**
  **********************************************************************************************************************
  * @file    lpbam_${LPBAM_NAME?replace(" ","")?lower_case}_${ScenarioName?lower_case}_config.c
  * @author  MCD Application Team
  * @brief   Provide LPBAM ${LPBAM_NAME} application ${ScenarioName} configuration services.
  **********************************************************************************************************************
  * @attention
  *
  * Copyright (c) ${year} STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  **********************************************************************************************************************
  */
/* USER CODE END Header */
/* Includes ----------------------------------------------------------------------------------------------------------*/
#include "lpbam_${LPBAM_NAME?replace(" ","_")?lower_case}.h"
[#compress]
#n
/* Private typedef ---------------------------------------------------------------------------------------------------*/
/* USER CODE BEGIN PTD */

#n/* USER CODE END PTD */

#n/* Private define --------------------------------------------------------------------------------------------------*/
[#if Queues??]
[#assign ind = 0]
    [#list Queues as QName]
[#if QName?starts_with("Coupled") && !isSalveQueue(QName)]
#define ${QName?upper_case?replace(" ","_")}_Q_IDX  (${ind}U)
[#assign ind = ind + 1]
[/#if]
[/#list]
[#list Queues as QName]
[#if !QName?starts_with("Coupled") && !isSalveQueue(QName)]
#define ${QName?upper_case?replace(" ","_")}_Q_IDX  (${ind}U)
[#assign ind = ind + 1]
[/#if]
    [/#list]
[/#if]
#define DMA_TIMEOUT_DURATION (0x1000U)
#n
/* USER CODE BEGIN PD */

#n/* USER CODE END PD */
#n
/* Private macro -----------------------------------------------------------------------------------------------------*/
/* USER CODE BEGIN PM */

#n/* USER CODE END PM */
[/#compress]
#n
/* External variables ------------------------------------------------------------------------------------------------*/
/* IP handler declaration */
[#if PC_PERIPHERALS??]
    [#list PC_PERIPHERALS as periph]
[#if periph!="VREFBUF"]
    [@common.optinclude name=contextFolder+sourceDir+"/Src/"+LPBAM_NAME?replace(" ","_")+ "_" + periph.toLowerCase() + "_handler.tmp"/]
[/#if]
    [/#list]
[/#if]

[#if Queues??]
/* LPBAM queues declaration */
    [#list Queues as QName]
extern DMA_QListTypeDef ${QName?replace(" ","_")}_Q;
    [/#list]
#n
[/#if]
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private function prototypes ---------------------------------------------------------------------------------------*/
[#function getHanndler(ipname)]
    [#if handlers??]
        [#list handlers as handler]
            [#list handler.entrySet() as entry]
                [#if entry.key == ipname]
                    [#assign iphandlerDef = entry.value] 
                    [#list iphandlerDef as val]
                    [#return val.handler]
                    [/#list]
                [/#if]
            [/#list]
        [/#list]
    [/#if]  
[#return ""]  
[/#function]
[#function getHanndlerType(ipname)]
    [#if handlers??]
        [#list handlers as handler]
            [#list handler.entrySet() as entry]
                [#if entry.key == ipname]
                    [#assign iphandlerDef = entry.value] 
                    [#list iphandlerDef as val]
                    [#return val.handlerType]
                    [/#list]
                [/#if]
            [/#list]
        [/#list]
    [/#if]  
[#return ""]  
[/#function]
[#if PC_PERIPHERALS??]
[#list PC_PERIPHERALS as periph]
[#if handlers??]
        [#list handlers as handler]
            [#list handler.entrySet() as entry]
                [#if entry.key == periph]
                    [#assign iphandlerDef = entry.value] 
                    [#list iphandlerDef as val]
                    [#assign PHandler = val.handler]
                    [#assign PHandlerType = val.handlerType]
                    [#break]
                    [/#list]
                [/#if]
            [/#list]
        [/#list]
    [/#if]  
    
#n/* LPBAM ${periph} management APIs */
static void MX_${periph}_Init(void);
[#if PHandler?? && periph!="VREFBUF" && periph!="TAMP" && periph!="PWR" &&  periph!="GPIO" && !periph?starts_with("LPDMA")]
static void MX_${periph}_MspInit(${PHandlerType} *${PHandler});
static void MX_${periph}_MspDeInit(${PHandlerType} *${PHandler});
[/#if]
[#if periph!="VREFBUF" && periph!="TAMP" && periph!="PWR" &&  periph!="GPIO" && !periph?starts_with("LPDMA")]
static void MX_${periph}_DeInit(void);
[/#if]       
    [/#list]
[/#if]

[#-- Autonumous APIs --]
/* LPBAM autonomous mode management APIs */
static void MX_AutonomousMode_Init(void);
static void MX_AutonomousMode_DeInit(void);

[#assign DMA_Error_Callback = {"1":"1"}]
[#assign DMA_HT_Callback = {"1":"1"}]
[#assign DMA_TC_Callback = {"1":"1"}]
[#-- Link/Unlink APIs --]
[#assign isQueueInterruptEnabled = false]
/* LPBAM queue linking/unlinking APIs */
[#if Queues??]
    [#list Queues as QName]
        [#if !isSalveQueue(QName)]
static void MX_${QName?replace(" ","_")}_Q_Link(DMA_HandleTypeDef *hdma);
static void MX_${QName?replace(" ","_")}_Q_UnLink(DMA_HandleTypeDef *hdma);
        [/#if]
[/#list]
[/#if]
[#if Queues??]
    [#list Queues as QName]
[#if LPBAMQUEUESETTINGS?? && !isSalveQueue(QName)]

[#assign SELECETED_LPBAMQUEUESETTINGS = LPBAMQUEUESETTINGS[0][QName]]
           [#list SELECETED_LPBAMQUEUESETTINGS?keys as key]
                [#if key?starts_with("DESCRIPTOR") && SELECETED_LPBAMQUEUESETTINGS[key]??]

                    [#if Queue_Descriptor?? && !Queue_Descriptor[QName]??]                        
                         [#assign Queue_Descriptor = DMA_Error_Callback + {QName:SELECETED_LPBAMQUEUESETTINGS[key]}]
                    [#else]
                        [#if !Queue_Descriptor??]
                            [#assign Queue_Descriptor = {QName:SELECETED_LPBAMQUEUESETTINGS[key]}]
                        [/#if]
                    [/#if]
                [/#if]
                [#if !QName?starts_with("Coupled") && (key=="Interrupt1" || key=="Interrupt2" || key=="Interrupt3" || key=="Interrupt6")]
                    [#if SELECETED_LPBAMQUEUESETTINGS[key]!="DISABLE"]
                        [#if !DMA_Error_Callback[QName]??]
                        [#assign DMA_Error_Callback = DMA_Error_Callback + {QName:"1"}]
                        [/#if]
                    [/#if]
                [/#if]
                [#if !QName?starts_with("Coupled") && key=="Interrupt4"]
                    [#if SELECETED_LPBAMQUEUESETTINGS[key]!="DISABLE"]
                        [#if !DMA_HT_Callback[QName]??]
                        [#assign DMA_HT_Callback = DMA_HT_Callback + {QName:"1"}]
                        [/#if]
                    [/#if]
                [/#if]
                [#if !QName?starts_with("Coupled") && key=="Interrupt5"]
                    [#if SELECETED_LPBAMQUEUESETTINGS[key]!="DISABLE"]
                        [#if !DMA_TC_Callback[QName]??]
                        [#assign DMA_TC_Callback = DMA_TC_Callback + {QName:"1"}]
                        [/#if]
                    [/#if]
                [/#if]
                [#if QName?starts_with("Coupled") && (key=="Interrupt1_CoupledQueue" || key=="Interrupt2_CoupledQueue" || key=="Interrupt3_CoupledQueue" || key=="Interrupt6_CoupledQueue")]
                    [#if SELECETED_LPBAMQUEUESETTINGS[key]!="DISABLE"]
                        [#if !DMA_Error_Callback[QName]??]
                        [#assign DMA_Error_Callback = DMA_Error_Callback + {QName:"1"}]
                        [/#if]
                    [/#if]
                [/#if]
                [#if QName?starts_with("Coupled") && key=="Interrupt4_CoupledQueue"]
                    [#if SELECETED_LPBAMQUEUESETTINGS[key]!="DISABLE"]
                        [#if !DMA_HT_Callback[QName]??]
                        [#assign DMA_HT_Callback = DMA_HT_Callback + {QName:"1"}]
                        [/#if]
                    [/#if]
                [/#if]
                [#if QName?starts_with("Coupled") && key=="Interrupt5_CoupledQueue"]
                    [#if SELECETED_LPBAMQUEUESETTINGS[key]!="DISABLE"]
                        [#if !DMA_TC_Callback[QName]??]
                        [#assign DMA_TC_Callback = DMA_TC_Callback + {QName:"1"}]
                        [/#if]
                    [/#if]
                [/#if]
            [/#list]            
        [/#if]
[#if DMA_Error_Callback[QName]?? || DMA_HT_Callback[QName]?? || DMA_TC_Callback[QName]?? ]
[#assign isQueueInterruptEnabled = true]
[/#if]
[/#list]
[#if isQueueInterruptEnabled]
#n
/* LPBAM DMA user callback APIs */
[/#if]
[#list Queues as QName]
        [#if DMA_Error_Callback[QName]??]
static void MX_${QName?replace(" ","_")}_Q_DMA_Error_Callback(DMA_HandleTypeDef *hdma);
        [/#if]
        [#if DMA_HT_Callback[QName]??]
static void MX_${QName?replace(" ","_")}_Q_DMA_HT_Callback(DMA_HandleTypeDef *hdma);
        [/#if]
        [#if DMA_TC_Callback[QName]??]
static void MX_${QName?replace(" ","_")}_Q_DMA_TC_Callback(DMA_HandleTypeDef *hdma);
        [/#if]
[/#list]
[#if isQueueInterruptEnabled]
/* LPBAM DMA NVIC API */
static void MX_DMA_NVIC_Config(DMA_HandleTypeDef *hdma, uint32_t PreemptPriority, uint32_t SubPriority);
    [/#if]
[/#if]
[#-- Scenario API --]
#n
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */
#n/* Exported functions ----------------------------------------------------------------------------------------------*/
/**
#t* @brief  ${LPBAM_NAME} application ${ScenarioName} scenario initialization
#t* @param  None
#t* @retval None
#t*/
void MX_${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Init(void)
{
[#if PC_PERIPHERALS??]
    [#list PC_PERIPHERALS as periph]
#t/* LPBAM ${periph} initialization */
#tMX_${periph}_Init();
#n
    [/#list]
[/#if]
#t/* Autonomous Mode initialization */
#tMX_AutonomousMode_Init();
#n
#t/* USER CODE BEGIN ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Init */
#n#t/* USER CODE END ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Init */
}
#n
[#compress]
/**
#t* @brief  ${LPBAM_NAME} application ${ScenarioName} scenario de-initialization
#t* @param  None
#t* @retval None
#t*/
void MX_${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_DeInit(void)
{
 [#if PC_PERIPHERALS??]
    [#list PC_PERIPHERALS as periph]
[#if !periph?starts_with("VREFBUF")&& !periph?starts_with("TAMP") && periph!="PWR" &&  periph!="GPIO" && !periph?starts_with("LPDMA")]
#t/* LPBAM ${periph} De-initialization */
#tMX_${periph}_DeInit();#n
[/#if]
    [/#list]
[/#if]
#t/* Autonomous mode de-initialization */
#tMX_AutonomousMode_DeInit();
#n
#t/* USER CODE BEGIN ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_DeInit */
#n#t/* USER CODE END ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_DeInit */
}
#n
/**
#t* @brief  ${LPBAM_NAME} application ${ScenarioName} scenario link
#t* @param  None
#t* @retval None
#t*/
void MX_${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Link(DMA_HandleTypeDef *hdma)
{
#t/* USER CODE BEGIN ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Link 0 */
#n#t/* USER CODE END ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Link 0 */
#n
[#if Queues??]
    [#list Queues as QName]
        [#if QName?starts_with("Coupled") && !isSalveQueue(QName)]
#t/* Link ${QName} queue to DMA channel */
#tMX_${QName?replace(" ","_")}_Q_Link(&hdma[${QName?upper_case?replace(" ","_")}_Q_IDX]);
#n
#t/* USER CODE BEGIN LINK ${QName?upper_case?replace(" ","_")}_Q_IDX */
#n#t/* USER CODE END LINK ${QName?upper_case?replace(" ","_")}_Q_IDX */
#n
        [/#if]
    [/#list]
[#list Queues as QName]
[#if !QName?starts_with("Coupled") && !isSalveQueue(QName)]
#t/* Link ${QName} queue to DMA channel */
#tMX_${QName?replace(" ","_")}_Q_Link(&hdma[${QName?upper_case?replace(" ","_")}_Q_IDX]);
#n
#t/* USER CODE BEGIN LINK ${QName?upper_case?replace(" ","_")}_Q_IDX */
#n#t/* USER CODE END LINK ${QName?upper_case?replace(" ","_")}_Q_IDX */
#n
[/#if]
    [/#list]
[/#if]
#n
#t/* USER CODE BEGIN ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Link 1 */
#n#t/* USER CODE END ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Link 1 */
}
#n
/**
#t* @brief  ${LPBAM_NAME} application ${ScenarioName} scenario unlink
#t* @param  hdma :Pointer to a DMA_HandleTypeDef structure that contains the configuration information for the specified 
#t*#t#t#t#t#t#t#tDMA Channel
#t* @retval None
#t*/
void MX_${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_UnLink(DMA_HandleTypeDef *hdma)
{
#t/* USER CODE BEGIN ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_UnLink 0 */
#n#t/* USER CODE END ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_UnLink 0 */
#n
[#if Queues??]
    [#list Queues as QName]
[#if QName?starts_with("Coupled") && !isSalveQueue(QName)]
#t/* LPBAM unLink ${QName} queue to DMA channel */
#tMX_${QName?replace(" ","_")}_Q_UnLink(&hdma[${QName?upper_case?replace(" ","_")}_Q_IDX]);
#n
#t/* USER CODE BEGIN UNLINK ${QName?upper_case?replace(" ","_")}_Q_IDX */
#n#t/* USER CODE END UNLINK ${QName?upper_case?replace(" ","_")}_Q_IDX */
#n
[/#if]
    [/#list]
[#list Queues as QName]
[#if !QName?starts_with("Coupled") && !isSalveQueue(QName)]
#t/* LPBAM unLink ${QName} queue to DMA channel */
#tMX_${QName?replace(" ","_")}_Q_UnLink(&hdma[${QName?upper_case?replace(" ","_")}_Q_IDX]);
#n
#t/* USER CODE BEGIN UNLINK ${QName?upper_case?replace(" ","_")}_Q_IDX */
#n#t/* USER CODE END UNLINK ${QName?upper_case?replace(" ","_")}_Q_IDX */
#n
[/#if]
    [/#list]
[/#if]
#n
#t/* USER CODE BEGIN ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_UnLink 1 */
#n#t/* USER CODE END ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_UnLink 1 */
}
#n
/**
#t* @brief  ${LPBAM_NAME} application ${ScenarioName} scenario start
#t* @retval None
#t*/
void MX_${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Start(DMA_HandleTypeDef *hdma)
{
[#if Queues??]
    [#list Queues as QName]
[#if QName?starts_with("Coupled") && !isSalveQueue(QName)]
#t/* LPBAM start DMA channel in linked-list mode */
#tif (HAL_DMAEx_List_Start(&hdma[${QName?upper_case?replace(" ","_")}_Q_IDX]) != HAL_OK)
#t{
#t#tError_Handler();
#t}
#n
[/#if]
[/#list]
[#list Queues as QName]
[#if !QName?starts_with("Coupled") && !isSalveQueue(QName)]
#t/* LPBAM start DMA channel in linked-list mode */
#tif (HAL_DMAEx_List_Start(&hdma[${QName?upper_case?replace(" ","_")}_Q_IDX]) != HAL_OK)
#t{
#t#tError_Handler();
#t}
#n
[/#if]
    [/#list]
[/#if]
#t/* USER CODE BEGIN ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Start */

#n#t/* USER CODE END ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Start */
[#if QueueTriggers??]
    [#list QueueTriggers as Trigger]
#t/* ${Trigger} start*/
#tif (HAL_LPTIM_PWM_Start(&hlptim3, LPTIM_CHANNEL_1) != HAL_OK)
#t{
#t#tError_Handler();
#t}
    [/#list]
[/#if]
}
#n
/**
#t* @brief  ${LPBAM_NAME} application ${ScenarioName} scenario stop
#t* @retval None
#t*/
void MX_${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Stop(DMA_HandleTypeDef *hdma)
{
[#if Queues??]
    [#list Queues as QName]
[#if QName?starts_with("Coupled") && !isSalveQueue(QName)]
#t/* LPBAM stop DMA channel in linked-list mode */
#tif ((hdma[${QName?upper_case?replace(" ","_")}_Q_IDX].State == HAL_DMA_STATE_BUSY) && (hdma[${QName?upper_case?replace(" ","_")}_Q_IDX].LinkedListQueue->FirstCircularNode != 0U))
#t{
#t#tif (HAL_DMA_Abort(&hdma[${QName?upper_case?replace(" ","_")}_Q_IDX]) != HAL_OK)
#t#t{
#t#t#tError_Handler();
#t#t}
#t}
#n
#t/* Check if DMA channel interrupt is enabled */
#tif ((hdma[${QName?upper_case?replace(" ","_")}_Q_IDX].State == HAL_DMA_STATE_BUSY) && (__HAL_DMA_GET_IT_SOURCE(&hdma[${QName?upper_case?replace(" ","_")}_Q_IDX], DMA_IT_TC) == 0U))
#t{
#t#tif (HAL_DMA_PollForTransfer(&hdma[${QName?upper_case?replace(" ","_")}_Q_IDX], HAL_DMA_FULL_TRANSFER, DMA_TIMEOUT_DURATION) != HAL_OK)
#t#t{
#t#t#tError_Handler();
#t#t}
#t}
[/#if]
[/#list]
[#list Queues as QName]
[#if !QName?starts_with("Coupled") && !isSalveQueue(QName)]
#t/* LPBAM stop DMA channel in linked-list mode */
#tif ((hdma[${QName?upper_case?replace(" ","_")}_Q_IDX].State == HAL_DMA_STATE_BUSY) && (hdma[${QName?upper_case?replace(" ","_")}_Q_IDX].LinkedListQueue->FirstCircularNode != 0U))
#t{
#t#tif (HAL_DMA_Abort(&hdma[${QName?upper_case?replace(" ","_")}_Q_IDX]) != HAL_OK)
#t#t{
#t#t#tError_Handler();
#t#t}
#t}
#n
#t/* Check if DMA channel interrupt is enabled */
#tif ((hdma[${QName?upper_case?replace(" ","_")}_Q_IDX].State == HAL_DMA_STATE_BUSY) && (__HAL_DMA_GET_IT_SOURCE(&hdma[${QName?upper_case?replace(" ","_")}_Q_IDX], DMA_IT_TC) == 0U))
#t{
#t#tif (HAL_DMA_PollForTransfer(&hdma[${QName?upper_case?replace(" ","_")}_Q_IDX], HAL_DMA_FULL_TRANSFER, DMA_TIMEOUT_DURATION) != HAL_OK)
#t#t{
#t#t#tError_Handler();
#t#t}
#t}
[/#if]
    [/#list]
[/#if]
#n
#t/* USER CODE BEGIN ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Stop */

#n#t/* USER CODE END ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Stop */
}
#n
/**
#t* @brief  ${LPBAM_NAME} application ${ScenarioName} autonomous mode init
#t* @param  None
#t* @retval None
#t*/
static void MX_AutonomousMode_Init(void)
{
#t/* Enable LPDMA1 Sleep Clock */
#t__HAL_RCC_LPDMA1_CLK_SLEEP_ENABLE();
#t/* Enable LPDMA1 Autonomous Mode */
#t__HAL_RCC_LPDMA1_CLKAM_ENABLE();
#n
#t/* Enable SRAM4 Sleep Clock */
#t__HAL_RCC_SRAM4_CLK_SLEEP_ENABLE();
#t/* Enable SRAM4 Autonomous Mode */
#t__HAL_RCC_SRAM4_CLKAM_ENABLE();
[#assign allClocks = ""]
[#if PC_PERIPHERALS??]
    [#list PC_PERIPHERALS as periph]
        [#list PERIPHERALS_VS_CLK as PERIPHERALS_And_CLK]
        [#assign ipCLOCK = PERIPHERALS_And_CLK[periph]]
        [/#list]
        [#if ipCLOCK?? && !periph?starts_with("LPDMA") && !periph?starts_with("GPIO") && !periph?starts_with("NVIC") && !periph?starts_with("TAMP") && periph!="PWR"]
            [#list ipCLOCK as clk]
                [#if clk!="none"  && clk!="__HAL_RCC_RTC_ENABLE"]
                    [#if !allClocks?contains(clk?replace("CLK_", "CLKAM_")?replace("VREFBUF", "VREF")?replace("COMP", "COMP12"))]                        
#n
#t/* Enable ${periph} Sleep Clock */
#t${clk?replace("CLK_ENABLE", "CLK_SLEEP_ENABLE")?replace("VREFBUF", "VREF")}();
#t/* Enable ${periph} Autonomous Mode */
#t${clk?replace("CLK_", "CLKAM_")?replace("VREFBUF", "VREF")?replace("COMP", "COMP12")}();
                        [#assign allClocks = allClocks + " " + clk?replace("CLK_", "CLKAM_")?replace("VREFBUF", "VREF")?replace("COMP", "COMP12")]
                        [#assign allClocks = allClocks + " " + clk?replace("CLK_ENABLE", "CLK_SLEEP_ENABLE")?replace("VREFBUF", "VREF")]
                    [/#if]
                [/#if]
            [/#list]
        [#else]            
            [#if periph?starts_with("GPIO") && GPIO_CLK_LIST??]
                [#list GPIO_CLK_LIST as clk]
                    [#if clk!="none"  && clk?starts_with("__HAL_RCC_LPGPIO")]
                        [#if !allClocks?contains(clk?replace("CLK_", "CLKAM_")?replace("VREFBUF", "VREF"))]
#n
#t/* Enable ${clk?replace("__HAL_RCC_", "")?replace("_CLK_ENABLE", "")} Sleep Clock */
#t${clk?replace("CLK_ENABLE", "CLK_SLEEP_ENABLE")}();
#t/* Enable ${clk?replace("__HAL_RCC_", "")?replace("_CLK_ENABLE", "")} Autonomous Mode */
#t${clk?replace("CLK_", "CLKAM_")}();

                    [#assign allClocks = allClocks + " " + clk?replace("CLK_", "CLKAM_")]
                    [#assign allClocks = allClocks + " " + clk?replace("CLK_ENABLE", "CLK_SLEEP_ENABLE")]
                        [/#if]
                    [/#if]
                [/#list]
            [/#if]
        [/#if]
    [/#list]
[/#if]
#n
#t/* USER CODE BEGIN AutonomousMode_Init */
#n#t/* USER CODE END AutonomousMode_Init */
}
#n
[/#compress]
/**
#t* @brief  ${LPBAM_NAME} application ${ScenarioName} autonomous mode deinit
#t* @param  None
#t* @retval None
#t*/
static void MX_AutonomousMode_DeInit(void)
{
#t/* Disable LPDMA1 Sleep Clock */
#t__HAL_RCC_LPDMA1_CLK_SLEEP_DISABLE();
#t/* Disable LPDMA1 Autonomous Mode */
#t__HAL_RCC_LPDMA1_CLKAM_DISABLE();

#t/* Disable SRAM4 Sleep Clock */
#t__HAL_RCC_SRAM4_CLK_SLEEP_DISABLE();
#t/* Disable SRAM4 Autonomous Mode */
#t__HAL_RCC_SRAM4_CLKAM_DISABLE();
[#compress]
[#assign allClocks = ""]
[#if PC_PERIPHERALS??]
#n
    [#list PC_PERIPHERALS as periph]
        [#list PERIPHERALS_VS_CLK as PERIPHERALS_And_CLK]
        [#assign ipCLOCK = PERIPHERALS_And_CLK[periph]]
        [/#list]
        [#if ipCLOCK?? && !periph?starts_with("LPDMA") && !periph?starts_with("GPIO") && !periph?starts_with("NVIC") && !periph?starts_with("TAMP") && periph!="PWR"]
            [#list ipCLOCK as clk]
                [#if clk!="none" && clk!="__HAL_RCC_RTC_ENABLE" && clk!="__HAL_RCC_RTCAPB_CLKAM_ENABLE"]
                    [#if !allClocks?contains(clk?replace("CLK_", "CLKAM_")?replace("VREFBUF", "VREF"))]                        
#t/* Disable ${periph} Sleep Clock */
#t${clk?replace("CLK_ENABLE", "CLK_SLEEP_DISABLE")?replace("VREFBUF", "VREF")}();
#t/* Disable ${periph} Autonomous Mode */
#t${clk?replace("CLK_ENABLE", "CLKAM_DISABLE")?replace("CLKAM_ENABLE", "CLKAM_DISABLE")?replace("VREFBUF", "VREF")?replace("COMP", "COMP12")}();
#n
                        [#assign allClocks = allClocks + " " + clk?replace("CLK_ENABLE", "CLKAM_DISABLE")?replace("CLKAM_ENABLE", "CLKAM_DISABLE")?replace("VREFBUF", "VREF")]
                        [#assign allClocks = allClocks + " " + clk?replace("CLK_ENABLE", "CLK_SLEEP_DISABLE")?replace("VREFBUF", "VREF")]                        
                    [/#if]
                [/#if]
            [/#list]
        [#else]            
            [#if periph?starts_with("GPIO") && GPIO_CLK_LIST??]
                [#list GPIO_CLK_LIST as clk]
                    [#if clk!="none"  && clk?starts_with("__HAL_RCC_LPGPIO")]
                        [#if !allClocks?contains(clk?replace("CLK_", "CLKAM_")?replace("VREFBUF", "VREF"))]
#t/* Disable ${clk?replace("__HAL_RCC_", "")?replace("_CLK_ENABLE", "")} Sleep Clock */
#t${clk?replace("CLK_ENABLE", "CLK_SLEEP_DISABLE")}();
#t/* Disable ${clk?replace("__HAL_RCC_", "")?replace("_CLK_ENABLE", "")} Autonomous Mode */
#t${clk?replace("CLK_ENABLE", "CLKAM_DISABLE")}();
#n
                    [#assign allClocks = allClocks + " " + clk?replace("CLK_ENABLE", "CLKAM_DISABLE")]
                    [#assign allClocks = allClocks + " " + clk?replace("CLK_ENABLE", "CLK_SLEEP_DISABLE")]
                        [/#if]
                    [/#if]
                [/#list]
            [/#if]
        [/#if]

    [/#list]
[/#if] 
#n
[/#compress]
#t/* USER CODE BEGIN AutonomousMode_DeInit */
#n#t/* USER CODE END AutonomousMode_DeInit */
}

[#if PC_PERIPHERALS??]
   [#list PC_PERIPHERALS as periph]
   [@common.optinclude name=contextFolder+sourceDir+"/Src/"+LPBAM_NAME?replace(" ","_")+ "_" + periph.toLowerCase() + "_init.tmp"/]
   [/#list]
[/#if]
[@common.optinclude name=contextFolder+sourceDir+"/Src/"+LPBAM_NAME?replace(" ","_")+ "_gpio.tmp"/][#-- ADD GPIO Code--]
[#-- Queue Link/Unlik --]
[#if Queues??]
    [#list Queues as QName]
[#if !isSalveQueue(QName)]
#n/**
#t* @brief  ${QName} queue link
#t* @retval None
#t*/
[#assign QueueConfigModel = ""]
[#assign interrupts = [""]]
[#if LPBAMQUEUECONFIG??]
    [#list LPBAMQUEUECONFIG as conf]
    [#if conf[QName]??]
        [#assign QueueConfigModel = conf[QName]]        
    [/#if]
    [/#list]
[/#if]
[#if LPBAMQUEUESETTINGS??]
    [#list LPBAMQUEUESETTINGS as setting]
    [#list setting.entrySet() as entry]
                [#if entry.key?starts_with("interrupt") && entry.value!="DISABLE"]
                    [#assign interrupts = interrupts +[entry.value]]
                [/#if]
            [/#list]
    [/#list]
[/#if]
static void MX_${QName?replace(" ","_")}_Q_Link(DMA_HandleTypeDef *hdma)
{
#t/* Enable LPDMA1 clock */
#t__HAL_RCC_LPDMA1_CLK_ENABLE();
[#compress]
#n
    [#if QueueConfigModel!=""]       
        [#list QueueConfigModel.configModelList as instanceData]
                    [#assign args = ""]
                    [#assign listOfLocalVariables =""]
                    [#assign resultList =""]
            [#assign instName = instanceData.instanceName]
            [#if instanceData.instIndex??][@common.generateConfigModelListCode configModel=instanceData inst=instName  nTab=1 index=instanceData.instIndex/][#else][@common.generateConfigModelListCode configModel=instanceData inst=instName  nTab=1 index=""/][/#if]
        [/#list]
    [/#if]
}
[/#compress]
#n
/**
#t* @brief  ${QName} queue unlink
#t* @retval None
#t*/
static void MX_${QName?replace(" ","_")}_Q_UnLink(DMA_HandleTypeDef *hdma)
{
  /* UnLink ${QName} queue to DMA channel */
  if (HAL_DMAEx_List_UnLinkQ(hdma) != HAL_OK)
  {
    Error_Handler();
  }
[#if DMA_Error_Callback[QName]??]
#n#t/* UnRegister DMA channel error callbacks */
#tif (HAL_DMA_UnRegisterCallback(hdma, HAL_DMA_XFER_ERROR_CB_ID) != HAL_OK)
#t{
#t#tError_Handler();
#t}
[/#if]
[#if DMA_HT_Callback[QName]??]
#n#t/* UnRegister DMA channel half transfer complete callbacks */
#tif (HAL_DMA_UnRegisterCallback(hdma, HAL_DMA_XFER_HALFCPLT_CB_ID) != HAL_OK)
#t{
#t#tError_Handler();
#t}
[/#if]
[#if DMA_TC_Callback[QName]??]
#n#t/* Register DMA channel transfer complete callbacks */
#tif (HAL_DMA_UnRegisterCallback(hdma, HAL_DMA_XFER_CPLT_CB_ID) != HAL_OK)
#t{
#t#tError_Handler();
#t}
[/#if]
#n#t/* DMA linked list de-init */
#tif (HAL_DMAEx_List_DeInit(hdma) != HAL_OK)
#t{
#t#tError_Handler();
#t}  
}

[#if DMA_Error_Callback[QName]??]
/**
#t* @brief  ${QName} queue dma error callback
#t* @retval None
#t*/
static void MX_${QName?replace(" ","_")}_Q_DMA_Error_Callback(DMA_HandleTypeDef *hdma)
{
  /* USER CODE BEGIN ${QName?replace(" ","_")}_DMA_Error_Callback */

  /* USER CODE END ${QName?replace(" ","_")}_DMA_Error_Callback */
}
[/#if]
[#if DMA_HT_Callback[QName]??]
/**
#t* @brief  ${QName} queue dma half transfer complete callbacks
#t* @retval None
#t*/
static void MX_${QName?replace(" ","_")}_Q_DMA_HT_Callback(DMA_HandleTypeDef *hdma)
{
  /* USER CODE BEGIN ${QName?replace(" ","_")}_DMA_HT_Callback */

  /* USER CODE END ${QName?replace(" ","_")}_DMA_HT_Callback */
}
[/#if]

[#if DMA_TC_Callback[QName]??]
/**
#t* @brief  ${QName} queue dma transfer complete callbacks
#t* @retval None
#t*/
static void MX_${QName?replace(" ","_")}_Q_DMA_TC_Callback(DMA_HandleTypeDef *hdma)
{
  /* USER CODE BEGIN ${QName?replace(" ","_")}_DMA_TC_Callback */

  /* USER CODE END ${QName?replace(" ","_")}_DMA_TC_Callback */
}
[/#if]
[/#if]
[/#list]
[/#if]
#n
/* USER CODE BEGIN ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Config */
#n/* USER CODE END ${LPBAM_NAME?replace(" ","_")}_${ScenarioName}_Config */
#n
[#-- MX_DMA_NVIC_Config --]
[#if isQueueInterruptEnabled]
/**
#t* @brief DMA channel NVIC configuration
#t* @retval None
#t*/
static void MX_DMA_NVIC_Config(DMA_HandleTypeDef *hdma, uint32_t PreemptPriority, uint32_t SubPriority)
{
#tIRQn_Type irq = LPDMA1_Channel0_IRQn;
#n
#t/* Check DMA channel instance */
#tswitch ((uint32_t)hdma->Instance)
#t{
#t#tcase (uint32_t)LPDMA1_Channel0: /* DMA channel_0 */
#t#t{
#t#t#tirq = LPDMA1_Channel0_IRQn;
#t#t#tbreak;
#t#t}
#n
#t#tcase (uint32_t)LPDMA1_Channel1: /* DMA channel_1 */
#t#t{
#t#t#tirq = LPDMA1_Channel1_IRQn;
#t#t#tbreak;
#t#t}
#n
#t#tcase (uint32_t)LPDMA1_Channel2: /* DMA channel_2 */
#t#t{
#t#t#tirq = LPDMA1_Channel2_IRQn;
#t#t#tbreak;
#t#t}
#n
#t#tcase (uint32_t)LPDMA1_Channel3: /* DMA channel_3 */
#t#t{
#t#t#tirq = LPDMA1_Channel3_IRQn;
#t#t#tbreak;
#t#t}
#t}
#n
#t/* Enable NVIC for DMA channel */
#tHAL_NVIC_SetPriority(irq, PreemptPriority, SubPriority);
#tHAL_NVIC_EnableIRQ(irq);
}
[/#if]
[#function getQueueInfo(queueName,keyName)]
    [#if Inputs??]
        [#list Inputs as inData]
            [#list inData.entrySet() as entry]
                [#if entry.key==keyName]
                    [#assign val = entry.value]
                    [#if  val[queueName]??]
                        [#return val[queueName]]
                    [/#if]
                [/#if]
            [/#list]
        [/#list]
        [#return ""]
    [/#if]   
    [#return ""]
[/#function]
[#function isSalveQueue(queueName)]
    [#if SlaveQueues??]
        [#list SlaveQueues as queue]
           [#if  queue == queueName]
                [#return true]
            [/#if]
        [/#list]
        [#return false]
    [/#if]   
    [#return false]
[/#function]
[#function isCoupledQueue(queueName)]
    [#if SlaveQueues??]
        [#list SlaveQueues as queue]
           [#if  queue == queueName]
                [#return true]
            [/#if]
        [/#list]
        [#return false]
    [/#if]   
    [#return false]
[/#function]
