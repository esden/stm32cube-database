[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ux_device_printer.c
  * @author  MCD Application Team
  * @brief   USBX Device PRINTER applicative file
  ******************************************************************************
 [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "ux_device_printer.h"
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]

    [#if name == "REG_UX_DEVICE_PRINTER"]
      [#assign REG_UX_DEVICE_PRINTER_value = value]
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
[#if REG_UX_DEVICE_PRINTER_value == "1"]
/* Define Printer device ID */
UCHAR USBD_PRINTER_DeviceID [] = {
  /* USER CODE BEGIN USBD_PRINTER_DeviceID */

  "  "                             /* Length */
  "MFG:Generic;"                   /* Manufacturer */
  "MDL:Generic_/_Text_Only;"       /* Model */
  "CMD:1284.4;"                    /* Command Set */
  "CLS:PRINTER;"                   /* Class */
  "DES:Generic text only printer;" /* Description */

  /* USER CODE END USBD_PRINTER_DeviceID */
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

[#if REG_UX_DEVICE_PRINTER_value == "1"]
/**
  * @brief  USBD_PRINTER_GetDeviceID
  *         Get the printer device ID.
  * @param  none
  * @retval USBD_PRINTER_DeviceID : Pointer to printer device ID.
  */
UCHAR *USBD_PRINTER_GetDeviceID(VOID)
{
  /* USER CODE BEGIN USBD_PRINTER_GetDeviceID */

  ux_utility_short_put_big_endian(USBD_PRINTER_DeviceID, sizeof(USBD_PRINTER_DeviceID));

  /* USER CODE END USBD_PRINTER_GetDeviceID */

  return USBD_PRINTER_DeviceID;
}

/**
  * @brief  USBD_PRINTER_Activate
  *         This function is called while inserting a printer device.
  * @param  printer_instance: Pointer to the printer class instance.
  * @retval none
  */
VOID USBD_PRINTER_Activate(VOID *printer_instance)
{
  /* USER CODE BEGIN USBD_PRINTER_Activate */
  UX_PARAMETER_NOT_USED(printer_instance);
  /* USER CODE END USBD_PRINTER_Activate */

  return;
}

/**
  * @brief  USBD_PRINTER_Deactivate
  *         This function is called while extracting a printer device.
  * @param  printer_instance: Pointer to the printer class instance.
  * @retval none
  */
VOID USBD_PRINTER_Deactivate(VOID *printer_instance)
{
  /* USER CODE BEGIN USBD_PRINTER_Deactivate */
  UX_PARAMETER_NOT_USED(printer_instance);
  /* USER CODE END USBD_PRINTER_Deactivate */

  return;
}

/**
  * @brief  USBD_PRINTER_SoftReset
  *         This function is called while resetting a printer device.
  * @param  printer_instance: Pointer to the printer class instance.
  * @retval none
  */
VOID USBD_PRINTER_SoftReset(VOID *printer_instance)
{
  /* USER CODE BEGIN USBD_PRINTER_SoftReset */
  UX_PARAMETER_NOT_USED(printer_instance);
  /* USER CODE END USBD_PRINTER_SoftReset */

  return;
}

[/#if]
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
