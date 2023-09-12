[#ftl]
/**
  ******************************************************************************
  * @file    mbmux_table.h
  * @author  MCD Application Team
  * @brief   Maps the IPCC channels to memory buffers
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MBMUX_TABLE_H__
#define __MBMUX_TABLE_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32wlxx_hal_ipcc.h"
#include "features_info.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported constants --------------------------------------------------------*/
#define  MBMUX_CHANNEL_NUMBER  IPCC_CHANNEL_NUMBER

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported types ------------------------------------------------------------*/

typedef enum
{
  MBMUX_CMD_RESP  = 0x00U,  /*!< Channel direction Tx is used by an MCU to transmit */
  MBMUX_NOTIF_ACK  = 0x01U   /*!< Channel direction Rx is used by an MCU to receive */
} MBMUX_ComType_t;

typedef struct
{
  uint32_t MsgId;
  void (*MsgCm4Cb)(void *ComObj);
  void (*MsgCm0plusCb)(void *ComObj);
  uint16_t BufSize;      /*!<  size of the array given by the applic */
  uint16_t ParamCnt;     /*!<  nr of words composing the message */
  uint32_t *ParamBuf;
  uint32_t ReturnVal;    /*!<  only used in RX */
} MBMUX_ComParam_t;

typedef struct
{
  MBMUX_ComParam_t        MBCmdRespParam[MBMUX_CHANNEL_NUMBER];
  MBMUX_ComParam_t        MBNotifAckParam[MBMUX_CHANNEL_NUMBER];
  uint8_t                 MBMUXMapping[FEAT_INFO_CNT][2];
  __IO uint16_t           SynchronizeCpusAtBoot;
  uint16_t                ChipRevId;
} MBMUX_ComTable_t;

/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /* __MBMUX_TABLE_H__ */
