[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_usbx_host.c
  * @author  MCD Application Team
  * @brief   USBX host applicative file
  ******************************************************************************
  [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = "1" ]
[#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE_VAL = "1" ]
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
    [#if name == "AZRTOS_APP_MEM_ALLOCATION_METHOD"]
      [#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = value]
    [/#if]
    [#if name == "REG_UX_HOST_CORE"]
      [#assign REG_UX_HOST_CORE_value = value]
    [/#if]
	[#if name == "REG_UX_HOST_HUB"]
      [#assign REG_UX_HOST_HUB_value = value]
    [/#if]
    [#if name == "REG_UX_HOST_HID_MOUSE"]
      [#assign REG_UX_HOST_HID_MOUSE_value = value]
    [/#if]
    [#if name == "REG_UX_HOST_HID_KEYBOARD"]
      [#assign REG_UX_HOST_HID_KEYBOARD_value = value]
    [/#if]
    [#if name == "REG_UX_HOST_HID_RCU"]
      [#assign REG_UX_HOST_HID_RCU_value = value]
    [/#if]
    [#if name == "REG_UX_HOST_Mass_Storage"]
      [#assign REG_UX_HOST_MSC_value = value]
    [/#if]
    [#if name == "REG_UX_HOST_CDC_ACM"]
      [#assign REG_UX_HOST_CDC_ACM_value = value]
    [/#if]
    [#if name == "USBX_HOST_APP_THREAD_NAME"]
      [#assign USBX_HOST_APP_THREAD_NAME_value = value]
    [/#if]
    [#if name == "REG_UX_HOST_THREAD"]
      [#assign REG_UX_HOST_THREAD_value = value]
    [/#if]
    [#if name == "AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE"]
      [#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE_VAL = value]
    [/#if]
    [#if name == "UX_STANDALONE"]
      [#assign UX_STANDALONE_ENABLED_Value = value]
    [/#if]


   [/#list]
[/#if]
[/#list]
[/#compress]
/* Includes ------------------------------------------------------------------*/
#include "app_usbx_host.h"

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
[#if !FamilyName?lower_case?starts_with("stm32n6")]
[#if UX_STANDALONE_ENABLED_Value == "1" && AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE_VAL  != "0" ]

/* USER CODE BEGIN UX_Host_Memory_Buffer */

/* USER CODE END UX_Host_Memory_Buffer */
#if defined ( __ICCARM__ )
#pragma data_alignment=4
#endif
__ALIGN_BEGIN static UCHAR ux_host_byte_pool_buffer[UX_HOST_APP_MEM_POOL_SIZE] __ALIGN_END;
[/#if]
[/#if]
[#if REG_UX_HOST_THREAD_value == "1" && UX_STANDALONE_ENABLED_Value == "0"]
static TX_THREAD ux_host_app_thread;
[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
[#if REG_UX_HOST_THREAD_value == "1" && UX_STANDALONE_ENABLED_Value == "0"]
static VOID ${USBX_HOST_APP_THREAD_NAME_value}(ULONG thread_input);
[/#if]
[#if REG_UX_HOST_CORE_value == "true"]
static UINT ux_host_event_callback(ULONG event, UX_HOST_CLASS *current_class, VOID *current_instance);
static VOID ux_host_error_callback(UINT system_level, UINT system_context, UINT error_code);
[/#if]
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/**
  * @brief  Application USBX Host Initialization.
[#if UX_STANDALONE_ENABLED_Value == "1"]
  * @param  none
[#else]
  * @param  memory_ptr: memory pointer
[/#if]
  * @retval status
  */
[#if UX_STANDALONE_ENABLED_Value == "1"]
UINT MX_USBX_Host_Init(VOID)
[#else]
UINT MX_USBX_Host_Init(VOID *memory_ptr)
[/#if]
{
  UINT ret = UX_SUCCESS;
[#if REG_UX_HOST_CORE_value  == "true" && UX_STANDALONE_ENABLED_Value == "1" && AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE_VAL  != "0" && !FamilyName?lower_case?starts_with("stm32n6")]
  UCHAR *pointer;
[/#if]

[#if (REG_UX_HOST_CORE_value  == "true" || REG_UX_HOST_THREAD_value == "1") && UX_STANDALONE_ENABLED_Value == "0" && AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL  != "0" ]
  UCHAR *pointer;
  TX_BYTE_POOL *byte_pool = (TX_BYTE_POOL*)memory_ptr;
[/#if]

  /* USER CODE BEGIN MX_USBX_Host_Init0 */
[#if !FamilyName?lower_case?starts_with("stm32n6")]
[#if REG_UX_HOST_CORE_value  == "false" && UX_STANDALONE_ENABLED_Value == "1"]
  UX_PARAMETER_NOT_USED(ux_host_byte_pool_buffer);
[#else]

[/#if]
[/#if]
  /* USER CODE END MX_USBX_Host_Init0 */

[#if REG_UX_HOST_CORE_value  == "true"]
[#if !FamilyName?lower_case?starts_with("stm32n6")]
[#if UX_STANDALONE_ENABLED_Value == "0"]
  /* Allocate the stack for USBX Memory */
  if (tx_byte_allocate(byte_pool, (VOID **) &pointer,
                       USBX_HOST_MEMORY_STACK_SIZE, TX_NO_WAIT) != TX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_ALLOCATE_STACK_ERROR */
    return TX_POOL_ERROR;
    /* USER CODE END USBX_ALLOCATE_STACK_ERROR */
  }
[#else]
  pointer = ux_host_byte_pool_buffer;
[/#if]
[#if !FamilyName?lower_case?starts_with("stm32n6")]
  /* Initialize USBX Memory */
  if (ux_system_initialize(pointer, USBX_HOST_MEMORY_STACK_SIZE, UX_NULL, 0) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_SYSTEM_INITIALIZE_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_SYSTEM_INITIALIZE_ERROR */
  }
[/#if]
[/#if]
  /* Install the host portion of USBX */
  if (ux_host_stack_initialize(ux_host_event_callback) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_HOST_INITIALIZE_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_HOST_INITIALIZE_ERROR */
  }

  /* Register a callback error function */
  ux_utility_error_callback_register(&ux_host_error_callback);
[#if !FamilyName?lower_case?starts_with("stm32n6")]
[#if REG_UX_HOST_HUB_value??]
[#if REG_UX_HOST_HUB_value == "1"]
  /* Initialize the host hub class */
  if (ux_host_stack_class_register(_ux_system_host_class_hub_name,
                                   ux_host_class_hub_entry) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_HOST_HUB_REGISTER_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_HOST_HUB_REGISTER_ERROR */
  }
[/#if]
[/#if]

[#if (REG_UX_HOST_HID_MOUSE_value == "1" || REG_UX_HOST_HID_KEYBOARD_value == "1" || REG_UX_HOST_HID_RCU_value == "1" )]
  /* Initialize the host hid class */
  if (ux_host_stack_class_register(_ux_system_host_class_hid_name,
                                   ux_host_class_hid_entry) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_HSOT_HID_REGISTER_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_HSOT_HID_REGISTER_ERROR */
  }
[/#if]

[#if REG_UX_HOST_HID_MOUSE_value == "1"]
  /* Initialize the host hid mouse client */
  if (ux_host_class_hid_client_register(_ux_system_host_class_hid_client_mouse_name,
                                        ux_host_class_hid_mouse_entry) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_HOST_HID_MOUSE_REGISTER_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_HOST_HID_MOUSE_REGISTER_ERROR */
  }
[/#if]

[#if REG_UX_HOST_HID_KEYBOARD_value == "1"]
  /* Initialize the host hid keyboard client */
  if (ux_host_class_hid_client_register(_ux_system_host_class_hid_client_keyboard_name,
                                        ux_host_class_hid_keyboard_entry) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_HOST_HID_KEYBOARD_REGISTER_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_HOST_HID_KEYBOARD_REGISTER_ERROR */
  }
[/#if]

[#if REG_UX_HOST_HID_RCU_value == "1"]
  /* Initialize the host hid rcu client */
  if (ux_host_class_hid_client_register(_ux_system_host_class_hid_client_remote_control_name,
                                        ux_host_class_hid_remote_control_entry) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_HOST_HID_RCU_REGISTER_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_HOST_HID_RCU_REGISTER_ERROR */
  }
[/#if]
[#if REG_UX_HOST_MSC_value == "1"]
  /* Initialize the host storage class */
  if (ux_host_stack_class_register(_ux_system_host_class_storage_name,
                                   ux_host_class_storage_entry) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_HOST_STORAGE_REGISTER_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_HOST_STORAGE_REGISTER_ERROR */
  }
[/#if]

[#if REG_UX_HOST_CDC_ACM_value == "1"]
  /* Initialize the host cdc acm class */
  if ((ux_host_stack_class_register(_ux_system_host_class_cdc_acm_name,
                                    ux_host_class_cdc_acm_entry)) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_HOST_CDC_ACM_REGISTER_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_HOST_CDC_ACM_REGISTER_ERROR */
  }
[/#if]
[/#if]
[/#if]

[#if REG_UX_HOST_THREAD_value == "1" && UX_STANDALONE_ENABLED_Value == "0"]
  /* Allocate the stack for host application main thread */
  if (tx_byte_allocate(byte_pool, (VOID **) &pointer, UX_HOST_APP_THREAD_STACK_SIZE,
                       TX_NO_WAIT) != TX_SUCCESS)
  {
    /* USER CODE BEGIN MAIN_THREAD_ALLOCATE_STACK_ERROR */
    return TX_POOL_ERROR;
    /* USER CODE END MAIN_THREAD_ALLOCATE_STACK_ERROR */
  }

  /* Create the host application main thread */
  if (tx_thread_create(&ux_host_app_thread, UX_HOST_APP_THREAD_NAME, ${USBX_HOST_APP_THREAD_NAME_value},
                       0, pointer, UX_HOST_APP_THREAD_STACK_SIZE, UX_HOST_APP_THREAD_PRIO,
                       UX_HOST_APP_THREAD_PREEMPTION_THRESHOLD, UX_HOST_APP_THREAD_TIME_SLICE,
                       UX_HOST_APP_THREAD_START_OPTION) != TX_SUCCESS)
  {
    /* USER CODE BEGIN MAIN_THREAD_CREATE_ERROR */
    return TX_THREAD_ERROR;
    /* USER CODE END MAIN_THREAD_CREATE_ERROR */
  }

[/#if]
  /* USER CODE BEGIN MX_USBX_Host_Init1 */

  /* USER CODE END MX_USBX_Host_Init1 */

  return ret;
}


[#if REG_UX_HOST_THREAD_value == "1" && UX_STANDALONE_ENABLED_Value == "0"]
/**
  * @brief  Function implementing ${USBX_HOST_APP_THREAD_NAME_value}.
  * @param  thread_input: User thread input parameter.
  * @retval none
  */
static VOID ${USBX_HOST_APP_THREAD_NAME_value}(ULONG thread_input)
{
  /* USER CODE BEGIN ${USBX_HOST_APP_THREAD_NAME_value} */
  TX_PARAMETER_NOT_USED(thread_input);
  /* USER CODE END ${USBX_HOST_APP_THREAD_NAME_value} */
}
[/#if]

[#if UX_STANDALONE_ENABLED_Value == "1" && !FamilyName?lower_case?starts_with("stm32n6")]
/**
  * @brief  _ux_utility_interrupt_disable
  *         USB utility interrupt disable.
  * @param  none
  * @retval none
  */
ALIGN_TYPE _ux_utility_interrupt_disable(VOID)
{
  /* USER CODE BEGIN _ux_utility_interrupt_disable */
  return(0);
  /* USER CODE END _ux_utility_interrupt_disable */
}

/**
  * @brief  _ux_utility_interrupt_restore
  *         USB utility interrupt restore.
  * @param  flags
  * @retval none
  */
VOID _ux_utility_interrupt_restore(ALIGN_TYPE flags)
{
  /* USER CODE BEGIN _ux_utility_interrupt_restore */
  UX_PARAMETER_NOT_USED(flags);
  /* USER CODE END _ux_utility_interrupt_restore */
}

/**
  * @brief  _ux_utility_time_get
  *         Get Time Tick for host timing.
  * @param  none
  * @retval time tick
  */
ULONG _ux_utility_time_get(VOID)
{
  ULONG time_tick = 0U;

  /* USER CODE BEGIN _ux_utility_time_get */

  /* USER CODE END _ux_utility_time_get */

  return time_tick;
}
[/#if]

[#if REG_UX_HOST_CORE_value == "true"]
/**
  * @brief  ux_host_event_callback
  *         This callback is invoked to notify application of instance changes.
  * @param  event: event code.
  * @param  current_class: Pointer to class.
  * @param  current_instance: Pointer to class instance.
  * @retval status
  */
UINT ux_host_event_callback(ULONG event, UX_HOST_CLASS *current_class, VOID *current_instance)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN ux_host_event_callback0 */
  UX_PARAMETER_NOT_USED(current_class);
  UX_PARAMETER_NOT_USED(current_instance);
  /* USER CODE END ux_host_event_callback0 */

  switch (event)
  {
    case UX_DEVICE_INSERTION:

      /* USER CODE BEGIN UX_DEVICE_INSERTION */

      /* USER CODE END UX_DEVICE_INSERTION */

      break;

    case UX_DEVICE_REMOVAL:

      /* USER CODE BEGIN UX_DEVICE_REMOVAL */

      /* USER CODE END UX_DEVICE_REMOVAL */

      break;

[#if (REG_UX_HOST_HID_MOUSE_value == "1" || REG_UX_HOST_HID_KEYBOARD_value == "1" )]
    case UX_HID_CLIENT_INSERTION:

      /* USER CODE BEGIN UX_HID_CLIENT_INSERTION */

      /* USER CODE END UX_HID_CLIENT_INSERTION */

      break;

    case UX_HID_CLIENT_REMOVAL:

      /* USER CODE BEGIN UX_HID_CLIENT_REMOVAL */

      /* USER CODE END UX_HID_CLIENT_REMOVAL */

      break;
[/#if]

    case UX_DEVICE_CONNECTION:

      /* USER CODE BEGIN UX_DEVICE_CONNECTION */

      /* USER CODE END UX_DEVICE_CONNECTION */

      break;

    case UX_DEVICE_DISCONNECTION:

      /* USER CODE BEGIN UX_DEVICE_DISCONNECTION */

      /* USER CODE END UX_DEVICE_DISCONNECTION */

      break;

    default:

      /* USER CODE BEGIN EVENT_DEFAULT */

      /* USER CODE END EVENT_DEFAULT */

      break;
  }

  /* USER CODE BEGIN ux_host_event_callback1 */

  /* USER CODE END ux_host_event_callback1 */

  return status;
}
[/#if]


[#if REG_UX_HOST_CORE_value == "true"]
/**
  * @brief ux_host_error_callback
  *         This callback is invoked to notify application of error changes.
  * @param  system_level: system level parameter.
  * @param  system_context: system context code.
  * @param  error_code: error event code.
  * @retval Status
  */
VOID ux_host_error_callback(UINT system_level, UINT system_context, UINT error_code)
{
  /* USER CODE BEGIN ux_host_error_callback0 */
  UX_PARAMETER_NOT_USED(system_level);
  UX_PARAMETER_NOT_USED(system_context);
  /* USER CODE END ux_host_error_callback0 */

  switch (error_code)
  {
    case UX_DEVICE_ENUMERATION_FAILURE:

      /* USER CODE BEGIN UX_DEVICE_ENUMERATION_FAILURE */

      /* USER CODE END UX_DEVICE_ENUMERATION_FAILURE */

      break;

    case  UX_NO_DEVICE_CONNECTED:

      /* USER CODE BEGIN UX_NO_DEVICE_CONNECTED */

      /* USER CODE END UX_NO_DEVICE_CONNECTED */

      break;

    default:

      /* USER CODE BEGIN ERROR_DEFAULT */

      /* USER CODE END ERROR_DEFAULT */

      break;
  }

  /* USER CODE BEGIN ux_host_error_callback1 */

  /* USER CODE END ux_host_error_callback1 */
}
[/#if]
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
