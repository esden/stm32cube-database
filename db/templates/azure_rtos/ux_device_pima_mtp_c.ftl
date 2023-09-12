[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ux_device_pima_mtp.c
  * @author  MCD Application Team
  * @brief   USBX Device PIMA MTP applicative source file
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2022 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "ux_device_pima_mtp.h"
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
    [#if name == "REG_UX_DEVICE_PIMA_MTP"]
      [#assign REG_UX_DEVICE_PIMA_MTP_value = value]
    [/#if]
   [/#list]
[/#if]
[/#list]
[/#compress]

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
[#if REG_UX_DEVICE_PIMA_MTP_value == "1"]

/* Define PIMA supported device properties */
USHORT USBD_MTP_DevicePropSupported[] = {
  /* USER CODE BEGIN USBD_MTP_DevicePropSupported */

  /* USER CODE END USBD_MTP_DevicePropSupported */
  0
};

/* Define PIMA supported capture formats */
USHORT USBD_MTP_DeviceSupportedCaptureFormats[] = {
  /* USER CODE BEGIN USBD_MTP_DeviceSupportedCaptureFormats */

  /* USER CODE END USBD_MTP_DeviceSupportedCaptureFormats */
  0
};

/* Define PIMA supported image formats */
USHORT USBD_MTP_DeviceSupportedImageFormats[] = {
  /* USER CODE BEGIN USBD_MTP_DeviceSupportedImageFormats */

  /* USER CODE END USBD_MTP_DeviceSupportedImageFormats */
  0
};

/* Object property supported
   WORD 0    : Object Format Code
   WORD 1    : Number of Prop codes for this Object format
   WORD n    : Prop Codes
   WORD n+2  : Next Object Format code ....
*/
USHORT USBD_MTP_ObjectPropSupported[] = {
  /* USER CODE BEGIN USBD_MTP_ObjectPropSupported */

  /* USER CODE END USBD_MTP_ObjectPropSupported */
  0
};

[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

[#if REG_UX_DEVICE_PIMA_MTP_value == "1"]
/**
  * @brief  USBD_PIMA_MTP_Activate
  *         This function is called when insertion of a PIMA MTP device.
  * @param  pima_instance: Pointer to the pima class instance.
  * @retval none
  */
VOID USBD_PIMA_MTP_Activate(VOID *pima_instance)
{
  /* USER CODE BEGIN USBD_PIMA_MTP_Activate */
  UX_PARAMETER_NOT_USED(pima_instance);
  /* USER CODE END USBD_PIMA_MTP_Activate */

  return;
}

/**
  * @brief  USBD_PIMA_MTP_Deactivate
  *         This function is called when extraction of a PIMA MTP device.
  * @param  pima_instance: Pointer to the pima class instance.
  * @retval none
  */
VOID USBD_PIMA_MTP_Deactivate(VOID *pima_instance)
{
  /* USER CODE BEGIN USBD_PIMA_MTP_Deactivate */
  UX_PARAMETER_NOT_USED(pima_instance);
  /* USER CODE END USBD_PIMA_MTP_Deactivate */

  return;
}

/**
  * @brief  USBD_MTP_Cancel
  *         This function is invoked when host requested to cancel operation.
  * @param  pima_instance: Pointer to the pima class instance.
  * @retval status
  */
UINT USBD_MTP_Cancel(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_MTP_Cancel */
  UX_PARAMETER_NOT_USED(pima_instance);
  /* USER CODE END USBD_MTP_Cancel */

  return status;
}

/**
  * @brief  USBD_MTP_DeviceReset
  *         This function is invoked when host requested to reset device.
  * @param  pima_instance: Pointer to the pima class instance.
  * @retval status
  */
UINT USBD_MTP_DeviceReset(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_MTP_DeviceReset */
  UX_PARAMETER_NOT_USED(pima_instance);
  /* USER CODE END USBD_MTP_DeviceReset */

  return status;
}

/**
  * @brief  USBD_MTP_GetDevicePropDesc
  *         This function is invoked when host requested to get device prop.
  * @param  pima_instance: Pointer to the pima class instance.
  * @param  device_property: device property code.
  * @param  device_prop_dataset: device property value.
  * @param  device_prop_dataset_length: device property value length.
  * @retval status
  */
UINT USBD_MTP_GetDevicePropDesc(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance,
                                ULONG device_property,
                                UCHAR **device_prop_dataset,
                                ULONG *device_prop_dataset_length)

{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_MTP_GetDevicePropDesc */
  UX_PARAMETER_NOT_USED(pima_instance);
  UX_PARAMETER_NOT_USED(device_property);
  UX_PARAMETER_NOT_USED(device_prop_dataset);
  UX_PARAMETER_NOT_USED(device_prop_dataset_length);
  /* USER CODE END USBD_MTP_GetDevicePropDesc */

  return status;
}

/**
  * @brief  USBD_MTP_GetDevicePropValue
  *         This function is invoked when host requested to get device
  *         prop value.
  * @param  pima_instance: Pointer to the pima class instance.
  * @param  device_property: device property code.
  * @param  device_prop_value: device property value.
  * @param  device_prop_value_length: device property value length.
  * @retval status
  */
UINT USBD_MTP_GetDevicePropValue(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance,
                                 ULONG device_property,
                                 UCHAR **device_prop_value,
                                 ULONG *device_prop_value_length)

{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_MTP_GetDevicePropValue */
  UX_PARAMETER_NOT_USED(pima_instance);
  UX_PARAMETER_NOT_USED(device_property);
  UX_PARAMETER_NOT_USED(device_prop_value);
  UX_PARAMETER_NOT_USED(device_prop_value_length);
  /* USER CODE END USBD_MTP_GetDevicePropValue */

  return status;
}

/**
  * @brief  USBD_MTP_SetDevicePropValue
  *         This function is invoked when host requested to set device
  *         prop value.
  * @param  pima_instance: Pointer to the pima class instance.
  * @param  device_property: device property code.
  * @param  device_prop_value: device property value.
  * @param  device_prop_value_length: device property value length.
  * @retval status
  */
UINT USBD_MTP_SetDevicePropValue(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance,
                                 ULONG device_property,
                                 UCHAR *device_prop_value,
                                 ULONG device_prop_value_length)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_MTP_SetDevicePropValue */
  UX_PARAMETER_NOT_USED(pima_instance);
  UX_PARAMETER_NOT_USED(device_property);
  UX_PARAMETER_NOT_USED(device_prop_value);
  UX_PARAMETER_NOT_USED(device_prop_value_length);
  /* USER CODE END USBD_MTP_SetDevicePropValue */

  return status;
}

/**
  * @brief  USBD_MTP_FormatStorage
  *         This function is invoked when host requested to format storage
  *         media.
  * @param  pima_instance: Pointer to the pima class instance.
  * @param  storage_id: Storage id.
  * @retval status
  */
UINT USBD_MTP_FormatStorage(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance,
                            ULONG storage_id)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_MTP_FormatStorage */
  UX_PARAMETER_NOT_USED(pima_instance);
  UX_PARAMETER_NOT_USED(storage_id);
  /* USER CODE END USBD_MTP_FormatStorage */

  return status;
}

/**
  * @brief  USBD_MTP_GetStorageInfo
  *         This function is invoked when host requested to get storage
  *         media information.
  * @param  pima_instance: Pointer to the pima class instance.
  * @param  storage_id: Storage id.
  * @retval status
  */
UINT USBD_MTP_GetStorageInfo(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance,
                             ULONG storage_id)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_MTP_GetStorageInfo */
  UX_PARAMETER_NOT_USED(pima_instance);
  UX_PARAMETER_NOT_USED(storage_id);
  /* USER CODE END USBD_MTP_GetStorageInfo */

  return status;
}

/**
  * @brief  MTP_Get_ObjectNumber
  *         This function is invoked when host requested to get object
  *         number.
  * @param  pima_instance: pima instance
  * @param  object_format_code: Object format
  * @param  object_association: Object association
  * @param  object_number: Object number
  * @retval status
  */
UINT USBD_MTP_GetObjectNumber(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance,
                              ULONG object_format_code,
                              ULONG object_association,
                              ULONG *object_number)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN MTP_Get_ObjectNumber */
  UX_PARAMETER_NOT_USED(pima_instance);
  UX_PARAMETER_NOT_USED(object_format_code);
  UX_PARAMETER_NOT_USED(object_association);
  UX_PARAMETER_NOT_USED(object_number);
  /* USER CODE END MTP_Get_ObjectNumber */

  return status;
}

/**
  * @brief  USBD_MTP_GetObjectHandles
  *         This function is invoked when host requested to get object
  *         handles.
  * @param  pima_instance: Pointer to the pima class instance.
  * @param  object_handles_format_code: Format code for the handles.
  * @param  object_handles_association: Object association code.
  * @param  object_handles_array: Address where to store the handles.
  * @param  object_handles_max_number: Maximum number of handles in the array.
  * @retval status
  */
UINT USBD_MTP_GetObjectHandles(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance,
                               ULONG object_handles_format_code,
                               ULONG object_handles_association,
                               ULONG *object_handles_array,
                               ULONG object_handles_max_number)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_MTP_GetObjectHandles */
  UX_PARAMETER_NOT_USED(pima_instance);
  UX_PARAMETER_NOT_USED(object_handles_format_code);
  UX_PARAMETER_NOT_USED(object_handles_association);
  UX_PARAMETER_NOT_USED(object_handles_array);
  UX_PARAMETER_NOT_USED(object_handles_max_number);
  /* USER CODE END USBD_MTP_GetObjectHandles */

  return status;
}

/**
  * @brief  USBD_MTP_GetObjectInfo
  *         This function is invoked when host requested to get object
  *         information.
  * @param  pima_instance: Pointer to the pima class instance.
  * @param  object_handle: Handle of the object (object index).
  * @param  object: Object pointer address
  * @retval status
  */
UINT USBD_MTP_GetObjectInfo(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance,
                            ULONG object_handle,
                            UX_SLAVE_CLASS_PIMA_OBJECT **object)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_MTP_GetObjectInfo */
  UX_PARAMETER_NOT_USED(pima_instance);
  UX_PARAMETER_NOT_USED(object_handle);
  UX_PARAMETER_NOT_USED(object);
  /* USER CODE END USBD_MTP_GetObjectInfo */

  return status;
}

/**
  * @brief  USBD_MTP_GetObjectData
  *         This function is invoked when host requested to get object data.
  * @param  pima_instance: Pointer to the pima class instance.
  * @param  object_handle: Handle of the object (object index).
  * @param  object_buffer: Object buffer address
  * @param  object_length_requested: Object data length requested by
  *                                  the client to the application.
  * @param  object_actual_length: Object data length returned by the application.
  * @retval status
  */
UINT USBD_MTP_GetObjectData(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance,
                            ULONG object_handle,
                            UCHAR *object_buffer,
                            ULONG object_offset,
                            ULONG object_length_requested,
                            ULONG *object_actual_length)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_MTP_GetObjectData */
  UX_PARAMETER_NOT_USED(pima_instance);
  UX_PARAMETER_NOT_USED(object_handle);
  UX_PARAMETER_NOT_USED(object_buffer);
  UX_PARAMETER_NOT_USED(object_offset);
  UX_PARAMETER_NOT_USED(object_length_requested);
  UX_PARAMETER_NOT_USED(object_actual_length);
  /* USER CODE END USBD_MTP_GetObjectData */

  return status;
}

/**
  * @brief  USBD_MTP_SendObjectInfo
  *         This function is called when the PIMA class needs to receive
  *         the object information in the local system for future storage.
  * @param  pima_instance: Pointer to the pima class instance.
  * @param  object: Pointer to the object.
  * @param  storage_id: Storage id.
  * @param  parent_object_handle: parent object handle.
  * @param  object_handle: Handle of the object.
  * @retval status
  */
UINT USBD_MTP_SendObjectInfo(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance,
                             UX_SLAVE_CLASS_PIMA_OBJECT *object,
                             ULONG storage_id, ULONG parent_object_handle,
                             ULONG *object_handle)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_MTP_SendObjectInfo */
  UX_PARAMETER_NOT_USED(pima_instance);
  UX_PARAMETER_NOT_USED(object);
  UX_PARAMETER_NOT_USED(storage_id);
  UX_PARAMETER_NOT_USED(parent_object_handle);
  UX_PARAMETER_NOT_USED(object_handle);
  /* USER CODE END USBD_MTP_SendObjectInfo */

  return status;
}

/**
  * @brief  USBD_MTP_SendObjectData
  *         This function is called when the PIMA class needs to receive
  *         the object data in the local system for storage.
  * @param  pima_instance: Pointer to the pima class instance.
  * @param  object_handle: Handle of the object.
  * @param  phase: phase of the transfer (active or complete).
  * @param  object_buffer: Object buffer address.
  * @param  object_offset: Address of data.
  * @param  object_length: Object data length sent by application.
  * @retval status
  */
UINT USBD_MTP_SendObjectData(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance,
                             ULONG object_handle, ULONG phase,
                             UCHAR *object_buffer, ULONG object_offset,
                             ULONG object_length)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_MTP_SendObjectData */
  UX_PARAMETER_NOT_USED(pima_instance);
  UX_PARAMETER_NOT_USED(object_handle);
  UX_PARAMETER_NOT_USED(phase);
  UX_PARAMETER_NOT_USED(object_buffer);
  UX_PARAMETER_NOT_USED(object_offset);
  UX_PARAMETER_NOT_USED(object_length);
  /* USER CODE END USBD_MTP_SendObjectData */

  return status;
}

/**
  * @brief  USBD_MTP_DeleteObject
  *         This function is called when the PIMA class needs to delete
  *         an object on the local storage.
  * @param  pima_instance: Pointer to the pima class instance.
  * @param  object_handle: Handle of the object.
  * @retval status
  */
UINT USBD_MTP_DeleteObject(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance,
                           ULONG object_handle)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_MTP_DeleteObject */
  UX_PARAMETER_NOT_USED(pima_instance);
  UX_PARAMETER_NOT_USED(object_handle);
  /* USER CODE END USBD_MTP_DeleteObject */

  return status;
}

/**
  * @brief  USBD_MTP_GetObjectPropDesc
  *         This function is invoked when host requested to get object
  *         prop desc.
  * @param  pima_instance: Pointer to the pima class instance.
  * @param  object_property: object property.
  * @param  object_format_code: object format code.
  * @param  object_prop_dataset: object property dataset.
  * @param  object_prop_dataset_length: object property dataset length.
  * @retval status
  */
UINT USBD_MTP_GetObjectPropDesc(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance,
                                ULONG object_property,
                                ULONG object_format_code,
                                UCHAR **object_prop_dataset,
                                ULONG *object_prop_dataset_length)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_MTP_GetObjectPropDesc */
  UX_PARAMETER_NOT_USED(pima_instance);
  UX_PARAMETER_NOT_USED(object_property);
  UX_PARAMETER_NOT_USED(object_format_code);
  UX_PARAMETER_NOT_USED(object_prop_dataset);
  UX_PARAMETER_NOT_USED(object_prop_dataset_length);
  /* USER CODE END USBD_MTP_GetObjectPropDesc */

  return status;
}

