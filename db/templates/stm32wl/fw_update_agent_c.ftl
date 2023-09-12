[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    fw_update_agent.c
  * @author  MCD Application Team
  * @brief   This file provides set of functions to manage Firmware Update functionalities.
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign STM32WL5MXX = "false"]
[#assign INTERNAL_LORAWAN_FUOTA = "0"]
[#if SWIPdatas??]
    [#list SWIPdatas as SWIP]
        [#if SWIP.defines??]
            [#list SWIP.defines as definition]
                [#if definition.name == "STM32WL5MXX"]
                    [#assign STM32WL5MXX = definition.value]
                [/#if]
            [/#list]
        [/#if]
    [/#list]
[/#if]

/* Includes ------------------------------------------------------------------*/
#include "platform.h"
[#if INTERNAL_LORAWAN_FUOTA == "1"]
#define SFU_FWIMG_COMMON_C
#include "sfu_fwimg_regions.h"
[/#if]
#include "fw_update_agent.h"
#include "sys_app.h"
#include "utilities.h"

#include "flash_if.h"
[#if INTERNAL_LORAWAN_FUOTA == "1"]
#include "se_def_metadata.h"
[/#if]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/
#if (INTEROP_TEST_MODE == 0)
void FwUpdateAgent_Run(void)
{
  /* USER CODE BEGIN FwUpdateAgent_Run_1 */

  /* USER CODE END FwUpdateAgent_Run_1 */
[#if INTERNAL_LORAWAN_FUOTA == "1"]
  int32_t status = FLASH_IF_OK;
[#if (STM32WL5MXX == "false")]
  uint8_t fw_header_dwl_slot[SE_FW_HEADER_TOT_LEN];

  /* Read header in slot 1 */
  FLASH_IF_Read((void *)fw_header_dwl_slot, (const void *)FRAG_DECODER_DWL_REGION_START, SE_FW_HEADER_TOT_LEN);

  /* Ask for installation at next reset */
  status = FLASH_IF_Erase((void *)FRAG_DECODER_SWAP_REGION_START, FRAG_DECODER_SWAP_REGION_SIZE);

  if (status == FLASH_IF_OK)
  {
    status = FLASH_IF_Write((void *)FRAG_DECODER_SWAP_REGION_START,
                            (const void *)fw_header_dwl_slot,
                            SE_FW_HEADER_TOT_LEN);
  }

[/#if]
  if (status == FLASH_IF_OK)
  {
#if ( LORAWAN_PACKAGES_VERSION == 1 )
    /* only required without Firmware Management protocol */
    /* System Reboot*/
    NVIC_SystemReset();
#endif /* LORAWAN_PACKAGES_VERSION */
  }
  else
  {
    APP_LOG(TS_OFF, VLEVEL_M, "FW Update Agent Run Failed\r\n");
  }
  /* USER CODE BEGIN FwUpdateAgent_Run_2 */

  /* USER CODE END FwUpdateAgent_Run_2 */
[/#if]
}
#endif /* INTEROP_TEST_MODE */

/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/
/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
