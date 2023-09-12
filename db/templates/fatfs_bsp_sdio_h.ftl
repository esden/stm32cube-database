[#ftl]
/**
 ******************************************************************************
 [#assign familyName=FamilyName?lower_case]
 [#if familyName="stm32f1"]
 * @file    bsp_driver_sd.h for F1 (based on stm3210e_eval_sd.h)
 [/#if]
 [#if familyName="stm32f2"]
 * @file    bsp_driver_sd.h for F2 (based on stm322xg_eval_sd.h)
 [/#if]
 [#if familyName="stm32f4"]
 * @file    bsp_driver_sd.h for F4 (based on stm324x9i_eval_sd.h)
 [/#if]
  * @brief   This file contains the common defines and functions prototypes for 
  *          the bsp_driver_sd.c driver.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${FamilyName}_SD_H
#define __${FamilyName}_SD_H

#ifdef __cplusplus
 extern "C" {
#endif 

/* Includes ------------------------------------------------------------------*/
#include "${FamilyName?lower_case}xx_hal.h"
[#if Platform??]
#include "fatfs_platform.h"
[/#if]

/* Exported types --------------------------------------------------------*/ 
/** 
  * @brief SD Card information structure 
  */
#define BSP_SD_CardInfo HAL_SD_CardInfoTypeDef

/* Exported constants --------------------------------------------------------*/ 
/**
  * @brief  SD status structure definition  
  */     
#define   MSD_OK                        ((uint8_t)0x00)
#define   MSD_ERROR                     ((uint8_t)0x01)

/** 
  * @brief  SD transfer state definition  
  */     
#define   SD_TRANSFER_OK                ((uint8_t)0x00)
#define   SD_TRANSFER_BUSY              ((uint8_t)0x01)

#define SD_PRESENT               ((uint8_t)0x01)
#define SD_NOT_PRESENT           ((uint8_t)0x00)
#define SD_DATATIMEOUT           ((uint32_t)100000000)

#ifdef OLD_API
/* kept to avoid issue when migrating old projects. */
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */ 
#else
/* USER CODE BEGIN BSP_H_CODE */
/* Exported functions --------------------------------------------------------*/   
uint8_t BSP_SD_Init(void);
uint8_t BSP_SD_ITConfig(void);
void    BSP_SD_DetectIT(void);
void    BSP_SD_DetectCallback(void);
uint8_t BSP_SD_ReadBlocks(uint32_t *pData, uint32_t ReadAddr, uint32_t NumOfBlocks, uint32_t Timeout);
uint8_t BSP_SD_WriteBlocks(uint32_t *pData, uint32_t WriteAddr, uint32_t NumOfBlocks, uint32_t Timeout);
uint8_t BSP_SD_ReadBlocks_DMA(uint32_t *pData, uint32_t ReadAddr, uint32_t NumOfBlocks);
uint8_t BSP_SD_WriteBlocks_DMA(uint32_t *pData, uint32_t WriteAddr, uint32_t NumOfBlocks);
uint8_t BSP_SD_Erase(uint32_t StartAddr, uint32_t EndAddr);
void BSP_SD_IRQHandler(void);
void BSP_SD_DMA_Tx_IRQHandler(void);
void BSP_SD_DMA_Rx_IRQHandler(void);
uint8_t BSP_SD_GetCardState(void);
void    BSP_SD_GetCardInfo(HAL_SD_CardInfoTypeDef *CardInfo);
uint8_t BSP_SD_IsDetected(void);

/* These functions can be modified in case the current settings (e.g. DMA stream)
   need to be changed for specific application needs */
void    BSP_SD_AbortCallback(void);
void    BSP_SD_WriteCpltCallback(void);
void    BSP_SD_ReadCpltCallback(void);
/* USER CODE END BSP_H_CODE */
#endif
   
#ifdef __cplusplus
}
#endif

#endif /* __${FamilyName}_SD_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/