/**
  * @brief  USBD_MTP_GetObjectPropValue
  *         This function is invoked when host requested to get object
  *         prop value.
  * @param  pima_instance : Pointer to the pima class instance.
  * @param  object_handle: Handle of the object.
  * @param  object_prop_code: Object property code.
  * @param  object_prop_value: Object property value.
  * @param  object_prop_value_length: Object property value length.
  * @retval status
  */
UINT USBD_MTP_GetObjectPropValue(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance,
                                 ULONG object_handle,
                                 ULONG object_prop_code,
                                 UCHAR **object_prop_value,
                                 ULONG *object_prop_value_length)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_MTP_GetObjectPropValue */
  UX_PARAMETER_NOT_USED(pima_instance);
  UX_PARAMETER_NOT_USED(object_handle);
  UX_PARAMETER_NOT_USED(object_prop_code);
  UX_PARAMETER_NOT_USED(object_prop_value);
  UX_PARAMETER_NOT_USED(object_prop_value_length);
  /* USER CODE END USBD_MTP_GetObjectPropValue */

  return status;
}

/**
  * @brief  USBD_MTP_SetObjectPropValue
  *         This function is invoked when host requested to set object
  *         prop value.
  * @param  pima_instance : Pointer to the pima class instance.
  * @param  object_handle : Handle of the object.
  * @param  object_prop_code : Object property code.
  * @param  object_prop_value: Object property value.
  * @param  object_prop_value_length: Object property value length.
  * @retval status
  */
