[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    baes.h
  * @author  MCD Application Team
  * @brief   This file contains the interface of the basic AES software module.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
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

#ifndef BAES_H__
#define BAES_H__


#include <stdint.h>


/* Basic AES module dedicated to BLE stack with the following features:
 *   - AES ECB encryption
 *   - AES CMAC computation
 *
 * Configuration: the file "app_common.h" is included in this module.
 * It must define:
 *   - CFG_BAES_SW equals to 1 for software implementation
 *   - CFG_BAES_SW equals to 0 for use of hardware accelerator
 *
 * Notes:
 *   - only 128-bit key is supported
 *   - re-entrance is not supported
 */

/* General interface */

extern void BAES_Reset( void );

/* AES ECB interface */

extern void BAES_EcbCrypt( const uint8_t* key,
                           const uint8_t* input,
                           uint8_t* output,
                           int enc );


/* AES CMAC interface */

extern void BAES_CmacSetKey( const uint8_t* key );

[#if myHash["OTHER_THAN_BLE"]?number == 1]
extern void BAES_CmacSetVector( const uint8_t * pIV );
[/#if]

extern void BAES_CmacCompute( const uint8_t* input,
                              uint32_t size,
                              uint8_t* output );

/* AES CCM interface */

extern int BAES_CcmCrypt( uint8_t mode,
                          const uint8_t* key,
                          uint8_t iv_length,
                          const uint8_t* iv,
                          uint16_t add_length,
                          const uint8_t* add,
                          uint16_t input_length,
                          const uint8_t* input,
                          uint8_t tag_length,
                          uint8_t* tag,
                          uint8_t* output );


#endif /* BAES_H__ */
