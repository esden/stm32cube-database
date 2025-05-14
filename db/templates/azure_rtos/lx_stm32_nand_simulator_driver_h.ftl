[#ftl]
/**************************************************************************/
/*                                                                        */
/*       Copyright (c) Microsoft Corporation. All rights reserved.        */
/*                                                                        */
/*       This software is licensed under the Microsoft Software License   */
/*       Terms for Microsoft Azure RTOS. Full text of the license can be  */
/*       found in the LICENSE file at https://aka.ms/AzureRTOS_EULA       */
/*       and in the root directory of this software.                      */
/*                                                                        */
/**************************************************************************/

#ifndef LX_STM32_NAND_SIMULATOR_DRIVER_H
#define LX_STM32_NAND_SIMULATOR_DRIVER_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "lx_api.h"
#include "${FamilyName?lower_case}xx_hal.h"
[#assign nand_sim_total_blocks = 8]
[#assign nand_sim_pages_per_block = 16]
[#assign nand_sim_bytes_per_page = 2048]
[#assign nand_sim_spare_bytes_per_page = 64]
[#assign nand_sim_bad_block_byte_position = 3]
[#assign nand_sim_extra_bytes_position = 5]

[#if FamilyName?lower_case != "stm32mp13"]
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
    [#if name == "LX_NAND_SIM_TOTAL_BLOCKS"]
      [#assign nand_sim_total_blocks = value]
    [/#if]
    [#if name == "LX_NAND_SIM_PAGES_PER_BLOCK"]
      [#assign nand_sim_pages_per_block = value]
    [/#if]
   
    [#if name == "LX_NAND_SIM_BYTES_PER_PAGE"]
      [#assign nand_sim_bytes_per_page = value]
    [/#if]
    [#if name == "LX_NAND_SIM_SPARE_BYTES_PER_PAGE"]
      [#assign nand_sim_spare_bytes_per_page = value]
    [/#if]
    [#if name == "LX_NAND_SIM_EXTRA_BYTES_POSITION"]
      [#assign nand_sim_extra_bytes_position = value]
    [/#if]
    [#if name == "LX_NAND_SIM_BAD_BLOCK_BYTE_POSITION"]
      [#assign nand_sim_bad_block_byte_position = value]
    [/#if]
    [/#list]
[/#if]
[/#list]
[/#compress]
[/#if]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/

[#if FamilyName?lower_case == "stm32u0" || FamilyName?lower_case == "stm32c0"]
/* Number of blocks of the simulated NAND memory */
#define TOTAL_BLOCKS                        ${nand_sim_total_blocks}
/* Number of pages in each block */
#define PHYSICAL_PAGES_PER_BLOCK            ${nand_sim_pages_per_block}
/* Page size in bytes */
#define BYTES_PER_PHYSICAL_PAGE             ${nand_sim_bytes_per_page}
/* Page size in words */
#define WORDS_PER_PHYSICAL_PAGE             (${nand_sim_bytes_per_page} / 4)
/* Number of spare bytes for every page */
#define SPARE_BYTES_PER_PAGE                ${nand_sim_spare_bytes_per_page}
/* Bad block byte position within the spare bytes */
#define BAD_BLOCK_POSITION                  ${nand_sim_bad_block_byte_position}
/* Start position for the extra bytes within the spare bytes */
#define EXTRA_BYTE_POSITION                 ${nand_sim_extra_bytes_position}

[#else] 
#define TOTAL_BLOCKS                        8

#define PHYSICAL_PAGES_PER_BLOCK            16        /* Min value of 2            */
#define BYTES_PER_PHYSICAL_PAGE             2048      /* 2048 bytes per page       */

#define WORDS_PER_PHYSICAL_PAGE             2048/4    /* Words per page            */
#define SPARE_BYTES_PER_PAGE                64        /* 64 "spare" bytes per page */
#define BAD_BLOCK_POSITION                  0         /* 0 is the bad block byte position*/
#define EXTRA_BYTE_POSITION                 2         /* 2 is the extra bytes starting byte position*/
[/#if]
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/

/* Define the function prototypes of the LevelX driver entry function.  */

UINT  lx_stm32_nand_simulator_initialize(LX_NAND_FLASH *nor_flash);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif
#endif /* LX_STM32_NAND_SIMULATOR_DRIVER_H */

