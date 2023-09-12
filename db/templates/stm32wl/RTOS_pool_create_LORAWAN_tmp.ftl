[#ftl]
  if (tx_byte_pool_create(&lorawan_app_byte_pool, "LORAWAN App memory pool", lorawan_byte_pool_buffer, LORAWAN_APP_MEM_POOL_SIZE) != TX_SUCCESS)
  {
    /* USER CODE BEGIN LORAWAN_Byte_Pool_Error */

    /* USER CODE END LORAWAN_Byte_Pool_Error */
  }
  else
  {
    /* USER CODE BEGIN LORAWAN_Byte_Pool_Success */

    /* USER CODE END LORAWAN_Byte_Pool_Success */

    memory_ptr = (VOID *)&lorawan_app_byte_pool;
