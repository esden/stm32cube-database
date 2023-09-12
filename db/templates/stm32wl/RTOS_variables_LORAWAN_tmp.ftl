[#ftl]
/* USER CODE BEGIN LORAWAN_Pool_Buffer */

/* USER CODE END LORAWAN_Pool_Buffer */
#if defined ( __ICCARM__ )
#pragma data_alignment=4
#endif
static UCHAR lorawan_byte_pool_buffer[LORAWAN_APP_MEM_POOL_SIZE];
static TX_BYTE_POOL lorawan_app_byte_pool;