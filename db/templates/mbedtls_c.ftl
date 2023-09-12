[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : mbedtls.c
  * Description        : This file provides code for the configuration
  *                      of the mbedtls instances.
  ******************************************************************************
  ******************************************************************************
 [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign mbedtls_threading = 0]
[#assign mbedtls_ssl = 0]
[#list IPdatas as IP]
    [#list IP.configModelList as instanceData]
        [#list instanceData.configs as config]
            [#assign methodList = config.libMethod]
            [#list methodList as method]
                [#list method.arguments as argument]
                    [#if (argument.name == "MBEDTLS_THREADING_C") && (argument.value == "1")]
                        [#assign mbedtls_threading = 1]
                    [/#if]
                    [#if (argument.name == "MBEDTLS_SSL_CLI_C") && (argument.value == "1")]
                        [#assign mbedtls_ssl = 1]
                    [/#if]
                    [#if (argument.name == "MBEDTLS_SSL_SRV_C") && (argument.value == "1")]
                        [#assign mbedtls_ssl = 1]
                    [/#if]
                [/#list]
            [/#list]
        [/#list]
    [/#list]
[/#list]

/* Includes ------------------------------------------------------------------*/
#include "mbedtls.h"

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

/* Global variables ---------------------------------------------------------*/
[#if mbedtls_ssl == 1]
mbedtls_ssl_context ssl;
mbedtls_ssl_config conf;
mbedtls_x509_crt cert;
mbedtls_ctr_drbg_context ctr_drbg;
mbedtls_entropy_context entropy;
[/#if]

/* USER CODE BEGIN 2 */

/* USER CODE END 2 */

/* MBEDTLS init function */
void MX_MBEDTLS_Init(void)
{
   /**
  */
[#if mbedtls_threading == 1]
    mbedtls_threading_set_alt(cmsis_os_mutex_init, cmsis_os_mutex_free, cmsis_os_mutex_lock, cmsis_os_mutex_unlock);
[/#if]
[#if mbedtls_ssl == 1]
  mbedtls_ssl_init(&ssl);
  mbedtls_ssl_config_init(&conf);
  mbedtls_x509_crt_init(&cert);
  mbedtls_ctr_drbg_init(&ctr_drbg);
  mbedtls_entropy_init( &entropy );
[/#if]
  /* USER CODE BEGIN 3 */

  /* USER CODE END 3 */

}

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */

/**
  * @}
  */
 
/**
  * @}
  */

