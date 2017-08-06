[#ftl]
/**
  ******************************************************************************
  * File Name          : dma.h
  * Description        : This file contains all the function prototypes for
  *                      the dma.c file
  ******************************************************************************
[@common.optinclude name="Src/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __dma_H
#define __dma_H

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#assign includesList = ""]
[#list includes as include]
[#if !includesList?contains(include)]
#include "${include}"
[#assign includesList = includesList+" "+include]
[/#if]
[/#list]
#n
/* DMA memory to memory transfer handles -------------------------------------*/
[#if variables?? && variables?size > 0]
[#list variables as variable]
extern ${variable.value} ${variable.name};
[/#list]
[/#if]
extern void Error_Handler(void);
#n
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */
#n
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */
#n
void MX_DMA_Init(void);
[#compress]
#n/* USER CODE BEGIN Prototypes */
#n     
/* USER CODE END Prototypes */
#n
[/#compress]
#ifdef __cplusplus
}
#endif

#endif /* __dma_H */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
