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
[#if FamilyName=="STM32L5"]
#include "mbedtls/entropy.h"
[/#if]
#include "mbedtls/entropy_poll.h"

[#if FamilyName=="STM32L5"]
static __IO uint32_t isInitialized = 0;

static RNG_HandleTypeDef RNG_Handle;

static void RNG_Init(void);
/* RNG init function */
static void RNG_Init(void)
{
  if (isInitialized == 0)
  {
    RNG_Handle.Instance = RNG;
    /* DeInitialize the RNG peripheral */
    if (HAL_RNG_DeInit(&RNG_Handle) != HAL_OK)
    {
      return;
    }
    /* Initialize the RNG peripheral */
    if (HAL_RNG_Init(&RNG_Handle) != HAL_OK)
    {
      return;
    }
    isInitialized = 1;
  }
}

int mbedtls_hardware_poll(void *Data, unsigned char *Output, size_t Len, size_t *oLen)
{
  __IO uint8_t random_value[4];
  int ret = 0;

  RNG_Init();

  if (isInitialized == 0)
  {
    ret = MBEDTLS_ERR_ENTROPY_SOURCE_FAILED;
  }
  else
  {
    *oLen = 0;
    while ((*oLen < Len) && (ret == 0))
    {
      if (HAL_RNG_GenerateRandomNumber(&RNG_Handle, (uint32_t *)random_value) == HAL_OK)
      {
        for (uint8_t i = 0; (i < sizeof(uint32_t)) && (*oLen < Len) ; i++)
        {
          Output[*oLen] = random_value[i];
          *oLen += 1;
        }
      }
      else
      {
        ret = MBEDTLS_ERR_ENTROPY_SOURCE_FAILED;
      }
    }

    /* Just be extra sure that we didn't do it wrong */
    if (__HAL_RNG_GET_FLAG(&RNG_Handle, (RNG_FLAG_CECS | RNG_FLAG_SECS)) != 0)
    {
      *oLen = 0;
      ret = MBEDTLS_ERR_ENTROPY_SOURCE_FAILED;
    }
  }

  return ret;
}
[#else]
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
      [#if FamilyName=="STM32F4"]
      memcpy(&(Output[index * 4]), &randomValue, 4);
      [#else]
      memset(&(Output[index * 4]), (int)randomValue, 4);
      [/#if]
    }
    else
    {
      Error_Handler();
    }
  }
  
  return 0;
}
[/#if]

#endif /*MBEDTLS_ENTROPY_HARDWARE_ALT*/
