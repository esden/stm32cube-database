[#ftl]
[#assign  mmc_instance = "0"]
[#assign  mmc_init = "1"]
[#assign  sector_size = "512"]
[#assign  use_dma = "0"]
[#assign  maintain_cpu_cache = "0"]
[#assign  transfer_notification = "Custom"]
[#assign FX_STANDALONE_ENABLE_value = "0"]
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
	
	[#if name == "MMC_SECTOR_SIZE"]
      [#assign sector_size = value]
    [/#if]
    [#if name == "FX_DRIVER_MMC_INIT"]
      [#assign mmc_init = value]
    [/#if]
	[#if name == "MMC_ENABLE_CACHE_MAINTENANCE"]
      [#if value =="true"]
        [#assign maintain_cpu_cache = "1"]
      [/#if]
    [/#if]
	[#if name == "MMC_INSTANCE"]
      [#assign mmc_instance = value]
    [/#if]
    [#if name == "MMC_GLUE_FUNCTIONS"]
      [#assign glue_functions = value]
	   [#if value =="DMA_API"]
			[#assign use_dma = "1"]
	   [/#if]
    [/#if]
	[#if name == "MMC_TRANSFER_NOTIFICATION"]
      [#assign transfer_notification = value]
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
#ifndef FX_STM32_MMC_DRIVER_H
#define FX_STM32_MMC_DRIVER_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "fx_api.h"

#include "${FamilyName?lower_case}xx_hal.h"
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

[#if transfer_notification=="ThreadX_Semaphore"]
extern TX_SEMAPHORE mmc_tx_semaphore;
extern TX_SEMAPHORE mmc_rx_semaphore;
[/#if]
[#if transfer_notification=="Global_state_variables"]
extern __IO UINT mmc_rx_cplt;
extern __IO UINT mmc_tx_cplt;
[/#if]

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */
/* Default timeout used to wait for fx operations */
[#if (transfer_notification=="ThreadX_Semaphore") || ((transfer_notification=="Custom")&& (FX_STANDALONE_ENABLE_value == "0"))]
#define FX_STM32_MMC_DEFAULT_TIMEOUT                           (10 * TX_TIMER_TICKS_PER_SECOND)
[/#if]
[#if (transfer_notification=="Global_state_variables")  || ((transfer_notification=="Custom")&& (FX_STANDALONE_ENABLE_value == "1"))]
#define FX_STM32_MMC_DEFAULT_TIMEOUT                           (10 * 1000)
[/#if]

/* let the filex low-level driver initialize the MMC driver */
#define FX_STM32_MMC_INIT                                       ${mmc_init}

/* Enable the cache maintenance, needed when using MMC DMA
 * and accessing buffers in cacheable area
 * this is valid only for CM7 based products or those
 * with dedicated cache IP.
 * For STM32U5 this flag should be always set to 0 unless external
 * memories are being used.
 */
#define FX_STM32_MMC_CACHE_MAINTENANCE                    	    ${maintain_cpu_cache}

/* Use the MMC DMA API */
#define FX_STM32_MMC_DMA_API                              	    1

/* MMC instance to be used by FileX */
#define FX_STM32_MMC_INSTANCE                                   ${mmc_instance}

/* Default sector size, used by the driver */
#define FX_STM32_MMC_DEFAULT_SECTOR_SIZE                        512

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Define the macro to get the current time in ticks */
/* USER CODE BEGIN FX_STM32_MMC_CURRENT_TIME_TX */
[#if (transfer_notification=="ThreadX_Semaphore") || ((transfer_notification=="Custom")&& (FX_STANDALONE_ENABLE_value == "0"))]
#define FX_STM32_MMC_CURRENT_TIME()                            tx_time_get()
[/#if]
[#if (transfer_notification=="Global_state_variables")  || ((transfer_notification=="Custom")&& (FX_STANDALONE_ENABLE_value == "1"))]
#define FX_STM32_MMC_CURRENT_TIME()                            HAL_GetTick()
[/#if]

/* USER CODE END FX_STM32_MMC_CURRENT_TIME_TX */

/* Macro called before initializing the MMC driver
 * e.g. create a semaphore used for transfer notification */
[#if transfer_notification=="ThreadX_Semaphore"]
/* USER CODE BEGIN FX_STM32_MMC_PRE_INIT_TX */

#define FX_STM32_MMC_PRE_INIT(_media_ptr)                do { \
                                                          if ((tx_semaphore_create(&mmc_rx_semaphore, "mmc rx transfer semaphore", 0) != TX_SUCCESS) || \
                                                              (tx_semaphore_create(&mmc_tx_semaphore, "mmc tx transfer semaphore", 0) != TX_SUCCESS))  \
                                                          { \
                                                            _media_ptr->fx_media_driver_status = FX_IO_ERROR; \
                                                          } \
                                                        } while(0)

/* USER CODE END FX_STM32_MMC_PRE_INIT_TX */
[/#if]

[#if (transfer_notification=="Custom") || (transfer_notification=="Global_state_variables")]
/* USER CODE BEGIN FX_STM32_MMC_PRE_INIT */

 #define FX_STM32_MMC_PRE_INIT(_media_ptr)      
 
 /* USER CODE END FX_STM32_MMC_PRE_INIT*/
[/#if]

/* Macro called after initializing the MMC driver */
/* USER CODE BEGIN FX_STM32_MMC_POST_INIT */

#define FX_STM32_MMC_POST_INIT(_media_ptr)

/* USER CODE END FX_STM32_MMC_POST_INIT */

/* Macro called after the MMC deinit */

[#if transfer_notification=="ThreadX_Semaphore"]
/* USER CODE BEGIN FX_STM32_MMC_POST_DEINIT_TX */

#define FX_STM32_MMC_POST_DEINIT(_media_ptr)             do { \
                                                          tx_semaphore_delete(&mmc_rx_semaphore); \
                                                          tx_semaphore_delete(&mmc_tx_semaphore); \
                                                        } while(0)

/* USER CODE END FX_STM32_MMC_POST_DEINIT_TX */
[/#if]
[#if (transfer_notification=="Custom") || (transfer_notification=="Global_state_variables")]
/* Macro called after the MMC deinit */
/* USER CODE BEGIN FX_STM32_MMC_POST_DEINIT */

 #define FX_STM32_MMC_POST_DEINIT(_media_ptr) 
 
/* USER CODE END FX_STM32_MMC_POST_DEINIT */ 
[/#if]

/* Macro called after the abort request */
/* USER CODE BEGIN FX_STM32_MMC_POST_ABORT */

#define FX_STM32_MMC_POST_ABORT(_media_ptr)

/* USER CODE END FX_STM32_MMC_POST_ABORT */

/* Macro called before performing read operation */
[#if transfer_notification=="ThreadX_Semaphore"]
/* USER CODE BEGIN FX_STM32_MMC_PRE_READ_TRANSFER_DMA */
[/#if]
[#if (transfer_notification=="Custom") || (transfer_notification=="Global_state_variables")]
/* USER CODE BEGIN FX_STM32_MMC_PRE_READ_TRANSFER */
[/#if]

#define FX_STM32_MMC_PRE_READ_TRANSFER(_media_ptr)
[#if transfer_notification=="ThreadX_Semaphore"]
/* USER CODE END FX_STM32_MMC_PRE_READ_TRANSFER_DMA */
[/#if]
[#if (transfer_notification=="Custom") || (transfer_notification=="Global_state_variables")]
/* USER CODE END FX_STM32_MMC_PRE_READ_TRANSFER */
[/#if]

[#if transfer_notification=="ThreadX_Semaphore"]
/* Macro called after performing read operation */
/* USER CODE BEGIN FX_STM32_MMC_POST_READ_TRANSFER_TX */

#define FX_STM32_MMC_POST_READ_TRANSFER(_media_ptr)

/* USER CODE END FX_STM32_MMC_POST_READ_TRANSFER_TX */

/* Macro for read error handling */
/* USER CODE BEGIN FX_STM32_MMC_READ_TRANSFER_ERROR_TX */

#define FX_STM32_MMC_READ_TRANSFER_ERROR(_status_)

/* USER CODE END FX_STM32_MMC_READ_TRANSFER_ERROR_TX */


/* Define how to notify about Read completion operation */
/* USER CODE BEGIN FX_STM32_MMC_READ_CPLT_NOTIFY_TX */

#define FX_STM32_MMC_READ_CPLT_NOTIFY()                  do { \
                                                          if(tx_semaphore_get(&mmc_rx_semaphore, FX_STM32_MMC_DEFAULT_TIMEOUT) != TX_SUCCESS) \
                                                            { \
                                                              return FX_IO_ERROR; \
                                                            } \
                                                        } while(0)

/* USER CODE END FX_STM32_MMC_READ_CPLT_NOTIFY_TX */

/* Define how to notify about write completion operation */
/* USER CODE BEGIN FX_STM32_MMC_WRITE_CPLT_NOTIFY_TX */

#define FX_STM32_MMC_WRITE_CPLT_NOTIFY()                 do { \
                                                          if(tx_semaphore_get(&mmc_tx_semaphore, FX_STM32_MMC_DEFAULT_TIMEOUT) != TX_SUCCESS) \
                                                            { \
                                                              return FX_IO_ERROR; \
                                                            } \
                                                        } while(0)

/* USER CODE END FX_STM32_MMC_WRITE_CPLT_NOTIFY_TX */

/* Macro called before performing write operation */
/* USER CODE BEGIN FX_STM32_MMC_PRE_WRITE_TRANSFER_TX */

#define FX_STM32_MMC_PRE_WRITE_TRANSFER(_media_ptr)

/* USER CODE END FX_STM32_MMC_PRE_WRITE_TRANSFER_TX */

/* Macro called after performing write operation */
/* USER CODE BEGIN FX_STM32_MMC_POST_WRITE_TRANSFER */

#define FX_STM32_MMC_POST_WRITE_TRANSFER(_media_ptr)

/* USER CODE END FX_STM32_MMC_POST_WRITE_TRANSFER */

/* Macro for write error handling */
/* USER CODE BEGIN FX_STM32_MMC_WRITE_TRANSFER_ERROR */

#define FX_STM32_MMC_WRITE_TRANSFER_ERROR(_status_)

/* USER CODE END FX_STM32_MMC_WRITE_TRANFSER_ERROR */
[/#if]

[#if transfer_notification=="Custom"]
/* Macro called after performing read operation */
/* USER CODE BEGIN FX_STM32_MMC_POST_READ_TRANSFER */

#define FX_STM32_MMC_POST_READ_TRANSFER(_media_ptr)

/* USER CODE END FX_STM32_MMC_POST_READ_TRANSFER */

/* Macro for read error handling */
/* USER CODE BEGIN FX_STM32_MMC_READ_TRANSFER_ERROR */

#define FX_STM32_MMC_READ_TRANSFER_ERROR(_status_)

/* USER CODE END FX_STM32_MMC_READ_TRANSFER_ERROR */

/* Define how to notify about Read completion operation */
/* USER CODE BEGIN FX_STM32_MMC_READ_CPLT_NOTIFY */

#define FX_STM32_MMC_READ_CPLT_NOTIFY()

/* USER CODE END FX_STM32_MMC_READ_CPLT_NOTIFY */

/* Define how to notify about write completion operation */
/* USER CODE BEGIN FX_STM32_MMC_WRITE_CPLT_NOTIFY */

#define FX_STM32_MMC_WRITE_CPLT_NOTIFY() 

/* USER CODE END FX_STM32_MMC_WRITE_CPLT_NOTIFY */

/* Macro called before performing write operation */
/* USER CODE BEGIN FX_STM32_MMC_PRE_WRITE_TRANSFER */

#define FX_STM32_MMC_PRE_WRITE_TRANSFER(_media_ptr)

/* USER CODE END FX_STM32_MMC_PRE_WRITE_TRANSFER */

/* Macro called after performing write operation */
/* USER CODE BEGIN FX_STM32_MMC_POST_WRITE_TRANSFER */

#define FX_STM32_MMC_POST_WRITE_TRANSFER(_media_ptr)

/* USER CODE END FX_STM32_MMC_POST_WRITE_TRANSFER */

/* Macro for write error handling */
/* USER CODE BEGIN FX_STM32_MMC_WRITE_TRANSFER_ERROR */

#define FX_STM32_MMC_WRITE_TRANSFER_ERROR(_status_)

/* USER CODE END FX_STM32_MMC_WRITE_TRANFSER_ERROR */
[/#if]


[#if transfer_notification=="Global_state_variables"]
/* Macro called after performing read operation */
/* USER CODE BEGIN FX_STM32_MMC_POST_READ_TRANSFER */

#define FX_STM32_MMC_POST_READ_TRANSFER(_media_ptr)

/* USER CODE END FX_STM32_MMC_POST_READ_TRANSFER */

/* Macro for read error handling */
/* USER CODE BEGIN FX_STM32_MMC_READ_TRANSFER_ERROR */

#define FX_STM32_MMC_READ_TRANSFER_ERROR(_status_)

/* USER CODE END FX_STM32_MMC_READ_TRANSFER_ERROR */

/* Define how to notify about Read completion operation */
/* USER CODE BEGIN FX_STM32_MMC_READ_CPLT_NOTIFY */

#define FX_STM32_MMC_READ_CPLT_NOTIFY()     do { \
                                              UINT start = HAL_GetTick(); \
                                              while (HAL_GetTick() - start < FX_STM32_MMC_DEFAULT_TIMEOUT) \
                                              {\
                                                if (mmc_rx_cplt == 1) \
                                                  break;\
                                              }\
                                              if (mmc_rx_cplt == 0) \
                                                return FX_IO_ERROR; \
                                           } while(0)

/* USER CODE END FX_STM32_MMC_READ_CPLT_NOTIFY */

/* Define how to notify about write completion operation */
/* USER CODE BEGIN FX_STM32_MMC_WRITE_CPLT_NOTIFY */

#define FX_STM32_MMC_WRITE_CPLT_NOTIFY()      do { \
                                              UINT start = HAL_GetTick(); \
                                              while (HAL_GetTick() - start < FX_STM32_MMC_DEFAULT_TIMEOUT) \
                                              {\
                                                if (mmc_tx_cplt == 1) \
                                                  break;\
                                              }\
                                              if (mmc_tx_cplt == 0) \
                                                return FX_IO_ERROR;\
                                           } while(0)

/* USER CODE END FX_STM32_MMC_WRITE_CPLT_NOTIFY */

/* Macro called before performing write operation */
/* USER CODE BEGIN FX_STM32_MMC_PRE_WRITE_TRANSFER */

#define FX_STM32_MMC_PRE_WRITE_TRANSFER(_media_ptr)

/* USER CODE END FX_STM32_MMC_PRE_WRITE_TRANSFER */

/* Macro called after performing write operation */
/* USER CODE BEGIN FX_STM32_MMC_POST_WRITE_TRANSFER */

#define FX_STM32_MMC_POST_WRITE_TRANSFER					FX_STM32_MMC_POST_READ_TRANSFER

/* USER CODE END FX_STM32_MMC_POST_WRITE_TRANSFER */

/* Macro for write error handling */
/* USER CODE BEGIN FX_STM32_MMC_WRITE_TRANSFER_ERROR */

#define FX_STM32_MMC_WRITE_TRANSFER_ERROR				FX_STM32_MMC_READ_TRANSFER_ERROR

/* USER CODE END FX_STM32_MMC_WRITE_TRANFSER_ERROR */
[/#if]


/* Exported functions prototypes ---------------------------------------------*/

INT fx_stm32_mmc_init(UINT instance);
INT fx_stm32_mmc_deinit(UINT instance);

INT fx_stm32_mmc_get_status(UINT instance);

INT fx_stm32_mmc_read_blocks(UINT instance, UINT *buffer, UINT start_block, UINT total_blocks);
INT fx_stm32_mmc_write_blocks(UINT instance, UINT *buffer, UINT start_block, UINT total_blocks);

VOID fx_stm32_mmc_driver(FX_MEDIA *media_ptr);

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

#endif /* FX_STM32_MMC_DRIVER_H */