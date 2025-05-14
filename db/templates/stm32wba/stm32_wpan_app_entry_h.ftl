[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_entry.h
  * @author  MCD Application Team
  * @brief   Interface to the application
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign PG_FILL_UCS = "False"]
[#assign PG_BSP_NUCLEO_WBA52CG = 0]
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
#ifndef APP_ENTRY_H
#define APP_ENTRY_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/

/* Private includes ----------------------------------------------------------*/
#include "app_common.h"
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
#include "tx_api.h"
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
[/#if]
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
#define WPAN_SUCCESS 0u

[#if (myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled")]
/******************************************************************************
 * Information Table
 *
 * Version
 * [0:3]   = Build - 0: Untracked - 15:Released - x: Tracked version
 * [4:7]   = branch - 0: Mass Market - x: ...
 * [8:15]  = Subversion
 * [16:23] = Version minor
 * [24:31] = Version major
 *
 ******************************************************************************/
#define CFG_FW_BUILD              (0)
#define CFG_FW_BRANCH             (0)
#define CFG_FW_SUBVERSION         (0)
#define CFG_FW_MINOR_VERSION      (5)
#define CFG_FW_MAJOR_VERSION      (1)

[/#if]
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported variables --------------------------------------------------------*/
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
extern TX_BYTE_POOL *pBytePool; /* ThreadX byte pool pointer for whole WPAN middleware */
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
[/#if]
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macros ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
void MX_APPE_Config(void);
uint32_t MX_APPE_Init(void *p_param);
[#if (myHash["OTHER_THAN_BLE"]?number == 1)]
void MX_APPE_LinkLayerInit(void);
[/#if]
[#if myHash["SEQUENCER_STATUS"]?number == 1 || (myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled")]
void MX_APPE_Process(void);
[/#if]

/* USER CODE BEGIN EFP */
[#if PG_FILL_UCS == "True"]
[#if PG_BSP_NUCLEO_WBA52CG == 1]
#if (CFG_BUTTON_SUPPORTED == 1)
uint8_t APPE_ButtonIsLongPressed(uint16_t btnIdx);
void APPE_Button1Action(void);
void APPE_Button2Action(void);
void APPE_Button3Action(void);
#endif
[/#if]
[/#if]

/* USER CODE END EFP */

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /*APP_ENTRY_H */
