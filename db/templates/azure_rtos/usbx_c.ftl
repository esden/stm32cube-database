[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
  * File Name          : app_usbx.c
  * Description        : This file provides code for the configuration
  *                      of the ${name?lower_case} instances.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]  
  ******************************************************************************
  */
[#-- 'UserCode sections' are indexed dynamically --]
		
/* Includes ------------------------------------------------------------------*/
#include "app_usbx.h" 

/* Global variables ---------------------------------------------------------*/

UINT MX_USBX_Init(void)
{
#tUINT ret = UX_SUCCESS;
#t/* USER CODE BEGIN  USBX_Init */
	
#t/* USER CODE END  USBX_Init */
#treturn ret;
}

[#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = "1" ]
[#assign USBX_HOST_ENABLED = "false" ]
[#assign USBX_DEVICE_ENABLED = "1" ]
[#compress]
[#if SWIPdatas??]
 [#list SWIPdatas as SWIP]
  [#if SWIP.variables??]
   [#list SWIP.variables as variable]
	[#assign value = variable.value]
    [#assign name = variable.name]
	 [#if name.contains("AZRTOS_APP_MEM_ALLOCATION_METHOD")]
      [#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = value]
    [/#if]
	[#if name?contains("UX_Host_CoreStack") && value == "1"]
	  [#assign USBX_HOST_ENABLED = "true" ]
	[/#if]
	[#if name?contains("UX_Device_CoreStack") && value == "1"]
	 [#assign USBX_DEVICE_ENABLED = "true" ]
	[/#if]
   [/#list]
  [/#if]
 [/#list]
[/#if]
[/#compress]



[#-- USBX device ----------------------------------------------------------------------------------------------------------------------------------------------------------------- --]
[#if USBX_DEVICE_ENABLED == "true"]
/**
  * @brief  Application USBX Device Initialization.
  * @param memory_ptr: memory pointer
  * @retval int
  */
UINT MX_USBX_Device_Init(VOID *memory_ptr)
{
  #tUINT ret = UX_SUCCESS;
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL  != "0"]
  #tTX_BYTE_POOL *byte_pool = (TX_BYTE_POOL*)memory_ptr;
[/#if]
  /* USER CODE BEGIN App_USBX_Device_Init */
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL  != "0"]
  #t(void)byte_pool;
[/#if]
  /* USER CODE END App_USBX_Device_Init */

  #treturn ret;
}
[/#if]

[#-- USBX host -------------------------------------------------------------------------------------------------------------------------------------------------------------- --]

[#if USBX_HOST_ENABLED == "true"] 
/**
  * @brief  Application USBX Host Initialization.
  * @param memory_ptr: memory pointer
  * @retval int
  */
UINT MX_USBX_Host_Init(VOID *memory_ptr)
{
  #tUINT ret = UX_SUCCESS;
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL  != "0"]
  TX_BYTE_POOL *byte_pool = (TX_BYTE_POOL*)memory_ptr;
[/#if]
  /* USER CODE BEGIN App_USBX_Host_Init */
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL  != "0"]
  (void)byte_pool;
[/#if]
  /* USER CODE END App_USBX_Host_Init */

  #treturn ret;
}
[/#if]

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
