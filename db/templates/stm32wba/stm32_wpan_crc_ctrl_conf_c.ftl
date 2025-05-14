[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    crc_ctrl_conf.c
  * @author  MCD Application Team
  * @brief   Source for CRC client controller module configuration file
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

/* Includes ------------------------------------------------------------------*/
/* Own header files */
#include "crc_ctrl.h"

/* HAL CRC header */
#include "stm32wbaxx_hal_crc.h"

/* Global variables ----------------------------------------------------------*/
/* Private defines -----------------------------------------------------------*/
/* Private macros ------------------------------------------------------------*/
/* Private typedef -----------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
/**
 * @brief CRC Handle configuration for SNVMA use
 */
CRCCTRL_Handle_t SNVMA_Handle =
{
  .Uid = 0x00,
  .PreviousComputedValue = 0x00,
  .State = HANDLE_NOT_REG,
  .Configuration =
  {
    .DefaultPolynomialUse = DEFAULT_POLYNOMIAL_DISABLE,
    .DefaultInitValueUse = DEFAULT_INIT_VALUE_ENABLE,
    .GeneratingPolynomial = 7607,
    .CRCLength = CRC_POLYLENGTH_16B,
    .InputDataInversionMode = CRC_INPUTDATA_INVERSION_NONE,
    .OutputDataInversionMode = CRC_OUTPUTDATA_INVERSION_DISABLE,
    .InputDataFormat = CRC_INPUTDATA_FORMAT_WORDS,
  },
};
[/#if]

/* USER CODE BEGIN User CRC configurations */

/* USER CODE END User CRC configurations */

/* Callback prototypes -------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Functions Definition ------------------------------------------------------*/
/* Callback Definition -------------------------------------------------------*/
/* Private functions Definition ----------------------------------------------*/
