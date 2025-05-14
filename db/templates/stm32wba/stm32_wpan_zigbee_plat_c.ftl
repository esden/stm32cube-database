[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    zigbee_plat.c
  * @author  MCD Application Team
  * @brief   Source file for the Zigbee platform adaptation layer
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign myHash = {}]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#assign myHash = {definition.name:definition.value} + myHash]
        [/#list]
    [/#if]
[/#list]

/* Includes ------------------------------------------------------------------*/
#include <stdbool.h>

#include "app_common.h"
#include "hw.h"
#include "baes.h"
#include "zigbee_plat.h"
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
#include "advanced_memory_manager.h"
[/#if]
[#if (myHash["CFG_MM_TYPE"]?number == 1)]
#include "stm32_mm.h"
[/#if]

/* Private includes -----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private defines -----------------------------------------------------------*/
[#if (myHash["CFG_MM_TYPE"]?number == 1)]
#define C_SYS_MEMORY_HEAP_SIZE_BYTES          CFG_MM_POOL_SIZE

[/#if]
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macros ------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* round a size in bytes to a size in words (32 bits) */
#define BYTES_TO_WORD32(a) (((a) + 3) >> 2)

/* Private constants ---------------------------------------------------------*/
/* USER CODE BEGIN PC */

/* USER CODE END PC */

/* Private variables ---------------------------------------------------------*/
[#if (myHash["CFG_MM_TYPE"]?number == 1)]
static uint8_t        SYS_MEMORY_HEAP[C_SYS_MEMORY_HEAP_SIZE_BYTES];

[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Global variables ----------------------------------------------------------*/
/* USER CODE BEGIN GV */

/* USER CODE END GV */

/* Private functions prototypes-----------------------------------------------*/
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Functions Definition ------------------------------------------------------*/

/**
 *
 */
void ZIGBEE_PLAT_Init( void )
{
  //TIMER_Init( );
}

/**
 *
 */
void ZIGBEE_PLAT_RngInit( void )
{
  // -- Init random HW driver --
  HW_RNG_Start( );
}

/**
 *
 */
void ZIGBEE_PLAT_RngProcess( void )
{
  // -- Generate new Random numbers --
  HW_RNG_Process();
}

/**
 * 
 */
void ZIGBEE_PLAT_RngGet( uint8_t cNumberOfBytes, uint8_t * pValue )
{
  uint8_t   cNbRemainingBytes = cNumberOfBytes;
  uint8_t   *pData = pValue;
  uint32_t  lGeneratedRandom;

  /* Get the requested RNGs (4 bytes by 4bytes) */
  while ( cNbRemainingBytes >= 4u )
  {
    HW_RNG_Get(1, &lGeneratedRandom);
    memcpy( pData, &lGeneratedRandom, 4);
    cNbRemainingBytes -= 4u;
    pData += 4u;
  }

  /* Get the remaining number of RNGs */
  if ( cNbRemainingBytes > 0u )
  {
    HW_RNG_Get(1, &lGeneratedRandom);
    memcpy( pData, &lGeneratedRandom, cNbRemainingBytes);
  }
}

/**
 * 
 */
void ZIGBEE_PLAT_AesEcbEncrypt( const uint8_t * pKey, const uint8_t * pInput, uint8_t * pOutput )
{
  BAES_EcbCrypt( pKey, pInput, pOutput, HW_AES_ENC );
}

/**
 * 
 */
void ZIGBEE_PLAT_AesCmacSetKey( const uint8_t * pKey )
{
  BAES_CmacSetKey( pKey );
}

/**
 * 
 */
void ZIGBEE_PLAT_AesCmacSetVector( const uint8_t * pIV )
{
  BAES_CmacSetVector( pIV );
}

/**
 * 
 */
void ZIGBEE_PLAT_AesCrypt32( const uint32_t * pInput, uint32_t * pOutput )
{
  HW_AES_Crypt( pInput, pOutput );
}

/**
 * 
 */
void ZIGBEE_PLAT_AesCrypt( const uint8_t * pInput, uint8_t * pOutput )
{
  HW_AES_Crypt8( pInput, pOutput );
}

/**
 * 
 */
void ZIGBEE_PLAT_AesCmacCompute( const uint8_t * pInput, uint32_t lInputLength, uint8_t * pOutputTag )
{
  BAES_CmacCompute( pInput, lInputLength, pOutputTag );
}

/**
 *
 */
bool ZIGBEE_PLAT_ZbHeapInit( void )
{
[#if (myHash["CFG_MM_TYPE"]?number == 1)]
  static bool  bHeapAlreadyDone = false;
  
  /* Initialize System Heap used by Zigbee Stack */
  if ( bHeapAlreadyDone == false )
  {
    UTIL_MM_Init( SYS_MEMORY_HEAP, C_SYS_MEMORY_HEAP_SIZE_BYTES );
    bHeapAlreadyDone = true;
  }
[/#if]

  return true;
}

/**
 *
 */
void * ZIGBEE_PLAT_ZbHeapMalloc( uint32_t iSize )
{
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
  void  *ptr = NULL;

  /* Fix a problem with AMM if iSize is null */
  if ( iSize == 0u )
  {
    iSize = 1;
  }

  if ( AMM_Alloc( CFG_AMM_VIRTUAL_STACK_ZIGBEE_INIT, BYTES_TO_WORD32(iSize), (uint32_t**)&ptr, NULL ) != AMM_ERROR_OK )
  {
    ptr = NULL;
  }
[/#if]
[#if (myHash["CFG_MM_TYPE"]?number == 1)]
  void  *ptr;

  ptr = UTIL_MM_GetBuffer( iSize );
[/#if]
[#if (myHash["CFG_MM_TYPE"]?number == 0)]
  void  *ptr;

  ptr = malloc( iSize );
[/#if]

  return ptr;
}

/**
 *
 */
void ZIGBEE_PLAT_ZbHeapFree( void * ptr )
{
  if ( ptr != NULL )
  {
[#if (myHash["CFG_MM_TYPE"]?number == 2)]  
    AMM_Free( ptr );
[/#if]
[#if (myHash["CFG_MM_TYPE"]?number == 1)]
    UTIL_MM_ReleaseBuffer( ptr );
[/#if]
[#if (myHash["CFG_MM_TYPE"]?number == 0)]
    free( ptr );
[/#if]
  }
  else
  {
    /* Intentional INFINITE_LOOP */
    /* coverity[no_escape] */
    while(1) {}
  }
}

/**
 * 
 */
unsigned int ZIGBEE_PLAT_ZbHeapMallocCurrentSize()
{
  return 0U;
}
    
/**
 * 
 */
bool ZIGBEE_PLAT_HeapInit( void )
{
[#if (myHash["CFG_MM_TYPE"]?number == 1)]
  return ZIGBEE_PLAT_ZbHeapInit();
[#else]
  return true;
[/#if]
}

/**
 * 
 */
void * ZIGBEE_PLAT_HeapMalloc( uint32_t iSize )
{
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
  void  *ptr = NULL;

  /* Fix a problem with AMM if iSize is null */
  if ( iSize == 0u )
  {
    iSize = 1;
  }

  if ( AMM_Alloc( CFG_AMM_VIRTUAL_STACK_ZIGBEE_HEAP, BYTES_TO_WORD32(iSize), (uint32_t**)&ptr, NULL ) != AMM_ERROR_OK )
  {
    ptr = NULL;
  }
[/#if]
[#if (myHash["CFG_MM_TYPE"]?number == 1)]
  void  *ptr;

  ptr = UTIL_MM_GetBuffer( iSize );
[/#if]
[#if (myHash["CFG_MM_TYPE"]?number == 0)]
  void  *ptr;

  ptr = malloc( iSize );
[/#if]

  return ptr;
}

/**
 * 
 */
void ZIGBEE_PLAT_HeapFree( void * ptr )
{
  if ( ptr != NULL )
  {
[#if (myHash["CFG_MM_TYPE"]?number == 2)]  
    AMM_Free( ptr );
[/#if]
[#if (myHash["CFG_MM_TYPE"]?number == 1)]
    UTIL_MM_ReleaseBuffer( ptr );
[/#if]
[#if (myHash["CFG_MM_TYPE"]?number == 0)]
    free( ptr );
[/#if]
  }
  else
  {
    /* Intentional INFINITE_LOOP */
    /* coverity[no_escape] */
    while(1) {}
  }
}

/**
 * 
 */
unsigned int ZIGBEE_PLAT_HeapMallocCurrentSize( void )
{
  return 0U;
}

/**
 * 
 */
unsigned long ZIGBEE_PLAT_HeapAvailable( void )
{
    return 0U;
}

/**
 * 
 */
bool ZIGBEE_PLAT_HeapCheckAlloc( uint32_t iSize )
{
    /* Just assume we have enough memory in the system heap */
    return true;
}

/**
 * 
 */
unsigned long ZIGBEE_PLAT_HeapUsed( void )
{
    /*  ZIGBEE_PLAT_HeapUSed is not updated in this file, because we're not tracking memory usage. */
    return 0U;
}

/**
 * 
 */
unsigned long ZIGBEE_PLAT_HeapHighWaterMark( void )
{
    /* ZIGBEE_PLAT_HeapHighWaterMark is not updated in this file. */
    return 0U;
}
