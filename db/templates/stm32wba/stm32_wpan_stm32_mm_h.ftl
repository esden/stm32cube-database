[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    stm32_mm.h
  * @author  MCD Application Team
  * @brief   Header for stm32_mm.c module
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef STM32_MM_H
#define STM32_MM_H

/* Includes ------------------------------------------------------------------*/
/* Exported defines -----------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* External variables --------------------------------------------------------*/
/* Exported macros -----------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */
/**
 * @brief  Initialize the Pool
 * @param  p_pool: The pool of memory to manage
 * @param  pool_size: The size of the pool
 * @retval None
 */
void UTIL_MM_Init(uint8_t *p_pool, uint32_t pool_size);

/**
 * @brief  Provide a buffer
 * @param  xWantedSize: The size of the buffer requested
 * @retval The buffer address when available or NULL when there is no buffer
 */

void * UTIL_MM_GetBuffer(size_t xWantedSize);

/**
 * @brief  Release a buffer
 * @param  pv: The data buffer address
 * @retval None
 */

void UTIL_MM_ReleaseBuffer( void * pv );

/* Exported functions to be implemented by the user if required ------------- */

#endif /* STM32_MM_H */