UINT USBD_MTP_SetObjectPropValue(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance,
                                 ULONG object_handle,
                                 ULONG object_prop_code,
                                 UCHAR *object_prop_value,
                                 ULONG object_prop_value_length)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_MTP_SetObjectPropValue */
  UX_PARAMETER_NOT_USED(pima_instance);
  UX_PARAMETER_NOT_USED(object_handle);
  UX_PARAMETER_NOT_USED(object_prop_code);
  UX_PARAMETER_NOT_USED(object_prop_value);
  UX_PARAMETER_NOT_USED(object_prop_value_length);
  /* USER CODE END USBD_MTP_SetObjectPropValue */

  return status;
}

/**
  * @brief  USBD_MTP_GetObjectReferences
  *         This function is invoked when host requested to get object
  *         references.
  * @param  pima_instance : Pointer to the pima class instance.
  * @param  object_handle : Handle of the object.
  * @param  object_handle_array: object handle array.
  * @param  object_handle_array_length: length of object handle array.
  * @retval status
  */
UINT USBD_MTP_GetObjectReferences(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance,
                                  ULONG object_handle,
                                  UCHAR **object_handle_array,
                                  ULONG *object_handle_array_length)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_MTP_GetObjectReferences */
  UX_PARAMETER_NOT_USED(pima_instance);
  UX_PARAMETER_NOT_USED(object_handle);
  UX_PARAMETER_NOT_USED(object_handle_array);
  UX_PARAMETER_NOT_USED(object_handle_array_length);
  /* USER CODE END USBD_MTP_GetObjectReferences */

  return status;
}

