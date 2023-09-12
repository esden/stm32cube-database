[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name?remove_beginning("Target/")}
  * @author  MCD Application Team
  * @brief   routines for Memory Management service needed by the BLE ACI 
  *          Transport Layer
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#include "stdint.h"
#include "memory_manager.h"
#include "ble_mm_if.h"

/* Private typedef -----------------------------------------------------------*/
/* Private defines -----------------------------------------------------------*/
/* Private macros ------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/

/*Pool of the memory used by ACI Transport Layer*/
uint8_t *BlePool;
uint32_t BlePoolSize;

  
/* Private functions prototypes-----------------------------------------------*/
/* Functions Definition ------------------------------------------------------*/

/**
 * @brief ble_mm_init
 * This function is used to initialize the memory for ble. This memory is used
 * by aci transport layer to transmit asynchronous events.
 *
 * @param  p_pool: The pool of the memory
 * @param  pool_size: size of the memory 
 * @retval elt_size : size of each element is the memory
 */
void ble_mm_init(uint8_t *p_pool, uint32_t pool_size,  uint32_t elt_size){
  MM_Init( p_pool , pool_size, elt_size);
  BlePool = p_pool;
  BlePoolSize = pool_size;
}

/**
 * @brief ble_mm_get_config
 * This function is used to get memory information allocated for ble
 * for ble
 * 
 * @param blepool pool of the memory allocated for ble
 * 
 * @param blepoolsize pool size of the memory allocated for ble
 *
 */
void ble_mm_get_config(uint8_t **blepool, uint32_t *blepoolsize){
  *blepool = BlePool;
  *blepoolsize = BlePoolSize;
}

/**
 * @brief ble_mm_get_buffer
 * This function is used by the ble host to get buffer memory.
 *
 * @param  size: The size of the buffer requested
 * @param  cb: The callback to be called when a buffer is made available later on
 *                   if there is no buffer currently available when this API is called
 * @retval The buffer address when available or NULL when there is no buffer
 */
uint8_t *ble_mm_get_buffer(uint32_t size, ble_mm_available_callback_t cb){
  
  return MM_GetBuffer(size, (MM_pCb_t) cb );
  
}

/**
 * @brief ble_mm_release_buffer
 * This function is used by the ble host to release memory allocated for 
 * a buffer.
 * 
 * @param  p_buffer: The data buffer address
 * @retval None
 *
 */
void ble_mm_release_buffer(uint8_t* p_buffer){
  MM_ReleaseBuffer((MM_pBufAdd_t) p_buffer);
}
