[#ftl]
[#assign moduleName = "none"]
[#if ModuleName??]
    [#assign moduleName = ModuleName]
[/#if]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_${moduleName?lower_case}.c
  * @author  MCD Application Team
  * @brief   ${moduleName?lower_case} application implementation file
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

/* Includes ------------------------------------------------------------------*/

#include "app_${moduleName?lower_case}.h"
[#if includes??]
[#list includes as include]
#include "${include}"
[/#list]
[/#if]

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

[#assign GEN_TX_INIT_CODE = "false"]
[#assign GEN_FX_INIT_CODE = "false"]
[#assign GEN_NX_INIT_CODE = "false"]
[#assign GEN_UX_HOST_INIT_CODE = "false"]
[#assign GEN_UX_DEVICE_INIT_CODE = "false"]

[#if RTEdatas??]
[#list RTEdatas as define]

[#if define?contains("THREADX_ENABLED")]
[#assign GEN_TX_INIT_CODE = "true"]
[/#if]

[#if define?contains("FILEX_ENABLED")]
[#assign GEN_FX_INIT_CODE = "true"]
[/#if]

[#if define?contains("NETXDUO_ENABLED")]
[#assign GEN_NX_INIT_CODE = "true"]
[/#if]

[#if define?contains("USBXHOST_ENABLED")]
[#assign GEN_UX_HOST_INIT_CODE = "true"]
[/#if]

[#if define?contains("USBXDEVICE_ENABLED")]
[#assign GEN_UX_DEVICE_INIT_CODE = "true"]
[/#if]

[/#list]
[/#if]
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
  * @brief  Define the initial system.
  * @param  first_unused_memory : Pointer to the first unused memory
  * @retval None
  */
VOID tx_application_define(VOID *first_unused_memory)
{
    VOID *memory_ptr = first_unused_memory;
    /* USER CODE BEGIN  tx_application_define */

    /* USER CODE END  tx_application_define */

[#if GEN_TX_INIT_CODE == "true" && GEN_NX_INIT_CODE == "false" && GEN_FX_INIT_CODE == "false" && GEN_UX_HOST_INIT_CODE == "false" && GEN_UX_DEVICE_INIT_CODE == "false" ]
    if (App_ThreadX_Init(memory_ptr) != TX_SUCCESS)
    {
        /* USER CODE BEGIN  App_ThreadX_Init_Error */
      
        /* USER CODE END  App_ThreadX_Init_Error */
    }
    /* USER CODE BEGIN  App_ThreadX_Init_Success */
      
    /* USER CODE END  App_ThreadX_Init_Success */
[/#if]
[#if GEN_FX_INIT_CODE == "true"]
    if (App_FileX_Init(memory_ptr) != FX_SUCCESS)
    {
        /* USER CODE BEGIN  App_FileX_Init_Error */
      
        /* USER CODE END  App_FileX_Init_Error */
    }
    /* USER CODE BEGIN  App_FileX_Init_Success */
  
    /* USER CODE END  App_FileX_Init_Success */

[/#if]
[#if GEN_NX_INIT_CODE == "true"]
    if (App_NetXDuo_Init(memory_ptr) != NX_SUCCESS)
    {
      /* USER CODE BEGIN  App_NetXDuo_Init_Error */
      
      /* USER CODE END  App_NetXDuo_Init_Error */
    }
    /* USER CODE BEGIN  App_NetXDuo_Init_Success */
  
    /* USER CODE END App_NetXDuo_Init_Success */
[/#if]
[#if GEN_UX_HOST_INIT_CODE == "true"]
    if (App_USBX_Host_Init(memory_ptr) != UX_SUCCESS)
    {
      /* USER CODE BEGIN  App_USBX_Host_Init_Error */
      
      /* USER CODE END  App_USBX_Host_Init_Error */
    }
    /* USER CODE BEGIN  App_USBX_Host_Init_Success */
      
    /* USER CODE END  App_USBX_Host_Init_Success */ 
[/#if]
[#if GEN_UX_DEVICE_INIT_CODE == "true"]
    if (App_USBX_Device_Init(memory_ptr) != UX_SUCCESS)
    {
      /* USER CODE BEGIN  App_USBX_Device_Init_Error */
      
      /* USER CODE END  App_USBX_Device_Init_Error */
    }
    /* USER CODE BEGIN  App_USBX_Device_Init_Success */
      
    /* USER CODE END  App_USBX_Device_Init_Success */
[/#if]
}

/**
  * @brief  ${fctName}
  * @param  None 
  * @retval None
  */
void ${fctName}(void)
{
  /* USER CODE BEGIN  Before_Kernel_Start */
    
  /* USER CODE END  Before_Kernel_Start */
    
  tx_kernel_enter();
  
  /* USER CODE BEGIN  Kernel_Start_Error */
    
  /* USER CODE END  Kernel_Start_Error */
}


/**
  * @brief  ${fctProcessName}
  * @param  None
  * @retval None
  */
void ${fctProcessName}(void)
{
  /* USER CODE BEGIN  1 */

  /* USER CODE END  1 */

}