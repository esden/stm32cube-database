[#ftl]
/**
  ******************************************************************************
  * @file    sgfx_credentials.h
  * @author  MCD Application Team
  * @brief   interface to key manager and encryption algorithm
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
[#--
********************************
SWIP Data:

[#if SWIPdatas??]
  [#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
Defines:
      [#list SWIP.defines as definition]
        ${definition.name}: ${definition.value}
      [/#list]
    [/#if]
  [/#list]
[/#if]
********************************
--]
[#assign SUBGHZ_APPLICATION = ""]
[#list SWIPdatas as SWIP]
  [#if SWIP.defines??]
    [#list SWIP.defines as definition]
            [#if definition.name == "SUBGHZ_APPLICATION"]
                [#assign SUBGHZ_APPLICATION = definition.value]
            [/#if]
        [/#list]
  [/#if]
[/#list]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __SGFX_CREDENTIALS_H__
#define __SGFX_CREDENTIALS_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if (SUBGHZ_APPLICATION != "SIGFOX_USER_APPLICATION")]
#include <stdint.h>
#include "sigfox_types.h"

[/#if]
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/

/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
#define AES_KEY_LEN 16 /* bytes */

/* encrypted_sigfox_data defines size */
#define MANUF_DEVICE_ID_LENGTH      4
#define MANUF_SIGNATURE_LENGTH     16
#define MANUF_VER_LENGTH            1
#define MANUF_SPARE_1               3
#define MANUF_DEVICE_KEY_LENGTH    16
#define MANUF_PAC_LENGTH            8
#define MANUF_SPARE_2              14
#define MANUF_CRC_LENGTH            2

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/**
  * @brief get the cmac library version
  * @retval return a string containing the library version
  */
const char *CREDENTIALS_get_version(void);

/**
  * @brief get the loaded dev_id
  * @param[out] return the dev_id in the pointer
  */
void CREDENTIALS_get_dev_id(uint8_t *dev_id);

/**
  * @brief get the loaded pac
  * @param[out] return the pac in the pointer
  */
void CREDENTIALS_get_initial_pac(uint8_t *pac);

/**
  * @brief get the payload_encryption_flag
  * @retval  the payload_encryption_flag
  */
sfx_bool CREDENTIALS_get_payload_encryption_flag(void);

/**
  * @brief set the payload_encryption_flag
  * @param[in] enable flag. 0: disable, 1: enable
  * @retval  none
  */
void CREDENTIALS_set_payload_encryption_flag(uint8_t enable);

/**
  * @brief encrypts the data_to_encrypt with aes secrete Key
  * @param[out] the encrypted data
  * @param[in] the data_to_encrypt
  * @param[in] the number of aes blocks
  */
sfx_error_t CREDENTIALS_aes_128_cbc_encrypt(uint8_t *encrypted_data, uint8_t *data_to_encrypt, uint8_t block_len);

/**
  * @brief encrypts the data_to_encrypt with aes session Key
  * @param[out] the encrypted data
  * @param[in] the data_to_encrypt
  * @param[in] the number of aes blocks
  */
sfx_error_t CREDENTIALS_aes_128_cbc_encrypt_with_session_key(uint8_t *encrypted_data, uint8_t *data_to_encrypt,
                                                             uint8_t block_len);

/**
  * @brief wraps the session Key
  * @param[in] the arguments used to generate the session Key
  * @param[in] the number of aes blocks
  */
sfx_error_t CREDENTIALS_wrap_session_key(uint8_t *data, uint8_t blocks);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __SGFX_CREDENTIALS_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
