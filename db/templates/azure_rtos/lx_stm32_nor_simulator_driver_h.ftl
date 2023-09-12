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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef LX_STM32_NOR_SIMULATOR_DRIVER_H
#define LX_STM32_NOR_SIMULATOR_DRIVER_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "lx_api.h"

#include "${FamilyName?lower_case}xx.h"


[#assign nor_flash_addr = "SRAM3_BASE"]
[#assign nor_flash_size = (128 * 1024)]

[#assign nor_sector_size = 512]
[#assign nor_sectors_per_block = 16]

[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]

    [#if name == "LX_NOR_SIM_BASE_ADDRESS"]
      [#assign nor_flash_addr = value]
    [/#if]

    [#if name == "LX_NOR_SIM_FLASH_SIZE"]
      [#assign nor_flash_size = value]
    [/#if]

    [#if name == "LX_NOR_SIM_SECTOR_SIZE"]
      [#assign nor_sector_size = value]
    [/#if]

    [#if name == "LX_NOR_SIM_SECTORS_PER_BLOCK"]
      [#assign nor_sectors_per_block = value]
    [/#if]
    [/#list]
[/#if]
[/#list]
[/#compress]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
#define LX_NOR_SIMULATOR_FLASH_BASE_ADDRESS  ${nor_flash_addr}

#define LX_NOR_SIMULATOR_FLASH_SIZE          ${nor_flash_size}

#define LX_NOR_SIMULATOR_SECTOR_SIZE         ${nor_sector_size}

#define LX_NOR_SIMULATOR_SECTORS_PER_BLOCK   ${nor_sectors_per_block}

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/* Define the function prototypes of the LevelX driver entry function.  */
UINT  lx_stm32_nor_simulator_initialize(LX_NOR_FLASH *nor_flash);

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
#endif /* STM32_FX_LEVELX_DRIVER_H */

