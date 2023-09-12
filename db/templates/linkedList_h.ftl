[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * File Name          : linked_list.h
  * Description        : This file provides code for the configuration
  *                      of the LinkedList.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */ 

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef LINKED_LIST_H
#define LINKED_LIST_H

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "main.h"

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
[#list linkedListNames as queueName]
HAL_StatusTypeDef MX_${queueName}_Config(void);
[/#list]

#ifdef __cplusplus
}
#endif

#endif /* LINKED_LIST_H */

