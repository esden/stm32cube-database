[#ftl]
[#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = "1" ]
[#assign FILEX_ENABLED_ENABLED_Value = "false" ]
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

  [#if name == "FILEX_APPLICATION_THREAD_ENTRY_NAME"]
      [#assign FILEX_APPLICATION_THREAD_ENTRY_NAME_value = value]
    [/#if]

  [#if name == "FILEX_APPLICATION_THREAD_PRIORITY"]
      [#assign FILEX_APPLICATION_THREAD_PRIORITY_value = value]
    [/#if]

	[#if name == "FILEX_APPLICATION_THREAD_STACK_SIZE"]
      [#assign FILEX_APPLICATION_THREAD_STACK_SIZE_value = value]
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

  [#if name == "FX_SRAM_INTERFACE"]
      [#assign FX_SRAM_INTERFACE_value = value]
    [/#if]

    [#if name == "FX_SD_INTERFACE"]
      [#assign FX_SD_INTERFACE_value = value]
    [/#if]

  [#if name == "FX_MMC_INTERFACE"]
      [#assign FX_MMC_INTERFACE_value = value]
    [/#if]

  [#if name == "FX_LX_NOR_INTERFACE"]
      [#assign FX_LX_NOR_INTERFACE_value = value]
    [/#if]

    [#if name == "LX_NOR_USE_SIMULATOR_DRIVER"]
      [#assign LX_NOR_USE_SIMULATOR_DRIVER_value = value]
    [/#if]

  [#if name == "LX_NOR_USE_OSPI_DRIVER"]
      [#assign LX_NOR_USE_OSPI_DRIVER_value = value]
    [/#if]

	[#if name == "FX_STANDALONE_ENABLE"]
      [#assign FX_STANDALONE_ENABLE_value = value]
    [/#if]

[#if RTEdatas??]
  [#list RTEdatas as define]

    [#if define?contains("THREADX_ENABLED")]
      [#assign THREADX_ENABLED_Value = "true"]
    [/#if]
	[#if define?contains("FILEX_ENABLED")]
      [#assign FILEX_ENABLED_Value = "true"]
    [/#if]
	[#if define?contains("LX_NOR_OSPI_DRIVER")]
      [#assign LX_NOR_OSPI_DRIVER_ENABLED_Value = "true"]
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
  * @file    app_filex.c
  * @author  MCD Application Team
  * @brief   FileX applicative file
  ******************************************************************************
 [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "app_filex.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
[#if FX_STANDALONE_ENABLE_value !="1"]
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL  != "0"]
[#if GENERATE_FILEX_INIT_CODE_value??]
[#if GENERATE_FILEX_INIT_CODE_value  == "true"]
/* Main thread stack size */
#define FX_APP_THREAD_STACK_SIZE         ${FILEX_APPLICATION_THREAD_STACK_SIZE_value}
/* Main thread priority */
#define FX_APP_THREAD_PRIO               ${FILEX_APPLICATION_THREAD_PRIORITY_value}
[/#if]
[/#if]
[/#if]
[/#if]
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
[#if FX_STANDALONE_ENABLE_value !="1"]
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL  != "0"]
[#if GENERATE_FILEX_INIT_CODE_value??]
[#if GENERATE_FILEX_INIT_CODE_value  == "true"]
/* Main thread global data structures.  */
TX_THREAD       fx_app_thread;
[/#if]
[/#if]
[/#if]
[/#if]

[#if FX_STANDALONE_ENABLE_value !="1"]
[#if FX_SRAM_INTERFACE_value??]
[#if FX_SRAM_INTERFACE_value == "1"]
[#if LINK_SRAM_DRIVER_value == "1" || FORMAT_SRAM_MEDIA_value == "1"]
/* Buffer for FileX FX_MEDIA sector cache. */
[#if FamilyName=="STM32C0" || FamilyName=="STM32U0"]
uint32_t fx_sram_media_memory[FX_SRAM_SECTOR_SIZE / sizeof(uint32_t)];

[#else]
ALIGN_32BYTES (uint32_t fx_sram_media_memory[FX_SRAM_SECTOR_SIZE / sizeof(uint32_t)]);

[/#if]
/* Define FileX global data structures.  */
FX_MEDIA        sram_disk;
[/#if]
[/#if]
[/#if]
[/#if]

[#if FX_STANDALONE_ENABLE_value !="1"]
[#if FX_SD_INTERFACE_value??]
[#if FX_SD_INTERFACE_value == "1"]
[#if LINK_SD_DRIVER_value == "1" || FORMAT_SD_MEDIA_value == "1"]
/* Buffer for FileX FX_MEDIA sector cache. */
[#if FamilyName=="STM32U0"]
uint32_t fx_nor_simulator_media_memory[FX_NOR_SIMULATOR_SECTOR_SIZE / sizeof(uint32_t)];
[#else]
ALIGN_32BYTES (uint32_t fx_sd_media_memory[FX_STM32_SD_DEFAULT_SECTOR_SIZE / sizeof(uint32_t)]);
[/#if]
/* Define FileX global data structures.  */
FX_MEDIA        sdio_disk;
[/#if]
[#if FORMAT_SD_MEDIA_value == "1"]
HAL_SD_CardInfoTypeDef *pCardInfoSD;
[/#if]
[/#if]
[/#if]
[/#if]

[#if FX_STANDALONE_ENABLE_value !="1"]
[#if FX_MMC_INTERFACE_value??]
[#if FX_MMC_INTERFACE_value == "1"]
[#if LINK_MMC_DRIVER_value == "1" || FORMAT_MMC_MEDIA_value == "1"]
/* Buffer for FileX FX_MEDIA sector cache. */
ALIGN_32BYTES (uint32_t fx_mmc_media_memory[FX_STM32_MMC_DEFAULT_SECTOR_SIZE / sizeof(uint32_t)]);
/* Define FileX global data structures.  */
FX_MEDIA        mmc_disk;
[/#if]
[#if FORMAT_MMC_MEDIA_value == "1"]
HAL_MMC_CardInfoTypeDef *pCardInfoMMC;
[/#if]
[/#if]
[/#if]
[/#if]

[#if FX_STANDALONE_ENABLE_value !="1"]
[#if FX_LX_NOR_INTERFACE_value??]
[#if FX_LX_NOR_INTERFACE_value == "1" && LX_NOR_USE_OSPI_DRIVER_value =="true"]
[#if LINK_NOR_OSPI_DRIVER_value == "1" || FORMAT_NOR_OSPI_MEDIA_value == "1"]
/* Buffer for FileX FX_MEDIA sector cache. */
ALIGN_32BYTES (uint32_t fx_nor_ospi_media_memory[FX_NOR_OSPI_SECTOR_SIZE / sizeof(uint32_t)]);
/* Define FileX global data structures.  */
FX_MEDIA        nor_ospi_flash_disk;
[/#if]
[/#if]
[/#if]
[/#if]

[#if FX_STANDALONE_ENABLE_value !="1"]
[#if LX_NOR_USE_SIMULATOR_DRIVER_value??]
[#if LX_NOR_USE_SIMULATOR_DRIVER_value == "true" && FX_LX_NOR_INTERFACE_value == "1"]
[#if LINK_NOR_SIMULATOR_DRIVER_value == "1" || FORMAT_NOR_SIMULATOR_MEDIA_value == "1"]
/* Buffer for FileX FX_MEDIA sector cache. */
[#if FamilyName=="STM32U0"]
uint32_t fx_nor_simulator_media_memory[FX_NOR_SIMULATOR_SECTOR_SIZE / sizeof(uint32_t)];
[#else]
ALIGN_32BYTES (uint32_t fx_nor_simulator_media_memory[FX_NOR_SIMULATOR_SECTOR_SIZE / sizeof(uint32_t)]);
[/#if]
/* Define FileX global data structures.  */
FX_MEDIA        nor_simulator_flash_disk;
[/#if]
[/#if]
[/#if]
[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
[#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = "1" ]
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
	
	[#if name == "FX_STANDALONE_ENABLE"]
      [#assign FX_STANDALONE_ENABLE_value = value]
    [/#if]
   [/#list]
[/#if]
[/#list]
[/#compress]


[#if FX_STANDALONE_ENABLE_value == "1"]
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */
/**
  * @brief  Application FileX Initialization.
  * @param memory_ptr: memory pointer
  * @retval int
  */
UINT MX_FileX_Init(void)
{
  UINT ret = FX_SUCCESS;
  /* USER CODE BEGIN MX_FileX_Init */

  /* USER CODE END MX_FileX_Init */

/* Initialize FileX.  */
  fx_system_initialize();

  /* USER CODE BEGIN MX_FileX_Init 1*/

  /* USER CODE END MX_FileX_Init 1*/

  return ret;
}
[#else]
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL  != "0"]
[#if GENERATE_FILEX_INIT_CODE_value??]
[#if GENERATE_FILEX_INIT_CODE_value  == "true"]
/* Main thread entry function.  */
void ${FILEX_APPLICATION_THREAD_ENTRY_NAME_value}(ULONG thread_input);
[/#if]
[/#if]
[/#if]

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/**
  * @brief  Application FileX Initialization.
  * @param memory_ptr: memory pointer
  * @retval int
*/
UINT MX_FileX_Init(VOID *memory_ptr)
{
  UINT ret = FX_SUCCESS;
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL  != "0"]
[#if GENERATE_FILEX_INIT_CODE_value??]
[#if GENERATE_FILEX_INIT_CODE_value  == "true"]
  TX_BYTE_POOL *byte_pool = (TX_BYTE_POOL*)memory_ptr;
  VOID *pointer;

/* USER CODE BEGIN MX_FileX_MEM_POOL */

/* USER CODE END MX_FileX_MEM_POOL */

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/*Allocate memory for the main thread's stack*/
  ret = tx_byte_allocate(byte_pool, &pointer, FX_APP_THREAD_STACK_SIZE, TX_NO_WAIT);

/* Check FX_APP_THREAD_STACK_SIZE allocation*/
  if (ret != FX_SUCCESS)
  {
    return TX_POOL_ERROR;
  }

/* Create the main thread.  */
  ret = tx_thread_create(&fx_app_thread, FX_APP_THREAD_NAME, ${FILEX_APPLICATION_THREAD_ENTRY_NAME_value}, 0, pointer, FX_APP_THREAD_STACK_SIZE,
                         FX_APP_THREAD_PRIO, FX_APP_PREEMPTION_THRESHOLD, FX_APP_THREAD_TIME_SLICE, FX_APP_THREAD_AUTO_START);

/* Check main thread creation */
  if (ret != FX_SUCCESS)
  {
    return TX_THREAD_ERROR;
  }
[#else]
  TX_BYTE_POOL *byte_pool = (TX_BYTE_POOL*)memory_ptr;

  /* USER CODE BEGIN MX_FileX_MEM_POOL */
  (void)byte_pool;
  /* USER CODE END MX_FileX_MEM_POOL */
[/#if]  
[/#if]  
[/#if]

/* USER CODE BEGIN MX_FileX_Init */
  
/* USER CODE END MX_FileX_Init */

/* Initialize FileX.  */
  fx_system_initialize();

/* USER CODE BEGIN MX_FileX_Init 1*/

/* USER CODE END MX_FileX_Init 1*/

  return ret;
}
[/#if]



[#if FX_STANDALONE_ENABLE_value !="1"]
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL  != "0" ]
[#if GENERATE_FILEX_INIT_CODE_value??]                                                                  
[#if GENERATE_FILEX_INIT_CODE_value  == "true"]                                                                  
/**
 * @brief  Main thread entry.
 * @param thread_input: ULONG user argument used by the thread entry
 * @retval none
*/
 void ${FILEX_APPLICATION_THREAD_ENTRY_NAME_value}(ULONG thread_input)
 {
[#if FX_SRAM_INTERFACE_value??]
[#if FX_SRAM_INTERFACE_value == "1"]
[#if FORMAT_SRAM_MEDIA_value == "1" || LINK_SRAM_DRIVER_value == "1"]
  UINT sram_status = FX_SUCCESS;
[/#if]
[/#if]
[/#if]

[#if FX_SD_INTERFACE_value??]
[#if FX_SD_INTERFACE_value == "1"]
[#if FORMAT_SD_MEDIA_value == "1" || LINK_SD_DRIVER_value == "1"]
  UINT sd_status = FX_SUCCESS;
[/#if]
[/#if]
[/#if]

[#if FX_MMC_INTERFACE_value??]
[#if FX_MMC_INTERFACE_value == "1"]
[#if FORMAT_MMC_MEDIA_value == "1" || LINK_MMC_DRIVER_value == "1"]
  UINT mmc_status = FX_SUCCESS;
[/#if]
[/#if]
[/#if]

[#if FX_LX_NOR_INTERFACE_value??]
[#if FX_LX_NOR_INTERFACE_value == "1" && LX_NOR_USE_OSPI_DRIVER_value =="true"]
[#if FORMAT_NOR_OSPI_MEDIA_value == "1" || LINK_NOR_OSPI_DRIVER_value == "1"]  
  UINT nor_ospi_status = FX_SUCCESS;
[/#if]
[/#if]

[#if LX_NOR_USE_SIMULATOR_DRIVER_value == "true" && FX_LX_NOR_INTERFACE_value == "1"]
[#if FORMAT_NOR_SIMULATOR_MEDIA_value == "1" || LINK_NOR_SIMULATOR_DRIVER_value == "1"]  
  UINT nor_sim_status = FX_SUCCESS;
[/#if]
[/#if]
[/#if]
/* USER CODE BEGIN ${FILEX_APPLICATION_THREAD_ENTRY_NAME_value} 0*/
  
/* USER CODE END ${FILEX_APPLICATION_THREAD_ENTRY_NAME_value} 0*/

[#if FX_SRAM_INTERFACE_value??]
[#if FX_SRAM_INTERFACE_value == "1"]
[#if FORMAT_SRAM_MEDIA_value == "1"]
/* Format the SRAM_BASE memory as FAT */
  sram_status =  fx_media_format(&sram_disk,                              // RamDisk pointer
                                 fx_stm32_sram_driver,                    // Driver entry
                                 (VOID *)FX_NULL,                         // Device info pointer
                                 (UCHAR *) fx_sram_media_memory,          // Media buffer pointer
                                 sizeof(fx_sram_media_memory),            // Media buffer size
                                 FX_SRAM_VOLUME_NAME,                     // Volume Name
                                 FX_SRAM_NUMBER_OF_FATS,                  // Number of FATs
                                 32,                                      // Directory Entries
                                 FX_SRAM_HIDDEN_SECTORS,                  // Hidden sectors
                                 FX_SRAM_DISK_SIZE / FX_SRAM_SECTOR_SIZE, // Total sectors
                                 FX_SRAM_SECTOR_SIZE,                     // Sector size
                                 8,                                       // Sectors per cluster
                                 1,                                       // Heads
                                 1);                                      // Sectors per track

/* Check the format sram_status */
  if (sram_status != FX_SUCCESS)
  {
   /* USER CODE BEGIN SRAM MEDIA open error */
    while(1);
    /* USER CODE END SRAM MEDIA open error */
  }
[/#if]

[#if LINK_SRAM_DRIVER_value == "1"] 
/* Open the sram_disk driver */
  sram_status =  fx_media_open(&sram_disk, FX_SRAM_VOLUME_NAME, fx_stm32_sram_driver, (VOID *)FX_NULL, (VOID *) fx_sram_media_memory, sizeof(fx_sram_media_memory));

/* Check the media open sram_status */
  if (sram_status != FX_SUCCESS)
  {
    /* USER CODE BEGIN SRAM DRIVER open error */
    while(1);
    /* USER CODE END SRAM DRIVER open error */
  }
[/#if]
[/#if]
[/#if]

[#if FX_SD_INTERFACE_value??]
[#if FX_SD_INTERFACE_value == "1"]
[#if FORMAT_SD_MEDIA_value == "1"]
/* Format the SD memory as FAT */
  sd_status =  fx_media_format(&sdio_disk,                          // SD_Disk pointer
                               fx_stm32_sd_driver,                  // Driver entry
                               (VOID *)FX_NULL,                     // Device info pointer
                               (UCHAR *) fx_sd_media_memory,        // Media buffer pointer
                               sizeof(fx_sd_media_memory),          // Media buffer size
                               FX_SD_VOLUME_NAME,                   // Volume Name
                               FX_SD_NUMBER_OF_FATS,                // Number of FATs
                               32,                                  // Directory Entries
                               FX_SD_HIDDEN_SECTORS,                // Hidden sectors
                               pCardInfoSD->BlockNbr,                 // Total sectors
                               FX_STM32_SD_DEFAULT_SECTOR_SIZE,     // Sector size
                               8,                                   // Sectors per cluster
                               1,                                   // Heads
                               1);                                  // Sectors per track

/* Check the format sd_status */
  if (sd_status != FX_SUCCESS)
  {
     /* USER CODE BEGIN SD MEDIA get info error */
    while(1);
    /* USER CODE END SD MEDIA get info error */
  }
 
[/#if]
[#if LINK_SD_DRIVER_value == "1"]
/* Open the SD disk driver */
  sd_status =  fx_media_open(&sdio_disk, FX_SD_VOLUME_NAME, fx_stm32_sd_driver, (VOID *)FX_NULL, (VOID *) fx_sd_media_memory, sizeof(fx_sd_media_memory));

/* Check the media open sd_status */
  if (sd_status != FX_SUCCESS)
  {
     /* USER CODE BEGIN SD DRIVER get info error */
    while(1);
    /* USER CODE END SD DRIVER get info error */
  }
[/#if]
[/#if]
[/#if]

[#if FX_MMC_INTERFACE_value??]
[#if FX_MMC_INTERFACE_value == "1"]
[#if FORMAT_MMC_MEDIA_value == "1"]
/* Format the MMC memory as FAT */
  mmc_status =  fx_media_format(&mmc_disk,                             // MMC_Disk pointer
                                fx_stm32_mmc_driver,                   // Driver entry
                                (VOID *)FX_NULL,                       // Device info pointer
                                (UCHAR *) fx_mmc_media_memory,         // Media buffer pointer
                                sizeof(fx_mmc_media_memory),           // Media buffer size
                                FX_MMC_VOLUME_NAME,                    // Volume Name
                                FX_MMC_NUMBER_OF_FATS,                 // Number of FATs
                                32,                                    // Directory Entries
                                FX_MMC_HIDDEN_SECTORS,                 // Hidden sectors
                                pCardInfoMMC->BlockNbr,                   // Total sectors
                                FX_STM32_MMC_DEFAULT_SECTOR_SIZE,      // Sector size
                                8,                                     // Sectors per cluster
                                1,                                     // Heads
                                1);                                    // Sectors per track

/* Check the format mmc_status */
  if (mmc_status != FX_SUCCESS)
  {
    /* USER CODE BEGIN MMC format error */
    while(1);
    /* USER CODE END MMC format error */
  }
[/#if]

[#if LINK_MMC_DRIVER_value == "1"]
/* Open the disk driver */
  mmc_status =  fx_media_open(&mmc_disk, FX_MMC_VOLUME_NAME, fx_stm32_mmc_driver, (VOID *)FX_NULL, (VOID *) fx_mmc_media_memory, sizeof(fx_mmc_media_memory));

/* Check the media open mmc_status */
  if (mmc_status != FX_SUCCESS)
  {
    /* USER CODE BEGIN MMC open error */
    while(1);
    /* USER CODE END MMC open error */
  }
[/#if]
[/#if]
[/#if]

[#if FX_LX_NOR_INTERFACE_value??]
[#if FX_LX_NOR_INTERFACE_value == "1" && LX_NOR_USE_OSPI_DRIVER_value =="true"]
[#if FORMAT_NOR_OSPI_MEDIA_value == "1"]
/* Format the OCTO-SPI NOR flash as FAT */
  nor_ospi_status =  fx_media_format(&nor_ospi_flash_disk,                                                           // nor_ospi_flash_disk pointer
                                     fx_stm32_levelx_nor_driver,                                                     // Driver entry
                                     (VOID *)LX_NOR_OSPI_DRIVER_ID,                                                  // Device info pointer
                                     (UCHAR *) fx_nor_ospi_media_memory,                                             // Media buffer pointer
                                     sizeof(fx_nor_ospi_media_memory),                                               // Media buffer size
                                     FX_NOR_OSPI_VOLUME_NAME,                                                        // Volume Name
                                     FX_NOR_OSPI_NUMBER_OF_FATS,                                                     // Number of FATs
                                     32,                                                                             // Directory Entries
                                     FX_NOR_OSPI_HIDDEN_SECTORS,                                                     // Hidden sectors
                                     (LX_STM32_OSPI_FLASH_SIZE - LX_STM32_OSPI_SECTOR_SIZE)/ FX_NOR_OSPI_SECTOR_SIZE,// Total sectors
                                     FX_NOR_OSPI_SECTOR_SIZE,                                                        // Sector size
                                     8,                                                                              // Sectors per cluster
                                     1,                                                                              // Heads
                                     1);                                                                             // Sectors per track

/* Check the format nor_ospi_status */
  if (nor_ospi_status != FX_SUCCESS)
  {
    /* USER CODE BEGIN OCTO-SPI NOR format error */
    while(1);
    /* USER CODE END OCTO-SPI NOR format error */
  }
[/#if]

[#if LINK_NOR_OSPI_DRIVER_value == "1"]
  /* Open the OCTO-SPI NOR driver */
 nor_ospi_status =  fx_media_open(&nor_ospi_flash_disk, FX_NOR_OSPI_VOLUME_NAME, fx_stm32_levelx_nor_driver, (VOID *)LX_NOR_OSPI_DRIVER_ID, (VOID *) fx_nor_ospi_media_memory, sizeof(fx_nor_ospi_media_memory));

/* Check the media open nor_ospi_status */
  if (nor_ospi_status != FX_SUCCESS)
  {
    /* USER CODE BEGIN OCTO-SPI NOR open error */
    while(1);
    /* USER CODE END OCTO-SPI NOR open error */
  }
[/#if]
[/#if]

[#if LX_NOR_USE_SIMULATOR_DRIVER_value == "true" && FX_LX_NOR_INTERFACE_value == "1"]
[#if FORMAT_NOR_SIMULATOR_MEDIA_value == "1"]  
/* Format the SIMULATOR NOR flash as FAT */
  nor_sim_status =  fx_media_format(&nor_simulator_flash_disk,                                  // nor_simulator_flash_disk pointer
                                    fx_stm32_levelx_nor_driver,                                 // Driver entry
                                    (VOID *)LX_NOR_SIMULATOR_DRIVER_ID,                         // Device info pointer
                                    (UCHAR *) fx_nor_simulator_media_memory,                    // Media buffer pointer
                                    sizeof(fx_nor_simulator_media_memory),                      // Media buffer size
                                    FX_NOR_SIMULATOR_VOLUME_NAME,                               // Volume Name
                                    FX_NOR_SIMULATOR_NUMBER_OF_FATS,                            // Number of FATs
                                    32,                                                         // Directory Entries
                                    FX_NOR_SIMULATOR_HIDDEN_SECTORS,                            // Hidden sectors
                                    LX_NOR_SIMULATOR_FLASH_SIZE / FX_NOR_SIMULATOR_SECTOR_SIZE, // Total sectors
                                    FX_NOR_SIMULATOR_SECTOR_SIZE,                               // Sector size
                                    8,                                                          // Sectors per cluster
                                    1,                                                          // Heads
                                    1);                                                         // Sectors per track

/* Check the format nor_sim_status */
  if (nor_sim_status != FX_SUCCESS)
  {
    /* USER CODE BEGIN NOR Simulator format error */
    while(1);
    /* USER CODE END NOR Simulator format error */
  }
[/#if]

[#if LINK_NOR_SIMULATOR_DRIVER_value == "1"]
/* Open the SIMULATOR NOR driver */
  nor_sim_status =  fx_media_open(&nor_simulator_flash_disk, FX_NOR_SIMULATOR_VOLUME_NAME, fx_stm32_levelx_nor_driver, (VOID *)LX_NOR_SIMULATOR_DRIVER_ID, (VOID *) fx_nor_simulator_media_memory, sizeof(fx_nor_simulator_media_memory));

/* Check the media open nor_sim_status */
  if (nor_sim_status != FX_SUCCESS) 
  {
    /* USER CODE BEGIN NOR Simulator open error */
    while(1);
    /* USER CODE END NOR Simulator open error */
  }
[/#if]
[/#if]
[/#if]
/* USER CODE BEGIN ${FILEX_APPLICATION_THREAD_ENTRY_NAME_value} 1*/
  
/* USER CODE END ${FILEX_APPLICATION_THREAD_ENTRY_NAME_value} 1*/
  }
[/#if]
[/#if]
[/#if]
[/#if]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
