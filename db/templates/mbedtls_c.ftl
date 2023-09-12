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

/* Includes ------------------------------------------------------------------*/
#include "mbedtls.h"

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

/* Global variables ---------------------------------------------------------*/

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

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
