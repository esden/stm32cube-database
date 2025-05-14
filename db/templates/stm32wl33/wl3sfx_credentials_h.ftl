[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    wl3sfx_credentials.h
  * @author  GPM WBL Application Team
  * @brief   Sigfox credentials management (ID / PAC / NAK) for STM32WL3. The implementation of this module is not public.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include <stdint.h>
#include "ST_Sigfox_Types.h"

#ifndef __WL3SFX_CREDENTIALS_H
#define __WL3SFX_CREDENTIALS_H

/**
 * @addtogroup WL3SFX
 * @{
 * @addtogroup WL3SFX_CREDENTIALS Credentials Management
 * @brief Sigfox credentials management (ID / PAC / NAK) and board flash credentials retriever
 * @{
 */

/** Mode with which Sigfox credentials in flash memory are encrypted. */
typedef enum {
  /** Encryption with a fixed key */
  WL3SFX_CREDENTIALS_MODE_FIXED = 0x01,
  // variable encryption mode not yet supported (lack of UID)
  /** No encryption */
  WL3SFX_CREDENTIALS_MODE_NONE = 0x03
} WL3SFX_CREDENTIALS_EncryptionMode;

/** Type of encryption key. */
typedef enum {
  /** Board-specific encryption key that is stored in flash memory. */
  WL3SFX_CREDENTIALS_ENCKEY_BOARD = 0,

  /** Test mode encryption key <i>0x0123456789ABCDEF0123456789ABCDEF</i>. */
  WL3SFX_CREDENTIALS_ENCKEY_TEST,

  /** Public key, i.e. <i>0x00112233445566778899AABBCCDDEEFF</i>. */
  WL3SFX_CREDENTIALS_ENCKEY_PUBLIC
} WL3SFX_CREDENTIALS_EncryptionKeyType;

/** Result type for credentials management functions. */
typedef enum {
  /** Successful */
  WL3SFX_CREDENTIALS_OK = 0,

  /** Error (unspecified) */
  WL3SFX_CREDENTIALS_ERR
} WL3SFX_CREDENTIALS_Result;

/**
 * @brief Retrieve board information according to the ST_SFX_BoardCredentials and returns it to the caller.
 *
 * @param[out] credentials: pointer to a struct of the type of ST_SFX_BoardCredentials.
 *
 * @retval Error code: WL3SFX_CREDENTIALS_OK (0) or WL3SFX_CREDENTIALS_ERR (1)
 */
WL3SFX_CREDENTIALS_Result wl3sfx_credentials_retrieve(ST_SFX_BoardCredentials* credentials);

/**
 * @brief Perform the AES128-CBC encryption using the AES KEY associated to the board.
 *
 * @param[out] encrypted_data pointer to the destination buffer where the encrypted data must be stored.
 * @param[in] data_to_encrypt pointer to the source buffer where the data to encrypt are stored.
 * @param[in] data_len length of the data buffer to encrypt.
 * @param[in] key pointer to key to use if useExternalKey is specified
 * @param[in] useExternalKey if 0, use current default key (board key, public key or test key); if 1, use specified key
 *
 * @retval Error code: WL3SFX_CREDENTIALS_OK (0) or WL3SFX_CREDENTIALS_ERR (1)
 */
WL3SFX_CREDENTIALS_Result wl3sfx_credentials_encrypt(
  uint8_t* encrypted_data, uint8_t* data_to_encrypt, uint16_t data_len, uint8_t* key, uint8_t useExternalKey);

/**
 * @brief Switch the to the specified key type.
 *
 * @param[in] WL3SFX_CREDENTIALS_EncryptionKeyType type: type of key to switch to. <i>0x0123456789ABCDEF0123456789ABCDEF</i> for
 * WL3SFX_CREDENTIALS_ENCKEY_TEST, <i>0x00112233445566778899AABBCCDDEEFF</i> for WL3SFX_CREDENTIALS_ENCKEY_PUBLIC and the board's default key
 * from memory for WL3SFX_CREDENTIALS_ENCKEY_BOARD.
 *
 * @retval Error code: WL3SFX_CREDENTIALS_OK (0) or WL3SFX_CREDENTIALS_ERR (1)
 */
WL3SFX_CREDENTIALS_Result wl3sfx_credentials_set_key(WL3SFX_CREDENTIALS_EncryptionKeyType type);

/**
 * @brief Switch the to the test ID <i>0xFEDCBA98</i>.
 *
 * @param[in] en: if 1 switch to the test ID, else restore the one associated with the board.
 *
 * @retval Error code: WL3SFX_CREDENTIALS_OK (0) or WL3SFX_CREDENTIALS_ERR (1)
 */
WL3SFX_CREDENTIALS_Result wl3sfx_credentials_set_test_id(uint8_t en);

/**
 * @brief Gets the ID from the EEPROM on the board.
 *
 * @param[out] id: pointer to the array where the ID should be stored.
 * \note: The function \ref wl3sfx_credentials_retrieve is called in the
 *  initialization phase of the board.
 *
 * @retval Error code: WL3SFX_CREDENTIALS_OK (0) or WL3SFX_CREDENTIALS_ERR (1)
 */
WL3SFX_CREDENTIALS_Result wl3sfx_credentials_get_id(uint8_t* id);

/**
 * @brief Gets the PAC from the EEPROM on the board.
 *
 * @param[out] pac: pointer to the array where the PAC should be stored.
 * \note: The function \ref wl3sfx_credentials_retrieve is called in the
 *  initialization phase of the board.
 *
 * @retval Error code: WL3SFX_CREDENTIALS_OK (0) or WL3SFX_CREDENTIALS_ERR (1)
 */
WL3SFX_CREDENTIALS_Result wl3sfx_credentials_get_initial_pac(uint8_t* pac);

/**
 * @brief Set payload encryption flag. This change is not persistent over device restarts.
 *
 * @param flag Value of payload encryption flag (1 = encrypt, 0 = do not encrypt)
 *
 * @retval Error code: WL3SFX_CREDENTIALS_OK (0) or WL3SFX_CREDENTIALS_ERR (1)
 */
WL3SFX_CREDENTIALS_Result wl3sfx_credentials_set_payload_encryption_flag(uint8_t flag);

/**
 * @brief Retrieve value of payload encryption flag
 *
 * @param flag Pointer to the byte where the value of payload encryption flag should be stored.
 *
 * @retval Error code: WL3SFX_CREDENTIALS_OK (0) or WL3SFX_CREDENTIALS_ERR (1)
 */
WL3SFX_CREDENTIALS_Result wl3sfx_credentials_get_payload_encryption_flag(uint8_t* flag);

/** @}@} */

#endif