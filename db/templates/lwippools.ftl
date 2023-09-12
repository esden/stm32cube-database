[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
  * File Name          : lwippools.h
  * Description        : This file provides initialization code for LWIP
  *                      middleWare.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */ 
  
 /******************************************************************************
 * If MEMP_USE_CUSTOM_POOLS option is enabled:
 *  - include this lwippools.h file that defines additional pools beyond the 
 *    "standard" ones required by lwIP.
 *  - make sure you have lwippools.h in your include path.
 ******************************************************************************/
 
/* MEMP_USE_CUSTOM_POOLS is enabled => This file is required by LwIP */

#ifdef __cplusplus
 extern "C" {
#endif

#n#n/* USER CODE BEGIN 0 */
/* Warning 1: The following code is only given as an example */
/* You can use this example code by uncommenting it */
/* -------------- EXAMPLE of CODE ------------------------*/
/* Define three pools with sizes 256, 512, and 1512 bytes */
/* 
#if MEM_USE_POOLS
LWIP_MALLOC_MEMPOOL_START
LWIP_MALLOC_MEMPOOL(20, 256)
LWIP_MALLOC_MEMPOOL(10, 512)
LWIP_MALLOC_MEMPOOL(5, 1512)
LWIP_MALLOC_MEMPOOL_END
#endif
*/
/* -------------- END of EXAMPLE of CODE -----------------*/

/* USER CODE END 0 */

#ifdef __cplusplus
}
#endif
