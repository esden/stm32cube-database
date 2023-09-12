[#ftl]
[#compress]

[#assign ospi_init_driver = "1"]
[#assign ospi_erase_flash = "0"]
[#assign glue_api = "DMA_API"]
[#assign TRANSFER_NOTIFICATION = "ThreadX_Semaphore"]
[#assign ospi_instance = 0]
[#assign ospi_comp = "custom"]
[#assign use_dma = 0]

[#if BspComponentDatas??]
[#list BspComponentDatas as SWIP]
[#if SWIP.ipName?contains("MX25LM51245G")]
	[#assign ospi_comp = "MX25LM51245G"]
[/#if]
[/#list]
[/#if]

[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]

    [#if name == "LX_DRIVER_CALLS_OSPI_INIT"]
      [#assign ospi_init_driver = value]
    [/#if]

    [#if name == "LX_DRIVER_ERASES_OSPI_AFTER_INIT"]
      [#assign ospi_erase_flash = value]
    [/#if]

    [#if name == "TRANSFER_NOTIFICATION"]
      [#assign TRANSFER_NOTIFICATION = value]
    [/#if]

    [#if name == "LX_OSPI_INSTANCE"]
      [#assign ospi_instance = value]
    [/#if]

    [#if name == "GLUE_FUNCTIONS"]
      [#assign glue_api = value]
    [/#if]
	
	[#if name == "LX_USE_OSPI_OCTOSPI"]
      [#assign LX_USE_OSPI_OCTOSPI_value = value]
    [/#if]
	
  [/#list]
[/#if]
[/#list]

[#if glue_api == "DMA_API"]
  [#assign use_dma = 1]
[/#if]
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

#ifndef LX_STM32_OSPI_DRIVER_H
#define LX_STM32_OSPI_DRIVER_H

#ifdef __cplusplus
extern "C" {
#endif



/* Includes ------------------------------------------------------------------*/
#include "lx_api.h"
#include "${FamilyName?lower_case}xx_hal.h"
[#if ospi_comp != "custom"]
#include "${ospi_comp?lower_case}.h"
[/#if]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

[#if glue_api == "DMA_API"]
  [#if TRANSFER_NOTIFICATION == "ThreadX_Semaphore"]
/* The following semaphore is being to notify about RX/TX completion. It needs to be released in the transfer callbacks */
extern TX_SEMAPHORE ospi_rx_semaphore;
extern TX_SEMAPHORE ospi_tx_semaphore;
  [/#if]
[/#if]

/* Exported constants --------------------------------------------------------*/

/* the OctoSPI instance, default value set to 0 */
#define LX_STM32_OSPI_INSTANCE                           ${ospi_instance}

#define LX_STM32_OSPI_DEFAULT_TIMEOUT                    10 * TX_TIMER_TICKS_PER_SECOND

#define LX_STM32_DEFAULT_SECTOR_SIZE                     LX_STM32_OSPI_SECTOR_SIZE
[#if glue_api == "DMA_API"]
#define LX_STM32_OSPI_DMA_API                            ${use_dma}
[/#if]

/* when set to 1 LevelX is initializing the OctoSPI memory,
 * otherwise it is the up to the application to perform it.
 */
#define LX_STM32_OSPI_INIT                               ${ospi_init_driver}

/* allow the driver to fully erase the OctoSPI chip. This should be used carefully.
 * the call is blocking and takes a while. by default it is set to 0.
 */
#define LX_STM32_OSPI_ERASE                              ${ospi_erase_flash}

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

#define LX_STM32_OSPI_CURRENT_TIME                              tx_time_get

/* Macro called after initializing the OSPI driver
 * e.g. create a semaphore used for transfer notification */
[#if glue_api == "DMA_API" && TRANSFER_NOTIFICATION == "ThreadX_Semaphore" ]
 /* USER CODE BEGIN LX_STM32_OSPI_POST_INIT */

#define LX_STM32_OSPI_POST_INIT()                        do { \
                                                         if (tx_semaphore_create(&ospi_rx_semaphore, "ospi rx transfer semaphore", 0) != TX_SUCCESS) \
                                                         { \
                                                           return LX_ERROR; \
                                                         } \
                                                         if (tx_semaphore_create(&ospi_tx_semaphore, "ospi tx transfer semaphore", 0) != TX_SUCCESS) \
                                                         { \
                                                           return LX_ERROR; \
                                                         } \
                                                        } while(0)
/* USER CODE END LX_STM32_OSPI_POST_INIT */
[#else]
/* USER CODE BEGIN LX_STM32_OSPI_POST_INIT */

#define  LX_STM32_OSPI_POST_INIT()

/* USER CODE END LX_STM32_OSPI_POST_INIT */
[/#if]

/* Macro called before performing read operation */

[#if glue_api == "DMA_API" && TRANSFER_NOTIFICATION == "ThreadX_Semaphore" ]
/* USER CODE BEGIN LX_STM32_OSPI_PRE_READ_TRANSFER */

#define LX_STM32_OSPI_PRE_READ_TRANSFER(__status__)

/* USER CODE END LX_STM32_OSPI_PRE_READ_TRANSFER */
[#else]
/* USER CODE BEGIN LX_STM32_OSPI_PRE_READ_TRANSFER */

#define LX_STM32_OSPI_PRE_READ_TRANSFER(__status__)

/* USER CODE END LX_STM32_OSPI_PRE_READ_TRANSFER */
[/#if]

/* Define how to notify about Read completion operation */

[#if glue_api == "DMA_API" && TRANSFER_NOTIFICATION == "ThreadX_Semaphore" ]
/* USER CODE BEGIN LX_STM32_OSPI_READ_CPLT_NOTIFY */

#define LX_STM32_OSPI_READ_CPLT_NOTIFY(__status__)      do { \
                                                          if(tx_semaphore_get(&ospi_rx_semaphore, HAL_OSPI_TIMEOUT_DEFAULT_VALUE) != TX_SUCCESS) \
                                                          { \
                                                            __status__ = LX_ERROR; \
                                                          } \
                                                        } while(0)

/* USER CODE END LX_STM32_OSPI_READ_CPLT_NOTIFY */
[#else]
/* USER CODE BEGIN LX_STM32_OSPI_READ_CPLT_NOTIFY */

#define LX_STM32_OSPI_READ_CPLT_NOTIFY(__status__)

/* USER CODE END LX_STM32_OSPI_READ_CPLT_NOTIFY */
[/#if]

/* Macro called after performing read operation */

/* USER CODE BEGIN LX_STM32_OSPI_POST_READ_TRANSFER */

#define LX_STM32_OSPI_POST_READ_TRANSFER(__status__)

/* USER CODE END LX_STM32_OSPI_POST_READ_TRANSFER */

/* Macro for read error handling */
/* USER CODE BEGIN LX_STM32_OSPI_READ_TRANSFER_ERROR */

#define LX_STM32_OSPI_READ_TRANSFER_ERROR(__status__)

/* USER CODE END LX_STM32_OSPI_READ_TRANSFER_ERROR */


/* Macro called before performing write operation */

/* USER CODE BEGIN LX_STM32_OSPI_PRE_WRITE_TRANSFER */

#define LX_STM32_OSPI_PRE_WRITE_TRANSFER(__status__)

/* USER CODE END LX_STM32_OSPI_PRE_WRITE_TRANSFER */

/* Define how to notify about write completion operation */

[#if glue_api == "DMA_API" && TRANSFER_NOTIFICATION == "ThreadX_Semaphore" ]
/* USER CODE BEGIN LX_STM32_OSPI_WRITE_CPLT_NOTIFY */

#define LX_STM32_OSPI_WRITE_CPLT_NOTIFY(__status__)     do { \
                                                          if(tx_semaphore_get(&ospi_tx_semaphore, HAL_OSPI_TIMEOUT_DEFAULT_VALUE) != TX_SUCCESS) \
                                                          { \
                                                            __status__ = LX_ERROR; \
                                                          } \
                                                        } while(0)

/* USER CODE END LX_STM32_OSPI_WRITE_CPLT_NOTIFY */
[#else]
/* USER CODE BEGIN LX_STM32_OSPI_WRITE_CPLT_NOTIFY */

#define LX_STM32_OSPI_WRITE_CPLT_NOTIFY(__status__)

/* USER CODE END LX_STM32_OSPI_WRITE_CPLT_NOTIFY */
[/#if]

/* Macro called after performing write operation */

/* USER CODE BEGIN LX_STM32_OSPI_POST_WRITE_TRANSFER */

#define LX_STM32_OSPI_POST_WRITE_TRANSFER(__status__)

/* USER CODE END LX_STM32_OSPI_POST_WRITE_TRANSFER */

/* Macro for write error handling */

/* USER CODE BEGIN LX_STM32_OSPI_WRITE_TRANSFER_ERROR */

#define LX_STM32_OSPI_WRITE_TRANSFER_ERROR(__status__)

/* USER CODE END LX_STM32_OSPI_WRITE_TRANSFER_ERROR */

/* Exported functions prototypes ---------------------------------------------*/
INT lx_stm32_ospi_lowlevel_init(UINT instance);
INT lx_stm32_ospi_lowlevel_deinit(UINT instance);

INT lx_stm32_ospi_get_status(UINT instance);
INT lx_stm32_ospi_get_info(UINT instance, ULONG *block_size, ULONG *total_blocks);

INT lx_stm32_ospi_read(UINT instance, ULONG *address, ULONG *buffer, ULONG words);
INT lx_stm32_ospi_write(UINT instance, ULONG *address, ULONG *buffer, ULONG words);

INT lx_stm32_ospi_erase(UINT instance, ULONG block, ULONG erase_count, UINT full_chip_erase);
INT lx_stm32_ospi_is_block_erased(UINT instance, ULONG block);

UINT lx_ospi_driver_system_error(UINT error_code);

UINT lx_stm32_ospi_initialize(LX_NOR_FLASH *nor_flash);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

[#if glue_api == "DMA_API"]
[#if ospi_comp == "MX25LM51245G"]
#define LX_STM32_OSPI_DUMMY_CYCLES_READ_OCTAL     20
#define LX_STM32_OSPI_DUMMY_CYCLES_CR_CFG         ${ospi_comp}_CR2_DC_6_CYCLES

#define LX_STM32_OSPI_SECTOR_SIZE                 ${ospi_comp}_SECTOR_64K
#define LX_STM32_OSPI_FLASH_SIZE                  ${ospi_comp}_FLASH_SIZE
#define LX_STM32_OSPI_PAGE_SIZE                   ${ospi_comp}_PAGE_SIZE

#define LX_STM32_OSPI_BULK_ERASE_MAX_TIME         ${ospi_comp}_BULK_ERASE_MAX_TIME
#define LX_STM32_OSPI_SECTOR_ERASE_MAX_TIME       ${ospi_comp}_SECTOR_ERASE_MAX_TIME
#define LX_STM32_OSPI_WRITE_REG_MAX_TIME          ${ospi_comp}_WRITE_REG_MAX_TIME

#define LX_STM32_OSPI_OCTAL_BULK_ERASE_CMD        ${ospi_comp}_OCTA_BULK_ERASE_CMD
#define LX_STM32_OSPI_OCTAL_SECTOR_ERASE_CMD      ${ospi_comp}_OCTA_SECTOR_ERASE_64K_CMD

#define LX_STM32_OSPI_WRITE_ENABLE_CMD            ${ospi_comp}_WRITE_ENABLE_CMD
#define LX_STM32_OSPI_WRITE_CFG_REG2_CMD          ${ospi_comp}_WRITE_CFG_REG2_CMD
#define LX_STM32_OSPI_OCTAL_WRITE_ENABLE_CMD      ${ospi_comp}_OCTA_WRITE_ENABLE_CMD
#define LX_STM32_OSPI_OCTAL_WRITE_CFG_REG2_CMD    ${ospi_comp}_OCTA_WRITE_CFG_REG2_CMD

#define LX_STM32_OSPI_READ_STATUS_REG_CMD         ${ospi_comp}_READ_STATUS_REG_CMD
#define LX_STM32_OSPI_READ_CFG_REG2_CMD           ${ospi_comp}_WRITE_CFG_REG2_CMD

#define LX_STM32_OSPI_OCTAL_READ_DTR_CMD          ${ospi_comp}_OCTA_READ_DTR_CMD
#define LX_STM32_OSPI_OCTAL_READ_CFG_REG2_CMD     ${ospi_comp}_OCTA_READ_CFG_REG2_CMD
#define LX_STM32_OSPI_OCTAL_READ_STATUS_REG_CMD   ${ospi_comp}_OCTA_READ_STATUS_REG_CMD


#define LX_STM32_OSPI_RESET_ENABLE_CMD            ${ospi_comp}_RESET_ENABLE_CMD
#define LX_STM32_OSPI_RESET_MEMORY_CMD            ${ospi_comp}_RESET_MEMORY_CMD

#define LX_STM32_OSPI_OCTAL_PAGE_PROG_CMD         ${ospi_comp}_OCTA_PAGE_PROG_CMD

#define LX_STM32_OSPI_CR2_REG3_ADDR               ${ospi_comp}_CR2_REG3_ADDR
#define LX_STM32_OSPI_CR2_REG1_ADDR               ${ospi_comp}_CR2_REG1_ADDR
#define LX_STM32_OSPI_SR_WEL                      ${ospi_comp}_SR_WEL
#define LX_STM32_OSPI_SR_WIP                      ${ospi_comp}_SR_WIP
#define LX_STM32_OSPI_CR2_SOPI                    ${ospi_comp}_CR2_SOPI
#define LX_STM32_OSPI_CR2_DOPI                    ${ospi_comp}_CR2_DOPI
[/#if]
[#if ospi_comp == "custom"]
/* USER CODE BEGIN CUSTOM_OSPI */
/* Define the command codes and flags below related to the NOR Flash memory used */
#error "[This error is thrown on purpose] : define the command codes and flags below related to the NOR Flash memory used"

#define LX_STM32_OSPI_DUMMY_CYCLES_READ_OCTAL     0xFF
#define LX_STM32_OSPI_DUMMY_CYCLES_CR_CFG         0xFF

#define LX_STM32_OSPI_SECTOR_SIZE                 0xFF
#define LX_STM32_OSPI_FLASH_SIZE                  0xFF
#define LX_STM32_OSPI_PAGE_SIZE                   0xFF

#define LX_STM32_OSPI_BULK_ERASE_MAX_TIME         0xFF
#define LX_STM32_OSPI_SECTOR_ERASE_MAX_TIME       0xFF
#define LX_STM32_OSPI_WRITE_REG_MAX_TIME          0xFF

#define LX_STM32_OSPI_OCTAL_BULK_ERASE_CMD        0xFF
#define LX_STM32_OSPI_OCTAL_SECTOR_ERASE_CMD      0xFF

#define LX_STM32_OSPI_WRITE_ENABLE_CMD            0xFF
#define LX_STM32_OSPI_WRITE_CFG_REG2_CMD          0xFF
#define LX_STM32_OSPI_OCTAL_WRITE_ENABLE_CMD      0xFF
#define LX_STM32_OSPI_OCTAL_WRITE_CFG_REG2_CMD    0xFF

#define LX_STM32_OSPI_READ_STATUS_REG_CMD         0xFF
#define LX_STM32_OSPI_READ_CFG_REG2_CMD           0xFF

#define LX_STM32_OSPI_OCTAL_READ_DTR_CMD          0xFF
#define LX_STM32_OSPI_OCTAL_READ_CFG_REG2_CMD     0xFF
#define LX_STM32_OSPI_OCTAL_READ_STATUS_REG_CMD   0xFF


#define LX_STM32_OSPI_RESET_ENABLE_CMD            0xFF
#define LX_STM32_OSPI_RESET_MEMORY_CMD            0xFF

#define LX_STM32_OSPI_OCTAL_PAGE_PROG_CMD         0xFF

#define LX_STM32_OSPI_CR2_REG3_ADDR               0xFF
#define LX_STM32_OSPI_CR2_REG1_ADDR               0xFF
#define LX_STM32_OSPI_SR_WEL                      0xFF
#define LX_STM32_OSPI_SR_WIP                      0xFF
#define LX_STM32_OSPI_CR2_SOPI                    0xFF
#define LX_STM32_OSPI_CR2_DOPI                    0xFF

/* USER CODE END CUSTOM_OSPI */
[/#if]
[/#if]

[#if glue_api != "DMA_API"]
[#if ospi_comp == "MX25LM51245G"]
#define LX_STM32_OSPI_SECTOR_SIZE                 ${ospi_comp}_SECTOR_64K
[#else]
#error "[This error is thrown on purpose] : define the correct OSPI Sector Size"
#define LX_STM32_OSPI_SECTOR_SIZE                 0xFFFF
[/#if]
[/#if]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif
#endif /* LX_STM32_OSPI_DRIVER_H */
