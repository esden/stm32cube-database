[#ftl]
/* USER CODE BEGIN SUBGHZ_PHY_Pool_Buffer */

/* USER CODE END SUBGHZ_PHY_Pool_Buffer */
#if defined ( __ICCARM__ )
#pragma data_alignment=4
#endif
static UCHAR subghz_phy_byte_pool_buffer[SUBGHZ_PHY_APP_MEM_POOL_SIZE];
static TX_BYTE_POOL subghz_phy_app_byte_pool;