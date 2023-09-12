[#ftl]

[#assign  sd_instance = "0"]
[#assign  maintain_cpu_cache = "0"]
[#assign  use_dma = "0"]

[#assign  sector_size = "512"]
[#assign  sd_init = "1"]
[#assign FX_STANDALONE_ENABLE_value = "3"]
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
    [#if name == "GLUE_FUNCTIONS"]
      [#assign glue_functions = value]
    [/#if]
	[#if name == "SDMMC_INSTANCE"]
      [#assign sd_instance = value]
    [/#if]
	[#if name == "USE_SD_DMA"]
      [#if value.contains("1")]
        [#assign use_dma = "1"]
      [/#if]
    [/#if]

    [#if name == "ENABLE_CACHE_MAINTENANCE"]
      [#if value.contains("true")]
        [#assign maintain_cpu_cache = "1"]
      [/#if]
    [/#if]
    [#if name == "SD_SECTOR_SIZE"]
      [#assign sector_size = value]
    [/#if]
    [#if name == "FX_DRIVER_SDMMC_INIT"]
      [#assign sd_init = value]
    [/#if]
	[#if name == "FX_STANDALONE_ENABLE"]
		[#assign FX_STANDALONE_ENABLE_value = value]
	[/#if]
    [/#list]
[/#if]
[/#list]
[/#compress]

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
#ifndef FX_STM32_SD_DRIVER_H
#define FX_STM32_SD_DRIVER_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "fx_api.h"

#include "${FamilyName?lower_case}xx_hal.h"
/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/

/* Default timeout used to wait for fx operations */
[#if FX_STANDALONE_ENABLE_value == "0"]
#define FX_STM32_SD_DEFAULT_TIMEOUT                           (10 * TX_TIMER_TICKS_PER_SECOND)
[/#if]
[#if FX_STANDALONE_ENABLE_value == "1"]
#define FX_STM32_SD_DEFAULT_TIMEOUT                           (10 * 1000)
[/#if]

/* Default SD sector size typically 512 for uSD */
#define FX_STM32_SD_DEFAULT_SECTOR_SIZE                    	512

/* let the filex low-level driver initialize the SD driver */
#define FX_STM32_SD_INIT                                    ${sd_init}


/* Use the SD DMA API, when enabled cache maintenance
 * may be required
 */
#define FX_STM32_SD_DMA_API									${use_dma}

/* Enable the cache maintenance, needed when using SD DMA
 * and accessing buffers in cacheable area
 * this is valid only for CM7 based products or those
 * with dedicated cache IP.
 * For STM32U5 this flag should be always set to 0 unless external
 * memories are being used.
 */
#define FX_STM32_SD_CACHE_MAINTENANCE						${maintain_cpu_cache}

/* SD instance default to 0 */
#define FX_STM32_SD_INSTANCE                                ${sd_instance}

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */


/* Get the current time in ticks */

/* USER CODE BEGIN FX_STM32_SD_CURRENT_TIME */

[#if FX_STANDALONE_ENABLE_value == "0"]
#define FX_STM32_SD_CURRENT_TIME()                          tx_time_get()
[/#if]
[#if FX_STANDALONE_ENABLE_value == "1"]
#define FX_STM32_SD_CURRENT_TIME()                          HAL_GetTick()
[/#if]

/* USER CODE END FX_STM32_SD_CURRENT_TIME */


/* Macro called before initializing the SD driver
 * for example to create a semaphore used for
 * transfer notification
 */

/* USER CODE BEGIN FX_STM32_SD_PRE_INIT */

#define  FX_STM32_SD_PRE_INIT(_media_ptr)

/* USER CODE END FX_STM32_SD_PRE_INIT */


/* Macro called after initializing the SD driver */

/* USER CODE BEGIN FX_STM32_SD_POST_INIT */

#define FX_STM32_SD_POST_INIT(_media_ptr)

/* USER CODE END FX_STM32_SD_POST_INIT */


/* USER CODE BEGIN FX_STM32_SD_POST_DEINIT */

/* Macro called after the SD deinit */
#define FX_STM32_SD_POST_DEINIT(_media_ptr)

/* USER CODE END FX_STM32_SD_POST_DEINIT */

/* USER CODE BEGIN FX_STM32_SD_POST_ABORT */

/* Macro called after the abort request */
#define FX_STM32_SD_POST_ABORT(_media_ptr)

/* USER CODE END FX_STM32_SD_POST_ABORT */


/* USER CODE BEGIN FX_STM32_SD_PRE_READ_TRANSFER */

/* Macro called before performing read operation */
#define FX_STM32_SD_PRE_READ_TRANSFER(_media_ptr)

/* USER CODE END FX_STM32_SD_PRE_READ_TRANSFER */

/* USER CODE BEGIN FX_STM32_SD_POST_READ_TRANSFER */

/* Macro called after performing read operation */
#define FX_STM32_SD_POST_READ_TRANSFER(_media_ptr)

/* USER CODE END FX_STM32_SD_POST_READ_TRANSFER */

/* USER CODE BEGIN FX_STM32_SD_READ_TRANSFER_ERROR */

/* Macro for read error handling */
#define FX_STM32_SD_READ_TRANSFER_ERROR(_status_)

/* USER CODE END FX_STM32_SD_READ_TRANSFER_ERROR */

/* USER CODE BEGIN FX_STM32_SD_READ_CPLT_NOTIFY */

/* Define how to notify about Read completion operation */
#define FX_STM32_SD_READ_CPLT_NOTIFY()

/* USER CODE END FX_STM32_SD_READ_CPLT_NOTIFY */


/* USER CODE BEGIN FX_STM32_SD_WRITE_CPLT_NOTIFY */

/* Define how to notify about write completion operation */
#define FX_STM32_SD_WRITE_CPLT_NOTIFY()

/* USER CODE END FX_STM32_SD_WRITE_CPLT_NOTIFY */

/* USER CODE BEGIN FX_STM32_SD_PRE_WRITE_TRANSFER */

/* Macro called before performing write operation */
#define FX_STM32_SD_PRE_WRITE_TRANSFER(__media_ptr__)

/* USER CODE END FX_STM32_SD_PRE_WRITE_TRANSFER */

/* USER CODE BEGIN FX_STM32_SD_POST_WRITE_TRANSFER */

/* Macro called after performing write operation */
#define FX_STM32_SD_POST_WRITE_TRANSFER(__media_ptr__)

/* USER CODE END FX_STM32_SD_POST_WRITE_TRANSFER */

/* USER CODE BEGIN FX_STM32_SD_WRITE_TRANSFER_ERROR */

/* Macro for write error handling */
#define FX_STM32_SD_WRITE_TRANSFER_ERROR(__status__)

/* USER CODE END FX_STM32_SD_WRITE_TRANSFER_ERROR */



/* Exported functions prototypes ---------------------------------------------*/

INT fx_stm32_sd_init(UINT Instance);
INT fx_stm32_sd_deinit(UINT Instance);

INT fx_stm32_sd_get_status(UINT Instance);

INT fx_stm32_sd_read_blocks(UINT Instance, UINT *Buffer, UINT StartSector, UINT NbrOfBlocks);
INT fx_stm32_sd_write_blocks(UINT Instance, UINT *Buffer, UINT StartSector, UINT NbrOfBlocks);


VOID  fx_stm32_sd_driver(FX_MEDIA *media_ptr);

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

#endif /* FX_STM32_SD_DRIVER_H */