/**
  * @brief  USBD_MTP_SetObjectReferences
  *         This function is invoked when host requested to set object
  *         references.
  * @param  pima_instance : Pointer to the pima class instance.
  * @param  object_handle : Handle of the object.
  * @param  object_handle_array: object handle array.
  * @param  object_handle_array_length: length of object handle array.
  * @retval status
  */
UINT USBD_MTP_SetObjectReferences(struct UX_SLAVE_CLASS_PIMA_STRUCT *pima_instance,
                                  ULONG object_handle,
                                  UCHAR *object_handle_array,
                                  ULONG object_handle_array_length)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_MTP_SetObjectReferences */
  UX_PARAMETER_NOT_USED(pima_instance);
  UX_PARAMETER_NOT_USED(object_handle);
  UX_PARAMETER_NOT_USED(object_handle_array);
  UX_PARAMETER_NOT_USED(object_handle_array_length);
  /* USER CODE END USBD_MTP_SetObjectReferences */

  return status;
}

/**
  * @brief  USBD_MTP_StorageGetMaxCapabilityLow
  *         This function is called to get storage max capability low.
  * @param  none
  * @retval max capability
  */
ULONG USBD_MTP_StorageGetMaxCapabilityLow(VOID)
{
  ULONG max_capability_low = 0U;

  /* USER CODE BEGIN USBD_MTP_StorageGetMaxCapabilityLow */

  /* USER CODE END USBD_MTP_StorageGetMaxCapabilityLow */

  return max_capability_low;
}

