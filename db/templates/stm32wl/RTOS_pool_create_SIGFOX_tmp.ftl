[#ftl]
  if (tx_byte_pool_create(&sigfox_app_byte_pool, "SIGFOX App memory pool", sigfox_byte_pool_buffer, SIGFOX_APP_MEM_POOL_SIZE) != TX_SUCCESS)
  {
    /* USER CODE BEGIN SIGFOX_Byte_Pool_Error */

    /* USER CODE END SIGFOX_Byte_Pool_Error */
  }
  else
  {
    /* USER CODE BEGIN SIGFOX_Byte_Pool_Success */

    /* USER CODE END SIGFOX_Byte_Pool_Success */

    memory_ptr = (VOID *)&sigfox_app_byte_pool;
