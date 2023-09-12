[#ftl]
/* USER CODE BEGIN Header */
/**
  **********************************************************************************************************************
  * @file   lpbam_${LPBAM_NAME?replace(" ","_")?lower_case}_config.c
  * @author MCD Application Team
  * @brief  Provides LPBAM ${LPBAM_NAME} application configuration services
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

/* Private variables -------------------------------------------------------------------------------------------------*/
static RAMCFG_HandleTypeDef hramcfg;

/* Private function prototypes ---------------------------------------------------------------------------------------*/
static void MX_SystemClock_Config(void);
static void MX_SystemPower_Config(void);
static void MX_SRAM_WaitState_Config(void);
#n
/* Exported functions ------------------------------------------------------------------------------------------------*/
/**
  * @brief  ${LPBAM_NAME?replace(" ","_")} application initialization
  * @param  None
  * @retval None
  */
void MX_${LPBAM_NAME?replace(" ","_")}_Init(void)
{
#t/* USER CODE BEGIN ${LPBAM_NAME?replace(" ","_")}_Init 0 */
#n#t/* USER CODE END ${LPBAM_NAME?replace(" ","_")}_Init 0 */
#n
#t/* Configure SRAM wait states */
#tMX_SRAM_WaitState_Config();
 
#t/* Configure system clock */
#tMX_SystemClock_Config();

#t/* Configure system power */
#tMX_SystemPower_Config();

#t/* USER CODE BEGIN ${LPBAM_NAME?replace(" ","_")}_Init 1 */
#n#t/* USER CODE END ${LPBAM_NAME?replace(" ","_")}_Init 1 */
}
#n
/* Private functions -------------------------------------------------------------------------------------------------*/
/**
  * @brief  System Clock Configuration
  * @param  None
  * @retval None
  */
static void MX_SystemClock_Config(void)
{
[#compress]
[#assign nbVars = 0]
[#assign listOfLocalVariables =""]
        [#assign resultList =""]
    [#list clockConfig as configModel] [#--list0--]
        [#list configModel.configs as config] [#--list1--]
           [#compress] [@common.getLocalVariable configModel1=config listOfLocalVariables=listOfLocalVariables resultList=resultList/][/#compress]
            [#assign listOfLocalVariables =resultList]
            [#assign nbVars = nbVars + getNbVariable(config)]
        [/#list]
    [/#list]
[/#compress]
[#if nbVars != 0 ]
#n
[/#if]
[#assign clockInst=""]
[#assign nTab=1]
[#if clockConfig??] 
[#list clockConfig as configModel] [#--list0--]
    [#--list configModel.configs as config--] [#--list1--]
   [#compress] [@common.generateConfigModelListCode configModel=configModel inst=clockInst  nTab=1 index=""/][/#compress]
    [#--/#list--]
[/#list][/#if]
}
#n
/**
  * @brief  System Power Configuration
  * @param  None
  * @retval None
  */
static void MX_SystemPower_Config(void)
{
#t/* USER CODE BEGIN PWR_Config 0 */
  
#t/* USER CODE END PWR_Config 0 */
#n
#t/* Enable PWR interface clock */
#t__HAL_RCC_PWR_CLK_ENABLE();
#n
[#compress]
[#if pwrConfig??]
[#list pwrConfig as config]
 [#assign listOfLocalVariables =""]
        [#assign resultList =""] 	
            [@common.getLocalVariableList instanceData=config/] 
[/#list]
[/#if]
[#-- PWR configuration --]
[#if pwrConfig??]
[#list pwrConfig as config]
[@common.generateConfigModelListCode2 configModel=config inst="PWR"  nTab=1 index=""/]
[/#list]
[/#if]
#n
#t/* USER CODE BEGIN PWR_Config 1 */
  
#n#t/* USER CODE END PWR_Config 1 */
[/#compress]
#n}
#n
/**
  * @brief  SRAM Wait State configuration
  * @param  None
  * @retval None
  */
static void MX_SRAM_WaitState_Config(void)
{
  /* RAMCFG clock enable */
  __HAL_RCC_RAMCFG_CLK_ENABLE();

  /*
   * RAMCFG initialization
   */
  hramcfg.Instance = RAMCFG_SRAM4;
  if (HAL_RAMCFG_Init(&hramcfg) != HAL_OK)
  {
    Error_Handler();
  }

  /*
   * RAMCFG wait states configuration
   */
  if (HAL_RAMCFG_ConfigWaitState(&hramcfg, ${WateState}) != HAL_OK)
  {
    Error_Handler();
  }
}
[#-- function getNbVariable --]
[#function getNbVariable configModel1]
    [#if configModel1.methods??] 
        [#assign methodList1 = configModel1.methods]
    [#else] [#assign methodList1 = configModel1.libMethod]
    [/#if]
 [#assign nbVars = 0]
 [#assign myListOfLocalVariables = ""]
    [#list methodList1 as method][#-- list methodList1 --][#if method.arguments?? && method.status!="WARNING"]
        [#list method.arguments as argument][#-- list method.arguments --]
            [#if argument.genericType == "struct"][#-- if struct --]
                [#if argument.context??][#-- if argument.context?? --]
                    [#if argument.context!="global"&&argument.status!="WARNING"&&argument.status!="NULL"] [#-- if !global --]
                    [#assign varName= " "+argument.name]                    
                    [#assign ll= myListOfLocalVariables?split(" ")]
                    [#assign exist=false]
                    [#list ll as var  ]
                        [#if var==argument.name]
                            [#assign exist=true]
                        [/#if]
                    [/#list]
                    [#if !exist]  [#-- if exist --]                  
                      [#assign myListOfLocalVariables = myListOfLocalVariables + " "+ argument.name]
                      [#assign nbVars = nbVars + 1]
                      [#assign resultList = myListOfLocalVariables]
                    [/#if][#-- if exist --]
                    [/#if][#-- if global --]
                [#else][#-- if context?? --]
            [/#if][#-- if argument.context?? --]
[#else][#-- if non struct --]
                [#if argument.context??][#-- if argument.context?? --]
                    [#if argument.context!="global"&&argument.status!="WARNING"&&argument.status!="NULL"&&argument.returnValue="true"] [#-- if !global --]
                    [#assign varName= " "+argument.name]                    
                    [#assign ll= myListOfLocalVariables?split(" ")]
                    [#assign exist=false]
                    [#list ll as var  ]
                        [#if var==argument.name]
                            [#assign exist=true]
                        [/#if]
                    [/#list]
                    [#if !exist]  [#-- if exist --]                  
                      [#assign myListOfLocalVariables = myListOfLocalVariables + " "+ argument.name]
                      [#assign nbVars = nbVars + 1]
                      [#assign resultList = myListOfLocalVariables]
                    [/#if][#-- if exist --]
                    [/#if][#-- if global --]
                [#else][#-- if context?? --]
            [/#if]
            [/#if][#-- if struct --]
        [/#list][#-- list method.arguments --]
        [/#if]
    [/#list][#-- list methodList1 --]
[#return nbVars]
[/#function]
[#-- function getNbVariable of a config End--]