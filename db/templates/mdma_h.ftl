[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : mdma.h
  * Description        : This file contains all the function prototypes for
  *                      the mdma.c file
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign ipName = "MDMA"]
[#if dmas?size > 0]
  [#list dmas as dma]
    [#assign ipName = dma]
  [/#list]
[/#if]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${ipName?lower_case}_H
#define __${ipName?lower_case}_H

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "main.h"
#n
/* MDMA transfer handles -----------------------------------------------------*/
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

#endif /* __${ipName?lower_case}_H */

/**
  * @}
  */
