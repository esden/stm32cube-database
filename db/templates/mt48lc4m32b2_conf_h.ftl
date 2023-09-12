/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    mt48lc4m32b2_conf.h
  * @author  MCD Application Team
  * @brief   This file contains some configurations required for the
  *          MT48LC4M32B2 SDRAM memory.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2019 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef MT48LC4M32B2_CONF_H
#define MT48LC4M32B2_CONF_H

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
/* Update the below line with adequate hal file. ie: #include "stm32f7xx_hal.h" */
#include "stm32h7xx_hal.h"

   
/** @addtogroup BSP
  * @{
  */
  
/** @addtogroup Components
  * @{
  */

/** @addtogroup MT48LC4M32B2
  * @{
  */

/** @addtogroup MT48LC4M32B2_Exported_Constants
  * @{
  */  
#define REFRESH_COUNT                    ((uint32_t)0x0603)   /* SDRAM refresh counter */
   
#define MT48LC4M32B2_TIMEOUT             ((uint32_t)0xFFFF)

#ifdef __cplusplus
}
#endif

#endif /* mt48lc4m32b2_CONF_H */
/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

