[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name?remove_beginning("System/Modules/MemoryManager/")}
  * @author  MCD Application Team
  * @brief   Header for memory_manager.c module
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef MEMORY_MANAGER_H
#define MEMORY_MANAGER_H

/* Includes ------------------------------------------------------------------*/
/* Exported defines -----------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
typedef void (*MM_pCb_t)( void );
typedef  uint8_t (*MM_pBufAdd_t);

/* Exported constants --------------------------------------------------------*/
/* External variables --------------------------------------------------------*/
/* Exported macros -----------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */
void MM_Init(uint8_t *p_pool, uint32_t pool_size,  uint32_t elt_size);
MM_pBufAdd_t MM_GetBuffer(uint32_t size, MM_pCb_t cb );
void MM_ReleaseBuffer( MM_pBufAdd_t p_buffer );

/* Exported functions to be implemented by the user if required ------------- */

#endif /* MEMORY_MANAGER_H */
