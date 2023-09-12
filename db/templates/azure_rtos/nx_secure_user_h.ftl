[#ftl]
/**************************************************************************/
/*                                                                        */
/*       Copyright (c) Microsoft Corporation. All rights reserved.        */
/*                                                                        */
/*       This software is licensed under the Microsoft Software License   */
/*       Terms for Microsoft Azure RTOS. Full text of the license can be  */
/*       found in the LICENSE file at https://aka.ms/AzureRTOS_EULA       */
/*       and in the root directory of this software.                      */
/*                                                                        */
/**************************************************************************/


/**************************************************************************/
/**************************************************************************/
/**                                                                       */
/** NetX Secure Component                                                 */
/**                                                                       */
/**    Transport Layer Security (TLS)                                     */
/**                                                                       */
/**************************************************************************/
/**************************************************************************/


/**************************************************************************/
/*                                                                        */
/*  PORT SPECIFIC C INFORMATION                            RELEASE        */
/*                                                                        */
/*    nx_secure_user.h                                    PORTABLE C      */
/*                                                           6.1.9        */
/*                                                                        */
/*  AUTHOR                                                                */
/*                                                                        */
/*    Timothy Stapko, Microsoft Corporation                               */
/*                                                                        */
/*  DESCRIPTION                                                           */
/*                                                                        */
/*    This file contains user defines for configuring NetX Secure in      */
/*    specific ways. This file will have an effect only if the            */
/*    application and NetX Secure library are built with                  */
/*    NX_SECURE_INCLUDE_USER_DEFINE_FILE defined.                         */
/*    Note that all the defines in this file may also be made on the      */
/*    command line when building NetX library and application objects.    */
/*                                                                        */
/*  RELEASE HISTORY                                                       */
/*                                                                        */
/*    DATE              NAME                      DESCRIPTION             */
/*                                                                        */
/*  05-19-2020     Timothy Stapko           Initial Version 6.0           */
/*  09-30-2020     Timothy Stapko           Modified comment(s),          */
/*                                            resulting in version 6.1    */
/*  08-02-2021     Timothy Stapko           Modified comment(s),          */
/*                                            resulting in version 6.1.8  */
/*  10-15-2021     Timothy Stapko           Modified comment(s), added    */
/*                                            macro to disable client     */
/*                                            initiated renegotiation for */
/*                                            TLS server instances,       */
/*                                            resulting in version 6.1.9  */
/*                                                                        */
/**************************************************************************/

#ifndef NX_SECURE_USER_H
#define NX_SECURE_USER_H

[#compress]
   
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]

	[#if name == "NX_IP_PERIODIC_RATE"]
      [#assign NX_IP_PERIODIC_RATE_value = value]
    [/#if]
	
	[#if name == "NX_CRYPTO_MAX_RSA_MODULUS_SIZE"]
      [#assign NX_CRYPTO_MAX_RSA_MODULUS_SIZE_value = value]
    [/#if]
	
	[#if name == "NX_CRYPTO_FIPS"]
      [#assign NX_CRYPTO_FIPS_value = value]
    [/#if]
	
	[#if name == "NX_CRYPTO_CBC_MAX_BLOCK_SIZE"]
      [#assign NX_CRYPTO_CBC_MAX_BLOCK_SIZE_value = value]
    [/#if]
	
	[#if name == "NX_CRYPTO_DRBG_BLOCK_LENGTH"]
      [#assign NX_CRYPTO_DRBG_BLOCK_LENGTH_value = value]
    [/#if]
	
	[#if name == "NX_CRYPTO_DRBG_SEED_BUFFER_LEN"]
      [#assign NX_CRYPTO_DRBG_SEED_BUFFER_LEN_value = value]
    [/#if]
	
	[#if name == "NX_CRYPTO_DRBG_MAX_ENTROPY_LEN"]
      [#assign NX_CRYPTO_DRBG_MAX_ENTROPY_LEN_value = value]
    [/#if]
	
	[#if name == "NX_CRYPTO_DRBG_MAX_SEED_LIFE"]
      [#assign NX_CRYPTO_DRBG_MAX_SEED_LIFE_value = value]
    [/#if]
	
	[#if name == "NX_CRYPTO_DRBG_MUTEX_GET"]
      [#assign NX_CRYPTO_DRBG_MUTEX_GET_value = value]
    [/#if]
	
	[#if name == "NX_CRYPTO_DRBG_MUTEX_PUT"]
      [#assign NX_CRYPTO_DRBG_MUTEX_PUT_value = value]
    [/#if]
	
	[#if name == "NX_CRYPTO_DRBG_USE_DF"]
      [#assign NX_CRYPTO_DRBG_USE_DF_value = value]
    [/#if]
	
	[#if name == "NX_CRYPTO_DRBG_PREDICTION_RESISTANCE"]
      [#assign NX_CRYPTO_DRBG_PREDICTION_RESISTANCE_value = value]
    [/#if]
	
	[#if name == "NX_CRYPTO_HARDWARE_RAND_INITIALIZE"]
      [#assign NX_CRYPTO_HARDWARE_RAND_INITIALIZE_value = value]
    [/#if]
	
	[#if name == "NX_CRYPTO_ECDSA_SCRATCH_BUFFER_SIZE"]
      [#assign NX_CRYPTO_ECDSA_SCRATCH_BUFFER_SIZE_value = value]
    [/#if]
	
	[#if name == "NX_CRYPTO_ECDH_SCRATCH_BUFFER_SIZE"]
      [#assign NX_CRYPTO_ECDH_SCRATCH_BUFFER_SIZE_value = value]
    [/#if]	
	
	[#if name == "NX_CRYPTO_ECJPAKE_SCRATCH_BUFFER_SIZE"]
      [#assign NX_CRYPTO_ECJPAKE_SCRATCH_BUFFER_SIZE_value = value]
    [/#if]
	
	[#if name == "NX_CRYPTO_HMAC_MAX_PAD_SIZE"]
      [#assign NX_CRYPTO_HMAC_MAX_PAD_SIZE_value = value]
    [/#if]
	
	[#if name == "NX_CRYPTO_HUGE_NUMBER_BITS"]
      [#assign NX_CRYPTO_HUGE_NUMBER_BITS_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_ALLOW_SELF_SIGNED_CERTIFICATES"]
      [#assign NX_SECURE_ALLOW_SELF_SIGNED_CERTIFICATES_value = value]
    [/#if]

	[#if name == "NX_SECURE_ENABLE_CLIENT_CERTIFICATE_VERIFY"]
      [#assign NX_SECURE_ENABLE_CLIENT_CERTIFICATE_VERIFY_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_TLS_ENABLE_TLS_1_1"]
      [#assign NX_SECURE_TLS_ENABLE_TLS_1_1_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_TLS_ENABLE_TLS_1_3"]
      [#assign NX_SECURE_TLS_ENABLE_TLS_1_3_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_TLS_DISABLE_PROTOCOL_VERSION_DOWNGRADE"]
      [#assign NX_SECURE_TLS_DISABLE_PROTOCOL_VERSION_DOWNGRADE_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_AEAD_CIPHER_CHECK"]
      [#assign NX_SECURE_AEAD_CIPHER_CHECK_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_DISABLE_X509"]
      [#assign NX_SECURE_DISABLE_X509_value = value]
    [/#if]

	[#if name == "NX_SECURE_DTLS_COOKIE_LENGTH"]
      [#assign NX_SECURE_DTLS_COOKIE_LENGTH_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_DTLS_MAXIMUM_RETRANSMIT_RETRIES"]
      [#assign NX_SECURE_DTLS_MAXIMUM_RETRANSMIT_RETRIES_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_DTLS_MAXIMUM_RETRANSMIT_TIMEOUT"]
      [#assign NX_SECURE_DTLS_MAXIMUM_RETRANSMIT_TIMEOUT_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_DTLS_RETRANSMIT_RETRY_SHIFT"]
      [#assign NX_SECURE_DTLS_RETRANSMIT_RETRY_SHIFT_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_DTLS_RETRANSMIT_TIMEOUT"]
      [#assign NX_SECURE_DTLS_RETRANSMIT_TIMEOUT_value = value]
    [/#if]

	[#if name == "NX_SECURE_ENABLE_AEAD_CIPHER"]
      [#assign NX_SECURE_ENABLE_AEAD_CIPHER_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_ENABLE_ECJPAKE_CIPHERSUITE"]
      [#assign NX_SECURE_ENABLE_ECJPAKE_CIPHERSUITE_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_KEY_CLEAR"]
      [#assign NX_SECURE_KEY_CLEAR_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_MEMCMP"]
      [#assign NX_SECURE_MEMCMP_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_MEMCPY"]
      [#assign NX_SECURE_MEMCPY_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_MEMMOVE"]
      [#assign NX_SECURE_MEMMOVE_value = value]
    [/#if]	
	
	[#if name == "NX_SECURE_MEMSET"]
      [#assign NX_SECURE_MEMSET_value = value]
    [/#if]	
	
	[#if name == "NX_SECURE_POWER_ON_SELF_TEST_MODULE_INTEGRITY_CHECK"]
      [#assign NX_SECURE_POWER_ON_SELF_TEST_MODULE_INTEGRITY_CHECK_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_RNG_CHECK_COUNT"]
      [#assign NX_SECURE_RNG_CHECK_COUNT_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_TLS_MAX_PSK_ID_SIZE"]
      [#assign NX_SECURE_TLS_MAX_PSK_ID_SIZE_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_TLS_MAX_PSK_KEYS"]
      [#assign NX_SECURE_TLS_MAX_PSK_KEYS_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_TLS_MAX_PSK_SIZE"]
      [#assign NX_SECURE_TLS_MAX_PSK_SIZE_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_TLS_MINIMUM_CERTIFICATE_SIZE"]
      [#assign NX_SECURE_TLS_MINIMUM_CERTIFICATE_SIZE_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_TLS_MINIMUM_MESSAGE_BUFFER_SIZE"]
      [#assign NX_SECURE_TLS_MINIMUM_MESSAGE_BUFFER_SIZE_value = value]
    [/#if]
			
	[#if name == "NX_SECURE_TLS_PREMASTER_SIZE"]
      [#assign NX_SECURE_TLS_PREMASTER_SIZE_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_TLS_SNI_EXTENSION_DISABLED"]
      [#assign NX_SECURE_TLS_SNI_EXTENSION_DISABLED_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_TLS_USE_SCSV_CIPHPERSUITE"]
      [#assign NX_SECURE_TLS_USE_SCSV_CIPHPERSUITE_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_X509_DISABLE_CRL"]
      [#assign NX_SECURE_X509_DISABLE_CRL_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_ENABLE_DTLS"]
      [#assign NX_SECURE_ENABLE_DTLS_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_DISABLE_ERROR_CHECKING"]
      [#assign NX_SECURE_DISABLE_ERROR_CHECKING_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_TLS_CLIENT_DISABLED"]
      [#assign NX_SECURE_TLS_CLIENT_DISABLED_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_ENABLE_PSK_CIPHERSUITES"]
      [#assign NX_SECURE_ENABLE_PSK_CIPHERSUITES_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_X509_STRICT_NAME_COMPARE"]
      [#assign NX_SECURE_X509_STRICT_NAME_COMPARE_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_X509_USE_EXTENDED_DISTINGUISHED_NAMES"]
      [#assign NX_SECURE_X509_USE_EXTENDED_DISTINGUISHED_NAMES_value = value]
    [/#if]

	[#if name == "NX_SECURE_ENABLE_ECC_CIPHERSUITE"]
      [#assign NX_SECURE_ENABLE_ECC_CIPHERSUITE_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_TLS_ENABLE_SSL_3_0"]
      [#assign NX_SECURE_TLS_ENABLE_SSL_3_0_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_TLS_MAX_PSK_NONCE_SIZE"]
      [#assign NX_SECURE_TLS_MAX_PSK_NONCE_SIZE_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_TLS_ENABLE_SECURE_RENEGOTIATION"]
      [#assign NX_SECURE_TLS_ENABLE_SECURE_RENEGOTIATION_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_X509_CERTIFICATE_VERIFY_EXTENSION"]
      [#assign NX_SECURE_X509_CERTIFICATE_VERIFY_EXTENSION_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_X509_PARSE_CRL_EXTENSION"]
      [#assign NX_SECURE_X509_PARSE_CRL_EXTENSION_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_X509_CRL_VERIFY_EXTENSION"]
      [#assign NX_SECURE_X509_CRL_VERIFY_EXTENSION_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_X509_CERTIFICATE_INITIALIZE_EXTENSION"]
      [#assign NX_SECURE_X509_CERTIFICATE_INITIALIZE_EXTENSION_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_TLS_SERVER_DISABLED"]
      [#assign NX_SECURE_TLS_SERVER_DISABLED_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_TLS_REQUIRE_RENEGOTIATION_EXT"]
      [#assign NX_SECURE_TLS_REQUIRE_RENEGOTIATION_EXT_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_TLS_DISABLE_CLIENT_INITIATED_RENEGOTIATION"]
      [#assign NX_SECURE_TLS_DISABLE_CLIENT_INITIATED_RENEGOTIATION_value = value]
    [/#if]
	
	[#if name == "NX_SECURE_TLS_DISABLE_SECURE_RENEGOTIATION"]
      [#assign NX_SECURE_TLS_DISABLE_SECURE_RENEGOTIATION_value = value]
    [/#if]
	
	[#if name == "NX_CRYPTO_AES_USE_RAM_TABLES"]
      [#assign NX_CRYPTO_AES_USE_RAM_TABLES_value = value]
    [/#if]

  [/#list]
[/#if]
[/#list]
[/#compress]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

/* Define various build options for the NetX Secure port.  The application should either make changes
   here by commenting or un-commenting the conditional compilation defined OR supply the defines
   though the compiler's equivalent of the -D option.  */


/* Override various options with default values already assigned in nx_secure_tls.h */


/* Defined, this option gives the maximum RSA modulus expected, in bits. The 
   default value is 4096 for a 4096-bit modulus. Other values can be 3072, 
   2048, or 1024 (not recommended). */
[#if NX_CRYPTO_MAX_RSA_MODULUS_SIZE_value == "4096"]
/*
#define NX_CRYPTO_MAX_RSA_MODULUS_SIZE	    4096
*/
[#else]
#define NX_CRYPTO_MAX_RSA_MODULUS_SIZE 		${NX_CRYPTO_MAX_RSA_MODULUS_SIZE_value}
[/#if]

/* Defined, this option enables extra security features required for 
   FIPS-Compliant usage. This option is not enabled for non-FIPS build. */
[#if NX_CRYPTO_FIPS_value == "true"]
#define NX_CRYPTO_FIPS
[#else]
/*
#define NX_CRYPTO_FIPS
*/
[/#if]

/* This option defines cbc max block size. The default value is 16.*/
[#if NX_CRYPTO_CBC_MAX_BLOCK_SIZE_value == "16"]
/*
#define NX_CRYPTO_CBC_MAX_BLOCK_SIZE         16
*/
[#else]
#define NX_CRYPTO_CBC_MAX_BLOCK_SIZE         ${NX_CRYPTO_CBC_MAX_BLOCK_SIZE_value}
[/#if]

/* This option defines the drbg block length. 
   The default value is NX_CRYPTO_DRBG_BLOCK_LENGTH_AES.*/
[#if NX_CRYPTO_DRBG_BLOCK_LENGTH_value == "16"]
/*
#define NX_CRYPTO_DRBG_BLOCK_LENGTH         NX_CRYPTO_DRBG_BLOCK_LENGTH_AES
*/
[#else]
#define NX_CRYPTO_DRBG_BLOCK_LENGTH         ${NX_CRYPTO_DRBG_BLOCK_LENGTH_value}
[/#if]

/* This option defines the drbg seed buffer length. The default value is 256.*/
[#if NX_CRYPTO_DRBG_SEED_BUFFER_LEN_value == "256"]
/*
#define NX_CRYPTO_DRBG_SEED_BUFFER_LEN         256
*/
[#else]
#define NX_CRYPTO_DRBG_SEED_BUFFER_LEN         ${NX_CRYPTO_DRBG_SEED_BUFFER_LEN_value}
[/#if]

/* This option defines the drbg max entropy length. The default value is 125.*/
[#if NX_CRYPTO_DRBG_MAX_ENTROPY_LEN_value == "125"]
/*
#define NX_CRYPTO_DRBG_MAX_ENTROPY_LEN         125
*/
[#else]
#define NX_CRYPTO_DRBG_MAX_ENTROPY_LEN         ${NX_CRYPTO_DRBG_MAX_ENTROPY_LEN_value}
[/#if]

/* This option defines the drbg max seed life. The default value is 100000.*/
[#if NX_CRYPTO_DRBG_MAX_SEED_LIFE_value == "100000"]
/*
#define NX_CRYPTO_DRBG_MAX_SEED_LIFE         100000
*/
[#else]
#define NX_CRYPTO_DRBG_MAX_SEED_LIFE         ${NX_CRYPTO_DRBG_MAX_SEED_LIFE_value}
[/#if]

/* Defined, this option enables drbg mutex get.*/
[#if NX_CRYPTO_DRBG_MUTEX_GET_value == "true"]
#define NX_CRYPTO_DRBG_MUTEX_GET        
[#else]
/*
#define NX_CRYPTO_DRBG_MUTEX_GET  
*/     
[/#if]

/* Defined, this option enables drbg mutex put.*/
[#if NX_CRYPTO_DRBG_MUTEX_PUT_value == "true"]
#define NX_CRYPTO_DRBG_MUTEX_PUT        
[#else]
/*
#define NX_CRYPTO_DRBG_MUTEX_PUT  
*/     
[/#if]

/* This option define drbg use df.*/
[#if NX_CRYPTO_DRBG_USE_DF_value == "1"]
/*
#define NX_CRYPTO_DRBG_USE_DF		  1   
*/   
[#else]
#define NX_CRYPTO_DRBG_USE_DF         ${NX_CRYPTO_DRBG_USE_DF_value}     
[/#if]

/* This option defines drbg prediction resistance.*/
[#if NX_CRYPTO_DRBG_PREDICTION_RESISTANCE_value == "1"]
/*
#define NX_CRYPTO_DRBG_PREDICTION_RESISTANCE		  1   
*/   
[#else]
#define NX_CRYPTO_DRBG_PREDICTION_RESISTANCE         ${NX_CRYPTO_DRBG_PREDICTION_RESISTANCE_value}     
[/#if]

/* Defined, this option enables crypto hardware random initialize.*/
[#if NX_CRYPTO_HARDWARE_RAND_INITIALIZE_value == "true"]
#define NX_CRYPTO_HARDWARE_RAND_INITIALIZE		   
[#else]
/*
#define NX_CRYPTO_HARDWARE_RAND_INITIALIZE        
*/   
[/#if]

/* This option defines crypto ecdsa scratch buffer size.*/
[#if NX_CRYPTO_ECDSA_SCRATCH_BUFFER_SIZE_value == "3016"]
/*
#define NX_CRYPTO_ECDSA_SCRATCH_BUFFER_SIZE		    3016  
*/
[#else]
#define NX_CRYPTO_ECDSA_SCRATCH_BUFFER_SIZE         ${NX_CRYPTO_ECDSA_SCRATCH_BUFFER_SIZE_value}             
[/#if]

/* This option defines ecdh scratch buffer size.*/
[#if NX_CRYPTO_ECDH_SCRATCH_BUFFER_SIZE_value == "2464"]
/*
#define NX_CRYPTO_ECDH_SCRATCH_BUFFER_SIZE		   2464  
*/
[#else]
#define NX_CRYPTO_ECDH_SCRATCH_BUFFER_SIZE         ${NX_CRYPTO_ECDH_SCRATCH_BUFFER_SIZE_value}               
[/#if]

/* This option defines the ecjpake scratch buffer size.*/
[#if NX_CRYPTO_ECJPAKE_SCRATCH_BUFFER_SIZE_value == "4096"]
/*
#define NX_CRYPTO_ECJPAKE_SCRATCH_BUFFER_SIZE		    4096  
*/
[#else]
#define NX_CRYPTO_ECJPAKE_SCRATCH_BUFFER_SIZE         ${NX_CRYPTO_ECJPAKE_SCRATCH_BUFFER_SIZE_value}             
[/#if]

/* This option defines the hmac max pad size.*/
[#if NX_CRYPTO_HMAC_MAX_PAD_SIZE_value == "128"]
/*
#define NX_CRYPTO_HMAC_MAX_PAD_SIZE		    128  
*/
[#else]
#define NX_CRYPTO_HMAC_MAX_PAD_SIZE         ${NX_CRYPTO_HMAC_MAX_PAD_SIZE_value}             
[/#if]

/* This option defines the huge number bits.*/
[#if NX_CRYPTO_HUGE_NUMBER_BITS_value == "32"]
/*
#define NX_CRYPTO_HUGE_NUMBER_BITS		    32  
*/
[#else]
#define NX_CRYPTO_HUGE_NUMBER_BITS         ${NX_CRYPTO_HUGE_NUMBER_BITS_value}             
[/#if]

/* Defined, this option allows TLS to accept self-signed certificates from 
   a remote host. By default, TLS will reject self-signed server certificates 
   as a security precaution. If this macro is defined, self-signed certificates
   must still be added to the trusted store to be accepted. */
[#if NX_SECURE_ALLOW_SELF_SIGNED_CERTIFICATES_value == "true"]
#define NX_SECURE_ALLOW_SELF_SIGNED_CERTIFICATES
[#else]
/*
#define NX_SECURE_ALLOW_SELF_SIGNED_CERTIFICATES
*/
[/#if]

/* Defined, this option enables the optional X.509 Client Certificate
   Verification for TLS Servers4. */
[#if NX_SECURE_ENABLE_CLIENT_CERTIFICATE_VERIFY_value == "true"]
#define NX_SECURE_ENABLE_CLIENT_CERTIFICATE_VERIFY
[#else]
/*
#define NX_SECURE_ENABLE_CLIENT_CERTIFICATE_VERIFY
*/
[/#if]

/* Defined, this option enables the legacy TLSv1.1 mode. TLSv1.1 is considered
   obsolete so it should only be enabled for backward-compatibility with older 
   applications.*/
[#if NX_SECURE_TLS_ENABLE_TLS_1_1_value == "true"]
#define NX_SECURE_TLS_ENABLE_TLS_1_1
[#else]
/*
#define NX_SECURE_TLS_ENABLE_TLS_1_1
*/
[/#if]

/* Defined, this option enables TLSv1.3 mode. TLS 1.3 is the newest version of
   TLS and is disabled by default.*/
[#if NX_SECURE_TLS_ENABLE_TLS_1_3_value == "true"]
#define NX_SECURE_TLS_ENABLE_TLS_1_3
[#else]
/*
#define NX_SECURE_TLS_ENABLE_TLS_1_3
*/
[/#if]

/* Defined, this option enables protocol version downgrade for TLS client.*/
[#if NX_SECURE_TLS_DISABLE_PROTOCOL_VERSION_DOWNGRADE_value == "true"]
#define NX_SECURE_TLS_DISABLE_PROTOCOL_VERSION_DOWNGRADE
[#else]
/*
#define NX_SECURE_TLS_DISABLE_PROTOCOL_VERSION_DOWNGRADE
*/
[/#if]

/* Defined, this option enables AEAD ciphersuites other than 
   AES-CCM or AES-GCM working.*/
[#if NX_SECURE_AEAD_CIPHER_CHECK_value == "true"]
#define NX_SECURE_AEAD_CIPHER_CHECK
[#else]
/*
#define NX_SECURE_AEAD_CIPHER_CHECK
*/
[/#if]

/* Defined, this option disables X509 feature.*/
[#if NX_SECURE_DISABLE_X509_value == "true"]
#define NX_SECURE_DISABLE_X509
[#else]
/*
#define NX_SECURE_DISABLE_X509
*/
[/#if]

/* This option defines the length of DTLS cookie. */
[#if NX_SECURE_DTLS_COOKIE_LENGTH_value == "32"]
/*
#define NX_SECURE_DTLS_COOKIE_LENGTH         32
*/ 
[#else]
#define NX_SECURE_DTLS_COOKIE_LENGTH         ${NX_SECURE_DTLS_COOKIE_LENGTH_value}
[/#if]

/* This option defines the maximum retransmit retries for 
   DTLS handshake packet. */
[#if NX_SECURE_DTLS_MAXIMUM_RETRANSMIT_RETRIES_value == "10"]
/*
#define NX_SECURE_DTLS_MAXIMUM_RETRANSMIT_RETRIES         10
*/
[#else]
#define NX_SECURE_DTLS_MAXIMUM_RETRANSMIT_RETRIES         ${NX_SECURE_DTLS_MAXIMUM_RETRANSMIT_RETRIES_value}
[/#if]

/* This option defines the maximum DTLS retransmit rate. The default value is 
   60 * NX_IP_PERIODIC_RATE. */
[#if NX_SECURE_DTLS_MAXIMUM_RETRANSMIT_TIMEOUT_value == "6000" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_SECURE_DTLS_MAXIMUM_RETRANSMIT_TIMEOUT         (60 * NX_IP_PERIODIC_RATE)
*/
[#else]
#define NX_SECURE_DTLS_MAXIMUM_RETRANSMIT_TIMEOUT         ${NX_SECURE_DTLS_MAXIMUM_RETRANSMIT_TIMEOUT_value}
[/#if]

/* This option defines how the retransmit timeout period changes between 
   successive retries.   If this value is 0, the initial retransmit timeout
   is the same as subsequent retransmit timeouts. If this value is 1, 
   each successive retransmit is twice as long.  */
[#if NX_SECURE_DTLS_RETRANSMIT_RETRY_SHIFT_value == "1"]
/*
#define NX_SECURE_DTLS_RETRANSMIT_RETRY_SHIFT         1
*/
[#else]
#define NX_SECURE_DTLS_RETRANSMIT_RETRY_SHIFT         ${NX_SECURE_DTLS_RETRANSMIT_RETRY_SHIFT_value}
[/#if]

/* This option defines the initial DTLS retransmit rate. */
[#if NX_SECURE_DTLS_RETRANSMIT_TIMEOUT_value == "100" && NX_IP_PERIODIC_RATE_value == "100"]
/*
#define NX_SECURE_DTLS_RETRANSMIT_TIMEOUT        NX_IP_PERIODIC_RATE 
*/
[#else]
#define NX_SECURE_DTLS_RETRANSMIT_TIMEOUT         ${NX_SECURE_DTLS_RETRANSMIT_TIMEOUT_value}
[/#if]

/* Defined, this option enables AEAD ciphersuites. */
[#if NX_SECURE_ENABLE_AEAD_CIPHER_value == "true"]
#define NX_SECURE_ENABLE_AEAD_CIPHER  
[#else]
/*
#define NX_SECURE_ENABLE_AEAD_CIPHER
*/
[/#if]

/* Defined, this option enables ECJPAKE ciphersuites for DTLS. */
[#if NX_SECURE_ENABLE_ECJPAKE_CIPHERSUITE_value == "true"]
#define NX_SECURE_ENABLE_ECJPAKE_CIPHERSUITE 
[#else]
/*
#define NX_SECURE_ENABLE_ECJPAKE_CIPHERSUITE
*/
[/#if]

/* Defined, this option enables key related materials cleanup 
   when they are not used anymore. */
[#if NX_SECURE_KEY_CLEAR_value == "true"]
#define NX_SECURE_KEY_CLEAR
[#else]
/*
#define NX_SECURE_KEY_CLEAR  
*/
[/#if]


/* This option defines the memory compare function. */
[#if NX_SECURE_MEMCMP_value == "memcmp"]
/*
#define NX_SECURE_MEMCMP         "memcmp"
*/
[#else]
#define NX_SECURE_MEMCMP         "${NX_SECURE_MEMCMP_value}"
[/#if]

/* This option defines the memory copy function. */
[#if NX_SECURE_MEMCPY_value == "memcpy"]
/*
#define NX_SECURE_MEMCPY         "memcpy"
*/
[#else]
#define NX_SECURE_MEMCPY         "${NX_SECURE_MEMCPY_value}"
[/#if]

/* This option defines the memory move function. */
[#if NX_SECURE_MEMMOVE_value == "memmove"]
/*
#define NX_SECURE_MEMMOVE         "memmove"
*/
[#else]
#define NX_SECURE_MEMMOVE         "${NX_SECURE_MEMMOVE_value}"
[/#if]

/* This option defines the memory set function. */
[#if NX_SECURE_MEMSET_value == "memset"]
/*
#define NX_SECURE_MEMSET         "memset"
*/
[#else]
#define NX_SECURE_MEMSET         "${NX_SECURE_MEMSET_value}"
[/#if]

/* This option enables module integrity self test. */
[#if NX_SECURE_POWER_ON_SELF_TEST_MODULE_INTEGRITY_CHECK_value == "true"]
#define NX_SECURE_POWER_ON_SELF_TEST_MODULE_INTEGRITY_CHECK 
[#else]
/*
#define NX_SECURE_POWER_ON_SELF_TEST_MODULE_INTEGRITY_CHECK  
*/      
[/#if]

/* This option defines the random number check for duplication. */
[#if NX_SECURE_RNG_CHECK_COUNT_value == "3"]
/*
#define NX_SECURE_RNG_CHECK_COUNT         3
*/
[#else]
#define NX_SECURE_RNG_CHECK_COUNT         ${NX_SECURE_RNG_CHECK_COUNT_value}
[/#if]

/* This option defines the maximum size of PSK ID. */
[#if NX_SECURE_TLS_MAX_PSK_ID_SIZE_value == "20"]
/*
#define NX_SECURE_TLS_MAX_PSK_ID_SIZE         20
*/
[#else]
#define NX_SECURE_TLS_MAX_PSK_ID_SIZE         ${NX_SECURE_TLS_MAX_PSK_ID_SIZE_value}
[/#if]

/* This option defines the maximum PSK keys. */
[#if NX_SECURE_TLS_MAX_PSK_KEYS_value == "5"]
/*
#define NX_SECURE_TLS_MAX_PSK_KEYS         5
*/
[#else]
#define NX_SECURE_TLS_MAX_PSK_KEYS         ${NX_SECURE_TLS_MAX_PSK_KEYS_value}
[/#if]

/* This option defines the maximum size of PSK. */
[#if NX_SECURE_TLS_MAX_PSK_SIZE_value == "64"]
/*
#define NX_SECURE_TLS_MAX_PSK_SIZE         64
*/
[#else]
#define NX_SECURE_TLS_MAX_PSK_SIZE         ${NX_SECURE_TLS_MAX_PSK_SIZE_value}
[/#if]

/* This option defines a minimum reasonable size for a TLS X509 certificate.
   This is used in checking for * errors in allocating certificate space. 
   The size is determined by assuming a 512-bit RSA key, MD5 hash, and 
   a rough estimate of other data. It is theoretically possible for a 
   real certificate to be smaller, but in that case, bypass the error 
   checking by re-defining this macro.   
   Approximately: 64(RSA) + 16(MD5) + 176(ASN.1 + text data, common name, etc) */
[#if NX_SECURE_TLS_MINIMUM_CERTIFICATE_SIZE_value == "256"]
/*
#define NX_SECURE_TLS_MINIMUM_CERTIFICATE_SIZE         256
*/
[#else]
#define NX_SECURE_TLS_MINIMUM_CERTIFICATE_SIZE         ${NX_SECURE_TLS_MINIMUM_CERTIFICATE_SIZE_value}
[/#if]

/* This option defines the minimum size for the TLS message buffer.
   It is determined by a number of factors, but primarily the expected size 
   of the TLS handshake Certificate message (sent by the TLS server) 
   that may contain multiple certificates of 1-2KB each. The upper limit 
   is determined by the length field in the TLS header (16 bit), and is 64KB. */
[#if NX_SECURE_TLS_MINIMUM_MESSAGE_BUFFER_SIZE_value == "4000"]
/*
#define NX_SECURE_TLS_MINIMUM_MESSAGE_BUFFER_SIZE         4000
*/
[#else]
#define NX_SECURE_TLS_MINIMUM_MESSAGE_BUFFER_SIZE         ${NX_SECURE_TLS_MINIMUM_MESSAGE_BUFFER_SIZE_value}
[/#if]

/* This option defines the size of pre-master secret. 
   The pre-master secret should be at least 66 bytes for ECDH/ECDHE with 
   secp521r1. 
   The pre-master secret is 48 bytes, except for PSK ciphersuites for which 
   it may be more.*/
[#if NX_SECURE_TLS_PREMASTER_SIZE_value == "48"]
[#if NX_SECURE_ENABLE_ECC_CIPHERSUITE_value == "false"]
/*
#define NX_SECURE_TLS_PREMASTER_SIZE         48
*/
[#else]
/*
#define NX_SECURE_TLS_PREMASTER_SIZE         68
*/
[/#if]
[#else]
#define NX_SECURE_TLS_PREMASTER_SIZE         ${NX_SECURE_TLS_PREMASTER_SIZE_value}
[/#if]

/* This option disables Server Name Indication (SNI) extension. */
[#if NX_SECURE_TLS_SNI_EXTENSION_DISABLED_value == "true"]
#define NX_SECURE_TLS_SNI_EXTENSION_DISABLED         
[#else]
/*
#define NX_SECURE_TLS_SNI_EXTENSION_DISABLED      
*/ 
[/#if]

/* This option enables SCSV ciphersuite in ClientHello message. */
[#if NX_SECURE_TLS_USE_SCSV_CIPHPERSUITE_value == "true"]
#define NX_SECURE_TLS_USE_SCSV_CIPHPERSUITE         
[#else]
/*
#define NX_SECURE_TLS_USE_SCSV_CIPHPERSUITE     
*/  
[/#if]

/* This option disables X509 Certificate Revocation List check. */
[#if NX_SECURE_X509_DISABLE_CRL_value == "true"]
#define NX_SECURE_X509_DISABLE_CRL         
[#else]
/*
#define NX_SECURE_X509_DISABLE_CRL       
*/
[/#if]

/* This macro must be defined to enable DTLS logic in NetX Secure. */
[#if NX_SECURE_ENABLE_DTLS_value == "true"]
#define NX_SECURE_ENABLE_DTLS         
[#else]
/*
#define NX_SECURE_ENABLE_DTLS       
*/
[/#if]

/* Defined, this option removes the basic NetX Secure error checking.
   It is typically used after the application has been debugged. */
[#if NX_SECURE_DISABLE_ERROR_CHECKING_value == "true"]
#define NX_SECURE_DISABLE_ERROR_CHECKING         
[#else]
/*
#define NX_SECURE_DISABLE_ERROR_CHECKING       
*/
[/#if]

/* Defined, this option removes all TLS/DTLS stack code related to
   Client mode, reducing code and data usage. */
[#if NX_SECURE_TLS_CLIENT_DISABLED_value == "true"]
#define NX_SECURE_TLS_CLIENT_DISABLED         
[#else]
/*
#define NX_SECURE_TLS_CLIENT_DISABLED       
*/
[/#if]

/* Defined, this option enables Pre-Shared Key (PSK) functionality. 
   It does not disable digital certificates. */
[#if NX_SECURE_ENABLE_PSK_CIPHERSUITES_value == "true"]
#define NX_SECURE_ENABLE_PSK_CIPHERSUITES         
[#else]
/*
#define NX_SECURE_ENABLE_PSK_CIPHERSUITES       
*/
[/#if]

/* Defined, this option enables strict distinguished name comparison for 
   X.509 certificates for certificate searching and verification. The default 
   is to only compare the Common Name fields of the Distinguished Names. */
[#if NX_SECURE_X509_STRICT_NAME_COMPARE_value == "true"]
#define NX_SECURE_X509_STRICT_NAME_COMPARE         
[#else]
/*
#define NX_SECURE_X509_STRICT_NAME_COMPARE       
*/
[/#if]

/* Defined, this option enables the optional X.509 Distinguished Name fields,
   at the expense of extra memory use for X.509 certificates. */
[#if NX_SECURE_X509_USE_EXTENDED_DISTINGUISHED_NAMES_value == "true"]
#define NX_SECURE_X509_USE_EXTENDED_DISTINGUISHED_NAMES         
[#else]
/*
#define NX_SECURE_X509_USE_EXTENDED_DISTINGUISHED_NAMES       
*/
[/#if]

/* Defined, this option enables the ECC support in TLS. */
[#if NX_SECURE_ENABLE_ECC_CIPHERSUITE_value == "true"]
#define NX_SECURE_ENABLE_ECC_CIPHERSUITE         
[#else]
/*
#define NX_SECURE_ENABLE_ECC_CIPHERSUITE       
*/
[/#if]

/* Defined, this option enables SSL 3.0 . */
[#if NX_SECURE_TLS_ENABLE_SSL_3_0_value == "true"]
#define NX_SECURE_TLS_ENABLE_SSL_3_0         
[#else]
/*
#define NX_SECURE_TLS_ENABLE_SSL_3_0       
*/
[/#if]

/* This option defines the TLS maximum psk monce size.  
   The default value is 255.*/
[#if NX_SECURE_TLS_MAX_PSK_NONCE_SIZE_value == "255"]
/*
#define NX_SECURE_TLS_MAX_PSK_NONCE_SIZE         255
*/         
[#else]
#define NX_SECURE_TLS_MAX_PSK_NONCE_SIZE       ${NX_SECURE_TLS_MAX_PSK_NONCE_SIZE_value}
[/#if]

[#if NX_SECURE_TLS_ENABLE_SECURE_RENEGOTIATION_value??]
/* Defined, this option enables secure renegotiation.*/
[#if NX_SECURE_TLS_ENABLE_SECURE_RENEGOTIATION_value == "true"]
#define NX_SECURE_TLS_ENABLE_SECURE_RENEGOTIATION         
[#else]
/*
#define NX_SECURE_TLS_ENABLE_SECURE_RENEGOTIATION       
*/
[/#if]
[/#if]

/* Defined, this option enables certificate verify extension.*/
[#if NX_SECURE_X509_CERTIFICATE_VERIFY_EXTENSION_value == "true"]
#define NX_SECURE_X509_CERTIFICATE_VERIFY_EXTENSION         
[#else]
/*
#define NX_SECURE_X509_CERTIFICATE_VERIFY_EXTENSION       
*/
[/#if]

/* Defined, this option enables X509 parse crl extension.*/
[#if NX_SECURE_X509_PARSE_CRL_EXTENSION_value == "true"]
#define NX_SECURE_X509_PARSE_CRL_EXTENSION         
[#else]
/*
#define NX_SECURE_X509_PARSE_CRL_EXTENSION       
*/
[/#if]

/* Defined, this option enables X509 crl verify extension.*/
[#if NX_SECURE_X509_CRL_VERIFY_EXTENSION_value == "true"]
#define NX_SECURE_X509_CRL_VERIFY_EXTENSION         
[#else]
/*
#define NX_SECURE_X509_CRL_VERIFY_EXTENSION       
*/
[/#if]
 
/* Defined, this option enables X509 certificate initialize extension.*/
[#if NX_SECURE_X509_CERTIFICATE_INITIALIZE_EXTENSION_value == "true"]
#define NX_SECURE_X509_CERTIFICATE_INITIALIZE_EXTENSION         
[#else]
/*
#define NX_SECURE_X509_CERTIFICATE_INITIALIZE_EXTENSION       
*/
[/#if]

/* Defined, this option removes all TLS stack code 
   related to TLS Server mode, reducing code and data usage.*/
[#if NX_SECURE_TLS_SERVER_DISABLED_value == "true"]
#define NX_SECURE_TLS_SERVER_DISABLED		    
[#else]
/*
#define NX_SECURE_TLS_SERVER_DISABLED   
*/                   
[/#if]

/* When defined the AES Tabled are  moved to RAM. */
[#if NX_CRYPTO_AES_USE_RAM_TABLES_value == "false"]
/*
#define NX_CRYPTO_AES_USE_RAM_TABLES
*/
[#else]
#define NX_CRYPTO_AES_USE_RAM_TABLES
[/#if]

/* Defines whether or not the connection should be terminated immediately upon failure to receive the secure renegotiation extension during the initial handshake.
   By default, the connection is not terminated.*/
[#if NX_SECURE_TLS_REQUIRE_RENEGOTIATION_EXT_value == "false"]
/*
#define NX_SECURE_TLS_REQUIRE_RENEGOTIATION_EXT
*/
[#else]
#define NX_SECURE_TLS_REQUIRE_RENEGOTIATION_EXT
[/#if]

/* Disables client-initiated renegotiation for TLS servers. 
   In some instances, client-initiated renegotiation can become a possible denial-of-service vulnerability. */
[#if NX_SECURE_TLS_DISABLE_CLIENT_INITIATED_RENEGOTIATION_value == "false"]
/*
#define NX_SECURE_TLS_DISABLE_CLIENT_INITIATED_RENEGOTIATION
*/
[#else]
#define NX_SECURE_TLS_DISABLE_CLIENT_INITIATED_RENEGOTIATION
[/#if]

/* Disable secure session renegotiation extension. */
[#if NX_SECURE_TLS_DISABLE_SECURE_RENEGOTIATION_value == "false"]
/*
#define NX_SECURE_TLS_DISABLE_SECURE_RENEGOTIATION
*/
[#else]
#define NX_SECURE_TLS_DISABLE_SECURE_RENEGOTIATION
[/#if]

/* USER CODE BEGIN 2 */

/* USER CODE END 2 */

#endif /* NX_SECURE_USER_H */