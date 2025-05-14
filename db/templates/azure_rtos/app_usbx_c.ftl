[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_usbx.c
  * @author  MCD Application Team
  * @brief   USBX applicative file
  ******************************************************************************
  [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = "1" ]
[#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE_VAL = "1" ]
[#assign USBX_DEVICE_CLASS_NB = 0]
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
    [#if name == "AZRTOS_APP_MEM_ALLOCATION_METHOD"]
      [#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = value]
    [/#if]
	[#if name == "UX_STANDALONE"]
      [#assign UX_STANDALONE_ENABLED_Value = value]
    [/#if]
    [#if name == "AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE"]
      [#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE_VAL = value]
    [/#if]
    [#if name == "REG_UX_HOST_CORE"]
      [#assign REG_UX_HOST_CORE_value = value]
    [/#if]
	[#if name == "REG_UX_DEVICE_CORE"]
      [#assign REG_UX_DEVICE_CORE_value = value]
    [/#if]
    [#if name == "USBXDEVICE_ENABLED"]
      [#assign USBXDEVICE_ENABLED_value = value]
    [/#if]
	[#if name == "USBXHOST_ENABLED"]
      [#assign USBXHOST_ENABLED_value = value]
    [/#if]
    [#if name == "REG_UX_HOST_THREAD"]
      [#assign REG_UX_HOST_THREAD_value = value]
    [/#if]
	[#if name == "REG_UX_DEVICE_HID_MOUSE"]
      [#assign REG_UX_DEVICE_HID_MOUSE_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_HID_KEYBOARD"]
      [#assign REG_UX_DEVICE_HID_KEYBOARD_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_HID_CUSTOM"]
      [#assign REG_UX_DEVICE_HID_CUSTOM_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_STORAGE"]
      [#assign REG_UX_DEVICE_STORAGE_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_CDC_ACM"]
      [#assign REG_UX_DEVICE_CDC_ACM_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_CDC_ECM"]
      [#assign REG_UX_DEVICE_CDC_ECM_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_DFU"]
      [#assign REG_UX_DEVICE_DFU_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_PIMA_MTP"]
      [#assign REG_UX_DEVICE_PIMA_MTP_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_RNDIS"]
      [#assign REG_UX_DEVICE_RNDIS_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_THREAD"]
      [#assign REG_UX_DEVICE_THREAD_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_VIDEO"]
      [#assign REG_UX_DEVICE_VIDEO_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_CCID"]
      [#assign REG_UX_DEVICE_CCID_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_PRINTER"]
      [#assign REG_UX_DEVICE_PRINTER_value = value]
    [/#if]
   [/#list]
[/#if]
[/#list]
[/#compress]

[#if REG_UX_DEVICE_HID_MOUSE_value == "1"]
  [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
[/#if]
[#if REG_UX_DEVICE_HID_KEYBOARD_value == "1"]
  [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
[/#if]
[#if REG_UX_DEVICE_HID_CUSTOM_value == "1"]
  [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
[/#if]
[#if REG_UX_DEVICE_STORAGE_value == "1"]
  [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
[/#if]
[#if REG_UX_DEVICE_CDC_ACM_value == "1"]
  [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
[/#if]
[#if REG_UX_DEVICE_CDC_ECM_value == "1"]
  [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
[/#if]
[#if REG_UX_DEVICE_DFU_value == "1"]
  [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
[/#if]
[#if REG_UX_DEVICE_PIMA_MTP_value == "1"]
  [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
[/#if]
[#if REG_UX_DEVICE_RNDIS_value == "1"]
  [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
[/#if]
[#if REG_UX_DEVICE_VIDEO_value == "1"]
  [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
[/#if]
[#if REG_UX_DEVICE_CCID_value == "1"]
  [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
[/#if]
[#if REG_UX_DEVICE_PRINTER_value == "1"]
  [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
[/#if]
/* Includes ------------------------------------------------------------------*/
#include "app_usbx.h"
[#if USBXDEVICE_ENABLED_value == "1"]
#include "app_usbx_device.h"
[/#if]
[#if USBXHOST_ENABLED_value == "1"]
#include "app_usbx_host.h"
[/#if]

[#if UX_STANDALONE_ENABLED_Value == "1" && AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE_VAL  != "0" ]

/* USER CODE BEGIN UX_Memory_Buffer */

/* USER CODE END UX_Memory_Buffer */
#if defined ( __ICCARM__ )
#pragma data_alignment=4
#endif
__ALIGN_BEGIN static UCHAR ux_byte_pool_buffer[UX_APP_MEM_POOL_SIZE] __ALIGN_END;
[/#if]


/**
  * @brief  Application USBX Initialization.
[#if UX_STANDALONE_ENABLED_Value == "1"]
  * @param  none
[#else]
  * @param  memory_ptr: memory pointer
[/#if]
  * @retval status
  */
[#if UX_STANDALONE_ENABLED_Value == "0"]
UINT MX_USBX_Init(VOID *memory_ptr)
[#else]
UINT MX_USBX_Init(VOID)
[/#if]
{
  UINT ret = UX_SUCCESS;
[#if UX_STANDALONE_ENABLED_Value == "1" && AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE_VAL  != "0" ]
  UCHAR *pointer;
[/#if]

[#if UX_STANDALONE_ENABLED_Value == "0" && AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL  != "0" ]
  UCHAR *pointer;
  TX_BYTE_POOL *byte_pool = (TX_BYTE_POOL*)memory_ptr;
[/#if]

  /* USER CODE BEGIN MX_USBX_Init0 */
[#if (REG_UX_HOST_CORE_value  == "false" || REG_UX_DEVICE_CORE_value  == "false") && UX_STANDALONE_ENABLED_Value == "1"]

  UX_PARAMETER_NOT_USED(ux_byte_pool_buffer);
[#else]

[/#if]
  /* USER CODE END MX_USBX_Init0 */
  
[#if UX_STANDALONE_ENABLED_Value == "0"]
  /* Allocate the stack for USBX Memory */
  if (tx_byte_allocate(byte_pool, (VOID **) &pointer,
                       USBX_MEMORY_STACK_SIZE, TX_NO_WAIT) != TX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_ALLOCATE_STACK_ERROR */
    return TX_POOL_ERROR;
    /* USER CODE END USBX_ALLOCATE_STACK_ERROR */
  }
[#else]
  pointer = ux_byte_pool_buffer;
[/#if]

  /* Initialize USBX Memory */
  if (ux_system_initialize(pointer, USBX_MEMORY_STACK_SIZE, UX_NULL, 0) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_SYSTEM_INITIALIZE_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_SYSTEM_INITIALIZE_ERROR */
  }

[#if USBXDEVICE_ENABLED_value == "true"]
[#if UX_STANDALONE_ENABLED_Value == "0"]
  ret = MX_USBX_Device_Init(byte_pool);
[#else]
  ret = MX_USBX_Device_Init();
[/#if]
  if(ret != UX_SUCCESS)
  {
  /* USER CODE BEGIN MX_USBX_Device_Init_Error */
    while(1)
    {
    }
  /* USER CODE END MX_USBX_Device_Init_Error */
  }
[/#if]

[#if USBXHOST_ENABLED_value == "true"]
[#if UX_STANDALONE_ENABLED_Value == "0"]
  ret = MX_USBX_Host_Init(byte_pool);
[#else]
  ret = MX_USBX_Host_Init();
[/#if]
  if(ret != UX_SUCCESS){
  /* USER CODE BEGIN MX_USBX_Host_Init_Error */
    while(1)
    {
    }
  /* USER CODE END MX_USBX_Host_Init_Error */
  }
[/#if]


  /* USER CODE BEGIN MX_USBX_Init1 */

  /* USER CODE END MX_USBX_Init1 */


  return ret; 
}

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */