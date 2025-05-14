[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    osal.h
  * @author  GPM WBL Application Team
  * @brief   This header file defines the OS abstraction layer. OSAL defines the
             set of functions which needs to be ported to target operating
             system and target platform.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#ifndef __OSAL_H__
#define __OSAL_H__

/******************************************************************************
 * Includes
 *****************************************************************************/
#include <stdint.h>

/******************************************************************************
 * Macros
 *****************************************************************************/


/******************************************************************************
 * Function Prototypes
 *****************************************************************************/

/** 
 * @brief This function copies size number of bytes from a 
 * memory location pointed by src to a destination 
 * memory location pointed by dest. The locations must not overlap.
 * 
 * @param[out] dest Destination address
 * @param[in] src  Source address
 * @param[in] size Number of bytes to copy
 */
 
extern void Osal_MemCpy(void *dest, const void *src, unsigned int size);

/** 
 * @brief This function copies a given number of bytes, multiple of 4, from a 
 * memory location pointed by src to a destination memory location pointed by
 * dest, by using only 32-bit accesses. The locations must not overlap.
 * 
 * @param[out] dest Destination address. It must be 32-bit aligned.
 * @param[in]  src  Source address. It must be 32-bit aligned.
 * @param[in]  size Number of bytes to copy. It must be a multiple of 4.
 */
extern void Osal_MemCpy4(uint32_t *dest, const uint32_t *src, unsigned int size);

/**
 * @brief This function sets first number of bytes, specified
 * by size, to the destination memory pointed by ptr 
 * to the specified value
 * 
 * @param[in] ptr    Destination address
 * @param[in] value  Value to be set
 * @param[in] size   Size in the bytes  
 */
 
extern void Osal_MemSet(void *ptr, int value, unsigned int size);

/**
 * @brief This function compares n bytes of two regions of memory
 * 
 * @param[in] s1    First buffer to compare.
 * @param[in] s2    Second buffer to compare.
 * @param[in] size  Number of bytes to compare.   
 * 
 * @return  0 if the two buffers are equal, 1 otherwise
 */
extern int Osal_MemCmp(void *s1, void *s2, unsigned int size);

#endif /* __OSAL_H__ */