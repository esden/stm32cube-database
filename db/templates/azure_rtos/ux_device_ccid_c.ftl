[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ux_device_ccid.c
  * @author  MCD Application Team
  * @brief   USBX Device CCID applicative file
  ******************************************************************************
 [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "ux_device_ccid.h"
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]

    [#if name == "REG_UX_DEVICE_CCID"]
      [#assign REG_UX_DEVICE_CCID_value = value]
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
[#if REG_UX_DEVICE_CCID_value == "1"]
/* Define CCID device command handle */
UX_DEVICE_CLASS_CCID_HANDLES USBD_CCID_Handles = {
  /* USER CODE BEGIN USBD_CCID_Handles */

  USBD_CCID_icc_power_on,
  USBD_CCID_icc_power_off,
  USBD_CCID_get_slot_status,
  USBD_CCID_xfr_block,
  USBD_CCID_get_parameters,
  USBD_CCID_reset_parameters,
  USBD_CCID_set_parameters,
  USBD_CCID_escape,
  USBD_CCID_icc_clock,
  USBD_CCID_t0_apdu,
  USBD_CCID_secure,
  USBD_CCID_mechanical,
  USBD_CCID_abort,
  USBD_CCID_set_data_rate_and_clock_frequency,

  /* USER CODE END USBD_CCID_Handles */
};

ULONG USBD_CCID_Clocks[USBD_CCID_N_CLOCKS] = {
  /* USER CODE BEGIN USBD_CCID_Clocks */
  USBD_CCID_DEFAULT_CLOCK_FREQ
  /* USER CODE END USBD_CCID_Clocks */
};

ULONG USBD_CCID_DataRates[USBD_CCID_N_DATA_RATES] = {
  /* USER CODE BEGIN USBD_CCID_DataRates */
  USBD_CCID_DEFAULT_DATA_RATE
  /* USER CODE END USBD_CCID_DataRates */
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

[#if REG_UX_DEVICE_CCID_value == "1"]
/**
  * @brief  USBD_CCID_Activate
  *         This function is called while inserting CCID device.
  * @param  ccid_instance: Pointer to the ccid class instance.
  * @retval none
  */
VOID USBD_CCID_Activate(VOID *ccid_instance)
{
  /* USER CODE BEGIN USBD_CCID_Activate */
  UX_PARAMETER_NOT_USED(ccid_instance);
  /* USER CODE END USBD_CCID_Activate */

  return;
}

/**
  * @brief  USBD_CCID_Deactivate
  *         This function is called while extracting CCID device.
  * @param  ccid_instance: Pointer to the ccid class instance.
  * @retval none
  */
VOID USBD_CCID_Deactivate(VOID *ccid_instance)
{
  /* USER CODE BEGIN USBD_CCID_Deactivate */
  UX_PARAMETER_NOT_USED(ccid_instance);
  /* USER CODE END USBD_CCID_Deactivate */

  return;
}

/**
  * @brief  USBD_CCID_icc_power_on
  *         Activate the card slot and get the ATR from ICC
  * @param  slot: card slot
  * @param  io_msg: CCID message struct
  * @retval status
  */
UINT USBD_CCID_icc_power_on(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_CCID_icc_power_on */
  UX_PARAMETER_NOT_USED(slot);
  UX_PARAMETER_NOT_USED(io_msg);
  /* USER CODE END USBD_CCID_icc_power_on */

  return status;
}

/**
  * @brief  USBD_CCID_icc_power_off
  *         Deactivate the card slot
  * @param  slot: card slot
  * @param  io_msg: CCID message struct
  * @retval status
  */
UINT USBD_CCID_icc_power_off(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_CCID_icc_power_off */
  UX_PARAMETER_NOT_USED(slot);
  UX_PARAMETER_NOT_USED(io_msg);
  /* USER CODE END USBD_CCID_icc_power_off */

  return status;
}

/**
  * @brief  USBD_CCID_get_slot_status
  *         Get current status of the slot
  * @param  slot: card slot
  * @param  io_msg: CCID message struct
  * @retval status
  */
UINT USBD_CCID_get_slot_status(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_CCID_get_slot_status */
  UX_PARAMETER_NOT_USED(slot);
  UX_PARAMETER_NOT_USED(io_msg);
  /* USER CODE END USBD_CCID_get_slot_status */

  return status;
}

/**
  * @brief  USBD_CCID_xfr_block
  *         Transfer data block to the ICC
  * @param  slot: card slot
  * @param  io_msg: CCID message struct
  * @retval status
  */
UINT USBD_CCID_xfr_block(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_CCID_xfr_block */
  UX_PARAMETER_NOT_USED(slot);
  UX_PARAMETER_NOT_USED(io_msg);
  /* USER CODE END USBD_CCID_xfr_block */

  return status;
}

/**
  * @brief  USBD_CCID_get_parameters
  *         Get slot parameters
  * @param  slot: card slot
  * @param  io_msg: CCID message struct
  * @retval status
  */
UINT USBD_CCID_get_parameters(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_CCID_get_parameters */
  UX_PARAMETER_NOT_USED(slot);
  UX_PARAMETER_NOT_USED(io_msg);
  /* USER CODE END USBD_CCID_get_parameters */

  return status;
}

/**
  * @brief  USBD_CCID_reset_parameters
  *         Reset slot parameters to default value
  * @param  slot: card slot
  * @param  io_msg: CCID message struct
  * @retval status
  */
UINT USBD_CCID_reset_parameters(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_CCID_reset_parameters */
  UX_PARAMETER_NOT_USED(slot);
  UX_PARAMETER_NOT_USED(io_msg);
  /* USER CODE END USBD_CCID_reset_parameters */

  return status;
}

/**
  * @brief  USBD_CCID_set_parameters
  *         Set slot parameters
  * @param  slot: card slot
  * @param  io_msg: CCID message struct
  * @retval status
  */
UINT USBD_CCID_set_parameters(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_CCID_set_parameters */
  UX_PARAMETER_NOT_USED(slot);
  UX_PARAMETER_NOT_USED(io_msg);
  /* USER CODE END USBD_CCID_set_parameters */

  return status;
}

/**
  * @brief  USBD_CCID_escape
  *         Define and access extended features
  * @param  slot: card slot
  * @param  io_msg: CCID message struct
  * @retval status
  */
UINT USBD_CCID_escape(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_CCID_escape */
  UX_PARAMETER_NOT_USED(slot);
  UX_PARAMETER_NOT_USED(io_msg);
  /* USER CODE END USBD_CCID_escape */

  return status;
}

/**
  * @brief  USBD_CCID_icc_clock
  *         Stop or restart the clock
  * @param  slot: card slot
  * @param  io_msg: CCID message struct
  * @retval status
  */
UINT USBD_CCID_icc_clock(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_CCID_icc_clock */
  UX_PARAMETER_NOT_USED(slot);
  UX_PARAMETER_NOT_USED(io_msg);
  /* USER CODE END USBD_CCID_icc_clock */

  return status;
}

/**
  * @brief  USBD_CCID_t0_apdu
  *         Changes parameters used for T=0 protocol APDU messages transportation
  * @param  slot: card slot
  * @param  io_msg: CCID message struct
  * @retval status
  */
UINT USBD_CCID_t0_apdu(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_CCID_t0_apdu */
  UX_PARAMETER_NOT_USED(slot);
  UX_PARAMETER_NOT_USED(io_msg);
  /* USER CODE END USBD_CCID_t0_apdu */

  return status;
}

/**
  * @brief  USBD_CCID_secure
  *         Allow entering the PIN for verification or modification
  * @param  slot: card slot
  * @param  io_msg: CCID message struct
  * @retval status
  */
UINT USBD_CCID_secure(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_CCID_secure */
  UX_PARAMETER_NOT_USED(slot);
  UX_PARAMETER_NOT_USED(io_msg);
  /* USER CODE END USBD_CCID_secure */

  return status;
}

/**
  * @brief  USBD_CCID_mechanical
  *         Manage motorized type CCID functionality
  * @param  slot: card slot
  * @param  io_msg: CCID message struct
  * @retval status
  */
UINT USBD_CCID_mechanical(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_CCID_mechanical */
  UX_PARAMETER_NOT_USED(slot);
  UX_PARAMETER_NOT_USED(io_msg);
  /* USER CODE END USBD_CCID_mechanical */

  return status;
}

/**
  * @brief  USBD_CCID_abort
  *         Tell the CCID to stop any current transfer at the specified slot
  * @param  slot: card slot
  * @param  io_msg: CCID message struct
  * @retval status
  */
UINT USBD_CCID_abort(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_CCID_abort */
  UX_PARAMETER_NOT_USED(slot);
  UX_PARAMETER_NOT_USED(io_msg);
  /* USER CODE END USBD_CCID_abort */

  return status;
}

/**
  * @brief  USBD_CCID_set_data_rate_and_clock_frequency
  *         Set the data rate and clock frequency of a specific slot
  * @param  slot: card slot
  * @param  io_msg: CCID message struct
  * @retval status
  */
UINT USBD_CCID_set_data_rate_and_clock_frequency(ULONG slot, UX_DEVICE_CLASS_CCID_MESSAGES *io_msg)
{
  UINT status = UX_SUCCESS;

  /* USER CODE BEGIN USBD_CCID_set_data_rate_and_clock_frequency */
  UX_PARAMETER_NOT_USED(slot);
  UX_PARAMETER_NOT_USED(io_msg);
  /* USER CODE END USBD_CCID_set_data_rate_and_clock_frequency */

  return status;
}

[/#if]
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
