[#ftl]
/**************************************************************************/
/*                                                                        */
/*       Copyright (c) Microsoft Corporation. All rights reserved.        */
/*                                                                        */
/*       This software is licensed under the Microsoft Software License   */
/*       Terms for Microsoft Azure RTOS. Full text of the license can be  */
/*       found in the LICENSE file at https://aka.ms/AzureRTOS_EULA       */
/*       and in the root directory of this software.                      */
/*                                                                        */
/**************************************************************************/


/**************************************************************************/
/**************************************************************************/
/**                                                                       */
/** USBX Component                                                        */
/**                                                                       */
/**   User Specific                                                       */
/**                                                                       */
/**************************************************************************/
/**************************************************************************/


/**************************************************************************/
/*                                                                        */
/*  PORT SPECIFIC C INFORMATION                            RELEASE        */
/*                                                                        */
/*    ux_user.h                                           PORTABLE C      */
[#if FamilyName?lower_case?starts_with("stm32c0")]
/*                                                           6.3.0        */
[#else]
/*                                                           6.2.0        */
[/#if]
/*                                                                        */
/*  AUTHOR                                                                */
/*                                                                        */
/*    Chaoqiong Xiao, Microsoft Corporation                               */
/*                                                                        */
/*  DESCRIPTION                                                           */
/*                                                                        */
/*    This file contains user defines for configuring USBX in specific    */
/*    ways. This file will have an effect only if the application and     */
/*    USBX library are built with UX_INCLUDE_USER_DEFINE_FILE defined.    */
/*    Note that all the defines in this file may also be made on the      */
/*    command line when building USBX library and application objects.    */
/*                                                                        */
/*  RELEASE HISTORY                                                       */
/*                                                                        */
/*    DATE              NAME                      DESCRIPTION             */
/*                                                                        */
/*  05-19-2020     Chaoqiong Xiao           Initial Version 6.0           */
/*  09-30-2020     Chaoqiong Xiao           Modified comment(s),          */
/*                                            resulting in version 6.1    */
/*  02-02-2021     Xiuwen Cai               Modified comment(s), added    */
/*                                            compile option for using    */
/*                                            packet pool from NetX,      */
/*                                            resulting in version 6.1.4  */
/*  04-02-2021     Chaoqiong Xiao           Modified comment(s),          */
/*                                            added DFU_UPLOAD option,    */
/*                                            added macro to enable       */
/*                                            device bi-dir-endpoints,    */
/*                                            added macro to disable CDC- */
/*                                            ACM transmission support,   */
/*                                            resulting in version 6.1.6  */
/*  06-02-2021     Xiuwen Cai               Modified comment(s), added    */
/*                                            transfer timeout value      */
/*                                            options,                    */
/*                                            resulting in version 6.1.7  */
/*  08-02-2021     Wen Wang                 Modified comment(s),          */
/*                                            fixed spelling error,       */
/*                                            resulting in version 6.1.8  */
/*  10-15-2021     Chaoqiong Xiao           Modified comment(s),          */
/*                                            added option for assert,    */
/*                                            resulting in version 6.1.9  */
/*  01-31-2022     Chaoqiong Xiao           Modified comment(s),          */
/*                                            added standalone support,   */
/*                                            added option for device     */
/*                                            audio feedback endpoint,    */
/*                                            added option for MTP,       */
/*                                            added options for HID       */
/*                                            interrupt OUT support,      */
/*                                            added option to validate    */
/*                                            class code in enumeration,  */
/*                                            resulting in version 6.1.10 */
/*  07-29-2022     Chaoqiong Xiao           Modified comment(s),          */
/*                                            added audio class features, */
/*                                            added device CDC_ACM and    */
/*                                            printer write auto ZLP,     */
/*                                            resulting in version 6.1.12 */
/*  10-31-2022     Chaoqiong Xiao           Modified comment(s),          */
/*                                            deprecated ECM pool option, */
/*                                            added align minimal config, */
/*                                            added host stack instance   */
/*                                            creation strategy control,  */
/*                                            resulting in version 6.2.0  */
/*                                                                        */
[#if FamilyName?lower_case == "stm32u0"]
/*  03-08-2023     Chaoqiong Xiao           Modified comment(s),          */
/*                                            added option to disable dev */
/*                                            alternate setting support,  */
/*                                            added option to disable dev */
/*                                            framework initialize scan,  */
/*                                            added option to reference   */
/*                                            names by pointer to chars,  */
/*                                            added option to enable      */
/*                                            basic USBX error checking,  */
/*                                            resulting in version 6.2.1  */
/*                                                                        */
[/#if]
[#if FamilyName?lower_case?starts_with("stm32c0")]
/*  03-08-2023     Chaoqiong Xiao           Modified comment(s),          */
/*                                            added option to disable dev */
/*                                            alternate setting support,  */
/*                                            added option to disable dev */
/*                                            framework initialize scan,  */
/*                                            added option to reference   */
/*                                            names by pointer to chars,  */
/*                                            added option to enable      */
/*                                            basic USBX error checking,  */
/*                                            resulting in version 6.2.1  */
/*  10-31-2023     Xiuwen Cai, CQ Xiao      Modified comment(s),          */
/*                                            refined memory management,  */
/*                                            added zero copy support     */
/*                                            in many device classes,     */
/*                                            added a new mode to manage  */
/*                                            endpoint buffer in classes, */
/*                                            added option for get string */
/*                                            requests with zero wIndex,  */
/*                                            resulting in version 6.3.0  */
/*                                                                        */
[/#if]
/**************************************************************************/

#ifndef UX_USER_H
#define UX_USER_H

[#assign UX_HOST_ENABLED_Value = "false"]
[#assign UX_DEVICE_ENABLED_Value  = "false"]
[#assign UX_DEVICE_DFU_ENABLED_Value = "false"]
[#assign UX_DEVICE_CDC_ACM_ENABLED_Value = "false"]
[#assign UX_DEVICE_HID_CUSTOM_ENABLED_Value = "false"]
[#assign UX_DEVICE_PIMA_ENABLED_Value = "false"]
[#assign UX_DEVICE_CDC_ECM_ENABLED_Value = "false"]
[#assign UX_DEVICE_PRINTER_ENABLED_Value = "false"]
        [#assign UX_STANDALONE_ENABLED_Value = ""]
        [#assign UX_DEVICE_CLASS_PRINTER_WRITE_AUTO_ZLP_value = ""]


[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
 [#assign name = define.name]
 [#assign value = define.value]

  [#if name?contains("UX_Host_CoreStack") && (value=="1")]
   [#assign UX_HOST_ENABLED_Value = "true"]
  [/#if]

  [#if name?contains("UX_Device_CoreStack") && (value=="1")]
   [#assign UX_DEVICE_ENABLED_Value = "true"]
  [/#if]

  [#if name?contains("UX_DEVICE_HID_CUSTOM") && (value=="1")]
   [#assign UX_DEVICE_HID_CUSTOM_ENABLED_Value = "true"]
  [/#if]

  [#if name?contains("UX_DEVICE_PIMA") && (value=="1")]
   [#assign UX_DEVICE_PIMA_ENABLED_Value = "true"]
  [/#if]

  [#if name?contains("UX_DEVICE_CDC_ACM") && (value=="1")]
   [#assign UX_DEVICE_CDC_ACM_ENABLED_Value = "true"]
  [/#if]

  [#if name?contains("UX_DEVICE_DFU") && (value=="1")]
   [#assign UX_DEVICE_DFU_ENABLED_Value = "true"]
  [/#if]

  [#if name?contains("UX_DEVICE_CDC_ECM") && (value=="1")]
   [#assign UX_DEVICE_CDC_ECM_ENABLED_Value = "true"]
  [/#if]

  [#if name?contains("UX_DEVICE_PRINTER") && (value=="1")]
   [#assign UX_DEVICE_PRINTER_ENABLED_Value = "true"]
  [/#if]

[/#list]
[/#if]
[/#list]
[#compress]

[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
[#list SWIP.defines as definition]
 [#assign value = definition.value]
 [#assign name = definition.name]

  [#if name == "UX_THREAD_STACK_SIZE"]
   [#assign UX_THREAD_STACK_SIZE_value = value]
  [/#if]

  [#if name == "UX_HOST_ENUM_THREAD_STACK_SIZE"]
   [#assign UX_HOST_ENUM_THREAD_STACK_SIZE_value = value]
  [/#if]

  [#if name == "UX_HOST_HCD_THREAD_STACK_SIZE"]
   [#assign UX_HOST_HCD_THREAD_STACK_SIZE_value = value]
  [/#if]

  [#if name == "UX_HOST_HNP_POLLING_THREAD_STACK"]
   [#assign UX_HOST_HNP_POLLING_THREAD_STACK_value = value]
  [/#if]

  [#if name == "UX_PERIODIC_RATE"]
   [#assign UX_PERIODIC_RATE_value = value]
  [/#if]

  [#if name == "UX_MAX_CLASS_DRIVER"]
   [#assign UX_MAX_CLASS_DRIVER_value = value]
  [/#if]

  [#if name == "UX_MAX_SLAVE_CLASS_DRIVER"]
   [#assign UX_MAX_SLAVE_CLASS_DRIVER_value = value]
  [/#if]

  [#if name == "UX_MAX_SLAVE_LUN"]
   [#assign UX_MAX_SLAVE_LUN_value = value]
  [/#if]

  [#if name == "UX_MAX_SLAVE_INTERFACES"]
   [#assign UX_MAX_SLAVE_INTERFACES_value = value]
  [/#if]

  [#if name == "UX_MAX_DEVICES"]
   [#assign UX_MAX_DEVICES_value = value]
  [/#if]

  [#if name == "UX_MAX_HCD"]
   [#assign UX_MAX_HCD_value = value]
  [/#if]

  [#if name == "UX_MAX_HOST_LUN"]
   [#assign UX_MAX_HOST_LUN_value = value]
  [/#if]

  [#if name == "UX_SLAVE_REQUEST_CONTROL_MAX_LENGTH"]
   [#assign UX_SLAVE_REQUEST_CONTROL_MAX_LENGTH_value = value]
  [/#if]

  [#if name == "UX_SLAVE_REQUEST_DATA_MAX_LENGTH"]
   [#assign UX_SLAVE_REQUEST_DATA_MAX_LENGTH_value = value]
  [/#if]

  [#if name == "UX_SLAVE_CLASS_STORAGE_INCLUDE_MMC"]
   [#assign UX_SLAVE_CLASS_STORAGE_INCLUDE_MMC_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_STORAGE_MEMORY_BUFFER_SIZE"]
   [#assign UX_HOST_CLASS_STORAGE_MEMORY_BUFFER_SIZE_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_STORAGE_THREAD_STACK_SIZE"]
   [#assign UX_HOST_CLASS_STORAGE_THREAD_STACK_SIZE_value = value]
  [/#if]

  [#if name == "UX_MAX_ED"]
   [#assign UX_MAX_ED_value = value]
  [/#if]

  [#if name == "UX_MAX_TD"]
   [#assign UX_MAX_TD_value = value]
  [/#if]

  [#if name == "UX_MAX_ISO_TD"]
   [#assign UX_MAX_ISO_TD_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_HID_DECOMPRESSION_BUFFER"]
   [#assign UX_HOST_CLASS_HID_DECOMPRESSION_BUFFER_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_HID_USAGES"]
   [#assign UX_HOST_CLASS_HID_USAGES_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE"]
   [#assign UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE_REPORT_KEY_DOWN_ONLY"]
   [#assign UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE_REPORT_KEY_DOWN_ONLY_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE_REPORT_LOCK_KEYS"]
   [#assign UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE_REPORT_LOCK_KEYS_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE_REPORT_MODIFIER_KEYS"]
   [#assign UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE_REPORT_MODIFIER_KEYS_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_STORAGE_MAX_MEDIA"]
   [#assign UX_HOST_CLASS_STORAGE_MAX_MEDIA_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_STORAGE_INCLUDE_LEGACY_PROTOCOL_SUPPORT"]
   [#assign UX_HOST_CLASS_STORAGE_INCLUDE_LEGACY_PROTOCOL_SUPPORT_value = value]
  [/#if]

  [#if name == "UX_ENFORCE_SAFE_ALIGNMENT"]
   [#assign UX_ENFORCE_SAFE_ALIGNMENT_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES"]
   [#assign UX_DEVICE_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES"]
   [#assign UX_HOST_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_CDC_ECM_PACKET_POOL_WAIT"]
   [#assign UX_DEVICE_CLASS_CDC_ECM_PACKET_POOL_WAIT_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_HID_EVENT_BUFFER_LENGTH"]
   [#assign UX_DEVICE_CLASS_HID_EVENT_BUFFER_LENGTH_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_HID_MAX_EVENTS_QUEUE"]
   [#assign UX_DEVICE_CLASS_HID_MAX_EVENTS_QUEUE_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_DFU_UPLOAD_DISABLE"]
   [#assign UX_DEVICE_CLASS_DFU_UPLOAD_DISABLE_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_DFU_ERROR_GET_ENABLE"]
   [#assign UX_DEVICE_CLASS_DFU_ERROR_GET_ENABLE_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_DFU_STATUS_POLLTIMEOUT"]
   [#assign UX_DEVICE_CLASS_DFU_STATUS_POLLTIMEOUT_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_DFU_STATUS_MODE"]
   [#assign UX_DEVICE_CLASS_DFU_STATUS_MODE_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_DFU_CUSTOM_REQUEST_ENABLE"]
   [#assign UX_DEVICE_CLASS_DFU_CUSTOM_REQUEST_ENABLE_value = value]
  [/#if]

  [#if name == "UX_HOST_SIDE_ONLY"]
   [#assign UX_HOST_SIDE_ONLY_value = value]
  [/#if]

  [#if name == "UX_DEVICE_SIDE_ONLY"]
   [#assign UX_DEVICE_SIDE_ONLY_value = value]
  [/#if]


  [#if name == "UX_HOST_CLASS_STORAGE_MAX_TRANSFER_SIZE"]
   [#assign UX_HOST_CLASS_STORAGE_MAX_TRANSFER_SIZE_value = value]
  [/#if]

  [#if name == "UX_DEBUG_LOG_SIZE"]
   [#assign UX_DEBUG_LOG_SIZE_value = value]
  [/#if]

  [#if name == "UX_THREAD_PRIORITY_ENUM"]
   [#assign UX_THREAD_PRIORITY_ENUM_value = value]
  [/#if]

  [#if name == "UX_THREAD_PRIORITY_CLASS"]
   [#assign UX_THREAD_PRIORITY_CLASS_value = value]
  [/#if]

  [#if name == "UX_THREAD_PRIORITY_KEYBOARD"]
   [#assign UX_THREAD_PRIORITY_KEYBOARD_value = value]
  [/#if]

  [#if name == "UX_THREAD_PRIORITY_HCD"]
   [#assign UX_THREAD_PRIORITY_HCD_value = value]
  [/#if]

  [#if name == "UX_NO_TIME_SLICE"]
   [#assign UX_NO_TIME_SLICE_value = value]
  [/#if]

  [#if name == "UX_MAX_DEVICE_ENDPOINTS"]
   [#assign UX_MAX_DEVICE_ENDPOINTS_value = value]
  [/#if]

  [#if name == "UX_MAX_DEVICE_INTERFACES"]
   [#assign UX_MAX_DEVICE_INTERFACES_value = value]
  [/#if]

  [#if name == "UX_MAX_ROOTHUB_PORT"]
   [#assign UX_MAX_ROOTHUB_PORT_value = value]
  [/#if]

  [#if name == "UX_MAX_TT"]
   [#assign UX_MAX_TT_value = value]
  [/#if]

  [#if name == "UX_TRACE_INSERT_MACROS"]
   [#assign UX_TRACE_INSERT_MACROS_value = value]
  [/#if]

  [#if name == "UX_DEVICE_BIDIRECTIONAL_ENDPOINT_SUPPORT"]
   [#assign UX_DEVICE_BIDIRECTIONAL_ENDPOINT_SUPPORT_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_CDC_ACM_TRANSMISSION_DISABLE"]
   [#assign UX_DEVICE_CLASS_CDC_ACM_TRANSMISSION_DISABLE_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_HID_INTERRUPT_OUT_SUPPORT"]
   [#assign UX_DEVICE_CLASS_HID_INTERRUPT_OUT_SUPPORT_value = value]
  [/#if]

  [#if name == "UX_PIMA_WITH_MTP_SUPPORT"]
   [#assign UX_PIMA_WITH_MTP_SUPPORT_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_CDC_ACM_WRITE_AUTO_ZLP"]
   [#assign UX_DEVICE_CLASS_CDC_ACM_WRITE_AUTO_ZLP_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_PRINTER_WRITE_AUTO_ZLP"]
   [#assign UX_DEVICE_CLASS_PRINTER_WRITE_AUTO_ZLP_value = value]
  [/#if]

  [#if name == "UX_HOST_DEVICE_CLASS_CODE_VALIDATION_ENABLE"]
   [#assign UX_HOST_DEVICE_CLASS_CODE_VALIDATION_ENABLE_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_HID_INTERRUPT_OUT_SUPPORT"]
   [#assign UX_HOST_CLASS_HID_INTERRUPT_OUT_SUPPORT_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_AUDIO_2_SUPPORT"]
   [#assign UX_HOST_CLASS_AUDIO_2_SUPPORT_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_AUDIO_FEEDBACK_SUPPORT"]
   [#assign UX_HOST_CLASS_AUDIO_FEEDBACK_SUPPORT_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_AUDIO_INTERRUPT_SUPPORT"]
   [#assign UX_HOST_CLASS_AUDIO_INTERRUPT_SUPPORT_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_HID_REPORT_TRANSFER_TIMEOUT"]
   [#assign UX_HOST_CLASS_HID_REPORT_TRANSFER_TIMEOUT_value = value]
  [/#if]

  [#if name == "UX_ENABLE_ASSERT"]
   [#assign UX_ENABLE_ASSERT_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_CDC_ECM_PACKET_POOL_INSTANCE_WAIT"]
   [#assign UX_HOST_CLASS_CDC_ECM_PACKET_POOL_INSTANCE_WAIT_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_CDC_ECM_PACKET_POOL_WAIT"]
   [#assign UX_HOST_CLASS_CDC_ECM_PACKET_POOL_WAIT_value = value]
  [/#if]

  [#if name == "UX_HOST_CLASS_CDC_ECM_USE_PACKET_POOL_FROM_NETX"]
   [#assign UX_HOST_CLASS_CDC_ECM_USE_PACKET_POOL_FROM_NETX_value = value]
  [/#if]

  [#if name == "UX_CONTROL_TRANSFER_TIMEOUT"]
   [#assign UX_CONTROL_TRANSFER_TIMEOUT_value = value]
  [/#if]

  [#if name == "UX_NON_CONTROL_TRANSFER_TIMEOUT"]
   [#assign UX_NON_CONTROL_TRANSFER_TIMEOUT_value = value]
  [/#if]
  
  [#if name == "UX_OTG_SUPPORT"]
   [#assign UX_OTG_SUPPORT_value = value]
  [/#if] 
  
  [#if name == "UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT"]
   [#assign UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT_value = value]
  [/#if] 
  
  [#if name == "UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT"]
   [#assign UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT_value = value]
  [/#if] 

  [#if name == "UX_STANDALONE"]
   [#assign UX_STANDALONE_ENABLED_Value = value]
  [/#if] 

  [#if name == "UX_ENABLE_ERROR_CHECKING"]
    [#assign UX_ENABLE_ERROR_CHECKING_value = value]
  [/#if]
  
  [#if name == "UX_DEVICE_ALTERNATE_SETTING_SUPPORT_DISABLE"]
    [#assign UX_DEVICE_ALTERNATE_SETTING_SUPPORT_DISABLE_value = value]
  [/#if]

  [#if name == "UX_DEVICE_INITIALIZE_FRAMEWORK_SCAN_DISABLE"]
    [#assign UX_DEVICE_INITIALIZE_FRAMEWORK_SCAN_DISABLE_value = value]
  [/#if]

  [#if name == "UX_HOST_STACK_CONFIGURATION_INSTANCE_CREATE_CONTROL"]
    [#assign UX_HOST_STACK_CONFIGURATION_INSTANCE_CREATE_CONTROL_value = value]
  [/#if]

  [#if name == "UX_ALIGN_MIN"]
    [#assign UX_ALIGN_MIN_value = value]
  [/#if]

  [#if name == "UX_MAX_CLASSES"]
    [#assign UX_MAX_CLASSES_value = value]
  [/#if]

  [#if name == "UX_NAME_REFERENCED_BY_POINTER"]
    [#assign UX_NAME_REFERENCED_BY_POINTER_value = value]
  [/#if]

  [#if name == "UX_DEVICE_ENDPOINT_BUFFER_OWNER"]
    [#assign UX_DEVICE_ENDPOINT_BUFFER_OWNER_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_CDC_ACM_ZERO_COPY"]
    [#assign UX_DEVICE_CLASS_CDC_ACM_ZERO_COPY_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_HID_ZERO_COPY"]
    [#assign UX_DEVICE_CLASS_HID_ZERO_COPY_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_CDC_ECM_ZERO_COPY"]
    [#assign UX_DEVICE_CLASS_CDC_ECM_ZERO_COPY_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_RNDIS_ZERO_COPY"]
    [#assign UX_DEVICE_CLASS_RNDIS_ZERO_COPY_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_PRINTER_ZERO_COPY"]
    [#assign UX_DEVICE_CLASS_PRINTER_ZERO_COPY_value = value]
  [/#if]

  [#if name == "UX_DEVICE_ENABLE_GET_STRING_WITH_ZERO_LANGUAGE_ID"]
    [#assign UX_DEVICE_ENABLE_GET_STRING_WITH_ZERO_LANGUAGE_ID_value = value]
  [/#if]

  [#if name == "UX_DEVICE_CLASS_AUDIO_FEEDBACK_ENDPOINT_BUFFER_SIZE"]
    [#assign UX_DEVICE_CLASS_AUDIO_FEEDBACK_ENDPOINT_BUFFER_SIZE_value = value]
  [/#if]

[/#list]
[/#if]
[/#list]
[/#compress]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

/* Define various build options for the USBX port.  The application should either make changes
   here by commenting or un-commenting the conditional compilation defined OR supply the defines
   though the compiler's equivalent of the -D option.  */

/* Define USBX Generic Thread Stack Size.  */
[#if UX_THREAD_STACK_SIZE_value == "2048"]
/* #define UX_THREAD_STACK_SIZE                             (2 * 1024) */
[#else]
#define UX_THREAD_STACK_SIZE                                ${UX_THREAD_STACK_SIZE_value}
[/#if]

/* Define USBX Host Enum Thread Stack Size. The default is to use UX_THREAD_STACK_SIZE */
[#if UX_HOST_ENUM_THREAD_STACK_SIZE_value == "2048"]
/* #define UX_HOST_ENUM_THREAD_STACK_SIZE                   UX_THREAD_STACK_SIZE  */
[#else]
#define UX_HOST_ENUM_THREAD_STACK_SIZE                      ${UX_HOST_ENUM_THREAD_STACK_SIZE_value}
[/#if]

/* Define USBX Host HCD Thread Stack Size.  The default is to use UX_THREAD_STACK_SIZE */
[#if UX_HOST_HCD_THREAD_STACK_SIZE_value == "2048"]
/* #define UX_HOST_HCD_THREAD_STACK_SIZE                    UX_THREAD_STACK_SIZE */
[#else]
#define UX_HOST_HCD_THREAD_STACK_SIZE                       ${UX_HOST_HCD_THREAD_STACK_SIZE_value}
[/#if]

/* Define USBX Host HNP Polling Thread Stack Size. The default is to use UX_THREAD_STACK_SIZE */
[#if UX_HOST_HNP_POLLING_THREAD_STACK_value == "2048"]
/*
#define UX_HOST_HNP_POLLING_THREAD_STACK                    UX_THREAD_STACK_SIZE
*/
[#else]
#define UX_HOST_HNP_POLLING_THREAD_STACK                    ${UX_HOST_HNP_POLLING_THREAD_STACK_value}
[/#if]


/* Override various options with default values already assigned in ux_api.h or ux_port.h. Please
   also refer to ux_port.h for descriptions on each of these options.  */

[#if UX_ALIGN_MIN_value??]
/* Defined, this value represents minimal allocated memory alignment in number of bytes.
   The default is UX_ALIGN_16 (0x0f) to align allocated memory to 16 bytes.  */
[#if UX_ALIGN_MIN_value == "UX_ALIGN_16"]
/* #define UX_ALIGN_MIN                      UX_ALIGN_16 */
[#else]
#define UX_ALIGN_MIN                         ${UX_ALIGN_MIN_value}
[/#if]
[/#if]

/* Defined, this value represents how many ticks per seconds for a specific hardware platform.
   The default is 1000 indicating 1 tick per millisecond.  */

[#if UX_PERIODIC_RATE_value == "1000" && UX_STANDALONE_ENABLED_Value == "0"]
/* #define UX_PERIODIC_RATE     (TX_TIMER_TICKS_PER_SECOND) */
[#elseif UX_PERIODIC_RATE_value != "1000" && UX_STANDALONE_ENABLED_Value == "0"]
#define UX_PERIODIC_RATE        ${UX_PERIODIC_RATE_value}
[#elseif UX_STANDALONE_ENABLED_Value == "1"]
#define UX_PERIODIC_RATE        1000
[/#if]

/* Define control transfer timeout value in millisecond.
   The default is 10000 milliseconds.  */
[#if UX_CONTROL_TRANSFER_TIMEOUT_value??]
[#if UX_CONTROL_TRANSFER_TIMEOUT_value == "10000"]
/* #define UX_CONTROL_TRANSFER_TIMEOUT                      10000 */
[#else]
#define UX_CONTROL_TRANSFER_TIMEOUT                         ${UX_CONTROL_TRANSFER_TIMEOUT_value}
[/#if]
[/#if]

/* Define non control transfer timeout value in millisecond.
   The default is 50000 milliseconds.  */
[#if UX_NON_CONTROL_TRANSFER_TIMEOUT_value??]
[#if UX_NON_CONTROL_TRANSFER_TIMEOUT_value == "50000"]
/* #define UX_NON_CONTROL_TRANSFER_TIMEOUT                  50000 */
[#else]
#define UX_NON_CONTROL_TRANSFER_TIMEOUT                     ${UX_NON_CONTROL_TRANSFER_TIMEOUT_value}
[/#if]
[/#if]


/* Defined, this value is the maximum number of classes that can be loaded by USBX. This value
   represents the class container and not the number of instances of a class. For instance, if a
   particular implementation of USBX needs the hub class, the printer class, and the storage
   class, then the UX_MAX_CLASSES value can be set to 3 regardless of the number of devices
   that belong to these classes.  */
[#if UX_MAX_CLASSES_value??]
[#if UX_MAX_CLASSES_value == "2"]
/* #define UX_MAX_CLASSES    2 */
[#else]
#define UX_MAX_CLASSES       ${UX_MAX_CLASSES_value}
[/#if]
[/#if]


[#if UX_MAX_CLASS_DRIVER_value == "2"]
/* #define UX_MAX_CLASS_DRIVER    2 */
[#else]
#define UX_MAX_CLASS_DRIVER       ${UX_MAX_CLASS_DRIVER_value}
[/#if]

/* Defined, this value is the maximum number of classes in the device stack that can be loaded by
   USBX.  */

#define UX_MAX_SLAVE_CLASS_DRIVER    ${UX_MAX_SLAVE_CLASS_DRIVER_value}

/* Defined, this value is the maximum number of interfaces in the device framework.  */

[#if UX_MAX_SLAVE_INTERFACES_value == "16"]
/* #define UX_MAX_SLAVE_INTERFACES    16 */
[#else]
#define UX_MAX_SLAVE_INTERFACES       ${UX_MAX_SLAVE_INTERFACES_value}
[/#if]

/* Defined, this value represents the number of different host controllers available in the system.
   For USB 1.1 support, this value will usually be 1. For USB 2.0 support, this value can be more
   than 1. This value represents the number of concurrent host controllers running at the same time.
   If for instance there are two instances of OHCI running, or one EHCI and one OHCI controller
   running, the UX_MAX_HCD should be set to 2.  */

[#if UX_MAX_HCD_value == "1"]
/* #define UX_MAX_HCD       1 */
[#else]
#define UX_MAX_HCD          ${UX_MAX_HCD_value}
[/#if]

/* Defined, this value represents the maximum number of devices that can be attached to the USB.
   Normally, the theoretical maximum number on a single USB is 127 devices. This value can be
   scaled down to conserve memory. Note that this value represents the total number of devices
   regardless of the number of USB buses in the system.  */

[#if UX_MAX_DEVICES_value == "127"]
/* #define UX_MAX_DEVICES    127 */
[#else]
#define UX_MAX_DEVICES       ${UX_MAX_DEVICES_value}
[/#if]

/* Defined, this value represents the current number of SCSI logical units represented in the device
   storage class driver.  */

[#if UX_MAX_SLAVE_LUN_value == "1"]
/* #define UX_MAX_SLAVE_LUN    1 */
[#else]
#define UX_MAX_SLAVE_LUN              ${UX_MAX_SLAVE_LUN_value}
[/#if]

/* Defined, this value represents the maximum number of SCSI logical units represented in the
   host storage class driver.  */

[#if UX_MAX_HOST_LUN_value == "1"]
/* #define UX_MAX_HOST_LUN  1 */
[#else]
#define UX_MAX_HOST_LUN               ${UX_MAX_HOST_LUN_value}
[/#if]

/* Defined, this value represents the maximum number of bytes received on a control endpoint in
   the device stack. The default is 256 bytes but can be reduced in memory constrained environments.  */

[#if UX_SLAVE_REQUEST_CONTROL_MAX_LENGTH_value == "256"]
/* #define UX_SLAVE_REQUEST_CONTROL_MAX_LENGTH              256 */
[#else]
#define UX_SLAVE_REQUEST_CONTROL_MAX_LENGTH                 ${UX_SLAVE_REQUEST_CONTROL_MAX_LENGTH_value}
[/#if]

[#if FamilyName?lower_case?starts_with("stm32c0")]
/* Defined, this value represents the endpoint buffer owner.
   0 - The default, endpoint buffer is managed by core stack. Each endpoint takes UX_SLAVE_REQUEST_DATA_MAX_LENGTH bytes.
   1 - Endpoint buffer managed by classes. In this case not all endpoints consume UX_SLAVE_REQUEST_DATA_MAX_LENGTH bytes.
*/
[#if UX_DEVICE_ENDPOINT_BUFFER_OWNER_value == "0"]
#define UX_DEVICE_ENDPOINT_BUFFER_OWNER      0
[#else]
#define UX_DEVICE_ENDPOINT_BUFFER_OWNER      1
[/#if]

/* Defined, it enables device CDC ACM zero copy for bulk in/out endpoints (write/read).
    Enabled, the endpoint buffer is not allocated in class, application must
    provide the buffer for read/write, and the buffer must meet device controller driver (DCD)
    buffer requirements (e.g., aligned and cache safe).
    It only works if UX_DEVICE_ENDPOINT_BUFFER_OWNER is 1 (endpoint buffer managed by class).
 */

[#if UX_DEVICE_CLASS_CDC_ACM_ZERO_COPY_value == "1" && UX_DEVICE_ENDPOINT_BUFFER_OWNER_value == "1"]
#define UX_DEVICE_CLASS_CDC_ACM_ZERO_COPY
[#else]
/* #define UX_DEVICE_CLASS_CDC_ACM_ZERO_COPY  */
[/#if]

/* Defined, it enables device HID zero copy and flexible queue support (works if HID owns endpoint buffer).
    Enabled, the internal queue buffer is directly used for transfer, the APIs are kept to keep
    backword compatibility, to AVOID KEEPING BUFFERS IN APPLICATION.
    Flexible queue introduces initialization parameter _event_max_number and _event_max_length,
    so each HID function could have different queue settings.
    _event_max_number could be 2 ~ UX_DEVICE_CLASS_HID_MAX_EVENTS_QUEUE.
    Max of _event_max_length could be UX_DEVICE_CLASS_HID_EVENT_BUFFER_LENGTH.
    If the initialization parameters are invalid (are 0s or exceed upper mentioned definition),
    UX_DEVICE_CLASS_HID_MAX_EVENTS_QUEUE and UX_DEVICE_CLASS_HID_EVENT_BUFFER_LENGTH are used to
    calculate and allocate the queue.
 */
[#if UX_DEVICE_CLASS_HID_ZERO_COPY_value == "1" && UX_DEVICE_ENDPOINT_BUFFER_OWNER_value == "1"]
#define UX_DEVICE_CLASS_HID_ZERO_COPY
[#else]
/* #define UX_DEVICE_CLASS_HID_ZERO_COPY  */
[/#if]

/* Defined, it enables device CDC_ECM zero copy support (works if CDC_ECM owns endpoint buffer).
    Enabled, it requires that the NX IP default packet pool is in cache safe area, and buffer max
    size is larger than UX_DEVICE_CLASS_CDC_ECM_ETHERNET_PACKET_SIZE (1536).
 */

[#if UX_DEVICE_CLASS_CDC_ECM_ZERO_COPY_value == "1" && UX_DEVICE_ENDPOINT_BUFFER_OWNER_value == "1"]
#define UX_DEVICE_CLASS_CDC_ECM_ZERO_COPY
[#else]
/* #define UX_DEVICE_CLASS_CDC_ECM_ZERO_COPY  */
[/#if]

/* Defined, it enables device RNDIS zero copy support (works if RNDIS owns endpoint buffer).
    Enabled, it requires that the NX IP default packet pool is in cache safe area, and buffer max
    size is larger than UX_DEVICE_CLASS_RNDIS_MAX_PACKET_TRANSFER_SIZE (1600).
 */

[#if UX_DEVICE_CLASS_RNDIS_ZERO_COPY_value == "1" && UX_DEVICE_ENDPOINT_BUFFER_OWNER_value == "1"]
#define UX_DEVICE_CLASS_RNDIS_ZERO_COPY
[#else]
/* #define UX_DEVICE_CLASS_RNDIS_ZERO_COPY  */
[/#if]

/* Defined, it enables zero copy support (works if PRINTER owns endpoint buffer).
    Defined, it enables zero copy for bulk in/out endpoints (write/read). In this case, the endpoint
    buffer is not allocated in class, application must provide the buffer for read/write, and the
    buffer must meet device controller driver (DCD) buffer requirements (e.g., aligned and cache
    safe if buffer is for DMA).
 */

[#if UX_DEVICE_CLASS_PRINTER_ZERO_COPY_value == "1" && UX_DEVICE_ENDPOINT_BUFFER_OWNER_value == "1"]
#define UX_DEVICE_CLASS_PRINTER_ZERO_COPY
[#else]
/* #define UX_DEVICE_CLASS_PRINTER_ZERO_COPY  */
[/#if]
[/#if]


/* Defined, this value represents the maximum number of bytes that can be received or transmitted
   on any endpoint. This value cannot be less than the maximum packet size of any endpoint. The default
   is 2048 bytes but can be reduced in memory constrained environments. For cd-rom support in the storage
   class, this value cannot be less than 2048.  */

[#if UX_SLAVE_REQUEST_DATA_MAX_LENGTH_value == "2048"]
/* #define UX_SLAVE_REQUEST_DATA_MAX_LENGTH                 2048 */
[#else]
#define UX_SLAVE_REQUEST_DATA_MAX_LENGTH                    ${UX_SLAVE_REQUEST_DATA_MAX_LENGTH_value}
[/#if]

[#if FamilyName?lower_case?starts_with("stm32c0")]
/* Defined, this enables processing of Get String Descriptor requests with zero Language ID.
   The first language ID in the language ID framwork will be used if the request has a zero
   Language ID.  */

[#if UX_DEVICE_ENABLE_GET_STRING_WITH_ZERO_LANGUAGE_ID_value == "0"]
/* #define UX_DEVICE_ENABLE_GET_STRING_WITH_ZERO_LANGUAGE_ID  */
[#else]
#define UX_DEVICE_ENABLE_GET_STRING_WITH_ZERO_LANGUAGE_ID
[/#if]

[/#if]


/* Defined, this value includes code to handle storage Multi-Media Commands (MMC). E.g., DVD-ROM. */

[#if UX_SLAVE_CLASS_STORAGE_INCLUDE_MMC_value == "0"]
/* #define UX_SLAVE_CLASS_STORAGE_INCLUDE_MMC */
[#else]
#define UX_SLAVE_CLASS_STORAGE_INCLUDE_MMC
[/#if]

/* Defined, this value represents the maximum number of bytes that a storage payload can send/receive.
   The default is 8K bytes but can be reduced in memory constrained environments.  */

[#if UX_HOST_CLASS_STORAGE_MEMORY_BUFFER_SIZE_value == "8192"]
/* #define UX_HOST_CLASS_STORAGE_MEMORY_BUFFER_SIZE         8192 */
[#else]
#define UX_HOST_CLASS_STORAGE_MEMORY_BUFFER_SIZE            ${UX_HOST_CLASS_STORAGE_MEMORY_BUFFER_SIZE_value}
[/#if]

/* Define USBX Mass Storage Thread Stack Size. The default is to use UX_THREAD_STACK_SIZE. */

[#if UX_HOST_CLASS_STORAGE_THREAD_STACK_SIZE_value == "2048"]
/* #define UX_HOST_CLASS_STORAGE_THREAD_STACK_SIZE          UX_THREAD_STACK_SIZE */
[#else]
#define UX_HOST_CLASS_STORAGE_THREAD_STACK_SIZE             ${UX_HOST_CLASS_STORAGE_THREAD_STACK_SIZE_value}
[/#if]

/* Defined, this value represents the maximum number of Ed, regular TDs and Isochronous TDs. These values
   depend on the type of host controller and can be reduced in memory constrained environments.  */

[#if UX_MAX_ED_value == "80"]
/* #define UX_MAX_ED        80 */
[#else]
#define UX_MAX_ED           ${UX_MAX_ED_value}
[/#if]

[#if UX_MAX_TD_value == "128"]
/* #define UX_MAX_TD        128 */
[#else]
#define UX_MAX_TD           ${UX_MAX_TD_value}
[/#if]

[#if UX_MAX_ISO_TD_value == "1"]
/* #define UX_MAX_ISO_TD    1 */
[#else]
#define UX_MAX_ISO_TD       ${UX_MAX_ISO_TD_value}
[/#if]

/* Defined, this value represents the maximum size of the HID decompressed buffer. This cannot be determined
   in advance so we allocate a big block, usually 4K but for simple HID devices like keyboard and mouse
   it can be reduced a lot. */

[#if UX_HOST_CLASS_HID_DECOMPRESSION_BUFFER_value == "4096"]
/* #define UX_HOST_CLASS_HID_DECOMPRESSION_BUFFER           4096 */
[#else]
#define UX_HOST_CLASS_HID_DECOMPRESSION_BUFFER              ${UX_HOST_CLASS_HID_DECOMPRESSION_BUFFER_value}
[/#if]

/* Defined, this value represents the maximum number of HID usages for a HID device.
   Default is 2048 but for simple HID devices like keyboard and mouse it can be reduced a lot. */

[#if UX_HOST_CLASS_HID_USAGES_value == "2048"]
/* #define UX_HOST_CLASS_HID_USAGES                         2048 */
[#else]
#define UX_HOST_CLASS_HID_USAGES                            ${UX_HOST_CLASS_HID_USAGES_value}
[/#if]

/* By default, each key in each HID report from the device is reported by ux_host_class_hid_keyboard_key_get
   (a HID report from the device is received whenever there is a change in a key state i.e. when a key is pressed
   or released. The report contains every key that is down). There are limitations to this method such as not being
   able to determine when a key has been released.

   Defined, this value causes ux_host_class_hid_keyboard_key_get to only report key changes i.e. key presses
   and key releases. */

[#if UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE_value == "1"]
#define UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE
[#else]
/* #define UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE */
[/#if]

/* Works when UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE is defined.

   Defined, this value causes ux_host_class_hid_keyboard_key_get to only report key pressed/down changes;
   key released/up changes are not reported.
 */

[#if UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE_REPORT_KEY_DOWN_ONLY_value == "1"]
#define UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE_REPORT_KEY_DOWN_ONLY
[#else]
/* #define UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE_REPORT_KEY_DOWN_ONLY */
[/#if]

/* Works when UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE is defined.

   Defined, this value causes ux_host_class_hid_keyboard_key_get to report lock key (CapsLock/NumLock/ScrollLock) changes.
 */

[#if UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE_REPORT_LOCK_KEYS_value == "1"]
#define UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE_REPORT_LOCK_KEYS
[#else]
/* #define UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE_REPORT_LOCK_KEYS */
[/#if]

/* Works when UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE is defined.

   Defined, this value causes ux_host_class_hid_keyboard_key_get to report modifier key (Ctrl/Alt/Shift/GUI) changes.
 */

[#if UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE_REPORT_MODIFIER_KEYS_value == "1"]
#define UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE_REPORT_MODIFIER_KEYS
[#else]
/* #define UX_HOST_CLASS_HID_KEYBOARD_EVENTS_KEY_CHANGES_MODE_REPORT_MODIFIER_KEYS */
[/#if]

/* Defined, this value represents the maximum number of media for the host storage class.
   Default is 8 but for memory constrained resource systems this can ne reduced to 1. */

[#if UX_HOST_CLASS_STORAGE_MAX_MEDIA_value == "2"]
/* #define UX_HOST_CLASS_STORAGE_MAX_MEDIA                  2 */
[#else]
#define UX_HOST_CLASS_STORAGE_MAX_MEDIA                     ${UX_HOST_CLASS_STORAGE_MAX_MEDIA_value}
[/#if]

/* Defined, this value includes code to handle storage devices that use the CB
   or CBI protocol (such as floppy disks). It is off by default because these
   protocols are obsolete, being superseded by the Bulk Only Transport (BOT) protocol
   which virtually all modern storage devices use.
*/

[#if UX_HOST_CLASS_STORAGE_INCLUDE_LEGACY_PROTOCOL_SUPPORT_value == "0"]
/* #define UX_HOST_CLASS_STORAGE_INCLUDE_LEGACY_PROTOCOL_SUPPORT */
[#else]
#define UX_HOST_CLASS_STORAGE_INCLUDE_LEGACY_PROTOCOL_SUPPORT
[/#if]

/* Defined, this value forces the memory allocation scheme to enforce alignment
   of memory with the UX_SAFE_ALIGN field.
*/

[#if UX_ENFORCE_SAFE_ALIGNMENT_value == "0"]
/* #define UX_ENFORCE_SAFE_ALIGNMENT */
[#else]
#define UX_ENFORCE_SAFE_ALIGNMENT
[/#if]

/* Defined, this value represents the number of packets in the CDC_ECM device class.
   The default is 16.
*/

[#if UX_DEVICE_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES_value == "4"]
/* #define UX_DEVICE_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES        4 */
[#else]
#define UX_DEVICE_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES           ${UX_DEVICE_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES_value}
[/#if]

/* Defined, this value represents the number of packets in the CDC_ECM host class.
   The default is 16.
*/
[#if UX_HOST_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES_value == "16"]
/* #define UX_HOST_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES          16 */
[#else]
#define UX_HOST_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES             ${UX_HOST_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES_value}
[/#if]

/* Defined, this value represents the number of milliseconds to wait for packet
   allocation until invoking the application's error callback and retrying.
   The default is 1000 milliseconds.
*/

[#if UX_HOST_CLASS_CDC_ECM_PACKET_POOL_WAIT_value == "10"]
/* #define UX_HOST_CLASS_CDC_ECM_PACKET_POOL_WAIT           10 */
[#else]
#define UX_HOST_CLASS_CDC_ECM_PACKET_POOL_WAIT              ${UX_HOST_CLASS_CDC_ECM_PACKET_POOL_WAIT_value}
[/#if]

/* Defined, this value represents the number of milliseconds to wait for packet
   pool availability checking loop.
   The default is 100 milliseconds.
*/

[#if UX_HOST_CLASS_CDC_ECM_PACKET_POOL_INSTANCE_WAIT_value??]
[#if UX_HOST_CLASS_CDC_ECM_PACKET_POOL_INSTANCE_WAIT_value == "10"]
/* #define UX_HOST_CLASS_CDC_ECM_PACKET_POOL_INSTANCE_WAIT  10 */
[#else]
#define UX_HOST_CLASS_CDC_ECM_PACKET_POOL_INSTANCE_WAIT     ${UX_HOST_CLASS_CDC_ECM_PACKET_POOL_INSTANCE_WAIT_value}
[/#if]
[/#if]

/* Defined, this enables CDC ECM class to use the packet pool from NetX instance.  */

[#if UX_HOST_CLASS_CDC_ECM_USE_PACKET_POOL_FROM_NETX_value == "0"]
/* #define UX_HOST_CLASS_CDC_ECM_USE_PACKET_POOL_FROM_NETX */
[#else]
#define UX_HOST_CLASS_CDC_ECM_USE_PACKET_POOL_FROM_NETX
[/#if]

/* Defined, this value represents the number of milliseconds to wait for packet
   allocation until invoking the application's error callback and retrying.
*/

[#if UX_DEVICE_CLASS_CDC_ECM_PACKET_POOL_WAIT_value == "10"]
/* #define UX_DEVICE_CLASS_CDC_ECM_PACKET_POOL_WAIT         10 */
[#else]
#define UX_DEVICE_CLASS_CDC_ECM_PACKET_POOL_WAIT            ${UX_DEVICE_CLASS_CDC_ECM_PACKET_POOL_WAIT_value}
[/#if]

/* Defined, this value represents the the maximum length of HID reports on the
   device.
 */

[#if UX_DEVICE_CLASS_HID_EVENT_BUFFER_LENGTH_value == "64"]
/* #define UX_DEVICE_CLASS_HID_EVENT_BUFFER_LENGTH          64 */
[#else]
#define UX_DEVICE_CLASS_HID_EVENT_BUFFER_LENGTH             ${UX_DEVICE_CLASS_HID_EVENT_BUFFER_LENGTH_value}
[/#if]

/* Defined, this value represents the the maximum number of HID events/reports
   that can be queued at once.
 */

[#if UX_DEVICE_CLASS_HID_MAX_EVENTS_QUEUE_value == "8"]
/* #define UX_DEVICE_CLASS_HID_MAX_EVENTS_QUEUE             8 */
[#else]
#define UX_DEVICE_CLASS_HID_MAX_EVENTS_QUEUE                ${UX_DEVICE_CLASS_HID_MAX_EVENTS_QUEUE_value}
[/#if]


/* Defined, this macro will disable DFU_UPLOAD support.  */

[#if UX_DEVICE_CLASS_DFU_UPLOAD_DISABLE_value == "1"]
#define UX_DEVICE_CLASS_DFU_UPLOAD_DISABLE
[#else]
/* #define UX_DEVICE_CLASS_DFU_UPLOAD_DISABLE  */
[/#if]

/* Defined, this macro will enable DFU_GETSTATUS and DFU_GETSTATE in dfuERROR.  */

[#if UX_DEVICE_CLASS_DFU_ERROR_GET_ENABLE_value == "1"]
#define UX_DEVICE_CLASS_DFU_ERROR_GET_ENABLE
[#else]
/* #define UX_DEVICE_CLASS_DFU_ERROR_GET_ENABLE  */
[/#if]

/* Defined, this macro will change status mode.
   0 - simple mode,
       status is queried from application in dfuDNLOAD-SYNC and dfuMANIFEST-SYNC state,
       no bwPollTimeout.
   1 - status is queried from application once requested,
       b0-3 : media status
       b4-7 : bStatus
       b8-31: bwPollTimeout
       bwPollTimeout supported.
*/

[#if UX_DEVICE_CLASS_DFU_STATUS_MODE_value == "0"  && UX_DEVICE_DFU_ENABLED_Value == "true"]
#define UX_DEVICE_CLASS_DFU_STATUS_MODE                     0
[#elseif UX_DEVICE_CLASS_DFU_STATUS_MODE_value == "1"  && UX_DEVICE_DFU_ENABLED_Value == "true"]
#define UX_DEVICE_CLASS_DFU_STATUS_MODE                     1
[#else]
/* #define UX_DEVICE_CLASS_DFU_STATUS_MODE                  1 */
[/#if]


/* Defined, this value represents the default DFU status bwPollTimeout.
   The value is 3 bytes long (max 0xFFFFFFu).
   By default the bwPollTimeout is 1 (means 1ms).
 */

[#if UX_DEVICE_CLASS_DFU_STATUS_POLLTIMEOUT_value == "1" && UX_DEVICE_DFU_ENABLED_Value == "true"]
#define UX_DEVICE_CLASS_DFU_STATUS_POLLTIMEOUT              1
[#elseif UX_DEVICE_CLASS_DFU_STATUS_POLLTIMEOUT_value != "1" && UX_DEVICE_DFU_ENABLED_Value == "true"]
#define UX_DEVICE_CLASS_DFU_STATUS_POLLTIMEOUT              ${UX_DEVICE_CLASS_DFU_STATUS_POLLTIMEOUT_value}
[#else]
/* #define UX_DEVICE_CLASS_DFU_STATUS_POLLTIMEOUT           1 */
[/#if]

/* Defined, this macro will enable custom request process callback.  */

[#if UX_DEVICE_CLASS_DFU_CUSTOM_REQUEST_ENABLE_value == "1" && UX_DEVICE_DFU_ENABLED_Value == "true"]
#define UX_DEVICE_CLASS_DFU_CUSTOM_REQUEST_ENABLE
[#else]
/* #define UX_DEVICE_CLASS_DFU_CUSTOM_REQUEST_ENABLE  */
[/#if]

/* Defined, this macro disables CDC ACM non-blocking transmission support. */

[#if UX_DEVICE_CLASS_CDC_ACM_TRANSMISSION_DISABLE_value == "1" && UX_DEVICE_CDC_ACM_ENABLED_Value == "true"]
#define UX_DEVICE_CLASS_CDC_ACM_TRANSMISSION_DISABLE
[#else]
/* #define UX_DEVICE_CLASS_CDC_ACM_TRANSMISSION_DISABLE */
[/#if]

/* Defined, device HID interrupt OUT transfer is supported.  */

[#if UX_DEVICE_CLASS_HID_INTERRUPT_OUT_SUPPORT_value == "1" && UX_DEVICE_HID_CUSTOM_ENABLED_Value == "true"]
#define UX_DEVICE_CLASS_HID_INTERRUPT_OUT_SUPPORT
[#else]
/* #define UX_DEVICE_CLASS_HID_INTERRUPT_OUT_SUPPORT */
[/#if]

/* defined, this macro enables device audio feedback endpoint support.  */

[#if UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT_value == "1"]
#define UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT
[#else]
/* #define UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT  */
[/#if]

/* Defined, class _write is pending ZLP automatically (complete transfer) after buffer is sent.  */

[#if UX_DEVICE_CLASS_CDC_ACM_WRITE_AUTO_ZLP_value == "1" && UX_DEVICE_CDC_ACM_ENABLED_Value == "true"]
#define UX_DEVICE_CLASS_CDC_ACM_WRITE_AUTO_ZLP
[#else]
/* #define UX_DEVICE_CLASS_CDC_ACM_WRITE_AUTO_ZLP  */
[/#if]

[#if UX_DEVICE_CLASS_PRINTER_WRITE_AUTO_ZLP_value == "1" && UX_DEVICE_PRINTER_ENABLED_Value == "true"]
#define UX_DEVICE_CLASS_PRINTER_WRITE_AUTO_ZLP
[#else]
/* #define UX_DEVICE_CLASS_PRINTER_WRITE_AUTO_ZLP  */
[/#if]

/* defined, this macro enables device audio interrupt endpoint support.  */
[#if UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT_value == "1"]
#define UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT
[#else]
/* #define UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT  */
[/#if]

/* Defined, this macro enables device bi-directional endpoint support. */

[#if UX_DEVICE_BIDIRECTIONAL_ENDPOINT_SUPPORT_value == "1" && UX_DEVICE_ENABLED_Value == "true"]
#define UX_DEVICE_BIDIRECTIONAL_ENDPOINT_SUPPORT
[#else]
/* #define UX_DEVICE_BIDIRECTIONAL_ENDPOINT_SUPPORT */
[/#if]

[#if UX_DEVICE_ALTERNATE_SETTING_SUPPORT_DISABLE_value??]
/* Defined, this macro disables interface alternate setting support.
   Device stalls
 */
[#if UX_DEVICE_ALTERNATE_SETTING_SUPPORT_DISABLE_value == "1"]
#define UX_DEVICE_ALTERNATE_SETTING_SUPPORT_DISABLE
[#else]
/* #define UX_DEVICE_ALTERNATE_SETTING_SUPPORT_DISABLE  */
[/#if]
[/#if]

[#if UX_DEVICE_INITIALIZE_FRAMEWORK_SCAN_DISABLE_value??]
/* Defined, this macro disables device framework scan, where max number of endpoints (except EP0)
   and max number of interfaces are calculated at runtime, as a base to allocate memory for
   interfaces and endpoints structures and their buffers.
   Undefined, the following two macros must be defined to initialize memory structures. */
   
[#if UX_DEVICE_INITIALIZE_FRAMEWORK_SCAN_DISABLE_value == "1"]
#define UX_DEVICE_INITIALIZE_FRAMEWORK_SCAN_DISABLE
[#else]
/* #define UX_DEVICE_INITIALIZE_FRAMEWORK_SCAN_DISABLE */
[/#if]
[/#if]

/* Defined, this macro enables device/host PIMA MTP support.  */

[#if UX_PIMA_WITH_MTP_SUPPORT_value == "1" && UX_DEVICE_PIMA_ENABLED_Value == "true"]
#define UX_PIMA_WITH_MTP_SUPPORT
[#else]
/* #define UX_PIMA_WITH_MTP_SUPPORT */
[/#if]

/* Defined, this macro enables host device class code validation.
   Only following USB-IF allowed device class code is allowed:
   0x00, 0x02 (CDC Control), 0x09 (Hub), 0x11 (Billboard), 0xDC (Diagnostic), 0xEF (MISC), 0xFF (Vendor)
   Refer to https://www.usb.org/defined-class-codes for more details.
 */

[#if UX_HOST_DEVICE_CLASS_CODE_VALIDATION_ENABLE_value == "0"]
/* #define UX_HOST_DEVICE_CLASS_CODE_VALIDATION_ENABLE  */
[#else]
#define UX_HOST_DEVICE_CLASS_CODE_VALIDATION_ENABLE
[/#if]

/* Defined, host HID interrupt OUT transfer is supported.  */

[#if UX_HOST_CLASS_HID_INTERRUPT_OUT_SUPPORT_value == "0"]
/* #define UX_HOST_CLASS_HID_INTERRUPT_OUT_SUPPORT  */
[#else]
#define UX_HOST_CLASS_HID_INTERRUPT_OUT_SUPPORT
[/#if]

/* Define HID report transfer timeout value in millisecond.
   The default is 10000 milliseconds.  */

[#if UX_HOST_CLASS_HID_REPORT_TRANSFER_TIMEOUT_value == "10000"]
/* #define UX_HOST_CLASS_HID_REPORT_TRANSFER_TIMEOUT        10000 */
[#else]
#define UX_HOST_CLASS_HID_REPORT_TRANSFER_TIMEOUT           ${UX_HOST_CLASS_HID_REPORT_TRANSFER_TIMEOUT_value}
[/#if]

/* Defined, host audio UAC 2.0 is supported.  */
[#if UX_HOST_CLASS_AUDIO_2_SUPPORT_value == "0"]
/* #define UX_HOST_CLASS_AUDIO_2_SUPPORT  */
[#else]
#define UX_HOST_CLASS_AUDIO_2_SUPPORT
[/#if]

/* Defined, host audio optional feedback endpoint is supported.  */
[#if UX_HOST_CLASS_AUDIO_FEEDBACK_SUPPORT_value == "0"]
/* #define UX_HOST_CLASS_AUDIO_FEEDBACK_SUPPORT  */
[#else]
#define UX_HOST_CLASS_AUDIO_FEEDBACK_SUPPORT
[/#if]

/* Defined, host audio optional interrupt endpoint is support.  */
[#if UX_HOST_CLASS_AUDIO_INTERRUPT_SUPPORT_value == "0"]
/* #define UX_HOST_CLASS_AUDIO_INTERRUPT_SUPPORT  */
[#else]
#define UX_HOST_CLASS_AUDIO_INTERRUPT_SUPPORT
[/#if]

[#if UX_HOST_STACK_CONFIGURATION_INSTANCE_CREATE_CONTROL_value??]
/* Defined, this value controls host configuration instance creation, include all
   interfaces and endpoints physical resources.
   Possible settings:
    UX_HOST_STACK_CONFIGURATION_INSTANCE_CREATE_ALL (0) - The default, create all inside configuration.
    UX_HOST_STACK_CONFIGURATION_INSTANCE_CREATE_OWNED (1) - Create things owned by class driver.
   Not defined, default setting is applied. */

[#if UX_HOST_STACK_CONFIGURATION_INSTANCE_CREATE_CONTROL_value == "UX_HOST_STACK_CONFIGURATION_INSTANCE_CREATE_ALL"]
/* #define UX_HOST_STACK_CONFIGURATION_INSTANCE_CREATE_CONTROL        UX_HOST_STACK_CONFIGURATION_INSTANCE_CREATE_ALL */
[#else]
#define UX_HOST_STACK_CONFIGURATION_INSTANCE_CREATE_CONTROL           ${UX_HOST_STACK_CONFIGURATION_INSTANCE_CREATE_CONTROL_value}
[/#if]
[/#if]

[#if UX_NAME_REFERENCED_BY_POINTER_value??]
/* Defined, the _name in structs are referenced by pointer instead of by contents.
   By default the _name is an array of string that saves characters, the contents are compared to confirm match.
   If referenced by pointer the address pointer to const string is saved, the pointers are compared to confirm match. */
[#if UX_NAME_REFERENCED_BY_POINTER_value == "0"]
/* #define UX_NAME_REFERENCED_BY_POINTER  */
[#else]
#define UX_NAME_REFERENCED_BY_POINTER
[/#if]
[/#if]

/* Defined, this value will only enable the host side of usbx.  */
[#if FamilyName?lower_case == "stm32u0"]
/* #define UX_HOST_SIDE_ONLY */
[#else]
[#if UX_HOST_SIDE_ONLY_value == "1" && UX_HOST_ENABLED_Value == "true"]
#define UX_HOST_SIDE_ONLY
[#else]
/* #define UX_HOST_SIDE_ONLY */
[/#if]
[/#if]

[#if FamilyName?lower_case == "stm32u0"]
#define UX_DEVICE_SIDE_ONLY
[#else]
/* Defined, this value will only enable the device side of usbx.  */
[#if UX_DEVICE_SIDE_ONLY_value == "1" && UX_DEVICE_ENABLED_Value == "true"]
#define UX_DEVICE_SIDE_ONLY
[#else]
/* #define UX_DEVICE_SIDE_ONLY */
[/#if]
[/#if]
/* Defined, this value will include the OTG polling thread. OTG can only be active if both host/device are present.
*/
#ifndef UX_HOST_SIDE_ONLY
#ifndef UX_DEVICE_SIDE_ONLY
[#if (DIE=="DIE455" || DIE=="DIE474" || DIE=="DIE484"  || DIE=="DIE478"  || DIE=="DIE489" || DIE=="DIE493" || (UX_OTG_SUPPORT_value?? && UX_OTG_SUPPORT_value == "0" ))]
/* #define UX_OTG_SUPPORT */
[#else]
#define UX_OTG_SUPPORT
[/#if]
#endif
#endif

/* Defined, this macro will enable the standalone mode of usbx.  */
[#if UX_STANDALONE_ENABLED_Value == "1"]
#define UX_STANDALONE
[#else]
/* #define UX_STANDALONE  */
[/#if]

/* Defined, this value represents the maximum size of single transfers for the SCSI data phase.
   By default it's 1024.
*/

[#if UX_HOST_CLASS_STORAGE_MAX_TRANSFER_SIZE_value == "1024"]
/* #define UX_HOST_CLASS_STORAGE_MAX_TRANSFER_SIZE          (1024 * 1) */
[#else]
#define UX_HOST_CLASS_STORAGE_MAX_TRANSFER_SIZE             ${UX_HOST_CLASS_STORAGE_MAX_TRANSFER_SIZE_value}
[/#if]

/* Defined, this value represents the size of the log pool.
*/
[#if UX_DEBUG_LOG_SIZE_value == "16384"]
/* #define UX_DEBUG_LOG_SIZE          (1024 * 16) */
[#else]
#define UX_DEBUG_LOG_SIZE             ${UX_DEBUG_LOG_SIZE_value}
[/#if]

/* Defined, this macro represents the non-blocking function to return time tick.
   This macro is used only in standalone mode.
   The tick rate is defined by UX_PERIODIC_RATE.
   If it's not defined, or TX is not included, a external function must be
   implement in application:
      extern  ULONG       _ux_utility_time_get(VOID);
*/
/* #define _ux_utility_time_get() tx_time_get()  */

/* Defined, this macro represents the non-blocking function to disable interrupts
   and return old interrupt setting flags.
   If it's not defined, or TX is not included, a external function must be
   implement in application:
      extern ALIGN_TYPE   _ux_utility_interrupt_disable(VOID);
*/
/* #define _ux_utility_interrupt_disable() _tx_thread_interrupt_disable()  */

/* Defined, this macro represents the non-blocking function to restore interrupts.
   If it's not defined, or TX is not included, a external function must be
   implement in application:
      extern VOID         _ux_utility_interrupt_restore(ALIGN_TYPE);
*/
/* #define _ux_utility_interrupt_restore(flags) _tx_thread_interrupt_restore(flags)  */

/* Defined, this enables the assert checks inside usbx.  */
[#if UX_ENABLE_ASSERT_value??]
[#if UX_ENABLE_ASSERT_value == "0"]
/* #define UX_ENABLE_ASSERT */
[#else]
#define UX_ENABLE_ASSERT
[/#if]
[/#if]

/* Defined, this defines the assert action taken when failure detected. By default
   it halts without any output.  */
[#if UX_ENABLE_ASSERT_value??]
[#if UX_ENABLE_ASSERT_value == "0"]
/* #define UX_ASSERT_FAIL  for (;;) {tx_thread_sleep(UX_WAIT_FOREVER); }  */
[#else]
#define UX_ASSERT_FAIL  for (;;) {tx_thread_sleep(UX_WAIT_FOREVER); }
[/#if]
[/#if]

/* This is the ThreadX priority value for the USBX enumeration threads that monitors the bus topology */

[#if UX_THREAD_PRIORITY_ENUM_value == "20"]
/* #define UX_THREAD_PRIORITY_ENUM           20 */
[#else]
#define UX_THREAD_PRIORITY_ENUM              ${UX_THREAD_PRIORITY_ENUM_value}
[/#if]

/* This is the ThreadX priority value for the standard USBX threads */

[#if UX_THREAD_PRIORITY_CLASS_value == "20"]
/* #define UX_THREAD_PRIORITY_CLASS          20 */
[#else]
#define UX_THREAD_PRIORITY_CLASS             ${UX_THREAD_PRIORITY_CLASS_value}
[/#if]

/* This is the ThreadX priority value for the USBX HID keyboard class. */

[#if UX_THREAD_PRIORITY_KEYBOARD_value == "20"]
/* #define UX_THREAD_PRIORITY_KEYBOARD       20 */
[#else]
#define UX_THREAD_PRIORITY_KEYBOARD          ${UX_THREAD_PRIORITY_KEYBOARD_value}
[/#if]

/* This is the ThreadX priority value for the host controller thread. */

[#if UX_THREAD_PRIORITY_HCD_value == "2"]
/* #define UX_THREAD_PRIORITY_HCD             2 */
[#else]
#define UX_THREAD_PRIORITY_HCD                ${UX_THREAD_PRIORITY_HCD_value}
[/#if]

/* This value actually defines the time slice that will be used for threads. For example, if defined to 0, the ThreadX target port does not use time slices. */

[#if UX_NO_TIME_SLICE_value == "0"]
/* #define UX_NO_TIME_SLICE                  0 */
[#else]
#define UX_NO_TIME_SLICE                     ${UX_NO_TIME_SLICE_value}
[/#if]

/* it define USBX device max number of endpoints (1~n). */

[#if UX_MAX_DEVICE_ENDPOINTS_value == "6"]
/* #define UX_MAX_DEVICE_ENDPOINTS           6 */
[#else]
#define UX_MAX_DEVICE_ENDPOINTS              ${UX_MAX_DEVICE_ENDPOINTS_value}
[/#if]

/* it define USBX device max number of interfacess (1~n). */

[#if UX_MAX_DEVICE_INTERFACES_value == "6"]
/* #define UX_MAX_DEVICE_INTERFACES          6 */
[#else]
#define UX_MAX_DEVICE_INTERFACES             ${UX_MAX_DEVICE_INTERFACES_value}
[/#if]

/* Define USBX max root hub port (1 ~ n).  */

[#if UX_MAX_ROOTHUB_PORT_value == "4"]
/* #define UX_MAX_ROOTHUB_PORT             4 */
[#else]
#define UX_MAX_ROOTHUB_PORT                ${UX_MAX_ROOTHUB_PORT_value}
[/#if]

/* Define USBX max TT. */

[#if UX_MAX_TT_value == "8"]
/* #define UX_MAX_TT                        8 */
[#else]
#define UX_MAX_TT                           ${UX_MAX_TT_value}
[/#if]

[#if UX_ENABLE_ERROR_CHECKING_value??]
/* Defined, this option enables the basic USBX error checking. This define is typically used
   when the application is debugging and removed after the application is fully debugged.  */
   
[#if UX_ENABLE_ERROR_CHECKING_value == "0"]
/* #define UX_ENABLE_ERROR_CHECKING */
[#else]
#define UX_ENABLE_ERROR_CHECKING
[/#if]
[/#if]

/* USER CODE BEGIN 2 */

/* USER CODE END 2 */

#endif
