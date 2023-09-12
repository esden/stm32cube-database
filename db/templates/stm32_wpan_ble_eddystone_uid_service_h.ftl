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
#ifndef EDDYSTONE_UID_SERVICE_H
#define EDDYSTONE_UID_SERVICE_H

#ifdef __cplusplus
extern "C" 
{
#endif

/* Includes ------------------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
typedef struct
{
  uint16_t AdvertisingInterval;/*!< Specifies the desired advertising interval. */
  uint8_t CalibratedTxPower;   /*!< Specifies the power at 0m. */
  uint8_t * NamespaceID;       /*!< Specifies the 10-byte namespace to which the beacon belongs. */
  uint8_t * BeaconID;          /*!< Specifies the unique 6-byte beacon ID within the specified namespace. */
} EddystoneUID_InitTypeDef;


/* Exported constants --------------------------------------------------------*/
/* Exported Macros -----------------------------------------------------------*/
/* Exported functions --------------------------------------------------------*/
tBleStatus EddystoneUID_Init(EddystoneUID_InitTypeDef *EddystoneUID_Init);
void EddystoneUID_Process(void);

#ifdef __cplusplus
}
#endif

#endif /* EDDYSTONE_UID_SERVICE_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
