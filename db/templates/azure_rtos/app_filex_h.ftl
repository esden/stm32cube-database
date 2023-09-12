[#ftl]
[#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = "1" ]
[#assign THREADX_ENABLED_Value = "false" ]
[#assign FILEX_ENABLED_ENABLED_Value = "false" ]
[#assign FX_SRAM_INTERFACE_ENABLED_Value = "false" ]
[#assign FX_SD_INTERFACE_ENABLED_Value = "false" ]
[#assign FX_MMC_INTERFACE_ENABLED_Value = "false" ]
[#assign FX_LX_NOR_INTERFACE_ENABLED_Value = "false" ]
[#assign LX_NOR_QSPI_DRIVER_ENABLED_Value = "false" ]
[#assign LX_NOR_OSPI_DRIVER_ENABLED_Value = "false" ]
[#assign LX_NOR_SIMULATOR_DRIVER_ENABLED_Value = "false" ]

[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as variable]
    [#assign value = variable.value]
    [#assign name = variable.name]

    [#if name == "AZRTOS_APP_MEM_ALLOCATION_METHOD"]
      [#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = value]
    [/#if]

	  [#if name == "GENERATE_FILEX_INIT_CODE"]
      [#assign GENERATE_FILEX_INIT_CODE_value = value]
    [/#if]

	  [#if name == "LINK_SRAM_DRIVER"]
      [#assign LINK_SRAM_DRIVER_value = value]
    [/#if]

    [#if name == "FORMAT_SRAM_MEDIA"]
      [#assign FORMAT_SRAM_MEDIA_value = value]
    [/#if]

  	[#if name == "LINK_SD_DRIVER"]
      [#assign LINK_SD_DRIVER_value = value]
    [/#if]

    [#if name == "FORMAT_SD_MEDIA"]
      [#assign FORMAT_SD_MEDIA_value = value]
    [/#if]

  	[#if name == "LINK_MMC_DRIVER"]
      [#assign LINK_MMC_DRIVER_value = value]
    [/#if]

    [#if name == "FORMAT_MMC_MEDIA"]
      [#assign FORMAT_MMC_MEDIA_value = value]
    [/#if]

  	[#if name == "LINK_NOR_OSPI_DRIVER"]
      [#assign LINK_NOR_OSPI_DRIVER_value = value]
    [/#if]

    [#if name == "FORMAT_NOR_OSPI_MEDIA"]
      [#assign FORMAT_NOR_OSPI_MEDIA_value = value]
    [/#if]

	  [#if name == "LINK_NOR_SIMULATOR_DRIVER"]
      [#assign LINK_NOR_SIMULATOR_DRIVER_value = value]
    [/#if]

    [#if name == "FORMAT_NOR_SIMULATOR_MEDIA"]
      [#assign FORMAT_NOR_SIMULATOR_MEDIA_value = value]
    [/#if]

   [#if name == "LX_NOR_USE_OSPI_DRIVER"]
      [#assign LX_NOR_USE_OSPI_DRIVER_value = value]
    [/#if]

[#if RTEdatas??]
  [#list RTEdatas as define]

    [#if define?contains("THREADX_ENABLED")]
      [#assign THREADX_ENABLED_Value = "true"]
    [/#if]
	  [#if define?contains("FILEX_ENABLED")]
      [#assign FILEX_ENABLED_Value = "true"]
    [/#if]
    [#if define?contains("FX_SRAM_INTERFACE")]
      [#assign FX_SRAM_INTERFACE_ENABLED_Value = "true"]
    [/#if]
    [#if define?contains("FX_SD_INTERFACE")]
      [#assign FX_SD_INTERFACE_ENABLED_Value = "true"]
    [/#if]
    [#if define?contains("FX_MMC_INTERFACE")]
      [#assign FX_MMC_INTERFACE_ENABLED_Value = "true"]
    [/#if]
    [#if define?contains("FX_LX_NOR_INTERFACE")]
      [#assign FX_LX_NOR_INTERFACE_ENABLED_Value = "true"]
    [/#if]
  	[#if define?contains("LX_NOR_QSPI_DRIVER")]
      [#assign LX_NOR_QSPI_DRIVER_ENABLED_Value = "true"]
    [/#if]
  	[#if define?contains("LX_NOR_OSPI_DRIVER")]
      [#assign LX_NOR_OSPI_DRIVER_ENABLED_Value = "true"]
    [/#if]
  	[#if define?contains("LX_NOR_SIMULATOR_DRIVER")]
      [#assign LX_NOR_SIMULATOR_DRIVER_ENABLED_Value = "true"]
    [/#if]

  [/#list]
  [/#if]
   [/#list]
[/#if]
[/#list]
[/#compress]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_filex.h
  * @author  MCD Application Team
  * @brief   FileX applicative header file
  ******************************************************************************
  [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __APP_FILEX_H__
#define __APP_FILEX_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "fx_api.h"
[#if SWIPdatas??]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as variable]
    [#assign value = variable.value]
    [#assign name = variable.name]
[#if name?contains("FX_SRAM_INTERFACE") && value == "1"]
#include "fx_stm32_sram_driver.h"
[/#if]
[#if name?contains("FX_SD_INTERFACE") && value == "1"]
#include "fx_stm32_sd_driver.h"
[/#if]
[#if name?contains("FX_MMC_INTERFACE") && value == "1"]
#include "fx_stm32_mmc_driver.h"
[/#if]
[#if name?contains("FX_LX_NOR_INTERFACE") && value == "1"]
#include "fx_stm32_levelx_nor_driver.h"
[/#if]
[#if name?contains("FX_LX_NAND_INTERFACE") && value == "1"]
#include "fx_stm32_levelx_nand_driver.h"
[/#if]
[#if name?contains("FX_CUSTOM_INTERFACE") && value == "1"]
#include "fx_stm32_custom_driver.h"
[/#if]
[#if name?contains("LX_NOR_USE_SIMULATOR_DRIVER") && value == "true"]
#include "lx_stm32_nor_simulator_driver.h"
[/#if]
[#if name?contains("LX_NOR_USE_CUSTOM_DRIVER") && value == "true"]
#include "lx_stm32_nor_custom_driver.h"
[/#if]
[#if name?contains("LX_NAND_USE_SIMULATOR_DRIVER") && value == "true"]
#include "lx_stm32_nand_simulator_driver.h"
[/#if]
[#if name?contains("LX_NAND_USE_CUSTOM_DRIVER") && value == "true"]
#include "lx_stm32_nand_custom_driver.h"
[/#if]
[#if name?contains("LX_NOR_USE_OSPI_DRIVER") && value == "true"]
#include "lx_stm32_ospi_driver.h"
[/#if]
[#if name == "FX_STANDALONE_ENABLE"]
    [#assign FX_STANDALONE_ENABLE_value = value]
[/#if]
[/#list]
[/#if]
[/#list]
[/#if]
/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
[#if FX_STANDALONE_ENABLE_value == "1"]
UINT MX_FileX_Init(void);
[#else]
UINT MX_FileX_Init(VOID *memory_ptr);
[/#if]


/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
[#if FX_STANDALONE_ENABLE_value !="1"]
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL  != "0"] 
[#if GENERATE_FILEX_INIT_CODE_value??]
[#if GENERATE_FILEX_INIT_CODE_value  == "true"]
/* Main thread Name */
#ifndef FX_APP_THREAD_NAME
  #define FX_APP_THREAD_NAME "FileX app thread"
#endif

/* Main thread time slice */
#ifndef FX_APP_THREAD_TIME_SLICE
  #define FX_APP_THREAD_TIME_SLICE TX_NO_TIME_SLICE
#endif

/* Main thread auto start */
#ifndef FX_APP_THREAD_AUTO_START
  #define FX_APP_THREAD_AUTO_START TX_AUTO_START
#endif

/* Main thread preemption threshold */
#ifndef FX_APP_PREEMPTION_THRESHOLD
  #define FX_APP_PREEMPTION_THRESHOLD FX_APP_THREAD_PRIO
#endif
[/#if]
[/#if]
[/#if]
[/#if]

[#if SWIPdatas??]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as variable]
    [#assign value = variable.value]
    [#assign name = variable.name]
[#if FX_STANDALONE_ENABLE_value !="1"]
[#if name?contains("FX_SRAM_INTERFACE") && value == "1"]
[#if LINK_SRAM_DRIVER_value??]
[#if LINK_SRAM_DRIVER_value == "1" || FORMAT_SRAM_MEDIA_value == "1"]
/* fx sram volume name */
#ifndef FX_SRAM_VOLUME_NAME
  #define FX_SRAM_VOLUME_NAME "SRAM_FLASH_DISK"
#endif

/* fx sram number of bytes per sector */
#ifndef FX_SRAM_SECTOR_SIZE
  #define FX_SRAM_SECTOR_SIZE            512
#endif
[/#if]

[#if FORMAT_SRAM_MEDIA_value == "1" ]
/* fx sram number of FATs */
#ifndef FX_SRAM_NUMBER_OF_FATS
  #define FX_SRAM_NUMBER_OF_FATS           1
#endif

/* fx sram Hidden sectors */
#ifndef FX_SRAM_HIDDEN_SECTORS
  #define FX_SRAM_HIDDEN_SECTORS           0
#endif
[/#if]
[/#if]
[/#if]

[#if name?contains("FX_SD_INTERFACE") && value == "1"]
[#if LINK_SD_DRIVER_value == "1" || FORMAT_SD_MEDIA_value == "1"]
/* fx sd volume name */
#ifndef FX_SD_VOLUME_NAME
  #define FX_SD_VOLUME_NAME "STM32_SDIO_DISK"
#endif
/* fx sd number of FATs */
#ifndef FX_SD_NUMBER_OF_FATS
  #define FX_SD_NUMBER_OF_FATS                1
#endif

/* fx sd Hidden sectors */
#ifndef FX_SD_HIDDEN_SECTORS
  #define FX_SD_HIDDEN_SECTORS               0
#endif
[/#if]
[/#if]

[#if name?contains("FX_MMC_INTERFACE") && value == "1"]
[#if LINK_MMC_DRIVER_value == "1" || FORMAT_MMC_MEDIA_value == "1"]
/* fx mmc volume name */
#ifndef FX_MMC_VOLUME_NAME
  #define FX_MMC_VOLUME_NAME "STM32_MMC_DISK"
#endif

/* fx mmc number of FATs */
#ifndef FX_MMC_NUMBER_OF_FATS
  #define FX_MMC_NUMBER_OF_FATS             1
#endif

/* fx mmc Hidden sectors */
#ifndef FX_MMC_HIDDEN_SECTORS
  #define FX_MMC_HIDDEN_SECTORS             0
#endif
[/#if]
[/#if]
[#if name?contains("FX_LX_NOR_INTERFACE")  && LX_NOR_USE_OSPI_DRIVER_value =="true" && value == "1"]
[#if LINK_NOR_OSPI_DRIVER_value == "1" && FORMAT_NOR_OSPI_MEDIA_value == "1"]

/* fx nor_ospi volume name */
#ifndef FX_NOR_OSPI_VOLUME_NAME
  #define FX_NOR_OSPI_VOLUME_NAME "STM32_NOR_OSPI_FLASH_DISK"
#endif

/* fx nor_ospi number of bytes per sector */
#ifndef FX_NOR_OSPI_SECTOR_SIZE
  #define FX_NOR_OSPI_SECTOR_SIZE         512
#endif

/* fx nor_ospi number of FATs */
#ifndef FX_NOR_OSPI_NUMBER_OF_FATS
  #define FX_NOR_OSPI_NUMBER_OF_FATS        1
#endif

/* fx nor_ospi Hidden sectors */
#ifndef FX_NOR_OSPI_HIDDEN_SECTORS
  #define FX_NOR_OSPI_HIDDEN_SECTORS        0
#endif
[/#if]
[/#if]

[#if name?contains("LX_NOR_USE_SIMULATOR_DRIVER")  && value == "true"]
[#if LINK_NOR_SIMULATOR_DRIVER_value == "1" && FORMAT_NOR_SIMULATOR_MEDIA_value == "1"]
/* fx nor_simulator volume name */
#ifndef FX_NOR_SIMULATOR_VOLUME_NAME
  #define FX_NOR_SIMULATOR_VOLUME_NAME "STM32_NOR_SIMULATOR_FLASH_DISK"
#endif

/* fx nor_simulator number of bytes per sector */
#ifndef FX_NOR_SIMULATOR_SECTOR_SIZE
  #define FX_NOR_SIMULATOR_SECTOR_SIZE     512
#endif

/* fx nor_simulator number of FATs */
#ifndef FX_NOR_SIMULATOR_NUMBER_OF_FATS
  #define FX_NOR_SIMULATOR_NUMBER_OF_FATS    1
#endif

/* fx nor_simulator Hidden sectors */
#ifndef FX_NOR_SIMULATOR_HIDDEN_SECTORS
  #define FX_NOR_SIMULATOR_HIDDEN_SECTORS    0
#endif

[/#if]
[/#if]
[/#if]
[/#list]
[/#if]
[/#list]
[/#if]
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
#ifdef __cplusplus
}
#endif
#endif /* __APP_FILEX_H__ */
