[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    simple_nvm_arbiter_conf.c
  * @author  MCD Application Team
  * @brief   The Simple NVM arbiter module provides an interface to write and/or
  *          restore data from SRAM to FLASH with use of NVMs.
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

/* Memset */
#include <string.h>

/* Own header files */
#include "simple_nvm_arbiter_conf.h"
#include "simple_nvm_arbiter_common.h"

/* Global variables ----------------------------------------------------------*/
/* Private defines -----------------------------------------------------------*/
/* Private macros ------------------------------------------------------------*/
/* Private typedef -----------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/

[#if myHash["SNVMA_NVM_NUMBER"]?number != 0]
/* Representation of the NVM configuration */
SNVMA_NvmElt_t SNVMA_NvmConfiguration [SNVMA_NVM_NUMBER] =
{
[#list 1..myHash["SNVMA_NVM_NUMBER"]?number as nvm_number]
  /* NVM ID #${nvm_number} */
  {
    .BankNumber = SNVMA_NVM_ID_${nvm_number}_BANK_NUMBER,
    .BankSize = SNVMA_NVM_ID_${nvm_number}_BANK_SIZE,
  },
[/#list]
};
[/#if]

/* Callback prototypes -------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Functions Definition ------------------------------------------------------*/
/* Callback Definition -------------------------------------------------------*/
/* Private functions Definition ----------------------------------------------*/
