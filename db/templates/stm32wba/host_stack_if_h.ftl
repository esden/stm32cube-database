[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    host_stack_if.h
  * @author  MCD Application Team
  * @brief : This file contains the interface for the stack tasks
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

#ifndef HOST_STACK_IF_H
#define HOST_STACK_IF_H

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
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

/* Exported functions prototypes ---------------------------------------------*/
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled")]
void BleStackCB_Process(void);
[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 2 */

/* USER CODE END 2 */

#endif /* HOST_STACK_IF_H */
