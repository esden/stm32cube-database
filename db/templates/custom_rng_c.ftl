[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    custom_rng.c
  * @author  MCD Application Team
  * @version V1.0.0
  * @date    20-June-2017
  * @brief   mbedtls alternate entropy data function skeleton to be completed by the user.
  *
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include "mbedtls_config.h"

#ifdef MBEDTLS_ENTROPY_HARDWARE_ALT

#include "${main_h}"
#include "string.h"
#include "${FamilyName?lower_case}xx_hal.h"
#include "mbedtls/entropy_poll.h"

int mbedtls_hardware_poll( void *Data, unsigned char *Output, size_t Len, size_t *oLen )
{
/* USER CODE BEGIN custom_rng */
  #error "please complete this function mbedtls_hardware_poll with your own code";
  return -1;
/* USER CODE END custom_rng */
}


#endif /*MBEDTLS_ENTROPY_HARDWARE_ALT*/
