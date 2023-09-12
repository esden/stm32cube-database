[#ftl]
[#compress]

[#assign ospi_init_driver = "1"]
[#assign ospi_erase_flash = "0"]
[#assign glue_api = "DMA_API"]

[#assign ospi_comp = "custom"]
[#assign ospi_instance = 1]

[#if BspComponentDatas??]
[#list BspComponentDatas as BSP]
[#if BSP.ipName?contains("MX25LM51245G")]
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
      [#assign TRANSFER_NOTIFICATION_value = value]
    [/#if]

    [#if name == "LX_OSPI_INSTANCE"]
    [#if value == "1"]
      [#assign ospi_instance = 2]
    [/#if]
    [/#if]

    [#if name == "GLUE_FUNCTIONS"]
      [#assign glue_api = value]
    [/#if]

    [#if name == "LX_USE_OCTOSPI"]
      [#assign LX_USE_OCTOSPI_value = value]
    [/#if]
	
    [#if "${FamilyName?lower_case}" == "stm32u5"]
      [#assign  used_api= "OSPI"]
    [/#if]
    
    [#if "${FamilyName?lower_case}" == "stm32h5"]
      [#assign used_api = "XSPI"]
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
#include "lx_stm32_ospi_driver.h"
[#if LX_USE_OCTOSPI_value == "octo SPI"]
[#if "${FamilyName?lower_case}" == "stm32u5"]
[#if ospi_comp == "MX25LM51245G"]

/* HAL DMA API implementation for OctoSPI component MX25LM51245G
 * The present implementation assumes the following settings are set:

  Instance              = OCTOSPI${ospi_instance}
  FifoThreshold         = 4
  DualQuad              = disabled
  MemoryType            = Macronix
  DeviceSize            = 26
  ChipSelectHighTime    = 2
  FreeRunningClock      = disabled
  ClockMode             = low
  ClockPrescaler        = 4
  SampleShifting        = none
  DelayHoldQuarterCycle = enabled
  ChipSelectBoundary    = 0
  DelayBlockBypass      = used
 */
 [/#if]
[/#if]
[#elseif LX_USE_OCTOSPI_value == "Octo SPI with Data Strobe"]
[#if "${FamilyName?lower_case}" == "stm32h5"]
[#if ospi_comp == "MX25LM51245G"]

/* HAL DMA API implementation for OctoSPI component MX25LM51245G
 * The present implementation assumes the following settings are set:

  Instance              = OCTOSPI${ospi_instance}
  FifoThreshold         = 1
  DualQuad              = disabled
  MemoryType            = Macronix
  DeviceSize            = 26
  ChipSelectHighTime    = 2
  FreeRunningClock      = disabled
  ClockMode             = low
  ClockPrescaler        = 3
  SampleShifting        = none
  DelayHoldQuarterCycle = enabled
  ChipSelectBoundary    = 0
  DelayBlockBypass      = used
 */
[/#if]
[/#if]
[/#if]

extern ${used_api}_HandleTypeDef hospi${ospi_instance};

#if (LX_STM32_OSPI_INIT == 1)
extern void MX_OCTOSPI${ospi_instance}_Init(void);
#endif

[#if glue_api == "DMA_API"]
static uint8_t ospi_memory_reset            (${used_api}_HandleTypeDef *h${used_api?lower_case});
static uint8_t ospi_set_write_enable        (${used_api}_HandleTypeDef *h${used_api?lower_case});
static uint8_t ospi_auto_polling_ready      (${used_api}_HandleTypeDef *h${used_api?lower_case}, uint32_t timeout);
static uint8_t ospi_set_octal_mode          (${used_api}_HandleTypeDef *h${used_api?lower_case});
[/#if]

/* USER CODE BEGIN SECTOR_BUFFER */
ULONG ospi_sector_buffer[LX_STM32_OSPI_SECTOR_SIZE / sizeof(ULONG)];
/* USER CODE END SECTOR_BUFFER */
[#if glue_api == "DMA_API"]

[#if TRANSFER_NOTIFICATION_value == "ThreadX_Semaphore"]
TX_SEMAPHORE ${used_api?lower_case}_rx_semaphore;
TX_SEMAPHORE ${used_api?lower_case}_tx_semaphore;
[/#if]
[/#if]

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/**
* @brief system init for octospi levelx driver
* @param UINT instance OSPI instance to initialize
* @retval 0 on success error value otherwise
*/
INT lx_stm32_ospi_lowlevel_init(UINT instance)
{
  INT status = 0;

  /* USER CODE BEGIN PRE_OSPI_INIT */

  /* USER CODE END PRE_OSPI_INIT */

[#if glue_api == "DMA_API"]

  /* Call the DeInit function to reset the driver */
#if (LX_STM32_OSPI_INIT == 1)
  hospi${ospi_instance}.Instance = OCTOSPI${ospi_instance};
  if (HAL_${used_api}_DeInit(&hospi${ospi_instance}) != HAL_OK)
  {
    return 1;
  }

  /* Init the OSPI */
  MX_OCTOSPI${ospi_instance}_Init();
#endif

  /* OSPI memory reset */
  if (ospi_memory_reset(&hospi${ospi_instance}) != 0)
  {
    return 1;
  }

  /* Enable octal mode */
  if (ospi_set_octal_mode(&hospi${ospi_instance}) != 0)
  {
    return 1;
  }

[/#if]

  /* USER CODE BEGIN POST_OSPI_INIT */

  /* USER CODE END POST_OSPI_INIT */

  return status;
}

/**
* @brief deinit octospi levelx driver, could be called by the fx_media_close()
* @param UINT instance OSPI instance to deinitialize
* @retval 0 on success error value otherwise
*/
INT lx_stm32_ospi_lowlevel_deinit(UINT instance)
{
  INT status = 0;

[#if glue_api == "DMA_API"]
  [#if TRANSFER_NOTIFICATION_value == "ThreadX_Semaphore"]
  /* Delete semaphore objects */
  tx_semaphore_delete(&${used_api ?lower_case}_tx_semaphore);
  tx_semaphore_delete(&${used_api ?lower_case}_rx_semaphore);
  [/#if]

  /* Call the DeInit function to reset the driver */
  if (HAL_${used_api}_DeInit(&hospi${ospi_instance}) != HAL_OK)
  {
    return 1;
  }
[/#if]

  /* USER CODE BEGIN PRE_OSPI_DEINIT */

  /* USER CODE END PRE_OSPI_DEINIT */

  return status;
}

/**
* @brief Get the status of the OSPI instance
* @param UINT instance OSPI instance
* @retval 0 if the OSPI is ready 1 otherwise
*/
INT lx_stm32_ospi_get_status(UINT instance)
{
  INT status = 0;

[#if glue_api == "DMA_API"]
  ${used_api}_RegularCmdTypeDef s_command;
  uint8_t reg[2];
[/#if]

  /* USER CODE BEGIN PRE_OSPI_GET_STATUS */

  /* USER CODE END PRE_OSPI_GET_STATUS */

[#if glue_api == "DMA_API"]
  /* Initialize the read status register command */

  [#if "${FamilyName?lower_case}" == "stm32u5"]
  s_command.OperationType         = HAL_OSPI_OPTYPE_COMMON_CFG;
  s_command.FlashId               = HAL_OSPI_FLASH_ID_1;
  s_command.Instruction           = LX_STM32_OSPI_OCTAL_READ_STATUS_REG_CMD;
  s_command.InstructionMode       = HAL_OSPI_INSTRUCTION_8_LINES;
  s_command.InstructionSize       = HAL_OSPI_INSTRUCTION_16_BITS;
  s_command.Address               = 0;
  s_command.AddressMode           = HAL_OSPI_ADDRESS_8_LINES;
  s_command.AddressSize           = HAL_OSPI_ADDRESS_32_BITS;
  s_command.AlternateBytesMode    = HAL_OSPI_ALTERNATE_BYTES_NONE;
  s_command.DataMode              = HAL_OSPI_DATA_8_LINES;
  s_command.NbData                = 2;
  s_command.DummyCycles           = LX_STM32_OSPI_DUMMY_CYCLES_READ_OCTAL;
  s_command.SIOOMode              = HAL_OSPI_SIOO_INST_EVERY_CMD;

  /* DTR mode is enabled */
  s_command.InstructionDtrMode    = HAL_OSPI_INSTRUCTION_DTR_ENABLE;
  s_command.AddressDtrMode        = HAL_OSPI_ADDRESS_DTR_ENABLE;
  s_command.DataDtrMode           = HAL_OSPI_DATA_DTR_ENABLE;
  s_command.DQSMode               = HAL_OSPI_DQS_ENABLE;
  [/#if]
  [#if "${FamilyName?lower_case}" == "stm32h5"]
  s_command.OperationType         = HAL_XSPI_OPTYPE_COMMON_CFG;
  s_command.IOSelect              = HAL_XSPI_SELECT_IO_7_0;
  s_command.Instruction           = LX_STM32_OSPI_OCTAL_READ_STATUS_REG_CMD;
  s_command.InstructionMode       = HAL_XSPI_INSTRUCTION_8_LINES;
  s_command.InstructionWidth      = HAL_XSPI_INSTRUCTION_16_BITS;
  s_command.Address               = 0;
  s_command.AddressMode           = HAL_XSPI_ADDRESS_8_LINES;
  s_command.AddressWidth          = HAL_XSPI_ADDRESS_32_BITS;
  s_command.AlternateBytesMode    = HAL_XSPI_ALT_BYTES_NONE;
  s_command.DataMode              = HAL_XSPI_DATA_8_LINES;
  s_command.DataLength            = 2;
  s_command.DummyCycles           = LX_STM32_OSPI_DUMMY_CYCLES_READ_OCTAL;
  s_command.SIOOMode              = HAL_XSPI_SIOO_INST_EVERY_CMD;

  /* DTR mode is enabled */
  s_command.InstructionDTRMode    = HAL_XSPI_INSTRUCTION_DTR_ENABLE;
  s_command.AddressDTRMode        = HAL_XSPI_ADDRESS_DTR_ENABLE;
  s_command.DataDTRMode           = HAL_XSPI_DATA_DTR_ENABLE;
  s_command.DQSMode               = HAL_XSPI_DQS_ENABLE;
  [/#if]

  /* USER CODE BEGIN GET_STATUS_CMD */

  /* USER CODE END GET_STATUS_CMD */

  /* Configure the command */
  if (HAL_${used_api}_Command(&hospi${ospi_instance}, &s_command, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  /* Reception of the data */
  if (HAL_${used_api}_Receive(&hospi${ospi_instance}, reg, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  /* Check the value of the register */
  if ((reg[0] & LX_STM32_OSPI_SR_WIP) != 0)
  {
    return 1;
  }

  /* USER CODE BEGIN POST_OSPI_GET_STATUS */

  /* USER CODE END POST_OSPI_GET_STATUS */

[/#if]
  return status;
}

/**
* @brief Get size info of the flash memory
* @param UINT instance OSPI instance
* @param ULONG * block_size pointer to be filled with Flash block size
* @param ULONG * total_blocks pointer to be filled with Flash total number of blocks
* @retval 0 on Success and block_size and total_blocks are correctly filled
          1 on Failure, block_size = 0, total_blocks = 0
*/
INT lx_stm32_ospi_get_info(UINT instance, ULONG *block_size, ULONG *total_blocks)
{
  INT status = 0;

  /* USER CODE BEGIN PRE_OSPI_GET_INFO */

  /* USER CODE END PRE_OSPI_GET_INFO */

[#if glue_api == "DMA_API"]
  *block_size = LX_STM32_OSPI_SECTOR_SIZE;

  *total_blocks = (LX_STM32_OSPI_FLASH_SIZE / LX_STM32_OSPI_SECTOR_SIZE);

  /* USER CODE BEGIN POST_OSPI_GET_INFO */

  /* USER CODE END POST_OSPI_GET_INFO */
[/#if]
  return status;
}

/**
* @brief Read data from the OSPI memory into a buffer
* @param UINT instance OSPI instance
* @param ULONG * address the start address to read from
* @param ULONG * buffer the destination buffer
* @param ULONG words the total number of words to be read
* @retval 0 on Success 1 on Failure
*/
INT lx_stm32_ospi_read(UINT instance, ULONG *address, ULONG *buffer, ULONG words)
{
  INT status = 0;

[#if glue_api == "DMA_API"]
  ${used_api}_RegularCmdTypeDef s_command;
[/#if]

  /* USER CODE BEGIN PRE_OSPI_READ */

  /* USER CODE END PRE_OSPI_READ */

[#if glue_api == "DMA_API"]
  /* Initialize the read command */

  [#if "${FamilyName?lower_case}" == "stm32u5"]
  s_command.OperationType         = HAL_OSPI_OPTYPE_COMMON_CFG;
  s_command.FlashId               = HAL_OSPI_FLASH_ID_1;
  s_command.InstructionMode       = HAL_OSPI_INSTRUCTION_8_LINES;
  s_command.InstructionSize       = HAL_OSPI_INSTRUCTION_16_BITS;
  s_command.Address               = (uint32_t)address;
  s_command.AddressMode           = HAL_OSPI_ADDRESS_8_LINES;
  s_command.AddressSize           = HAL_OSPI_ADDRESS_32_BITS;
  s_command.AlternateBytesMode    = HAL_OSPI_ALTERNATE_BYTES_NONE;
  s_command.DataMode              = HAL_OSPI_DATA_8_LINES;
  s_command.NbData                = words * sizeof(ULONG);
  s_command.DummyCycles           = LX_STM32_OSPI_DUMMY_CYCLES_READ_OCTAL;
  s_command.SIOOMode              = HAL_OSPI_SIOO_INST_EVERY_CMD;

  /* DTR mode is enabled */
  s_command.Instruction           = LX_STM32_OSPI_OCTAL_READ_DTR_CMD;
  s_command.InstructionDtrMode    = HAL_OSPI_INSTRUCTION_DTR_ENABLE;
  s_command.AddressDtrMode        = HAL_OSPI_ADDRESS_DTR_ENABLE;
  s_command.DataDtrMode           = HAL_OSPI_DATA_DTR_ENABLE;
  s_command.DQSMode               = HAL_OSPI_DQS_ENABLE;
  [/#if]
  [#if "${FamilyName?lower_case}" == "stm32h5"]
  s_command.OperationType      = HAL_XSPI_OPTYPE_COMMON_CFG;
  s_command.IOSelect           = HAL_XSPI_SELECT_IO_7_0;
  s_command.InstructionMode    = HAL_XSPI_INSTRUCTION_8_LINES;
  s_command.InstructionWidth   = HAL_XSPI_INSTRUCTION_16_BITS;
  s_command.Address            = (uint32_t)address;
  s_command.AddressMode        = HAL_XSPI_ADDRESS_8_LINES;
  s_command.AddressWidth       = HAL_XSPI_ADDRESS_32_BITS;
  s_command.AlternateBytesMode = HAL_XSPI_ALT_BYTES_NONE;
  s_command.DataMode           = HAL_XSPI_DATA_8_LINES;
  s_command.DataLength         = (uint32_t) words * sizeof(ULONG);
  s_command.DummyCycles        = DUMMY_CYCLES_READ_OCTAL_DTR;
  s_command.SIOOMode           = HAL_XSPI_SIOO_INST_EVERY_CMD;

  /* DTR mode is enabled */
  s_command.Instruction           = LX_STM32_OSPI_OCTAL_READ_DTR_CMD;
  s_command.InstructionDTRMode    = HAL_XSPI_INSTRUCTION_DTR_ENABLE;
  s_command.AddressDTRMode        = HAL_XSPI_ADDRESS_DTR_ENABLE;
  s_command.DataDTRMode           = HAL_XSPI_DATA_DTR_ENABLE;
  s_command.DQSMode               = HAL_XSPI_DQS_ENABLE;
  [/#if]

  /* USER CODE BEGIN OSPI_READ_CMD */

  /* USER CODE END OSPI_READ_CMD */

  /* Configure the command */
  if (HAL_${used_api}_Command(&hospi${ospi_instance}, &s_command, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  /* Reception of the data */
  if (HAL_${used_api}_Receive_DMA(&hospi${ospi_instance}, (uint8_t*)buffer) != HAL_OK)
  {
    return 1;
  }
[/#if]

  /* USER CODE BEGIN POST_OSPI_READ */

  /* USER CODE END POST_OSPI_READ */

  return status;
}

/**
* @brief write a data buffer into the OSPI memory
* @param UINT instance OSPI instance
* @param ULONG * address the start address to write into
* @param ULONG * buffer the data source buffer
* @param ULONG words the total number of words to be written
* @retval 0 on Success 1 on Failure
*/
INT lx_stm32_ospi_write(UINT instance, ULONG *address, ULONG *buffer, ULONG words)
{
  INT status = 0;

[#if glue_api == "DMA_API"]
  ${used_api}_RegularCmdTypeDef s_command;

  uint32_t end_addr;
  uint32_t current_addr;

  uint32_t current_size;
  uint32_t data_buffer;
[/#if]

  /* USER CODE BEGIN PRE_OSPI_WRITE */

  /* USER CODE END PRE_OSPI_WRITE */

[#if glue_api == "DMA_API"]
[#if TRANSFER_NOTIFICATION_value == "ThreadX_Semaphore"]
  /* Calculation of the size between the write address and the end of the page */
  current_size = LX_STM32_OSPI_PAGE_SIZE - ((uint32_t)address % LX_STM32_OSPI_PAGE_SIZE);

  /* Check if the size of the data is less than the remaining place in the page */
  if (current_size > (((uint32_t) words) * sizeof(ULONG)))
  {
    current_size = ((uint32_t) words) * sizeof(ULONG);
  }

  /* Initialize the address variables */
  current_addr = (uint32_t) address;
  end_addr = ((uint32_t) address) + ((uint32_t) words) * sizeof(ULONG);
  data_buffer= (uint32_t)buffer;

  /* Initialize the program command */

[#if "${FamilyName?lower_case}" == "stm32u5"]  
  s_command.OperationType         = HAL_OSPI_OPTYPE_COMMON_CFG;
  s_command.FlashId               = HAL_OSPI_FLASH_ID_1;
  s_command.Instruction           = LX_STM32_OSPI_OCTAL_PAGE_PROG_CMD;
  s_command.InstructionMode       = HAL_OSPI_INSTRUCTION_8_LINES;
  s_command.InstructionSize       = HAL_OSPI_INSTRUCTION_16_BITS;
  s_command.AddressMode           = HAL_OSPI_ADDRESS_8_LINES;
  s_command.AddressSize           = HAL_OSPI_ADDRESS_32_BITS;
  s_command.AlternateBytesMode    = HAL_OSPI_ALTERNATE_BYTES_NONE;
  s_command.DataMode              = HAL_OSPI_DATA_8_LINES;
  s_command.DummyCycles           = 0;
  s_command.SIOOMode              = HAL_OSPI_SIOO_INST_EVERY_CMD;

  /* DTR mode is enabled */
  s_command.InstructionDtrMode    = HAL_OSPI_INSTRUCTION_DTR_ENABLE;
  s_command.AddressDtrMode        = HAL_OSPI_ADDRESS_DTR_ENABLE;
  s_command.DataDtrMode           = HAL_OSPI_DATA_DTR_ENABLE;
  s_command.DQSMode               = HAL_OSPI_DQS_DISABLE;

  /* USER CODE BEGIN OSPI_WRITE_CMD */

  /* USER CODE END OSPI_WRITE_CMD */

  /* Perform the write page by page */
  do
  {
    s_command.Address = current_addr;
    s_command.NbData  = current_size;
[/#if]
[#if "${FamilyName?lower_case}" == "stm32h5"]
  s_command.OperationType         = HAL_XSPI_OPTYPE_COMMON_CFG;
  s_command.IOSelect              = HAL_XSPI_SELECT_IO_7_0;
  s_command.Instruction           = LX_STM32_OSPI_OCTAL_PAGE_PROG_CMD;
  s_command.InstructionMode       = HAL_XSPI_INSTRUCTION_8_LINES;
  s_command.InstructionWidth      = HAL_XSPI_INSTRUCTION_16_BITS;
  s_command.AddressMode           = HAL_XSPI_ADDRESS_8_LINES;
  s_command.AddressWidth          = HAL_XSPI_ADDRESS_32_BITS;
  s_command.AlternateBytesMode    = HAL_XSPI_ALT_BYTES_NONE;
  s_command.DataMode              = HAL_XSPI_DATA_8_LINES;
  s_command.DummyCycles           = 0;
  s_command.SIOOMode              = HAL_XSPI_SIOO_INST_EVERY_CMD;

  /* DTR mode is enabled */
  s_command.InstructionDTRMode    = HAL_XSPI_INSTRUCTION_DTR_ENABLE;
  s_command.AddressDTRMode        = HAL_XSPI_ADDRESS_DTR_ENABLE;
  s_command.DataDTRMode           = HAL_XSPI_DATA_DTR_ENABLE;
  s_command.DQSMode               = HAL_XSPI_DQS_ENABLE;

  /* USER CODE BEGIN OSPI_WRITE_CMD */

  /* USER CODE END OSPI_WRITE_CMD */

  /* Perform the write page by page */
  do
  {
    s_command.Address = current_addr;
    s_command.DataLength  = current_size;
[/#if]

    /* Enable write operations */
    if (ospi_set_write_enable(&hospi${ospi_instance}) != 0)
    {
      return 1;
    }

    /* Configure the command */
    if (HAL_${used_api}_Command(&hospi${ospi_instance}, &s_command, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
    {
      return 1;
    }

    /* Transmission of the data */
    if (HAL_${used_api}_Transmit_DMA(&hospi${ospi_instance}, (uint8_t*)data_buffer) != HAL_OK)
    {
      return 1;
    }

    /* Check success of the transmission of the data */
    if(tx_semaphore_get(&${used_api?lower_case}_tx_semaphore, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != TX_SUCCESS)
    {
     return 1;
    }

    /* Configure automatic polling mode to wait for end of program */
    if (ospi_auto_polling_ready(&hospi${ospi_instance}, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != 0)
    {
      return 1;
    }

    /* Update the address and data variables for next page programming */
    current_addr += current_size;
    data_buffer += current_size;

    current_size = ((current_addr + LX_STM32_OSPI_PAGE_SIZE) > end_addr) ? (end_addr - current_addr) : LX_STM32_OSPI_PAGE_SIZE;
  } while (current_addr < end_addr);

   /* Release ${used_api ?lower_case}_transfer_semaphore in case of writing success */
    tx_semaphore_put(&${used_api?lower_case}_tx_semaphore);

[/#if]
[#if TRANSFER_NOTIFICATION_value == "Custom"]
  /* Calculation of the size between the write address and the end of the page */
  current_size = LX_STM32_OSPI_PAGE_SIZE - ((uint32_t)address % LX_STM32_OSPI_PAGE_SIZE);

  /* Check if the size of the data is less than the remaining place in the page */
  if (current_size > (((uint32_t) words) * sizeof(ULONG)))
  {
    current_size = ((uint32_t) words) * sizeof(ULONG);
  }

  /* Initialize the address variables */
  current_addr = (uint32_t) address;
  end_addr = ((uint32_t) address) + ((uint32_t) words) * sizeof(ULONG);
  data_buffer= (uint32_t)buffer;

  /* Initialize the program command */

[#if "${FamilyName?lower_case}" == "stm32u5"]
  s_command.OperationType         = HAL_OSPI_OPTYPE_COMMON_CFG;
  s_command.FlashId               = HAL_OSPI_FLASH_ID_1;
  s_command.Instruction           = LX_STM32_OSPI_OCTAL_PAGE_PROG_CMD;
  s_command.InstructionMode       = HAL_OSPI_INSTRUCTION_8_LINES;
  s_command.InstructionSize       = HAL_OSPI_INSTRUCTION_16_BITS;
  s_command.AddressMode           = HAL_OSPI_ADDRESS_8_LINES;
  s_command.AddressSize           = HAL_OSPI_ADDRESS_32_BITS;
  s_command.AlternateBytesMode    = HAL_OSPI_ALTERNATE_BYTES_NONE;
  s_command.DataMode              = HAL_OSPI_DATA_8_LINES;
  s_command.DummyCycles           = 0;
  s_command.SIOOMode              = HAL_OSPI_SIOO_INST_EVERY_CMD;

  /* DTR mode is enabled */
  s_command.InstructionDtrMode    = HAL_OSPI_INSTRUCTION_DTR_ENABLE;
  s_command.AddressDtrMode        = HAL_OSPI_ADDRESS_DTR_ENABLE;
  s_command.DataDtrMode           = HAL_OSPI_DATA_DTR_ENABLE;
  s_command.DQSMode               = HAL_OSPI_DQS_DISABLE;
[/#if]
[#if "${FamilyName?lower_case}" == "stm32h5"]
  s_command.OperationType         = HAL_XSPI_OPTYPE_COMMON_CFG;
  s_command.IOSelect              = HAL_XSPI_SELECT_IO_7_0;
  s_command.Instruction           = LX_STM32_OSPI_OCTAL_PAGE_PROG_CMD;
  s_command.InstructionMode       = HAL_XSPI_INSTRUCTION_8_LINES;
  s_command.InstructionWidth      = HAL_XSPI_INSTRUCTION_16_BITS;
  s_command.AddressMode           = HAL_XSPI_ADDRESS_8_LINES;
  s_command.AddressWidth          = HAL_XSPI_ADDRESS_32_BITS;
  s_command.AlternateBytesMode    = HAL_XSPI_ALT_BYTES_NONE;
  s_command.DataMode              = HAL_XSPI_DATA_8_LINES;
  s_command.DummyCycles           = 0;
  s_command.SIOOMode              = HAL_XSPI_SIOO_INST_EVERY_CMD;

  /* DTR mode is enabled */
  s_command.InstructionDTRMode    = HAL_XSPI_INSTRUCTION_DTR_ENABLE;
  s_command.AddressDTRMode        = HAL_XSPI_ADDRESS_DTR_ENABLE;
  s_command.DataDTRMode           = HAL_XSPI_DATA_DTR_ENABLE;
  s_command.DQSMode               = HAL_XSPI_DQS_ENABLE;
[/#if]

  /* USER CODE BEGIN OSPI_WRITE_CMD 1 */

  /* USER CODE END OSPI_WRITE_CMD 1 */

  /* Perform the write page by page */
[#if "${FamilyName?lower_case}" == "stm32u5"]
  do
  {
    s_command.Address = current_addr;
    s_command.NbData  = current_size;
[/#if]
[#if "${FamilyName?lower_case}" == "stm32h5"]
  do
  {
    s_command.Address = current_addr;
    s_command.DataLength  = current_size;
[/#if]

    /* Enable write operations */
    if (ospi_set_write_enable(&hospi${ospi_instance}) != 0)
    {
      return 1;
    }

    /* Configure the command */
    if (HAL_${used_api}_Command(&hospi${ospi_instance}, &s_command, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
    {
      return 1;
    }

    /* Transmission of the data */
    if (HAL_${used_api}_Transmit_DMA(&hospi${ospi_instance}, (uint8_t*)data_buffer) != HAL_OK)
    {
      return 1;
    }

    /* Add a check for successful data transmission */

    /* USER CODE BEGIN POST_OSPI_DMA_WRITE */

    /* USER CODE END POST_OSPI_DMA_WRITE */

    /* Configure automatic polling mode to wait for end of program */
    if (ospi_auto_polling_ready(&hospi${ospi_instance}, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != 0)
    {
      return 1;
    }

    /* Update the address and data variables for next page programming */
    current_addr += current_size;
    data_buffer += current_size;

    current_size = ((current_addr + LX_STM32_OSPI_PAGE_SIZE) > end_addr) ? (end_addr - current_addr) : LX_STM32_OSPI_PAGE_SIZE;
  } while (current_addr < end_addr);

/* At this stage the write operation is successful
 * Add LX_STM32_OSPI_WRITE_CPLT_NOTIFY() implementation to notify the low-level driver
 */
[/#if]
  /* USER CODE BEGIN POST_OSPI_WRITE */

  /* USER CODE END POST_OSPI_WRITE */

  return status;
}

/**
* @brief Erase the whole flash or a single block
* @param UINT instance OSPI instance
* @param ULONG  block the block to be erased
* @param ULONG  erase_count the number of times the block was erased
* @param UINT full_chip_erase if set to 0 a single block is erased otherwise the whole flash is erased
* @retval 0 on Success 1 on Failure
*/
INT lx_stm32_ospi_erase(UINT instance, ULONG block, ULONG erase_count, UINT full_chip_erase)
{
  INT status = 0;

[#if glue_api == "DMA_API"]
  ${used_api}_RegularCmdTypeDef s_command;

  /* USER CODE BEGIN PRE_OSPI_ERASE */

  /* USER CODE END PRE_OSPI_ERASE */

  /* Initialize the erase command */

  [#if "${FamilyName?lower_case}" == "stm32u5"]
  s_command.OperationType         = HAL_OSPI_OPTYPE_COMMON_CFG;
  s_command.FlashId               = HAL_OSPI_FLASH_ID_1;
  s_command.InstructionMode       = HAL_OSPI_INSTRUCTION_8_LINES;
  s_command.InstructionSize       = HAL_OSPI_INSTRUCTION_16_BITS;
  s_command.AlternateBytesMode    = HAL_OSPI_ALTERNATE_BYTES_NONE;
  s_command.DataMode              = HAL_OSPI_DATA_NONE;
  s_command.DummyCycles           = 0;
  s_command.DQSMode               = HAL_OSPI_DQS_DISABLE;
  s_command.SIOOMode              = HAL_OSPI_SIOO_INST_EVERY_CMD;

  /* DTR mode is enabled */
  s_command.InstructionDtrMode    = HAL_OSPI_INSTRUCTION_DTR_ENABLE;

  if(full_chip_erase)
  {
    s_command.Instruction         = LX_STM32_OSPI_OCTAL_BULK_ERASE_CMD;
    s_command.AddressMode         = HAL_OSPI_ADDRESS_NONE;
  }
  else
  {
    s_command.Instruction         = LX_STM32_OSPI_OCTAL_SECTOR_ERASE_CMD;
    s_command.Address             = (block * LX_STM32_OSPI_SECTOR_SIZE);
    s_command.AddressMode         = HAL_OSPI_ADDRESS_8_LINES;
    s_command.AddressSize         = HAL_OSPI_ADDRESS_32_BITS;
    s_command.AddressDtrMode      = HAL_OSPI_ADDRESS_DTR_ENABLE; /* DTR mode is enabled */
  }
  [/#if]
  [#if "${FamilyName?lower_case}" == "stm32h5"]
  s_command.OperationType         = HAL_XSPI_OPTYPE_COMMON_CFG;
  s_command.IOSelect              = HAL_XSPI_SELECT_IO_7_0;;
  s_command.InstructionMode       = HAL_XSPI_INSTRUCTION_8_LINES;
  s_command.InstructionWidth      = HAL_XSPI_INSTRUCTION_16_BITS;
  s_command.AlternateBytesMode    = HAL_XSPI_ALT_BYTES_NONE;
  s_command.DataMode              = HAL_XSPI_DATA_NONE;
  s_command.DummyCycles           = 0;
  s_command.DQSMode               = HAL_XSPI_DQS_DISABLE;
  s_command.SIOOMode              = HAL_XSPI_SIOO_INST_EVERY_CMD;

  /* DTR mode is enabled */
  s_command.InstructionDTRMode    = HAL_XSPI_INSTRUCTION_DTR_ENABLE;

  if(full_chip_erase)
  {
    s_command.Instruction         = LX_STM32_OSPI_OCTAL_BULK_ERASE_CMD;
    s_command.AddressMode         = HAL_XSPI_ADDRESS_NONE;
  }
  else
  {
    s_command.Instruction         = LX_STM32_OSPI_OCTAL_SECTOR_ERASE_CMD;
    s_command.Address             = (block * LX_STM32_OSPI_SECTOR_SIZE);
    s_command.AddressMode         = HAL_XSPI_ADDRESS_8_LINES;
    s_command.AddressWidth        = HAL_XSPI_ADDRESS_32_BITS;
    s_command.AddressDTRMode      = HAL_XSPI_ADDRESS_DTR_ENABLE;
  }
  [/#if]

  /* USER CODE BEGIN OSPI_ERASE_CMD */

  /* USER CODE END OSPI_ERASE_CMD */

  /* Enable write operations */
  if (ospi_set_write_enable(&hospi${ospi_instance}) != 0)
  {
    return 1;
  }

  /* Send the command */
  if (HAL_${used_api}_Command(&hospi${ospi_instance}, &s_command, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  /* Configure automatic polling mode to wait for end of erase */
  if (ospi_auto_polling_ready(&hospi${ospi_instance}, LX_STM32_OSPI_BULK_ERASE_MAX_TIME) != 0)
  {
    return 1;
  }
[/#if]

  /* USER CODE BEGIN POST_OSPI_ERASE */

  /* USER CODE END POST_OSPI_ERASE */

  return status;
}

/**
* @brief Check that a block was actually erased
* @param UINT instance OSPI instance
* @param ULONG  block the block to be checked
* @retval 0 on Success 1 on Failure
*/
INT lx_stm32_ospi_is_block_erased(UINT instance, ULONG block)
{
  INT status = 0;

  /* USER CODE BEGIN OSPI_BLOCK_ERASED */

  /* USER CODE END OSPI_BLOCK_ERASED */

  return status;
}

/**
* @brief Handle levelx system errors
* @param UINT error_code Code of the concerned error.
* @retval UINT error code.
*/

UINT  lx_ospi_driver_system_error(UINT error_code)
{
  UINT status = LX_ERROR;

  /* USER CODE BEGIN OSPI_SYSTEM_ERROR */

  /* USER CODE END OSPI_SYSTEM_ERROR */

  return status;
}

[#if glue_api == "DMA_API"]
/**
  * @brief  Reset the OSPI memory.
  * @param  h${used_api ?lower_case}: ${used_api} handle pointer
  * @retval O on success 1 on Failure.
  */
static uint8_t ospi_memory_reset(${used_api}_HandleTypeDef *h${used_api?lower_case})
{
  uint8_t status = 0;


  ${used_api}_RegularCmdTypeDef s_command;
  ${used_api}_AutoPollingTypeDef s_config;

  /* Initialize the reset enable command */
  [#if "${FamilyName?lower_case}" == "stm32u5"]
  s_command.OperationType         = HAL_OSPI_OPTYPE_COMMON_CFG;
  s_command.FlashId               = HAL_OSPI_FLASH_ID_1;
  s_command.Instruction           = LX_STM32_OSPI_RESET_ENABLE_CMD;
  s_command.InstructionMode       = HAL_OSPI_INSTRUCTION_1_LINE;
  s_command.InstructionSize       = HAL_OSPI_INSTRUCTION_8_BITS;
  s_command.InstructionDtrMode    = HAL_OSPI_INSTRUCTION_DTR_DISABLE;
  s_command.AddressMode           = HAL_OSPI_ADDRESS_NONE;
  s_command.AlternateBytesMode    = HAL_OSPI_ALTERNATE_BYTES_NONE;
  s_command.DataMode              = HAL_OSPI_DATA_NONE;
  s_command.DummyCycles           = 0;
  s_command.DQSMode               = HAL_OSPI_DQS_DISABLE;
  s_command.SIOOMode              = HAL_OSPI_SIOO_INST_EVERY_CMD;
  [/#if]
  [#if "${FamilyName?lower_case}" == "stm32h5"]
  s_command.OperationType         = HAL_XSPI_OPTYPE_COMMON_CFG;
  s_command.IOSelect              = HAL_XSPI_SELECT_IO_7_0;
  s_command.Instruction           = LX_STM32_OSPI_RESET_ENABLE_CMD;
  s_command.InstructionMode       = HAL_XSPI_INSTRUCTION_1_LINE;
  s_command.InstructionWidth      = HAL_XSPI_INSTRUCTION_8_BITS;
  s_command.InstructionDTRMode    = HAL_XSPI_INSTRUCTION_DTR_DISABLE;
  s_command.AddressMode           = HAL_XSPI_ADDRESS_NONE;
  s_command.AlternateBytesMode    = HAL_XSPI_ALT_BYTES_NONE;
  s_command.DataMode              = HAL_XSPI_DATA_NONE;
  s_command.DummyCycles           = 0;
  s_command.DQSMode               = HAL_XSPI_DQS_DISABLE;
  s_command.SIOOMode              = HAL_XSPI_SIOO_INST_EVERY_CMD;
  [/#if]

  /* Send the command */
  if (HAL_${used_api}_Command(&hospi${ospi_instance}, &s_command, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  /* Send the reset memory command */
  s_command.Instruction = LX_STM32_OSPI_RESET_MEMORY_CMD;
  if (HAL_${used_api}_Command(&hospi${ospi_instance}, &s_command, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  /* Configure automatic polling mode to wait the memory is ready */
  [#if "${FamilyName?lower_case}" == "stm32u5"]
  s_command.Instruction  = LX_STM32_OSPI_OCTAL_READ_STATUS_REG_CMD;
  s_command.DataMode     = HAL_OSPI_DATA_1_LINE;
  s_command.NbData       = 1;
  s_command.DataDtrMode  = HAL_OSPI_DATA_DTR_DISABLE;

  s_config.Match         = 0;
  s_config.Mask          = LX_STM32_OSPI_SR_WIP;
  s_config.MatchMode     = HAL_OSPI_MATCH_MODE_AND;
  s_config.Interval      = 0x10;
  s_config.AutomaticStop = HAL_OSPI_AUTOMATIC_STOP_ENABLE;
  [/#if]
  [#if "${FamilyName?lower_case}" == "stm32h5"]
  s_command.Instruction  = LX_STM32_OSPI_READ_STATUS_REG_CMD;
  s_command.DataMode     = HAL_XSPI_DATA_1_LINE;
  s_command.DataLength   = 1;
  s_command.DataDTRMode  = HAL_XSPI_DATA_DTR_DISABLE;

  s_config.MatchValue    = 0;
  s_config.MatchMask     = LX_STM32_OSPI_SR_WIP;
  s_config.MatchMode     = HAL_XSPI_MATCH_MODE_AND;
  s_config.IntervalTime  = 0x10;
  s_config.AutomaticStop = HAL_XSPI_AUTOMATIC_STOP_ENABLE;
  [/#if]

  if (HAL_${used_api}_Command(&hospi${ospi_instance}, &s_command, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  if (HAL_${used_api}_AutoPolling(&hospi${ospi_instance}, &s_config, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  /* USER CODE BEGIN OSPI_MEMORY_RESET_CMD */

  /* USER CODE END OSPI_MEMORY_RESET_CMD */

  return status;
}

/**
  * @brief  Send a Write Enable command and wait its effective.
  * @param  h${used_api ?lower_case}: ${used_api} handle pointer
  * @retval O on success 1 on Failure.
  */
static uint8_t ospi_set_write_enable(${used_api}_HandleTypeDef *h${used_api?lower_case})
{
  uint8_t status = 0;

  ${used_api}_RegularCmdTypeDef  s_command;

  /* Enable write operations */
  [#if "${FamilyName?lower_case}" == "stm32u5"]
  s_command.OperationType         = HAL_OSPI_OPTYPE_COMMON_CFG;
  s_command.FlashId               = HAL_OSPI_FLASH_ID_1;
  s_command.Instruction           = LX_STM32_OSPI_OCTAL_WRITE_ENABLE_CMD;
  s_command.InstructionMode       = HAL_OSPI_INSTRUCTION_8_LINES;
  s_command.InstructionSize       = HAL_OSPI_INSTRUCTION_16_BITS;
  s_command.AddressMode           = HAL_OSPI_ADDRESS_NONE;
  s_command.AlternateBytesMode    = HAL_OSPI_ALTERNATE_BYTES_NONE;
  s_command.DataMode              = HAL_OSPI_DATA_NONE;
  s_command.DummyCycles           = 0;
  s_command.DQSMode               = HAL_OSPI_DQS_DISABLE;
  s_command.SIOOMode              = HAL_OSPI_SIOO_INST_EVERY_CMD;

  /* DTR mode is enabled */
  s_command.InstructionDtrMode    = HAL_OSPI_INSTRUCTION_DTR_ENABLE;
  [/#if]
  [#if "${FamilyName?lower_case}" == "stm32h5"]
  s_command.OperationType         = HAL_XSPI_OPTYPE_COMMON_CFG;
  s_command.IOSelect              = HAL_XSPI_SELECT_IO_7_0;
  s_command.Instruction           = LX_STM32_OSPI_OCTAL_WRITE_ENABLE_CMD;
  s_command.InstructionMode       = HAL_XSPI_INSTRUCTION_8_LINES;
  s_command.InstructionWidth      = HAL_XSPI_INSTRUCTION_16_BITS;
  s_command.AddressMode           = HAL_XSPI_ADDRESS_NONE;
  s_command.AlternateBytesMode    = HAL_XSPI_ALT_BYTES_NONE;
  s_command.DataMode              = HAL_XSPI_DATA_NONE;
  s_command.DummyCycles           = 0U;
  s_command.DQSMode               = HAL_XSPI_DQS_DISABLE;
  s_command.SIOOMode              = HAL_XSPI_SIOO_INST_EVERY_CMD;

  /* DTR mode is enabled */
  s_command.InstructionDTRMode    = HAL_XSPI_INSTRUCTION_DTR_ENABLE;
  [/#if]

  if (HAL_${used_api}_Command(&hospi${ospi_instance}, &s_command, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  if (ospi_auto_polling_ready(h${used_api?lower_case}, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != 0)
  {
    return 1;
  }

 /* USER CODE BEGIN OSPI_WRITE_ENABLE_CMD */

 /* USER CODE END OSPI_WRITE_ENABLE_CMD */

  return status;
}

/**
  * @brief  Read the SR of the memory and wait the EOP.
  * @param  h${used_api ?lower_case}: ${used_api} handle pointer
  * @param  timeout: timeout value before returning an error
  * @retval O on success 1 on Failure.
  */
static uint8_t ospi_auto_polling_ready(${used_api}_HandleTypeDef *h${used_api?lower_case}, uint32_t timeout)
{
  uint8_t status = 0;

  ${used_api}_RegularCmdTypeDef  s_command;
  ${used_api}_AutoPollingTypeDef s_config;
  uint8_t reg[2];
  uint32_t start = LX_STM32_OSPI_CURRENT_TIME();

  /* Configure automatic polling mode to wait for memory ready */
  [#if "${FamilyName?lower_case}" == "stm32u5"]
  s_command.OperationType         = HAL_OSPI_OPTYPE_COMMON_CFG;
  s_command.FlashId               = HAL_OSPI_FLASH_ID_1;
  s_command.Instruction           = LX_STM32_OSPI_OCTAL_READ_STATUS_REG_CMD;
  s_command.InstructionMode       = HAL_OSPI_INSTRUCTION_8_LINES;
  s_command.InstructionSize       = HAL_OSPI_INSTRUCTION_16_BITS;
  s_command.Address               = 0;
  s_command.AddressMode           = HAL_OSPI_ADDRESS_8_LINES;
  s_command.AddressSize           = HAL_OSPI_ADDRESS_32_BITS;
  s_command.AlternateBytesMode    = HAL_OSPI_ALTERNATE_BYTES_NONE;
  s_command.DataMode              = HAL_OSPI_DATA_8_LINES;
  s_command.NbData                = 2;
  s_command.DummyCycles           = LX_STM32_OSPI_DUMMY_CYCLES_READ_OCTAL;
  s_command.SIOOMode              = HAL_OSPI_SIOO_INST_EVERY_CMD;

  /* DTR mode is enabled */
  s_command.InstructionDtrMode    = HAL_OSPI_INSTRUCTION_DTR_ENABLE;
  s_command.AddressDtrMode        = HAL_OSPI_ADDRESS_DTR_ENABLE;
  s_command.DataDtrMode           = HAL_OSPI_DATA_DTR_ENABLE;
  s_command.DQSMode               = HAL_OSPI_DQS_ENABLE;

  s_config.Match           = 0;
  s_config.Mask            = LX_STM32_OSPI_SR_WIP;
  [/#if]
  [#if "${FamilyName?lower_case}" == "stm32h5"]
  s_command.OperationType         = HAL_XSPI_OPTYPE_COMMON_CFG;
  s_command.IOSelect              = HAL_XSPI_SELECT_IO_7_0;
  s_command.Instruction           = LX_STM32_OSPI_OCTAL_READ_STATUS_REG_CMD;
  s_command.InstructionMode       = HAL_XSPI_INSTRUCTION_8_LINES;
  s_command.InstructionWidth      = HAL_XSPI_INSTRUCTION_16_BITS;
  s_command.Address               = 0U;
  s_command.AddressMode           = HAL_XSPI_ADDRESS_8_LINES;
  s_command.AddressWidth          = HAL_XSPI_ADDRESS_32_BITS;
  s_command.AlternateBytesMode    = HAL_XSPI_ALT_BYTES_NONE;
  s_command.DataMode              = HAL_XSPI_DATA_8_LINES;
  s_command.DataLength            = 2U;
  s_command.DummyCycles           = LX_STM32_OSPI_DUMMY_CYCLES_READ_OCTAL;
  s_command.SIOOMode              = HAL_XSPI_SIOO_INST_EVERY_CMD;

  /* DTR mode is enabled */
  s_command.InstructionDTRMode    = HAL_XSPI_INSTRUCTION_DTR_ENABLE;
  s_command.AddressDTRMode        = HAL_XSPI_ADDRESS_DTR_ENABLE;
  s_command.DataDTRMode           = HAL_XSPI_DATA_DTR_ENABLE;
  s_command.DQSMode               = HAL_XSPI_DQS_ENABLE;

  s_config.MatchValue           = 0U;
  s_config.MatchMask            = LX_STM32_OSPI_SR_WIP;
  [/#if]

  while( LX_STM32_OSPI_CURRENT_TIME() - start < timeout)
  {
     if (HAL_${used_api}_Command(&hospi${ospi_instance}, &s_command, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
    {
      status = 1;
      break;
    }

    if (HAL_${used_api}_Receive(&hospi${ospi_instance}, reg, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
    {
      status = 1;
      break;
    }
    /* the Memory is ready, break from the loop */
    [#if "${FamilyName?lower_case}" == "stm32u5"]
    if ((reg[0] & s_config.Mask ) == s_config.Match)
    {
      break;
    }
    [/#if]
    [#if "${FamilyName?lower_case}" == "stm32h5"]
    if ((reg[0] & s_config.MatchMask ) == s_config.MatchValue)
    {
      break;
    }
    [/#if]
  }

  /* USER CODE BEGIN OSPI_AUTO_POLLING_READY */

  /* USER CODE END OSPI_AUTO_POLLING_READY */
  return status;
}

/**
  * @brief  This function enables the octal mode of the memory.
  * @param  h${used_api ?lower_case}: ${used_api} handle
  * @retval 0 on success 1 on Failure.
  */
static uint8_t ospi_set_octal_mode(${used_api}_HandleTypeDef *h${used_api?lower_case})
{
  int status = 0;


  ${used_api}_RegularCmdTypeDef  s_command;
  ${used_api}_AutoPollingTypeDef s_config;
  uint8_t reg[2];

  [#if "${FamilyName?lower_case}" == "stm32u5"]
  s_command.OperationType      = HAL_OSPI_OPTYPE_COMMON_CFG;
  s_command.FlashId            = HAL_OSPI_FLASH_ID_1;
  s_command.InstructionDtrMode = HAL_OSPI_INSTRUCTION_DTR_DISABLE;
  s_command.AddressSize        = HAL_OSPI_ADDRESS_32_BITS;
  s_command.AddressDtrMode     = HAL_OSPI_ADDRESS_DTR_DISABLE;
  s_command.AlternateBytesMode = HAL_OSPI_ALTERNATE_BYTES_NONE;
  s_command.DataDtrMode        = HAL_OSPI_DATA_DTR_DISABLE;
  s_command.DQSMode            = HAL_OSPI_DQS_DISABLE;
  s_command.SIOOMode           = HAL_OSPI_SIOO_INST_EVERY_CMD;

  s_config.MatchMode     = HAL_OSPI_MATCH_MODE_AND;
  s_config.Interval      = 0x10;
  s_config.AutomaticStop = HAL_OSPI_AUTOMATIC_STOP_ENABLE;

  /* Activate the Octal mode */

  s_command.Instruction     = LX_STM32_OSPI_WRITE_ENABLE_CMD;
  s_command.InstructionMode = HAL_OSPI_INSTRUCTION_1_LINE;
  s_command.InstructionSize = HAL_OSPI_INSTRUCTION_8_BITS;
  s_command.AddressMode     = HAL_OSPI_ADDRESS_NONE;
  s_command.DataMode        = HAL_OSPI_DATA_NONE;
  s_command.DummyCycles     = 0;
  [/#if]
  [#if "${FamilyName?lower_case}" == "stm32h5"]
  s_command.OperationType      = HAL_XSPI_OPTYPE_COMMON_CFG;
  s_command.IOSelect           = HAL_XSPI_SELECT_IO_7_0;
  s_command.InstructionDTRMode = HAL_XSPI_INSTRUCTION_DTR_DISABLE;
  s_command.AddressWidth       = HAL_XSPI_ADDRESS_32_BITS;
  s_command.AddressDTRMode     = HAL_XSPI_ADDRESS_DTR_DISABLE;
  s_command.AlternateBytesMode = HAL_XSPI_ALT_BYTES_NONE;
  s_command.DataDTRMode        = HAL_XSPI_DATA_DTR_DISABLE;
  s_command.DQSMode            = HAL_XSPI_DQS_DISABLE;
  s_command.SIOOMode           = HAL_XSPI_SIOO_INST_EVERY_CMD;

  s_config.MatchMode     = HAL_XSPI_MATCH_MODE_AND;
  s_config.IntervalTime  = 0x10U;
  s_config.AutomaticStop = HAL_XSPI_AUTOMATIC_STOP_ENABLE;

  /* Activate the Octal mode */

  s_command.Instruction      = LX_STM32_OSPI_WRITE_ENABLE_CMD;
  s_command.InstructionMode  = HAL_XSPI_INSTRUCTION_1_LINE;
  s_command.InstructionWidth = HAL_XSPI_INSTRUCTION_8_BITS;
  s_command.AddressMode      = HAL_XSPI_ADDRESS_NONE;
  s_command.DataMode         = HAL_XSPI_DATA_NONE;
  s_command.DummyCycles      = 0U;
  [/#if]
  /* Add a short delay to let the IP settle before starting the command */
  HAL_Delay(1);

  if (HAL_${used_api}_Command(&hospi${ospi_instance}, &s_command, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  /* Configure automatic polling mode to wait for write enabling */
  [#if "${FamilyName?lower_case}" == "stm32u5"]
  s_config.Match = LX_STM32_OSPI_SR_WEL;
  s_config.Mask  = LX_STM32_OSPI_SR_WEL;

  s_command.Instruction = LX_STM32_OSPI_READ_STATUS_REG_CMD;
  s_command.DataMode    = HAL_OSPI_DATA_1_LINE;
  s_command.NbData      = 1;
  [/#if]
  [#if "${FamilyName?lower_case}" == "stm32h5"]
  s_config.MatchValue = LX_STM32_OSPI_SR_WEL;
  s_config.MatchMask  = LX_STM32_OSPI_SR_WEL;

  s_command.Instruction = LX_STM32_OSPI_READ_STATUS_REG_CMD;
  s_command.DataMode    = HAL_XSPI_DATA_1_LINE;
  s_command.DataLength  = 1;
  [/#if]

  if (HAL_${used_api}_Command(&hospi${ospi_instance}, &s_command, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  if (HAL_${used_api}_AutoPolling(&hospi${ospi_instance}, &s_config, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  /* Write Configuration register 2 (with new dummy cycles) */

  s_command.Instruction = LX_STM32_OSPI_WRITE_CFG_REG2_CMD;
  s_command.Address     = LX_STM32_OSPI_CR2_REG3_ADDR;
  s_command.AddressMode = HAL_${used_api}_ADDRESS_1_LINE;

  reg[0] = LX_STM32_OSPI_DUMMY_CYCLES_CR_CFG;

  if (HAL_${used_api}_Command(&hospi${ospi_instance}, &s_command, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  if (HAL_${used_api}_Transmit(&hospi${ospi_instance}, reg, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  /* Enable write operations */

  s_command.Instruction = LX_STM32_OSPI_WRITE_ENABLE_CMD;
  s_command.AddressMode = HAL_${used_api}_ADDRESS_NONE;
  s_command.DataMode    = HAL_${used_api}_DATA_NONE;

  if (HAL_${used_api}_Command(&hospi${ospi_instance}, &s_command, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  /* Configure automatic polling mode to wait for write enabling */

  s_command.Instruction = LX_STM32_OSPI_READ_STATUS_REG_CMD;
  s_command.DataMode    = HAL_${used_api}_DATA_1_LINE;

  if (HAL_${used_api}_Command(&hospi${ospi_instance}, &s_command, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  if (HAL_${used_api}_AutoPolling(&hospi${ospi_instance}, &s_config, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  /* Write Configuration register 2 (with Octal I/O SPI protocol) */

  s_command.Instruction = LX_STM32_OSPI_WRITE_CFG_REG2_CMD;
  s_command.Address     = LX_STM32_OSPI_CR2_REG1_ADDR;
  s_command.AddressMode = HAL_${used_api}_ADDRESS_1_LINE;

  /* DTR mode is enabled */

  reg[0] = LX_STM32_OSPI_CR2_DOPI;

  if (HAL_${used_api}_Command(&hospi${ospi_instance}, &s_command, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  if (HAL_${used_api}_Transmit(&hospi${ospi_instance}, reg, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  if (ospi_auto_polling_ready(&hospi${ospi_instance}, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != 0)
  {
    return 1;
  }

  /* Check the configuration has been correctly done */
  [#if "${FamilyName?lower_case}" == "stm32u5"]
  s_command.Instruction     = LX_STM32_OSPI_OCTAL_READ_CFG_REG2_CMD;
  s_command.InstructionMode = HAL_OSPI_INSTRUCTION_8_LINES;
  s_command.InstructionSize = HAL_OSPI_INSTRUCTION_16_BITS;
  s_command.AddressMode     = HAL_OSPI_ADDRESS_8_LINES;
  s_command.DataMode        = HAL_OSPI_DATA_8_LINES;
  s_command.DummyCycles     = LX_STM32_OSPI_DUMMY_CYCLES_READ_OCTAL;
  s_command.NbData          = 2;
  reg[0] = 0;

  s_command.InstructionDtrMode = HAL_OSPI_INSTRUCTION_DTR_ENABLE;
  s_command.AddressDtrMode     = HAL_OSPI_ADDRESS_DTR_ENABLE;
  s_command.DataDtrMode        = HAL_OSPI_DATA_DTR_ENABLE;
  s_command.DQSMode            = HAL_OSPI_DQS_ENABLE;
  [/#if]
  [#if "${FamilyName?lower_case}" == "stm32h5"]
  s_command.Instruction      = LX_STM32_OSPI_OCTAL_READ_CFG_REG2_CMD;
  s_command.InstructionMode  = HAL_XSPI_INSTRUCTION_8_LINES;
  s_command.InstructionWidth = HAL_XSPI_INSTRUCTION_16_BITS;
  s_command.AddressMode      = HAL_XSPI_ADDRESS_8_LINES;
  s_command.DataMode         = HAL_XSPI_DATA_8_LINES;
  s_command.DummyCycles      = LX_STM32_OSPI_DUMMY_CYCLES_READ_OCTAL;
  s_command.DataLength       = 2U;
  reg[0] = 0;

  s_command.InstructionDTRMode = HAL_XSPI_INSTRUCTION_DTR_ENABLE;
  s_command.AddressDTRMode     = HAL_XSPI_ADDRESS_DTR_ENABLE;
  s_command.DataDTRMode        = HAL_XSPI_DATA_DTR_ENABLE;
  s_command.DQSMode            = HAL_XSPI_DQS_ENABLE;
  [/#if]

  if (HAL_${used_api}_Command(&hospi${ospi_instance}, &s_command, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  if (HAL_${used_api}_Receive(&hospi${ospi_instance}, reg, HAL_${used_api}_TIMEOUT_DEFAULT_VALUE) != HAL_OK)
  {
    return 1;
  }

  /* DTR mode is enabled */
  if (reg[0] != LX_STM32_OSPI_CR2_DOPI)
  {
    return 1;
  }

  /* USER CODE BEGIN OSPI_OCTALMODE_CMD */

  /* USER CODE END  OSPI_OCTALMODE_CMD */

  return status;
}

/**
  * @brief  Rx Transfer completed callbacks.
  * @param  h${used_api ?lower_case} ${used_api} handle
  * @retval None
  */
[#if TRANSFER_NOTIFICATION_value == "Custom"]
void HAL_${used_api}_RxCpltCallback(${used_api}_HandleTypeDef *h${used_api?lower_case})
{
  /* Custom transfer completion notification mechanism goes here */

  /* USER CODE BEGIN RX_CMPLT */

  /* USER CODE END RX_CMPLT */
}
[#else]
void HAL_${used_api}_RxCpltCallback(${used_api}_HandleTypeDef *h${used_api?lower_case})
{
  /* USER CODE BEGIN PRE_RX_CMPLT */

  /* USER CODE END PRE_RX_CMPLT */

  tx_semaphore_put(&${used_api?lower_case}_rx_semaphore);

  /* USER CODE BEGIN POST_RX_CMPLT */

  /* USER CODE END POST_RX_CMPLT */
}
[/#if]

/**
  * @brief  Tx Transfer completed callbacks.
  * @param  h${used_api ?lower_case} ${used_api} handle
  * @retval None
  */
[#if TRANSFER_NOTIFICATION_value == "Custom"]
void HAL_${used_api}_TxCpltCallback(${used_api}_HandleTypeDef *h${used_api?lower_case})
{
  /* Custom transfer completion notification mechanism goes here */

  /* USER CODE BEGIN TX_CMPLT */

  /* USER CODE END TX_CMPLT */
}
[#else]
void HAL_${used_api}_TxCpltCallback(${used_api}_HandleTypeDef *h${used_api?lower_case})
{
  /* USER CODE BEGIN PRE_TX_CMPLT */

  /* USER CODE END PRE_TX_CMPLT */

  tx_semaphore_put(&${used_api?lower_case}_tx_semaphore);

  /* USER CODE BEGIN POST_TX_CMPLT */

  /* USER CODE END POST_TX_CMPLT */
}
[/#if]
[/#if]
[#else]
[#if "${FamilyName?lower_case}" == "stm32u5"]
#error "[This error is thrown on purpose] : the OCTOSPI IP is configured as ${LX_USE_OCTOSPI_value} which is not supported yet.
[#if ospi_comp == "MX25LM51245G"]

/* HAL DMA API implementation for OctoSPI component MX25LM51245G
 * The present implementation assumes the following settings are set:

  Instance              = OCTOSPI${ospi_instance}
  FifoThreshold         = 4
  DualQuad              = disabled
  MemoryType            = Macronix
  DeviceSize            = 26
  ChipSelectHighTime    = 2
  FreeRunningClock      = disabled
  ClockMode             = low
  ClockPrescaler        = 4
  SampleShifting        = none
  DelayHoldQuarterCycle = enabled
  ChipSelectBoundary    = 0
  DelayBlockBypass      = used
 */
[/#if]
[/#if]
[#if "${FamilyName?lower_case}" == "stm32h5"]
[#if ospi_comp == "MX25LM51245G"]

/* HAL DMA API implementation for OctoSPI component MX25LM51245G
 * The present implementation assumes the following settings are set:

  Instance              = OCTOSPI${ospi_instance}
  FifoThreshold         = 1
  DualQuad              = disabled
  MemoryType            = Macronix
  DeviceSize            = 26
  ChipSelectHighTime    = 2
  FreeRunningClock      = disabled
  ClockMode             = low
  ClockPrescaler        = 3
  SampleShifting        = none
  DelayHoldQuarterCycle = enabled
  ChipSelectBoundary    = 0
  DelayBlockBypass      = used
 */
[/#if]
[/#if]

extern ${used_api}_HandleTypeDef hospi${ospi_instance};

#if (LX_STM32_OSPI_INIT == 1)
extern void MX_OCTOSPI${ospi_instance}_Init(void);
#endif

[#if glue_api == "DMA_API"]
static uint8_t ${used_api?lower_case}_memory_reset            (${used_api}_HandleTypeDef *hospi);
static uint8_t ${used_api?lower_case}_set_write_enable        (${used_api}_HandleTypeDef *hospi);
static uint8_t ${used_api?lower_case}_auto_polling_ready      (${used_api}_HandleTypeDef *hospi, uint32_t timeout);
static uint8_t ${used_api?lower_case}_set_octal_mode          (${used_api}_HandleTypeDef *hospi);
[/#if]

/* USER CODE BEGIN SECTOR_BUFFER_1 */
ULONG ospi_sector_buffer[LX_STM32_OSPI_SECTOR_SIZE / sizeof(ULONG)];
/* USER CODE END SECTOR_BUFFER_1 */
[#if glue_api == "DMA_API"]

[#if TRANSFER_NOTIFICATION_value == "ThreadX_Semaphore"]
TX_SEMAPHORE ${used_api?lower_case}_rx_semaphore;
TX_SEMAPHORE ${used_api?lower_case}_tx_semaphore;
[/#if]
[/#if]

/* USER CODE BEGIN 2 */

/* USER CODE END 2 */

/**
* @brief system init for octospi levelx driver
* @param UINT instance OSPI instance to initialize
* @retval 0 on success error value otherwise
*/
INT lx_stm32_ospi_lowlevel_init(UINT instance)
{
  INT status = 0;

  /* USER CODE BEGIN OSPI_INIT */

  /* USER CODE END OSPI_INIT */

  return status;
}

/**
* @brief deinit octospi levelx driver, could be called by the fx_media_close()
* @param UINT instance OSPI instance to deinitialize
* @retval 0 on success error value otherwise
*/
INT lx_stm32_ospi_lowlevel_deinit(UINT instance)
{
  INT status = 0;

  /* USER CODE BEGIN OSPI_DEINIT */

  /* USER CODE END OSPI_DEINIT */

  return status;
}

/**
* @brief Get the status of the OSPI instance
* @param UINT instance OSPI instance
* @retval 0 if the OSPI is ready 1 otherwise
*/
INT lx_stm32_ospi_get_status(UINT instance)
{
  INT status = 0;

  /* USER CODE BEGIN OSPI_GET_STATUS */

  /* USER CODE END OSPI_GET_STATUS */

  return status;
}

/**
* @brief Get size info of the flash memory
* @param UINT instance OSPI instance
* @param ULONG * block_size pointer to be filled with Flash block size
* @param ULONG * total_blocks pointer to be filled with Flash total number of blocks
* @retval 0 on Success and block_size and total_blocks are correctly filled
          1 on Failure, block_size = 0, total_blocks = 0
*/
INT lx_stm32_ospi_get_info(UINT instance, ULONG *block_size, ULONG *total_blocks)
{
  INT status = 0;

  /* USER CODE BEGIN OSPI_GET_INFO */

  /* USER CODE END OSPI_GET_INFO */

  return status;
}

/**
* @brief Read data from the OSPI memory into a buffer
* @param UINT instance OSPI instance
* @param ULONG * address the start address to read from
* @param ULONG * buffer the destination buffer
* @param ULONG words the total number of words to be read
* @retval 0 on Success 1 on Failure
*/
INT lx_stm32_ospi_read(UINT instance, ULONG *address, ULONG *buffer, ULONG words)
{
  INT status = 0;

  /* USER CODE BEGIN OSPI_READ */

  /* USER CODE END OSPI_READ */

  return status;
}

/**
* @brief write a data buffer into the OSPI memory
* @param UINT instance OSPI instance
* @param ULONG * address the start address to write into
* @param ULONG * buffer the data source buffer
* @param ULONG words the total number of words to be written
* @retval 0 on Success 1 on Failure
*/
INT lx_stm32_ospi_write(UINT instance, ULONG *address, ULONG *buffer, ULONG words)
{
  INT status = 0;

  /* USER CODE BEGIN OSPI_WRITE */

  /* USER CODE END OSPI_WRITE */

  return status;
}

/**
* @brief Erase the whole flash or a single block
* @param UINT instance OSPI instance
* @param ULONG  block the block to be erased
* @param ULONG  erase_count the number of times the block was erased
* @param UINT full_chip_erase if set to 0 a single block is erased otherwise the whole flash is erased
* @retval 0 on Success 1 on Failure
*/
INT lx_stm32_ospi_erase(UINT instance, ULONG block, ULONG erase_count, UINT full_chip_erase)
{
  INT status = 0;

  /* USER CODE BEGIN OSPI_ERASE */

  /* USER CODE END OSPI_ERASE */

  return status;
}

/**
* @brief Check that a block was actually erased
* @param UINT instance OSPI instance
* @param ULONG  block the block to be checked
* @retval 0 on Success 1 on Failure
*/
INT lx_stm32_ospi_is_block_erased(UINT instance, ULONG block)
{
  INT status = 0;

  /* USER CODE BEGIN OSPI_BLOCK_ERASED */

  /* USER CODE END OSPI_BLOCK_ERASED */

  return status;
}

/**
* @brief Handle levelx system errors
* @param UINT error_code Code of the concerned error.
* @retval UINT error code.
*/

UINT  lx_ospi_driver_system_error(UINT error_code)
{
  UINT status = LX_ERROR;

  /* USER CODE BEGIN OSPI_SYSTEM_ERROR */

  /* USER CODE END OSPI_SYSTEM_ERROR */

  return status;
}

[#if glue_api == "DMA_API"]
/**
  * @brief  Reset the OSPI memory.
  * @param  h${used_api ?lower_case}: ${used_api} handle pointer
  * @retval O on success 1 on Failure.
  */
static uint8_t ospi_memory_reset(OSPI_HandleTypeDef *h${used_api?lower_case})
{
  uint8_t status = 0;

  /* USER CODE BEGIN OSPI_MEMORY_RESET_CMD */

  /* USER CODE END OSPI_MEMORY_RESET_CMD */

  return status;
}

/**
  * @brief  Send a Write Enable command and wait its effective.
  * @param  h${used_api ?lower_case}: ${used_api} handle pointer
  * @retval O on success 1 on Failure.
  */
static uint8_t ospi_set_write_enable(OSPI_HandleTypeDef *h${used_api?lower_case})
{
  uint8_t status = 0;

 /* USER CODE BEGIN OSPI_WRITE_ENABLE_CMD */

 /* USER CODE END OSPI_WRITE_ENABLE_CMD */

  return status;
}

/**
  * @brief  Read the SR of the memory and wait the EOP.
  * @param  h${used_api ?lower_case}: ${used_api} handle pointer
  * @param  timeout: timeout value before returning an error
  * @retval O on success 1 on Failure.
  */
static uint8_t ospi_auto_polling_ready(OSPI_HandleTypeDef *h${used_api?lower_case}, uint32_t timeout)
{
  uint8_t status = 0;

  /* USER CODE BEGIN OSPI_AUTO_POLLING_READY */

  /* USER CODE END OSPI_AUTO_POLLING_READY */
  return status;
}

/**
  * @brief  This function enables the octal mode of the memory.
  * @param  h${used_api ?lower_case}: ${used_api} handle
  * @retval 0 on success 1 on Failure.
  */
static uint8_t ospi_set_octal_mode(OSPI_HandleTypeDef *h${used_api?lower_case})
{
  int status = 0;

  /* USER CODE BEGIN OSPI_OCTALMODE_CMD */

  /* USER CODE END  OSPI_OCTALMODE_CMD */

  return status;
}

/**
  * @brief  Rx Transfer completed callbacks.
  * @param  h${used_api ?lower_case}: ${used_api} handle
  * @retval None
  */
[#if TRANSFER_NOTIFICATION_value == "Custom"]
void HAL_${used_api}_RxCpltCallback(OSPI_HandleTypeDef *h${used_api?lower_case})
{
  /* Custom transfer completion notification mechanism goes here */
  /* USER CODE BEGIN RX_CMPLT */

  /* USER CODE END RX_CMPLT */
}
[#else]
void HAL_${used_api}_RxCpltCallback(OSPI_HandleTypeDef *h${used_api?lower_case})
{
  /* USER CODE BEGIN PRE_RX_CMPLT */

  /* USER CODE END PRE_RX_CMPLT */

  tx_semaphore_put(&${used_api?lower_case}_rx_semaphore);

  /* USER CODE BEGIN POST_RX_CMPLT */

  /* USER CODE END POST_RX_CMPLT */
}
[/#if]

/**
  * @brief  Tx Transfer completed callbacks.
  * @param  h${used_api ?lower_case}: ${used_api} handle
  * @retval None
  */
[#if TRANSFER_NOTIFICATION_value == "Custom"]
void HAL_${used_api}_TxCpltCallback(OSPI_HandleTypeDef *h${used_api?lower_case})
{
  /* Custom transfer completion notification mechanism goes here */
  /* USER CODE BEGIN TX_CMPLT */

  /* USER CODE END TX_CMPLT */
}
[#else]
void HAL_${used_api}_TxCpltCallback(OSPI_HandleTypeDef *h${used_api?lower_case})
{
  /* USER CODE BEGIN PRE_TX_CMPLT */

  /* USER CODE END PRE_TX_CMPLT */

  tx_semaphore_put(&${used_api?lower_case}_tx_semaphore);

  /* USER CODE BEGIN POST_TX_CMPLT */

  /* USER CODE END POST_TX_CMPLT */
}
[/#if]
[/#if]


[/#if]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
