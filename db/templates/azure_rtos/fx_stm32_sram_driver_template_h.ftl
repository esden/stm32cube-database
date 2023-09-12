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

#ifndef FX_STM32_SRAM_DRIVER_H
#define FX_STM32_SRAM_DRIVER_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "fx_api.h"

/* include the ${FamilyName?lower_case}xx.h to be able to access the memory region defines */
#include "${FamilyName?lower_case}xx.h"

[#assign ram_disk_addr = "D1_AXISRAM_BASE"]
[#assign ram_disk_size = (128 * 1024)]

[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]

    [#if name == "FX_SRAM_BASE_ADDRESS"]
      [#assign ram_disk_addr = value]
    [/#if]

    [#if name == "SRAM_DISK_SIZE"]
      [#assign ram_disk_size = value]
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
#define FX_SRAM_DISK_BASE_ADDRESS         ${ram_disk_addr}
#define FX_SRAM_DISK_SIZE                 ${ram_disk_size}

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
VOID fx_stm32_sram_driver(FX_MEDIA *media_ptr);

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
#endif /* FX_STM32_SRAM_DRIVER_H */

