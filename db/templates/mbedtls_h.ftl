[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : mbedtls.h
  * Description        : This file provides code for the configuration
  *                      of the mbedtls instances.
  ******************************************************************************
  ******************************************************************************
 [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign mbedtls_threading = 0]
[#list IPdatas as IP]
    [#list IP.configModelList as instanceData]
        [#list instanceData.configs as config]
            [#assign methodList = config.libMethod]
            [#list methodList as method]
                [#list method.arguments as argument]
                    [#if (argument.name == "MBEDTLS_THREADING_C") && (argument.value == "1")]
                        [#assign mbedtls_threading = 1]
                    [/#if]
                [/#list]
            [/#list]
        [/#list]
    [/#list]
[/#list]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __mbedtls_H
#define __mbedtls_H
#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "mbedtls_config.h"
[#if mbedtls_threading == 1]
#include "threading.h"
[/#if]
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/* Global variables ---------------------------------------------------------*/

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

/* MBEDTLS init function */
void MX_MBEDTLS_Init(void);

/* USER CODE BEGIN 2 */

/* USER CODE END 2 */

#ifdef __cplusplus
}
#endif
#endif /*__mbedtls_H */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/