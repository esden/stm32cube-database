[#ftl]
/**
  ******************************************************************************
  * @file    sigfox_info.h
  * @author  MCD Application Team
  * @brief   To give info to the application about Sigfox configuration
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

#ifndef __SIGFOX_INFO_H__
#define __SIGFOX_INFO_H__
#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/*!
 * To give info to the application about Sigfox capability
 * it can depend how it has been compiled (e.g. compiled regions ...)
 * Params should be better uint32_t foe easier alignment with info_table concept
 */
typedef struct
{
  uint32_t Region;   /*!< Combination of regions  */
} SigfoxInfo_t;

/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/**
  * @brief initialises the SigfoxInfo table
  * @param none
  * @retval  none
  */
void SigfoxInfo_Init(void);

/**
  * @brief returns the pointer to the SigfoxMacInfo table
  * @param none
  * @retval  SigfoxMacInfoTable pointer
  */
SigfoxInfo_t *SigfoxInfo_GetPtr(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __SIGFOX_INFO_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
