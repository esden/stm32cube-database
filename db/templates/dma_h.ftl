[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name?lower_case}.h
  * @brief   This file contains all the function prototypes for
  *          the ${name?lower_case}.c file
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign ipName = "DMA"]
[#if dmas?size > 0]
  [#list dmas as dma]
    [#assign ipName = dma]
  [/#list]
[/#if]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${ipName}_H__
#define __${ipName}_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "main.h"
#n
/* DMA memory to memory transfer handles -------------------------------------*/
[#if variables?? && variables?size > 0]
[#list variables as variable]
extern ${variable.value} ${variable.name};
[/#list]
[/#if]

#n
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */
#n
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */
#n
void MX_${ipName}_Init(void);
[#compress]
#n/* USER CODE BEGIN Prototypes */
#n     
/* USER CODE END Prototypes */
#n
[/#compress]
#ifdef __cplusplus
}
#endif

#endif /* __${ipName}_H__ */

