[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    simple_nvm_arbiter_conf.h
  * @author  MCD Application Team
  * @brief   Configuration header for simple_nvm_arbiter.c module
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
#ifndef SIMPLE_NVM_ARBITER_CONF_H
#define SIMPLE_NVM_ARBITER_CONF_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "utilities_common.h"

#include "simple_nvm_arbiter_common.h"

#include "stm32wbaxx_hal_flash.h"

/* Exported constants --------------------------------------------------------*/

/* ========================================================================== */
/* +                            NVM part - USER DEFINED                     + */
/* ========================================================================== */

/**
 * @brief Number of managed NVMs
 *
 * @details This number must be lower than SNVMA_MAX_NUMBER_NVM
 *
 */
#define SNVMA_NVM_NUMBER                ${myHash["SNVMA_NVM_NUMBER"]}u

/**
 * @brief Polynomial value for CRC16
 *
 */
#define SNVMA_POLY_CRC16                0x${myHash["SNVMA_POLY_CRC16"]}u

/* Check that NVM number does not exceed limitations */
#if SNVMA_NVM_NUMBER > SNVMA_MAX_NUMBER_NVM
#error Number of NVM to manage is to high
#endif /* SNVMA_NVM_NUMBER > SNVMA_MAX_NUMBER_NVM */

/* ========================================================================== */
/* +                        NVM IDs part - USER DEFINED                     + */
/* ========================================================================== */

[#list 1..myHash["SNVMA_NVM_NUMBER"]?number as nvm_number]
/* NVM ID #${nvm_number} */
#define ${myHash["SNVMA_NVM_ID_${nvm_number}"]}
#define SNVMA_NVM_ID_${nvm_number}_BANK_NUMBER      ${myHash["SNVMA_NVM_ID_${nvm_number}_BANK_NUMBER"]}u
#define SNVMA_NVM_ID_${nvm_number}_BANK_SIZE        ${myHash["SNVMA_NVM_ID_${nvm_number}_BANK_SIZE"]}u

#if (SNVMA_NVM_ID_${nvm_number}_BANK_NUMBER == 0u) || (SNVMA_NVM_ID_${nvm_number}_BANK_SIZE == 0u)
#error NVM ID #${nvm_number} => Bank not initialized
#elif (SNVMA_NVM_ID_${nvm_number}_BANK_NUMBER < SNVMA_MIN_NUMBER_BANK)
#error NVM ID #${nvm_number} => Not enough bank
#endif

[/#list]
/* ========================================================================== */
/* +                       Check part - NOT USER DEFINED                    + */
/* ========================================================================== */

/* Compute the number of sectors required */
[#assign SNVMA_NUMBER_OF_SECTOR_NEEDED = ""]
[#list 1..myHash["SNVMA_NVM_NUMBER"]?number as nvm_number]
[#assign SNVMA_NUMBER_OF_SECTOR_NEEDED = SNVMA_NUMBER_OF_SECTOR_NEEDED + "(SNVMA_NVM_ID_" + nvm_number?string  + "_BANK_NUMBER * SNVMA_NVM_ID_" + nvm_number?string + "_BANK_SIZE) + "]
[/#list]

#define SNVMA_NUMBER_OF_SECTOR_NEEDED ${SNVMA_NUMBER_OF_SECTOR_NEEDED?remove_ending(" + ")}

[#assign SNVMA_NUMBER_OF_BANKS = "("]
[#list 1..myHash["SNVMA_NVM_NUMBER"]?number as nvm_number]
[#assign SNVMA_NUMBER_OF_BANKS = SNVMA_NUMBER_OF_BANKS + "SNVMA_NVM_ID_" + nvm_number?string  + "_BANK_NUMBER + "]
[/#list]
[#assign SNVMA_NUMBER_OF_BANKS = SNVMA_NUMBER_OF_BANKS?remove_ending(" + ")]
[#assign SNVMA_NUMBER_OF_BANKS = SNVMA_NUMBER_OF_BANKS + ")"]

#define SNVMA_NUMBER_OF_BANKS ${SNVMA_NUMBER_OF_BANKS}

/* Check that required number of sector does not exceed Flash capacities */
#if SNVMA_NUMBER_OF_SECTOR_NEEDED == 0u
#error SNVMA_NUMBER_OF_SECTOR_NEEDED shall not be zero
#elif SNVMA_NUMBER_OF_BANKS == 0u
#error SNVMA_NUMBER_OF_BANKS shall not be zero
#endif /* SNVMA_NUMBER_OF_SECTOR_NEEDED == 0 */

/* Exported types ------------------------------------------------------------*/

/* ========================================================================== */
/* +                    Buffer ID part - CAN BE USER DEFINED                + */
/* ========================================================================== */

/**
 * @brief Enumeration of the Buffer IDs available
 *
 * @details Each NVM can handle up to 4 user IDs
 *
 * @details Enumeration member can be renamed to fit user needs - ie: SNVMA_BufferId_4 => SNVMA_BleNvmId
 *
 */
typedef enum SNVMA_BufferId
{
[#list 1..(myHash["SNVMA_NVM_NUMBER"]?number) as nvm_number]
  [#list 1..4 as buffer_nbr]
  ${myHash["SNVMA_NVM_ID_${nvm_number}_BUFFER_${buffer_nbr}_NAME"]},
  [/#list]
[/#list]
[#if (PG_SKIP_LIST == "True")]
  SNVMA_BufferId_1,
  SNVMA_BufferId_2,
  SNVMA_BufferId_3,
[/#if]
  SNVMA_BufferId_Max  /* End of the enumeration */
}SNVMA_BufferId_t;

/* Exported variables --------------------------------------------------------*/
/* Exported macros -----------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */

#ifdef __cplusplus
}
#endif

#endif /* SIMPLE_NVM_ARBITER_CONF_H */
