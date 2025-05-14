[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    temp_measurement.h
  * @author  MCD Application Team
  * @brief   Header for temp_measurement.c module
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef TEMP_MEASUREMENT_H
#define TEMP_MEASUREMENT_H

/* Includes ------------------------------------------------------------------*/
#include "utilities_common.h"

/* Exported defines ----------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
/**
 * @brief Temperature Measurement command status codes
 */
typedef enum TEMPMEAS_Cmd_Status
{
  TEMPMEAS_OK,
  TEMPMEAS_NOK,
  TEMPMEAS_ADC_INIT,
  TEMPMEAS_UNKNOWN,
} TEMPMEAS_Cmd_Status_t;

/* Exported constants --------------------------------------------------------*/
/* External variables --------------------------------------------------------*/
/* Exported macros -----------------------------------------------------------*/
/* Exported functions prototypes ---------------------------------------------*/

/**
  * @brief  Initialize the temperature measurement
  * 
  * @retval Operation state
  */
TEMPMEAS_Cmd_Status_t TEMPMEAS_Init (void);

/**
  * @brief  Request temperature measurement
  * @param  None
  * @retval None
  */
void TEMPMEAS_RequestTemperatureMeasurement (void);

#endif /* TEMP_MEASUREMENT_H */
