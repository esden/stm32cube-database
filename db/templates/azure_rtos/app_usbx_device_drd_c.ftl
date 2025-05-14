[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_usbx_device.c
  * @author  MCD Application Team
  * @brief   USBX Device applicative file
  ******************************************************************************
  [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE_VAL = "1" ]
[#assign USBX_DEVICE_CLASS_NB = 0]
[#assign UX_STANDALONE_ENABLED_Value = ""]
[#assign REG_UX_DEVICE_CCID_value = ""]
[#assign REG_UX_DEVICE_PRINTER_value = ""]
[#assign REG_UX_DEVICE_VIDEO_value = ""]
[#assign UX_Device_Controller_value = "0" ]
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
    [#if name == "AZRTOS_APP_MEM_ALLOCATION_METHOD"]
      [#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = value]
    [/#if]
    [#if name == "AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE"]
      [#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_STANDALONE_VAL = value]
    [/#if]
    [#if name == "USBX_DEVICE_APP_THREAD_NAME"]
      [#assign USBX_DEVICE_APP_THREAD_NAME_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_THREAD"]
      [#assign REG_UX_DEVICE_THREAD_value = value]
    [/#if]
    [#if name == "REG_USBX_DEVICE_CON_CK"]
      [#assign REG_USBX_DEVICE_CON_CK_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_CORE"]
      [#assign REG_UX_DEVICE_CORE_value = value]
    [/#if]
    [#if name == "UX_DEVICE_HID_MOUSE"]
      [#assign UX_DEVICE_HID_MOUSE_value = value]
    [/#if]
    [#if name == "UX_DEVICE_HID_KEYBOARD"]
      [#assign UX_DEVICE_HID_KEYBOARD_value = value]
    [/#if]
    [#if name == "UX_DEVICE_HID_CUSTOM"]
      [#assign UX_DEVICE_HID_CUSTOM_value = value]
    [/#if]
    [#if name == "UX_DEVICE_STORAGE"]
      [#assign UX_DEVICE_STORAGE_value = value]
    [/#if]
    [#if name == "UX_DEVICE_CDC_ACM"]
      [#assign UX_DEVICE_CDC_ACM_value = value]
    [/#if]
    [#if name == "UX_DEVICE_CDC_ECM"]
      [#assign UX_DEVICE_CDC_ECM_value = value]
    [/#if]
    [#if name == "UX_DEVICE_DFU"]
      [#assign UX_DEVICE_DFU_value = value]
    [/#if]
    [#if name == "UX_DEVICE_PIMA_MTP"]
      [#assign UX_DEVICE_PIMA_MTP_value = value]
    [/#if]
    [#if name == "UX_DEVICE_RNDIS"]
      [#assign UX_DEVICE_RNDIS_value = value]
    [/#if]
    [#if name == "UX_DEVICE_VIDEO"]
      [#assign UX_DEVICE_VIDEO_value = value]
    [/#if]
    [#if name == "UX_DEVICE_CCID"]
      [#assign UX_DEVICE_CCID_value = value]
    [/#if]
    [#if name == "UX_DEVICE_PRINTER"]
      [#assign UX_DEVICE_PRINTER_value = value]
    [/#if]
    [#if name == "UX_STANDALONE"]
      [#assign UX_STANDALONE_ENABLED_Value = value]
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
    [#if name == "REG_UX_DEVICE_VIDEO"]
      [#assign REG_UX_DEVICE_VIDEO_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_CCID"]
      [#assign REG_UX_DEVICE_CCID_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_PRINTER"]
      [#assign REG_UX_DEVICE_PRINTER_value = value]
    [/#if]
	[#if name == "Dual_Role_Device_Enabled"]
      [#assign Dual_Role_Device_Enabled_value = value]
    [/#if]
	[#if name == "UX_Device_Controller"]
      [#assign UX_Device_Controller_value = value]
    [/#if]
   [/#list]
[/#if]
[/#list]
[/#compress]
	[#if UX_DEVICE_HID_MOUSE_value == "1"]
      [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
    [/#if]
    [#if UX_DEVICE_HID_KEYBOARD_value == "1"]
      [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
    [/#if]
    [#if UX_DEVICE_HID_CUSTOM_value == "1"]
      [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
    [/#if]
    [#if UX_DEVICE_STORAGE_value == "1"]
      [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
    [/#if]
    [#if UX_DEVICE_CDC_ACM_value == "1"]
      [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
    [/#if]
    [#if UX_DEVICE_CDC_ECM_value == "1"]
      [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
    [/#if]
    [#if UX_DEVICE_DFU_value == "1"]
      [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
    [/#if]
    [#if UX_DEVICE_PIMA_MTP_value == "1"]
      [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
    [/#if]
    [#if UX_DEVICE_RNDIS_value == "1"]
      [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
    [/#if]
    [#if UX_DEVICE_VIDEO_value == "1"]
      [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
    [/#if]
    [#if UX_DEVICE_CCID_value == "1"]
      [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
    [/#if]
    [#if UX_DEVICE_PRINTER_value == "1"]
      [#assign USBX_DEVICE_CLASS_NB = USBX_DEVICE_CLASS_NB+1]
    [/#if]
/* Includes ------------------------------------------------------------------*/
#include "app_usbx_device.h"
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

[#if REG_UX_DEVICE_HID_MOUSE_value == "1"]
static ULONG hid_mouse_interface_number;
static ULONG hid_mouse_configuration_number;
[/#if]
[#if REG_UX_DEVICE_HID_KEYBOARD_value == "1"]
static ULONG hid_keyboard_interface_number;
static ULONG hid_keyboard_configuration_number;
[/#if]
[#if REG_UX_DEVICE_HID_CUSTOM_value == "1"]
static ULONG hid_custom_interface_number;
static ULONG hid_custom_configuration_number;
[/#if]
[#if REG_UX_DEVICE_STORAGE_value == "1"]
static ULONG storage_interface_number;
static ULONG storage_configuration_number;
[/#if]
[#if REG_UX_DEVICE_CDC_ACM_value == "1"]
static ULONG cdc_acm_interface_number;
static ULONG cdc_acm_configuration_number;
[/#if]
[#if REG_UX_DEVICE_CDC_ECM_value == "1"]
static ULONG cdc_ecm_interface_number;
static ULONG cdc_ecm_configuration_number;
static UCHAR cdc_ecm_local_nodeid[UX_DEVICE_CLASS_CDC_ECM_NODE_ID_LENGTH];
static UCHAR cdc_ecm_remote_nodeid[UX_DEVICE_CLASS_CDC_ECM_NODE_ID_LENGTH];
[/#if]
[#if REG_UX_DEVICE_DFU_value == "1"]
static ULONG dfu_interface_number;
static ULONG dfu_configuration_number;
[/#if]
[#if REG_UX_DEVICE_PIMA_MTP_value == "1"]
static ULONG pima_mtp_interface_number;
static ULONG pima_mtp_configuration_number;
[/#if]
[#if REG_UX_DEVICE_RNDIS_value == "1"]
static ULONG rndis_interface_number;
static ULONG rndis_configuration_number;
static UCHAR rndis_local_nodeid[UX_DEVICE_CLASS_RNDIS_NODE_ID_LENGTH];
static UCHAR rndis_remote_nodeid[UX_DEVICE_CLASS_RNDIS_NODE_ID_LENGTH];
[/#if]
[#if REG_UX_DEVICE_VIDEO_value == "1"]
static ULONG video_interface_number;
static ULONG video_configuration_number;
[/#if]
[#if REG_UX_DEVICE_CCID_value == "1"]
static ULONG ccid_interface_number;
static ULONG ccid_configuration_number;
[/#if]
[#if REG_UX_DEVICE_PRINTER_value == "1"]
static ULONG printer_interface_number;
static ULONG printer_configuration_number;
[/#if]
[#if REG_UX_DEVICE_HID_MOUSE_value == "1"]
static UX_SLAVE_CLASS_HID_PARAMETER hid_mouse_parameter;
[/#if]
[#if REG_UX_DEVICE_HID_KEYBOARD_value == "1"]
static UX_SLAVE_CLASS_HID_PARAMETER hid_keyboard_parameter;
[/#if]
[#if REG_UX_DEVICE_HID_CUSTOM_value == "1"]
static UX_SLAVE_CLASS_HID_PARAMETER custom_hid_parameter;
[/#if]
[#if REG_UX_DEVICE_STORAGE_value == "1"]
static UX_SLAVE_CLASS_STORAGE_PARAMETER storage_parameter;
[/#if]
[#if REG_UX_DEVICE_CDC_ACM_value == "1"]
static UX_SLAVE_CLASS_CDC_ACM_PARAMETER cdc_acm_parameter;
[/#if]
[#if REG_UX_DEVICE_CDC_ECM_value == "1"]
static UX_SLAVE_CLASS_CDC_ECM_PARAMETER cdc_ecm_parameter;
[/#if]
[#if REG_UX_DEVICE_DFU_value == "1"]
static UX_SLAVE_CLASS_DFU_PARAMETER dfu_parameter;
[/#if]
[#if REG_UX_DEVICE_PIMA_MTP_value == "1"]
static UX_SLAVE_CLASS_PIMA_PARAMETER pima_mtp_parameter;
[/#if]
[#if REG_UX_DEVICE_RNDIS_value == "1"]
static UX_SLAVE_CLASS_RNDIS_PARAMETER rndis_parameter;
[/#if]
[#if REG_UX_DEVICE_VIDEO_value == "1"]
static UX_DEVICE_CLASS_VIDEO_PARAMETER video_parameter;
static UX_DEVICE_CLASS_VIDEO_STREAM_PARAMETER video_stream_parameter[USBD_VIDEO_STREAM_NMNBER];
[/#if]
[#if REG_UX_DEVICE_CCID_value == "1"]
static UX_DEVICE_CLASS_CCID_PARAMETER ccid_parameter;
[/#if]
[#if REG_UX_DEVICE_PRINTER_value == "1"]
static UX_DEVICE_CLASS_PRINTER_PARAMETER printer_parameter;
[/#if]
[#if REG_UX_DEVICE_THREAD_value == "1" && UX_STANDALONE_ENABLED_Value == "0"]
static TX_THREAD ux_device_app_thread;
[/#if]
[#if REG_UX_DEVICE_PIMA_MTP_value == "1" ]
extern USHORT USBD_MTP_DevicePropSupported[];
extern USHORT USBD_MTP_DeviceSupportedCaptureFormats[];
extern USHORT USBD_MTP_DeviceSupportedImageFormats[];
extern USHORT USBD_MTP_ObjectPropSupported[];
[/#if]
[#if REG_UX_DEVICE_CCID_value == "1" ]
extern UX_DEVICE_CLASS_CCID_HANDLES USBD_CCID_Handles;
extern ULONG USBD_CCID_Clocks[];
extern ULONG USBD_CCID_DataRates[];
[/#if]

/* USER CODE BEGIN PV */
extern PCD_HandleTypeDef           hpcd_USB_OTG_HS;
/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
[#if REG_UX_DEVICE_THREAD_value == "1" && UX_STANDALONE_ENABLED_Value == "0"]
static VOID ${USBX_DEVICE_APP_THREAD_NAME_value}(ULONG thread_input);
[/#if]
[#if (REG_USBX_DEVICE_CON_CK_value == "1") && (REG_UX_DEVICE_CORE_value  == "true") && (USBX_DEVICE_CLASS_NB != 0)]
static UINT USBD_ChangeFunction(ULONG Device_State);
[/#if]
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/**
  * @brief  Application USBX Device Initialization.
[#if UX_STANDALONE_ENABLED_Value == "1"]
  * @param  none
[#else]
  * @param  memory_ptr: memory pointer
[/#if]
  * @retval status
  */

[#if UX_STANDALONE_ENABLED_Value == "1"]
UINT MX_USBX_Device_Init(VOID)
[#else]
UINT MX_USBX_Device_Init(VOID *memory_ptr)
[/#if]
{
  UINT ret = UX_SUCCESS;
[#if (UX_STANDALONE_ENABLED_Value == "0")]
[#if (REG_UX_DEVICE_CORE_value  == "true" && USBX_DEVICE_CLASS_NB != 0) || (REG_UX_DEVICE_THREAD_value == "1")]
  UCHAR *pointer;
  TX_BYTE_POOL *byte_pool = (TX_BYTE_POOL*)memory_ptr;
[/#if]
[/#if]
  /* USER CODE BEGIN MX_USBX_Device_Init 0 */
  /* USER CODE END MX_USBX_Device_Init 0 */

[#if Dual_Role_Device_Enabled_value == "0"]
  /* Initialize the Stack USB Device*/
  if (MX_USBX_Device_Stack_Init() != UX_SUCCESS)
  {
    /* USER CODE BEGIN MAIN_INITIALIZE_STACK_ERROR */
    return UX_ERROR;
    /* USER CODE END MAIN_INITIALIZE_STACK_ERROR */
  }
[/#if]  

  /* USER CODE BEGIN MX_USBX_Device_Init 1 */
  /* USER CODE END MX_USBX_Device_Init 1 */
  
[#if REG_UX_DEVICE_THREAD_value == "1" && UX_STANDALONE_ENABLED_Value == "0"]
  /* Allocate the stack for device application main thread */
  if (tx_byte_allocate(byte_pool, (VOID **) &pointer, UX_DEVICE_APP_THREAD_STACK_SIZE,
                       TX_NO_WAIT) != TX_SUCCESS)
  {
    /* USER CODE BEGIN MAIN_THREAD_ALLOCATE_STACK_ERROR */
    return TX_POOL_ERROR;
    /* USER CODE END MAIN_THREAD_ALLOCATE_STACK_ERROR */
  }

  /* Create the device application main thread */
  if (tx_thread_create(&ux_device_app_thread, UX_DEVICE_APP_THREAD_NAME, ${USBX_DEVICE_APP_THREAD_NAME_value},
                       0, pointer, UX_DEVICE_APP_THREAD_STACK_SIZE, UX_DEVICE_APP_THREAD_PRIO,
                       UX_DEVICE_APP_THREAD_PREEMPTION_THRESHOLD, UX_DEVICE_APP_THREAD_TIME_SLICE,
                       UX_DEVICE_APP_THREAD_START_OPTION) != TX_SUCCESS)
  {
    /* USER CODE BEGIN MAIN_THREAD_CREATE_ERROR */
    return TX_THREAD_ERROR;
    /* USER CODE END MAIN_THREAD_CREATE_ERROR */
  }

[/#if]

  /* USER CODE BEGIN MX_USBX_Device_Init 2 */
  /* USER CODE END MX_USBX_Device_Init 2 */

  return ret;
}

/**
  * @brief  Application USBX Device Initialization.
  * @param  None
  * @retval ret
  */
UINT MX_USBX_Device_Stack_Init(void)
{
  UINT ret = UX_SUCCESS;
[#if (REG_UX_DEVICE_CORE_value  == "true") && (USBX_DEVICE_CLASS_NB != 0)]
  UCHAR *device_framework_high_speed;
  UCHAR *device_framework_full_speed;
  ULONG device_framework_hs_length;
  ULONG device_framework_fs_length;
  ULONG string_framework_length;
  ULONG language_id_framework_length;
  UCHAR *string_framework;
  UCHAR *language_id_framework;
[/#if]


  /* USER CODE BEGIN MX_USBX_Device_Stack_Init 0 */

  /* USER CODE END MX_USBX_Device_Stack_Init 0 */
[#if (REG_UX_DEVICE_CORE_value  == "true") && (USBX_DEVICE_CLASS_NB != 0)]
  /* Get Device Framework High Speed and get the length */
  device_framework_high_speed = USBD_Get_Device_Framework_Speed(USBD_HIGH_SPEED,
                                                                &device_framework_hs_length);

  /* Get Device Framework Full Speed and get the length */
  device_framework_full_speed = USBD_Get_Device_Framework_Speed(USBD_FULL_SPEED,
                                                                &device_framework_fs_length);

  /* Get String Framework and get the length */
  string_framework = USBD_Get_String_Framework(&string_framework_length);

  /* Get Language Id Framework and get the length */
  language_id_framework = USBD_Get_Language_Id_Framework(&language_id_framework_length);

  /* Install the device portion of USBX */
  if (ux_device_stack_initialize(device_framework_high_speed,
                                 device_framework_hs_length,
                                 device_framework_full_speed,
                                 device_framework_fs_length,
                                 string_framework,
                                 string_framework_length,
                                 language_id_framework,
                                 language_id_framework_length,
[#if REG_USBX_DEVICE_CON_CK_value == "1"]
                                 USBD_ChangeFunction) != UX_SUCCESS)
[#else]
                                 UX_NULL) != UX_SUCCESS)
[/#if]
  {
    /* USER CODE BEGIN USBX_DEVICE_INITIALIZE_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_DEVICE_INITIALIZE_ERROR */
  }
[/#if]

[#if REG_UX_DEVICE_HID_MOUSE_value == "1"]
  /* Initialize the hid mouse class parameters for the device */
  hid_mouse_parameter.ux_slave_class_hid_instance_activate         = USBD_HID_Mouse_Activate;
  hid_mouse_parameter.ux_slave_class_hid_instance_deactivate       = USBD_HID_Mouse_Deactivate;
  hid_mouse_parameter.ux_device_class_hid_parameter_report_address = USBD_HID_ReportDesc(INTERFACE_HID_MOUSE);
  hid_mouse_parameter.ux_device_class_hid_parameter_report_length  = USBD_HID_ReportDesc_length(INTERFACE_HID_MOUSE);
  hid_mouse_parameter.ux_device_class_hid_parameter_report_id      = UX_FALSE;
  hid_mouse_parameter.ux_device_class_hid_parameter_callback       = USBD_HID_Mouse_SetReport;
  hid_mouse_parameter.ux_device_class_hid_parameter_get_callback   = USBD_HID_Mouse_GetReport;

  /* USER CODE BEGIN HID_MOUSE_PARAMETER */

  /* USER CODE END HID_MOUSE_PARAMETER */

  /* Get hid mouse configuration number */
  hid_mouse_configuration_number = USBD_Get_Configuration_Number(CLASS_TYPE_HID, INTERFACE_HID_MOUSE);

  /* Find hid mouse interface number */
  hid_mouse_interface_number = USBD_Get_Interface_Number(CLASS_TYPE_HID, INTERFACE_HID_MOUSE);

  /* Initialize the device hid Mouse class */
  if (ux_device_stack_class_register(_ux_system_slave_class_hid_name,
                                     ux_device_class_hid_entry,
                                     hid_mouse_configuration_number,
                                     hid_mouse_interface_number,
                                     &hid_mouse_parameter) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_DEVICE_HID_MOUSE_REGISTER_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_DEVICE_HID_MOUSE_REGISTER_ERROR */
  }
[/#if]

[#if REG_UX_DEVICE_HID_KEYBOARD_value == "1"]
  /* Initialize the hid keyboard class parameters for the device */
  hid_keyboard_parameter.ux_slave_class_hid_instance_activate         = USBD_HID_Keyboard_Activate;
  hid_keyboard_parameter.ux_slave_class_hid_instance_deactivate       = USBD_HID_Keyboard_Deactivate;
  hid_keyboard_parameter.ux_device_class_hid_parameter_report_address = USBD_HID_ReportDesc(INTERFACE_HID_KEYBOARD);
  hid_keyboard_parameter.ux_device_class_hid_parameter_report_length  = USBD_HID_ReportDesc_length(INTERFACE_HID_KEYBOARD);
  hid_keyboard_parameter.ux_device_class_hid_parameter_report_id      = UX_FALSE;
  hid_keyboard_parameter.ux_device_class_hid_parameter_callback       = USBD_HID_Keyboard_SetReport;
  hid_keyboard_parameter.ux_device_class_hid_parameter_get_callback   = USBD_HID_Keyboard_GetReport;

  /* USER CODE BEGIN HID_KEYBOARD_PARAMETER */

  /* USER CODE END HID_KEYBOARD_PARAMETER */

  /* Get hid keyboard configuration number */
  hid_keyboard_configuration_number = USBD_Get_Configuration_Number(CLASS_TYPE_HID, INTERFACE_HID_KEYBOARD);

  /* Find hid keyboard interface number */
  hid_keyboard_interface_number = USBD_Get_Interface_Number(CLASS_TYPE_HID, INTERFACE_HID_KEYBOARD);

  /* Initialize the device hid keyboard class */
  if (ux_device_stack_class_register(_ux_system_slave_class_hid_name,
                                     ux_device_class_hid_entry,
                                     hid_keyboard_configuration_number,
                                     hid_keyboard_interface_number,
                                     &hid_keyboard_parameter) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_DEVICE_HID_KEYBOARD_REGISTER_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_DEVICE_HID_KEYBOARD_REGISTER_ERROR */
  }
[/#if]

[#if REG_UX_DEVICE_HID_CUSTOM_value == "1"]
  /* Initialize the hid custom class parameters for the device */
  custom_hid_parameter.ux_slave_class_hid_instance_activate         = USBD_Custom_HID_Activate;
  custom_hid_parameter.ux_slave_class_hid_instance_deactivate       = USBD_Custom_HID_Deactivate;
  custom_hid_parameter.ux_device_class_hid_parameter_report_address = USBD_HID_ReportDesc(INTERFACE_HID_CUSTOM);
  custom_hid_parameter.ux_device_class_hid_parameter_report_length  = USBD_HID_ReportDesc_length(INTERFACE_HID_CUSTOM);
  custom_hid_parameter.ux_device_class_hid_parameter_report_id      = UX_FALSE;
  custom_hid_parameter.ux_device_class_hid_parameter_callback       = USBD_Custom_HID_SetFeature;
  custom_hid_parameter.ux_device_class_hid_parameter_get_callback   = USBD_Custom_HID_GetReport;
#ifdef UX_DEVICE_CLASS_HID_INTERRUPT_OUT_SUPPORT
  custom_hid_parameter.ux_device_class_hid_parameter_receiver_initialize       = ux_device_class_hid_receiver_initialize;
  custom_hid_parameter.ux_device_class_hid_parameter_receiver_event_max_number = USBD_Custom_HID_EventMaxNumber();
  custom_hid_parameter.ux_device_class_hid_parameter_receiver_event_max_length = USBD_Custom_HID_EventMaxLength();
  custom_hid_parameter.ux_device_class_hid_parameter_receiver_event_callback   = USBD_Custom_HID_SetReport;
#endif /* UX_DEVICE_CLASS_HID_INTERRUPT_OUT_SUPPORT */

  /* USER CODE BEGIN CUSTOM_HID_PARAMETER */

  /* USER CODE END CUSTOM_HID_PARAMETER */

  /* Get Custom hid configuration number */
  hid_custom_configuration_number = USBD_Get_Configuration_Number(CLASS_TYPE_HID, INTERFACE_HID_CUSTOM);

  /* Find Custom hid interface number */
  hid_custom_interface_number = USBD_Get_Interface_Number(CLASS_TYPE_HID, INTERFACE_HID_CUSTOM);

  /* Initialize the device hid custom class */
  if (ux_device_stack_class_register(_ux_system_slave_class_hid_name,
                                     ux_device_class_hid_entry,
                                     hid_custom_configuration_number,
                                     hid_custom_interface_number,
                                     &custom_hid_parameter) != UX_SUCCESS)
  {
  /* USER CODE BEGIN USBX_DEVICE_HID_CUSTOM_REGISTER_ERROR */
  return UX_ERROR;
  /* USER CODE END USBX_DEVICE_HID_CUSTOM_REGISTER_ERROR */
  }
[/#if]

[#if REG_UX_DEVICE_STORAGE_value == "1"]
  /* Initialize the storage class parameters for the device */
  storage_parameter.ux_slave_class_storage_instance_activate   = USBD_STORAGE_Activate;
  storage_parameter.ux_slave_class_storage_instance_deactivate = USBD_STORAGE_Deactivate;

  /* Store the number of LUN in this device storage instance */
  storage_parameter.ux_slave_class_storage_parameter_number_lun = STORAGE_NUMBER_LUN;

  /* Initialize the storage class parameters for reading/writing to the Flash Disk */
  storage_parameter.ux_slave_class_storage_parameter_lun[0].
    ux_slave_class_storage_media_last_lba = USBD_STORAGE_GetMediaLastLba();

  storage_parameter.ux_slave_class_storage_parameter_lun[0].
    ux_slave_class_storage_media_block_length = USBD_STORAGE_GetMediaBlocklength();

  storage_parameter.ux_slave_class_storage_parameter_lun[0].
    ux_slave_class_storage_media_type = 0;

  storage_parameter.ux_slave_class_storage_parameter_lun[0].
    ux_slave_class_storage_media_removable_flag = STORAGE_REMOVABLE_FLAG;

  storage_parameter.ux_slave_class_storage_parameter_lun[0].
    ux_slave_class_storage_media_read_only_flag = STORAGE_READ_ONLY;

  storage_parameter.ux_slave_class_storage_parameter_lun[0].
    ux_slave_class_storage_media_read = USBD_STORAGE_Read;

  storage_parameter.ux_slave_class_storage_parameter_lun[0].
    ux_slave_class_storage_media_write = USBD_STORAGE_Write;

  storage_parameter.ux_slave_class_storage_parameter_lun[0].
    ux_slave_class_storage_media_flush = USBD_STORAGE_Flush;

  storage_parameter.ux_slave_class_storage_parameter_lun[0].
    ux_slave_class_storage_media_status = USBD_STORAGE_Status;

  storage_parameter.ux_slave_class_storage_parameter_lun[0].
    ux_slave_class_storage_media_notification = USBD_STORAGE_Notification;

  /* USER CODE BEGIN STORAGE_PARAMETER */

  /* USER CODE END STORAGE_PARAMETER */

  /* Get storage configuration number */
  storage_configuration_number = USBD_Get_Configuration_Number(CLASS_TYPE_MSC, 0);

  /* Find storage interface number */
  storage_interface_number = USBD_Get_Interface_Number(CLASS_TYPE_MSC, 0);

  /* Initialize the device storage class */
  if (ux_device_stack_class_register(_ux_system_slave_class_storage_name,
                                     ux_device_class_storage_entry,
                                     storage_configuration_number,
                                     storage_interface_number,
                                     &storage_parameter) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_DEVICE_STORAGE_REGISTER_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_DEVICE_STORAGE_REGISTER_ERROR */
  }
[/#if]

[#if REG_UX_DEVICE_CDC_ACM_value == "1"]
  /* Initialize the cdc acm class parameters for the device */
  cdc_acm_parameter.ux_slave_class_cdc_acm_instance_activate   = USBD_CDC_ACM_Activate;
  cdc_acm_parameter.ux_slave_class_cdc_acm_instance_deactivate = USBD_CDC_ACM_Deactivate;
  cdc_acm_parameter.ux_slave_class_cdc_acm_parameter_change    = USBD_CDC_ACM_ParameterChange;

  /* USER CODE BEGIN CDC_ACM_PARAMETER */

  /* USER CODE END CDC_ACM_PARAMETER */

  /* Get cdc acm configuration number */
  cdc_acm_configuration_number = USBD_Get_Configuration_Number(CLASS_TYPE_CDC_ACM, 0);

  /* Find cdc acm interface number */
  cdc_acm_interface_number = USBD_Get_Interface_Number(CLASS_TYPE_CDC_ACM, 0);

  /* Initialize the device cdc acm class */
  if (ux_device_stack_class_register(_ux_system_slave_class_cdc_acm_name,
                                     ux_device_class_cdc_acm_entry,
                                     cdc_acm_configuration_number,
                                     cdc_acm_interface_number,
                                     &cdc_acm_parameter) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_DEVICE_CDC_ACM_REGISTER_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_DEVICE_CDC_ACM_REGISTER_ERROR */
  }
[/#if]

[#if REG_UX_DEVICE_CDC_ECM_value == "1"]
  /* Initialize the cdc ecm class parameters for the device */
  cdc_ecm_parameter.ux_slave_class_cdc_ecm_instance_activate   = USBD_CDC_ECM_Activate;
  cdc_ecm_parameter.ux_slave_class_cdc_ecm_instance_deactivate = USBD_CDC_ECM_Deactivate;

  /* Get CDC ECM local MAC address */
  USBD_CDC_ECM_GetMacAdd((uint8_t *)CDC_ECM_LOCAL_MAC_STR_DESC, cdc_ecm_local_nodeid);

  /* Define CDC ECM local node id */
  cdc_ecm_parameter.ux_slave_class_cdc_ecm_parameter_local_node_id[0] = cdc_ecm_local_nodeid[0];
  cdc_ecm_parameter.ux_slave_class_cdc_ecm_parameter_local_node_id[1] = cdc_ecm_local_nodeid[1];
  cdc_ecm_parameter.ux_slave_class_cdc_ecm_parameter_local_node_id[2] = cdc_ecm_local_nodeid[2];
  cdc_ecm_parameter.ux_slave_class_cdc_ecm_parameter_local_node_id[3] = cdc_ecm_local_nodeid[3];
  cdc_ecm_parameter.ux_slave_class_cdc_ecm_parameter_local_node_id[4] = cdc_ecm_local_nodeid[4];
  cdc_ecm_parameter.ux_slave_class_cdc_ecm_parameter_local_node_id[5] = cdc_ecm_local_nodeid[5];

  /* Get CDC ECM remote MAC address */
  USBD_CDC_ECM_GetMacAdd((uint8_t *)CDC_ECM_REMOTE_MAC_STR_DESC, cdc_ecm_remote_nodeid);

  /* Define CDC ECM remote node id */
  cdc_ecm_parameter.ux_slave_class_cdc_ecm_parameter_remote_node_id[0] = cdc_ecm_remote_nodeid[0];
  cdc_ecm_parameter.ux_slave_class_cdc_ecm_parameter_remote_node_id[1] = cdc_ecm_remote_nodeid[1];
  cdc_ecm_parameter.ux_slave_class_cdc_ecm_parameter_remote_node_id[2] = cdc_ecm_remote_nodeid[2];
  cdc_ecm_parameter.ux_slave_class_cdc_ecm_parameter_remote_node_id[3] = cdc_ecm_remote_nodeid[3];
  cdc_ecm_parameter.ux_slave_class_cdc_ecm_parameter_remote_node_id[4] = cdc_ecm_remote_nodeid[4];
  cdc_ecm_parameter.ux_slave_class_cdc_ecm_parameter_remote_node_id[5] = cdc_ecm_remote_nodeid[5];

  /* USER CODE BEGIN CDC_ECM_PARAMETER */

  /* USER CODE END CDC_ECM_PARAMETER */

  /* Get cdc ecm configuration number */
  cdc_ecm_configuration_number = USBD_Get_Configuration_Number(CLASS_TYPE_CDC_ECM, 0);

  /* Find cdc ecm interface number */
  cdc_ecm_interface_number = USBD_Get_Interface_Number(CLASS_TYPE_CDC_ECM, 0);

  /* Initialize the device cdc ecm class */
  if (ux_device_stack_class_register(_ux_system_slave_class_cdc_ecm_name,
                                     ux_device_class_cdc_ecm_entry,
                                     cdc_ecm_configuration_number,
                                     cdc_ecm_interface_number,
                                     &cdc_ecm_parameter) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_DEVICE_CDC_ECM_REGISTER_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_DEVICE_CDC_ECM_REGISTER_ERROR */
  }
[/#if]

[#if REG_UX_DEVICE_DFU_value == "1"]
  /* Initialize the dfu class parameters for the device */
  dfu_parameter.ux_slave_class_dfu_parameter_instance_activate   = USBD_DFU_Activate;
  dfu_parameter.ux_slave_class_dfu_parameter_instance_deactivate = USBD_DFU_Deactivate;
  dfu_parameter.ux_slave_class_dfu_parameter_get_status          = USBD_DFU_GetStatus;
  dfu_parameter.ux_slave_class_dfu_parameter_read                = USBD_DFU_Read;
  dfu_parameter.ux_slave_class_dfu_parameter_write               = USBD_DFU_Write;
  dfu_parameter.ux_slave_class_dfu_parameter_notify              = USBD_DFU_Notify;
#ifdef UX_DEVICE_CLASS_DFU_CUSTOM_REQUEST_ENABLE
  dfu_parameter.ux_device_class_dfu_parameter_custom_request     = USBD_DFU_CustomRequest;
#endif /* UX_DEVICE_CLASS_DFU_CUSTOM_REQUEST_ENABLE */
  dfu_parameter.ux_slave_class_dfu_parameter_framework           = device_framework_full_speed;
  dfu_parameter.ux_slave_class_dfu_parameter_framework_length    = device_framework_fs_length;

  /* USER CODE BEGIN DFU_PARAMETER */

  /* USER CODE END DFU_PARAMETER */

  /* Get dfu configuration number */
  dfu_configuration_number = USBD_Get_Configuration_Number(CLASS_TYPE_DFU, 0);

  /* Find dfu interface number */
  dfu_interface_number = USBD_Get_Interface_Number(CLASS_TYPE_DFU, 0);

  /* Initialize the device dfu class */
  if (ux_device_stack_class_register(_ux_system_slave_class_dfu_name,
                                     ux_device_class_dfu_entry,
                                     dfu_configuration_number,
                                     dfu_interface_number,
                                     &dfu_parameter) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_DEVICE_DFU_REGISTER_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_DEVICE_DFU_REGISTER_ERROR */
  }
[/#if]

[#if REG_UX_DEVICE_PIMA_MTP_value == "1"]
  /* Initialize the pima class parameters for the device */
  pima_mtp_parameter.ux_device_class_pima_instance_activate = USBD_PIMA_MTP_Activate;
  pima_mtp_parameter.ux_device_class_pima_instance_deactivate = USBD_PIMA_MTP_Deactivate;

  pima_mtp_parameter.ux_device_class_pima_parameter_manufacturer                   = (UCHAR *)USBD_MTP_INFO_MANUFACTURER;
  pima_mtp_parameter.ux_device_class_pima_parameter_model                          = (UCHAR *)USBD_MTP_INFO_MODEL;
  pima_mtp_parameter.ux_device_class_pima_parameter_device_version                 = (UCHAR *)USBD_MTP_INFO_VERSION;
  pima_mtp_parameter.ux_device_class_pima_parameter_serial_number                  = (UCHAR *)USBD_MTP_INFO_SERIAL_NUMBER;
  pima_mtp_parameter.ux_device_class_pima_parameter_storage_id                     = USBD_MTP_STORAGE_ID;
  pima_mtp_parameter.ux_device_class_pima_parameter_storage_type                   = USBD_MTP_STORAGE_TYPE;
  pima_mtp_parameter.ux_device_class_pima_parameter_storage_file_system_type       = USBD_MTP_STORAGE_FILE_SYSTEM_TYPE;
  pima_mtp_parameter.ux_device_class_pima_parameter_storage_access_capability      = USBD_MTP_STORAGE_FILE_ACCESS_CAPABILITY;
  pima_mtp_parameter.ux_device_class_pima_parameter_storage_max_capacity_low       = USBD_MTP_StorageGetMaxCapabilityLow();
  pima_mtp_parameter.ux_device_class_pima_parameter_storage_max_capacity_high      = USBD_MTP_StorageGetMaxCapabilityHigh();
  pima_mtp_parameter.ux_device_class_pima_parameter_storage_free_space_low         = USBD_MTP_StorageGetFreeSpaceLow();
  pima_mtp_parameter.ux_device_class_pima_parameter_storage_free_space_high        = USBD_MTP_StorageGetFreeSpaceHigh();
  pima_mtp_parameter.ux_device_class_pima_parameter_storage_free_space_image       = USBD_MTP_StorageGetFreeSpaceImage();
  pima_mtp_parameter.ux_device_class_pima_parameter_storage_description            = (UCHAR*)USBD_MTP_STORAGE_DESCRIPTION;
  pima_mtp_parameter.ux_device_class_pima_parameter_storage_volume_label           = (UCHAR*)USBD_MTP_STORAGE_DESCRIPTION_IDENTIFIER;
  pima_mtp_parameter.ux_device_class_pima_parameter_device_properties_list         = USBD_MTP_DevicePropSupported;
  pima_mtp_parameter.ux_device_class_pima_parameter_supported_capture_formats_list = USBD_MTP_DeviceSupportedCaptureFormats;
  pima_mtp_parameter.ux_device_class_pima_parameter_supported_image_formats_list   = USBD_MTP_DeviceSupportedImageFormats;
  pima_mtp_parameter.ux_device_class_pima_parameter_object_properties_list         = USBD_MTP_ObjectPropSupported;

  /* Define the pima callbacks */
  pima_mtp_parameter.ux_device_class_pima_parameter_cancel                = USBD_MTP_Cancel;
  pima_mtp_parameter.ux_device_class_pima_parameter_device_reset          = USBD_MTP_DeviceReset;
  pima_mtp_parameter.ux_device_class_pima_parameter_device_prop_desc_get  = USBD_MTP_GetDevicePropDesc;
  pima_mtp_parameter.ux_device_class_pima_parameter_device_prop_value_get = USBD_MTP_GetDevicePropValue;
  pima_mtp_parameter.ux_device_class_pima_parameter_device_prop_value_set = USBD_MTP_SetDevicePropValue;
  pima_mtp_parameter.ux_device_class_pima_parameter_storage_format        = USBD_MTP_FormatStorage;
  pima_mtp_parameter.ux_device_class_pima_parameter_storage_info_get      = USBD_MTP_GetStorageInfo;
  pima_mtp_parameter.ux_device_class_pima_parameter_object_number_get     = USBD_MTP_GetObjectNumber;
  pima_mtp_parameter.ux_device_class_pima_parameter_object_handles_get    = USBD_MTP_GetObjectHandles;
  pima_mtp_parameter.ux_device_class_pima_parameter_object_info_get       = USBD_MTP_GetObjectInfo;
  pima_mtp_parameter.ux_device_class_pima_parameter_object_data_get       = USBD_MTP_GetObjectData;
  pima_mtp_parameter.ux_device_class_pima_parameter_object_info_send      = USBD_MTP_SendObjectInfo;
  pima_mtp_parameter.ux_device_class_pima_parameter_object_data_send      = USBD_MTP_SendObjectData;
  pima_mtp_parameter.ux_device_class_pima_parameter_object_delete         = USBD_MTP_DeleteObject;
  pima_mtp_parameter.ux_device_class_pima_parameter_object_prop_desc_get  = USBD_MTP_GetObjectPropDesc;
  pima_mtp_parameter.ux_device_class_pima_parameter_object_prop_value_get = USBD_MTP_GetObjectPropValue;
  pima_mtp_parameter.ux_device_class_pima_parameter_object_prop_value_set = USBD_MTP_SetObjectPropValue;
  pima_mtp_parameter.ux_device_class_pima_parameter_object_references_get = USBD_MTP_GetObjectReferences;
  pima_mtp_parameter.ux_device_class_pima_parameter_object_references_set = USBD_MTP_SetObjectReferences;

  /* Store the instance owner */
  pima_mtp_parameter.ux_device_class_pima_parameter_application = NULL;

  /* USER CODE BEGIN PIMA_MTP_PARAMETER */

  /* USER CODE END PIMA_MTP_PARAMETER */

  /* Get pima mtp configuration number */
  pima_mtp_configuration_number = USBD_Get_Configuration_Number(CLASS_TYPE_PIMA_MTP, 0);

  /* Find pima mtp interface number */
  pima_mtp_interface_number = USBD_Get_Interface_Number(CLASS_TYPE_PIMA_MTP, 0);

  /* Initialize the device pima mtp class */
  if (ux_device_stack_class_register(_ux_system_slave_class_pima_name,
                                     ux_device_class_pima_entry,
                                     pima_mtp_configuration_number,
                                     pima_mtp_interface_number,
                                     &pima_mtp_parameter) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_DEVICE_MTP_REGISTER_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_DEVICE_MTP_REGISTER_ERROR */
  }
[/#if]

[#if REG_UX_DEVICE_RNDIS_value == "1"]
  /* Initialize the rndis class parameters for the device */
  rndis_parameter.ux_slave_class_rndis_instance_activate   = USBD_RNDIS_Activate;
  rndis_parameter.ux_slave_class_rndis_instance_deactivate = USBD_RNDIS_Deactivate;

  /* Get RNDIS local MAC address */
  USBD_RNDIS_GetMacAdd((uint8_t *)RNDIS_LOCAL_MAC_STR_DESC, rndis_local_nodeid);

  /* Define RNDIS local node id */
  rndis_parameter.ux_slave_class_rndis_parameter_local_node_id[0] = rndis_local_nodeid[0];
  rndis_parameter.ux_slave_class_rndis_parameter_local_node_id[1] = rndis_local_nodeid[1];
  rndis_parameter.ux_slave_class_rndis_parameter_local_node_id[2] = rndis_local_nodeid[2];
  rndis_parameter.ux_slave_class_rndis_parameter_local_node_id[3] = rndis_local_nodeid[3];
  rndis_parameter.ux_slave_class_rndis_parameter_local_node_id[4] = rndis_local_nodeid[4];
  rndis_parameter.ux_slave_class_rndis_parameter_local_node_id[5] = rndis_local_nodeid[5];

  /* Get RNDIS local MAC address */
  USBD_RNDIS_GetMacAdd((uint8_t *)RNDIS_REMOTE_MAC_STR_DESC, rndis_remote_nodeid);

  /* Define RNDIS remote node id */
  rndis_parameter.ux_slave_class_rndis_parameter_remote_node_id[0] = rndis_remote_nodeid[0];
  rndis_parameter.ux_slave_class_rndis_parameter_remote_node_id[1] = rndis_remote_nodeid[1];
  rndis_parameter.ux_slave_class_rndis_parameter_remote_node_id[2] = rndis_remote_nodeid[2];
  rndis_parameter.ux_slave_class_rndis_parameter_remote_node_id[3] = rndis_remote_nodeid[3];
  rndis_parameter.ux_slave_class_rndis_parameter_remote_node_id[4] = rndis_remote_nodeid[4];
  rndis_parameter.ux_slave_class_rndis_parameter_remote_node_id[5] = rndis_remote_nodeid[5];

  rndis_parameter.ux_slave_class_rndis_parameter_vendor_id      = USBD_VID;
  rndis_parameter.ux_slave_class_rndis_parameter_driver_version = USBD_RNDIS_DRIVER_VERSION;

  /* USER CODE BEGIN RNDIS_PARAMETER */

  /* USER CODE END RNDIS_PARAMETER */

  ux_utility_memory_copy(rndis_parameter.ux_slave_class_rndis_parameter_vendor_description,
                         USBD_PRODUCT_STRING, sizeof(USBD_PRODUCT_STRING));

  /* Get rndis configuration number */
  rndis_configuration_number = USBD_Get_Configuration_Number(CLASS_TYPE_RNDIS, 0);

  /* Find rndis interface number */
  rndis_interface_number = USBD_Get_Interface_Number(CLASS_TYPE_RNDIS, 0);

  /* Initialize the device RNDIS */
  if (ux_device_stack_class_register(_ux_system_slave_class_rndis_name,
                                     ux_device_class_rndis_entry,
                                     rndis_configuration_number,
                                     rndis_interface_number,
                                     &rndis_parameter) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_DEVICE_RNDIS_REGISTER_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_DEVICE_RNDIS_REGISTER_ERROR */
  }

[/#if]

[#if REG_UX_DEVICE_VIDEO_value == "1"]
  /* Initialize the video class parameters for the device */
  video_stream_parameter[0].ux_device_class_video_stream_parameter_callbacks.ux_device_class_video_stream_change
    = USBD_VIDEO_StreamChange;

  video_stream_parameter[0].ux_device_class_video_stream_parameter_callbacks.ux_device_class_video_stream_payload_done
    = USBD_VIDEO_StreamPayloadDone;

  video_stream_parameter[0].ux_device_class_video_stream_parameter_callbacks.ux_device_class_video_stream_request
    = USBD_VIDEO_StreamRequest;

  video_stream_parameter[0].ux_device_class_video_stream_parameter_max_payload_buffer_nb
    = USBD_VIDEO_PAYLOAD_BUFFER_NUMBER;

  video_stream_parameter[0].ux_device_class_video_stream_parameter_max_payload_buffer_size
    = USBD_VIDEO_StreamGetMaxPayloadBufferSize();

[#if UX_STANDALONE_ENABLED_Value == "0"]
  video_stream_parameter[0].ux_device_class_video_stream_parameter_thread_entry
    = ux_device_class_video_write_thread_entry;
[#else]
  video_stream_parameter[0].ux_device_class_video_stream_parameter_task_function
    = ux_device_class_video_write_task_function;
[/#if]

  /* Set the parameters for Video device */
  video_parameter.ux_device_class_video_parameter_streams_nb  = USBD_VIDEO_STREAM_NMNBER;
  video_parameter.ux_device_class_video_parameter_streams     = video_stream_parameter;

  video_parameter.ux_device_class_video_parameter_callbacks.ux_slave_class_video_instance_activate
    = USBD_VIDEO_Activate;

  video_parameter.ux_device_class_video_parameter_callbacks.ux_slave_class_video_instance_deactivate
    = USBD_VIDEO_Deactivate;

  /* USER CODE BEGIN VIDEO_PARAMETER */

  /* USER CODE END VIDEO_PARAMETER */

  /* Get video configuration number */
  video_configuration_number = USBD_Get_Configuration_Number(CLASS_TYPE_VIDEO, 0);

  /* Find video interface number */
  video_interface_number = USBD_Get_Interface_Number(CLASS_TYPE_VIDEO, 0);

  /* Initialize the device VIDEO */
  if (ux_device_stack_class_register(_ux_system_device_class_video_name,
                                     ux_device_class_video_entry,
                                     video_configuration_number,
                                     video_interface_number,
                                     (VOID *)&video_parameter) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_DEVICE_VIDEO_REGISTER_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_DEVICE_VIDEO_REGISTER_ERROR */
  }

[/#if]

[#if REG_UX_DEVICE_CCID_value == "1"]
  /* Initialize the ccid class parameters for the device */
  ccid_parameter.ux_device_class_ccid_handles             = &USBD_CCID_Handles;
  ccid_parameter.ux_device_class_ccid_instance_activate   = USBD_CCID_Activate;
  ccid_parameter.ux_device_class_ccid_instance_deactivate = USBD_CCID_Deactivate;
  ccid_parameter.ux_device_class_ccid_max_n_slots         = USBD_CCID_MAX_SLOT_INDEX;
  ccid_parameter.ux_device_class_ccid_max_n_busy_slots    = USBD_CCID_MAX_BUSY_SLOTS;
  ccid_parameter.ux_device_class_ccid_max_transfer_length = USBD_CCID_MAX_BLOCK_SIZE_HEADER;
  ccid_parameter.ux_device_class_ccid_n_clocks            = USBD_CCID_N_CLOCKS;
  ccid_parameter.ux_device_class_ccid_clocks              = USBD_CCID_Clocks;
  ccid_parameter.ux_device_class_ccid_n_data_rates        = USBD_CCID_N_DATA_RATES;
  ccid_parameter.ux_device_class_ccid_data_rates          = USBD_CCID_DataRates;

  /* USER CODE BEGIN CCID_PARAMETER */

  /* USER CODE END CCID_PARAMETER */

  /* Get ccid configuration number */
  ccid_configuration_number = USBD_Get_Configuration_Number(CLASS_TYPE_CCID, 0);

  /* Find ccid interface number */
  ccid_interface_number = USBD_Get_Interface_Number(CLASS_TYPE_CCID, 0);

  /* Initialize the device CCID class */
  if (ux_device_stack_class_register(_ux_system_device_class_ccid_name,
                                     ux_device_class_ccid_entry,
                                     ccid_configuration_number,
                                     ccid_interface_number,
                                     &ccid_parameter) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_DEVICE_CCID_REGISTER_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_DEVICE_CCID_REGISTER_ERROR */
  }
[/#if]

[#if REG_UX_DEVICE_PRINTER_value == "1"]
  /* Initialize the printer class parameters for the device */
  printer_parameter.ux_device_class_printer_device_id           = USBD_PRINTER_GetDeviceID();
  printer_parameter.ux_device_class_printer_instance_activate   = USBD_PRINTER_Activate;
  printer_parameter.ux_device_class_printer_instance_deactivate = USBD_PRINTER_Deactivate;
  printer_parameter.ux_device_class_printer_soft_reset          = USBD_PRINTER_SoftReset;

  /* USER CODE BEGIN PRINTER_PARAMETER */

  /* USER CODE END PRINTER_PARAMETER */

  /* Get printer configuration number */
  printer_configuration_number = USBD_Get_Configuration_Number(CLASS_TYPE_PRINTER, 0);

  /* Find printer interface number */
  printer_interface_number = USBD_Get_Interface_Number(CLASS_TYPE_PRINTER, 0);

  /* Initialize the device printer class */
  if (ux_device_stack_class_register(_ux_system_device_class_printer_name,
                                     ux_device_class_printer_entry,
                                     printer_configuration_number,
                                     printer_interface_number,
                                     &printer_parameter) != UX_SUCCESS)
  {
    /* USER CODE BEGIN USBX_DEVICE_PRINTER_REGISTER_ERROR */
    return UX_ERROR;
    /* USER CODE END USBX_DEVICE_PRINTER_REGISTER_ERROR */
  }
[/#if]

[#if (REG_UX_DEVICE_CDC_ECM_value == "1") || (REG_UX_DEVICE_RNDIS_value == "1")]

  /* Perform the initialization of the network driver. This will initialize the
     USBX network layer */

  ux_network_driver_init();

[/#if]

[#if UX_Device_Controller_value == "1"]
  /* Initialize and link controller HAL driver */
  ux_dcd_stm32_initialize((ULONG)USB_OTG_HS, (ULONG)&hpcd_USB_OTG_HS);
[/#if]
  /* USER CODE BEGIN MX_USBX_Device_Stack_Init_PostTreatment */
  /* USER CODE END MX_USBX_Device_Stack_Init_PostTreatment */
  
  /* USER CODE BEGIN MX_USBX_Device_Stack_Init 1 */

  /* USER CODE END MX_USBX_Device_Stack_Init 1 */

  return ret;
}

[#if REG_UX_DEVICE_THREAD_value == "1" && UX_STANDALONE_ENABLED_Value == "0"]
/**
  * @brief  Function implementing ${USBX_DEVICE_APP_THREAD_NAME_value}.
  * @param  thread_input: User thread input parameter.
  * @retval none
  */
static VOID ${USBX_DEVICE_APP_THREAD_NAME_value}(ULONG thread_input)
{
  /* USER CODE BEGIN ${USBX_DEVICE_APP_THREAD_NAME_value} */
  TX_PARAMETER_NOT_USED(thread_input);
  /* USER CODE END ${USBX_DEVICE_APP_THREAD_NAME_value} */
}
[/#if]

/**
  * @brief MX_USBX_Device_Stack_DeInit
  *        Unitialization of USB Device.
  * uninitialize the device stack, unregister of device class stack
  * unregister of the usb device controller
  * @retval None
  */
UINT MX_USBX_Device_Stack_DeInit(void)
{
  UINT ret = UX_SUCCESS;

  /* USER CODE BEGIN MX_USBX_Device_Stack_DeInit_PreTreatment_0 */
  /* USER CODE END MX_USBX_Device_Stack_DeInit_PreTreatment_0 */

  /* Unregister USB device controller. */
  if (_ux_dcd_stm32_uninitialize((ULONG)USB_OTG_HS, (ULONG)&hpcd_USB_OTG_HS) != UX_SUCCESS)
  {
    return UX_ERROR;
  }
  
[#if REG_UX_DEVICE_HID_MOUSE_value == "1" || REG_UX_DEVICE_HID_KEYBOARD_value == "1" || REG_UX_DEVICE_HID_CUSTOM_value == "1"]
/* Unregister hid class. */
  if (ux_device_stack_class_unregister(_ux_system_slave_class_hid_name,
                                       ux_device_class_hid_entry) != UX_SUCCESS)
  {
    return UX_ERROR;
  }
[/#if]

[#if REG_UX_DEVICE_STORAGE_value == "1"]
/* Unregister storage class. */
  if (ux_device_stack_class_unregister(_ux_system_slave_class_storage_name,
                                       ux_device_class_storage_entry) != UX_SUCCESS)
  {
    return UX_ERROR;
  }
[/#if]

[#if REG_UX_DEVICE_CDC_ACM_value == "1"]
  /* Unregister CDC ACM class. */
  if (ux_device_stack_class_unregister(_ux_system_slave_class_cdc_acm_name,
                                     ux_device_class_cdc_acm_entry) != UX_SUCCESS)
  {
    return UX_ERROR;
  }
[/#if]

[#if REG_UX_DEVICE_CDC_ECM_value == "1"]
  /* Unregister CDC ECM class. */
  if (ux_device_stack_class_unregister(_ux_system_slave_class_cdc_ecm_name,
                                     ux_device_class_cdc_ecm_entry) != UX_SUCCESS)
  {
    return UX_ERROR;
  }
[/#if]

[#if REG_UX_DEVICE_DFU_value == "1"]
  /* Unregister dfu class. */
  if (ux_device_stack_class_unregister(_ux_system_slave_class_dfu_name,
                                     ux_device_class_dfu_entry) != UX_SUCCESS)
  {
    return UX_ERROR;
  }
[/#if]

[#if REG_UX_DEVICE_PIMA_MTP_value == "1"]
  /* Unregister pima class. */
  if (ux_device_stack_class_unregister(_ux_system_slave_class_pima_name,
                                     ux_device_class_pima_entry) != UX_SUCCESS)
  {
    return UX_ERROR;
  }
[/#if]

[#if REG_UX_DEVICE_RNDIS_value == "1"]
  /* Unregister rndis class. */
  if (ux_device_stack_class_unregister(_ux_system_slave_class_rndis_name,
                                     ux_device_class_rndis_entry) != UX_SUCCESS)
  {
    return UX_ERROR;
  }

[/#if]

[#if REG_UX_DEVICE_VIDEO_value == "1"]
  /* Unregister video class. */
  if (ux_device_stack_class_unregister(_ux_system_device_class_video_name,
                                     ux_device_class_video_entry) != UX_SUCCESS)
  {
    return UX_ERROR;
  }

[/#if]

[#if REG_UX_DEVICE_CCID_value == "1"]
  /* Unregister CCID class. */
  if (ux_device_stack_class_unregister(_ux_system_device_class_ccid_name,
                                     ux_device_class_ccid_entry) != UX_SUCCESS)
  {
    return UX_ERROR;
  }
[/#if]

[#if REG_UX_DEVICE_PRINTER_value == "1"]
  /* Unregister printer class. */
  if (ux_device_stack_class_unregister(_ux_system_device_class_printer_name,
                                     ux_device_class_printer_entry) != UX_SUCCESS)
  {
    return UX_ERROR;
  }
[/#if]

  /* The code below is required for uninstalling the device portion of USBX.  */
  if (ux_device_stack_uninitialize() != UX_SUCCESS)
  {
    return UX_ERROR;
  }

  /* USER CODE BEGIN MX_USBX_Device_Stack_DeInit_PreTreatment_1 */
  /* USER CODE END MX_USBX_Device_Stack_DeInit_PreTreatment_1 */

  /* USER CODE BEGIN MX_USBX_Device_Stack_DeInit_PostTreatment */
  /* USER CODE END MX_USBX_Device_Stack_DeInit_PostTreatment */

  return ret;
}

[#if (REG_USBX_DEVICE_CON_CK_value  == "1") && (REG_UX_DEVICE_CORE_value  == "true") && (USBX_DEVICE_CLASS_NB != 0)]
/**
  * @brief  USBD_ChangeFunction
  *         This function is called when the device state changes.
  * @param  Device_State: USB Device State
  * @retval status
  */
static UINT USBD_ChangeFunction(ULONG Device_State)
{
   UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_ChangeFunction0 */

  /* USER CODE END USBD_ChangeFunction0 */

  switch (Device_State)
  {
    case UX_DEVICE_ATTACHED:

      /* USER CODE BEGIN UX_DEVICE_ATTACHED */

      /* USER CODE END UX_DEVICE_ATTACHED */

      break;

    case UX_DEVICE_REMOVED:

      /* USER CODE BEGIN UX_DEVICE_REMOVED */

      /* USER CODE END UX_DEVICE_REMOVED */

      break;

    case UX_DCD_STM32_DEVICE_CONNECTED:

      /* USER CODE BEGIN UX_DCD_STM32_DEVICE_CONNECTED */

      /* USER CODE END UX_DCD_STM32_DEVICE_CONNECTED */

      break;

    case UX_DCD_STM32_DEVICE_DISCONNECTED:

      /* USER CODE BEGIN UX_DCD_STM32_DEVICE_DISCONNECTED */

      /* USER CODE END UX_DCD_STM32_DEVICE_DISCONNECTED */

      break;

    case UX_DCD_STM32_DEVICE_SUSPENDED:

      /* USER CODE BEGIN UX_DCD_STM32_DEVICE_SUSPENDED */

      /* USER CODE END UX_DCD_STM32_DEVICE_SUSPENDED */

      break;

    case UX_DCD_STM32_DEVICE_RESUMED:

      /* USER CODE BEGIN UX_DCD_STM32_DEVICE_RESUMED */

      /* USER CODE END UX_DCD_STM32_DEVICE_RESUMED */

      break;

    case UX_DCD_STM32_SOF_RECEIVED:

      /* USER CODE BEGIN UX_DCD_STM32_SOF_RECEIVED */

      /* USER CODE END UX_DCD_STM32_SOF_RECEIVED */

      break;

    default:

      /* USER CODE BEGIN DEFAULT */

      /* USER CODE END DEFAULT */

      break;

  }

  /* USER CODE BEGIN USBD_ChangeFunction1 */

  /* USER CODE END USBD_ChangeFunction1 */

  return status;
}
[/#if]
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
