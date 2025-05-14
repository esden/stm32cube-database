[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    osal.c
  * @author  GPM WBL Application Team
  * @brief   osal APIs
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#ifdef __GNUC__
#pragma GCC optimize ("-Os")
#endif

/* Includes ------------------------------------------------------------------*/
#include <string.h>
#include "osal.h"

/** 
 * A version of the memcpy that only uses 32-bit accesses.
 * dest and src must be 32-bit aligned and size must be a multiple of 4.
 */
void Osal_MemCpy4(uint32_t *dest, const uint32_t *src, unsigned int size)
{
    for (unsigned int i = 0; i < size/4; i++)
        dest[i] = src[i];
}


