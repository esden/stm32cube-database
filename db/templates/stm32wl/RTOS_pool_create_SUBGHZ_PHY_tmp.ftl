[#ftl]
  if (tx_byte_pool_create(&subghz_phy_app_byte_pool, "SUBGHZ_PHY App memory pool", subghz_phy_byte_pool_buffer, SUBGHZ_PHY_APP_MEM_POOL_SIZE) != TX_SUCCESS)
  {
    /* USER CODE BEGIN SUBGHZ_PHY_Byte_Pool_Error */

    /* USER CODE END SUBGHZ_PHY_Byte_Pool_Error */
  }
  else
  {
    /* USER CODE BEGIN SUBGHZ_PHY_Byte_Pool_Success */

    /* USER CODE END SUBGHZ_PHY_Byte_Pool_Success */

    memory_ptr = (VOID *)&subghz_phy_app_byte_pool;