/**
  * @brief  USBD_MTP_StorageGetMaxCapabilityHigh
  *         This function is called to get storage max capability high.
  * @param  none
  * @retval max capability high
  */
ULONG USBD_MTP_StorageGetMaxCapabilityHigh(VOID)
{
  ULONG max_capability_high = 0U;

  /* USER CODE BEGIN USBD_MTP_StorageGetMaxCapabilityHigh */

  /* USER CODE END USBD_MTP_StorageGetMaxCapabilityHigh */

  return max_capability_high;
}

/**
  * @brief  USBD_MTP_StorageGetFreeSpaceLow
  *         This function is called to get storage free space low.
  * @param  none
  * @retval Free space low
  */
ULONG USBD_MTP_StorageGetFreeSpaceLow(VOID)
{
  ULONG free_space_low = 0U;

  /* USER CODE BEGIN USBD_MTP_StorageGetFreeSpaceLow */

  /* USER CODE END USBD_MTP_StorageGetFreeSpaceLow */

  return free_space_low;
}

/**
  * @brief  USBD_MTP_StorageGetFreeSpaceHigh
  *         This function is called to get storage free space high.
  * @param  none
  * @retval Free space high
  */
ULONG USBD_MTP_StorageGetFreeSpaceHigh(VOID)
{
  ULONG free_space_high = 0U;

  /* USER CODE BEGIN USBD_MTP_StorageGetFreeSpaceHigh */

  /* USER CODE END USBD_MTP_StorageGetFreeSpaceHigh */

  return free_space_high;
}

/**
  * @brief  USBD_MTP_StorageGetFreeSpaceImage
  *         This function is called to get storage free space image.
  * @param  none
  * @retval Free space image
  */
ULONG USBD_MTP_StorageGetFreeSpaceImage(VOID)
{
  ULONG free_space_image = 0U;

  /* USER CODE BEGIN USBD_MTP_StorageGetFreeSpaceImage */

  /* USER CODE END USBD_MTP_StorageGetFreeSpaceImage */

  return free_space_image;
}

[/#if]
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
