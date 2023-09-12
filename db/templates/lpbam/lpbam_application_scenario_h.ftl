[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file   LPBAM/LPBAM_DAC_OPAMP_ContinuousConversion/Inc/main.h
  * @author MCD Application Team
  * @brief  Header for main.c module
  ******************************************************************************
  * @attention
  *
  * Copyright (c) ${year} STMicroelectronics.
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
#ifndef LPBAM_DACCONV_SIGNALGEN_H
#define LPBAM_DACCONV_SIGNALGEN_H

/* Includes ------------------------------------------------------------------*/
#include "stm32_lpbam.h"
#include "TriangularSignal.h"

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */
void lpbam_dacconv_continuousconv_config(void);
void lpbam_dacconv_continuousconv_build(void);

/* Exported macro ------------------------------------------------------------*/

#endif /* LPBAM_DACCONV_SIGNALGEN_BUILD_H */
