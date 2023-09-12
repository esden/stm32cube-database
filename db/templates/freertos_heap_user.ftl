[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : heap_user.c
  * Description        : User implementation of heap management functions.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/*
 * A user implementation of pvPortMalloc() and vPortFree(). 
 * To be completed by the user.
 *
 * See heap_1.c, heap_2.c, heap_3.c, heap_4.c amd heap_5.c for sample 
 * implementations, and the memory management pages of 
 * http://www.FreeRTOS.org for more information.
 */
 
 #include <stdlib.h> /* for size_t */

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */     

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN Variables */

/* USER CODE END Variables */

/* USER CODE BEGIN UserCode1 */     

/* USER CODE END UserCode1 */

/* USER CODE BEGIN pvPortMallocImpl */ 
void *pvPortMalloc( size_t xWantedSize )
{
  void *pvReturn = NULL;

  return pvReturn;
}
/* USER CODE END pvPortMallocImpl */

/* USER CODE BEGIN vPortFreeImpl */
void vPortFree( void *pv )
{
     
}
/* USER CODE END vPortFreeImpl */


/* USER CODE BEGIN UserCode2 */     
void vPortInitialiseBlocks( void ) /* needed with Keil? */
{
	/* This just exists to keep the linker quiet. */
}
/* USER CODE END UserCode2 */
