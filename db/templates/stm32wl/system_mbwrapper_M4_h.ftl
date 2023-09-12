[#ftl]
/**
  ******************************************************************************
  * @file    system_mbwrapper.h
  * @author  MCD Application Team
  * @brief   This file implements the CM4 side wrapper of the Radio interface
  *          shared between M0 and M4.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __SYSTEM_MBWRAPPER_CM4_H__
#define __SYSTEM_MBWRAPPER_CM4_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "sgfx_eeprom_if.h"
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions ------------------------------------------------------- */
uint32_t SYS_EE_ReadBuffer_mbwrapper(e_EE_ID EEsgfxID,  uint32_t *data);
uint32_t SYS_EE_WriteBuffer_mbwrapper(e_EE_ID EEsgfxID,  uint32_t data);
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__SYSTEM_MBWRAPPER_CM4_H__*/

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
