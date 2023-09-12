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
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${name}_H__
#define __${name}_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "main.h"
#n
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */
#n
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */
#n
[#list datas as data]
[#if data.ipName=="gpio"]
void MX_GPIO_Init(void);
[#else]
void MX_${data.ipName}_GPIO_Init(void);
[/#if]
[/#list]
[#compress]
#n/* USER CODE BEGIN Prototypes */
#n     
/* USER CODE END Prototypes */
#n
[/#compress]
#ifdef __cplusplus
}
#endif
#endif /*__ GPIO_H__ */

