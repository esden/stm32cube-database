[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ux_device_descriptors.h
  * @author  MCD Application Team
  * @brief   USBX Device descriptor header file
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
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __UX_DEVICE_DESCRIPTORS_H__
#define __UX_DEVICE_DESCRIPTORS_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "ux_api.h"
#include "ux_stm32_config.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private defines -----------------------------------------------------------*/
#define USBD_MAX_NUM_CONFIGURATION                     1U
#define USBD_MAX_SUPPORTED_CLASS                       3U
#define USBD_MAX_CLASS_ENDPOINTS                       9U
#define USBD_MAX_CLASS_INTERFACES                      9U

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
[#assign usbd_cdcecm_mac_address = 0]

[#assign usbd_dfu_bm_attributes = 0]
[#assign usbd_dfu_detachtimeout = 0]
[#assign usbd_dfu_xfer_size = 0]
[#assign usbd_dfu_string_desc = 0]

[#assign usbd_vid_value = 0]
[#assign usbd_pid_value = 0]
[#assign usbd_langid = 0]

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

    [#if name == "USBD_HID_EPIN_ADDR"]
      [#assign usbd_hid_ep_in_address = value]
    [/#if]


    [#if name == "USBD_HID_EPIN_FS_MPS"]
      [#assign usbd_hid_ep_in_fs_mps = value]
    [/#if]

    [#if name == "USBD_HID_EPIN_HS_MPS"]
      [#assign usbd_hid_ep_in_hs_mps = value]
    [/#if]

    [#if name == "USBD_HID_EPIN_FS_BINTERVAL"]
      [#assign usbd_hid_ep_in_fs_bint = value]
    [/#if]

    [#if name == "USBD_HID_EPIN_HS_BINTERVAL"]
      [#assign usbd_hid_ep_in_hs_bint = value]
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

    [#if name == "USBD_CDCECM_MAC_ADDR"]
      [#assign usbd_cdcecm_mac_address = value]
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
  [/#if]
  [#if name?contains("UX_DEVICE_HID") && value == "1"]
#define USBD_HID_CLASS_ACTIVATED                       1U
  [/#if]
  [#if name?contains("UX_DEVICE_CDC_ACM") && value == "1"]
#define USBD_CDC_ACM_CLASS_ACTIVATED                   1U
  [/#if]
  [#if name?contains("UX_DEVICE_CDC_ECM") && value == "1"]
#define USBD_CDC_ECM_CLASS_ACTIVATED                   1U
  [/#if]
  [#if name?contains("UX_DEVICE_DFU") && value == "1"]
#define USBD_DFU_CLASS_ACTIVATED                       1U
  [/#if]
[/#list]
[/#if]
[/#list]

#define USBD_CONFIG_MAXPOWER                           ${usbd_max_power}U
#define USBD_COMPOSITE_USE_IAD                         ${usbd_composite_aid}U
#define USBD_DEVICE_FRAMEWORK_BUILDER_ENABLED          ${usbd_builder_enabled}U
/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Enum Class Type */
typedef enum
{
  CLASS_TYPE_NONE    = 0,
  CLASS_TYPE_HID     = 1,
  CLASS_TYPE_CDC_ACM = 2,
  CLASS_TYPE_MSC     = 3,
  CLASS_TYPE_CDC_ECM = 4,
  CLASS_TYPE_DFU     = 5,
} USBD_CompositeClassTypeDef;

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
  uint8_t                     add;
  uint8_t                     type;
  uint16_t                    size;
  uint8_t                     is_used;
} USBD_EPTypeDef;

/* USB Composite handle structure */
typedef struct
{
  USBD_CompositeClassTypeDef   ClassType;
  uint32_t                     ClassId;
  uint32_t                     Active;
  uint32_t                     NumEps;
  USBD_EPTypeDef               Eps[USBD_MAX_CLASS_ENDPOINTS];
  uint32_t                     NumIf;
  uint8_t                      Ifs[USBD_MAX_CLASS_INTERFACES];
} USBD_CompositeElementTypeDef;

/* USB Device handle structure */
typedef struct _USBD_DevClassHandleTypeDef
{
  uint8_t                 Speed;
  uint32_t                classId;
  uint32_t                NumClasses;
  USBD_CompositeElementTypeDef tclasslist[USBD_MAX_SUPPORTED_CLASS];
  uint32_t                CurrDevDescSz;
  uint32_t                CurrConfDescSz;
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
  uint8_t           bLength;
  uint8_t           bDescriptorType;
  uint16_t          bcdUSB;
  uint8_t           bDeviceClass;
  uint8_t           bDeviceSubClass;
  uint8_t           bDeviceProtocol;
  uint8_t           bMaxPacketSize;
  uint16_t          idVendor;
  uint16_t          idProduct;
  uint16_t          bcdDevice;
  uint8_t           iManufacturer;
  uint8_t           iProduct;
  uint8_t           iSerialNumber;
  uint8_t           bNumConfigurations;
} __PACKED USBD_DeviceDescTypedef;

/* USB Iad descriptors structure */
typedef struct
{
  uint8_t           bLength;
  uint8_t           bDescriptorType;
  uint8_t           bFirstInterface;
  uint8_t           bInterfaceCount;
  uint8_t           bFunctionClass;
  uint8_t           bFunctionSubClass;
  uint8_t           bFunctionProtocol;
  uint8_t           iFunction;
} __PACKED USBD_IadDescTypedef;

/* USB interface descriptors structure */
typedef struct
{
  uint8_t           bLength;
  uint8_t           bDescriptorType;
  uint8_t           bInterfaceNumber;
  uint8_t           bAlternateSetting;
  uint8_t           bNumEndpoints;
  uint8_t           bInterfaceClass;
  uint8_t           bInterfaceSubClass;
  uint8_t           bInterfaceProtocol;
  uint8_t           iInterface;
} __PACKED USBD_IfDescTypedef;

/* USB endpoint descriptors structure */
typedef struct
{
  uint8_t           bLength;
  uint8_t           bDescriptorType;
  uint8_t           bEndpointAddress;
  uint8_t           bmAttributes;
  uint16_t          wMaxPacketSize;
  uint8_t           bInterval;
} __PACKED USBD_EpDescTypedef;

/* USB Config descriptors structure */
typedef struct
{
  uint8_t   bLength;
  uint8_t   bDescriptorType;
  uint16_t  wDescriptorLength;
  uint8_t   bNumInterfaces;
  uint8_t   bConfigurationValue;
  uint8_t   iConfiguration;
  uint8_t   bmAttributes;
  uint8_t   bMaxPower;
} __PACKED USBD_ConfigDescTypedef;

/* USB Qualifier descriptors structure */
typedef struct
{
  uint8_t           bLength;
  uint8_t           bDescriptorType;
  uint16_t          bcdDevice;
  uint8_t           Class;
  uint8_t           SubClass;
  uint8_t           Protocol;
  uint8_t           bMaxPacketSize;
  uint8_t           bNumConfigurations;
  uint8_t           bReserved;
} __PACKED USBD_DevQualiDescTypedef;

[#assign acm_ecm_rndis = "0"]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
    [#assign value = define.value]
    [#assign name = define.name]
[#if name?contains("UX_DEVICE_HID") && value == "1"]
#if USBD_HID_CLASS_ACTIVATED == 1U
/* USB HID descriptors structure */
typedef struct
{
  uint8_t           bLength;
  uint8_t           bDescriptorType;
  uint16_t          bcdHID;
  uint8_t           bCountryCode;
  uint8_t           bNumDescriptors;
  uint8_t           bHIDDescriptorType;
  uint16_t          wItemLength;
} __PACKED USBD_HIDDescTypedef;
/* USER CODE BEGIN HID_CLASS */

/* USER CODE END HID_CLASS */
#endif /* USBD_HID_CLASS_ACTIVATED == 1U */
[/#if]

[#if (name?contains("UX_DEVICE_CDC_ACM") && value == "1") || (name?contains("UX_DEVICE_CDC_ECM") && value == "1")]
[#if acm_ecm_rndis == "0"]
#if (USBD_CDC_ACM_CLASS_ACTIVATED == 1) || (USBD_CMPSIT_ACTIVATE_RNDIS == 1) || (USBD_CDC_ECM_CLASS_ACTIVATED == 1)
typedef struct
{
  /* Header Functional Descriptor*/
  uint8_t           bLength;
  uint8_t           bDescriptorType;
  uint8_t           bDescriptorSubtype;
  uint16_t          bcdCDC;
} __PACKED USBD_CDCHeaderFuncDescTypedef;

typedef struct
{
  /* Call Management Functional Descriptor*/
  uint8_t           bLength;
  uint8_t           bDescriptorType;
  uint8_t           bDescriptorSubtype;
  uint8_t           bmCapabilities;
  uint8_t           bDataInterface;
} __PACKED USBD_CDCCallMgmFuncDescTypedef;

typedef struct
{
  /* ACM Functional Descriptor*/
  uint8_t           bLength;
  uint8_t           bDescriptorType;
  uint8_t           bDescriptorSubtype;
  uint8_t           bmCapabilities;
} __PACKED USBD_CDCACMFuncDescTypedef;

typedef struct
{
  /* Union Functional Descriptor*/
  uint8_t           bLength;
  uint8_t           bDescriptorType;
  uint8_t           bDescriptorSubtype;
  uint8_t           bMasterInterface;
  uint8_t           bSlaveInterface;
} __PACKED USBD_CDCUnionFuncDescTypedef;

#endif /* (USBD_CDC_ACM_CLASS_ACTIVATED == 1) || (USBD_CMPSIT_ACTIVATE_RNDIS == 1)  || (USBD_CDC_ECM_CLASS_ACTIVATED == 1)*/
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
  uint8_t           bLength;
  uint8_t           bDescriptorType;
  uint8_t           bmAttributes;
  uint16_t          wDetachTimeout;
  uint16_t          wTransferSze;
  uint16_t          bcdDFUVersion;
}__PACKED USBD_DFUFuncDescTypedef;
#endif /* USBD_DFU_CLASS_ACTIVATED */
[/#if]




[/#list]
[/#if]
[/#list]

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN Private_defines */

/* USER CODE END Private_defines */

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

uint8_t *USBD_Get_Device_Framework_Speed(uint8_t Speed, ULONG *Length);
uint8_t *USBD_Get_String_Framework(ULONG *Length);
uint8_t *USBD_Get_Language_Id_Framework(ULONG *Length);

[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
    [#assign value = define.value]
    [#assign name = define.name]
[#if name?contains("UX_DEVICE_HID") && value == "1"]
#if USBD_HID_CLASS_ACTIVATED == 1U
uint8_t *USBD_Get_Device_HID_MOUSE_ReportDesc(void);
#endif /* USBD_HID_CLASS_ACTIVATED == 1U */
[/#if]
[/#list]
[/#if]
[/#list]
/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN Private_defines */

/* USER CODE END Private_defines */

#define USBD_VID                                       ${usbd_vid_value}
#define USBD_PID                                       ${usbd_pid_value}
#define USBD_LANGID_STRING                             ${usbd_langid}
#define USBD_MANUFACTURER_STRING                       "${usbd_manufacturer_string}"
#define USBD_PRODUCT_STRING                            "${usbd_product_string}"
#define USBD_SERIAL_NUMBER                             "${serial_number}"

#define USB_DESC_TYPE_INTERFACE                        0x04U
#define USB_DESC_TYPE_ENDPOINT                         0x05U
#define USB_DESC_TYPE_CONFIGURATION                    0x02U
#define USB_DESC_TYPE_IAD                              0x0BU

#define USBD_EP_TYPE_CTRL                              0x00U
#define USBD_EP_TYPE_ISOC                              0x01U
#define USBD_EP_TYPE_BULK                              0x02U
#define USBD_EP_TYPE_INTR                              0x03U

#define USBD_FULL_SPEED                                0x00U
#define USBD_HIGH_SPEED                                0x01U

#define USB_BCDUSB                                     0x0200U
#define LANGUAGE_ID_MAX_LENGTH                         2U

#define USBD_IDX_MFC_STR                               0x01U
#define USBD_IDX_PRODUCT_STR                           0x02U
#define USBD_IDX_SERIAL_STR                            0x03U

#define USBD_MAX_EP0_SIZE                              64U
#define USBD_DEVICE_QUALIFIER_DESC_SIZE                0x0AU

#define USBD_STRING_FRAMEWORK_MAX_LENGTH               256U

[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
    [#assign value = define.value]
    [#assign name = define.name]
[#if name?contains("UX_DEVICE_STORAGE") && value == "1"]
/* Device Storage Class */
#define USBD_MSC_EPOUT_ADDR                            0x0${usbd_msc_ep_out_address}U
#define USBD_MSC_EPIN_ADDR                             0x8${usbd_msc_ep_in_address}U
#if (USBD_MSC_EPOUT_ADDR == (USBD_MSC_EPIN_ADDR & 0x0FU))
#error Address endpoint IN shall be different form endpoint OUT.
#endif
#define USBD_MSC_EPOUT_FS_MPS                          ${usbd_msc_ep_out_fs_mps}U
#define USBD_MSC_EPOUT_HS_MPS                          ${usbd_msc_ep_out_hs_mps}U
#define USBD_MSC_EPIN_FS_MPS                           ${usbd_msc_ep_in_fs_mps}U
#define USBD_MSC_EPIN_HS_MPS                           ${usbd_msc_ep_in_hs_mps}U
[/#if]

[#if name?contains("UX_DEVICE_HID") && value == "1"]
/* Device HID Class */
#define USBD_HID_EPIN_ADDR                            0x8${usbd_hid_ep_in_address}U
#define USBD_HID_EPIN_FS_MPS                          ${usbd_hid_ep_in_fs_mps}U
#define USBD_HID_EPIN_HS_MPS                          ${usbd_hid_ep_in_hs_mps}U
#define USBD_HID_EPIN_FS_BINTERVAL                    ${usbd_hid_ep_in_fs_bint}U
#define USBD_HID_EPIN_HS_BINTERVAL                    ${usbd_hid_ep_in_hs_bint}U
[/#if]

[#if name?contains("UX_DEVICE_CDC_ACM") && value == "1"]
/* Device CDC-ACM Class */
#define USBD_CDCACM_EPINCMD_ADDR                      0x8${usbd_cdc_ep_in_cmd_address}U
#define USBD_CDCACM_EPINCMD_FS_MPS                    ${usbd_cdc_ep_in_cmd_fs_mps}U
#define USBD_CDCACM_EPINCMD_HS_MPS                    ${usbd_cdc_ep_in_cmd_hs_mps}U
#define USBD_CDCACM_EPIN_ADDR                         0x8${usbd_cdc_ep_in_address}U
#define USBD_CDCACM_EPOUT_ADDR                        0x0${usbd_cdc_ep_out_address}U
#if (USBD_CDCACM_EPOUT_ADDR == (USBD_CDCACM_EPIN_ADDR & 0x0FU))
#error Address endpoint IN shall be different form endpoint OUT.
#endif
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
#define CDC_ECM_MAC_STR_DESC     (uint8_t *)"${usbd_cdcecm_mac_address}"

#define USBD_CDC_ECM_NX_PKPOOL_ENTRIES                ${usbd_cdcecm_nx_pkpool_entries}U
#define USBD_CDC_ECM_PACKET_POOL_WAIT                 ${usbd_cdcecm_packet_pool_wait}U

#define USBD_CDCECM_EPINCMD_ADDR                      0x8${usbd_cdcecm_ep_in_cmd_address}U
#define USBD_CDCECM_EPINCMD_FS_MPS                    ${usbd_cdcecm_ep_in_cmd_fs_mps}U
#define USBD_CDCECM_EPINCMD_HS_MPS                    ${usbd_cdcecm_ep_in_cmd_hs_mps}U
#define USBD_CDCECM_EPINCMD_FS_BINTERVAL              ${usbd_cdcecm_ep_in_cmd_fs_bint}U
#define USBD_CDCECM_EPINCMD_HS_BINTERVAL              ${usbd_cdcecm_ep_in_cmd_hs_bint}U
#define USBD_CDCECM_EPIN_ADDR                         0x8${usbd_cdcecm_ep_in_address}U
#define USBD_CDCECM_EPOUT_ADDR                        0x0${usbd_cdcecm_ep_out_address}U
#define USBD_CDCECM_EPIN_FS_MPS                       ${usbd_cdcecm_ep_in_fs_mps}U
#define USBD_CDCECM_EPIN_HS_MPS                       ${usbd_cdcecm_ep_in_hs_mps}U
#define USBD_CDCECM_EPOUT_FS_MPS                      ${usbd_cdcecm_ep_out_fs_mps}U
#define USBD_CDCECM_EPOUT_HS_MPS                      ${usbd_cdcecm_ep_out_hs_mps}U

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

[/#list]
[/#if]
[/#list]

[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
    [#assign value = define.value]
    [#assign name = define.name]
[#if name?contains("UX_DEVICE_HID") && value == "1"]
#define HID_DESCRIPTOR_TYPE                           0x21U
#define USBD_HID_DESC_SIZE                            9U
#define USBD_HID_MOUSE_REPORT_DESC_SIZE               74U
[/#if]
[/#list]
[/#if]
[/#list]

/* This is the maximum supported configuration descriptor size
   User may redefine this value in order to optima */
#ifndef USBD_FRAMEWORK_MAX_DESC_SZ
#define USBD_FRAMEWORK_MAX_DESC_SZ                    200U
#endif /* USBD_FRAMEWORK_MAX_DESC_SZ */

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
/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
