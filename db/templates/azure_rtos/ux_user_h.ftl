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
/*                                                           6.0          */
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
/*                                                                        */
/**************************************************************************/

#ifndef UX_USER_H
#define UX_USER_H

[#assign UX_HOST_ENABLED_Value = "false"]
[#assign UX_DEVICE_ENABLED_Value  = "false"]

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
	
	[#if name == "UX_HOST_CLASS_CDC_ECM_PACKET_POOL_WAIT"]
      [#assign UX_HOST_CLASS_CDC_ECM_PACKET_POOL_WAIT_value = value]
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
	
	[#if name == "UX_OTG_SUPPORT"]
      [#assign UX_OTG_SUPPORT_value = value]
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
	
  [/#list]
[/#if]
[/#list]
[/#compress]

/* Define various build options for the USBX port.  The application should either make changes
   here by commenting or un-commenting the conditional compilation defined OR supply the defines
   though the compiler's equivalent of the -D option.  */

[#if UX_THREAD_STACK_SIZE_value == "2048"]
/* #define UX_THREAD_STACK_SIZE                                (2 * 1024)
*/
[#else]
#define UX_THREAD_STACK_SIZE                                ${UX_THREAD_STACK_SIZE_value}
[/#if]

/* Define USBX Host Enum Thread Stack Size. The default is to use UX_THREAD_STACK_SIZE */
[#if UX_HOST_ENUM_THREAD_STACK_SIZE_value == "2048"]
/*
#define UX_HOST_ENUM_THREAD_STACK_SIZE                      UX_THREAD_STACK_SIZE
*/
[#else]
#define UX_HOST_ENUM_THREAD_STACK_SIZE                      ${UX_HOST_ENUM_THREAD_STACK_SIZE_value}
[/#if]

/* Define USBX Host Thread Stack Size.  The default is to use UX_THREAD_STACK_SIZE */
[#if UX_HOST_HCD_THREAD_STACK_SIZE_value == "2048"]
/*
#define UX_HOST_HCD_THREAD_STACK_SIZE                       UX_THREAD_STACK_SIZE
*/
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

/* Defined, this value represents how many ticks per seconds for a specific hardware platform.
   The default is 1000 indicating 1 tick per millisecond.  */

[#if UX_PERIODIC_RATE_value == "1000"]
/* #define UX_PERIODIC_RATE (TX_TIMER_TICKS_PER_SECOND)*/
[#else]
#define UX_PERIODIC_RATE                                  ${UX_PERIODIC_RATE_value}
[/#if]

/* Defined, this value is the maximum number of classes that can be loaded by USBX. This value
   represents the class container and not the number of instances of a class. For instance, if a
   particular implementation of USBX needs the hub class, the printer class, and the storage
   class, then the UX_MAX_CLASSES value can be set to 3 regardless of the number of devices
   that belong to these classes.  */

[#if UX_MAX_CLASS_DRIVER_value == "3"]
/* #define UX_MAX_CLASS_DRIVER  3 */
[#else]
#define UX_MAX_CLASS_DRIVER                                     ${UX_MAX_CLASS_DRIVER_value}
[/#if]

/* Defined, this value is the maximum number of classes in the device stack that can be loaded by
   USBX.  */
[#if UX_MAX_SLAVE_CLASS_DRIVER_value == "1"]
/* #define UX_MAX_SLAVE_CLASS_DRIVER    1 */
[#else]
#define UX_MAX_SLAVE_CLASS_DRIVER                         ${UX_MAX_SLAVE_CLASS_DRIVER_value}
[/#if]

/* Defined, this value is the maximum number of interfaces in the device framework.  */

[#if UX_MAX_SLAVE_INTERFACES_value == "16"]
/* #define UX_MAX_SLAVE_INTERFACES    16 */
[#else]
#define UX_MAX_SLAVE_INTERFACES                          ${UX_MAX_SLAVE_INTERFACES_value}
[/#if]

/* Defined, this value represents the number of different host controllers available in the system.
   For USB 1.1 support, this value will usually be 1. For USB 2.0 support, this value can be more
   than 1. This value represents the number of concurrent host controllers running at the same time.
   If for instance there are two instances of OHCI running, or one EHCI and one OHCI controller
   running, the UX_MAX_HCD should be set to 2.  */

[#if UX_MAX_HCD_value == "1"]
/* #define UX_MAX_HCD  1 */
[#else]
#define UX_MAX_HCD                                       ${UX_MAX_HCD_value}
[/#if]

/* Defined, this value represents the maximum number of devices that can be attached to the USB.
   Normally, the theoretical maximum number on a single USB is 127 devices. This value can be
   scaled down to conserve memory. Note that this value represents the total number of devices
   regardless of the number of USB buses in the system.  */

[#if UX_MAX_DEVICES_value == "127"]
/* #define UX_MAX_DEVICES  127 */
[#else]
#define UX_MAX_DEVICES                                    ${UX_MAX_DEVICES_value}
[/#if]

/* Defined, this value represents the current number of SCSI logical units represented in the device
   storage class driver.  */

[#if UX_MAX_SLAVE_LUN_value == "1"]
/* #define UX_MAX_SLAVE_LUN    1 */
[#else]
#define UX_MAX_SLAVE_LUN                                  ${UX_MAX_SLAVE_LUN_value}
[/#if]

/* Defined, this value represents the maximum number of SCSI logical units represented in the
   host storage class driver.  */

[#if UX_MAX_HOST_LUN_value == "1"]
/* #define UX_MAX_HOST_LUN  1 */
[#else]
#define UX_MAX_HOST_LUN                                   ${UX_MAX_HOST_LUN_value}
[/#if]

/* Defined, this value represents the maximum number of bytes received on a control endpoint in
   the device stack. The default is 256 bytes but can be reduced in memory constraint environments.  */

[#if UX_SLAVE_REQUEST_CONTROL_MAX_LENGTH_value == "256"]
/* #define UX_SLAVE_REQUEST_CONTROL_MAX_LENGTH        256 */
[#else]
#define UX_SLAVE_REQUEST_CONTROL_MAX_LENGTH                                   ${UX_SLAVE_REQUEST_CONTROL_MAX_LENGTH_value}
[/#if]

/* Defined, this value represents the maximum number of bytes that can be received or transmitted
   on any endpoint. This value cannot be less than the maximum packet size of any endpoint. The default
   is 4096 bytes but can be reduced in memory constraint environments. For cd-rom support in the storage
   class, this value cannot be less than 2048.  */

[#if UX_SLAVE_REQUEST_DATA_MAX_LENGTH_value == "4096"]
/* #define UX_SLAVE_REQUEST_DATA_MAX_LENGTH        4096 */
[#else]
#define UX_SLAVE_REQUEST_DATA_MAX_LENGTH                                   ${UX_SLAVE_REQUEST_DATA_MAX_LENGTH_value}
[/#if]

/* Defined, this value includes code to handle storage Multi-Media Commands (MMC). E.g., DVD-ROM. */

[#if UX_SLAVE_CLASS_STORAGE_INCLUDE_MMC_value == "0"]
/* #define UX_SLAVE_CLASS_STORAGE_INCLUDE_MMC */
[#else]
#define UX_SLAVE_CLASS_STORAGE_INCLUDE_MMC
[/#if]

/* Defined, this value represents the maximum number of bytes that a storage payload can send/receive.
   The default is 8K bytes but can be reduced in memory constraint environments.  */

[#if UX_HOST_CLASS_STORAGE_MEMORY_BUFFER_SIZE_value == "8192"]
/* #define UX_HOST_CLASS_STORAGE_MEMORY_BUFFER_SIZE        8192 */
[#else]
#define UX_HOST_CLASS_STORAGE_MEMORY_BUFFER_SIZE                                   ${UX_HOST_CLASS_STORAGE_MEMORY_BUFFER_SIZE_value}
[/#if]

/* Define USBX Mass Storage Thread Stack Size. The default is to use UX_THREAD_STACK_SIZE. */

[#if UX_HOST_CLASS_STORAGE_THREAD_STACK_SIZE_value == "2048"]
/* #define UX_HOST_CLASS_STORAGE_THREAD_STACK_SIZE             UX_THREAD_STACK_SIZE */
[#else]
#define UX_HOST_CLASS_STORAGE_THREAD_STACK_SIZE                                   ${UX_HOST_CLASS_STORAGE_THREAD_STACK_SIZE_value}
[/#if]

/* Defined, this value represents the maximum number of Ed, regular TDs and Isochronous TDs. These values
   depend on the type of host controller and can be reduced in memory constraint environments.  */

[#if UX_MAX_ED_value == "80"]
/* #define UX_MAX_ED                                           80 */
[#else]
#define UX_MAX_ED                                   ${UX_MAX_ED_value}
[/#if]

[#if UX_MAX_TD_value == "128"]
/* #define UX_MAX_TD                                           128 */
[#else]
#define UX_MAX_TD                                   ${UX_MAX_TD_value}
[/#if]

[#if UX_MAX_ISO_TD_value == "1"]
/* #define UX_MAX_ISO_TD                                           1 */
[#else]
#define UX_MAX_ISO_TD                                   ${UX_MAX_ISO_TD_value}
[/#if]

/* Defined, this value represents the maximum size of the HID decompressed buffer. This cannot be determined
   in advance so we allocate a big block, usually 4K but for simple HID devices like keyboard and mouse
   it can be reduced a lot. */

[#if UX_HOST_CLASS_HID_DECOMPRESSION_BUFFER_value == "4096"]
/* #define UX_HOST_CLASS_HID_DECOMPRESSION_BUFFER                                           4096 */
[#else]
#define UX_HOST_CLASS_HID_DECOMPRESSION_BUFFER                                   ${UX_HOST_CLASS_HID_DECOMPRESSION_BUFFER_value}
[/#if]

/* Defined, this value represents the maximum number of HID usages for a HID device.
   Default is 2048 but for simple HID devices like keyboard and mouse it can be reduced a lot. */

[#if UX_HOST_CLASS_HID_USAGES_value == "2048"]
/* #define UX_HOST_CLASS_HID_USAGES                                           2048 */
[#else]
#define UX_HOST_CLASS_HID_USAGES                                   ${UX_HOST_CLASS_HID_USAGES_value}
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
/* #define UX_HOST_CLASS_STORAGE_MAX_MEDIA                                           2 */
[#else]
#define UX_HOST_CLASS_STORAGE_MAX_MEDIA                                   ${UX_HOST_CLASS_STORAGE_MAX_MEDIA_value}
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
/* #define UX_DEVICE_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES           4 */
[#else]
#define UX_DEVICE_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES                        ${UX_DEVICE_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES_value}
[/#if]

/* Defined, this value represents the number of packets in the CDC_ECM host class.
   The default is 16.
*/
[#if UX_HOST_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES_value == "16"]
/* #define UX_HOST_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES                                           16 */
[#else]
#define UX_HOST_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES                                   ${UX_HOST_CLASS_CDC_ECM_NX_PKPOOL_ENTRIES_value}
[/#if]

/* Defined, this value represents the number of milliseconds to wait for packet
   allocation until invoking the application's error callback and retrying.
   The default is 1000 milliseconds.
*/
[#if UX_HOST_CLASS_CDC_ECM_PACKET_POOL_WAIT_value == "10"]
/* #define UX_HOST_CLASS_CDC_ECM_PACKET_POOL_WAIT                                           10 */
[#else]
#define UX_HOST_CLASS_CDC_ECM_PACKET_POOL_WAIT                                   ${UX_HOST_CLASS_CDC_ECM_PACKET_POOL_WAIT_value}
[/#if]

/* Defined, this value represents the number of milliseconds to wait for packet
   allocation until invoking the application's error callback and retrying.
*/
[#if UX_DEVICE_CLASS_CDC_ECM_PACKET_POOL_WAIT_value == "1000"]
/* #define UX_DEVICE_CLASS_CDC_ECM_PACKET_POOL_WAIT                                           1000 */
[#else]
#define UX_DEVICE_CLASS_CDC_ECM_PACKET_POOL_WAIT                                   ${UX_DEVICE_CLASS_CDC_ECM_PACKET_POOL_WAIT_value}
[/#if]

/* Defined, this value represents the the maximum length of HID reports on the
   device.
 */

[#if UX_DEVICE_CLASS_HID_EVENT_BUFFER_LENGTH_value == "64"]
/* #define UX_DEVICE_CLASS_HID_EVENT_BUFFER_LENGTH                                           64 */
[#else]
#define UX_DEVICE_CLASS_HID_EVENT_BUFFER_LENGTH                                   ${UX_DEVICE_CLASS_HID_EVENT_BUFFER_LENGTH_value}
[/#if]

/* Defined, this value represents the the maximum number of HID events/reports
   that can be queued at once.
 */

[#if UX_DEVICE_CLASS_HID_MAX_EVENTS_QUEUE_value == "8"]
/* #define UX_DEVICE_CLASS_HID_MAX_EVENTS_QUEUE                                           8 */
[#else]
#define UX_DEVICE_CLASS_HID_MAX_EVENTS_QUEUE                                   ${UX_DEVICE_CLASS_HID_MAX_EVENTS_QUEUE_value}
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

[#if UX_DEVICE_CLASS_DFU_STATUS_MODE_value == "0"]
#define UX_DEVICE_CLASS_DFU_STATUS_MODE                  0
[#else]
#define UX_DEVICE_CLASS_DFU_STATUS_MODE                  1
[/#if]


/* Defined, this value represents the default DFU status bwPollTimeout.
   The value is 3 bytes long (max 0xFFFFFFu).
   By default the bwPollTimeout is 1 (means 1ms).
 */

[#if UX_DEVICE_CLASS_DFU_STATUS_POLLTIMEOUT_value == "1"]
#define UX_DEVICE_CLASS_DFU_STATUS_POLLTIMEOUT                                   (1)
[#else]
#define UX_DEVICE_CLASS_DFU_STATUS_POLLTIMEOUT             ${UX_DEVICE_CLASS_DFU_STATUS_POLLTIMEOUT_value}
[/#if]

/* Defined, this macro will enable custom request process callback.  */

[#if UX_DEVICE_CLASS_DFU_CUSTOM_REQUEST_ENABLE_value == "1"]
#define UX_DEVICE_CLASS_DFU_CUSTOM_REQUEST_ENABLE
[#else]
/* #define UX_DEVICE_CLASS_DFU_CUSTOM_REQUEST_ENABLE  */
[/#if]

/* Defined, this value will only enable the host side of usbx.  */

[#if UX_HOST_SIDE_ONLY_value == "1" && UX_HOST_ENABLED_Value == "true"]
#define UX_HOST_SIDE_ONLY
[#else]
/* #define UX_HOST_SIDE_ONLY */
[/#if]

[#if UX_DEVICE_SIDE_ONLY_value == "1" && UX_DEVICE_ENABLED_Value == "true"]
#define UX_DEVICE_SIDE_ONLY
[#else]
/* #define UX_DEVICE_SIDE_ONLY */
[/#if]

/* Defined, this value will include the OTG polling thread. OTG can only be active if both host/device are present.
*/

[#if UX_OTG_SUPPORT_value == "0"]

#ifndef UX_HOST_SIDE_ONLY
#ifndef UX_DEVICE_SIDE_ONLY

/* #define UX_OTG_SUPPORT */

#endif
#endif
[#else]
#ifndef UX_HOST_SIDE_ONLY
#ifndef UX_DEVICE_SIDE_ONLY

#define UX_OTG_SUPPORT

#endif
#endif
[/#if]

/* Defined, this value represents the maximum size of single tansfers for the SCSI data phase.
*/

[#if UX_HOST_CLASS_STORAGE_MAX_TRANSFER_SIZE_value == "1024"]
/* #define UX_HOST_CLASS_STORAGE_MAX_TRANSFER_SIZE             (1024 * 1) */
[#else]
#define UX_HOST_CLASS_STORAGE_MAX_TRANSFER_SIZE             ${UX_HOST_CLASS_STORAGE_MAX_TRANSFER_SIZE_value}
[/#if]

/* Defined, this value represents the size of the log pool.
*/
[#if UX_DEBUG_LOG_SIZE_value == "16384"]
/* #define UX_DEBUG_LOG_SIZE                                   (1024 * 16) */
[#else]
#define UX_DEBUG_LOG_SIZE             ${UX_DEBUG_LOG_SIZE_value}
[/#if]

/* This is the ThreadX priority value for the USBX enumeration threads that monitors the bus topology */

[#if UX_THREAD_PRIORITY_ENUM_value == "20"]
/* #define UX_THREAD_PRIORITY_ENUM             20 */
[#else]
#define UX_THREAD_PRIORITY_ENUM                ${UX_THREAD_PRIORITY_ENUM_value}
[/#if]

/* This is the ThreadX priority value for the standard USBX threads */

[#if UX_THREAD_PRIORITY_CLASS_value == "20"]
/* #define UX_THREAD_PRIORITY_CLASS             20 */
[#else]
#define UX_THREAD_PRIORITY_CLASS                ${UX_THREAD_PRIORITY_CLASS_value}
[/#if]

/* This is the ThreadX priority value for the USBX HID keyboard class. */

[#if UX_THREAD_PRIORITY_KEYBOARD_value == "20"]
/* #define UX_THREAD_PRIORITY_KEYBOARD             20 */
[#else]
#define UX_THREAD_PRIORITY_KEYBOARD                ${UX_THREAD_PRIORITY_KEYBOARD_value}
[/#if]

/* This is the ThreadX priority value for the host controller thread. */

[#if UX_THREAD_PRIORITY_HCD_value == "2"]
/* #define UX_THREAD_PRIORITY_HCD             2 */
[#else]
#define UX_THREAD_PRIORITY_HCD                ${UX_THREAD_PRIORITY_HCD_value}
[/#if]

/* This value actually defines the time slice that will be used for threads. For example, if defined to 0, the ThreadX target port does not use time slices. */

[#if UX_NO_TIME_SLICE_value == "0"]
/* #define UX_NO_TIME_SLICE             0 */
[#else]
#define UX_NO_TIME_SLICE                ${UX_NO_TIME_SLICE_value}
[/#if]

/* it define USBX device max number of endpoints (1~n). */

[#if UX_MAX_DEVICE_ENDPOINTS_value == "6"]
/* #define UX_MAX_DEVICE_ENDPOINTS             6 */
[#else]
#define UX_MAX_DEVICE_ENDPOINTS                ${UX_MAX_DEVICE_ENDPOINTS_value}
[/#if]

/* it define USBX device max number of interfacess (1~n). */

[#if UX_MAX_DEVICE_INTERFACES_value == "6"]
/* #define UX_MAX_DEVICE_INTERFACES             6 */
[#else]
#define UX_MAX_DEVICE_INTERFACES                ${UX_MAX_DEVICE_INTERFACES_value}
[/#if]

/* Define USBX max root hub port (1 ~ n).  */

[#if UX_MAX_ROOTHUB_PORT_value == "4"]
/* #define UX_MAX_ROOTHUB_PORT             4 */
[#else]
#define UX_MAX_ROOTHUB_PORT                ${UX_MAX_ROOTHUB_PORT_value}
[/#if]

/* Define USBX max TT. */

[#if UX_MAX_TT_value == "8"]
/* #define UX_MAX_TT             8 */
[#else]
#define UX_MAX_TT                ${UX_MAX_TT_value}
[/#if]

/* Determine if tracing is enabled.  */

[#if UX_TRACE_INSERT_MACROS_value == "1"]
#define UX_TRACE_INSERT_MACROS
[#else]
/*#define UX_TRACE_INSERT_MACROS*/
[/#if]
#endif

