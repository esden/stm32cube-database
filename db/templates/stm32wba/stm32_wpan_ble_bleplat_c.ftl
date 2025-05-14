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
[#assign PG_FILL_UCS = "False"]
[#assign PG_BSP_NUCLEO_WBA52CG = 0]
[#assign PG_VALIDATION = 0]
[#assign PG_SKIP_LIST = "False"]
[#assign myHash = {}]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#assign myHash = {definition.name:definition.value} + myHash]
        [/#list]
    [/#if]
[/#list]
[#--
Key & Value:
[#list myHash?keys as key]
Key: ${key}; Value: ${myHash[key]}
[/#list]
--]

#include "app_common.h"
#include "bleplat.h"
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
#include "nvm.h"
[/#if]
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
#include "baes.h"
#include "bpka.h"
#include "ble_timer.h"
#include "blestack.h"
#include "host_stack_if.h"
[#else]
#include "stm32wbaxx_ll_rng.h"
#include "stm32wbaxx_ll_bus.h"
[/#if]

#include "ble_wrap.c"

/*****************************************************************************/

void BLEPLAT_Init( void )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  BAES_Reset( );
  BPKA_Reset( );
  BLE_TIMER_Init();
[#else]
  return;
[/#if]
}

/*****************************************************************************/

int BLEPLAT_NvmAdd( uint8_t type,
                    const uint8_t* data,
                    uint16_t size,
                    const uint8_t* extra_data,
                    uint16_t extra_size )
{
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
  return NVM_Add( type, data, size, extra_data, extra_size );
[#else]
  return 0;
[/#if]
}

/*****************************************************************************/

int BLEPLAT_NvmGet( uint8_t mode,
                    uint8_t type,
                    uint16_t offset,
                    uint8_t* data,
                    uint16_t size )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
  return NVM_Get( mode, type, offset, data, size );
[#else]
  return 0;
[/#if]
[#else]
  return -3; // Simulate end of NVM  
[/#if]
}

/*****************************************************************************/

int BLEPLAT_NvmCompare( uint16_t offset,
                        const uint8_t* data,
                        uint16_t size )
{
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
  return NVM_Compare( offset, data, size );
[#else]
  return 0;
[/#if]
}

/*****************************************************************************/

void BLEPLAT_NvmDiscard( uint8_t mode )
{
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
  NVM_Discard( mode );
[#else]
  return;
[/#if]
}

/*****************************************************************************/

void BLEPLAT_RngGet( uint8_t n,
                     uint32_t* val )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  /* Read 32-bit random values from HW driver */
  HW_RNG_Get( n, val );
[#else]
  LL_AHB2_GRP1_EnableClock( LL_AHB2_GRP1_PERIPH_RNG );        
  LL_RNG_Enable( RNG );                                         
  while ( n-- )
  {
    *val++=LL_RNG_ReadRandData32( RNG );
  }
[/#if]
}

/*****************************************************************************/

void BLEPLAT_AesEcbEncrypt( const uint8_t* key,
                            const uint8_t* input,
                            uint8_t* output )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  BAES_EcbCrypt( key, input, output, 1 );
[#else]
  return;
[/#if]
}

/*****************************************************************************/

void BLEPLAT_AesCmacSetKey( const uint8_t* key )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  BAES_CmacSetKey( key );
[#else]
  return;
[/#if]
}

/*****************************************************************************/

void BLEPLAT_AesCmacCompute( const uint8_t* input,
                             uint32_t input_length,
                             uint8_t* output_tag )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  BAES_CmacCompute( input, input_length, output_tag );
[#else]
  return;
[/#if]
}

/*****************************************************************************/

int BLEPLAT_AesCcmCrypt( uint8_t mode,
                         const uint8_t* key,
                         uint8_t iv_length,
                         const uint8_t* iv,
                         uint16_t add_length,
                         const uint8_t* add,
                         uint32_t input_length,
                         const uint8_t* input,
                         uint8_t tag_length,
                         uint8_t* tag,
                         uint8_t* output )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  return BAES_CcmCrypt( mode, key, iv_length, iv, add_length, add,
                        input_length, input, tag_length, tag, output );
[#else]
  return 0;
[/#if]
}

/*****************************************************************************/

int BLEPLAT_PkaStartP256Key( const uint32_t* local_private_key )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  return BPKA_StartP256Key( local_private_key );
[#else]
  return 0;
[/#if]
}

/*****************************************************************************/

void BLEPLAT_PkaReadP256Key( uint32_t* local_public_key )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  BPKA_ReadP256Key( local_public_key );
[#else]
  return;
[/#if]
}

/*****************************************************************************/

int BLEPLAT_PkaStartDhKey( const uint32_t* local_private_key,
                           const uint32_t* remote_public_key )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  return BPKA_StartDhKey( local_private_key, remote_public_key );
[#else]
  return 0;
[/#if]
}

/*****************************************************************************/

int BLEPLAT_PkaReadDhKey( uint32_t* dh_key )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  return BPKA_ReadDhKey( dh_key );
[#else]
  return 0;
[/#if]
}

[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
/*****************************************************************************/

void BPKACB_Complete( void )
{
  BLEPLATCB_PkaComplete( );

  BleStackCB_Process( );
}

[/#if]
/*****************************************************************************/

uint8_t BLEPLAT_TimerStart( uint16_t layer,
                            uint32_t timeout )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  return BLE_TIMER_Start( layer, timeout );
[#else]
  return 0;
[/#if]
}

/*****************************************************************************/

void BLEPLAT_TimerStop( uint16_t layer )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  BLE_TIMER_Stop( layer );
[#else]
  return;
[/#if]
}

/*****************************************************************************/
