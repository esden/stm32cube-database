[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ll_sys_if.h
  * @author  MCD Application Team
  * @brief   Header file for initiating system
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
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
#ifndef LL_SYS_IF_H
#define LL_SYS_IF_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if (myHash["BLE"] == "Enabled")]
[#if myHash["THREADX_STATUS"]?number == 1 ]
#include "tx_api.h"
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
#include "cmsis_os2.h"
[/#if]
[/#if]

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled")  || (myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled")]
#define DRIFT_TIME_DEFAULT                      (13)
#define DRIFT_TIME_EXTRA_LSI2                   (9)
#define DRIFT_TIME_EXTRA_GCC_DEBUG              (6)

#define EXEC_TIME_DEFAULT                       (10)
#define EXEC_TIME_EXTRA_LSI2                    (3)
#define EXEC_TIME_EXTRA_GCC_DEBUG               (4)

#define SCHDL_TIME_DEFAULT                      (20)
[/#if]
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
[#if (myHash["BLE"] == "Enabled")]
[#if myHash["THREADX_STATUS"]?number == 1 ]
/* LINK_LAYER_TASK related resources */
extern TX_MUTEX           LinkLayerMutex;

[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
extern osMutexId_t LinkLayerMutex;

[/#if]
[/#if]
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
void ll_sys_bg_temperature_measurement(void);
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*LL_SYS_IF_H */
