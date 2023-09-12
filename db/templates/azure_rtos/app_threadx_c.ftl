[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_threadx.c
  * @author  MCD Application Team
  * @brief   ThreadX applicative file
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2020 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under Ultimate Liberty license
  * SLA0044, the "License"; You may not use this file except in compliance with
  * the License. You may obtain a copy of the License at:
  *                             www.st.com/SLA0044
  *
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign TX_ENABLED = "true"]
[#assign FX_ENABLED = "false"]
[#assign NX_ENABLED = "false"]
[#assign UX_HOST_ENABLED = "false"]
[#assign UX_DEVICE_ENABLED = "false"]
[#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = "1"]
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
	
    [#if name == "FILEX_ENABLED" && value == "true"]
      [#assign FX_ENABLED = value]
    [/#if]    
	[#if name == "NETXDUO_ENABLED" && value == "true"]
      [#assign NX_ENABLED = value]
    [/#if]
	[#if name == "USBXDEVICE_ENABLED" && value == "true"]
      [#assign UX_DEVICE_ENABLED = value]
    [/#if]
	[#if name == "USBXHOST_ENABLED" && value == "true"]
      [#assign UX_HOST_ENABLED = value]
    [/#if]
	 [#if name == "AZRTOS_APP_MEM_ALLOCATION_METHOD"]
      [#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = value]
    [/#if]
	[#if name == "TX_LOW_POWER"]
      [#assign TX_LOW_POWER_value = value]
    [/#if]
	
	[#if name == "TX_LOW_POWER_TIMER_SETUP"]
      [#assign TX_LOW_POWER_TIMER_SETUP_value = value]
    [/#if]
	
	[#if name == "TX_LOW_POWER_USER_ENTER"]
      [#assign TX_LOW_POWER_USER_ENTER_value = value]
    [/#if]
	
	[#if name == "TX_LOW_POWER_USER_EXIT"]
      [#assign TX_LOW_POWER_USER_EXIT_value = value]
    [/#if]
	
	[#if name == "TX_LOW_POWER_USER_TIMER_ADJUST"]
      [#assign TX_LOW_POWER_USER_TIMER_ADJUST_value = value]
    [/#if]
    [/#list]
[/#if]
[/#list]
[/#compress]

/* Includes ------------------------------------------------------------------*/
#include "app_threadx.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

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
  
/**
  * @brief  Application ThreadX Initialization.
  * @param memory_ptr: memory pointer
  * @retval int
  */
UINT App_ThreadX_Init(VOID *memory_ptr)
{
  UINT ret = TX_SUCCESS;
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL  != "0"]
  TX_BYTE_POOL *byte_pool = (TX_BYTE_POOL*)memory_ptr;
  
   /* USER CODE BEGIN App_ThreadX_MEM_POOL */
  (void)byte_pool;
  /* USER CODE END App_ThreadX_MEM_POOL */
[/#if]

  /* USER CODE BEGIN App_ThreadX_Init */
  /* USER CODE END App_ThreadX_Init */
  
  return ret;
}

  /**
  * @brief  MX_ThreadX_Init
  * @param  None 
  * @retval None
  */
void MX_ThreadX_Init(void)
{
  /* USER CODE BEGIN  Before_Kernel_Start */
    
  /* USER CODE END  Before_Kernel_Start */
    
  tx_kernel_enter();
  
  /* USER CODE BEGIN  Kernel_Start_Error */
    
  /* USER CODE END  Kernel_Start_Error */
}

[#if TX_LOW_POWER_value == "1"]
[#if TX_LOW_POWER_TIMER_SETUP_value != " " && TX_LOW_POWER_TIMER_SETUP_value != ""]

/**
  * @brief  ${TX_LOW_POWER_TIMER_SETUP_value}
  * @param  count : TX timer count
  * @retval None
  */
void ${TX_LOW_POWER_TIMER_SETUP_value}(ULONG count)
{
  /* USER CODE BEGIN  ${TX_LOW_POWER_TIMER_SETUP_value} */

  /* USER CODE END  ${TX_LOW_POWER_TIMER_SETUP_value} */
}
[/#if]
[#if TX_LOW_POWER_USER_ENTER_value != " " && TX_LOW_POWER_USER_ENTER_value != ""]

/**
  * @brief  ${TX_LOW_POWER_USER_ENTER_value}
  * @param  None
  * @retval None
  */
void ${TX_LOW_POWER_USER_ENTER_value}()
{
  /* USER CODE BEGIN  ${TX_LOW_POWER_USER_ENTER_value} */

  /* USER CODE END  ${TX_LOW_POWER_USER_ENTER_value} */
}
[/#if]
[#if TX_LOW_POWER_USER_EXIT_value != " " && TX_LOW_POWER_USER_EXIT_value != ""]

/**
  * @brief  ${TX_LOW_POWER_USER_EXIT_value}
  * @param  None
  * @retval None
  */
void ${TX_LOW_POWER_USER_EXIT_value}()
{
  /* USER CODE BEGIN  ${TX_LOW_POWER_USER_EXIT_value} */

  /* USER CODE END  ${TX_LOW_POWER_USER_EXIT_value} */
}
[/#if]
[#if TX_LOW_POWER_USER_TIMER_ADJUST_value != " " && TX_LOW_POWER_USER_TIMER_ADJUST_value != ""]

/**
  * @brief  ${TX_LOW_POWER_USER_TIMER_ADJUST_value}
  * @param  None
  * @retval Amount of time (in ticks)
  */
ULONG ${TX_LOW_POWER_USER_TIMER_ADJUST_value}()
{
  /* USER CODE BEGIN  ${TX_LOW_POWER_USER_TIMER_ADJUST_value} */
  return 0;
  /* USER CODE END  ${TX_LOW_POWER_USER_TIMER_ADJUST_value} */
}
[/#if]
[/#if]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
