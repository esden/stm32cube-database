[#ftl]
/**
  ******************************************************************************
  * @file    sigfox_mbwrapper.c
  * @author  MCD Application Team
  * @brief   This file implements the CM4 side wrapper of the Sigfox interface
  *          shared between M0 and M4.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "platform.h"
#include "sigfox_mbwrapper.h"
#include "platform.h"
#include "mbmux.h"
#include "mbmuxif_sys.h"
#include "msg_id.h"
#include "mbmuxif_sigfox.h"
#include "stm32_mem.h"
[#if !FREERTOS??][#-- If FreeRtos is not used --]
#include "stm32_seq.h"
[/#if]
#include "sys_app.h"
#include "st_sigfox_api.h"
#include "sigfox_monarch_api.h"
#include "sgfx_app.h"
#include "sigfox_info.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
#ifndef MAX
#define MAX( a, b ) ( ( ( a ) > ( b ) ) ? ( a ) : ( b ) )
#endif /* MAX */
#define NB_ELEMENTS_MAX 3

/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
UTIL_MEM_PLACE_IN_SECTION("MB_MEM1") uint8_t aSigfoxMbWrapShareBuffer[sizeof(sfx_rc_t)];

static sfx_u8(* app_cb)(sfx_u8 rc_bit_mask, sfx_s16 rssi);

static SigfoxCallback_t *callback_wrap;

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/
/*!
  * \brief   Open Sigfox API
  *
  *
  * \param   [IN] sfx_rc_t - Radio configuration structure
  *
  * \retval  sfx_error_t Status of the operation. Possible returns are:
  *          \ref SFX_ERR_NONE,
  *          \ref SFX_ERR_API_OPEN_xx
  */
sfx_error_t SIGFOX_API_open(sfx_rc_t *rc)
{
  /* USER CODE BEGIN SIGFOX_API_open_1 */

  /* USER CODE END SIGFOX_API_open_1 */
  MBMUX_ComParam_t *com_obj;
  uint32_t *com_buffer ;
  uint16_t i = 0;
  uint32_t ret;

  /* copy data from Cm4 stack memory to shared memory */
  UTIL_MEM_cpy_8((uint8_t *) aSigfoxMbWrapShareBuffer, (uint8_t *) rc, sizeof(sfx_rc_t));

  com_obj = MBMUXIF_GetSigfoxFeatureCmdComPtr();
  com_obj->MsgId = SIGFOX_START_ID;
  com_buffer = com_obj->ParamBuf;
  com_buffer[i++] = (uint32_t) aSigfoxMbWrapShareBuffer;
  com_obj->ParamCnt = i;
  MBMUXIF_SigfoxSendCmd();
  /* waiting for event */
  /* once event is received and semaphore released: */

  /* copy back data from shared memory to Cm4 stack private memory */
  UTIL_MEM_cpy_8((uint8_t *) rc, (uint8_t *) aSigfoxMbWrapShareBuffer, sizeof(sfx_rc_t));

  ret = com_obj->ReturnVal;
  return (sfx_error_t) ret;
  /* USER CODE BEGIN SIGFOX_API_open_2 */

  /* USER CODE END SIGFOX_API_open_2 */
}

/*!
  * \brief   Close Sigfox API
  *
  * \retval  sfx_error_t Status of the operation. Possible returns are:
  *          \ref SFX_ERR_NONE,
  *          \ref SFX_ERR_API_CLOSE_xx
  */
sfx_error_t SIGFOX_API_close(void)
{
  /* USER CODE BEGIN SIGFOX_API_close_1 */

  /* USER CODE END SIGFOX_API_close_1 */
  MBMUX_ComParam_t *com_obj;
  uint32_t ret;

  com_obj = MBMUXIF_GetSigfoxFeatureCmdComPtr();
  com_obj->MsgId = SIGFOX_STOP_ID;
  com_obj->ParamCnt = 0;
  MBMUXIF_SigfoxSendCmd();
  /* waiting for event */
  /* once event is received and semaphore released: */
  ret = com_obj->ReturnVal;
  return (sfx_error_t) ret;
  /* USER CODE BEGIN SIGFOX_API_close_2 */

  /* USER CODE END SIGFOX_API_close_2 */
}

/*!
  * \brief Send a standard SIGFOX frame with customer payload
  *
  * \retval  sfx_error_t Status of the operation. Possible returns are:
  *          \ref SFX_ERR_NONE,
  *          \ref SFX_ERR_API_SEND_FRAME_xx
  *          \ref SFX_ERR_INT_xx
  */
sfx_error_t SIGFOX_API_send_frame(sfx_u8 *customer_data, sfx_u8 customer_data_length,
                                  sfx_u8 *customer_response, sfx_u8 tx_mode,
                                  sfx_bool initiate_downlink_flag)
{
  /* USER CODE BEGIN SIGFOX_API_send_frame_1 */

  /* USER CODE END SIGFOX_API_send_frame_1 */
  MBMUX_ComParam_t *com_obj;
  uint32_t *com_buffer ;
  uint16_t i = 0;
  uint32_t ret;

  /* copy data from Cm4 stack memory to shared memory */
  UTIL_MEM_cpy_8((uint8_t *) aSigfoxMbWrapShareBuffer, (uint8_t *) customer_data,
                 SGFX_MAX_UL_PAYLOAD_SIZE * sizeof(sfx_u8));
  UTIL_MEM_cpy_8((uint8_t *)(aSigfoxMbWrapShareBuffer + SGFX_MAX_UL_PAYLOAD_SIZE * sizeof(sfx_u8)),
                 (uint8_t *)customer_response, SGFX_MAX_DL_PAYLOAD_SIZE * sizeof(sfx_u8));

  com_obj = MBMUXIF_GetSigfoxFeatureCmdComPtr();
  com_obj->MsgId = SIGFOX_SEND_FRAME_DWNL_ID;
  com_buffer = com_obj->ParamBuf;
  com_buffer[i++] = (uint32_t) aSigfoxMbWrapShareBuffer;
  com_buffer[i++] = (uint32_t) customer_data_length;
  com_buffer[i++] = ((uint32_t) aSigfoxMbWrapShareBuffer + SGFX_MAX_UL_PAYLOAD_SIZE * sizeof(sfx_u8));
  com_buffer[i++] = (uint32_t) tx_mode;
  com_buffer[i++] = (uint32_t) initiate_downlink_flag ;

  com_obj->ParamCnt = i;
  MBMUXIF_SigfoxSendCmd();
  /* waiting for event */
  /* once event is received and semaphore released: */

  /* copy back data from shared memory to Cm4 stack memory */
  UTIL_MEM_cpy_8((uint8_t *) customer_data, (uint8_t *) aSigfoxMbWrapShareBuffer,
                 SGFX_MAX_UL_PAYLOAD_SIZE * sizeof(sfx_u8));
  UTIL_MEM_cpy_8((uint8_t *)customer_response,
                 (uint8_t *)(aSigfoxMbWrapShareBuffer + SGFX_MAX_UL_PAYLOAD_SIZE * sizeof(sfx_u8)),
                 SGFX_MAX_DL_PAYLOAD_SIZE * sizeof(sfx_u8));

  ret = com_obj->ReturnVal;
  return (sfx_error_t) ret;
  /* USER CODE BEGIN SIGFOX_API_send_frame_2 */

  /* USER CODE END SIGFOX_API_send_frame_2 */
}

/*!
  * \brief Send a standard SIGFOX frame with customer payload
  *
  * \param[in] sfx_bool bit_value                Bit state (SFX_TRUE or SFX_FALSE)
  * \param[out] sfx_u8 *customer_response        Returned 8 Bytes data in case of downlink
  * \param[in] sfx_u8 tx_mode                    tx_mode shall be set to 2.
  * \param[in] sfx_bool initiate_downlink_flag   Flag to initiate a downlink response
  * \retval  sfx_error_t Status of the operation. Possible returns are:
  *          \ref SFX_ERR_NONE,
  *          \ref SFX_ERR_API_SEND_BIT_xx
  *          \ref SFX_ERR_INT_xx
  */
sfx_error_t SIGFOX_API_send_bit(sfx_bool bit_value,
                                sfx_u8 *customer_response,
                                sfx_u8 tx_mode,
                                sfx_bool initiate_downlink_flag)
{
  /* USER CODE BEGIN SIGFOX_API_send_bit_1 */

  /* USER CODE END SIGFOX_API_send_bit_1 */
  MBMUX_ComParam_t *com_obj;
  uint32_t *com_buffer ;
  uint16_t i = 0;
  uint32_t ret;

  /* copy data from Cm4 stack memory to shared memory */
  UTIL_MEM_cpy_8((uint8_t *)aSigfoxMbWrapShareBuffer, (uint8_t *)customer_response,
                 SGFX_MAX_DL_PAYLOAD_SIZE * sizeof(sfx_u8));

  com_obj = MBMUXIF_GetSigfoxFeatureCmdComPtr();
  com_obj->MsgId = SIGFOX_SEND_BIT_ID;
  com_buffer = com_obj->ParamBuf;
  com_buffer[i++] = (uint32_t) bit_value;
  com_buffer[i++] = (uint32_t) aSigfoxMbWrapShareBuffer;
  com_buffer[i++] = (uint32_t) tx_mode;
  com_buffer[i++] = (uint32_t) initiate_downlink_flag;

  com_obj->ParamCnt = i;
  MBMUXIF_SigfoxSendCmd();
  /* waiting for event */
  /* once event is received and semaphore released: */

  /* copy back data from shared memory to Cm4 stack memory */
  UTIL_MEM_cpy_8((uint8_t *)customer_response, (uint8_t *) aSigfoxMbWrapShareBuffer,
                 SGFX_MAX_DL_PAYLOAD_SIZE * sizeof(sfx_u8));

  ret = com_obj->ReturnVal;
  return (sfx_error_t) ret;
  /* USER CODE BEGIN SIGFOX_API_send_bit_2 */

  /* USER CODE END SIGFOX_API_send_bit_2 */
}

/*!
  * \brief   Send an out of band SIGFOX frame
  *
  *
  * \param   [IN] sfx_oob_enum_t oob_type  - Type of the OOB frame to send
  *
  * \retval  sfx_error_t Status of the operation. Possible returns are:
  *          \ref SFX_ERR_NONE,
  *          \ref SFX_ERR_INT_xx
  */
sfx_error_t SIGFOX_API_send_outofband(sfx_oob_enum_t oob_type)
{
  /* USER CODE BEGIN SIGFOX_API_send_outofband_1 */

  /* USER CODE END SIGFOX_API_send_outofband_1 */
  MBMUX_ComParam_t *com_obj;
  uint32_t *com_buffer ;
  uint16_t i = 0;
  uint32_t ret;

  com_obj = MBMUXIF_GetSigfoxFeatureCmdComPtr();
  com_obj->MsgId = SIGFOX_SEND_OOB_ID;
  com_buffer = com_obj->ParamBuf;
  com_buffer[i++] = (uint32_t) oob_type;
  com_obj->ParamCnt = i;
  MBMUXIF_SigfoxSendCmd();
  /* waiting for event */
  /* once event is received and semaphore released: */

  ret = com_obj->ReturnVal;
  return (sfx_error_t) ret;
  /* USER CODE BEGIN SIGFOX_API_send_outofband_2 */

  /* USER CODE END SIGFOX_API_send_outofband_2 */
}

/*!
  * \brief   configure specific variables for standard
  *          It is mandatory to call this function after SIGFOX_API_open() for FH and LBT
  *
  * \param   [IN] config_words          -  Meaning depends on the standard
  * \param   [IN] sfx_bool timer_enable -  Enable timer feature for FH
  * \retval  sfx_error_t Status of the operation. Possible returns are:
  *          \ref SFX_ERR_NONE,
  *          \ref SFX_ERR_API_SET_CONFIG_xx
  */
sfx_error_t SIGFOX_API_set_std_config(sfx_u32 config_words[NB_ELEMENTS_MAX],
                                      sfx_bool timer_enable)
{
  /* USER CODE BEGIN SIGFOX_API_set_std_config_1 */

  /* USER CODE END SIGFOX_API_set_std_config_1 */
  MBMUX_ComParam_t *com_obj;
  uint32_t *com_buffer ;
  uint16_t i = 0;
  uint32_t ret;

  /* copy data from Cm4 stack memory to shared memory */
  UTIL_MEM_cpy_8((uint8_t *) aSigfoxMbWrapShareBuffer, (uint8_t *) config_words, NB_ELEMENTS_MAX * sizeof(sfx_u32));

  com_obj = MBMUXIF_GetSigfoxFeatureCmdComPtr();
  com_obj->MsgId = SIGFOX_SET_STD_ID;
  com_buffer = com_obj->ParamBuf;
  com_buffer[i++] = (uint32_t) aSigfoxMbWrapShareBuffer;
  com_buffer[i++] = (uint32_t) timer_enable;

  com_obj->ParamCnt = i;
  MBMUXIF_SigfoxSendCmd();
  /* waiting for event */
  /* once event is received and semaphore released: */

  /* copy back data from shared memory to Cm4 stack private memory */
  UTIL_MEM_cpy_8((uint8_t *) config_words, (uint8_t *) aSigfoxMbWrapShareBuffer, NB_ELEMENTS_MAX * sizeof(sfx_u32));

  ret = com_obj->ReturnVal;
  return (sfx_error_t) ret;
  /* USER CODE BEGIN SIGFOX_API_set_std_config_2 */

  /* USER CODE END SIGFOX_API_set_std_config_2 */
}

/*!
  * \brief   Executes a continuous wave or modulation depending on the parameter type
  *
  * \param   [IN] frequency          -  Frequency at which the signal has to be generated
  * \param   [IN] sfx_modulation_type_t type   -  Type of modulation to use in continuous mode
  * \retval  sfx_error_t Status of the operation. Possible returns are:
  *          \ref SFX_ERR_NONE,
  *          \ref SFX_ERR_API_START_CONTINUOUS_TRANSMISSION_xx
  */
sfx_error_t SIGFOX_API_start_continuous_transmission(sfx_u32 frequency, sfx_modulation_type_t type)
{
  /* USER CODE BEGIN SIGFOX_API_start_continuous_transmission_1 */

  /* USER CODE END SIGFOX_API_start_continuous_transmission_1 */
  MBMUX_ComParam_t *com_obj;
  uint32_t *com_buffer ;
  uint16_t i = 0;
  uint32_t ret;

  /* copy data from Cm4 stack memory to shared memory */
  UTIL_MEM_cpy_8((uint8_t *) aSigfoxMbWrapShareBuffer, (uint8_t *) type, sizeof(sfx_modulation_type_t));

  com_obj = MBMUXIF_GetSigfoxFeatureCmdComPtr();
  com_obj->MsgId = SIGFOX_START_CONTINUOUS_ID;
  com_buffer = com_obj->ParamBuf;
  com_buffer[i++] = (uint32_t) frequency;
  com_buffer[i++] = (uint32_t) aSigfoxMbWrapShareBuffer;

  com_obj->ParamCnt = i;
  MBMUXIF_SigfoxSendCmd();
  /* waiting for event */
  /* once event is received and semaphore released: */

  /* copy back data from shared memory to Cm4 stack private memory */
  UTIL_MEM_cpy_8((uint8_t *) type, (uint8_t *) aSigfoxMbWrapShareBuffer, sizeof(sfx_modulation_type_t));

  ret = com_obj->ReturnVal;
  return (sfx_error_t) ret;
  /* USER CODE BEGIN SIGFOX_API_start_continuous_transmission_2 */

  /* USER CODE END SIGFOX_API_start_continuous_transmission_2 */
}

/*!
  * \brief   Stop the current continuous transmission
  *
  * \retval  sfx_error_t Status of the operation. Possible returns are:
  *          \ref SFX_ERR_NONE,
  *          \ref SFX_ERR_API_STOP_CONTINUOUS_TRANSMISSION_xx
  */
sfx_error_t SIGFOX_API_stop_continuous_transmission(void)
{
  /* USER CODE BEGIN SIGFOX_API_stop_continuous_transmission_1 */

  /* USER CODE END SIGFOX_API_stop_continuous_transmission_1 */
  MBMUX_ComParam_t *com_obj;
  uint32_t ret;

  com_obj = MBMUXIF_GetSigfoxFeatureCmdComPtr();
  com_obj->MsgId = SIGFOX_STOP_CONTINUOUS_ID;
  com_obj->ParamCnt = 0;
  MBMUXIF_SigfoxSendCmd();
  /* waiting for event */
  /* once event is received and semaphore released: */
  ret = com_obj->ReturnVal;
  return (sfx_error_t) ret;
  /* USER CODE BEGIN SIGFOX_API_stop_continuous_transmission_2 */

  /* USER CODE END SIGFOX_API_stop_continuous_transmission_2 */
}

/*!
  * \brief   Returns current SIGFOX library version, or RF Version, or MCU version
  *
  * \param[out] sfx_u8 **version                 Pointer to Byte array (ASCII format) containing library version
  * \param[out] sfx_u8 *size                     Size of the byte array pointed by *version
  * \param[in]  sfx_version_type_t type          Type of the version ( MCU, RF, ... )
  * \retval  sfx_error_t Status of the operation. Possible returns are:
  *          \ref SFX_ERR_NONE,
  *          \ref SFX_ERR_API_GET_VERSION_xx
  */
sfx_error_t SIGFOX_API_get_version(sfx_u8 **version, sfx_u8 *size, sfx_version_type_t type)
{
  /* USER CODE BEGIN SIGFOX_API_get_version_1 */

  /* USER CODE END SIGFOX_API_get_version_1 */
  MBMUX_ComParam_t *com_obj;
  uint32_t *com_buffer ;
  uint16_t i = 0;
  uint32_t ret;

  /* copy data from Cm4 stack memory to shared memory */
  UTIL_MEM_cpy_8((uint8_t *) aSigfoxMbWrapShareBuffer, (uint8_t *) version, sizeof(sfx_u32));
  UTIL_MEM_cpy_8((uint8_t *)(aSigfoxMbWrapShareBuffer + sizeof(sfx_u32)), (uint8_t *) size, sizeof(sfx_u8));

  com_obj = MBMUXIF_GetSigfoxFeatureCmdComPtr();
  com_obj->MsgId = SIGFOX_GET_VERSION_ID;
  com_buffer = com_obj->ParamBuf;
  com_buffer[i++] = (uint32_t) aSigfoxMbWrapShareBuffer;
  com_buffer[i++] = (uint32_t)(aSigfoxMbWrapShareBuffer + sizeof(sfx_u32));
  com_buffer[i++] = (uint32_t) type ;
  com_obj->ParamCnt = i;
  MBMUXIF_SigfoxSendCmd();
  /* waiting for event */
  /* once event is received and semaphore released: */

  /* copy back data from shared memory to Cm4 stack private memory */
  UTIL_MEM_cpy_8((uint8_t *) version, (uint8_t *) aSigfoxMbWrapShareBuffer, sizeof(sfx_u32));
  UTIL_MEM_cpy_8((uint8_t *) size, (uint8_t *)(aSigfoxMbWrapShareBuffer + sizeof(sfx_u32)), sizeof(sfx_u8));

  ret = com_obj->ReturnVal;
  return (sfx_error_t) ret;
  /* USER CODE BEGIN SIGFOX_API_get_version_2 */

  /* USER CODE END SIGFOX_API_get_version_2 */
}

/*!
  * \brief   copies the ID of the device to the pointer given in parameter
  *
  *
  * \param[out] sfx_u8* dev_id    Pointer where to write the device ID
  *
  * \retval  sfx_error_t Status of the operation. Possible returns are:
  *          \ref SFX_ERR_NONE,
  *          \ref SFX_ERR_API_GET_DEVICE_ID_xx
  */
sfx_error_t SIGFOX_API_get_device_id(sfx_u8 *dev_id)
{
  /* USER CODE BEGIN SIGFOX_API_get_device_id_1 */

  /* USER CODE END SIGFOX_API_get_device_id_1 */
  MBMUX_ComParam_t *com_obj;
  uint32_t *com_buffer ;
  uint16_t i = 0;
  uint32_t ret;

  /* copy data from Cm4 stack memory to shared memory */
  UTIL_MEM_cpy_8((uint8_t *) aSigfoxMbWrapShareBuffer, (uint8_t *) dev_id, sizeof(sfx_u32));

  com_obj = MBMUXIF_GetSigfoxFeatureCmdComPtr();
  com_obj->MsgId = SIGFOX_GET_DEVICE_ID;
  com_buffer = com_obj->ParamBuf;
  com_buffer[i++] = (uint32_t) aSigfoxMbWrapShareBuffer;
  com_obj->ParamCnt = i;
  MBMUXIF_SigfoxSendCmd();
  /* waiting for event */
  /* once event is received and semaphore released: */

  /* copy back data from shared memory to Cm4 stack private memory */
  UTIL_MEM_cpy_8((uint8_t *) dev_id, (uint8_t *) aSigfoxMbWrapShareBuffer, sizeof(sfx_u32));

  ret = com_obj->ReturnVal;
  return (sfx_error_t) ret;
  /* USER CODE BEGIN SIGFOX_API_get_device_id_2 */

  /* USER CODE END SIGFOX_API_get_device_id_2 */
}

/*!
  * \brief   Get the value of the PAC stored in the device
  *
  *
  * \param[out] sfx_u8* initial_pac              Pointer to initial PAC
  *
  * \retval  sfx_error_t Status of the operation. Possible returns are:
  *          \ref SFX_ERR_NONE,
  *          \ref SFX_ERR_API_GET_DEVICE_ID_xx
  */
sfx_error_t SIGFOX_API_get_initial_pac(sfx_u8 *initial_pac)
{
  /* USER CODE BEGIN SIGFOX_API_get_initial_pac_1 */

  /* USER CODE END SIGFOX_API_get_initial_pac_1 */
  MBMUX_ComParam_t *com_obj;
  uint32_t *com_buffer ;
  uint16_t i = 0;
  uint32_t ret;

  /* copy data from Cm4 stack memory to shared memory */
  UTIL_MEM_cpy_8((uint8_t *) aSigfoxMbWrapShareBuffer, (uint8_t *) initial_pac, PAC_LENGTH * sizeof(sfx_u8));

  com_obj = MBMUXIF_GetSigfoxFeatureCmdComPtr();
  com_obj->MsgId = SIGFOX_GET_INIT_PAC_ID;
  com_buffer = com_obj->ParamBuf;
  com_buffer[i++] = (uint32_t) aSigfoxMbWrapShareBuffer;
  com_obj->ParamCnt = i;
  MBMUXIF_SigfoxSendCmd();
  /* waiting for event */
  /* once event is received and semaphore released: */

  /* copy back data from shared memory to Cm4 stack private memory */
  UTIL_MEM_cpy_8((uint8_t *) initial_pac, (uint8_t *) aSigfoxMbWrapShareBuffer, PAC_LENGTH * sizeof(sfx_u8));

  ret = com_obj->ReturnVal;
  return (sfx_error_t) ret;
  /* USER CODE BEGIN SIGFOX_API_get_initial_pac_2 */

  /* USER CODE END SIGFOX_API_get_initial_pac_2 */
}

/*!
  * \brief   Set the period for transmission of RC Sync frame
  *
  *
  * \param[in] sfx_u16 rollover_counter_period
  *       Transmission period of the RC Sync frame (in number of 'normal' frames)
  *
  * \retval  sfx_error_t Status of the operation. Possible returns are:
  *          \ref SFX_ERR_NONE,
  *          \ref SFX_ERR_API_GET_DEVICE_ID_xx
  */
sfx_error_t SIGFOX_API_set_rc_sync_period(sfx_u16 rc_sync_period)
{
  /* USER CODE BEGIN SIGFOX_API_set_rc_sync_period_1 */

  /* USER CODE END SIGFOX_API_set_rc_sync_period_1 */
  MBMUX_ComParam_t *com_obj;
  uint32_t *com_buffer ;
  uint16_t i = 0;
  uint32_t ret;

  com_obj = MBMUXIF_GetSigfoxFeatureCmdComPtr();
  com_obj->MsgId = SIGFOX_SET_RCSYNC_PERIOD_ID;
  com_buffer = com_obj->ParamBuf;
  com_buffer[i++] = (uint32_t) rc_sync_period;
  com_obj->ParamCnt = i;
  MBMUXIF_SigfoxSendCmd();
  /* waiting for event */
  /* once event is received and semaphore released: */

  ret = com_obj->ReturnVal;
  return (sfx_error_t) ret;
  /* USER CODE BEGIN SIGFOX_API_set_rc_sync_period_2 */

  /* USER CODE END SIGFOX_API_set_rc_sync_period_2 */
}

/*!
  * \brief   executes the test modes needed for the Sigfox RF and Protocol Tests
  *
  * \param[in]  sfx_rc_t                    Radio Configuration pointer
  * \param[in]  sfx_test_mode_t test_mode   Test mode to be executed
  * \retval  sfx_error_t Status of the operation. Possible returns are:
  *          \ref SFX_ERR_NONE,
  */
sfx_error_t ADDON_SIGFOX_RF_PROTOCOL_API_test_mode(sfx_rc_enum_t rc_enum, sfx_test_mode_t test_mode)
{
  /* USER CODE BEGIN ADDON_SIGFOX_RF_PROTOCOL_API_test_mode_1 */

  /* USER CODE END ADDON_SIGFOX_RF_PROTOCOL_API_test_mode_1 */
  MBMUX_ComParam_t *com_obj;
  uint32_t *com_buffer ;
  uint16_t i = 0;
  uint32_t ret;

  com_obj = MBMUXIF_GetSigfoxFeatureCmdComPtr();
  com_obj->MsgId = SIGFOX_API_TEST_MODE_ID;
  com_buffer = com_obj->ParamBuf;
  com_buffer[i++] = (uint32_t) rc_enum;
  com_buffer[i++] = (uint32_t) test_mode;
  com_obj->ParamCnt = i;
  MBMUXIF_SigfoxSendCmd();
  /* waiting for event */
  /* once event is received and semaphore released: */

  ret = com_obj->ReturnVal;
  return (sfx_error_t) ret;
  /* USER CODE BEGIN ADDON_SIGFOX_RF_PROTOCOL_API_test_mode_2 */

  /* USER CODE END ADDON_SIGFOX_RF_PROTOCOL_API_test_mode_2 */
}

/*!
  * \brief   executes the test modes needed for the Sigfox RF and Protocol Tests
  *
  * \param[in]  sfx_rc_t                    Radio Configuration pointer
  * \param[in]  sfx_test_mode_t test_mode   Test mode to be executed
  * \param[in]  sfx_u8 rc_capabilities      Radio Capabilities in bitmask format
  * \retval  sfx_error_t Status of the operation. Possible returns are:
  *          \ref SFX_ERR_NONE,
  */
sfx_error_t ADDON_SIGFOX_RF_PROTOCOL_API_monarch_test_mode(sfx_rc_enum_t rc_enum, sfx_test_mode_t test_mode,
                                                           sfx_u8 rc_capabilities)
{
  /* USER CODE BEGIN ADDON_SIGFOX_RF_PROTOCOL_API_monarch_test_mode_1 */

  /* USER CODE END ADDON_SIGFOX_RF_PROTOCOL_API_monarch_test_mode_1 */
  MBMUX_ComParam_t *com_obj;
  uint32_t *com_buffer ;
  uint16_t i = 0;
  uint32_t ret;

  com_obj = MBMUXIF_GetSigfoxFeatureCmdComPtr();
  com_obj->MsgId = SIGFOX_API_MONARCH_TEST_MODE_ID;
  com_buffer = com_obj->ParamBuf;
  com_buffer[i++] = (uint32_t) rc_enum;
  com_buffer[i++] = (uint32_t) test_mode;
  com_buffer[i++] = (uint32_t) rc_capabilities;
  com_obj->ParamCnt = i;
  MBMUXIF_SigfoxSendCmd();
  /* waiting for event */
  /* once event is received and semaphore released: */

  ret = com_obj->ReturnVal;
  return (sfx_error_t) ret;
  /* USER CODE BEGIN ADDON_SIGFOX_RF_PROTOCOL_API_monarch_test_mode_2 */

  /* USER CODE END ADDON_SIGFOX_RF_PROTOCOL_API_monarch_test_mode_2 */
}

/*!
  * \brief   executes a scan of the air to detect a Sigfox Beacon
  *
  * \param[in] sfx_u16 timer                     Scan duration value ( with the unit parameter information )
  * \param[in] sfx_timer_unit_enum_t  unit       Unit to be considered for the scan time computation
  * \param[in] app_callback_handler              This is the function that will be called by the Sigfox Library when the scan is completed.
  *                                              ( either when RC Found or when Timeout )
  *                 parameter of this callback are :
  *                     \param[out] sfx_u8       rc  Value of the RC found. There could be only 1 RC or 0 ( not found )
  *                     \param[out] rssi         RSSI value of the RC found. if rc = 0, rssi is not valid ( is set to 0 too )
  * \retval  sfx_error_t Status of the operation. Possible returns are:
  *          \ref SFX_ERR_NONE,
  *          \ref SFX_ERR_MONARCH_API_xx
  */
sfx_error_t SIGFOX_MONARCH_API_execute_rc_scan(sfx_u8 rc_capabilities_bit_mask, sfx_u16 timer,
                                               sfx_timer_unit_enum_t unit, sfx_u8(* app_callback_handler)(sfx_u8 rc_bit_mask, sfx_s16 rssi))
{
  /* USER CODE BEGIN SIGFOX_MONARCH_API_execute_rc_scan_1 */

  /* USER CODE END SIGFOX_MONARCH_API_execute_rc_scan_1 */
  MBMUX_ComParam_t *com_obj;
  uint32_t *com_buffer ;
  uint16_t i = 0;
  uint32_t ret;

  /*Init callback on M4 side*/
  app_cb = app_callback_handler;

  com_obj = MBMUXIF_GetSigfoxFeatureCmdComPtr();
  com_obj->MsgId = SIGFOX_API_MONARCH_TEST_EXEC_RC_SCAN_ID;
  com_buffer = com_obj->ParamBuf;
  com_buffer[i++] = (uint32_t) rc_capabilities_bit_mask;
  com_buffer[i++] = (uint32_t) timer;
  com_buffer[i++] = (uint32_t) unit;
  com_buffer[i++] = (uint32_t) app_cb;
  com_obj->ParamCnt = i;
  MBMUXIF_SigfoxSendCmd();
  /* waiting for event */
  /* once event is received and semaphore released: */

  ret = com_obj->ReturnVal;
  return (sfx_error_t) ret;
  /* USER CODE BEGIN SIGFOX_MONARCH_API_execute_rc_scan_2 */

  /* USER CODE END SIGFOX_MONARCH_API_execute_rc_scan_2 */
}

/*!
  * \brief    stops a RC scan which is on going
  *
  * \retval  sfx_error_t Status of the operation. Possible returns are:
  *          \ref SFX_ERR_NONE,
  *          \ref SFX_ERR_MONARCH_API_xx
  */
sfx_error_t SIGFOX_MONARCH_API_stop_rc_scan(void)
{
  /* USER CODE BEGIN SIGFOX_MONARCH_API_stop_rc_scan_1 */

  /* USER CODE END SIGFOX_MONARCH_API_stop_rc_scan_1 */
  MBMUX_ComParam_t *com_obj;
  uint32_t ret;

  com_obj = MBMUXIF_GetSigfoxFeatureCmdComPtr();
  com_obj->MsgId = SIGFOX_API_MONARCH_STOP_RC_SCAN_ID;
  com_obj->ParamCnt = 0;
  MBMUXIF_SigfoxSendCmd();
  /* waiting for event */
  /* once event is received and semaphore released: */
  ret = com_obj->ReturnVal;
  return (sfx_error_t) ret;
  /* USER CODE BEGIN SIGFOX_MONARCH_API_stop_rc_scan_2 */

  /* USER CODE END SIGFOX_MONARCH_API_stop_rc_scan_2 */
}

/**
  * @brief initialises the SigfoxInfo capabilities table
  * @param none
  * @retval  none
  */
void SigfoxInfo_Init(void)
{
  /* USER CODE BEGIN SigfoxInfo_Init_1 */

  /* USER CODE END SigfoxInfo_Init_1 */
  MBMUX_ComParam_t *com_obj;

  com_obj = MBMUXIF_GetSigfoxFeatureCmdComPtr();
  com_obj->MsgId = SIGFOX_INFO_INIT_ID;
  com_obj->ParamCnt = 0;
  MBMUXIF_SigfoxSendCmd();
  /* waiting for event */
  /* once event is received and semaphore released: */
  return;
  /* USER CODE BEGIN SigfoxInfo_Init_2 */

  /* USER CODE END SigfoxInfo_Init_2 */
}

/**
  * @brief returns the pointer to the SigfoxInfo capabilities table
  * @param none
  * @retval  SigfoxInfoTable pointer
  */
SigfoxInfo_t *SigfoxInfo_GetPtr(void)
{
  /* USER CODE BEGIN SigfoxInfo_GetPtr_1 */

  /* USER CODE END SigfoxInfo_GetPtr_1 */
  FEAT_INFO_Param_t  *p_feature;

  p_feature = MBMUXIF_SystemGetFeatCapabInfoPtr(FEAT_INFO_SIGFOX_ID);
  return (SigfoxInfo_t *) p_feature->Feat_Info_Config_Ptr ;
  /* USER CODE BEGIN SigfoxInfo_GetPtr_2 */

  /* USER CODE END SigfoxInfo_GetPtr_2 */
}

void Sigfox_Register(SigfoxCallback_t *SigfoxCallback)
{
  /* USER CODE BEGIN Sigfox_Register_1 */

  /* USER CODE END Sigfox_Register_1 */
  callback_wrap = SigfoxCallback;
  /* USER CODE BEGIN Sigfox_Register_2 */

  /* USER CODE END Sigfox_Register_2 */
}
/**
  * @brief This function processes the callbacks and primitives from Cm0
  * @param ComObj : parameters
  * @retval none
  */

void Process_Sigfox_Notif(MBMUX_ComParam_t *ComObj)
{
  /* USER CODE BEGIN Process_Sigfox_Notif_1 */

  /* USER CODE END Process_Sigfox_Notif_1 */
  uint32_t    cb_ret;

  APP_LOG(TS_ON, VLEVEL_H, "CM4 - Sigfox Notif received \n\r");

  /* process Command */
  switch (ComObj->MsgId)
  {
    /* callbacks */
    case SIGFOX_GET_BATTERY_LEVEL_CB_ID:
      if (callback_wrap->GetBatteryLevel != NULL)
      {
        cb_ret = (uint32_t) callback_wrap->GetBatteryLevel();
      }
      else
      {
        while (1) {}
      }
      /* prepare response buffer */
      ComObj->ParamCnt = 0; /* reset ParamCnt */
      ComObj->ReturnVal =  cb_ret; /* */
      break;

    case SIGFOX_GET_TEMPERATURE_LEVEL_CB_ID:
      if (callback_wrap->GetTemperatureLevel != NULL)
      {
        cb_ret = (uint32_t) callback_wrap->GetTemperatureLevel();
      }
      else
      {
        while (1) {}
      }
      /* prepare response buffer */
      ComObj->ParamCnt = 0; /* reset ParamCnt */
      ComObj->ReturnVal =  cb_ret; /* */
      break;

    case SIGFOX_MONARCH_RC_SCAN_CB_ID:
      if (app_cb != NULL)
      {
        cb_ret = (sfx_u8) app_cb((sfx_u8)ComObj->ParamBuf[0], (sfx_s16) ComObj->ParamBuf[1]);
      }
      else
      {
        while (1) {}
      }
      /* prepare response buffer */
      ComObj->ParamCnt = 0; /* reset ParamCnt */
      ComObj->ReturnVal =  cb_ret; /* */
      break;

    default:
      break;
  }

  /* send Ack */
  APP_LOG(TS_ON, VLEVEL_H,  "CM4 - Sigfox sending ack \n\r");
  MBMUX_AcknowledgeSnd(FEAT_INFO_SIGFOX_ID);
  /* USER CODE BEGIN Process_Sigfox_Notif_2 */

  /* USER CODE END Process_Sigfox_Notif_2 */
}

/* Private Functions Definition -----------------------------------------------*/
/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
