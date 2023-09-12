[#ftl]
  if (tx_byte_pool_create(&usbpd_app_byte_pool, "USBPD App memory pool", usbpd_byte_pool_buffer, USBPD_APP_MEM_POOL_SIZE) != TX_SUCCESS)
  {
    /* USER CODE BEGIN USBPD_Byte_Pool_Error */

    /* USER CODE END USBPD_Byte_Pool_Error */
  }
  else
  {
    /* USER CODE BEGIN USBPD_Byte_Pool_Success */

    /* USER CODE END USBPD_Byte_Pool_Success */

    memory_ptr = (VOID *)&usbpd_app_byte_pool;
