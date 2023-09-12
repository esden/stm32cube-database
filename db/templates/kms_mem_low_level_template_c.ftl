[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    kms_mem_low_level.c
  * @author  MCD Application Team
  * @brief   This file contains implementations for Key Management Services (KMS)
  *          memory management Low Level function to custom memory allocator
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
#include "kms.h"
#include "kms_mem.h"
/* USER CODE BEGIN KMS_MEM_LOW_LEVEL_Includes */
/* USER CODE END KMS_MEM_LOW_LEVEL_Includes */

/** @addtogroup Key_Management_Services Key Management Services (KMS)
  * @{
  */

/** @addtogroup KMS_MEM_LL Memory management Low Level access
  * @{
  */

/* Private types -------------------------------------------------------------*/
/* USER CODE BEGIN KMS_MEM_LOW_LEVEL_Private_Types */
/* USER CODE END KMS_MEM_LOW_LEVEL_Private_Types */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN KMS_MEM_LOW_LEVEL_Private_Defines */
/* USER CODE END KMS_MEM_LOW_LEVEL_Private_Defines */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN KMS_MEM_LOW_LEVEL_Private_Macros */
/* USER CODE END KMS_MEM_LOW_LEVEL_Private_Macros */

/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN KMS_MEM_LOW_LEVEL_Private_Variables */
/* USER CODE END KMS_MEM_LOW_LEVEL_Private_Variables */

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN KMS_MEM_LOW_LEVEL_Private_Function_Prototypes */
/* USER CODE END KMS_MEM_LOW_LEVEL_Private_Function_Prototypes */

/* Private function ----------------------------------------------------------*/
/* USER CODE BEGIN KMS_MEM_LOW_LEVEL_Private_Functions */
/* USER CODE END KMS_MEM_LOW_LEVEL_Private_Functions */

/* Exported functions --------------------------------------------------------*/
/* USER CODE BEGIN KMS_MEM_LOW_LEVEL_Private_Exported_Functions */
/* USER CODE END KMS_MEM_LOW_LEVEL_Private_Exported_Functions */


/**
  * @brief  Initialize memory management
  */
void KMS_MemInit(void)
{
  /* USER CODE BEGIN KMS_MemInit */
  /* Put your own implementation here */
  /* USER CODE END KMS_MemInit */
}

/**
  * @brief  Allocate memory
  * @param  session Session requesting the memory
  * @param  size Size of the memory to allocate
  * @retval Allocated pointer if successful to allocate, NULL_PTR if failed
  */
CK_VOID_PTR KMS_Alloc(CK_SESSION_HANDLE session, size_t size)
{
  /* USER CODE BEGIN KMS_Alloc */
  /* Put your own implementation here */
  return NULL;
  /* USER CODE END KMS_Alloc */
}

/**
  * @brief  Free memory
  * @param  session Session freeing the memory
  * @param  ptr     Pointer to the memory to free
  * @retval None
  */
void KMS_Free(CK_SESSION_HANDLE session, CK_VOID_PTR ptr)
{
  /* USER CODE BEGIN KMS_Free */
  /* Put your own implementation here */
  /* USER CODE END KMS_Free */
}

/**
  * @}
  */

/**
  * @}
  */

