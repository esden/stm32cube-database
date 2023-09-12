[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ${name?lower_case}.h
  * @brief   This file contains all the functions prototypes for the gpio
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
[#list includes as include]
#include "${include}"
[/#list]
void MX_GPIO_Init(void);
#ifdef __cplusplus
}
#endif
#endif /*__ GPIO_H__ */

