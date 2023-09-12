[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    hardware_rng.c
  * @author  MCD Application Team
  * @version V1.2.1
  * @date    14-April-2017
  * @brief   mbedtls alternate entropy data function.
  *          the mbedtls_hardware_poll() is customized to use the STM32 RNG
  *          to generate random data, required for TLS encryption algorithms.
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

extern RNG_HandleTypeDef hrng;

int mbedtls_hardware_poll( void *Data, unsigned char *Output, size_t Len, size_t *oLen )
{
  uint32_t index;
  uint32_t randomValue;
		
  for (index = 0; index < Len/4; index++)
  {
    if (HAL_RNG_GenerateRandomNumber(&hrng, &randomValue) == HAL_OK)
    {
      *oLen += 4;
      memset(&(Output[index * 4]), (int)randomValue, 4);
    }
    else
    {
      Error_Handler();
    }
  }
  
  return 0;
}


#endif /*MBEDTLS_ENTROPY_HARDWARE_ALT*/
