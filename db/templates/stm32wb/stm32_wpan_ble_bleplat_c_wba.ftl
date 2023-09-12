[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    bleplat.c
  * @author  MCD Application Team
  * @brief   This file implements the platform functions for BLE stack library.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include "app_common.h"
#include "bleplat.h"
#include "nvm.h"
#include "baes.h"
#include "bpka.h"
#include "ble_timer.h"

/*****************************************************************************/

void BLEPLAT_Init( void )
{
  BAES_Reset( );
  BLE_TIMER_Init( );
}

/*****************************************************************************/

int BLEPLAT_NvmAdd( uint8_t type,
                    const uint8_t* data,
                    uint16_t size,
                    const uint8_t* extra_data,
                    uint16_t extra_size )
{
  return NVM_Add( type, data, size, extra_data, extra_size );
}

/*****************************************************************************/

int BLEPLAT_NvmGet( uint8_t mode,
                    uint8_t type,
                    uint16_t offset,
                    uint8_t* data,
                    uint16_t size )
{
  return NVM_Get( mode, type, offset, data, size );
}

/*****************************************************************************/

int BLEPLAT_NvmCompare( uint16_t offset,
                        const uint8_t* data,
                        uint16_t size )
{
  return NVM_Compare( offset, data, size );
}

/*****************************************************************************/

void BLEPLAT_NvmDiscard( uint8_t mode )
{
  NVM_Discard( mode );
}

/*****************************************************************************/

void BLEPLAT_RngGet( uint8_t n,
                     uint32_t* val )
{
  /* Read 32-bit random values from HW driver */
  HW_RNG_Get( n, val );
}

/*****************************************************************************/

void BLEPLAT_AesEcbEncrypt( const uint8_t* key,
                            const uint8_t* input,
                            uint8_t* output )
{
  BAES_EcbCrypt( key, input, output, 1 );
}

/*****************************************************************************/

void BLEPLAT_AesCmacSetKey( const uint8_t* key )
{
  BAES_CmacSetKey( key );
}

/*****************************************************************************/

void BLEPLAT_AesCmacCompute( const uint8_t* input,
                             uint32_t input_length,
                             uint8_t* output_tag )
{
  BAES_CmacCompute( input, input_length, output_tag );
}

/*****************************************************************************/

int BLEPLAT_PkaStartP256Key( const uint32_t* local_private_key )
{
  return BPKA_StartP256Key( local_private_key );
}

/*****************************************************************************/

void BLEPLAT_PkaReadP256Key( uint32_t* local_public_key )
{
  BPKA_ReadP256Key( local_public_key );
}

/*****************************************************************************/

int BLEPLAT_PkaStartDhKey( const uint32_t* local_private_key,
                           const uint32_t* remote_public_key )
{
  return BPKA_StartDhKey( local_private_key, remote_public_key );
}

/*****************************************************************************/

int BLEPLAT_PkaReadDhKey( uint32_t* dh_key )
{
  return BPKA_ReadDhKey( dh_key );
}

/*****************************************************************************/

void BPKACB_Complete( void )
{
  BLEPLATCB_PkaComplete( );
}

/*****************************************************************************/

uint8_t BLEPLAT_TimerStart( uint8_t layer,
                            uint32_t timeout )
{
  return BLE_TIMER_Start( (uint16_t)layer, timeout );
}

/*****************************************************************************/

void BLEPLAT_TimerStop( uint8_t layer )
{
  BLE_TIMER_Stop( (uint16_t)layer );
}

/*****************************************************************************/

void BLE_TIMERCB_Expiry( uint8_t layer )
{
  BLEPLATCB_TimerExpiry( layer );
}

/*****************************************************************************/

uint8_t BLEPLAT_ConfigureDataPath( uint8_t data_path_direction,
                                   uint8_t data_pathID,
                                   uint8_t vendor_specific_config_length,
                                   const uint8_t* vendor_specific_config )
{
  return 0;
}

uint8_t BLEPLAT_ReadLocalSupportedCodecs(
                                uint8_t* num_supported_standard_codecs,
                                uint16_t* Std_Codec,
                                uint8_t* Num_Supported_Vendor_Specific_Codecs,
                                uint16_t* VS_Codec )
{
  return 0;
}

uint8_t BLEPLAT_ReadLocalSupportedCodecCapabilities(
                                        const uint8_t* codecID,
                                        uint8_t logical_transport_type,
                                        uint8_t direction,
                                        uint8_t* num_codec_capabilities,
                                        uint8_t* codec_capability )
{
  return 0;
}

uint8_t BLEPLAT_ReadLocalSupportedControllerDelay(
                                        const uint8_t* codec_ID,
                                        uint8_t logical_transport_type,
                                        uint8_t direction,
                                        uint8_t codec_configuration_length,
                                        const uint8_t* codec_configuration,
                                        uint8_t* min_controller_delay,
                                        uint8_t* max_controller_delay )
{
  return 0;
}

void BLEPLAT_LeSyncEvent(uint8_t group_id,
                              uint32_t next_anchor_point,
                              uint32_t time_stamp)
{

}

void BLEPLAT_GroupParamEvent(uint8_t opcode,
                                   uint8_t big_handle,
                                   uint8_t cig_id,
                                   uint16_t iso_interval,
                                   uint16_t* connection_handle)
{

}

void BLEPLAT_CalibrationCallback( void )
{

}

/*****************************************************************************/
