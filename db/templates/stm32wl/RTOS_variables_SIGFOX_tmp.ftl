[#ftl]
/* USER CODE BEGIN SIGFOX_Pool_Buffer */

/* USER CODE END SIGFOX_Pool_Buffer */
#if defined ( __ICCARM__ )
#pragma data_alignment=4
#endif
static UCHAR sigfox_byte_pool_buffer[SIGFOX_APP_MEM_POOL_SIZE];
static TX_BYTE_POOL sigfox_app_byte_pool;