[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : ${name?lower_case}.h
  * @version        : ${version}
[#--  * @packageVersion : ${fwVersion} --]
  * @brief          : Header for secure_manager_api.c file.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${name?upper_case}__H__
#define __${name?upper_case}__H__

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if includes??]
[#list includes as include]
#include "${include}"
[/#list]
[/#if]

/* USER CODE BEGIN INCLUDE */

/* USER CODE END INCLUDE */





[#-- Global variables --]
/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/*
 * -- Insert your variables declaration here --
 */
/* USER CODE BEGIN VARIABLES */

/* USER CODE END VARIABLES */

void MX_${name}_Init(void);

/*
 * -- Insert functions declaration here --
 */
/* USER CODE BEGIN FD */

/* USER CODE END FD */

#ifdef __cplusplus
}
#endif

#endif /* __${name?upper_case}__H__ */

