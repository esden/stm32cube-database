[#ftl]
  if (tx_byte_pool_create(&stm32_wpan_app_byte_pool, "STM32_WPAN App memory pool", stm32_wpan_byte_pool_buffer, STM32_WPAN_APP_MEM_POOL_SIZE) != TX_SUCCESS)
  {
    /* USER CODE BEGIN STM32_WPAN_Byte_Pool_Error */

    /* USER CODE END STM32_WPAN_Byte_Pool_Error */
  }
  else
  {
    /* USER CODE BEGIN STM32_WPAN_Byte_Pool_Success */

    /* USER CODE END STM32_WPAN_Byte_Pool_Success */

    memory_ptr = (VOID *)&stm32_wpan_app_byte_pool;
