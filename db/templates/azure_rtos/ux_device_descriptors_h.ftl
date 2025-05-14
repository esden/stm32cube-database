[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ux_device_descriptors.h
  * @author  MCD Application Team
  * @brief   USBX Device descriptor header file
  ******************************************************************************
  [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __UX_DEVICE_DESCRIPTORS_H__
#define __UX_DEVICE_DESCRIPTORS_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "ux_api.h"
#include "ux_stm32_config.h"
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as variable]
    [#assign value = variable.value]
    [#assign name = variable.name]
[#if name?contains("UX_DEVICE_HID_CORE") && value == "1"]
#include "ux_device_class_hid.h"
[/#if]
[#if name?contains("UX_DEVICE_RNDIS") && value == "1"]
#include "ux_device_class_rndis.h"
[/#if]
[#if name?contains("UX_DEVICE_STORAGE") && value == "1"]
#include "ux_device_class_storage.h"
[/#if]
[#if name?contains("UX_DEVICE_CDC_ACM") && value == "1"]
#include "ux_device_class_cdc_acm.h"
[/#if]
[#if name?contains("UX_DEVICE_CDC_ECM") && value == "1"]
#include "ux_device_class_cdc_ecm.h"
[/#if]
[#if name?contains("UX_DEVICE_DFU") && value == "1"]
#include "ux_device_class_dfu.h"
[/#if]
[#if name?contains("UX_DEVICE_PIMA") && value == "1"]
#include "ux_device_class_pima.h"
[/#if]
[#if name?contains("UX_DEVICE_VIDEO") && value == "1"]
#include "ux_device_class_video.h"
[/#if]
[#if name?contains("UX_DEVICE_CCID") && value == "1"]
#include "ux_device_class_ccid.h"
[/#if]
[#if name?contains("UX_DEVICE_PRINTER") && value == "1"]
#include "ux_device_class_printer.h"
[/#if]
[/#list]
[/#if]
[/#list]

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private defines -----------------------------------------------------------*/
#define USBD_MAX_NUM_CONFIGURATION                     1U
#define USBD_MAX_SUPPORTED_CLASS                       3U
#define USBD_MAX_CLASS_ENDPOINTS                       9U
[#if FamilyName?lower_case?starts_with("stm32c0")]
#define USBD_MAX_CLASS_INTERFACES                      12U
[#else]
#define USBD_MAX_CLASS_INTERFACES                      11U
[/#if]

[#assign usbd_msc_ep_out_address = 0]
[#assign usbd_msc_ep_in_address = 0]
[#assign usbd_msc_ep_out_fs_mps = 0]
[#assign usbd_msc_ep_out_hs_mps = 0]
[#assign usbd_msc_ep_in_fs_mps = 0]
[#assign usbd_msc_ep_in_hs_mps = 0]

[#assign usbd_hid_ep_in_address = 0]
[#assign usbd_hid_ep_in_fs_mps = 0]
[#assign usbd_hid_ep_in_hs_mps = 0]
[#assign usbd_hid_ep_in_fs_bint = 0]
[#assign usbd_hid_ep_in_hs_bint = 0]

[#assign usbd_cdc_ep_out_address = 0]
[#assign usbd_cdc_ep_in_address = 0]
[#assign usbd_cdc_ep_in_cmd_address = 0]
[#assign usbd_cdc_ep_in_cmd_fs_mps = 0]
[#assign usbd_cdc_ep_in_cmd_hs_mps = 0]
[#assign usbd_cdc_ep_in_fs_mps = 0]
[#assign usbd_cdc_ep_in_hs_mps = 0]
[#assign usbd_cdc_ep_out_fs_mps = 0]
[#assign usbd_cdc_ep_out_hs_mps = 0]
[#assign usbd_cdc_ep_in_fs_bint = 0]
[#assign usbd_cdc_ep_in_hs_bint = 0]

[#assign usbd_cdcecm_nx_pkpool_entries = 0]
[#assign usbd_cdcecm_packet_pool_wait = 0]
[#assign usbd_cdcecm_ep_in_cmd_address = 0]
[#assign usbd_cdcecm_ep_in_cmd_fs_mps = 0]
[#assign usbd_cdcecm_ep_in_cmd_hs_mps = 0]
[#assign usbd_cdcecm_ep_in_cmd_fs_bint = 0]
[#assign usbd_cdcecm_ep_in_cmd_hs_bint = 0]
[#assign usbd_cdcecm_ep_in_address = 0]
[#assign usbd_cdcecm_ep_in_fs_mps = 0]
[#assign usbd_cdcecm_ep_in_hs_mps = 0]
[#assign usbd_cdcecm_ep_out_address = 0]
[#assign usbd_cdcecm_ep_out_fs_mps = 0]
[#assign usbd_cdcecm_ep_out_hs_mps = 0]
[#assign usbd_cdcecm_local_mac_address = 0]
[#assign usbd_cdcecm_remote_mac_address = 0]
[#assign usbd_rndis_remote_mac_address = 0]

[#assign usbd_dfu_bm_attributes = 0]
[#assign usbd_dfu_detachtimeout = 0]
[#assign usbd_dfu_xfer_size = 0]
[#assign usbd_dfu_string_desc = 0]

[#assign usbd_video_ep_in_address = 0]
[#assign usbd_video_ep_in_fs_mps = 0]
[#assign usbd_video_ep_in_hs_mps = 0]
[#assign usbd_video_width = 0]
[#assign usbd_video_height = 0]
[#assign usbd_video_cam_fps_fs = 0]
[#assign usbd_video_cam_fps_hs = 0]
[#assign vs_format_subtype = 0]
[#assign usbd_uvc_bits_per_pixel = 0]
[#assign usbd_uvc_charac = 0]
[#assign usbd_uvc_matrix_coeff = 0]
[#assign usbd_uvc_guid = 0]
[#assign usbd_vid_value = 0]
[#assign usbd_pid_value = 0]
[#assign usbd_langid = 0]
[#assign UX_class_nb = 0]

[#assign usbd_manufacturer_string = 0]
[#assign usbd_product_string = 0]
[#assign serial_number = 0]

[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]

    [#assign value = definition.value]
    [#assign name = definition.name]

    [#if name == "USBD_MSC_EPOUT_ADDR"]
      [#assign usbd_msc_ep_out_address = value]
    [/#if]
    [#if name == "USBD_MSC_EPIN_ADDR"]
      [#assign usbd_msc_ep_in_address = value]
    [/#if]
    [#if name == "USBD_MSC_EPIN_FS_MPS"]
      [#assign usbd_msc_ep_in_fs_mps = value]
    [/#if]
    [#if name == "USBD_MSC_EPIN_HS_MPS"]
      [#assign usbd_msc_ep_in_hs_mps = value]
    [/#if]
    [#if name == "USBD_MSC_EPOUT_FS_MPS"]
      [#assign usbd_msc_ep_out_fs_mps = value]
    [/#if]
    [#if name == "USBD_MSC_EPOUT_HS_MPS"]
      [#assign usbd_msc_ep_out_hs_mps = value]
    [/#if]
    [#if name == "USBD_CDCACM_EPOUT_ADDR"]
      [#assign usbd_cdc_ep_out_address = value]
    [/#if]
    [#if name == "USBD_CDCACM_EPIN_ADDR"]
      [#assign usbd_cdc_ep_in_address = value]
    [/#if]
    [#if name == "USBD_CDCACM_EPINCMD_ADDR"]
      [#assign usbd_cdc_ep_in_cmd_address = value]
    [/#if]
    [#if name == "USBD_CDCACM_EPINCMD_FS_MPS"]
      [#assign usbd_cdc_ep_in_cmd_fs_mps = value]
    [/#if]
    [#if name == "USBD_CDCACM_EPINCMD_HS_MPS"]
      [#assign usbd_cdc_ep_in_cmd_hs_mps = value]
    [/#if]
    [#if name == "USBD_CDCACM_EPIN_FS_MPS"]
      [#assign  usbd_cdc_ep_in_fs_mps = value]
    [/#if]
    [#if name == "USBD_CDCACM_EPOUT_FS_MPS"]
      [#assign  usbd_cdc_ep_out_fs_mps = value]
    [/#if]
    [#if name == "USBD_CDCACM_EPIN_HS_MPS"]
      [#assign usbd_cdc_ep_in_hs_mps  = value]
    [/#if]
    [#if name == "USBD_CDCACM_EPOUT_HS_MPS"]
      [#assign  usbd_cdc_ep_out_hs_mps = value]
    [/#if]
    [#if name == "USBD_CDCACM_EPINCMD_FS_BINTERVAL"]
      [#assign usbd_cdc_ep_in_fs_bint = value]
    [/#if]
    [#if name == "USBD_CDCACM_EPINCMD_HS_BINTERVAL"]
      [#assign usbd_cdc_ep_in_hs_bint = value]
    [/#if]
    [#if name == "USBD_DEVICE_FRAMEWORK_BUILDER_ENABLED"]
      [#assign usbd_builder_enabled = value]
    [/#if]
    [#if name == "USBD_MAX_POWER"]
      [#assign usbd_max_power = value]
    [/#if]
    [#if name == "USBD_COMPOSITE_USE_IAD"]
      [#assign usbd_composite_aid = value]
    [/#if]
    [#if name == "USBD_VID"]
      [#assign usbd_vid_value = value]
    [/#if]
    [#if name == "USBD_PID"]
      [#assign usbd_pid_value = value]
    [/#if]
    [#if name == "USBD_LANGID_STRING"]
      [#assign usbd_langid = value]
    [/#if]
    [#if name == "USBD_MANUFACTURER_STRING"]
      [#assign usbd_manufacturer_string = value]
    [/#if]
    [#if name == "USBD_PRODUCT_STRING"]
      [#assign usbd_product_string = value]
    [/#if]
    [#if name == "USBD_SERIAL_NUMBER"]
      [#assign serial_number = value]
    [/#if]
    [#if name == "USBD_CDC_ECM_NX_PKPOOL_ENTRIES"]
      [#assign usbd_cdcecm_nx_pkpool_entries = value]
    [/#if]
    [#if name == "USBD_CDC_ECM_PACKET_POOL_WAIT"]
      [#assign usbd_cdcecm_packet_pool_wait = value]
    [/#if]
    [#if name == "USBD_CDCECM_EPINCMD_ADDR"]
      [#assign usbd_cdcecm_ep_in_cmd_address = value]
    [/#if]
    [#if name == "USBD_CDCECM_EPINCMD_FS_MPS"]
      [#assign usbd_cdcecm_ep_in_cmd_fs_mps = value]
    [/#if]
    [#if name == "USBD_CDCECM_EPINCMD_HS_MPS"]
      [#assign usbd_cdcecm_ep_in_cmd_hs_mps = value]
    [/#if]
    [#if name == "USBD_CDCECM_EPINCMD_FS_BINTERVAL"]
      [#assign usbd_cdcecm_ep_in_cmd_fs_bint = value]
    [/#if]
    [#if name == "USBD_CDCECM_EPINCMD_HS_BINTERVAL"]
      [#assign usbd_cdcecm_ep_in_cmd_hs_bint = value]
    [/#if]
    [#if name == "USBD_CDCECM_EPIN_ADDR"]
      [#assign usbd_cdcecm_ep_in_address = value]
    [/#if]
    [#if name == "USBD_CDCECM_EPIN_FS_MPS"]
      [#assign usbd_cdcecm_ep_in_fs_mps = value]
    [/#if]
    [#if name == "USBD_CDCECM_EPIN_HS_MPS"]
      [#assign usbd_cdcecm_ep_in_hs_mps = value]
    [/#if]
    [#if name == "USBD_CDCECM_EPOUT_ADDR"]
      [#assign usbd_cdcecm_ep_out_address = value]
    [/#if]
    [#if name == "USBD_CDCECM_EPOUT_FS_MPS"]
      [#assign usbd_cdcecm_ep_out_fs_mps = value]
    [/#if]
    [#if name == "USBD_CDCECM_EPOUT_HS_MPS"]
      [#assign usbd_cdcecm_ep_out_hs_mps = value]
    [/#if]
    [#if name == "USBD_CDCECM_LOCAL_MAC_ADDR"]
      [#assign usbd_cdcecm_local_mac_address = value]
    [/#if]
    [#if name == "USBD_CDCECM_REMOTE_MAC_ADDR"]
      [#assign usbd_cdcecm_remote_mac_address = value]
    [/#if]
    [#if name == "USBD_DFU_BM_ATTRIBUTES"]
      [#assign usbd_dfu_bm_attributes = value]
    [/#if]
    [#if name == "USBD_DFU_DetachTimeout"]
      [#assign usbd_dfu_detachtimeout = value]
    [/#if]
    [#if name == "USBD_DFU_XFER_SIZE"]
      [#assign usbd_dfu_xfer_size = value]
    [/#if]
    [#if name == "USBD_DFU_MEDIA"]
      [#assign usbd_dfu_string_desc = value]
    [/#if]
    [#if name == "UX_DEVICE_BIDIRECTIONAL_ENDPOINT_SUPPORT"]
      [#assign ux_device_bidirectional_endpoint_support_val = value]
    [/#if]
    [#if name == "USBD_HID_MOUSE_EPIN_ADDR"]
      [#assign usbd_hid_mouse_ep_in_address = value]
    [/#if]
    [#if name == "USBD_HID_MOUSE_EPIN_FS_MPS"]
      [#assign usbd_hid_mouse_ep_in_fs_mps = value]
    [/#if]
    [#if name == "USBD_HID_MOUSE_EPIN_HS_MPS"]
      [#assign usbd_hid_mouse_ep_in_hs_mps = value]
    [/#if]
    [#if name == "USBD_HID_MOUSE_EPIN_FS_BINTERVAL"]
      [#assign usbd_hid_mouse_ep_in_fs_bint = value]
    [/#if]
    [#if name == "USBD_HID_MOUSE_EPIN_HS_BINTERVAL"]
      [#assign usbd_hid_mouse_ep_in_hs_bint = value]
    [/#if]
    [#if name == "USBD_HID_KEYBOARD_EPIN_ADDR"]
      [#assign usbd_hid_key_ep_in_address = value]
    [/#if]
    [#if name == "USBD_HID_KEYBOARD_EPIN_FS_MPS"]
      [#assign usbd_hid_key_ep_in_fs_mps = value]
    [/#if]
    [#if name == "USBD_HID_KEYBOARD_EPIN_HS_MPS"]
      [#assign usbd_hid_key_ep_in_hs_mps = value]
    [/#if]
    [#if name == "USBD_HID_KEYBOARD_EPIN_FS_BINTERVAL"]
      [#assign usbd_hid_key_ep_in_fs_bint = value]
    [/#if]
    [#if name == "USBD_HID_KEYBOARD_EPIN_HS_BINTERVAL"]
      [#assign usbd_hid_key_ep_in_hs_bint = value]
    [/#if]
    [#if name == "UX_DEVICE_CLASS_HID_INTERRUPT_OUT_SUPPORT"]
      [#assign UX_DEVICE_CLASS_HID_INTERRUPT_OUT_SUPPORT_value = value]
    [/#if]
    [#if name == "USBD_HID_CUSTOM_EPIN_ADDR"]
      [#assign usbd_hid_custom_ep_in_address = value]
    [/#if]
    [#if name == "USBD_HID_CUSTOM_EPOUT_ADDR"]
      [#assign usbd_hid_custom_ep_out_address = value]
    [/#if]
    [#if name == "USBD_HID_CUSTOM_EPIN_FS_MPS"]
      [#assign usbd_hid_custom_ep_in_fs_mps = value]
    [/#if]
    [#if name == "USBD_HID_CUSTOM_EPIN_HS_MPS"]
      [#assign usbd_hid_custom_ep_in_hs_mps = value]
    [/#if]
    [#if name == "USBD_HID_CUSTOM_EPIN_FS_BINTERVAL"]
      [#assign usbd_hid_custom_ep_in_fs_bint = value]
    [/#if]
    [#if name == "USBD_HID_CUSTOM_EPIN_HS_BINTERVAL"]
      [#assign usbd_hid_custom_ep_in_hs_bint = value]
    [/#if]
    [#if name == "USBD_HID_CUSTOM_EPOUT_FS_MPS"]
      [#assign usbd_hid_custom_ep_out_fs_mps = value]
    [/#if]
    [#if name == "USBD_HID_CUSTOM_EPOUT_HS_MPS"]
      [#assign usbd_hid_custom_ep_out_hs_mps = value]
    [/#if]
    [#if name == "USBD_HID_CUSTOM_EPOUT_FS_BINTERVAL"]
      [#assign usbd_hid_custom_ep_out_fs_bint = value]
    [/#if]
    [#if name == "USBD_HID_CUSTOM_EPOUT_HS_BINTERVAL"]
      [#assign usbd_hid_custom_ep_out_hs_bint = value]
    [/#if]

    [#if name == "USBD_VIDEO_EPIN_ADDR"]
      [#assign usbd_video_ep_in_address = value]
    [/#if]

     [#if name == "USBD_VIDEO_EPIN_FS_MPS"]
      [#assign usbd_video_ep_in_fs_mps = value]
    [/#if]

    [#if name == "USBD_VIDEO_EPIN_HS_MPS"]
      [#assign usbd_video_ep_in_hs_mps = value]
    [/#if]

    [#if name == "USBD_VIDEO_EPIN_FS_BINTERVAL"]
      [#assign usbd_video_ep_in_fs_binterval = value]
    [/#if]

    [#if name == "USBD_VIDEO_EPIN_HS_BINTERVAL"]
      [#assign usbd_video_ep_in_hs_binterval = value]
    [/#if]

    [#if name == "UVC_FRAME_WIDTH"]
      [#assign usbd_video_width = value]
    [/#if]

    [#if name == "UVC_FRAME_HEIGHT"]
      [#assign usbd_video_height = value]
    [/#if]

    [#if name == "UVC_CAM_FPS_FS"]
      [#assign usbd_video_cam_fps_fs = value]
    [/#if]

    [#if name == "UVC_CAM_FPS_HS"]
      [#assign usbd_video_cam_fps_hs = value]
    [/#if]

    [#if name == "UVC_VERSION"]
      [#assign uvc_version = value]
    [/#if]
    [#if name == "VS_FORMAT_SUBTYPE"]
      [#assign vs_format_subtype = value]
    [/#if]
    [#if name == "UVC_BITS_PER_PIXEL"]
      [#assign usbd_uvc_bits_per_pixel = value]
    [/#if]
    [#if name == "UVC_COLOR_PRIMARIE"]
      [#assign usbd_uvc_color = value]
    [/#if]
    [#if name == "UVC_TFR_CHARACTERISTICS"]
      [#assign usbd_uvc_charac = value]
    [/#if]
    [#if name == "UVC_MATRIX_COEFFICIENTS"]
      [#assign usbd_uvc_matrix_coeff = value]
    [/#if]
    [#if name == "UVC_UNCOMPRESSED_GUID"]
      [#assign usbd_uvc_guid = value]
    [/#if]
    [#if name == "USBD_PIMA_EP_IN_CMD_ADDR"]
      [#assign usbd_pima_ep_in_cmd_address = value]
    [/#if]
    [#if name == "USBD_PIMA_EP_IN_CMD_FS_MPS"]
      [#assign usbd_pima_ep_in_cmd_fs_mps = value]
    [/#if]
    [#if name == "USBD_PIMA_EP_IN_CMD_HS_MPS"]
      [#assign usbd_pima_ep_in_cmd_hs_mps = value]
    [/#if]
    [#if name == "USBD_PIMA_EP_OUT_ADDR"]
      [#assign usbd_pima_ep_out_address = value]
    [/#if]
    [#if name == "USBD_PIMA_EP_IN_ADDR"]
      [#assign usbd_pima_ep_in_address = value]
    [/#if]
    [#if name == "USBD_PIMA_EP_IN_FS_MPS"]
      [#assign usbd_pima_ep_in_fs_mps = value]
    [/#if]
    [#if name == "USBD_PIMA_EP_IN_HS_MPS"]
      [#assign usbd_pima_ep_in_hs_mps = value]
    [/#if]
    [#if name == "USBD_PIMA_EP_OUT_FS_MPS"]
      [#assign usbd_pima_ep_out_fs_mps = value]
    [/#if]
    [#if name == "USBD_PIMA_EP_OUT_HS_MPS"]
      [#assign usbd_pima_ep_out_hs_mps = value]
    [/#if]
    [#if name == "USBD_PIMA_EP_IN_CMD_FS_BINTERVAL"]
      [#assign usbd_pima_ep_in_fs_bint = value]
    [/#if]
    [#if name == "USBD_PIMA_EP_IN_CMD_HS_BINTERVAL"]
      [#assign usbd_pima_ep_in_hs_bint = value]
    [/#if]
    [#if name == "UX_PIMA_WITH_MTP_SUPPORT"]
      [#assign UX_PIMA_WITH_MTP_SUPPORT_value = value]
    [/#if]
    [#if name == "USBD_CCID_EPOUT_ADDR"]
      [#assign usbd_ccid_ep_out_address = value]
    [/#if]
    [#if name == "USBD_CCID_EPIN_ADDR"]
      [#assign usbd_ccid_ep_in_address = value]
    [/#if]
    [#if name == "USBD_CCID_EPINCMD_ADDR"]
      [#assign usbd_ccid_ep_in_cmd_address = value]
    [/#if]
    [#if name == "USBD_CCID_EPINCMD_FS_MPS"]
      [#assign usbd_ccid_ep_in_cmd_fs_mps = value]
    [/#if]
    [#if name == "USBD_CCID_EPINCMD_HS_MPS"]
      [#assign usbd_ccid_ep_in_cmd_hs_mps = value]
    [/#if]
    [#if name == "USBD_CCID_EPIN_FS_MPS"]
      [#assign  usbd_ccid_ep_in_fs_mps = value]
    [/#if]
    [#if name == "USBD_CCID_EPOUT_FS_MPS"]
      [#assign  usbd_ccid_ep_out_fs_mps = value]
    [/#if]
    [#if name == "USBD_CCID_EPIN_HS_MPS"]
      [#assign usbd_ccid_ep_in_hs_mps  = value]
    [/#if]
    [#if name == "USBD_CCID_EPOUT_HS_MPS"]
      [#assign  usbd_ccid_ep_out_hs_mps = value]
    [/#if]
    [#if name == "USBD_CCID_EPINCMD_FS_BINTERVAL"]
      [#assign usbd_ccid_ep_in_fs_bint = value]
    [/#if]
    [#if name == "USBD_CCID_EPINCMD_HS_BINTERVAL"]
      [#assign usbd_ccid_ep_in_hs_bint = value]
    [/#if]
    [#if name == "USBD_CCID_MAX_SLOT_INDEX"]
      [#assign usbd_ccid_max_slot_index = value]
    [/#if]
    [#if name == "USBD_CCID_MAX_BUSY_SLOTS"]
      [#assign usbd_ccid_max_busy_slots = value]
    [/#if]
    [#if name == "USBD_CCID_N_CLOCKS"]
      [#assign usbd_ccid_n_clocks = value]
    [/#if]
    [#if name == "USBD_CCID_N_DATA_RATES"]
      [#assign usbd_ccid_n_data_rates = value]
    [/#if]
    [#if name == "USBD_CCID_MAX_BLOCK_SIZE_HEADER"]
      [#assign usbd_ccid_max_block_size_header = value]
    [/#if]
    [#if name == "USBD_CCID_DEFAULT_DATA_RATE"]
      [#assign usbd_ccid_default_data_rate = value]
    [/#if]
    [#if name == "USBD_CCID_MAX_DATA_RATE"]
      [#assign usbd_ccid_max_data_rate = value]
    [/#if]
    [#if name == "USBD_CCID_DEFAULT_CLOCK_FREQ"]
      [#assign usbd_ccid_default_clock_freq = value]
    [/#if]
    [#if name == "USBD_CCID_MAX_CLOCK_FREQ"]
      [#assign usbd_ccid_max_clock_freq = value]
    [/#if]
    [#if name == "USBD_CCID_PROTOCOL"]
      [#assign usbd_ccid_protocol = value]
    [/#if]
    [#if name == "USBD_CCID_VOLTAGE_SUPPLY"]
      [#assign usbd_ccid_voltage_supply = value]
    [/#if]
    [#if name == "USBD_RNDIS_LOCAL_MAC_ADDR"]
      [#assign usbd_rndis_local_mac_address = value]
    [/#if]
    [#if name == "USBD_RNDIS_REMOTE_MAC_ADDR"]
      [#assign usbd_rndis_remote_mac_address = value]
    [/#if]
    [#if name == "USBD_RNDIS_EPINCMD_ADDR"]
      [#assign usbd_rndis_ep_in_cmd_address = value]
    [/#if]
    [#if name == "USBD_RNDIS_EPINCMD_FS_MPS"]
      [#assign usbd_rndis_ep_in_cmd_fs_mps = value]
    [/#if]
    [#if name == "USBD_RNDIS_EPINCMD_HS_MPS"]
      [#assign usbd_rndis_ep_in_cmd_hs_mps = value]
    [/#if]
    [#if name == "USBD_RNDIS_EPINCMD_FS_BINTERVAL"]
      [#assign usbd_rndis_ep_in_cmd_fs_bint = value]
    [/#if]
    [#if name == "USBD_RNDIS_EPINCMD_HS_BINTERVAL"]
      [#assign usbd_rndis_ep_in_cmd_hs_bint = value]
    [/#if]
    [#if name == "USBD_RNDIS_EPIN_ADDR"]
      [#assign usbd_rndis_ep_in_address = value]
    [/#if]
    [#if name == "USBD_RNDIS_EPIN_FS_MPS"]
      [#assign usbd_rndis_ep_in_fs_mps = value]
    [/#if]
    [#if name == "USBD_RNDIS_EPIN_HS_MPS"]
      [#assign usbd_rndis_ep_in_hs_mps = value]
    [/#if]
    [#if name == "USBD_RNDIS_EPOUT_ADDR"]
      [#assign usbd_rndis_ep_out_address = value]
    [/#if]
    [#if name == "USBD_RNDIS_EPOUT_FS_MPS"]
      [#assign usbd_rndis_ep_out_fs_mps = value]
    [/#if]
    [#if name == "USBD_RNDIS_EPOUT_HS_MPS"]
      [#assign usbd_rndis_ep_out_hs_mps = value]
    [/#if]
    [#if name == "USBD_PRNT_EPOUT_ADDR"]
      [#assign usbd_prnt_epout_addr = value]
    [/#if]
    [#if name == "USBD_PRNT_EPIN_ADDR"]
      [#assign usbd_prnt_epin_addr = value]
    [/#if]
    [#if name == "USBD_PRNT_EPOUT_FS_MPS"]
      [#assign usbd_prnt_epout_fs_mps = value]
    [/#if]
    [#if name == "USBD_PRNT_EPOUT_HS_MPS"]
      [#assign usbd_prnt_epout_hs_mps = value]
    [/#if]
    [#if name == "USBD_PRNT_EPIN_FS_MPS"]
      [#assign usbd_prnt_epin_fs_mps = value]
    [/#if]
    [#if name == "USBD_PRNT_EPIN_HS_MPS"]
      [#assign usbd_prnt_epin_hs_mps = value]
    [/#if]
    [#if name == "USBD_PRNT_IF_PROTOCOL"]
      [#assign usbd_prnt_if_protocol = value]
    [/#if]
    [#if name == "USBD_FRAMEWORK_MAX_DESC_SZ"]
      [#assign USBD_FRAMEWORK_MAX_DESC_SZ_value = value]
    [/#if]
  [/#list]
[/#if]
[/#list]
[/#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as variable]
    [#assign value = variable.value]
    [#assign name = variable.name]
  [#if name?contains("UX_DEVICE_STORAGE") && value == "1"]
#define USBD_MSC_CLASS_ACTIVATED                       1U
    [#assign UX_class_nb = UX_class_nb+1]
  [/#if]
  [#if name?contains("UX_DEVICE_HID_CORE") && value == "1"]
#define USBD_HID_CLASS_ACTIVATED                       1U
  [/#if]
  [#if name?contains("UX_DEVICE_CDC_ACM") && value == "1"]
#define USBD_CDC_ACM_CLASS_ACTIVATED                   1U
    [#assign UX_class_nb = UX_class_nb+1]
  [/#if]
  [#if name?contains("UX_DEVICE_CDC_ECM") && value == "1"]
#define USBD_CDC_ECM_CLASS_ACTIVATED                   1U
    [#assign UX_class_nb = UX_class_nb+1]
  [/#if]
  [#if name?contains("UX_DEVICE_RNDIS") && value == "1"]
#define USBD_RNDIS_CLASS_ACTIVATED                     1U
    [#assign UX_class_nb = UX_class_nb+1]
  [/#if]
  [#if name?contains("UX_DEVICE_DFU") && value == "1"]
#define USBD_DFU_CLASS_ACTIVATED                       1U
    [#assign UX_class_nb = UX_class_nb+1]
  [/#if]
  [#if name?contains("UX_DEVICE_PIMA") && value == "1"]
    [#if UX_PIMA_WITH_MTP_SUPPORT_value == "1"]
#define USBD_PIMA_MTP_CLASS_ACTIVATED                  1U
    [#assign UX_class_nb = UX_class_nb+1]
    [/#if]
  [/#if]
  [#if name?contains("UX_DEVICE_PRINTER") && value == "1"]
#define USBD_PRINTER_CLASS_ACTIVATED                   1U
    [#assign UX_class_nb = UX_class_nb+1]
  [/#if]
  [#if name?contains("UX_DEVICE_VIDEO") && value == "1"]
#define USBD_VIDEO_CLASS_ACTIVATED                     1U
    [#assign UX_class_nb = UX_class_nb+1]
  [/#if]
  [#if name?contains("UX_DEVICE_CCID") && value == "1"]
#define USBD_CCID_CLASS_ACTIVATED                      1U
    [#assign UX_class_nb = UX_class_nb+1]
  [/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as variable]
    [#assign value = variable.value]
    [#assign name = variable.name]
[#if name?contains("UX_DEVICE_HID_MOUSE") && value == "1"]
#define USBD_HID_MOUSE_ACTIVATED                       1U
    [#assign UX_class_nb = UX_class_nb+1]
[/#if]
[#if name?contains("UX_DEVICE_HID_KEYBOARD") && value == "1"]
#define USBD_HID_KEYBOARD_ACTIVATED                    1U
    [#assign UX_class_nb = UX_class_nb+1]
[/#if]
[#if name?contains("UX_DEVICE_HID_CUSTOM") && value == "1"]
#define USBD_HID_CUSTOM_ACTIVATED                      1U
    [#assign UX_class_nb = UX_class_nb+1]
[/#if][/#list]
[/#if]
[/#list]
[#if (ux_device_bidirectional_endpoint_support_val == "0") && (UX_class_nb > 3)]
#error Bidirectional endpoint flag disabled, max selected device classes should not be more then 3.
[/#if]

[#if (ux_device_bidirectional_endpoint_support_val == "1") && (UX_class_nb > 5)]
#error Bidirectional endpoint flag enabled, max selected device classes should not be more then 5.
[/#if]

#define USBD_CONFIG_MAXPOWER                           ${usbd_max_power}U
#define USBD_COMPOSITE_USE_IAD                         ${usbd_composite_aid}U
#define USBD_DEVICE_FRAMEWORK_BUILDER_ENABLED          ${usbd_builder_enabled}U

#define USBD_FRAMEWORK_MAX_DESC_SZ                     ${USBD_FRAMEWORK_MAX_DESC_SZ_value}U
/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */
[#if FamilyName?lower_case?starts_with("stm32c0")]
/* Enum Class Type */
typedef enum
{
  CLASS_TYPE_NONE     = 0,
  CLASS_TYPE_HID      = 1,
  CLASS_TYPE_CDC_ACM  = 2,
  CLASS_TYPE_MSC      = 3,
  CLASS_TYPE_CDC_ECM  = 4,
  CLASS_TYPE_DFU      = 5,
  CLASS_TYPE_VIDEO    = 6,
  CLASS_TYPE_PIMA_MTP = 7,
  CLASS_TYPE_CCID     = 8,
  CLASS_TYPE_PRINTER  = 9,
  CLASS_TYPE_RNDIS    = 10,
} USBD_CompositeClassTypeDef;
[#else]
/* Enum Class Type */
typedef enum
{
  CLASS_TYPE_NONE     = 0,
  CLASS_TYPE_HID      = 1,
  CLASS_TYPE_CDC_ACM  = 2,
  CLASS_TYPE_MSC      = 3,
  CLASS_TYPE_CDC_ECM  = 4,
  CLASS_TYPE_DFU      = 5,
  CLASS_TYPE_PIMA_MTP = 6,
  CLASS_TYPE_RNDIS    = 7,
  CLASS_TYPE_VIDEO    = 8,
  CLASS_TYPE_CCID     = 9,
  CLASS_TYPE_PRINTER  = 10,
} USBD_CompositeClassTypeDef;
[/#if]

[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as variable]
    [#assign value = variable.value]
    [#assign name = variable.name]
[#if name?contains("UX_DEVICE_HID_CORE") && value == "1"]
/* Enum HID Interface Type */
typedef enum
{
  INTERFACE_HID_CUSTOM     = 0,
  INTERFACE_HID_KEYBOARD   = 1,
  INTERFACE_HID_MOUSE      = 2,
} USBD_HIDInterfaceTypeDef;

[/#if][/#list]
[/#if]
[/#list]
/* USB Endpoint handle structure */
typedef struct
{
  uint32_t status;
  uint32_t total_length;
  uint32_t rem_length;
  uint32_t maxpacket;
  uint16_t is_used;
  uint16_t bInterval;
} USBD_EndpointTypeDef;

/* USB endpoint handle structure */
typedef struct
{
  uint8_t add;
  uint8_t type;
  uint16_t size;
  uint8_t is_used;
} USBD_EPTypeDef;

/* USB Composite handle structure */
typedef struct
{
  USBD_CompositeClassTypeDef ClassType;
  uint32_t ClassId;
  uint8_t InterfaceType;
  uint32_t Active;
  uint32_t NumEps;
  uint32_t NumIf;
  USBD_EPTypeDef Eps[USBD_MAX_CLASS_ENDPOINTS];
  uint8_t Ifs[USBD_MAX_CLASS_INTERFACES];
} USBD_CompositeElementTypeDef;

/* USB Device handle structure */
typedef struct _USBD_DevClassHandleTypeDef
{
  uint8_t Speed;
  uint32_t classId;
  uint32_t NumClasses;
  USBD_CompositeElementTypeDef tclasslist[USBD_MAX_SUPPORTED_CLASS];
  uint32_t CurrDevDescSz;
  uint32_t CurrConfDescSz;
} USBD_DevClassHandleTypeDef;

/* USB Device endpoint direction */
typedef enum
{
  OUT   = 0x00,
  IN    = 0x80,
} USBD_EPDirectionTypeDef;

/* USB Device descriptors structure */
typedef struct
{
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint16_t bcdUSB;
  uint8_t bDeviceClass;
  uint8_t bDeviceSubClass;
  uint8_t bDeviceProtocol;
  uint8_t bMaxPacketSize;
  uint16_t idVendor;
  uint16_t idProduct;
  uint16_t bcdDevice;
  uint8_t iManufacturer;
  uint8_t iProduct;
  uint8_t iSerialNumber;
  uint8_t bNumConfigurations;
} __PACKED USBD_DeviceDescTypedef;

/* USB Iad descriptors structure */
typedef struct
{
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint8_t bFirstInterface;
  uint8_t bInterfaceCount;
  uint8_t bFunctionClass;
  uint8_t bFunctionSubClass;
  uint8_t bFunctionProtocol;
  uint8_t iFunction;
} __PACKED USBD_IadDescTypedef;

/* USB interface descriptors structure */
typedef struct
{
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint8_t bInterfaceNumber;
  uint8_t bAlternateSetting;
  uint8_t bNumEndpoints;
  uint8_t bInterfaceClass;
  uint8_t bInterfaceSubClass;
  uint8_t bInterfaceProtocol;
  uint8_t iInterface;
} __PACKED USBD_IfDescTypedef;

/* USB endpoint descriptors structure */
typedef struct
{
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint8_t bEndpointAddress;
  uint8_t bmAttributes;
  uint16_t wMaxPacketSize;
  uint8_t bInterval;
} __PACKED USBD_EpDescTypedef;

/* USB Config descriptors structure */
typedef struct
{
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint16_t wDescriptorLength;
  uint8_t bNumInterfaces;
  uint8_t bConfigurationValue;
  uint8_t iConfiguration;
  uint8_t bmAttributes;
  uint8_t bMaxPower;
} __PACKED USBD_ConfigDescTypedef;

/* USB Qualifier descriptors structure */
typedef struct
{
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint16_t bcdDevice;
  uint8_t Class;
  uint8_t SubClass;
  uint8_t Protocol;
  uint8_t bMaxPacketSize;
  uint8_t bNumConfigurations;
  uint8_t bReserved;
} __PACKED USBD_DevQualiDescTypedef;

[#assign acm_ecm_rndis = "0"]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as variable]
    [#assign value = variable.value]
    [#assign name = variable.name]
[#if name?contains("UX_DEVICE_HID_CORE") && value == "1"]
#if USBD_HID_CLASS_ACTIVATED == 1U
/* USB HID descriptors structure */
typedef struct
{
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint16_t bcdHID;
  uint8_t bCountryCode;
  uint8_t bNumDescriptors;
  uint8_t bHIDDescriptorType;
  uint16_t wDescriptorLength;
} __PACKED USBD_HIDDescTypedef;
#endif /* USBD_HID_CLASS_ACTIVATED == 1U */
[/#if]

[#if (name?contains("UX_DEVICE_CDC_ACM") && value == "1") || (name?contains("UX_DEVICE_CDC_ECM") && value == "1")|| (name?contains("UX_DEVICE_RNDIS") && value == "1")]
[#if acm_ecm_rndis == "0"]
#if (USBD_CDC_ACM_CLASS_ACTIVATED == 1) || (USBD_RNDIS_CLASS_ACTIVATED == 1) || (USBD_CDC_ECM_CLASS_ACTIVATED == 1)
typedef struct
{
  /* Header Functional Descriptor*/
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint8_t bDescriptorSubtype;
  uint16_t bcdCDC;
} __PACKED USBD_CDCHeaderFuncDescTypedef;

typedef struct
{
  /* Call Management Functional Descriptor*/
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint8_t bDescriptorSubtype;
  uint8_t bmCapabilities;
  uint8_t bDataInterface;
} __PACKED USBD_CDCCallMgmFuncDescTypedef;

typedef struct
{
  /* ACM Functional Descriptor*/
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint8_t bDescriptorSubtype;
  uint8_t bmCapabilities;
} __PACKED USBD_CDCACMFuncDescTypedef;

typedef struct
{
  /* Union Functional Descriptor*/
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint8_t bDescriptorSubtype;
  uint8_t bMasterInterface;
  uint8_t bSlaveInterface;
} __PACKED USBD_CDCUnionFuncDescTypedef;

#endif /* (USBD_CDC_ACM_CLASS_ACTIVATED == 1) || (USBD_RNDIS_CLASS_ACTIVATED == 1)  || (USBD_CDC_ECM_CLASS_ACTIVATED == 1)*/
[#assign acm_ecm_rndis = "1"]
[/#if]
[/#if]

[#if name?contains("UX_DEVICE_CDC_ECM") && value == "1"]
#if USBD_CDC_ECM_CLASS_ACTIVATED == 1
typedef struct
{
  uint8_t bFunctionLength;
  uint8_t bDescriptorType;
  uint8_t bDescriptorSubType;
  uint8_t iMacAddress;
  uint8_t bEthernetStatistics3;
  uint8_t bEthernetStatistics2;
  uint8_t bEthernetStatistics1;
  uint8_t bEthernetStatistics0;
  uint16_t wMaxSegmentSize;
  uint16_t bNumberMCFiltes;
  uint8_t bNumberPowerFiltes;
} __PACKED USBD_ECMFuncDescTypedef;
#endif /* USBD_CDC_ECM_CLASS_ACTIVATED */
[/#if]

[#if name?contains("UX_DEVICE_DFU") && value == "1"]
#if USBD_DFU_CLASS_ACTIVATED == 1
typedef struct
{
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint8_t bmAttributes;
  uint16_t wDetachTimeout;
  uint16_t wTransferSze;
  uint16_t bcdDFUVersion;
}__PACKED USBD_DFUFuncDescTypedef;
#endif /* USBD_DFU_CLASS_ACTIVATED */
[/#if]

[#if name?contains("UX_DEVICE_VIDEO") && value == "1"]
#if USBD_VIDEO_CLASS_ACTIVATED == 1

/* Video Control Interface Descriptor (Interface Header) */
typedef struct
{
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint8_t bDescriptorSubtype;
  uint16_t bcdUVC;
  uint16_t wTotalLength;
  uint32_t dwClockFrequency;
  uint8_t bInCollection;
  uint8_t aInterfaceNr;
} __PACKED USBD_VIDEOCSVCIfDescTypeDef;

/* Video Interface Descriptor (Input Terminal) */
typedef struct
{
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint8_t bDescriptorSubtype;
  uint8_t bTerminalID;
  uint16_t wTerminalType;
  uint8_t bAssocTerminal;
  uint8_t iTerminal;
} __PACKED USBD_VIDEOInputTerminalDescTypeDef;

/* Video Interface Descriptor (Output Terminal) */
typedef struct
{
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint8_t bDescriptorSubtype;
  uint8_t bTerminalID;
  uint16_t wTerminalType;
  uint8_t bAssocTerminal;
  uint8_t bSourceID;
  uint8_t iTerminal;
} __PACKED USBD_VIDEOOutputTerminalDescTypeDef;

/* Video Streaming Interface Input Header Descriptor */
typedef struct
{
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint8_t bDescriptorSubtype;
  uint8_t bNumFormats;
  uint16_t wTotalLength;
  uint8_t bEndpointAddress;
  uint8_t bmInfo;
  uint8_t bTerminalLink;
  uint8_t bStillCaptureMethod;
  uint8_t bTriggerSupport;
  uint8_t bTriggerUsage;
  uint8_t bControlSize;
  uint8_t bmaControls;
} __PACKED USBD_VIDEOVSHeaderDescTypeDef;

/* Video Format Descriptor*/
typedef struct
{
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint8_t bDescriptorSubType;
  uint8_t bFormatIndex;
  uint8_t bNumFrameDescriptors;
[#if vs_format_subtype == "1"]
  uint8_t pGiudFormat[16];
  uint8_t bBitsPerPixel;
[#else]
  uint8_t bmFlags;
[/#if]
  uint8_t bDefaultFrameIndex;
  uint8_t bAspectRatioX;
  uint8_t bAspectRatioY;
  uint8_t bmInterfaceFlag;
  uint8_t bCopyProtect;
} __PACKED USBD_VIDEOPayloadFormatDescTypeDef;

[#if vs_format_subtype == "1"]
typedef struct
{
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint8_t bDescriptorSubType;
  uint8_t bColorPrimarie;
  uint8_t bTransferCharacteristics;
  uint8_t bMatrixCoefficients;
} __PACKED USBD_ColorMatchingDescTypeDef;
[/#if]

/* Frame Descriptor */
typedef struct
{
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint8_t bDescriptorSubType;
  uint8_t bFrameIndex;
  uint8_t bmCapabilities;
  uint16_t wWidth;
  uint16_t wHeight;
  uint32_t dwMinBitRate;
  uint32_t dwMaxBitRate;
  uint32_t dwMaxVideoFrameBufferSize;
  uint32_t dwDefaultFrameInterval;
  uint8_t bFrameIntervalType;
  uint32_t dwFrameInterval;
} __PACKED USBD_VIDEOFrameDescTypeDef;

#endif /* USBD_VIDEO_CLASS_ACTIVATED */
[/#if]
[#if name?contains("UX_DEVICE_CCID") && value == "1"]
#if USBD_CCID_CLASS_ACTIVATED == 1U
/*
 * CCID Class specification revision 1.1
 * Smart Card Device Class Descriptor Table
 */

typedef struct
{
  uint8_t bLength;
  uint8_t bDescriptorType;
  uint16_t bcdCCID;
  uint8_t bMaxSlotIndex;
  uint8_t bVoltageSupport;
  uint32_t dwProtocols;
  uint32_t dwDefaultClock;
  uint32_t dwMaximumClock;
  uint8_t bNumClockSupported;
  uint32_t dwDataRate;
  uint32_t dwMaxDataRate;
  uint8_t bNumDataRatesSupported;
  uint32_t dwMaxIFSD;
  uint32_t dwSynchProtocols;
  uint32_t dwMechanical;
  uint32_t dwFeatures;
  uint32_t dwMaxCCIDMessageLength;
  uint8_t bClassGetResponse;
  uint8_t bClassEnvelope;
  uint16_t wLcdLayout;
  uint8_t bPINSupport;
  uint8_t bMaxCCIDBusySlots;
} __PACKED USBD_CCIDDescTypedef;
#endif /* USBD_CCID_CLASS_ACTIVATED == 1U */
[/#if]

[/#list]
[/#if]
[/#list]

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

uint8_t *USBD_Get_Device_Framework_Speed(uint8_t Speed, ULONG *Length);
uint8_t *USBD_Get_String_Framework(ULONG *Length);
uint8_t *USBD_Get_Language_Id_Framework(ULONG *Length);
uint16_t USBD_Get_Interface_Number(uint8_t class_type, uint8_t interface_type);
uint16_t USBD_Get_Configuration_Number(uint8_t class_type, uint8_t interface_type);

[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as variable]
    [#assign value = variable.value]
    [#assign name = variable.name]
[#if name?contains("UX_DEVICE_HID_CORE") && value == "1"]
#if USBD_HID_CLASS_ACTIVATED == 1U
uint8_t *USBD_HID_ReportDesc(uint8_t hid_type);
uint16_t USBD_HID_ReportDesc_length(uint8_t hid_type);
#endif /* USBD_HID_CLASS_ACTIVATED == 1U */
[/#if][/#list]
[/#if]
[/#list]
/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN Private_defines */

/* USER CODE END Private_defines */

#define USBD_VID                                      ${usbd_vid_value}
#define USBD_PID                                      ${usbd_pid_value}
#define USBD_LANGID_STRING                            ${usbd_langid}
#define USBD_MANUFACTURER_STRING                      "${usbd_manufacturer_string}"
#define USBD_PRODUCT_STRING                           "${usbd_product_string}"
#define USBD_SERIAL_NUMBER                            "${serial_number}"

#define USB_DESC_TYPE_INTERFACE                       0x04U
#define USB_DESC_TYPE_ENDPOINT                        0x05U
#define USB_DESC_TYPE_CONFIGURATION                   0x02U
#define USB_DESC_TYPE_IAD                             0x0BU

#define USBD_EP_TYPE_CTRL                             0x00U
#define USBD_EP_TYPE_ISOC                             0x01U
#define USBD_EP_TYPE_BULK                             0x02U
#define USBD_EP_TYPE_INTR                             0x03U

[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as variable]
    [#assign value = variable.value]
    [#assign name = variable.name]
[#if name?contains("UX_DEVICE_VIDEO") && value == "1"]
#define USBD_EP_ATTR_ISOC_NOSYNC                      0x00U
#define USBD_EP_ATTR_ISOC_ASYNC                       0x04U
#define USBD_EP_ATTR_ISOC_ADAPT                       0x08U
#define USBD_EP_ATTR_ISOC_SYNC                        0x0CU
[/#if][/#list]
[/#if]
[/#list]
#define USBD_FULL_SPEED                               0x00U
#define USBD_HIGH_SPEED                               0x01U


#define USB_BCDUSB                                    0x0200U
#define LANGUAGE_ID_MAX_LENGTH                        2U

#define USBD_IDX_MFC_STR                              0x01U
#define USBD_IDX_PRODUCT_STR                          0x02U
#define USBD_IDX_SERIAL_STR                           0x03U

#define USBD_MAX_EP0_SIZE                             64U
#define USBD_DEVICE_QUALIFIER_DESC_SIZE               0x0AU

#define USBD_STRING_FRAMEWORK_MAX_LENGTH              256U

[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as variable]
    [#assign value = variable.value]
    [#assign name = variable.name]
[#if name?contains("UX_DEVICE_STORAGE") && value == "1"]
/* Device Storage Class */
#define USBD_MSC_EPOUT_ADDR                           0x0${usbd_msc_ep_out_address}U
#define USBD_MSC_EPIN_ADDR                            0x8${usbd_msc_ep_in_address}U
[#if ux_device_bidirectional_endpoint_support_val == "0"]
#if (USBD_MSC_EPOUT_ADDR == (USBD_MSC_EPIN_ADDR & 0x0FU))
#error Address endpoint IN shall be different form endpoint OUT.
#endif
[/#if]
#define USBD_MSC_EPOUT_FS_MPS                         ${usbd_msc_ep_out_fs_mps}U
#define USBD_MSC_EPOUT_HS_MPS                         ${usbd_msc_ep_out_hs_mps}U
#define USBD_MSC_EPIN_FS_MPS                          ${usbd_msc_ep_in_fs_mps}U
#define USBD_MSC_EPIN_HS_MPS                          ${usbd_msc_ep_in_hs_mps}U
[/#if]

[#if name?contains("UX_DEVICE_HID_MOUSE") && value == "1"]
/* Device HID Mouse */
#define USBD_HID_MOUSE_EPIN_ADDR                      0x8${usbd_hid_mouse_ep_in_address}U
#define USBD_HID_MOUSE_EPIN_FS_MPS                    ${usbd_hid_mouse_ep_in_fs_mps}U
#define USBD_HID_MOUSE_EPIN_HS_MPS                    ${usbd_hid_mouse_ep_in_hs_mps}U
#define USBD_HID_MOUSE_EPIN_FS_BINTERVAL              ${usbd_hid_mouse_ep_in_fs_bint}U
#define USBD_HID_MOUSE_EPIN_HS_BINTERVAL              ${usbd_hid_mouse_ep_in_hs_bint}U
[/#if]

[#if name?contains("UX_DEVICE_HID_KEYBOARD") && value == "1"]
/* Device HID Keyboard */
#define USBD_HID_KEYBOARD_EPIN_ADDR                   0x8${usbd_hid_key_ep_in_address}U
#define USBD_HID_KEYBOARD_EPIN_FS_MPS                 ${usbd_hid_key_ep_in_fs_mps}U
#define USBD_HID_KEYBOARD_EPIN_HS_MPS                 ${usbd_hid_key_ep_in_hs_mps}U
#define USBD_HID_KEYBOARD_EPIN_FS_BINTERVAL           ${usbd_hid_key_ep_in_fs_bint}U
#define USBD_HID_KEYBOARD_EPIN_HS_BINTERVAL           ${usbd_hid_key_ep_in_hs_bint}U
[/#if]

[#if name?contains("UX_DEVICE_HID_CUSTOM") && value == "1"]
/* Device HID Custom */
#define USBD_HID_CUSTOM_EPIN_ADDR                     0x8${usbd_hid_custom_ep_in_address}U
[#if UX_DEVICE_CLASS_HID_INTERRUPT_OUT_SUPPORT_value == "1"]
#define USBD_HID_CUSTOM_EPOUT_ADDR                    0x0${usbd_hid_custom_ep_out_address}U
[#if ux_device_bidirectional_endpoint_support_val == "0"]
#if (USBD_HID_CUSTOM_EPOUT_ADDR == (USBD_HID_CUSTOM_EPIN_ADDR & 0x0FU))
#error Address endpoint IN shall be different form endpoint OUT.
#endif
[/#if]
[/#if]
#define USBD_HID_CUSTOM_EPIN_FS_MPS                   ${usbd_hid_custom_ep_in_fs_mps}U
#define USBD_HID_CUSTOM_EPIN_HS_MPS                   ${usbd_hid_custom_ep_in_hs_mps}U
#define USBD_HID_CUSTOM_EPIN_FS_BINTERVAL             ${usbd_hid_custom_ep_in_fs_bint}U
#define USBD_HID_CUSTOM_EPIN_HS_BINTERVAL             ${usbd_hid_custom_ep_in_hs_bint}U
[#if UX_DEVICE_CLASS_HID_INTERRUPT_OUT_SUPPORT_value == "1"]
#define USBD_HID_CUSTOM_EPOUT_FS_MPS                  ${usbd_hid_custom_ep_out_fs_mps}U
#define USBD_HID_CUSTOM_EPOUT_HS_MPS                  ${usbd_hid_custom_ep_out_hs_mps}U
#define USBD_HID_CUSTOM_EPOUT_FS_BINTERVAL            ${usbd_hid_custom_ep_out_fs_bint}U
#define USBD_HID_CUSTOM_EPOUT_HS_BINTERVAL            ${usbd_hid_custom_ep_out_hs_bint}U
[/#if]
[/#if]

[#if name?contains("UX_DEVICE_CDC_ACM") && value == "1"]
/* Device CDC-ACM Class */
#define USBD_CDCACM_EPINCMD_ADDR                      0x8${usbd_cdc_ep_in_cmd_address}U
#define USBD_CDCACM_EPINCMD_FS_MPS                    ${usbd_cdc_ep_in_cmd_fs_mps}U
#define USBD_CDCACM_EPINCMD_HS_MPS                    ${usbd_cdc_ep_in_cmd_hs_mps}U
#define USBD_CDCACM_EPIN_ADDR                         0x8${usbd_cdc_ep_in_address}U
#define USBD_CDCACM_EPOUT_ADDR                        0x0${usbd_cdc_ep_out_address}U
[#if ux_device_bidirectional_endpoint_support_val == "0"]
#if (USBD_CDCACM_EPOUT_ADDR == (USBD_CDCACM_EPIN_ADDR & 0x0FU))
#error Address endpoint IN shall be different form endpoint OUT.
#endif
[/#if]
#define USBD_CDCACM_EPIN_FS_MPS                       ${usbd_cdc_ep_in_fs_mps}U
#define USBD_CDCACM_EPIN_HS_MPS                       ${usbd_cdc_ep_in_hs_mps}U
#define USBD_CDCACM_EPOUT_FS_MPS                      ${usbd_cdc_ep_out_fs_mps}U
#define USBD_CDCACM_EPOUT_HS_MPS                      ${usbd_cdc_ep_out_hs_mps}U
#define USBD_CDCACM_EPINCMD_FS_BINTERVAL              ${usbd_cdc_ep_in_fs_bint}U
#define USBD_CDCACM_EPINCMD_HS_BINTERVAL              ${usbd_cdc_ep_in_hs_bint}U
[/#if]

[#if name?contains("UX_DEVICE_CDC_ECM") && value == "1"]
/* CDC_ECM parameters: you can fine tune these values depending on the needed baudrates and performance. */
#define USBD_DESC_ECM_BCD                             0x1000U
#define USBD_DESC_SUBTYPE_ACM                         0x0FU
#define CDC_ECM_ETH_STATS_BYTE3                       0U
#define CDC_ECM_ETH_STATS_BYTE2                       0U
#define CDC_ECM_ETH_STATS_BYTE1                       0U
#define CDC_ECM_ETH_STATS_BYTE0                       0U
/* Ethernet Maximum Segment size, typically 1514 bytes */
#define CDC_ECM_ETH_MAX_SEGSZE                        1514U
/* Number of Ethernet multicast filters */
#define CDC_ECM_ETH_NBR_MACFILTERS                    0U
/* Number of wakeup power filters */
#define CDC_ECM_ETH_NBR_PWRFILTERS                    0U
/* MAC String index */
#define CDC_ECM_MAC_STRING_INDEX                      10U
#define CDC_ECM_LOCAL_MAC_STR_DESC                    (uint8_t *)"${usbd_cdcecm_local_mac_address}"
#define CDC_ECM_REMOTE_MAC_STR_DESC                   (uint8_t *)"${usbd_cdcecm_remote_mac_address}"

#define USBD_CDC_ECM_NX_PKPOOL_ENTRIES                ${usbd_cdcecm_nx_pkpool_entries}U
#define USBD_CDC_ECM_PACKET_POOL_WAIT                 ${usbd_cdcecm_packet_pool_wait}U

#define USBD_CDCECM_EPINCMD_ADDR                      0x8${usbd_cdcecm_ep_in_cmd_address}U
#define USBD_CDCECM_EPINCMD_FS_MPS                    ${usbd_cdcecm_ep_in_cmd_fs_mps}U
#define USBD_CDCECM_EPINCMD_HS_MPS                    ${usbd_cdcecm_ep_in_cmd_hs_mps}U
#define USBD_CDCECM_EPINCMD_FS_BINTERVAL              ${usbd_cdcecm_ep_in_cmd_fs_bint}U
#define USBD_CDCECM_EPINCMD_HS_BINTERVAL              ${usbd_cdcecm_ep_in_cmd_hs_bint}U
#define USBD_CDCECM_EPIN_ADDR                         0x8${usbd_cdcecm_ep_in_address}U
#define USBD_CDCECM_EPOUT_ADDR                        0x0${usbd_cdcecm_ep_out_address}U
[#if ux_device_bidirectional_endpoint_support_val == "0"]
#if (USBD_CDCECM_EPOUT_ADDR == (USBD_CDCECM_EPIN_ADDR & 0x0FU))
#error Address endpoint IN shall be different form endpoint OUT.
#endif
[/#if]
#define USBD_CDCECM_EPIN_FS_MPS                       ${usbd_cdcecm_ep_in_fs_mps}U
#define USBD_CDCECM_EPIN_HS_MPS                       ${usbd_cdcecm_ep_in_hs_mps}U
#define USBD_CDCECM_EPOUT_FS_MPS                      ${usbd_cdcecm_ep_out_fs_mps}U
#define USBD_CDCECM_EPOUT_HS_MPS                      ${usbd_cdcecm_ep_out_hs_mps}U

[/#if]

[#if name?contains("UX_DEVICE_RNDIS") && value == "1"]
/* RNDIS Device parameters */

/* MAC String index */
#define RNDIS_MAC_STRING_INDEX                        6U
#define RNDIS_LOCAL_MAC_STR_DESC                      (uint8_t *)"${usbd_rndis_local_mac_address}"
#define RNDIS_REMOTE_MAC_STR_DESC                     (uint8_t *)"${usbd_rndis_remote_mac_address}"

#define USBD_RNDIS_EPINCMD_ADDR                       0x8${usbd_rndis_ep_in_cmd_address}U
#define USBD_RNDIS_EPINCMD_FS_MPS                     ${usbd_rndis_ep_in_cmd_fs_mps}U
#define USBD_RNDIS_EPINCMD_HS_MPS                     ${usbd_rndis_ep_in_cmd_hs_mps}U
#define USBD_RNDIS_EPINCMD_FS_BINTERVAL               ${usbd_rndis_ep_in_cmd_fs_bint}U
#define USBD_RNDIS_EPINCMD_HS_BINTERVAL               ${usbd_rndis_ep_in_cmd_hs_bint}U
#define USBD_RNDIS_EPIN_ADDR                          0x8${usbd_rndis_ep_in_address}U
#define USBD_RNDIS_EPOUT_ADDR                         0x0${usbd_rndis_ep_out_address}U
[#if ux_device_bidirectional_endpoint_support_val == "0"]
#if (USBD_RNDIS_EPOUT_ADDR == (USBD_RNDIS_EPIN_ADDR & 0x0FU))
#error Address endpoint IN shall be different form endpoint OUT.
#endif
[/#if]
#define USBD_RNDIS_EPIN_FS_MPS                        ${usbd_rndis_ep_in_fs_mps}U
#define USBD_RNDIS_EPIN_HS_MPS                        ${usbd_rndis_ep_in_hs_mps}U
#define USBD_RNDIS_EPOUT_FS_MPS                       ${usbd_rndis_ep_out_fs_mps}U
#define USBD_RNDIS_EPOUT_HS_MPS                       ${usbd_rndis_ep_out_hs_mps}U
[/#if]

[#if name?contains("UX_DEVICE_DFU") && value == "1"]
/* DFU parameters: you can fine tune these values depending on the needed baudrates and performance. */
#define DFU_DESCRIPTOR_TYPE                           0x21U
#define USBD_DFU_BM_ATTRIBUTES                        ${usbd_dfu_bm_attributes}U
#define USBD_DFU_DetachTimeout                        ${usbd_dfu_detachtimeout}U
#define USBD_DFU_XFER_SIZE                            ${usbd_dfu_xfer_size}U

#define USBD_DFU_STRING_DESC_INDEX                    0x06U

#define USBD_DFU_STRING_DESC                          "${usbd_dfu_string_desc}"
[/#if]

[#if name?contains("UX_DEVICE_VIDEO") && value == "1"]
/* Device VIDEO Class */
#define USBD_VIDEO_EPIN_ADDR                          0x8${usbd_video_ep_in_address}U
#define USBD_VIDEO_EPIN_FS_MPS                        ${usbd_video_ep_in_fs_mps}U
#define USBD_VIDEO_EPIN_HS_MPS                        ${usbd_video_ep_in_hs_mps}U
#define USBD_VIDEO_EPIN_FS_BINTERVAL                  ${usbd_video_ep_in_fs_binterval}U
#define USBD_VIDEO_EPIN_HS_BINTERVAL                  ${usbd_video_ep_in_hs_binterval}U

#define UVC_FRAME_WIDTH                               ${usbd_video_width}U
#define UVC_FRAME_HEIGHT                              ${usbd_video_height}U
#define UVC_CAM_FPS_FS                                ${usbd_video_cam_fps_fs}U
#define UVC_CAM_FPS_HS                                ${usbd_video_cam_fps_hs}U

#define UVC_MIN_BIT_RATE(n)                           (UVC_FRAME_WIDTH * UVC_FRAME_HEIGHT * 16U * (n))
#define UVC_MAX_BIT_RATE(n)                           (UVC_FRAME_WIDTH * UVC_FRAME_HEIGHT * 16U * (n))
#define UVC_INTERVAL(n)                               (10000000U/(n))
#define UVC_MAX_FRAME_SIZE                            (UVC_FRAME_WIDTH * UVC_FRAME_HEIGHT * 16U / 2U)

[#if vs_format_subtype == "1"]
#define UVC_GUID_YUY2                                 0x32595559U
#define UVC_GUID_NV12                                 0x3231564EU

#define UVC_BITS_PER_PIXEL                            ${usbd_uvc_bits_per_pixel}U
[#if usbd_uvc_guid == "0"]
#define UVC_UNCOMPRESSED_GUID                         UVC_GUID_YUY2
[#else]
#define UVC_UNCOMPRESSED_GUID                         UVC_GUID_NV12
[/#if]
#define UVC_COLOR_PRIMARIE                            ${usbd_uvc_color}U
#define UVC_TFR_CHARACTERISTICS                       ${usbd_uvc_charac}U
#define UVC_MATRIX_COEFFICIENTS                       ${usbd_uvc_matrix_coeff}U
[/#if]

[#if vs_format_subtype == "0"]
#define VS_FORMAT_DESC_SIZE                           0x0BU
#define VC_HEADER_SIZE                                0x37U
[#else]
#define VS_FORMAT_DESC_SIZE                           0x1BU
#define VC_HEADER_SIZE                                0x4DU
[/#if]

#ifndef WBVAL
#define WBVAL(x) ((x) & 0xFFU),(((x) >> 8) & 0xFFU)
#endif /* WBVAL */
#ifndef DBVAL
#define DBVAL(x) ((x)& 0xFFU),(((x) >> 8) & 0xFFU),(((x)>> 16) & 0xFFU),(((x) >> 24) & 0xFFU)
#endif /* DBVAL */
[/#if]

[#if name?contains("UX_DEVICE_PIMA") && value == "1"]
/* Device PIMA Class */
#define USBD_PIMA_EPINCMD_ADDR                        0x8${usbd_pima_ep_in_cmd_address}U
#define USBD_PIMA_EPINCMD_FS_MPS                      ${usbd_pima_ep_in_cmd_fs_mps}U
#define USBD_PIMA_EPINCMD_HS_MPS                      ${usbd_pima_ep_in_cmd_hs_mps}U
#define USBD_PIMA_EPINCMD_FS_BINTERVAL                ${usbd_pima_ep_in_fs_bint}U
#define USBD_PIMA_EPINCMD_HS_BINTERVAL                ${usbd_pima_ep_in_hs_bint}U

#define USBD_PIMA_EPIN_ADDR                           0x8${usbd_pima_ep_in_address}U
#define USBD_PIMA_EPOUT_ADDR                          0x0${usbd_pima_ep_out_address}U
[#if ux_device_bidirectional_endpoint_support_val == "0"]
#if (USBD_PIMA_EPOUT_ADDR == (USBD_PIMA_EPIN_ADDR & 0x0FU))
#error Address endpoint IN shall be different form endpoint OUT.
#endif
[/#if]
#define USBD_PIMA_EPIN_FS_MPS                         ${usbd_pima_ep_in_fs_mps}U
#define USBD_PIMA_EPIN_HS_MPS                         ${usbd_pima_ep_in_hs_mps}U
#define USBD_PIMA_EPOUT_FS_MPS                        ${usbd_pima_ep_out_fs_mps}U
#define USBD_PIMA_EPOUT_HS_MPS                        ${usbd_pima_ep_out_hs_mps}U
[/#if]

[#if name?contains("UX_DEVICE_CCID") && value == "1"]
/* Device CCID Class */
#define USBD_CCID_EPINCMD_ADDR                        0x8${usbd_ccid_ep_in_cmd_address}U
#define USBD_CCID_EPINCMD_FS_MPS                      ${usbd_ccid_ep_in_cmd_fs_mps}U
#define USBD_CCID_EPINCMD_HS_MPS                      ${usbd_ccid_ep_in_cmd_hs_mps}U
#define USBD_CCID_EPIN_ADDR                           0x8${usbd_ccid_ep_in_address}U
#define USBD_CCID_EPOUT_ADDR                          0x0${usbd_ccid_ep_out_address}U
[#if ux_device_bidirectional_endpoint_support_val == "0"]
#if (USBD_CCID_EPOUT_ADDR == (USBD_CCID_EPIN_ADDR & 0x0FU))
#error Address endpoint IN shall be different form endpoint OUT.
#endif
[/#if]
#define USBD_CCID_EPIN_FS_MPS                         ${usbd_ccid_ep_in_fs_mps}U
#define USBD_CCID_EPIN_HS_MPS                         ${usbd_ccid_ep_in_hs_mps}U
#define USBD_CCID_EPOUT_FS_MPS                        ${usbd_ccid_ep_out_fs_mps}U
#define USBD_CCID_EPOUT_HS_MPS                        ${usbd_ccid_ep_out_hs_mps}U
#define USBD_CCID_EPINCMD_FS_BINTERVAL                ${usbd_ccid_ep_in_fs_bint}U
#define USBD_CCID_EPINCMD_HS_BINTERVAL                ${usbd_ccid_ep_in_hs_bint}U

#define USBD_CCID_MAX_SLOT_INDEX                      ${usbd_ccid_max_slot_index}U
#define USBD_CCID_MAX_BUSY_SLOTS                      ${usbd_ccid_max_busy_slots}U
#define USBD_CCID_N_CLOCKS                            ${usbd_ccid_n_clocks}U
#define USBD_CCID_N_DATA_RATES                        ${usbd_ccid_n_data_rates}U

#define USBD_CCID_MAX_BLOCK_SIZE_HEADER               ${usbd_ccid_max_block_size_header}U
#define USBD_CCID_DEFAULT_DATA_RATE                   ${usbd_ccid_default_data_rate}U
#define USBD_CCID_MAX_DATA_RATE                       ${usbd_ccid_max_data_rate}U
#define USBD_CCID_DEFAULT_CLOCK_FREQ                  ${usbd_ccid_default_clock_freq}U
#define USBD_CCID_MAX_CLOCK_FREQ                      ${usbd_ccid_max_clock_freq}U
#define USBD_CCID_PROTOCOL                            ${usbd_ccid_protocol}U
#define USBD_CCID_VOLTAGE_SUPPLY                      ${usbd_ccid_voltage_supply}U
[/#if]
[#if name?contains("UX_DEVICE_PRINTER") && value == "1"]
/* Device Printer Class */
#define USBD_PRNT_EPIN_ADDR                           0x8${usbd_prnt_epin_addr}U
#define USBD_PRNT_EPOUT_ADDR                          0x0${usbd_prnt_epout_addr}U
[#if ux_device_bidirectional_endpoint_support_val == "0"]
#if (USBD_PRNT_EPOUT_ADDR == (USBD_PRNT_EPIN_ADDR & 0x0FU))
#error Address endpoint IN shall be different form endpoint OUT.
#endif
[/#if]
#define USBD_PRNT_EPOUT_FS_MPS                        ${usbd_prnt_epout_fs_mps}U
#define USBD_PRNT_EPOUT_HS_MPS                        ${usbd_prnt_epout_hs_mps}U
#define USBD_PRNT_EPIN_FS_MPS                         ${usbd_prnt_epin_fs_mps}U
#define USBD_PRNT_EPIN_HS_MPS                         ${usbd_prnt_epin_hs_mps}U

#define USBD_PRNT_IF_PROTOCOL                         ${usbd_prnt_if_protocol}U
[/#if]

[/#list]
[/#if]
[/#list]

#ifndef USBD_CONFIG_STR_DESC_IDX
#define USBD_CONFIG_STR_DESC_IDX                      0U
#endif /* USBD_CONFIG_STR_DESC_IDX */

#ifndef USBD_CONFIG_BMATTRIBUTES
#define USBD_CONFIG_BMATTRIBUTES                      0xC0U
#endif /* USBD_CONFIG_BMATTRIBUTES */

/* Private macro -----------------------------------------------------------*/
/* USER CODE BEGIN Private_macro */

/* USER CODE END Private_macro */
#define __USBD_FRAMEWORK_SET_EP(epadd, eptype, epsize, HSinterval, FSinterval) do { \
                                /* Append Endpoint descriptor to Configuration descriptor */ \
                                pEpDesc = ((USBD_EpDescTypedef*)((uint32_t)pConf + *Sze)); \
                                pEpDesc->bLength            = (uint8_t)sizeof(USBD_EpDescTypedef); \
                                pEpDesc->bDescriptorType    = USB_DESC_TYPE_ENDPOINT; \
                                pEpDesc->bEndpointAddress   = (epadd); \
                                pEpDesc->bmAttributes       = (eptype); \
                                pEpDesc->wMaxPacketSize     = (epsize); \
                                if(pdev->Speed == USBD_HIGH_SPEED) \
                                { \
                                  pEpDesc->bInterval        = (HSinterval); \
                                } \
                                else \
                                { \
                                  pEpDesc->bInterval        = (FSinterval); \
                                } \
                                *Sze += (uint32_t)sizeof(USBD_EpDescTypedef); \
                              } while(0)

#define __USBD_FRAMEWORK_SET_IF(ifnum, alt, eps, class, subclass, protocol, istring) do {\
                                /* Interface Descriptor */ \
                                pIfDesc = ((USBD_IfDescTypedef*)((uint32_t)pConf + *Sze)); \
                                pIfDesc->bLength = (uint8_t)sizeof(USBD_IfDescTypedef); \
                                pIfDesc->bDescriptorType = USB_DESC_TYPE_INTERFACE; \
                                pIfDesc->bInterfaceNumber = (ifnum); \
                                pIfDesc->bAlternateSetting = (alt); \
                                pIfDesc->bNumEndpoints = (eps); \
                                pIfDesc->bInterfaceClass = (class); \
                                pIfDesc->bInterfaceSubClass = (subclass); \
                                pIfDesc->bInterfaceProtocol = (protocol); \
                                pIfDesc->iInterface = (istring); \
                                *Sze += (uint32_t)sizeof(USBD_IfDescTypedef); \
                              } while(0)
#ifdef __cplusplus
}
#endif
#endif  /* __UX_DEVICE_DESCRIPTORS_H__ */
