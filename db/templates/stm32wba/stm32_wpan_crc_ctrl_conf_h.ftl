[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    crc_ctrl_conf.h
  * @author  MCD Application Team
  * @brief   Configuration Header for crc_ctrl.c module
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign PG_SKIP_LIST = "False"]
[#assign myHash = {}]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#assign myHash = {definition.name:definition.value} + myHash]
        [/#list]
    [/#if]
[/#list]
[#--
Key & Value:
[#list myHash?keys as key]
Key: ${key}; Value: ${myHash[key]}
[/#list]
--]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef CRC_CTRL_CONF_H
#define CRC_CTRL_CONF_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
/* Own header files */
#include "crc_ctrl.h"

/* CRC configuration types */
#include "stm32wbaxx_hal_crc.h"

/* Exported defines ----------------------------------------------------------*/
/**
 * @brief Physical address of the CRC to use
 */
#define CRCCTRL_HWADDR   CRC

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* External variables --------------------------------------------------------*/
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
/**
 * @brief Handle used by the Simple NVM Arbiter to access the CRC functions
 */
extern CRCCTRL_Handle_t SNVMA_Handle;
[/#if]

/* Exported macros -----------------------------------------------------------*/
/* Exported functions prototypes ---------------------------------------------*/

#ifdef __cplusplus
}
#endif

#endif /* CRC_CTRL_CONF_H */
