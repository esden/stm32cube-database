[#ftl]
/* USER CODE BEGIN Header */
/**
  **********************************************************************************************************************
  * @file    lpbam_${LPBAM_NAME?replace(" ","_")?lower_case}.h
  * @author  MCD Application Team
  * @brief   Header for LPBAM ${LPBAM_NAME} application
  **********************************************************************************************************************
  * @attention
  *
  * Copyright (c) ${year} STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  **********************************************************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -----------------------------------------------------------------------------*/
#ifndef LPBAM_${LPBAM_NAME?upper_case?replace(" ","_")}_H
#define LPBAM_${LPBAM_NAME?upper_case?replace(" ","_")}_H

/* Includes ----------------------------------------------------------------------------------------------------------*/
#include "main.h"
#include "stm32_lpbam.h"

/* Exported functions ------------------------------------------------------------------------------------------------*/
/* ${LPBAM_NAME?replace(" ","_")} application initialization */
void MX_${LPBAM_NAME?replace(" ","_")}_Init(void);

/* ${LPBAM_NAME?replace(" ","_")} application ${ScenarioName?replace(" ","_")} scenario initialization */
void MX_${LPBAM_NAME?replace(" ","_")}_${ScenarioName?replace(" ","_")}_Init(void);

/* ${LPBAM_NAME?replace(" ","_")} application ${ScenarioName?replace(" ","_")} scenario de-initialization */
void MX_${LPBAM_NAME?replace(" ","_")}_${ScenarioName?replace(" ","_")}_DeInit(void);

/* ${LPBAM_NAME?replace(" ","_")} application ${ScenarioName?replace(" ","_")} scenario build */
void MX_${LPBAM_NAME?replace(" ","_")}_${ScenarioName?replace(" ","_")}_Build(void);

/* ${LPBAM_NAME?replace(" ","_")} application ${ScenarioName?replace(" ","_")} scenario link */
void MX_${LPBAM_NAME?replace(" ","_")}_${ScenarioName?replace(" ","_")}_Link(DMA_HandleTypeDef *hdma);

/* ${LPBAM_NAME?replace(" ","_")} application ${ScenarioName?replace(" ","_")} scenario unlink */
void MX_${LPBAM_NAME?replace(" ","_")}_${ScenarioName?replace(" ","_")}_UnLink(DMA_HandleTypeDef *hdma);

/* ${LPBAM_NAME?replace(" ","_")} application ${ScenarioName?replace(" ","_")} scenario start */
void MX_${LPBAM_NAME?replace(" ","_")}_${ScenarioName?replace(" ","_")}_Start(DMA_HandleTypeDef *hdma);

/* ${LPBAM_NAME?replace(" ","_")} application ${ScenarioName?replace(" ","_")} scenario stop */
void MX_${LPBAM_NAME?replace(" ","_")}_${ScenarioName?replace(" ","_")}_Stop(DMA_HandleTypeDef *hdma);

#endif /* LPBAM_${LPBAM_NAME?replace(" ","_")?upper_case}_H */
