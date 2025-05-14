[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           ${name}
  * @author         MCD Application Team
[#--  * @packageVersion ${fwVersion} --]
  * @brief          This file implements the USB device descriptors.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign className = ""]
[#assign variable = ""]

[#assign useLPM = false]
[#list SWIPdatas as SWIP]
	[#compress]
		[#if SWIP.parameters??]
			[#list SWIP.parameters?keys as key] [#assign variable = variable +key] [/#list]
			[#if variable?contains("_MSC_")][#assign className = "MSC"][/#if]
			[#if variable?contains("_DFU_")][#assign className = "DFU"][/#if]
			[#if variable?contains("_HID_")][#assign className = "HID"][/#if]
			[#if variable?contains("_AUDIO_")][#assign className = "AUDIO"][/#if]
			[#if variable?contains("_CCID_")][#assign className = "CCID"][/#if]
			[#if variable?contains("_MTP_")][#assign className = "MTP"][/#if]
			[#if variable?contains("_CDC_")][#assign className = "CDC"][/#if]
			[#if variable?contains("_CUSTOMHID_")][#assign className = "CUSTOMHID"][/#if]
		[/#if]
	[/#compress]
[/#list]

/* Includes ------------------------------------------------------------------*/
#include "usbd_core.h"
#include "usbd_desc.h"
#include "usbd_conf.h"
[#assign HS = 0]
[#assign FS = 0]
[#assign instanceNb = 0]
[#assign CLASS_FS = ""]
[#assign CLASS_HS = ""]

/* USER CODE BEGIN INCLUDE */

/* USER CODE END INCLUDE */

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/

/* USER CODE BEGIN PV */
/* Private variables ---------------------------------------------------------*/

/* USER CODE END PV */


/** @addtogroup STM32_USB_OTG_DEVICE_LIBRARY
  * @{
  */


/** @addtogroup USBD_DESC
  * @{
  */


/** @defgroup USBD_DESC_Private_TypesDefinitions USBD_DESC_Private_TypesDefinitions
  * @brief Private types.
  * @{
  */

/* USER CODE BEGIN PRIVATE_TYPES */

/* USER CODE END PRIVATE_TYPES */

/**
  * @}
  */


/** @defgroup USBD_DESC_Private_Defines USBD_DESC_Private_Defines
  * @brief Private defines.
  * @{
  */

[#-- SWIPdatas is a list of SWIPconfigModel --]
[#list SWIPdatas as SWIP]
[#compress]
[#if SWIP.defines??]
	[#list SWIP.defines as definition]
	[#assign value = definition.value]
	[#assign paramName = definition.paramName]
	[#assign name = definition.name]

	[#if name == "PID_AUDIO_FS" || name == "PID_CCID_FS" || name == "PID_CDC_FS" || name == "PID_DFU_FS" || name == "PID_HID_FS" || name == "PID_CUSTOMHID_FS" || name == "PID_MSC_FS" || name == "PID_BILLBOARD_FS" || name == "PID_MTP_FS" ]
      [#assign FS = 1 ]
    [/#if]
	
	[#if name == "PID_AUDIO_HS" || name == "PID_CCID_HS" || name == "PID_CDC_HS" || name == "PID_DFU_HS" || name == "PID_HID_HS" || name == "PID_CUSTOMHID_HS" || name == "PID_MSC_HS" || name == "PID_BILLBOARD_HS" || name == "PID_MTP_HS" ]
      [#assign HS = 1 ]
    [/#if]
	
[#if cpucore=="ARM_CORTEX_M4"]
    [#if definition.paramName == "DEVICE_SERIAL0"]
#define DEVICE_SERIAL0 #t#t(*(uint32_t *) ${value})
    [/#if]
    [#if definition.paramName == "DEVICE_SERIAL1"]	
#define DEVICE_SERIAL1 #t#t(*(uint32_t *) ${value})
    [/#if]
    [#if definition.paramName == "DEVICE_SERIAL2"]	
#define DEVICE_SERIAL2 #t#t(*(uint32_t *) ${value})
    [/#if]
[/#if]

[#if !definition.paramName.contains("DEVICE_SERIAL")]
[#if definition.paramName == "CLASS_NAME_HS"]
	[#assign CLASS_HS = value]
[#elseif definition.paramName == "CLASS_NAME_FS"]
	[#assign CLASS_FS = value]
[#elseif  definition.type=="string"]
	[#assign instanceNb = instanceNb + 1]
#define USBD_${definition.paramName} #t#t"${value}"
[#elseif  definition.type=="stringRW"]
	[#assign instanceNb = instanceNb + 1]
#define USBD_${definition.paramName} #t#t"${value}"
[#else]
#define USBD_${definition.paramName} #t#t${value}
[/#if]
[/#if]
	[/#list]
[/#if]
[/#compress]
[/#list]

#n
#define USB_SIZ_BOS_DESC            0x0C

/* USER CODE BEGIN PRIVATE_DEFINES */

/* USER CODE END PRIVATE_DEFINES */

/**
  * @}
  */

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */


/** @defgroup USBD_DESC_Private_Macros USBD_DESC_Private_Macros
  * @brief Private macros.
  * @{
  */

/* USER CODE BEGIN PRIVATE_MACRO */

/* USER CODE END PRIVATE_MACRO */

/**
  * @}
  */
  
/** @defgroup USBD_DESC_Private_FunctionPrototypes USBD_DESC_Private_FunctionPrototypes
  * @brief Private functions declaration.
  * @{
  */
  
static void Get_SerialNum(void);
static void IntToUnicode(uint32_t value, uint8_t * pbuf, uint8_t len);
  
/**
  * @}
  */  
  
[#if FS == 1]

/** @defgroup USBD_DESC_Private_FunctionPrototypes USBD_DESC_Private_FunctionPrototypes
  * @brief Private functions declaration.
  * @{
  */

uint8_t * USBD_${className}_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length);
uint8_t * USBD_${className}_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length);
uint8_t * USBD_${className}_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length);
uint8_t * USBD_${className}_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length);
uint8_t * USBD_${className}_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length);
uint8_t * USBD_${className}_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length);
uint8_t * USBD_${className}_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length);
[#-- Ticket 66338 
#ifdef USBD_SUPPORT_USER_STRING_DESC
uint8_t * USBD_${className}_USRStringDesc(USBD_SpeedTypeDef speed, uint8_t idx, uint16_t *length);
#endif /* USBD_SUPPORT_USER_STRING_DESC */
[--]
#if (USBD_LPM_ENABLED == 1)
uint8_t * USBD_${className}_USR_BOSDescriptor(USBD_SpeedTypeDef speed, uint16_t *length);
#endif /* (USBD_LPM_ENABLED == 1) */

/**
  * @}
  */


/** @defgroup USBD_DESC_Private_Variables USBD_DESC_Private_Variables
  * @brief Private variables.
  * @{
  */

USBD_DescriptorsTypeDef ${className}_Desc =
{
  USBD_${className}_DeviceDescriptor,
  USBD_${className}_LangIDStrDescriptor,
  USBD_${className}_ManufacturerStrDescriptor,
  USBD_${className}_ProductStrDescriptor,
  USBD_${className}_SerialStrDescriptor,
  USBD_${className}_ConfigStrDescriptor,
  USBD_${className}_InterfaceStrDescriptor
[#if family?contains("STM32F7") || family?contains("STM32F4") || family?contains("STM32L4") ]
#if (USBD_LPM_ENABLED == 1)
 ,USBD_${className}_USR_BOSDescriptor
#endif /* (USBD_LPM_ENABLED == 1) */
[/#if]
};

#if defined ( __ICCARM__ ) /* IAR Compiler */
  #pragma data_alignment=4
#endif /* defined ( __ICCARM__ ) */
/** USB standard device descriptor. */
__ALIGN_BEGIN uint8_t USBD_${className}_DeviceDesc[USB_LEN_DEV_DESC] __ALIGN_END =
{
  0x12,                       /*bLength */
  USB_DESC_TYPE_DEVICE,       /*bDescriptorType*/
[#if family?contains("STM32F7") || family?contains("STM32F4") || family?contains("STM32L4") ]
#if (USBD_LPM_ENABLED == 1)
  0x01,                       /*bcdUSB */ /* changed to USB version 2.01
                                             in order to support LPM L1 suspend
                                             resume test of USBCV3.0*/
#else
  0x00,                       /*bcdUSB */
#endif /* (USBD_LPM_ENABLED == 1) */
[#else]
  0x00,                       /*bcdUSB */
[/#if]
  0x02,
[#if CLASS_FS == "CDC"]
  0x02,                       /*bDeviceClass*/
  0x02,                       /*bDeviceSubClass*/
[#else]
  0x00,                       /*bDeviceClass*/
  0x00,                       /*bDeviceSubClass*/
[/#if]
  0x00,                       /*bDeviceProtocol*/
  USB_MAX_EP0_SIZE,           /*bMaxPacketSize*/
  LOBYTE(USBD_VID),           /*idVendor*/
  HIBYTE(USBD_VID),           /*idVendor*/
  LOBYTE(USBD_PID),           /*idProduct*/
  HIBYTE(USBD_PID),           /*idProduct*/
  0x00,                       /*bcdDevice rel. 2.00*/
  0x02,
  USBD_IDX_MFC_STR,           /*Index of manufacturer  string*/
  USBD_IDX_PRODUCT_STR,       /*Index of product string*/
  USBD_IDX_SERIAL_STR,        /*Index of serial number string*/
  USBD_MAX_NUM_CONFIGURATION  /*bNumConfigurations*/
};

[#if family?contains("STM32F7") || family?contains("STM32F4") || family?contains("STM32L4") ]
/** BOS descriptor. */
#if (USBD_LPM_ENABLED == 1)
#if defined ( __ICCARM__ ) /* IAR Compiler */
  #pragma data_alignment=4
#endif /* defined ( __ICCARM__ ) */
__ALIGN_BEGIN uint8_t USBD_${className}_BOSDesc[USB_SIZ_BOS_DESC] __ALIGN_END =
{
  0x5,
  USB_DESC_TYPE_BOS,
  0xC,
  0x0,
  0x1,  /* 1 device capability*/
        /* device capability*/
  0x7,
  USB_DEVICE_CAPABITY_TYPE,
  0x2,
  0x2,  /* LPM capability bit set*/
  0x0,
  0x0,
  0x0
};
#endif /* (USBD_LPM_ENABLED == 1) */
[/#if]

/**
  * @}
  */
[/#if]


[#if HS == 1]
/** @defgroup USBD_DESC_Private_FunctionPrototypes USBD_DESC_Private_FunctionPrototypes
  * @brief Private functions declaration.
  * @{
  */

uint8_t * USBD_${className}_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length);
uint8_t * USBD_${className}_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length);
uint8_t * USBD_${className}_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length);
uint8_t * USBD_${className}_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length);
uint8_t * USBD_${className}_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length);
uint8_t * USBD_${className}_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length);
uint8_t * USBD_${className}_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length);
[#-- Ticket 66338 
#ifdef USBD_SUPPORT_USER_STRING_DESC
uint8_t * USBD_${className}_USRStringDesc(USBD_SpeedTypeDef speed, uint8_t idx, uint16_t *length);
#endif /* USBD_SUPPORT_USER_STRING_DESC */
[--]

#if (USBD_LPM_ENABLED == 1)
uint8_t * USBD_${className}_USR_BOSDescriptor(USBD_SpeedTypeDef speed, uint16_t *length);
#endif /* (USBD_LPM_ENABLED == 1) */

/**
  * @}
  */


/** @defgroup USBD_DESC_Private_Variables USBD_DESC_Private_Variables
  * @brief Private variables.
  * @{
  */

USBD_DescriptorsTypeDef ${className}_Desc =
{
  USBD_${className}_DeviceDescriptor,
  USBD_${className}_LangIDStrDescriptor,
  USBD_${className}_ManufacturerStrDescriptor,
  USBD_${className}_ProductStrDescriptor,
  USBD_${className}_SerialStrDescriptor,
  USBD_${className}_ConfigStrDescriptor,
  USBD_${className}_InterfaceStrDescriptor
[#if family?contains("STM32F7") || family?contains("STM32F4") || family?contains("STM32L4") ]
#if (USBD_LPM_ENABLED == 1)
 , USBD_${className}_USR_BOSDescriptor
#endif /* (USBD_LPM_ENABLED == 1) */
[/#if]
};

#if defined ( __ICCARM__ ) /* IAR Compiler */
  #pragma data_alignment=4
#endif /* defined ( __ICCARM__ ) */
/** USB standard device descriptor. */
__ALIGN_BEGIN uint8_t USBD_${className}_DeviceDesc[USB_LEN_DEV_DESC] __ALIGN_END =
{
  0x12,                       /*bLength */
  USB_DESC_TYPE_DEVICE,       /*bDescriptorType*/
[#if family?contains("STM32F7") || family?contains("STM32F4")  || family?contains("STM32L4") ]
#if (USBD_LPM_ENABLED == 1)
  0x01,                       /*bcdUSB */ /* changed to USB version 2.01
                                             in order to support LPM L1 suspend
                                             resume test of USBCV3.0*/
#else
  0x00,                       /*bcdUSB */
#endif /* (USBD_LPM_ENABLED == 1) */
[#else]
  0x00,                       /*bcdUSB */
[/#if]

  0x02,
[#if CLASS_HS == "CDC"]
  0x02,                       /*bDeviceClass*/
  0x02,                       /*bDeviceSubClass*/
[#else]
  0x00,                       /*bDeviceClass*/
  0x00,                       /*bDeviceSubClass*/
[/#if]
  0x00,                       /*bDeviceProtocol*/
  USB_MAX_EP0_SIZE,           /*bMaxPacketSize*/
  LOBYTE(USBD_VID),           /*idVendor*/
  HIBYTE(USBD_VID),           /*idVendor*/
  LOBYTE(USBD_PID),        /*idProduct*/
  HIBYTE(USBD_PID),        /*idProduct*/
  0x00,                       /*bcdDevice rel. 2.00*/
  0x02,
  USBD_IDX_MFC_STR,           /*Index of manufacturer  string*/
  USBD_IDX_PRODUCT_STR,       /*Index of product string*/
  USBD_IDX_SERIAL_STR,        /*Index of serial number string*/
  USBD_MAX_NUM_CONFIGURATION  /*bNumConfigurations*/
};

/** BOS descriptor. */
#if (USBD_LPM_ENABLED == 1)
#if defined ( __ICCARM__ ) /* IAR Compiler */
  #pragma data_alignment=4
#endif /* defined ( __ICCARM__ ) */
__ALIGN_BEGIN uint8_t USBD_${className}_BOSDesc[USB_SIZ_BOS_DESC] __ALIGN_END =
{
  0x5,
  USB_DESC_TYPE_BOS,
  0xC,
  0x0,
  0x1,  /* 1 device capability */
        /* device capability */
  0x7,
  USB_DEVICE_CAPABITY_TYPE,
  0x2,
  0x2,  /*LPM capability bit set */
  0x0,
  0x0,
  0x0
};
#endif /* (USBD_LPM_ENABLED == 1) */

/**
  * @}
  */


[/#if]

/** @defgroup USBD_DESC_Private_Variables USBD_DESC_Private_Variables
  * @brief Private variables.
  * @{
  */

#if defined ( __ICCARM__ ) /* IAR Compiler */
  #pragma data_alignment=4
#endif /* defined ( __ICCARM__ ) */

/** USB lang identifier descriptor. */
__ALIGN_BEGIN uint8_t USBD_LangIDDesc[USB_LEN_LANGID_STR_DESC] __ALIGN_END =
{
     USB_LEN_LANGID_STR_DESC,
     USB_DESC_TYPE_STRING,
     LOBYTE(USBD_LANGID_STRING),
     HIBYTE(USBD_LANGID_STRING)
};

#if defined ( __ICCARM__ ) /* IAR Compiler */
  #pragma data_alignment=4
#endif /* defined ( __ICCARM__ ) */
/* Internal string descriptor. */
__ALIGN_BEGIN uint8_t USBD_StrDesc[USBD_MAX_STR_DESC_SIZ] __ALIGN_END;

#if defined ( __ICCARM__ ) /*!< IAR Compiler */
  #pragma data_alignment=4   
#endif
__ALIGN_BEGIN uint8_t USBD_StringSerial[USB_SIZ_STRING_SERIAL] __ALIGN_END = {
  USB_SIZ_STRING_SERIAL,
  USB_DESC_TYPE_STRING,
};

/**
  * @}
  */


/** @defgroup USBD_DESC_Private_Functions USBD_DESC_Private_Functions
  * @brief Private functions.
  * @{
  */

[#if HS == 1]
/**
  * @brief  Return the device descriptor
  * @param  speed : Current device speed
  * @param  length : Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
uint8_t * USBD_${className}_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_${className}_DeviceDesc);
  return USBD_${className}_DeviceDesc;
}

/**
  * @brief  Return the LangID string descriptor
  * @param  speed : Current device speed
  * @param  length : Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
uint8_t * USBD_${className}_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);
  return USBD_LangIDDesc;
}

/**
  * @brief  Return the product string descriptor
  * @param  speed : Current device speed
  * @param  length : Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
uint8_t * USBD_${className}_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  USBD_GetString((uint8_t *)USBD_PRODUCT_STRING, USBD_StrDesc, length);
  return USBD_StrDesc;
}

/**
  * @brief  Return the manufacturer string descriptor
  * @param  speed : Current device speed
  * @param  length : Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
uint8_t * USBD_${className}_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  USBD_GetString((uint8_t *)USBD_MANUFACTURER_STRING, USBD_StrDesc, length);
  return USBD_StrDesc;
}

/**
  * @brief  Return the serial number string descriptor
  * @param  speed : Current device speed
  * @param  length : Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
uint8_t * USBD_${className}_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = USB_SIZ_STRING_SERIAL;

  /* Update the serial number string descriptor with the data from the unique
   * ID */
  Get_SerialNum();
  /* USER CODE BEGIN USBD_${className}_SerialStrDescriptor */
  
  /* USER CODE END USBD_${className}_SerialStrDescriptor */

  return (uint8_t *) USBD_StringSerial;
}

/**
  * @brief  Return the configuration string descriptor
  * @param  speed : Current device speed
  * @param  length : Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
uint8_t * USBD_${className}_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  USBD_GetString((uint8_t *)USBD_CONFIGURATION_STRING, USBD_StrDesc, length);
  return USBD_StrDesc;
}

/**
  * @brief  Return the interface string descriptor
  * @param  speed : Current device speed
  * @param  length : Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
uint8_t * USBD_${className}_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  USBD_GetString((uint8_t *)USBD_INTERFACE_STRING, USBD_StrDesc, length);
  return USBD_StrDesc;
}

#if (USBD_LPM_ENABLED == 1)
/**
  * @brief  Return the BOS descriptor
  * @param  speed : Current device speed
  * @param  length : Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
uint8_t * USBD_${className}_USR_BOSDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_${className}_BOSDesc);
  return (uint8_t*)USBD_${className}_BOSDesc;
}
#endif /* (USBD_LPM_ENABLED == 1) */
[/#if]


[#if FS == 1]
/**
  * @brief  Return the device descriptor
  * @param  speed : Current device speed
  * @param  length : Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
uint8_t * USBD_${className}_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_${className}_DeviceDesc);
  return USBD_${className}_DeviceDesc;
}

/**
  * @brief  Return the LangID string descriptor
  * @param  speed : Current device speed
  * @param  length : Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
uint8_t * USBD_${className}_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);
  return USBD_LangIDDesc;
}

/**
  * @brief  Return the product string descriptor
  * @param  speed : Current device speed
  * @param  length : Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
uint8_t * USBD_${className}_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  USBD_GetString((uint8_t *)USBD_PRODUCT_STRING, USBD_StrDesc, length);
  return USBD_StrDesc;
}

/**
  * @brief  Return the manufacturer string descriptor
  * @param  speed : Current device speed
  * @param  length : Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
uint8_t * USBD_${className}_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  USBD_GetString((uint8_t *)USBD_MANUFACTURER_STRING, USBD_StrDesc, length);
  return USBD_StrDesc;
}

/**
  * @brief  Return the serial number string descriptor
  * @param  speed : Current device speed
  * @param  length : Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
uint8_t * USBD_${className}_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = USB_SIZ_STRING_SERIAL;

  /* Update the serial number string descriptor with the data from the unique
   * ID */
  Get_SerialNum();
  /* USER CODE BEGIN USBD_${className}_SerialStrDescriptor */
  
  /* USER CODE END USBD_${className}_SerialStrDescriptor */
  
  return (uint8_t *) USBD_StringSerial;
}

/**
  * @brief  Return the configuration string descriptor
  * @param  speed : Current device speed
  * @param  length : Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
uint8_t * USBD_${className}_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  USBD_GetString((uint8_t *)USBD_CONFIGURATION_STRING, USBD_StrDesc, length);
  return USBD_StrDesc;
}

/**
  * @brief  Return the interface string descriptor
  * @param  speed : Current device speed
  * @param  length : Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
uint8_t * USBD_${className}_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  USBD_GetString((uint8_t *)USBD_INTERFACE_STRING, USBD_StrDesc, length);
  return USBD_StrDesc;
}

#if (USBD_LPM_ENABLED == 1)
/**
  * @brief  Return the BOS descriptor
  * @param  speed : Current device speed
  * @param  length : Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
uint8_t * USBD_${className}_USR_BOSDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_${className}_DeviceDesc);
  return (uint8_t*)USBD_${className}_DeviceDesc;
}
#endif /* (USBD_LPM_ENABLED == 1) */
[/#if]

/**
  * @brief  Create the serial number string descriptor 
  * @param  None 
  * @retval None
  */
static void Get_SerialNum(void)
{
  uint32_t deviceserial0;
  uint32_t deviceserial1; 
  uint32_t deviceserial2;

[#if cpucore=="ARM_CORTEX_M4" && (CLASS_FS=="CDC" | CLASS_HS=="CDC")]
/* USER CODE BEGIN SerialNum */

  deviceserial0 = DEVICE_SERIAL0;
  deviceserial1 = DEVICE_SERIAL1;
  deviceserial2 = DEVICE_SERIAL2;

/* USER CODE END SerialNum */
[#elseif cpucore=="ARM_CORTEX_M7" | CLASS_FS!="CDC" | CLASS_HS!="CDC"]
  deviceserial0 = *(uint32_t *) DEVICE_ID1;
  deviceserial1 = *(uint32_t *) DEVICE_ID2;
  deviceserial2 = *(uint32_t *) DEVICE_ID3;
[/#if]

  deviceserial0 += deviceserial2;

  if (deviceserial0 != 0)
  {
    IntToUnicode(deviceserial0, &USBD_StringSerial[2], 8);
    IntToUnicode(deviceserial1, &USBD_StringSerial[18], 4);
  }
}

/**
  * @brief  Convert Hex 32Bits value into char 
  * @param  value: value to convert
  * @param  pbuf: pointer to the buffer 
  * @param  len: buffer length
  * @retval None
  */
static void IntToUnicode(uint32_t value, uint8_t * pbuf, uint8_t len)
{
  uint8_t idx = 0;

  for (idx = 0; idx < len; idx++)
  {
    if (((value >> 28)) < 0xA)
    {
      pbuf[2 * idx] = (value >> 28) + '0';
    }
    else
    {
      pbuf[2 * idx] = (value >> 28) + 'A' - 10;
    }

    value = value << 4;

    pbuf[2 * idx + 1] = 0;
  }
}
/**
  * @}
  */


/**
  * @}
  */


/**
  * @}
  */

