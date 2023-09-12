[#ftl]
[#assign CPUCORE = cpucore?replace("ARM_CORTEX_","C")?replace("+","PLUS")]
/**
  ******************************************************************************
  * @file    sigfox_mbwrapper.h
  * @author  MCD Application Team
  * @brief   This file implements the CM0 side wrapper of the SigfoxMac interface
  *          shared between M0 and M4.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __SIGFOX_MBWRAPPER_${CPUCORE}_H__
#define __SIGFOX_MBWRAPPER_${CPUCORE}_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "mbmux_table.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
[#if CPUCORE == "CM4"]
/*!
  * Sigfox callback structure
*/
typedef struct sSigfoxCallback
{
  /*!
  * \brief   Measures the battery level
  *
  * \retval  Battery level [0: node is connected to an external
  *          power source, 1..254: battery level, where 1 is the minimum
  *          and 254 is the maximum value, 255: the node was not able
  *          to measure the battery level]
  */
  uint16_t (*GetBatteryLevel)(void);
  /*!
  * \brief   Measures the temperature level
  *
  * \retval  Temperature level
  */
  int16_t (*GetTemperatureLevel)(void);
} SigfoxCallback_t;
[/#if]

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
[#if CPUCORE == "CM4"]
void Process_Sigfox_Notif(MBMUX_ComParam_t *ComObj);

void Sigfox_Register(SigfoxCallback_t *SigfoxCallback);
[#elseif CPUCORE == "CM0PLUS"]
void Process_Sigfox_Cmd(MBMUX_ComParam_t *ComObj);

uint16_t GetBatteryLevel_mbwrapper(void);

int16_t GetTemperatureLevel_mbwrapper(void);
[/#if]

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__SIGFOX_MBWRAPPER_${CPUCORE}_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
