[#ftl]
/* USER CODE BEGIN Header */
/**
 ******************************************************************************
  * File Name          : ${name}
  * Description        : 
 ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
 ******************************************************************************
 */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef EDDYSTONE_TLM_SERVICE_H
#define EDDYSTONE_TLM_SERVICE_H

#ifdef __cplusplus
extern "C" 
{
#endif

/* Includes ------------------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported Macros -----------------------------------------------------------*/
/* Exported functions --------------------------------------------------------*/
void EddystoneTLM_Process(void);

#ifdef __cplusplus
}
#endif

#endif /* EDDYSTONE_TLM_SERVICE_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
